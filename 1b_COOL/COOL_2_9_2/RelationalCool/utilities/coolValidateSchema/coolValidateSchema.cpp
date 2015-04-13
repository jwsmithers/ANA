// $Id: coolValidateSchema.cpp,v 1.7 2011-04-10 20:38:51 avalassi Exp $

// Include files
#include <iostream>
#include "CoolKernel/IDatabase.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "RelationalAccess/IConnectionService.h"
#include "RelationalAccess/IConnectionServiceConfiguration.h"

// Local include files
#include "RalSchemaValidation.h"
#include "../../src/CoralApplication.h"
#include "../../src/RalDatabase.h"
#include "../../src/TransRalDatabase.h"
#include "../../src/VersionInfo.h"

// Namespace
using namespace cool;

// Message output
#define LOG  std::cout
#define ENDL std::endl

//-----------------------------------------------------------------------------

int main( int argc, char** argv )
{

  LOG << "Schema validation starting" << ENDL;

  try {

    // Get the command line arguments
    std::string dbId;
    if ( argc != 2 ) {
      LOG << "Usage: " << argv[0] << " dbId" << ENDL;
      std::string dbIdOra =
        "oracle://SERVER;schema=USER1;dbname=DB;user=USER1";
      LOG << "Example: " << argv[0] << " '" << dbIdOra << "'\n" << ENDL;
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
      coral::IConnectionServiceConfiguration& connSvcConf =
        app.connectionSvc().configuration();
      connSvcConf.setAuthenticationService("CORAL/Services/LFCReplicaService");
      connSvcConf.setLookupService("CORAL/Services/LFCReplicaService");
    }

    // Open the database and create a schema validation manager
    IDatabaseSvc& dbSvc = app.databaseService();
    IDatabasePtr db = dbSvc.openDatabase( dbId ); // open in readOnly mode
    RalDatabase* ralDb =
      dynamic_cast<TransRalDatabase*>( db.get() )->getRalDb();
    RalSchemaValidation sv( ralDb );

    // Validate the schema of the whole database
    sv.validateDatabase();

  }

  catch( cool::Exception& e )
  {
    LOG << "ERROR! Cool Exception: '" << e.what() << "'" << ENDL;
    return 1;
  }

  catch( std::exception& e )
  {
    LOG << "ERROR! Standard C++ exception: '" << e.what() << "'" << ENDL;
    return 1;
  }

  catch( ... )
  {
    LOG << "ERROR! Unknown exception caught" << ENDL;
    return 1;
  }

  // Successful program termination
  LOG << "Schema validation successfully completed" << ENDL;
  return 0;

}

//-----------------------------------------------------------------------------
