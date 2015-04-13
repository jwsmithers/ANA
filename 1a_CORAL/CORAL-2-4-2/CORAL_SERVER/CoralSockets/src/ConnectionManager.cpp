// $Id: ConnectionManager.cpp,v 1.3.2.2 2012-06-07 12:19:55 avalassi Exp $

// Include files
#include "CoralSockets/GenericSocketException.h"

// Local include files
#include "ConnectionManager.h"

// Logger
#define LOGGER_NAME "CoralSockets::ConnectionManager"
#include "logger.h"

// Debug
#undef DEBUG
#define DEBUG(out)

// Namespace
using namespace coral::CoralSockets;

//-----------------------------------------------------------------------------

ConnectionManager::ConnectionManager()
{
  // Initialize the random generator
  ::srand( ::time(0) );
}

//-----------------------------------------------------------------------------

ConnectionManager::~ConnectionManager()
{
}

//-----------------------------------------------------------------------------

ConToken ConnectionManager::addContext( SocketContextSPtr context )
{
  coral::lock_guard lock( m_connectionMapMutex );

  ConToken token;
  do {
    token = createToken();
  } while ( m_connectionMap.find( token ) != m_connectionMap.end() );

  m_connectionMap[ token ] = context;
  return token;
}

//-----------------------------------------------------------------------------

SocketContextSPtr ConnectionManager::getContext( ConToken token )
{
  coral::lock_guard lock( m_connectionMapMutex );

  if ( m_connectionMap.find( token ) == m_connectionMap.end() )
    throw GenericSocketException("did not find token in map!",
                                 "ConnectionManager::getConnection()");

  SocketContextSPtr ret( m_connectionMap[ token ] );
  m_connectionMap.erase( token );
  return ret;
}

//-----------------------------------------------------------------------------

ConToken ConnectionManager::createToken()
{
  // Maximum of uin32_t
  return ::rand();
}
