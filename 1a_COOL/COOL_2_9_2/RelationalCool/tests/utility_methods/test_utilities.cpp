// $Id: test_utilities.cpp,v 1.25 2013-03-08 10:53:25 avalassi Exp $

// Include files
#include <cstring> // for memset
#include <iostream>
#include "CoolKernel/ChannelSelection.h"
#include "CoolKernel/../src/SealTime.h"

// Local include files
//#define COOLUNITTESTTIMER 1
#include "CoolKernel/../tests/Common/CoolUnitTest.h"
#include "src/timeToString.h"

// Needed for _tzset, gmtime and timegm on Windows
#ifdef WIN32
#include <time.h>
inline static time_t timegm (struct tm *t)
{
  // This code is copied as-is from SEAL Time.cpp
  time_t t1 = mktime (t);
  struct tm gmt = *gmtime (&t1);
  time_t t2 = mktime (&gmt);
  return t1 + (t1 - t2);
}
#endif

// Forward declaration (for easier indentation)
namespace cool
{
  class utility_methodsTest;
}

// The test class
class cool::utility_methodsTest : public cool::CoolUnitTest
{

private:

  CPPUNIT_TEST_SUITE( utility_methodsTest );

  CPPUNIT_TEST( test_stringToTime );
  CPPUNIT_TEST( test_timeToString );

  // The second test in this pair is kept only for reference: I thought that
  // (not) calling tzset/_tzset would influence the result, but it does not!
  CPPUNIT_TEST( test_sealTimeFromDate );
  CPPUNIT_TEST( test_sealTimeFromDate_tzset );

  CPPUNIT_TEST( test_timegm_gmtime );
  CPPUNIT_TEST( test_gmtime_timegm );

  CPPUNIT_TEST_SUITE_END();

public:

  /// Tests that timegm( gmtime ( time_t ) ) = ( time_t )
  /// NB: tm_years are # years after 1900
  /// NB: time_t measures seconds after 1970-1-1
  /// On Windows use private implementation of timegm (see SEAL Time.cpp)
  void test_timegm_gmtime() {
    time_t aTimet = (31+2)*86400+12*3600+62; // 2894462 (1970-2-3 12:01:02)
    struct tm aTm = *gmtime( &aTimet );
    time_t aTimetNew = timegm( &aTm );
    bool verbose = false;
    if ( verbose ) {
      std::cout << "Test test_timegm_gmtime" << std::endl;
      std::cout << "aTimet = " << aTimet << std::endl;
      std::cout
        << "aTm = "
        << 1900+aTm.tm_year << "-" << aTm.tm_mon+1 << "-" << aTm.tm_mday
        << " " << aTm.tm_hour << ":" << aTm.tm_min << ":" << aTm.tm_sec
        << " (DST=" << aTm.tm_isdst << ")" << std::endl;
      std::cout << "aTimetNew = " << aTimetNew << std::endl;
    }
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "timegm(gmtime(time_t))==time_t", aTimet, aTimetNew );
  }

  /// Tests that gmtime( gmtime ( tm ) ) = ( tm )
  /// On Windows use private implementation of timegm (see SEAL Time.cpp)
  void test_gmtime_timegm() {
    bool verbose = false;
    struct tm aTm;
    int month; // Months in [0-11]
    for ( month = 0; month < 12; month++ ) {
      int year = 70; // Years after 1900
      int day = 03;
      int hour = 12;
      int minute = 01;
      int second = 02;
      // It seems that the +1 case should fail, but I fail with -1... why???!
      //memset (&aTm, sizeof(aTm), 0); // As in SEAL Time.cpp
      memset (&aTm, 0, sizeof(aTm)); // Fix Coverity NO_EFFECT (real bug!)
      aTm.tm_year = year;
      aTm.tm_mon = month;
      aTm.tm_mday = day;
      aTm.tm_hour = hour;
      aTm.tm_min = minute;
      aTm.tm_sec = second;
      if ( verbose ) {
        std::cout << "Test test_gmtime_timegm" << std::endl;
        std::cout
          << "Before setting isdst:  aTm = "
          << 1900+aTm.tm_year << "-" << aTm.tm_mon+1 << "-" << aTm.tm_mday
          << " " << aTm.tm_hour << ":" << aTm.tm_min << ":" << aTm.tm_sec
          << std::endl;
      }
      // Test with tm_idst = -1
      aTm.tm_isdst = -1;
      if ( verbose )
        std::cout
          << "Before calling timegm: aTm = "
          << 1900+aTm.tm_year << "-" << aTm.tm_mon+1 << "-" << aTm.tm_mday
          << " " << aTm.tm_hour << ":" << aTm.tm_min << ":" << aTm.tm_sec
          << " (DST=" << aTm.tm_isdst << ")" << std::endl;
      time_t aTimetM1 = timegm( &aTm );
      if ( verbose )
        std::cout
          << "After  calling timegm: aTm = "
          << 1900+aTm.tm_year << "-" << aTm.tm_mon+1 << "-" << aTm.tm_mday
          << " " << aTm.tm_hour << ":" << aTm.tm_min << ":" << aTm.tm_sec
          << " (DST=" << aTm.tm_isdst << ")" << std::endl;
      struct tm aTmM1;
      aTmM1 = *gmtime( &aTimetM1 );
      // Test with tm_idst = 0
      aTm.tm_year = year;
      aTm.tm_mon = month;
      aTm.tm_mday = day;
      aTm.tm_hour = hour;
      aTm.tm_min = minute;
      aTm.tm_sec = second;
      aTm.tm_isdst = 0;
      if ( verbose )
        std::cout
          << "Before calling timegm: aTm = "
          << 1900+aTm.tm_year << "-" << aTm.tm_mon+1 << "-" << aTm.tm_mday
          << " " << aTm.tm_hour << ":" << aTm.tm_min << ":" << aTm.tm_sec
          << " (DST=" << aTm.tm_isdst << ")" << std::endl;
      time_t aTimet0 = timegm( &aTm );
      if ( verbose )
        std::cout
          << "After  calling timegm: aTm = "
          << 1900+aTm.tm_year << "-" << aTm.tm_mon+1 << "-" << aTm.tm_mday
          << " " << aTm.tm_hour << ":" << aTm.tm_min << ":" << aTm.tm_sec
          << " (DST=" << aTm.tm_isdst << ")" << std::endl;
      struct tm aTm0;
      aTm0 = *gmtime( &aTimet0 );
      // Test with tm_idst = +1
      aTm.tm_year = year;
      aTm.tm_mon = month;
      aTm.tm_mday = day;
      aTm.tm_hour = hour;
      aTm.tm_min = minute;
      aTm.tm_sec = second;
      aTm.tm_isdst = +1;
      if ( verbose )
        std::cout
          << "Before calling timegm: aTm = "
          << 1900+aTm.tm_year << "-" << aTm.tm_mon+1 << "-" << aTm.tm_mday
          << " " << aTm.tm_hour << ":" << aTm.tm_min << ":" << aTm.tm_sec
          << " (DST=" << aTm.tm_isdst << ")" << std::endl;
      time_t aTimetP1 = timegm( &aTm );
      if ( verbose )
        std::cout
          << "After  calling timegm: aTm = "
          << 1900+aTm.tm_year << "-" << aTm.tm_mon+1 << "-" << aTm.tm_mday
          << " " << aTm.tm_hour << ":" << aTm.tm_min << ":" << aTm.tm_sec
          << " (DST=" << aTm.tm_isdst << ")" << std::endl;
      struct tm aTmP1;
      aTmP1 = *gmtime( &aTimetP1 );
      // Verbose printout
      if ( verbose ) {
        std::cout
          << "aTm = "
          << 1900+year << "-" << month+1 << "-" << day
          << " " << hour << ":" << minute << ":" << second
          << " (DST=-1,0,+1)" << std::endl;
        std::cout << "aTimetM1 = " << aTimetM1 << std::endl;
        std::cout
          << "aTmM1 = "
          << 1900+aTmM1.tm_year << "-" << aTmM1.tm_mon+1
          << "-" <<aTmM1.tm_mday
          << " " << aTmM1.tm_hour << ":" << aTmM1.tm_min
          << ":" << aTmM1.tm_sec
          << " (DST=" << aTmM1.tm_isdst << ")" << std::endl;
        std::cout << "aTimet0 = " << aTimet0 << std::endl;
        std::cout
          << "aTm0 = "
          << 1900+aTm0.tm_year << "-" << aTm0.tm_mon+1
          << "-" << aTm0.tm_mday
          << " " << aTm0.tm_hour << ":" << aTm0.tm_min
          << ":" << aTm0.tm_sec
          << " (DST=" << aTm0.tm_isdst << ")" << std::endl;
        std::cout << "aTimetP1 = " << aTimetP1 << std::endl;
        std::cout
          << "aTmP1 = "
          << 1900+aTmP1.tm_year << "-" << aTmP1.tm_mon+1
          << "-" <<aTmP1.tm_mday
          << " " << aTmP1.tm_hour << ":" << aTmP1.tm_min
          << ":" << aTmP1.tm_sec
          << " (DST=" << aTmP1.tm_isdst << ")" << std::endl;
      }
      // Actual tests
      // Do NOT test isdst: gmtime ALWAYS returns isdst=0!
      std::stringstream msg;
      msg << " (Month[0-11]=" << month << ")";
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( std::string("gmtime(timegm(tm,isDst=0))==tm : hour")+msg.str(),
          hour, aTm0.tm_hour );
#ifndef WIN32
      // The following tests FAIL on Windows!!!
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( std::string("gmtime(timegm(tm,isDst=-1))==tm : hour")+msg.str(),
          hour, aTmM1.tm_hour );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( std::string("gmtime(timegm(tm,isDst=+1))==tm : hour")+msg.str(),
          hour, aTmP1.tm_hour );
#endif
    }
  }


  /// Tests seal::Time constructor from y,mo,d,h,mi,s,ns,local
  /// The test fails on Windows only for months from April onwards
  void test_sealTimeFromDate() {
    bool local = false; // Use UTC-GMT times
    int month; // Months in [0-11]
    for ( month = 0; month < 12; month++ ) {
      int year = 1970; // Years after 1900
      int day = 03;
      int hour = 12;
      int minute = 01;
      int second = 02;
      long nsecond = 123456789;
      // AV 28.06.2005 Test for the BUG in seal::Time constructor...
      // AV 18.01.2007 cool::SealTime uses months in [1-12]!!!
      SealTime cTime( year, month+1, day, hour, minute, second, nsecond );
      seal::Time sTime = cTime.sealTime();
      time_t s1970 = (31+2)*86400+12*3600+62; // 2894462 (1970-2-3 12:01:02)
      if ( month == 0 ) s1970 -= 31*86400;  // Remove January
      if ( month >= 2 ) s1970 += 28*86400;  // Add February (365 day year)
      if ( month >= 3 ) s1970 += 31*86400;  // Add March
      if ( month >= 4 ) s1970 += 30*86400;  // Add April
      if ( month >= 5 ) s1970 += 31*86400;  // Add May
      if ( month >= 6 ) s1970 += 30*86400;  // Add June
      if ( month >= 7 ) s1970 += 31*86400;  // Add July
      if ( month >= 8 ) s1970 += 31*86400;  // Add August
      if ( month >= 9 ) s1970 += 30*86400;  // Add September
      if ( month >= 10 ) s1970 += 31*86400;  // Add October
      if ( month >= 11 ) s1970 += 30*86400;  // Add November
      std::stringstream msg;
      msg << " (Month[0-11]=" << month << ")";
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( std::string("ns from 1900")+msg.str(),
          (seal::Time::ValueType)s1970*1000000000 + nsecond, sTime.ns() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( std::string("year")+msg.str(), year, sTime.year(local) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( std::string("month")+msg.str(), month, sTime.month(local) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( std::string("day")+msg.str(), day, sTime.day(local) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( std::string("hour")+msg.str(), hour, sTime.hour(local) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( std::string("minute")+msg.str(), minute, sTime.minute(local) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( std::string("second")+msg.str(), second, sTime.second(local) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( std::string("nsecond")+msg.str(), nsecond, sTime.nsecond() );
    }
  }


  /// Tests seal::Time constructor AFTER CALLING tzset()
  void test_sealTimeFromDate_tzset() {
#ifdef WIN32
    _tzset();
#else
    tzset();
#endif
    test_sealTimeFromDate();
  }


  /// Tests timeToString and stringToTime conversions
  void test_timeToString() {
    std::string aString1 = "2005-06-21_12:00:01.123456789 GMT";
    Time aTime1 = stringToTime( aString1 );
    std::string aString2 = timeToString( aTime1 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "string 2 == string 1", aString1, aString2 );
    Time aTime2 = stringToTime( aString2 );
    std::string aString3 = timeToString( aTime2 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "string 3 == string 2", aString2, aString3 );
  }


  /// tests stringToTime
  void test_stringToTime() {
    try {
      std::string s = "1970-02-03_12:01:02.123456789 GMT";
      SealTime cTime = stringToTime( s );
      seal::Time sTime = cTime.sealTime();
      bool local = false;
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( std::string("year"), 1970, sTime.year(local) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( std::string("month"), 2, sTime.month(local)+1 ); // month in [1-12]
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( std::string("day"), 3, sTime.day(local) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( std::string("hour"), 12, sTime.hour(local) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( std::string("minute"), 01, sTime.minute(local) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( std::string("second"), 02, sTime.second(local) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( std::string("nanoseconds"), (long)123456789, sTime.nsecond() );
    } catch ( std::exception& e ) {
      std::cout << e.what() << std::endl;
      throw;
    }

  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  // Constructor (executed N times, _before_ all N test executions)
  utility_methodsTest() : CoolUnitTest()
  {
  }

  // Destructor (executed N times, _after_ all N test executions)
  ~utility_methodsTest()
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

CPPUNIT_TEST_SUITE_REGISTRATION( cool::utility_methodsTest );

COOLTEST_MAIN( utility_methodsTest )
