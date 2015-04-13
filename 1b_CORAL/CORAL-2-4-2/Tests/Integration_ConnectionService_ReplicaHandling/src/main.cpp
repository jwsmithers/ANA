#include "TestApp.h"
#include "CoralBase/Exception.h"
#include <iostream>
#include <exception>
#include <cstdlib>

#define TEST_CORE_REPLICA_SERVICE_0 "replica0"
#define TEST_CORE_REPLICA_SERVICE_1 "replica1"
#define TEST_CORE_REPLICA_SERVICE_2 "replica2"
#define TEST_CORE_REPLICA_SERVICE_3 "replica3"
#define TEST_CORE_REPLICA_SERVICE_4 "replica4"

int main( int argc, char *argv[] )
{
  TestApp app("CS_REPLICAHANDLING");

  if(app.check(argc, argv))
  {
    app.addServiceName(TEST_CORE_SCHEME_ADMIN);

    app.addServiceName(TEST_CORE_REPLICA_SERVICE_0);
    app.addServiceName(TEST_CORE_REPLICA_SERVICE_1);
    app.addServiceName(TEST_CORE_REPLICA_SERVICE_2);
    app.addServiceName(TEST_CORE_REPLICA_SERVICE_3);
    app.addServiceName(TEST_CORE_REPLICA_SERVICE_4);
    try
    {
      app.run();
    }
    TESTCORE_FETCHERRORS
      }
  return 1;
}
