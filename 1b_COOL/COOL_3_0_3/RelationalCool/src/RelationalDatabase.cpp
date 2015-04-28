// First of all, enable or disable the COOL290 API extensions (bug #92204)
#include "CoolKernel/VersionInfo.h"

// Include files
#include <map>
#include <vector>
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordException.h"
#include "CoolKernel/RecordSpecification.h"
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"

// Local include files
#include "IRelationalTransactionMgr.h"
#include "RelationalChannelTable.h"
#include "RelationalDatabase.h"
#include "RelationalDatabaseTable.h"
#include "RelationalException.h"
#include "RelationalFolderSet.h"
#include "RelationalGlobalTagTable.h"
#include "RelationalIovSharedSequenceTable.h"
#include "RelationalNodeMgr.h"
#include "RelationalNodeTable.h"
#include "RelationalObjectTable.h"
#include "RelationalObject2TagTable.h"
#include "RelationalObjectMgr.h"
#include "RelationalQueryDefinition.h"
#include "RelationalQueryMgr.h"
#include "RelationalSchemaMgr.h"
#include "RelationalTableRow.h"
#include "RelationalTag2TagTable.h"
#include "RelationalTagSequence.h"
#include "RelationalTagSharedSequenceTable.h"
#include "RelationalTagTable.h"
#include "RelationalTagMgr.h"
#include "VersionInfo.h"

// *** START *** 3.0.0 schema extensions (task #4307, task #4396)
#include "RelationalChannelTablesTable.h"
#include "RelationalGlobalHeadTagTable.h"
#include "RelationalGlobalUserTagTable.h"
#include "RelationalIovTablesTable.h"
// **** END **** 3.0.0 schema extensions (task #4307, task #4396)

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

RelationalDatabase::RelationalDatabase( const DatabaseId& dbId )
  : m_dbAttr()
  , m_isOpen( false )
  , m_relationalDbId( dbId )
  , m_log( new coral::MessageStream( "RelationalDatabase" ) )
  , m_queryMgr( 0 )
  , m_schemaMgr( 0 )
  , m_nodeMgr( 0 )
  , m_tagMgr( 0 )
{
  log() << coral::Debug << "Instantiate a RelationalDatabase for '"
        << m_relationalDbId.middleTier()
        << databaseId() << "'" << coral::MessageStream::endmsg;

  // Parse the dbId URL as RelationalDatabaseId connection parameters
  std::string technology = m_relationalDbId.technology();
  std::string server = m_relationalDbId.server();
  std::string user = m_relationalDbId.user();
  std::string password = m_relationalDbId.password();
  std::string schema = m_relationalDbId.schema();
  std::string dbName = m_relationalDbId.dbName();
  log() << "Technology: '" << technology << "'" << coral::MessageStream::endmsg;
  log() << "Server: '" << server << "'" << coral::MessageStream::endmsg;
  log() << "User: '" << user << "'" << coral::MessageStream::endmsg;
  if ( getenv( "COOL_AUTH_SHOWPASSWORD" ) )
    log() << "Password: '" << password << "'" << coral::MessageStream::endmsg;
  else
    log() << "Password: '" << "********" << "'" << coral::MessageStream::endmsg;
  log() << "Schema: '" << schema << "'"  << coral::MessageStream::endmsg;
  log() << "Conditions database name: '" << dbName << "'" << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

RelationalDatabase::~RelationalDatabase()
{
  //*m_pThis = NULL;
  //m_pThis.reset();
  log() << coral::Debug << "Delete the RelationalDatabase for '"
        << m_relationalDbId.middleTier()
        << databaseId() << "'" << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RelationalDatabase::checkDbOpenTransaction( const std::string& domain,
                                                 cool::AccessMode mode ) const
{
  if ( !isOpen() )
    throw DatabaseNotOpen( domain );
  if ( mode == cool::ReadWrite && isReadOnly() )
    throw DatabaseOpenInReadOnlyMode( domain );
  if ( !transactionMgr()->isActive() )
    throw RelationalException( "Transaction is not active", domain );
//  if ( mode == cool::ReadWrite && transactionMgr()->isReadOnly() )
//    throw cool::Exception( "Transaction is read only", domain );
}

//-----------------------------------------------------------------------------

const DatabaseId& RelationalDatabase::databaseId() const
{
  return m_relationalDbId.urlHidePswd();
}

//-----------------------------------------------------------------------------

const std::string& RelationalDatabase::databaseName() const
{
  return m_relationalDbId.dbName();
}

//-----------------------------------------------------------------------------

const IRecord& RelationalDatabase::databaseAttributes() const
{
  if ( ! isOpen() ) throw DatabaseNotOpen( "RelationalDatabase" );
  return m_dbAttr;
}

//-----------------------------------------------------------------------------

void RelationalDatabase::createDatabase()
{
  // Default attributes
  std::string dbName = databaseName();
  Record dbAttr( databaseAttributesSpecification() );

  std::string defaultTablePrefix = dbName + "_";
  dbAttr[RelationalDatabaseTable::attributeNames::defaultTablePrefix]
  .setValue( defaultTablePrefix );

  /*
  // *** START *** 3.0.0 schema extensions (task #4307)
  std::string channelTablesTableName =
    RelationalChannelTablesTable::defaultTableName( defaultTablePrefix );
  dbAttr[RelationalDatabaseTable::attributeNames::channelTablesTableName]
    .setValue( channelTablesTableName );

  std::string iovTablesTableName =
    RelationalIovTablesTable::defaultTableName( defaultTablePrefix );
  dbAttr[RelationalDatabaseTable::attributeNames::iovTablesTableName]
    .setValue( iovTablesTableName );
  // **** END **** 3.0.0 schema extensions (task #4307)
  *///

  std::string nodeTableName =
    RelationalNodeTable::defaultTableName( defaultTablePrefix );
  dbAttr[RelationalDatabaseTable::attributeNames::nodeTableName]
    .setValue( nodeTableName );

  std::string tagTableName =
    RelationalGlobalTagTable::defaultTableName( defaultTablePrefix );
  dbAttr[RelationalDatabaseTable::attributeNames::tagTableName]
    .setValue( tagTableName );

  /*
  // *** START *** 3.0.0 schema extensions (task #4396)
  std::string headTagTableName =
    RelationalGlobalHeadTagTable::defaultTableName( defaultTablePrefix );
  dbAttr[RelationalDatabaseTable::attributeNames::headTagTableName]
    .setValue( headTagTableName );

  std::string userTagTableName =
    RelationalGlobalUserTagTable::defaultTableName( defaultTablePrefix );
  dbAttr[RelationalDatabaseTable::attributeNames::userTagTableName]
    .setValue( userTagTableName );
  // **** END **** 3.0.0 schema extensions (task #4396)
  *///

  std::string tag2TagTableName =
    RelationalTag2TagTable::defaultTableName( defaultTablePrefix );
  dbAttr[RelationalDatabaseTable::attributeNames::tag2TagTableName]
    .setValue( tag2TagTableName );

  std::string tagSharedSequenceName =
    RelationalTagSharedSequenceTable::defaultTableName( defaultTablePrefix );
  dbAttr[RelationalDatabaseTable::attributeNames::tagSharedSequenceName]
    .setValue( tagSharedSequenceName );

  std::string iovSharedSequenceName =
    RelationalIovSharedSequenceTable::defaultTableName( defaultTablePrefix );
  dbAttr[RelationalDatabaseTable::attributeNames::iovSharedSequenceName]
    .setValue( iovSharedSequenceName );

  // Create a database with the default attributes
  return createDatabase( dbAttr );
}

//-----------------------------------------------------------------------------

void RelationalDatabase::openDatabase()
{

  std::string dbName = databaseName();
  log() << "Open the database with name " << dbName << coral::MessageStream::endmsg;

  // Connect to the backend server if not yet done
  if ( ! isConnected() ) connect();

  // Retrieve the database attributes in the top-level management table
  log() << "Fetch database attributes" << coral::MessageStream::endmsg;
  m_dbAttr = fetchDatabaseAttributes();
  log() << "Fetched database attributes: " << m_dbAttr << coral::MessageStream::endmsg;

  // Check that the release number and schema versions of the database are
  // compatible with the release number and schema versions of this client
  std::string releaseNumber =
    m_dbAttr[RelationalDatabaseTable::attributeNames::release].
    data<std::string>();
  std::string schemaVersion =
    m_dbAttr[RelationalDatabaseTable::attributeNames::schemaVersion].
    data<std::string>();
  if ( !areReleaseAndSchemaCompatible( releaseNumber, schemaVersion ) ) {
    std::stringstream s;
    s << "Release number mismatch - SCHEMA EVOLUTION REQUIRED: "
      << "database with OLDER release number " << releaseNumber
      << " cannot be opened using CURRENT client release number "
      << VersionInfo::release;
    throw IncompatibleReleaseNumber( s.str(), "RelationalDatabase" );
  }

  // The database is now open
  m_isOpen = true;
}

//-----------------------------------------------------------------------------

bool
RelationalDatabase::areReleaseAndSchemaCompatible
( const std::string releaseNumber,
  const std::string schemaVersion ) const
{
  bool status = true;
  // Preliminary check: this release must be 1.2.0 or later
  // MAKE SURE THAT 1.2.0 <= THISRELEASE
  VersionNumber db_rel_version(releaseNumber);
  VersionNumber db_schema_version(schemaVersion);

  if ( VersionInfo::release < "1.2.0" )
  {
    std::stringstream s;
    s << "PANIC! CURRENT client release number " << VersionInfo::release
      << " is older than 1.2.0?";
    throw IncompatibleReleaseNumber( s.str(), "RelationalDatabase" );
  }
  // Cannot open databases created with releases earlier than 1.2.0
  // No schema evolution is possible for such database schemas
  // DbRelease < 1.2.0
  else if ( db_rel_version < "1.2.0" )
  {
    std::stringstream s;
    s << "Release number mismatch"
      << " - SCHEMA EVOLUTION NOT POSSIBLE: "
      << "database with OLDER release number " << db_rel_version
      << " (older than 1.2.0)"
      << " cannot be opened using CURRENT client release number "
      << VersionInfo::release;
    throw IncompatibleReleaseNumber( s.str(), "RelationalDatabase" );
  }
  // Schema evolution for 1.2.0 <= DbRelease < THISRELEASE
  // Open databases created with releases earlier than this release
  else if ( db_rel_version < VersionInfo::release )
  {
    if (
#if defined(COOL290CO) || defined(COOL290EX) || defined(COOL290VP)
#if defined(COOL300)
        // This release (3.0.3) can read 3.0.x
        ( db_rel_version >= "3.0.0" && db_rel_version <= "3.0.3" ) ||
#endif
        // This release (2.9.6) can read 2.9.x
        ( db_rel_version >= "2.9.0" && db_rel_version <= "2.9.6" ) ||
#endif
        // This release (2.8.20) can read 2.8.x
        // This release (2.8.20) can read 2.7.0
        // This release (2.8.20) can read 2.6.0
        // This release (2.8.20) can read 2.5.0
        // This release (2.8.20) can read 2.4.0
        // This release (2.8.20) can read 2.3.x (including the unreleased 2.3.1)
        // This release (2.8.20) can read 2.2.x
        // This release (2.8.20) can read 2.1.x
        // This release (2.8.20) can read 2.0.0
        ( db_rel_version >= "2.8.0" && db_rel_version <= "2.8.20" ) ||
        ( db_rel_version == "2.7.0" ) ||
        ( db_rel_version == "2.6.0" ) ||
        ( db_rel_version == "2.5.0" ) ||
        ( db_rel_version == "2.4.0" ) ||
        ( db_rel_version >= "2.3.0" && db_rel_version <= "2.3.1" ) ||
        ( db_rel_version >= "2.2.0" && db_rel_version <= "2.2.2" ) ||
        ( db_rel_version >= "2.1.0" && db_rel_version <= "2.1.1" ) ||
        ( db_rel_version == "2.0.0" ) )
    {
      status = true;
      log() << coral::Info
            << "Release number backward compatibility "
            << "- NO SCHEMA EVOLUTION REQUIRED: "
            << "database with OLDER release number " << releaseNumber
            << " will be opened using CURRENT client release number "
            << VersionInfo::release << coral::MessageStream::endmsg;
    }
    // This release (2.8.20) needs schema evolution before it can read 1.3.x
    else if ( db_rel_version >= "1.3.0" && db_rel_version <= "1.3.4" )
    {
      status = false;
      log() << coral::Warning
            << "Release number mismatch"
            << " - SCHEMA EVOLUTION REQUIRED: "
            << "database with OLDER release number " << db_rel_version
            << " cannot be opened using CURRENT client release number "
            << VersionInfo::release << coral::MessageStream::endmsg;
    }
    // This release (2.8.20) needs schema evolution before it can read 1.2.x
    else if ( db_rel_version >= "1.2.0" && db_rel_version <= "1.2.9" )
    {
      status = false;
      log() << coral::Warning
            << "Release number mismatch"
            << " - SCHEMA EVOLUTION REQUIRED: "
            << "database with OLDER release number " << db_rel_version
            << " cannot be opened using CURRENT client release number "
            << VersionInfo::release << coral::MessageStream::endmsg;
    }
    // This release (2.8.20) can NOT read any other previous releases
    else
    {
      std::stringstream s;
      s << "PANIC! Release number mismatch: "
        << "database with (UNKNOWN!) OLDER release number "
        << db_rel_version
        << " cannot be opened using CURRENT client release number "
        << VersionInfo::release;
      throw IncompatibleReleaseNumber( s.str(), "RelationalDatabase" );
    }
  }
  // DbRelease == THISRELEASE
  else if ( db_rel_version == VersionInfo::release )
  {
    status = true;
    log() << coral::Debug
          << "Release number match: "
          << "database with CURRENT release number " << db_rel_version
          << " will be opened using CURRENT client release number "
          << VersionInfo::release << coral::MessageStream::endmsg;
  }
  // Check schema version for dbs created with releases newer than this one!
  // THIS_RELEASE < DbRelease
  else if ( VersionInfo::release < db_rel_version )
  {
    // Cannot open dbs with schema versions newer than that of this release!
    // THIS_SCHEMAVERSION < DbSchemaVersion
    if ( VersionInfo::schemaVersion < db_schema_version )
    {
      std::stringstream s;
      s << "Release number and schema version mismatch"
        << " - SCHEMA NOT BACKWARD COMPATIBLE: "
        << "database with NEWER release number " << db_rel_version
        << " and NEWER schema version " << db_schema_version
        << " cannot be opened using CURRENT client release number "
        << VersionInfo::release
        << " (CURRENT schema version " << VersionInfo::schemaVersion << ")";
      throw IncompatibleReleaseNumber( s.str(), "RelationalDatabase" );
    }
    // Open databases created using a newer release but the same schema version
    // THIS_SCHEMAVERSION == DbSchemaVersion
    else if ( VersionInfo::schemaVersion == db_schema_version )
    {
      status = true;
      log() << coral::Debug
            << "Release number mismatch with schema version match: "
            << "database with NEWER release number " << db_rel_version
            << " and CURRENT schema version " << db_schema_version
            << " will be opened using CURRENT client release number "
            << VersionInfo::release
            << " (CURRENT schema version "
            << VersionInfo::schemaVersion << ")"
            << coral::MessageStream::endmsg;
    }
    // PANIC! How can it be that a newer release has an older schema?
    else if ( VersionInfo::schemaVersion > db_schema_version )
    {
      std::stringstream s;
      s << "PANIC! Release number and schema version mismatch: "
        << "database with NEWER release number " << db_rel_version
        << " than CURRENT client release number " << VersionInfo::release
        << " has OLDER schema version " << db_schema_version
        << " (CURRENT schema version " << VersionInfo::schemaVersion << ")";
      throw IncompatibleReleaseNumber( s.str(), "RelationalDatabase" );
    }
    // PANIC! How can it be that none of "<", "==", ">" is true?
    else
    {
      std::stringstream s;
      s << "PANIC! Release number and schema version mismatch: "
        << "database with NEWER release number " << db_rel_version
        << " than CURRENT client release number " << VersionInfo::release
        << " has UNKNOWN schema version " << db_schema_version
        << " (CURRENT schema version " << VersionInfo::schemaVersion << ")";
      throw IncompatibleReleaseNumber( s.str(), "RelationalDatabase" );
    }
  }
  // PANIC! How can it be that none of "<", "==", ">" is true?
  else
  {
    std::stringstream s;
    s << "PANIC! Release number mismatch: "
      << "database with UNKNOWN release number " << db_rel_version
      << " cannot be opened using CURRENT client release number "
      << VersionInfo::release;
    throw IncompatibleReleaseNumber( s.str(), "RelationalDatabase" );
  }
  return status;
}

//-----------------------------------------------------------------------------

bool RelationalDatabase::isValidPayloadFieldName
( const std::string& name )
{
  static std::string allowedChar =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ_1234567890";
  const std::string ucName = uppercaseString( name );
  if ( name.size() < 1 ||
       name.size() > 30 ||
       ucName.find_first_not_of( allowedChar ) != ucName.npos ||
       ucName.find_first_not_of( "_1234567890" ) != 0 ||
       ucName.find( "COOL_" ) == 0 )
    return false;
  else
    return true;
}

//-----------------------------------------------------------------------------

void RelationalDatabase::validatePayloadSpecification
( const IRecordSpecification& spec )
{
  // Throw PayloadSpecificationTooManyFields if #fields > 900
  if ( spec.size() > 900 )
    throw PayloadSpecificationTooManyFields
      ( spec.size(), "RelationalDatabase" );

  // Throw PayloadSpecificationTooManyBlobFields if #blobFields > 10
  UInt32 nBlobFields = 0;
  for ( UInt32 i = 0; i < spec.size(); i++ )
    if ( spec[i].storageType().id() == cool_StorageType_TypeId::Blob64k ||
         spec[i].storageType().id() == cool_StorageType_TypeId::Blob16M ) nBlobFields++;
  if ( nBlobFields > 10 )
    throw PayloadSpecificationTooManyBlobFields
      ( nBlobFields, "RelationalDatabase" );

  // Throw PayloadSpecificationTooManyString255Fields if #string255Fields > 200
  UInt32 nSt255Fields = 0;
  for ( UInt32 i = 0; i < spec.size(); i++ )
    if ( spec[i].storageType().id() == cool_StorageType_TypeId::String255 ) nSt255Fields++;
  if ( nSt255Fields > 200 )
    throw PayloadSpecificationTooManyString255Fields
      ( nSt255Fields, "RelationalDatabase" );

  // Throw PayloadSpecificationInvalidFieldName if any field names are invalid.
  // Names of payload fields must have between 1 and 30 characters (including
  // only letters, digits or '_'), must start with a letter and cannot start
  // with the "COOL_" prefix (in any lowercase/uppercase combination).
  for ( UInt32 i = 0; i < spec.size(); i++ ) {
    const std::string& name = spec[i].name();
    if ( ! isValidPayloadFieldName( name ) )
      throw PayloadSpecificationInvalidFieldName( name, "RelationalDatabase" );
  }
}

//-----------------------------------------------------------------------------

void RelationalDatabase::closeDatabase()
{
  disconnect();
  m_isOpen = false;
}

//-----------------------------------------------------------------------------

const std::string RelationalDatabase::mainTableName() const
{
  return RelationalDatabaseTable::tableName( databaseName() );
}

//-----------------------------------------------------------------------------

const std::string RelationalDatabase::defaultTablePrefix() const
{
  if ( ! isOpen() ) throw DatabaseNotOpen( "RelationalDatabase" );
  const IRecord& dbAttr = databaseAttributes();
  std::string theDefaultTablePrefix =
    dbAttr[RelationalDatabaseTable::attributeNames::defaultTablePrefix]
    .data<RelationalDatabaseTable::columnTypes::attributeValue>();
  return theDefaultTablePrefix;
}

//-----------------------------------------------------------------------------

// *** START *** 3.0.0 schema extensions (task #4307)
const std::string RelationalDatabase::iovTablesTableName() const
{
  if ( ! isOpen() ) throw DatabaseNotOpen( "RelationalDatabase" );
  const IRecord& dbAttr = databaseAttributes();
  std::string tableName =
    dbAttr[RelationalDatabaseTable::attributeNames::iovTablesTableName]
    .data<RelationalDatabaseTable::columnTypes::attributeValue>();
  return tableName;
}

//-----------------------------------------------------------------------------

const std::string RelationalDatabase::channelTablesTableName() const
{
  if ( ! isOpen() ) throw DatabaseNotOpen( "RelationalDatabase" );
  const IRecord& dbAttr = databaseAttributes();
  std::string tableName =
    dbAttr[RelationalDatabaseTable::attributeNames::channelTablesTableName]
    .data<RelationalDatabaseTable::columnTypes::attributeValue>();
  return tableName;
}
// **** END **** 3.0.0 schema extensions (task #4307)

//-----------------------------------------------------------------------------

const std::string RelationalDatabase::nodeTableName() const
{
  if ( ! isOpen() ) throw DatabaseNotOpen( "RelationalDatabase" );
  const IRecord& dbAttr = databaseAttributes();
  std::string theNodeTableName =
    dbAttr[RelationalDatabaseTable::attributeNames::nodeTableName]
    .data<RelationalDatabaseTable::columnTypes::attributeValue>();
  return theNodeTableName;
}

//-----------------------------------------------------------------------------

const std::string RelationalDatabase::globalTagTableName() const
{
  if ( ! isOpen() ) throw DatabaseNotOpen( "RelationalDatabase" );
  const IRecord& dbAttr = databaseAttributes();
  std::string tableName =
    dbAttr[RelationalDatabaseTable::attributeNames::tagTableName]
    .data<RelationalDatabaseTable::columnTypes::attributeValue>();
  return tableName;
}

//-----------------------------------------------------------------------------

// *** START *** 3.0.0 schema extensions (task #4396)
const std::string RelationalDatabase::globalHeadTagTableName() const
{
  if ( ! isOpen() ) throw DatabaseNotOpen( "RelationalDatabase" );
  const IRecord& dbAttr = databaseAttributes();
  std::string tableName =
    dbAttr[RelationalDatabaseTable::attributeNames::headTagTableName]
    .data<RelationalDatabaseTable::columnTypes::attributeValue>();
  return tableName;
}

//-----------------------------------------------------------------------------

const std::string RelationalDatabase::globalUserTagTableName() const
{
  if ( ! isOpen() ) throw DatabaseNotOpen( "RelationalDatabase" );
  const IRecord& dbAttr = databaseAttributes();
  std::string tableName =
    dbAttr[RelationalDatabaseTable::attributeNames::userTagTableName]
    .data<RelationalDatabaseTable::columnTypes::attributeValue>();
  return tableName;
}
// **** END **** 3.0.0 schema extensions (task #4396)

//-----------------------------------------------------------------------------

const std::string RelationalDatabase::tag2TagTableName() const
{
  if ( ! isOpen() ) throw DatabaseNotOpen( "RelationalDatabase" );
  const IRecord& dbAttr = databaseAttributes();
  std::string tableName =
    dbAttr[RelationalDatabaseTable::attributeNames::tag2TagTableName]
    .data<RelationalDatabaseTable::columnTypes::attributeValue>();
  return tableName;
}

//-----------------------------------------------------------------------------

const std::string RelationalDatabase::tagSharedSequenceName() const
{
  if ( ! isOpen() ) throw DatabaseNotOpen( "RelationalDatabase" );
  const IRecord& dbAttr = databaseAttributes();
  std::string tableName =
    dbAttr[RelationalDatabaseTable::attributeNames::tagSharedSequenceName]
    .data<RelationalDatabaseTable::columnTypes::attributeValue>();
  return tableName;
}

//-----------------------------------------------------------------------------

const std::string RelationalDatabase::iovSharedSequenceName() const
{
  if ( ! isOpen() ) throw DatabaseNotOpen( "RelationalDatabase" );
  const IRecord& dbAttr = databaseAttributes();
  std::string tableName =
    dbAttr[RelationalDatabaseTable::attributeNames::iovSharedSequenceName]
    .data<RelationalDatabaseTable::columnTypes::attributeValue>();
  return tableName;
}

//-----------------------------------------------------------------------------

/*
bool RelationalDatabase::isValidAttributeListSpecification
( const coral::AttributeListSpecification& spec )
{
  coral::AttributeListSpecification::const_iterator it;
  for ( it=spec.begin(); it!=spec.end(); ++it ) {
    std::string attrName = it->name();

    // Check that attribute names only contain alphanumeric characters or '_'
    static std::string allowedChar =
      "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_";
    if ( attrName.find_first_not_of(allowedChar) != std::string::npos ) {
      log() << coral::Debug << "Invalid character in attribute name: '"
            << attrName << "'" << coral::MessageStream::endmsg;
      return false;
    }

  }
  return true;
}
*///

//-----------------------------------------------------------------------------

bool RelationalDatabase::isOpen() const
{
  return m_isOpen;
}

//-----------------------------------------------------------------------------

coral::MessageStream& RelationalDatabase::log() const
{
  *m_log << coral::Verbose;
  return *m_log;
}

//-----------------------------------------------------------------------------

RelationalQueryMgr& RelationalDatabase::queryMgr() const
{
  if ( m_queryMgr.get() )
    return *m_queryMgr;
  else
    throw RelationalException
      ( "PANIC! RelationalQueryMgr pointer is null", "RelationalDatabase" );
}

//-----------------------------------------------------------------------------

RelationalSchemaMgr& RelationalDatabase::schemaMgr() const
{
  if ( m_schemaMgr.get() )
    return *m_schemaMgr;
  else
    throw RelationalException
      ( "PANIC! RelationalSchemaMgr pointer is null", "RelationalDatabase" );
}

//-----------------------------------------------------------------------------

RelationalNodeMgr& RelationalDatabase::nodeMgr() const
{
  if ( m_nodeMgr.get() )
    return *m_nodeMgr;
  else
    throw RelationalException
      ( "PANIC! RelationalNodeMgr pointer is null", "RelationalDatabase" );
}

//-----------------------------------------------------------------------------

RelationalTagMgr& RelationalDatabase::tagMgr() const
{
  if ( m_tagMgr.get() )
    return *m_tagMgr;
  else
    throw RelationalException
      ( "PANIC! RelationalTagMgr pointer is null", "RelationalDatabase" );
}

//-----------------------------------------------------------------------------

const RelationalObjectMgr& RelationalDatabase::objectMgr() const
{
  if ( m_objectMgr.get() )
    return *m_objectMgr;
  else
    throw RelationalException
      ( "PANIC! RelationalObjectMgr pointer is null",
        "RelationalDatabase" );
}

//-----------------------------------------------------------------------------

void RelationalDatabase::setQueryMgr
( std::auto_ptr<RelationalQueryMgr> queryMgr )
{
  m_queryMgr = queryMgr;
}

//-----------------------------------------------------------------------------

void RelationalDatabase::setSchemaMgr
( std::auto_ptr<RelationalSchemaMgr> schemaMgr )
{
  m_schemaMgr = schemaMgr;
}

//-----------------------------------------------------------------------------

void RelationalDatabase::setNodeMgr( std::auto_ptr<RelationalNodeMgr> nodeMgr )
{
  m_nodeMgr = nodeMgr;
}

//-----------------------------------------------------------------------------

void RelationalDatabase::setTagMgr( std::auto_ptr<RelationalTagMgr> tagMgr )
{
  m_tagMgr = tagMgr;
}

//-----------------------------------------------------------------------------

void RelationalDatabase::setObjectMgr
( std::auto_ptr<RelationalObjectMgr> objectMgr )
{
  m_objectMgr = objectMgr;
}

//-----------------------------------------------------------------------------

boost::shared_ptr<IRelationalTransactionMgr>
RelationalDatabase::transactionMgr() const
{
  if ( m_transactionMgr.get() )
    return m_transactionMgr;
  else
    throw RelationalException
      ( "PANIC! RelationalTransactionMgr pointer is null",
        "RelationalDatabase" );
}

//-----------------------------------------------------------------------------

void RelationalDatabase::setTransactionMgr
( boost::shared_ptr<IRelationalTransactionMgr> transactionMgr )
{
  m_transactionMgr = transactionMgr;
}

//-----------------------------------------------------------------------------

const IRecordSpecification&
RelationalDatabase::databaseAttributesSpecification()
{
  static RecordSpecification s_dbAttrSpec;

  if ( s_dbAttrSpec.size() == 0 ) {
    s_dbAttrSpec.extend
      ( RelationalDatabaseTable::attributeNames::defaultTablePrefix,
        RelationalDatabaseTable::columnTypeIds::attributeValue );
    /*
    // *** START *** 3.0.0 schema extensions (task #4307)
    s_dbAttrSpec.extend
      ( RelationalDatabaseTable::attributeNames::iovTablesTableName,
        RelationalDatabaseTable::columnTypeIds::attributeValue );
    s_dbAttrSpec.extend
      ( RelationalDatabaseTable::attributeNames::channelTablesTableName,
        RelationalDatabaseTable::columnTypeIds::attributeValue );
    // **** END **** 3.0.0 schema extensions (task #4307)
    *///
    s_dbAttrSpec.extend
      ( RelationalDatabaseTable::attributeNames::nodeTableName,
        RelationalDatabaseTable::columnTypeIds::attributeValue );
    /*
    // *** START *** 3.0.0 schema extensions (task #4396)
    s_dbAttrSpec.extend
      ( RelationalDatabaseTable::attributeNames::headTagTableName,
        RelationalDatabaseTable::columnTypeIds::attributeValue );
    s_dbAttrSpec.extend
      ( RelationalDatabaseTable::attributeNames::userTagTableName,
        RelationalDatabaseTable::columnTypeIds::attributeValue );
    // **** END **** 3.0.0 schema extensions (task #4396)
    *///
    s_dbAttrSpec.extend
      ( RelationalDatabaseTable::attributeNames::tagTableName,
        RelationalDatabaseTable::columnTypeIds::attributeValue );
    s_dbAttrSpec.extend
      ( RelationalDatabaseTable::attributeNames::tag2TagTableName,
        RelationalDatabaseTable::columnTypeIds::attributeValue );
    s_dbAttrSpec.extend
      ( RelationalDatabaseTable::attributeNames::tagSharedSequenceName,
        RelationalDatabaseTable::columnTypeIds::attributeValue );
    s_dbAttrSpec.extend
      ( RelationalDatabaseTable::attributeNames::iovSharedSequenceName,
        RelationalDatabaseTable::columnTypeIds::attributeValue );
    s_dbAttrSpec.extend
      ( RelationalDatabaseTable::attributeNames::release,
        RelationalDatabaseTable::columnTypeIds::attributeValue );
    s_dbAttrSpec.extend
      ( RelationalDatabaseTable::attributeNames::cvsCheckout,
        RelationalDatabaseTable::columnTypeIds::attributeValue );
    s_dbAttrSpec.extend
      ( RelationalDatabaseTable::attributeNames::cvsCheckin,
        RelationalDatabaseTable::columnTypeIds::attributeValue );
    s_dbAttrSpec.extend
      ( RelationalDatabaseTable::attributeNames::schemaVersion,
        RelationalDatabaseTable::columnTypeIds::attributeValue );
  }
  return s_dbAttrSpec;
}

//-----------------------------------------------------------------------------

const StorageType&
RelationalDatabase::storageType( const std::string& name )
{
  if ( name == "Bool" )
    return StorageType::storageType( cool_StorageType_TypeId::Bool );
  //if ( name == "Char" )
  //  return StorageType::storageType( cool_StorageType_TypeId::Char );
  if ( name == "UChar" )
    return StorageType::storageType( cool_StorageType_TypeId::UChar );
  if ( name == "Int16" )
    return StorageType::storageType( cool_StorageType_TypeId::Int16 );
  if ( name == "UInt16" )
    return StorageType::storageType( cool_StorageType_TypeId::UInt16 );
  if ( name == "Int32" )
    return StorageType::storageType( cool_StorageType_TypeId::Int32 );
  if ( name == "UInt32" )
    return StorageType::storageType( cool_StorageType_TypeId::UInt32 );
  if ( name == "UInt63" )
    return StorageType::storageType( cool_StorageType_TypeId::UInt63 );
  if ( name == "Int64" )
    return StorageType::storageType( cool_StorageType_TypeId::Int64 );
  //if ( name == "UInt64" )
  //  return StorageType::storageType( cool_StorageType_TypeId::UInt64 );
  if ( name == "Float" )
    return StorageType::storageType( cool_StorageType_TypeId::Float );
  if ( name == "Double" )
    return StorageType::storageType( cool_StorageType_TypeId::Double );
  if ( name == "String255" )
    return StorageType::storageType( cool_StorageType_TypeId::String255 );
  if ( name == "String4k" )
    return StorageType::storageType( cool_StorageType_TypeId::String4k );
  if ( name == "String64k" )
    return StorageType::storageType( cool_StorageType_TypeId::String64k );
  if ( name == "String16M" )
    return StorageType::storageType( cool_StorageType_TypeId::String16M );
  if ( name == "Blob64k" )
    return StorageType::storageType( cool_StorageType_TypeId::Blob64k );
  if ( name == "Blob16M" )
    return StorageType::storageType( cool_StorageType_TypeId::Blob16M );
  throw RelationalException
    ( "PANIC! No StorageType exists with name " + name, "RelationalDatabase" );
}

//-----------------------------------------------------------------------------

const std::string RelationalDatabase::encodeRecordSpecification
( const IRecordSpecification& recordSpec )
{
  std::ostringstream out;
  for ( unsigned int i=0; i<recordSpec.size(); i++ ) {
    const IFieldSpecification& fieldSpec = recordSpec[i];
    if ( i != 0 ) out << ",";
    out << fieldSpec.name()
        << ":" << fieldSpec.storageType().name();
  }
  return out.str();
}

//-----------------------------------------------------------------------------

const RecordSpecification
RelationalDatabase::decodeRecordSpecification( const std::string& encodedSpec )
{
  RecordSpecification recordSpec;
  if ( !encodedSpec.empty() ) {
    std::string::size_type pos = 0;
    while ( pos != encodedSpec.npos ) {
      std::string::size_type newpos = encodedSpec.find( ',', pos );
      std::string item_str;
      if ( newpos != encodedSpec.npos )
        item_str = encodedSpec.substr(pos,newpos-pos);
      else
        item_str = encodedSpec.substr(pos);
      std::string::size_type separator_pos = item_str.find(':');
      if ( separator_pos == item_str.npos )
        throw RelationalException
          ( std::string
            ( "Bad format, ':' not found in encoded RecordSpecification '" )
            + encodedSpec + "'", "RelationalDatabase" );
      recordSpec.extend
        ( item_str.substr( 0, separator_pos ),
          RelationalDatabase::storageType
          ( item_str.substr( separator_pos+1 ) ) );
      pos = ( newpos != encodedSpec.npos ) ? newpos+1 : newpos;
    }
  }
  return recordSpec;
}

//-----------------------------------------------------------------------------

RelationalTableRow
RelationalDatabase::fetchTagTableRow( const std::string& tagTableName,
                                      const std::string& tagName )
{
  log() << "Fetch tag table row for tag " << tagName
        << " from table '" << tagTableName
        << "'" << coral::MessageStream::endmsg;

  // Define the WHERE clause for the selection using bind variables
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "tagName",
                        RelationalTagTable::columnTypeIds::tagName );
  Record whereData( whereDataSpec );
  whereData["tagName"].setValue( tagName );
  std::string whereClause = RelationalTagTable::columnNames::tagName;
  whereClause += "= :tagName";

  // Delegate the query to the RelationalQueryMgr
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( tagTableName );
  queryDef.addSelectItems( RelationalTagTable::tableSpecification() );
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );
  try
  {
    return queryMgr().fetchOrderedRows( queryDef, "", 1 )[0]; // expect 1 row
  }
  catch( NoRowsFound& )
  {
    throw TagNotFound
      ( "Tag '" + tagName + "' not found in local tag table " + tagTableName ,
        "RelationalDatabase" );
  }
}

//-----------------------------------------------------------------------------

const IHvsTagMgr& RelationalDatabase::hvsTagMgr() const
{
  return tagMgr();
}

//-----------------------------------------------------------------------------

const Record RelationalDatabase::fetchDatabaseAttributes() const
{
  // Fetch all rows from the top-level management table
  std::vector<RelationalTableRow> rows;
  try
  {
    RelationalQueryDefinition queryDef;
    queryDef.addFromItem( mainTableName() );
    queryDef.addSelectItems( RelationalDatabaseTable::tableSpecification() );
    rows = queryMgr().fetchOrderedRows( queryDef ); // no WHERE or ORDER clause
  }
  catch ( TableNotFound& )
  {
    log() << coral::Verbose
          << "Could not open database - main database table not found"
          << coral::MessageStream::endmsg;
    throw DatabaseDoesNotExist( "RelationalDatabase" );
  }

  // Create a new database attributes Record from the rows retrieved
  // Read ALL rows even if they are not in the default specification
  // (e.g. read schema evolution information where present)
  // Use a vector instead of a map to keep the order of properties.
  std::vector < std::pair<std::string, std::string> > propertyList;
  RecordSpecification spec;
  const StorageType::TypeId attrTypeId =
    RelationalDatabaseTable::columnTypeIds::attributeValue;
  for ( std::vector<RelationalTableRow>::const_iterator
          row = rows.begin(); row != rows.end(); ++row )
  {
    std::string attrName =
      (*row)[RelationalDatabaseTable::columnNames::attributeName].
      data<std::string>();
    std::string attrValue =
      (*row)[RelationalDatabaseTable::columnNames::attributeValue].
      data<std::string>();
    spec.extend( attrName, attrTypeId );
    std::pair<std::string, std::string> property( attrName, attrValue );
    propertyList.push_back( property );
  }
  Record dbAttr( spec );
  for ( std::vector < std::pair<std::string, std::string> >::const_iterator
          prop = propertyList.begin(); prop != propertyList.end(); ++prop )
  {
    dbAttr[prop->first].setValue( prop->second );
  }

  // Return the database attributes
  return dbAttr;
}

//-----------------------------------------------------------------------------

RelationalTableRow
RelationalDatabase::fetchObject2TagTableRow
( const std::string& object2TagTableName,
  unsigned int tagId,
  unsigned int objectId,
  PayloadMode::Mode pMode )
{
  // Define the WHERE clause for the selection using bind variables
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "tagId",
                        RelationalObject2TagTable::columnTypeIds::tagId );
  whereDataSpec.extend( "objectId",
                        RelationalObject2TagTable::columnTypeIds::objectId );
  Record whereData( whereDataSpec );
  whereData["tagId"].setValue( tagId );
  whereData["objectId"].setValue( objectId );
  std::string whereClause = RelationalObject2TagTable::columnNames::tagId;
  whereClause += "= :tagId";
  whereClause += " and ";
  whereClause += RelationalObject2TagTable::columnNames::objectId;
  whereClause += "= :objectId";

  // Delegate the query to the RelationalQueryMgr
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( object2TagTableName );
  queryDef.addSelectItems
    ( RelationalObject2TagTable::tableSpecification( pMode ) );
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );
  std::stringstream s;
  s << "Query object2Tag table row with tag_id=" << tagId
    << " and object_id=" << objectId;
  return queryMgr().fetchOrderedRows( queryDef, s.str(), 1 )[0]; // expct 1 row
}

//-----------------------------------------------------------------------------

const RelationalTableRow
RelationalDatabase::fetchNodeTableRow( const std::string& fullPath ) const
{
  return nodeMgr().fetchNodeTableRow( fullPath );
}

//-----------------------------------------------------------------------------

const RelationalTableRow
RelationalDatabase::fetchNodeTableRow( unsigned int nodeId ) const
{
  return nodeMgr().fetchNodeTableRow( nodeId );
}

//-----------------------------------------------------------------------------

const RelationalTableRow
RelationalDatabase::fetchNodeTableRow( const std::string& whereClause,
                                       const Record& whereData ) const
{
  return nodeMgr().fetchNodeTableRow( whereClause, whereData );
}

//-----------------------------------------------------------------------------

const std::vector<std::string>
RelationalDatabase::listNodes( unsigned int nodeId,
                               bool isLeaf,
                               bool ascending ) const
{
  return nodeMgr().listNodes( nodeId, isLeaf, ascending );
}

//-----------------------------------------------------------------------------

const std::vector<std::string>
RelationalDatabase::listFolders( const RelationalFolderSet* folderset,
                                 bool ascending ) const
{
  // Cross-check that the database is open
  checkDbOpenTransaction( "RelationalDatabase::listFolders",
                          cool::ReadOnly );

  bool isLeaf = true;
  std::vector<std::string>
    nodes( listNodes( folderset->id(), isLeaf, ascending ) );

  return nodes;
}

//-----------------------------------------------------------------------------

const std::vector<std::string>
RelationalDatabase::listFolderSets( const RelationalFolderSet* folderset,
                                    bool ascending ) const
{
  // Cross-check that the database is open
  checkDbOpenTransaction( "RelationalDatabase::listFolderSets",
                          cool::ReadOnly );

  bool isLeaf = false;
  std::vector<std::string>
    nodes( listNodes( folderset->id(), isLeaf, ascending ) );

  return nodes;
}

//-----------------------------------------------------------------------------

const std::vector<std::string>
RelationalDatabase::listAllNodes( bool ascending )
{
  // Cross-check that the database is open
  checkDbOpenTransaction( "RelationalDatabase::listAllNodes",
                          cool::ReadOnly );

  // Delegate to the node manager
  std::vector<std::string> nodeList = nodeMgr().listAllNodes( ascending );

  // Return the list of nodes
  return nodeList;
}

//-----------------------------------------------------------------------------

/*
const std::vector<std::string>
RelationalDatabase::listAllNodes( bool ascending )
{
  return nodeMgr().listAllNodes( ascending );
}
*///

//-----------------------------------------------------------------------------

bool RelationalDatabase::existsNode( const std::string& fullPath )
{
  return nodeMgr().existsNode( fullPath );
}

//-----------------------------------------------------------------------------

bool RelationalDatabase::existsFolderSet( const std::string& fullPath )
{
  return nodeMgr().existsFolderSet( fullPath );
}

//-----------------------------------------------------------------------------

bool RelationalDatabase::existsFolder( const std::string& fullPath )
{
  return nodeMgr().existsFolder( fullPath );
}

//-----------------------------------------------------------------------------

const std::vector<std::string> RelationalDatabase::listAllTables() const
{
  checkDbOpenTransaction( "RelationalDatabase::listAllTables",
                          cool::ReadOnly );
  std::vector<std::string> tables;

  // Get the database schema version
  std::string dbSchemaVersion =
    m_dbAttr[RelationalDatabaseTable::attributeNames::schemaVersion].
    data<std::string>();

  // Add the tables of each node
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( nodeTableName() );
  queryDef.addSelectItems( RelationalNodeTable::tableSpecification( VersionNumber( dbSchemaVersion ) ) );
  std::vector<RelationalTableRow> nodes =
    queryMgr().fetchOrderedRows( queryDef );
  std::vector<RelationalTableRow>::const_iterator node;
  for ( node = nodes.begin(); node != nodes.end(); node++ )
  {
    std::string fullPath =
      (*node)[RelationalNodeTable::columnNames::nodeFullPath]
      .data<std::string>();
    bool isLeaf =
      (*node)[RelationalNodeTable::columnNames::nodeIsLeaf].data<bool>();
    // If the database schema version is 2.0.0 or higher, check that
    // the node schema version is supported by this software release
    if ( VersionNumber( dbSchemaVersion ) >= VersionNumber( "2.0.0" ) )
    {
      VersionNumber schemaVersion =
        (*node)[RelationalNodeTable::columnNames::nodeSchemaVersion]
        .data<std::string>();
      bool isSupported = true;
      if ( isLeaf )
      {
        if ( !RelationalFolder::isSupportedSchemaVersion( schemaVersion ) )
        {
          // Hack: 2.0.0 folders are not supported, but tables can be listed
          if ( schemaVersion != VersionNumber( "2.0.0" ) )
            isSupported = false;
        }
      }
      else
      {
        if ( !RelationalFolderSet::isSupportedSchemaVersion( schemaVersion ) )
          isSupported = false;
      }
      if ( VersionInfo::release < schemaVersion )
      {
        std::stringstream s;
        s << "Cannot list tables for node:";
        if ( isLeaf ) s << " folder '";
        else s << " folder set '";
        s << fullPath << " has schema version " << schemaVersion
          << " that is newer than this software release "
          << VersionInfo::release;
        log() << coral::Warning << s.str() << coral::MessageStream::endmsg;
        if ( isLeaf )
          throw UnsupportedFolderSchema( s.str(), "RelationalDatabase" );
        else
          throw UnsupportedFolderSetSchema( s.str(), "RelationalDatabase" );
      }
      else if ( !isSupported )
      {
        std::stringstream s;
        s << "PANIC! Cannot list tables for node:";
        if ( isLeaf ) s << " folder '";
        else s << " folder set '";
        s << fullPath
          << "' appears to have been created using UNKNOWN schema version "
          << schemaVersion
          << " that is older than (or as old as) the current software release "
          << VersionInfo::release;
        throw PanicException( s.str(), "RalDatabase" );
      }
    }
    unsigned int nodeId =
      (*node)[RelationalNodeTable::columnNames::nodeId].data<unsigned int>();
    // Node is a folder
    if ( isLeaf )
    {
      // Add tables for MV folders
      FolderVersioning::Mode versioningMode =
        RelationalFolder::versioningMode( (*node).data() );
      if ( versioningMode == cool_FolderVersioning_Mode::MULTI_VERSION )
      {
        // Add the IOV2tag table
        tables.push_back
          ( RelationalFolder::object2TagTableName( (*node).data() ) );
        // Add the local tag sequence
        tables.push_back
          ( RelationalTagSequence::sequenceName
            ( defaultTablePrefix(), nodeId ) );
        // Add the local tag table
        tables.push_back
          ( RelationalFolder::tagTableName( (*node).data() ) );
      }
      // Add the channel table (2.0.0 or higher)
      if ( VersionNumber( dbSchemaVersion ) >= VersionNumber( "2.0.0" ) )
        tables.push_back
          ( RelationalChannelTable::defaultTableName
            ( defaultTablePrefix(), nodeId ) );
      // Add the IOV table and the associated sequence
      tables.push_back
        ( RelationalObjectTable::sequenceName
          ( RelationalFolder::objectTableName((*node).data()) ) );
      tables.push_back
        ( RelationalFolder::objectTableName( (*node).data() ) );
    }
    // Node is a folder set
    else
    {
      // Add the local tag sequence
      tables.push_back
        ( RelationalTagSequence::sequenceName
          ( defaultTablePrefix(), nodeId ) );
    }
  }

  // Add the global tag table
  tables.push_back( globalTagTableName() );

  // Add the tag2tag table and its associated sequence
  tables.push_back( RelationalTag2TagTable::sequenceName(tag2TagTableName()) );
  tables.push_back( tag2TagTableName() );

  // Add the node table and its associated sequence
  tables.push_back( RelationalNodeTable::sequenceName(nodeTableName()) );
  tables.push_back( nodeTableName() );

  // Add the main table
  tables.push_back( mainTableName() );

  // Return the full list of tables
  return tables;
}

//-----------------------------------------------------------------------------
