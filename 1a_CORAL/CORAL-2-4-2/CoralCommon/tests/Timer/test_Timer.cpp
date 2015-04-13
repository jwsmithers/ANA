#include "CoralCommon/SimpleTimer.h"
#include "CoralCommon/Utilities.h"

#include <stdexcept>
#include <iostream>
#include <unistd.h>

int main( int, char** )
{
  try
  {
    coral::SimpleTimer st;

    if( st.total() != 0 )
      throw std::logic_error( "Invalid total duration of an idle timer!" );

    st.start();

    if( st.total() != 0 )
      throw std::logic_error( "Invalid total duration of an empty timer!" );

    unsigned long long j = 0;
    ::usleep( 10 ); // sleep 10 microseconds (fix bug #103396)

    coral::SimpleTimer::ValueType snap1 = st.sample();

    if( snap1 == 0 )
      throw std::logic_error( "Invalid sample duration of a running timer (1)!" );

    ::usleep( 10 ); // sleep 10 microseconds (fix bug #103396)

    if( st.total() != snap1 )
      throw std::logic_error( "Invalid total duration of a running timer (1)!" );

    std::cout << "First snapshot after " << snap1 << " microseconds" << std::endl;

    ::usleep( 10 ); // sleep 10 microseconds (fix bug #103396)

    coral::SimpleTimer::ValueType snap2 = st.sample();

    if( snap2 == 0 )
      throw std::logic_error( "Invalid sample duration of a running timer (2)!" );

    ::usleep( 10 ); // sleep 10 microseconds (fix bug #103396)

    if( st.total() != snap2 )
      throw std::logic_error( "Invalid total duration of a running timer (2)!" );

    std::cout << "Second snapshot after " << snap2 << " microseconds" << std::endl;

    if( snap1 >= snap2 )
      throw std::logic_error( "Invalid consequent time snapshots of a running timer!" );

    // Test the KISS sleep function port from SEAL
    coral::SimpleTimer slt;
    slt.start();
    coral::sleepSeconds(2);
    slt.stop();
    std::cout << "Was supposed to sleep for 2 secs and slept roughly for " << slt.total() << " microseconds" << std::endl;

    coral::SimpleTimer::ValueType snap3 = st.sample();

    for ( unsigned int i=0; i<1000000; ++i ) j+=i;

    st.stop();

    std::cout << "1M iterations loop running for " << st.total()-snap3 << " microseconds: sum=" << j << std::endl;

    if( st.total() <= snap2 )
      throw std::logic_error( "Invalid total duration of a stopped timer!" );


    std::cout << "Total running time " << st.total() << " microseconds" << std::endl;
  }
  catch( const std::exception& e )
  {
    std::cerr << "Caught an exception: " << e.what() << " ... " << std::endl;
  }
  catch( ... )
  {
    std::cerr << "Caught an unknown exception..." << std::endl;
  }

  return 0;
}
