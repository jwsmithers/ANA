#include <cstdlib>
#include <map>
#include <sstream>

#include "CoralBase/MessageStream.h"
#include "RelationalAccess/AuthenticationServiceException.h"
#include "CoralCommon/IConnection.h"
#include "CoralCommon/ISession.h"
#include "RelationalAccess/SessionException.h"
#include "SessionHandle.h"
#include "UidGenerator.h"

#ifdef _WIN32
#pragma warning ( disable : 4355 ) // 'this' used in base member initializer list
#endif

/// constructor
coral::ConnectionService::SessionHandle::SessionHandle( const std::string& connectionServiceName ) :
  m_connectionServiceName( connectionServiceName ),
  m_session(),
  m_info( new SessionSharedInfo( connectionServiceName ) ),
  m_connection( connectionServiceName ),
  m_transactionProxy( *this )
{
  // Assign a tmp ID: these are tmp sessions not associated to any connection
  m_info->m_sessionId = UidGenerator::generateSessionUid( "" );
}

/// constructor
coral::ConnectionService::SessionHandle::SessionHandle( const std::string& connectionServiceName,
                                                        const ConnectionHandle& connection ) :
  m_connectionServiceName( connectionServiceName ),
  m_session(),
  m_info( new SessionSharedInfo( connectionServiceName ) ),
  m_connection(connection),
  m_transactionProxy( *this )
{
  // Assign a real session ID: these are sessions associated to a connection
  m_info->m_sessionId = UidGenerator::generateSessionUid( connection.connectionId() );
}

/// destructor
coral::ConnectionService::SessionHandle::~SessionHandle()
{
}

coral::ConnectionService::SessionHandle::SessionHandle( const SessionHandle& rhs ) :
  m_connectionServiceName( rhs.m_connectionServiceName ),
  m_session(rhs.m_session),
  m_info(rhs.m_info),
  m_connection(rhs.m_connection),
  m_transactionProxy( *this )
{
}

coral::ConnectionService::SessionHandle&
coral::ConnectionService::SessionHandle::operator=( const SessionHandle& rhs )
{
  m_connectionServiceName = rhs.m_connectionServiceName;
  m_session = rhs.m_session;
  m_info = rhs.m_info;
  m_connection = rhs.m_connection;
  return *this;
}

/// returns
coral::ConnectionService::SessionHandle::operator bool() const
{
  return m_session.get()!=0;
}

/// initialize the session
bool
coral::ConnectionService::SessionHandle::open( const std::string& schemaName,
                                               const std::string& userName,
                                               const std::string& password,
                                               coral::AccessMode accessMode )
{
  coral::MessageStream log( m_connectionServiceName );
  //log << coral::Info << "SessionHandle for sessionID=" << m_info->m_sessionId << " on connectionID=" << m_connection.connectionId() << " will be opened" << coral::MessageStream::endmsg;
  coral::ISession* sess = m_connection.newSession(schemaName,userName,password,accessMode,m_info->m_sessionId);
  if(sess) {
    m_session = boost::shared_ptr<ISession>(sess);
    m_info->m_open = true;
    //log << coral::Info << "SessionHandle for sessionID=" << m_info->m_sessionId << " on connectionID=" << m_connection.connectionId() << " has been opened" << coral::MessageStream::endmsg;
  }
  return m_info->m_open;
}

void
coral::ConnectionService::SessionHandle::close()
{
  coral::MessageStream log( m_connectionServiceName );
  if(m_session) {
    if(m_info->m_open) {
      log << coral::Info << "User session with sessionID=" << m_info->m_sessionId << " will be ended on connectionID="<< m_connection.connectionId() << coral::MessageStream::endmsg; // Matches printout for startUserSession in ConnectionHandle.cpp
      //log << coral::Info << "SessionHandle for sessionID=" << m_info->m_sessionId << " on connectionID=" << m_connection.connectionId() << " will be closed" << coral::MessageStream::endmsg;
      m_session->endUserSession();
      //log << coral::Info << "SessionHandle for sessionID=" << m_info->m_sessionId << " on connectionID=" << m_connection.connectionId() << " has been closed" << coral::MessageStream::endmsg;
      m_info->m_open = false;
      m_session.reset();
    }
  }
  else
  {
    log << coral::Info << "SessionHandle for sessionID=" << m_info->m_sessionId << " was not open: no need to close it" << coral::MessageStream::endmsg;
  }
}

bool
coral::ConnectionService::SessionHandle::isOpen() const
{
  bool open = false;
  if(m_session && m_info->m_open) open = true;
  return open;
}

bool
coral::ConnectionService::SessionHandle::isValid() const
{
  bool valid = false;
  if(isOpen() && m_connection.isValid()) valid = true;
  return valid;
}

coral::ISession*
coral::ConnectionService::SessionHandle::physicalSession() const
{
  return m_session.get();
}

coral::ConnectionService::ConnectionHandle&
coral::ConnectionService::SessionHandle::connection()
{
  return m_connection;
}

const coral::ConnectionService::ConnectionHandle&
coral::ConnectionService::SessionHandle::connection() const
{
  return m_connection;
}
