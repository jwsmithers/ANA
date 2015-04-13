// $Id: test_ObjectId.cpp,v 1.17 2013-03-08 10:53:24 avalassi Exp $

// Local include files
//#define COOLUNITTESTTIMER 1
#include "CoolKernel/../tests/Common/CoolUnitTest.h"
#include "src/ObjectId.h"

// Forward declaration (for easier indentation)
namespace cool
{
  class ObjectIdTest;
}

// The test class
class cool::ObjectIdTest : public cool::CoolUnitTest
{

private:

  CPPUNIT_TEST_SUITE( ObjectIdTest );
  CPPUNIT_TEST( test_ObjectId1 );
  CPPUNIT_TEST( test_ObjectId2 );
  CPPUNIT_TEST( test_ObjectId3 );
  CPPUNIT_TEST( test_ObjectId4 );
  CPPUNIT_TEST( test_ObjectId5 );
  CPPUNIT_TEST( test_ObjectId6 );
  CPPUNIT_TEST( test_ObjectId7 );
  CPPUNIT_TEST( test_ObjectId8 );
  CPPUNIT_TEST( test_ObjectId9 );
  CPPUNIT_TEST( test_maxId );
  CPPUNIT_TEST( test_maxId_overflow );
  CPPUNIT_TEST_SUITE_END();

public:

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_ObjectId1() {
    ObjectId id = 1;
    CPPUNIT_ASSERT_MESSAGE
      ( "isUserObject", ObjectIdHandler::isUserObject(id) == true );
    CPPUNIT_ASSERT_MESSAGE
      ( "isLSysObject", ObjectIdHandler::isLSysObject(id) == false );
    CPPUNIT_ASSERT_MESSAGE
      ( "isRSysObject", ObjectIdHandler::isRSysObject(id) == false );
    CPPUNIT_ASSERT_MESSAGE
      ( "userObject", ObjectIdHandler::userObject(id) == 1 );
    CPPUNIT_ASSERT_MESSAGE
      ( "lSysObject", ObjectIdHandler::lSysObject(id) == 2 );
    CPPUNIT_ASSERT_MESSAGE
      ( "rSysObject", ObjectIdHandler::rSysObject(id) == 3 );
    CPPUNIT_ASSERT_MESSAGE
      ( "nextUserObject", ObjectIdHandler::nextUserObject(id) == 7 );
    try {
      ObjectIdHandler::prevUserObject(id);
      CPPUNIT_ASSERT_MESSAGE( "exception expected", false );
    } catch ( Exception& e ) {
      std::ostringstream msg;
      msg << "ObjectId '" << id << "' has no previous user object";
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "exception caught",  msg.str(), std::string( e.what() ) );
    }
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_ObjectId2() {
    ObjectId id = 2;
    CPPUNIT_ASSERT_MESSAGE
      ( "isUserObject", ObjectIdHandler::isUserObject(id) == false );
    CPPUNIT_ASSERT_MESSAGE
      ( "isLSysObject", ObjectIdHandler::isLSysObject(id) == true );
    CPPUNIT_ASSERT_MESSAGE
      ( "isRSysObject", ObjectIdHandler::isRSysObject(id) == false );
    CPPUNIT_ASSERT_MESSAGE
      ( "userObject", ObjectIdHandler::userObject(id) == 1 );
    CPPUNIT_ASSERT_MESSAGE
      ( "lSysObject", ObjectIdHandler::lSysObject(id) == 2 );
    CPPUNIT_ASSERT_MESSAGE
      ( "rSysObject", ObjectIdHandler::rSysObject(id) == 3 );
    CPPUNIT_ASSERT_MESSAGE
      ( "nextUserObject", ObjectIdHandler::nextUserObject(id) == 7 );
    try {
      ObjectIdHandler::prevUserObject(id);
      CPPUNIT_ASSERT_MESSAGE( "exception expected", false );
    } catch ( Exception& e ) {
      std::ostringstream msg;
      msg << "ObjectId '" << id << "' has no previous user object";
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "exception caught", std::string( e.what() ), msg.str() );
    }
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_ObjectId3() {
    ObjectId id = 3;
    CPPUNIT_ASSERT_MESSAGE
      ( "isUserObject", ObjectIdHandler::isUserObject(id) == false );
    CPPUNIT_ASSERT_MESSAGE
      ( "isLSysObject", ObjectIdHandler::isLSysObject(id) == false );
    CPPUNIT_ASSERT_MESSAGE
      ( "isRSysObject", ObjectIdHandler::isRSysObject(id) == true );
    CPPUNIT_ASSERT_MESSAGE
      ( "userObject", ObjectIdHandler::userObject(id) == 1 );
    CPPUNIT_ASSERT_MESSAGE
      ( "lSysObject", ObjectIdHandler::lSysObject(id) == 2 );
    CPPUNIT_ASSERT_MESSAGE
      ( "rSysObject", ObjectIdHandler::rSysObject(id) == 3 );
    CPPUNIT_ASSERT_MESSAGE
      ( "nextUserObject", ObjectIdHandler::nextUserObject(id) == 7 );
    try {
      ObjectIdHandler::prevUserObject(id);
      CPPUNIT_ASSERT_MESSAGE( "exception expected", false );
    } catch ( Exception& e ) {
      std::ostringstream msg;
      msg << "ObjectId '" << id << "' has no previous user object";
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "exception caught", std::string( e.what() ), msg.str() );
    }
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_ObjectId4() {
    ObjectId id = 4; // this is unused and reserved for user tag related ids
    CPPUNIT_ASSERT_MESSAGE
      ( "isUserObject", ObjectIdHandler::isUserObject(id) == false );
    CPPUNIT_ASSERT_MESSAGE
      ( "isLSysObject", ObjectIdHandler::isLSysObject(id) == false );
    CPPUNIT_ASSERT_MESSAGE
      ( "isRSysObject", ObjectIdHandler::isRSysObject(id) == false );
    CPPUNIT_ASSERT_MESSAGE
      ( "userObject", ObjectIdHandler::userObject(id) == 1 );
    CPPUNIT_ASSERT_MESSAGE
      ( "lSysObject", ObjectIdHandler::lSysObject(id) == 2 );
    CPPUNIT_ASSERT_MESSAGE
      ( "rSysObject", ObjectIdHandler::rSysObject(id) == 3 );
    CPPUNIT_ASSERT_MESSAGE
      ( "nextUserObject", ObjectIdHandler::nextUserObject(id) == 7 );
    try {
      ObjectIdHandler::prevUserObject(id);
      CPPUNIT_ASSERT_MESSAGE( "exception expected", false );
    } catch ( Exception& e ) {
      std::ostringstream msg;
      msg << "ObjectId '" << id << "' has no previous user object";
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "exception caught", std::string( e.what() ), msg.str() );
    }
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_ObjectId5() {
    ObjectId id = 5; // this is unused and reserved for user tag related ids
    CPPUNIT_ASSERT_MESSAGE
      ( "isUserObject", ObjectIdHandler::isUserObject(id) == false );
    CPPUNIT_ASSERT_MESSAGE
      ( "isLSysObject", ObjectIdHandler::isLSysObject(id) == false );
    CPPUNIT_ASSERT_MESSAGE
      ( "isRSysObject", ObjectIdHandler::isRSysObject(id) == false );
    CPPUNIT_ASSERT_MESSAGE
      ( "userObject", ObjectIdHandler::userObject(id) == 1 );
    CPPUNIT_ASSERT_MESSAGE
      ( "lSysObject", ObjectIdHandler::lSysObject(id) == 2 );
    CPPUNIT_ASSERT_MESSAGE
      ( "rSysObject", ObjectIdHandler::rSysObject(id) == 3 );
    CPPUNIT_ASSERT_MESSAGE
      ( "nextUserObject", ObjectIdHandler::nextUserObject(id) == 7 );
    try {
      ObjectIdHandler::prevUserObject(id);
      CPPUNIT_ASSERT_MESSAGE( "exception expected", false );
    } catch ( Exception& e ) {
      std::ostringstream msg;
      msg << "ObjectId '" << id << "' has no previous user object";
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "exception caught", std::string( e.what() ), msg.str() );
    }
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_ObjectId6() {
    ObjectId id = 6; // this is unused and reserved for user tag related ids
    CPPUNIT_ASSERT_MESSAGE
      ( "isUserObject", ObjectIdHandler::isUserObject(id) == false );
    CPPUNIT_ASSERT_MESSAGE
      ( "isLSysObject", ObjectIdHandler::isLSysObject(id) == false );
    CPPUNIT_ASSERT_MESSAGE
      ( "isRSysObject", ObjectIdHandler::isRSysObject(id) == false );
    CPPUNIT_ASSERT_MESSAGE
      ( "userObject", ObjectIdHandler::userObject(id) == 1 );
    CPPUNIT_ASSERT_MESSAGE
      ( "lSysObject", ObjectIdHandler::lSysObject(id) == 2 );
    CPPUNIT_ASSERT_MESSAGE
      ( "rSysObject", ObjectIdHandler::rSysObject(id) == 3 );
    CPPUNIT_ASSERT_MESSAGE
      ( "nextUserObject", ObjectIdHandler::nextUserObject(id) == 7 );
    try {
      ObjectIdHandler::prevUserObject(id);
      CPPUNIT_ASSERT_MESSAGE( "exception expected", false );
    } catch ( Exception& e ) {
      std::ostringstream msg;
      msg << "ObjectId '" << id << "' has no previous user object";
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "exception caught", std::string( e.what() ), msg.str() );
    }
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_ObjectId7() {
    ObjectId id = 7;
    CPPUNIT_ASSERT_MESSAGE
      ( "isUserObject", ObjectIdHandler::isUserObject(id) == true );
    CPPUNIT_ASSERT_MESSAGE
      ( "isLSysObject", ObjectIdHandler::isLSysObject(id) == false );
    CPPUNIT_ASSERT_MESSAGE
      ( "isRSysObject", ObjectIdHandler::isRSysObject(id) == false );
    CPPUNIT_ASSERT_MESSAGE
      ( "userObject", ObjectIdHandler::userObject(id) == 7 );
    CPPUNIT_ASSERT_MESSAGE
      ( "lSysObject", ObjectIdHandler::lSysObject(id) == 8 );
    CPPUNIT_ASSERT_MESSAGE
      ( "rSysObject", ObjectIdHandler::rSysObject(id) == 9 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "nextUserObject", 13u, ObjectIdHandler::nextUserObject(id) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "prevUserObject", 1u, ObjectIdHandler::prevUserObject(id) );
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_ObjectId8() {
    ObjectId id = 8;
    CPPUNIT_ASSERT_MESSAGE
      ( "isUserObject", ObjectIdHandler::isUserObject(id) == false );
    CPPUNIT_ASSERT_MESSAGE
      ( "isLSysObject", ObjectIdHandler::isLSysObject(id) == true );
    CPPUNIT_ASSERT_MESSAGE
      ( "isRSysObject", ObjectIdHandler::isRSysObject(id) == false );
    CPPUNIT_ASSERT_MESSAGE
      ( "userObject", ObjectIdHandler::userObject(id) == 7 );
    CPPUNIT_ASSERT_MESSAGE
      ( "lSysObject", ObjectIdHandler::lSysObject(id) == 8 );
    CPPUNIT_ASSERT_MESSAGE
      ( "rSysObject", ObjectIdHandler::rSysObject(id) == 9 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "nextUserObject", 13u, ObjectIdHandler::nextUserObject(id) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "prevUserObject", 1u, ObjectIdHandler::prevUserObject(id) );
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_ObjectId9() {
    ObjectId id = 9;
    CPPUNIT_ASSERT_MESSAGE
      ( "isUserObject", ObjectIdHandler::isUserObject(id) == false );
    CPPUNIT_ASSERT_MESSAGE
      ( "isLSysObject", ObjectIdHandler::isLSysObject(id) == false );
    CPPUNIT_ASSERT_MESSAGE
      ( "isRSysObject", ObjectIdHandler::isRSysObject(id) == true );
    CPPUNIT_ASSERT_MESSAGE
      ( "userObject", ObjectIdHandler::userObject(id) == 7 );
    CPPUNIT_ASSERT_MESSAGE
      ( "lSysObject", ObjectIdHandler::lSysObject(id) == 8 );
    CPPUNIT_ASSERT_MESSAGE
      ( "rSysObject", ObjectIdHandler::rSysObject(id) == 9 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "nextUserObject", 13u, ObjectIdHandler::nextUserObject(id) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "prevUserObject", 1u, ObjectIdHandler::prevUserObject(id) );
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


  void test_maxId() {
    ObjectId id = UINT_MAX; // == 4294967295
    CPPUNIT_ASSERT_MESSAGE
      ( "isUserObject", ObjectIdHandler::isUserObject(id) == false );
    CPPUNIT_ASSERT_MESSAGE
      ( "isLSysObject", ObjectIdHandler::isLSysObject(id) == false );
    CPPUNIT_ASSERT_MESSAGE
      ( "isRSysObject", ObjectIdHandler::isRSysObject(id) == true );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "userObject", 4294967293u, ObjectIdHandler::userObject(id) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "lSysObject", 4294967294u, ObjectIdHandler::lSysObject(id) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "rSysObject", 4294967295u, ObjectIdHandler::rSysObject(id) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "prevUserObject", 4294967287u, ObjectIdHandler::prevUserObject(id) );
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


  void test_maxId_overflow() {
    ObjectId id = UINT_MAX;
    CPPUNIT_ASSERT_THROW(ObjectIdHandler::nextUserObject(id) , ObjectIdException);
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  // Constructor (executed N times, _before_ all N test executions)
  ObjectIdTest() : CoolUnitTest()
  {
  }

  // Destructor (executed N times, _after_ all N test executions)
  ~ObjectIdTest()
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

CPPUNIT_TEST_SUITE_REGISTRATION( cool::ObjectIdTest );

COOLTEST_MAIN( ObjectIdTest )
