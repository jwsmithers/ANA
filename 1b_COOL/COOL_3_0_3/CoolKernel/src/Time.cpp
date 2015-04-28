// First of all, set/unset CORAL290, COOL300, COOL400 and COOL_HAS_CPP11 macros
#include "CoolKernel/VersionInfo.h"

// Include files
#include <cstdio> // For sprintf on gcc45
#include "CoralBase/TimeStamp.h"
#include "CoolKernel/Exception.h"
#include "CoolKernel/Time.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

Time::~Time()
{
}

//-----------------------------------------------------------------------------

#ifndef COOL300TS
Time::Time()
{
  coral::TimeStamp now;
  m_year = now.year();
  m_month = now.month();
  m_day = now.day();
  m_hour = now.hour();
  m_minute = now.minute();
  m_second = now.second();
  m_nanosecond = now.nanosecond();
}
#else
Time::Time()
  : m_ts() // coral::TimeStamp() returns the current UTC time
{
}
#endif

//-----------------------------------------------------------------------------

Time::Time( int year,
            int month,
            int day,
            int hour,
            int minute,
            int second,
            long nanosecond ) :
#ifndef COOL300TS
  m_year( year )
  , m_month( month )
  , m_day( day )
  , m_hour( hour )
  , m_minute( minute )
  , m_second( second )
  , m_nanosecond( nanosecond )
#else
  m_ts( year, month, day, hour, minute, second, nanosecond )
#endif
{
}

//-----------------------------------------------------------------------------

Time::Time( const Time& rhs ) :
  ITime( rhs ),
#ifndef COOL300TS
  m_year( rhs.year() )
  , m_month( rhs.month() )
  , m_day( rhs.day() )
  , m_hour( rhs.hour() )
  , m_minute( rhs.minute() )
  , m_second( rhs.second() )
  , m_nanosecond( rhs.nanosecond() )
#else
  m_ts( rhs.m_ts )
#endif
{
}

//-----------------------------------------------------------------------------

Time& Time::operator=( const Time& rhs )
{
  if ( this == &rhs ) return *this;  // Fix Coverity SELF_ASSIGN
#ifndef COOL300TS
  m_year = rhs.year();
  m_month = rhs.month();
  m_day = rhs.day();
  m_hour = rhs.hour();
  m_minute = rhs.minute();
  m_second = rhs.second();
  m_nanosecond = rhs.nanosecond();
#else
  m_ts = rhs.m_ts;
#endif
  return (*this);
}

//-----------------------------------------------------------------------------

Time::Time( const ITime& rhs ) :
#ifndef COOL300TS
  m_year( rhs.year() )
  , m_month( rhs.month() )
  , m_day( rhs.day() )
  , m_hour( rhs.hour() )
  , m_minute( rhs.minute() )
  , m_second( rhs.second() )
  , m_nanosecond( rhs.nanosecond() )
#else
  m_ts( rhs.year(), rhs.month(), rhs.day(), rhs.hour(), rhs.minute(), rhs.second(), rhs.nanosecond() )
#endif
{
}

//-----------------------------------------------------------------------------

Time& Time::operator=( const ITime& rhs )
{
#ifndef COOL300TS
  m_year = rhs.year();
  m_month = rhs.month();
  m_day = rhs.day();
  m_hour = rhs.hour();
  m_minute = rhs.minute();
  m_second = rhs.second();
  m_nanosecond = rhs.nanosecond();
#else
  m_ts = coral::TimeStamp( rhs.year(), rhs.month(), rhs.day(), rhs.hour(), rhs.minute(), rhs.second(), rhs.nanosecond() );
#endif
  return (*this);
}

//-----------------------------------------------------------------------------

#ifdef COOL300TS
Time::Time( const coral::TimeStamp& rhs )
  : m_ts( rhs )
{
}
#endif

//-----------------------------------------------------------------------------

#ifdef COOL300TS
Time& Time::operator=( const coral::TimeStamp& rhs )
{
  m_ts = rhs;
  return (*this);
}
#endif

//-----------------------------------------------------------------------------

std::ostream& Time::print( std::ostream& os ) const
{
  int year = this->year();
  int month = this->month(); // Months are in [1-12]
  int day = this->day();
  int hour = this->hour();
  int min = this->minute();
  int sec = this->second();
  long nsec = this->nanosecond();
  char timeChar[] = "yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT";
  int nChar = std::string(timeChar).size();
  if ( snprintf( timeChar, 30, // Fix Coverity SECURE_CODING
                 "%4.4d-%2.2d-%2.2d_%2.2d:%2.2d:%2.2d.%9.9ld GMT",
                 year, month, day, hour, min, sec, nsec) == nChar ) {
    return os << std::string( timeChar );
  }
  std::stringstream s;
  s << "PANIC! Error printing out "
    << year << "-" << month << "-" << day << "_"
    << hour << ":" << min << ":" << sec << "." << nsec;
  throw Exception( s.str(), "Time" );
}

//-----------------------------------------------------------------------------

bool Time::operator==( const ITime& rhs ) const
{
#ifndef COOL300TS
  if ( m_year != rhs.year() ) return false;
  if ( m_month != rhs.month() ) return false;
  if ( m_day != rhs.day() ) return false;
  if ( m_hour != rhs.hour() ) return false;
  if ( m_minute != rhs.minute() ) return false;
  if ( m_second != rhs.second() ) return false;
  if ( m_nanosecond != rhs.nanosecond() ) return false;
  return true;
#else
  return ( m_ts == cool::Time( rhs ).coralTimeStamp() );
#endif
}

//-----------------------------------------------------------------------------

bool Time::operator>( const ITime& rhs ) const
{
#ifndef COOL300TS
  if ( m_year > rhs.year() ) return true;
  if ( m_year < rhs.year() ) return false;
  if ( m_month > rhs.month() ) return true;
  if ( m_month < rhs.month() ) return false;
  if ( m_day > rhs.day() ) return true;
  if ( m_day < rhs.day() ) return false;
  if ( m_hour > rhs.hour() ) return true;
  if ( m_hour < rhs.hour() ) return false;
  if ( m_minute > rhs.minute() ) return true;
  if ( m_minute < rhs.minute() ) return false;
  if ( m_second > rhs.second() ) return true;
  if ( m_second < rhs.second() ) return false;
  if ( m_nanosecond > rhs.nanosecond() ) return true;
  if ( m_nanosecond < rhs.nanosecond() ) return false;
  if ( (*this) == rhs ) return false;
  std::stringstream s;
  s << "PANIC! Could not determine if " << *this << " > " << rhs;
  throw Exception( s.str(), "Time" );
#else
  return ( m_ts > cool::Time( rhs ).coralTimeStamp() );
#endif
}

//-----------------------------------------------------------------------------
