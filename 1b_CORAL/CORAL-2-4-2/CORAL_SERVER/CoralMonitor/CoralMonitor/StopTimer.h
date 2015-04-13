// $Id: StopTimer.h,v 1.2.2.1.2.5 2013-02-06 14:33:11 avalassi Exp $
#ifndef CORALMONITOR_STOPTIMER_H
#define CORALMONITOR_STOPTIMER_H 1

// Include files
#include <string>
#include <sys/times.h>

namespace coral
{
  /**
   * Usage:
   *
   * StopTimer myTimer;
   * myTimer.start();
   * // performance critical part
   * myTimer.stop()
   *
   * You should then manally retrieve the timers.
   *
   * By default timings are disabled: they can be enabled
   * by setting the environment variable CORALSERVER_TIMING.
   *
   *///

  class StopTimer
  {
  public:

    /// default constructor
    StopTimer();

    // Destructor
    virtual ~StopTimer(){}

    /// Start timer
    virtual void start();

    /// Stop timer
    virtual void stop();

    /// Get user time in seconds
    virtual double getUserTime() const;

    /// Get system time in seconds
    virtual double getSystemTime() const;

    /// Get the real time in seconds
    virtual double getRealTime() const;

  private:

    /// Is timing enabled
    bool m_isEnabled;

    /// Is the watch running?
    bool m_isRunning;

    /// How much time elapsed
    struct tms m_elapsedTime;

    /// Starting time of the watch
    struct tms m_startTime;

    /// Elapsed real time
    clock_t m_elapsedReal;

    /// Starting real time
    clock_t m_startReal;

#ifdef __linux
    unsigned long m_startUserLinux;
    unsigned long m_startSystemLinux;
    unsigned long m_elapsedUserLinux;
    unsigned long m_elapsedSystemLinux;
#endif
  };

}
#endif
