#ifndef FRONTIERACCESS_SESSION_H
#define FRONTIERACCESS_SESSION_H 1

#include <map>
#include <string>
#include <boost/shared_ptr.hpp>
#include "CoralBase/../src/coral_thread_headers.h"
#include "CoralCommon/IDevSession.h"
#include "RelationalAccess/AccessMode.h"

namespace frontier
{
  class Connection;
}

namespace coral
{
  class IDevConnection;
  class ITypeConverter;

  namespace FrontierAccess
  {
    class MonitorController;
    class Schema;
    class SessionProperties;
    class Transaction;

    /**
     * Class Session
     *
     * Implementation of the ISession interface for the FrontierAccess module
     *///
    class Session : public coral::IDevSession
    {
    public:

      /// Constructor
      Session( coral::IDevConnection& connection,
               const std::string& domainServiceName,
               const std::string& connectionString,
               frontier::Connection& fconnection,
               coral::mutex& flock,
               const std::string& schemaName,
               const coral::ITypeConverter& converter );

      /// Destructor
      virtual ~Session();

      /**
       * Returns the reference to the underlying IMonitoring object.
       *///
      coral::IMonitoring& monitoring();

      /**
       * Authenticates with the database server using a user/password pair.
       * If the authentication fails an AuthenticationFailureException is thrown.
       *///
      void startUserSession( const std::string& userName, const std::string& password );

      /**
       * Terminates a user session without dropping the connection to the database server
       *///
      void endUserSession();

      /**
       * Returns the status of a user session.
       *///
      bool isUserSessionActive() const;

      /**
       * Returns the corresponding ITransaction object.
       * If a connection is not yet established, a ConnectionNotActiveException is thrown.
       *///
      coral::ITransaction& transaction();

      /**
       * Returns a reference to the working ISchema object.
       * If a connection is not yet established, a ConnectionNotActiveException is thrown.
       *///
      coral::ISchema& nominalSchema();

      /**
       * Returns a reference to the ISchema object corresponding to the specified name.
       * If a connection is not yet established, a ConnectionNotActiveException is thrown.
       * If no schema exists corresponding to the specified name an InvalidSchemaNameException is thrown.
       *///
      coral::ISchema& schema( const std::string& schemaName );

      /**
       * Returns the technology name for the remote session.
       * For plugins establishing a database connection through a middle-tier
       * (e.g. CoralAccess), this is discovered when establishing the remote session.
       *///
      std::string remoteTechnologyName() const
      {
        return "frontier"; // same as Domain.flavorName()
      }

    private:

      /// Copy constructor is private (fix Coverity MISSING_COPY)
      Session( const Session& rhs );

      /// Assignment operator is private (fix Coverity MISSING_ASSIGN)
      Session& operator=( const Session& rhs );

    private:

      /// The session properties
      boost::shared_ptr<SessionProperties> m_sessionProperties;

      /// "Physical" connection established flag
      bool m_connected;

      /// The monitoring controller
      coral::FrontierAccess::MonitorController* m_monitorController;

      /// The nominal schema object
      coral::FrontierAccess::Schema* m_schema;

      /// The transaction object
      coral::FrontierAccess::Transaction* m_transaction;

      /// A map of the other schemas
      std::map< std::string, Schema* > m_schemas;

    };

  }

}
#endif
