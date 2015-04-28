
// Include files
#include <iostream>
#include "CoolKernel/Exception.h"
#include "CoralBase/Exception.h"
#include "RelationalAccess/IConnectionServiceConfiguration.h"
#include "RelationalAccess/ISessionProxy.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ITransaction.h"

// Local include files
#include "../../src/CoralApplication.h"
#include "../../src/CoralConnectionServiceProxy.h"
#include "../../src/RalSessionMgr.h"
#include "../../src/RelationalDatabaseId.h"

// Message output
#define LOG std::cout

//-----------------------------------------------------------------------------

int main( int argc, char** argv )
{

  try
  {

    // Have all tables been dropped successfully?
    bool success = true;

    // Get the command line arguments
    std::string dbId;
    if ( argc == 2 )
    {
      dbId = argv[1];
    }
    else
    {
      LOG << "Usage: " << argv[0] << " dbId" << std:: endl;
      std::string dbId1 =
        "oracle://SERVER;schema=SCHEMA;user=USER;password=PSWD;dbname=DB";
      std::string dbId2 =
        "oracle://SERVER;schema=SCHEMA;dbname=DB";
      LOG << std::endl;
      LOG << "Example: " << argv[0] << " '" << dbId1 << "'\n"
          << "[Decode user and password from explicit credentials]"
          << std::endl;
      LOG << std::endl;
      LOG << "Example: " << argv[0] << " '" << dbId2 << "'\n"
          << "[Get user and password from authentication service]"
          << std::endl;
      return 1;
    }

    // Decode and print out the database URL
    cool::RelationalDatabaseId relationalDbId(dbId);
    std::string dbName = relationalDbId.dbName();
    LOG << "Drop COOL database \"" << relationalDbId.urlHidePswd() << "\""
        << std::endl;

    // Instantiate a COOL Application
    cool::CoralApplication app;

    // Disable CORAL automatic pool clean up thread
    LOG << "Getting CORAL Connection Service configurator" << std::endl;
    coral::IConnectionServiceConfiguration &connSvcConf =
      app.connectionSvc().configuration();

    // If we can access a LFC and the user is not explicitely forbidding it,
    // we try to use CORAL LFCReplicaService
    if ( ::getenv("COOL_IGNORE_LFC") == NULL &&
         ::getenv("LFC_HOST") != NULL )
    {
      // use CORAL LFCReplicaService
      connSvcConf.setAuthenticationService("CORAL/Services/LFCReplicaService");
      connSvcConf.setLookupService("CORAL/Services/LFCReplicaService");
    }

    LOG << "Disabling CORAL connection automatic clean up" << std::endl;
    connSvcConf.disablePoolAutomaticCleanUp();
    connSvcConf.setConnectionTimeOut( 0 );

    // Workaround for ORA-01466 (bug #87935)
    if ( ::getenv( "CORAL_TESTSUITE_SLEEPFOR01466" ) )
      ::setenv( "CORAL_TESTSUITE_SLEEPFOR01466_PREFIX", dbName.c_str(), 1 );

    // Create a session manager and start a transaction
    const bool readOnly = false;
    cool::CoralConnectionServiceProxyPtr ppConnSvc
      ( new cool::CoralConnectionServiceProxy( &app.connectionSvc() ) );
    cool::RalSessionMgr rsm( ppConnSvc, dbId, readOnly );
    LOG << "Start transaction." << std::endl;
    rsm.session().transaction().start();
    std::set<std::string> existingTables =
      rsm.session().nominalSchema().listTables();

    // Mark for deletion all tables whose names start with dbName + "_"
    // Tables must be deleted in a specific order because of FK constraints
    std::string signature = dbName + "_";
    std::list<std::string> tablesToDelete;
    // Management tables are deleted last (and in a specific order)
    std::list<std::string> mgmtTables;
    mgmtTables.push_back( signature + "DB_ATTRIBUTES" );
    // *** START *** 3.0.0 schema extensions (task #4307)
    mgmtTables.push_back( signature + "IOVTABLES" );
    mgmtTables.push_back( signature + "CHANNELTABLES" );
    // **** END **** 3.0.0 schema extensions (task #4307)
    mgmtTables.push_back( signature + "NODES" );
    mgmtTables.push_back( signature + "NODES_SEQ" );
    mgmtTables.push_back( signature + "TAGS" );
    // *** START *** 3.0.0 schema extensions (task #4396)
    mgmtTables.push_back( signature + "USERTAGS" );
    mgmtTables.push_back( signature + "HEADTAGS" );
    // **** END **** 3.0.0 schema extensions (task #4396)
    mgmtTables.push_back( signature + "TAG2TAG" );
    mgmtTables.push_back( signature + "TAG2TAG_SEQ" );
    mgmtTables.push_back( signature + "TAGS_SEQ" );
    mgmtTables.push_back( signature + "IOVS_SEQ" );

    // 1. Management tables are deleted last
    // (first inserted will be at the back of the list, and deleted last)
    std::list<std::string>::const_iterator mgmtTable;
    for ( mgmtTable = mgmtTables.begin();
          mgmtTable != mgmtTables.end();
          ++mgmtTable )
    {
      if ( existingTables.find( *mgmtTable ) != existingTables.end() )
      {
        existingTables.erase( *mgmtTable );
        // First inserted will be at the back of the list - and deleted last
        tablesToDelete.push_front( *mgmtTable );
      }
    }

    // 2. Tables that are not associated to individual nodes (and are not
    // management tables either) are deleted before the management tables
    // [NB: There should be no such tables, but delete them anyway!]
    std::set<std::string>::reverse_iterator existingTable;
    for ( existingTable = existingTables.rbegin();
          existingTable != existingTables.rend();
          ++existingTable )
    {
      if ( existingTable->find( signature ) == 0 &&
           existingTable->find( signature+"F" ) != 0 )
      {
        // First inserted will be at the back of the list - and deleted last
        // [i.e. delete these tables in alphabetical order - as in COOL133c]
        tablesToDelete.push_front( *existingTable );
      }
    }

    // 3. Tables that are associated to individual nodes are deleted first
    // 3a. Delete all channel tables last, because of FK constraints
    // (first inserted will be at the back of the list, and deleted last)
    for ( existingTable = existingTables.rbegin();
          existingTable != existingTables.rend();
          ++existingTable )
    {
      if ( existingTable->find( signature ) == 0 &&
           existingTable->find( signature+"F" ) == 0 &&
           existingTable->rfind( "_CHANNELS" ) == existingTable->size()-9 )
      {
        tablesToDelete.push_front( *existingTable );
      }
    }
    // 3b. Delete all tables other than channel/payload tables in the middle
    // (first inserted will be at the back of the list, and deleted last)
    for ( existingTable = existingTables.rbegin();
          existingTable != existingTables.rend();
          ++existingTable )
    {
      if ( existingTable->find( signature ) == 0 &&
           existingTable->find( signature+"F" ) == 0 &&
           existingTable->rfind( "_CHANNELS" ) != existingTable->size()-9 &&
           existingTable->rfind( "_PAYLOAD" ) != existingTable->size()-8 )
      {
        // First inserted will be at the back of the list - and deleted last
        // [i.e. delete these tables in alphabetical order - as in COOL133c]
        tablesToDelete.push_front( *existingTable );
      }
    }
    // 3c. Delete payload tables first
    // (first inserted will be at the back of the list, and deleted last)
    for ( existingTable = existingTables.rbegin();
          existingTable != existingTables.rend();
          ++existingTable )
    {
      if ( existingTable->find( signature ) == 0 &&
           existingTable->find( signature+"F" ) == 0 &&
           existingTable->rfind( "_PAYLOAD" ) == existingTable->size()-8 )
      {
        tablesToDelete.push_front( *existingTable );
      }
    }

    // Drop the tables
    std::list<std::string> tablesToDelete2;
    std::list<std::string>::iterator tableToDelete;
    for ( tableToDelete = tablesToDelete.begin();
          tableToDelete != tablesToDelete.end();
          ++tableToDelete )
    {
      LOG << "Dropping table \"" << *tableToDelete << "\" ... " << std::flush;
      try
      {
        rsm.session().nominalSchema().dropTable(*tableToDelete);
        LOG << "done.";
      }
      catch(...)
      {
        LOG << "failed on first try, will try again.";
        tablesToDelete2.push_back( *tableToDelete );
      }
      LOG << std::endl;
    }

    // Try again to drop the tables that could not be dropped on the first try.
    // This was originally added to drop folders with vector payloads
    // (should we not instead define the order better including dependencies?)
    // TODO: switch to new CORAL dropTable with cascade option when available
    for ( tableToDelete = tablesToDelete2.begin();
          tableToDelete != tablesToDelete2.end();
          ++tableToDelete )
    {
      LOG << "Dropping table \"" << *tableToDelete
          << "\", second try ... " << std::flush;
      try
      {
        rsm.session().nominalSchema().dropTable(*tableToDelete);
        LOG << "done." << std::endl;
      }
      catch(...)
      {
        LOG << "failed." << std::endl;
        success = false;
      }
    }

    // Commit the transaction
    LOG << "Commit transaction." << std::endl;
    rsm.session().transaction().commit();

    // Close the session manager access to the CORAL connection service
    ppConnSvc->purgeConnectionPool();
    ppConnSvc->resetICS();

    // Have all tables been dropped successfully?
    if ( success )
    {
      // Successful program termination
      LOG << "All database tables have been dropped successfully."
          << std::endl;
      return 0;
    }
    else
    {
      // This used to be a warning but will now be an error
      // (e.g. ORA-00054 resource busy with NOWAIT: bug #91006)
      LOG << "ERROR! One or more database tables could not be dropped."
          << std::endl;
      return 1;
    }
  }

  catch( cool::Exception& e )
  {
    LOG << "ERROR! Cool Exception: '" << e.what() << "'" << std::endl;
    return 1;
  }

  catch( coral::Exception& e )
  {
    LOG << "ERROR! Coral Exception: '" << e.what() << "'" << std::endl;
    return 1;
  }

  catch( std::exception& e )
  {
    LOG << "ERROR! Standard C++ exception: '" << e.what() << "'" << std::endl;
    return 1;
  }

  catch( ... )
  {
    LOG << "ERROR! Unknown exception caught" << std::endl;
    return 1;
  }

}

//-----------------------------------------------------------------------------
