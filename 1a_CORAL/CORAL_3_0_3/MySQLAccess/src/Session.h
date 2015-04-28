#ifndef MYSQLACCESS_SESSION_H
#define MYSQLACCESS_SESSION_H 1

// First of all, set/unset CORAL240, CORAL300 and CORAL_HAS_CPP11 macros
#include "CoralBase/VersionInfo.h"

#include "MySQL_headers.h"
#include <map>
#include <string>
#include "CoralBase/../src/coral_thread_headers.h"
#include "CoralCommon/IDevSession.h"
#include "RelationalAccess/AccessMode.h"

namespace coral
{
  class IDevConnection;

  namespace MySQLAccess
  {

    class DomainProperties;
    class SessionProperties;
    class MonitorController;
    class Schema;
    class Transaction;

    typedef std::map<std::string,Schema*> SchemaRegistry;

    /**
     * Class Session
     *
     * Implementation of the ISession interface for the MySQLAccess module
     *///
    class Session : public coral::IDevSession
    {
    public:
      /// Constructor
      Session(  coral::IDevConnection& connection,
                const DomainProperties& domainProperties,
                const std::string& connectionString,
                const std::string& schemaName,
                MYSQL*& handle, bool& connected,
                coral::mutex& lock,
                coral::AccessMode mode );

      /// Destructor
      virtual ~Session();

      /**
       * Returns the reference to the underlying IMonitoringController object.
       *///
#ifndef CORAL300MG
      coral::IMonitoring& monitoring();
#else
      coral::IMonitoringController& monitoringController();
#endif

      /**
       * Returns the nominal schema name for the given connection string
       *///
      std::string nominalSchemaNameForConnection( const std::string& connectionName ) const;

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
        return "MySQL"; // same as Domain.flavorName()
      }

    private:

      /// Copy constructor is private (fix Coverity MISSING_COPY)
      Session( const Session& rhs );

      /// Assignment operator is private (fix Coverity MISSING_ASSIGN)
      Session& operator=( const Session& rhs );

    private:

      /// The session properties
      boost::shared_ptr<SessionProperties> m_properties;

      /// The monitoring controller
      MonitorController* m_monitorController;

      /// The schema object
      std::string m_nominalSchemaName;

      /// The schema object
      Schema* m_schema;

      /// The registry of opened schemas
      SchemaRegistry m_schreg;

      /// The transaction object
      Transaction* m_transaction;

      /// Access mode
      coral::AccessMode m_accessMode;

      /// lock
      coral::mutex& m_lock;

    };

  }

}
#endif // MYSQLACCESS_SESSION_H
