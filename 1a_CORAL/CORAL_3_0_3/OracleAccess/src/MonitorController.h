#ifndef ORACLEACCESS_MONITORCONTROLLER_H
#define ORACLEACCESS_MONITORCONTROLLER_H 1

// First of all, set/unset CORAL240, CORAL300 and CORAL_HAS_CPP11 macros
#include "CoralBase/VersionInfo.h"

#include <boost/shared_ptr.hpp>
#include "CoralBase/../src/coral_thread_headers.h"
#include "CoralCommon/IMonitoringController.h"

namespace coral
{

  namespace OracleAccess
  {

    class SessionProperties;

    /**
     * Class MonitorController
     *
     * Implementation of the IMonitoringController interface for OracleAccess.
     *
     *///
#ifndef CORAL300MG
    class MonitorController : virtual public coral::IMonitoring
#else
    class MonitorController : virtual public coral::IMonitoringController
#endif
    {
    public:

      /// Constructor
      explicit MonitorController( boost::shared_ptr<const SessionProperties> properties );

      /// Destructor
      virtual ~MonitorController();

      /**
       * Starts the client-side monitoring for the current session.
       * Throws a MonitoringServiceNotFoundException if there is no monitoring service available.
       *///
      void start( coral::monitor::Level level = coral::monitor::Default );

      /**
       * Stops the client side monitoring.
       * Throws a monitoring exception if something went wrong.
       *///
      void stop();

      /**
       * Reports whatever has been gather by the monitoring service to an std::ostream.
       * Throws a MonitoringServiceNotFoundException if there is no monitoring service available.
       *///
      void reportToOutputStream( std::ostream& os ) const;

      /**
       * Triggers the reporting of the underlying monitoring service.
       * Throws a MonitoringServiceNotFoundException if there is no monitoring service available.
       *///
      void report() const;

      /**
       * Returns the status of the monitoring.
       *///
      bool isActive() const;

    private:

      /// The session properties
      boost::shared_ptr<const SessionProperties> m_sessionProperties;

      /// Mutex lock
      mutable coral::mutex m_mutex;

    };

  }

}
#endif // ORACLEACCESS_MONITORCONTROLLER_H
