// First of all, enable or disable the CORAL240 API extensions (bug #89707)
#include "CoralBase/VersionInfo.h"

// Include files
#include <cstdlib>
#include <exception>
#include <iostream>
#include "CoralBase/AttributeSpecification.h"
#include "CoralBase/Date.h"
#include "CoralBase/../tests/Common/CoralCppUnitTest.h"

// Forward declaration (for easier indentation)
namespace coral
{
  class DateTest;
}

// The test class
class coral::DateTest : public coral::CoralCppUnitTest
{

  CPPUNIT_TEST_SUITE( DateTest );
  CPPUNIT_TEST( test_date );
  CPPUNIT_TEST_SUITE_END();

public:

  void setUp()
  {
    // Make test results independent of shell TZ (try setenv TZ 'Asia/Kolkata')
    ::setenv( "TZ", "Europe/Zurich", 1 );
  }

  void tearDown() {}

  // ------------------------------------------------------

  void test_date()
  {
    std::cout << std::endl;
    std::cout << "Testing the \""
              << coral::AttributeSpecification::typeNameForType<coral::Date>()
              << "\" type..." << std::endl;
#ifndef CORAL300CPP11
    coral::Date locToday = coral::Date::today();
    std::cout << "The (local) date today is "
              << locToday.day() << "/"
              << locToday.month() << "/"
              << locToday.year() << std::endl;
#endif
    coral::Date utcToday;
    std::cout << "The (UTC) date today is "
              << utcToday.day() << "/"
              << utcToday.month() << "/"
              << utcToday.year() << std::endl;
    coral::Date utcBday( 1999, 12, 21 );
    std::cout << "Danae was born on "
              << utcBday.day() << "/"
              << utcBday.month() << "/"
              << utcBday.year() << std::endl;
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "YY utcBday", 1999, utcBday.year() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "MM utcBday", 12, utcBday.month() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "DD utcBday", 21, utcBday.day() );
  }

  // ------------------------------------------------------

};

CPPUNIT_TEST_SUITE_REGISTRATION( coral::DateTest );

CORALCPPUNITTEST_MAIN( DateTest )
