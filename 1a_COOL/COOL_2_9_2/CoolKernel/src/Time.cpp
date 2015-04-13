// $Id: Time.cpp,v 1.19 2012-06-29 12:47:41 avalassi Exp $

// Include files
#include <cstdio> // For sprintf on gcc45
#include "CoolKernel/Exception.h"
#include "CoolKernel/Time.h"

// Local include files
#include "SealTime.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

Time::~Time()
{
}

//-----------------------------------------------------------------------------

Time::Time()
{
  SealTime now;
  m_year = now.year();
  m_month = now.month();
  m_day = now.day();
  m_hour = now.hour();
  m_minute = now.minute();
  m_second = now.second();
  m_nanosecond = now.nanosecond();
}

//-----------------------------------------------------------------------------

Time::Time( int year,
            int month,
            int day,
            int hour,
            int minute,
            int second,
            long nanosecond )
  : m_year( year )
  , m_month( month )
  , m_day( day )
  , m_hour( hour )
  , m_minute( minute )
  , m_second( second )
  , m_nanosecond( nanosecond )
{
}

//-----------------------------------------------------------------------------

Time::Time( const Time& rhs )
  : ITime( rhs )
  , m_year( rhs.year() )
  , m_month( rhs.month() )
  , m_day( rhs.day() )
  , m_hour( rhs.hour() )
  , m_minute( rhs.minute() )
  , m_second( rhs.second() )
  , m_nanosecond( rhs.nanosecond() )
{
}

//-----------------------------------------------------------------------------

Time& Time::operator=( const Time& rhs )
{
  if ( this == &rhs ) return *this;  // Fix Coverity SELF_ASSIGN
  m_year = rhs.year();
  m_month = rhs.month();
  m_day = rhs.day();
  m_hour = rhs.hour();
  m_minute = rhs.minute();
  m_second = rhs.second();
  m_nanosecond = rhs.nanosecond();
  return (*this);
}

//-----------------------------------------------------------------------------

Time::Time( const ITime& rhs )
  : m_year( rhs.year() )
  , m_month( rhs.month() )
  , m_day( rhs.day() )
  , m_hour( rhs.hour() )
  , m_minute( rhs.minute() )
  , m_second( rhs.second() )
  , m_nanosecond( rhs.nanosecond() )
{
}

//-----------------------------------------------------------------------------

Time& Time::operator=( const ITime& rhs )
{
  m_year = rhs.year();
  m_month = rhs.month();
  m_day = rhs.day();
  m_hour = rhs.hour();
  m_minute = rhs.minute();
  m_second = rhs.second();
  m_nanosecond = rhs.nanosecond();
  return (*this);
}

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
  if ( m_year != rhs.year() ) return false;
  if ( m_month != rhs.month() ) return false;
  if ( m_day != rhs.day() ) return false;
  if ( m_hour != rhs.hour() ) return false;
  if ( m_minute != rhs.minute() ) return false;
  if ( m_second != rhs.second() ) return false;
  if ( m_nanosecond != rhs.nanosecond() ) return false;
  return true;
}

//-----------------------------------------------------------------------------

bool Time::operator>( const ITime& rhs ) const
{
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
}

//-----------------------------------------------------------------------------
