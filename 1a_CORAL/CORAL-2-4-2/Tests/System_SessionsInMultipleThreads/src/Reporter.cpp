#include "Reporter.h"
#include <iostream>

void
Reporter::reportToSTDOUT( const std::string& message )
{
  coral::lock_guard lock( m_outputMutex );
  std::cout << message << std::endl;
  std::cout.flush();
}

void
Reporter::reportToSTDERR( const std::string& message )
{
  coral::lock_guard lock( m_outputMutex );
  std::cerr << message << std::endl;
  std::cerr.flush();
}
