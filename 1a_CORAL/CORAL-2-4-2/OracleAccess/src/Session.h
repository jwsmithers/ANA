#ifndef ORACLEACCESS_SESSION_H
#define ORACLEACCESS_SESSION_H 1

#include <map>
#include <boost/shared_ptr.hpp>
#include "CoralBase/../src/coral_thread_headers.h"
#include "CoralBase/MessageStream.h"
#include "CoralCommon/IDevSession.h"
#include "RelationalAccess/AccessMode.h"

struct OCIServer;

namespace coral
{

  namespace OracleAccess
  {

    class ConnectionProperties;
    class MonitorController;
    class SessionProperties;
    class Schema;
    class Transaction;

    /**
     * Class Session
     *
     * Implementation of the ISession interface for the OracleAccess module
     *///
    class Session : virtual public coral::IDevSession
    {
    public:

      /// Constructor
      Session( coral::IDevConnection& connection,
               boost::shared_ptr<ConnectionProperties> connectionProperties,
               const std::string& schemaName,
               coral::AccessMode mode );

      /// Destructor
      ~Session();

      /**
       * Returns the reference to the underlying IMonitoring object.
       *///
      coral::IMonitoring& monitoring();

      /**
       * Authenticates with the database server using a user/password pair.
       * If the authentication fails an AuthenticationFailureException is thrown.
       *///
      void startUserSession( const std::string& userName,
                             const std::string& password );

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
        return "Oracle"; // same as Domain.flavorName()
      }

      /// NetworkGlitch: restart session
      bool restartSession();

    private:

      /// Copy constructor is private (fix Coverity MISSING_COPY)
      Session( const Session& rhs );

      /// Assignment operator is private (fix Coverity MISSING_ASSIGN)
      Session& operator=( const Session& rhs );

      /// Allocate the OCI handles and begin the OCI session
      void beginOciSession();

      /// End the OCI session and deallocate the OCI handles
      //void endOciSession(); // NOT YET IMPLEMENTED OR USED

      /// Execute a simple statement (OracleStatement may cause deadlocks)
      bool executeSimpleSQL( OCISvcCtx* ociSvcCtxHandle,
                             const std::string& sql ) const;

    private:

      /// The session properties
      boost::shared_ptr<SessionProperties> m_properties;

      /// The monitoring controller
      MonitorController* m_monitorController;

      /// The schema object
      Schema* m_schema;

      /// The transaction object
      Transaction* m_transaction;

      /// Mutex for the handles
      mutable coral::mutex m_mutex;

      /// Mutex for the schemas
      mutable coral::mutex m_mutexForSchemas;

      /// A map of the other schemas
      std::map< std::string, Schema* > m_schemas;

      /// NetworkGlitch: The username
      std::string m_userName;

      /// NetworkGlitch: The password
      std::string m_password;

    };

  }

}

#endif
