
// Include files
#include <iostream>
#include <stdlib.h> // For setenv and _putenv
#include "CoralMonitor/StopTimer.h"
#include "CoralSockets/PollServer.h"

// Local include files
#include "../../src/DummyRequestHandlerFactory.h"

// Namespace
using namespace coral::CoralSockets;

//-----------------------------------------------------------------------------

/** @file socketServerMT.cpp
 *
 *  @author Andrea Valassi and Martin Wache
 *  @date   2007-12-26
 *///

int main( int argc, char** argv )
{
  try
  {
    // Get the server parameters
    std::string host;
    int port;
    //bool debug = false;
    if ( argc == 1 )
    {
      host = "localhost";
      port = 50017;
      //debug = true;
    }
    /*
    else if ( argc == 7 || argc == 8 )
    {
      host = argv[1];
      port = atoi( argv[2] );
      bufferSize = atoi( argv[3] );
      timeout = atoi( argv[4] );
      if ( atoi( argv[6] ) == 1 ) debug = true;
      if ( argc == 8 && std::string( argv[7] ) == std::string( "SLAC" ) ) SLAC = true;
    }
    else
    {
      LOG << "Usage:   " << argv[0]
          << " [host port bufferSize timeout #handlerThreadsPerSocket debug [SLAC]]" << std::endl;
      LOG << "Example: " << argv[0] << " localhost 50017 8192 10 10 1" << std::endl;
      LOG << "Example: " << argv[0] << " localhost 60017 8192 10 10 1 SLAC" << std::endl;
      return 1;
    }
    *///
    else
    {
      std::cout << "Usage:   " << argv[0] << std::endl;
      return 1;
    }

    // Start the server
    std::cout << "Entering main" << std::endl;
    std::cout << "Create a dummy request handler factory" << std::endl;
    //coral::CoralServerBase::DummyRequestHandlerFactory handlerFactory;
    std::cout << "Start the server on " << host << ":" << port << std::endl;

    coral::CoralSockets::DummyRequestHandlerFactory dummyHandlerFactory;
    PollServer server( dummyHandlerFactory, host, port,
#ifdef HAVE_OPENSSL
                       "",0, // we don't want ssl ports even if they are supported
#endif
                       10);

    server.run( -1 );

    std::cout << "Exiting main" << std::endl;

  }

  catch( std::exception& e )
  {
    std::cout << "ERROR! Standard C++ exception: '" << e.what() << "'" << std::endl;
    return 1;
  }

  catch( ... )
  {
    std::cout << "ERROR! Unknown exception caught" << std::endl;
    return 1;
  }

  //coral::printTimers();
  // Successful program termination
  return 0;

}

//-----------------------------------------------------------------------------
