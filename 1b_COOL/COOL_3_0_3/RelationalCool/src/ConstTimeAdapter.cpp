
// Local include files
#include "ConstTimeAdapter.h"
#include "timeToString.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

ConstTimeAdapter::~ConstTimeAdapter()
{
}

//-----------------------------------------------------------------------------

ConstTimeAdapter::ConstTimeAdapter( const std::string& time )
  : m_time( time )
{
}

//-----------------------------------------------------------------------------

int ConstTimeAdapter::year() const
{
  return stringToTime( m_time ).year();
}

//-----------------------------------------------------------------------------

int ConstTimeAdapter::month() const
{
  return stringToTime( m_time ).month();
}

//-----------------------------------------------------------------------------

int ConstTimeAdapter::day() const
{
  return stringToTime( m_time ).day();
}

//-----------------------------------------------------------------------------

int ConstTimeAdapter::hour() const
{
  return stringToTime( m_time ).hour();
}

//-----------------------------------------------------------------------------

int ConstTimeAdapter::minute() const
{
  return stringToTime( m_time ).minute();
}

//-----------------------------------------------------------------------------

int ConstTimeAdapter::second() const
{
  return stringToTime( m_time ).second();
}

//-----------------------------------------------------------------------------

long ConstTimeAdapter::nanosecond() const
{
  return stringToTime( m_time ).nanosecond();
}

//-----------------------------------------------------------------------------

std::ostream& ConstTimeAdapter::print( std::ostream& os ) const
{
  return stringToTime( m_time ).print( os );
}

//-----------------------------------------------------------------------------

bool ConstTimeAdapter::operator==( const ITime& rhs ) const
{
  return stringToTime( m_time ) == rhs;
}

//-----------------------------------------------------------------------------

bool ConstTimeAdapter::operator>( const ITime& rhs ) const
{
  return stringToTime( m_time ) > rhs;
}

//-----------------------------------------------------------------------------
