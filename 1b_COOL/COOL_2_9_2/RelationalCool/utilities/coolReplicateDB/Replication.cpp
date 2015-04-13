// $Id: Replication.cpp,v 1.64 2012-07-02 16:49:40 avalassi Exp $

// Include files
#include <iostream>
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"
#include "CoralBase/AttributeListException.h"
#include "CoolKernel/Exception.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/InternalErrorException.h"
#include "CoolKernel/Record.h"
#include "RelationalAccess/IBulkOperation.h"
#include "RelationalAccess/IConnectionServiceConfiguration.h"
#include "RelationalAccess/IColumn.h"
#include "RelationalAccess/IQuery.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ISessionProxy.h"
#include "RelationalAccess/ITable.h"
#include "RelationalAccess/ITableDataEditor.h"
#include "RelationalAccess/ITableDescription.h"
#include "RelationalAccess/TableDescription.h"
#include "RelationalAccess/ITransaction.h"

// Local include files
#include "Replication.h"
#include "../../src/IRelationalBulkOperation.h"
#include "../../src/RalDatabase.h"
#include "../../src/RalQueryMgr.h"
#include "../../src/RelationalChannelTable.h"
#include "../../src/RelationalDatabaseTable.h"
#include "../../src/RelationalFolder.h"
#include "../../src/RelationalGlobalTagTable.h"
#include "../../src/RelationalNodeMgr.h"
#include "../../src/RelationalNodeTable.h"
#include "../../src/RelationalObject2TagTable.h"
#include "../../src/RelationalObjectMgr.h"
#include "../../src/RelationalObjectTable.h"
#include "../../src/RelationalObjectTableRow.h"
#include "../../src/RelationalPayloadTable.h"
#include "../../src/RelationalQueryDefinition.h"
#include "../../src/RelationalQueryMgr.h"
#include "../../src/RelationalSequence.h"
#include "../../src/RelationalSequenceMgr.h"
#include "../../src/RelationalSchemaMgr.h"
#include "../../src/RelationalTag2TagTable.h"
#include "../../src/RelationalTagTable.h"
#include "../../src/RelationalTransaction.h"
#include "../../src/TransRalDatabase.h"
#include "../../src/sleep.h"

using namespace cool;

// Message output
#define LOG std::cout

// Local type definitions
typedef boost::shared_ptr<RelationalSequence> RelationalSequencePtr;

//---------------------------------------------------------------------------

Replication::Replication()
  : CoralApplication()
  , m_sourceDb()
  , m_targetDb()
  , m_sourceRalDb( 0 )
  , m_targetRalDb( 0 )
  , m_cursor()
{
  // Disable CORAL automatic pool clean up thread
  coral::IConnectionServiceConfiguration &connSvcConf =
    connectionSvc().configuration();
  // If we can access a LFC and the user is not explicitely forbidding it,
  // we try to use CORAL LFCReplicaService
  if ( ::getenv("COOL_IGNORE_LFC") == NULL &&
       ::getenv("LFC_HOST") != NULL ) {
    // use CORAL LFCReplicaService
    connSvcConf.setAuthenticationService("CORAL/Services/LFCReplicaService");
    connSvcConf.setLookupService("CORAL/Services/LFCReplicaService");
  }
  connSvcConf.disablePoolAutomaticCleanUp();
  connSvcConf.setConnectionTimeOut( 0 );
}

//---------------------------------------------------------------------------

std::vector<RelationalTableRow>
Replication::newNodeTableRows( const RalDatabase& db,
                               const std::string& lastUpdate )
{
  RecordSpecification whereDataSpec;
  whereDataSpec.extend
    ( "lastUpdate",
      RelationalNodeTable::columnTypeIds::nodeInsertionTime );
  Record whereData( whereDataSpec );
  whereData["lastUpdate"].setValue( lastUpdate );
  std::string whereClause =
    RelationalNodeTable::columnNames::nodeInsertionTime + " > :lastUpdate";
  std::string orderClause = RelationalNodeTable::columnNames::nodeId;
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( db.nodeTableName() );
  queryDef.addSelectItems( RelationalNodeTable::tableSpecification() );
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );
  queryDef.addOrderItem( orderClause );
  return db.queryMgr().fetchOrderedRows( queryDef );
}

//---------------------------------------------------------------------------

std::vector<RelationalTableRow>
Replication::modifiedNodeTableRows( const RalDatabase& db,
                                    const std::string& lastUpdate )
{
  RecordSpecification whereDataSpec;
  whereDataSpec.extend
    ( "lastUpdate",
      RelationalNodeTable::columnTypeIds::lastModDate );
  Record whereData( whereDataSpec );
  whereData["lastUpdate"].setValue( lastUpdate );
  std::string whereClause =
    RelationalNodeTable::columnNames::lastModDate + " > :lastUpdate"
    + " and "
    + RelationalNodeTable::columnNames::lastModDate + " > "
    + RelationalNodeTable::columnNames::nodeInsertionTime;
  std::string orderClause = RelationalNodeTable::columnNames::nodeId;
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( db.nodeTableName() );
  queryDef.addSelectItems( RelationalNodeTable::tableSpecification() );
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );
  queryDef.addOrderItem( orderClause );
  return db.queryMgr().fetchOrderedRows( queryDef );
}

//---------------------------------------------------------------------------

std::vector<RelationalTableRow>
Replication::fetchNodeTableRows( const RalDatabase& db, bool isLeaf )
{
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "isLeaf",
                        RelationalNodeTable::columnTypeIds::nodeIsLeaf );
  Record whereData( whereDataSpec );
  whereData["isLeaf"].setValue( isLeaf );
  std::string whereClause =
    RelationalNodeTable::columnNames::nodeIsLeaf + " = :isLeaf";
  std::string orderClause = RelationalNodeTable::columnNames::nodeId;
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( db.nodeTableName() );
  queryDef.addSelectItems( RelationalNodeTable::tableSpecification() );
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );
  queryDef.addOrderItem( orderClause );
  return db.queryMgr().fetchOrderedRows( queryDef );
}

//---------------------------------------------------------------------------

boost::shared_ptr<CursorHandle>
Replication::newObjectTableRows( const RalDatabase& db,
                                 const RelationalFolder& folder,
                                 const std::string& lastUpdate )
{
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "lastUpdate",
                        RelationalObjectTable::columnTypeIds::sysInsTime );
  Record whereData( whereDataSpec );
  whereData["lastUpdate"].setValue( lastUpdate );
  std::string whereClause =
    RelationalObjectTable::columnNames::sysInsTime() + " > :lastUpdate";
  std::string orderClause = RelationalObjectTable::columnNames::objectId();
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( folder.objectTableName() );
  queryDef.addSelectItems( RelationalObjectTable::tableSpecification
                           ( folder.payloadSpecification(),
                             folder.payloadMode() ) );
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );
  queryDef.addOrderItem( orderClause );
  std::auto_ptr<RalQueryMgr> queryMgr( new RalQueryMgr( *db.sessionMgr() ) );
  boost::shared_ptr<coral::AttributeList> dataBuffer;
  std::auto_ptr<coral::IQuery>
    query( queryMgr->prepareQuery( queryDef, dataBuffer ) );
  return boost::shared_ptr<CursorHandle>
    ( new CursorHandle( query, dataBuffer ) );
}

//---------------------------------------------------------------------------

boost::shared_ptr<CursorHandle>
Replication::newPayloadTableRows( const RalDatabase& db,
                                  const RelationalFolder& folder,
                                  const std::string& lastUpdate )
{
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "lastUpdate",
                        RelationalPayloadTable::columnTypeIds::p_sysInsTime );
  Record whereData( whereDataSpec );
  whereData["lastUpdate"].setValue( lastUpdate );
  std::string whereClause =
    RelationalPayloadTable::columnNames::p_sysInsTime() + " > :lastUpdate";
  std::string orderClause =
    folder.payloadMode() == PayloadMode::SEPARATEPAYLOAD  ?
    RelationalPayloadTable::columnNames::payloadId() :
    RelationalPayloadTable::columnNames::payloadSetId();
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( folder.payloadTableName() );
  queryDef.addSelectItems( RelationalPayloadTable::tableSpecification
                           ( folder.payloadSpecification(), folder.payloadMode() ) );
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );
  queryDef.addOrderItem( orderClause );
  std::auto_ptr<RalQueryMgr> queryMgr( new RalQueryMgr( *db.sessionMgr() ) );
  boost::shared_ptr<coral::AttributeList> dataBuffer;
  std::auto_ptr<coral::IQuery>
    query( queryMgr->prepareQuery( queryDef, dataBuffer ) );
  return boost::shared_ptr<CursorHandle>
    ( new CursorHandle( query, dataBuffer ) );
}

//---------------------------------------------------------------------------

boost::shared_ptr<CursorHandle>
Replication::modifiedObjectTableRows( const RalDatabase& db,
                                      const RelationalFolder& folder,
                                      const std::string& lastUpdate )
{
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "lastUpdate",
                        RelationalObjectTable::columnTypeIds::lastModDate );
  Record whereData( whereDataSpec );
  whereData["lastUpdate"].setValue( lastUpdate );
  std::string whereClause =
    RelationalObjectTable::columnNames::lastModDate() + " > :lastUpdate"
    + " and "
    + RelationalObjectTable::columnNames::lastModDate() + " > "
    + RelationalObjectTable::columnNames::sysInsTime();
  std::string orderClause = RelationalObjectTable::columnNames::objectId();
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( folder.objectTableName() );
  queryDef.addSelectItems( RelationalObjectTable::tableSpecification
                           ( folder.payloadSpecification(),
                             folder.payloadMode() ) );
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );
  queryDef.addOrderItem( orderClause );
  std::auto_ptr<RalQueryMgr> queryMgr( new RalQueryMgr( *db.sessionMgr() ) );
  boost::shared_ptr<coral::AttributeList> dataBuffer;
  std::auto_ptr<coral::IQuery>
    query( queryMgr->prepareQuery( queryDef, dataBuffer ) );
  return boost::shared_ptr<CursorHandle>
    ( new CursorHandle( query, dataBuffer ) );
}

//---------------------------------------------------------------------------

std::vector<RelationalTableRow>
Replication::localTagTableRows( const RalDatabase& db,
                                const RelationalFolder& folder )
{
  std::string orderClause = RelationalTagTable::columnNames::tagId;
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( folder.tagTableName() );
  queryDef.addSelectItems( RelationalTagTable::tableSpecification() );
  queryDef.addOrderItem( orderClause );
  return db.queryMgr().fetchOrderedRows( queryDef ); // no WHERE clause
}

//---------------------------------------------------------------------------

std::vector<RelationalTableRow>
Replication::object2TagTableRows( const RalDatabase& db,
                                  const RelationalFolder& folder )
{
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( folder.object2TagTableName() );
  queryDef.addSelectItems( RelationalObject2TagTable::tableSpecification( folder.payloadMode() ) );
  return db.queryMgr().fetchOrderedRows( queryDef ); // no WHERE/ORDER clause
}

//---------------------------------------------------------------------------

std::vector<RelationalTableRow>
Replication::globalTagTableRows( const RalDatabase& db )
{
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( db.globalTagTableName() );
  queryDef.addSelectItems( RelationalGlobalTagTable::tableSpecification() );
  return db.queryMgr().fetchOrderedRows( queryDef ); // no WHERE/ORDER clause
}

//---------------------------------------------------------------------------

std::vector<RelationalTableRow>
Replication::tag2TagTableRows( const RalDatabase& db )
{
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( db.tag2TagTableName() );
  queryDef.addSelectItems( RelationalTag2TagTable::tableSpecification() );
  return db.queryMgr().fetchOrderedRows( queryDef ); // no WHERE/ORDER clause
}

//---------------------------------------------------------------------------

std::vector<RelationalTableRow>
Replication::channelTableRows( const RalDatabase& db,
                               const RelationalFolder& folder )
{
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( folder.channelTableName() );
  queryDef.addSelectItems( RelationalChannelTable::tableSpecification() );
  return db.queryMgr().fetchOrderedRows( queryDef ); // no WHERE/ORDER clause
}

//---------------------------------------------------------------------------

unsigned int
Replication::bulkInsert( const RalDatabase& db,
                         const std::string& tableName,
                         boost::shared_ptr<CursorHandle>& cursorHandle )
{
  if ( ! cursorHandle->cursor().next() ) return 0;
  coral::ITable&
    objectTable = db.session().nominalSchema().tableHandle( tableName );
  coral::AttributeList data( cursorHandle->cursor().currentRow() );
  //coral::AttributeList data( rows[0].data() );
  int rowCacheSize = 100;
  std::auto_ptr<coral::IBulkOperation>
    bulkInserter( objectTable.dataEditor().bulkInsert( data, rowCacheSize ) );
  int rowCount = 0;
  do
  {
    data.fastCopyData( cursorHandle->cursor().currentRow() );
    bulkInserter->processNextIteration();
    ++rowCount;
  }
  while ( cursorHandle->cursor().next() );
  bulkInserter->flush();
  return rowCount;
}

//---------------------------------------------------------------------------

unsigned int
Replication::bulkInsert( const RalDatabase& db,
                         const std::string& tableName,
                         const std::vector<RelationalTableRow>& rows )
{
  if ( rows.empty() ) return 0;
  coral::ITable&
    objectTable = db.session().nominalSchema().tableHandle( tableName );
  coral::AttributeList data( rows[0].data() );
  int rowCacheSize = 100;
  std::auto_ptr<coral::IBulkOperation>
    bulkInserter( objectTable.dataEditor().bulkInsert( data, rowCacheSize ) );
  for ( std::vector<RelationalTableRow>::const_iterator
          row = rows.begin(); row != rows.end(); ++row )
  {
    data.fastCopyData( row->data() );
    bulkInserter->processNextIteration();
  }
  bulkInserter->flush();
  return rows.size();
}

//---------------------------------------------------------------------------

void
Replication::bulkUpdateObjectTableRows
( const RalDatabase& db,
  const std::string& tableName,
  boost::shared_ptr<CursorHandle>& cursorHandle )
{
  if ( ! cursorHandle->cursor().next() ) return;
  coral::AttributeList updateData( cursorHandle->cursor().currentRow() );
  std::string setClause = "";
  bool first = true;
  for ( coral::AttributeList::const_iterator
          i = updateData.begin(); i != updateData.end(); ++i )
  {
    if ( first )
    {
      first = false;
    }
    else
    {
      setClause += ", ";
    }
    setClause += i->specification().name() + " = :" +
      i->specification().name();
  }
  std::string whereClause = RelationalObjectTable::columnNames::objectId();
  whereClause += "= :" + RelationalObjectTable::columnNames::objectId();
  coral::ITable&
    objectTable = db.session().nominalSchema().tableHandle( tableName );
  int dataCacheSize = 100; // rows
  std::auto_ptr<coral::IBulkOperation>
    query( objectTable.dataEditor().bulkUpdateRows( setClause,
                                                    whereClause,
                                                    updateData,
                                                    dataCacheSize ) );
  do
  {
    updateData.fastCopyData( cursorHandle->cursor().currentRow() );
    query->processNextIteration();
  }
  while ( cursorHandle->cursor().next() );
  query->flush();
}

//---------------------------------------------------------------------------

void
Replication::bulkUpdateNodeTableDescriptions
( const RalDatabase& db,
  const std::vector<RelationalTableRow>& rows )
{
  if ( rows.empty() ) return;
  RecordSpecification updateDataSpec;
  updateDataSpec.extend( "description",
                         RelationalNodeTable::columnTypeIds::nodeDescription );
  updateDataSpec.extend( "nodeId",
                         RelationalNodeTable::columnTypeIds::nodeId );
  Record updateData( updateDataSpec );
  std::string setClause =
    RelationalNodeTable::columnNames::nodeDescription + " = :description";
  std::string whereClause =
    RelationalNodeTable::columnNames::nodeId + " = :nodeId";
  int dataCacheSize = 100; // rows
  boost::shared_ptr<IRelationalBulkOperation> query =
    db.queryMgr().bulkUpdateTableRows
    ( db.nodeTableName(), setClause, whereClause, updateData, dataCacheSize );
  for ( std::vector<RelationalTableRow>::const_iterator
          row = rows.begin(); row != rows.end(); ++row )
  {
    updateData["description"].setValue
      ( row->data()[RelationalNodeTable::columnNames::nodeDescription].
        data<std::string>() );
    updateData["nodeId"].setValue
      ( row->data()[RelationalNodeTable::columnNames::nodeId].
        data<unsigned int>() );
    query->processNextIteration();
  }
  query->flush();
}

//---------------------------------------------------------------------------

std::string Replication::serverTime( const RalDatabase& db )
{
  std::string serverTimeClause = db.queryMgr().serverTimeClause();
  std::string serverTimeAlias = "COOL_SERVER_TIME";
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( db.mainTableName() );
  queryDef.addSelectItem
    ( serverTimeClause, StorageType::String255, serverTimeAlias );
  const std::vector<RelationalTableRow> rows
    ( db.queryMgr().fetchOrderedRows( queryDef ) );
  return rows[0][serverTimeAlias].data<std::string>();
}

//---------------------------------------------------------------------------

void Replication::updateLastReplication( const RalDatabase& db,
                                         const std::string& lastReplication )
{
  LOG << "Setting time of replication in target" << std::endl;
  RecordSpecification updateDataSpec;
  updateDataSpec.extend
    ( "lastReplication",
      RelationalDatabaseTable::columnTypeIds::attributeValue );
  Record updateData( updateDataSpec );
  updateData["lastReplication"].setValue( lastReplication );
  std::string setClause =
    RelationalDatabaseTable::columnNames::attributeValue;
  setClause += "= :lastReplication";
  std::string whereClause =
    RelationalDatabaseTable::columnNames::attributeName
    + " = '" + RelationalDatabaseTable::attributeNames::lastReplication + "'";
  // Execute the update
  UInt32 updatedRows = db.queryMgr().updateTableRows
    ( db.mainTableName(), setClause, whereClause, updateData );
  if ( updatedRows == 0 )
  {
    // it's a new attribute
    Record data( RelationalDatabaseTable::tableSpecification() );
    data[RelationalDatabaseTable::columnNames::attributeName].setValue
      ( RelationalDatabaseTable::attributeNames::lastReplication );
    data[RelationalDatabaseTable::columnNames::attributeValue].setValue
      ( lastReplication );
    db.queryMgr().insertTableRow( db.mainTableName(), data );
  }
  else if ( updatedRows != 1 )
  {
    throw Exception
      ( "Could not update a row of the main table", "Replication" );
  }
}

//---------------------------------------------------------------------------

void Replication::updateLastReplicationSource( const RalDatabase& db,
                                               const std::string& sourceUrl )
{
  LOG << "Setting replication source in target" << std::endl;
  RecordSpecification updateDataSpec;
  updateDataSpec.extend
    ( "sourceUrl",
      RelationalDatabaseTable::columnTypeIds::attributeValue );
  Record updateData( updateDataSpec );
  updateData["sourceUrl"].setValue( sourceUrl );
  std::string setClause =
    RelationalDatabaseTable::columnNames::attributeValue;
  setClause += "= :sourceUrl";
  std::string whereClause =
    RelationalDatabaseTable::columnNames::attributeName
    + " = '"
    + RelationalDatabaseTable::attributeNames::lastReplicationSource + "'";
  // Execute the update
  UInt32 updatedRows = db.queryMgr().updateTableRows
    ( db.mainTableName(), setClause, whereClause, updateData );
  if ( updatedRows == 0 )
  {
    // it's a new attribute
    Record data( RelationalDatabaseTable::tableSpecification() );
    data[RelationalDatabaseTable::columnNames::attributeName].setValue
      ( RelationalDatabaseTable::attributeNames::lastReplicationSource );
    data[RelationalDatabaseTable::columnNames::attributeValue].setValue
      ( sourceUrl );
    db.queryMgr().insertTableRow( db.mainTableName(), data );
  }
  else if ( updatedRows != 1 )
  {
    throw Exception
      ( "Could not update a row of the main table", "Replication" );
  }
}

//---------------------------------------------------------------------------

void Replication::setSourceDb( const std::string& url )
{
  std::cout << "opening source: " << url << std::endl;
  try
  {
    bool readOnly = true;
    m_sourceDb = databaseService().openDatabase( url, readOnly );
  }
  catch ( Exception& e )
  {
    std::cerr << "Exception: " << e.what() << std::endl;
    std::cerr << "while opening " << url << std::endl;
    throw e;
  }
  if ( m_sourceDb.get() == 0 )
    throw Exception( "source db is null", "Replication" );
  TransRalDatabase* traldb = dynamic_cast<TransRalDatabase*>(m_sourceDb.get());
  if ( !traldb ) throw InternalErrorException( "Dynamic cast failed", "Replication" );  // Fix Coverity FORWARD_NULL
  m_sourceRalDb = traldb->getRalDb();
  if ( m_sourceRalDb == 0 ) throw Exception( "source db is null",
                                             "Replication" );
}

//---------------------------------------------------------------------------

void Replication::setTargetDb( const std::string& url )
{
  std::cout << "opening target: " << url << std::endl;
  try
  {
    bool readOnly = false;
    m_targetDb = databaseService().openDatabase( url, readOnly );
  }
  catch ( DatabaseDoesNotExist& )
  {
    m_targetDb = databaseService().createDatabase( url );
  }
  if ( m_targetDb.get() == 0 )
    throw Exception( "target db is null", "Replication" );
  TransRalDatabase* traldb = dynamic_cast<TransRalDatabase*>(m_targetDb.get());
  if ( !traldb ) throw InternalErrorException( "Dynamic cast failed", "Replication" );  // Fix Coverity FORWARD_NULL
  m_targetRalDb = traldb->getRalDb();
  if ( m_targetRalDb == 0 ) throw Exception( "target db is null",
                                             "Replication" );
}

//---------------------------------------------------------------------------

std::string Replication::getLastUpdate()
{
  std::string lastUpdate = "0000-00-00_00:00:00.000000000 GMT";
  coral::AttributeList targetDbAttributes =
    targetDb().databaseAttributes().attributeList();
  try
  {
    lastUpdate = targetDbAttributes
      [RelationalDatabaseTable::attributeNames::lastReplication]
      .data<std::string>();
  }
  catch ( coral::AttributeListException& ) {}
  return lastUpdate;
}

//---------------------------------------------------------------------------

bool Replication::checkSchemaCompliance( const RalDatabase& source,
                                         const RalDatabase& target )
{
  coral::AttributeList sourceDbAttributes =
    source.databaseAttributes().attributeList();
  coral::AttributeList targetDbAttributes =
    target.databaseAttributes().attributeList();
  return
    sourceDbAttributes[RelationalDatabaseTable::attributeNames::schemaVersion]
    ==
    targetDbAttributes[RelationalDatabaseTable::attributeNames::schemaVersion];
}

//---------------------------------------------------------------------------

void Replication::replicateNodeTable( const std::string& lastUpdate )
{
  LOG << "Replicating node table" << std::endl;
  // check for dropped nodes
  {
    // Fetch nodes in reverse order so that dropping nodes will start with the
    // deepest node.
    bool ascending = false;
    // Use node mgr directly to prevent opening of a new transaction.
    std::vector<std::string> sourceNodes =
      sourceDb().nodeMgr().listAllNodes( ascending );
    std::vector<std::string> targetNodes =
      targetDb().nodeMgr().listAllNodes( ascending );
    // Find dropped nodes
    for ( std::vector<std::string>::const_iterator
            n = targetNodes.begin(); n != targetNodes.end(); ++n )
    {
      if ( find( sourceNodes.begin(), sourceNodes.end(), *n )
           == sourceNodes.end() )
      {
        // Node does not exist in source -- drop it
        targetDb().dropNode( *n );
      }
    }
  }
  std::vector<RelationalTableRow> rows =
    newNodeTableRows( sourceDb(), lastUpdate );
  std::string nodeSeqName =
    RelationalNodeTable::sequenceName( targetDb().nodeTableName() );
  RelationalSequencePtr nodeSeq
    ( targetDb().queryMgr().sequenceMgr().getSequence( nodeSeqName ) );
  unsigned int previousNodeId = nodeSeq->currVal();
  for ( std::vector<RelationalTableRow>::const_iterator
          i = rows.begin(); i != rows.end(); ++i )
  {
    unsigned int nodeId =
      i->data()[RelationalNodeTable::columnNames::nodeId]
      .data<unsigned int>();
    bool nodeIsLeaf =
      i->data()[RelationalNodeTable::columnNames::nodeIsLeaf]
      .data<bool>();
    std::string nodeFullPath =
      i->data()[RelationalNodeTable::columnNames::nodeFullPath]
      .data<std::string>();
    std::string nodeDescription =
      i->data()[RelationalNodeTable::columnNames::nodeDescription]
      .data<std::string>();
    std::string folderPayloadSpecDesc =
      i->data()[RelationalNodeTable::columnNames::folderPayloadSpecDesc]
      .data<std::string>();
    FolderVersioning::Mode folderVersioningMode =
      FolderVersioning::Mode
      ( i->data()[RelationalNodeTable::columnNames::folderVersioningMode]
        .data<int>() );
    PayloadMode::Mode payloadMode = RelationalFolder::payloadMode( i->data() );
    // Skip the root folder set if present, because even if it shows up
    // in the selection (when a db has never been replicated) it will already
    // exists on the target after database bootstrapping. In other words
    // it then is already replicated through bootstrapping.
    if ( nodeFullPath == "/" ) continue;
    // fix for bug #30578
    unsigned int gap = nodeId - previousNodeId;
    // start counting from 1, because a gap of 1 is expected -- we only
    // want to increment the node sequence for gaps larger than one
    for ( unsigned int ii = 1; ii < gap; ++ii )
    {
      nodeSeq->nextVal();
    }
    previousNodeId = nodeId;
    // Check if the node exists on the target. If so, it was dropped and
    // recreated in the meantime. Therefore we drop and recreate it as well.
    if ( targetDb().nodeMgr().existsNode( nodeFullPath ) )
      targetDb().dropNode( nodeFullPath );
    bool createParents = false;
    LOG << "\tReplicating " << nodeFullPath << " ... ";
    if ( nodeIsLeaf )
    {
      RecordSpecification spec =
        RelationalDatabase::decodeRecordSpecification
        ( folderPayloadSpecDesc );
      targetDb().createFolder( nodeFullPath,
                               spec,
                               nodeDescription,
                               folderVersioningMode,
                               createParents,
                               payloadMode );
    }
    else
    {
      targetDb().createFolderSet( nodeFullPath,
                                  nodeDescription,
                                  createParents );
    }
    LOG << "done" << std::endl;
  }
  // update modified node descriptions
  {
    std::vector<RelationalTableRow> rowsNew =
      modifiedNodeTableRows( sourceDb(), lastUpdate );
    bulkUpdateNodeTableDescriptions( targetDb(), rowsNew );
  }
  // identify renamed/extended payload specifications
  updatePayloadSpecifications();
}

//---------------------------------------------------------------------------

void Replication::updatePayloadSpecifications()
{
  bool isLeaf = true;
  std::vector<RelationalTableRow> sourceNodes
    = fetchNodeTableRows( sourceDb(), isLeaf );
  std::vector<RelationalTableRow> targetNodes
    = fetchNodeTableRows( targetDb(), isLeaf );
  if ( ! sourceNodes.size() == targetNodes.size() )
  {
    throw Exception( "Unexpected size mismatch between source and target "
                     "node counts.", "Replication" );
  }
  std::vector<RelationalTableRow>::const_iterator s, t;
  for ( s = sourceNodes.begin(), t = targetNodes.begin();
        s != sourceNodes.end();
        ++s, ++t )
  {
    std::string sourceFullPath =
      s->data()[RelationalNodeTable::columnNames::nodeFullPath]
      .data<std::string>();
    std::string targetFullPath =
      t->data()[RelationalNodeTable::columnNames::nodeFullPath]
      .data<std::string>();
    if ( sourceFullPath != targetFullPath )
    {
      throw Exception( "Unexpected node path mismatch between source "
                       "and target.", "Replication" );
    }
    // Get the folders and specs of source and target
    IFolderPtr sourceFolder = sourceDb().getFolder( sourceFullPath );
    IFolderPtr targetFolder = targetDb().getFolder( targetFullPath );
    const IRecordSpecification&
      sourceSpec = sourceFolder->payloadSpecification();
    const IRecordSpecification&
      targetSpec = targetFolder->payloadSpecification();
    if ( sourceSpec != targetSpec )
    {
      // Obtain a RelationalFolder pointer to call the interal API
      RelationalFolder* relTargetFolder = dynamic_cast<RelationalFolder*>(targetFolder.get());
      if ( !relTargetFolder ) throw InternalErrorException( "Dynamic cast failed", "Replication" );  // Fix Coverity FORWARD_NULL
      // The source spec is at least as long as the target spec. We check the
      // fields up to the target's size for name changes. Any extra fields in
      // the source must be additional fields which we add.
      UInt32 index = 0;
      for ( ; index < targetSpec.size(); ++index )
      {
        if ( sourceSpec[index].name() != targetSpec[index].name() )
        {
          relTargetFolder->renamePayload( targetSpec[index].name(),
                                          sourceSpec[index].name() );
        }
      }
      // We continue to use 'index' to loop over the potential extra fields
      // in sourceSpec
      for ( ; index < sourceSpec.size(); ++index )
      {
        // Prepare the new specification
        // (we need to get the target spec from the folder each time,
        // because it changes as we loop)
        RecordSpecification newRecordSpecification;
        newRecordSpecification.extend( sourceSpec[index] );
        Record newRecord( newRecordSpecification );
        relTargetFolder->extendPayloadSpecification( newRecord );
      }
    }
  }
}

//---------------------------------------------------------------------------

void Replication::replicateNodes( const std::string& lastUpdate )
{
  LOG << "Replicating nodes" << std::endl;
  replicateFolderSets( lastUpdate );
  replicateFolders( lastUpdate );
}

//---------------------------------------------------------------------------

void Replication::replicateFolderSets( const std::string& /*lastUpdate*/ )
{
  //LOG << "Replicating folder sets" << std::endl;
  // only table is xxx_TAGS_SEQ which we don't replicate for the read-only
  // target
}

//---------------------------------------------------------------------------

void Replication::replicateFolders( const std::string& lastUpdate )
{
  LOG << "Replicating folders" << std::endl;
  bool isLeaf = true;
  std::vector<RelationalTableRow> nodes = fetchNodeTableRows( sourceDb(),
                                                              isLeaf );

  for ( std::vector<RelationalTableRow>::const_iterator
          n = nodes.begin(); n != nodes.end(); ++n )
  {
    RelationalFolder sourceFolder( sourceDb().relationalDbPtr(), n->data() );
    RelationalTableRow targetNode =
      targetDb().nodeMgr().fetchNodeTableRow( sourceFolder.fullPath() );
    RelationalFolder targetFolder( targetDb().relationalDbPtr(),
                                   targetNode.data() );
    LOG << "\tReplicating " << sourceFolder.fullPath() << " ... ";
    replicateFolder( sourceFolder, targetFolder, lastUpdate );
    LOG << " done" << std::endl;
  }
}

//---------------------------------------------------------------------------

void Replication::replicateFolder( const RelationalFolder& sourceFolder,
                                   const RelationalFolder& targetFolder,
                                   const std::string& lastUpdate )
{
  // replicate channels (drop the FK to the channel table,
  // delete all channels, recreate all channels, recreate the FK)
  {
    //bool debug = false; // printout for bug #54767
    //debug = ( targetFolder.objectTableName() == "COOLTGT_F0007_IOVS" );
    //if ( debug )
    //  std::cout << "\n*** coolReplicateDB dropObjectChannelFK "
    //            << targetFolder.objectTableName() << "..." << std::endl;
    targetDb().schemaMgr().dropObjectChannelFK
      ( targetFolder.objectTableName() );
    //if ( debug )
    //  std::cout << "*** coolReplicateDB dropObjectChannelFK "
    //            << targetFolder.objectTableName() << "... DONE" << std::endl;
    std::vector<RelationalTableRow> rows =
      channelTableRows( sourceDb(), sourceFolder );
    std::string whereClause = "";
    Record whereData;
    targetDb().queryMgr().deleteTableRows
      ( targetFolder.channelTableName(), whereClause, whereData );
    bulkInsert( targetDb(), targetFolder.channelTableName(), rows );
    //if ( debug )
    //  std::cout << "*** coolReplicateDB createObjectChannelFK "
    //            << targetFolder.objectTableName() << "..." << std::endl;
    targetDb().schemaMgr().createObjectChannelFK
      ( targetFolder.objectTableName(),
        targetFolder.channelTableName() );
    //if ( debug )
    //  std::cout << "*** coolReplicateDB createObjectChannelFK "
    //            << targetFolder.objectTableName() << "... DONE" << std::endl;
  }
  // replicate new payloads for separate payload folder
  if ( sourceFolder.payloadMode() == PayloadMode::SEPARATEPAYLOAD )
  {
    boost::shared_ptr<CursorHandle>
      cursorHandle = newPayloadTableRows( sourceDb(),
                                          sourceFolder,
                                          lastUpdate );
    bulkInsert( targetDb(), targetFolder.payloadTableName(), cursorHandle );
  }
  // update modified iovs
  {
    boost::shared_ptr<CursorHandle>
      cursorHandle = modifiedObjectTableRows( sourceDb(),
                                              sourceFolder,
                                              lastUpdate );
    bulkUpdateObjectTableRows( targetDb(),
                               targetFolder.objectTableName(),
                               cursorHandle );
  }
  // replicate new iovs
  {
    boost::shared_ptr<CursorHandle>
      cursorHandle = newObjectTableRows( sourceDb(),
                                         sourceFolder,
                                         lastUpdate );
    bulkInsert( targetDb(), targetFolder.objectTableName(), cursorHandle );
  }
  // replicate new payloads for vector payload folder
  if ( sourceFolder.payloadMode() == PayloadMode::VECTORPAYLOAD )
  {
    boost::shared_ptr<CursorHandle>
      cursorHandle = newPayloadTableRows( sourceDb(),
                                          sourceFolder,
                                          lastUpdate );
    bulkInsert( targetDb(), targetFolder.payloadTableName(), cursorHandle );
  }
  if ( sourceFolder.versioningMode() == FolderVersioning::MULTI_VERSION )
  {
    // clear target's tag related tables
    // (do object2tag first, because of integrity constraints)
    std::string whereClause = "";
    Record whereData;
    targetDb().queryMgr().deleteTableRows( targetFolder.object2TagTableName(),
                                           whereClause,
                                           whereData );
    targetDb().queryMgr().deleteTableRows( targetFolder.tagTableName(),
                                           whereClause,
                                           whereData );
    // replicate local tags
    {
      std::vector<RelationalTableRow> rows = localTagTableRows( sourceDb(),
                                                                sourceFolder );
      bulkInsert( targetDb(), targetFolder.tagTableName(), rows );
    }
    // replicate tag to iov relations
    {
      std::vector<RelationalTableRow> rows =
        object2TagTableRows( sourceDb(), sourceFolder );
      bulkInsert( targetDb(), targetFolder.object2TagTableName(), rows );
    }
  }
}

//---------------------------------------------------------------------------

void Replication::replicateTags()
{
  LOG << "Replicating tags" << std::endl;
  // remove integrity constraint on target tag2tag table
  targetDb().schemaMgr().dropTag2TagFKs( targetDb().tag2TagTableName() );
  // replicate global tag table
  {
    std::vector<RelationalTableRow> rows = globalTagTableRows( sourceDb() );
    std::string whereClause = "";
    Record whereData;
    targetDb().queryMgr().deleteTableRows( targetDb().globalTagTableName(),
                                           whereClause,
                                           whereData );
    bulkInsert( targetDb(), targetDb().globalTagTableName(), rows );
  }
  // reenable integrity constraint on target tag2tag table
  targetDb().schemaMgr().createTag2TagFKs( targetDb().tag2TagTableName(),
                                           targetDb().globalTagTableName() );
  // replicate tag to tag tabel
  {
    // delete all target rows
    std::string whereClause = "";
    Record whereData;
    targetDb().queryMgr().deleteTableRows( targetDb().tag2TagTableName(),
                                           whereClause,
                                           whereData );
    // fetch and insert source rows into target table
    std::vector<RelationalTableRow> rows = tag2TagTableRows( sourceDb() );
    bulkInsert( targetDb(), targetDb().tag2TagTableName(), rows );
  }
}

//---------------------------------------------------------------------------

int Replication::replicate( const std::string& sourceUrl,
                            const std::string& targetUrl )
{
  setSourceDb( sourceUrl );
  setTargetDb( targetUrl );
  if ( ! checkSchemaCompliance( sourceDb(), targetDb() ) )
  {
    throw Exception( "schemas are incompatible for replication",
                     "Replication" );
  }
  std::string lastUpdate = getLastUpdate();
  {
    bool readOnly = true;
    RelationalTransaction sourceTransaction( sourceDb().transactionMgr(),
                                             readOnly );
    readOnly = false;
    RelationalTransaction targetTransaction( targetDb().transactionMgr(),
                                             readOnly );
    std::string timeOfReplication = serverTime( sourceDb() );
    LOG << "Time of last update: " << lastUpdate << std::endl;
    LOG << "Time of replication: " << timeOfReplication << std::endl;
    // This timeout variable exists purely for concurrency testing purposes.
    // The intention is to allow the replciation transaction to start
    // and leave time for concurrent processes to access the database
    // before the actual replication starts in order to investigate how
    // the replication behaves under these circumstances.
    if ( getenv( "COOLREPLICATION_TIMEOUT" ) )
    {
      int timeout = atoi( getenv( "COOLREPLICATION_TIMEOUT" ) );
      cool::sleep( timeout );
    }
    replicateNodeTable( lastUpdate );
    replicateNodes( lastUpdate );
    replicateTags();
    updateLastReplication( targetDb(), timeOfReplication );
    updateLastReplicationSource( targetDb(), sourceUrl );
    sourceTransaction.commit();
    targetTransaction.commit();
  }
  LOG << "Done." << std::endl;
  return 0;
}

//---------------------------------------------------------------------------
