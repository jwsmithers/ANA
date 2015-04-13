#ifndef CORALBASE_TIMESTAMPEPOCH_H
#define CORALBASE_TIMESTAMPEPOCH_H 1

// Include files
#include "CoralBase/boost_datetime_headers.h"

namespace coral
{
  /// Use coral::getTimeStampEpoch() instead of coral::TimeStamp:Epoch (bug #64016)
  /// The epoch constant timestamp used to calculate the total number of nanoseconds since the epoch time UTC
  inline const boost::posix_time::ptime& getTimeStampEpoch()
  {
    //std::cout << "getTimeStampEpoch() called" << std::endl;
    //std::cout << "In TimeStamp.cpp: &(Epoch) is " << &(coral::TimeStamp::Epoch) << std::endl;
    static const boost::posix_time::ptime s_epoch( boost::gregorian::date(1970, 1, 1 ) );
    //std::cout << "&(getTimeStampEpoch()) will give " << &(s_epoch) << std::endl;
    //std::cout << "getTimeStampEpoch() will give " << s_epoch << std::endl;
    return s_epoch;
  }
}

#endif // CORALBASE_TIMESTAMPEPOCH_H
