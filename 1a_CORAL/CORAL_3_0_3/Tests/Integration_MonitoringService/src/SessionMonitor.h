// -*- C++ -*-
#ifndef CORAL_USER_SESSIONMON_H
#define CORAL_USER_SESSIONMON_H 1

#include "CoralCommon/MonitoringReportTypes.h"
#include "CoralCommon/MonitoringEvent.h"

#include <vector>
#include <map>
#include <string>

namespace usermon
{
  /// The raw stream of recorder monitoring events
  typedef std::vector<coral::monitor::Event::Record> EventStream;

  /// The session related book-keeping of monitored events
  struct SessionMonitor
  {
    SessionMonitor();
    SessionMonitor( bool, coral::monitor::Level );

    bool active;
    coral::monitor::Level level;
    EventStream stream;
  };

  /// are identified by session key
  /// The repository of monitored events for all sessions where event streams
  typedef std::map< std::string, SessionMonitor > Repository;
}

#endif // CORAL_USER_SESSIONMON_H
