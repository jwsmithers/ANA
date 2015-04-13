#include <iostream>
#include <sstream>
#include <exception>
#include "CoralBase/Exception.h"
#include "TestDriver.h"
#include <cstdlib>

#include "TestEnv/TestEnv.h"

int main( int argc, char *argv[] )
{
  try
  {
    TestEnv te("CS_STOREDPROCEDURES");

    if ( ! te.check(argc, argv) ) return 1;

    // Move these three inside try block to fix Coverity UNCAUGHT_EXCEPT
    te.addServiceName(TEST_CORE_SCHEME_ADMIN);
    te.addServiceName(TEST_CORE_SCHEME_ADMIN);
    te.addServiceName(TEST_CORE_SCHEME_ADMIN);

    TestDriver testDriver;

    for ( int i = 0; i < 1; ++i ) {

      //      std::ostringstream os;
      //      os << "/dbdev/service_" << i + 1;
      std::string serviceName = te.getServiceName(i);

      std::cout << "  running for " << serviceName << "..." << std::endl;
      testDriver.run( serviceName );

      std::cout << "[OVAL] Test for database service " << serviceName << " passed." << std::endl;
    }

  }
  catch ( coral::Exception& e )
  {
    std::cerr << "CORAL Exception : " << e.what() << std::endl;
    return 1;
  }
  catch ( std::exception& e )
  {
    std::cerr << "C++ Exception : " << e.what() << std::endl;
    return 1;
  }
  catch ( ... )
  {
    std::cerr << "Unhandled exception " << std::endl;
    return 1;
  }
  std::cout << "[OVAL] Success" << std::endl;
  return 0;
}
