// $Id: TimeWrapper.cpp,v 1.4 2012-06-29 12:47:41 avalassi Exp $

// Local include files
#include "SealTime.h"
#include "TimeWrapper.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

TimeWrapper::~TimeWrapper()
{
  delete m_time;
}

//-----------------------------------------------------------------------------

TimeWrapper::TimeWrapper()
{
  m_time = new SealTime();
}

//-----------------------------------------------------------------------------

TimeWrapper::TimeWrapper( int year,
                          int month,
                          int day,
                          int hour,
                          int minute,
                          int second,
                          long nanosecond )
{
  m_time = new SealTime( year, month, day, hour, minute, second, nanosecond );
}

//-----------------------------------------------------------------------------

TimeWrapper::TimeWrapper( const TimeWrapper& rhs )
  : ITime( rhs )
{
  m_time = new SealTime( rhs );
}

//-----------------------------------------------------------------------------

TimeWrapper& TimeWrapper::operator=( const TimeWrapper& rhs )
{
  if ( this == &rhs ) return *this;  // Fix Coverity SELF_ASSIGN
  delete m_time;
  m_time = new SealTime( rhs );
  return (*this);
}

//-----------------------------------------------------------------------------

TimeWrapper::TimeWrapper( const ITime& rhs )
{
  m_time = new SealTime( rhs );
}

//-----------------------------------------------------------------------------

TimeWrapper& TimeWrapper::operator=( const ITime& rhs )
{
  delete m_time;
  m_time = new SealTime( rhs );
  return (*this);
}

//-----------------------------------------------------------------------------
