#ifndef COOLKERNEL_TIMEWRAPPER_H
#define COOLKERNEL_TIMEWRAPPER_H

// Include files
#include "CoolKernel/ITime.h"

namespace cool
{

  /** @class TimeWrapper TimeWrapper.h
   *
   *  Generic concrete COOL time class.
   *
   *  The implementation details are hidden from the public API.
   *
   *  @author Andrea Valassi
   *  @date   2007-01-17
   *///

  class TimeWrapper : public ITime
  {

  public:

    /// Destructor.
    virtual ~TimeWrapper();

    /// Default constructor: returns the current UTC time.
    TimeWrapper();

    /// Constructor.
    TimeWrapper( int year,
                 int month,
                 int day,
                 int hour,
                 int minute,
                 int second,
                 long nanosecond );

    /// Copy constructor from another TimeWrapper.
    TimeWrapper( const TimeWrapper& rhs );

    /// Assignment operator from another TimeWrapper.
    TimeWrapper& operator=( const TimeWrapper& rhs );

    /// Copy constructor from any other ITime.
    TimeWrapper( const ITime& rhs );

    /// Assignment operator from any other ITime.
    TimeWrapper& operator=( const ITime& rhs );

    /// Returns the year.
    int year() const
    {
      return m_time->year();
    }

    /// Returns the month [1-12].
    int month() const
    {
      return m_time->month();
    }

    /// Returns the day [1-31].
    int day() const
    {
      return m_time->day();
    }

    /// Returns the hour [0-23].
    int hour() const
    {
      return m_time->hour();
    }

    /// Returns the minute [0-59].
    int minute() const
    {
      return m_time->minute();
    }

    /// Returns the second [0-59].
    int second() const
    {
      return m_time->second();
    }

    /// Returns the nanosecond [0-999999999].
    long nanosecond() const
    {
      return m_time->nanosecond();
    }

    /// Print to an output stream.
    std::ostream& print( std::ostream& os ) const
    {
      return m_time->print( os );
    }

    /// Comparison operator.
    bool operator==( const ITime& rhs ) const
    {
      return m_time->operator==( rhs );
    }

    /// Comparison operator.
    bool operator>( const ITime& rhs ) const
    {
      return m_time->operator>( rhs );
    }

  private:

    /// Privately owned implementation class to which all calls are delegated.
    ITime* m_time;

  };

}

#endif // COOLKERNEL_TIMEWRAPPER_H
