#ifndef CORAL_CORALBASE_TIMESTAMP_H
#define CORAL_CORALBASE_TIMESTAMP_H 1

// First of all, set/unset CORAL240, CORAL300 and CORAL_HAS_CPP11 macros
#include "CoralBase/VersionInfo.h"

// Include files
#ifdef CORAL300CPP11
#include <ostream>
#endif
#include <string>

// Replace Boost by c++11 in the CORAL3 API (task #49014 and task #50598)
#ifndef CORAL300CPP11
#include "CoralBase/boost_datetime_headers.h"
#else
#include <chrono>
#endif

#ifndef CORAL240TS
// Move coral::time from public API to private implementation (bug #103289)
namespace coral
{
  namespace time
  {
    // From BOOST: This local adjustor depends on the machine TZ settings-- highly dangerous!
    typedef boost::date_time::c_local_adjustor<boost::posix_time::ptime> local_adj;
    // In case it's missing in BOOST build - might fail to compile
    typedef boost::date_time::subsecond_duration<boost::posix_time::time_duration,1000000000> nanoseconds;
  }
}
#endif

namespace coral
{

  /**
     @class TimeStamp TimeStamp.h CoralBase/TimeStamp.h

     A class defining the TIMESTAMP type.

     In CORAL 2.x both UTC and local timestamps are supported.
     In CORAL 3.x only UTC timestamps are supported.

  *///
  class TimeStamp
  {
  public:

    /// The int64 type for storing time as nanoseconds since the epoch time UTC
    typedef signed long long int ValueType;

#ifndef CORAL240TS
    /// Remove this obsolete method from the CORAL240 API (bug #64016)
    static const boost::posix_time::ptime& Epoch;
#endif

  public:

    /// Default constructor, returns the current time UTC
    TimeStamp();

#ifndef CORAL300CPP11
    /// Constructor from YYYY-MM-DD:hh:mm:ss.nnnnnnnnn UTC
    /// (the three least significant digits of nanoseconds may be ignored).
    /// Optionally UTC time input is converted and stored into a local time.
    /// [WARNING! This may lead to loss of precision on CORAL2xx.]
    /// [TimeStamp typically has Boost's microsecond resolution in CORAL2xx.]
    /// [WARNING! No checks are done on the input parameters.]
    TimeStamp( int year, int month, int day,
               int hour, int minute, int second, long nanosecond,
               bool isLocalTime = false ); // default: UTC
#else
    /// Constructor from YYYY-MM-DD:hh:mm:ss.nnnnnnnnn UTC.
    /// Range: 1677-09-21_00:12:43.145224192 to 2262-04-11_23:47:16.854775807.
    /// Throws an Exception if input parameters are outside their ranges
    /// or if the day of that month does not exist during that year.
    /// [This is guaranteed to have no loss of precision on CORAL300.]
    /// [TimeStamp is guaranteed to have nanosecond resolution in CORAL300!]
    TimeStamp( int year, // [1677-2262] int64 range around 1970...
               int month, // [1-12]
               int day, // [1-31]
               int hour, // [0-23]
               int minute, // [0-59]
               int second, // [0-59]
               long nanosecond ); // [0-999999999]
#endif

#ifndef CORAL300CPP11
    /// Constructor from a posix time UTC
    explicit TimeStamp( const boost::posix_time::ptime& );

    /// Constructor from a posix time UTC, optionally into local time
    explicit TimeStamp( const boost::posix_time::ptime&,
                        bool isLocalTime ); // default: UTC (no arg => false)
#else
    /// Constructor from a c++11 time_point UTC.
    /// [WARNING! This may lead to loss of precision on CORAL300 on icc13.]
    /// [Check resolution via typeid(system_clock::time_point::period).]
    /// [On icc13, c++11 time_point has microsecond resolution (bug #104622)!]
    explicit TimeStamp( const std::chrono::system_clock::time_point& );
#endif

#ifndef CORAL300CPP11
    /// Constructor from number of nanoseconds since epoch time UTC.
    /// [WARNING! This may lead to loss of precision on CORAL2xx.]
    /// [TimeStamp typically has Boost's microsecond resolution in CORAL2xx.]
    explicit TimeStamp( ValueType& nsecs );
#else
    /// Constructor from number of nanoseconds since epoch time UTC.
    /// [This is guaranteed to have no loss of precision on CORAL300.]
    /// [TimeStamp is guaranteed to have nanosecond resolution in CORAL300!]
    explicit TimeStamp( ValueType nsecs );
#endif

    /// Destructor
    ~TimeStamp();

    /// Copy constructor
    TimeStamp( const TimeStamp& rhs );

    /// Assignment operator
    TimeStamp& operator=( const TimeStamp& rhs );

    /// Returns the year
    int year() const;

    /// Returns the month [1-12]
    int month() const;

    /// Returns the day [1-31]
    int day() const;

    /// Returns the hour [0-23]
    int hour() const;

    /// Returns the minute [0-59]
    int minute() const;

    /// Returns the second [0-59]
    int second() const;

#ifndef CORAL300CPP11
    /// Returns the fractional seconds [0-999999(999)].
    /// [WARNING! This may lead to loss of precision on CORAL2xx.]
    /// [TimeStamp typically has Boost's microsecond resolution in CORAL2xx.]
    long nanosecond() const;
#else
    /// Returns the nanoseconds [0-999999999].
    /// [This is guaranteed to have no loss of precision on CORAL300.]
    /// [TimeStamp is guaranteed to have nanosecond resolution in CORAL300!]
    long nanosecond() const;
#endif

#ifndef CORAL300CPP11
    /// The number of nanoseconds from epoch 01/01/1970 UTC (fits in int64)
    /// For 'now' this is the same whether 'now' is expressed in UTC or local!
    /// [WARNING! This may lead to loss of precision on CORAL2xx.]
    /// [TimeStamp typically has Boost's microsecond resolution in CORAL2xx.]
    ValueType total_nanoseconds() const;
#else
    /// The number of nanoseconds from epoch 01/01/1970 UTC (fits in int64)
    /// [This is guaranteed to have no loss of precision on CORAL300.]
    /// [TimeStamp is guaranteed to have nanosecond resolution in CORAL300!]
    ValueType total_nanoseconds() const;
#endif

#ifndef CORAL300CPP11
    /// Returns the underlying UTC or local posix time (by reference).
    const boost::posix_time::ptime& time() const;
#else
    /// Returns a c++11 time_point UTC (by value).
    /// [WARNING! This may lead to loss of precision on CORAL300 on icc13.]
    /// [Check resolution via typeid(system_clock::time_point::period).]
    /// [On icc13, c++11 time_point has microsecond resolution (bug #104622)!]
    std::chrono::system_clock::time_point time() const;
#endif

    /// Equal operator
    bool operator==( const TimeStamp& rhs ) const;

    /// Comparison operator
    bool operator!=( const TimeStamp& rhs ) const;

#ifdef CORAL300CPP11
    /// Comparison operator
    bool operator>( const TimeStamp& rhs ) const;

    /// Comparison operator
    bool operator>=( const TimeStamp& rhs ) const;

    /// Comparison operator
    bool operator<( const TimeStamp& rhs ) const;

    /// Comparison operator
    bool operator<=( const TimeStamp& rhs ) const;
#endif

#ifndef CORAL300CPP11
    /// Return the current time (UTC or local)
    static TimeStamp now( bool isLocalTime=false ); // default: UTC
#else
    /// Return the current time UTC
    static TimeStamp now();
#endif

    /// Return the string representation of the time stamp
    std::string toString() const;

#ifdef CORAL300CPP11
    /// Print to an output stream.
    std::ostream& print( std::ostream& os ) const;
#endif

  private:

#ifndef CORAL300CPP11
    /// The actual posix time object
    boost::posix_time::ptime m_time;
#else
    /// The actual year, month [1-12] and day [1-31]
    int m_year, m_mon, m_day;

    /// The actual hour, minute, second and nanosecond
    int m_hour, m_min, m_sec, m_nsec;
#endif

#ifndef CORAL300CPP11
    /// Is the point in time UTC or a local time?
    bool m_isLocal;

    /// In case a Timestamp is flagged as local time we initialize this one too
    std::auto_ptr<boost::posix_time::ptime> m_localTime;
#endif
  };

#ifdef CORAL300CPP11
  /// Print to an output stream.
  inline std::ostream& operator<<( std::ostream& s, const TimeStamp& time )
  {
    return time.print( s );
  }
#endif

}

#endif
