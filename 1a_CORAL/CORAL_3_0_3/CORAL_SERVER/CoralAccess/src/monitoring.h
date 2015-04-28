#ifndef CORALACCESS_MONITORING_H
#define CORALACCESS_MONITORING_H 1

// Include files
#include "CoralMonitor/ScopedTimer.h"

/*
// Redefine SCOPED_TIMER: enable monitoring only if the env variable is set
#define SCOPED_TIMER( name ) \
  static std::auto_ptr<coral::TimerStats> myStats; \
  static bool myStatsOn = ::getenv( "CORALACCESS_MONITORING" ); \
  if ( myStatsOn ) myStats.reset( new coral::TimerStats( name ) ); \
  coral::ScopedTimer timer( myStats.get() );
*///

#endif
