// First of all, set/unset CORAL240, CORAL300 and CORAL_HAS_CPP11 macros
#include "CoralBase/VersionInfo.h"

#include "Session.h"
#include "Connection.h"
#include "SessionProperties.h"
#include "MonitorController.h"
#include "ErrorHandler.h"
#include "Transaction.h"
#include "Schema.h"
#include "Statement.h"

#include "CoralCommon/URIParser.h"
#include "CoralCommon/MonitoringEventDescription.h"

#include "RelationalAccess/SessionException.h"
#include "RelationalAccess/SchemaException.h"
#include "RelationalAccess/IAuthenticationService.h"
#include "RelationalAccess/IAuthenticationCredentials.h"
#include "RelationalAccess/IMonitoringService.h"

#include "CoralBase/AttributeList.h"
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeSpecification.h"
#include "CoralBase/MessageStream.h"

#include "CoralKernel/Service.h"
#include "CoralKernel/Context.h"

#include "frontier_client/FrontierException.hpp"

#include <locale>

coral::FrontierAccess::Session::Session( coral::IDevConnection& dconnection,
                                         const std::string& domainServiceName,
                                         const std::string& connectionString,
                                         frontier::Connection& fconnection,
                                         coral::mutex& flock,
                                         const std::string& schemaName,
                                         const coral::ITypeConverter& converter )
  : coral::IDevSession( dconnection )
  , m_sessionProperties( new SessionProperties( domainServiceName, connectionString, fconnection, flock, schemaName, const_cast<coral::ITypeConverter&>(converter), *this ) )
  , m_connected( false )
  , m_monitorController( new MonitorController( m_sessionProperties ) )
  , m_schema( 0 )
  , m_transaction( 0 )
  , m_schemas()
{
#ifdef FRONTIER_CONNECTION_PROPERTIES_DEBUG
  std::cout << std::endl; // Improve formatting (eg for tests)
  std::cout << "Create Session " << this << std::endl;
#endif
  // Retrieve and return the Oracle server version (bug #103685)
  coral::FrontierAccess::Connection* conn = dynamic_cast<coral::FrontierAccess::Connection*>( &dconnection );
  if ( conn && conn->serverVersion() == "UNKNOWN" )
  {
    // Retrieve and return the Oracle server version (bug #103685)
    coral::FrontierAccess::Statement statement( m_sessionProperties, "SELECT VERSION FROM PRODUCT_COMPONENT_VERSION WHERE PRODUCT LIKE 'Oracle Database%'" );
    if( ! statement.execute( coral::AttributeList() ) )
      throw coral::SessionException( m_sessionProperties->domainServiceName(), "Could not determine Oracle server version (query failed)", "coral::FrontierAccess::Session::Session" );
    coral::AttributeList outBuffer;
    outBuffer.extend<std::string>( "VERSION" );
    statement.defineOutput( outBuffer );
    statement.fetchNext();
    std::string serverVersion = outBuffer[0].data<std::string>();
    if ( serverVersion.empty() )
      throw coral::SessionException( m_sessionProperties->domainServiceName(), "Could not determine Oracle server version (null value returned)", "coral::FrontierAccess::Session::Session" );
    if ( serverVersion == "UNKNOWN" )
      throw coral::SessionException( m_sessionProperties->domainServiceName(), "Could not determine Oracle server version ('UNKNOWN' returned)", "coral::FrontierAccess::Session::Session" );
    conn->m_serverVersion = serverVersion; // quick and dirty "friend" hack
  }
}

coral::FrontierAccess::Session::~Session()
{
#ifdef FRONTIER_CONNECTION_PROPERTIES_DEBUG
  std::cout << "Delete Session " << this << std::endl;
#endif
  m_sessionProperties->nullifySession(); // fix bug #73834 (bug #80024)
  for( std::map< std::string, Schema* >::iterator iSchema = m_schemas.begin(); iSchema != m_schemas.end(); ++iSchema )
  {
    delete iSchema->second;
  }
  delete m_transaction;
  delete m_schema; // fix bug #42189: delete transaction first, schema later!
  delete m_monitorController;
  m_sessionProperties.reset();
}

#ifndef CORAL300MG
coral::IMonitoring&
coral::FrontierAccess::Session::monitoring()
{
  return *m_monitorController;
}
#else
coral::IMonitoringController&
coral::FrontierAccess::Session::monitoringController()
{
  return *m_monitorController;
}
#endif

void coral::FrontierAccess::Session::startUserSession( const std::string& /*userName*/, const std::string& /*password*/ ) // Login & Password ignored for Frontier
{
  coral::MessageStream log( m_sessionProperties->domainServiceName() );
  // A message log
  // Setting the user name as schema name
  // This is obsoleted by the new connection string syntax --> m_sessionProperties->setSchemaName( userName );

  // If this the first schema we assume it is the nominal schema
  if( ! m_schema )
    m_schema = new coral::FrontierAccess::Schema( m_sessionProperties, m_sessionProperties->schemaName() );

  if( ! m_transaction )
    m_transaction = new coral::FrontierAccess::Transaction( m_sessionProperties, *m_schema );

  // And the password - there is none for Frontier (yet)

  // Authenticating - there is none for Frontier (yet)

  // FIXME - (Do we ever do it for Frontier?) Enable sql trace

  log << coral::Debug << "Starting Frontier user session to: " << this->m_sessionProperties->connectionString() << " on schema: " << this->m_sessionProperties->schemaName() << coral::MessageStream::endmsg;

  // Record the beginning of the session
  if ( m_sessionProperties->monitoringService() )
  {
    m_sessionProperties->monitoringService()->record( m_sessionProperties->connectionString(), coral::monitor::Session, coral::monitor::Info, monitoringEventDescription.sessionBegin() );
  }
}

bool coral::FrontierAccess::Session::isUserSessionActive() const
{
  return ( ! m_sessionProperties->log().empty() );
}

void coral::FrontierAccess::Session::endUserSession()
{
  if ( this->isUserSessionActive() )
  {

    // Abort any active transaction
    if ( this->transaction().isActive() )
      this->transaction().rollback();

    // FIXME - (Do we ever do it for Frontier?) Stop the tracing

    // We report the executed commands to Verbose channel & clear it
    coral::MessageStream log( m_sessionProperties->domainServiceName() );

    for( SessionLog::const_iterator sli = m_sessionProperties->log().begin(); sli != m_sessionProperties->log().end(); ++sli )
      log << coral::Verbose << "User: " << m_sessionProperties->schemaName() << " query: " << (*sli).sql << coral::MessageStream::endmsg;

    m_sessionProperties->log().clear();

    // Record the ending of the session
    if ( m_sessionProperties->monitoringService() )
    {
      m_sessionProperties->monitoringService()->record( m_sessionProperties->connectionString(), coral::monitor::Session, coral::monitor::Info, monitoringEventDescription.sessionEnd() );
    }
  }
}

coral::ITransaction& coral::FrontierAccess::Session::transaction()
{
  return *m_transaction;
}

coral::ISchema& coral::FrontierAccess::Session::nominalSchema()
{
  return *m_schema;
}

coral::ISchema& coral::FrontierAccess::Session::schema( const std::string& schema )
{
  // Form the schema name correctly by setting everything to upper case
  std::string schemaName = schema;
  for ( std::string::size_type i = 0; i < schemaName.size(); ++i )
  {
    schemaName[i] = std::toupper( schemaName[i], std::locale::classic() );
  }

  // Check first is the schema with the corresponding name exists in the map
  std::map< std::string, Schema* >::iterator iSchema = m_schemas.find( schemaName );
  if ( iSchema != m_schemas.end() ) return *( iSchema->second );

  // Check in the database if a schema with such a name exists
  coral::AttributeList inBuffer; inBuffer.extend<std::string>( "user" ); inBuffer[0].data<std::string>() = schemaName;
  coral::AttributeList outBuffer; outBuffer.extend<std::string>( "USERNAME" );

  coral::FrontierAccess::Statement statement( m_sessionProperties, "SELECT USERNAME FROM ALL_USERS WHERE USERNAME=:\"user\"" );

  if( ! statement.execute( inBuffer ) )
  {
    // FIXME - error reporting
    ;
  }

  statement.defineOutput( outBuffer );
  statement.fetchNext();

  std::string foundSchema = "";

  foundSchema = outBuffer[0].data<std::string>();

  if( foundSchema.empty() )
    throw coral::InvalidSchemaNameException( m_sessionProperties->domainServiceName(), "coral::FrontierAccess::Session::schema" );

  // The schema exists. Insert it into the map of the known ones
  coral::FrontierAccess::Schema* newSchema = new coral::FrontierAccess::Schema( m_sessionProperties, schemaName );
  m_schemas.insert( std::make_pair( schemaName, newSchema ) );
  return *newSchema;
}
