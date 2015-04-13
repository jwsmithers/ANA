// $Id: coolPrivileges.cpp,v 1.15 2012-06-29 15:25:05 avalassi Exp $

// Include files
#include <iostream>
#include "CoralBase/Exception.h"
#include "CoolKernel/IDatabase.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/InternalErrorException.h"
#include "RelationalAccess/IConnectionService.h"
#include "RelationalAccess/IConnectionServiceConfiguration.h"

// Local include files
#include "RalPrivilegeManager.h"
#include "../../src/CoralApplication.h"
#include "../../src/RalDatabase.h"
#include "../../src/TransRalDatabase.h"

// Namespace
using namespace cool;

// Message output
#define LOG std::cout

//-----------------------------------------------------------------------------

int main( int argc, char** argv )
{

  try {

    // Get the command line arguments
    bool ok = true;
    std::string dbId;
    std::string comm;
    std::string role;
    std::string user;
    if ( argc != 5 )
      ok = false;
    else {
      dbId = argv[1];
      comm = argv[2];
      role = argv[3];
      user = argv[4];
      if ( comm != "GRANT" &&
           comm != "REVOKE" )
        ok = false;
      if ( role != "READER" &&
           role != "WRITER" &&
           role != "TAGGER" &&
           role != "ALL" )
        ok = false;
    }
    if ( !ok ) {
      LOG << "Usage: " << argv[0]
          << " dbId {GRANT|REVOKE} {READER|WRITER|TAGGER|ALL} user"
          << std:: endl;
      std::string dbId1 =
        "oracle://SERVER;schema=USER1;dbname=DB;user=USER1";
      std::string dbId2 =
        "ServerAlias(owner)/DBNAME";
      LOG << "Example: " << argv[0] << " '" << dbId1
          << "' GRANT READER USER2" << std::endl;
      LOG << "Example: " << argv[0] << " '" << dbId2
          << "' GRANT READER USER2" << std::endl;
      return 1;
    }

    // Instantiate a COOL Application
    CoralApplication app;

    // If we can access a LFC and the user is not explicitely forbidding it,
    // we try to use CORAL LFCReplicaService
    if ( ::getenv("COOL_IGNORE_LFC") == NULL &&
         ::getenv("LFC_HOST") != NULL ) {
      // try to load CORAL LFCReplicaService
      coral::IConnectionServiceConfiguration &connSvcConf =
        app.connectionSvc().configuration();
      connSvcConf.setAuthenticationService("CORAL/Services/LFCReplicaService");
      connSvcConf.setLookupService("CORAL/Services/LFCReplicaService");
    }

    // Open the database
    IDatabaseSvc& dbSvc = app.databaseService();
    IDatabasePtr db = dbSvc.openDatabase( dbId, false ); // open for update
    // get bare RalDatabase -> manual transaction mode
    TransRalDatabase* traldb = dynamic_cast<TransRalDatabase*>( db.get() );
    if ( !traldb ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RalDatabase* ralDb = traldb->getRalDb();
    RalPrivilegeManager prMgr( ralDb );

    // Grant/Revoke role to/from user
    if ( comm == "GRANT" ) {
      LOG << "GRANT '" << role
          << "' privileges to user " << user << std::endl;
      if ( role == "READER" ) {
        prMgr.grantReaderPrivileges( user );
      } else if ( role == "WRITER" ) {
        prMgr.grantReaderPrivileges( user );
        prMgr.grantWriterPrivileges( user );
      } else if ( role == "TAGGER" ) {
        bool retag = true;
        prMgr.grantReaderPrivileges( user );
        prMgr.grantTaggerPrivileges( user, retag );
      } else if ( role == "ALL" ) {
        bool retag = true;
        prMgr.grantReaderPrivileges( user );
        prMgr.grantWriterPrivileges( user );
        prMgr.grantTaggerPrivileges( user, retag );
      } else {
        LOG << "Unknown privileges '" << role << "'" << std::endl;
      }
    }
    else {
      LOG << "REVOKE '" << role
          << "' privileges from user " << user << std::endl;
      if ( role == "READER" ) {
        prMgr.revokeReaderPrivileges( user );
      } else if ( role == "WRITER" ) {
        prMgr.revokeWriterPrivileges( user );
      } else if ( role == "TAGGER" ) {
        prMgr.revokeTaggerPrivileges( user );
      } else if ( role == "ALL" ) {
        prMgr.revokeTaggerPrivileges( user );
        prMgr.revokeWriterPrivileges( user );
        prMgr.revokeReaderPrivileges( user );
      } else {
        LOG << "Unknown privileges '" << role << "'" << std::endl;
      }
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

  // Successful program termination
  return 0;

}

//-----------------------------------------------------------------------------
