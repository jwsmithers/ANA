// $Id: test_RalDatabaseSvc.cpp,v 1.44 2013-03-08 11:44:43 avalassi Exp $

// Include files
#include <iostream>
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/Exception.h"

// Local include files
//#define COOLUNITTESTTIMER 1
//#define COOLDBUNITTESTDEBUG 1
#include "tests/Common/CoolDBUnitTest.h"
#include "src/CoralApplication.h"
#include "src/VersionInfo.h"

// Forward declaration (for easier indentation)
namespace cool
{
  class RalDatabaseSvcTest;
}

// The test class
class cool::RalDatabaseSvcTest : public cool::CoolDBUnitTest
{

private:

  CPPUNIT_TEST_SUITE( RalDatabaseSvcTest );
  CPPUNIT_TEST( test_getService );
  CPPUNIT_TEST( test_serviceVersion );
  CPPUNIT_TEST( test_createDatabase );
  CPPUNIT_TEST( test_openDatabase );
  CPPUNIT_TEST( test_openDatabase_rw );
  CPPUNIT_TEST( test_openDatabase_nonexisting );
  CPPUNIT_TEST_SUITE_END();

public:

  /// Tests openDatabase on a nonexisting database
  void test_openDatabase_nonexisting()
  {
    CoralApplication app;
    IDatabaseSvc& dbSvc = app.databaseService();
    dbSvc.dropDatabase( s_connectionString );
    CPPUNIT_ASSERT_THROW( dbSvc.openDatabase( s_connectionString ),
                          DatabaseDoesNotExist );
    // Cleanup
    if ( !getenv( "COOL_RALDATABASESVCTEST_SKIP_DROPDB" ) ) dropDB();
  }

  /// Tests openDatabase
  void test_openDatabase()
  {
    try {
      CoralApplication app;
      IDatabaseSvc& dbSvc = app.databaseService();
      //std::cout << "Drop database..." << std::endl;
      dbSvc.dropDatabase( s_connectionString );
      //std::cout << "Drop database... OK" << std::endl;
      //std::cout << "Create database..." << std::endl;
      dbSvc.createDatabase( s_connectionString );
      //std::cout << "Create database... OK" << std::endl;
      //std::cout << "Open database R/O..." << std::endl;
      try
      {
        s_db = dbSvc.openDatabase( s_connectionString, true );
        //std::cout << "Open database R/O... OK" << std::endl;
      }
      catch( ... )
      {
        std::cout << "Open database R/O... FAILED!" << std::endl;
        std::cout << "Open database R/W..." << std::endl;
        s_db = dbSvc.openDatabase( s_connectionString, false );
        std::cout << "Open database R/W... OK" << std::endl;
        throw;
      }
      CPPUNIT_ASSERT( s_db.get() != 0 );
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
    // Cleanup
    if ( !getenv( "COOL_RALDATABASESVCTEST_SKIP_DROPDB" ) ) dropDB();
  }

  /// Tests openDatabase
  void test_openDatabase_rw()
  {
    try {
      CoralApplication app;
      IDatabaseSvc& dbSvc = app.databaseService();
      dbSvc.dropDatabase( s_connectionString );
      dbSvc.createDatabase( s_connectionString );
      s_db = dbSvc.openDatabase( s_connectionString, false );
      CPPUNIT_ASSERT( s_db.get() != 0 );
    } catch ( std::exception& e ) {
      std::cout << e.what() << std::endl;
      throw;
    }
    // Cleanup
    if ( !getenv( "COOL_RALDATABASESVCTEST_SKIP_DROPDB" ) ) dropDB();
  }

  /// Tests createDatabase
  void test_createDatabase()
  {
    try {
      CoralApplication app;
      IDatabaseSvc& dbSvc = app.databaseService();
      dbSvc.dropDatabase( s_connectionString );
      s_db = dbSvc.createDatabase( s_connectionString );
      CPPUNIT_ASSERT( s_db.get() != 0 );
    } catch ( std::exception& e ) {
      std::cout << e.what() << std::endl;
      throw;
    }
    // Cleanup
    if ( !getenv( "COOL_RALDATABASESVCTEST_SKIP_DROPDB" ) ) dropDB();
  }

  /// Tests IDatabaseSvc::serviceVersion()
  void test_serviceVersion()
  {
    CoralApplication app;
    IDatabaseSvc& dbSvc = app.databaseService();
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "IDatabaseSvc version",
        std::string(VersionInfo::release),
        dbSvc.serviceVersion() );
  }

  /// Tests the getService method for the RalDatabaseSvc
  /// (the seal plugin/context mechanism)
  void test_getService()
  {
    CoralApplication app;
    app.databaseService();
    //CPPUNIT_ASSERT_MESSAGE( "reach this point without exception", true );
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  /// Constructor (executed N times, _before_ all N test executions)
  /// NB This test is testing the service, so I cannot get it in the ctor!
  RalDatabaseSvcTest()
    : cool::CoolDBUnitTest( false ) // do not load the service
  {
  }

  // Destructor (executed N times, _after_ all N test executions)
  ~RalDatabaseSvcTest()
  {
  }

private:

  // Setup (executed N times, at the start of each test execution)
  void coolUnitTest_setUp()
  {
  }

  // TearDown (executed N times, at the end of each test execution)
  void coolUnitTest_tearDown()
  {
  }

};

CPPUNIT_TEST_SUITE_REGISTRATION( cool::RalDatabaseSvcTest );

COOLTEST_MAIN( RalDatabaseSvcTest )
