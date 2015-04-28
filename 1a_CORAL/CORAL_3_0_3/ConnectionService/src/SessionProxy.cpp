// First of all, set/unset CORAL240, CORAL300 and CORAL_HAS_CPP11 macros
#include "CoralBase/VersionInfo.h"

#include "CoralBase/MessageStream.h"
#include "CoralCommon/ISession.h"
#include "RelationalAccess/SessionException.h"

#include "ConnectionPool.h"
#include "ConnectionService.h"
#include "InvalidSessionProxyException.h"
#include "SessionProxy.h"

using namespace coral::ConnectionService;

/// constructor
SessionProperties::SessionProperties( const SessionHandle& session )
  : m_session( session )
{
}

/// destructor
SessionProperties::~SessionProperties()
{
}

/// Returns the name of the RDBMS flavour..
std::string SessionProperties::flavorName() const
{
  return m_session.connection().technologyName();
}

/// Returns the version of the database server.
std::string SessionProperties::serverVersion() const
{
  return m_session.connection().serverVersion();
}

/// constructor
RemoteSessionProperties::RemoteSessionProperties( const SessionHandle& session )
  : m_session( session )
{
}

/// destructor
RemoteSessionProperties::~RemoteSessionProperties()
{
}

/// Returns the name of the RDBMS flavour..
std::string RemoteSessionProperties::flavorName() const
{
  return m_session.physicalSession()->remoteTechnologyName();
}

/// Returns the version of the database server.
std::string RemoteSessionProperties::serverVersion() const
{
  return m_session.physicalSession()->remoteServerVersion();
}

SessionProxy::SessionProxy( const std::string& connectionString,
                            coral::AccessMode accessMode,
                            ConnectionService* connectionService ) :
  m_connectionString( connectionString ),
  m_role(""),
  m_accessMode( accessMode ),
  m_connectionService( connectionService ),
  m_session( connectionService->name() ),
  m_properties( m_session ),
  m_remoteProperties( m_session )
{
}

SessionProxy::SessionProxy( const std::string& connectionString,
                            const std::string& role,
                            coral::AccessMode accessMode,
                            ConnectionService* connectionService ) :
  m_connectionString( connectionString ),
  m_role( role ),
  m_accessMode( accessMode ),
  m_connectionService( connectionService ),
  m_session( connectionService->name() ),
  m_properties( m_session ),
  m_remoteProperties( m_session )
{
}

SessionProxy::~SessionProxy()
{
  m_session.close();
  if(m_connectionService)
  {
    m_connectionService->connectionPool().releaseConnection( m_session.connection() );
    m_connectionService->unRegisterSession( this );
  }
}

void SessionProxy::open( const coral::ICertificateData *cert )
{
  if( ! m_connectionService ) throw InvalidSessionProxyException( m_connectionString, "SessionProxy::open" );
  m_session = m_connectionService->connectionPool().getValidSession( m_connectionString, m_role, m_accessMode, cert );
}

coral::ISessionProperties&
SessionProxy::properties()
{
  return m_properties;
}

/// Returns the properties of the remote session.
const coral::ISessionProperties&
SessionProxy::remoteProperties()
{
  return m_remoteProperties;
}

coral::ISchema&
SessionProxy::nominalSchema()
{
  return m_session.physicalSession()->nominalSchema();
}

coral::ISchema&
SessionProxy::schema( const std::string& schemaName )
{
  return m_session.physicalSession()->schema( schemaName );
}

bool
SessionProxy::isConnectionShared() const
{
  if ( !m_session.isValid() )
    throw InvalidSessionProxyException( m_connectionString, "SessionProxy::isConnectionShared" );
  return m_session.connection().numberOfSessions()>1;
}

coral::ITransaction&
SessionProxy::transaction()
{
  return m_session.transactionProxy();
}

coral::ITypeConverter&
SessionProxy::typeConverter()
{
  return m_session.connection().typeConverter();
}

#ifdef CORAL300MG
coral::IMonitoringController&
SessionProxy:: monitoringController()
{
  throw coral::Exception( "This method is not yet implemented",
                          "SessionProxy:: monitoringController()",
                          "coral::ConnectionService" );
}
#endif

coral::ISession*
SessionProxy::session()
{
  return m_session.physicalSession();
}

void
SessionProxy::invalidate()
{
  m_connectionService = 0;
}
