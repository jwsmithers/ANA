#include <cstring> // fix bug #58581
#include <iostream>
#include <sstream>
#include "oci.h"

#include "CoralBase/boost_datetime_headers.h"
#include "CoralBase/MessageStream.h"
#include "CoralCommon/MonitoringEventDescription.h"
#include "CoralCommon/Utilities.h"
#include "CoralKernel/Context.h"
#include "CoralKernel/Service.h"
#include "RelationalAccess/IMonitoringService.h"
#include "RelationalAccess/SessionException.h"

#include "Connection.h"
#include "ConnectionProperties.h"
#include "DomainProperties.h"
#include "OracleErrorHandler.h"
#include "Session.h"

coral::OracleAccess::Connection::Connection( const coral::OracleAccess::DomainProperties& domainProperties,
                                             const std::string& connectionString ) :
  m_properties(), // fix Windows warning C4355 ('this' in initializer list)
  m_mutex()
{
#ifdef ORACLE_CONNECTION_PROPERTIES_DEBUG
  std::cout << std::endl; // Improve formatting (eg for tests)
  std::cout << "Create Connection " << this << std::endl; // debug bug #98736
#endif
  m_properties.reset( new ConnectionProperties( domainProperties, connectionString, *this ) ); // fix Windows warning C4355 ('this' in initializer list)
}


coral::OracleAccess::Connection::~Connection()
{
#ifdef ORACLE_CONNECTION_PROPERTIES_DEBUG
  std::cout << "Delete Connection " << this << std::endl; // debug bug #98736
#endif
  if ( this->isConnected() ) this->disconnect();
  m_properties->nullifyConnection(); // see bug #79883 and bug #73834...
  m_properties.reset();
}


coral::ISession*
coral::OracleAccess::Connection::newSession( const std::string& schemaName,
                                             coral::AccessMode mode ) const
{
  if ( ! const_cast<coral::OracleAccess::Connection*>( this )->isConnected() )
    throw coral::ConnectionNotActiveException( m_properties->domainServiceName(), "IConnection::newSession" );

  coral::lock_guard lock( m_mutex );
  return new coral::OracleAccess::Session( *( static_cast<coral::IDevConnection*>( const_cast<coral::OracleAccess::Connection*>( this ) ) ),
                                           m_properties,
                                           schemaName,
                                           mode );
}


void
coral::OracleAccess::Connection::connect()
{
  if ( this->isConnected() )
  {
    coral::MessageStream log( m_properties->domainServiceName() );
    log << coral::Warning << "A connection is already present for \""
        << m_properties->connectionString() << "\"" << coral::MessageStream::endmsg;
    return;
  }

  // Allocate the OCI handles and begin the OCI connection
  coral::lock_guard lock( m_mutex );
  attachOciConnection();

  //  // Record the beginning of the connection using the Monitoring service
  //  coral::IHandle<coral::monitor::IMonitoringService> monitoringService = coral::Context::instance().query<coral::monitor::IMonitoringService>();
  //
  //  if ( monitoringService.isValid() )
  //  {
  //    monitoringService->setLevel( "oracle://" + m_properties->connectionString(), coral::monitor::Default );
  //    monitoringService->enable( "oracle://" + m_properties->connectionString() );
  //    monitoringService->record( "oracle://" + m_properties->connectionString(), coral::monitor::Session, coral::monitor::Info, monitoringEventDescription.connectionBegin() );
  //  }

  // Test bug #58522 (aka bug #65709, bug #75596)
  // Most likely ORA-24327 happens if the glitch is anywhere between
  // OCIServerAttach (init Connection) and OCISessionBegin (init Session).
  if ( getenv( "CORAL_ORA_TEST_ORA24327_SLEEP10S" ) )
  {
    std::string time1 = boost::posix_time::to_simple_string( boost::posix_time::microsec_clock::local_time() ).substr(12);
    std::cout << "__Connection::connect() @"
              << time1 << " sleep 10s (test ORA-24327)" << std::endl;
    coral::sleepSeconds(10);
    std::string time2 = boost::posix_time::to_simple_string( boost::posix_time::microsec_clock::local_time() ).substr(12);
    std::cout << "__Connection::connect() @"
              << time2 << " slept 10s (test ORA-24327)" << std::endl;
  }
}


void
coral::OracleAccess::Connection::attachOciConnection( bool reconnect )
{
  coral::MessageStream log( m_properties->domainServiceName() );

  // Create the environment
  ub4 mode = OCI_OBJECT | OCI_THREADED; // 0x00000002 | 0x00000001
  static bool first = true;
  if ( first )
  {
    first = false;
    if ( getenv( "CORAL_ORA_NO_OCI_THREADED" ) )
    {
      mode = OCI_OBJECT; // 0x00000002
      log << coral::Warning
          << "Env CORAL_ORA_NO_OCI_THREADED was specified: "
          << "OCIEnvCreate will use OCI_OBJECT "
          << "instead of OCI_OBJECT | OCI_THREADED" << coral::MessageStream::endmsg;
    }
    else if ( getenv( "CORAL_ORA_OCI_NO_MUTEX" )  )
    {
      mode = OCI_OBJECT | OCI_THREADED | OCI_NO_MUTEX; // 0x00000002 | 0x00000001 | 0x00000080
      log << coral::Warning
          << "Env CORAL_ORA_OCI_NO_MUTEX was specified: "
          << "OCIEnvCreate will use OCI_OBJECT | OCI_THREADED | OCI_NO_MUTEX "
          << "instead of OCI_OBJECT | OCI_THREADED" << coral::MessageStream::endmsg;
    }
  }
  OCIEnv* ociEnvHandle = 0;
  static unsigned int ociDebug = 0;
  if ( !reconnect && ociDebug < 2 &&
       !getenv( "CORAL_ORA_OCI_DEBUG_OCIENVCREATE2" ) &&
       getenv( "CORAL_ORA_OCI_DEBUG_OCIENVCREATE" ) )
  {
#ifdef linux
    std::stringstream cmd;
    cmd << "strace -p " << getpid() << " 2>&1 &";
    std::cout << "***** OracleAccess CORAL_ORA_OCI_DEBUG_OCIENVCREATE is set  *****" << std::endl;
    if ( getenv( "LD_LIBRARY_PATH" ) ) std::cout << "LD_LIBRARY_PATH = " << std::string( getenv( "LD_LIBRARY_PATH" ) ) << std::endl;
    std::cout << "***** OracleAccess DEBUG: strace OCIEnvCreate calls (START) *****" << std::endl;
    system( cmd.str().c_str() );
    // Sleep 1 second (else OCIEnvCreate may be executed before strace is attached)
    coral::sleepSeconds( 1 );
#endif
  }
  sword status = OCIEnvCreate( &ociEnvHandle, mode, 0,0,0,0,0,0 );
#ifdef ORACLE_CONNECTION_PROPERTIES_DEBUG
  std::cout << "OCIEnvCreate returned " << ociEnvHandle << std::endl; // debug bug #98736
#endif
  if ( !reconnect &&
       ( ( ociDebug < 1 && getenv( "CORAL_ORA_OCI_DEBUG_OCIENVCREATE2" ) ) ||
         ( ociDebug < 2 && getenv( "CORAL_ORA_OCI_DEBUG_OCIENVCREATE" ) ) ) )
  {
    ociDebug++;
#ifdef linux
    std::stringstream cmd;
    //cmd << "killall strace";
    cmd << "kill `ps -C strace -f | grep 'strace -p " << getpid() << "' | awk '{print $2}'` &> /dev/null";
    system( cmd.str().c_str() );
    std::cout << "***** OracleAccess DEBUG: strace OCIEnvCreate calls (END) *****" << std::endl;
    if ( getenv( "LD_LIBRARY_PATH" ) ) std::cout << "LD_LIBRARY_PATH = " << std::string( getenv( "LD_LIBRARY_PATH" ) ) << std::endl;
#endif
  }

  // First failure - try again (workaround for bug #31554)
  if ( status != OCI_SUCCESS )
  {
    log << coral::Error
        << "Could not allocate an OCI environment handle: status=" << status
        << ", handle=" << ociEnvHandle << coral::MessageStream::endmsg;
    if ( status == OCI_SUCCESS_WITH_INFO || status == OCI_ERROR )
    {
      if ( status == OCI_SUCCESS_WITH_INFO )
        log << coral::Error << "OCIEnvCreate status=OCI_SUCCESS_WITH_INFO" << coral::MessageStream::endmsg;
      else if ( status == OCI_ERROR )
        log << coral::Error << "OCIEnvCreate status=OCI_ERROR" << coral::MessageStream::endmsg;
    }
    log << coral::Error << "Try a second time" << coral::MessageStream::endmsg;
    ociEnvHandle = 0;
    status = OCIEnvCreate( &ociEnvHandle, mode, 0,0,0,0,0,0 );
#ifdef ORACLE_CONNECTION_PROPERTIES_DEBUG
    std::cout << "OCIEnvCreate returned " << ociEnvHandle << std::endl; // debug bug #98736
#endif
  }

  // Second failure - give up
  if ( status != OCI_SUCCESS )
  {
    log << coral::Error
        << "Could not allocate an OCI environment handle: status=" << status
        << ", handle=" << ociEnvHandle << coral::MessageStream::endmsg;
    if ( status == OCI_SUCCESS_WITH_INFO || status == OCI_ERROR )
    {
      if ( status == OCI_SUCCESS_WITH_INFO )
        log << coral::Error << "OCIEnvCreate status=OCI_SUCCESS_WITH_INFO" << coral::MessageStream::endmsg;
      else if ( status == OCI_ERROR )
        log << coral::Error << "OCIEnvCreate status=OCI_ERROR" << coral::MessageStream::endmsg;
    }
    throw coral::ServerException( m_properties->domainServiceName(), "Could not allocate an OCI environment handle" );
  }

  // Creating the error handle
  void* temporaryPointer = 0;
  status = OCIHandleAlloc( ociEnvHandle, &temporaryPointer,
                           OCI_HTYPE_ERROR, 0, 0 );
  if ( status != OCI_SUCCESS )
  {
#ifdef ORACLE_CONNECTION_PROPERTIES_DEBUG
    std::cout << "Free OCIEnv " << ociEnvHandle << std::endl; // debug bug #98736
#endif
    OCIHandleFree( ociEnvHandle, OCI_HTYPE_ENV );
    throw coral::ServerException( m_properties->domainServiceName(),
                                  "Could not allocate an OCI error handle" );
  }
  OCIError* ociErrorHandle = static_cast< OCIError* >( temporaryPointer );
  //std::cout << "OCIError created " << this << std::endl; // bug #83601

  // Creating a server handle
  temporaryPointer = 0;
  status = OCIHandleAlloc( ociEnvHandle, &temporaryPointer,
                           OCI_HTYPE_SERVER, 0, 0 );
  if ( status != OCI_SUCCESS )
  {
    OCIHandleFree( ociErrorHandle, OCI_HTYPE_ERROR );
#ifdef ORACLE_CONNECTION_PROPERTIES_DEBUG
    std::cout << "Free OCIEnv " << ociEnvHandle << std::endl; // debug bug #98736
#endif
    OCIHandleFree( ociEnvHandle, OCI_HTYPE_ENV );
    throw coral::ServerException( m_properties->domainServiceName(),
                                  "Could not allocate an OCI server handle" );
  }
  OCIServer* ociServerHandle = static_cast< OCIServer* >( temporaryPointer );

  // Creating an error handler to be used in the subsequent calls.
  coral::OracleAccess::OracleErrorHandler errorHandler( ociErrorHandle );

  // Attaching the server
  const std::string database = m_properties->connectionString();
  status = OCIServerAttach( ociServerHandle, ociErrorHandle,
                            reinterpret_cast<const text *>( database.c_str() ),
                            ::strlen( database.c_str() ),
                            OCI_DEFAULT );
  if ( status != OCI_SUCCESS )
  {
    errorHandler.handleCase( status, "attaching a server '"+database+"'" );
    if ( errorHandler.isError() )
    {
      log << coral::Error << errorHandler.message() << coral::MessageStream::endmsg;
      OCIHandleFree( ociServerHandle, OCI_HTYPE_SERVER );
      OCIHandleFree( ociErrorHandle, OCI_HTYPE_ERROR );
#ifdef ORACLE_CONNECTION_PROPERTIES_DEBUG
      std::cout << "Free OCIEnv " << ociEnvHandle << std::endl; // debug bug #98736
#endif
      OCIHandleFree( ociEnvHandle, OCI_HTYPE_ENV );
      const sb4 lastErrorCode = errorHandler.lastErrorCode();
      if ( lastErrorCode == 12154 || // TNS: could not resolve connect identifier
           lastErrorCode == 12505 || // TNS: listener does not know SID in connect descriptor
           lastErrorCode == 12538 || // TNS: no such protocol adapter
           lastErrorCode == 12545 ) // connect failed because target host or object does not exist
      {
        // Wrong db specification
        throw coral::DatabaseNotAccessibleException( m_properties->domainServiceName(), "IConnection::connect" );
      }
      if ( true )
      {
        // Retry in these cases
        throw coral::ConnectionException( m_properties->domainServiceName(), "IConnection::connect" );
      }
      else
      {
        // Do not retry
        throw coral::ServerException( m_properties->domainServiceName() );
      }
    }
    else
    {
      log << coral::Warning << errorHandler.message() << coral::MessageStream::endmsg;
    }
  }
  log << coral::Verbose << "New connection started with OCIServerAttach"
      << " (OCIServer*=" << ociServerHandle << ")"
      << coral::MessageStream::endmsg;

  // Set handles and retrieve the server version
  m_properties->setHandles( ociEnvHandle, ociErrorHandle, ociServerHandle );
  try
  {
    m_properties->serverVersion();
  }
  catch( ... )
  {
    m_properties->setHandles( 0, 0, 0 ); // eventually deletes OCI handles
    throw;
  }
}


bool
coral::OracleAccess::Connection::isConnected( bool probePhysicalConnection )
{
  coral::lock_guard lock( m_mutex );
  bool logicalConnection = ( m_properties->ociEnvHandle() != 0 );
  if ( ! logicalConnection ) return false;
  if ( probePhysicalConnection )
  {
    text txtServerVersion[1000];
    sword status = OCIServerVersion( m_properties->ociServerHandle(),
                                     m_properties->ociErrorHandle(),
                                     txtServerVersion, 1000, OCI_HTYPE_SERVER );
    if ( status != OCI_SUCCESS )
    {
      // NB: do NOT invalidate all sessions! (fix bug #94931)
      logicalConnection = false;
    }
  }
  return logicalConnection;
}


void
coral::OracleAccess::Connection::disconnect()
{
  if ( ! this->isConnected() ) return;
  coral::lock_guard lock( m_mutex );

  // Clean up all the active sessions !!!
  this->invalidateAllSessions();

  // Debug
  {
    coral::MessageStream log( m_properties->domainServiceName() );
    log << coral::Verbose << "End connection with OCIServerDetach"
        << " (OCIServer*=" << m_properties->ociServerHandle() << ")"
        << coral::MessageStream::endmsg;
  }

  // Detach the connection and defer deletion of OCI handles (bug #94385)
  // NB Remove old workaround to avoid double deletion if lostConnection
  // (this had been introduced in 2007 between versions 1.9 and 1.10...)
  OCIServerDetach( m_properties->ociServerHandle(),
                   m_properties->ociErrorHandle(),
                   OCI_DEFAULT );
  m_properties->setHandles( 0, 0, 0 );

  //  // Record the ending of the connection
  //  coral::IHandle<coral::monitor::IMonitoringService> monitoringService = coral::Context::instance().query<coral::monitor::IMonitoringService>();
  //
  //  if ( monitoringService.isValid() )
  //  {
  //    monitoringService->record( "oracle://" + m_properties->connectionString(), coral::monitor::Session, coral::monitor::Info, monitoringEventDescription.connectionEnd() );
  //    monitoringService->disable( "oracle://" + m_properties->connectionString() );
  //
}


std::string
coral::OracleAccess::Connection::serverVersion() const
{
  if ( ! const_cast<coral::OracleAccess::Connection*>( this )->isConnected() )
    throw coral::ConnectionNotActiveException( m_properties->domainServiceName(), "IConnection::serverVersion" );
  coral::lock_guard lock( m_mutex );
  return m_properties->serverVersion();
}


coral::ITypeConverter&
coral::OracleAccess::Connection::typeConverter()
{
  if ( ! this->isConnected() )
    throw coral::ConnectionNotActiveException( m_properties->domainServiceName(), "Connection::typeConverter" );
  coral::lock_guard lock( m_mutex );
  return m_properties->typeConverter();
}


bool
coral::OracleAccess::Connection::restartConnection()
{
  // Mark old OCI handles for garbage collection in ConnectionProperties dtor
  // (No need to try and reuse same error/env handles for several connections)
  m_properties->setHandles( 0, 0, 0 );
  // Allocate the OCI handles and begin the OCI connection
  bool reconnect = true;
  this->attachOciConnection( reconnect );
  // Reconnection was successful (else attachOciConnection would have thrown)
  return true; // FIXME: this method should become a void
}
