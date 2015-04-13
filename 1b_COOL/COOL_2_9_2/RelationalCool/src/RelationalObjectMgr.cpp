// $Id: RelationalObjectMgr.cpp,v 1.70 2012-01-30 17:42:51 avalassi Exp $

// Include files
#include <boost/scoped_array.hpp>
#include "CoolKernel/InternalErrorException.h"
#include "CoolKernel/IObjectIterator.h"
#include "RelationalAccess/SchemaException.h"

// Local include files
#include "HvsTagRecord.h"
#include "IRelationalBulkOperation.h"
#include "RelationalChannelTable.h"
#include "RelationalException.h"
#include "RelationalGlobalTagTable.h"
#include "RelationalObject.h"
#include "RelationalObjectIterator.h"
#include "RelationalObjectMgr.h"
#include "RelationalObjectTable.h"
#include "RelationalObjectTableRow.h"
#include "RelationalPayloadTable.h"
#include "RelationalQueryDefinition.h"
#include "RelationalSequence.h"
#include "RelationalSequenceMgr.h"
#include "RelationalTableRow.h"
#include "RelationalTagMgr.h"
#include "RelationalTagTable.h"
#include "SimpleObject.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

RelationalObjectMgr::RelationalObjectMgr( const RelationalDatabase& db )
  : m_db( db )
  , m_log( new coral::MessageStream( "RelationalObjectMgr" ) )
{
}

//-----------------------------------------------------------------------------

coral::MessageStream& RelationalObjectMgr::log() const
{
  *m_log << coral::Verbose;
  return *m_log;
}

//-----------------------------------------------------------------------------

IObjectPtr
RelationalObjectMgr::findObject( const RelationalFolder* folder,
                                 const ValidityKey& pointInTime,
                                 const ChannelId& channelId,
                                 const std::string& tagName ) const
{
  // Cross-check that the database is open
  if ( ! db().isOpen() ) throw DatabaseNotOpen( "RalDatabase" );

  IObjectIteratorPtr objs = browseObjects( folder,
                                           pointInTime,
                                           pointInTime,
                                           ChannelSelection( channelId ),
                                           tagName );

  if ( ! objs->goToNext() )
  {
    std::stringstream s;
    s << pointInTime;
    throw ObjectNotFound( s.str(), folder->fullPath() );
  }
  IObjectPtr obj( objs->currentRef().clone() );
  if ( objs->goToNext() )
    throw InternalErrorException
      ( "PANIC! More than one object in findObject query", "RalDatabase" );
  return obj;
}

//-----------------------------------------------------------------------------

IObjectIteratorPtr
RelationalObjectMgr::browseObjects
( const RelationalFolder* folder,
  const ValidityKey& since,
  const ValidityKey& until,
  const ChannelSelection& channels,
  const std::string& tagName,
  const IRecordSelection* payloadQuery,
  const bool countOnly ) const
{
  IObjectIteratorPtr iterator;

  // Cross-check that the database is open
  if ( ! db().isOpen() ) throw DatabaseNotOpen( "RalDatabase" );

  FolderVersioning::Mode versioningMode = folder->versioningMode();
  try
  {
    // Throw TagNotFound if the tag does not exist in this folder
    // [this is delegated to the RelationalObjectIterator constructor]

    if ( versioningMode == FolderVersioning::SINGLE_VERSION )
    {
      bool isUserTag = false;
      iterator.reset
        ( new RelationalObjectIterator
          ( m_db.sessionMgr(), queryMgr(), transactionMgr(), tagMgr(),
            *folder, since, until, channels, tagName, isUserTag,
            payloadQuery, countOnly ));
    }
    else if ( versioningMode == FolderVersioning::MULTI_VERSION )
    {
      bool isUserTag = folder->existsUserTag( tagName );
      iterator.reset
        ( new RelationalObjectIterator
          ( m_db.sessionMgr(), queryMgr(), transactionMgr(), tagMgr(),
            *folder, since, until, channels, tagName, isUserTag,
            payloadQuery, countOnly ));
    }
    else
    {
      std::stringstream s;
      s << "Unsupported folder versioning mode: "
        << versioningMode;
      throw RelationalException( s.str(), "RalDatabase" );
    }
  }
  catch ( coral::TableNotExistingException& )
  {
    // Guard against a dropped folder and provide meaningful feedback
    // (minor issue: catch CORAL exception in a generic Relational class...)
    throw FolderSpecificTableNotFound( folder->fullPath(), "RalDatabase" );
  }
  return iterator;
}

//-----------------------------------------------------------------------------

bool
RelationalObjectMgr::dropChannel( const RelationalFolder* folder,
                                  const ChannelId& channelId ) const
{
  db().checkDbOpenTransaction( "RelationalObjectMgr::dropChannel",
                               cool::ReadWrite );

  const std::string folderName = folder->fullPath();
  // FIRST check if there are any IOVs for this channel
  // (throw an exception if there are any - this is the semantics
  // of the dropChannel method, it is NOT a workaround for bug #23755).
  if ( db().relationalObjectTable( *folder )->existsChannel( channelId ) )
  {
    std::ostringstream s;
    s << "Cannot drop channel with id=" << channelId
      << " in folder '" << folder->fullPath()
      << "': the channel contains some IOVs";
    throw RelationalException( s.str(), "RelationalObjectMgr" );
  }
  // THEN check if the channel exists (only) in the channel table
  RelationalChannelTable table( db(), *folder );
  try
  {
    table.fetchRowForId( channelId );
  }
  catch ( NoRowsFound& )
  {
    return false;
  }
  std::string whereClause = RelationalChannelTable::columnNames::channelId();
  whereClause += "= :channel";
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "channel",
                        RelationalChannelTable::columnTypeIds::channelId );
  Record whereData( whereDataSpec );
  whereData["channel"].setValue( channelId );
  // Rely on the queryMgr to throw an exception if the DELETE goes wrong
  queryMgr().deleteTableRows( table.tableName(), whereClause, whereData, 1 );
  return true;
}

//-----------------------------------------------------------------------------

void
RelationalObjectMgr::createChannel( const RelationalFolder* folder,
                                    const ChannelId& channelId,
                                    const std::string& channelName,
                                    const std::string& description ) const
{
  db().checkDbOpenTransaction( "RelationalObjectMgr::createChannel",
                               cool::ReadWrite );

  const std::string folderName = folder->fullPath();
  // Check if a channel with the given ID already exists
  try
  {
    RelationalChannelTable table( db(), *folder );
    table.fetchRowForId( channelId );
    throw ChannelExists( folderName, channelId, "RelationalObjectMgr" );
  }
  catch ( NoRowsFound& ) {}
  // Check if a channel with the given name already exists
  try
  {
    RelationalChannelTable table( db(), *folder );
    table.fetchRowForChannelName( channelName );
    throw ChannelExists( folderName, channelName, "RelationalObjectMgr" );
  } catch ( NoRowsFound& ) {}
  // Create a new channel with the given ID and name
  unsigned int lastObjectId = 0;
  bool hasNewData = false;
  insertChannelTableRow( folder->channelTableName(),
                         channelId,
                         lastObjectId,
                         hasNewData,
                         channelName,
                         description );
}

//-----------------------------------------------------------------------------

void RelationalObjectMgr::insertChannelTableRow
( const std::string& channelTableName,
  const ChannelId& channelId,
  unsigned int lastObjectId,
  bool hasNewData,
  const std::string& channelName,
  const std::string& description ) const
{
  Record data( RelationalChannelTable::tableSpecification() );
  data[RelationalChannelTable::columnNames::channelId()].setValue
    ( channelId );
  data[RelationalChannelTable::columnNames::lastObjectId()].setValue
    ( lastObjectId );
  data[RelationalChannelTable::columnNames::hasNewData()].setValue
    ( hasNewData );
  if ( channelName != "" )
    data[RelationalChannelTable::columnNames::channelName()].setValue
      ( channelName );
  else
    data[RelationalChannelTable::columnNames::channelName()].setNull();
  data[RelationalChannelTable::columnNames::description()].setValue
    ( description );
  queryMgr().insertTableRow( channelTableName, data );
}

//-----------------------------------------------------------------------------

void RelationalObjectMgr::updateChannelTable
( const std::string& channelTableName,
  const ChannelId& channelId,
  unsigned int lastObjectId,
  bool hasNewData ) const
{
  log() << "Update in table " << channelTableName
        << " for channel " << channelId << coral::MessageStream::endmsg;

  // Update the lastObjectId column only if hasNewData is false
  // Enforce that lastObjectId should be 0 otherwise
  bool updateLastObjectId = (!hasNewData);
  if ( !updateLastObjectId && lastObjectId != 0 )
    throw RelationalException
      ( "PANIC! Unexpected arguments to updateChannelTable", "RelationalObjectMgr" );

  // Define the SET and WHERE clauses for the update using bind variables
  RecordSpecification updateDataSpec;
  if ( updateLastObjectId )
    updateDataSpec.extend
      ( "lastObjectId", RelationalChannelTable::columnTypeIds::lastObjectId );
  updateDataSpec.extend( "hasNewData",
                         RelationalChannelTable::columnTypeIds::hasNewData );
  updateDataSpec.extend( "channel",
                         RelationalChannelTable::columnTypeIds::channelId );
  Record updateData( updateDataSpec );
  if ( updateLastObjectId )
    updateData["lastObjectId"].setValue( lastObjectId );
  updateData["hasNewData"].setValue( hasNewData );
  updateData["channel"].setValue( channelId );
  std::string setClause;
  if ( updateLastObjectId )
  {
    setClause += RelationalChannelTable::columnNames::lastObjectId();
    setClause += " = :lastObjectId";
    setClause += ", ";
  }
  setClause += RelationalChannelTable::columnNames::hasNewData();
  setClause += "= :hasNewData";
  std::string whereClause = RelationalChannelTable::columnNames::channelId();
  whereClause += "= :channel";

  // Execute the update
  UInt32 updatedRows = queryMgr().updateTableRows
    ( channelTableName, setClause, whereClause, updateData );

  if ( updatedRows == 0 )
  {
    // it's a new channel
    Record data( RelationalChannelTable::tableSpecification() );
    data[RelationalChannelTable::columnNames::channelId()].setValue
      ( channelId );
    data[RelationalChannelTable::columnNames::lastObjectId()].setValue
      ( lastObjectId );
    data[RelationalChannelTable::columnNames::hasNewData()].setValue
      ( hasNewData );
    //data[RelationalChannelTable::columnNames::channelName()].setValue
    //  ( std::string("") );
    data[RelationalChannelTable::columnNames::channelName()].setNull(); // UK!
    queryMgr().insertTableRow( channelTableName, data );
  }
  else if ( updatedRows != 1 )
  {
    throw RowNotUpdated
      ( "Could not update a row of the channels table", "RalDatabase" );
  }
}

//-----------------------------------------------------------------------------

void RelationalObjectMgr::bulkUpdateChannelTable
( const std::string& channelTableName,
  const std::map< ChannelId, unsigned int >& updateDataMap,
  bool hasNewData ) const
{
  log() << "Bulk update channel table " << channelTableName
        << coral::MessageStream::endmsg;

  if ( updateDataMap.empty() ) {
    log() << "Nothing to update" << coral::MessageStream::endmsg;
    return;
  }

  // Update the lastObjectId column only if hasNewData is false
  bool updateLastObjectId = (!hasNewData);

  // ATTEMPT BULK UPDATE
  {
    // Define the SET and WHERE clauses for the update using bind variables
    RecordSpecification updateDataSpec;
    if ( updateLastObjectId )
      updateDataSpec.extend
        ( "lastObjectId",
          RelationalChannelTable::columnTypeIds::lastObjectId );
    updateDataSpec.extend
      ( "hasNewData",
        RelationalChannelTable::columnTypeIds::hasNewData );
    updateDataSpec.extend
      ( "channel",
        RelationalChannelTable::columnTypeIds::channelId );
    Record updateData( updateDataSpec );
    std::string setClause;
    if ( updateLastObjectId )
    {
      setClause += RelationalChannelTable::columnNames::lastObjectId();
      setClause += " = :lastObjectId";
      setClause += ", ";
    }
    setClause += RelationalChannelTable::columnNames::hasNewData();
    setClause += "= :hasNewData";
    std::string whereClause = RelationalChannelTable::columnNames::channelId();
    whereClause += "= :channel";

    boost::shared_ptr<IRelationalBulkOperation> query =
      db().queryMgr().bulkUpdateTableRows
      ( channelTableName, setClause, whereClause, updateData,
        RelationalFolder::bulkOpRowCacheSize() );

    for ( std::map< ChannelId, unsigned int >::const_iterator
            i = updateDataMap.begin(); i != updateDataMap.end(); ++i )
    {
      updateData["channel"].setValue( i->first );
      if ( updateLastObjectId )
        updateData["lastObjectId"].setValue( i->second );
      updateData["hasNewData"].setValue( hasNewData );
      query->processNextIteration();
    }
    query->flush();

  }

  // CHECK BULK UPDATE - ELSE SINGLE ROW INSERT/UPDATE
  // (NB THIS CAN ONLY BE DONE IF HASNEWDATA IS TRUE!)
  if ( hasNewData )
  {
    // Get updated row count
    RelationalQueryDefinition def;
    //def.addSelectItems(...); // None - SELECT COUNT(*) FROM ( SELECT * ... )
    def.addFromItem( channelTableName, "" );
    std::string whereClause =
      RelationalChannelTable::columnNames::hasNewData() + " = :hasNewData";
    def.setWhereClause( whereClause );
    RecordSpecification whereDataSpec;
    whereDataSpec.extend( "hasNewData", StorageType::Bool );
    Record whereData( whereDataSpec );
    whereData["hasNewData"].setValue( hasNewData );
    def.setBindVariables( whereData );
    UInt32 rowCount = queryMgr().countRows( def );

    // If the row count differs from what is expected,
    // insert/update channels one by one in the table
    if ( rowCount != updateDataMap.size() )
    {
      log() << "Bulk update failed (rows updated=" << rowCount
            << ", rows to be updated=" << updateDataMap.size()
            << "): use single row insert/update"
            << coral::MessageStream::endmsg;

      // Fall back to the non-bulk channel update
      for ( std::map< ChannelId, unsigned int >::const_iterator
              i = updateDataMap.begin(); i != updateDataMap.end(); ++i )
      {
        ChannelId channel = i->first;
        log() << "Insert or update channel " << channel
              << coral::MessageStream::endmsg;
        updateChannelTable
          ( channelTableName, channel, i->second, hasNewData );
      }
    }
  }

}

//-----------------------------------------------------------------------------

void RelationalObjectMgr::bulkUpdateObjectTableIov
( const std::string& objectTableName,
  const std::map<unsigned int,ValidityKey>& objectIdNewUntil ) const
{
  log() << "Bulk update IOVs in table " << objectTableName
        << coral::MessageStream::endmsg;

  if ( objectIdNewUntil.empty() ) {
    log() << "Nothing to update" << coral::MessageStream::endmsg;
    return;
  }

  // Define the SET and WHERE clauses for the update using bind variables
  // NB: Oracle execution plan, from interactive Benthic test, uses
  // fast access via the 1D index on objectId
  // (UPDATE STATEMENT, UPDATE, INDEX UNIQUE SCAN)
  RecordSpecification updateDataSpec;
  updateDataSpec.extend( "until",
                         RelationalObjectTable::columnTypeIds::iovUntil );
  updateDataSpec.extend( "objId",
                         RelationalObjectTable::columnTypeIds::objectId );
  Record updateData( updateDataSpec );
  std::string setClause = RelationalObjectTable::columnNames::iovUntil();
  setClause += "= :until";
  setClause += ", ";
  setClause += RelationalObjectTable::columnNames::lastModDate();
  setClause += " = " + queryMgr().serverTimeClause();
  std::string whereClause = RelationalObjectTable::columnNames::objectId();
  whereClause += "= :objId";

  boost::shared_ptr<IRelationalBulkOperation> query =
    db().queryMgr().bulkUpdateTableRows
    ( objectTableName, setClause, whereClause, updateData,
      RelationalFolder::bulkOpRowCacheSize() );

  for ( std::map<unsigned int,ValidityKey>::const_iterator
          i = objectIdNewUntil.begin(); i != objectIdNewUntil.end(); ++i ) {
    updateData["objId"].setValue( i->first );
    updateData["until"].setValue( i->second );
    query->processNextIteration();
  }
  query->flush();

}

//-----------------------------------------------------------------------------

// TODO Andrea/Romain: do we really need channelId here?
// Roman noted that the 'SELECT IN' query could be rewritten without the
// loop on the channel table... but maybe actually what needs to be done
// is to keep the loop on the channels table and remove the selection
// on channelId in the WHERE clause (update all channels in bulk)?

bool RelationalObjectMgr::bulkUpdateObjectTableNewHeadId
( const std::string& objectTableName,
  const std::string& channelTableName,
  const SOVector& updateNewHeads,
  unsigned int userTagId ) const
{
  log() << "Bulk update IOV table" << coral::MessageStream::endmsg;

  // Bind variable values for the SET and WHERE clauses
  RecordSpecification updateDataSpec;
  updateDataSpec.extend( "newHeadId",
                         RelationalObjectTable::columnTypeIds::newHeadId );
  updateDataSpec.extend( "channel",
                         RelationalObjectTable::columnTypeIds::channelId );
  updateDataSpec.extend( "userTagId",
                         RelationalObjectTable::columnTypeIds::userTagId );
  updateDataSpec.extend( "userTagId1",
                         RelationalObjectTable::columnTypeIds::userTagId );
  updateDataSpec.extend( "since1",
                         RelationalObjectTable::columnTypeIds::iovSince );
  updateDataSpec.extend( "since2",
                         RelationalObjectTable::columnTypeIds::iovSince );
  updateDataSpec.extend( "until1",
                         RelationalObjectTable::columnTypeIds::iovUntil );
  updateDataSpec.extend( "since3",
                         RelationalObjectTable::columnTypeIds::iovSince );
  Record updateData( updateDataSpec );

  // Prepare the SET clause
  std::string setClause = RelationalObjectTable::columnNames::newHeadId();
  setClause += "= :newHeadId";
  setClause += ", ";
  setClause += RelationalObjectTable::columnNames::lastModDate();
  setClause += " = " + queryMgr().serverTimeClause();

  // Prepare the WHERE clause
  std::string whereClause;
  if ( queryMgr().databaseTechnology() == "MySQL" ||
       getenv( "COOL_TASK6086_DISABLERBUPDATE" ) )
  {
    // Prepare the WHERE clause (COOL230 all backends and COOL231 MySQL)
    whereClause = RelationalObjectTable::columnNames::channelId();
    whereClause += "= :channel";
    whereClause += " AND ";
    whereClause += RelationalObjectTable::columnNames::userTagId();
    whereClause += "= :userTagId";
    whereClause += " AND ";
    whereClause += RelationalObjectTable::columnNames::newHeadId();
    whereClause += "= 0";
    whereClause += " AND ";
    // Also see SimpleObject::overlaps for this clause
    std::string s = RelationalObjectTable::columnNames::iovSince();
    std::string u = RelationalObjectTable::columnNames::iovUntil();
    whereClause += "(";
    whereClause += "( ( " + s + " <= :since1 ) AND ( :since2 < " +u+ " ) )";
    whereClause += " OR ( ( :since3 <= " +s+ " ) AND ( " +s+ " < :until1 ) )";
    whereClause += ")";
  }
  else
  {
    std::string schemaPrefix = "";
    if ( queryMgr().schemaName() != "" )
      schemaPrefix = queryMgr().schemaName() + ".";

    // Prepare the WHERE clause (COOL231 Oracle/Frontier/SQLite by Romain)
    // Latest change by Andrea: MERGE subqueries to simplify the SQL query:
    // result is very similar to RelationaObjectTable::queryDefinitionGeneric
    whereClause = RelationalObjectTable::columnNames::objectId();
    whereClause += " IN ( SELECT ";
    whereClause += "/*+ QB_NAME(BROWSE3) ";
    if ( queryMgr().databaseTechnology() == "Oracle" ||
         queryMgr().databaseTechnology() == "frontier" )
    {
      whereClause += "INDEX_RS_ASC(@BROWSE3 COOL_I3@BROWSE3 (USER_TAG_ID ";
      whereClause += "NEW_HEAD_ID CHANNEL_ID IOV_SINCE IOV_UNTIL)) ";
      whereClause += "LEADING(@BROWSE3 COOL_C2@BROWSE3 COOL_I3@BROWSE3) ";
      whereClause += "USE_NL(@BROWSE3 COOL_I3@BROWSE3) ";
      whereClause += "INDEX(@MAX1 COOL_I1@MAX1 (USER_TAG_ID ";
      whereClause += "NEW_HEAD_ID CHANNEL_ID IOV_SINCE IOV_UNTIL)) ";
    }
    whereClause += "*/ ";
    whereClause += "COOL_I3.";
    whereClause += RelationalObjectTable::columnNames::objectId();
    whereClause += " FROM " ;
    whereClause += schemaPrefix + channelTableName + " COOL_C2, ";
    whereClause += schemaPrefix + objectTableName + " COOL_I3 ";
    whereClause += "WHERE COOL_C2.CHANNEL_ID=:channel ";
    whereClause += "AND COOL_I3.USER_TAG_ID=:userTagId ";
    whereClause += "AND COOL_I3.NEW_HEAD_ID=0 ";
    whereClause += "AND COOL_I3.CHANNEL_ID=COOL_C2.CHANNEL_ID ";
    whereClause += "AND COOL_I3.IOV_SINCE>= " ;
    whereClause += "COALESCE( ";
    whereClause += "( SELECT /*+ QB_NAME(MAX1) */ ";
    whereClause += "MAX(COOL_I1.IOV_SINCE) FROM ";
    whereClause += schemaPrefix + objectTableName + " COOL_I1 ";
    whereClause += "WHERE  ";
    whereClause += "COOL_I1.USER_TAG_ID= :userTagId1 AND ";
    whereClause += "COOL_I1.NEW_HEAD_ID=0 AND ";
    whereClause += "COOL_I1.CHANNEL_ID=COOL_C2.CHANNEL_ID AND ";
    whereClause += "COOL_I1.IOV_SINCE<=:since1 ) ";
    whereClause += ",:since2) ";
    whereClause += "AND COOL_I3.IOV_SINCE<:until1 ";
    whereClause += "AND COOL_I3.IOV_UNTIL>:since3 ";
    whereClause += " ) ";
  }

  boost::shared_ptr<IRelationalBulkOperation> query =
    db().queryMgr().bulkUpdateTableRows
    ( objectTableName, setClause, whereClause, updateData,
      RelationalFolder::bulkOpRowCacheSize() );
  //std::cout << "*** setClause: " << setClause << std::endl;
  //std::cout << "*** whereClause: " << whereClause << std::endl;

  ObjectId minNewHeadId = 0;
  for ( SOIterator interval =  updateNewHeads.begin();
        interval != updateNewHeads.end();
        ++interval)
  {
    // where data
    updateData["channel"].setValue( (unsigned int) interval->channelId );
    updateData["userTagId"].setValue( userTagId );
    updateData["userTagId1"].setValue( userTagId );
    updateData["since1"].setValue( interval->since );
    updateData["since2"].setValue( interval->since );
    updateData["since3"].setValue( interval->since );
    updateData["until1"].setValue( interval->until );
    // set data
    updateData["newHeadId"].setValue( interval->objectId );
    if ( minNewHeadId == 0 || interval->objectId < minNewHeadId )
      minNewHeadId = interval->objectId;
    //std::cout << " [ " << interval->since
    //          << ", " << interval->until << " [ oID "
    //          << interval->objectId << std::endl;
    query->processNextIteration();
  }
  query->flush();

  // Check if any rows have been updated
  bool updated = false;
  {
    RelationalQueryDefinition checkDef;
    // This triggers bug #43528
    //std::string schemaPrefix = "";
    //if ( queryMgr().schemaName() != "" )
    //  schemaPrefix = queryMgr().schemaName() + ".";
    //checkDef.addFromItem( schemaPrefix + objectTableName );
    checkDef.addFromItem( objectTableName );
    checkDef.setWhereClause
      ( RelationalObjectTable::columnNames::userTagId() + "=:userTagId AND " +
        RelationalObjectTable::columnNames::newHeadId() + ">=:minNewHeadId" );
    RecordSpecification checkDataSpec;
    checkDataSpec.extend
      ( "userTagId", RelationalObjectTable::columnTypeIds::userTagId );
    checkDataSpec.extend
      ( "minNewHeadId", RelationalObjectTable::columnTypeIds::newHeadId );
    Record checkData( checkDataSpec );
    checkData["userTagId"].setValue( userTagId );
    checkData["minNewHeadId"].setValue( minNewHeadId );
    checkDef.setBindVariables( checkData );
    UInt32 updatedRows = queryMgr().countRows( checkDef );
    if ( updatedRows > 0 ) updated = true;
    //std::cout << "Number of updated rows: " << updatedRows << std::endl;
  }
  return updated;
}

//-----------------------------------------------------------------------------

int RelationalObjectMgr::truncateObjectValidity
( const RelationalFolder* folder,
  const ValidityKey& until,
  const ChannelSelection& channels ) const
{
  if ( folder->versioningMode() != FolderVersioning::SINGLE_VERSION )
    throw RelationalException("Truncating of IOVs is only supported for "
                              "single version Folders.",
                              "RelationalObjectMgr");
  db().checkDbOpenTransaction( "RelationalObjectMgr::truncateObjectValidity",
                               cool::ReadWrite );

  RelationalObjectTable objectTable( queryMgr(), *folder );
  std::map<unsigned int,ValidityKey> objectIdNewUntil;
  int count=0;

  // get all rows in [until, until[
  const std::auto_ptr<IRelationalQueryDefinition>
    def( objectTable.queryDefinitionSV( until, until, channels ) );
  std::vector<RelationalTableRow> result = queryMgr().fetchOrderedRows( *def,
                                                                        "SV truncate object validity");

  // Process the result set
  for ( std::vector<RelationalTableRow>::const_iterator
          i = result.begin(); i != result.end(); ++i ) {
    RelationalObjectTableRow obj( *i );
    if ( obj.until() == ValidityKeyMax ) {
      objectIdNewUntil[ obj.objectId() ] = until;
      count++;
    } else
      throw RelationalException("Truncating IOVs is only allowed for "
                                "until +inf IOVs", "RelationalObjectMgr");
  }

  // Bulk update the rows with open IOVs
  bulkUpdateObjectTableIov( folder->objectTableName(), objectIdNewUntil );
  return count;
}

//-----------------------------------------------------------------------------

void RelationalObjectMgr::bulkInsertObjectTableRows
( const RelationalFolder* folder,
  const std::vector<RelationalObjectTableRowPtr>& rows,
  const std::vector<RelationalPayloadTableRowPtr>& payloadRows ) const
{
  const std::string& objectTableName=folder->objectTableName();
  const std::string& payloadTableName=folder->payloadTableName();
  const RecordSpecification& rowSpec=folder->payloadSpecification();
  // Check that there are >0 rows to store
  unsigned int nRows = rows.size();
  if ( nRows == 0 ) {
    log() << "No rows to store into table "
          << objectTableName << coral::MessageStream::endmsg;
    return;
  }
  log() << "Bulk inserting " << nRows << " rows into table "
        << objectTableName << coral::MessageStream::endmsg;

  // Get a new IOV ID from the sequence
  // Get also the corresponding database server system date
  boost::shared_ptr<RelationalSequence> objectIdSeq
    ( queryMgr().sequenceMgr().getSequence
      ( RelationalObjectTable::sequenceName( objectTableName ) ) );
  // Possible bug #54717: currDate returns old date if nextVal is not called!
  std::string sysDate = objectIdSeq->currDate(); // for update (lock): needed?

  // Setup the relational table bulk inserter
  bool useBulkInserter = true;
  int iovIterations = 0;

  // Payload is stored in a separate table
  if ( folder->payloadMode() == PayloadMode::VECTORPAYLOAD  )
  {

    // payload table
    RecordSpecification payloadTableSpec =
      RelationalPayloadTable::tableSpecification( rowSpec, folder->payloadMode() );
    Record payloadData( payloadTableSpec );
    // TEMPORARY HACK: no IField::setValue/fastCopy(const coral::Attribute&)...
    coral::AttributeList& payloadDataAL =
      const_cast<coral::AttributeList&>( payloadData.attributeList() );

    // iov table
    RecordSpecification iovTableSpec =
      RelationalObjectTable::tableSpecification( rowSpec, folder->payloadMode() );
    Record iovData( iovTableSpec );
    // TEMPORARY HACK: no IField::setValue/fastCopy(const coral::Attribute&)...
    coral::AttributeList& iovDataAL =
      const_cast<coral::AttributeList&>( iovData.attributeList() );

    boost::shared_ptr<IRelationalBulkOperation> payloadBulkInserter;
    boost::shared_ptr<IRelationalBulkOperation> iovBulkInserter;
    if ( useBulkInserter )
    {
      payloadBulkInserter = db().queryMgr().bulkInsertTableRows
        ( payloadTableName, payloadData,
          RelationalFolder::bulkOpRowCacheSize() );
      iovBulkInserter = db().queryMgr().bulkInsertTableRows
        ( objectTableName, iovData,
          RelationalFolder::bulkOpRowCacheSize() );
    }

    // Iterate through the IOV objects and register them for insertion
    std::vector<RelationalObjectTableRowPtr>::const_iterator row;
    for ( row = rows.begin(); row != rows.end(); ++row )
    {

      for ( coral::AttributeList::const_iterator
              iAtt = (*row)->data().begin(); iAtt != (*row)->data().end(); ++iAtt )
      {
        const std::string& name = iAtt->specification().name();
        try
        {
          iovDataAL[name].fastCopy( *iAtt );
        }
        catch ( coral::AttributeListException& )
        {
          throw RelationalException
            ( "A field with name '" + name
              + "' does not exist in the folder object specification",
              "RelationalObjectMgr" );
        }
      }
      // TEMPORARY! sysInsTime and lastUpdate as string rather than DATE
      iovData[RelationalObjectTable::columnNames::sysInsTime()]
        .setValue( sysDate );
      iovData[RelationalObjectTable::columnNames::lastModDate()]
        .setValue( sysDate );

      // Verbose printout: print full row that is being inserted into the DB
      // TEMPORARY? Speed up insertion by disabling IOV streaming to MsgStream
      /*
         std::ostringstream dataStream;
         data.print( dataStream );
         log() << "Insert into the IOV table the following AttributeList: "
         << dataStream.str() << coral::MessageStream::endmsg;
      *///

      // Insert the new object in the IOV table
      if ( useBulkInserter )
      {
        // Flush both bulk operations one row before the iov auto-flush
        // NB: RalQueryMgr throws if rowCacheSize <= 1...
        if ( iovIterations == iovBulkInserter->rowCacheSize()-1 )
        {
          iovBulkInserter->flush();
          iovIterations = 0;
        }
        iovIterations++;
        iovBulkInserter->processNextIteration();
      }
      else
      {
        queryMgr().insertTableRow( objectTableName, iovData );
      }
    }

    // Flush the bulk inserter
    if ( useBulkInserter )
      iovBulkInserter->flush();


    iovIterations = 0;
    // Iterate through the payload rows and register them for insertion
    std::vector<RelationalPayloadTableRowPtr>::const_iterator pRow;
    for ( pRow = payloadRows.begin(); pRow != payloadRows.end(); ++pRow )
    {

      // reset payload data
      for ( UInt32 i = 0; i < payloadData.size(); i++ )
        payloadData[i].setNull();

      for ( coral::AttributeList::const_iterator
              iAtt = (*pRow)->data().begin(); iAtt != (*pRow)->data().end(); ++iAtt )
      {
        const std::string& name = iAtt->specification().name();
        try
        {
          payloadDataAL[name].fastCopy( *iAtt );
        }
        catch ( coral::AttributeListException& )
        {
          throw RelationalException
            ( "A field with name '" + name
              + "' does not exist in the folder payload specification",
              "RelationalObjectMgr" );
        }
      }

      // new payload set p_sysInsTime and store payload
      payloadData[RelationalPayloadTable::columnNames::p_sysInsTime()]
        .setValue( sysDate );
      if ( useBulkInserter )
        payloadBulkInserter->processNextIteration();
      else
        queryMgr().insertTableRow( payloadTableName, payloadData );


      // Verbose printout: print full row that is being inserted into the DB
      // TEMPORARY? Speed up insertion by disabling IOV streaming to MsgStream
      /*
         std::ostringstream dataStream;
         data.print( dataStream );
         log() << "Insert into the IOV table the following AttributeList: "
         << dataStream.str() << coral::MessageStream::endmsg;
      *///

      // Insert the new object in the IOV table
      if ( useBulkInserter )
      {
        // Flush both bulk operations one row before the iov auto-flush
        // NB: RalQueryMgr throws if rowCacheSize <= 1...
        if ( iovIterations == payloadBulkInserter->rowCacheSize()-1 )
        {
          payloadBulkInserter->flush();
          iovIterations = 0;
        }
        iovIterations++;
      }
    }
    if ( useBulkInserter )
      payloadBulkInserter->flush();

  }
  else if ( folder->payloadMode() == PayloadMode::SEPARATEPAYLOAD  )
  {

    // Get a pointer to the payloadID sequence
    //boost::shared_ptr<RelationalSequence> payloadIdSeq
    //  ( queryMgr().
    //    sequenceMgr().getSequence
    //    ( RelationalPayloadTable::sequenceName( payloadTableName ) ) );

    // payload table
    RecordSpecification payloadTableSpec =
      RelationalPayloadTable::tableSpecification( rowSpec, folder->payloadMode() );
    Record payloadData( payloadTableSpec );
    // TEMPORARY HACK: no IField::setValue/fastCopy(const coral::Attribute&)...
    coral::AttributeList& payloadDataAL =
      const_cast<coral::AttributeList&>( payloadData.attributeList() );

    // iov table
    RecordSpecification iovTableSpec =
      RelationalObjectTable::tableSpecification( rowSpec, PayloadMode::SEPARATEPAYLOAD );
    Record iovData( iovTableSpec );
    // TEMPORARY HACK: no IField::setValue/fastCopy(const coral::Attribute&)...
    coral::AttributeList& iovDataAL =
      const_cast<coral::AttributeList&>( iovData.attributeList() );

    boost::shared_ptr<IRelationalBulkOperation> payloadBulkInserter;
    boost::shared_ptr<IRelationalBulkOperation> iovBulkInserter;
    if ( useBulkInserter )
    {
      payloadBulkInserter = db().queryMgr().bulkInsertTableRows
        ( payloadTableName, payloadData,
          RelationalFolder::bulkOpRowCacheSize() );
      iovBulkInserter = db().queryMgr().bulkInsertTableRows
        ( objectTableName, iovData,
          RelationalFolder::bulkOpRowCacheSize() );
    }

    // Iterate through the payload rows and register them for insertion
    std::vector<RelationalPayloadTableRowPtr>::const_iterator pRow;
    for ( pRow = payloadRows.begin(); pRow != payloadRows.end(); ++pRow )
    {

      // reset payload data
      for ( UInt32 i = 0; i < payloadData.size(); i++ )
        payloadData[i].setNull();

      for ( coral::AttributeList::const_iterator
              iAtt = (*pRow)->data().begin(); iAtt != (*pRow)->data().end(); ++iAtt )
      {
        const std::string& name = iAtt->specification().name();
        try
        {
          payloadDataAL[name].fastCopy( *iAtt );
        }
        catch ( coral::AttributeListException& )
        {
          throw RelationalException
            ( "A field with name '" + name
              + "' does not exist in the folder payload specification",
              "RelationalObjectMgr" );
        }
      }

      // new payload set p_sysInsTime and store payload
      payloadData[RelationalPayloadTable::columnNames::p_sysInsTime()]
        .setValue( sysDate );
      if ( useBulkInserter )
        payloadBulkInserter->processNextIteration();
      else
        queryMgr().insertTableRow( payloadTableName, payloadData );


      // Verbose printout: print full row that is being inserted into the DB
      // TEMPORARY? Speed up insertion by disabling IOV streaming to MsgStream
      /*
         std::ostringstream dataStream;
         data.print( dataStream );
         log() << "Insert into the IOV table the following AttributeList: "
         << dataStream.str() << coral::MessageStream::endmsg;
      *///

      // Insert the new object in the IOV table
      if ( useBulkInserter )
      {
        // Flush both bulk operations one row before the iov auto-flush
        // NB: RalQueryMgr throws if rowCacheSize <= 1...
        if ( iovIterations == payloadBulkInserter->rowCacheSize()-1 )
        {
          payloadBulkInserter->flush();
          iovIterations = 0;
        }
        iovIterations++;
      }
    }
    if ( useBulkInserter )
      payloadBulkInserter->flush();

    iovIterations = 0;
    // Iterate through the IOV objects and register them for insertion
    std::vector<RelationalObjectTableRowPtr>::const_iterator row;
    for ( row = rows.begin(); row != rows.end(); ++row )
    {

      for ( coral::AttributeList::const_iterator
              iAtt = (*row)->data().begin(); iAtt != (*row)->data().end(); ++iAtt )
      {
        const std::string& name = iAtt->specification().name();
        try
        {
          iovDataAL[name].fastCopy( *iAtt );
        }
        catch ( coral::AttributeListException& )
        {
          throw RelationalException
            ( "A field with name '" + name
              + "' does not exist in the folder object specification",
              "RelationalObjectMgr" );
        }
      }
      // TEMPORARY! sysInsTime and lastUpdate as string rather than DATE
      iovData[RelationalObjectTable::columnNames::sysInsTime()]
        .setValue( sysDate );
      iovData[RelationalObjectTable::columnNames::lastModDate()]
        .setValue( sysDate );

      // Verbose printout: print full row that is being inserted into the DB
      // TEMPORARY? Speed up insertion by disabling IOV streaming to MsgStream
      /*
         std::ostringstream dataStream;
         data.print( dataStream );
         log() << "Insert into the IOV table the following AttributeList: "
         << dataStream.str() << coral::MessageStream::endmsg;
      *///

      // Insert the new object in the IOV table
      if ( useBulkInserter )
      {
        // Flush both bulk operations one row before the iov auto-flush
        // NB: RalQueryMgr throws if rowCacheSize <= 1...
        if ( iovIterations == iovBulkInserter->rowCacheSize()-1 )
        {
          iovBulkInserter->flush();
          iovIterations = 0;
        }
        iovIterations++;
        iovBulkInserter->processNextIteration();
      }
      else
      {
        queryMgr().insertTableRow( objectTableName, iovData );
      }
    }

    // Flush the bulk inserter
    if ( useBulkInserter )
    {
      payloadBulkInserter->flush();
      iovBulkInserter->flush();
    };

  }

  // Payload is NOT stored in a separate table
  else
  {
    // AV 07.03.2007 - fix for bug #24464
    // (record to be stored may have fewer fields and in a different order!)
    // [NB - this may lead to C++ performance degradations]
    //coral::AttributeList data( rows[0].data() );
    RecordSpecification tableSpec =
      RelationalObjectTable::tableSpecification( rowSpec, PayloadMode::INLINEPAYLOAD );
    Record data( tableSpec );
    // TEMPORARY HACK: no IField::setValue/fastCopy(const coral::Attribute&)...
    coral::AttributeList& dataAL =
      const_cast<coral::AttributeList&>( data.attributeList() );

    boost::shared_ptr<IRelationalBulkOperation> bulkInserter;
    if ( useBulkInserter )
      bulkInserter = db().queryMgr().bulkInsertTableRows
        ( objectTableName, data,
          RelationalFolder::bulkOpRowCacheSize() );

    // Iterate through the objects and register them for insertion
    std::vector<RelationalObjectTableRowPtr>::const_iterator row;
    for ( row = rows.begin(); row != rows.end(); ++row )
    {

      // AV 07.03.2007 - fix for bug #24464
      // (record to be stored may have fewer fields and in a different order!)
      for ( UInt32 i = 0; i < data.size(); i++ ) data[i].setNull();

      for ( coral::AttributeList::const_iterator
              iAtt = (*row)->data().begin(); iAtt != (*row)->data().end(); ++iAtt )
      {
        const std::string& name = iAtt->specification().name();
        try
        {
          // AV 30.11.2006 - fast is not the fastest! should we use share?
          // Check also who does the validate() and when...
          dataAL[name].fastCopy( *iAtt );
        }
        catch ( coral::AttributeListException& )
        {
          throw RelationalException
            ( "A field with name '" + name
              + "' does not exist in the folder payload specification",
              "RelationalObjectMgr" );
        }
      }

      // TEMPORARY! sysInsTime and lastUpdate as string rather than DATE
      data[RelationalObjectTable::columnNames::sysInsTime()]
        .setValue( sysDate );
      data[RelationalObjectTable::columnNames::lastModDate()]
        .setValue( sysDate );

      // Verbose printout: print full row that is being inserted into the DB
      // TEMPORARY? Speed up insertion by disabling IOV streaming to MsgStream
      /*
         std::ostringstream dataStream;
         data.print( dataStream );
         log() << "Insert into the IOV table the following AttributeList: "
         << dataStream.str() << coral::MessageStream::endmsg;
      *///

      /*
      // Check that all column values are within their allowed range.
      // REMOVE? This is already done by the IField::setValue calls above.
      rowSpec.validate( data, false ); // data only ( no spec size )
      *///

      // Insert the new object in the IOV table
      if ( useBulkInserter )
        bulkInserter->processNextIteration();
      else
        queryMgr().insertTableRow( objectTableName, data );
    }

    // Flush the bulk inserter
    if ( useBulkInserter )
      bulkInserter->flush();
  }
}

//-----------------------------------------------------------------------------

/// Channel comparison functor to compare RelationalObjectPtrs
class eq_channel
  : public std::unary_function<RelationalObjectPtr, bool>
{
public:
  eq_channel( const ChannelId& channel ) : m_channelid( channel ) {}
  bool operator()( const RelationalObjectPtr& obj ) const
  {
    return ( obj->channelId() == m_channelid  );
  }
private:
  ChannelId m_channelid;
};

//-----------------------------------------------------------------------------

void RelationalObjectMgr::updateSingleVersionIovs
( RelationalFolder* folder,
  const std::pair<ChannelIdValidityKeyMap,ChannelIdObjectIdMap>& intersectors,
  const std::vector<RelationalObjectPtr>& objects ) const
{
  RelationalObjectTable objectTable( queryMgr(), *folder );
  log() << "Update SV IOVs" << coral::MessageStream::endmsg;

  // The first map contains the new 'since' per channel for update in the
  // channel table
  const ChannelIdValidityKeyMap& channelSince = intersectors.first;
  // The second map contains the new 'lastObjectId' per channel for update in
  // the channel table. We make a copy, because it potentially has to be
  // modified in the 'back-insertion' algorithm.
  ChannelIdObjectIdMap channelLastObjectId = intersectors.second;

  // Flag the channels that have new data for the later join


  // Implementation of task #2009, comment #13:
  // Try the bulk insertion first, check by counting if the expected number
  // of channels has been flagged in the channels table and if so proceed
  // with the bulk insertion.
  // If the count is not what expected, fall back to single update version.
  {
    // Flag the channels in need of an update in the channels table
    bool hasNewData = true;
    unsigned int lastObjectId = 0; // dummy - ignored
    std::map< ChannelId, unsigned int > updateDataMap;
    for ( ChannelIdValidityKeyMap::const_iterator
            i = channelSince.begin(); i != channelSince.end(); ++i )
    {
      const ChannelId& channel = i->first;
      updateDataMap[channel] = lastObjectId;
    }
    bulkUpdateChannelTable
      ( folder->channelTableName(), updateDataMap, hasNewData );
  }

  // Fetch the 'last row' for each channel with new data
  std::vector<RelationalObjectTableRow> lastRows;
  fetchLastRowsWithNewData( folder, lastRows );

  // This map records the object ids in need of an until update
  std::map<unsigned int,ValidityKey> objectIdNewUntil;

  // Update the IOVs of the last rows if required
  for ( std::vector<RelationalObjectTableRow>::const_iterator
          row = lastRows.begin(); row != lastRows.end(); ++row ) {
    // check IOV
    // bulk update if necessary
    ChannelId channel = row->channelId();
    ChannelIdValidityKeyMap::const_iterator
      intersector = channelSince.find( channel );
    ValidityKey newUntil =
      intersector != channelSince.end()
      ? intersector->second
      : // this can't possibly happen as we only select rows that have
        // previously been marked from this very map. This throw only
      // completes the code path.
      throw InternalErrorException( "Channel without corresponding "
                                    "intersector", "RalDatabase" );
    if ( row->until() == ValidityKeyMax &&
         row->since() < newUntil ) {
      // Record this object id for IOV update
      objectIdNewUntil[row->objectId()] = newUntil;
    } else if ( newUntil < row->until() ) {
      // task #3138: Change SV requirement to "do not overlap"
      // instead of "do not backinsert"

      // Prepare a channel comparator to filer on the current channel
      eq_channel channel_cmp( channel );

      // Find all objects in the current channel and count them
      std::vector<RelationalObjectPtr>::const_iterator
        i = find_if( objects.begin(), objects.end(), channel_cmp );
      int count = 0;
      RelationalObjectPtr obj = *i;
      if ( i != objects.end() ) {
        ++count;
        if ( find_if( ++i, objects.end(), channel_cmp ) != objects.end() ) {
          ++count;
        }
      }

      // We can do back-insertion only if there's no more than one IOV in
      // this channel
      if ( count == 1 ) {
        // Select [since, until[ and check for 0 iovs -- otherwise we have
        // an overlap
        ValidityKey until = obj->until();
        // We want to select [since, until[ but the countRows method selects
        // [since, until] (i.e. including the upper bound. Therefore we need
        // to decrement the until value. This might seem dodgy but:
        // 1. it allows us to reuse the count query instead of writing a new
        //    one with :until < iov_until instead of '<='
        // 2. it is safe as long as the ValidityKey type defines operator--.
        //    Currently it's an integer type and therefore safe. A note
        //    regarding this has been added to the type definition. The only
        //    foreseeable problem with this change is if ValidityKey should
        //    ever turn into an 'non-decrementable' type, e.g. a float.
        //    If that should happen, implementing operator-- will not be
        //    possible and the warning placed at ValidityKey's place of
        //    definition will lead to this place.
        --until;
        // Count the objects in [since, until[
        const std::auto_ptr<IRelationalQueryDefinition>
          def( objectTable.queryDefinitionSV( obj->since(), until, channel ) );
        //const std::auto_ptr<IRelationalQueryDefinition>
        //  def( objectTable.queryDefinitionGeneric
        //       ( obj->since(), until, channel ) );
        if ( queryMgr().countRows( *def, "SV object count" ) != 0 ) {
          // We have a collision
          log() << coral::Verbose
                << "Exception - overlapping intervals: new until = "
                << newUntil << ", last until = "
                << row->until() << coral::MessageStream::endmsg;
          throw RelationalException
            ( "Back-insertion collision: "
              "overlapping intervals not allowed in SINGLE_VERSION mode",
              "RalDatabase" );
        }
        // No collision, we can back-insert. We also have to update the
        // 'lastObjectId' update map for this channel, because it currently
        // has the newly (back-inserted) object id recorded for this channel.
        // Since we're back-inserted it's not the true 'lastObjectId'. This
        // is actually the 'row' object (the current iterator of lastRows in
        // this loop) which has been fetched via 'fetchLastRowsWithNewData'.
        channelLastObjectId[channel] = row->objectId();
      } else {
        log() << coral::Verbose
              << "Exception - overlapping intervals: new until = "
              << newUntil << ", last until = " << row->until()
              << coral::MessageStream::endmsg;
        throw RelationalException
          ( "Back-insertion not possible due to multiple objects in channel" );
      }
    }
  }

  // Bulk update the rows with open IOVs
  bulkUpdateObjectTableIov( folder->objectTableName(), objectIdNewUntil );

  // Bulk update the channel table data
  bool hasNewData = false;
  std::map< ChannelId, unsigned int > updateDataMap;
  for ( ChannelIdObjectIdMap::const_iterator
          i = channelLastObjectId.begin();
        i != channelLastObjectId.end(); ++i )
  {
    const ChannelId& channel = i->first;
    const unsigned int& lastObjectId = i->second;
    updateDataMap[channel] = lastObjectId;
  }
  bulkUpdateChannelTable
    ( folder->channelTableName(), updateDataMap, hasNewData );

}

//-----------------------------------------------------------------------------

void RelationalObjectMgr::fetchLastRowsWithNewData
( RelationalFolder* folder,
  std::vector<RelationalObjectTableRow>& rows ) const
{
  // NEW (with RelationalQueryDefinition)
  RelationalQueryDefinition def;

  // Use a hint to stabilize the execution plan (task #5654)
  def.setHint( "/*+ INDEX(C) INDEX_RS_ASC(O) LEADING(C O) USE_NL(C O) */" );
  //def.setHint( "/*+ INDEX(O) */" ); // BAD (Oracle bug 4323868)
  //def.setHint( "/*+ LEADING(C O) USE_HASH(C O) */" ); // BAD (as COOL_2_2_1)

  RelationalObjectTable objectTable( queryMgr(), *folder );
  def.addSelectItems( objectTable.tableSpecification(), "O." );

  def.addFromItem( folder->objectTableName(), "O" );
  def.addFromItem( folder->channelTableName(), "C" );

  std::string whereClause;
  whereClause +=
    "C." + RelationalChannelTable::columnNames::hasNewData()
    + " = :hasNewData";
  whereClause += " AND ";
  whereClause +=
    "C." + RelationalChannelTable::columnNames::lastObjectId() + " = "
    "O." + RelationalObjectTable::columnNames::objectId();
  def.setWhereClause( whereClause );

  def.addOrderItem
    ( "C." + RelationalChannelTable::columnNames::channelId() + " ASC" );

  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "hasNewData", StorageType::Bool );
  Record whereData( whereDataSpec );
  whereData["hasNewData"].setValue( true );
  def.setBindVariables( whereData );

  std::vector<RelationalTableRow> result = queryMgr().fetchOrderedRows( def );

  // Process the result set
  for ( std::vector<RelationalTableRow>::const_iterator
          i = result.begin(); i != result.end(); ++i ) {
    rows.push_back( RelationalObjectTableRow( *i ) );
  }

}

//-----------------------------------------------------------------------------

void RelationalObjectMgr::storeObjects
( RelationalFolder* folder,
  const std::vector<RelationalObjectPtr>& objects,
  bool userTagOnly ) const
{
  log() << "Store " << objects.size() << " objects into folder "
        << folder->fullPath() << coral::MessageStream::endmsg;
  FolderVersioning::Mode versioningMode = folder->versioningMode();
  if ( versioningMode == FolderVersioning::SINGLE_VERSION )
  {
    if ( userTagOnly )
    {
      std::stringstream msg;
      msg << "Single version folder: userTagOnly is meaningless";
      throw RelationalException( msg.str(),
                                 "RelationalObjectMgr::storeObjects" );
    }
    storeSingleVersionObjects( folder, objects );
  }
  else if ( versioningMode == FolderVersioning::MULTI_VERSION )
  {
    storeMultiVersionObjects( folder, objects, userTagOnly );
  }
  else
  {
    std::stringstream s;
    s << "invalid versioning mode: " << versioningMode;
    throw RelationalException( s.str(), "RalDatabase" );
  }
}

//-----------------------------------------------------------------------------

void RelationalObjectMgr::storeSingleVersionObjects
( RelationalFolder* folder,
  const std::vector<RelationalObjectPtr>& objects ) const
{
  log() << "Store " << objects.size() << " SV Objects into folder '"
        << folder->fullPath() << "'" << coral::MessageStream::endmsg;

  if ( objects.empty() ) return;
  // check for a user tag being specified
  for ( std::vector<RelationalObjectPtr>::const_iterator
          i = objects.begin(); i != objects.end(); ++i ) {
    if ( (*i)->userTagName() != "" ) {
      std::stringstream s;
      s << "Cannot store a SV object with user tag: " << (*i)->userTagName();
      throw FolderIsSingleVersion
        ( folder->fullPath(), s.str(), "RalDatabase" );
    }
  }

  RecordSpecification rowSpec = folder->payloadSpecification();

  std::vector<RelationalObjectTableRowPtr> rows;
  std::vector<RelationalPayloadTableRowPtr> payloadRows;

  // Set the objectIdOffset: We start from the current sequence value +1
  boost::shared_ptr<RelationalSequence> objectIdSeq
    ( queryMgr().sequenceMgr().getSequence
      ( RelationalObjectTable::sequenceName( folder->objectTableName() ) ) );
  unsigned int objectIdOffset =
    objectIdSeq->currVal() +1; // lock (select for update)
  objectIdSeq->nextVal( objects.size() );

  // Get a pointer to the payloadID sequence
  boost::shared_ptr<RelationalSequence> payloadIdSeq;
  RelationalPayloadTable::columnTypes::payloadId pIdOffset=0;
  if ( folder->payloadMode() == PayloadMode::SEPARATEPAYLOAD )
  {
    payloadIdSeq=queryMgr().sequenceMgr().getSequence(
                                                      RelationalPayloadTable::sequenceName(
                                                                                           folder->payloadTableName() ) );
    pIdOffset = payloadIdSeq->currVal() + 1; // lock (select for update)
    payloadIdSeq->nextVal( objects.size() );
  }

  std::pair<ChannelIdValidityKeyMap,ChannelIdObjectIdMap>
    intersectors( processSingleVersionObjects
                  ( objects, rows, payloadRows, objectIdOffset,
                    pIdOffset, folder->payloadMode() ) );

  updateSingleVersionIovs( folder, intersectors, objects );

  bulkInsertObjectTableRows( folder, rows, payloadRows );
}

//-----------------------------------------------------------------------------

void RelationalObjectMgr::storeMultiVersionObjects
( RelationalFolder* folder,
  const std::vector<RelationalObjectPtr>& objects,
  bool userTagOnly ) const
{
  log() << "Store " << objects.size() << " MV Objects into folder '"
        << folder->fullPath() << "'" << coral::MessageStream::endmsg;

  if ( objects.empty() ) return;

  // confirm that all objects have the same tagName (if any)
  std::string userTagName( objects[0]->userTagName() );
  for ( std::vector<RelationalObjectPtr>::const_iterator
          i = objects.begin(); i != objects.end(); ++i )
  {
    if ( (*i)->userTagName() != userTagName )
    {
      std::stringstream s;
      s << "Conflicting tag '" << (*i)->userTagName() << "' specified "
        << "during bulk insertion";
      throw RelationalException( s.str(), "RalDatabase" );
    }
  }

  // Determine user tag id (by fetching or creation)
  // Any HEAD tag ("", "head", "HEAD", "Head"...) -> no user tag (userTagId=0)
  // NB Cannot make a difference between "" and "HEAD"!!!
  unsigned int userTagId;
  bool partiallyLocked=false;
  if ( IHvsNode::isHeadTag( userTagName ) )
  {
    userTagId = 0;
  }

  // Proper user tag - check if tag exists or must be created
  else
  {
    bool createTag = false;
    if ( ! tagMgr().existsTag( userTagName ) )
    {
      // Tag does not exist in any folder - create it
      createTag = true;
    }
    else
    {
      try
      {
        // Tag exists in this folder - check if user tag or standard (HEAD) tag
        RelationalTableRow tagRow =
          tagMgr().fetchGlobalTagTableRow( folder->id(), userTagName );
        userTagId =
          tagRow[RelationalTagTable::columnNames::tagId]
          .data<unsigned int>();
        // Throw TagIsLocked if the tag is locked
        HvsTagLock::Status lockStatus =
          HvsTagLock::Status
          ( tagRow[RelationalGlobalTagTable::columnNames::tagLockStatus]
            .data<UInt16>() );
        if ( lockStatus == HvsTagLock::LOCKED )
          throw TagIsLocked
            ( "Cannot store objects with user tag '" + userTagName +
              "': tag is locked", "RelationalObjectMgr" );
        if ( lockStatus == HvsTagLock::PARTIALLYLOCKED )
          partiallyLocked=true;

        // Tag is a standard tag in this folder - throw TagExists (can't mix!)
        // TODO - performance (see task #4381)
        if ( RelationalFolder::existsTagInObject2TagTable
             ( queryMgr(), userTagId, folder->object2TagTableName() ) )
          throw TagExists( userTagName, "RalDatabase" );
        // Else tag exists already either because of user tag or HVS
        // (should we check and throw a PANIC exception otherwise?)
      }
      catch ( TagNotFound& )
      {
        // TEMPORARY! Eventually can use same tag in several folders!
        // Tag exists in another folder - throw TagExists
        throw TagExists( userTagName, "RalDatabase" );
      }
    }
    if ( createTag )
    {
      // Get a new tag ID and insert the new tag in the global tag table
      // PERFORMANCE WARNING - createTag() will query existsTag() a 2nd time
      std::string description = "";
      HvsTagRecord userTag =
        //tagMgr().createTag( folder->id(), userTagName, description );
        tagMgr().createTagAndLocalTag
        ( folder->id(), userTagName, description, folder->tagTableName() );
      userTagId = userTag.id();
    }
  }

  log() << "All MV Objects have the same user tag '"
        << userTagName << "' (tagId=" << userTagId << ")"
        << coral::MessageStream::endmsg;

  // Set the objectIdOffset: We start from the current sequence value +1
  boost::shared_ptr<RelationalSequence> objectIdSeq
    ( queryMgr().sequenceMgr().getSequence
      ( RelationalObjectTable::sequenceName( folder->objectTableName() ) ) );
  unsigned int objectIdOffset =
    objectIdSeq->currVal() +1; // lock (select for update)
  // Reserve ids for two system objects in addition to the user object
  // and also leave room for the user tag ids:
  // therefore 6*size()
  objectIdSeq->nextVal( ObjectIdIncrement * objects.size() );

  // Get a pointer to the payloadID sequence
  boost::shared_ptr<RelationalSequence> payloadIdSeq;
  RelationalPayloadTable::columnTypes::payloadId pIdOffset=0;
  if ( folder->hasPayloadTable() ) {
    payloadIdSeq = queryMgr().sequenceMgr().getSequence
      ( RelationalPayloadTable::sequenceName( folder->payloadTableName() ) );
    pIdOffset = payloadIdSeq->currVal() + 1; // lock (select for update)
    payloadIdSeq->nextVal( objects.size() );
  }

  std::vector<RelationalObjectTableRowPtr> rows;
  std::vector<RelationalPayloadTableRowPtr> payloadRows;
  std::map<unsigned int, unsigned int> idToIndex;

  // Insert global head objects
  // (append the global head rows to the 'rows' vector)
  if ( ! userTagOnly )
  {
    std::vector<SimpleObject>
      intersectors( processMultiVersionObjects
                    ( objects, rows, payloadRows, objectIdOffset, idToIndex,
                      0, false, pIdOffset, folder->payloadMode() ) );
    mergeWithHead( folder, intersectors, rows, idToIndex );
  }

  // Insert user tag head objects
  // (append the user tag rows to the 'rows' vector)
  if ( ! IHvsNode::isHeadTag( userTagName ) )
  {
    std::vector<RelationalObjectTableRowPtr> userTagRows;
    std::map<unsigned int, unsigned int> idToIndexUserTagRows;

    std::vector<SimpleObject> userTagIntersectors
      ( processMultiVersionObjects( objects,
                                    userTagRows,
                                    payloadRows,
                                    objectIdOffset,
                                    idToIndexUserTagRows,
                                    userTagId,
                                    partiallyLocked,
                                    pIdOffset,
                                    folder->payloadMode() ) );

    // Compute the user tag head rows (to be appended to the 'rows' vector)
    mergeWithHead( folder, userTagIntersectors, userTagRows,
                   idToIndexUserTagRows, userTagId, partiallyLocked );

    // Append user tag head rows into the 'rows' vector
    std::copy( userTagRows.begin(),
               userTagRows.end(),
               std::back_inserter( rows ) );

  }

  // Fill the channel table for MV folders (fix bug #23755).
  // Analyse the 'rows' vector to extract the channels that need an update.
  // BulkUpdate must be called twice - first with hasNewData==true (so that
  // the single row update/insert can work) and then with hasNewData==false.
  // For the first execution, lastObjectId must be set to 0
  // (just use the map to indicate which channels are updated).
  std::map< ChannelId, unsigned int > updateDataMap;
  std::vector<RelationalObjectTableRowPtr>::const_iterator row;
  for ( row = rows.begin(); row != rows.end(); ++row )
  {
    const ChannelId& channel = (*row)->channelId();
    updateDataMap[channel] = 0;
  }
  bool hasNewData = true;
  bulkUpdateChannelTable
    ( folder->channelTableName(), updateDataMap, hasNewData );
  // For the second execution, compute the highest objectId in each channel
  for ( row = rows.begin(); row != rows.end(); ++row )
  {
    const ChannelId& channel = (*row)->channelId();
    const unsigned int& objectId = (*row)->objectId();
    if ( updateDataMap[channel] < objectId )
      updateDataMap[channel] = objectId;
  }
  hasNewData = false;
  bulkUpdateChannelTable
    ( folder->channelTableName(), updateDataMap, hasNewData );

  // Now write all head rows from the 'rows' vector into the database
  // (both the global head rows and the user tag rows)
  bulkInsertObjectTableRows( folder, rows, payloadRows );
}

//-----------------------------------------------------------------------------

std::pair<ChannelIdValidityKeyMap, ChannelIdObjectIdMap>
RelationalObjectMgr::processSingleVersionObjects
( const std::vector<RelationalObjectPtr>& objects,
  std::vector<RelationalObjectTableRowPtr>& rows,
  std::vector<RelationalPayloadTableRowPtr>& payloadRows,
  unsigned int objectIdOffset,
  unsigned int pIdOffset,
  PayloadMode::Mode pMode ) const
{
  // records the lowest 'since' per channel
  ChannelIdValidityKeyMap lowestSince;
  // records the last object id per channel
  ChannelIdObjectIdMap lastObjectIds;
  // records the last object id from the 'objects' stack that has been
  // validated in a given channel
  std::map<ChannelId,unsigned int> prevObjects;
  rows.reserve( objects.size() );

  for ( unsigned int object_index = 0;
        object_index < objects.size(); ++object_index ) {

    RelationalObjectPtr obj = objects[ object_index ];

    // if pIdOffest != 0 the payload is stored in a separate table
    // and we have to fill the payloadId field
    RelationalObjectTableRowPtr row( new RelationalObjectTableRow(obj,
                                                                  pMode ) );
    row->setObjectId( object_index + objectIdOffset );
    if (  pMode == PayloadMode::SEPARATEPAYLOAD )
    {
      row->setPayloadId( object_index + pIdOffset );

      RelationalPayloadTableRowPtr pRow( new RelationalPayloadTableRow( obj,
                                                                        pMode ) );
      pRow->setPayloadId( object_index + pIdOffset );

      payloadRows.push_back( pRow );
    }
    else if ( pMode == PayloadMode::VECTORPAYLOAD )
    {
      row->setPayloadSetId( row->objectId() );

      IRecordIterator &it=obj->payloadIterator();
      int i=0;
      while ( it.goToNext() )
      {
        RelationalPayloadTableRowPtr pRow( new RelationalPayloadTableRow( it.currentRef(),
                                                                          pMode ) );

        pRow->setPayloadSetId( row->objectId() );
        pRow->setPayloadItemId( i );
        payloadRows.push_back( pRow );
        i++;
      }
      row->setPayloadNItems( i );
      if ( i == 0 )
      {
        // special case, no payload rows:
        // we add a dummy payload row containing null values, because
        // we can't do a outer join with coral.
        RelationalPayloadTableRowPtr pRow( new RelationalPayloadTableRow( obj,
                                                                          pMode ) );
        pRow->setPayloadItemId( 0 );
        pRow->setPayloadSetId( row->objectId() );
        payloadRows.push_back( pRow );
      }

    }


    ValidityKey since = row->since();
    ValidityKey until = row->until();

    // Internal consistency check: since<until (NB: since=until NOT ALLOWED!)
    if ( since >= until )
      throw ValidityIntervalBackwards( since, until, "RalDatabase" );

    // Validity key checks
    if ( since > ValidityKeyMax )
      throw ValidityKeyOutOfBoundaries( since, "RalDatabase" );
    if ( until > ValidityKeyMax )
      throw ValidityKeyOutOfBoundaries( until, "RalDatabase" );

    std::map<ChannelId,unsigned int>::iterator
      prevObj = prevObjects.find( row->channelId() );
    if ( prevObj != prevObjects.end() ) {

      unsigned int index = prevObj->second;

      RelationalObjectTableRow& prevRow( *rows[ index ] );

      if ( prevRow.until() == ValidityKeyMax &&
           prevRow.since() < row->since() ) {
        prevRow.setUntil( row->since() );
      } else if ( prevRow.until() > row->since() ) {
        log() << coral::Verbose
              << "Exception - overlapping intervals: new since = "
              << row->since() << ", last until = "
              << prevRow.until() << coral::MessageStream::endmsg;
        throw RelationalException
          ( "Overlapping intervals not allowed in SINGLE_VERSION mode",
            "RalDatabase" );
      }
    }

    prevObjects[ obj->channelId() ] = object_index;

    // update lowestSince map if there's no entry yet
    if ( lowestSince.find( row->channelId() ) == lowestSince.end() ) {
      lowestSince[ row->channelId() ] = row->since();
    }
    // update last object id
    lastObjectIds[ row->channelId() ] = row->objectId();

    rows.push_back( row );
  }

  return std::make_pair( lowestSince, lastObjectIds );
}

//-----------------------------------------------------------------------------

std::vector<SimpleObject>
RelationalObjectMgr::processMultiVersionObjects
( const std::vector<RelationalObjectPtr>& objects,
  std::vector<RelationalObjectTableRowPtr>& rows,
  std::vector<RelationalPayloadTableRowPtr>& payloadRows,
  unsigned int objectIdOffset,
  std::map<unsigned int, unsigned int>& idToIndex,
  unsigned int userTagId,
  bool partiallyLocked,
  unsigned int pIdOffset,
  PayloadMode::Mode pMode ) const
{

  rows.reserve( objects.size() );

  // The head is the current top layer of the object stack
  std::vector<SimpleObject> head;

  // The bottom is the list of object intervals as seen from 'below'
  // -- think of it as the head if you invert the layers.
  std::vector<SimpleObject> bottom;

  for ( unsigned int object_index = 0;
        object_index < objects.size(); ++object_index ) {

    RelationalObjectPtr obj = objects[ object_index ];

    // Internal consistency check: since<until (NB: since=until NOT ALLOWED!)
    if ( obj->since() >= obj->until() )
      throw ValidityIntervalBackwards( obj->since(), obj->until(), "RalDatabase" );

    // Validity key checks
    if ( obj->since() > ValidityKeyMax )
      throw ValidityKeyOutOfBoundaries( obj->since(), "RalDatabase" );
    if ( obj->until() > ValidityKeyMax )
      throw ValidityKeyOutOfBoundaries( obj->until(), "RalDatabase" );

    // Objects in the rows vector are inserted with an
    // object_id == 6*object_index + objectIdOffset
    // to reserve object_ids that are possibly needed for system objecs
    // created by mergeWithHead (maximum of two system objects per user object)
    // Additional room is reserved for ids need by user tags in the future
    // The object_id 0 is reserved for 'null' references
    // (objectIdOffset is > 0)
    RelationalObjectTableRowPtr currentRow( new RelationalObjectTableRow( obj,
                                                                          pMode ) );
    if ( userTagId == 0 ) {
      currentRow->setObjectId
        ( ObjectIdIncrement * object_index + objectIdOffset );
    } else {
      // user tag objects have an objectId offset of 3
      currentRow->setObjectId
        ( ObjectIdIncrement * object_index + objectIdOffset +3 );
    }
    currentRow->setUserTagId( userTagId );

    // set the payload id / payload set id and create payload rows
    if ( pMode == PayloadMode::SEPARATEPAYLOAD ) {
      if ( obj->payloadId() != 0 )
        // we reinsert an existing payload with different IOV
        currentRow->setPayloadId( obj->payloadId() );
      else {
        // this is a new payload, which has to be stored, allocate new payload id
        currentRow->setPayloadId( pIdOffset + object_index );
        // safe payload id in obj, to prevent this payload to get stored again
        obj->setPayloadId( pIdOffset + object_index );

        RelationalPayloadTableRowPtr pRow( new RelationalPayloadTableRow( obj,
                                                                          pMode ) );
        pRow->setPayloadId( pIdOffset + object_index );
        payloadRows.push_back( pRow );

      }
    }
    else if ( pMode == PayloadMode::VECTORPAYLOAD ) {
      if ( obj->payloadSetId() != 0 )
      {
        // reinserting existing payload
        currentRow->setPayloadSetId( obj->payloadSetId() );
        currentRow->setPayloadNItems( obj->payloadSize() );
      }
      else
      {
        // new row with new payload, set payload set id to objectId()
        obj->setPayloadSetId( currentRow->objectId() );
        currentRow->setPayloadSetId( currentRow->objectId() );

        IRecordIterator &it=obj->payloadIterator();
        int i=0;
        while ( it.goToNext() )
        {
          RelationalPayloadTableRowPtr pRow( new RelationalPayloadTableRow( it.currentRef(),
                                                                            pMode ) );

          pRow->setPayloadSetId( currentRow->objectId() );
          pRow->setPayloadItemId( i );
          payloadRows.push_back( pRow );
          i++;
        }
        obj->setPayloadNItems( i );
        currentRow->setPayloadNItems( i );
        if ( i == 0 )
        {
          // special case zero payload rows:
          // add dummy payload row, to avoid the need of an outer join
          RelationalPayloadTableRowPtr pRow( new RelationalPayloadTableRow( obj,
                                                                            pMode ) );
          pRow->setPayloadSetId( currentRow->objectId() );
          pRow->setPayloadItemId( 0 );
          payloadRows.push_back( pRow );
        };
      }
    };

    idToIndex[ currentRow->objectId() ] = rows.size();
    rows.push_back( currentRow );

    SimpleObject currentObject( currentRow->objectId(),
                                currentRow->channelId(),
                                currentRow->since(),
                                currentRow->until() );

    // Check which objects in the head are affected
    std::vector<SimpleObject> affectedObjs = currentObject.intersect( head );

    if ( partiallyLocked && affectedObjs.size()!=0)
      throw  TagIsLocked
        ( "Cannot store objects with user tag: "
          "tag is partially locked "
          "and there are overlapping IOVs in bulk insert",
          "RelationalObjectMgr" );

    // Add the current object to the head and, if it 'falls through' the
    // current head, i.e. does not intersect with it, also to the bottom
    head.push_back( currentObject );
    if ( affectedObjs.empty() ) bottom.push_back( currentObject );

    for ( std::vector<SimpleObject>::const_iterator
            headObj = affectedObjs.begin();
          headObj != affectedObjs.end();
          ++headObj ) {

      unsigned int headObjIndex = idToIndex[ headObj->objectId ];

      // Update the newHeadId of the intersected head object and remove
      // it from the head
      rows[headObjIndex]->setNewHeadId( currentObject.objectId );
      head.erase( remove( head.begin(), head.end(), *headObj ) );

      // Cut the examined headObj with the currentObject. Create system
      // objects from the intervals (one or two), set their originalId
      // and add them to the head and the rows.
      SOVector topVisibleIntervals = currentObject.filter( *headObj );
      for ( SOIterator interval = topVisibleIntervals.begin();
            interval != topVisibleIntervals.end();
            ++interval ) {
        // assign the object id in a fixed order:
        // [ sysobj: id+1 ][ userobj: id ][ sysobj: id+2 ]
        unsigned int objectId = interval->since < currentObject.since
          ? currentObject.objectId +1
          : currentObject.objectId +2;
        idToIndex[ objectId ] = rows.size();
        log() << "Create system object: ["
              << interval->since << "," << interval->until << "]"
              << coral::MessageStream::endmsg;
        RelationalObjectTableRowPtr
          sysObjRow = createSystemObjectRow
          ( *rows[headObjIndex], objectId, interval->since, interval->until );
        sysObjRow->setNewHeadId( 0 );
        rows.push_back( sysObjRow );
        SimpleObject sysObj( sysObjRow->objectId(),
                             sysObjRow->channelId(),
                             sysObjRow->since(),
                             sysObjRow->until() );
        head.push_back( sysObj );
        // Sort the head to ensure a reproducible order of system objects,
        // such that the lower end system object always comes before the
        // upper end system object. One could perhaps avoid the sort and
        // bookkeep the indexes but sort is most likely not a performance
        // problem.
        sort( head.begin(), head.end(), lt_since() );
      }

      // Check which parts of the current object 'fall through' the current
      // bottom -- i.e. which parts are visible from below --
      // and add them to the head.
      SOVector visibleIntervals = currentObject.visibleThrough( bottom );
      bottom.insert
        ( bottom.end(), visibleIntervals.begin(), visibleIntervals.end() );

    } // for ( affectedObjs.begin() )

  } // for ( objects.begin()

  return bottom;
}

//-----------------------------------------------------------------------------

// Types used in mergeWithHead
struct sIOV
{
  ValidityKey since;
  ValidityKey until;
  unsigned int count;
};
typedef std::map<ValidityKey,RelationalObjectTableRow*> keyRowMap;

//-----------------------------------------------------------------------------

void RelationalObjectMgr::mergeWithHead
( RelationalFolder* folder,
  const std::vector<SimpleObject> splitters,
  std::vector<RelationalObjectTableRowPtr>& rows,
  std::map<unsigned int, unsigned int>& idToIndex,
  unsigned int userTagId,
  bool partiallyLocked ) const
{
  log() << "Merge with HEAD" << coral::MessageStream::endmsg;

  // The transient head is a list of head objects created from intersecting
  // the persistent head with the 'splitters' intervals
  SOVector transHead;
  RelationalObjectTable objectTable( queryMgr(), *folder );

  // load relevant objects of the persistent head into a map which
  // can be accessed by channel -> iov_since
  // there are now overlaps, so by this we can easily find the IOV
  // which corresponds to a point in time
  std::map<ChannelId, keyRowMap > channelIovRowMap;

  // owner of the row vectors!
  // they are automatically deleted when the method is finished
  boost::scoped_array< std::auto_ptr< std::vector<RelationalObjectTableRow> > >
    channelsPersHead( 0 );

  // find min and max IOV for each channel
  std::map<ChannelId, sIOV> channelIov;
  for ( SOIterator splitter = splitters.begin();
        splitter != splitters.end();
        ++splitter ) {
    std::map<ChannelId, sIOV>::iterator it=
      channelIov.find(splitter->channelId);

    if ( it == channelIov.end() ) {
      // channel doesn't exist
      struct sIOV iov;
      iov.since=splitter->since;
      iov.until=splitter->until;
      iov.count=1;
      channelIov[splitter->channelId]=iov;
    } else {
      if ( it->second.since > splitter->since )
        it->second.since = splitter->since;
      if ( it->second.until < splitter->until )
        it->second.until = splitter->until;
      ++it->second.count;
    }
  }

  // allocate array of auto_ptrs to vectors
  channelsPersHead.reset
    ( new std::auto_ptr< std::vector<RelationalObjectTableRow> >
      [ channelIov.size() ]() );

  // maximum number of rows that will be prefetched
  unsigned int maxRows=1000;
  if ( getenv("COOL_MVINSERTION_PREFETCH_MAXROWS") )
  {
    std::stringstream rowsEnv( getenv("COOL_MVINSERTION_PREFETCH_MAXROWS" ) );
    rowsEnv >> maxRows;
    if (rowsEnv.fail())
      log() << coral::Error << "setting MV insertion prefetch maxRows to '"
            <<  getenv("COOL_MVINSERTION_PREFETCH_MAXROWS" )
            <<"' failed. Current maxRows value: " << maxRows
            << coral::MessageStream::endmsg;
    else
      log() << coral::Info << "setting MV insertion prefetch maxRows to "
            << maxRows << coral::MessageStream::endmsg;
    log() << coral::Debug;
  }

  int idx=0;
  // load IOVs for all channels for which splitter exits
  for (std::map<ChannelId, sIOV>::iterator
         it = channelIov.begin();
       it != channelIov.end() && maxRows>0;
       ++it, ++idx ) {
    ChannelId cId=it->first;

    // don't prefetch channels with only one or less splitters
    if (it->second.count <= 1) {
      continue;
    }
    log() <<"loading persistent head for Channel " << cId
          << " ["<< it->second.since << ", "<< it->second.until
          << " [ splitter count "<< it->second.count
          << " maxRows "<< maxRows << coral::MessageStream::endmsg;

    // load IOVs which are in the current head
    // return 0 if more than maxRows rows would be loaded
    channelsPersHead[idx] = objectTable.fetchRowsBtTimesInHead
      ( it->second.since, it->second.until, cId, userTagId, maxRows );

    // if channel contained too many to be overwritten IOVs skip this channel
    if ( channelsPersHead[idx].get() == 0) {
      log() << coral::Info
            << "MV insertion maxRows limit reached. Not prefetching "
            << "more IOVs" << coral::MessageStream::endmsg;
      log() << coral::Debug;
      continue;
    }
    maxRows-=channelsPersHead[idx]->size();

    std::vector<RelationalObjectTableRow>&
      currChannelRows( *(channelsPersHead[idx]) );

    // fill map for channel with the rows
    keyRowMap& IovMap=channelIovRowMap[cId];
    for (std::vector<RelationalObjectTableRow>::iterator
           row=currChannelRows.begin(); row!=currChannelRows.end(); ++row)
    {
      IovMap[row->since()]=&(*row);
    }
  }

  // Vector to hold all splitters which require an update of the newHeadID
  // of the persistent head.
  SOVector newHeadUpdaters;

  log() << "Loop over splitters - begin" << coral::MessageStream::endmsg;
  for ( SOIterator splitter = splitters.begin();
        splitter != splitters.end();
        ++splitter ) {

    log() << "Process splitter [" << splitter->since
          << "," << splitter->until << "]" << coral::MessageStream::endmsg;
    // Find affected objects from intersecting the transient head with splitter
    SOVector affectedObjs = splitter->intersect( transHead );
    SOVector bottomVisibleIntervals = splitter->visibleThrough( transHead );

    if ( partiallyLocked && affectedObjs.size() !=0 )
      throw RelationalException
        ( "PANIC! Tag is partially locked and transHead is not empty!",
          "RelationalObjectMgr" );

    for ( SOIterator headObj = affectedObjs.begin();
          headObj != affectedObjs.end();
          ++headObj ) {
      unsigned int headObjIndex = idToIndex[ headObj->objectId ];

      // Update the newHeadId of the intersected head object and remove
      // it from the transient head
      rows[headObjIndex]->setNewHeadId( splitter->objectId );
      transHead.erase
        ( remove( transHead.begin(), transHead.end(), *headObj ) );

      // Cut the examined headObj with the splitter. Create system
      // objects from the intervals (one or two), set their originalId
      // and add them to the transient head and the rows.
      SOVector topVisibleIntervals = splitter->filter( *headObj );
      for ( SOIterator interval = topVisibleIntervals.begin();
            interval != topVisibleIntervals.end();
            ++interval ) {
        unsigned int objectId = interval->since < splitter->since
          ? splitter->objectId +1
          : splitter->objectId +2;
        idToIndex[ objectId ] = rows.size();
        log() << "Create system object (intersecting transient HEAD): ["
              << interval->since << "," << interval->until << "]"
              << coral::MessageStream::endmsg;
        RelationalObjectTableRowPtr
          sysObjRow = createSystemObjectRow
          ( *rows[headObjIndex], objectId, interval->since, interval->until );
        sysObjRow->setNewHeadId( 0 );
        rows.push_back( sysObjRow );
        SimpleObject sysObj( sysObjRow->objectId(),
                             sysObjRow->channelId(),
                             sysObjRow->since(),
                             sysObjRow->until() );
        transHead.push_back( sysObj );
        // Sort the head to ensure a reproducible order of system objects,
        // such that the lower end system object always comes before the
        // upper end system object.
        sort( transHead.begin(), transHead.end(), lt_since() );
      }

    } // for ( affectedObjs.begin() ... )

    // Now that the transient head has been examined we have to check
    // which parts of the splitter have not been 'absorbed' by it and
    // 'fall through' to the persistent head.
    //SOVector bottomVisibleIntervals = splitter->visibleThrough( transHead );

    for ( SOIterator interval = bottomVisibleIntervals.begin();
          interval != bottomVisibleIntervals.end();
          ++interval ) {
      bool sortHead = false;

      try { // Check if we need to create a system object at the lower end
        keyRowMap::iterator obj;
        bool prefetched=false;
        if ( channelIovRowMap.find(interval->channelId) !=
             channelIovRowMap.end() )
        {
          // we have prefetched IOVs for this channel
          prefetched=true;
          keyRowMap& IovMap=channelIovRowMap[interval->channelId];
          obj=IovMap.upper_bound(interval->since);
          // upper bound returns the next greater IOV, but we want the
          // IOV just bevore interval->since
          if ( obj != IovMap.begin()  )
            --obj;
          if ( obj == IovMap.end() )
            // no object at point interval->since
            throw ObjectNotFound("temporary","mergeWithHead");
        }
        RelationalObjectTableRow lowerEnd =
          prefetched ?
          *(obj->second) :
          objectTable.fetchRowAtTimeInHead( interval->since,
                                            interval->channelId,
                                            userTagId );
        ValidityKey sysObjSince = lowerEnd.since();
        ValidityKey sysObjUntil = interval->since;
        if ( lowerEnd.until()>interval->since &&
             lowerEnd.since()<interval->since &&
             sysObjUntil > sysObjSince // avoid 0 length IOVs
             ) {
          // will not be reached if no intersecting object
          if ( partiallyLocked )
            throw TagIsLocked
              ( "Cannot store objects with user tag: "
                "tag is partially locked and the IOVs are overlapping with "
                "tag head (IOV start)",
                "RelationalObjectMgr" );

          unsigned int objectId = interval->objectId +1;
          idToIndex[ objectId ] = rows.size();
          log() << "Create system object (intersecting persistent HEAD"
                << " at low end): [" << sysObjSince
                << "," << sysObjUntil << "]" << coral::MessageStream::endmsg;
          RelationalObjectTableRowPtr
            sysObjRow = createSystemObjectRow( lowerEnd, objectId,
                                               sysObjSince,
                                               sysObjUntil );
          sysObjRow->setNewHeadId( 0 );
          rows.push_back( sysObjRow );
          SimpleObject sysObj( sysObjRow->objectId(),
                               sysObjRow->channelId(),
                               sysObjRow->since(),
                               sysObjRow->until() );
          transHead.push_back( sysObj );
          sortHead = true;
        }


      } catch ( ObjectNotFound& /* ignored */ ) { }

      try { // Check if we need to create a system object at the upper end
        keyRowMap::iterator obj;
        bool prefetched=false;
        if ( channelIovRowMap.find(interval->channelId) !=
             channelIovRowMap.end() )
        {
          // we have prefetched IOVs for this channel
          prefetched=true;
          keyRowMap& IovMap=channelIovRowMap[interval->channelId];
          obj=IovMap.upper_bound(interval->until);
          // upper bound returns the next greater IOV, but we want the
          // IOV just bevore interval->since
          if ( obj != IovMap.begin()  )
            --obj;
          if ( obj == IovMap.end() )
            // channel map is empty
            throw ObjectNotFound("temporary","mergeWithHead");
        }
        RelationalObjectTableRow upperEnd =
          prefetched ?
          *(obj->second) :
          objectTable.fetchRowAtTimeInHead( interval->until,
                                            interval->channelId,
                                            userTagId );
        ValidityKey sysObjSince = interval->until;
        ValidityKey sysObjUntil = upperEnd.until();
        if (
            upperEnd.since()<interval->until &&
            upperEnd.until()>interval->until &&

            sysObjUntil > sysObjSince
            // avoid 0 length IOVs
            &&
            interval->until != upperEnd.since()
            // needed because
            // fetchObjectTableRowHead at pointInTime "interval->until"
            // will fetch an object that *starts* at "interval->until"
            // but we actually only want objects up to
            // "interval->until - epsilon"
            // Instead of using "interval->until -1" as point in time
            // (which would assume granularity of 1 in IOVs) we select at
            // "interval->until" and discard objects that start exactly at
            // "interval->until", i.e. [a,b[ = [a,b] - [b]
            )
        {

          // will not be reached if no intersecting object
          if ( partiallyLocked )
            throw TagIsLocked
              ( "Cannot store objects with user tag: "
                "tag is partially locked and the IOVs are overlapping with "
                "tag head (IOV end)",
                "RelationalObjectMgr" );

          unsigned int objectId = interval->objectId +2;
          idToIndex[ objectId ] = rows.size();
          log() << "Create system object (intersecting persistent HEAD"
                << " at high end): [" << sysObjSince
                << "," << sysObjUntil << "]" << coral::MessageStream::endmsg;
          RelationalObjectTableRowPtr
            sysObjRow = createSystemObjectRow( upperEnd,
                                               objectId,
                                               sysObjSince,
                                               sysObjUntil );
          sysObjRow->setNewHeadId( 0 );
          rows.push_back( sysObjRow );
          SimpleObject sysObj( sysObjRow->objectId(),
                               sysObjRow->channelId(),
                               sysObjRow->since(),
                               sysObjRow->until() );
          transHead.push_back( sysObj );
          sortHead = true;
        }
      } catch ( ObjectNotFound& /* ignored */ ) { }

      // See above why we sort
      if ( sortHead ) sort( transHead.begin(), transHead.end(), lt_since() );

      // Update the newHeadIds of all overlapped head rows
      keyRowMap::iterator obj;
      bool callUpdate=true;
      if ( channelIovRowMap.find(interval->channelId) !=
           channelIovRowMap.end() )
      {
        // we have prefetched IOVs for this channel
        keyRowMap& IovMap=channelIovRowMap[interval->channelId];
        obj=IovMap.upper_bound(interval->since);
        // upper bound returns the next greater IOV, but we want the
        // IOV just bevore interval->since
        if ( obj != IovMap.begin()  )
          --obj;
        while (obj!=IovMap.end() && obj->second->until()<=interval->since )
          ++obj;
        // check if in the prefetched row there is at least one
        // which is covered by this splitter
        if (obj==IovMap.end() || obj->second->since()>interval->until )
          callUpdate=false;
      }
      if ( callUpdate )
        newHeadUpdaters.insert(newHeadUpdaters.end(),*interval);
    } // for ( bottomVisibleIntervals.begin() ... )

  } // for ( splitters.begin() ... )
  if ( newHeadUpdaters.size()>0 )
  {
    bool updated = bulkUpdateObjectTableNewHeadId( folder->objectTableName(),
                                                   folder->channelTableName(),
                                                   newHeadUpdaters,
                                                   userTagId );
    if ( partiallyLocked && updated )
    {
      // Inserted IOV covers existing ivos
      //std::cout << "ERROR: tag is partially locked and "
      //          << updated << " IOVS need to be updated" << std::endl;
      throw TagIsLocked
        ( "Cannot store objects with user tag: "
          "tag is partially locked and the IOVs are overlapping "
          "with tag head (covering existing IOV)",
          "RelationalObjectMgr" );
    }
  }
  log() << "Loop over splitters - end" << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

RelationalObjectTableRowPtr
RelationalObjectMgr::createSystemObjectRow
( const RelationalObjectTableRow& origRow,
  unsigned int objectId,
  const ValidityKey& since,
  const ValidityKey& until ) const
{
  RelationalObjectTableRowPtr row( new RelationalObjectTableRow( origRow ) );

  // Update some fields
  row->setObjectId( objectId );
  row->setSince( since);
  row->setUntil( until );
  row->setOriginalId( origRow.objectId() );

  return row;
}

//-----------------------------------------------------------------------------
