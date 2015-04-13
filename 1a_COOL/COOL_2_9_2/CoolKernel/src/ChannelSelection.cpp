// $Id: ChannelSelection.cpp,v 1.7 2009-12-17 18:50:43 avalassi Exp $

// Include files
#include "CoolKernel/ChannelSelection.h"
#include "CoolKernel/Exception.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

ChannelSelection::ChannelRange::ChannelRange( const ChannelId& firstChannel,
                                              const ChannelId& lastChannel )
  : m_firstChannel( firstChannel )
  , m_lastChannel( lastChannel )
{
  if ( firstChannel > lastChannel )
    throw InvalidChannelRange( firstChannel, lastChannel, "ChannelSelection" );
}

//-----------------------------------------------------------------------------

ChannelId ChannelSelection::ChannelRange::firstChannel() const
{
  return m_firstChannel;
}

//-----------------------------------------------------------------------------

ChannelId ChannelSelection::ChannelRange::lastChannel() const
{
  return m_lastChannel;
}

//-----------------------------------------------------------------------------

bool ChannelSelection::ChannelRange::inRange( const ChannelId& channel ) const
{
  return firstChannel() <= channel && channel <= lastChannel();
}

//-----------------------------------------------------------------------------

ChannelSelection::ChannelSelection( const Order& order )
  : m_isNumeric( true )
  , m_allChannels( true )
  , m_order( order )
{
#ifndef WIN32
  m_ranges.push_back( ChannelRange( std::numeric_limits<ChannelId>::min(),
                                    std::numeric_limits<ChannelId>::max() ) );
#else
  // Port to VC9 on Windows
  m_ranges.push_back( ChannelRange( UInt32Min, UInt32Max ) );
#endif
}

//-----------------------------------------------------------------------------

ChannelSelection::ChannelSelection( const ChannelId& channel )
  : m_isNumeric( true )
  , m_allChannels( false )
  , m_order( channelBeforeSince )
{
  m_ranges.push_back( ChannelRange( channel, channel ) );
}

//-----------------------------------------------------------------------------

ChannelSelection::ChannelSelection( const ChannelId& firstChannel,
                                    const ChannelId& lastChannel,
                                    const Order& order )
  : m_isNumeric( true )
  , m_allChannels( false )
  , m_order( order )
{
  if ( firstChannel > lastChannel )
    throw InvalidChannelRange( firstChannel, lastChannel, "ChannelSelection" );

  m_ranges.push_back( ChannelRange( firstChannel, lastChannel ) );
}

//-----------------------------------------------------------------------------

ChannelSelection::ChannelSelection( const std::string& channelName,
                                    const Order& order )
  : m_isNumeric( false )
  , m_allChannels( false )
  , m_channelName( channelName )
  , m_order( order )
{
}

//-----------------------------------------------------------------------------

bool ChannelSelection::allChannels() const
{
  return m_allChannels;
}

//-----------------------------------------------------------------------------

ChannelId ChannelSelection::firstChannel() const
{
  if ( ! isNumeric() )
    throw Exception( "Numeric method called for "
                     "non-numeric ChannelSelection",
                     "ChannelSelection" );

  return m_ranges[0].firstChannel();
}

//-----------------------------------------------------------------------------

ChannelId ChannelSelection::lastChannel() const
{
  if ( ! isNumeric() )
    throw Exception( "Numeric method called for "
                     "non-numeric ChannelSelection",
                     "ChannelSelection" );

  return m_ranges[m_ranges.size()-1].lastChannel();
}

//-----------------------------------------------------------------------------

ChannelSelection::Order ChannelSelection::order() const
{
  return m_order;
}

//-----------------------------------------------------------------------------

const ChannelSelection
ChannelSelection::all( const ChannelSelection::Order& order )
{
  return ChannelSelection( order );
}

//-----------------------------------------------------------------------------

bool ChannelSelection::inSelection( const ChannelId& channel ) const
{
  if ( ! isNumeric() )
    throw Exception( "Numeric method called for "
                     "non-numeric ChannelSelection",
                     "ChannelSelection" );

  for ( std::vector<ChannelRange>::const_iterator
          i = m_ranges.begin(); i != m_ranges.end(); ++i )
  {
    if ( i->inRange( channel ) ) return true;
  }
  return false;
}

//-----------------------------------------------------------------------------

/// Returns true if the given channelName is in the selection
bool ChannelSelection::inSelection( const std::string& channelName ) const
{
  if ( isNumeric() )
    throw Exception( "Non-numeric method called for "
                     "numeric ChannelSelection",
                     "ChannelSelection" );

  return channelName == m_channelName;
}

//-----------------------------------------------------------------------------

bool ChannelSelection::isContiguous() const
{
  if ( ! isNumeric() )
    throw Exception( "Numeric method called for "
                     "non-numeric ChannelSelection",
                     "ChannelSelection" );

  if ( m_ranges.size() == 0 ) return true;

  for ( unsigned int i = 1; i < m_ranges.size(); ++i )
  {
    ChannelId prev = m_ranges[i-1].lastChannel();
    // specifically avoid +1 to be independant of ChannelId granularity
    ++prev;
    if ( prev < m_ranges[i].firstChannel() ) return false;
  }
  return true;
}

//-----------------------------------------------------------------------------

void ChannelSelection::addRange( const ChannelId& firstChannel,
                                 const ChannelId& lastChannel )
{
  if ( ! isNumeric() )
    throw Exception( "Numeric method called for "
                     "non-numeric ChannelSelection",
                     "ChannelSelection" );

  if ( firstChannel > lastChannel )
    throw InvalidChannelRange( firstChannel, lastChannel,
                               "ChannelSelection" );

  if ( lastChannel < this->firstChannel() )
  {
    m_ranges.insert( m_ranges.begin(),
                     ChannelRange( firstChannel, lastChannel ) );
  }
  else if ( this->lastChannel() < firstChannel )
  {
    m_ranges.push_back( ChannelRange( firstChannel, lastChannel ) );
  }
  else
  {
    std::stringstream s;
    s << "Cannot add range [" << firstChannel << "," << lastChannel
      << "], because it overlaps with selection";
    throw Exception( s.str(), "ChannelSelection" );
  }
}

//-----------------------------------------------------------------------------

void ChannelSelection::addChannel( const ChannelId& channel )
{
  if ( ! isNumeric() )
    throw Exception( "Numeric method called for "
                     "non-numeric ChannelSelection",
                     "ChannelSelection" );

  addRange( channel, channel );
}

//-----------------------------------------------------------------------------

bool ChannelSelection::isNumeric() const
{
  return m_isNumeric;
}

//-----------------------------------------------------------------------------

const std::string& ChannelSelection::channelName() const
{
  return m_channelName;
}

//-----------------------------------------------------------------------------

std::vector<ChannelSelection::ChannelRange>::const_iterator
ChannelSelection::begin() const
{
  return m_ranges.begin();
}

//-----------------------------------------------------------------------------

std::vector<ChannelSelection::ChannelRange>::const_iterator
ChannelSelection::end() const
{
  return m_ranges.end();
}

//-----------------------------------------------------------------------------

unsigned int ChannelSelection::rangeCount() const
{
  return m_ranges.size();
}

//-----------------------------------------------------------------------------
