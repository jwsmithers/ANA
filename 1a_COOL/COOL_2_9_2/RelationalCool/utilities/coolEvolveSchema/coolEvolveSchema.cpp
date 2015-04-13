// $Id: coolEvolveSchema.cpp,v 1.16 2009-12-16 17:27:48 avalassi Exp $

// Include files
#include <iostream>
#include "CoolKernel/IDatabase.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "RelationalAccess/IConnectionService.h"
#include "RelationalAccess/IConnectionServiceConfiguration.h"

// Local include files
#include "RalSchemaEvolution.h"
#include "../../src/CoralApplication.h"
#include "../../src/CoralConnectionServiceProxy.h"
#include "../../src/RalDatabase.h"
#include "../../src/VersionInfo.h"

// Namespace
using namespace cool;

// Message output
#define LOG std::cout

//-----------------------------------------------------------------------------

int main( int argc, char** argv )
{

  try {

    // Get the command line arguments
    std::string dbId;
    if ( argc != 2 ) {
      LOG << "Usage: " << argv[0] << " dbId" << std:: endl;
      std::string dbIdOra =
        "oracle://SERVER;schema=USER1;dbname=DB;user=USER1";
      LOG << "Example: " << argv[0] << " '" << dbIdOra << "'\n" << std::endl;
      return 1;
    }
    else {
      dbId = argv[1];
    }

    // Instantiate a COOL Application
    CoralApplication app;

    // If we can access a LFC and the user is not explicitely forbidding it,
    // we try to use CORAL LFCReplicaService
    if ( ::getenv("COOL_IGNORE_LFC") == NULL &&
         ::getenv("LFC_HOST") != NULL )
    {
      // try to load CORAL LFCReplicaService
      coral::IConnectionServiceConfiguration &connSvcConf =
        app.connectionSvc().configuration();
      connSvcConf.setAuthenticationService("CORAL/Services/LFCReplicaService");
      connSvcConf.setLookupService("CORAL/Services/LFCReplicaService");
    }

    // Create a schema evolution manager
    cool::CoralConnectionServiceProxyPtr ppConnSvc
      ( new cool::CoralConnectionServiceProxy( &app.connectionSvc() ) );
    RalSchemaEvolution se( ppConnSvc, dbId );

    // Evolve the schema of the whole database
    se.evolveDatabase();

    // Close the session manager access to the CORAL connection service
    ppConnSvc->purgeConnectionPool();
    ppConnSvc->resetICS();

  }

  catch( cool::Exception& e )
  {
    LOG << "ERROR! Cool Exception: '" << e.what() << "'" << std::endl;
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
  LOG << "Schema evolution successfully completed" << std::endl;
  return 0;

}

//-----------------------------------------------------------------------------
