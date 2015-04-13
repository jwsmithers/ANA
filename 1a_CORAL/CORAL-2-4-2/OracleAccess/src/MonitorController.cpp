#include <iostream>

#include "CoralKernel/Context.h"
#include "CoralKernel/Service.h"
#include "RelationalAccess/IMonitoringService.h"
#include "RelationalAccess/IMonitoringReporter.h"
#include "RelationalAccess/SessionException.h"

#include "DomainProperties.h"
#include "MonitorController.h"
#include "SessionProperties.h"


coral::OracleAccess::MonitorController::MonitorController( boost::shared_ptr<const SessionProperties> properties ) :
  m_sessionProperties( properties ),
  m_mutex()
{
#ifdef ORACLE_CONNECTION_PROPERTIES_DEBUG
  std::cout << "Create MonitorController " << this << std::endl; // debug bug #98736
#endif
}


coral::OracleAccess::MonitorController::~MonitorController()
{
#ifdef ORACLE_CONNECTION_PROPERTIES_DEBUG
  std::cout << "Delete MonitorController " << this << std::endl; // debug bug #98736
#endif
}


void
coral::OracleAccess::MonitorController::start( coral::monitor::Level level )
{
  coral::lock_guard lock( m_mutex );

  coral::monitor::IMonitoringService* monitoringService = m_sessionProperties->monitoringService();

  if ( monitoringService == NULL )
  {
    coral::IHandle<coral::monitor::IMonitoringService> monService = coral::Context::instance().query<coral::monitor::IMonitoringService>();

    if( ! monService.isValid() )
    {
      throw coral::MonitoringServiceNotFoundException( m_sessionProperties->domainServiceName() );
    }

    monitoringService = monService.get();
    SessionProperties* properties = const_cast<SessionProperties*>( m_sessionProperties.get() );
    properties->setMonitoringService( monitoringService );

  }
  monitoringService->setLevel( "oracle://" + m_sessionProperties->connectionString() + "/" + m_sessionProperties->schemaName(), level );
  monitoringService->enable( "oracle://" + m_sessionProperties->connectionString() + "/" + m_sessionProperties->schemaName() );
}


void
coral::OracleAccess::MonitorController::stop()
{
  coral::lock_guard lock( m_mutex );
  coral::monitor::IMonitoringService* monitoringService = m_sessionProperties->monitoringService();
  if ( monitoringService ) {
    monitoringService->disable( "oracle://" + m_sessionProperties->connectionString() + "/" + m_sessionProperties->schemaName() );
  }
  SessionProperties* properties = const_cast<SessionProperties*>( m_sessionProperties.get() );
  properties->setMonitoringService( 0 );
}


void
coral::OracleAccess::MonitorController::reportToOutputStream( std::ostream& os ) const
{
  coral::lock_guard lock( m_mutex );
  coral::monitor::IMonitoringService* monitoringService = m_sessionProperties->monitoringService();
  if ( ! monitoringService ) {
    throw coral::MonitoringServiceNotFoundException( m_sessionProperties->domainServiceName(),
                                                     "IMonitoring::reportToOutputStream" );
  }
  monitoringService->reporter().reportToOutputStream( "oracle://" + m_sessionProperties->connectionString() + "/" + m_sessionProperties->schemaName(),
                                                      os );
}


void
coral::OracleAccess::MonitorController::report() const
{
  coral::lock_guard lock( m_mutex );
  coral::monitor::IMonitoringService* monitoringService = m_sessionProperties->monitoringService();
  if ( ! monitoringService ) {
    throw coral::MonitoringServiceNotFoundException( m_sessionProperties->domainServiceName(),
                                                     "IMonitoring::report" );
  }
  monitoringService->reporter().report( "oracle://" + m_sessionProperties->connectionString() + "/" + m_sessionProperties->schemaName() );
}


bool
coral::OracleAccess::MonitorController::isActive() const
{
  coral::lock_guard lock( m_mutex );
  return ( m_sessionProperties->monitoringService() != 0 ||
           m_sessionProperties->monitoringService()->active( "oracle://" + m_sessionProperties->connectionString() + "/" + m_sessionProperties->schemaName() ) );
}
