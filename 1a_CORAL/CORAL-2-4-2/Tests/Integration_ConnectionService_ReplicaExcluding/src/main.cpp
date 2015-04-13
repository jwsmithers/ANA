#include "TestApp.h"
#include "CoralBase/Exception.h"
#include <iostream>
#include <exception>
#include <cstdlib>

#define TEST_CORE_REPLICA_EXCLUDING_0 "replicaExcluding0"
#define TEST_CORE_REPLICA_EXCLUDING_1 "replicaExcluding1"
#define TEST_CORE_REPLICA_EXCLUDING_2 "replicaExcluding2"

int main( int argc, char *argv[] )
{
  TestApp app("CS_REPLICAEXCLUDING");

  if(app.check(argc, argv))
  {

    app.addServiceName(TEST_CORE_SCHEME_ADMIN);

    app.addServiceName(TEST_CORE_REPLICA_EXCLUDING_0);
    app.addServiceName(TEST_CORE_REPLICA_EXCLUDING_1);
    app.addServiceName(TEST_CORE_REPLICA_EXCLUDING_2);
    try
    {
      app.run();
    }
    TESTCORE_FETCHERRORS
      }
  return 1;
}
