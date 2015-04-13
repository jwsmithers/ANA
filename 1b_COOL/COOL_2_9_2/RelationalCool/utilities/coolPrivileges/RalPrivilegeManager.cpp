// $Id: RalPrivilegeManager.cpp,v 1.17 2012-06-29 15:25:05 avalassi Exp $

// Include files
#include "CoolKernel/InternalErrorException.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ITable.h"

// Local include files
// [NB Weird: a transaction is needed to avoid OCI_INVALID_HANDLE...]
// [See http://dbforums.com/t394084.html]
#include "RalPrivilegeManager.h"
#include "../../src/RalDatabase.h"
#include "../../src/RelationalException.h"
#include "../../src/RelationalFolder.h"
#include "../../src/RelationalFolderSet.h"
#include "../../src/RelationalNodeTable.h"
#include "../../src/RelationalObjectTable.h"
#include "../../src/RelationalPayloadTable.h"
#include "../../src/RelationalTagSequence.h"
#include "../../src/RelationalTagTable.h"
#include "../../src/RelationalTag2TagTable.h"
#include "../../src/RelationalTransaction.h"

// Workaround for Windows (win32_vc9_dbg)
// DELETE seems to be defined in a Windows VC9 header
// See also CoolKernel/CoolKernel/MessageLevels.h
// See also RelationalCool/src/CoralApplication.cpp
#ifdef WIN32
#ifdef DELETE
#undef DELETE
#pragma message ("WARN!NG: in coolPrivileges/RalPrivilegeManager.cpp")
#pragma message ("WARN!NG: 'DELETE' was defined and has been undefined")
#endif
#endif

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

RalPrivilegeManager::RalPrivilegeManager( RalDatabase* db )
  : m_db( db )
  , m_log( new coral::MessageStream
           ( "RalPrivilegeManager" ) )
{
  log() << coral::Debug << "Instantiate a RalPrivilegeManager for '"
        << m_db->databaseId() << "'" << coral::MessageStream::endmsg;
  m_fourPrivs.push_back( SELECT );
  m_fourPrivs.push_back( INSERT );
  m_fourPrivs.push_back( UPDATE );
  m_fourPrivs.push_back( DELETE );
  // This class can only be used with "oracle" database technology
  if ( m_db->sessionMgr()->databaseTechnology() != "Oracle" ) {
    throw RelationalException
      ( "Unsupported technology '" + m_db->sessionMgr()->databaseTechnology() +
        "' for database privilege management ", "RalPrivilegeManager" );
  }
}

//-----------------------------------------------------------------------------

RalPrivilegeManager::~RalPrivilegeManager()
{
  log() << coral::Debug << "Delete the RalPrivilegeManager for '"
        << m_db->databaseId() << "'" << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

coral::MessageStream& RalPrivilegeManager::log() {
  *m_log << coral::Verbose;
  return *m_log;
}

//-----------------------------------------------------------------------------

std::vector< std::string >
RalPrivilegeManager::i_listReaderTables( const Privilege& priv )
{
  std::vector< std::string > tables;
  RelationalTransaction transaction( m_db->transactionMgr(), false ); //read-only

  // Tables with SELECT privileges
  if ( priv == SELECT ) {

    // Main table
    tables.push_back
      ( m_db->mainTableName() );

    // Node table and sequence
    tables.push_back
      ( m_db->nodeTableName() );
    tables.push_back
      ( RelationalNodeTable::sequenceName( m_db->nodeTableName() ) );

    // Global tag table
    tables.push_back
      ( m_db->globalTagTableName() );

    // Tag2tag table and sequence
    tables.push_back
      ( m_db->tag2TagTableName() );
    tables.push_back
      ( RelationalTag2TagTable::sequenceName( m_db->tag2TagTableName() ) );

    // Tag shared sequence
    tables.push_back
      ( m_db->tagSharedSequenceName() );

    // Object shared sequence
    tables.push_back
      ( m_db->iovSharedSequenceName() );

    // Loop over all nodes in the database
    std::vector<std::string> nodes( m_db->listAllNodes( false ) );
    std::vector<std::string>::const_iterator node;
    for ( node = nodes.begin(); node != nodes.end(); node++ ) {
      // Process folders
      try {
        IFolderPtr folder = m_db->getFolder( *node );
        RelationalFolder* relFolder =
          dynamic_cast<RelationalFolder*>( folder.get() );
        if ( !relFolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
        // Object table and sequence
        tables.push_back
          ( relFolder->objectTableName() );
        tables.push_back
          ( RelationalObjectTable::sequenceName
            ( relFolder->objectTableName() ) );
        // Payload table and sequence (PT only)
        if ( relFolder->hasPayloadTable() ) {
          tables.push_back
            ( relFolder->payloadTableName() );
          tables.push_back
            ( RelationalPayloadTable::sequenceName
              ( relFolder->payloadTableName() ) );
        }
        // Channel table
        tables.push_back
          ( relFolder->channelTableName() );
        // Tag table and sequence and object2tag table (MV only)
        if ( relFolder->versioningMode() == FolderVersioning::MULTI_VERSION ) {
          tables.push_back
            ( relFolder->tagTableName() );
          tables.push_back
            ( RelationalTagSequence::sequenceName
              ( m_db->defaultTablePrefix(), relFolder->id() ) );
          tables.push_back
            ( relFolder->object2TagTableName() );
        }
      }
      catch ( FolderNotFound& e ) {
        if ( ! e.isFolderSet() ) throw;
      }
      // Process folder sets
      try {
        IFolderSetPtr folderSet = m_db->getFolderSet( *node );
        RelationalFolderSet* relFolderSet =
          dynamic_cast<RelationalFolderSet*>( folderSet.get() );
        if ( !relFolderSet ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
        if ( priv == SELECT ) {
          // Local tag sequence
          tables.push_back
            ( RelationalTagSequence::sequenceName
              ( m_db->defaultTablePrefix(), relFolderSet->id() ) );
        }
      }
      catch ( FolderSetNotFound& e ) {
        if ( ! e.isFolder() ) throw;
      }
    }
  }

  // Tables with INSERT or UPDATE or DELETE privileges
  else if ( priv == INSERT || priv == UPDATE || priv == DELETE ) {
    // No tables!
  }

  // Unknown privilege
  else {
    throw RelationalException
      ( "PANIC! Unknown privilege", "RalPrivilegeManager" );
  }

  transaction.commit();
  return tables;

}

//-----------------------------------------------------------------------------

std::vector< std::string >
RalPrivilegeManager::i_listWriterTables( const Privilege& priv )
{
  std::vector< std::string > tables;
  RelationalTransaction transaction( m_db->transactionMgr(), false ); //read-only

  // Tables with SELECT privileges
  if ( priv == SELECT ) {
    // No tables! Reader privileges must be granted explcitly!
    //tables = i_listReaderTables( SELECT );
  }

  // Tables with INSERT or UPDATE privileges
  else if ( priv == INSERT || priv == UPDATE ) {

    if ( priv == UPDATE ) {
      // UPDATE: object shared sequence
      tables.push_back
        ( m_db->iovSharedSequenceName() );
    }

    // Loop over all nodes in the database
    std::vector<std::string> nodes( m_db->listAllNodes( false ) );
    std::vector<std::string>::const_iterator node;
    for ( node = nodes.begin(); node != nodes.end(); node++ ) {
      try {
        IFolderPtr folder = m_db->getFolder( *node );
        RelationalFolder* relFolder =
          dynamic_cast<RelationalFolder*>( folder.get() );
        if ( !relFolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
        if ( priv == INSERT ) {
          // INSERT: object table, channel table
          tables.push_back
            ( relFolder->objectTableName() );
          tables.push_back
            ( relFolder->channelTableName() );
          // INSERT: payload table (PT only)
          if ( relFolder->hasPayloadTable() ) {
            tables.push_back
              ( relFolder->payloadTableName() );
          }
        } else {
          // UPDATE: object table and sequence, channel table
          tables.push_back
            ( relFolder->objectTableName() );
          tables.push_back
            ( RelationalObjectTable::sequenceName
              ( relFolder->objectTableName() ) );
          tables.push_back
            ( relFolder->channelTableName() );
          // UPDATE: payload table sequence (PT only)
          if ( relFolder->hasPayloadTable() ) {
            //tables.push_back
            //  ( relFolder->payloadTableName() );
            tables.push_back
              ( RelationalPayloadTable::sequenceName
                ( relFolder->payloadTableName() ) );
          }
        }
      }
      catch ( FolderNotFound& e ) {
        if ( ! e.isFolderSet() ) throw;
      }
    }
  }

  // Tables with DELETE privileges
  else if ( priv == DELETE ) {
    // No tables!
  }

  // Unknown privilege
  else {
    throw RelationalException
      ( "PANIC! Unknown privilege", "RalPrivilegeManager" );
  }
  transaction.commit();

  return tables;

}

//-----------------------------------------------------------------------------

std::vector< std::string >
RalPrivilegeManager::i_listTaggerTables( const Privilege& priv,
                                         const bool retag )
{
  std::vector< std::string > tables;
  RelationalTransaction transaction( m_db->transactionMgr() ); // read-write

  // Tables with SELECT privileges
  if ( priv == SELECT ) {
    // No tables! Reader privileges must be granted explcitly!
    //tables = i_listReaderTables( SELECT );
  }

  // Tables with INSERT or UPDATE or DELETE privileges
  else if ( priv == INSERT || priv == UPDATE || priv == DELETE ) {

    if ( priv == INSERT ) {
      // INSERT: global tag and tag2tag tables
      tables.push_back
        ( m_db->globalTagTableName() );
      tables.push_back
        ( m_db->tag2TagTableName() );
    } else if ( priv == UPDATE ) {
      // UPDATE: tag shared sequence and tag2tag sequence
      tables.push_back
        ( m_db->tagSharedSequenceName() );
      tables.push_back
        ( RelationalTag2TagTable::sequenceName( m_db->tag2TagTableName() ) );
    } else {
      // DELETE: global tag and tag2tag table (only for retagging)
      if ( retag ) {
        tables.push_back
          ( m_db->globalTagTableName() );
        tables.push_back
          ( m_db->tag2TagTableName() );
      }
    }

    // Loop over all nodes in the database
    std::vector<std::string> nodes( m_db->listAllNodes( false ) );
    std::vector<std::string>::const_iterator node;
    for ( node = nodes.begin(); node != nodes.end(); node++ ) {
      // Process folders
      try {
        IFolderPtr folder = m_db->getFolder( *node );
        RelationalFolder* relFolder =
          dynamic_cast<RelationalFolder*>( folder.get() );
        if ( !relFolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
        // MV folders only
        if ( relFolder->versioningMode() == FolderVersioning::MULTI_VERSION ) {
          if ( priv == INSERT ) {
            // INSERT: local tag and object2tag table
            tables.push_back
              ( relFolder->tagTableName() );
            tables.push_back
              ( relFolder->object2TagTableName() );
          } else if ( priv == UPDATE ) {
            // UPDATE: local tag sequence
            tables.push_back
              ( RelationalTagSequence::sequenceName
                ( m_db->defaultTablePrefix(), relFolder->id() ) );
          } else {
            // DELETE: local tag and object2tag table (only for retagging)
            if ( retag ) {
              tables.push_back
                ( relFolder->tagTableName() );
              tables.push_back
                ( relFolder->object2TagTableName() );
            }
          }
        }
      }
      catch ( FolderNotFound& e ) {
        if ( ! e.isFolderSet() ) throw;
      }
      // Process folder sets
      try {
        IFolderSetPtr folderSet = m_db->getFolderSet( *node );
        RelationalFolderSet* relFolderSet =
          dynamic_cast<RelationalFolderSet*>( folderSet.get() );
        if ( !relFolderSet ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
        if ( priv == UPDATE ) {
          // UPDATE: local tag sequence
          tables.push_back
            ( RelationalTagSequence::sequenceName
              ( m_db->defaultTablePrefix(), relFolderSet->id() ) );
        }
      }
      catch ( FolderSetNotFound& e ) {
        if ( ! e.isFolder() ) throw;
      }
    }
  }

  // Unknown privilege
  else {
    throw RelationalException
      ( "PANIC! Unknown privilege", "RalPrivilegeManager" );
  }
  transaction.commit();

  return tables;

}

//-----------------------------------------------------------------------------

coral::ITablePrivilegeManager&
RalPrivilegeManager::i_tablePrivMgr( const std::string& tableName )
{
  coral::ITable& tableHandle =
    m_db->session().nominalSchema().tableHandle( tableName );
  return tableHandle.privilegeManager();
}

//-----------------------------------------------------------------------------

void RalPrivilegeManager::i_grantPrivilege( const Privilege& priv,
                                            const std::string& table,
                                            const std::string& user )
{
  coral::ITablePrivilegeManager::Privilege ralPriv;
  if ( priv == SELECT )
    ralPriv = coral::ITablePrivilegeManager::Select;
  else if ( priv == INSERT )
    ralPriv = coral::ITablePrivilegeManager::Insert;
  else if ( priv == UPDATE )
    ralPriv = coral::ITablePrivilegeManager::Update;
  else if ( priv == DELETE )
    ralPriv = coral::ITablePrivilegeManager::Delete;
  else
    throw RelationalException
      ( "PANIC! Unknown privilege", "RalPrivilegeManager" );
  i_tablePrivMgr( table ).grantToUser( user, ralPriv );
}

//-----------------------------------------------------------------------------

void RalPrivilegeManager::i_revokePrivilege( const Privilege& priv,
                                             const std::string& table,
                                             const std::string& user )
{
  coral::ITablePrivilegeManager::Privilege ralPriv;
  if ( priv == SELECT )
    ralPriv = coral::ITablePrivilegeManager::Select;
  else if ( priv == INSERT )
    ralPriv = coral::ITablePrivilegeManager::Insert;
  else if ( priv == UPDATE )
    ralPriv = coral::ITablePrivilegeManager::Update;
  else if ( priv == DELETE )
    ralPriv = coral::ITablePrivilegeManager::Delete;
  else
    throw RelationalException
      ( "PANIC! Unknown privilege", "RalPrivilegeManager" );
  i_tablePrivMgr( table ).revokeFromUser( user, ralPriv );
}

//-----------------------------------------------------------------------------

void RalPrivilegeManager::grantReaderPrivileges( const std::string& user )
{
  log() << "Grant reader role privileges to user '" << user << "'"
        << coral::MessageStream::endmsg;
  std::vector<Privilege>::const_iterator priv;
  for ( priv = m_fourPrivs.begin(); priv != m_fourPrivs.end(); priv++ ) {
    std::vector<std::string> tables( i_listReaderTables( *priv ) );
    std::vector<std::string>::const_iterator table;
    RelationalTransaction transaction( m_db->transactionMgr() ); // read-write
    for ( table = tables.begin(); table != tables.end(); table++ ) {
      i_grantPrivilege( *priv, *table, user );
    }
    transaction.commit();
  }
}

//-----------------------------------------------------------------------------

void RalPrivilegeManager::revokeReaderPrivileges( const std::string& user )
{
  log() << "Revoke reader role privileges from user '" << user << "'"
        << coral::MessageStream::endmsg;
  std::vector<Privilege>::const_iterator priv;
  for ( priv = m_fourPrivs.begin(); priv != m_fourPrivs.end(); priv++ ) {
    std::vector<std::string> tables( i_listReaderTables( *priv ) );
    std::vector<std::string>::const_iterator table;
    RelationalTransaction transaction( m_db->transactionMgr() ); // read-write
    for ( table = tables.begin(); table != tables.end(); table++ ) {
      i_revokePrivilege( *priv, *table, user );
    }
    transaction.commit();
  }
}

//-----------------------------------------------------------------------------

void RalPrivilegeManager::grantWriterPrivileges( const std::string& user )
{
  log() << "Grant writer role privileges to user '" << user << "'"
        << coral::MessageStream::endmsg;
  std::vector<Privilege>::const_iterator priv;
  for ( priv = m_fourPrivs.begin(); priv != m_fourPrivs.end(); priv++ ) {
    std::vector<std::string> tables( i_listWriterTables( *priv ) );
    std::vector<std::string>::const_iterator table;
    RelationalTransaction transaction( m_db->transactionMgr() ); // read-write
    for ( table = tables.begin(); table != tables.end(); table++ ) {
      i_grantPrivilege( *priv, *table, user );
    }
    transaction.commit();
  }
}

//-----------------------------------------------------------------------------

void RalPrivilegeManager::revokeWriterPrivileges( const std::string& user )
{
  log() << "Revoke writer role privileges from user '" << user << "'"
        << coral::MessageStream::endmsg;
  std::vector<Privilege>::const_iterator priv;
  for ( priv = m_fourPrivs.begin(); priv != m_fourPrivs.end(); priv++ ) {
    std::vector<std::string> tables( i_listWriterTables( *priv ) );
    std::vector<std::string>::const_iterator table;
    RelationalTransaction transaction( m_db->transactionMgr() ); // read-write
    for ( table = tables.begin(); table != tables.end(); table++ ) {
      i_revokePrivilege( *priv, *table, user );
    }
    transaction.commit();
  }
}

//-----------------------------------------------------------------------------

void RalPrivilegeManager::grantTaggerPrivileges( const std::string& user,
                                                 const bool retag )
{
  log() << "Grant tagger role privileges to user '" << user << "'"
        << coral::MessageStream::endmsg;
  std::vector<Privilege>::const_iterator priv;
  for ( priv = m_fourPrivs.begin(); priv != m_fourPrivs.end(); priv++ ) {
    std::vector<std::string> tables( i_listTaggerTables( *priv, retag ) );
    std::vector<std::string>::const_iterator table;
    RelationalTransaction transaction( m_db->transactionMgr() ); // read-write
    for ( table = tables.begin(); table != tables.end(); table++ ) {
      i_grantPrivilege( *priv, *table, user );
    }
    transaction.commit();
  }
}

//-----------------------------------------------------------------------------

void RalPrivilegeManager::revokeTaggerPrivileges( const std::string& user )
{
  bool retag = true; // Revoke retag privileges
  log() << "Revoke tagger role privileges from user '" << user << "'"
        << coral::MessageStream::endmsg;
  std::vector<Privilege>::const_iterator priv;
  for ( priv = m_fourPrivs.begin(); priv != m_fourPrivs.end(); priv++ ) {
    std::vector<std::string> tables( i_listTaggerTables( *priv, retag ) );
    std::vector<std::string>::const_iterator table;
    RelationalTransaction transaction( m_db->transactionMgr() ); // read-write
    for ( table = tables.begin(); table != tables.end(); table++ ) {
      i_revokePrivilege( *priv, *table, user );
    }
    transaction.commit();
  }
}

//-----------------------------------------------------------------------------
