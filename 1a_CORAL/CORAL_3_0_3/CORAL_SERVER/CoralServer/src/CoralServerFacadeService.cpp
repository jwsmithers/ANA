
// Local include files
#include "CoralServerFacadeService.h"

// Logger
#define LOGGER_NAME "CORAL/Services/CoralServerFacade"
#include "logger.h"

// Namespaces
using namespace coral::CoralServer;

//-----------------------------------------------------------------------------

CoralServerFacadeService::CoralServerFacadeService( const std::string& key )
  : coral::Service( key )
  , m_facade( 0 )
{
  logger << Debug << "Create CoralServerFacadeService" << endlog;
}

//-----------------------------------------------------------------------------

CoralServerFacadeService::~CoralServerFacadeService()
{
  logger << Debug << "Delete CoralServerFacadeService" << endlog;
}

//-----------------------------------------------------------------------------
