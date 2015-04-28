// First of all, enable or disable the COOL290 API extensions (bug #92204)
#include "CoolKernel/VersionInfo.h"

// Include files
#include <sstream>
#include "CoolKernel/ChannelSelection.h"
#include "HvsTagRecord.h"
#include "CoolKernel/Record.h"
#include "CoolKernel/ValidityKey.h"
#include "CoralBase/Exception.h"
#include "RelationalAccess/IBulkOperation.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ITable.h"
#include "RelationalAccess/ITableDataEditor.h"
#include "RelationalAccess/SchemaException.h"

// Local include files
#include "DummyTransactionMgr.h"
#include "HvsPathHandler.h"
#include "HvsPathHandlerException.h"
#include "ManualTransaction.h"
#include "ObjectId.h"
#include "RalDatabase.h"
#include "RalQueryMgr.h"
#include "RalSchemaMgr.h"
#include "RalSessionMgr.h"
#include "RalTransactionMgr.h"
#include "RelationalChannelTable.h"
#include "RelationalDatabaseId.h"
#include "RelationalDatabaseTable.h"
#include "RelationalException.h"
#include "RelationalFolder.h"
#include "RelationalFolderUnsupported.h"
#include "RelationalFolderSet.h"
#include "RelationalFolderSetUnsupported.h"
#include "RelationalNodeMgr.h"
#include "RelationalNodeTable.h"
#include "RelationalGlobalTagTable.h"
#include "RelationalObject.h"
#include "RelationalObjectMgr.h"
#include "RelationalObjectTable.h"
#include "RelationalObjectTableRow.h"
#include "RelationalObject2TagTable.h"
#include "RelationalPayloadTable.h"
#include "RelationalQueryDefinition.h"
#include "RelationalQueryMgr.h"
#include "RelationalSequence.h"
#include "RelationalSequenceMgr.h"
#include "RelationalTableRow.h"
#include "RelationalTagMgr.h"
#include "RelationalTagSequence.h"
#include "RelationalTagTable.h"
#include "RelationalTag2TagTable.h"
#include "SimpleObject.h"
#include "TimingReportMgr.h"
#include "TransRelFolder.h"
#include "VersionInfo.h"
#include "attributeListToString.h"
#include "sleep.h"
#include "timeToString.h"
#include "uppercaseString.h"

// Additional VersionInfo specific to RalDatabase.cpp
namespace cool
{
  namespace VersionInfo {
    const std::string cvsCheckout = "$Name: not supported by cvs2svn $";
    const std::string cvsCheckin = "$Id: RalDatabase.cpp,v 1.656 2012-07-08 20:02:33 avalassi Exp $";
  }
}

// Namespace
using namespace cool;

// Local type definitions
typedef boost::shared_ptr<RelationalSequence> RelationalSequencePtr;

//-----------------------------------------------------------------------------

RalDatabase::RalDatabase( CoralConnectionServiceProxyPtr ppConnSvc,
                          const DatabaseId& dbId,
                          bool readOnly )
  : RelationalDatabase( dbId )
  , m_useTimeout( true )
  , m_sessionMgr( new RalSessionMgr( ppConnSvc, dbId, readOnly ) )
{
  std::string ro = ( readOnly ? "R/O" : "R/W" );
  log() << coral::Info << "Instantiate a " << ro << " RalDatabase for '"
        << databaseId() << "'" << coral::MessageStream::endmsg;

  // Create a new relational query manager
  setQueryMgr( std::auto_ptr<RelationalQueryMgr>
               ( new RalQueryMgr( *sessionMgr() ) ) );

  // Create a new relational schema manager
  setSchemaMgr( std::auto_ptr<RelationalSchemaMgr>
                ( new RalSchemaMgr( *this, sessionMgr() ) ) );

  // Create a new relational node manager
  setNodeMgr( std::auto_ptr<RelationalNodeMgr>
              ( new RelationalNodeMgr( *this ) ) );

  // Create a new relational tag manager
  setTagMgr( std::auto_ptr<RelationalTagMgr>
             ( new RelationalTagMgr( *this ) ) );

  // Create a new object manager
  setObjectMgr( std::auto_ptr<RelationalObjectMgr>
                ( new RelationalObjectMgr( *this ) ) );

  // Create a new relational transaction manager
  // For read-only connections, a single R/O transaction is started by the
  // RalSessionMgr for the duration of the database connection (unless in
  // 'manytx mode): all other clients use a dummy transaction manager!
  //if ( !readOnly )
  if ( !readOnly || sessionMgr()->isReadOnlyManyTx() )
  {
    setTransactionMgr( boost::shared_ptr<IRelationalTransactionMgr>
                       ( new RalTransactionMgr( sessionMgr() ) ) );
  }
  else
  {
    setTransactionMgr( boost::shared_ptr<IRelationalTransactionMgr>
                       ( new DummyTransactionMgr() ) );
  }

  // Initialize timing reports
  if ( TimingReport::enabled() )
  {
    TimingReportMgr::initialize();
    TimingReportMgr::startTimer( "TOTAL [cool::RalDatabase]" );
  }
}

//-----------------------------------------------------------------------------

RalDatabase::~RalDatabase()
{
  log() << coral::Info << "Delete the RalDatabase for '"
        << databaseId() << "'" << coral::MessageStream::endmsg;

  // Loop over all nodes in the node map
  for ( std::map<std::string,RelationalTableRow*>::const_iterator
          row = m_nodes.begin(); row != m_nodes.end(); ++row )
  {
    delete row->second;
  }

  // Finalize timing reports
  if ( TimingReportMgr::isActive() ) {
    TimingReportMgr::stopTimer( "TOTAL [cool::RalDatabase]" );
    TimingReportMgr::finalize();
  }
}

//-----------------------------------------------------------------------------

void RalDatabase::createDatabase( const IRecord& dbAttr )
{
  std::string dbName = databaseName();
  log() << "Create a new database with name " << dbName
        << coral::MessageStream::endmsg;

  // Check if the database attribute specification is valid
  if ( dbAttr.specification() != databaseAttributesSpecification() )
    throw RelationalException
      ( "Invalid database attributes specification", "RalDatabase" );
  m_dbAttr = dbAttr;

  // Add release and schema related attributes
  m_dbAttr[RelationalDatabaseTable::attributeNames::release].setValue
    <RelationalDatabaseTable::columnTypes::attributeValue>
    ( VersionInfo::release );
  m_dbAttr[RelationalDatabaseTable::attributeNames::cvsCheckout].setValue
    <RelationalDatabaseTable::columnTypes::attributeValue>
    ( VersionInfo::cvsCheckout );
  m_dbAttr[RelationalDatabaseTable::attributeNames::cvsCheckin].setValue
    <RelationalDatabaseTable::columnTypes::attributeValue>
    ( VersionInfo::cvsCheckin );
  m_dbAttr[RelationalDatabaseTable::attributeNames::schemaVersion].setValue
    <RelationalDatabaseTable::columnTypes::attributeValue>
    ( VersionInfo::schemaVersion );

  // TEMPORARY? AV 04.04.2005
  // FIXME: you should check here that the default prefix is not longer
  // than 8 characters and is already uppercase.
  // FIXME: you should check here that the table names are all uppercase
  // and not longer than the maximum allowed Oracle/MySQL limits.

  // Do NOT check that DB is open: it is not! (bug #87090)
  //checkDbOpenTransaction( "RalDatabase::refreshNode", cool::ReadWrite );

  // Check ONLY that RW transaction is active (is this needed/ok?)
  if ( !transactionMgr()->isActive() )
    throw RelationalException( "Transaction is not active",
                               "RalDatabase::refreshNode" );
  //if ( transactionMgr()->isReadOnly() )
  //  throw RelationalException( "Transaction is read only",
  //                             "RalDatabase::refreshNode" );

  // Get the name of the main management table, create it and fill it
  schemaMgr().createMainTable( mainTableName() );
  schemaMgr().fillMainTable( mainTableName(), m_dbAttr.attributeList() );

  /*
  // *** START *** 3.0.0 schema extensions (task #4307)
  // Get the name of the iovTables table and create it
  std::string iovTablesTableName =
    dbAttr[RelationalDatabaseTable::attributeNames::iovTablesTableName].
    data<std::string>();
  schemaMgr().createIovTablesTable( iovTablesTableName );

  // Get the name of the channelTables table and create it
  std::string channelTablesTableName =
    dbAttr[RelationalDatabaseTable::attributeNames::channelTablesTableName].
    data<std::string>();
  schemaMgr().createChannelTablesTable( channelTablesTableName );
  // **** END **** 3.0.0 schema extensions (task #4307)
  *///

  // Get the name of the node table and create it
  std::string nodeTableName =
    dbAttr[RelationalDatabaseTable::attributeNames::nodeTableName].
    data<std::string>();
  std::string defaultTablePrefix =
    dbAttr[RelationalDatabaseTable::attributeNames::defaultTablePrefix].
    data<std::string>();
  schemaMgr().createNodeTable( nodeTableName, defaultTablePrefix );

  // Get the name of the tag table and create it
  std::string tagTableName =
    dbAttr[RelationalDatabaseTable::attributeNames::tagTableName].
    data<std::string>();
  schemaMgr().createGlobalTagTable( tagTableName, nodeTableName );

  /*
  // *** START *** 3.0.0 schema extensions (task #4396)
  // Get the name of the head tag table and create it
  std::string headTagTableName =
    dbAttr[RelationalDatabaseTable::attributeNames::headTagTableName].
    data<std::string>();
  schemaMgr().createGlobalHeadTagTable( headTagTableName, tagTableName );

  // Get the name of the user tag table and create it
  std::string userTagTableName =
    dbAttr[RelationalDatabaseTable::attributeNames::userTagTableName].
    data<std::string>();
  schemaMgr().createGlobalUserTagTable( userTagTableName, tagTableName );
  // **** END **** 3.0.0 schema extensions (task #4396)
  *///

  // Get the name of the tag table and create it
  std::string tag2TagTableName =
    dbAttr[RelationalDatabaseTable::attributeNames::tag2TagTableName].
    data<std::string>();
  schemaMgr().createTag2TagTable
    ( tag2TagTableName, tagTableName, nodeTableName );

  // Get the name of the tag shared sequence and create it
  std::string tagSharedSequenceName =
    dbAttr[RelationalDatabaseTable::attributeNames::tagSharedSequenceName].
    data<std::string>();
  schemaMgr().createSharedSequence( tagSharedSequenceName, nodeTableName );

  // Get the name of the IOV shared sequence and create it
  std::string iovSharedSequenceName =
    dbAttr[RelationalDatabaseTable::attributeNames::iovSharedSequenceName].
    data<std::string>();
  schemaMgr().createSharedSequence( iovSharedSequenceName, nodeTableName );

  // The database is now open
  m_isOpen = true;

  // TEMPORARY? Sleep to work around the ORA-01466 problem (Oracle only)
  if ( m_sessionMgr->databaseTechnology() == "Oracle" && m_useTimeout ) {
    log() << "Sleep to work around the ORA-01466 problem"
          << coral::MessageStream::endmsg;
    cool::sleep(1);
  }

}

//-----------------------------------------------------------------------------

bool RalDatabase::dropDatabase()
{
  log() << coral::Info << "Drop database..." << coral::MessageStream::endmsg;

  // AV 2005-07-07
  // Return true if all database tables are dropped as expected.
  // Return false (without throwing any exception) if the database and
  // all associated tables do not exist any more on exit from this method,
  // but the database or some associated tables did not exist to start with.
  bool status = true;

  // Throw a RelationalException if the database or one of its tables
  // cannot be dropped (i.e. continues to exist on exit from this method).
  // Any exception is thrown as soon as the first problem appears:
  // the implementation is based on many individual transactions,
  // there is no attempt to go back to the last known state on failure
  // (also because technically difficult, Oracle DDL is auto-committed).

  // Check that DB is open and RW transaction is active (is this needed/ok?)
  checkDbOpenTransaction( "RalDatabase::refreshNode", cool::ReadWrite );

  // Enclose the implementation in a try-catch block anyway,
  // just to be able to print some debug messages on failures.
  try
  {

    // For each folder, drop IOV table and sequence and delete the folder row.
    // Also delete any tags associated to the folder from the global tag table
    // and from the tag2tag table (otherwise FK constraints may be violated)
    // Throw an Exception if the schema of one of the nodes in this database
    // is more recent than the schema version supported by the current release:
    // in this case make sure you do not drop ANY node (throw immediately)!
    if ( ! dropAllNodes() ) status = false;

    // Drop the IOV shared sequence
    {
      std::string tableName = iovSharedSequenceName();
      log() << coral::Debug << "Drop table " << tableName
            << coral::MessageStream::endmsg;
      if ( ! schemaMgr().dropTable( tableName ) ) status = false;
    }

    // Drop the tag shared sequence
    {
      std::string tableName = tagSharedSequenceName();
      log() << coral::Debug << "Drop table " << tableName
            << coral::MessageStream::endmsg;
      if ( ! schemaMgr().dropTable( tableName ) ) status = false;
    }

    // Drop the sequence associated to the tag2tag table
    {
      std::string seqName =
        RelationalTag2TagTable::sequenceName( tag2TagTableName() );
      log() << coral::Debug << "Drop sequence " << seqName
            << coral::MessageStream::endmsg;
      if ( ! queryMgr().sequenceMgr().existsSequence( seqName ) )
      {
        status = false;
      }
      else
      {
        queryMgr().sequenceMgr().dropSequence( seqName );
      }
    }

    // Drop the tag2tag table
    {
      std::string tableName = tag2TagTableName();
      log() << coral::Debug << "Drop table " << tableName
            << coral::MessageStream::endmsg;
      if ( ! schemaMgr().dropTable( tableName ) ) status = false;
    }

    /*
    // *** START *** 3.0.0 schema extensions (task #4396)
    // Drop the global user tag table
    {
      std::string tableName = globalUserTagTableName();
      log() << coral::Debug << "Drop table " << tableName
            << coral::MessageStream::endmsg;
      if ( ! schemaMgr().dropTable( tableName ) ) status = false;
    }

    // Drop the global head tag table
    {
      std::string tableName = globalHeadTagTableName();
      log() << coral::Debug << "Drop table " << tableName
            << coral::MessageStream::endmsg;
      if ( ! schemaMgr().dropTable( tableName ) ) status = false;
    }
    // **** END **** 3.0.0 schema extensions (task #4396)
    *///

    // Drop the global tag table
    {
      std::string tableName = globalTagTableName();
      log() << coral::Debug << "Drop table " << tableName
            << coral::MessageStream::endmsg;
      if ( ! schemaMgr().dropTable( tableName ) ) status = false;
    }

    // Drop the sequence associated to the node table
    {
      std::string seqName =
        RelationalNodeTable::sequenceName( nodeTableName() );
      log() << coral::Debug << "Drop sequence " << seqName
            << coral::MessageStream::endmsg;
      if ( ! queryMgr().sequenceMgr().existsSequence( seqName ) )
      {
        status = false;
      }
      else
      {
        queryMgr().sequenceMgr().dropSequence( seqName );
      }
    }

    // Drop the node table
    {
      std::string tableName = nodeTableName();
      log() << coral::Debug << "Drop table " << tableName
            << coral::MessageStream::endmsg;
      if ( ! schemaMgr().dropTable( tableName ) ) status = false;
    }

    /*
    // *** START *** 3.0.0 schema extensions (task #4307)
    // Drop the channelTables table
    {
      std::string tableName = channelTablesTableName();
      //log() << coral::Debug << "Drop table " << tableName
      //      << coral::MessageStream::endmsg;
      //if ( ! schemaMgr().dropTable( tableName ) ) status = false;
    }

    // Drop the iovTables table
    {
      std::string tableName = iovTablesTableName();
      //log() << coral::Debug << "Drop table " << tableName
      //      << coral::MessageStream::endmsg;
      //if ( ! schemaMgr().dropTable( tableName ) ) status = false;
    }
    // **** END **** 3.0.0 schema extensions (task #4307)
    *///

    // Drop the main table
    {
      std::string tableName = mainTableName();
      log() << coral::Debug << "Drop table " << tableName
            << coral::MessageStream::endmsg;
      if ( ! schemaMgr().dropTable( tableName ) ) status = false;
    }

  }
  catch ( std::exception& e )
  {
    log() << coral::Warning << "Exception caught in dropDatabase(): "
          << e.what() << coral::MessageStream::endmsg;
    throw;
  }

  // Success: the database does not exist anymore
  // Return status code 'false' if parts of it were missing already
  log() << coral::Info << "Drop database... DONE"
        << coral::MessageStream::endmsg;
  return status;
}

//-----------------------------------------------------------------------------

void RalDatabase::refreshDatabase( bool keepNodes )
{
  log() << coral::Info << "Refresh database"
        << ( keepNodes ? " (refresh nodes)" : " (drop nodes)" )
        << "..." << coral::MessageStream::endmsg;

  // Check that DB is open and RW transaction is active (is this needed/ok?)
  checkDbOpenTransaction( "RalDatabase::refreshNode", cool::ReadWrite );

  // Enclose the implementation in a try-catch block anyway,
  // just to be able to print some debug messages on failures.
  try
  {

    if ( !keepNodes )
      // For each node, drop IOV table and sequence and delete the node row.
      // Also delete any tags associated to the node from the global tag table
      // and from the tag2tag table (otherwise FK constraints may be violated)
      // Throw an Exception if the schema of any nodes in this database is
      // more recent than the schema version supported by the current release:
      // in this case make sure you do not drop ANY node (throw immediately)!
      dropAllNodes( true );  // keep the root node
    else
      refreshAllNodes();

    // Delete all rows from the IOV shared sequence
    {
      std::string tableName = iovSharedSequenceName();
      log() << coral::Debug << "Refresh table " << tableName
            << coral::MessageStream::endmsg;
      queryMgr().deleteAllTableRows( tableName );
      // No need to init() or nextVal(): see RalSchemaMgr::createSharedSequence
    }

    // Delete all rows from the tag shared sequence
    {
      std::string tableName = tagSharedSequenceName();
      log() << coral::Debug << "Refresh table " << tableName
            << coral::MessageStream::endmsg;
      queryMgr().deleteAllTableRows( tableName );
      // No need to init() or nextVal(): see RalSchemaMgr::createSharedSequence
    }

    // Delete all rows from the sequence associated to the tag2tag table
    {
      std::string seqName =
        RelationalTag2TagTable::sequenceName( tag2TagTableName() );
      log() << coral::Debug << "Refresh sequence " << seqName
            << coral::MessageStream::endmsg;
      queryMgr().deleteAllTableRows( seqName );
      queryMgr().sequenceMgr().initSequence( seqName );
      // No need to nextVal(): see RalSchemaMgr::createTag2TagTable
    }

    // Delete all rows from the tag2tag table
    {
      std::string tableName = tag2TagTableName();
      log() << coral::Debug << "Refresh table " << tableName
            << coral::MessageStream::endmsg;
      queryMgr().deleteAllTableRows( tableName );
    }

    /*
    // *** START *** 3.0.0 schema extensions (task #4396)
    // Delete all rows from the global user tag table
    {
      std::string tableName = globalUserTagTableName();
      log() << coral::Debug << "Refresh table " << tableName
            << coral::MessageStream::endmsg;
      queryMgr().deleteAllTableRows( tableName );
    }

    // Delete all rows from the global head tag table
    {
      std::string tableName = globalHeadTagTableName();
      log() << coral::Debug << "Refresh table " << tableName
            << coral::MessageStream::endmsg;
      queryMgr().deleteAllTableRows( tableName );
    }
    // **** END **** 3.0.0 schema extensions (task #4396)
    *///

    // Delete all rows from the global tag table
    {
      std::string tableName = globalTagTableName();
      log() << coral::Debug << "Refresh table " << tableName
            << coral::MessageStream::endmsg;
      queryMgr().deleteAllTableRows( tableName );
    }

    // Delete all rows from the sequence associated to the node table
    // (NB call nextVal: see RalSchemaMgr::createNodeTable)
    if ( !keepNodes )
    {
      std::string seqName =
        RelationalNodeTable::sequenceName( nodeTableName() );
      log() << coral::Debug << "Refresh sequence " << seqName
            << coral::MessageStream::endmsg;
      queryMgr().deleteAllTableRows( seqName );
      queryMgr().sequenceMgr().initSequence( seqName );
      queryMgr().sequenceMgr().getSequence( seqName )->nextVal(); // root node!
    }

    // Do nothing about the node table
    // (could delete all rows except root, but we already dropped all nodes)
    {
      std::string tableName = nodeTableName();
      log() << coral::Debug << "Refresh table " << tableName
            << coral::MessageStream::endmsg;
    }

    /*
    // *** START *** 3.0.0 schema extensions (task #4307)
    // Delete all rows from the channelTables table
    {
      std::string tableName = channelTablesTableName();
      //log() << coral::Debug << "Refresh table " << tableName
      //      << coral::MessageStream::endmsg;
      //queryMgr().deleteAllTableRows( tableName );
    }

    // Delete all rows from the iovTables table
    {
      std::string tableName = iovTablesTableName();
      //log() << coral::Debug << "Refresh table " << tableName
      //      << coral::MessageStream::endmsg;
      //queryMgr().deleteAllTableRows( tableName );
    }
    // **** END **** 3.0.0 schema extensions (task #4307)
    *///

    // Do nothing about the main table
    {
      std::string tableName = mainTableName();
      log() << coral::Debug << "Refresh table " << tableName
            << coral::MessageStream::endmsg;
    }

  }
  catch ( std::exception& e )
  {
    log() << coral::Warning << "Exception caught in refreshDatabase(): "
          << e.what() << coral::MessageStream::endmsg;
    throw;
  }

  // Success: the database has been refreshed
  log() << coral::Info << "Refresh database"
        << ( keepNodes ? " (refresh nodes)" : " (drop nodes)" )
        << "... DONE" << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalDatabase::refreshAllNodes()
{
  log() << coral::Info << "Refresh all nodes..."
        << coral::MessageStream::endmsg;

  // Listing the nodes in reverse order may be better
  std::vector<std::string> nodes( listAllNodes( false ) );
  std::vector<std::string>::const_iterator node;
  for ( node = nodes.begin(); node != nodes.end(); node++ )
    refreshNode( *node );

  // Success: the nodes have been been refreshed
  log() << coral::Info << "Refresh all nodes... DONE"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalDatabase::refreshNode( const std::string& fullPath )
{
  log() << coral::Debug << "Refresh node '" << fullPath << "' ..."
        << coral::MessageStream::endmsg;
  checkDbOpenTransaction("RalDatabase::refreshNode", cool::ReadWrite );

  // Fetch the row for this node
  RelationalTableRow nodeRow;
  try {
    nodeRow = fetchNodeTableRow( fullPath );
  } catch ( NodeTableRowNotFound& ) {
    // A node with this name does not exist: nothing to drop
    log() << coral::Error << "Node '" << fullPath
          << "' cannot be refreshed (node not found)"
          << coral::MessageStream::endmsg;
    throw;
  } catch ( coral::QueryException& e ) {
    // The query on the node table failed: for instance, the query may fail
    // with ORA-00904 if some columns are missing from the node table because
    // the process that created the database crashed or was killed while
    // altering the node table to change the SQL type of its columns
    log() << coral::Error << "The node table cannot be queried: '"
          << e.what() << coral::MessageStream::endmsg;
    throw;
  }
  bool isLeaf =
    nodeRow[RelationalNodeTable::columnNames::nodeIsLeaf].data<bool>();
  unsigned int nodeId =
    nodeRow[RelationalNodeTable::columnNames::nodeId].data<unsigned int>();

  // Check that the node schema version is supported by this software release
  VersionNumber schemaVersion =
    nodeRow[RelationalNodeTable::columnNames::nodeSchemaVersion]
    .data<std::string>();
  bool isSupported = true;
  if ( isLeaf ) {
    if ( !RelationalFolder::isSupportedSchemaVersion( schemaVersion ) )
      isSupported = false;
  }
  else {
    if ( !RelationalFolderSet::isSupportedSchemaVersion( schemaVersion ) )
      isSupported = false;
  }
  if ( VersionInfo::release < schemaVersion )
  {
    std::stringstream s;
    s << "Cannot refresh node:";
    if ( isLeaf ) s << " folder '";
    else s << " folder set '";
    s << fullPath << " has schema version " << schemaVersion
      << " that is newer than this software release "
      << VersionInfo::release;
    log() << coral::Warning << s.str() << coral::MessageStream::endmsg;
    throw RelationalException( s.str(), "RalDatabase" );
  }
  else if ( !isSupported )
  {
    std::stringstream s;
    s << "PANIC! Cannot refresh node:";
    if ( isLeaf ) s << " folder '";
    else s << " folder set '";
    s << fullPath
      << "' appears to have been created using UNKNOWN schema version "
      << schemaVersion
      << " that is older than (or as old as) the current software release "
      << VersionInfo::release;
    throw RelationalException( s.str(), "RalDatabase" );
  }

  // TRY block
  try
  {

    // Folder: refresh folder-specific tables and sequences
    if ( isLeaf )
    {
      std::string objectTableName =
        RelationalFolder::objectTableName( nodeRow.data() );
      std::string payloadTableName =
        RelationalFolder::payloadTableName( nodeRow.data() );
      std::string tagTableName =
        RelationalFolder::tagTableName( nodeRow.data() );
      std::string object2TagTableName =
        RelationalFolder::object2TagTableName( nodeRow.data() );
      FolderVersioning::Mode versioningMode =
        RelationalFolder::versioningMode( nodeRow.data() );
      std::string tagSequenceName = RelationalTagSequence::sequenceName
        ( defaultTablePrefix(), nodeId );
      std::string tableName;
      std::string seqName;
      // Refresh tables for MV folders
      if ( versioningMode == cool_FolderVersioning_Mode::MULTI_VERSION )
      {
        // Refresh iov2tag table first (it has FK constraints on other tables)
        tableName = object2TagTableName;
        log() << "Refresh table " << tableName << coral::MessageStream::endmsg;
        queryMgr().deleteAllTableRows( tableName );
        // Refresh local tag table
        tableName = tagTableName;
        log() << "Refresh table " << tableName << coral::MessageStream::endmsg;
        queryMgr().deleteAllTableRows( tableName );
        // Refresh local tag sequence
        // (NB call nextVal: see RalSchemaMgr::createTagSequence)
        seqName = tagSequenceName;
        log() << "Refresh sequence " << seqName
              << coral::MessageStream::endmsg;
        queryMgr().deleteAllTableRows( seqName );
        queryMgr().sequenceMgr().initSequence( seqName );
        queryMgr().sequenceMgr().getSequence( seqName )->nextVal();
      }
      // vector  payload table
      tableName = payloadTableName;
      if ( RelationalFolder::payloadMode( nodeRow.data() ) ==
           cool_PayloadMode_Mode::VECTORPAYLOAD )
      {
        log() << "Refresh table " << tableName << coral::MessageStream::endmsg;
        queryMgr().deleteAllTableRows( tableName );
        // Refresh payload sequence
        // (NB call nextVal: see RalSchemaMgr::createPayloadTable)
      };
      // Refresh iov table
      tableName = objectTableName;
      log() << "Refresh table " << tableName << coral::MessageStream::endmsg;
      queryMgr().deleteAllTableRows( tableName );
      // Refresh iov sequence
      // (NB call nextVal: see RalSchemaMgr::createObjectTable)
      seqName = RelationalObjectTable::sequenceName( objectTableName );
      log() << "Refresh sequence " << seqName << coral::MessageStream::endmsg;
      queryMgr().deleteAllTableRows( seqName );
      queryMgr().sequenceMgr().initSequence( seqName );
      queryMgr().sequenceMgr().getSequence( seqName )->nextVal();
      // Refresh payload table if it exists
      tableName = payloadTableName;
      if ( RelationalFolder::payloadMode( nodeRow.data() ) ==
           cool_PayloadMode_Mode::SEPARATEPAYLOAD )
      {
        log() << "Refresh table " << tableName << coral::MessageStream::endmsg;
        queryMgr().deleteAllTableRows( tableName );
        // Refresh payload sequence
        // (NB call nextVal: see RalSchemaMgr::createPayloadTable)
        seqName = RelationalPayloadTable::sequenceName( payloadTableName );
        log() << "Refresh sequence " << seqName
              << coral::MessageStream::endmsg;
        queryMgr().deleteAllTableRows( seqName );
        queryMgr().sequenceMgr().initSequence( seqName );
        queryMgr().sequenceMgr().getSequence( seqName )->nextVal();
      };
      // Refresh channel table last (it is referenced by FKs in the IOV table)
      tableName = RelationalChannelTable::defaultTableName
        ( defaultTablePrefix(), nodeId );
      log() << "Refresh table " << tableName << coral::MessageStream::endmsg;
      queryMgr().deleteAllTableRows( tableName );
    }

    // Folder set
    else
    {
      // Refresh local tag sequence
      // (NB call nextVal: see RalSchemaMgr::createTagSequence)
      std::string tagSequenceName = RelationalTagSequence::sequenceName
        ( defaultTablePrefix(), nodeId );
      std::string seqName = tagSequenceName;
      log() << "Refresh sequence " << seqName << coral::MessageStream::endmsg;
      queryMgr().deleteAllTableRows( seqName );
      queryMgr().sequenceMgr().initSequence( seqName );
      queryMgr().sequenceMgr().getSequence( seqName )->nextVal();
    }
  }

  // CATCH block
  catch ( std::exception& e )
  {
    log() << coral::Fatal << "Exception caught in refreshNode(): '"
          << e.what() << "'" << std::endl;
  }

  // Return
  log() << coral::Debug << "Refresh node '" << fullPath << "' ... DONE"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

UInt32 RalDatabase::insertNodeTableRow
( const std::string& fullPath,
  const std::string& description,
  bool createParents,
  bool isLeaf,
  const std::string& payloadSpecDesc,
  FolderVersioning::Mode versioningMode,
  PayloadMode::Mode payloadMode )
{
  checkDbOpenTransaction( "RalDatabase::insertNodeTableRow", cool::ReadWrite );

  // This is the maximum number of nodes that can be created
  // Note that this limitation is coupled to the folder name
  // generation via the pattern F%4.4i_IOVS --> max: F9999_IOVS
  // There is no point in working around this limitation at this time
  // as the database will not handle several thousands of tables well.
  // (At least the MySQL backend has proven to be problematic at this scale.)
  unsigned int kMaxNumberOfNodes = 9999;

  log() << "Create a new node with name " << fullPath
        << coral::MessageStream::endmsg;
  // Cross-check that the database is open
  if ( ! isOpen() ) throw DatabaseNotOpen( "RalDatabase" );

  /*
  // AV 09.05.2005 Move this AFTER locking sequence to fix David Front's bug
  // Check if a folder or folder set with this name already exists
  if ( existsNode( fullPath ) ) {
    throw NodeExists( fullPath, "RalDatabase" );
  }
  *///

  // Split the full path
  HvsPathHandler pathHandler;
  std::pair<std::string, std::string> parentAndChild;
  try {
    parentAndChild = pathHandler.splitFullPath( fullPath );
  } catch ( HvsPathHandlerException& ) {
    log() << coral::Error << "Invalid folder node path '"
          << fullPath << "'" << coral::MessageStream::endmsg;
    throw;
  }
  std::string parentFullPath = parentAndChild.first;
  std::string unresolvedName = parentAndChild.second;

  // Look for the parent folder set
  unsigned int nodeParentId;
  try {
    RelationalTableRow row = fetchNodeTableRow( parentFullPath );
    bool isParentLeaf =
      row[RelationalNodeTable::columnNames::nodeIsLeaf].data<bool>();
    if ( isParentLeaf ) {
      std::stringstream s;
      s << "Cannot create node '" << fullPath
        << "', because the parent path contains a leaf node";
      throw RelationalException( s.str(), "RalDatabase" );
    }
    IFolderSetPtr parent
      ( new RelationalFolderSet( relationalDbPtr(), row.data() ) );
    nodeParentId = parent->id();
  } catch ( NodeTableRowNotFound& ) {
    if( ! createParents ) throw;
    createFolderSet( parentFullPath, // full path
                     "", // description
                     true ); // createParents
    RelationalTableRow row = fetchNodeTableRow( parentFullPath );
    IFolderSetPtr parent
      ( new RelationalFolderSet( relationalDbPtr(), row.data() ) );
    nodeParentId = parent->id();
  }

  // Get a new folder ID from the sequence
  std::string nodeSeqName =
    RelationalNodeTable::sequenceName( nodeTableName() );
  RelationalSequencePtr nodeSeq
    ( queryMgr().sequenceMgr().getSequence( nodeSeqName ) );
  unsigned int nodeId = nodeSeq->nextVal();
  if ( nodeId > kMaxNumberOfNodes )
    throw RelationalException
      ( "Node ID out of boundaries", "RalDatabase" );
  std::string insertionTime = nodeSeq->currDate(); // nextVal -> recent!

  // AV 09.05.2005 Move this AFTER locking sequence to fix David Front's bug
  // Check if a folder or folder set with this name already exists
  if ( existsNode( fullPath ) ) {
    /*
    // NB Error message only makes sense if first cross-check is also kept
    log() << coral::Error
          << "Congratulations! You tried to create folder " << fullPath
          << " from two separate connections EXACTLY at the same time!"
          << coral::MessageStream::endmsg;
    *///
    throw NodeExists( fullPath, "RalDatabase" );
  }

  // Register the folder in the node table
  // AV 14-03-2005 TEMPORARY? Till RAL handles NULL values better
  // Do not insert NULL values: insert empty strings instead
  const IRecordSpecification& nodeTableSpec =
    RelationalNodeTable::tableSpecification();
  Record data( nodeTableSpec );
  data[RelationalNodeTable::columnNames::nodeId].setValue
    ( nodeId );
  data[RelationalNodeTable::columnNames::nodeParentId].setValue
    ( nodeParentId );
  data[RelationalNodeTable::columnNames::nodeName].setValue
    ( unresolvedName );
  data[RelationalNodeTable::columnNames::nodeFullPath].setValue
    ( fullPath );
  data[RelationalNodeTable::columnNames::nodeDescription].setValue
    ( description );
  data[RelationalNodeTable::columnNames::nodeIsLeaf].setValue
    ( isLeaf );
  if ( isLeaf ) {
    data[RelationalNodeTable::columnNames::nodeSchemaVersion].setValue
      ( std::string( RelationalFolder::folderSchemaVersion
                     ( payloadMode ) ) );
  }
  else {
    data[RelationalNodeTable::columnNames::nodeSchemaVersion].setValue
      ( std::string( RelationalFolderSet::folderSetSchemaVersion() ) );
  }
  data[RelationalNodeTable::columnNames::nodeInsertionTime].setValue
    ( insertionTime );
  data[RelationalNodeTable::columnNames::lastModDate].setValue
    ( insertionTime );

  if ( isLeaf )
  {
    // Set the folder specific information
    data[RelationalNodeTable::columnNames::folderVersioningMode].setValue
      ( (int)versioningMode );
    data[RelationalNodeTable::columnNames::folderPayloadSpecDesc].setValue
      ( payloadSpecDesc );
    data[RelationalNodeTable::columnNames::folderPayloadInline].setValue
      ( RelationalFolder::folderSchemaPayloadMode( payloadMode ) );
    if ( payloadMode != cool_PayloadMode_Mode::INLINEPAYLOAD )
      data[RelationalNodeTable::columnNames::folderPayloadExtRef].setValue
        ( RelationalPayloadTable::defaultTableName
          ( defaultTablePrefix(), nodeId ) );
    else
      data[RelationalNodeTable::columnNames::folderPayloadExtRef].setValue
        ( std::string( "" ) );
    data[RelationalNodeTable::columnNames::folderChannelSpecDesc].setValue
      ( std::string( "" ) );
    data[RelationalNodeTable::columnNames::folderChannelExtRef].setValue
      ( std::string( "" ) );
    data[RelationalNodeTable::columnNames::folderObjectTableName].setValue
      ( RelationalObjectTable::defaultTableName
        ( defaultTablePrefix(), nodeId ) );
    data[RelationalNodeTable::columnNames::folderTagTableName].setValue
      ( RelationalTagTable::defaultTableName
        ( defaultTablePrefix(), nodeId ) );
    data[RelationalNodeTable::columnNames::folderObject2TagTableName].setValue
      ( RelationalObject2TagTable::defaultTableName
        ( defaultTablePrefix(), nodeId ) );
    data[RelationalNodeTable::columnNames::folderChannelTableName].setValue
      ( RelationalChannelTable::defaultTableName
        ( defaultTablePrefix(), nodeId ) );
  }
  else
  {
    // Insert default values for folder sets
    data[RelationalNodeTable::columnNames::folderVersioningMode].setValue
      ( (int)cool_FolderVersioning_Mode::NONE ); // default for folder sets
    data[RelationalNodeTable::columnNames::folderPayloadSpecDesc].setValue
      ( std::string( "" ) );
    data[RelationalNodeTable::columnNames::folderPayloadInline].setValue
      ( RelationalFolderSet::folderSetSchemaPayloadMode() ); // default (0)
    data[RelationalNodeTable::columnNames::folderPayloadExtRef].setValue
      ( std::string( "" ) );
    data[RelationalNodeTable::columnNames::folderChannelSpecDesc].setValue
      ( std::string( "" ) );
    data[RelationalNodeTable::columnNames::folderChannelExtRef].setValue
      ( std::string( "" ) );
    data[RelationalNodeTable::columnNames::folderObjectTableName].setValue
      ( std::string( "" ) );
    data[RelationalNodeTable::columnNames::folderTagTableName].setValue
      ( std::string( "" ) );
    data[RelationalNodeTable::columnNames::folderObject2TagTableName].setValue
      ( std::string( "" ) );
    data[RelationalNodeTable::columnNames::folderChannelTableName].setValue
      ( std::string( "" ) );
  }

  /*
  // Check that all column values are within their allowed range.
  // REMOVE? This is already done by the IField::setValue calls above.
  nodeTableSpec.validate( data.attributeList() );
  *///

  // Perform the actual db update
  queryMgr().insertTableRow( nodeTableName(), data );
  return nodeId;
}

//-----------------------------------------------------------------------------

IFolderSetPtr RalDatabase::createFolderSet( const std::string& fullPath,
                                            const std::string& description,
                                            bool createParents )
{
  log() << coral::Verbose
        << "Create folder set " << fullPath << coral::MessageStream::endmsg;

  if ( ! transactionMgr()->autoTransactions() ) {
    throw RelationalException("Cannot create folder set in manual "
                              "transaction mode", "RalDatabase");
  }

  // Cross-check that the database is open
  checkDbOpenTransaction( "RalDatabase::createFolderSet", cool::ReadWrite );

  bool isLeaf = false;
  std::string payloadSpecDesc = "";
  FolderVersioning::Mode folderVersioningMode = cool_FolderVersioning_Mode::NONE;

  unsigned int nodeId = insertNodeTableRow
    ( fullPath, description, createParents, isLeaf,
      // The "" payloadSpecDesc argument is set to NULL only in the Oracle db
      payloadSpecDesc, folderVersioningMode );

  std::string tagSequenceName = RelationalTagSequence::sequenceName
    ( defaultTablePrefix(), nodeId );
  schemaMgr().createTagSequence( tagSequenceName );

  log() << coral::Verbose
        << "Created folder set " << fullPath
        << ": now fetch it and return it" << coral::MessageStream::endmsg;

  return getFolderSet( fullPath );
}


//-----------------------------------------------------------------------------

#ifndef COOL300DP
IFolderPtr RalDatabase::createFolder
( const std::string& fullPath,
  const IRecordSpecification& payloadSpec,
  const std::string& description,
  FolderVersioning::Mode versioningMode,
  bool createParents )
{
  // Cross-check that the database is open
  if ( ! isOpen() ) throw DatabaseNotOpen( "RalDatabase" );
  // Cross-check that we're not in manual transaction more
  if ( ! transactionMgr()->autoTransactions() ) {
    throw RelationalException("Cannot create folder in manual "
                              "transaction mode", "RalDatabase");
  }
  IFolderPtr folder =
    createFolder( fullPath, payloadSpec, description,
                  versioningMode, createParents, cool_PayloadMode_Mode::INLINEPAYLOAD );
  return folder;
}
#endif

//-----------------------------------------------------------------------------

IFolderPtr RalDatabase::createFolder
(  const std::string& fullPath,
   const IFolderSpecification& folderSpec,
   const std::string& description,
   bool createParents )
{
  // Cross-check that the database is open
  if ( ! isOpen() ) throw DatabaseNotOpen( "RalDatabase" );
  // Cross-check that we're not in manual transaction more
  if ( ! transactionMgr()->autoTransactions() ) {
    throw RelationalException("Cannot create folder in manual "
                              "transaction mode", "RalDatabase");
  }
  FolderVersioning::Mode versioningMode = folderSpec.versioningMode();
  const IRecordSpecification& payloadSpec = folderSpec.payloadSpecification();
  IFolderPtr folder =
#ifdef COOL290VP
    createFolder( fullPath, payloadSpec, description,
                  versioningMode, createParents, folderSpec.payloadMode() );
#else
  createFolder( fullPath, payloadSpec, description,
                versioningMode, createParents,
                ( folderSpec.hasPayloadTable() ?
                  cool_PayloadMode_Mode::SEPARATEPAYLOAD :
                  cool_PayloadMode_Mode::INLINEPAYLOAD )
                );
#endif
  return folder;
}

//-----------------------------------------------------------------------------

IFolderPtr RalDatabase::createFolder
( const std::string& fullPath,
  const IRecordSpecification& payloadSpec,
  const std::string& description,
  FolderVersioning::Mode versioningMode,
  bool createParents,
  PayloadMode::Mode payloadMode )
{
  log() << coral::Verbose
        << "Create folder " << fullPath  << coral::MessageStream::endmsg;

  // Cross-check that the database is open
  if ( ! isOpen() ) throw DatabaseNotOpen( "RalDatabase" );

  // Validate the payload specification.
  // Throws InvalidPayloadSpecification if the payload spec is invalid:
  // there can be at most 900 fields, including up to 10 BLOB fields;
  // field names must have between 1 and 30 characters (including only
  // letters, digits or '_'), must start with a letter and cannot start
  // with the "COOL_" prefix (in any lowercase/uppercase combination).
  validatePayloadSpecification( payloadSpec );

  // Register the folder in the node table
  std::string payloadSpecDesc = encodeRecordSpecification( payloadSpec );

  bool isLeaf = true;
  unsigned int nodeId = insertNodeTableRow
    ( fullPath, description, createParents,
      isLeaf, payloadSpecDesc, versioningMode, payloadMode );

  // Create the IOV table for the folder
  std::string objectTableName = RelationalObjectTable::defaultTableName
    ( defaultTablePrefix(), nodeId );
  std::string payloadTableName = "";
  if ( payloadMode != cool_PayloadMode_Mode::INLINEPAYLOAD )
    payloadTableName = RelationalPayloadTable::defaultTableName
      ( defaultTablePrefix(), nodeId );
  std::string obj2tagTableName = RelationalObject2TagTable::defaultTableName
    ( defaultTablePrefix(), nodeId );
  std::string tagTableName = RelationalTagTable::defaultTableName
    ( defaultTablePrefix(), nodeId );
  std::string tagSequenceName = RelationalTagSequence::sequenceName
    ( defaultTablePrefix(), nodeId );
  std::string channelTableName =
    RelationalChannelTable::defaultTableName( defaultTablePrefix(), nodeId );

  if ( versioningMode == cool_FolderVersioning_Mode::SINGLE_VERSION ||
       versioningMode == cool_FolderVersioning_Mode::MULTI_VERSION ) {

    schemaMgr().createChannelTable( channelTableName );

    if ( payloadMode == cool_PayloadMode_Mode::SEPARATEPAYLOAD ) {
      schemaMgr().createPayloadTable( payloadTableName,
                                      objectTableName,
                                      payloadSpec,
                                      payloadMode );
      schemaMgr().createObjectTable
        ( objectTableName, channelTableName,
          RelationalPayloadTable::defaultSpecification( payloadMode ),
          versioningMode, payloadTableName, payloadMode );
    }
    else if ( payloadMode == cool_PayloadMode_Mode::VECTORPAYLOAD)
    {
      //std::cout << "creating vector folder " << std::endl;
      schemaMgr().createObjectTable
        ( objectTableName, channelTableName,
          RecordSpecification(),
          versioningMode, payloadTableName, payloadMode );

      schemaMgr().createPayloadTable( payloadTableName,
                                      objectTableName,
                                      payloadSpec,
                                      payloadMode );
    }
    else
    {
      // inline payload
      schemaMgr().createObjectTable
        ( objectTableName, channelTableName, payloadSpec,
          versioningMode, "", payloadMode );
    }

    if ( versioningMode == cool_FolderVersioning_Mode::MULTI_VERSION ) {
      schemaMgr().createTagSequence( tagSequenceName );
      schemaMgr().createTagTable( tagTableName );
      schemaMgr().createObject2TagTable( obj2tagTableName,
                                         objectTableName,
                                         tagTableName,
                                         payloadTableName,
                                         payloadMode );
    }

  } else {
    std::stringstream s;
    s << "Invalid versioning mode specified: " << versioningMode;
    throw InvalidFolderSpecification( s.str(), "RalDatabase" );
  }

  // TEMPORARY? Sleep to work around the ORA-01466 problem (Oracle only)
  if ( m_sessionMgr->databaseTechnology() == "Oracle" && m_useTimeout ) {
    log() << "Sleep to work around the ORA-01466 problem"
          << coral::MessageStream::endmsg;
    cool::sleep(1);
  }

  // Get and return the IFolder instance for the folder that has just been
  // created [NB This causes a second round trip to fetch the data that has
  // just been written, but performance impact is low because folder creation
  // is a relatively rare operation, and it's more modular to use getFolder]
  log() << coral::Verbose
        << "Created folder " << fullPath
        << ": now fetch it and return it" << coral::MessageStream::endmsg;
  return getFolder( fullPath );

}

//-----------------------------------------------------------------------------

void RalDatabase::updateNodeTableDescription
( const std::string& fullPath, const std::string& description ) const
{
  log() << "Updating node description at path: "
        << fullPath << coral::MessageStream::endmsg;

  checkDbOpenTransaction( "updateNodeTableDescription", cool::ReadWrite );

  // Define the SET and WHERE clauses for the update using bind variables
  RecordSpecification updateDataSpec;
  updateDataSpec.extend( "desc",
                         RelationalNodeTable::columnTypeIds::nodeDescription );
  updateDataSpec.extend( "path",
                         RelationalNodeTable::columnTypeIds::nodeFullPath );
  Record updateData( updateDataSpec );
  updateData["desc"].setValue( description );
  updateData["path"].setValue( fullPath );
  std::string setClause = RelationalNodeTable::columnNames::nodeDescription;
  setClause += "= :desc";
  setClause += ", ";
  setClause += RelationalNodeTable::columnNames::lastModDate;
  setClause += " = " + queryMgr().serverTimeClause();
  std::string whereClause = RelationalNodeTable::columnNames::nodeFullPath;
  whereClause += "= :path";

  // Execute the update
  if ( 1 != queryMgr().updateTableRows
       ( nodeTableName(), setClause, whereClause, updateData ) )
    throw RowNotUpdated
      ( "Could not update a row of the node table", "RalDatabase" );

}

//-----------------------------------------------------------------------------

IFolderPtr RalDatabase::getFolder( const std::string& fullPath )
{
  if ( TimingReportMgr::isActive() )
    TimingReportMgr::startTimer( "cool::RalDatabase::getFolder()" );

  checkDbOpenTransaction( "RalDatabase::getFolder", cool::ReadOnly );

  log() << "Get folder with name " << fullPath << coral::MessageStream::endmsg;
  if ( ! isOpen() ) throw DatabaseNotOpen( "RalDatabase" );

  IFolderPtr folder;

  // For Update connections, fetch each folder every time
  if ( !sessionMgr()->isReadOnly() )
  {
    try {
      RelationalTableRow row = fetchNodeTableRow( fullPath );
      folder = getFolder( row );
    } catch ( NodeTableRowNotFound& ) {
      throw FolderNotFound( fullPath, "RalDatabase" );
    }
  }

  // For ReadOnly connections, use the folder cache
  else
  {
    if ( m_nodes.size() == 0 ) preloadAllNodes();
    if ( m_nodes.find( fullPath ) != m_nodes.end() )
      folder = getFolder( *m_nodes[fullPath] );
    else
      throw FolderNotFound( fullPath, "RalDatabase" );
  }

  if ( TimingReportMgr::isActive() )
    TimingReportMgr::stopTimer( "cool::RalDatabase::getFolder()" );
  return folder;
}

//-----------------------------------------------------------------------------

IFolderPtr RalDatabase::getFolder( const RelationalTableRow& row )
{
  std::string fullPath =
    row[RelationalNodeTable::columnNames::nodeFullPath].data<std::string>();
  bool isLeaf =
    row[RelationalNodeTable::columnNames::nodeIsLeaf].data<bool>();
  if ( ! isLeaf )
    throw FolderNotFound( fullPath, "RalDatabase", true );
  VersionNumber schemaVersion =
    row[RelationalNodeTable::columnNames::nodeSchemaVersion]
    .data<std::string>();
  IFolderPtr folder;
  // Handle all well-defined hardcoded folder schema versions supported by
  // the RelationalFolder class; return an unusable Unsupported folder
  // for folders with schema versions higher than the present s/w release;
  // throw a PANIC exception for all other values (should never happen!).
  if ( RelationalFolder::isSupportedSchemaVersion( schemaVersion ) )
  {
    folder.reset
      ( new RelationalFolder( relationalDbPtr(), row.data() ) );
  }
  else if ( VersionInfo::release < schemaVersion )
  {
    folder.reset
      ( new RelationalFolderUnsupported( relationalDbPtr(), row.data() ) );
  }
  else if ( schemaVersion == VersionNumber( "2.0.0" ) )
  {
    folder.reset
      ( new RelationalFolderUnsupported( relationalDbPtr(), row.data() ) );
    //throw UnsupportedFolderSchema
    //  ( fullPath, schemaVersion, "RelationalFolderUnsupported" );
  }
  else
  {
    std::stringstream s;
    s << "PANIC! Cannot get folder '" << fullPath
      << "': it appears to have been created using UNKNOWN schema version "
      << schemaVersion
      << " that is older than (or as old as) the current software release "
      << VersionInfo::release;
    throw RelationalException( s.str(), "RalDatabase" );
  }
  return folder;
}

//-----------------------------------------------------------------------------

IFolderSetPtr RalDatabase::getFolderSet( const std::string& fullPath )
{
  log() << "Get folderset with name " << fullPath
        << coral::MessageStream::endmsg;
  checkDbOpenTransaction( "RalDatabase::getFolderSet", cool::ReadOnly );

  IFolderSetPtr folderSet;

  // For Update connections, fetch each folder every time
  if ( !sessionMgr()->isReadOnly() )
  {
    try {
      RelationalTableRow row = fetchNodeTableRow( fullPath );
      folderSet = getFolderSet( row );
    } catch ( NodeTableRowNotFound& ) {
      throw FolderSetNotFound( fullPath, "RalDatabase" );
    }
  }

  // For ReadOnly connections, use the folder cache
  else
  {
    if ( m_nodes.size() == 0 ) preloadAllNodes();
    if ( m_nodes.find( fullPath ) != m_nodes.end() )
      folderSet = getFolderSet( *m_nodes[fullPath] );
    else
      throw FolderSetNotFound( fullPath, "RalDatabase" );
  }

  return folderSet;
}

//-----------------------------------------------------------------------------

IFolderSetPtr RalDatabase::getFolderSet( const RelationalTableRow& row )
{
  std::string fullPath =
    row[RelationalNodeTable::columnNames::nodeFullPath].data<std::string>();
  bool isLeaf =
    row[RelationalNodeTable::columnNames::nodeIsLeaf].data<bool>();
  if ( isLeaf )
    throw FolderSetNotFound( fullPath, "RalDatabase", true );
  VersionNumber schemaVersion =
    row[RelationalNodeTable::columnNames::nodeSchemaVersion]
    .data<std::string>();
  IFolderSetPtr folderSet;
  // Handle all well-defined hardcoded folder set schema versions supported by
  // the RelationalFolderSet class; return an unusable Unsupported folderSet
  // for folder sets with schema versions higher than the present s/w release;
  // throw a PANIC exception for all other values (should never happen!).
  if ( RelationalFolderSet::isSupportedSchemaVersion( schemaVersion ) )
  {
    folderSet.reset
      ( new RelationalFolderSet( relationalDbPtr(), row.data() ) );
  }
  else if ( VersionInfo::release < schemaVersion )
  {
    folderSet.reset
      ( new RelationalFolderSetUnsupported( relationalDbPtr(), row.data() ) );
  }
  else
  {
    std::stringstream s;
    s << "PANIC! Cannot get folder set '" << fullPath
      << "': it appears to have been created using UNKNOWN schema version "
      << schemaVersion
      << " that is older than (or as old as) the current software release "
      << VersionInfo::release;
    throw RelationalException( s.str(), "RalDatabase" );
  }
  return folderSet;
}

//-----------------------------------------------------------------------------

void RalDatabase::preloadAllNodes()
{
  log() << "Preload all nodes" << coral::MessageStream::endmsg;

  if ( ! isOpen() ) throw DatabaseNotOpen( "RalDatabase" );

  if ( m_nodes.size() != 0 )
    throw RelationalException
      ( "PANIC! Nodes already preloaded", "RalDatabase" );

  if ( !sessionMgr()->isReadOnly() )
    throw RelationalException
      ( "PANIC! Cannot preload nodes in update mode", "RalDatabase" );

  std::vector<RelationalTableRow> rows = nodeMgr().fetchAllNodeTableRows();

  // Loop over all nodes in the node table
  for ( std::vector<RelationalTableRow>::const_iterator
          row = rows.begin(); row != rows.end(); ++row )
  {
    std::string fullPath =
      (*row)[RelationalNodeTable::columnNames::nodeFullPath]
      .data<std::string>();

    if ( m_nodes.find( fullPath ) != m_nodes.end() )
    {
      std::stringstream s;
      s << "PANIC! Node '" << fullPath
        << "' was found more than once in the node table!";
      throw RelationalException( s.str(), "RalDatabase" );
    }

    m_nodes[fullPath] = new RelationalTableRow( *row );

  }
}

//-----------------------------------------------------------------------------

bool RalDatabase::dropAllNodes( bool keepRoot )
{
  log() << coral::Info << "Drop all nodes ("
        << ( keepRoot ? "" : "do not" )
        << "keep root)..." << coral::MessageStream::endmsg;

  // AV 2005-07-07
  // Return true if all node, tag and tag2tag rows are deleted and all folder
  // tables (for nodes that are folders) are dropped as expected.
  // Return false (without throwing any exception) if the node rows and
  // any associated tables do not exist any more on exit from this method,
  // but some node rows or associated tables did not exist to start with.
  bool status = true;

  // Reinitialise the node sequence if keepRoot is true (for tests only!)
  std::string nodeSqNm = RelationalNodeTable::sequenceName( nodeTableName() );
  unsigned int nodeSqCurr = 0; // Get the real value in the RO transaction

  // Throw an Exception if the schema of one of the nodes in this database
  // is more recent than the schema version supported by the current release:
  // in this case make sure you do not drop ANY node (throw immediately)!
  {

    // Iterate over all folders and folder sets and compare schema versions
    // to a well-defined hardcoded list supported by this s/w release
    RelationalQueryDefinition queryDef;
    queryDef.addFromItem( nodeTableName() );
    queryDef.addSelectItems( RelationalNodeTable::tableSpecification() );
    std::vector<RelationalTableRow> rows =
      queryMgr().fetchOrderedRows( queryDef ); // no WHERE or ORDER clause
    for ( std::vector<RelationalTableRow>::const_iterator
            row = rows.begin(); row != rows.end(); row++ )
    {
      const std::string fullPath =
        (*row)[RelationalNodeTable::columnNames::nodeFullPath]
        .data<std::string>();
      bool isLeaf =
        (*row)[RelationalNodeTable::columnNames::nodeIsLeaf]
        .data<bool>();
      const VersionNumber schemaVersion =
        (*row)[RelationalNodeTable::columnNames::nodeSchemaVersion]
        .data<std::string>();
      bool isSupported = true;
      if ( isLeaf )
      {
        if ( !RelationalFolder::isSupportedSchemaVersion( schemaVersion ) )
          isSupported = false;
      }
      else
      {
        if ( !RelationalFolderSet::isSupportedSchemaVersion( schemaVersion ) )
          isSupported = false;
      }
      if ( VersionInfo::release < schemaVersion )
      {
        std::stringstream s;
        s << "Cannot drop database:";
        if ( isLeaf ) s << " folder '";
        else s << " folder set '";
        s << fullPath << " has schema version " << schemaVersion
          << " that is newer than this software release "
          << VersionInfo::release;
        log() << coral::Warning << s.str() << coral::MessageStream::endmsg;
        throw RelationalException( s.str(), "RalDatabase" );
      }
      else if ( ! isSupported )
      {
        std::stringstream s;
        s << "PANIC! Cannot drop database:";
        if ( isLeaf ) s << " folder '";
        else s << " folder set '";
        s << fullPath
          << "' appears to have been created using UNKNOWN schema version "
          << schemaVersion
          << " that is older than (or as old as) the current software release "
          << VersionInfo::release;
        throw RelationalException( s.str(), "RalDatabase" );
      }
    }

    // Get the current value of the node sequence (only needed if keepRoot)
    // NB: disable the for update clause (it needs a R/W transaction)
    if ( keepRoot )
    {
      bool forUpdate = false;
      nodeSqCurr =
        queryMgr().sequenceMgr().getSequence( nodeSqNm )->currVal( forUpdate );
    }

  }

  // Throw a RelationalException if a node row cannot be deleted or one table
  // cannot be dropped (i.e. continues to exist on exit from this method).

  // Listing the nodes in reverse order ensures that integrity constraints
  // are not violated (children are dropped before their parents)
  std::vector<std::string> nodes( listAllNodes( false ) );
  std::vector<std::string>::const_iterator node;
  log() << coral::Debug << "Will drop nodes in this order:"
        << coral::MessageStream::endmsg;
  HvsPathHandler handler;
  for ( node = nodes.begin(); node != nodes.end(); node++ )
  {
    if ( !keepRoot || *node != handler.rootFullPath() )
    {
      log() << coral::Debug << "Will drop '" << *node << "'"
            << coral::MessageStream::endmsg;
    }
  }
  for ( node = nodes.begin(); node != nodes.end(); node++ )
  {
    if ( !keepRoot || *node != handler.rootFullPath() )
    {
      log() << coral::Debug << "Now drop '" << *node << "'"
            << coral::MessageStream::endmsg;
      if ( ! dropNode( *node ) ) status = false;
    }
  }

  // If you keep the root node, this is only used for tests:
  // reinitialise the sequence associated to the node table.
  if ( keepRoot && nodeSqCurr > 0 )
  {
    log() << coral::Debug << "Refresh sequence " << nodeSqNm
          << coral::MessageStream::endmsg;
    queryMgr().deleteAllTableRows( nodeSqNm );
    queryMgr().sequenceMgr().initSequence( nodeSqNm );
    queryMgr().sequenceMgr().getSequence( nodeSqNm )->nextVal(); // root node!
  }

  // Success: the nodes do not exist anymore
  // Return status code 'false' if some nodes or tables were missing already
  log() << coral::Info << "Drop all nodes ("
        << ( keepRoot ? "" : "do not " )
        << "keep root)... DONE" << coral::MessageStream::endmsg;
  return status;

}

//-----------------------------------------------------------------------------

bool RalDatabase::dropNode( const std::string& fullPath )
{
  log() << "Drop node with full path " << fullPath
        << coral::MessageStream::endmsg;
  checkDbOpenTransaction( "RalDatabase::dropNode", cool::ReadWrite );

  // AV 2005-07-07
  // Return true if the node, tag and tag2tag rows for this node are deleted
  // and all folder tables (if the node is a folder) are dropped as expected.
  // Return false (without throwing any exception) if any such row and
  // any associated tables do not exist any more on exit from this method,
  // but the node or some associated tables did not exist to start with.
  bool status = true;

  // Throw a RelationalException if the node row cannot be deleted or one table
  // cannot be dropped (i.e. continues to exist on exit from this method).
  // Throw a RelationalException if the node is a non-empty folder set.
  // Also deletes any tags and tag2tag associated to the node
  // (and throws a RelationalException if such tags cannot be deleted).

  // Fetch the row for this node
  RelationalTableRow nodeRow;
  try {
    nodeRow = fetchNodeTableRow( fullPath );
  } catch ( NodeTableRowNotFound& ) {
    // A node with this name does not exist: nothing to drop
    log() << coral::Warning << "Node '" << fullPath
          << "' cannot be dropped (node not found)"
          << coral::MessageStream::endmsg;
    return false;
  } catch ( coral::QueryException& e ) {
    // The query on the node table failed: for instance, the query may fail
    // with ORA-00904 if some columns are missing from the node table because
    // the process that created the database crashed or was killed while
    // altering the node table to change the SQL type of its columns
    log() << coral::Warning << "The node table cannot be queried: '"
          << e.what() << coral::MessageStream::endmsg;
    return false;
  }
  bool isLeaf =
    nodeRow[RelationalNodeTable::columnNames::nodeIsLeaf].data<bool>();
  unsigned int nodeId =
    nodeRow[RelationalNodeTable::columnNames::nodeId].data<unsigned int>();

  // Throw TagIsLocked if any tags applied to this node are locked
  // (either LOCKED or PARTIALLYLOCKED - both are equivalent here)
  {
    std::vector<RelationalTableRow> rows =
      tagMgr().fetchGlobalTagTableRows( nodeId );
    for ( std::vector<RelationalTableRow>::const_iterator
            row = rows.begin(); row != rows.end(); ++row ) {
      HvsTagLock::Status lockStatus =
        HvsTagLock::Status
        ( (*row)[RelationalGlobalTagTable::columnNames::tagLockStatus]
          .data<UInt16>() );
      if ( lockStatus != cool_HvsTagLock_Status::UNLOCKED ) {
        std::string tagName =
          (*row)[RelationalGlobalTagTable::columnNames::tagName]
          .data<std::string>();
        throw TagIsLocked
          ( "Cannot drop node '" + fullPath +
            "': tag '" + tagName + "' is locked", "RalDatabase" );
      }
    }
  }

  // Check that the node schema version is supported by this software release
  VersionNumber schemaVersion =
    nodeRow[RelationalNodeTable::columnNames::nodeSchemaVersion]
    .data<std::string>();
  bool isSupported = true;
  if ( isLeaf ) {
    if ( !RelationalFolder::isSupportedSchemaVersion( schemaVersion ) )
      isSupported = false;
  }
  else {
    if ( !RelationalFolderSet::isSupportedSchemaVersion( schemaVersion ) )
      isSupported = false;
  }
  if ( VersionInfo::release < schemaVersion )
  {
    std::stringstream s;
    s << "Cannot drop node:";
    if ( isLeaf ) s << " folder '";
    else s << " folder set '";
    s << fullPath << " has schema version " << schemaVersion
      << " that is newer than this software release "
      << VersionInfo::release;
    log() << coral::Warning << s.str() << coral::MessageStream::endmsg;
    throw RelationalException( s.str(), "RalDatabase" );
  }
  else if ( !isSupported )
  {
    std::stringstream s;
    s << "PANIC! Cannot drop node:";
    if ( isLeaf ) s << " folder '";
    else s << " folder set '";
    s << fullPath
      << "' appears to have been created using UNKNOWN schema version "
      << schemaVersion
      << " that is older than (or as old as) the current software release "
      << VersionInfo::release;
    throw RelationalException( s.str(), "RalDatabase" );
  }

  // Folder: drop folder-specific tables and sequences
  if ( isLeaf )
  {
    std::string objectTableName =
      RelationalFolder::objectTableName( nodeRow.data() );
    std::string payloadTableName =
      RelationalFolder::payloadTableName( nodeRow.data() );
    std::string tagTableName =
      RelationalFolder::tagTableName( nodeRow.data() );
    std::string object2TagTableName =
      RelationalFolder::object2TagTableName( nodeRow.data() );
    FolderVersioning::Mode versioningMode =
      RelationalFolder::versioningMode( nodeRow.data() );
    std::string tagSequenceName = RelationalTagSequence::sequenceName
      ( defaultTablePrefix(), nodeId );
    std::string tableName;
    std::string seqName;
    // Drop tables for MV folders
    if ( versioningMode == cool_FolderVersioning_Mode::MULTI_VERSION )
    {
      // Drop iov2tag table first as it has FK constraints on the other tables
      tableName = object2TagTableName;
      log() << "Drop table " << tableName << coral::MessageStream::endmsg;
      if ( ! schemaMgr().dropTable( tableName ) ) status = false;
      // Drop local tag table
      tableName = tagTableName;
      log() << "Drop table " << tableName << coral::MessageStream::endmsg;
      if ( ! schemaMgr().dropTable( tableName ) ) status = false;
      // Drop local tag sequence
      seqName = tagSequenceName;
      log() << "Drop sequence " << seqName << coral::MessageStream::endmsg;
      if ( ! queryMgr().sequenceMgr().existsSequence( seqName ) ) {
        status = false;
      } else {
        queryMgr().sequenceMgr().dropSequence( seqName );
      }
    }
    // for vector payload folders, drop payload table before iov table
    if ( RelationalFolder::payloadMode( nodeRow.data() ) ==
         cool_PayloadMode_Mode::VECTORPAYLOAD )
    {
      tableName = payloadTableName;
      if ( ! schemaMgr().dropTable( tableName ) ) status = false;
    }
    // Drop iov table
    tableName = objectTableName;
    log() << "Drop table " << tableName << coral::MessageStream::endmsg;
    if ( ! schemaMgr().dropTable( tableName ) ) status = false;
    // Drop iov sequence
    seqName = RelationalObjectTable::sequenceName( objectTableName );
    log() << "Drop sequence " << seqName << coral::MessageStream::endmsg;
    if ( ! queryMgr().sequenceMgr().existsSequence( seqName ) ) {
      status = false;
    } else {
      queryMgr().sequenceMgr().dropSequence( seqName );
    }
    // if exists, drop payload table
    tableName = payloadTableName;
    if ( RelationalFolder::payloadMode( nodeRow.data() ) ==
         cool_PayloadMode_Mode::SEPARATEPAYLOAD )
    {
      if ( ! schemaMgr().dropTable( tableName ) ) status = false;
      // Drop payload sequence
      seqName = RelationalPayloadTable::sequenceName( payloadTableName );
      log() << "Drop sequence " << seqName << coral::MessageStream::endmsg;
      if ( ! queryMgr().sequenceMgr().existsSequence( seqName ) ) {
        status = false;
      } else {
        queryMgr().sequenceMgr().dropSequence( seqName );
      }
    };
    // Drop channel table last as it is referenced by FKs in the iov table
    tableName =
      RelationalChannelTable::defaultTableName( defaultTablePrefix(), nodeId );
    log() << "Drop table " << tableName << coral::MessageStream::endmsg;
    if ( ! schemaMgr().dropTable( tableName ) ) status = false;
  }

  // Folder set: make sure it is empty before deleting it and drop tag sequence
  else
  {
    // Make sure it is empty before deleting it
    bool hasFolders = ! ( listNodes( nodeId, true ).empty() );
    bool hasFolderSets = ! ( listNodes( nodeId, false ).empty() );
    if ( hasFolders || hasFolderSets ) {
      std::stringstream s;
      s << "Cannot drop folderset '" << fullPath
        << "', because it is not empty";
      throw RelationalException( s.str(), "RalDatabase" );
    }
    // Drop local tag sequence
    std::string tagSequenceName = RelationalTagSequence::sequenceName
      ( defaultTablePrefix(), nodeId );
    std::string seqName = tagSequenceName;
    log() << "Drop sequence " << seqName << coral::MessageStream::endmsg;
    if ( ! queryMgr().sequenceMgr().existsSequence( seqName ) ) {
      status = false;
    } else {
      queryMgr().sequenceMgr().dropSequence( seqName );
    }
  }

  // Delete all tag2tag relations associated to this node
  if ( ! session().nominalSchema().existsTable( tag2TagTableName() ) )
    status = false;
  else
    tagMgr().deleteTag2TagTableRowsForNode( nodeId );

  // Delete all global tags associated to this node
  if ( ! session().nominalSchema().existsTable( globalTagTableName() ) )
    status = false;
  else
    tagMgr().deleteGlobalTagTableRowsForNode( nodeId );

  // Delete the node from the node table
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "fullName",
                        RelationalNodeTable::columnTypeIds::nodeFullPath );
  Record whereData( whereDataSpec );
  whereData["fullName"].setValue( fullPath );
  std::string whereClause = RelationalNodeTable::columnNames::nodeFullPath;
  whereClause += "= :fullName";
  queryMgr().deleteTableRows
    ( nodeTableName(), whereClause, whereData, 1 );

  // Success: the node does not exist anymore
  // Return status code 'false' if the node or some tables were missing already
  return status;
}

//-----------------------------------------------------------------------------

boost::shared_ptr<RelationalObjectTable>
RalDatabase::relationalObjectTable( const RelationalFolder& folder ) const
{
  boost::shared_ptr<RelationalObjectTable>
    objectTable( new RelationalObjectTable( queryMgr(), folder ) );
  return objectTable;
}

//-----------------------------------------------------------------------------

boost::shared_ptr<ISessionMgr> RalDatabase::sessionMgr() const
{
  return m_sessionMgr;
}

//-----------------------------------------------------------------------------

coral::ISessionProxy& RalDatabase::session() const
{
  return m_sessionMgr->session();
}

//-----------------------------------------------------------------------------

bool RalDatabase::isConnected() const
{
  return m_sessionMgr->isConnected();
}

//-----------------------------------------------------------------------------

void RalDatabase::connect()
{
  return m_sessionMgr->connect();
}

//-----------------------------------------------------------------------------

void RalDatabase::disconnect()
{
  return m_sessionMgr->disconnect();
}

//-----------------------------------------------------------------------------

#ifdef COOL400
ITransactionPtr RalDatabase::startTransaction()
{
  transactionMgr()->setAutoTransactions( false );
  return ITransactionPtr( new ManualTransaction( transactionMgr() ) );
}
#endif

//-----------------------------------------------------------------------------
