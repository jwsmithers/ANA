#ifndef CORALBASE_CORALBINDHEADERS_H
#define CORALBASE_CORALBINDHEADERS_H 1

// NB: coral_bind_headers should be _completely_ removed in all branches!

// First of all, set/unset CORAL240, CORAL300 and CORAL_HAS_CPP11 macros
#include "CoralBase/VersionInfo.h"

// FIXME! Should use c++11 instead of boost in the internal implementation!
// NB: boost_bind_headers should be _completely_ removed in CORAL3 branch!
#ifndef CORAL300CPP11
#include "CoralBase/boost_bind_headers.h"
#else
#include "CoralBase/../src/boost_bind_headers.h" // SHOULD BE REMOVED!
#endif

#endif // CORALBASE_CORALBINDHEADERS_H
