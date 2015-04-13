#ifndef CORALCOMMON_UTILITIES_H
#define CORALCOMMON_UTILITIES_H 1

namespace coral 
{

  /*
  // A platform independent sleep function (only with Boost >= 1.50)
  void sleepNanoSeconds( unsigned int nanoSecondsToSleep );
  */

  // A platform independent sleep function
  void sleepSeconds( unsigned int secondsToSleep );

}

#endif
