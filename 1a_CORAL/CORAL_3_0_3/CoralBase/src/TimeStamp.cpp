// First of all, set/unset CORAL240, CORAL300 and CORAL_HAS_CPP11 macros
#include "CoralBase/VersionInfo.h"

// Include files
#ifdef CORAL300CPP11
#include <climits>
#include <cstdio>
#include <cstring>
#include <iostream>
#include "CoralBase/Exception.h"
#endif
#include <sstream>
#include "CoralBase/TimeStamp.h"

// Local include files
#ifndef CORAL300CPP11
#include "TimeStampEpoch.h"
#endif

#ifndef CORAL300CPP11
#ifdef CORAL240TS
// Move these from public API to private implementation (bug #103289)
namespace coral
{
  namespace time
  {
    // From BOOST: This local adjustor depends on the machine TZ settings-- highly dangerous!
    typedef boost::date_time::c_local_adjustor<boost::posix_time::ptime> local_adj;
    // In case it's missing in BOOST build - might fail to compile
    typedef boost::date_time::subsecond_duration<boost::posix_time::time_duration,1000000000LL> nanoseconds;
  }
}
#else
/// Remove this obsolete method from the CORAL240 API (bug #64016)
const boost::posix_time::ptime& coral::TimeStamp::Epoch = coral::getTimeStampEpoch();
#endif
#endif

#ifdef CORAL300CPP11
namespace coral
{
#if ((ULONG_MAX) == (UINT_MAX))
  // Beg of time for 32bit TimeStamp: 1901-12-13_20:45:52.000000000
  // End of time for 32bit TimeStamp: 2038-01-19_03:14:07.999999999
  const TimeStamp::ValueType nsAlpha( LONG_MIN * 1000000000LL ); // -2147483648000000000
  const TimeStamp::ValueType nsOmega( (-nsAlpha) - 1LL );        // +2147483647999999999
#else
  // Beg of time for 64bit TimeStamp: 1677-09-21_00:12:43.145224192
  // End of time for 64bit TimeStamp: 2262-04-11_23:47:16.854775807
  const TimeStamp::ValueType nsAlpha( LONG_LONG_MIN ); // -9223372036854775808
  const TimeStamp::ValueType nsOmega( LONG_LONG_MAX ); // +9223372036854775807
#endif
}
#endif

// Default constructor
#ifndef CORAL300CPP11
coral::TimeStamp::TimeStamp()
  : m_time( boost::posix_time::microsec_clock::universal_time() )
  , m_isLocal( false )
  , m_localTime( 0 )
{
}
#else
coral::TimeStamp::TimeStamp()
  : coral::TimeStamp( std::chrono::system_clock::now() )
{
}
#endif

#ifndef CORAL300CPP11
coral::TimeStamp::TimeStamp( int year, int month,  int day,
                             int hour, int minute, int second, long nanosecond,
                             bool isLocalTime /*=false*/ ) // default: UTC
  : m_time( boost::gregorian::date( year, month, day ),
            boost::posix_time::time_duration( hour, minute, second,
                                              ( boost::posix_time::time_duration::num_fractional_digits() == 6 ?
                                                nanosecond/1000 :
                                                nanosecond ) ) )
  , m_isLocal( isLocalTime )
  , m_localTime( 0 )
{
  if ( m_isLocal )
    m_localTime.reset( new boost::posix_time::ptime( coral::time::local_adj::utc_to_local( m_time ) ) );
}
#else
coral::TimeStamp::TimeStamp( int year, int month, int day,
                             int hour, int minute, int second, long nanosecond )
  : m_year( year )
  , m_mon( month )
  , m_day( day )
  , m_hour( hour )
  , m_min( minute )
  , m_sec( second )
  , m_nsec( nanosecond )
{
  const TimeStamp alpha( nsAlpha );
  const TimeStamp omega( nsOmega );
  // Check input parameter ranges
  if ( month < 1 || month > 12 ||
       day < 1 || day > 31 ||
       hour < 0 || hour > 23 ||
       minute < 0 || minute > 59 ||
       second < 0 || second > 59 ||
       nanosecond < 0 || nanosecond > 999999999 )
  {
    std::stringstream s;
    s << "Invalid arguments to TimeStamp("
      << year << "," << month << "," << day << ","
      << hour << "," << minute << "," << second << "," << nanosecond << ")";
    throw Exception( s.str(), "TimeStamp::TimeStamp", "coral::CoralBase" );
  }
  if ( year < alpha.year() || year > omega.year() )
  {
    std::stringstream s;
    s << "Invalid TimeStamp("
      << year << "," << month << "," << day << ","
      << hour << "," << minute << "," << second << "," << nanosecond
      << ") outside [" << alpha << "," << omega << "]";
    throw Exception( s.str(), "TimeStamp::TimeStamp", "coral::CoralBase" );
  }
  // Check borderline cases
  if ( ( year == alpha.year() && ( *this ) < alpha ) ||
       ( year == omega.year() && ( *this ) > omega ) )
  {
    std::stringstream s;
    s << "Invalid TimeStamp("
      << year << "," << month << "," << day << ","
      << hour << "," << minute << "," << second << "," << nanosecond
      << ") outside [" << alpha << "," << omega << "]";
    throw Exception( s.str(), "TimeStamp::TimeStamp", "coral::CoralBase" );
  }
  // Sanity check (needed for months with fewer days but always executed)
  TimeStamp ts( this->total_nanoseconds() );
  if ( *this != ts )
  {
    std::stringstream s;
    s << "Invalid TimeStamp("
      << year << "," << month << "," << day << ","
      << hour << "," << minute << "," << second << "," << nanosecond
      << ") representing " << ts;
    throw Exception( s.str(), "TimeStamp::TimeStamp", "coral::CoralBase" );
  }
}
#endif

#ifndef CORAL300CPP11
coral::TimeStamp::TimeStamp( const boost::posix_time::ptime& pT,
                             bool isLocalTime /*=false*/ ) // default: UTC
  : m_time( pT )
  , m_isLocal( isLocalTime )
  , m_localTime( 0 )
{
  if ( m_isLocal )
    m_localTime.reset( new boost::posix_time::ptime( coral::time::local_adj::utc_to_local( m_time ) ) );
}
#endif

#ifndef CORAL300CPP11
coral::TimeStamp::TimeStamp( coral::TimeStamp::ValueType& nsecs )
  : m_time()
  , m_isLocal( false ) // default: UTC
  , m_localTime( 0 )
{
  // This constructs the timestamp assuming UTC
  coral::TimeStamp::ValueType lSecs  = nsecs/1000000000LL; // extract seconds part
  coral::TimeStamp::ValueType lNsecs = nsecs%1000000000LL; // extract ns part
  // Little precision check
  long int precision = boost::posix_time::time_duration::num_fractional_digits();
  boost::posix_time::time_duration since_epoch;
  if ( precision > 6 )
    since_epoch = boost::posix_time::seconds( (long)lSecs ) + coral::time::nanoseconds( lNsecs );
  else
    since_epoch = boost::posix_time::seconds( (long)lSecs ) + boost::posix_time::microseconds( lNsecs/1000 );
  boost::posix_time::ptime time_since_epoch( boost::gregorian::date( 1970, 1, 1 ), since_epoch );
  m_time = time_since_epoch;
}
#else
coral::TimeStamp::TimeStamp( coral::TimeStamp::ValueType nsFromEpoch )
{
  // Use gmtime to convert nsFromEpoch into YYYY-MM-DD:hh:mm:ss.nnnnnnnnn
  ValueType secFromEpochLL = nsFromEpoch / 1000000000LL;
  m_nsec = nsFromEpoch % 1000000000LL;
  if ( nsFromEpoch < 0 && m_nsec != 0 )
  {
    secFromEpochLL -= 1;
    m_nsec += 1000000000LL;
  }
#if ((ULONG_MAX) == (UINT_MAX))
  // Restrict the range to 1901-2038 (fix CORALCOOL-2749 aka Y2038 bug...)
  if ( secFromEpochLL < LONG_MIN || secFromEpochLL > LONG_MAX )
  {
    std::stringstream s;
    s << "Invalid TimeStamp(" << nsFromEpoch
      << ") outside [" << nsAlpha << "," << nsOmega << "]";
    throw Exception( s.str(), "TimeStamp::TimeStamp", "coral::CoralBase" );
  }
#endif
  std::time_t secFromEpoch = secFromEpochLL; // this was causing CORALCOOL-2749
  struct std::tm t;
  ::gmtime_r( &secFromEpoch, &t );
  m_year = t.tm_year + 1900;
  m_mon  = t.tm_mon + 1;
  m_day  = t.tm_mday;
  m_hour = t.tm_hour;
  m_min  = t.tm_min;
  m_sec  = t.tm_sec;
}
#endif

#ifndef CORAL300CPP11
coral::TimeStamp::ValueType coral::TimeStamp::total_nanoseconds() const
{
  // This is always returned in UTC, keeps the former SEAL semantics
  coral::TimeStamp::ValueType nsecs = 0L;
  boost::posix_time::time_duration since_epoch = m_time - coral::getTimeStampEpoch(); // was using Epoch (bug #64016)
  nsecs = since_epoch.total_nanoseconds();
  return nsecs;
}
#else
coral::TimeStamp::ValueType coral::TimeStamp::total_nanoseconds() const
{
  // Use "timegm" to convert YYYY-MM-DD:hh:mm:ss.nnnnnnnnn into nsFromEpoch
  struct std::tm t = { m_sec, m_min, m_hour, m_day, m_mon-1, m_year-1900, 0, 0, -1, 0, NULL };
  std::time_t secFromEpoch = ::timegm(&t);
  return secFromEpoch*1000000000LL + m_nsec;
}
#endif

#ifndef CORAL300CPP11
coral::TimeStamp coral::TimeStamp::now( bool isLocalTime /*=false*/ )
{
  boost::posix_time::ptime timeNow;
  /*
  // BUG IN LOCAL TIME HANDLING (bug #104617) - DOUBLE UTC/LOCAL ADJUST!
  if ( isLocalTime ) timeNow = boost::posix_time::microsec_clock::local_time();
  else timeNow = boost::posix_time::microsec_clock::universal_time();
  */
  timeNow = boost::posix_time::microsec_clock::universal_time();
  return coral::TimeStamp( timeNow, isLocalTime );
}
#else
coral::TimeStamp coral::TimeStamp::now()
{
  return coral::TimeStamp();
}
#endif

std::string coral::TimeStamp::toString() const
{
  std::stringstream ss;
#ifndef CORAL300CPP11
  ss << day()  << "/" << month()  << "/" << year()   << " "
     << hour() << ":" << minute() << ":" << second() << "." << nanosecond();
#else
  this->print( ss );
#endif
  return ss.str();
}

#ifndef CORAL300CPP11
coral::TimeStamp::TimeStamp( const boost::posix_time::ptime& pT )
  : m_time( pT )
  , m_isLocal( false ) // default: UTC
{
}
#else
coral::TimeStamp::TimeStamp( const std::chrono::system_clock::time_point& tp )
  : TimeStamp( (std::chrono::duration_cast<std::chrono::nanoseconds>( tp.time_since_epoch() ) ).count() )
{
}
#endif

coral::TimeStamp::~TimeStamp()
{
}

#ifndef CORAL300CPP11
coral::TimeStamp::TimeStamp( const coral::TimeStamp& rhs )
  : m_time( rhs.m_time )
  , m_isLocal( rhs.m_isLocal )
  , m_localTime( 0 )
{
  if ( m_isLocal )
    m_localTime.reset( new boost::posix_time::ptime( coral::time::local_adj::utc_to_local( m_time ) ) );
}
#else
coral::TimeStamp::TimeStamp( const coral::TimeStamp& rhs )
  : m_year( rhs.m_year )
  , m_mon( rhs.m_mon )
  , m_day( rhs.m_day )
  , m_hour( rhs.m_hour )
  , m_min( rhs.m_min )
  , m_sec( rhs.m_sec )
  , m_nsec( rhs.m_nsec )
{
}
#endif

#ifndef CORAL300CPP11
coral::TimeStamp&
coral::TimeStamp::operator=( const coral::TimeStamp& rhs )
{
  if ( this != &rhs )
  {
    m_time = rhs.m_time;
    m_isLocal = rhs.m_isLocal;
    if ( m_isLocal )
      m_localTime.reset( new boost::posix_time::ptime( coral::time::local_adj::utc_to_local( m_time ) ) );
  }
  return *this;
}
#else
coral::TimeStamp&
coral::TimeStamp::operator=( const coral::TimeStamp& rhs )
{
  if( this != &rhs )
  {
    m_year = rhs.m_year;
    m_mon = rhs.m_mon;
    m_day = rhs.m_day;
    m_hour = rhs.m_hour;
    m_min = rhs.m_min;
    m_sec = rhs.m_sec;
    m_nsec = rhs.m_nsec;
  }
  return *this;
}
#endif

#ifndef CORAL300CPP11
int
coral::TimeStamp::year() const
{
  return ( ( m_isLocal && m_localTime.get() != 0 ) ?
           m_localTime->date().year() :
           m_time.date().year() );
}
#else
int
coral::TimeStamp::year() const
{
  return m_year;
}
#endif

#ifndef CORAL300CPP11
int
coral::TimeStamp::month() const
{
  return ( ( m_isLocal && m_localTime.get() != 0 ) ?
           m_localTime->date().month() :
           m_time.date().month() );
}
#else
int
coral::TimeStamp::month() const
{
  return m_mon;
}
#endif

#ifndef CORAL300CPP11
int
coral::TimeStamp::day() const
{
  return ( ( m_isLocal && m_localTime.get() != 0 ) ?
           m_localTime->date().day() :
           m_time.date().day() );
}
#else
int
coral::TimeStamp::day() const
{
  return m_day;
}
#endif

#ifndef CORAL300CPP11
int
coral::TimeStamp::hour() const
{
  return ( ( m_isLocal && m_localTime.get() != 0 ) ?
           m_localTime->time_of_day().hours() :
           m_time.time_of_day().hours() );
}
#else
int
coral::TimeStamp::hour() const
{
  return m_hour;
}
#endif

#ifndef CORAL300CPP11
int
coral::TimeStamp::minute() const
{
  return ( ( m_isLocal && m_localTime.get() != 0 ) ?
           m_localTime->time_of_day().minutes() :
           m_time.time_of_day().minutes() );
}
#else
int
coral::TimeStamp::minute() const
{
  return m_min;
}
#endif

#ifndef CORAL300CPP11
int
coral::TimeStamp::second() const
{
  return ( ( m_isLocal && m_localTime.get() != 0 ) ?
           m_localTime->time_of_day().seconds() :
           m_time.time_of_day().seconds() );
}
#else
int
coral::TimeStamp::second() const
{
  return m_sec;
}
#endif

#ifndef CORAL300CPP11
long
coral::TimeStamp::nanosecond() const
{
  // System independent (from BOOST docs):
  // ==> count*(time_duration_ticks_per_second / count_ticks_per_second)
  long ns = (long)( ( m_isLocal && m_localTime.get() != 0 ) ?
                    m_localTime->time_of_day().fractional_seconds() :
                    m_time.time_of_day().fractional_seconds() );
  return ( boost::posix_time::time_duration::num_fractional_digits() == 6 ? ns*1000 : ns );
}
#else
long
coral::TimeStamp::nanosecond() const
{
  return m_nsec;
}
#endif

#ifndef CORAL300CPP11
const boost::posix_time::ptime&
coral::TimeStamp::time() const
{
  return ( ( m_isLocal && m_localTime.get() != 0 ) ?
           *m_localTime :
           m_time );
}
#else
std::chrono::system_clock::time_point
coral::TimeStamp::time() const
{
  std::chrono::nanoseconds nsFromEpoch( this->total_nanoseconds() );
  return std::chrono::system_clock::time_point( std::chrono::duration_cast<std::chrono::system_clock::duration>( nsFromEpoch ) );
}
#endif

#ifndef CORAL300CPP11
bool
coral::TimeStamp::operator==( const coral::TimeStamp& rhs ) const
{
  return ( this->m_time == rhs.m_time );
}
#else
bool
coral::TimeStamp::operator==( const coral::TimeStamp& rhs ) const
{
  return ( ( m_year == rhs.m_year ) &&
           ( m_mon == rhs.m_mon ) &&
           ( m_day == rhs.m_day ) &&
           ( m_hour == rhs.m_hour ) &&
           ( m_min == rhs.m_min ) &&
           ( m_sec == rhs.m_sec ) &&
           ( m_nsec == rhs.m_nsec ) );
}
#endif

bool
coral::TimeStamp::operator!=( const coral::TimeStamp& rhs ) const
{
  return !( *this == rhs );
}


#ifdef CORAL300CPP11
// Implementation as in cool::Time
bool
coral::TimeStamp::operator>( const coral::TimeStamp& rhs ) const
{
  if ( m_year > rhs.m_year ) return true;
  if ( m_year < rhs.m_year ) return false;
  if ( m_mon > rhs.m_mon ) return true;
  if ( m_mon < rhs.m_mon ) return false;
  if ( m_day > rhs.m_day ) return true;
  if ( m_day < rhs.m_day ) return false;
  if ( m_hour > rhs.m_hour ) return true;
  if ( m_hour < rhs.m_hour ) return false;
  if ( m_min > rhs.m_min ) return true;
  if ( m_min < rhs.m_min ) return false;
  if ( m_sec > rhs.m_sec ) return true;
  if ( m_sec < rhs.m_sec ) return false;
  if ( m_nsec > rhs.m_nsec ) return true;
  else return false; // m_nsec <= rhs.m_nsec
}

// Implementation as in cool::ITime
bool
coral::TimeStamp::operator>=( const coral::TimeStamp& rhs ) const
{
  return ( (*this) > rhs || (*this) == rhs );
}

// Implementation as in cool::ITime
bool
coral::TimeStamp::operator<( const coral::TimeStamp& rhs ) const
{
  return !( (*this) >= rhs );
}

// Implementation as in cool::ITime
bool
coral::TimeStamp::operator<=( const coral::TimeStamp& rhs ) const
{
  return !( (*this) > rhs );
}

// Implementation as in cool::Time
std::ostream&
coral::TimeStamp::print( std::ostream& os ) const
{
  int year = this->year();
  int month = this->month(); // Months are in [1-12]
  int day = this->day();
  int hour = this->hour();
  int min = this->minute();
  int sec = this->second();
  long nsec = this->nanosecond();
  char timeChar[] = "yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT";
  int nChar = ::strlen(timeChar);
  if ( ::snprintf( timeChar, nChar+1, // Fix Coverity SECURE_CODING
                   "%4.4d-%2.2d-%2.2d_%2.2d:%2.2d:%2.2d.%9.9ld GMT",
                   year, month, day, hour, min, sec, nsec) == nChar )
  {
    return os << std::string( timeChar );
  }
  // No path to this statement, normally...
  std::stringstream s;
  s << "coral::TimeStamp(" << year << "," << month << "," << day << ","
    << hour << "," << min << "," << sec << "," << nsec << ")";
  std::cout << "[***CORAL INTERNAL ERROR in " << s.str()
            << ": please report!***]" << std::endl; // gentler than an exception
  return os << s.str();
}
#endif
