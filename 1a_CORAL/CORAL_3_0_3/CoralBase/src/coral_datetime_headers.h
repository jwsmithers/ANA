#ifndef CORALBASE_CORALDATETIMEHEADERS_H
#define CORALBASE_CORALDATETIMEHEADERS_H 1

// NB: coral_datetime_headers should be _completely_ removed in all branches!

// First of all, set/unset CORAL240, CORAL300 and CORAL_HAS_CPP11 macros
#include "CoralBase/VersionInfo.h"

// FIXME! This is only needed for boost::posix_time, should use coral::TimeStamp
// NB: boost_datetime_headers should be _completely_ removed in CORAL3 branch!
#ifndef CORAL300CPP11
#include "CoralBase/boost_datetime_headers.h"
#else
#include "CoralBase/../src/boost_datetime_headers.h" // SHOULD BE REMOVED!
#endif

#endif // CORALBASE_CORALDATETIMEHEADERS_H
