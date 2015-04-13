// $Id: SealTime.cpp,v 1.16 2012-06-29 12:51:46 avalassi Exp $

// Include files
#include <cstdio> // For sprintf on gcc45
#include <cstring> // For memset on gcc43
#include "CoolKernel/Exception.h"

// Local include files
#include "SealTime.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

SealTime::~SealTime()
{
}

//-----------------------------------------------------------------------------

SealTime::SealTime()
  : m_time( seal::Time::current() )
{
}

//-----------------------------------------------------------------------------

SealTime::SealTime( const seal::Time& time )
  : m_time( time )
{
}

//-----------------------------------------------------------------------------

SealTime::SealTime( int year,
                    int month,
                    int day,
                    int hour,
                    int minute,
                    int second,
                    long nanosecond )
//: m_time( year, month-1, day, hour, minute, second, nanosecond, false )
{
  // AV 28.06.2005 Fix a bug in the seal::Time constructor in SEAL_1_6_3
  // AV 18.01.2007 The bug has not yet been fixed in the latest SEAL_1_9_1!
  // The bug is in the implementation for local=false - here is the fix...
  bool local = false;
  tm val;
  memset ( &val, 0, sizeof (val) ); // Fix Coverity NO_EFFECT (real bug!)
  val.tm_sec = second;
  val.tm_min = minute;
  val.tm_hour = hour;
  val.tm_mday = day;
  val.tm_mon = month-1; // tm_mon months are in [0-11]
  val.tm_year = year > 1900 ? year - 1900 : year;
  // AV 28.06.2005 HERE WAS A BUG! (On Windows for local=false)
  //val.tm_isdst = -1; // FIXME?
  val.tm_isdst = 0;
  seal::Time::ValueType nsec = nanosecond;
  m_time = seal::Time::build( local, val, nsec );
}

//-----------------------------------------------------------------------------

SealTime::SealTime( const SealTime& rhs )
  : ITime( rhs )
  , m_time( rhs.sealTime() )
{
}

//-----------------------------------------------------------------------------

SealTime& SealTime::operator=( const SealTime& rhs )
{
  if ( this == &rhs ) return *this;  // Fix Coverity SELF_ASSIGN
  m_time = rhs.sealTime();
  return (*this);
}

//-----------------------------------------------------------------------------

SealTime::SealTime( const ITime& rhs )
{
  // Use the bug-fixed SealTime ctor instead of the buggy seal::Time ctor
  SealTime time( rhs.year(),
                 rhs.month(),
                 rhs.day(),
                 rhs.hour(),
                 rhs.minute(),
                 rhs.second(),
                 rhs.nanosecond() );
  m_time = time.sealTime();
}

//-----------------------------------------------------------------------------

SealTime& SealTime::operator=( const ITime& rhs )
{
  // Use the bug-fixed SealTime ctor instead of the buggy seal::Time ctor
  SealTime time( rhs.year(),
                 rhs.month(),
                 rhs.day(),
                 rhs.hour(),
                 rhs.minute(),
                 rhs.second(),
                 rhs.nanosecond() );
  m_time = time.sealTime();
  return (*this);
}

//-----------------------------------------------------------------------------

std::ostream& SealTime::print( std::ostream& os ) const
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
                 year, month, day, hour, min, sec, nsec) == nChar )
  {
    return os << std::string( timeChar );
  }
  std::stringstream s;
  s << "PANIC! Error printing out "
    << year << "-" << month << "-" << day << "_"
    << hour << ":" << min << ":" << sec << "." << nsec;
  throw Exception( s.str(), "SealTime" );
}

//-----------------------------------------------------------------------------

bool SealTime::operator==( const ITime& rhs ) const
{
  if ( this->year() != rhs.year() ) return false;
  if ( this->month() != rhs.month() ) return false;
  if ( this->day() != rhs.day() ) return false;
  if ( this->hour() != rhs.hour() ) return false;
  if ( this->minute() != rhs.minute() ) return false;
  if ( this->second() != rhs.second() ) return false;
  if ( this->nanosecond() != rhs.nanosecond() ) return false;
  return true;
}

//-----------------------------------------------------------------------------

bool SealTime::operator>( const ITime& rhs ) const
{
  if ( this->year() > rhs.year() ) return true;
  if ( this->year() < rhs.year() ) return false;

  if ( this->month() > rhs.month() ) return true;
  if ( this->month() < rhs.month() ) return false;

  if ( this->day() > rhs.day() ) return true;
  if ( this->day() < rhs.day() ) return false;

  if ( this->hour() > rhs.hour() ) return true;
  if ( this->hour() < rhs.hour() ) return false;

  if ( this->minute() > rhs.minute() ) return true;
  if ( this->minute() < rhs.minute() ) return false;

  if ( this->second() > rhs.second() ) return true;
  if ( this->second() < rhs.second() ) return false;

  if ( this->nanosecond() > rhs.nanosecond() ) return true;
  if ( this->nanosecond() < rhs.nanosecond() ) return false;

  if ( (*this) == rhs ) return false;
  std::stringstream s;
  s << "PANIC! Could not determine if " << *this << " > " << rhs;
  throw Exception( s.str(), "SealTime" );
}

//-----------------------------------------------------------------------------
