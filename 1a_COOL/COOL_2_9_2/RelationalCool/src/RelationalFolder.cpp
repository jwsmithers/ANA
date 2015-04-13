// $Id: RelationalFolder.cpp,v 1.268 2012-12-17 13:33:05 avalassi Exp $

// First of all, enable or disable the COOL290 API extensions (bug #92204)
#include "CoolKernel/VersionInfo.h"

// Include files
#include <list>
#include "CoralBase/AttributeList.h"
#include "CoralBase/AttributeSpecification.h"
#include "CoralBase/MessageStream.h"
#include "CoolKernel/ChannelSelection.h"
#include "CoolKernel/ConstRecordAdapter.h"
#include "CoolKernel/InternalErrorException.h"
#include "CoolKernel/Record.h"

// Local include files
#include "HvsPathHandler.h"
#include "HvsTagRecord.h"
#include "IRelationalBulkOperation.h"
#include "IRelationalTransactionMgr.h"
#include "ObjectVectorIterator.h"
#include "RelationalChannelTable.h"
#include "RelationalDatabase.h"
#include "RelationalException.h"
#include "RelationalFolder.h"
#include "RelationalGlobalTagTable.h"
#include "RelationalNodeTable.h"
#include "RelationalObject.h"
#include "RelationalObjectMgr.h"
#include "RelationalObjectTable.h"
#include "RelationalObjectTableRow.h"
#include "RelationalObject2TagTable.h"
#include "RelationalPayloadQuery.h"
#include "RelationalQueryDefinition.h"
#include "RelationalQueryMgr.h"
#include "RelationalSequence.h"
#include "RelationalSequenceMgr.h"
#include "RelationalSchemaMgr.h"
#include "RelationalTableRow.h"
#include "RelationalTagMgr.h"
#include "RelationalTagTable.h"
#include "RelationalTag2TagTable.h"
#include "TimingReportMgr.h"
//#include "UrlParser.h"
#include "timeToString.h"

// Namespace
using namespace cool;

// Local type definitions
typedef boost::shared_ptr<RelationalSequence> RelationalSequencePtr;

//-----------------------------------------------------------------------------

unsigned int RelationalFolder::bulkOpRowCacheSize()
{
  // 1. AV 18.01.2004 TEMPORARY? - was maxBufferSize(), for COOL IOV algorithm
  // Oracle - use 50k: workaround for ORA-24381 error if buffer>65535
  // MySQL - use 10k: this makes writing faster on MySQL
  // 2. AV 12.05.2009 - row cache size for CORAL/OCI client cache size
  // NB: RalQueryMgr throws if rowCacheSize <= 1...
  return 10000;
}

//-----------------------------------------------------------------------------

bool RelationalFolder::isSupportedSchemaVersion( const VersionNumber& rhs )
{
  // 1. Hardcoded requirement: folder schema must be >= 2.0.1 (bug #23755)
  if ( rhs < VersionNumber( "2.0.1" ) ) return false;
  // 2. Supported versions: 2.0.x (x>=1) and 2.8.x (x>=0)
  VersionNumber lhs201 = folderSchemaVersion( PayloadMode::INLINEPAYLOAD );
  if ( ( lhs201.majorVersion() == rhs.majorVersion() )
       && ( lhs201.minorVersion() == rhs.minorVersion() )
       //&& ( lhs201.patchVersion() <= rhs.patchVersion() )
       ) return true;
  VersionNumber lhs280 = folderSchemaVersion( PayloadMode::SEPARATEPAYLOAD );
  if ( ( lhs280.majorVersion() == rhs.majorVersion() )
       && ( lhs280.minorVersion() == rhs.minorVersion() )
       //&& ( lhs280.patchVersion() <= rhs.patchVersion() )
       ) return true;
#ifdef COOL290VP
  VersionNumber lhs290 = folderSchemaVersion( PayloadMode::VECTORPAYLOAD );
  if ( ( lhs290.majorVersion() == rhs.majorVersion() )
       && ( lhs290.minorVersion() == rhs.minorVersion() )
       //&& ( lhs280.patchVersion() <= rhs.patchVersion() )
       ) return true;
#endif
  return false;
}

//-----------------------------------------------------------------------------

PayloadMode::Mode
RelationalFolder::payloadMode( const coral::AttributeList& folderRow )
{
  // FIXME use VersionNumber to distinguish folder types ?

  VersionNumber schemaVersion = folderRow[RelationalNodeTable::columnNames::nodeSchemaVersion]
    .data<std::string>();

  VersionNumber lhsSeparate = folderSchemaVersion( PayloadMode::SEPARATEPAYLOAD );
  if ( ( lhsSeparate.majorVersion() == schemaVersion.majorVersion() )
       && ( lhsSeparate.minorVersion() == schemaVersion.minorVersion() )
       //&& ( lhs280.patchVersion() <= rhs.patchVersion() )
       )
    return PayloadMode::SEPARATEPAYLOAD;

  VersionNumber lhsVect = folderSchemaVersion( PayloadMode::VECTORPAYLOAD );
  if ( ( lhsVect.majorVersion() == schemaVersion.majorVersion() )
       && ( lhsVect.minorVersion() == schemaVersion.minorVersion() )
       //&& ( lhs280.patchVersion() <= rhs.patchVersion() )
       )
    return PayloadMode::VECTORPAYLOAD;

  return PayloadMode::INLINEPAYLOAD;
}


//-----------------------------------------------------------------------------

void RelationalFolder::initialize( const coral::AttributeList& row )
{
  m_prefetchAll = true; // Keep the API semantics of COOL_1_2_5
  m_useBuffer = false;
  m_userTagOnly = false;
  m_objectTableName = RelationalFolder::objectTableName( row );
  m_payloadTableName = RelationalFolder::payloadTableName( row );
  //m_folderSpec = FolderSpecification( versioningMode( row ), payloadSpecification( row ) );
  if ( m_folderSpec.versioningMode() == FolderVersioning::MULTI_VERSION )
  {
    m_tagTableName = RelationalFolder::tagTableName( row );
    m_object2TagTableName = RelationalFolder::object2TagTableName( row );
  }
  else
  {
    m_tagTableName = "";
    m_object2TagTableName = "";
  }
  m_channelTableName = RelationalFolder::channelTableName( row );
  const IRecordSpecification& spec =
    folderAttributesSpecification( m_folderSpec.versioningMode() );
  m_publicFolderAttributes = Record( spec, row );
  log() << coral::Debug << "Instantiate a RelationalFolder for '"
        << fullPath() << "'" << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

RelationalFolder::~RelationalFolder()
{
  log() << coral::Debug << "Delete the RelationalFolder for '"
        << fullPath() << "'" << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

coral::MessageStream& RelationalFolder::log() const
{
  *m_log << coral::Verbose;
  return *m_log;
}

//-----------------------------------------------------------------------------

const IRecord& RelationalFolder::folderAttributes() const {
  return m_publicFolderAttributes;
}

//-----------------------------------------------------------------------------

const RecordSpecification&
RelationalFolder::folderAttributesSpecification
( FolderVersioning::Mode versioningMode )
{
  if ( versioningMode == FolderVersioning::MULTI_VERSION ) {

    static RecordSpecification s_folderAttrSpec_MV;
    if ( s_folderAttrSpec_MV.size() == 0 ) {
      s_folderAttrSpec_MV.extend
        ( RelationalNodeTable::columnNames::nodeSchemaVersion,
          RelationalNodeTable::columnTypeIds::nodeSchemaVersion );
      s_folderAttrSpec_MV.extend
        ( RelationalNodeTable::columnNames::folderObjectTableName,
          RelationalNodeTable::columnTypeIds::folderObjectTableName );
      s_folderAttrSpec_MV.extend
        ( RelationalNodeTable::columnNames::folderTagTableName,
          RelationalNodeTable::columnTypeIds::folderTagTableName );
      s_folderAttrSpec_MV.extend
        ( RelationalNodeTable::columnNames::folderObject2TagTableName,
          RelationalNodeTable::columnTypeIds::folderObject2TagTableName );
      s_folderAttrSpec_MV.extend
        ( RelationalNodeTable::columnNames::folderChannelTableName,
          RelationalNodeTable::columnTypeIds::folderChannelTableName );
    }
    return s_folderAttrSpec_MV;

  } else {

    static RecordSpecification s_folderAttrSpec_SV;
    if ( s_folderAttrSpec_SV.size() == 0 ) {
      s_folderAttrSpec_SV.extend
        ( RelationalNodeTable::columnNames::nodeSchemaVersion,
          RelationalNodeTable::columnTypeIds::nodeSchemaVersion );
      s_folderAttrSpec_SV.extend
        ( RelationalNodeTable::columnNames::folderObjectTableName,
          RelationalNodeTable::columnTypeIds::folderObjectTableName );
      s_folderAttrSpec_SV.extend
        ( RelationalNodeTable::columnNames::folderChannelTableName,
          RelationalNodeTable::columnTypeIds::folderChannelTableName );
    }
    return s_folderAttrSpec_SV;

  }
}

//-----------------------------------------------------------------------------

/*
bool RelationalFolder::declareExternalReference
( const std::string& name,
  const std::vector< std::string >& attributes,
  const std::string& referencedEntity,
  const std::vector< std::string >& referencedAttributes )
{
  // Check if the reference already exists
  std::map< std::string, IFolder::ExternalReference >::const_iterator
    ref = m_externalReferences.find( name );
  if ( ref != m_externalReferences.end() ) {
    std::string errMsg =
      "External reference constraint '" + name
      + "' already exists for folder '" + fullPath() + "'";
    throw RelationalException( errMsg, "RelationalFolder" );
  }

  // Check that the number of referenced and referencing attributes match
  if ( attributes.size() != referencedAttributes.size() ) {
    std::string errMsg =
      "External reference constraint '" + name
      + "' could not be declared for folder '" + fullPath()
      + "': mismatch in the number of referenced and referencing attributes";
    throw RelationalException( errMsg, "RelationalFolder" );
  }

  // Check that each referencing attribute is used only once
  std::list<std::string> uniqueAttributes;
  std::vector<std::string>::const_iterator attr;
  for ( attr = attributes.begin(); attr != attributes.end(); attr++ ) {
    uniqueAttributes.push_back( *attr );
  }
  uniqueAttributes.unique();
  if ( uniqueAttributes.size() != attributes.size() ) {
    std::string errMsg =
      "External reference constraint '" + name
      + "' could not be declared for folder '" + fullPath()
      + "': one or more referencing attributes appear more than once";
    throw RelationalException( errMsg, "RelationalFolder" );
  }

  // Check that the referencing attributes are part of the user payload
  for ( attr = attributes.begin(); attr != attributes.end(); attr++ ) {
    try {
      extendedRecordSpecification()[ *attr ];
    } catch (...) {
      std::string errMsg =
        "External reference constraint '" + name
        + "' could not be declared for folder '" + fullPath()
        + "': attribute '" + *attr + "' not in folder payload specification";
      throw RelationalException( errMsg, "RelationalFolder" );
    }
  }

  // Check that the syntax of the referenced entity URL is supported
  // Example: "local://schema=USERNAME;table=TABLENAME".
  std::string url = referencedEntity;
  static const std::string s_localPrefix = "local://";
  std::string foreignSchema = "";
  std::string foreignTable = "";
  bool supportedUrl = true;
  if ( UrlParser::urlStartsWith( url, s_localPrefix ) ) {
    //std::cout << "URL = '" << url << "'" << std::endl;
    url = url.substr( s_localPrefix.size() ) + ";";
    //std::cout << "URL = '" << url << "'" << std::endl;
    unsigned int semicolonPos = url.find( ";" );
    while ( semicolonPos != std::string::npos ) {
      std::string optionString = url.substr( 0, semicolonPos );
      //std::cout << "option = '" << optionString << "'" << std::endl;
      url = url.substr( optionString.size()+1 );
      //std::cout << "URL = '" << url << "'" << std::endl;
      semicolonPos = url.find( ";" );
      UrlParser::Option option = UrlParser::parseOptionString( optionString );
      if ( option.first == "schema" ) {
        if ( foreignSchema != "" ) supportedUrl = false; //duplicate key
        foreignSchema = option.second;
      }
      if ( option.first == "table" ) {
        if ( foreignTable != "" ) supportedUrl = false; //duplicate key
        foreignTable = option.second;
      }
    }
  }
  if ( ! supportedUrl || foreignSchema == "" || foreignTable == "" ) {
    std::string errMsg =
      "External reference constraint '" + name
      + "' could not be declared for folder '" + fullPath()
      + "': unsupported referenced entity URL '"
      + referencedEntity + "'";
    throw RelationalException( errMsg, "RelationalFolder" );
  }
  // DUMMY IMPLEMENTATION FOR THE MOMENT: DO NOTHING

  // Add the external reference constraint to the list of constraints
  IFolder::ExternalReference reference;
  reference.name = name;
  reference.attributes = attributes;
  reference.referencedEntity = referencedEntity;
  reference.referencedAttributes = referencedAttributes;
  m_externalReferences[ name ] = reference;
  return true;

}

//-----------------------------------------------------------------------------

const std::vector< std::string > RelationalFolder::externalReferences() const
{
  std::vector< std::string > references;
  std::map< std::string, IFolder::ExternalReference >::const_iterator ref;
  for ( ref = m_externalReferences.begin();
        ref != m_externalReferences.end();
        ref++ ) {
    references.push_back( ref->first );
  }
  return references;
}

//-----------------------------------------------------------------------------

const IFolder::ExternalReference&
RelationalFolder::externalReference( const std::string& name ) const
{
  std::map< std::string, IFolder::ExternalReference >::const_iterator
    ref = m_externalReferences.find( name );
  if ( ref != m_externalReferences.end() ) {
    return ref->second;
  } else {
    std::string errMsg =
      "External reference constraint '" + name
      + "' not found for folder '" + fullPath() + "'";
    throw RelationalException( errMsg, "RelationalFolder" );
  }
}
*///

//-----------------------------------------------------------------------------

void RelationalFolder::setupStorageBuffer( bool useBuffer )
{
  if ( ( !useBuffer ) && m_useBuffer && ( !m_objectBuffer.empty() ) )
    flushStorageBuffer();
  m_useBuffer = useBuffer;
}

//-----------------------------------------------------------------------------

void RelationalFolder::flushStorageBuffer()
{
  log() << "Flushing storage buffer for folder " << fullPath() << coral::MessageStream::endmsg;
  if ( m_objectBuffer.empty() )
  {
    log() << coral::Warning << "Nothing to flush for folder "
          << fullPath() << ": buffer is empty" << coral::MessageStream::endmsg;
  }
  else
  {
    // Cross-check that the database is open
    if ( ! db().isOpen() ) throw DatabaseNotOpen( "RalDatabase" );
    db().checkDbOpenTransaction( "flushStorageBuffer", cool::ReadWrite );
    /*
    // This was removed in task #3271 - should we remove ALL autoTransaction?
    if ( db().transactionMgr()->isActive() )
    {
      if ( db().isReadOnly() ) {
        throw DatabaseOpenInReadOnlyMode( "RalDatabase" );
      } else {
        if ( db().transactionMgr()->autoTransactions() ) {
          throw RelationalException
            ( "Cannot start a concurrent write transaction", "RalDatabase" );
        }
      }
    }
    *///
    //db().__storeObjects( this, m_objectBuffer, m_userTagOnly );
    //m_objectBuffer.erase( m_objectBuffer.begin(), m_objectBuffer.end() );
    // AV 18.01.2004 TEMPORARY?
    unsigned theMaxBufferSize = bulkOpRowCacheSize();
    try
    {
      if ( theMaxBufferSize == 0 )
      {
        log() << "Store all objects (max buffer size = 0)"
              << coral::MessageStream::endmsg;
        db().objectMgr().storeObjects( this, m_objectBuffer, m_userTagOnly );
        m_objectBuffer.clear();
      }
      // AV - here could also avoid copy if buffer size is already < MAX
      else
      {
        log() << "Store at most " << theMaxBufferSize << " objects at a time"
              << coral::MessageStream::endmsg;
        /*
        // AV Access violation on vc9 (bug #45839)
        std::vector<RelationalObjectPtr>::iterator begin =
          m_objectBuffer.begin();
        std::vector<RelationalObjectPtr>::iterator end =
          begin + theMaxBufferSize < m_objectBuffer.end() ?
          begin + theMaxBufferSize :
          m_objectBuffer.end();
        while( begin < m_objectBuffer.end() )
        {
          // we should avoid this copy by adding an overloaded "storeObjects":
          // db().__storeObjects( m_objectBuffer, begin, end, m_userTagOnly )
          std::vector<RelationalObjectPtr> buffer;
          copy( begin, end, std::back_inserter( buffer ) );
          db().objectMgr().__storeObjects( this, buffer, m_userTagOnly );
          begin = end;
          end = ( end + theMaxBufferSize ) < m_objectBuffer.end() ?
            end + theMaxBufferSize :
            m_objectBuffer.end();
        }
        *///
        // AV Fix access violation on vc9 (bug #45839)
        unsigned int size = m_objectBuffer.size();
        unsigned int begin = 0;
        unsigned int end = ( theMaxBufferSize<size ?
                             theMaxBufferSize-1 :
                             size-1 );
        while( begin < size )
        {
          // we should avoid this copy by adding an overloaded "storeObjects":
          // db().__storeObjects( m_objectBuffer, begin, end, m_userTagOnly )
          std::vector<RelationalObjectPtr> buffer;
          for ( unsigned int index = begin; index <= end; index++ )
            buffer.push_back( m_objectBuffer[index] );
          db().objectMgr().storeObjects( this, buffer, m_userTagOnly );
          begin = end+1;
          end = ( end+theMaxBufferSize < size-1 ?
                  end+theMaxBufferSize :
                  size-1 );
        }
        m_objectBuffer.clear();
      }
    }
    catch (...)
    {
      // No need to print a warning if only the invalid IOV is discarded
      if ( m_objectBuffer.size() > 1 )
        log() << coral::Warning
              << "Exception caught while bulk-inserting IOVs"
              << ": NONE of the IOVs in the bulk insertion will be stored"
              << coral::MessageStream::endmsg;
      m_objectBuffer.clear();
      throw;
    }
  }

}

//-----------------------------------------------------------------------------

void RelationalFolder::storeObject( const ValidityKey& since,
                                    const ValidityKey& until,
                                    const std::vector<IRecordPtr>& payload,
                                    const ChannelId& channelId,
                                    const std::string& userTagName,
                                    bool userTagOnly )
{
  RelationalObjectPtr object
    ( new RelationalObject( since, until, payload, channelId, userTagName ) );

  storeObject( object, userTagOnly );
}

//-----------------------------------------------------------------------------

void RelationalFolder::storeObject( const ValidityKey& since,
                                    const ValidityKey& until,
                                    const unsigned int payloadId,
                                    const ChannelId& channelId,
                                    const std::string& userTagName,
                                    bool userTagOnly )
{
  RelationalObjectPtr object
    ( new RelationalObject( since, until, payloadId, channelId, userTagName ) );

  storeObject( object, userTagOnly );
}

//-----------------------------------------------------------------------------

void RelationalFolder::storeObject( const ValidityKey& since,
                                    const ValidityKey& until,
                                    const unsigned int payloadSetId,
                                    const unsigned int payloadSize,
                                    const ChannelId& channelId,
                                    const std::string& userTagName,
                                    bool userTagOnly )
{
  RelationalObjectPtr object
    ( new RelationalObject( since,
                            until,
                            payloadSetId,
                            payloadSize,
                            channelId,
                            userTagName ) );

  storeObject( object, userTagOnly );
}

//-----------------------------------------------------------------------------

void RelationalFolder::storeObject( const ValidityKey& since,
                                    const ValidityKey& until,
                                    const IRecord& payload,
                                    const ChannelId& channelId,
                                    const std::string& userTagName,
                                    bool userTagOnly )
{
  RelationalObjectPtr object
    ( new RelationalObject( since, until, payload, channelId, userTagName ) );

  storeObject( object, userTagOnly );
}

//-----------------------------------------------------------------------------

void RelationalFolder::storeObject( const ValidityKey& since,
                                    const ValidityKey& until,
                                    const coral::AttributeList& payload,
                                    const ChannelId& channelId,
                                    const std::string& userTagName,
                                    bool userTagOnly )
{
  //log() << "Store object using the AttributeList API"
  //      << coral::MessageStream::endmsg;
  ConstRecordAdapter record( payloadSpecification(), payload );
  //log() << "Store ConstRecordAdapter using the new API "
  //      << coral::MessageStream::endmsg;
  storeObject( since, until, record, channelId, userTagName, userTagOnly );
}

//-----------------------------------------------------------------------------

void RelationalFolder::storeObject( RelationalObjectPtr& object,
                                    bool userTagOnly )
{
  log() << "Store into folder " << fullPath()
        << " the following IOV: since=" << object->since()
        << " until=" << object->until()
        << coral::MessageStream::endmsg;

  // Check that userTagOnly is the same for all objects in a bulk insertion
  if ( m_objectBuffer.size() > 0 )
  {
    if ( userTagOnly != m_userTagOnly )
    {
      std::stringstream msg;
      msg << "Conflicting values of userTagOnly in the same bulk insertion";
      throw RelationalException( msg.str(), "RelationalFolder::storeObject" );
    }
  }
  else
  {
    m_userTagOnly = userTagOnly;
  }

  // Check that userTagName != "" if userTagOnly is true
  if ( userTagOnly && object->userTagName() == "" )
  {
    std::stringstream msg;
    msg << "A user tag must be specified if userTagOnly is true";
    throw RelationalException( msg.str(), "RelationalFolder::storeObject" );
  }

  // TODO - cross check payload against folder payload spec (bug #24464)?

  m_objectBuffer.push_back( object );

  // Store the object immediately if bulk insertion is not active
  if ( ! m_useBuffer ) flushStorageBuffer();
}

//-----------------------------------------------------------------------------

int
RelationalFolder::truncateObjectValidity( const ValidityKey& until,
                                          const ChannelSelection& channels )
{
  return db().objectMgr().truncateObjectValidity( this, until, channels );
}

//-----------------------------------------------------------------------------

IObjectPtr RelationalFolder::findObject( const ValidityKey& pointInTime,
                                         const ChannelId& channelId,
                                         const std::string& tagName ) const
{
  IObjectPtr obj
    ( db().objectMgr().findObject( this, pointInTime, channelId, tagName ) );
  return obj;
}

//-----------------------------------------------------------------------------

IObjectIteratorPtr
RelationalFolder::browseObjects( const ValidityKey& since,
                                 const ValidityKey& until,
                                 const ChannelSelection& channels,
                                 const std::string& tagName,
                                 bool prefetchAll,
                                 const IRecordSelection* payloadQuery ) const
{
  log() << "Browse objects in folder " << fullPath()
        << " between since=" << since << " and until=" << until
        << coral::MessageStream::endmsg;

  if ( TimingReportMgr::isActive() )
    TimingReportMgr::startTimer( "cool::RelationalFolder::browseObjects()" );
  IObjectIteratorPtr browserIt;

  if ( payloadQuery != 0 && !payloadQuery->canSelect(payloadSpecification()) )
    throw RelationalException
      ( "Invalid payload query for this folder (wrong payload specification)",
        "RelationalFolder::browseObject" );
  browserIt = db().objectMgr().browseObjects
    ( this, since, until, channels, tagName, payloadQuery );

  if ( prefetchAll )
  {
    if ( TimingReportMgr::isActive() )
      TimingReportMgr::startTimer
        ( "cool::RelationalFolder::browseObjects(V)" );
    IObjectIteratorPtr vectorIt
      ( new ObjectVectorIterator( browserIt->fetchAllAsVector() ) );
    browserIt = vectorIt;
    if ( TimingReportMgr::isActive() )
      TimingReportMgr::stopTimer
        ( "cool::RelationalFolder::browseObjects(V)" );
  }

  if ( TimingReportMgr::isActive() )
    TimingReportMgr::stopTimer( "cool::RelationalFolder::browseObjects()" );
  if (payloadQuery !=0 )
    log() << "Browse objects will return an iterator with a payloadQuery"
          << coral::MessageStream::endmsg;
  else
    if ( prefetchAll)
      log() << "Browse objects will return a vector iterator with "
            << browserIt->size() << " objects" << coral::MessageStream::endmsg;
    else
      log() << "Browse objects will return a vector iterator of unknown size"
            << coral::MessageStream::endmsg;

  return browserIt;
}

//-----------------------------------------------------------------------------

IObjectIteratorPtr
RelationalFolder::browseObjects( const ValidityKey& since,
                                 const ValidityKey& until,
                                 const ChannelSelection& channels,
                                 const std::string& tagName,
                                 const IRecordSelection* payloadQuery ) const
{
  /*
  // AV Move this code fragment where it belongs (RalObjectMgr?...)
  if ( payloadQuery != 0 )
  {
    bool trusted = false;
    if ( typeid( *payloadQuery ) == typeid ( FieldRangeSelection ) )
      trusted = true;
    // If trusted -> append describe() to the SQL WHERE clause
    // If not trusted -> scan locally using the select() method
  }
  *///
  return browseObjects
    ( since, until, channels, tagName, m_prefetchAll, payloadQuery );
}

//-----------------------------------------------------------------------------

IObjectIteratorPtr
RelationalFolder::findObjects( const ValidityKey& pointInTime,
                               const ChannelSelection& channels,
                               const std::string& tagName ) const
{
  ValidityKey since = pointInTime;
  ValidityKey until = pointInTime;
  return browseObjects( since, until, channels, tagName, m_prefetchAll, 0 );
}

//-----------------------------------------------------------------------------

IObjectVectorPtr
RelationalFolder::fetchObjectsInRange( const ValidityKey& since,
                                       const ValidityKey& until,
                                       const ChannelSelection& channels,
                                       const std::string& tagName ) const
{
  //return db().fetchObjects( this, since, until, channels, tagName );
  return browseObjects
    ( since, until, channels, tagName, m_prefetchAll, 0 )->fetchAllAsVector();
}

//-----------------------------------------------------------------------------

IObjectVectorPtr
RelationalFolder::fetchObjectsAtTime( const ValidityKey& pointInTime,
                                      const ChannelSelection& channels,
                                      const std::string& tagName ) const
{
  ValidityKey since = pointInTime;
  ValidityKey until = pointInTime;
  return fetchObjectsInRange( since, until, channels, tagName );
}

//-----------------------------------------------------------------------------

unsigned int
RelationalFolder::countObjects( const ValidityKey& since,
                                const ValidityKey& until,
                                const ChannelSelection& channels,
                                const std::string& tagName,
                                const IRecordSelection* payloadQuery ) const
{
  if ( payloadQuery != 0 && !payloadQuery->canSelect(payloadSpecification()) )
    throw RelationalException
      ( "Invalid payload query for this folder (wrong payload specification)",
        "RelationalFolder::browseObject" );
  bool countOnly = true;
  unsigned int count = db().objectMgr().browseObjects
    ( this, since, until, channels, tagName, payloadQuery, countOnly )->size();
  return count;
}

//-----------------------------------------------------------------------------

const std::vector<ChannelId>
RelationalFolder::listChannels() const
{
  db().checkDbOpenTransaction( "listChannels", cool::ReadOnly );
  // Use the channels table for both SV and MV folders.
  // Fix performance bug #24448 for SV folders in COOL_2_2_0.
  // Fix functional and performance bug #30443 for MV folders in COOL_2_2_2
  // (remove workaround for bug #23755 - MV channels table not filled).
  RelationalChannelTable channelTable( db(), *this );
  std::vector<ChannelId> channels = channelTable.listChannels();
  return channels;
}

//-----------------------------------------------------------------------------

const std::map<ChannelId,std::string>
RelationalFolder::listChannelsWithNames() const
{
  db().checkDbOpenTransaction( "listChannelsWithNames", cool::ReadOnly );
  // Use the channels table for both SV and MV folders.
  RelationalChannelTable channelTable( db(), *this );
  const std::map<ChannelId,std::string> channelsWithNames =
    channelTable.listChannelsWithNames();
  //for ( std::map<ChannelId,std::string>::const_iterator ch=channelsWithNames.begin(); ch!=channelsWithNames.end(); ch++ )
  //  std::cout << "Channel #" << ch->first << ": " << ch->second << std::endl; // debug bug #99488
  return channelsWithNames;
}

//-----------------------------------------------------------------------------

void RelationalFolder::createChannel( const ChannelId& channelId,
                                      const std::string& channelName,
                                      const std::string& description )
{
  db().objectMgr().createChannel( this, channelId, channelName, description );
}

//-----------------------------------------------------------------------------

bool RelationalFolder::dropChannel( const ChannelId& channelId )
{
  return db().objectMgr().dropChannel( this, channelId );
}

//-----------------------------------------------------------------------------

void RelationalFolder::setChannelName( const ChannelId& channelId,
                                       const std::string& channelName )
{
  log() << "Modify channel #" << channelId
        << " in folder '" << fullPath()
        << "': set name equal to '" << channelName << "'"
        << coral::MessageStream::endmsg;

  db().checkDbOpenTransaction( "setChannelName", cool::ReadWrite );

  // Throw if a channel with the given name already exists
  // (unless it is the name of this channel - fix for bug #23754)
  try {
    RelationalChannelTable table( db(), *this );
    RelationalTableRow row = table.fetchRowForChannelName( channelName );
    if ( channelId !=
         row[RelationalChannelTable::columnNames::channelId()]
         .data<ChannelId>() )
      throw ChannelExists( fullPath(), channelName, "RelationalFolder" );
  } catch ( NoRowsFound& ) {}

  // Define the SET and WHERE clauses for the update using bind variables
  RecordSpecification updateDataSpec;
  updateDataSpec.extend( "channelName",
                         RelationalChannelTable::columnTypeIds::channelName );
  updateDataSpec.extend( "channel",
                         RelationalChannelTable::columnTypeIds::channelId );
  Record updateData( updateDataSpec );
  updateData["channelName"].setValue( channelName );
  if ( channelName != "" )
    updateData["channelName"].setValue( channelName );
  else
    updateData["channelName"].setNull();
  updateData["channel"].setValue( channelId );
  std::string setClause = RelationalChannelTable::columnNames::channelName();
  setClause += "= :channelName";
  std::string whereClause = RelationalChannelTable::columnNames::channelId();
  whereClause += "= :channel";

  // Execute the update
  UInt32 updatedRows = db().queryMgr().updateTableRows
    ( channelTableName(), setClause, whereClause, updateData );

  // Remove workaround for bug #23755 (MV channels table not filled) and
  // old fix for bug #24445 (MV setChannelName fails without createChannel):
  // 'create' the channel row in the channel table if the channel exists
  // (i.e. contains some IOVs) but it has no associated channel table row
  /*
  // Was the channel name updated?
  if ( updatedRows != 1 ) {
    if ( m_folderSpec.versioningMode() == FolderVersioning::MULTI_VERSION ) {
      if ( db().relationalObjectTable( *this )->existsChannel( channelId ) ) {
        unsigned int lastObjectId = 0; // this is not maintained for MV folders
        bool hasNewData = false;
        std::string description = "";
        db().objectMgr().insertChannelTableRow( this->channelTableName(),
                                                channelId,
                                                lastObjectId,
                                                hasNewData,
                                                channelName,
                                                description );
        updatedRows = 1; // hack - workaround for bug #23755
      }
    }
  }
  *///

  // Was the channel name updated?
  if ( updatedRows != 1 ) {
    throw ChannelNotFound( channelId, "RalDatabase" );
  }

}

//-----------------------------------------------------------------------------

void RelationalFolder::setChannelDescription
( const ChannelId& channelId,
  const std::string& description )
{
  log() << "Update in table " << channelTableName()
        << " for channel " << channelId << coral::MessageStream::endmsg;

  // Define the SET and WHERE clauses for the update using bind variables
  RecordSpecification updateDataSpec;
  updateDataSpec.extend( "description",
                         RelationalChannelTable::columnTypeIds::description );
  updateDataSpec.extend( "channel",
                         RelationalChannelTable::columnTypeIds::channelId );
  Record updateData( updateDataSpec );
  updateData["description"].setValue( description );
  updateData["channel"].setValue( channelId );
  std::string setClause = RelationalChannelTable::columnNames::description();
  setClause += "= :description";
  std::string whereClause = RelationalChannelTable::columnNames::channelId();
  whereClause += "= :channel";


  db().checkDbOpenTransaction( "setChannelDescription", cool::ReadWrite );

  // Execute the update
  UInt32 updatedRows = db().queryMgr().updateTableRows
    ( channelTableName(), setClause, whereClause, updateData );

  // Remove workaround for bug #23755 (MV channels table not filled) and
  // old fix for bug #24461 (MV setChannelDesc fails without createChannel):
  // 'create' the channel row in the channel table if the channel exists
  // (i.e. contains some IOVs) but it has no associated channel table row
  /*
  // Was the channel name updated?
  if ( updatedRows != 1 ) {
    if ( m_folderSpec.versioningMode() == FolderVersioning::MULTI_VERSION ) {
      if ( db().relationalObjectTable( *this )->existsChannel( channelId ) ) {
        unsigned int lastObjectId = 0; // this is not maintained for MV folders
        bool hasNewData = false;
        std::string channelName = "";
        db().objectMgr().insertChannelTableRow( this->channelTableName(),
                                                channelId,
                                                lastObjectId,
                                                hasNewData,
                                                channelName,
                                                description );
        updatedRows = 1; // hack - workaround for bug #23755
      }
    }
  }
  *///

  // Was the channel name updated?
  if ( updatedRows != 1 ) {
    throw ChannelNotFound( channelId, "RalDatabase" );
  }

}

//-----------------------------------------------------------------------------

const std::string
RelationalFolder::channelName( const ChannelId& channelId ) const
{
  db().checkDbOpenTransaction( "channelName", cool::ReadOnly );
  bool exists = false;
  std::string channelName = "";
  try {
    RelationalChannelTable table( db(), *this );
    RelationalTableRow row = table.fetchRowForId( channelId );
    channelName = row[RelationalChannelTable::columnNames::channelName()].
      data<std::string>();
    exists = true;
  } catch ( NoRowsFound& ) {
    // Remove workaround for bug #23755 (MV channels table not filled) and
    // old fix for bug #24463 (MV channelName fails without createChannel)
    //exists = db().relationalObjectTable( *this )->existsChannel( channelId );
    exists = false;
  }
  if ( exists ) return channelName;
  else throw ChannelNotFound( channelId, "RelationalFolder" );
}

//-----------------------------------------------------------------------------

const std::string
RelationalFolder::channelDescription( const ChannelId& channelId ) const
{
  db().checkDbOpenTransaction( "channelDescription", cool::ReadOnly );
  bool exists = false;
  std::string description = "";
  try {
    RelationalChannelTable table( db(), *this );
    RelationalTableRow row = table.fetchRowForId( channelId );
    description = row[RelationalChannelTable::columnNames::description()].
      data<std::string>();
    exists = true;
  } catch ( NoRowsFound& ) {
    // Remove workaround for bug #23755 (MV channels table not filled) and old
    // fix for bug #24463 (MV channelDescription fails without createChannel)
    //exists = db().relationalObjectTable( *this )->existsChannel( channelId );
    exists = false;
  }
  if ( exists ) return description;
  else throw ChannelNotFound( channelId, "RelationalFolder" );
}

//-----------------------------------------------------------------------------

ChannelId
RelationalFolder::channelId( const std::string& channelName ) const
{
  try {
    db().checkDbOpenTransaction( "channelId", cool::ReadOnly );
    RelationalChannelTable table( db(), *this );
    RelationalTableRow row = table.fetchRowForChannelName( channelName );
    return row[RelationalChannelTable::columnNames::channelId()].
      data<ChannelId>();
  } catch ( NoRowsFound& ) {
    throw ChannelNotFound( channelName, "RelationalFolder" );
  }
}

//-----------------------------------------------------------------------------

bool
RelationalFolder::existsChannel( const std::string& channelName ) const
{
  try {
    db().checkDbOpenTransaction( "existsChannel", cool::ReadOnly );
    RelationalChannelTable table( db(), *this );
    table.fetchRowForChannelName( channelName );
    return true;
  } catch ( NoRowsFound& ) {
    return false;
  }
}

//-----------------------------------------------------------------------------

bool
RelationalFolder::existsChannel( const ChannelId& channelId ) const
{
  db().checkDbOpenTransaction( "existsChannel", cool::ReadOnly );
  bool exists;
  // Use the channels table for both SV and MV folders.
  // Fix functional and performance bug #30431 for MV folders in COOL_2_2_2
  // (remove workaround for bug #23755 - MV channels table not filled - and
  // old fix for bug #24449 - MV existsChannel fails without createChannel).
  try {
    RelationalChannelTable table( db(), *this );
    table.fetchRowForId( channelId );
    exists = true;
  } catch ( NoRowsFound& ) {
    exists= false;
  }
  return exists;
}

//-----------------------------------------------------------------------------

const std::string& RelationalFolder::objectTableName() const
{
  return m_objectTableName;
}

//-----------------------------------------------------------------------------

const std::string& RelationalFolder::payloadTableName() const
{
  return m_payloadTableName;
}

//-----------------------------------------------------------------------------

const std::string& RelationalFolder::tagTableName() const
{
  if ( m_folderSpec.versioningMode() == FolderVersioning::MULTI_VERSION )
    return m_tagTableName;
  else
    throw FolderIsSingleVersion
      ( fullPath(), " Tag table does not exist", "RalDatabase" );
}

//-----------------------------------------------------------------------------

const std::string& RelationalFolder::object2TagTableName() const
{
  if ( m_folderSpec.versioningMode() == FolderVersioning::MULTI_VERSION )
    return m_object2TagTableName;
  else
    throw FolderIsSingleVersion
      ( fullPath(), " Object2Tag table does not exist", "RalDatabase" );
}

//-----------------------------------------------------------------------------

const RecordSpecification
RelationalFolder::payloadSpecification
( const coral::AttributeList& folderRow )
{
  std::string value =
    folderRow[RelationalNodeTable::columnNames::folderPayloadSpecDesc]
    .data<std::string>();
  return RelationalDatabase::decodeRecordSpecification( value );
}

//-----------------------------------------------------------------------------

FolderVersioning::Mode
RelationalFolder::versioningMode( const coral::AttributeList& folderRow )
{
  int value =
    folderRow[RelationalNodeTable::columnNames::folderVersioningMode]
    .data<int>();
  return FolderVersioning::Mode( value );
}

//-----------------------------------------------------------------------------

const std::string
RelationalFolder::objectTableName( const coral::AttributeList& folderRow )
{
  std::string value =
    folderRow[RelationalNodeTable::columnNames::folderObjectTableName]
    .data<std::string>();
  return value;
}

//-----------------------------------------------------------------------------

const std::string
RelationalFolder::payloadTableName( const coral::AttributeList& folderRow )
{
  UInt16 payloadMode;
  if ( folderRow[RelationalNodeTable::columnNames::folderPayloadInline].isNull() )
    payloadMode = 0;  // Backward-compatibility (eg sqlite schemas for COOL 1.3.0)
  else
    payloadMode = folderRow[RelationalNodeTable::columnNames::folderPayloadInline]
      .data<UInt16>();
  std::string tableName =
    folderRow[RelationalNodeTable::columnNames::folderPayloadExtRef]
    .data<std::string>();
  if ( payloadMode != 0 && payloadMode != 1 )
    throw InternalErrorException( "PANIC! Invalid payload mode" ,
                                  "RelationalFolder::payloadTableName" );
  if ( payloadMode == 0 && tableName != "" )
    throw InternalErrorException( "PANIC! External ref in payload mode 0",
                                  "RelationalFolder::payloadTableName" );
  if ( payloadMode == 1 && tableName == "" )
    throw InternalErrorException( "PANIC! No external ref in payload mode 1",
                                  "RelationalFolder::payloadTableName" );
  return tableName;
}

//-----------------------------------------------------------------------------

const std::string
RelationalFolder::tagTableName( const coral::AttributeList& folderRow )
{
  std::string value =
    folderRow[RelationalNodeTable::columnNames::folderTagTableName]
    .data<std::string>();
  return value;
}

//-----------------------------------------------------------------------------

const std::string
RelationalFolder::object2TagTableName( const coral::AttributeList& folderRow )
{
  std::string value =
    folderRow[RelationalNodeTable::columnNames::folderObject2TagTableName]
    .data<std::string>();
  return value;
}

//-----------------------------------------------------------------------------

const std::string
RelationalFolder::channelTableName( const coral::AttributeList& folderRow )
{
  std::string value =
    folderRow[RelationalNodeTable::columnNames::folderChannelTableName]
    .data<std::string>();
  return value;
}

//-----------------------------------------------------------------------------

const std::string& RelationalFolder::channelTableName() const {
  return m_channelTableName;
}

//-----------------------------------------------------------------------------

void RelationalFolder::tagCurrentHead( const std::string& tagName,
                                       const std::string& description ) const
{
  log() << "Tag current HEAD of folder '" << this->fullPath()
        << "' with tag '" << tagName << "'" << coral::MessageStream::endmsg;

  if ( m_folderSpec.versioningMode() != FolderVersioning::MULTI_VERSION )
    throw FolderIsSingleVersion( fullPath(), "RelationalFolder" );

  // Cross-check that the database is open
  if ( ! db().isOpen() ) throw DatabaseNotOpen( "RelationalFolder" );

  // HEAD tag for SV folders and MV folders
  if ( IHvsNode::isHeadTag( tagName ) )
    throw ReservedHeadTag( tagName, "RelationalFolder" );

  // MV folder - identify which objects are to be tagged and tag them
  else {
    db().checkDbOpenTransaction( "tagCurrentHead", cool::ReadWrite );
    std::vector<RelationalObjectTableRow> objs =
      db().relationalObjectTable( *this )->fetchRowsForTaggingCurrentHead( this->payloadMode() );
    tagObjectList( tagName, description, objs );
    log() << "Tagged " << objs.size() << " objects with tag '" << tagName
          << "'" << coral::MessageStream::endmsg;
  }

}

//-----------------------------------------------------------------------------

void
RelationalFolder::cloneTagAsUserTag( const std::string& tagName,
                                     const std::string& tagClone,
                                     const std::string& description,
                                     bool forceOverwriteTag )
{
  log() << "Clone current HEAD of folder '" << this->fullPath()
        << "' with tag '" << tagName << "'" << coral::MessageStream::endmsg;

  if ( m_folderSpec.versioningMode() != FolderVersioning::MULTI_VERSION )
    throw FolderIsSingleVersion( fullPath(), "RelationalFolder" );

  // Cross-check that the database is open
  if ( ! db().isOpen() ) throw DatabaseNotOpen( "RelationalFolder" );

  // HEAD tag for SV folders and MV folders
  if ( IHvsNode::isHeadTag( tagClone ) )
    throw ReservedHeadTag( tagClone, "RelationalFolder" );

  // tagClone should not exist as a tag unless forceOverwriteTag is true
  if ( !forceOverwriteTag && db().existsTag(tagClone) )
    throw TagExists( tagName, "RelationalFolder" );

  // MV folder - identify which objects are to be cloned and clone them
  IObjectIteratorPtr objIter = browseObjects( ValidityKeyMin,
                                              ValidityKeyMax,
                                              ChannelSelection::all(),
                                              tagName,
                                              true,
                                              0 );
  bool m_useBuffer_sav = m_useBuffer;
  setupStorageBuffer( true );
  while ( objIter->goToNext() )
  {
    const RelationalObject& object =
      dynamic_cast<const RelationalObject&>( objIter->currentRef() );

    if ( payloadMode() == PayloadMode::SEPARATEPAYLOAD )
    {
      // store by payloadId, to avoid to store the payload again
      storeObject( object.since(),
                   object.until(),
                   object.payloadId(),
                   object.channelId(),
                   tagClone,
                   true );
    }
    else if ( payloadMode() == PayloadMode::VECTORPAYLOAD )
    {
      // store by payloadSetId, to avoid to store the payload again
      storeObject( object.since(),
                   object.until(),
                   object.payloadSetId(),
                   object.payloadSize(),
                   object.channelId(),
                   tagClone,
                   true );
    }
    else
    {
      // inline payload
      storeObject( object.since(),
                   object.until(),
                   object.payload(),
                   object.channelId(),
                   tagClone,
                   true );
    }
  }
  flushStorageBuffer();
  // restore original m_useBuffer setting
  setupStorageBuffer( m_useBuffer_sav );

  if ( description != "" ) setTagDescription( tagClone, description );

  log() << "Reinserted " << objIter->size() << " objects with tag '" << tagName
        << "'" << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RelationalFolder::tagHeadAsOfDate( const ITime& asOfDate,
                                        const std::string& tagName,
                                        const std::string& description ) const
{
  log() << "Tag HEAD as of date '" << timeToString(asOfDate)
        << "' of folder '" << this->fullPath()
        << "' with tag '" << tagName << "'" << coral::MessageStream::endmsg;

  if ( m_folderSpec.versioningMode() != FolderVersioning::MULTI_VERSION )
    throw FolderIsSingleVersion( fullPath(), "RelationalFolder" );

  // Cross-check that the database is open
  if ( ! db().isOpen() ) throw DatabaseNotOpen( "RelationalFolder" );

  // HEAD tag for SV folders and MV folders
  if ( IHvsNode::isHeadTag( tagName ) )
    throw ReservedHeadTag( tagName, "RelationalFolder" );

  // MV folder - identify which objects are to be tagged and tag them
  else {
    db().checkDbOpenTransaction( "tagHeadAsOfDate", cool::ReadWrite );
    std::vector<RelationalObjectTableRow> objs =
      db().relationalObjectTable( *this )
      ->fetchRowsForTaggingHeadAsOfDate( asOfDate, this->payloadMode() );
    tagObjectList( tagName, description, objs );
    log() << "Tagged " << objs.size() << " objects with tag '" << tagName
          << "'" << coral::MessageStream::endmsg;
  }

}

//-----------------------------------------------------------------------------

void RelationalFolder::tagHeadAsOfObjectId( unsigned int asOfObjectId,
                                            const std::string& tagName,
                                            const std::string& description )
{
  db().checkDbOpenTransaction( "tagHeadAsOfObjectId", cool::ReadWrite );

  // Identify which objects are to be tagged
  std::vector<RelationalObjectTableRow> objs =
    db().relationalObjectTable( *this )
    ->fetchRowsForTaggingHeadAsOfObjectId( asOfObjectId, this->payloadMode() );

  // Tag the objecs
  tagObjectList( tagName, description, objs );

}

//-----------------------------------------------------------------------------

const Time
RelationalFolder::insertionTimeOfLastObjectInTag
( const std::string& tagName ) const
{
  // Cross-check that the database is open
  if ( ! db().isOpen() ) throw DatabaseNotOpen( "RelationalDatabase" );

  // SV folders don't have tags, can't determine a tagTime
  if ( this->versioningMode() == FolderVersioning::SINGLE_VERSION )
    throw RelationalException( "tagTime not applicable in "
                               "SingleVersion mode", "RelationalFolder" );

  // Retrieve the tag insertion time from the folder's tag table
  db().checkDbOpenTransaction( "insertionTimeOfLastObjectInTag", cool::ReadOnly );

  RelationalTableRow
    row( db().tagMgr().fetchGlobalTagTableRow( this->id(), tagName ) );

  unsigned int tagId =
    row[RelationalTagTable::columnNames::tagId].data<unsigned int>();

  RelationalObjectTableRow objRow
    ( db().relationalObjectTable( *this )->fetchLastRowForTagId( tagId ) );


  return objRow.insertionTime();
}

//-----------------------------------------------------------------------------

void RelationalFolder::tagObjectList
( const std::string& tagName,
  const std::string& description,
  const std::vector<RelationalObjectTableRow>& objects ) const
{
  // Throw TagNotCreated if object list is empty
  if ( objects.size() == 0 )
    throw RelationalException
      ( "Tag '" + tagName + "' not created: no IOVs in the tag",
        "RelationalFolder" );

  // Transaction and cross-checks handled in outer scope
  UInt32 tagId;
  std::string insertionTime;

  // Tag already exists - check if created by HVS or by IOV tags
  try {
    HvsTagRecord tag = db().tagMgr().findTagRecord( this->id(), tagName );
    tagId = tag.id();
    // Tag was created by IOV or user tags - cannot reuse it
    if ( RelationalFolder::existsUserTagInObjectTable
         ( db().queryMgr(), tagId, this->objectTableName() ) ||
         RelationalFolder::existsTagInObject2TagTable
         ( db().queryMgr(), tagId, this->object2TagTableName() ) )
      throw TagExists( tagName, "RalDatabase" );
    // Else tag must have been created by HVS (should we check for PANIC?)
    // TODO! change the description of the tag according to what was provided

    // Throw TagIsLocked if the tag is locked
    // TODO: differentiate between LOCKED and PARTIALLYLOCKED?
    // This method is only used for standard 'HEAD' tags, not user tags:
    // if 'partial locks' are full locks for HEAD tags, then nothing to do.
    if ( tag.lockStatus() != HvsTagLock::UNLOCKED )
      throw TagIsLocked
        ( "Cannot tag objects with tag '" + tagName +
          "': tag is locked", "RelationalFolder" );

    // TEMPORARY! Get the new insertion time from tag2tagseq used as CLOCK!
    const std::string seqName =
      RelationalTag2TagTable::sequenceName( db().tag2TagTableName() );
    RelationalSequencePtr sequence
      ( db().queryMgr().sequenceMgr().getSequence( seqName ) );
    sequence->nextVal(); // TEMPORARY! value not used: need non-sequence clock!
    insertionTime = sequence->currDate(); // nextVal -> recent!
  }

  // Tag does not exist - get a new ID and insert the tag in the two tag tables
  catch ( TagNotFound& ) {
    //tag = tagMgr().createTag( folder->id(), tagName, description );
    HvsTagRecord tag = db().tagMgr().createTagAndLocalTag
      ( this->id(), tagName, description, this->tagTableName() );
    tagId = tag.id();
    insertionTime = timeToString( tag.insertionTime() );
  }

  // Insert the object ids into the object2Tag table
  insertObject2TagTableRows
    ( this->object2TagTableName(), tagId, insertionTime, objects, this->payloadMode() );
}

//-----------------------------------------------------------------------------

void RelationalFolder::deleteTag( const std::string& tagName )
{

  // Cross-check that the database is open
  if ( ! db().isOpen() ) throw DatabaseNotOpen( "RalDatabase" );

  // HEAD tag for SV folders and MV folders
  if ( IHvsNode::isHeadTag( tagName ) )
    throw ReservedHeadTag( tagName, "RalDatabase" );

  // SV folder
  if ( this->versioningMode() != FolderVersioning::MULTI_VERSION ) {
    throw FolderIsSingleVersion( this->fullPath(), "RelationalFolder" );
  }

  // MV folder - get the tagId for tagName from the global tag table
  else {
    db().checkDbOpenTransaction( "deleteTag", cool::ReadWrite );
    RelationalTableRow tagTableRow
      ( db().tagMgr().fetchGlobalTagTableRow( this->id(), tagName ) );
    // Throw TagIsLocked if the tag is locked
    // (either LOCKED or PARTIALLYLOCKED - both are equivalent here)
    HvsTagLock::Status lockStatus =
      HvsTagLock::Status
      ( tagTableRow[RelationalGlobalTagTable::columnNames::tagLockStatus]
        .data<UInt16>() );
    if ( lockStatus != HvsTagLock::UNLOCKED )
      throw TagIsLocked
        ( "Cannot delete tag '" + tagName + "': tag is locked",
          "RelationalFolder" );
    unsigned int tagId =
      tagTableRow[RelationalGlobalTagTable::columnNames::tagId]
      .data<unsigned int>();
    deleteObject2TagTableRows( this->object2TagTableName(), tagId );
    deleteObjectTableRowsForUserTag( this->objectTableName(), tagId );
    if ( !db().tagMgr().existsTagInTag2TagTable( this->id(), tagId ) ) {
      db().tagMgr().deleteTagTableRow( this->tagTableName(), tagId );
      db().tagMgr().deleteGlobalTagTableRow( this->id(), tagId );
    }
  }

}

//-----------------------------------------------------------------------------

void RelationalFolder::insertObject2TagTableRows
( const std::string& object2TagTableName,
  unsigned int tagId,
  const std::string& insertionTime,
  const std::vector<RelationalObjectTableRow>& rows,
  PayloadMode::Mode pMode ) const
{
  // Transaction handled in the outer scope

  // Check that there are >0 rows to insert
  unsigned int nRows = rows.size();
  if ( nRows == 0 ) {
    log() << "No rows to store into table "
          << object2TagTableName << coral::MessageStream::endmsg;
    return;
  }
  log() << "Bulk inserting " << nRows << " rows into table "
        << object2TagTableName << coral::MessageStream::endmsg;

  // Get a handle to the table
  //coral::ITable& table =
  //  session().nominalSchema().tableHandle( object2TagTableName );

  // Setup the relational table bulk inserter
  const IRecordSpecification& dataSpec =
    RelationalObject2TagTable::tableSpecification( pMode );
  Record data( dataSpec );
  boost::shared_ptr<IRelationalBulkOperation>
    bulkInserter( db().queryMgr().bulkInsertTableRows
                  ( object2TagTableName, data, bulkOpRowCacheSize() ) );

  // Iterate through the objects and register them for insertion
  for ( std::vector<RelationalObjectTableRow>::const_iterator
          row = rows.begin(); row != rows.end(); ++row )
  {

    // Set all fields in the spec
    data[RelationalObject2TagTable::columnNames::tagId].setValue
      ( tagId );
    data[RelationalObject2TagTable::columnNames::objectId].setValue
      ( row->objectId() );
    data[RelationalObject2TagTable::columnNames::channelId].setValue
      ( row->channelId() );
    data[RelationalObject2TagTable::columnNames::iovSince].setValue
      ( row->since() );
    data[RelationalObject2TagTable::columnNames::iovUntil].setValue
      ( row->until() );
    if ( this->payloadMode() == PayloadMode::SEPARATEPAYLOAD )
      data[RelationalObject2TagTable::columnNames::payloadId].setValue
        ( row->payloadId() );
    else if ( this->payloadMode() == PayloadMode::VECTORPAYLOAD )
      data[RelationalObject2TagTable::columnNames::payloadSetId].setValue
        ( row->payloadSetId() );
    // TEMPORARY! sysInsTime as string rather than DATE
    data[RelationalObject2TagTable::columnNames::sysInsTime].setValue
      ( insertionTime );

    // Verbose printout: print out the full row being inserted into the db
    // TEMPORARY? Speed up tagging by disabling the streaming to MsgStream
    /*
      std::ostringstream dataStream;
      data.print( dataStream );
      log() << "Insert into the object2tag table the following AttributeList: "
      << dataStream.str() << coral::MessageStream::endmsg;
    *///

    /*
    // Check that all column values are within their allowed range.
    // REMOVE? This is already done by the IField::setValue calls above.
    dataSpec.validate( data );
    *///

    // Insert the new object in the object2tag table
    bulkInserter->processNextIteration();

  }

  // Flush the bulk inserter
  bulkInserter->flush();

}

//-----------------------------------------------------------------------------

unsigned int RelationalFolder::deleteObject2TagTableRows
( const std::string& object2TagTableName,
  unsigned int tagId ) const
{
  // Transaction handled in the outer scope
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "tagId", RelationalTagTable::columnTypeIds::tagId );
  Record whereData( whereDataSpec );
  whereData["tagId"].setValue( tagId );
  std::string whereClause = RelationalTagTable::columnNames::tagId;
  whereClause += "= :tagId";
  return db().queryMgr().deleteTableRows
    ( object2TagTableName, whereClause, whereData );
}

//-----------------------------------------------------------------------------

unsigned int RelationalFolder::deleteObjectTableRowsForUserTag
( const std::string& objectTableName,
  unsigned int tagId ) const
{
  // Transaction handled in the outer scope
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "userTagId",
                        RelationalObjectTable::columnTypeIds::userTagId );
  Record whereData( whereDataSpec );
  whereData["userTagId"].setValue( tagId );
  std::string whereClause = RelationalObjectTable::columnNames::userTagId();
  whereClause += "= :userTagId";
  return db().queryMgr().deleteTableRows
    ( objectTableName, whereClause, whereData );
}

//-----------------------------------------------------------------------------

bool
RelationalFolder::existsUserTag( const std::string& userTagName ) const
{
  /*
    User tags are a special kind of tag. They are recorded mainly in the IOV
    table (although their name and description is also stored in the folder
    and global tag tables).

    The difference between a normal tag and a user tag is that the user tagId
    is referenced in the colum 'tag_id' of the iov table. Therefore in order
    to find out if a user tag has been assigned, a COUNT(*) on the iov table
    is made with a contraint tagId = userTagId.

    The userTagId is obtained from the folder's tag table tag_id. If no row
    exists for tagName then no user tag by that name has been assigned.

    Even though this requires two queries to perform this check I don't think
    we want to add an extra column 'isUserTag' to the tag table just to
    implement the (temporary, at least for this specification) user tag.
  *///
  db().checkDbOpenTransaction( "RelationalFolder::existsUserTag",
                               cool::ReadOnly );

  // HEAD tag
  if ( IHvsNode::isHeadTag( userTagName ) )
  {
    return false;
  }

  // Not a HEAD tag
  else
  {
    try {
      unsigned int userTagId =
        db().tagMgr().fetchGlobalTagTableRow( id(), userTagName )
        [RelationalTagTable::columnNames::tagId].data<unsigned int>();
      bool status = existsUserTagInObjectTable
        ( db().queryMgr(), userTagId, objectTableName() );
      return status;
    }
    catch ( TagNotFound& ) {
      return false;
    }
  }
}

//-----------------------------------------------------------------------------

void RelationalFolder::renamePayload( const std::string& oldName,
                                      const std::string& newName )
{
  // Preliminary checks
  if ( ! payloadSpecification().exists( oldName ) )
    throw RelationalException
      ( "Cannot rename payload field " + oldName + ": it does not exist",
        "RelationalFolder" );
  if ( payloadSpecification().exists( newName ) )
    throw RelationalException
      ( "Cannot rename payload field to " + newName + ": it already exists",
        "RelationalFolder" );
  if ( ! RelationalDatabase::isValidPayloadFieldName( newName ) )
    throw RelationalException
      ( "Cannot rename payload field to " + newName + ": invalid name",
        "RelationalFolder" );
  // Cross-check that we're not in manual transaction more
  if ( ! db().transactionMgr()->autoTransactions() ) {
    throw RelationalException("Cannot rename payload fields in manual "
                              "transaction mode", "RalDatabase");
  }

  db().checkDbOpenTransaction( "renamePayload", cool::ReadWrite );
  // Prepare the new specification
  RecordSpecification newRecordSpecification;
  for ( unsigned int i = 0; i < payloadSpecification().size(); i++ ) {
    const IFieldSpecification& field = payloadSpecification()[i];
    if ( field.name() == oldName ) {
      newRecordSpecification.extend( newName, field.storageType() );
    }
    else {
      newRecordSpecification.extend( field.name(), field.storageType() );
    }
  }

  // Rename column
  if ( payloadMode() == PayloadMode::INLINEPAYLOAD )
    db().schemaMgr().renameColumnInTable(m_objectTableName,oldName,newName);
  else
    db().schemaMgr().renameColumnInTable(m_payloadTableName,oldName,newName);

  // Prepare to update the folder description
  RecordSpecification dataSpec;
  dataSpec.extend( "newSpec",
                   RelationalNodeTable::columnTypeIds::folderPayloadSpecDesc);
  dataSpec.extend( "nodeId",
                   RelationalNodeTable::columnTypeIds::nodeId);
  Record data( dataSpec );
  data["newSpec"].setValue
    ( db().encodeRecordSpecification( newRecordSpecification ) );
  data["nodeId"].setValue( id() );
  std::string setClause =
    RelationalNodeTable::columnNames::folderPayloadSpecDesc;
  setClause += " = :newSpec, ";
  setClause += RelationalNodeTable::columnNames::lastModDate;
  setClause += " = " + db().queryMgr().serverTimeClause();
  std::string whereClause = RelationalNodeTable::columnNames::nodeId;
  whereClause += "= :nodeId";
  db().queryMgr().updateTableRows
    ( db().nodeTableName(), setClause, whereClause, data );

  // Set the new specification
  //m_folderSpec.payloadSpecification() = newRecordSpecification;
#ifdef COOL290VP
  m_folderSpec = FolderSpecification( m_folderSpec.versioningMode(), newRecordSpecification, m_folderSpec.payloadMode() );
#else
  m_folderSpec = FolderSpecification( m_folderSpec.versioningMode(), newRecordSpecification, m_folderSpec.hasPayloadTable() );
#endif
}

//-----------------------------------------------------------------------------

void RelationalFolder::extendPayloadSpecification( const IRecord& record )
{
  if ( record.specification().size() == 0 ) return;

  // Cross-check that we're not in manual transaction more
  if ( ! db().transactionMgr()->autoTransactions() ) {
    throw RelationalException("Cannot extend payload specification in manual "
                              "transaction mode", "RalDatabase");
  }

  db().checkDbOpenTransaction( "RelationalFolder::extendPayloadSpecification",
                               cool::ReadWrite );

  // Loop over all fields in the record
  const IRecordSpecification& spec = record.specification();
  for ( UInt32 i = 0; i < spec.size(); i++ )
  {
    // Preliminary checks
    const std::string& name = spec[i].name();
    if ( payloadSpecification().exists( name ) )
      throw RelationalException
        ( "Cannot add payload field " + name + ": it already exists",
          "RelationalFolder" );
    if ( ! RelationalDatabase::isValidPayloadFieldName( name ) )
      throw RelationalException
        ( "Cannot add payload field " + name + ": invalid name",
          "RelationalFolder" );
  }

  // Add columns (and set the values for all existing rows)
  if ( payloadMode() == PayloadMode::INLINEPAYLOAD )
    db().schemaMgr().addColumnsToTable( m_objectTableName, record );
  else
    db().schemaMgr().addColumnsToTable( m_payloadTableName, record );

  // Prepare the new specification
  RecordSpecification newRecordSpecification = payloadSpecification();
  newRecordSpecification.extend( spec );

  // Update the folder description
  RecordSpecification dataSpec;
  dataSpec.extend( "newSpec",
                   RelationalNodeTable::columnTypeIds::folderPayloadSpecDesc);
  dataSpec.extend( "nodeId",
                   RelationalNodeTable::columnTypeIds::nodeId);
  Record data( dataSpec );
  data["newSpec"].setValue
    ( db().encodeRecordSpecification( newRecordSpecification ) );
  data["nodeId"].setValue( id() );
  std::string setClause =
    RelationalNodeTable::columnNames::folderPayloadSpecDesc;
  setClause += " = :newSpec, ";
  setClause += RelationalNodeTable::columnNames::lastModDate;
  setClause += " = " + db().queryMgr().serverTimeClause();
  std::string whereClause = RelationalNodeTable::columnNames::nodeId;
  whereClause += "= :nodeId";
  db().queryMgr().updateTableRows
    ( db().nodeTableName(), setClause, whereClause, data );

  // Set the new specification
  //m_folderSpec.payloadSpecification() = newRecordSpecification;
#ifdef COOL290VP
  m_folderSpec = FolderSpecification( m_folderSpec.versioningMode(), newRecordSpecification, m_folderSpec.payloadMode() );
#else
  m_folderSpec = FolderSpecification( m_folderSpec.versioningMode(), newRecordSpecification, m_folderSpec.hasPayloadTable() );
#endif
}

//-----------------------------------------------------------------------------

bool
RelationalFolder::existsUserTagInObjectTable
( const RelationalQueryMgr& queryMgr,
  UInt32 userTagId,
  const std::string& objectTableName )
{
  bool exists = true;
  std::string desc = "";
  RelationalQueryDefinition queryDef;

  std::string whereClause =
    RelationalObjectTable::columnNames::userTagId();
  whereClause += "=:userTagId";
  queryDef.setWhereClause( whereClause );

  std::string hintPrefix = std::string("/") + std::string("*");
  std::string hintSuffix = std::string(" *") + std::string("/");
  std::string hint = hintPrefix + "+ QB_NAME(MAIN) ";
  hint += "INDEX_RS_ASC(@MAIN " + objectTableName + "@MAIN (USER_TAG_ID NEW_HEAD_ID CHANNEL_ID IOV_SINCE IOV_UNTIL)) ";
  hint += hintSuffix;
  queryDef.setHint( hint );

  RecordSpecification bindDataSpec;
  bindDataSpec.extend
    ( "userTagId", RelationalObjectTable::columnTypeIds::userTagId );
  Record bindData( bindDataSpec );
  bindData["userTagId"].setValue( userTagId );
  queryDef.setBindVariables( bindData );

  queryDef.addSelectItem( "MIN(" + RelationalObjectTable::columnNames::userTagId() + ")",
                          RelationalObjectTable::columnTypeIds::userTagId, "userTagId" );
  queryDef.addFromItem( objectTableName );

  try
  {
    const std::vector<RelationalTableRow> rows
      ( queryMgr.fetchOrderedRows( queryDef, desc, 1 ) );
    if ( rows[0].data()["userTagId"].isNull() ) exists = false;
  }
  catch ( NoRowsFound& )
  {
    exists = false;
  }
  return exists;
}

//-----------------------------------------------------------------------------

bool
RelationalFolder::existsTagInObject2TagTable
( const RelationalQueryMgr& queryMgr,
  UInt32 tagId,
  const std::string& object2TagTableName )
{
  bool exists = true;
  std::string desc = "";
  RelationalQueryDefinition queryDef;

  std::string whereClause( RelationalObject2TagTable::columnNames::tagId );
  whereClause += "=:tagId";
  queryDef.setWhereClause( whereClause );

  std::string hintPrefix = std::string("/") + std::string("*");
  std::string hintSuffix = std::string(" *") + std::string("/");
  std::string hint = hintPrefix + "+ QB_NAME(MAIN) ";
  hint += "INDEX_RS_ASC(@MAIN " + object2TagTableName + ") ";
  hint += hintSuffix;
  queryDef.setHint( hint );

  RecordSpecification bindDataSpec;
  bindDataSpec.extend
    ( "tagId", RelationalObject2TagTable::columnTypeIds::tagId );
  Record bindData( bindDataSpec );
  bindData["tagId"].setValue( tagId );
  queryDef.setBindVariables( bindData );

  queryDef.addSelectItem( "MIN(" + RelationalObject2TagTable::columnNames::tagId + ")",
                          RelationalObject2TagTable::columnTypeIds::tagId, "tagId" );
  queryDef.addFromItem( object2TagTableName );

  try {
    const std::vector<RelationalTableRow> rows
      ( queryMgr.fetchOrderedRows( queryDef, desc, 1 ) );
    if ( rows[0].data()["tagId"].isNull() ) exists = false;
  } catch ( NoRowsFound& ) {
    exists = false;
  }
  return exists;
}

//-----------------------------------------------------------------------------
