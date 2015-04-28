// First of all, set/unset CORAL240, CORAL300 and CORAL_HAS_CPP11 macros
#include "CoralBase/VersionInfo.h"

// Include files
#include <climits>
#include <cstdlib>
#include <exception>
#include <iostream>
#include <typeinfo>
#include "CoralBase/AttributeSpecification.h"
#include "CoralBase/Exception.h"
#include "CoralBase/TimeStamp.h"
#include "CoralBase/../tests/Common/CoralCppUnitTest.h"

// Inline getTimeStampEpoch in CORAL3 (only used in this test)
#ifndef CORAL300CPP11
#include "CoralBase/../src/TimeStampEpoch.h"
#else
namespace coral
{
  inline const std::chrono::system_clock::time_point& getTimeStampEpoch()
  {
    static const std::chrono::system_clock::time_point s_epoch( std::chrono::system_clock::from_time_t( 0 ) );
    return s_epoch;
  }
}
#endif

// Forward declaration (for easier indentation)
namespace coral
{
  class TimeStampTest;
}

// The test class
class coral::TimeStampTest : public coral::CoralCppUnitTest
{

  CPPUNIT_TEST_SUITE( TimeStampTest );
  CPPUNIT_TEST( test_nsFromEpoch0 );
  CPPUNIT_TEST( test_nsFromEpoch123456789 );
  CPPUNIT_TEST( test_birthday );
  CPPUNIT_TEST( test_resolution );
  CPPUNIT_TEST( test_invalidInput );
  CPPUNIT_TEST_SUITE_END();

public:

  void setUp()
  {
    // Make test results independent of shell TZ (try setenv TZ 'Asia/Kolkata')
    ::setenv( "TZ", "Europe/Zurich", 1 );
  }

  void tearDown() {}

  // ------------------------------------------------------

  // Test bug #104298
  void test_nsFromEpoch0()
  {
    std::cout << std::endl;
    std::cout << "Show Epoch" << std::endl;
    std::cout << "&(getTimeStampEpoch()) is " << &(coral::getTimeStampEpoch()) << std::endl;
#ifndef CORAL300CPP11
    std::cout << "getTimeStampEpoch() is " << coral::getTimeStampEpoch() << std::endl;
#else
    std::time_t tEpoch = std::chrono::system_clock::to_time_t( coral::getTimeStampEpoch() );
    std::cout << "getTimeStampEpoch() is " << std::asctime( std::gmtime( &tEpoch ) ) << std::endl;
#endif
#ifndef CORAL240TS
    /// Remove this obsolete method from the CORAL240 API (bug #64016)
    std::cout << "In timeTest.cpp: &(Epoch) is " << &(coral::TimeStamp::Epoch) << std::endl;
#ifndef _WIN32
    std::cout << "Epoch is " << coral::TimeStamp::Epoch << std::endl;
#endif
#endif
    // Test invariant with epoch time
    coral::TimeStamp epoch( coral::getTimeStampEpoch() );
    std::cout << "Nanoseconds from epoch should be 0 ns and is " << epoch.total_nanoseconds() << " ns " << std::endl;
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "ns from epoch", 0LL, epoch.total_nanoseconds() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "YYYY epoch", 1970, epoch.year() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "MM epoch", 01, epoch.month() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "DD epoch", 01, epoch.day() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "hh epoch", 00, epoch.hour() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "mm epoch", 00, epoch.minute() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "ss epoch", 00, epoch.second() );
  }

  // ------------------------------------------------------

  // Test bug #104298
  void test_nsFromEpoch123456789()
  {
    std::cout << std::endl;
    coral::TimeStamp::ValueType ns123456789 = 123456789;
    coral::TimeStamp epoch123456789( 1970, 1, 1, 0, 0, 0, ns123456789 );
    std::cout << "1. CORAL Nanoseconds from epoch should be " << ns123456789
              << " ns and is " << epoch123456789.total_nanoseconds()
              << " ns " << std::endl; // In CORAL2xx the result depends on Boost
    std::cout << "2. CORAL frac. seconds from epoch should be " << ns123456789
              << " ns and is " << epoch123456789.nanosecond()
              << " ns " << std::endl;
#ifndef CORAL300CPP11
    // TimeStamp typically has Boost's microsecond resolution in CORAL2xx
    // TimeStamp is guaranteed to have nanosecond resolution in CORAL300!
    int digits = boost::posix_time::time_duration::num_fractional_digits();
    std::cout << "Boost fractional digits: " << digits << std::endl;
    if ( digits == 6 ) ns123456789 = (ns123456789/1000)*1000;
#endif
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "ns from epoch123456789", ns123456789, epoch123456789.total_nanoseconds() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "fractional sec from epoch123456789", (long)ns123456789, epoch123456789.nanosecond() );
  }

  // ------------------------------------------------------

  void
  test_birthday()
  {
    std::cout << std::endl;
    // --- Test now ---
    coral::TimeStamp utcDef;
    coral::TimeStamp utcNow  = coral::TimeStamp::now();
#ifndef CORAL300CPP11
    coral::TimeStamp locNow = coral::TimeStamp::now(true);
#endif
    std::cout << "Testing the \""
              << coral::AttributeSpecification::typeNameForType( utcNow )
              << "\" type..." << std::endl;
    std::cout << "UTC def: "
              << utcDef.day() << "-"
              << utcDef.month() << "-"
              << utcDef.year() << " "
              << utcDef.hour() << ":"
              << utcDef.minute() << ":"
              << utcDef.second() << "."
              << utcDef.nanosecond() << std::endl;
    std::cout << "UTC now: "
              << utcNow.day() << "-"
              << utcNow.month() << "-"
              << utcNow.year() << " "
              << utcNow.hour() << ":"
              << utcNow.minute() << ":"
              << utcNow.second() << "."
              << utcNow.nanosecond() << std::endl;
#ifndef CORAL300CPP11
    std::cout << "Loc now: "
              << locNow.day() << "-"
              << locNow.month() << "-"
              << locNow.year() << " "
              << locNow.hour() << ":"
              << locNow.minute() << ":"
              << locNow.second() << "."
              << locNow.nanosecond() << std::endl;
#endif
    std::cout << "UTC def ns: " << utcDef.total_nanoseconds() << std::endl;
    std::cout << "UTC now ns: " << utcNow.total_nanoseconds() << std::endl;
#ifndef CORAL300CPP11
    std::cout << "Loc now ns: " << locNow.total_nanoseconds() << std::endl;
#endif
    // --- Test a fixed moment ---
    coral::TimeStamp utcBday( 1999, 12, 21, 12, 10, 30, 213331 ); // UTC
    std::cout << "Danae was born on (UTC) " << utcBday.toString() << std::endl;
#ifndef CORAL300CPP11
    coral::TimeStamp locBday( 1999, 12, 21, 12, 10, 30, 213331, true ); // local
    std::cout << "Danae was born on (loc) " << locBday.toString() << std::endl;
#endif
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "YYYY utcBday", 1999, utcBday.year() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "MM utcBday", 12, utcBday.month() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "DD utcBday", 21, utcBday.day() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "hh utcBday", 12, utcBday.hour() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "mm utcBday", 10, utcBday.minute() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "ss utcBday", 30, utcBday.second() );
#ifndef CORAL300CPP11
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "YYYY locBday", 1999, utcBday.year() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "MM locBday", 12, locBday.month() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "DD locBday", 21, locBday.day() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "hh locBday", 12+1, locBday.hour() ); // +1!
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "mm locBday", 10, locBday.minute() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "ss locBday", 30, locBday.second() );
#endif
    // Check in python: dt = datetime.utcfromtimestamp(945778230000213331/1e9)
    // dt.strftime('%Y-%m-%dT%H:%M:%S.%f') ==> '1999-12-21T12:10:30.000213'
    coral::TimeStamp::ValueType nsUtcBday = 945778230000213331LL;
    std::cout << "Total ns utcBday should be " << nsUtcBday
              << " and are " << utcBday.total_nanoseconds() << std::endl;
#ifndef CORAL300CPP11
    // Local times are only supportted in CORAL2xx
    std::cout << "Total ns locBday should be " << nsUtcBday
              << " and are " << locBday.total_nanoseconds() << std::endl;
    // TimeStamp typically has Boost's microsecond resolution in CORAL2xx
    // TimeStamp is guaranteed to have nanosecond resolution in CORAL300!
    int digits = boost::posix_time::time_duration::num_fractional_digits();
    std::cout << "Boost fractional digits: " << digits << std::endl;
    if ( digits == 6 ) nsUtcBday = (nsUtcBday/1000)*1000;
#endif
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "tot ns utcBday", nsUtcBday, utcBday.total_nanoseconds() );
    // Test ctor from total nanoseconds
    coral::TimeStamp utcBday2( nsUtcBday );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "tot ns utcBday2", nsUtcBday, utcBday2.total_nanoseconds() );
    CPPUNIT_ASSERT_MESSAGE( "utcBday2 == utcBDay", utcBday == utcBday2 );
    // Test time() and ctor from its result
    // NB: system_clock has only microsecond resolution in the c++11 of icc13
    // (and high_resolution_clock is not better as it has the same resolution)!
    // Check time_point::period to fix bug #104622 on icc
    coral::TimeStamp utcBday3( utcBday.time() );
#ifdef CORAL300CPP11
    if ( typeid(std::chrono::system_clock::time_point::period) == typeid(std::micro) ) nsUtcBday = (nsUtcBday/1000)*1000;
#endif
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "tot ns utcBday3", nsUtcBday, utcBday3.total_nanoseconds() );
#ifndef CORAL300CPP11
    CPPUNIT_ASSERT_MESSAGE( "utcBday3 == utcBDay", utcBday3 == utcBday );
#else
    if ( typeid(std::chrono::system_clock::time_point::period) == typeid(std::nano) ) // loss of precision otherwise ONLY in c++11 time manipulations (eg icc)
      CPPUNIT_ASSERT_MESSAGE( "utcBday3 == utcBDay", utcBday3 == utcBday );
#endif
  }

  // ------------------------------------------------------

  void
  test_resolution()
  {
    // Test resolution 0ns != 1ns
    coral::TimeStamp::ValueType ns0( 0 );
    coral::TimeStamp::ValueType ns1( 1 );
    coral::TimeStamp ts0( ns0 );
    coral::TimeStamp ts1( ns1 );
#ifndef CORAL300CPP11
    // TimeStamp typically has Boost's microsecond resolution in CORAL2xx
    int digits = boost::posix_time::time_duration::num_fractional_digits();
    std::cout << "Boost fractional digits: " << digits << std::endl;
    if ( digits == 9 ) // loss of precision otherwise...
      CPPUNIT_ASSERT_MESSAGE( "ts0 != ts1", ts0 != ts1 );
#else
    // TimeStamp is guaranteed to have nanosecond resolution in CORAL300!
    CPPUNIT_ASSERT_MESSAGE( "ts0 != ts1", ts0 != ts1 );
#endif
#ifdef CORAL300CPP11
    // Test the beginning and the end of time for TimeStamp...
#if ((ULONG_MAX) == (UINT_MAX))
    // Beg of time for 32bit TimeStamp: 1901-12-13_20:45:52.000000000
    // End of time for 32bit TimeStamp: 2038-01-19_03:14:07.999999999
    const coral::TimeStamp::ValueType
      nsAlpha( LONG_MIN * 1000000000LL ); // -2147483648000000000
    const coral::TimeStamp::ValueType
      nsOmega( (-nsAlpha) - 1LL );        // +2147483647999999999
#else
    // Beg of time for 64bit TimeStamp: 1677-09-21_00:12:43.145224192
    // End of time for 64bit TimeStamp: 2262-04-11_23:47:16.854775807
    const coral::TimeStamp::ValueType
      nsAlpha( LONG_LONG_MIN ); // -9223372036854775808
    const coral::TimeStamp::ValueType
      nsOmega( LONG_LONG_MAX ); // +9223372036854775807
#endif
    coral::TimeStamp alpha( nsAlpha );
    coral::TimeStamp omega( nsOmega );
    std::cout << std::endl;
    std::cout << "alpha: " << alpha << " (" << nsAlpha << ")" << std::endl;
    std::cout << "omega: " << omega << " ( " << nsOmega << ")" << std::endl;
#if ((ULONG_MAX) == (UINT_MAX))
    // Test resolution around 1901-12-13_20:45:52.000000000
    coral::TimeStamp ts0a( 1901, 12, 13, 20, 45, 52, 0 );
    CPPUNIT_ASSERT_MESSAGE( "ts0a == alpha", ts0a == alpha );
    coral::TimeStamp ts1a( 1901, 12, 13, 20, 45, 52, 1 );
    CPPUNIT_ASSERT_MESSAGE( "ts0a != ts1a", ts0a != ts1a );
    // Test resolution around 2038-01-19_03:14:07.999999999
    coral::TimeStamp ts0z( 2038, 1, 19, 3, 14, 7, 999999999 );
    CPPUNIT_ASSERT_MESSAGE( "ts0z == omega", ts0z == omega );
    coral::TimeStamp ts1z( 2038, 1, 19, 3, 14, 7, 999999998 );
    CPPUNIT_ASSERT_MESSAGE( "ts0z != ts1z", ts0z != ts1z );
    // Test printout in the CORAL300 format (same as in cool::Time GMT)
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "alpha", std::string("'1901-12-13_20:45:52.000000000 GMT'"), "'"+alpha.toString()+"'" );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "omega", std::string("'2038-01-19_03:14:07.999999999 GMT'"), "'"+omega.toString()+"'" );
#else
    // Test resolution around 1677-09-21_00:12:43.145224192
    coral::TimeStamp ts0a( 1677, 9, 21, 0, 12, 43, 145224192 );
    CPPUNIT_ASSERT_MESSAGE( "ts0a == alpha", ts0a == alpha );
    coral::TimeStamp ts1a( 1677, 9, 21, 0, 12, 43, 145224193 );
    CPPUNIT_ASSERT_MESSAGE( "ts0a != ts1a", ts0a != ts1a );
    // Test resolution around 2262-04-11_23:47:16.854775807
    coral::TimeStamp ts0z( 2262, 04, 11, 23, 47, 16, 854775807 );
    CPPUNIT_ASSERT_MESSAGE( "ts0z == omega", ts0z == omega );
    coral::TimeStamp ts1z( 2262, 04, 11, 23, 47, 16, 854775806 );
    CPPUNIT_ASSERT_MESSAGE( "ts0z != ts1z", ts0z != ts1z );
    // Test printout in the CORAL300 format (same as in cool::Time GMT)
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "alpha", std::string("'1677-09-21_00:12:43.145224192 GMT'"), "'"+alpha.toString()+"'" );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "omega", std::string("'2262-04-11_23:47:16.854775807 GMT'"), "'"+omega.toString()+"'" );
#endif
    // Test comparison operators too
    CPPUNIT_ASSERT_MESSAGE( "ts0a < ts1a", ts0a < ts1a );
    CPPUNIT_ASSERT_MESSAGE( "ts0a <= ts1a", ts0a <= ts1a );
    CPPUNIT_ASSERT_MESSAGE( "ts1a > ts0a", ts1a > ts0a );
    CPPUNIT_ASSERT_MESSAGE( "ts1a >= ts0a", ts1a >= ts0a );
    CPPUNIT_ASSERT_MESSAGE( "ts0a !< ts0a", ! (ts0a < ts0a) );
    CPPUNIT_ASSERT_MESSAGE( "ts0a <= ts0a", ts0a <= ts0a );
    CPPUNIT_ASSERT_MESSAGE( "ts0a !> ts0a", ! (ts0a > ts0a) );
    CPPUNIT_ASSERT_MESSAGE( "ts0a >= ts0a", ts0a >= ts0a );
    CPPUNIT_ASSERT_MESSAGE( "omega > alpha", omega > alpha );
#if ((ULONG_MAX) == (UINT_MAX))
    // Test borderline cases
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 1901, 12, 13, 20, 45, 51, 999999999 ), coral::Exception );
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 2038, 1, 19, 3, 14, 8, 0 ), coral::Exception );
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( nsAlpha-1LL ), coral::Exception );
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( nsOmega+1LL ), coral::Exception );
#else
    // Test borderline cases
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 1677, 9, 21, 0, 12, 43, 145224191 ), coral::Exception );
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 2262, 04, 11, 23, 47, 16, 854775808 ), coral::Exception );
#endif
#endif
  }

  // ------------------------------------------------------

  void
  test_invalidInput()
  {
    // Test valid arguments
    coral::TimeStamp::ValueType ns0( 0 );
    coral::TimeStamp ts0a( ns0 );
    coral::TimeStamp ts0b( 1970, 1, 1, 0, 0, 0, 0 );
    CPPUNIT_ASSERT_MESSAGE( "ts0a == ts0b", ts0a == ts0b );
#ifdef CORAL300CPP11
    // Test arguments outside ranges
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 1676, 1, 1, 0, 0, 0, 0 ), coral::Exception );
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 2263, 1, 1, 0, 0, 0, 0 ), coral::Exception );
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 1970, 0, 1, 0, 0, 0, 0 ), coral::Exception );
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 1970, 13, 1, 0, 0, 0, 0 ), coral::Exception );
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 1970, 1, 0, 0, 0, 0, 0 ), coral::Exception );
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 1970, 1, 32, 0, 0, 0, 0 ), coral::Exception );
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 1970, 1, 1, -1, 0, 0, 0 ), coral::Exception );
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 1970, 1, 1, 24, 0, 0, 0 ), coral::Exception );
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 1970, 1, 1, 0, -1, 0, 0 ), coral::Exception );
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 1970, 1, 1, 0, 60, 0, 0 ), coral::Exception );
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 1970, 1, 1, 0, 0, -1, 0 ), coral::Exception );
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 1970, 1, 1, 0, 0, 60, 0 ), coral::Exception );
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 1970, 1, 1, 0, 0, 0, -1 ), coral::Exception );
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 1970, 1, 1, 0, 0, 0, 1000000000 ), coral::Exception );
    // Test months with less than 30 days
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 2014, 4, 31, 0, 0, 0, 0 ), coral::Exception );
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 2014, 6, 31, 0, 0, 0, 0 ), coral::Exception );
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 2014, 9, 31, 0, 0, 0, 0 ), coral::Exception );
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 2014, 11, 31, 0, 0, 0, 0 ), coral::Exception );
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 2014, 2, 29, 0, 0, 0, 0 ), coral::Exception );
    coral::TimeStamp leap( 2012, 2, 29, 0, 0, 0, 0 );
    std::cout << std::endl;
    std::cout << "Testing leap year: " << leap << std::endl;
    // Test borderline cases
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 1677, 9, 21, 0, 12, 43, 145224191 ), coral::Exception );
    CPPUNIT_ASSERT_THROW( coral::TimeStamp( 2262, 04, 11, 23, 47, 16, 854775808 ), coral::Exception );
#endif
  }

  // ------------------------------------------------------

};

CPPUNIT_TEST_SUITE_REGISTRATION( coral::TimeStampTest );

CORALCPPUNITTEST_MAIN( TimeStampTest )
