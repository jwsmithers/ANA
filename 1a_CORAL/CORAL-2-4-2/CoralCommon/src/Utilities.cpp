#include "CoralCommon/Utilities.h"

#if BOOST_VERSION < 15000

#ifdef WIN32
#include <windows.h>
#else
#include <unistd.h>
#endif

void
coral::sleepSeconds( unsigned int secondsToSleep )
{
#ifdef WIN32
  ::Sleep( 1000 * secondsToSleep );
#else
  ::sleep( secondsToSleep );
#endif
}

#else

#include "CoralBase/../src/coral_thread_headers.h"

/*
namespace coral
{
  // A platform independent sleep function (only with Boost >= 1.50)
  void sleepNanoSeconds( unsigned int nanoSecondsToSleep );
}

void
coral::sleepNanoSeconds( unsigned int nsec )
{
  boost::this_thread::sleep_for( boost::chrono::nanoseconds( nsec ) );
}
*/

void
coral::sleepSeconds( unsigned int sec )
{
  boost::this_thread::sleep_for( boost::chrono::seconds( sec ) );
}

#endif
