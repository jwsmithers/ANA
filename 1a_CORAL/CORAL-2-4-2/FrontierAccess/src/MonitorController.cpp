#include "MonitorController.h"
#include "SessionProperties.h"
#include "DomainProperties.h"
#include "RelationalAccess/IMonitoringService.h"
#include "RelationalAccess/IMonitoringReporter.h"
#include "RelationalAccess/SessionException.h"
#include "CoralKernel/Service.h"
#include "CoralKernel/Context.h"


coral::FrontierAccess::MonitorController::MonitorController( boost::shared_ptr<const SessionProperties> properties ) :
  m_sessionProperties( properties )
{
}


coral::FrontierAccess::MonitorController::~MonitorController()
{
}


void
coral::FrontierAccess::MonitorController::start( coral::monitor::Level level )
{
  coral::IHandle<coral::monitor::IMonitoringService> monitoringService =
    coral::Context::instance().query<coral::monitor::IMonitoringService>("CORAL/Services/MonitoringService");

  if ( ! monitoringService.isValid() )
  {
    throw coral::MonitoringServiceNotFoundException( m_sessionProperties->domainServiceName() );
  }

  m_sessionProperties->setMonitoringService( monitoringService.get() );
  monitoringService->setLevel( m_sessionProperties->connectionString(), level );
  monitoringService->enable( m_sessionProperties->connectionString() );
}

void
coral::FrontierAccess::MonitorController::stop()
{
  coral::IHandle<coral::monitor::IMonitoringService> monitoringService = m_sessionProperties->monitoringService();

  if ( monitoringService.isValid() )
  {
    monitoringService->disable( m_sessionProperties->connectionString() );
  }

  m_sessionProperties->setMonitoringService( 0 );
}

void
coral::FrontierAccess::MonitorController::reportToOutputStream( std::ostream& os ) const
{
  coral::IHandle<coral::monitor::IMonitoringService> monitoringService = m_sessionProperties->monitoringService();

  if ( ! monitoringService.isValid() )
  {
    throw coral::MonitoringServiceNotFoundException( m_sessionProperties->domainServiceName(), "IMonitoring::reportToOutputStream" );
  }

  monitoringService->reporter().reportToOutputStream(  m_sessionProperties->connectionString(), os );
}

void
coral::FrontierAccess::MonitorController::report() const
{
  coral::IHandle<coral::monitor::IMonitoringService> monitoringService = m_sessionProperties->monitoringService();

  if ( ! monitoringService.isValid() )
  {
    throw coral::MonitoringServiceNotFoundException( m_sessionProperties->domainServiceName(), "IMonitoring::report" );
  }

  monitoringService->reporter().report( m_sessionProperties->connectionString() );
}

bool
coral::FrontierAccess::MonitorController::isActive() const
{
  return ( m_sessionProperties->monitoringService() != 0 ||
           m_sessionProperties->monitoringService()->active( m_sessionProperties->connectionString() ) );
}
