// Include files
#include "CoolKernel/Record.h"
#include "CoralBase/Attribute.h"
#include "RelationalAccess/IColumn.h"
#include "RelationalAccess/IIndex.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ITable.h"
#include "RelationalAccess/ITableDataEditor.h"
#include "RelationalAccess/ITableSchemaEditor.h"
#include "RelationalAccess/SchemaException.h"

// Local include files
#include "RalSchemaEvolution.h"
#include "../../src/HvsPathHandler.h"
#include "../../src/ObjectId.h"
#include "../../src/RalDatabase.h"
#include "../../src/RelationalChannelTable.h"
#include "../../src/RelationalDatabaseTable.h"
#include "../../src/RelationalException.h"
#include "../../src/RelationalFolder.h"
#include "../../src/RelationalGlobalTagTable.h"
#include "../../src/RelationalIovSharedSequenceTable.h"
#include "../../src/RelationalNodeTable.h"
#include "../../src/RelationalObjectTable.h"
#include "../../src/RelationalObjectTableRow.h"
#include "../../src/RelationalQueryDefinition.h"
#include "../../src/RelationalQueryMgr.h"
#include "../../src/RelationalSchemaMgr.h"
#include "../../src/RelationalTagSequence.h"
#include "../../src/RelationalTagSharedSequenceTable.h"
#include "../../src/RelationalTag2TagTable.h"
#include "../../src/RelationalTableRow.h"
#include "../../src/RelationalTransaction.h"
#include "../../src/VersionInfo.h"

// Additional VersionInfo specific to RalSchemaEvolution.cpp
namespace cool
{
  namespace VersionInfo {
    const std::string cvsCheckout = "$Name: not supported by cvs2svn $";
    const std::string cvsCheckin =
      "$Id: RalSchemaEvolution.cpp,v 1.122 2012-06-29 15:36:12 avalassi Exp $";
  }
}

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

RalSchemaEvolution::RalSchemaEvolution
( CoralConnectionServiceProxyPtr ppConnSvc,
  const DatabaseId& dbId )
  : m_db( new RalDatabase( ppConnSvc, dbId, false ) )
  , m_log( new coral::MessageStream( "RalSchemaEvolution" ) )
{
  log() << coral::Info
        << "Instantiate a RalSchemaEvolution manager for '"
        << m_db->databaseId() << "'" << coral::MessageStream::endmsg;

  // DIRTY HACK - open the database
  RelationalTransaction transaction( db().transactionMgr(), true ); // r/o
  m_db->m_dbAttr = db().fetchDatabaseAttributes();
  transaction.commit();
  m_db->m_isOpen = true;
}

//-----------------------------------------------------------------------------

RalSchemaEvolution::~RalSchemaEvolution()
{
  log() << coral::Info
        << "Delete the RalSchemaEvolution manager for '"
        << m_db->databaseId() << "'" << coral::MessageStream::endmsg;
  delete m_db; // Fix Coverity REVERSE_INULL (no need to check m_db)
}

//-----------------------------------------------------------------------------

coral::MessageStream& RalSchemaEvolution::log()
{
  *m_log << coral::Verbose;
  return *m_log;
}

//-----------------------------------------------------------------------------

void RalSchemaEvolution::evolveDatabase()
{
  // HACK - print verbose output
  //coral::MessageStream::setMsgVerbosity( coral::Verbose );

  // WELCOME
  log() << coral::Info << "Evolve database schema... START"
        << coral::MessageStream::endmsg;
  RelationalTransaction transaction( db().transactionMgr(), false ); // r/w

  // Can the schema of this database be evolved? Does it need to?
  const Record& dbAttr = db().databaseAttributes();
  std::string releaseNumber =
    dbAttr[RelationalDatabaseTable::attributeNames::release]
    .data<std::string>();
  std::string schemaVersion =
    dbAttr[RelationalDatabaseTable::attributeNames::schemaVersion].
    data<std::string>();
  bool dbNeedsEvolution = false;
  try
  {
    dbNeedsEvolution =
      !db().areReleaseAndSchemaCompatible( releaseNumber, schemaVersion );
  } catch ( IncompatibleReleaseNumber& e ) {
    log() << coral::Error << "Exception caught: '"
          << e.what() << "'" << std::endl;
    log() << coral::Error
          << "Schema evolution is not possible for this database - abort"
          << coral::MessageStream::endmsg;
    throw e;
  }

  // DATABASE NEEDS SCHEMA EVOLUTION FROM 130 TO 200
  if ( dbNeedsEvolution )
  {
    log() << coral::Info
          << "Database needs schema evolution to 2.0.0: proceed"
          << coral::MessageStream::endmsg;
    if ( schemaVersion == "1.2.0" ) {
      std::stringstream msg;
      msg << "Schema evolution from schema version " << schemaVersion
          << " is not possible using this tool from release "
          << VersionInfo::release << ". Please evolve the schema in two steps:"
          << " first to 1.3.0 using the tools from the COOL 1.3 releases,"
          << " and then to 2.0.0 using the tools from the current release.";
      msg << " Schema evolution is not possible for this database - abort";
      log() << coral::Error << msg.str() << coral::MessageStream::endmsg;
      throw IncompatibleReleaseNumber( msg.str(), "RalSchemaEvolution" );
    } else if ( schemaVersion == "1.3.0" ) {
#ifndef _WIN32
      evolveDatabase_130_to_200();
#else
      // Schema evolution from 1.3.x is not supported any longer on Windows
      std::stringstream msg;
      msg << "ERROR! Schema evolution from COOL 1.3.x to "
          << VersionInfo::release << " is not supported on Windows: "
          << "please perform schema evolution "
          << "on a COOL 1.3.x supported platform";
      log() << coral::Error << msg.str() << coral::MessageStream::endmsg;
      throw RelationalException
        ( msg.str(), "RalSchemaEvolution" );
#endif
    } else {
      std::stringstream msg;
      msg << "Unsupported schema version: '" << schemaVersion << "'.";
      msg << " Schema evolution is not possible for this database - abort";
      log() << coral::Error << msg.str() << coral::MessageStream::endmsg;
      throw IncompatibleReleaseNumber( msg.str(), "RalSchemaEvolution" );
    }
  }
  // DATABASE DOES NOT NEED SCHEMA EVOLUTION FROM 130 TO 200
  else
  {
    log() << coral::Info
          << "Database does not need schema evolution to 2.0.0"
          << coral::MessageStream::endmsg;
  }

  // CHECK INDIVIDUAL NODES FOR SCHEMA EVOLUTION FROM 200 TO 220
  log() << coral::Info
        << "Alter MySQL SQL types and "
        << "check if individual nodes need schema evolution to 2.2.0"
        << coral::MessageStream::endmsg;
  evolveDatabase_200_to_220();

  // CHECK NODE TABLE FOR SCHEMA EVOLUTION FROM 220 TO 281
  log() << coral::Info
        << "Check if node table needs schema evolution to 2.8.1"
        << coral::MessageStream::endmsg;
  evolveDatabase_220_to_281();

  // GOODBYE
  transaction.commit();
  log() << coral::Info << "Evolve database schema... DONE!"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalSchemaEvolution::evolveDatabase_130_to_200()
{
  log() << coral::Info
        << "Evolve database schema (130->200)..."
        << coral::MessageStream::endmsg;

  // -------------------------------------------------------------------
  // Alter selected SQL types of columns in all existing tables:
  // (1a) Alter MySQL "VARCHAR(255) BINARY" into "VARCHAR(255) BINARY"
  // *** NB: This is actually a no-op in evolving schemas from COOL1xx to 200.
  // *** BINARY was by mistake added in versions COOL200 to 211 (bug #24393,
  // *** aka bug #26484). Schema version number remains 2.0.0 in the change
  // *** from COOL211 to 220 (there are no production databases on MySQL).
  // (1b) %%% DISABLED %%% Alter MySQL "TEXT" into "TEXT BINARY"
  // ( 2) Alter SQLite "LONG" into "INT"
  // ( 3) Alter SQLite "UNSIGNEDLONG" into "UNSIGNEDINT"
  // -------------------------------------------------------------------

  i_alterSqlTypes_130_to_200();

  // -------------------------------------------------------------------
  // Evolve the node table:
  // ( 4) Change the FOLDER_PAYLOADSPEC column size from 4k to 64k
  // ( 5) Add the FOLDER_PAYLOAD_INLINE column (default: NULL)
  // ( 6) Add the FOLDER_PAYLOAD_EXTREF column (default: NULL)
  // ( 7) Add the FOLDER_CHANNELSPEC column (default: NULL)
  // ( 8) Add the FOLDER_CHANNEL_EXTREF column (default: NULL)
  // ( 9) Add the FOLDER_CHANNELTABLENAME column (default: NULL)
  // (10) Add the LASTMOD_DATE column (default: NOW)
  // (11) Add the SCHEMA_VERSION column (default: 2.0.0)
  // (12) Update the versioning mode of the root "/" folder set to -1
  // (13) Add the UK constraint on (nodeFullPath)
  // (14) Add the UK constraint on (nodeId, nodeParentId)
  // -------------------------------------------------------------------

  i_evolveNodeTable_130_200();

  // -------------------------------------------------------------------
  // Evolve the global tag table:
  // (15) Add the TAG_LOCK_STATUS column (default: 0)
  // (16) Recreate the PK on (nodeId, tagId) - invert the present order
  // (17) Add the UK constraint on tagName
  // (18) Add the FK constraint on nodeId to the NODES table
  // -------------------------------------------------------------------

  i_evolveGlobalTagTable_130_200();

  // -------------------------------------------------------------------
  // Evolve the tag2tag table:
  // (19) Add the FK constraint on the parent tag to the TAGS table
  // (20) Add the FK constraint on the child tag to the TAGS table
  // (21) Add the FK constraint on the parent/child to the NODES table
  // -------------------------------------------------------------------

  i_evolveTag2TagTable_130_200();

  // -------------------------------------------------------------------
  // (22) Create the tag shared sequence
  // -------------------------------------------------------------------

  i_createTagSharedSequence_130_200();

  // -------------------------------------------------------------------
  // (23) Create the IOV shared sequence
  // -------------------------------------------------------------------

  i_createIovSharedSequence_130_200();

  // -------------------------------------------------------------------
  // Evolve each folder from 130 to 200
  // (24) Add the LASTMOD_DATE column (default: NOW) to each IOV table
  // (25) Create each channels table
  // (26) Update the node table with each channels table name
  // -------------------------------------------------------------------
  {
    // List all folders ordered by nodeId
    RecordSpecification whereDataSpec;
    whereDataSpec.extend( "isLeaf",
                          RelationalNodeTable::columnTypeIds::nodeIsLeaf );
    Record whereData( whereDataSpec );
    whereData["isLeaf"].setValue
      ( true ); // select folders only
    std::string whereClause = RelationalNodeTable::columnNames::nodeIsLeaf;
    whereClause += "= :isLeaf";
    std::string orderClause = RelationalNodeTable::columnNames::nodeId;
    orderClause += " ASC";
    RelationalQueryDefinition queryDef;
    queryDef.addFromItem( db().nodeTableName() );
    queryDef.addSelectItems( RelationalNodeTable::tableSpecification( VersionNumber( "1.3.0" ) ) );
    queryDef.setWhereClause( whereClause );
    queryDef.setBindVariables( whereData );
    queryDef.addOrderItem( orderClause );
    std::vector<RelationalTableRow> rows =
      db().queryMgr().fetchOrderedRows( queryDef );
    // Evolve all folders one by one
    for ( std::vector<RelationalTableRow>::const_iterator
            row = rows.begin(); row != rows.end(); ++row )
    {
      i_evolveIovTable_130_to_200( *row );
      i_createChannelsTable_130_to_200( *row );
      i_fillChannelsTableSV_130_to_200( *row );
      i_updateNodeTable_130_to_200( *row );
    }
  }

  // -------------------------------------------------------------------
  // Update the main database table
  // (27) Insert schema evolution metadata
  // (28) Update current database schema to 2.0.0
  // (29) Insert names of new top-level tables
  // -------------------------------------------------------------------

  i_evolveMainTable_130_to_200();

  // Success
  log() << coral::Info
        << "Evolve database schema (130->200)... DONE!"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalSchemaEvolution::i_evolveNodeTable_130_200()
{
  log() << coral::Info
        << "Evolve node table schema (130->200)... START"
        << coral::MessageStream::endmsg;
  std::string nodeTableName = db().nodeTableName();

  // 1. Change the folderPayloadSpecDesc column size from 4k to 64k
  // First attempt - this fails with ORA-22858 on Oracle
  // (cannot ALTER a non-CLOB column into a CLOB column)
  if ( false )
  {
    std::string columnName =
      RelationalNodeTable::columnNames::folderPayloadSpecDesc;
    const StorageType::TypeId columnTypeId =
      RelationalNodeTable::columnTypeIds::folderPayloadSpecDesc;
    const cool::StorageType& columnType =
      StorageType::storageType( columnTypeId );
    log() << coral::Info
          << "Node table needs schema evolution"
          << ": alter type of column '" << columnName
          << "' in table '" << nodeTableName
          << "' to type '" << columnType.name() << "'"
          << coral::MessageStream::endmsg;
    coral::ITable& table = db().sessionMgr()->session()
      .nominalSchema().tableHandle( nodeTableName );
    try
    {
      const bool fixedSize = false;
      table.schemaEditor().changeColumnType
        ( columnName,
          coral::AttributeSpecification::typeNameForId( columnType.cppType() ),
          columnType.maxSize(), fixedSize );
    }
    catch ( std::exception& e )
    {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to alter type of column '" << columnName
            << "' in table '" << nodeTableName
            << "' to type '" << columnType.name() << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
  }
  // Second attempt - workaround: rename the 4k column, add a new 64k column
  // with the correct name, copy the contents, then drop the old column
  if ( true ) {
    std::string columnName =
      RelationalNodeTable::columnNames::folderPayloadSpecDesc;
    const StorageType::TypeId columnTypeId =
      RelationalNodeTable::columnTypeIds::folderPayloadSpecDesc;
    const cool::StorageType& columnType =
      StorageType::storageType( columnTypeId );
    log() << coral::Info
          << "Node table needs schema evolution"
          << ": alter type of column '" << columnName
          << "' in table '" << nodeTableName
          << "' to type '" << columnType.name() << "'"
          << coral::MessageStream::endmsg;
    coral::ITable& table = db().sessionMgr()->session()
      .nominalSchema().tableHandle( nodeTableName );
    try
    {
      // Rename the old 4k column
      std::string columnName4k =
        RelationalNodeTable::columnNames::folderPayloadSpecDesc + "_TMP";
      table.schemaEditor().renameColumn( columnName, columnName4k );
      // Add a new 64k column
      const bool fixedSize = false;
      table.schemaEditor().insertColumn
        ( columnName,
          coral::AttributeSpecification::typeNameForId( columnType.cppType() ),
          columnType.maxSize(), fixedSize );
      // Copy the value of the old 4k column into the new 64k column
      std::string whereClause = ""; // No WHERE clause
      std::string setClause = columnName + "=" + columnName4k;
      Record updateData; // No bind variables
      db().queryMgr().updateTableRows
        ( nodeTableName, setClause, whereClause, updateData );
      // Drop the old 4k column
      table.schemaEditor().dropColumn( columnName4k );
    }
    catch ( std::exception& e )
    {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to alter type of column '" << columnName
            << "' in table '" << nodeTableName
            << "' to type '" << columnType.name() << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
  }

  // 2. Add the folderPayloadInline column.
  {
    std::string columnName =
      RelationalNodeTable::columnNames::folderPayloadInline;
    const StorageType::TypeId columnTypeId =
      RelationalNodeTable::columnTypeIds::folderPayloadInline;
    const cool::StorageType& columnType =
      StorageType::storageType( columnTypeId );
    log() << coral::Info
          << "Node table needs schema evolution"
          << ": add column '" << columnName
          << "' of type '" << columnType.name()
          << "' to table '" << nodeTableName << "'"
          << coral::MessageStream::endmsg;
    coral::ITable& table = db().sessionMgr()->session()
      .nominalSchema().tableHandle( nodeTableName );
    try {
      const bool fixedSize = false;
      table.schemaEditor().insertColumn
        ( columnName,
          coral::AttributeSpecification::typeNameForId( columnType.cppType() ),
          columnType.maxSize(), fixedSize );
    } catch ( std::exception& e ) {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to add column '" << columnName
            << "' of type '" << columnType.name()
            << "' to table '" << nodeTableName << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
  }

  // 3. Add the folderPayloadExtRef column.
  {
    std::string columnName =
      RelationalNodeTable::columnNames::folderPayloadExtRef;
    const StorageType::TypeId columnTypeId =
      RelationalNodeTable::columnTypeIds::folderPayloadExtRef;
    const cool::StorageType& columnType =
      StorageType::storageType( columnTypeId );
    log() << coral::Info
          << "Node table needs schema evolution"
          << ": add column '" << columnName
          << "' of type '" << columnType.name()
          << "' to table '" << nodeTableName << "'"
          << coral::MessageStream::endmsg;
    coral::ITable& table = db().sessionMgr()->session()
      .nominalSchema().tableHandle( nodeTableName );
    try {
      const bool fixedSize = false;
      table.schemaEditor().insertColumn
        ( columnName,
          coral::AttributeSpecification::typeNameForId( columnType.cppType() ),
          columnType.maxSize(), fixedSize );
    } catch ( std::exception& e ) {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to add column '" << columnName
            << "' of type '" << columnType.name()
            << "' to table '" << nodeTableName << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
  }

  // 4. Add the folderChannelSpecDesc column.
  {
    std::string columnName =
      RelationalNodeTable::columnNames::folderChannelSpecDesc;
    const StorageType::TypeId columnTypeId =
      RelationalNodeTable::columnTypeIds::folderChannelSpecDesc;
    const cool::StorageType& columnType =
      StorageType::storageType( columnTypeId );
    log() << coral::Info
          << "Node table needs schema evolution"
          << ": add column '" << columnName
          << "' of type '" << columnType.name()
          << "' to table '" << nodeTableName << "'"
          << coral::MessageStream::endmsg;
    coral::ITable& table = db().sessionMgr()->session()
      .nominalSchema().tableHandle( nodeTableName );
    try {
      const bool fixedSize = false;
      table.schemaEditor().insertColumn
        ( columnName,
          coral::AttributeSpecification::typeNameForId( columnType.cppType() ),
          columnType.maxSize(), fixedSize );
    } catch ( std::exception& e ) {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to add column '" << columnName
            << "' of type '" << columnType.name()
            << "' to table '" << nodeTableName << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
  }

  // 5. Add the folderChannelExtRef column.
  {
    std::string columnName =
      RelationalNodeTable::columnNames::folderChannelExtRef;
    const StorageType::TypeId columnTypeId =
      RelationalNodeTable::columnTypeIds::folderChannelExtRef;
    const cool::StorageType& columnType =
      StorageType::storageType( columnTypeId );
    log() << coral::Info
          << "Node table needs schema evolution"
          << ": add column '" << columnName
          << "' of type '" << columnType.name()
          << "' to table '" << nodeTableName << "'"
          << coral::MessageStream::endmsg;
    coral::ITable& table = db().sessionMgr()->session()
      .nominalSchema().tableHandle( nodeTableName );
    try {
      const bool fixedSize = false;
      table.schemaEditor().insertColumn
        ( columnName,
          coral::AttributeSpecification::typeNameForId( columnType.cppType() ),
          columnType.maxSize(), fixedSize );
    } catch ( std::exception& e ) {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to add column '" << columnName
            << "' of type '" << columnType.name()
            << "' to table '" << nodeTableName << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
  }

  // 6. Add the folderChannelTableName column.
  {
    std::string columnName =
      RelationalNodeTable::columnNames::folderChannelTableName;
    const StorageType::TypeId columnTypeId =
      RelationalNodeTable::columnTypeIds::folderChannelTableName;
    const cool::StorageType& columnType =
      StorageType::storageType( columnTypeId );
    log() << coral::Info
          << "Node table needs schema evolution"
          << ": add column '" << columnName
          << "' of type '" << columnType.name()
          << "' to table '" << nodeTableName << "'"
          << coral::MessageStream::endmsg;
    coral::ITable& table = db().sessionMgr()->session()
      .nominalSchema().tableHandle( nodeTableName );
    try {
      const bool fixedSize = false;
      table.schemaEditor().insertColumn
        ( columnName,
          coral::AttributeSpecification::typeNameForId( columnType.cppType() ),
          columnType.maxSize(), fixedSize );
    } catch ( std::exception& e ) {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to add column '" << columnName
            << "' of type '" << columnType.name()
            << "' to table '" << nodeTableName << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
  }

  // 7. Add the lastModDate column and set its value to NOW.
  {
    std::string columnName =
      RelationalNodeTable::columnNames::lastModDate;
    // Add the lastModDate column.
    const StorageType::TypeId columnTypeId =
      RelationalNodeTable::columnTypeIds::lastModDate;
    const cool::StorageType& columnType =
      StorageType::storageType( columnTypeId );
    log() << coral::Info
          << "Node table needs schema evolution"
          << ": add column '" << columnName
          << "' of type '" << columnType.name()
          << "' to table '" << nodeTableName << "'"
          << coral::MessageStream::endmsg;
    coral::ITable& table = db().sessionMgr()->session()
      .nominalSchema().tableHandle( nodeTableName );
    try {
      const bool fixedSize = false;
      table.schemaEditor().insertColumn
        ( columnName,
          coral::AttributeSpecification::typeNameForId( columnType.cppType() ),
          columnType.maxSize(), fixedSize );
    } catch ( std::exception& e ) {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to add column '" << columnName
            << "' of type '" << columnType.name()
            << "' to table '" << nodeTableName << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
    // Set the value of the lastModDate column to NOW.
    try
    {
      std::string whereClause = ""; // No WHERE clause
      std::string columnValue = RelationalQueryMgr::serverTimeClause
        ( db().sessionMgr()->databaseTechnology() );
      std::string setClause = columnName + "=" + columnValue;
      Record updateData; // No bind variables
      db().queryMgr().updateTableRows
        ( nodeTableName, setClause, whereClause, updateData );
    }
    catch ( std::exception& e )
    {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to update table '" << nodeTableName << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
  }

  // 8. Add the SCHEMA_VERSION column and set its value to 2.0.0.
  {
    std::string columnName =
      RelationalNodeTable::columnNames::nodeSchemaVersion;
    // Add the nodeSchemaVersion column.
    const StorageType::TypeId columnTypeId =
      RelationalNodeTable::columnTypeIds::nodeSchemaVersion;
    const cool::StorageType& columnType =
      StorageType::storageType( columnTypeId );
    log() << coral::Info
          << "Node table needs schema evolution"
          << ": add column '" << columnName
          << "' of type '" << columnType.name()
          << "' to table '" << nodeTableName << "'"
          << coral::MessageStream::endmsg;
    coral::ITable& table = db().sessionMgr()->session()
      .nominalSchema().tableHandle( nodeTableName );
    try {
      const bool fixedSize = false;
      table.schemaEditor().insertColumn
        ( columnName,
          coral::AttributeSpecification::typeNameForId( columnType.cppType() ),
          columnType.maxSize(), fixedSize );
    } catch ( std::exception& e ) {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to add column '" << columnName
            << "' of type '" << columnType.name()
            << "' to table '" << nodeTableName << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
    // Set the value of the nodeSchemaVersion column to 2.0.0.
    // *** NB Hardcode the value to '2.0.0' (as in COOL_2_0_0): for folders
    // *** (but not for folder sets), this will be changed later to '2.0.1'.
    try
    {
      std::string whereClause; // No WHERE clause
      std::string setClause =
        columnName + "='" + std::string( VersionInfo::schemaVersion ) + "'";
      Record updateData; // No bind variables
      db().queryMgr().updateTableRows
        ( nodeTableName, setClause, whereClause, updateData );
    }
    catch ( std::exception& e )
    {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to update table '" << nodeTableName << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
  }

  // 9. Update the versioning mode of the root "/" folder set to -1
  {
    std::string columnName =
      RelationalNodeTable::columnNames::folderVersioningMode;
    HvsPathHandler handler;
    std::stringstream noneMode;
    noneMode << cool_FolderVersioning_Mode::NONE;
    std::string rootFullPath = handler.rootFullPath();
    log() << coral::Info
          << "Node table needs schema evolution"
          << ": set value of column '" << columnName
          << "' to '" << noneMode.str()
          << "' for the root folder set '" << rootFullPath << "'"
          << coral::MessageStream::endmsg;
    try
    {
      std::string whereClause =
        RelationalNodeTable::columnNames::nodeFullPath
        + "='" + rootFullPath + "'";
      std::string setClause = columnName + "=" + noneMode.str();
      Record updateData; // No bind variables
      db().queryMgr().updateTableRows
        ( nodeTableName, setClause, whereClause, updateData, 1 );
    }
    catch ( std::exception& e )
    {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to update table '" << nodeTableName << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
  }

  // 10. Add the UK constraint on (nodeFullPath)
  {
    log() << coral::Info
          << "Node table needs schema evolution"
          << ": create UK constraint on (nodeFullPath)"
          << " in table '" << nodeTableName << "'"
          << coral::MessageStream::endmsg;
    coral::ITable& table = db().sessionMgr()->session()
      .nominalSchema().tableHandle( nodeTableName );
    try {
      table.schemaEditor().setUniqueConstraint
        ( RelationalNodeTable::columnNames::nodeFullPath,
          nodeTableName+"_FULLPATH_UK" );
    } catch ( std::exception& e ) {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to create UK constraint on (nodeFullPath)"
            << " in table '" << nodeTableName << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
  }

  // 11. Add the UK constraint on (nodeId, nodeParentId)
  {
    std::vector<std::string> ukColumns;
    ukColumns.push_back( RelationalNodeTable::columnNames::nodeId );
    ukColumns.push_back( RelationalNodeTable::columnNames::nodeParentId );
    log() << coral::Info
          << "Node table needs schema evolution"
          << ": create UK constraint on (nodeId, parentId)"
          << " in table '" << nodeTableName << "'"
          << coral::MessageStream::endmsg;
    coral::ITable& table = db().sessionMgr()->session()
      .nominalSchema().tableHandle( nodeTableName );
    try {
      table.schemaEditor().setUniqueConstraint
        ( ukColumns, nodeTableName+"_PARENT_UK" );
    } catch ( std::exception& e ) {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to create UK constraint on (nodeId, parentId)"
            << " in table '" << nodeTableName << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
  }

  // Success
  log() << coral::Info
        << "Evolve node table schema (130->200)... DONE!"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalSchemaEvolution::i_evolveGlobalTagTable_130_200()
{
  log() << coral::Info
        << "Evolve global tag table schema (130->200)... START"
        << coral::MessageStream::endmsg;
  std::string globalTagTableName = db().globalTagTableName();

  // 1. Add the tagLockStatus column and set its value to 0.
  {
    std::string columnName =
      RelationalGlobalTagTable::columnNames::tagLockStatus;
    const StorageType::TypeId columnTypeId =
      RelationalGlobalTagTable::columnTypeIds::tagLockStatus;
    const cool::StorageType& columnType =
      StorageType::storageType( columnTypeId );
    // Add the tagLockStatus column.
    log() << coral::Info
          << "Global tag table needs schema evolution"
          << ": add column '" << columnName
          << "' of type '" << columnType.name()
          << "' to table '" << globalTagTableName << "'"
          << coral::MessageStream::endmsg;
    coral::ITable& table = db().sessionMgr()->session()
      .nominalSchema().tableHandle( globalTagTableName );
    try {
      const bool fixedSize = false;
      table.schemaEditor().insertColumn
        ( columnName,
          coral::AttributeSpecification::typeNameForId( columnType.cppType() ),
          columnType.maxSize(), fixedSize );
    } catch ( std::exception& e ) {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to add column '" << columnName
            << "' of type '" << columnType.name()
            << "' to table '" << globalTagTableName << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
    // Set the value of the tagLockStatus column to 0.
    try
    {
      std::string whereClause; // No WHERE clause
      std::string setClause = columnName + "=0";
      Record updateData; // No bind variables
      db().queryMgr().updateTableRows
        ( globalTagTableName, setClause, whereClause, updateData );
    }
    catch ( std::exception& e )
    {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to update table '" << globalTagTableName << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
  }

  // 2. Recreate the PK on (nodeId, tagId) - invert the present order
  {
    log() << coral::Info
          << "Global tag table needs schema evolution"
          << ": recreate PK on (nodeId, tagId)"
          << " in table '" << globalTagTableName << "'"
          << coral::MessageStream::endmsg;
    std::vector<std::string> pkColumns;
    pkColumns.push_back( RelationalGlobalTagTable::columnNames::nodeId );
    pkColumns.push_back( RelationalGlobalTagTable::columnNames::tagId );
    coral::ITable& table = db().sessionMgr()->session()
      .nominalSchema().tableHandle( globalTagTableName );
    try {
      table.schemaEditor().dropPrimaryKey();
      table.schemaEditor().setPrimaryKey( pkColumns );
    } catch ( std::exception& e ) {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to recreate PK on (nodeId, tagId)"
            << " in table '" << globalTagTableName << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
  }

  // 3. Add the UK constraint on tagName
  {
    log() << coral::Info
          << "Global tag table needs schema evolution"
          << ": create UK constraint on (tagName)"
          << " in table '" << globalTagTableName << "'"
          << coral::MessageStream::endmsg;
    coral::ITable& table = db().sessionMgr()->session()
      .nominalSchema().tableHandle( globalTagTableName );
    try {
      table.schemaEditor().setUniqueConstraint
        ( RelationalTagTable::columnNames::tagName,
          globalTagTableName+"_TAGNAME_UK" );
    } catch ( std::exception& e ) {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to create UK constraint on (tagName)"
            << " in table '" << globalTagTableName << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
  }

  // 4. Add the FK constraint on nodeId to the NODES table
  {
    std::string columnNameSrc =
      RelationalGlobalTagTable::columnNames::nodeId;
    std::string columnNameTgt =
      RelationalNodeTable::columnNames::nodeId;
    std::string nodeTableName = db().nodeTableName();
    log() << coral::Info
          << "Global tag table needs schema evolution"
          << ": create FK reference from '" << columnNameSrc
          << "' in table '" << globalTagTableName
          << "' to '" << columnNameTgt
          << "' in table '" << nodeTableName << "'"
          << coral::MessageStream::endmsg;
    coral::ITable& table = db().sessionMgr()->session()
      .nominalSchema().tableHandle( globalTagTableName );
    try {
      table.schemaEditor().createForeignKey
        ( globalTagTableName + "_NODEID_FK", columnNameSrc,
          nodeTableName, columnNameTgt );
    } catch ( std::exception& e ) {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to create FK reference from '" << columnNameSrc
            << "' in table '" << globalTagTableName
            << "' to '" << columnNameTgt
            << "' in table '" << nodeTableName << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
  }

  // Success
  log() << coral::Info
        << "Evolve global tag table schema (130->200)... DONE"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalSchemaEvolution::i_evolveTag2TagTable_130_200()
{
  log() << coral::Info
        << "Evolve tag2tag table schema (130->200)... START"
        << coral::MessageStream::endmsg;
  std::string tag2TagTableName = db().tag2TagTableName();

  // 1. Add the FK constraint on the parent tag to the TAGS table
  {
    std::string globalTagTableName = db().globalTagTableName();
    std::vector<std::string> fkColumnsSrc;
    fkColumnsSrc.push_back
      ( RelationalTag2TagTable::columnNames::parentNodeId );
    fkColumnsSrc.push_back
      ( RelationalTag2TagTable::columnNames::parentTagId );
    std::vector<std::string> fkColumnsTgt;
    fkColumnsTgt.push_back
      ( RelationalGlobalTagTable::columnNames::nodeId );
    fkColumnsTgt.push_back
      ( RelationalGlobalTagTable::columnNames::tagId );
    log() << coral::Info
          << "Tag2tag table needs schema evolution"
          << ": create FK reference from parent tag"
          << " in table '" << tag2TagTableName
          << "' to parent tag"
          << " in table '" << globalTagTableName << "'"
          << coral::MessageStream::endmsg;
    coral::ITable& table = db().sessionMgr()->session()
      .nominalSchema().tableHandle( tag2TagTableName );
    try {
      table.schemaEditor().createForeignKey
        ( tag2TagTableName + "_PTAG_FK", fkColumnsSrc,
          globalTagTableName, fkColumnsTgt );
    } catch ( std::exception& e ) {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to create FK reference from parent tag"
            << " in table '" << tag2TagTableName
            << "' to parent tag"
            << " in table '" << globalTagTableName << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
  }

  // 2. Add the FK constraint on the child tag to the TAGS table
  {
    std::string globalTagTableName = db().globalTagTableName();
    std::vector<std::string> fkColumnsSrc;
    fkColumnsSrc.push_back
      ( RelationalTag2TagTable::columnNames::childNodeId );
    fkColumnsSrc.push_back
      ( RelationalTag2TagTable::columnNames::childTagId );
    std::vector<std::string> fkColumnsTgt;
    fkColumnsTgt.push_back
      ( RelationalGlobalTagTable::columnNames::nodeId );
    fkColumnsTgt.push_back
      ( RelationalGlobalTagTable::columnNames::tagId );
    log() << coral::Info
          << "Tag2tag table needs schema evolution"
          << ": create FK reference from child tag"
          << " in table '" << tag2TagTableName
          << "' to child tag"
          << " in table '" << globalTagTableName << "'"
          << coral::MessageStream::endmsg;
    coral::ITable& table = db().sessionMgr()->session()
      .nominalSchema().tableHandle( tag2TagTableName );
    try {
      table.schemaEditor().createForeignKey
        ( tag2TagTableName + "_CTAG_FK", fkColumnsSrc,
          globalTagTableName, fkColumnsTgt );
    } catch ( std::exception& e ) {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to create FK reference from child tag"
            << " in table '" << tag2TagTableName
            << "' to child tag"
            << " in table '" << globalTagTableName << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
  }

  // 3. Add the FK constraint on the parent/child to the NODES table
  {
    std::string nodeTableName = db().nodeTableName();
    std::vector<std::string> fkColumnsSrc;
    fkColumnsSrc.push_back
      ( RelationalTag2TagTable::columnNames::childNodeId );
    fkColumnsSrc.push_back
      ( RelationalTag2TagTable::columnNames::parentNodeId );
    std::vector<std::string> fkColumnsTgt;
    fkColumnsTgt.push_back
      ( RelationalNodeTable::columnNames::nodeId );
    fkColumnsTgt.push_back
      ( RelationalNodeTable::columnNames::nodeParentId );
    log() << coral::Info
          << "Tag2tag table needs schema evolution"
          << ": create FK reference from parent/child"
          << " in table '" << tag2TagTableName
          << "' to parent/child"
          << " in table '" << nodeTableName << "'"
          << coral::MessageStream::endmsg;
    coral::ITable& table = db().sessionMgr()->session()
      .nominalSchema().tableHandle( tag2TagTableName );
    try {
      table.schemaEditor().createForeignKey
        ( tag2TagTableName + "_NODES_FK", fkColumnsSrc,
          nodeTableName, fkColumnsTgt );
    } catch ( std::exception& e ) {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to create FK reference from parent/child"
            << " in table '" << tag2TagTableName
            << "' to parent/child"
            << " in table '" << nodeTableName << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
  }

  // Success
  log() << coral::Info
        << "Evolve tag2tag table schema (130->200)... DONE"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalSchemaEvolution::i_createTagSharedSequence_130_200()
{
  log() << coral::Info
        << "Create tag shared sequence (130->200)... START"
        << coral::MessageStream::endmsg;
  const Record& dbAttr = db().databaseAttributes();
  std::string defaultTablePrefix =
    dbAttr[RelationalDatabaseTable::attributeNames::defaultTablePrefix]
    .data<std::string>();
  std::string tagSharedSequenceName =
    RelationalTagSharedSequenceTable::defaultTableName( defaultTablePrefix );

  // 1. Create the tag shared sequence
  {
    std::string nodeTableName = db().nodeTableName();
    log() << coral::Info
          << "Database needs schema evolution"
          << ": create tag shared sequence"
          << " table '" << tagSharedSequenceName << "'"
          << coral::MessageStream::endmsg;
    try {
      db().schemaMgr().createSharedSequence
        ( tagSharedSequenceName, nodeTableName );
    } catch ( std::exception& e ) {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to create tag shared sequence"
            << " table '" << tagSharedSequenceName << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
  }

  // Success
  log() << coral::Info
        << "Create tag shared sequence (130->200)... DONE"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalSchemaEvolution::i_createIovSharedSequence_130_200()
{
  log() << coral::Info
        << "Create IOV shared sequence (130->200)... START"
        << coral::MessageStream::endmsg;
  const Record& dbAttr = db().databaseAttributes();
  std::string defaultTablePrefix =
    dbAttr[RelationalDatabaseTable::attributeNames::defaultTablePrefix]
    .data<std::string>();
  std::string iovSharedSequenceName =
    RelationalIovSharedSequenceTable::defaultTableName( defaultTablePrefix );

  // 1. Create the IOV shared sequence
  {
    std::string nodeTableName = db().nodeTableName();
    log() << coral::Info
          << "Database needs schema evolution"
          << ": create IOV shared sequence"
          << " table '" << iovSharedSequenceName << "'"
          << coral::MessageStream::endmsg;
    try {
      db().schemaMgr().createSharedSequence
        ( iovSharedSequenceName, nodeTableName );
    } catch ( std::exception& e ) {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to create IOV shared sequence"
            << " table '" << iovSharedSequenceName << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
  }

  // Success
  log() << coral::Info
        << "Create IOV shared sequence (130->200)... DONE"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalSchemaEvolution::i_evolveIovTable_130_to_200
( const RelationalTableRow& row )
{
  log() << coral::Info
        << "Evolve IOV table schema (130->200)... START"
        << coral::MessageStream::endmsg;
  std::string fullPath =
    row[RelationalNodeTable::columnNames::nodeFullPath]
    .data<std::string>();
  std::string objectTableName =
    row[RelationalNodeTable::columnNames::folderObjectTableName]
    .data<std::string>();

  // 1. Add the lastModDate column and set its value to NOW.
  std::string columnName = RelationalObjectTable::columnNames::lastModDate();
  // Add the lastModDate column.
  // This is done by simply altering the table to add the column at the end:
  // with respect to tables created by COOL14x, the column order is different.
  const StorageType::TypeId columnTypeId =
    RelationalObjectTable::columnTypeIds::lastModDate;
  const cool::StorageType& columnType =
    StorageType::storageType( columnTypeId );
  log() << coral::Info
        << "Folder '" << fullPath << "' needs schema evolution"
        << ": add column '" << columnName
        << "' of type '" << columnType.name()
        << "' to table '" << objectTableName << "'"
        << coral::MessageStream::endmsg;
  coral::ITable& table = db().sessionMgr()->session()
    .nominalSchema().tableHandle( objectTableName );
  try {
    const bool fixedSize = false;
    table.schemaEditor().insertColumn
      ( columnName,
        coral::AttributeSpecification::typeNameForId( columnType.cppType() ),
        columnType.maxSize(), fixedSize );
  } catch ( std::exception& e ) {
    log() << coral::Error
          << "Exception caught: '" << e.what() << "'"
          << coral::MessageStream::endmsg;
    log() << coral::Error
          << "Failed to add column '" << columnName
          << "' of type '" << columnType.name()
          << "' to table '" << objectTableName << "'"
          << coral::MessageStream::endmsg;
    throw RelationalException
      ( "Schema evolution failed", "RalSchemaEvolution" );
  }
  // Set the value of the lastModDate column to NOW.
  try
  {
    std::string whereClause = ""; // No WHERE clause
    std::string columnValue = RelationalQueryMgr::serverTimeClause
      ( db().sessionMgr()->databaseTechnology() );
    std::string setClause = columnName + "=" + columnValue;
    Record updateData; // No bind variables
    db().queryMgr().updateTableRows
      ( objectTableName, setClause, whereClause, updateData );
  }
  catch ( std::exception& e )
  {
    log() << coral::Error
          << "Exception caught: '" << e.what() << "'"
          << coral::MessageStream::endmsg;
    log() << coral::Error
          << "Failed to update table '" << objectTableName << "'"
          << coral::MessageStream::endmsg;
    throw RelationalException
      ( "Schema evolution failed", "RalSchemaEvolution" );
  }

  // Success
  log() << coral::Info
        << "Evolve IOV table schema (130->200)... DONE!"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalSchemaEvolution::i_evolveMainTable_130_to_200()
{
  log() << coral::Info
        << "Evolve main table schema (130->200)... START"
        << coral::MessageStream::endmsg;
  std::string mainTableName = db().mainTableName();
  RelationalDatabaseTable::columnTypes::attributeName attrName;
  RelationalDatabaseTable::columnTypes::attributeValue attrValue;

  // 1a. Insert new rows:
  // X_Y_Z_SE_OLD_RELEASE (previous RELEASE before X_Y_Z upgrade)
  // X_Y_Z_SE_OLD_SCHEMA_VERSION (previous SCHEMA_VERSION before X_Y_Z upgrade)
  // X_Y_Z_SE_TIME (time of the X_Y_Z upgrade)
  try
  {
    const Record& dbAttr = db().databaseAttributes();
    std::string defaultTablePrefix =
      dbAttr[RelationalDatabaseTable::attributeNames::defaultTablePrefix]
      .data<std::string>();
    std::string oldRelease =
      dbAttr[RelationalDatabaseTable::attributeNames::release]
      .data<std::string>();
    std::string oldSchemaVersion =
      dbAttr[RelationalDatabaseTable::attributeNames::schemaVersion]
      .data<std::string>();
    RecordSpecification dataSpec;
    dataSpec.extend( RelationalDatabaseTable::columnNames::attributeName,
                     RelationalDatabaseTable::columnTypeIds::attributeName );
    dataSpec.extend( RelationalDatabaseTable::columnNames::attributeValue,
                     RelationalDatabaseTable::columnTypeIds::attributeValue );
    Record data( dataSpec );

    // X_Y_Z_SE_OLD_RELEASE (previous RELEASE before X_Y_Z upgrade)
    attrName = VersionInfo::schemaEvolutionPrefix + "OLD_" +
      RelationalDatabaseTable::attributeNames::release;
    attrValue = oldRelease;
    data[RelationalDatabaseTable::columnNames::attributeName]
      .setValue( attrName );
    data[RelationalDatabaseTable::columnNames::attributeValue]
      .setValue( attrValue );
    db().queryMgr().insertTableRow( mainTableName, data );

    // X_Y_Z_SE_OLD_SCHEMA_VERSION (previous SCHEMA_VERSION before XYZ upgrade)
    attrName = VersionInfo::schemaEvolutionPrefix + "OLD_" +
      RelationalDatabaseTable::attributeNames::schemaVersion;
    attrValue = oldSchemaVersion;
    data[RelationalDatabaseTable::columnNames::attributeName]
      .setValue( attrName );
    data[RelationalDatabaseTable::columnNames::attributeValue]
      .setValue( attrValue );
    db().queryMgr().insertTableRow( mainTableName, data );

    // X_Y_Z_SE_TIME (time of the X_Y_Z upgrade)
    // NB THIS ONLY INSERTS THE ROW - need SQL injection via UPDATE statement
    attrName = VersionInfo::schemaEvolutionPrefix + "TIME";
    attrValue = RelationalQueryMgr::serverTimeClause
      ( db().sessionMgr()->databaseTechnology() );
    RelationalQueryMgr::serverTimeClause
      ( db().sessionMgr()->databaseTechnology() );
    data[RelationalDatabaseTable::columnNames::attributeName]
      .setValue( attrName );
    data[RelationalDatabaseTable::columnNames::attributeValue]
      .setValue( attrValue );
    db().queryMgr().insertTableRow( mainTableName, data );
  }
  catch ( std::exception& e )
  {
    log() << coral::Error
          << "Exception caught: '" << e.what() << "'"
          << coral::MessageStream::endmsg;
    log() << coral::Error
          << "Failed to insert schema evolution metadata"
          << " into table '" << mainTableName << "'"
          << coral::MessageStream::endmsg;
    throw RelationalException
      ( "Schema evolution failed", "RalSchemaEvolution" );
  }

  // 1b. Update the value of X_Y_Z_SE_TIME
  try
  {
    std::string whereClause =
      RelationalDatabaseTable::columnNames::attributeName
      + "='" + attrName + "'";
    std::string setClause =
      RelationalDatabaseTable::columnNames::attributeValue
      + "=" + attrValue;
    Record updateData; // No bind variables
    db().queryMgr().updateTableRows
      ( mainTableName, setClause, whereClause, updateData, 1 );
  }
  catch ( std::exception& e )
  {
    log() << coral::Error
          << "Exception caught: '" << e.what() << "'"
          << coral::MessageStream::endmsg;
    log() << coral::Error
          << "Failed to update table '" << mainTableName << "'"
          << coral::MessageStream::endmsg;
    throw RelationalException
      ( "Schema evolution failed", "RalSchemaEvolution" );
  }

  // 2. Update the values of already existing rows.
  try
  {
    RecordSpecification updateDataSpec;
    updateDataSpec.extend
      ( "newAttrValue",
        RelationalDatabaseTable::columnTypeIds::attributeValue );
    updateDataSpec.extend
      ( "attrName",
        RelationalDatabaseTable::columnTypeIds::attributeName );
    Record updateData( updateDataSpec );
    std::string setClause =
      RelationalDatabaseTable::columnNames::attributeValue + "=:newAttrValue";
    std::string whereClause =
      RelationalDatabaseTable::columnNames::attributeName + "=:attrName";
    // RELEASE (after X_Y_Z upgrade)
    updateData["newAttrValue"].setValue<std::string>
      ( VersionInfo::release );
    updateData["attrName"].setValue
      ( RelationalDatabaseTable::attributeNames::release );
    db().queryMgr().updateTableRows
      ( mainTableName, setClause, whereClause, updateData, 1 );
    // SCHEMA_VERSION (after X_Y_Z upgrade)
    updateData["newAttrValue"].setValue<std::string>
      ( VersionInfo::schemaVersion );
    updateData["attrName"].setValue
      ( RelationalDatabaseTable::attributeNames::schemaVersion );
    db().queryMgr().updateTableRows
      ( mainTableName, setClause, whereClause, updateData, 1 );
    // CVS_CHECKOUT (after X_Y_Z upgrade)
    updateData["newAttrValue"].setValue<std::string>
      ( VersionInfo::cvsCheckout );
    updateData["attrName"].setValue
      ( RelationalDatabaseTable::attributeNames::cvsCheckout );
    db().queryMgr().updateTableRows
      ( mainTableName, setClause, whereClause, updateData, 1 );
    // CVS_CHECKIN (after X_Y_Z upgrade)
    updateData["newAttrValue"].setValue<std::string>
      ( VersionInfo::cvsCheckin );
    updateData["attrName"].setValue
      ( RelationalDatabaseTable::attributeNames::cvsCheckin );
    db().queryMgr().updateTableRows
      ( mainTableName, setClause, whereClause, updateData, 1 );
  }
  catch ( std::exception& e )
  {
    log() << coral::Error
          << "Exception caught: '" << e.what() << "'"
          << coral::MessageStream::endmsg;
    log() << coral::Error
          << "Failed to update table '" << mainTableName << "'"
          << coral::MessageStream::endmsg;
    throw RelationalException
      ( "Schema evolution failed", "RalSchemaEvolution" );
  }

  // 3. Insert new rows with the names of the new top-level tables
  try
  {
    const Record& dbAttr = db().databaseAttributes();
    std::string defaultTablePrefix =
      dbAttr[RelationalDatabaseTable::attributeNames::defaultTablePrefix]
      .data<std::string>();
    std::string tagSharedSequenceName =
      RelationalTagSharedSequenceTable::defaultTableName( defaultTablePrefix );
    std::string iovSharedSequenceName =
      RelationalIovSharedSequenceTable::defaultTableName( defaultTablePrefix );
    RecordSpecification dataSpec;
    dataSpec.extend( RelationalDatabaseTable::columnNames::attributeName,
                     RelationalDatabaseTable::columnTypeIds::attributeName );
    dataSpec.extend( RelationalDatabaseTable::columnNames::attributeValue,
                     RelationalDatabaseTable::columnTypeIds::attributeValue );
    Record data( dataSpec );

    // Tag shared sequence name
    attrName = RelationalDatabaseTable::attributeNames::tagSharedSequenceName;
    attrValue = tagSharedSequenceName;
    data[RelationalDatabaseTable::columnNames::attributeName]
      .setValue( attrName );
    data[RelationalDatabaseTable::columnNames::attributeValue]
      .setValue( attrValue );
    db().queryMgr().insertTableRow( mainTableName, data );

    // IOV shared sequence name
    attrName = RelationalDatabaseTable::attributeNames::iovSharedSequenceName;
    attrValue = iovSharedSequenceName;
    data[RelationalDatabaseTable::columnNames::attributeName]
      .setValue( attrName );
    data[RelationalDatabaseTable::columnNames::attributeValue]
      .setValue( attrValue );
    db().queryMgr().insertTableRow( mainTableName, data );
  }
  catch ( std::exception& e )
  {
    log() << coral::Error
          << "Exception caught: '" << e.what() << "'"
          << coral::MessageStream::endmsg;
    log() << coral::Error
          << "Failed to insert names of new top-level tables"
          << " into table '" << mainTableName << "'"
          << coral::MessageStream::endmsg;
    throw RelationalException
      ( "Schema evolution failed", "RalSchemaEvolution" );
  }

  // Success
  log() << coral::Info
        << "Evolve main table schema (130->200)... DONE!"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalSchemaEvolution::i_createChannelsTable_130_to_200
( const RelationalTableRow& row )
{
  unsigned int nodeId =
    row[RelationalNodeTable::columnNames::nodeId].data<unsigned int>();
  std::string channelTableName =
    RelationalChannelTable::defaultTableName
    ( db().defaultTablePrefix(), nodeId );
  log() << coral::Info
        << "Creating channels table " << channelTableName
        << " (130->200)..." << coral::MessageStream::endmsg;
  db().schemaMgr().createChannelTable( channelTableName );
  log() << coral::Info
        << "Creating channels table " << channelTableName
        << " (130->200)... DONE!" << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalSchemaEvolution::i_fillChannelsTableSV_130_to_200
( const RelationalTableRow& row )
{
  int folderVersioningMode =
    row[RelationalNodeTable::columnNames::folderVersioningMode].data<int>();

  // Only SV folders need to be updated
  if ( folderVersioningMode != (int)cool_FolderVersioning_Mode::SINGLE_VERSION ) return;

  unsigned int nodeId =
    row[RelationalNodeTable::columnNames::nodeId].data<unsigned int>();
  std::string channelTableName =
    RelationalChannelTable::defaultTableName
    ( db().defaultTablePrefix(), nodeId );
  log() << coral::Info
        << "Fill the SV channels table " << channelTableName
        << " (130->200)..." << coral::MessageStream::endmsg;

  std::string objectTableName =
    row[RelationalNodeTable::columnNames::folderObjectTableName]
    .data<std::string>();
  std::vector<ChannelId> channels = listChannels( objectTableName );

  for ( std::vector<ChannelId>::const_iterator
          ch = channels.begin(); ch != channels.end(); ++ch )
  {
    //std::cout << "Channel: " << *ch << std::endl;
    RelationalObjectTableRow objRow = fetchLastRow( objectTableName, *ch );
    bool hasNewData = false;
    std::string channelName = "";
    std::string description = "";
    insertChannelTableRow( channelTableName,
                           *ch,
                           objRow.objectId(),
                           hasNewData,
                           channelName,
                           description );
  }

  log() << coral::Info
        << "Fill the SV channels table " << channelTableName
        << " (130->200)... DONE!" << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalSchemaEvolution::i_updateNodeTable_130_to_200
( const RelationalTableRow& row )
{
  unsigned int nodeId =
    row[RelationalNodeTable::columnNames::nodeId].data<unsigned int>();

  // 1. Update FOLDER_CHANNELTABLENAME
  {
    std::string channelTableName =
      RelationalChannelTable::defaultTableName
      ( db().defaultTablePrefix(), nodeId );
    log() << coral::Info
          << "Updating channels table name " << channelTableName
          << " in node table (130->200)..." << coral::MessageStream::endmsg;
    std::string columnName =
      RelationalNodeTable::columnNames::folderChannelTableName;
    RecordSpecification updateDataSpec;
    updateDataSpec.extend
      ( "channelTableName",
        RelationalNodeTable::columnTypeIds::folderChannelTableName );
    updateDataSpec.extend
      ( "nodeId",
        RelationalNodeTable::columnTypeIds::nodeId );
    Record updateData( updateDataSpec );
    updateData["channelTableName"].setValue( channelTableName );
    updateData["nodeId"].setValue( nodeId );
    std::string setClause = columnName + "=:channelTableName";
    std::string whereClause =
      RelationalNodeTable::columnNames::nodeId + "=:nodeId";
    unsigned int expectedRows = 1;
    if ( ! db().queryMgr().updateTableRows
         ( db().nodeTableName(), setClause, whereClause,
           updateData, expectedRows ) )
    {
      log() << coral::Error
            << "Failed to set value in column '" << columnName
            << "' of table '" << db().nodeTableName() << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
    log() << coral::Info
          << "Updating channels table name " << channelTableName
          << " in node table (130->200)... DONE!"
          << coral::MessageStream::endmsg;
  }

  // 2. Update FOLDER_PAYLOADSPEC
  {
    log() << coral::Info
          << "Updating folder payload specification "
          << " in node table (130->200)..." << coral::MessageStream::endmsg;
    std::string oldSpecDesc =
      row[RelationalNodeTable::columnNames::folderPayloadSpecDesc]
      .data<std::string>();
    RecordSpecification spec = decodeRecordSpecification130( oldSpecDesc );
    std::string newSpecDesc =
      RelationalDatabase::encodeRecordSpecification( spec );
    std::string columnName =
      RelationalNodeTable::columnNames::folderPayloadSpecDesc;
    RecordSpecification updateDataSpec;
    updateDataSpec.extend
      ( "payloadSpecDesc",
        RelationalNodeTable::columnTypeIds::folderPayloadSpecDesc );
    updateDataSpec.extend
      ( "nodeId",
        RelationalNodeTable::columnTypeIds::nodeId );
    Record updateData( updateDataSpec );
    updateData["payloadSpecDesc"].setValue( newSpecDesc );
    updateData["nodeId"].setValue( nodeId );
    std::string setClause = columnName + "=:payloadSpecDesc";
    std::string whereClause =
      RelationalNodeTable::columnNames::nodeId + "=:nodeId";
    unsigned int expectedRows = 1;
    if ( ! db().queryMgr().updateTableRows
         ( db().nodeTableName(), setClause, whereClause,
           updateData, expectedRows ) )
    {
      log() << coral::Error
            << "Failed to set value in column '" << columnName
            << "' of table '" << db().nodeTableName() << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
    log() << coral::Info
          << "Updating folder payload specification "
          << " in node table (130->200)... DONE!"
          << coral::MessageStream::endmsg;
  }
}

//-----------------------------------------------------------------------------

const RecordSpecification
RalSchemaEvolution::decodeRecordSpecification130
( const std::string& encodedEALS )
{
  RecordSpecification recordSpec;
  if ( !encodedEALS.empty() ) {
    std::string::size_type pos = 0;
    while ( pos != encodedEALS.npos ) {
      std::string::size_type newpos = encodedEALS.find( ',', pos );
      std::string item_str;
      if ( newpos != encodedEALS.npos )
        item_str = encodedEALS.substr(pos,newpos-pos);
      else
        item_str = encodedEALS.substr(pos);
      std::string::size_type separator_pos = item_str.find(':');
      if ( separator_pos == item_str.npos )
        throw RelationalException
          ( std::string
            ( "Bad format, ':' not found in encoded EALSpecification '" )
            + encodedEALS + "'", "RalSchemaEvolution" );
      recordSpec.extend
        ( item_str.substr( 0, separator_pos ),
          RalSchemaEvolution::storageType130
          ( item_str.substr( separator_pos+1 ) ) );
      pos = ( newpos != encodedEALS.npos ) ? newpos+1 : newpos;
    }
  }
  return recordSpec;
}

//-----------------------------------------------------------------------------

const StorageType&
RalSchemaEvolution::storageType130( const std::string& name )
{
  if ( name == "bool:DEF" )
    return StorageType::storageType( cool_StorageType_TypeId::Bool );
  //if ( name == "..." )
  //  return StorageType::storageType( cool_StorageType_TypeId::Char ); // NOT IN 2.0.0
  if ( name == "unsigned char:DEF" )
    return StorageType::storageType( cool_StorageType_TypeId::UChar );
  if ( name == "short:DEF" )
    return StorageType::storageType( cool_StorageType_TypeId::Int16 );
  if ( name == "unsigned short:DEF" )
    return StorageType::storageType( cool_StorageType_TypeId::UInt16 );
  if ( name == "int:DEF" )
    return StorageType::storageType( cool_StorageType_TypeId::Int32 );
  if ( name == "long:DEF" )
    return StorageType::storageType( cool_StorageType_TypeId::Int32 );  // ONLY IN 1.3.0
  if ( name == "unsigned int:DEF" )
    return StorageType::storageType( cool_StorageType_TypeId::UInt32 );
  if ( name == "unsigned long:DEF" )
    return StorageType::storageType( cool_StorageType_TypeId::UInt32 );  // ONLY IN 1.3.0
  if ( name == "unsigned long long:uInt63" )
    return StorageType::storageType( cool_StorageType_TypeId::UInt63 );
  //if ( name == "..." )
  //  return StorageType::storageType( cool_StorageType_TypeId::Int64 ); // NEW IN 2.0.0!
  //if ( name == "..." )
  //  return StorageType::storageType( cool_StorageType_TypeId::UInt64 ); // NOT IN 2.0.0
  if ( name == "float:DEF" )
    return StorageType::storageType( cool_StorageType_TypeId::Float );
  if ( name == "double:DEF" )
    return StorageType::storageType( cool_StorageType_TypeId::Double );
  if ( name == "string:255" )
    return StorageType::storageType( cool_StorageType_TypeId::String255 );
  if ( name == "string:4000" )
    return StorageType::storageType( cool_StorageType_TypeId::String4k );
  if ( name == "string:64K" )
    return StorageType::storageType( cool_StorageType_TypeId::String64k );
  if ( name == "string:16M" )
    return StorageType::storageType( cool_StorageType_TypeId::String16M );
  //if ( name == "..." )
  //  return StorageType::storageType( cool_StorageType_TypeId::Blob64k ); // NEW IN 2.2.0!
  //if ( name == "..." )
  //  return StorageType::storageType( cool_StorageType_TypeId::Blob16M ); // NEW IN 2.2.0!
  throw RelationalException
    ( "PANIC! No 200 StorageType corresponds to 130 encoded type " + name,
      "RalSchemaEvolution" );
}

//-----------------------------------------------------------------------------

const std::vector<ChannelId>
RalSchemaEvolution::listChannels( const std::string& objectTableName ) const
{
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( objectTableName );
  std::string channelIdLabel = std::string( "DISTINCT " ) + RelationalObjectTable::columnNames::channelId();
  queryDef.addSelectItem( channelIdLabel,
                          RelationalObjectTable::columnTypeIds::channelId );
  queryDef.addOrderItem
    ( RelationalObjectTable::columnNames::channelId() + " ASC" );
  std::vector<RelationalTableRow> rows =
    db().queryMgr().fetchOrderedRows( queryDef ); // no WHERE clause
  std::vector<ChannelId> channels;
  for ( std::vector<RelationalTableRow>::const_iterator
          row = rows.begin(); row != rows.end(); ++row )
  {
    ChannelId channel =
      ( *row )[ channelIdLabel ]
      .data<ChannelId>(); // PORT: possibly <unsigned int> needed here instead
    channels.push_back( channel );
  }
  return channels;
}

//-----------------------------------------------------------------------------

RelationalObjectTableRow
RalSchemaEvolution::fetchLastRow( const std::string& objectTableName,
                                  const ChannelId& channelId )
{
  // The "last object" inserted in each channel of a SV folder is retrieved
  // as the object with the highest objectId in that channel (two possible
  // alternatives could be to use the highest iovSince or iovUntil).
  // The present algorithm uses two queries:
  // 1. First, select max(objectId) in the given channel
  // 2. Then, retrieve the full row for the object wih id=maxId

  // QUERY 1: select max(objectId) for the given channel
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
  queryDef.addFromItem( objectTableName );
  queryDef.addSelectItem( maxObjectIdName,
                          RelationalObjectTable::columnTypeIds::objectId );
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );
  ObjectId maxObjectId;
  try
  {
    RelationalTableRow maxObjectIdRow =
      db().queryMgr().fetchOrderedRows( queryDef, "", 1 )[0]; // expect 1 row
    maxObjectId = maxObjectIdRow[ maxObjectIdName ].data<ObjectId>();
  }
  catch( NoRowsFound& )
  {
    throw ObjectNotFound
      ( "max(objectId)", objectTableName, "RalSchemaEvolution" );
  }

  // QUERY 2: select * for objectId = max(objectId)
  return
    fetchRowForId( objectTableName, maxObjectId );

}

//---------------------------------------------------------------------------

void RalSchemaEvolution::i_alterSqlTypes_130_to_200()
{
  log() << coral::Info
        << "Alter SQL types (130->200)... START"
        << coral::MessageStream::endmsg;

  // Schema evolution of SQL types is only needed for MySQL and SQLite
  std::string tech = db().sessionMgr()->databaseTechnology();
  if ( tech == "Oracle" )
  {
    log() << coral::Info
          << "Schema evolution of SQL types is NOT needed for technology '"
          << tech << "'" << coral::MessageStream::endmsg;
  }
  else if ( tech == "frontier" )
  {
    log() << coral::Error
          << "Schema evolution is not possible for read/only technology '"
          << tech << "'" << coral::MessageStream::endmsg;
    throw RelationalException
      ( "Schema evolution failed", "RalSchemaEvolution" );
  }
  else if ( tech != "MySQL" && tech != "SQLite" )
  {
    log() << coral::Error
          << "Unknown technology '" << tech << "'"
          << coral::MessageStream::endmsg;
    throw RelationalException
      ( "Schema evolution failed", "RalSchemaEvolution" );
  }
  else
  {
    log() << coral::Info
          << "Schema evolution of SQL types is needed for technology '"
          << tech << "'" << coral::MessageStream::endmsg;
    const std::vector<std::string> tables = db().listAllTables();
    std::vector<std::string>::const_iterator iTable;
    for ( iTable = tables.begin(); iTable != tables.end(); iTable++ )
    {
      std::string tableName = *iTable;
      log() << coral::Info
            << "Scan columns of table '" << tableName << "'"
            << coral::MessageStream::endmsg;
      coral::ITable& table = db().sessionMgr()->session()
        .nominalSchema().tableHandle( tableName );
      int nCol = table.description().numberOfColumns();
      for ( int iCol = 0; iCol < nCol; iCol++ )
      {
        const coral::IColumn& column =
          table.description().columnDescription(iCol);
        //log() << coral::Verbose
        //      << "--> Column '" << column.name() << "'"
        //      << ", type '" << column.type() << "'"
        //      << ", size=" << column.size()
        //      << ", isSizeFixed '" << column.isSizeFixed() << "'"
        //      << coral::MessageStream::endmsg;
        const std::string name = column.name();
        std::string type = column.type();
        long size = column.size();
        const bool isSizeFixed = column.isSizeFixed();
        if ( ( tech=="SQLite" && ( type=="long" || type=="unsigned long" ) ) ||
             ( tech=="MySQL" && ( type=="string" && size==255 ) ) )
          //( tech=="MySQL" && ( type=="string" ) ) ) // disable TEXT BINARY
        {
          log() << coral::Info
                << "Alter SQL type of column '" << name << "'"
                << " (type " << type << ", size " << size << ")"
                << " in table '" << tableName << "'"
                << coral::MessageStream::endmsg;
          if ( tech=="SQLite" && type=="long" ) type="int";
          if ( tech=="SQLite" && type=="unsigned long" ) type="unsigned int";
          table.schemaEditor().changeColumnType
            ( name, type, size, isSizeFixed );
        }
      }
    }
  }

  // Success
  log() << coral::Info
        << "Alter SQL types (130->200)... DONE"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

const RelationalObjectTableRow
RalSchemaEvolution::fetchRowForId( const std::string& objectTableName,
                                   const unsigned int objectId ) const
{
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
  queryDef.addFromItem( objectTableName );
  queryDef.addSelectItems // fetch only the IOV metadata, not the payload
    ( RelationalObjectTable::defaultSpecification() );
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );
  try
  {
    return RelationalObjectTableRow
      ( db().queryMgr().fetchOrderedRows( queryDef, "", 1 )[0] ); // exp 1 row
  }
  catch( NoRowsFound& )
  {
    std::stringstream s;
    s << "object_id: " << objectId;
    throw ObjectNotFound
      ( s.str(), objectTableName, "RalSchemaEvolution" );
  }
}

//---------------------------------------------------------------------------

void RalSchemaEvolution::insertChannelTableRow
( const std::string& channelTableName,
  const ChannelId& channelId,
  const unsigned int lastObjectId,
  const bool hasNewData,
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
  db().queryMgr().insertTableRow( channelTableName, data );
}

//-----------------------------------------------------------------------------

void RalSchemaEvolution::evolveDatabase_200_to_220()
{
  log() << coral::Info
        << "Evolve database schema (200->220)..."
        << coral::MessageStream::endmsg;

  // -------------------------------------------------------------------
  // Alter selected SQL types of columns in all existing tables:
  // ( 1) Alter MySQL "VARCHAR(255)" into "VARCHAR(255) BINARY"
  // -------------------------------------------------------------------

  i_alterSqlTypes_200_to_220();

  // -------------------------------------------------------------------
  // Evolve each folder from 200 to 220
  // ( 1) Fill the channels tables of all MV folders
  // (2a) Create the 5-column index for user tags (task #4381) if needed
  // (2b) Add FK constraints (on channelId) to each IOV table
  // ( 3) Update the node table with new folder schema versions '2.0.1'
  // -------------------------------------------------------------------

  i_evolveNodes_200_to_220();

  // Success
  log() << coral::Info
        << "Evolve database schema (200->220)... DONE!"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalSchemaEvolution::i_alterSqlTypes_200_to_220()
{
  log() << coral::Info
        << "Alter SQL types (200->220)... START"
        << coral::MessageStream::endmsg;

  // Schema evolution of SQL types is only needed for MySQL
  std::string tech = db().sessionMgr()->databaseTechnology();
  if ( tech == "Oracle" || tech == "SQLite")
  {
    log() << coral::Info
          << "Schema evolution of SQL types is NOT needed for technology '"
          << tech << "'" << coral::MessageStream::endmsg;
  }
  else if ( tech == "frontier" )
  {
    log() << coral::Error
          << "Schema evolution is not possible for read/only technology '"
          << tech << "'" << coral::MessageStream::endmsg;
    throw RelationalException
      ( "Schema evolution failed", "RalSchemaEvolution" );
  }
  else if ( tech != "MySQL" )
  {
    log() << coral::Error
          << "Unknown technology '" << tech << "'"
          << coral::MessageStream::endmsg;
    throw RelationalException
      ( "Schema evolution failed", "RalSchemaEvolution" );
  }
  else
  {
    log() << coral::Info
          << "Schema evolution of SQL types is needed for technology '"
          << tech << "'" << coral::MessageStream::endmsg;
    const std::vector<std::string> tables = db().listAllTables();
    std::vector<std::string>::const_iterator iTable;
    for ( iTable = tables.begin(); iTable != tables.end(); iTable++ )
    {
      std::string tableName = *iTable;
      log() << coral::Info
            << "Scan columns of table '" << tableName << "'"
            << coral::MessageStream::endmsg;
      coral::ITable& table = db().sessionMgr()->session()
        .nominalSchema().tableHandle( tableName );
      int nCol = table.description().numberOfColumns();
      for ( int iCol = 0; iCol < nCol; iCol++ )
      {
        const coral::IColumn& column =
          table.description().columnDescription(iCol);
        //log() << coral::Verbose
        //      << "--> Column '" << column.name() << "'"
        //      << ", type '" << column.type() << "'"
        //      << ", size=" << column.size()
        //      << ", isSizeFixed '" << column.isSizeFixed() << "'"
        //      << coral::MessageStream::endmsg;
        const std::string name = column.name();
        std::string type = column.type();
        long size = column.size();
        const bool isSizeFixed = column.isSizeFixed();
        if ( ( tech=="MySQL" && ( type=="string" && size==255 ) ) )
        {
          log() << coral::Info
                << "Alter SQL type of column '" << name << "'"
                << " (type " << type << ", size " << size << ")"
                << " in table '" << tableName << "'"
                << coral::MessageStream::endmsg;
          if ( tech=="SQLite" && type=="long" ) type="int";
          if ( tech=="SQLite" && type=="unsigned long" ) type="unsigned int";
          table.schemaEditor().changeColumnType
            ( name, type, size, isSizeFixed );
        }
      }
    }
  }

  // Success
  log() << coral::Info
        << "Alter SQL types (200->220)... DONE"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalSchemaEvolution::i_evolveNodes_200_to_220()
{
  log() << coral::Info
        << "Evolve individual nodes (200->220) if needed..."
        << coral::MessageStream::endmsg;

  {
    const PayloadMode::Mode payloadMode = cool_PayloadMode_Mode::INLINEPAYLOAD; // no payload table in the 220 schema
    // List all folders ordered by nodeId
    RecordSpecification whereDataSpec;
    whereDataSpec.extend( "isLeaf",
                          RelationalNodeTable::columnTypeIds::nodeIsLeaf );
    Record whereData( whereDataSpec );
    whereData["isLeaf"].setValue( true ); // select folders only
    std::string whereClause = RelationalNodeTable::columnNames::nodeIsLeaf;
    whereClause += "= :isLeaf";
    std::string orderClause = RelationalNodeTable::columnNames::nodeId;
    orderClause += " ASC";
    RelationalQueryDefinition queryDef;
    queryDef.addFromItem( db().nodeTableName() );
    queryDef.addSelectItems( RelationalNodeTable::tableSpecification( VersionNumber( "2.0.0" ) ) );
    queryDef.setWhereClause( whereClause );
    queryDef.setBindVariables( whereData );
    queryDef.addOrderItem( orderClause );
    std::vector<RelationalTableRow> rows =
      db().queryMgr().fetchOrderedRows( queryDef );
    // Evolve all folders one by one
    bool evolveNone = true;
    for ( std::vector<RelationalTableRow>::const_iterator
            row = rows.begin(); row != rows.end(); ++row )
    {
      std::string fullPath =
        (*row)[RelationalNodeTable::columnNames::nodeFullPath]
        .data<std::string>();
      std::string nodeSchemaVersion =
        (*row)[RelationalNodeTable::columnNames::nodeSchemaVersion]
        .data<std::string>();
      if ( nodeSchemaVersion !=
           std::string( RelationalFolder::folderSchemaVersion(payloadMode) ) )
      {
        evolveNone = false;
        log() << coral::Info
              << "Folder '" << fullPath << "' needs schema evolution"
              << " from schema version '" << nodeSchemaVersion << "' to '"
              << RelationalFolder::folderSchemaVersion( payloadMode )
              << "'" << coral::MessageStream::endmsg;
        i_fillChannelsTableMV_200_to_220( *row );
        i_evolveIovTable_200_to_220( *row );
        i_updateNodeTable_200_to_220( *row );
      }
      else
      {
        log() << coral::Verbose
              << "Folder '" << fullPath << "' is already schema version '"
              << RelationalFolder::folderSchemaVersion( payloadMode )
              << "' and needs no schema evolution"
              << coral::MessageStream::endmsg;
      }
    }
    if ( evolveNone )
      log() << coral::Info
            << "All folders are already schema version '"
            << RelationalFolder::folderSchemaVersion( payloadMode )
            << "' and need no schema evolution"
            << coral::MessageStream::endmsg;
  }

  // Success
  log() << coral::Info
        << "Evolve individual nodes (200->220) if needed... DONE!"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalSchemaEvolution::i_fillChannelsTableMV_200_to_220
( const RelationalTableRow& row )
{
  int folderVersioningMode =
    row[RelationalNodeTable::columnNames::folderVersioningMode].data<int>();

  // Only MV folders need to be updated
  if ( folderVersioningMode != (int)cool_FolderVersioning_Mode::MULTI_VERSION ) return;

  unsigned int nodeId =
    row[RelationalNodeTable::columnNames::nodeId].data<unsigned int>();
  std::string channelTableName =
    RelationalChannelTable::defaultTableName
    ( db().defaultTablePrefix(), nodeId );
  log() << coral::Info
        << "Fill the MV channels table " << channelTableName
        << " (200->220)..." << coral::MessageStream::endmsg;

  std::string objectTableName =
    row[RelationalNodeTable::columnNames::folderObjectTableName]
    .data<std::string>();
  std::vector<ChannelId> channels = listChannels( objectTableName );

  for ( std::vector<ChannelId>::const_iterator
          ch = channels.begin(); ch != channels.end(); ++ch )
  {
    log() << coral::Verbose
          << "Fill the MV channels table " << channelTableName
          << " (200->220)..."
          << " Insert channel: " << *ch << coral::MessageStream::endmsg;
    RelationalObjectTableRow objRow = fetchLastRow( objectTableName, *ch );
    bool hasNewData = false;
    std::string channelName = "";
    std::string description = "";
    // Avoid CORAL error messages by changing the output level
    coral::MsgLevel outputLevel = coral::MessageStream::msgVerbosity();
    try
    {
      coral::MessageStream::setMsgVerbosity( coral::Fatal );
      insertChannelTableRow( channelTableName,
                             *ch,
                             objRow.objectId(),
                             hasNewData,
                             channelName,
                             description );
      coral::MessageStream::setMsgVerbosity( outputLevel );
    }
    // Ignore any rows already present in the channels table (fix bug #30361)
    catch ( coral::DuplicateEntryInUniqueKeyException& )
    {
      coral::MessageStream::setMsgVerbosity( outputLevel ); // OK?
      log() << coral::Warning
            << "Fill the MV channels table " << channelTableName
            << " (200->220)..."
            << " channel " << *ch << " already exists"
            << coral::MessageStream::endmsg;
    }
    // Debug printout for bug #45716
    catch ( std::exception& e )
    {
      coral::MessageStream::setMsgVerbosity( outputLevel ); // OK?
      log() << coral::Warning
            << "Fill the MV channels table " << channelTableName
            << " (200->220)..."
            << " Exception caught while inserting channel " << *ch
            << ": " << e.what() << coral::MessageStream::endmsg;
      log() << coral::Warning
            << "Exception will be rethrown" << coral::MessageStream::endmsg;
      throw;
    }
  }

  log() << coral::Info
        << "Fill the MV channels table " << channelTableName
        << " (200->220)... DONE!" << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalSchemaEvolution::i_evolveIovTable_200_to_220
( const RelationalTableRow& row )
{
  log() << coral::Info
        << "Evolve IOV table schema (200->220)... START"
        << coral::MessageStream::endmsg;
  std::string fullPath =
    row[RelationalNodeTable::columnNames::nodeFullPath]
    .data<std::string>();
  std::string objectTableName =
    row[RelationalNodeTable::columnNames::folderObjectTableName]
    .data<std::string>();
  std::string channelTableName =
    row[RelationalNodeTable::columnNames::folderChannelTableName]
    .data<std::string>();

  // 1. Add the 5-column index for user tags (task #4381) if needed
  {
    std::string indexName = objectTableName + "_UTAG_5INDX";
    log() << coral::Info
          << "Folder '" << fullPath << "' needs schema evolution"
          << ": add index '" << indexName
          << "' to table '" << objectTableName
          << "' if needed" << coral::MessageStream::endmsg;
    try
    {
      coral::ITable& objectTable = db().sessionMgr()->session()
        .nominalSchema().tableHandle( objectTableName );
      const coral::ITableDescription& description = objectTable.description();
      unsigned int nInd = description.numberOfIndices();
      bool indexExists = false;
      for ( unsigned iInd = 0; iInd < nInd; iInd++ )
      {
        if ( description.index( iInd ).name() == indexName )
          indexExists = true;
      }
      if ( !indexExists )
      {
        coral::ITableSchemaEditor& editor = objectTable.schemaEditor();
        std::vector<std::string> indColumns;
        indColumns.push_back
          ( RelationalObjectTable::columnNames::userTagId() );
        indColumns.push_back
          ( RelationalObjectTable::columnNames::newHeadId() );
        indColumns.push_back
          ( RelationalObjectTable::columnNames::channelId() );
        indColumns.push_back
          ( RelationalObjectTable::columnNames::iovSince() );
        indColumns.push_back
          ( RelationalObjectTable::columnNames::iovUntil() );
        bool unique = true;
        editor.createIndex( indexName, indColumns, unique );
      }
      else
      {
        log() << coral::Info
              << "Index '" << indexName << "' already exists in table '"
              << objectTableName << coral::MessageStream::endmsg;
      }
    }
    catch ( std::exception& e )
    {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed add index '" << indexName
            << "' to table '" << objectTableName
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
  }

  // 2. Add the FK constraint from the object table to the channel table
  {
    log() << coral::Info
          << "Folder '" << fullPath << "' needs schema evolution"
          << ": create FK reference from channels"
          << " in table '" << objectTableName
          << "' to channels"
          << " in table '" << channelTableName << "'"
          << coral::MessageStream::endmsg;
    try
    {
      db().schemaMgr().createObjectChannelFK
        ( objectTableName, channelTableName );
    }
    catch ( std::exception& e )
    {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to create FK reference from channels"
            << " in table '" << objectTableName
            << "' to channels"
            << " in table '" << channelTableName << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
  }

  // Success
  log() << coral::Info
        << "Evolve IOV table schema (200->220)... DONE!"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalSchemaEvolution::i_updateNodeTable_200_to_220
( const RelationalTableRow& row )
{
  unsigned int nodeId =
    row[RelationalNodeTable::columnNames::nodeId].data<unsigned int>();

  // 1. Update NODE_SCHEMA_VERSION
  {
    const PayloadMode::Mode payloadMode = cool_PayloadMode_Mode::INLINEPAYLOAD; // no payload table in the 220 schema
    log() << coral::Info
          << "Updating folder schema version to "
          << RelationalFolder::folderSchemaVersion( payloadMode )
          << " in node table (200->220)..." << coral::MessageStream::endmsg;
    std::string columnName =
      RelationalNodeTable::columnNames::nodeSchemaVersion;
    RecordSpecification updateDataSpec;
    updateDataSpec.extend
      ( "nodeSchemaVersion",
        RelationalNodeTable::columnTypeIds::nodeSchemaVersion );
    updateDataSpec.extend
      ( "nodeId",
        RelationalNodeTable::columnTypeIds::nodeId );
    Record updateData( updateDataSpec );
    updateData["nodeSchemaVersion"].setValue<std::string>
      ( RelationalFolder::folderSchemaVersion( payloadMode ) );
    updateData["nodeId"].setValue( nodeId );
    std::string setClause = columnName + "=:nodeSchemaVersion";
    std::string whereClause =
      RelationalNodeTable::columnNames::nodeId + "=:nodeId";
    unsigned int expectedRows = 1;
    if ( ! db().queryMgr().updateTableRows
         ( db().nodeTableName(), setClause, whereClause,
           updateData, expectedRows ) )
    {
      log() << coral::Error
            << "Failed to set value in column '" << columnName
            << "' of table '" << db().nodeTableName() << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
    log() << coral::Info
          << "Updating folder schema version to "
          << RelationalFolder::folderSchemaVersion( payloadMode )
          << " in node table (200->220)... DONE!"
          << coral::MessageStream::endmsg;
  }
}

//-----------------------------------------------------------------------------

void RalSchemaEvolution::evolveDatabase_220_to_281()
{
  log() << coral::Info
        << "Evolve database schema (220->281)..."
        << coral::MessageStream::endmsg;

  // -------------------------------------------------------------------
  // Update node table by replacing NULL with 0 or "".
  // ( 1) Update the FOLDER_PAYLOAD_INLINE column (from NULL to 0)
  // ( 2) Update the FOLDER_PAYLOAD_EXTREF column (from NULL to '')
  // ( 3) Update the FOLDER_CHANNELSPEC column (from NULL to '')
  // ( 4) Update the FOLDER_CHANNEL_EXTREF column (from NULL to '')
  // ( 5) Update the FOLDER_CHANNELTABLENAME column (from NULL to '')
  // -------------------------------------------------------------------

  i_updateNodeTable_220_to_281();

  // Success
  log() << coral::Info
        << "Evolve database schema (220->281)... DONE!"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalSchemaEvolution::i_updateNodeTable_220_to_281()
{
  // 1. Update the FOLDER_PAYLOAD_INLINE column (from NULL to 0)
  {
    std::string columnName =
      RelationalNodeTable::columnNames::folderPayloadInline;
    log() << coral::Info
          << "Updating NULL column " << columnName
          << " in node table (200->220)..." << coral::MessageStream::endmsg;
    std::string setClause = columnName + "=0";
    std::string whereClause = columnName + " IS NULL";
    Record updateData; // No bind variables
    try
    {
      db().queryMgr().updateTableRows
        ( db().nodeTableName(), setClause, whereClause, updateData  );
    }
    catch ( std::exception& e )
    {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to set value in column '" << columnName
            << "' of table '" << db().nodeTableName() << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
    log() << coral::Info
          << "Updating NULL column " << columnName
          << " in node table (200->220)... DONE!"
          << coral::MessageStream::endmsg;
  }
  // 2. Update the FOLDER_PAYLOAD_EXTREF column (from NULL to '')
  {
    std::string columnName =
      RelationalNodeTable::columnNames::folderPayloadExtRef;
    log() << coral::Info
          << "Updating NULL column " << columnName
          << " in node table (200->220)..." << coral::MessageStream::endmsg;
    std::string setClause = columnName + "=''";
    std::string whereClause = columnName + " IS NULL";
    Record updateData; // No bind variables
    try
    {
      db().queryMgr().updateTableRows
        ( db().nodeTableName(), setClause, whereClause, updateData  );
    }
    catch ( std::exception& e )
    {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to set value in column '" << columnName
            << "' of table '" << db().nodeTableName() << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
    log() << coral::Info
          << "Updating NULL column " << columnName
          << " in node table (200->220)... DONE!"
          << coral::MessageStream::endmsg;
  }
  // 3. Update the FOLDER_CHANNELSPEC column (from NULL to '')
  {
    std::string columnName =
      RelationalNodeTable::columnNames::folderChannelSpecDesc;
    log() << coral::Info
          << "Updating NULL column " << columnName
          << " in node table (200->220)..." << coral::MessageStream::endmsg;
    std::string setClause = columnName + "=''";
    std::string whereClause = columnName + " IS NULL";
    Record updateData; // No bind variables
    try
    {
      db().queryMgr().updateTableRows
        ( db().nodeTableName(), setClause, whereClause, updateData  );
    }
    catch ( std::exception& e )
    {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to set value in column '" << columnName
            << "' of table '" << db().nodeTableName() << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
    log() << coral::Info
          << "Updating NULL column " << columnName
          << " in node table (200->220)... DONE!"
          << coral::MessageStream::endmsg;
  }
  // 4. Update the FOLDER_CHANNEL_EXTREF column (from NULL to '')
  {
    std::string columnName =
      RelationalNodeTable::columnNames::folderChannelExtRef;
    log() << coral::Info
          << "Updating NULL column " << columnName
          << " in node table (200->220)..." << coral::MessageStream::endmsg;
    std::string setClause = columnName + "=''";
    std::string whereClause = columnName + " IS NULL";
    Record updateData; // No bind variables
    try
    {
      db().queryMgr().updateTableRows
        ( db().nodeTableName(), setClause, whereClause, updateData  );
    }
    catch ( std::exception& e )
    {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to set value in column '" << columnName
            << "' of table '" << db().nodeTableName() << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
    log() << coral::Info
          << "Updating NULL column " << columnName
          << " in node table (200->220)... DONE!"
          << coral::MessageStream::endmsg;
  }
  // 5. Update the FOLDER_CHANNELTABLENAME column (from NULL to '')
  {
    std::string columnName =
      RelationalNodeTable::columnNames::folderChannelTableName;
    log() << coral::Info
          << "Updating NULL column " << columnName
          << " in node table (200->220)..." << coral::MessageStream::endmsg;
    std::string setClause = columnName + "=''";
    std::string whereClause = columnName + " IS NULL";
    Record updateData; // No bind variables
    try
    {
      db().queryMgr().updateTableRows
        ( db().nodeTableName(), setClause, whereClause, updateData  );
    }
    catch ( std::exception& e )
    {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error
            << "Failed to set value in column '" << columnName
            << "' of table '" << db().nodeTableName() << "'"
            << coral::MessageStream::endmsg;
      throw RelationalException
        ( "Schema evolution failed", "RalSchemaEvolution" );
    }
    log() << coral::Info
          << "Updating NULL column " << columnName
          << " in node table (200->220)... DONE!"
          << coral::MessageStream::endmsg;
  }
}

//-----------------------------------------------------------------------------
