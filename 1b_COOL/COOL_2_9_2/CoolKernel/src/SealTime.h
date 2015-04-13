#ifndef COOLKERNEL_SEALTIME_H
#define COOLKERNEL_SEALTIME_H

// Include files
#include "CoolKernel/ITime.h"
#include "SealBaseTime.h"

namespace cool
{

  /** @class SealTime SealTime.h
   *
   *  SEAL-based implementation of cool::ITime
   *  (adapter of seal::Time to the cool::ITime interface).
   *
   *  @author Andrea Valassi
   *  @date   2007-01-18
   *///

  class SealTime : public ITime
  {

  public:

    /// Destructor.
    virtual ~SealTime();

    /// Default constructor: returns the current UTC time.
    SealTime();

    /// Constructor from a SEAL time - reinterpreted as a UTC time.
    SealTime( const seal::Time& time );

    /// Constructor from an explicit date/time - interpreted as a UTC time.
    SealTime( int year,
              int month,
              int day,
              int hour,
              int minute,
              int second,
              long nanosecond );

    /// Copy constructor from another SealTime.
    SealTime( const SealTime& rhs );

    /// Assignment operator from another SealTime.
    SealTime& operator=( const SealTime& rhs );

    /// Copy constructor from any other ITime.
    SealTime( const ITime& rhs );

    /// Assignment operator from any other ITime.
    SealTime& operator=( const ITime& rhs );

    /// Returns the seal Time.
    const seal::Time& sealTime() const
    {
      return m_time;
    }

    /// Returns the year.
    int year() const
    {
      bool local = false; // Use UTC-GMT times
      return m_time.year( local );
    }

    /// Returns the month [1-12].
    int month() const
    {
      bool local = false; // Use UTC-GMT times
      return m_time.month( local ) + 1; // SEAL months are in [0-11]
    }

    /// Returns the day [1-31].
    int day() const
    {
      bool local = false; // Use UTC-GMT times
      return m_time.day( local );
    }

    /// Returns the hour [0-23].
    int hour() const
    {
      bool local = false; // Use UTC-GMT times
      return m_time.hour( local );
    }

    /// Returns the minute [0-59].
    int minute() const
    {
      bool local = false; // Use UTC-GMT times
      return m_time.minute( local );
    }

    /// Returns the second [0-59].
    int second() const
    {
      bool local = false; // Use UTC-GMT times
      return m_time.second( local );
    }

    /// Returns the nanosecond [0-999999999].
    long nanosecond() const
    {
      return m_time.nsecond();
    }

    /// Print to an output stream.
    std::ostream& print( std::ostream& os ) const;

    /// Comparison operator.
    bool operator==( const ITime& rhs ) const;

    /// Comparison operator.
    bool operator>( const ITime& rhs ) const;

  private:

    seal::Time m_time;

  };

}

#endif // COOLKERNEL_SIMPLETIME_H
