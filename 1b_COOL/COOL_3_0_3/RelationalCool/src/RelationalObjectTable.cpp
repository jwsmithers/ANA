// Include files
#include "CoralBase/AttributeSpecification.h"

// Local include files
#include "boost_algorithm_headers.h"
#include "HvsTagRecord.h"
#include "ObjectId.h"
#include "RelationalChannelTable.h"
#include "RelationalException.h"
#include "RelationalFolder.h"
#include "RelationalObject.h"
#include "RelationalObjectTable.h"
#include "RelationalObjectTableRow.h"
#include "RelationalObject2TagTable.h"
#include "RelationalPayloadTable.h"
#include "RelationalPayloadQuery.h"
#include "RelationalQueryDefinition.h"
#include "RelationalQueryMgr.h"
#include "RelationalTagMgr.h"
#include "RelationalTagTable.h"
#include "timeToString.h"

// Local include files
#include "scoped_enums.h"

// Namespace
using namespace cool;

//---------------------------------------------------------------------------

RelationalObjectTable::RelationalObjectTable( const RelationalQueryMgr& queryMgr,
                                              const RelationalFolder& folder )
  : m_log( new coral::MessageStream( "RelationalObjectTable" ) )
  , m_queryMgr( queryMgr )
  , m_tagMgr( folder.db().tagMgr() )
  , m_payloadSpecification( folder.payloadSpecification() )
  , m_tableSpecification( tableSpecification( folder.payloadSpecification(),
                                              folder.payloadMode() ) )
  , m_payloadMode( folder.payloadMode() )
  , m_nodeId( folder.id() )
{
  m_objectTableName = folder.objectTableName();
  if ( folder.versioningMode() == cool_FolderVersioning_Mode::MULTI_VERSION ) {
    m_tagTableName = folder.tagTableName();
    m_object2TagTableName = folder.object2TagTableName();
  } else {
    m_tagTableName = "";
    m_object2TagTableName = "";
  }
  m_channelTableName = folder.channelTableName();
  m_payloadTableName = folder.payloadTableName();
}

//---------------------------------------------------------------------------

coral::MessageStream& RelationalObjectTable::log() const
{
  *m_log << coral::Verbose;
  return *m_log;
}

//---------------------------------------------------------------------------

RelationalObjectTable::~RelationalObjectTable()
{
}

//---------------------------------------------------------------------------

const IRecordSpecification&
RelationalObjectTable::defaultSpecification()
{
  static RecordSpecification spec;

  if ( spec.size() == 0 ) {
    spec.extend( RelationalObjectTable::columnNames::objectId(),
                 RelationalObjectTable::columnTypeIds::objectId );
    spec.extend( RelationalObjectTable::columnNames::channelId(),
                 RelationalObjectTable::columnTypeIds::channelId );
    spec.extend( RelationalObjectTable::columnNames::iovSince(),
                 RelationalObjectTable::columnTypeIds::iovSince );
    spec.extend( RelationalObjectTable::columnNames::iovUntil(),
                 RelationalObjectTable::columnTypeIds::iovUntil );
    spec.extend( RelationalObjectTable::columnNames::userTagId(),
                 RelationalObjectTable::columnTypeIds::userTagId );
    spec.extend( RelationalObjectTable::columnNames::sysInsTime(),
                 RelationalObjectTable::columnTypeIds::sysInsTime );
    spec.extend( RelationalObjectTable::columnNames::lastModDate(),
                 RelationalObjectTable::columnTypeIds::lastModDate );

    // Management columns for 'MultiVersion' folders
    spec.extend( RelationalObjectTable::columnNames::originalId(),
                 RelationalObjectTable::columnTypeIds::originalId );
    spec.extend( RelationalObjectTable::columnNames::newHeadId(),
                 RelationalObjectTable::columnTypeIds::newHeadId );
  }

  return spec;
}

//---------------------------------------------------------------------------

const RecordSpecification
RelationalObjectTable::tableSpecification
( const IRecordSpecification& payloadSpec, PayloadMode::Mode type )
{
  RecordSpecification spec;
  for ( unsigned int i=0; i<defaultSpecification().size(); i++ ) {
    const IFieldSpecification& field = defaultSpecification()[i];
    spec.extend( field.name(), field.storageType() );
  }
  // If the payload is not in a separate table, add the payload fields
  if ( type == cool_PayloadMode_Mode::INLINEPAYLOAD ) {
    for ( unsigned int i=0; i<payloadSpec.size(); i++ ) {
      const IFieldSpecification& field = payloadSpec[i];
      spec.extend( field.name(), field.storageType() );
    }
  }
  // If the payload is in a separate table, add the payloadId
  else if ( type == cool_PayloadMode_Mode::SEPARATEPAYLOAD )
  {
    spec.extend( RelationalObjectTable::columnNames::payloadId(),
                 RelationalObjectTable::columnTypeIds::payloadId );
  }
  else
  {
    // vector payload mode
    spec.extend( RelationalObjectTable::columnNames::payloadSetId(),
                 RelationalObjectTable::columnTypeIds::payloadSetId );
    spec.extend( RelationalObjectTable::columnNames::payloadSize(),
                 RelationalObjectTable::columnTypeIds::payloadSize );
  }
  return spec;
}

//---------------------------------------------------------------------------

const coral::AttributeList
RelationalObjectTable::rowAttributeList
( const coral::AttributeList& payload, PayloadMode::Mode pMode )
{
  RecordSpecification tmp=defaultSpecification();
  if ( pMode == cool_PayloadMode_Mode::SEPARATEPAYLOAD )
  {
    tmp.extend( RelationalObjectTable::columnNames::payloadId(),
                RelationalObjectTable::columnTypeIds::payloadId );
  }
  else if ( pMode == cool_PayloadMode_Mode::VECTORPAYLOAD )
  {
    // vector payload mode
    tmp.extend( RelationalObjectTable::columnNames::payloadSetId(),
                RelationalObjectTable::columnTypeIds::payloadSetId );
    tmp.extend( RelationalObjectTable::columnNames::payloadSize(),
                RelationalObjectTable::columnTypeIds::payloadSize );
  }


  coral::AttributeList al = Record( tmp ).attributeList();
  if ( pMode == cool_PayloadMode_Mode::INLINEPAYLOAD )
    // payload in ObjectTable
  {
    // User-defined payload columns
    for ( coral::AttributeList::const_iterator
            i = payload.begin(); i != payload.end(); ++i ) {
      al.extend( i->specification().name(), i->specification().typeName() );
    }
  }

  return al;
}

//-----------------------------------------------------------------------------

const RelationalObjectTableRow
RelationalObjectTable::fetchRowForId( unsigned int objectId,
                                      bool fetchPayload ) const
{
  log() << "Fetch object row from table " << objectTableName()
        << " for object_id=" << objectId << coral::MessageStream::endmsg;

  // Define the WHERE clause for the selection using bind variables
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "objectId",
                        RelationalObjectTable::columnTypeIds::objectId );
  Record whereData( whereDataSpec );
  whereData["objectId"].setValue( objectId );
  std::string whereClause = RelationalObjectTable::columnNames::objectId();
  whereClause += "= :objectId";

  // Delegate the query to the RelationalQueryMgr
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( objectTableName() );
  if ( fetchPayload ) // fetch both the IOV metadata and the payload
    queryDef.addSelectItems( tableSpecification() );
  else // fetch only the IOV metadata, not the payload
    queryDef.addSelectItems( defaultSpecification() );
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );
  try
  {
    return RelationalObjectTableRow
      ( queryMgr().fetchOrderedRows( queryDef, "", 1 )[0] ); // expect 1 row
  }
  catch( NoRowsFound& )
  {
    std::stringstream s;
    s << "object_id: " << objectId;
    throw ObjectNotFound
      ( s.str(), objectTableName(), "RelationalObjectTable" );
  }
}

//---------------------------------------------------------------------------

const std::vector<std::string>
RelationalObjectTable::orderByClause( const ChannelSelection& channels,
                                      const std::string& objectTableName )
{
  // Create a prefix if an objectTableName was specified
  std::string prefix = "";
  if ( objectTableName != "" ) prefix = objectTableName + ".";

  // Define the ORDER BY clause for the selection
  //
  // sas 2005-08-09: I'm not sure if we even have to make the following
  // distinction of single/multi channel selection or should just
  // generally have "channelId, iovSince" or vice versa ordering. The fact
  // that we have a 3D index might make this superfluous.
  std::vector<std::string> orderBy;
  if ( ! channels.isNumeric()
       || ( channels.isNumeric() &&
            ( channels.firstChannel() == channels.lastChannel() ) )
       ) {
    // Only one channel, skip 'channelId' in order clause
    if ( channels.order() == cool_ChannelSelection_Order::channelBeforeSince ||
         channels.order() == cool_ChannelSelection_Order::sinceBeforeChannel ) {
      orderBy.push_back
        ( prefix + RelationalObjectTable::columnNames::iovSince() + " ASC" );
    }
    else {
      orderBy.push_back
        ( prefix + RelationalObjectTable::columnNames::iovSince() + " DESC" );
    }
  } else {
    if ( channels.order() == cool_ChannelSelection_Order::channelBeforeSince ) {
      orderBy.push_back
        ( prefix + RelationalObjectTable::columnNames::channelId() + " ASC" );
      orderBy.push_back
        ( prefix + RelationalObjectTable::columnNames::iovSince() + " ASC" );
    }
    else if ( channels.order() == cool_ChannelSelection_Order::sinceBeforeChannel ) {
      orderBy.push_back
        ( prefix + RelationalObjectTable::columnNames::iovSince() + " ASC" );
      orderBy.push_back
        ( prefix + RelationalObjectTable::columnNames::channelId() + " ASC" );
    }
    else if ( channels.order() == cool_ChannelSelection_Order::channelBeforeSinceDesc ) {
      orderBy.push_back
        ( prefix + RelationalObjectTable::columnNames::channelId() + " ASC" );
      orderBy.push_back
        ( prefix + RelationalObjectTable::columnNames::iovSince() + " DESC" );
    }
    else if ( channels.order() == cool_ChannelSelection_Order::sinceDescBeforeChannel ) {
      orderBy.push_back
        ( prefix + RelationalObjectTable::columnNames::iovSince() + " DESC" );
      orderBy.push_back
        ( prefix + RelationalObjectTable::columnNames::channelId() + " ASC" );
    }
  }
  return orderBy;
}

//---------------------------------------------------------------------------

/*
/// TEMPORARY! This is ONLY needed by David's VerificationClient
RelationalObjectTableRow
RelationalObjectTable::fetchLastRowSV( const ChannelId& channelId,
                                       bool fetchPayload )
{
  log() << "Fetch last object row from table " << objectTableName()
        << coral::MessageStream::endmsg;

  // The "last object" inserted in each channel of a SV folder is retrieved
  // as the object with the highest objectId in that channel (two possible
  // alternatives could be to use the highest iovSince or iovUntil).
  // The present algorithm uses two queries:
  // 1. First, select MAX(objectId) in the given channel
  // 2. Then, retrieve the full row for the object wih id=maxId

  // QUERY 1: select MAX(objectId) for the given channel
  std::string maxObjectIdName =
    std::string("MAX(") + RelationalObjectTable::columnNames::objectId() + ")";

  // Define the WHERE clause for the selection using bind variables
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "channel",
                        RelationalObjectTable::columnTypeIds::channelId );
  Record whereData( whereDataSpec );
  whereData["channel"].setValue( channelId );
  std::string whereClause = RelationalObjectTable::columnNames::channelId();
  whereClause += "= :channel";

  // Delegate the query to the RalQueryMgr
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( objectTableName() );
  queryDef.addSelectItem( maxObjectIdName,
                          RelationalObjectTable::columnTypeIds::objectId );
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );
  ObjectId maxObjectId;
  try
  {
    RelationalTableRow maxObjectIdRow =
      queryMgr().fetchOrderedRows( queryDef, "", 1 )[0]; // expect 1 row
    maxObjectId = maxObjectIdRow[ maxObjectIdName ].data<ObjectId>();
  }
  catch( NoRowsFound& )
  {
    throw ObjectNotFound
      ( "MAX(objectId)", objectTableName(), "RelationalObjectTable" );
  }

  // QUERY 2: select * for objectId = MAX(objectId)
  return
    fetchRowForId( maxObjectId, fetchPayload );

}
*///

//---------------------------------------------------------------------------

const RelationalObjectTableRow
RelationalObjectTable::fetchLastRowForTagId( unsigned int tagId,
                                             bool fetchPayload ) const
{
  log() << "Fetch last object row from table " << objectTableName()
        << " for tagId " << tagId << coral::MessageStream::endmsg;
  ObjectId maxObjectId=0;
  bool isUserTag=true;

  // QUERY 1: select MAX(objectId) for the given tag
  std::string maxObjectIdName =
    std::string("MAX(") + RelationalObjectTable::columnNames::objectId() + ")";

  // First guess: it is a user tag
  try
  {
    std::string whereClause =
      RelationalObjectTable::columnNames::userTagId();
    whereClause += "=:userTagId";
    RecordSpecification whereDataSpec;
    whereDataSpec.extend( "userTagId",
                          RelationalObjectTable::columnTypeIds::userTagId );
    Record whereData( whereDataSpec );
    whereData["userTagId"].setValue( tagId );
    RelationalQueryDefinition queryDef;
    queryDef.addFromItem( objectTableName() );
    queryDef.addSelectItem( maxObjectIdName,
                            RelationalObjectTable::columnTypeIds::objectId );
    queryDef.setWhereClause( whereClause );
    queryDef.setBindVariables( whereData );
    RelationalTableRow maxObjectIdRow =
      queryMgr().fetchOrderedRows( queryDef, "", 1 )[0]; // expect 1 row
    if (maxObjectIdRow[ maxObjectIdName ].isNull()) isUserTag=false;
    else maxObjectId = maxObjectIdRow[ maxObjectIdName ].data<ObjectId>();
  }
  catch ( NoRowsFound& )
  {
    isUserTag=false;
  }

  // No user tag
  if ( !isUserTag )
  {
    RecordSpecification whereDataSpec;
    whereDataSpec.extend( "tagId",
                          RelationalObject2TagTable::columnTypeIds::tagId );
    Record whereData( whereDataSpec );
    whereData["tagId"].setValue( tagId );
    std::string whereClause = RelationalObject2TagTable::columnNames::tagId;
    whereClause += "= :tagId";
    try
    {
      RelationalQueryDefinition queryDef;
      queryDef.addFromItem( object2TagTableName() );
      queryDef.addSelectItem( maxObjectIdName,
                              RelationalObjectTable::columnTypeIds::objectId );
      queryDef.setWhereClause( whereClause );
      queryDef.setBindVariables( whereData );
      RelationalTableRow maxObjectIdRow =
        queryMgr().fetchOrderedRows( queryDef, "", 1 )[0]; // expect 1 row
      maxObjectId = maxObjectIdRow[ maxObjectIdName ].data<ObjectId>();
    }
    catch( NoRowsFound& )
    {
      throw ObjectNotFound
        ( "MAX(objectId)", object2TagTableName(), "RelationalObjectTable" );
    }
  }

  // QUERY 2: select * for objectId = MAX(objectId)
  return
    fetchRowForId( maxObjectId, fetchPayload );

}

//---------------------------------------------------------------------------

const RelationalObjectTableRow RelationalObjectTable::fetchRowAtTimeInHead
( const ValidityKey& pointInTime,
  const ChannelId& channelId,
  unsigned int userTagId )
{
  log() << "Fetch object row HEAD from table " << objectTableName()
        << " for channel=" << channelId
        << " at time=" << pointInTime
        << " (with user tag=" << userTagId << ")"
        << coral::MessageStream::endmsg;

  const std::auto_ptr<IRelationalQueryDefinition>
    def( queryDefinitionGeneric
         ( pointInTime, pointInTime, channelId, &userTagId,
           true, 0, false, false ) ); // don't fetch payload

  // Delegate the query to the RalQueryMgr
  try
  {
    return RelationalObjectTableRow
      ( queryMgr().fetchOrderedRows( *def, "", 1 )[0] ); // expect 1 row
  }
  catch( NoRowsFound& )
  {
    std::stringstream s;
    s << pointInTime;
    throw ObjectNotFound
      ( s.str(), objectTableName(), "RelationalObjectTable" );
  }
}
//---------------------------------------------------------------------------

std::auto_ptr< std::vector<RelationalObjectTableRow> >
RelationalObjectTable::fetchRowsBtTimesInHead
( const ValidityKey& since,
  const ValidityKey& until,
  const ChannelId& channelId,
  unsigned int userTagId,
  unsigned int maxRows )
{
  log() << "Fetch object row HEAD from table " << objectTableName()
        << " for channel=" << channelId
        << " bt times=" << since
        << ", " << until
        << " (with user tag=" << userTagId << ")"
        << coral::MessageStream::endmsg;

  const std::auto_ptr<IRelationalQueryDefinition>
    def( queryDefinitionGeneric
         ( since, until, channelId, &userTagId,
           true, 0, false, false ) ); // don't fetch payload

  // Delegate the query to the RalQueryMgr
  try
  {
    std::string desc = "";

    // return a auto_ptr to 0 if maxRow count is exceeded
    unsigned int count=queryMgr().countRows( *def, desc );
    if ( count  > maxRows )
      return std::auto_ptr< std::vector< RelationalObjectTableRow > >( 0 );

    const std::vector<RelationalTableRow> rows
      ( queryMgr().fetchOrderedRows( *def, desc ) );

    std::auto_ptr< std::vector<RelationalObjectTableRow> >
      objectRows( new std::vector<RelationalObjectTableRow>( ) );
    objectRows->reserve( count );

    for ( std::vector<RelationalTableRow>::const_iterator
            row = rows.begin(); row != rows.end(); ++row ) {
      objectRows->push_back( RelationalObjectTableRow( *row ) );
    }

    return objectRows;
  }
  catch( NoRowsFound& )
  {
    std::stringstream s;
    s << since << ", " << until;
    throw ObjectNotFound
      ( s.str(), objectTableName(), "RelationalObjectTable" );
  }
}

//---------------------------------------------------------------------------

/*
RelationalObjectTableRow RelationalObjectTable::fetchRowAtTimeInTag
( const ValidityKey& pointInTime,
  const ChannelId& channelId,
  const std::string& tagName )
{
  log() << "Fetch object row in tag from table " << objectTableName()
        << " for channel=" << channelId
        << " at time=" << pointInTime
        << " with tag=" << tagName
        << coral::MessageStream::endmsg;

  const std::auto_ptr<IRelationalQueryDefinition>
    def( queryDefinitionTag
         ( pointInTime, pointInTime, channelId, tagName ) );

  // Delegate the query to the RalQueryMgr
  try
  {
    std::string desc = "";
    const std::vector<RelationalTableRow> rows
      ( queryMgr().fetchOrderedRows( *def, desc, 1 ) );
    return RelationalObjectTableRow( rows[0] );
  }
  catch( NoRowsFound& )
  {
    std::stringstream s;
    s << pointInTime;
    throw ObjectNotFound
      ( s.str(), objectTableName(), "RelationalObjectTable" );
  }
}
*///

//---------------------------------------------------------------------------

std::vector<RelationalObjectTableRow>
RelationalObjectTable::fetchRowsForTaggingCurrentHead
( PayloadMode::Mode pMode )
{

  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( objectTableName() );

  // Add 'meta data' columns to the output list and define the output format
  queryDef.addSelectItem( RelationalObjectTable::columnNames::objectId(),
                          RelationalObjectTable::columnTypeIds::objectId );
  queryDef.addSelectItem( RelationalObjectTable::columnNames::channelId(),
                          RelationalObjectTable::columnTypeIds::channelId );
  queryDef.addSelectItem( RelationalObjectTable::columnNames::iovSince(),
                          RelationalObjectTable::columnTypeIds::iovSince );
  queryDef.addSelectItem( RelationalObjectTable::columnNames::iovUntil(),
                          RelationalObjectTable::columnTypeIds::iovUntil );
  queryDef.addSelectItem( RelationalObjectTable::columnNames::userTagId(),
                          RelationalObjectTable::columnTypeIds::userTagId );
  if ( pMode == cool_PayloadMode_Mode::SEPARATEPAYLOAD )
    queryDef.addSelectItem( RelationalObjectTable::columnNames::payloadId(),
                            RelationalObjectTable::columnTypeIds::payloadId );
  else if ( pMode == cool_PayloadMode_Mode::VECTORPAYLOAD )
    queryDef.addSelectItem( RelationalObjectTable::columnNames::payloadSetId(),
                            RelationalObjectTable::columnTypeIds::payloadSetId );

  queryDef.addSelectItem( RelationalObjectTable::columnNames::sysInsTime(),
                          RelationalObjectTable::columnTypeIds::sysInsTime );

  // Define the WHERE clause for the selection using bind variables
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "newHeadId",
                        RelationalObjectTable::columnTypeIds::newHeadId );
  whereDataSpec.extend( "userTagId",
                        RelationalObjectTable::columnTypeIds::userTagId );
  Record whereData( whereDataSpec );
  whereData["newHeadId"].setValue( 0u );
  whereData["userTagId"].setValue( 0u );
  std::string whereClause = RelationalObjectTable::columnNames::newHeadId();
  whereClause += "= :newHeadId";
  whereClause += " AND ";
  whereClause += RelationalObjectTable::columnNames::userTagId();
  whereClause += "= :userTagId";
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );

  /// Results are ordered by ascending values of the "since" start of IOV
  queryDef.addOrderItem
    ( RelationalObjectTable::columnNames::objectId() + " ASC" );

  // Delegate the query to the RalQueryMgr
  std::vector<RelationalTableRow> rows =
    queryMgr().fetchOrderedRows( queryDef );

  // TEMPORARY? Conversion to RelationalObjectTableRow
  std::vector<RelationalObjectTableRow> objectRows;
  for ( std::vector<RelationalTableRow>::const_iterator
          row = rows.begin(); row != rows.end(); ++row )
  {
    RelationalObjectTableRow objectRow( *row );
    objectRows.push_back( objectRow );
  }

  // Return the results
  return objectRows;

}

//---------------------------------------------------------------------------

std::vector<RelationalObjectTableRow>
RelationalObjectTable::fetchRowsForTaggingHeadAsOfDate
( const ITime& asOfDate, PayloadMode::Mode pMode )
{
  log() << "Fetch IOV rows from table '" << objectTableName()
        << "' for tagging as of date '" << timeToString(asOfDate)
        << "'" << coral::MessageStream::endmsg;

  // Ideally, this methods query should be merged with fetchObjectTableRows,
  // but it is not so easy due the output column specifications

  // Define the list of tables to query
  // NB Use UPPERCASE table aliases for Frontier (see task #3536)
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( objectTableName(), "I" );
  queryDef.addFromItem( objectTableName(), "O" );

  // Add 'meta data' columns to the output list and define the output format
  RecordSpecification spec;
  spec.extend( RelationalObjectTable::columnNames::objectId(),
               RelationalObjectTable::columnTypeIds::objectId );
  spec.extend( RelationalObjectTable::columnNames::channelId(),
               RelationalObjectTable::columnTypeIds::channelId );
  spec.extend( RelationalObjectTable::columnNames::iovSince(),
               RelationalObjectTable::columnTypeIds::iovSince );
  spec.extend( RelationalObjectTable::columnNames::iovUntil(),
               RelationalObjectTable::columnTypeIds::iovUntil );
  spec.extend( RelationalObjectTable::columnNames::userTagId(),
               RelationalObjectTable::columnTypeIds::userTagId );
  if ( pMode == cool_PayloadMode_Mode::SEPARATEPAYLOAD )
    spec.extend( RelationalObjectTable::columnNames::payloadId(),
                 RelationalObjectTable::columnTypeIds::payloadId );
  else if ( pMode == cool_PayloadMode_Mode::VECTORPAYLOAD )
    spec.extend( RelationalObjectTable::columnNames::payloadSetId(),
                 RelationalObjectTable::columnTypeIds::payloadSetId );

  spec.extend( RelationalObjectTable::columnNames::sysInsTime(),
               RelationalObjectTable::columnTypeIds::sysInsTime );
  queryDef.addSelectItems( spec, "I." );

  // Define the WHERE clause for the selection using bind variables
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "asOfDate1",
                        RelationalObjectTable::columnTypeIds::sysInsTime );
  whereDataSpec.extend( "userTagId",
                        RelationalObjectTable::columnTypeIds::userTagId );
  whereDataSpec.extend( "newHeadId",
                        RelationalObjectTable::columnTypeIds::newHeadId );
  whereDataSpec.extend( "asOfDate2",
                        RelationalObjectTable::columnTypeIds::sysInsTime );
  Record whereData( whereDataSpec );
  whereData["asOfDate1"].setValue( timeToString( asOfDate ) );
  whereData["userTagId"].setValue( 0u );
  whereData["newHeadId"].setValue( 0u );
  whereData["asOfDate2"].setValue( timeToString( asOfDate ) );
  std::string ins = RelationalObjectTable::columnNames::sysInsTime();
  std::string oid = RelationalObjectTable::columnNames::objectId();
  std::string nhid = RelationalObjectTable::columnNames::newHeadId();
  std::string whereClause = "I." + ins + " <= :asOfDate1";
  whereClause += " AND ";
  whereClause += "I." + RelationalObjectTable::columnNames::userTagId();
  whereClause += "= :userTagId";
  whereClause += " AND ( ";
  whereClause += "( I." + nhid + " = :newHeadId";
  whereClause += " AND I." + oid + " = O." + oid; // constrains self join
  whereClause += " ) ";
  whereClause += " OR ";
  whereClause += "( I." + nhid + " = O." + oid;
  whereClause += " AND O." + ins + " > :asOfDate2";
  whereClause += " ) ";
  whereClause += ")";
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );

  /// Results are ordered by ascending values of the "since" start of IOV
  queryDef.addOrderItem( std::string( "I." ) + RelationalObjectTable::columnNames::objectId() + " ASC" );

  // Delegate the query to the RalQueryMgr
  std::vector<RelationalTableRow> rows =
    queryMgr().fetchOrderedRows( queryDef );

  // TEMPORARY? Conversion to RelationalObjectTableRow
  std::vector<RelationalObjectTableRow> objectRows;
  for ( std::vector<RelationalTableRow>::const_iterator
          row = rows.begin(); row != rows.end(); ++row )
  {
    RelationalObjectTableRow objectRow( *row );
    objectRows.push_back( objectRow );
  }

  // Return the results
  return objectRows;

}

//---------------------------------------------------------------------------

std::vector<RelationalObjectTableRow>
RelationalObjectTable::fetchRowsForTaggingHeadAsOfObjectId
( unsigned int asOfObjectId, PayloadMode::Mode pMode )
{

  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( objectTableName() );

  // Add 'meta data' columns to the output list and define the output format
  queryDef.addSelectItem( RelationalObjectTable::columnNames::objectId(),
                          RelationalObjectTable::columnTypeIds::objectId );
  queryDef.addSelectItem( RelationalObjectTable::columnNames::channelId(),
                          RelationalObjectTable::columnTypeIds::channelId );
  queryDef.addSelectItem( RelationalObjectTable::columnNames::iovSince(),
                          RelationalObjectTable::columnTypeIds::iovSince );
  queryDef.addSelectItem( RelationalObjectTable::columnNames::iovUntil(),
                          RelationalObjectTable::columnTypeIds::iovUntil );
  queryDef.addSelectItem( RelationalObjectTable::columnNames::userTagId(),
                          RelationalObjectTable::columnTypeIds::userTagId );
  if ( pMode == cool_PayloadMode_Mode::SEPARATEPAYLOAD )
    queryDef.addSelectItem( RelationalObjectTable::columnNames::payloadId(),
                            RelationalObjectTable::columnTypeIds::payloadId );
  else if ( pMode == cool_PayloadMode_Mode::VECTORPAYLOAD )
    queryDef.addSelectItem( RelationalObjectTable::columnNames::payloadSetId(),
                            RelationalObjectTable::columnTypeIds::payloadSetId );
  queryDef.addSelectItem( RelationalObjectTable::columnNames::sysInsTime(),
                          RelationalObjectTable::columnTypeIds::sysInsTime );

  // AV 05.04.2005 Bug fix
  // The asOfObjectId argument must first be mapped into current user object
  // Also change algorithm so that next (rather than current) user obj is used
  ObjectId nextUserObjectId = ObjectIdHandler::nextUserObject( asOfObjectId );

  // Define the WHERE clause for the selection using bind variables
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "userTagId",
                        RelationalObjectTable::columnTypeIds::userTagId );
  whereDataSpec.extend( "oid1",
                        RelationalObjectTable::columnTypeIds::objectId );
  whereDataSpec.extend( "oid2",
                        RelationalObjectTable::columnTypeIds::objectId );
  Record whereData( whereDataSpec );
  whereData["userTagId"].setValue( 0u );
  whereData["oid1"].setValue( nextUserObjectId );
  whereData["oid2"].setValue( nextUserObjectId );
  std::string oid = RelationalObjectTable::columnNames::objectId();
  std::string nhid = RelationalObjectTable::columnNames::newHeadId();
  std::string whereClause = RelationalObjectTable::columnNames::userTagId();
  whereClause += "= :userTagId";
  whereClause += " AND ";
  whereClause += oid + " < :oid1";
  whereClause += " AND ( ";
  whereClause +=
    "   " + nhid + " = 0 or"; // AV 05.04.2005 No need to bind 0 (constant)
  whereClause += "   " + nhid + " >= :oid2";
  whereClause += " )";
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );

  /// Results are ordered by ascending values of the "since" start of IOV
  queryDef.addOrderItem
    ( RelationalObjectTable::columnNames::objectId() + " ASC" );

  // Delegate the query to the RalQueryMgr
  std::vector<RelationalTableRow> rows =
    queryMgr().fetchOrderedRows( queryDef );

  // TEMPORARY? Conversion to RelationalObjectTableRow
  std::vector<RelationalObjectTableRow> objectRows;
  for ( std::vector<RelationalTableRow>::const_iterator
          row = rows.begin(); row != rows.end(); ++row )
  {
    RelationalObjectTableRow objectRow( *row );
    objectRows.push_back( objectRow );
  }

  // Return the results
  return objectRows;

}

//---------------------------------------------------------------------------

bool
RelationalObjectTable::existsChannel( const ChannelId& channelId ) const
{
  std::string whereClause = RelationalObjectTable::columnNames::channelId();
  whereClause += "= :channelId";
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "channelId",
                        RelationalChannelTable::columnTypeIds::channelId );
  Record whereData( whereDataSpec );
  whereData["channelId"].setValue( channelId );
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( objectTableName() );
  UInt32 nRows = queryMgr().countRows( queryDef );
  return ( nRows > 0 );
}

//---------------------------------------------------------------------------

std::auto_ptr<IRelationalQueryDefinition>
RelationalObjectTable::queryDefinitionSV
( const ValidityKey& since,
  const ValidityKey& until,
  const ChannelSelection& channels,
  const IRecordSelection* payloadQuery,
  bool optimizeClobs,
  bool fetchPayload )
{
  // Delegate to queryDefinitionGeneric
  const unsigned int* pTagId = 0;
  bool isUserTag = true;
  return queryDefinitionGeneric( since, until, channels, pTagId, isUserTag,
                                 payloadQuery, optimizeClobs, fetchPayload );
}

//---------------------------------------------------------------------------

std::auto_ptr<IRelationalQueryDefinition>
RelationalObjectTable::queryDefinitionHeadAndUserTag
( const ValidityKey& since,
  const ValidityKey& until,
  const ChannelSelection& channels,
  const std::string& userTagName,
  const IRecordSelection* payloadQuery,
  bool optimizeClobs,
  bool fetchPayload )
{
  // TEMPORARY? Could provide tagName and do the tagName->tagId
  // mapping in the same join: here I assume we retrieve it before
  unsigned int tagId = 0;
  if (!IHvsNode::isHeadTag( userTagName ))
    try
    {
      tagId = m_tagMgr.findTagRecord( m_nodeId, userTagName ).id();
      //std::cout << "Tag '" << tagName << "' has tagId=" << tagId << std::endl;
    }
    catch(...)
    {
      //std::cout << "Tag '" << tagName
      //          << "' does not exist - use a dummy value tagId=0" << std::endl;
    }

  // Delegate to queryDefinitionGeneric
  bool isUserTag = true;
  return queryDefinitionGeneric( since, until, channels, &tagId, isUserTag,
                                 payloadQuery, optimizeClobs, fetchPayload );
}

//---------------------------------------------------------------------------

std::auto_ptr<IRelationalQueryDefinition>
RelationalObjectTable::queryDefinitionTag
( //const std::string& objectTableName,
 const ValidityKey& since,
 const ValidityKey& until,
 const ChannelSelection& channels,
 const std::string& tagName,
 const IRecordSelection* payloadQuery,
 bool optimizeClobs,
 bool fetchPayload )
{
  // TEMPORARY? Could provide tagName and do the tagName->tagId
  // mapping in the same join: here I assume we retrieve it before
  unsigned int tagId = 0;
  try
  {
    tagId = m_tagMgr.findTagRecord( m_nodeId, tagName ).id();
    //std::cout << "Tag '" << tagName << "' has tagId=" << tagId << std::endl;
  }
  catch(...)
  {
    //std::cout << "Tag '" << tagName
    //          << "' does not exist - use a dummy value tagId=0" << std::endl;
  }

  // Delegate to queryDefinitionGeneric
  bool isUserTag = false;
  return queryDefinitionGeneric( since, until, channels, &tagId, isUserTag,
                                 payloadQuery, optimizeClobs, fetchPayload );
}
//---------------------------------------------------------------------------

// NEW IMPLEMENTATION - IMPLEMENT TWO VIEW MERGES DIRECTLY!
std::auto_ptr<IRelationalQueryDefinition>
RelationalObjectTable::queryDefinitionGeneric
( //const std::string& objectTableName,
 const ValidityKey& since,
 const ValidityKey& until,
 const ChannelSelection& channels,
 const unsigned int* pTagId, // pTagId=0 means SV, (*pTagId)==0 means HEAD
 bool isUserTag, // ignored for SV and HEAD, used only for (*pTagId)!=0
 const IRecordSelection* payloadQuery,
 bool optimizeClobs,
 bool fetchPayload )
{
  // TEMPORARY? This method could accept a tag name as an argument instead
  // of a pointer to a tagID (in which case we would need to retrieve the
  // tagID inside this method, for instance using a join with the tag table -
  // which we may already have in some cases). The present implementation
  // assumes instead that we retrieve it before (or that we do not need it,
  // for instance for insertion...).

  // TEMPORARY - this method should be moved elsewhere
  // and table names should be provided as arguments...
  const std::string& objectTableName = m_objectTableName;
  const std::string& object2TagTableName = m_object2TagTableName;

  // Add double quotes for all techologies except SQLite
  std::string quotes = "";
  if ( queryMgr().databaseTechnology() == "Oracle" ||
       queryMgr().databaseTechnology() == "MySQL" ||
       queryMgr().databaseTechnology() == "frontier" ) quotes = "\"";

  // Create the hint prefix and suffix without interefering with C++ comments
  std::string hintPrefix = std::string("/") + std::string("*");
  std::string hintSuffix = std::string("*") + std::string("/");

  // --- SQL QUERY STRATEGY: 'external OR' vs. 'coalesce'/'internal OR' ---

  // Choose the SQL query strategy (externalOR vs. internalOR/coalesce)
  // DEFAULT: internalOR (userTagMV)/coalesce(SV/tagMV)
  bool useExternalOr = false;
  // Override the SQL strategy using environment variables
  if ( getenv( "COOL_QUERYDEFGEN_EXTERNALOR" ) )
  {
    std::cout << "__COOL alternative SQL strategy EXTERNALOR" << std::endl;
    useExternalOr = true;
  }

  // --- SQL QUERY STRATEGY: 'coalesce' vs. 'internal OR' ---

  // Choose the SQL query strategy (internalOR vs. coalesce)
  // DEFAULT: coalesce for all (SV/tagMV/userTagMV)
  bool useCoalesce = true;
  /*
  if ( pTagId == 0 )
  {
    // Default for SV: use coalesce
    useCoalesce = true;
  }
  else
  {
    if ( isUserTag )
    {
      // Default for MV user tags: use coalesce
      useCoalesce = true;
    }
    else
    {
      // Default for MV tags: do not use coalesce
      useCoalesce = true;
    }
  }
  *///
  // Override the SQL strategy using environment variables
  if ( getenv( "COOL_QUERYDEFGEN_COALESCE" ) )
  {
    useCoalesce = true;
    std::cout << "__COOL alternative SQL strategy COALESCE" << std::endl;
  }
  else if ( getenv( "COOL_QUERYDEFGEN_NOCOALESCE" ) )
  {
    useCoalesce = false;
    std::cout << "__COOL alternative SQL strategy NOCOALESCE" << std::endl;
  }

  // --- MV WHERE CLAUSES ---

  // If pTagId == 0, this is SV: no additional tagWhereClause.
  // If pTagId != 0, this is MV: prepare the additional tagWhereClause.
  std::string whereClauseTag1;
  Record whereDataTag1;
  std::string whereClauseTag3;
  Record whereDataTag3;
  std::string whereClauseTag3b;
  Record whereDataTag3b;
  //std::cout << "pTagId=" << pTagId << std::endl;
  //std::cout << "isUserTag=" << ( isUserTag?"T":"F") << std::endl;
  if ( pTagId != 0 )
  {
    unsigned int tagId = *pTagId;
    if ( isUserTag )
    {
      const std::string iovUtagIdName =
        RelationalObjectTable::columnNames::userTagId();
      const std::string iovNewHIdName =
        RelationalObjectTable::columnNames::newHeadId();
      const StorageType::TypeId iovUtagIdTyId =
        RelationalObjectTable::columnTypeIds::userTagId;
      // Use the 5D indx on userTagId, newHeadId, channelId, iovSince, iovUntil
      // that was originally introduced for findObject(userTag) in task #4381
      // Clause and data for subquery1 (max)
      {
        whereClauseTag1 += "COOL_I1." + iovUtagIdName;
        whereClauseTag1 += "=:" + quotes+"utagid1"+quotes;
        whereClauseTag1 += " AND ";
        whereClauseTag1 += "COOL_I1." + iovNewHIdName + "=0";
        whereClauseTag1 += " AND ";
        RecordSpecification spec;
        spec.extend( "utagid1", iovUtagIdTyId );
        Record rec( spec );
        rec["utagid1"].setValue( tagId );
        whereDataTag1.extend( rec );
      }
      // Clause and data for subquery3 (browse)
      {
        whereClauseTag3 += "COOL_I3." + iovUtagIdName;
        whereClauseTag3 += "=:" + quotes+"utagid3"+quotes;
        whereClauseTag3 += " AND ";
        whereClauseTag3 += "COOL_I3." + iovNewHIdName + "=0";
        whereClauseTag3 += " AND ";
        RecordSpecification spec;
        spec.extend( "utagid3", iovUtagIdTyId );
        Record rec( spec );
        rec["utagid3"].setValue( tagId );
        whereDataTag3.extend( rec );
      }
      // Clause and data for subquery3b (browse) - ONLY FOR EXTERNAL OR
      {
        whereClauseTag3b += "COOL_I3." + iovUtagIdName;
        whereClauseTag3b += "=:" + quotes+"utagid3b"+quotes;
        whereClauseTag3b += " AND ";
        whereClauseTag3b += "COOL_I3." + iovNewHIdName + "=0";
        whereClauseTag3b += " AND ";
        RecordSpecification spec;
        spec.extend( "utagid3b", iovUtagIdTyId );
        Record rec( spec );
        rec["utagid3b"].setValue( tagId );
        whereDataTag3b.extend( rec );
      }
    }
    else
    {
      const std::string i2tTagName =
        RelationalObject2TagTable::columnNames::tagId;
      const StorageType::TypeId i2tTagTyId =
        RelationalObject2TagTable::columnTypeIds::tagId;
      // Use the 4D index on tagId, channelId, iovSince, iovUntil
      // Clause and data for subquery1 (max)
      {
        whereClauseTag1 += "COOL_I1." + i2tTagName;
        whereClauseTag1 += "=:" + quotes+"tagid1"+quotes;
        whereClauseTag1 += " AND ";
        RecordSpecification spec;
        spec.extend( "tagid1", i2tTagTyId );
        Record rec( spec );
        rec["tagid1"].setValue( tagId );
        whereDataTag1.extend( rec );
      }
      // Clause and data for subquery3 (browse)
      {
        whereClauseTag3 += "COOL_I3." + i2tTagName;
        whereClauseTag3 += "=:" + quotes+"tagid3"+quotes;
        whereClauseTag3 += " AND ";
        RecordSpecification spec;
        spec.extend( "tagid3", i2tTagTyId );
        Record rec( spec );
        rec["tagid3"].setValue( tagId );
        whereDataTag3.extend( rec );
      }
      // Clause and data for subquery3b (browse) - ONLY FOR EXTERNAL OR
      {
        whereClauseTag3b += "COOL_I3." + i2tTagName;
        whereClauseTag3b += "=:" + quotes+"tagid3b"+quotes;
        whereClauseTag3b += " AND ";
        RecordSpecification spec;
        spec.extend( "tagid3b", i2tTagTyId );
        Record rec( spec );
        rec["tagid3b"].setValue( tagId );
        whereDataTag3b.extend( rec );
      }
    }
  }

  // --- SCHEMA ELEMENTS FOR SUBQUERY 1/2 (max) and SUBQUERY 3 (browse) ---

  std::string iovTable13;
  std::string iovSince13Name;
  std::string iovUntil13Name;
  std::string iovObjId13Name;
  std::string iovChnId13Name;
  StorageType::TypeId iovSince13TyId;
  StorageType::TypeId iovUntil13TyId;
  if ( pTagId == 0 || isUserTag )
  {
    iovTable13 = objectTableName;
    iovSince13Name = RelationalObjectTable::columnNames::iovSince();
    iovUntil13Name = RelationalObjectTable::columnNames::iovUntil();
    iovObjId13Name = RelationalObjectTable::columnNames::objectId();
    iovChnId13Name = RelationalObjectTable::columnNames::channelId();
    iovSince13TyId = RelationalObjectTable::columnTypeIds::iovSince;
    iovUntil13TyId = RelationalObjectTable::columnTypeIds::iovUntil;
  }
  else
  {
    iovTable13 = object2TagTableName;
    iovSince13Name = RelationalObject2TagTable::columnNames::iovSince;
    iovUntil13Name = RelationalObject2TagTable::columnNames::iovUntil;
    iovObjId13Name = RelationalObject2TagTable::columnNames::objectId;
    iovChnId13Name = RelationalObject2TagTable::columnNames::channelId;
    iovSince13TyId = RelationalObject2TagTable::columnTypeIds::iovSince;
    iovUntil13TyId = RelationalObject2TagTable::columnTypeIds::iovUntil;
  }
  std::string chnChnId13Name;
  std::string chnChnNm13Name;
  StorageType::TypeId chnChnId13TyId;
  StorageType::TypeId chnChnNm13TyId;
  chnChnId13Name = RelationalChannelTable::columnNames::channelId();
  chnChnNm13Name = RelationalChannelTable::columnNames::channelName();
  chnChnId13TyId = RelationalChannelTable::columnTypeIds::channelId;
  chnChnNm13TyId = RelationalChannelTable::columnTypeIds::channelName;

  // --- SUBQUERY 1 (max1: max for one channel) ---

  std::string subQuery1;
  Record whereDataSQ1;
  {
    std::string schemaPrefix;
    if ( queryMgr().schemaName() != "" )
      schemaPrefix = queryMgr().schemaName() + ".";
    // Hint for subquery1
    std::string hint = hintPrefix + "+ QB_NAME(MAX1) ";
    if ( getenv( "COOL_QUERYDEFGEN_HINTMAX1" ) )
    {
      std::string userHint( getenv( "COOL_QUERYDEFGEN_HINTMAX1" ) );
      boost::trim( userHint );
      if ( userHint != "" ) hint += userHint + " ";
    }
    hint = hint + hintSuffix;
    // Clause for subquery1
    subQuery1 += "( SELECT "+hint+" ";
    subQuery1 += "MAX(COOL_I1." + iovSince13Name + ")";
    subQuery1 += " FROM " + schemaPrefix + iovTable13 + " COOL_I1";
    subQuery1 += " WHERE ";
    subQuery1 += whereClauseTag1;
    subQuery1 += "COOL_I1."+iovChnId13Name + "=COOL_C2." + chnChnId13Name;
    subQuery1 += " AND ";
    subQuery1 += "COOL_I1."+iovSince13Name + "<=:" + quotes+"since1"+quotes;
    subQuery1 += " )";
    // Data for subquery1
    {
      whereDataSQ1.extend( whereDataTag1 );
      RecordSpecification spec;
      spec.extend( "since1", iovSince13TyId );
      Record rec( spec );
      rec["since1"].setValue( since );
      whereDataSQ1.extend( rec );
    }
  }

  // --- MAIN QUERY ---

  std::auto_ptr<RelationalQueryDefinition> pMainQuery
    ( new RelationalQueryDefinition( optimizeClobs ) ); // use CLOB optimization
  RelationalQueryDefinition& mainQuery = *pMainQuery;
  Record whereDataMQ;
  std::string whereClauseMQ;

  // --- Formerly SUBQUERY 3 (browse) ---
  // --- There is no SUBQUERY2 (it is already merged with SQ3!) ---
  // --- This is the main query for SV and MV user tags (no extra join) ---
  // --- There is no SUBQUERY3 (it is already merged with MAIN!) ---
  // --- There is an extra join for MV user tags (no extra join) ---

  {
    RelationalQueryDefinition& subQuery3 = mainQuery;
    Record& whereDataSQ3 = whereDataMQ;
    std::string& whereClauseSQ3 = whereClauseMQ;
    // FROM ...
    subQuery3.addFromItem( m_channelTableName, "COOL_C2" );
    subQuery3.addFromItem( iovTable13, "COOL_I3" );
    // WHERE ...
    if ( ! channels.allChannels() )
    {
      std::string whereClauseSQ2;
      Record whereDataSQ2;
      unsigned int maxNonContiguousRanges = 50;
      if ( channels.isNumeric() )
      {
        if ( channels.firstChannel() == channels.lastChannel() )
        {
          whereClauseSQ2 += "COOL_C2."+chnChnId13Name;
          whereClauseSQ2 += "=:" + quotes+"chid"+quotes;
          RecordSpecification spec;
          spec.extend( "chid", chnChnId13TyId );
          Record rec( spec );
          rec["chid"].setValue( channels.firstChannel() );
          whereDataSQ2.extend( rec );
        }
        else if ( channels.isContiguous() )
        {
          whereClauseSQ2 += "COOL_C2."+chnChnId13Name;
          whereClauseSQ2 += ">=:" + quotes+"chmin"+quotes;
          whereClauseSQ2 += " AND ";
          whereClauseSQ2 += "COOL_C2."+chnChnId13Name;
          whereClauseSQ2 += "<=:" + quotes+"chmax"+quotes;
          RecordSpecification spec;
          spec.extend( "chmin", chnChnId13TyId );
          spec.extend( "chmax", chnChnId13TyId );
          Record rec( spec );
          rec["chmin"].setValue( channels.firstChannel() );
          rec["chmax"].setValue( channels.lastChannel() );
          whereDataSQ2.extend( rec );
        }
        else if (channels.rangeCount() <= maxNonContiguousRanges )
        {
          whereClauseSQ2 += "(";
          unsigned int index = 0;
          for (std::vector<ChannelSelection::ChannelRange>::const_iterator
                 i = channels.begin(); i != channels.end(); ++i)
          {
            if (index > 0) whereClauseSQ2 += " OR ";

            std::stringstream chmin;
            chmin << "chmin" << index;
            std::stringstream chmax;
            chmax << "chmax" << index;

            whereClauseSQ2 += "COOL_C2."+chnChnId13Name;
            whereClauseSQ2 += ">=:" + quotes+chmin.str()+quotes;
            whereClauseSQ2 += " AND ";
            whereClauseSQ2 += "COOL_C2."+chnChnId13Name;
            whereClauseSQ2 += "<=:" + quotes+chmax.str()+quotes;
            RecordSpecification spec;
            spec.extend( chmin.str(), chnChnId13TyId );
            spec.extend( chmax.str(), chnChnId13TyId );
            Record rec( spec );
            rec[chmin.str()].setValue( i->firstChannel() );
            rec[chmax.str()].setValue( i->lastChannel() );
            whereDataSQ2.extend( rec );

            ++index;
          }
          whereClauseSQ2 += ")";
        }
        else
        {
          std::stringstream s;
          s << "Non-contiguous channel selection only supported for up to "
            << maxNonContiguousRanges << " ranges";
          throw RelationalException(s.str(), "RelationalObjectTable");
        }
      }
      else
      {
        whereClauseSQ2 += "COOL_C2."+chnChnNm13Name;
        whereClauseSQ2 += "=:" + quotes+"chname"+quotes;
        RecordSpecification spec;
        spec.extend( "chname", chnChnNm13TyId );
        Record rec( spec );
        rec["chname"].setValue( channels.channelName() );
        whereDataSQ2.extend( rec );
      }
      whereClauseSQ3 += whereClauseSQ2 + " AND ";
      whereDataSQ3.extend( whereDataSQ2 );
    }
    // Do not use a subquery for MySQL
    // (Romain - MySQL performance is bad if there are subqueries)
    if ( queryMgr().databaseTechnology() == "MySQL" )
    {
      whereClauseSQ3 += whereClauseTag3;
      whereClauseSQ3 += "COOL_I3."+iovChnId13Name+"=COOL_C2."+iovChnId13Name;
      whereClauseSQ3 += " AND ";
      {
        whereDataSQ3.extend( whereDataTag3 );
      }
      whereClauseSQ3 += "( ";
      whereClauseSQ3 += "( ";
      whereClauseSQ3 += "COOL_I3."+iovSince13Name;
      whereClauseSQ3 += "<=:" + quotes+"sinc3"+ quotes;
      whereClauseSQ3 += " AND ";
      whereClauseSQ3 += "COOL_I3."+iovUntil13Name;
      whereClauseSQ3 += ">:" + quotes+"sinc3u"+ quotes;
      whereClauseSQ3 += " )";
      {
        whereDataSQ3.extend( whereDataSQ1 );
        RecordSpecification spec;
        spec.extend( "sinc3u", iovUntil13TyId );
        spec.extend( "sinc3", iovUntil13TyId );
        Record rec( spec );
        rec["sinc3u"].setValue( since );
        rec["sinc3"].setValue( since );
        whereDataSQ3.extend( rec );
      }
      whereClauseSQ3 += " OR ";
      whereClauseSQ3 += "( ";
      whereClauseSQ3 += "COOL_I3."+iovSince13Name;
      whereClauseSQ3 += ">=:" + quotes+"sinc3s"+quotes;
      whereClauseSQ3 += " AND ";
      whereClauseSQ3 += "COOL_I3."+iovSince13Name;
      whereClauseSQ3 += "<=:" + quotes+"until3"+quotes;
      whereClauseSQ3 += " )";
      whereClauseSQ3 += " )";
      {
        RecordSpecification spec;
        spec.extend( "sinc3s", iovSince13TyId );
        spec.extend( "until3", iovSince13TyId );
        Record rec( spec );
        rec["sinc3s"].setValue( since );
        rec["until3"].setValue( until );
        whereDataSQ3.extend( rec );
      }
    }
    else
    {
      // Use the chosen SQL query strategy (externalOr vs. internalOr/coalesce)
      if ( useExternalOr )
      {
        //std::cout << "__COOL using EXTERNALOR" << std::endl;
        // 1. Implementation with external OR
        whereClauseSQ3 += "( ";
        whereClauseSQ3 += "( ";
        whereClauseSQ3 += whereClauseTag3;
        whereClauseSQ3 += "COOL_I3."+iovChnId13Name+"=COOL_C2."+iovChnId13Name;
        whereClauseSQ3 += " AND ";
        {
          whereDataSQ3.extend( whereDataTag3 );
        }
        whereClauseSQ3 += "COOL_I3."+iovSince13Name;
        whereClauseSQ3 += "=" + subQuery1;
        whereClauseSQ3 += " AND ";
        whereClauseSQ3 += "COOL_I3."+iovUntil13Name;
        whereClauseSQ3 += ">:" + quotes+"sinc3u"+ quotes;
        {
          whereDataSQ3.extend( whereDataSQ1 );
          RecordSpecification spec;
          spec.extend( "sinc3u", iovUntil13TyId );
          Record rec( spec );
          rec["sinc3u"].setValue( since );
          whereDataSQ3.extend( rec );
        }
        whereClauseSQ3 += " ) OR ( ";
        whereClauseSQ3 += whereClauseTag3b;
        whereClauseSQ3 += "COOL_I3."+iovChnId13Name+"=COOL_C2."+iovChnId13Name;
        whereClauseSQ3 += " AND ";
        {
          whereDataSQ3.extend( whereDataTag3b );
        }
        whereClauseSQ3 += "COOL_I3."+iovSince13Name;
        whereClauseSQ3 += ">=:" + quotes+"sinc3s"+quotes;
        whereClauseSQ3 += " AND ";
        whereClauseSQ3 += "COOL_I3."+iovSince13Name;
        whereClauseSQ3 += "<=:" + quotes+"until3"+quotes;
        {
          RecordSpecification spec;
          spec.extend( "sinc3s", iovSince13TyId );
          spec.extend( "until3", iovSince13TyId );
          Record rec( spec );
          rec["sinc3s"].setValue( since );
          rec["until3"].setValue( until );
          whereDataSQ3.extend( rec );
        }
        whereClauseSQ3 += " )";
        whereClauseSQ3 += " )";
      }
      else
      {
        whereClauseSQ3 += whereClauseTag3;
        whereClauseSQ3 += "COOL_I3."+iovChnId13Name+"=COOL_C2."+iovChnId13Name;
        whereClauseSQ3 += " AND ";
        {
          whereDataSQ3.extend( whereDataTag3 );
        }
        // Use the chosen SQL query strategy (internalOr vs. coalesce)
        if ( useCoalesce )
        {
          //std::cout << "__COOL using COALESCE" << std::endl;
          // 2. Implementation with COALESCE
          whereClauseSQ3 += "COOL_I3."+iovSince13Name;
          whereClauseSQ3 += ">=COALESCE("+ subQuery1;
          whereClauseSQ3 += ",:" + quotes+"sinc3s"+quotes + ")";
          whereClauseSQ3 += " AND ";
          whereClauseSQ3 += "COOL_I3."+iovSince13Name;
          whereClauseSQ3 += "<=:" + quotes+"until3"+quotes;
          whereClauseSQ3 += " AND ";
          whereClauseSQ3 += "COOL_I3."+iovUntil13Name;
          whereClauseSQ3 += ">:" + quotes+"sinc3u"+ quotes;
          {
            whereDataSQ3.extend( whereDataSQ1 );
            RecordSpecification spec;
            spec.extend( "sinc3s", iovSince13TyId );
            spec.extend( "until3", iovSince13TyId );
            spec.extend( "sinc3u", iovUntil13TyId );
            Record rec( spec );
            rec["sinc3s"].setValue( since );
            rec["until3"].setValue( until );
            rec["sinc3u"].setValue( since );
            whereDataSQ3.extend( rec );
          }
        }
        else
        {
          //std::cout << "__COOL using INTERNALOR" << std::endl;
          // 3. Implementation with internal OR (without COALESCE)
          whereClauseSQ3 += "( ";
          whereClauseSQ3 += "( ";
          whereClauseSQ3 += "COOL_I3."+iovSince13Name;
          whereClauseSQ3 += "=" + subQuery1;
          whereClauseSQ3 += " AND ";
          whereClauseSQ3 += "COOL_I3."+iovUntil13Name;
          whereClauseSQ3 += ">:" + quotes+"sinc3u"+ quotes;
          whereClauseSQ3 += " )";
          {
            whereDataSQ3.extend( whereDataSQ1 );
            RecordSpecification spec;
            spec.extend( "sinc3u", iovUntil13TyId );
            Record rec( spec );
            rec["sinc3u"].setValue( since );
            whereDataSQ3.extend( rec );
          }
          whereClauseSQ3 += " OR ";
          whereClauseSQ3 += "( ";
          whereClauseSQ3 += "COOL_I3."+iovSince13Name;
          whereClauseSQ3 += ">=:" + quotes+"sinc3s"+quotes;
          whereClauseSQ3 += " AND ";
          whereClauseSQ3 += "COOL_I3."+iovSince13Name;
          whereClauseSQ3 += "<=:" + quotes+"until3"+quotes;
          whereClauseSQ3 += " )";
          whereClauseSQ3 += " )";
          {
            RecordSpecification spec;
            spec.extend( "sinc3s", iovSince13TyId );
            spec.extend( "until3", iovSince13TyId );
            Record rec( spec );
            rec["sinc3s"].setValue( since );
            rec["until3"].setValue( until );
            whereDataSQ3.extend( rec );
          }
        }
      }
    }
  }

  // --- MAIN QUERY FOR SV AND MV USER TAGS ---

  std::string cool_i_main;
  if ( pTagId == 0 || isUserTag )
  {
    cool_i_main = "COOL_I3.";
  }

  // --- MAIN QUERY FOR MV TAGS ---

  else
  {
    cool_i_main = "COOL_I4.";
    // --- MAIN QUERY FOR MV TAGS ---
    mainQuery.addFromItem( objectTableName, "COOL_I4" );
    // WHERE ...
    const std::string& iovObjIdName =
      RelationalObjectTable::columnNames::objectId();
    whereClauseMQ += " AND COOL_I4."+iovObjIdName;
    whereClauseMQ += "=COOL_I3."+iovObjIdName;
  }

  // Join on separate payload table (task #3372)
  std::string cool_payload = cool_i_main;
  if ( ( m_payloadMode == cool_PayloadMode_Mode::SEPARATEPAYLOAD ||
         m_payloadMode == cool_PayloadMode_Mode::VECTORPAYLOAD )
       && fetchPayload )
  {
    mainQuery.addFromItem( m_payloadTableName, "COOL_P5" );
    cool_payload = "COOL_P5.";
    const std::string& payloadIdName =
      m_payloadMode == cool_PayloadMode_Mode::SEPARATEPAYLOAD ?
      RelationalPayloadTable::columnNames::payloadId() :
      RelationalPayloadTable::columnNames::payloadSetId();

    whereClauseMQ += " AND " + cool_i_main + payloadIdName;
    whereClauseMQ += " = "+ cool_payload + payloadIdName;
    //whereClauseMQ += "(+)"; // outer join for vector folder (oracle)
  }

  // --- MAIN QUERY (COMMON TO ALL CASES) ---

  {
    // SELECT ...
    for ( unsigned int i=0; i<tableSpecification().size(); i++ )
    {
      std::string expression = tableSpecification()[i].name();
      // AV PDBSTRESSTEST - START
      static bool first = true;
      if ( getenv( "COOL_PDBSTRESSTEST_NBYTES" ) )
      {
        if ( expression == "S" )
        {
          expression = std::string( "SUBSTR(S,1," ) +
            getenv( "COOL_PDBSTRESSTEST_NBYTES" ) + ")";
          //expression = std::string
          //  ( "SUBSTR(REPLACE(S,SUBSTR(S,100,1),SUBSTR(S,101,1)),1," ) +
          //  getenv( "COOL_PDBSTRESSTEST_NBYTES" ) + ")";
          if ( first )
          {
            std::cout << "__COOL_PDBSTRESSTEST Hack: will select "
                      << expression << std::endl;
            first = false;
          }
        }
      }
      // AV PDBSTRESSTEST - END
      expression = cool_i_main + expression;
      std::string fromAlias = cool_i_main;
      fromAlias.erase( fromAlias.length()-1 ); // strip off the "."
      mainQuery.addSelectItem( fromAlias,
                               expression,
                               tableSpecification()[i].storageType().id(),
                               tableSpecification()[i].name() );
    }
    // payload in separate table
    if ( !m_payloadTableName.empty()  && fetchPayload )
    {
      std::string fromAlias = cool_payload;
      fromAlias.erase( fromAlias.length()-1 ); // strip off the "."
      for ( unsigned int i=0; i<m_payloadSpecification.size(); i++ )
      {
        std::string expression = m_payloadSpecification[i].name();
        // AV PDBSTRESSTEST - START
        static bool first = true;
        if ( getenv( "COOL_PDBSTRESSTEST_NBYTES" ) )
        {
          if ( expression == "S" )
          {
            expression = std::string( "SUBSTR(S,1," ) +
              getenv( "COOL_PDBSTRESSTEST_NBYTES" ) + ")";
            //expression = std::string
            //  ( "SUBSTR(REPLACE(S,SUBSTR(S,100,1),SUBSTR(S,101,1)),1," ) +
            //  getenv( "COOL_PDBSTRESSTEST_NBYTES" ) + ")";
            if ( first )
            {
              std::cout << "__COOL_PDBSTRESSTEST Hack: will select "
                        << expression << std::endl;
              first = false;
            }
          }
        }
        // AV PDBSTRESSTEST - END
        expression = cool_payload + expression;
        mainQuery.addSelectItem( fromAlias,
                                 expression,
                                 m_payloadSpecification[i].storageType().id(),
                                 m_payloadSpecification[i].name() );
      }
      if ( m_payloadMode == cool_PayloadMode_Mode::VECTORPAYLOAD )
      {
        // add payload item id
        mainQuery.addSelectItem( fromAlias,
                                 cool_payload + RelationalPayloadTable::columnNames::payloadItemId(),
                                 RelationalPayloadTable::columnTypeIds::payloadItemId,
                                 RelationalPayloadTable::columnNames::payloadItemId() );
      }


    }
    // SELECT / * + HINT * / ...
    if ( queryMgr().databaseTechnology() == "Oracle" ||
         queryMgr().databaseTechnology() == "frontier" )
    {
      std::string hint = hintPrefix + "+ ";
      // Use an optimizer older than the current Oracle server version
      static const char* optimizer = ::getenv( "COOL_ORA_OPTIMIZER_FEATURES" );
      if ( optimizer )
      {
        //int serverVersionMajor;
        //std::istringstream serverVersion( queryMgr().serverVersion() );
        //serverVersion >> serverVersionMajor;
        //int optimizerVersionMajor;
        //std::istringstream optimizerVersion( optimizer );
        //optimizerVersion >> optimizerVersionMajor;
        //if ( optimizerVersionMajor > 0 &&
        //     optimizerVersionMajor <= serverVersionMajor )
        hint += "OPTIMIZER_FEATURES_ENABLE('" + std::string(optimizer) + "') ";
      }
      // Disable adaptive optimization on 12c (bug #102272 and task #44885)
      if ( !getenv( "COOL_ORA_ENABLE_ADAPTIVE_OPT" ) )
      {
        // Do not add hints to disable 12c adaptive optimization if
        // the Oracle server version is older than 12c (bug #103602)
        int serverVersionMajor;
        std::istringstream serverVersion( queryMgr().serverVersion() );
        serverVersion >> serverVersionMajor;
        //std::cout << "Oracle version: " << serverVersionMajor << std::endl;
        if ( serverVersionMajor >= 12 ) // FIX bug #103602
        {
          // Do not prepare adaptive plans (get rid of STATISTICS COLLECTOR in exec plans)
          hint += "OPT_PARAM('OPTIMIZER_ADAPTIVE_FEATURES','FALSE') ";
          // Do not use adaptive plans (get rid of OPT_ESTIMATE extra queries)
          hint += "OPT_PARAM('OPTIMIZER_ADAPTIVE_REPORTING_ONLY','TRUE') ";
          // NB: both hints above must be included!
        }
      }
      // Disable adaptive cursor sharing on Oracle 11g
      // (see https://savannah.cern.ch/task/?23366#comment20)
      hint += "NO_BIND_AWARE ";
      // Add the query block name
      hint += "QB_NAME(MAIN) ";
      // Hint chosen by the user at runtime
      if ( getenv( "COOL_QUERYDEFGEN_HINTMAIN" ) )
      {
        std::string userHint( getenv( "COOL_QUERYDEFGEN_HINTMAIN" ) );
        boost::trim( userHint );
        if ( userHint != "" ) hint += userHint + " ";
      }
      // These hints force Oracle to use always the same execution plan:
      // 1. For different bind variable values (otherwise bind variable
      // peeking may result in a plan that is good only for some values).
      // Alternatively one may disable bind variable peeking at the session
      // level via ALTER SESSION SET "_OPTIM_PEEK_USER_BINDS" = FALSE.
      // Bind variable peeking cannot be disabled at the statement level
      // because hint OPT_PARAM('_OPTIM_PEEK_USER_BINDS','FALSE') does not
      // work (it's essentially ignored, bind variables are peeked anyway).
      // 2. Whether or not statistics have been computed.
      // Hardcoded hints (without payload table)
      else if ( m_payloadTableName.empty() )
      {
        if ( pTagId != 0 && *pTagId == 0 && !isUserTag ) // MVHR (#5 of 9)
        {
          // Hints from Romain in task #5821 (current head IOV retrieval)
          //hint += "INDEX(@MAIN COOL_C2@MAIN (CHANNEL_ID)) "; // depends...
          hint += "INDEX(@MAIN COOL_I3@MAIN (USER_TAG_ID NEW_HEAD_ID CHANNEL_ID IOV_SINCE IOV_UNTIL)) ";
          hint += "LEADING(@MAIN COOL_C2@MAIN COOL_I3@MAIN) ";
          hint += "USE_NL(@MAIN COOL_I3@MAIN) ";
          hint += "INDEX(@MAX1 COOL_I1@MAX1 (USER_TAG_ID NEW_HEAD_ID CHANNEL_ID IOV_SINCE IOV_UNTIL)) ";
        }
        else if ( pTagId != 0 && !isUserTag ) // MVTR (#7 of 9)
        {
          // Hints from task #5820 (standard tag IOV retrieval)
          //hint += "INDEX(@MAIN COOL_C2@MAIN (CHANNEL_ID)) "; // depends...
          hint += "INDEX_RS_ASC(@MAIN COOL_I3@MAIN (TAG_ID CHANNEL_ID IOV_SINCE IOV_UNTIL)) ";
          hint += "INDEX_RS_ASC(@MAIN COOL_I4@MAIN (OBJECT_ID)) ";
          hint += "LEADING(@MAIN COOL_C2@MAIN COOL_I3@MAIN COOL_I4@MAIN) ";
          hint += "USE_NL(@MAIN COOL_I3@MAIN) ";
          hint += "USE_NL(@MAIN COOL_I4@MAIN) ";
          hint += "INDEX(@MAX1 COOL_I1@MAX1 (TAG_ID CHANNEL_ID IOV_SINCE IOV_UNTIL)) ";
        }
        else if ( pTagId != 0 && isUserTag ) // MVUR (#3 of 9)
        {
          // Hints from Romain in task #6086 (user tag IOV insertion)
          // Hints apply also to task #4381 (user tag IOV retrieval)
          //hint += "INDEX(@MAIN COOL_C2@MAIN (CHANNEL_ID)) "; // depends...
          hint += "INDEX_RS_ASC(@MAIN COOL_I3@MAIN (USER_TAG_ID NEW_HEAD_ID CHANNEL_ID IOV_SINCE IOV_UNTIL)) ";
          hint += "LEADING(@MAIN COOL_C2@MAIN COOL_I3@MAIN) ";
          hint += "USE_NL(@MAIN COOL_I3@MAIN) ";
          hint += "INDEX(@MAX1 COOL_I1@MAX1 (USER_TAG_ID NEW_HEAD_ID CHANNEL_ID IOV_SINCE IOV_UNTIL)) ";
        }
        else if ( pTagId == 0 ) // SV_R (#1 of 9) and SC_R (#9 of 9)
        {
          // Hints for SV IOV retrieval (task #2223, task #3675, task #4402)
          //hint += "INDEX(@MAIN COOL_C2@MAIN (CHANNEL_ID)) ";
          hint += "INDEX(@MAIN COOL_I3@MAIN (CHANNEL_ID IOV_SINCE IOV_UNTIL)) ";
          hint += "LEADING(@MAIN COOL_C2@MAIN COOL_I3@MAIN) ";
          hint += "USE_NL(@MAIN COOL_I3@MAIN) ";
          hint += "INDEX(@MAX1 COOL_I1@MAX1 (CHANNEL_ID IOV_SINCE IOV_UNTIL)) ";
        }
      }
      // Hardcoded hints (with payload table)
      else
      {
        if ( pTagId != 0 && *pTagId == 0 && !isUserTag ) // MPHR (#6 of 9)
        {
          //hint += "INDEX(@MAIN COOL_C2@MAIN (CHANNEL_ID)) "; // depends...
          hint += "INDEX_RS_ASC(@MAIN COOL_I3@MAIN (USER_TAG_ID NEW_HEAD_ID CHANNEL_ID IOV_SINCE IOV_UNTIL)) ";
          hint += "INDEX_RS_ASC(@MAIN COOL_P5@MAIN (PAYLOAD_ID)) ";
          hint += "LEADING(@MAIN COOL_C2@MAIN COOL_I3@MAIN COOL_P5@MAIN) ";
          hint += "USE_NL(@MAIN COOL_I3@MAIN) ";
          hint += "USE_NL(@MAIN COOL_P5@MAIN) ";
          hint += "INDEX(@MAX1 COOL_I1@MAX1 (USER_TAG_ID NEW_HEAD_ID CHANNEL_ID IOV_SINCE IOV_UNTIL)) ";
        }
        else if ( pTagId != 0 && !isUserTag ) // MPTR (#8 of 9)
        {
          //hint += "INDEX(@MAIN COOL_C2@MAIN (CHANNEL_ID)) ";
          hint += "INDEX_RS_ASC(@MAIN COOL_I3@MAIN (TAG_ID CHANNEL_ID IOV_SINCE IOV_UNTIL)) ";
          hint += "INDEX_RS_ASC(@MAIN COOL_I4@MAIN (OBJECT_ID)) ";
          hint += "INDEX_RS_ASC(@MAIN COOL_P5@MAIN (PAYLOAD_ID)) ";
          hint += "LEADING(@MAIN COOL_C2@MAIN COOL_I3@MAIN COOL_I4@MAIN COOL_P5@MAIN) ";
          hint += "USE_NL(@MAIN COOL_I3@MAIN) ";
          hint += "USE_NL(@MAIN COOL_I4@MAIN) ";
          hint += "USE_NL(@MAIN COOL_P5@MAIN) ";
          hint += "INDEX(@MAX1 COOL_I1@MAX1 (TAG_ID CHANNEL_ID IOV_SINCE IOV_UNTIL)) ";
        }
        else if ( pTagId != 0 && isUserTag ) // MPUR (#4 of 9)
        {
          //hint += "INDEX(@MAIN COOL_C2@MAIN (CHANNEL_ID)) ";
          hint += "INDEX_RS_ASC(@MAIN COOL_I3@MAIN (USER_TAG_ID NEW_HEAD_ID CHANNEL_ID IOV_SINCE IOV_UNTIL)) ";
          hint += "INDEX_RS_ASC(@MAIN COOL_P5@MAIN (PAYLOAD_ID)) ";
          hint += "LEADING(@MAIN COOL_C2@MAIN COOL_I3@MAIN COOL_P5@MAIN) ";
          hint += "USE_NL(@MAIN COOL_I3@MAIN) ";
          hint += "USE_NL(@MAIN COOL_P5@MAIN) ";
          hint += "INDEX(@MAX1 COOL_I1@MAX1 (USER_TAG_ID NEW_HEAD_ID CHANNEL_ID IOV_SINCE IOV_UNTIL)) ";
        }
        else if ( pTagId == 0 ) // SP_R (#2 of 9)
        {
          //hint += "INDEX(@MAIN COOL_C2@MAIN (CHANNEL_ID)) ";
          hint += "INDEX_RS_ASC(@MAIN COOL_I3@MAIN (CHANNEL_ID IOV_SINCE IOV_UNTIL)) ";
          hint += "INDEX_RS_ASC(@MAIN COOL_P5@MAIN (PAYLOAD_ID)) ";
          hint += "LEADING(@MAIN COOL_C2@MAIN COOL_I3@MAIN COOL_P5@MAIN) ";
          hint += "USE_NL(@MAIN COOL_I3@MAIN) ";
          hint += "USE_NL(@MAIN COOL_P5@MAIN) ";
          hint += "INDEX(@MAX1 COOL_I1@MAX1 (CHANNEL_ID IOV_SINCE IOV_UNTIL)) ";
        }
      }
      hint += hintSuffix;
      mainQuery.setHint( hint );
    }
    if ( payloadQuery !=0 )
    {
      RelationalPayloadQuery pq( *payloadQuery,
                                 cool_payload,
                                 queryMgr().databaseTechnology());

      if ( pq.isTrusted() )
      {
        if ( ! fetchPayload )
          throw PanicException("trusted payload query, but "
                               " fetchPayload is false",
                               "RelationalObjectTable");
        whereClauseMQ+=" AND ( "+pq.whereClause()+" )";
        whereDataMQ.extend( pq.whereData() );
      }
      //std::cout <<"where clause "<< whereClauseMQ << std::endl;
    }
    // WHERE...
    mainQuery.setWhereClause( whereClauseMQ );
    //std::cout << "Bind variables: " << whereDataMQ << std::endl;
    mainQuery.setBindVariables( whereDataMQ );
    // ORDER BY ...
    std::vector<std::string> orderBy = orderByClause( channels );
    for ( std::vector<std::string>::const_iterator
            it = orderBy.begin(); it != orderBy.end(); it++ )
    {
      // TODO: Optimise? Use cool_c2.channel_id, cool_i3.iov_since?
      //mainQuery.addOrderItem( cool_i_main + *it ); // no good?...
      mainQuery.addOrderItem( "COOL_I3." + *it ); // better...
    }
    if ( m_payloadMode == cool_PayloadMode_Mode::VECTORPAYLOAD && fetchPayload )
    {
      // order by payload item id
      mainQuery.addOrderItem( cool_payload +
                              RelationalPayloadTable::columnNames::payloadItemId()
                              + " ASC " );
    }


  }

  // --- RETURN THE MAIN QUERY DEFINITION ---
  //log() << "Prepared generic query definition: "
  //      << *pMainQuery << coral::MessageStream::endmsg;
  return std::auto_ptr<IRelationalQueryDefinition>( pMainQuery.release() );

}

//---------------------------------------------------------------------------
