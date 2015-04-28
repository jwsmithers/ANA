
#include <iostream>
#include <string>
#include <set>

// COOL API: database service bootstrap
#include "CoolApplication/Application.h"
#include "CoolApplication/DatabaseSvcFactory.h"

// COOL API include files (CoolKernel)
#include "CoolKernel/Exception.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/IDatabase.h"
#include "CoolKernel/IFolder.h"
#include "CoolKernel/IObject.h"

//-----------------------------------------------------------------------------

int main ( int /* argc */, char** /* argv */ ) {

  // --------------------------------------------------
  // Main part
  // --------------------------------------------------

  try {

    // init COOL application
    cool::Application app;

    // drop and create a database
    app.databaseService().dropDatabase("CondDB/COOLTEST");
    app.databaseService().createDatabase("CondDB/COOLTEST");

    // ... do something interesting here ...

  }

  // COOL, CORAL POOL exceptions inherit from std exceptions: catching
  // std::exception will catch all errors from COOL, CORAL and POOL
  catch ( std::exception& e ) {
    std::cout << "std::exception caught: " << e.what() << std::endl;
    return -1;
  }

  catch (...) {
    std::cout << "Unknown exception caught!" << std::endl;
    return -1;
  }

  return 0;

}

//-----------------------------------------------------------------------------
