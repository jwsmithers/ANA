// $Id: ScopedTimer.h,v 1.10.2.6 2013-02-06 14:54:52 avalassi Exp $
#ifndef CORALMONITOR_SCOPEDTIMER_H
#define CORALMONITOR_SCOPEDTIMER_H 1

// Include files
#include "CoralMonitor/StopTimer.h"

// Local include files
#include "StatsTypeTimer.h"

namespace coral
{

  /**
   * Usage:
   *
   * void class::doSomething()
   * {
   *   ScopedTimer timer( myTimerStats );
   *   // do something
   * }
   *
   *///

  class ScopedTimer
  {
  public:

    ScopedTimer( StatsTypeTimer& stat )
      : m_stat( stat )
    {
      m_stopTimer.start();
    }

    ~ScopedTimer()
    {
      m_stopTimer.stop();
      m_stat.add( m_stopTimer.getUserTime(),
                  m_stopTimer.getSystemTime(),
                  m_stopTimer.getRealTime() );
    }

  private:

    StatsTypeTimer& m_stat;

    StopTimer m_stopTimer;

  };

}

// Define the default SCOPED_TIMER (disable monitoring by default)
#define SCOPED_TIMER( x ) do { ; } while(0)

#endif
