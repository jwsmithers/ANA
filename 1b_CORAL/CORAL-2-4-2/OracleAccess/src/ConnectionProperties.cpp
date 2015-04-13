//#include <iostream>
#include "oci.h"

#include "CoralBase/MessageStream.h"
#include "CoralCommon/Utilities.h"
#include "CoralKernel/Service.h"
#include "RelationalAccess/SessionException.h"

#include "Connection.h"
#include "ConnectionProperties.h"
#include "DomainProperties.h"
#include "OracleErrorHandler.h"
#include "TypeConverter.h"

coral::OracleAccess::ConnectionProperties::ConnectionProperties( const DomainProperties& domainProperties,
                                                                 const std::string& connectionString,
                                                                 Connection& connection ) :
  m_domainProperties( domainProperties ),
  m_domainServiceName( domainProperties.service()->name() ),
  m_connectionString( connectionString ),
  m_typeConverter( new OracleAccess::TypeConverter( m_domainProperties ) ),
  m_ociEnvHandle( 0 ),
  m_ociErrorHandle( 0 ),
  m_ociServerHandle( 0 ),
  m_ociEnvHandleBin(),
  m_ociErrorHandleBin(),
  m_ociServerHandleBin(),
  m_serverVersion( "" ),
  m_majorServerVersion( 0 ),
  m_connection( &connection ),
  //m_connectionMutex(),
  m_mutex(),
  m_nRestarted( 0 )
{
#ifdef ORACLE_CONNECTION_PROPERTIES_DEBUG
  std::cout << "Create ConnectionProperties " << this << std::endl; // debug bug #98736
#endif
}



coral::OracleAccess::ConnectionProperties::~ConnectionProperties()
{
#ifdef ORACLE_CONNECTION_PROPERTIES_DEBUG
  std::cout << "Delete ConnectionProperties " << this << std::endl; // debug bug #98736
#endif
  delete m_typeConverter;
  /// Empty the garbage bin of old OCI server handles (bug #94385)
  for ( std::vector<OCIServer*>::const_iterator
          ociServerHandle = m_ociServerHandleBin.begin();
        ociServerHandle != m_ociServerHandleBin.end();
        ociServerHandle++ )
  {
    OCIHandleFree( *ociServerHandle, OCI_HTYPE_SERVER );
  }
  /// Empty the garbage bin of old OCI error handles (bug #94385)
  for ( std::vector<OCIError*>::const_iterator
          ociErrorHandle = m_ociErrorHandleBin.begin();
        ociErrorHandle != m_ociErrorHandleBin.end();
        ociErrorHandle++ )
  {
    OCIHandleFree( *ociErrorHandle, OCI_HTYPE_ERROR );
  }
  /// Empty the garbage bin of old OCI env handles (bug #94385)
  for ( std::vector<OCIEnv*>::const_iterator
          ociEnvHandle = m_ociEnvHandleBin.begin();
        ociEnvHandle != m_ociEnvHandleBin.end();
        ociEnvHandle++ )
  {
#ifdef ORACLE_CONNECTION_PROPERTIES_DEBUG
    std::cout << "Free OCIEnv " << *ociEnvHandle << std::endl; // debug bug #98736
#endif
    OCIHandleFree( *ociEnvHandle, OCI_HTYPE_ENV );
  }
  /// Finally release also the current handles (bug #98736)
  /// NB This should normally not be needed because the current handles should
  /// have already been moved to the garbage bin by Connection::disconnect
  if ( m_ociServerHandle )
  {
    OCIHandleFree( m_ociServerHandle, OCI_HTYPE_SERVER );
    m_ociServerHandle = 0;
  }
  if ( m_ociErrorHandle )
  {
    OCIHandleFree( m_ociErrorHandle, OCI_HTYPE_ERROR );
    m_ociErrorHandle = 0;
  }
  if ( m_ociEnvHandle )
  {
#ifdef ORACLE_CONNECTION_PROPERTIES_DEBUG
    std::cout << "Free OCIEnv " << m_ociEnvHandle << std::endl; // debug bug #98736
#endif
    OCIHandleFree( m_ociEnvHandle, OCI_HTYPE_ENV );
    m_ociEnvHandle = 0;
  }
}


/*
coral::OracleAccess::Connection&
coral::OracleAccess::ConnectionProperties::connection() const
{
  if ( !m_connection )
    throw coral::SessionException( "Connection has been nullified",
                                   "ConnectionProperties::connection",
                                   domainServiceName() );
  return *m_connection;
}
*///


void
coral::OracleAccess::ConnectionProperties::setHandles( OCIEnv* ociEnvHandle,
                                                       OCIError* ociErrorHandle,
                                                       OCIServer* ociServerHandle )
{
  coral::lock_guard lock( m_mutex );
  // Defer deletion of old OCI handles (bug #94385)
  if ( m_ociServerHandle != 0 )
    m_ociServerHandleBin.push_back( m_ociServerHandle );
  if ( m_ociErrorHandle != 0 )
    m_ociErrorHandleBin.push_back( m_ociErrorHandle );
  if ( m_ociEnvHandle != 0 )
    m_ociEnvHandleBin.push_back( m_ociEnvHandle );
  // Set the new handles
  m_ociEnvHandle = ociEnvHandle;
  m_ociErrorHandle = ociErrorHandle;
  m_ociServerHandle = ociServerHandle;
}


coral::ITypeConverter&
coral::OracleAccess::ConnectionProperties::typeConverter()
{
  coral::lock_guard lock( m_mutex );
  return *m_typeConverter;
}


const coral::ITypeConverter&
coral::OracleAccess::ConnectionProperties::typeConverter() const
{
  coral::lock_guard lock( m_mutex );
  return *m_typeConverter;
}


bool
coral::OracleAccess::ConnectionProperties::restartConnectionWithTimeOut()
{
  int time_counter = 0;
  while ( time_counter++ < 11 )
  {
    coral::MessageStream log( domainServiceName() );
    log << coral::Error << "The connection was lost (ConnectionProperties::restartConnection). Possibly a network glitch or ORA-03113 error. Restart OCI in the connection"; // Would be nice to add connection#id?...
    if ( time_counter > 1 ) log << coral::Error << " (RETRYING after 1 second - Attempt #" << time_counter-1 << ")";
    log << coral::Error << "." << coral::MessageStream::endmsg;
    try
    {
      m_connection->restartConnection();
      m_nRestarted++;
      return true;
    }
    catch( ... ) {} // fix bug #94492
    coral::sleepSeconds( 1 );
  }
  /// FIXME use special exception here
  throw coral::Exception( "Connection to DB server cannot be re-established",
                          "ConnectionProperties::restartConnectionWithTimeOut",
                          domainServiceName() );
}


bool
coral::OracleAccess::ConnectionProperties::wasConnectionLost()
{
  //coral::lock_guard lock( m_mutex );
  text txtServerVersion[1000];
  sword status = OCIServerVersion( m_ociServerHandle, m_ociErrorHandle,
                                   txtServerVersion, 1000, OCI_HTYPE_SERVER );
  if ( status != OCI_SUCCESS )
  {
    // NB: do NOT invalidate all sessions! (otherwise: bug #94931)
    // [This is consistent with RT's comment "separate check and action"!]
    coral::MessageStream log( domainServiceName() );
    log << coral::Error << "The connection was lost (ConnectionProperties::wasConnectionLost). OCIServerVersion fails for this connection." << coral::MessageStream::endmsg;
    return true;
  }
  else
  {
    return false;
  }
}


OCIServer*
coral::OracleAccess::ConnectionProperties::ociServerHandle( bool /*reconnect*/ ) const
{
  coral::lock_guard lock( m_mutex );
  return m_ociServerHandle;
}


unsigned long
coral::OracleAccess::ConnectionProperties::nRestarted()
{
  //coral::lock_guard lock( m_mutex ); // probably needed at some point
  return m_nRestarted;
}


std::string
coral::OracleAccess::ConnectionProperties::serverVersion()
{
  coral::lock_guard lock( m_mutex );
  fetchServerVersion();
  return m_serverVersion;
}


int
coral::OracleAccess::ConnectionProperties::majorServerVersion()
{
  coral::lock_guard lock( m_mutex );
  fetchServerVersion();
  return m_majorServerVersion;
}


void
coral::OracleAccess::ConnectionProperties::fetchServerVersion()
{
  coral::MessageStream log( domainServiceName() );
  if ( m_serverVersion == "11.1.0.0.0" )
    log << coral::Warning << "OCIServerVersion is 11.1.0.0.0. This may be a symptom of Oracle bug 9226591 (bug #102232). Try to retrieve OCIServerVersion again." << coral::MessageStream::endmsg;
  else if ( m_serverVersion != "" && m_majorServerVersion > 0 ) return;
  // Reset and retrieve the server version
  m_serverVersion = "";
  m_majorServerVersion = 0;
  text txtServerVersion[1000];
  sword status = OCIServerVersion( m_ociServerHandle, m_ociErrorHandle, txtServerVersion, 1000, OCI_HTYPE_SERVER );
  if ( status != OCI_SUCCESS )
  {
    log << coral::Error << "Failed to retrieve the server version. Please check if the character set on the DB server is supported (see bug #94547)." << coral::MessageStream::endmsg;
    throw coral::ConnectionException( domainServiceName(), "ConnectionProperties::fetchServerVersion", "Could not retrieve the Oracle server version" );
  }
  std::ostringstream os;
  os << txtServerVersion;
  std::string versionString( os.str() );
  // Trying to find a number of the format "i1.i2.i3.i4.i5"
  std::istringstream is( versionString.c_str() );
  while ( ! is.eof() )
  {
    std::string result;
    is >> result >> std::ws;
    std::istringstream isnumbers( result.c_str() );
    int i1, i2, i3, i4, i5;
    char c = ' ';
    isnumbers >> i1 >> c;
    if ( c != '.' ) continue;
    c = ' ';
    isnumbers >> i2 >> c;
    if ( c != '.' ) continue;
    c = ' ';
    isnumbers >> i3 >> c;
    if ( c != '.' ) continue;
    c = ' ';
    isnumbers >> i4 >> c;
    if ( c != '.' ) continue;
    isnumbers >> i5;
    std::ostringstream os12345;
    os12345 << i1 << c << i2 << c << i3 << c << i4 << c << i5;
    if ( os12345.str() != "" && i1 > 0 )
    {
      m_serverVersion = os12345.str();
      m_majorServerVersion = i1;
      m_typeConverter->reset( m_majorServerVersion );
      //std::cout << "SERVER VERSION " << m_serverVersion << " (" << m_majorServerVersion << ")" << std::endl;
      return;
    }
    break; // and throw
  }
  throw coral::ConnectionException( domainServiceName(), "ConnectionProperties::fetchServerVersion", "Failed to parse the Oracle server version string '"+versionString+"'" );
}
