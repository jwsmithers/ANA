#ifndef CORALCOMMON_IMONITORINGCONTROLLER_H
#define CORALCOMMON_IMONITORINGCONTROLLER_H 1

// First of all, set/unset CORAL240, CORAL300 and CORAL_HAS_CPP11 macros
#include "CoralBase/VersionInfo.h"

#ifndef CORAL300MG

// In CORAL2, use IMonitoring from RelationalAccess
#include "RelationalAccess/IMonitoring.h"

#else

// In CORAL3, use IMonitoringController from CoralCommon
#include <iosfwd>
#include "RelationalAccess/MonitoringLevel.h"

namespace coral
{

  /**
   * Class IMonitoringController
   *
   * User-level interface for controlling the client-side monitoring
   * for the current session.
   *///
  class IMonitoringController
  {

  public:

    /**
     * Starts the client-side monitoring for the current session.
     * Throws a MonitoringServiceNotFoundException
     * if there is no monitoring service available.
     *///
    virtual void start( monitor::Level level = monitor::Default ) = 0;

    /**
     * Stops the client side monitoring.
     * Throws a monitoring exception if something went wrong.
     *///
    virtual void stop() = 0;

    /**
     * Reports whatever was gathered by the monitoring service to an ostream.
     * Throws a MonitoringServiceNotFoundException
     * if there is no monitoring service available.
     *///
    virtual void reportToOutputStream( std::ostream& os ) const = 0;

    /**
     * Triggers the reporting of the underlying monitoring service.
     * Throws a MonitoringServiceNotFoundException
     * if there is no monitoring service available.
     *///
    virtual void report() const = 0;

    /**
     * Returns the status of the monitoring.
     *///
    virtual bool isActive() const = 0;

  protected:

    /// Protected empty destructor
    virtual ~IMonitoringController() {}

  };

}

#endif

#endif // CORALCOMMON_IMONITORINGCONTROLLER_H
