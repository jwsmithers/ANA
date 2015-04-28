// Include files
#include "CoolKernel/Record.h"
#include "CoolKernel/FolderVersioning.h"
#include "CoralBase/Attribute.h"

// Local include files
#include "RalSchemaValidation.h"
#include "../../src/HvsPathHandler.h"
#include "../../src/HvsPathHandlerException.h"
#include "../../src/RalDatabase.h"
#include "../../src/RelationalChannelTable.h"
#include "../../src/RelationalDatabaseTable.h"
#include "../../src/RelationalException.h"
#include "../../src/RelationalFolder.h"
#include "../../src/RelationalNodeTable.h"
#include "../../src/RelationalObjectTable.h"
#include "../../src/RelationalQueryDefinition.h"
#include "../../src/RelationalQueryMgr.h"
#include "../../src/RelationalTableRow.h"
#include "../../src/RelationalTagSequence.h"
#include "../../src/RelationalTransaction.h"
#include "../../src/RelationalSequenceTable.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

RalSchemaValidation::RalSchemaValidation( RalDatabase* db )
  : m_db( db )
  , m_log( new coral::MessageStream
           ( "RalSchemaValidation" ) )
  , m_fatal( false )
{
  log() << coral::Info
        << "Instantiate a RalSchemaValidation manager for '"
        << m_db->databaseId() << "'" << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

RalSchemaValidation::~RalSchemaValidation()
{
  log() << coral::Info
        << "Delete the RalSchemaValidation manager for '"
        << m_db->databaseId() << "'" << coral::MessageStream::endmsg;
  if ( ! m_fatal )
  {
    if ( m_errors.size() == 0 && m_warnings.size() == 0 )
    {
      std::cout << "All seems ok - no errors and no warnings" << std::endl;
    }
    else
    {
      unsigned ierr = 0;
      for ( std::vector<std::string>::const_iterator
              err = m_errors.begin(); err != m_errors.end(); ++err )
      {
        ierr++;
        std::cout << "ERROR (" << ierr << "/" << m_errors.size()
                  << "): " << *err << std::endl;
      }
      unsigned iwarn = 0;
      for ( std::vector<std::string>::const_iterator
              warn = m_warnings.begin(); warn != m_warnings.end(); ++warn )
      {
        iwarn++;
        std::cout << "WARNING (" << iwarn << "/" << m_warnings.size()
                  << "): " << *warn << std::endl;
      }
    }
  }
}

//-----------------------------------------------------------------------------

coral::MessageStream& RalSchemaValidation::log()
{
  *m_log << coral::Verbose;
  return *m_log;
}

//-----------------------------------------------------------------------------

void RalSchemaValidation::validateDatabase()
{
  // WELCOME
  log() << coral::Info
        << "Validate database schema... START" << coral::MessageStream::endmsg;
  RelationalTransaction transaction( db().transactionMgr(), true ); // r/o

  // Can the schema of this database be validated?
  const Record& dbAttr = db().databaseAttributes();
  std::string releaseNumber =
    dbAttr[RelationalDatabaseTable::attributeNames::release]
    .data<std::string>();
  std::string schemaVersion =
    dbAttr[RelationalDatabaseTable::attributeNames::schemaVersion].
    data<std::string>();
  log() << coral::Info
        << "Database release number: " << releaseNumber
        << coral::MessageStream::endmsg;
  log() << coral::Info
        << "Database schema version: " << schemaVersion
        << coral::MessageStream::endmsg;

  // VALIDATE THE DATABASE SCHEMA
  validateDatabase_28x();

  // GOODBYE
  transaction.commit();
  log() << coral::Info
        << "Validate database schema... DONE!" << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalSchemaValidation::validateDatabase_28x()
{
  log() << coral::Info
        << "Validate database schema (28x)..." << coral::MessageStream::endmsg;

  // -------------------------------------------------------------------
  // Check SQL types of columns in all existing tables (220):
  // (..) ..to be implemented..
  // -------------------------------------------------------------------

  //i_checkSqlTypes_220();

  // -------------------------------------------------------------------
  // Check all nodes (220):
  // ( 1) Check that channels tables exist for all folders
  // ( 2) Check that tagSequence tables exist for all nodes but SV folders
  // -------------------------------------------------------------------

  i_checkNodeTables_220();

  // -------------------------------------------------------------------
  // Check all nodes (222):
  // ( 3) Check the names of all nodes
  // -------------------------------------------------------------------

  i_checkNodeNames_222();

  // -------------------------------------------------------------------
  // Check all nodes (28x):
  // ( 4) Check that for all nodes the inline payload mode is not null
  // ( 5) Check that for all folder sets inlineMode is 0 and extRef == ""
  // ( 6) Check that for all folders inlineMode is 0/1 and extRef ==/!= ""
  // ( 7) Check that for all nodes the value of the external ref payload
  // ( 8) Check that all folders with inlineMode 0/1 are version 201/280
  // ( 9) Check the schema of the channels tables of all folders
  // -------------------------------------------------------------------

  i_checkNodes_28x();

  // Success
  log() << coral::Info
        << "Validate database schema (28x)... DONE!"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

/*
void RalSchemaValidation::i_checkSqlTypes_220()
{
  log() << coral::Info
        << "Check SQL types (220)... START" << coral::MessageStream::endmsg;

  // Success
  log() << coral::Info
        << "Check SQL types (220)... DONE" << coral::MessageStream::endmsg;
}
*///

//-----------------------------------------------------------------------------

void RalSchemaValidation::i_checkNodes_28x()
{
  log() << coral::Info
        << "Check individual nodes (28x)..." << coral::MessageStream::endmsg;

  {
    // Internal cross-checks of the tool
    VersionNumber version201( "2.0.1" );
    if ( version201 !=
         std::string( RelationalFolder::folderSchemaVersion( cool_PayloadMode_Mode::INLINEPAYLOAD ) ) )
    {
      std::stringstream msg;
      msg << "PANIC! Folder schema version for this software release is '"
          << RelationalFolder::folderSchemaVersion( cool_PayloadMode_Mode::INLINEPAYLOAD )
          << "' without payload table (expected: '" << version201 << "'):"
          << " please update the schemaValidation tool" << std::endl;
      log() << coral::Fatal << msg.str() << coral::MessageStream::endmsg;
      m_fatal = true;
      throw RelationalException( msg.str(), "RalSchemaValidation" );
    }
    VersionNumber version280( "2.8.0" );
    if ( version280 !=
         std::string( RelationalFolder::folderSchemaVersion( cool_PayloadMode_Mode::SEPARATEPAYLOAD ) ) )
    {
      std::stringstream msg;
      msg << "PANIC! Folder schema version for this software release is '"
          << RelationalFolder::folderSchemaVersion( cool_PayloadMode_Mode::SEPARATEPAYLOAD )
          << "' with payload table (expected: '" << version280 << "'):"
          << " please update the schemaValidation tool" << std::endl;
      log() << coral::Fatal << msg.str() << coral::MessageStream::endmsg;
      m_fatal = true;
      throw RelationalException( msg.str(), "RalSchemaValidation" );
    }
    // List all nodes (folders and folder sets) ordered by nodeId
    std::string orderClause = RelationalNodeTable::columnNames::nodeId;
    orderClause += " ASC";
    RelationalQueryDefinition queryDef;
    queryDef.addFromItem( db().nodeTableName() );
    queryDef.addSelectItems( RelationalNodeTable::tableSpecification
                             ( VersionNumber( "2.0.0" ) ) );
    queryDef.addOrderItem( orderClause );
    std::vector<RelationalTableRow> rows =
      db().queryMgr().fetchOrderedRows( queryDef ); // no WHERE clause
    // Check all nodes one by one
    bool evolveNone = true;
    for ( std::vector<RelationalTableRow>::const_iterator
            row = rows.begin(); row != rows.end(); ++row )
    {
      std::string fullPath =
        (*row)[RelationalNodeTable::columnNames::nodeFullPath]
        .data<std::string>();
      VersionNumber nodeSchemaVersion =
        (*row)[RelationalNodeTable::columnNames::nodeSchemaVersion]
        .data<std::string>();
      bool isLeaf =
        (*row)[RelationalNodeTable::columnNames::nodeIsLeaf]
        .data<bool>();
      std::string payloadTableName =
        (*row)[RelationalNodeTable::columnNames::folderPayloadExtRef]
        .data<std::string>();
      // Check that the inline payload mode is not null (28x)
      UInt16 payloadMode;
      if ( (*row)[RelationalNodeTable::columnNames::folderPayloadInline]
           .isNull() )
      {
        std::stringstream msg;
        msg << ( isLeaf ? "Folder" : "Folder set" ) << " '" << fullPath
            << "' is assigned NULL inline payload mode: reinterpreted as == 0";
        log() << coral::Warning << msg.str() << coral::MessageStream::endmsg;
        m_warnings.push_back( msg.str() );
        payloadMode = 0;
      }
      else
      {
        payloadMode =
          (*row)[RelationalNodeTable::columnNames::folderPayloadInline]
          .data<UInt16>();
      }
      //-------------
      // Folder sets
      //-------------
      if ( ! isLeaf )
      {
        // Check that for folder sets inlineMode is 0 and extRef == "" (28x).
        if ( payloadMode != 0 )
        {
          std::stringstream msg;
          msg << "PANIC! Unknown payload mode " << payloadMode
              << " for folder set '" << fullPath << "' (expected: 0):"
              << " data corruption?" << std::endl;
          log() << coral::Fatal << msg.str() << coral::MessageStream::endmsg;
          m_fatal = true;
          throw RelationalException( msg.str(), "RalSchemaValidation" );
        }
        if ( payloadTableName != "" )
        {
          std::stringstream msg;
          msg << "PANIC! External ref for folder set '" << fullPath << "':"
              << " data corruption?" << std::endl;
          log() << coral::Fatal << msg.str() << coral::MessageStream::endmsg;
          m_fatal = true;
          throw RelationalException( msg.str(), "RalSchemaValidation" );
        }
      }
      //-------------
      // Folders
      //-------------
      else
      {
        // Check that for folders inlineMode is 0/1 and extRef ==/!= "" (28x).
        if ( payloadMode != 0 && payloadMode != 1 )
        {
          std::stringstream msg;
          msg << "PANIC! Unknown payload mode " << payloadMode
              << " for folder '" << fullPath << "' (expected: 0 or 1):"
              << " data corruption?" << std::endl;
          log() << coral::Fatal << msg.str() << coral::MessageStream::endmsg;
          m_fatal = true;
          throw RelationalException( msg.str(), "RalSchemaValidation" );
        }
        else if ( payloadMode == 0 && payloadTableName != "" )
        {
          std::stringstream msg;
          msg << "PANIC! External ref in payload mode 0"
              << " for folder '" << fullPath << "':"
              << " data corruption?" << std::endl;
          log() << coral::Fatal << msg.str() << coral::MessageStream::endmsg;
          m_fatal = true;
          throw RelationalException( msg.str(), "RalSchemaValidation" );
        }
        else if ( payloadMode == 1 && payloadTableName == "" )
        {
          std::stringstream msg;
          msg << "PANIC! No external ref in payload mode 1"
              << " for folder '" << fullPath << "':"
              << " data corruption?" << std::endl;
          log() << coral::Fatal << msg.str() << coral::MessageStream::endmsg;
          m_fatal = true;
          throw RelationalException( msg.str(), "RalSchemaValidation" );
        }
        // Check that folders with inlineMode 0/1 are version 201/280 (28x).
        VersionNumber expSchemaVersion =
          ( payloadMode == 0 ? version201 : version280 );
        if ( nodeSchemaVersion < expSchemaVersion )
        {
          evolveNone = false;
          std::stringstream msg;
          msg << "Folder '" << fullPath << "' needs schema evolution"
              << " from schema version '" << nodeSchemaVersion << "' to '"
              << expSchemaVersion << "'";
          log() << coral::Warning << msg.str() << coral::MessageStream::endmsg;
          // No need to fail: just warn that this folder must be updated.
          // No need to check FKs either: they were not there before 2.0.1.
          m_warnings.push_back( msg.str() );
        }
        else if ( nodeSchemaVersion == expSchemaVersion )
        {
          log() << coral::Verbose
                << "Folder '" << fullPath << "' is already schema version '"
                << expSchemaVersion << "' and needs no schema evolution"
                << coral::MessageStream::endmsg;
          /// Check the schema of the channels tables of all folders (220).
          i_checkChannelsTable_220( *row );
        }
        else
        {
          std::stringstream msg;
          msg << "PANIC! Folder " << fullPath
              << " has schema version " << nodeSchemaVersion
              << " that is newer than that supported by this release ("
              << expSchemaVersion << ")";
          log() << coral::Fatal << msg.str() << coral::MessageStream::endmsg;
          m_fatal = true;
          throw RelationalException( msg.str(), "RalSchemaValidation" );
        }
      }
    }
    if ( evolveNone )
      log() << coral::Info
            << "All folders are already schema version '"
            << RelationalFolder::folderSchemaVersion( cool_PayloadMode_Mode::INLINEPAYLOAD )
            << "' or '"
            << RelationalFolder::folderSchemaVersion( cool_PayloadMode_Mode::SEPARATEPAYLOAD )
            << "' and need no schema evolution"
            << coral::MessageStream::endmsg;
  }

  // Success
  log() << coral::Info
        << "Check individual nodes (28x)... DONE!"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalSchemaValidation::i_checkChannelsTable_220
( const RelationalTableRow& row )
{
  int folderVersioningMode =
    row[RelationalNodeTable::columnNames::folderVersioningMode].data<int>();
  std::string svOrMv = "SV";
  if ( folderVersioningMode == (int)cool_FolderVersioning_Mode::MULTI_VERSION )
    svOrMv = "MV";
  std::string fullPath =
    row[RelationalNodeTable::columnNames::nodeFullPath]
    .data<std::string>();
  std::string channelTableName =
    row[RelationalNodeTable::columnNames::folderChannelTableName]
    .data<std::string>();
  std::string objectTableName =
    row[RelationalNodeTable::columnNames::folderObjectTableName]
    .data<std::string>();
  log() << coral::Info
        << "Check the " << svOrMv << " channels table " << channelTableName
        << " of folder " << fullPath << " (220)..."
        << coral::MessageStream::endmsg;

  // List all channels in the IOV table
  std::vector<RelationalTableRow> iovTableChannels;
  try
  {
    RelationalQueryDefinition def;
    def.addSelectItem
      ( "DISTINCT " + RelationalObjectTable::columnNames::channelId(),
        RelationalObjectTable::columnTypeIds::channelId,
        RelationalObjectTable::columnNames::channelId() );
    def.addFromItem( objectTableName );
    def.addOrderItem
      ( RelationalObjectTable::columnNames::channelId() + " ASC" );
    iovTableChannels = db().queryMgr().fetchOrderedRows( def );
  }
  catch( RelationalException& e )
  {
    std::stringstream msg;
    msg << "Error checking iov table of folder '" << fullPath
        << "'. Caught exception: '" << e.what() << "'. Skipping this table.";
    m_errors.push_back( msg.str() );
    return;
  }

  // List all channels in the channels table
  std::vector<RelationalTableRow> chTableChannels;
  try
  {
    RelationalQueryDefinition def;
    def.addSelectItem( RelationalChannelTable::columnNames::channelId(),
                       RelationalChannelTable::columnTypeIds::channelId );
    def.addFromItem( channelTableName );
    def.addOrderItem
      ( RelationalChannelTable::columnNames::channelId() + " ASC" );
    chTableChannels = db().queryMgr().fetchOrderedRows( def );
  }
  catch( RelationalException& e )
  {
    std::stringstream msg;
    msg << "Error checking channels table of folder '" << fullPath
        << "'. Caught exception: '" << e.what() << "'. Skipping this table.";
    m_errors.push_back(msg.str());
    return;
  }

  // Check that all IOV table channels are present in the channels table
  for ( std::vector<RelationalTableRow>::const_iterator ch =
          iovTableChannels.begin(); ch != iovTableChannels.end(); ++ch )
  {
    ChannelId chId =
      (*ch)[RelationalObjectTable::columnNames::channelId()].data<ChannelId>();
    bool found = false;
    //std::cout << "Channel in IOV table: " << chId << std::endl;
    for ( std::vector<RelationalTableRow>::const_iterator ch2 =
            chTableChannels.begin(); ch2 != chTableChannels.end(); ++ch2 )
    {
      ChannelId chId2 =
        (*ch2)[RelationalChannelTable::columnNames::channelId()]
        .data<ChannelId>();
      //std::cout << "Channel in channels table: " << chId2 << std::endl;
      if ( chId2 == chId )
      {
        //std::cout << "Channel found in both tables: " << chId << std::endl;
        found = true;
        break;
      }
    }
    if ( !found )
    {
      std::stringstream msg;
      msg << "Channel #" << chId << " in the IOV table " << objectTableName
          << " does not reference an entry in the channels table "
          << channelTableName << " of folder " << fullPath;
      m_fatal = true;
      throw RelationalException( msg.str(), "RalSchemaValidation" );
    }
  }
  log() << coral::Info
        << "Check the " << svOrMv << " channels table " << channelTableName
        << " of folder " << fullPath << " (220)... DONE!"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalSchemaValidation::i_checkNodeNames_222()
{
  log() << coral::Info
        << "Check node names (222)..." << coral::MessageStream::endmsg;

  {
    // List all nodes ordered by nodeId
    std::string orderClause = RelationalNodeTable::columnNames::nodeId;
    orderClause += " ASC";
    RelationalQueryDefinition queryDef;
    queryDef.addFromItem( db().nodeTableName() );
    queryDef.addSelectItems( RelationalNodeTable::tableSpecification
                             ( VersionNumber( "2.0.0" ) ) );
    queryDef.addOrderItem( orderClause );
    std::vector<RelationalTableRow> rows =
      db().queryMgr().fetchOrderedRows( queryDef ); // no WHERE clause
    // Check all nodes one by one
    for ( std::vector<RelationalTableRow>::const_iterator
            row = rows.begin(); row != rows.end(); ++row )
    {
      std::string fullPath =
        (*row)[RelationalNodeTable::columnNames::nodeFullPath]
        .data<std::string>();
      HvsPathHandler pathHandler;
      try
      {
        if ( fullPath != pathHandler.rootFullPath() )
          pathHandler.splitFullPath( fullPath );
      }
      catch ( HvsPathHandlerException& e )
      {
        log() << coral::Warning << e.what() << coral::MessageStream::endmsg;
        m_warnings.push_back( e.what() );
      }
    }
  }

  // Success
  log() << coral::Info
        << "Check node names (222)... DONE!"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalSchemaValidation::i_checkNodeTables_220()
{

  // List all nodes ordered by nodeId
  std::vector<RelationalTableRow> rows;
  {
    std::string orderClause = RelationalNodeTable::columnNames::nodeId;
    orderClause += " ASC";
    RelationalQueryDefinition queryDef;
    queryDef.addFromItem( db().nodeTableName() );
    queryDef.addSelectItems( RelationalNodeTable::tableSpecification
                             ( VersionNumber( "2.0.0" ) ) );
    queryDef.addOrderItem( orderClause );
    rows = db().queryMgr().fetchOrderedRows( queryDef ); // no WHERE clause
  }

  // Check all nodes one by one
  for ( std::vector<RelationalTableRow>::const_iterator
          row = rows.begin(); row != rows.end(); ++row )
  {
    UInt32 nodeId =
      (*row)[RelationalNodeTable::columnNames::nodeId]
      .data<UInt32>();
    std::string nodeFullPath =
      (*row)[RelationalNodeTable::columnNames::nodeFullPath]
      .data<cool::String255>();
    Int32 folderVersioningMode =
      (*row)[RelationalNodeTable::columnNames::folderVersioningMode]
      .data<Int32>();
    std::string tagSequenceName =
      RelationalTagSequence::sequenceName
      ( db().defaultTablePrefix(), nodeId );
    std::string channelTableName =
      RelationalChannelTable::defaultTableName
      ( db().defaultTablePrefix(), nodeId );
    try
    {
      if ( folderVersioningMode != (int)cool_FolderVersioning_Mode::SINGLE_VERSION )
      {
        // single version folder don't have a tag sequence table
        RelationalQueryDefinition queryDef;
        queryDef.addFromItem( tagSequenceName );
        queryDef.addSelectItems
          ( RelationalSequenceTable::tableSpecification() );
        db().queryMgr().fetchOrderedRows( queryDef ); // no WHERE/ORDER clause
      }
      if ( folderVersioningMode != (int)cool_FolderVersioning_Mode::NONE )
      {
        // check for channels table if the node is not a folder set
        RelationalQueryDefinition queryDef;
        queryDef.addFromItem( channelTableName );
        queryDef.addSelectItems
          ( RelationalChannelTable::tableSpecification() );
        db().queryMgr().fetchOrderedRows( queryDef ); // no WHERE/ORDER clause
      }
    }
    catch ( RelationalException& e )
    {
      std::stringstream msg;
      msg << "Corrupt or missing table for ";
      if ( folderVersioningMode != (int)cool_FolderVersioning_Mode::NONE )
        msg << "folder ";
      else msg << "folder set ";
      msg << "'" << nodeFullPath << "'. Error Message: '"<< e.what() << "'";
      m_errors.push_back( msg.str() );
    }
  }
}

//-----------------------------------------------------------------------------
