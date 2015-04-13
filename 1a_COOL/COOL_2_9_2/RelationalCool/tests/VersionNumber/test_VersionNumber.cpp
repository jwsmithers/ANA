// $Id: test_VersionNumber.cpp,v 1.7 2013-03-08 11:44:45 avalassi Exp $

// Local include files
//#define COOLUNITTESTTIMER 1
//#define COOLDBUNITTESTDEBUG 1
#include "tests/Common/CoolDBUnitTest.h"
#include "../../src/VersionNumber.h"

// Forward declaration (for easier indentation)
namespace cool
{
  class VersionNumberTest;
}

// The test class
class cool::VersionNumberTest : public cool::CoolUnitTest
{

private:

  CPPUNIT_TEST_SUITE( VersionNumberTest );
  CPPUNIT_TEST( test_constructor );
  CPPUNIT_TEST( test_conversion );
  CPPUNIT_TEST( test_print );
  CPPUNIT_TEST( test_comparison );
  CPPUNIT_TEST_SUITE_END();

public:

  // ------------------------------------------------------
  void test_constructor()
  {
    VersionNumber a("1.2.3");
    CPPUNIT_ASSERT_MESSAGE("char * constructor failed",
                           a.majorVersion() == 1
                           && a.minorVersion() == 2
                           && a.patchVersion() == 3);
    VersionNumber b(std::string("3.4.5"));
    CPPUNIT_ASSERT_MESSAGE("std::string constructor failed",
                           b.majorVersion() == 3
                           && b.minorVersion() == 4
                           && b.patchVersion() == 5);
    CPPUNIT_ASSERT_THROW( VersionNumber("x.y") , std::runtime_error );
  }

  // ------------------------------------------------------

  void test_conversion()
  {
    VersionNumber a("1.2.3");
    std::string s = a;
    CPPUNIT_ASSERT( s == "1.2.3" );
  }

  // ------------------------------------------------------

  void test_print()
  {
    VersionNumber a("9.8.7");
    std::ostringstream o;
    o << a;
    CPPUNIT_ASSERT( o.str() == (std::string)a );
  }

#define TEST_CMP_LT(A,B) CPPUNIT_ASSERT_MESSAGE \
  ( A " < "  B, VersionNumber(A) < B )

#define TEST_CMP_EQ(A,B) CPPUNIT_ASSERT_MESSAGE \
  ( A " == " B, VersionNumber(A) == B )

#define TEST_CMP_GT(A,B) CPPUNIT_ASSERT_MESSAGE \
  ( A " > " B, VersionNumber(A) > B )

#define TEST_CMP(A,B) TEST_CMP_LT(A,B);         \
  TEST_CMP_EQ(A,A);                             \
  TEST_CMP_EQ(B,B);                             \
  TEST_CMP_GT(B,A);

  // ------------------------------------------------------

  void test_comparison()
  {
    TEST_CMP( "1.0.0", "2.0.0" );
    TEST_CMP( "0.1.0", "0.2.0" );
    TEST_CMP( "0.0.1", "0.0.2" );
    TEST_CMP( "0.999.0", "1.0.2" );
    TEST_CMP( "0.0.999", "0.1.0" );
  }

#undef  TEST_CMP_LT
#undef  TEST_CMP_EQ
#undef  TEST_CMP_GT
#undef  TEST_CMP

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  // Constructor (executed N times, _before_ all N test executions)
  VersionNumberTest() : CoolUnitTest()
  {
  }

  // Destructor (executed N times, _after_ all N test executions)
  ~VersionNumberTest()
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

CPPUNIT_TEST_SUITE_REGISTRATION( cool::VersionNumberTest );

COOLTEST_MAIN(VersionNumberTest)
