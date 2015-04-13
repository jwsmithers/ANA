#include <iostream>

#include "CoolKernel/types.h"
#include "CoolKernel/IDatabase.h"
#include "CoolKernel/IDatabaseSvc.h"

#include "CoolApplication/Application.h"
#include "CoolApplication/DatabaseSvcFactory.h"

#include "RelationalAccess/ConnectionService.h"
#include "RelationalAccess/IConnectionServiceConfiguration.h"

int main (int argc, char *argv[])
{

  cool::DatabaseId dbId;

  if ( argc != 2 ) {
    std::stringstream msg;
    std::cerr << "ERROR! Wrong number of arguments (" << argc-1
              << ") to " << argv[0] << std::endl;
    return 1;
  }
  else {
    dbId = argv[1];
  }

  try {

    // Initialize COOL Application
    std::auto_ptr<cool::Application> app(new cool::Application());

    // handle to the coral connection service configuration
    coral::IConnectionServiceConfiguration &connSvcConf =
      app->connectionSvc().configuration();

    // use CORAL LFCReplicaService
    connSvcConf.setAuthenticationService("CORAL/Services/LFCReplicaService");
    connSvcConf.setLookupService("CORAL/Services/LFCReplicaService");

    // Connect to the database
    cool::IDatabaseSvc &dbSvc = app->databaseService();
    cool::IDatabasePtr db = dbSvc.openDatabase(dbId);

    // Work with the database
    // ...
    std::cout << "Nodes in the database:" << std::endl;
    std::vector<std::string> nodes = db->listAllNodes();
    for ( std::vector<std::string>::const_iterator i = nodes.begin();
          i != nodes.end(); ++i ) {
      std::cout << *i << std::endl;
    }
    // ...
  }
  catch (std::exception &e) {
    std::cerr << "Exception: " << e.what() << std::endl;
    return 1;
  }

  return 0;
}
