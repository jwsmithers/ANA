#ifndef COOLKERNEL_TIME_H
#define COOLKERNEL_TIME_H 1

// First of all, set/unset CORAL290, COOL300, COOL400 and COOL_HAS_CPP11 macros
#include "CoolKernel/VersionInfo.h"

// For COOL300, check that CORAL300 extensions are enabled in CORAL
#include "CoralBase/VersionInfo.h"
#ifdef COOL300TS
#ifndef CORAL300CPP11
#error "ERROR: COOL300TS requires CORAL300CPP11"
#endif
#endif

// Include files
#ifdef COOL300TS
#include "CoralBase/TimeStamp.h"
#endif
#include "CoolKernel/ITime.h"

namespace cool
{

  /** @class Time Time.h
   *
   *  Simple COOL time class.
   *
   *  Basic sanity checks on value ranges are delegated in the internal
   *  implementation to a more complex Time class (e.g. coral::TimeStamp).
   *
   *  @author Andrea Valassi
   *  @date   2007-01-17
   *///

  class Time : public ITime
  {

  public:

    /// Destructor.
    virtual ~Time();

    /// Default constructor: returns the current UTC time.
    Time();

    /// Constructor from an explicit date/time - interpreted as a UTC time.
    /// Sanity checks on the ranges of the input arguments are implemented.
    Time( int year,
          int month,
          int day,
          int hour,
          int minute,
          int second,
          long nanosecond );

    /// Copy constructor from another Time.
    Time( const Time& rhs );

    /// Assignment operator from another Time.
    Time& operator=( const Time& rhs );

    /// Copy constructor from any other ITime.
    Time( const ITime& rhs );

    /// Assignment operator from any other ITime.
    Time& operator=( const ITime& rhs );

#ifdef COOL300TS
    /// Copy constructor from a coral::TimeStamp.
    Time( const coral::TimeStamp& rhs );

    /// Assignment operator from a coral::TimeStamp.
    Time& operator=( const coral::TimeStamp& rhs );

    /// Return the underlying coral::TimeStamp.
    const coral::TimeStamp& coralTimeStamp() const
    {
      return m_ts;
    }
#endif

    /// Returns the year.
    int year() const
    {
#ifndef COOL300TS
      return m_year;
#else
      return m_ts.year();
#endif
    }

    /// Returns the month [1-12].
    int month() const
    {
#ifndef COOL300TS
      return m_month;
#else
      return m_ts.month();
#endif
    }

    /// Returns the day [1-31].
    int day() const
    {
#ifndef COOL300TS
      return m_day;
#else
      return m_ts.day();
#endif
    }

    /// Returns the hour [0-23].
    int hour() const
    {
#ifndef COOL300TS
      return m_hour;
#else
      return m_ts.hour();
#endif
    }

    /// Returns the minute [0-59].
    int minute() const
    {
#ifndef COOL300TS
      return m_minute;
#else
      return m_ts.minute();
#endif
    }

    /// Returns the second [0-59].
    int second() const
    {
#ifndef COOL300TS
      return m_second;
#else
      return m_ts.second();
#endif
    }

    /// Returns the nanosecond [0-999999999].
    long nanosecond() const
    {
#ifndef COOL300TS
      return m_nanosecond;
#else
      return m_ts.nanosecond();
#endif
    }

    /// Print to an output stream.
    std::ostream& print( std::ostream& os ) const;

    /// Comparison operator.
    bool operator==( const ITime& rhs ) const;

    /// Comparison operator.
    bool operator>( const ITime& rhs ) const;

  private:

#ifndef COOL300TS
    int m_year;
    int m_month;
    int m_day;
    int m_hour;
    int m_minute;
    int m_second;
    long m_nanosecond;
#else
    coral::TimeStamp m_ts;
#endif

  };

}

#endif // COOLKERNEL_TIME_H
