#include <cstdlib>
#include <exception>
#include <iostream>
#include "CoralBase/Exception.h"
#include "TestApp.h"

int main( int argc, char *argv[] )
{
  try // Move everything inside try block to fix Coverity UNCAUGHT_EXCEPT
  {
    TestApp app("MSERVICE");
    if ( !app.check( argc, argv ) ) return 1;
    app.addServiceName(TEST_CORE_SCHEME_ADMIN);
    app.run();
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
