// $Id: SessionProperties.cpp,v 1.10 2012-07-05 18:10:47 avalassi Exp $

#include "DomainProperties.h"
#include "SessionProperties.h"
#include "Session.h"
#include "TypeConverter.h"

#include "RelationalAccess/ISession.h"
#include "RelationalAccess/ITransaction.h"
#include "RelationalAccess/SessionException.h"

#include "CoralBase/Exception.h"

#include "CoralKernel/Service.h"
#include "CoralKernel/Context.h"

#include <stdexcept>
#include <locale>

coral::FrontierAccess::SessionProperties::SessionProperties( const std::string& domainServiceName,
                                                             const std::string& connectionString,
                                                             frontier::Connection& fconnection,
                                                             coral::mutex& flock,
                                                             const std::string& schemaName,
                                                             coral::ITypeConverter& converter,
                                                             Session& session )
  : m_domainServiceName( domainServiceName )
  , m_connectionString( connectionString )
  , m_connectionURL( connectionString )
  , m_frontierConnection( fconnection )
  , m_session( &session )
  , m_typeConverter( converter )
  , m_monitoringService( 0 )
  , m_majorServerVersion( 0 )
  , m_schemaName( "" )
  , m_lock( flock )
{
  if( ! schemaName.empty() )
    setSchemaName( schemaName );
}

coral::FrontierAccess::SessionProperties::~SessionProperties()
{
}

void
coral::FrontierAccess::SessionProperties::nullifySession()
{
  m_session = NULL;
}

frontier::Connection&
coral::FrontierAccess::SessionProperties::frontierConnection() const
{
  if ( !m_session )
    throw coral::SessionException( "Session has been nullified",
                                   "SessionProperties::frontierConnection",
                                   domainServiceName() );
  return m_frontierConnection;
}

void coral::FrontierAccess::SessionProperties::setMajorServerVersion( int majorServerVersion )
{
  m_majorServerVersion = majorServerVersion;
}

coral::ITypeConverter& coral::FrontierAccess::SessionProperties::typeConverter()
{
  return m_typeConverter;
}

const coral::ITypeConverter& coral::FrontierAccess::SessionProperties::typeConverter() const
{
  return m_typeConverter;
}

void coral::FrontierAccess::SessionProperties::setMonitoringService( coral::monitor::IMonitoringService* monitoringService ) const
{
  m_monitoringService = monitoringService;
}

bool coral::FrontierAccess::SessionProperties::isTransactionActive() const
{
  if ( !m_session )
    throw coral::SessionException( "Session has been nullified",
                                   "SessionProperties::isTransactionActive",
                                   domainServiceName() );
  return m_session->transaction().isActive();
}

coral::ISchema& coral::FrontierAccess::SessionProperties::schema() const
{
  if ( !m_session )
    throw coral::SessionException( "Session has been nullified",
                                   "SessionProperties::schema",
                                   domainServiceName() );
  return m_session->nominalSchema();
}

std::string coral::FrontierAccess::SessionProperties::schemaName() const
{
  return m_schemaName;
}

void coral::FrontierAccess::SessionProperties::setSchemaName( const std::string& newSchemaName )
{
  m_schemaName           = "";
  std::string tempSchema = newSchemaName;
  for ( std::string::size_type i = 0; i < tempSchema.size(); ++i )
  {
    m_schemaName += std::toupper( tempSchema[i], std::locale::classic() );
  }
}
