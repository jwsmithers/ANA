// $Id: test_RelationalDatabaseId.cpp,v 1.14 2013-03-08 10:53:24 avalassi Exp $

// Local include files
//#define COOLUNITTESTTIMER 1
#include "CoolKernel/../tests/Common/CoolUnitTest.h"
#include "src/RelationalDatabaseId.h"
#include "src/RelationalException.h"

// Forward declaration (for easier indentation)
namespace cool
{
  class RelationalDatabaseIdTest;
}

// The test class
class cool::RelationalDatabaseIdTest : public cool::CoolUnitTest
{

private:

  CPPUNIT_TEST_SUITE( RelationalDatabaseIdTest );
  CPPUNIT_TEST( test_technologies );
  CPPUNIT_TEST( test_alias );
  CPPUNIT_TEST( test_alias_role );
  CPPUNIT_TEST( test_user );
  CPPUNIT_TEST( test_password );
  CPPUNIT_TEST( test_cached_urls );
  CPPUNIT_TEST( test_cached_urls_alias );
  CPPUNIT_TEST( test_cached_urls_alias_role );
  CPPUNIT_TEST( test_order );
  CPPUNIT_TEST( test_missing );
  CPPUNIT_TEST( test_bad_url );
  CPPUNIT_TEST( test_middleTier );
  CPPUNIT_TEST_SUITE_END();

public:

  void basic_test( const std::string connString,
                   const std::string middleTier,
                   const std::string tech,
                   const std::string server,
                   const std::string schema,
                   const std::string dbname,
                   const std::string user="",
                   const std::string password="",
                   const std::string alias="",
                   const std::string role="")
  {
    RelationalDatabaseId id(connString);

    std::string msg = "Failed to parse '" + connString + "'";

    CPPUNIT_ASSERT_EQUAL_MESSAGE( msg, middleTier, id.middleTier() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( msg, tech,       id.technology() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( msg, server,     id.server()     );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( msg, schema,     id.schema()     );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( msg, dbname,     id.dbName()     );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( msg, user,       id.user()       );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( msg, password,   id.password()   );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( msg, alias,      id.alias()      );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( msg, role,       id.role()       );
  }

  void test_technologies()
  {
    basic_test("oracle://server;schema=theSchema;dbname=DBNAME",
               "","oracle","server","theSchema","DBNAME");
    basic_test("mysql://server;schema=theSchema;dbname=DBNAME",
               "","mysql","server","theSchema","DBNAME");
    basic_test("sqlite://server;schema=theSchema;dbname=DBNAME",
               "","sqlite","server","theSchema","DBNAME");
  }

  void test_middleTier()
  {
    basic_test
      ("coralxxx://host:port&oracle://server;schema=theSchema;dbname=DBNAME",
       "coralxxx://host:port&","oracle","server","theSchema","DBNAME");
    try
    {
      RelationalDatabaseId
        id("xxx://host:port&oracle://server;schema=theSchema;dbname=DBNAME");
      CPPUNIT_FAIL( "middleTier prefix starting with xxx should fail" );
    }
    catch ( RelationalException& ) {}
  }

  void test_alias()
  {
    basic_test("alias/DBNAME",
               "","","","","DBNAME","","","alias");
  }

  void test_alias_role()
  {
    basic_test("alias(role)/DBNAME",
               "","","","","DBNAME","","","alias","role");
  }

  void test_user()
  {
    try
    {
      RelationalDatabaseId
        id("oracle://server;schema=theSchema;dbname=DBNAME;user=theUser");
      CPPUNIT_FAIL( "URL with username but no password should fail" );
    }
    catch ( RelationalException& ) {}
  }

  void test_password()
  {
    try
    {
      RelationalDatabaseId
        id("oracle://server;schema=theSchema;dbname=DBNAME;password=thePswd");
      CPPUNIT_FAIL( "URL with password but no username should fail" );
    }
    catch ( RelationalException& ) {}
  }

  void test_cached_urls()
  {
    RelationalDatabaseId id("oracle://server;schema=theSchema;dbname=DBNAME;user=theUser;password=thePassword");
    CPPUNIT_ASSERT_EQUAL(std::string("oracle://server;schema=theSchema;dbname=DBNAME;user=theUser;password=thePassword"),
                         id.url());
    CPPUNIT_ASSERT_EQUAL(std::string("oracle://server;schema=theSchema;dbname=DBNAME;user=theUser;password=********"),
                         id.urlHidePswd());
    CPPUNIT_ASSERT_EQUAL(std::string("oracle://server;schema=theSchema;user=theUser;password=thePassword"),
                         id.urlNoDbname());
  }

  void test_cached_urls_alias()
  {
    RelationalDatabaseId id("alias/DBNAME");
    CPPUNIT_ASSERT_EQUAL(std::string("alias/DBNAME"),
                         id.url());
    CPPUNIT_ASSERT_EQUAL(std::string("alias/DBNAME"),
                         id.urlHidePswd());
    CPPUNIT_ASSERT_EQUAL(std::string("alias"),
                         id.urlNoDbname());
  }

  void test_cached_urls_alias_role()
  {
    RelationalDatabaseId id("alias(role)/DBNAME");
    CPPUNIT_ASSERT_EQUAL(std::string("alias(role)/DBNAME"),
                         id.url());
    CPPUNIT_ASSERT_EQUAL(std::string("alias(role)/DBNAME"),
                         id.urlHidePswd());
    CPPUNIT_ASSERT_EQUAL(std::string("alias(role)"),
                         id.urlNoDbname());
  }

  void test_order()
  {
    CPPUNIT_ASSERT_EQUAL(std::string("oracle://server;schema=theSchema;dbname=DBNAME;user=theUser;password=thePassword"),
                         RelationalDatabaseId("oracle://server;user=theUser;dbname=DBNAME;schema=theSchema;password=thePassword")
                         .url());
  }

  void test_missing()
  {
    CPPUNIT_ASSERT_THROW(RelationalDatabaseId("oracle://server;dbname=DBNAME;user=theUser;password=thePassword"),
                         RelationalException);
    CPPUNIT_ASSERT_THROW(RelationalDatabaseId("oracle://server;schema=theSchema;user=theUser;password=thePassword"),
                         RelationalException);
    CPPUNIT_ASSERT_THROW(RelationalDatabaseId("alias/"),
                         RelationalException);
  }

  void test_bad_url()
  {
    CPPUNIT_ASSERT_THROW( RelationalDatabaseId( "abcd://server;schema=theSchema;dbname=DBNAME;user=theUser;password=thePassword" ),
                          RelationalException);
    CPPUNIT_ASSERT_THROW(RelationalDatabaseId("bad:url"),
                         RelationalException);
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  // Constructor (executed N times, _before_ all N test executions)
  RelationalDatabaseIdTest() : CoolUnitTest()
  {
  }

  // Destructor (executed N times, _after_ all N test executions)
  ~RelationalDatabaseIdTest()
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

CPPUNIT_TEST_SUITE_REGISTRATION( cool::RelationalDatabaseIdTest );

COOLTEST_MAIN( RelationalDatabaseIdTest )
