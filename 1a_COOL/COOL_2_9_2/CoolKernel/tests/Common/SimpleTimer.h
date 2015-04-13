// $Id: SimpleTimer.h,v 1.1 2013-03-08 11:36:33 avalassi Exp $
#ifndef COMMON_SIMPLETIMER_H
#define COMMON_SIMPLETIMER_H 1

// Include files
#ifdef __linux
#include <cstring> // memset
#include <sys/times.h> // times
#include <unistd.h> // sysconf
#define CLK_TCK sysconf(_SC_CLK_TCK)
#endif

namespace cool
{
  /** @class SimpleTimer SimpleTimer.h
   *
   *  Usage:
   *    Timer myTimer;      // starts the timer
   *    myTimer.elapsed();  // returns the elapsed time
   *
   *  @author Andrea Valassi
   *  @date   2009-08-23
   *///

  class SimpleTimer
  {

  public:

    // Destructor
    ~SimpleTimer()
    {
    }

    // Constructor (starts the timer)
    SimpleTimer()
    {
#ifdef __linux
      struct tms now;
      memset( &now, 0, sizeof( now ) );
      m_startReal = times( &now );
#endif
    }

    // Return the elapsed real time in seconds since the start of the timer
    double elapsedSecondsReal()
    {
#ifdef __linux
      struct tms now;
      memset( &now, 0, sizeof( now ) );
      clock_t elapsedReal = times( &now ) - m_startReal;
      return (double)elapsedReal / CLK_TCK;
#else
      return 0; // No support on Windows or OSX
#endif
    }

  private:

#ifdef __linux
    // Starting real time
    clock_t m_startReal;
#endif

  };

}
#endif
