#ifndef CORAL_CORALBASE_DATE_H
#define CORAL_CORALBASE_DATE_H 1

// First of all, enable or disable the CORAL240 API extensions (bug #89707)
#include "CoralBase/VersionInfo.h"

// Replace Boost by c++11 in the CORAL3 API (task #49014 and task #50598)
#ifndef CORAL300CPP11
#include "CoralBase/boost_datetime_headers.h"
#else
#include <chrono>
#endif

namespace coral
{
  /**
   * @class Date Date.h CoralBase/Date.h
   *
   * A class defining a DATE type.
   *
   *///
  class Date
  {
  public:

    /// Default constructor - Returns the current UTC date
    Date();

    /// Constructor
    Date( int year, int month, int day );

    /// Destructor
    ~Date();

#ifndef CORAL300CPP11
    /// Constructor from a posix time
    explicit Date( const boost::posix_time::ptime& );
#else
    /// Constructor from a time_point
    explicit Date( const std::chrono::system_clock::time_point& );
#endif

    /// Copy constructor
    Date( const Date& rhs );

    /// Assignment operator
    Date& operator=( const Date& rhs );

    /// Equal operator
    bool operator==( const Date& rhs ) const;

    /// Comparison operator
    bool operator!=( const Date& rhs ) const;

    /// Returns the year
    int year() const;

    /// Returns the month [1-12]
    int month() const;

    /// Returns the day [1-31]
    int day() const;

#ifndef CORAL300CPP11
    /// Returns the underlying posix time (by reference)
    const boost::posix_time::ptime& time() const;
#else
    /// Returns a time_point (by value)
    std::chrono::system_clock::time_point time() const;
#endif

#ifndef CORAL300CPP11
    /// Returns the current (local) date
    static Date today();
#endif

  private:

#ifndef CORAL300CPP11
    /// The actual time object
    boost::posix_time::ptime m_time;
#else
    /// The actual year, month [1-12] and day [1-31]
    int m_year, m_mon, m_day;
#endif
  };

}

/// Inline methods
#ifndef CORAL300CPP11
inline
coral::Date::Date( const boost::posix_time::ptime& pT )
  : m_time( pT )
{
}


inline
coral::Date::Date( const coral::Date& rhs )
  : m_time( rhs.m_time )
{
}


inline coral::Date&
coral::Date::operator=( const coral::Date& rhs )
{
#ifdef CORAL240CO
  if ( this == &rhs ) return *this;  // Fix Coverity SELF_ASSIGN bug #95355
#endif
  m_time = rhs.m_time;
  return *this;
}
#endif


inline int
coral::Date::year() const
{
#ifndef CORAL300CPP11
  return m_time.date().year();
#else
  return m_year;
#endif
}


inline int
coral::Date::month() const
{
#ifndef CORAL300CPP11
  return m_time.date().month();
#else
  return m_mon;
#endif
}


inline int
coral::Date::day() const
{
#ifndef CORAL300CPP11
  return m_time.date().day();
#else
  return m_day;
#endif
}


#ifndef CORAL300CPP11
inline const boost::posix_time::ptime&
coral::Date::time() const
{
  return m_time;
}
#endif


inline bool
coral::Date::operator==( const coral::Date& rhs ) const
{
  return ( this->year() == rhs.year() &&
           this->month() == rhs.month() &&
           this->day() == rhs.day() );
}


inline bool
coral::Date::operator!=( const coral::Date& rhs ) const
{
  return ( this->year() != rhs.year() ||
           this->month() != rhs.month() ||
           this->day() != rhs.day() );
}
#endif
