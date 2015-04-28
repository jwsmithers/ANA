// First of all, enable or disable the CORAL240 API extensions (bug #89707)
#include "CoralBase/VersionInfo.h"

// Include files
#include "CoralBase/Date.h"
#ifdef CORAL300CPP11
#include "CoralBase/TimeStamp.h"
#endif

namespace coral
{

#ifndef CORAL300CPP11

  // Default constructor
  Date::Date()
    : m_time( boost::posix_time::microsec_clock::universal_time() ) // UTC
  {
  }

  // Constructor taken year month and day
  Date::Date( int year, int month, int day )
    : m_time( boost::gregorian::date( year, month, day ), 
              boost::posix_time::time_duration( 0, 0, 0, 0 ) )
  {
  }

  Date::~Date()
  {
  }

  Date Date::today()
  {
    boost::posix_time::ptime timeToday = boost::posix_time::microsec_clock::local_time(); // local
    return Date( timeToday );
  }

#else

  Date::Date()
  {
    coral::TimeStamp now = coral::TimeStamp::now(); // UTC
    m_year = now.year();
    m_mon = now.month();
    m_day = now.day();
  }

  Date::Date( const Date& rhs )
    : m_year( rhs.m_year ), m_mon( rhs.m_mon ), m_day( rhs.m_day )
  {
  }

  Date::Date( int year, int month, int day )
    : m_year( year ), m_mon ( month ), m_day ( day )
  {
  }

  Date::~Date()
  {
  }

  Date& Date::operator= ( const Date& rhs )
  {
    m_year = rhs.m_year;
    m_mon = rhs.m_mon;
    m_day = rhs.m_day;
    return *this;
  }

  Date::Date( const std::chrono::system_clock::time_point& ptime )
  {
    coral::TimeStamp ts( ptime );
    m_year = ts.year();
    m_mon = ts.month();
    m_day = ts.day();
  }

  std::chrono::system_clock::time_point Date::time() const
  {
    return coral::TimeStamp( m_year, m_mon, m_day, 0, 0, 0, 0 ).time();
  }

#endif

}
