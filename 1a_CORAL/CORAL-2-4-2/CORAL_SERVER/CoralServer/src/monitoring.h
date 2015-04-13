// $Id: monitoring.h,v 1.3.2.4 2013-02-05 15:16:19 avalassi Exp $
#ifndef CORALSERVER_MONITORING_H
#define CORALSERVER_MONITORING_H 1

// Include files
#include "CoralMonitor/ScopedTimer.h"

/*
// Redefine SCOPED_TIMER: enable monitoring only if the env variable is set
#define SCOPED_TIMER( name ) \
  static std::auto_ptr<coral::TimerStats> myStats; \
  static bool myStatsOn = ::getenv( "CORALSERVER_MONITORING" ); \
  if ( myStatsOn ) myStats.reset( new coral::TimerStats( name ) ); \
  coral::ScopedTimer timer( myStats.get() );
*///

#endif
