#ifndef FRONTIERACCESS_CONNECTION_H
#define FRONTIERACCESS_CONNECTION_H 1

// Switch on/off debugging for Create/Delete all objects
//#define FRONTIER_CONNECTION_PROPERTIES_DEBUG 1
#undef FRONTIER_CONNECTION_PROPERTIES_DEBUG

#include <map>
#include "CoralBase/../src/coral_thread_headers.h"
#include "CoralCommon/IDevConnection.h"

namespace frontier
{
  class Connection;
}

namespace coral
{
  class ISession;

  namespace FrontierAccess
  {
    class Session;
    class TypeConverter;

    /**
     * Class Connection
     *
     * Implementation of the IConnection interface for the FrontierAccess module
     *///
    class Connection : public coral::IDevConnection
    {
      friend class coral::FrontierAccess::Session; // hack for bug #103685
    public:
      /// Constructor
      Connection( const std::string& domainServiceName,
                  const std::string& connectionString );

      /// Destructor
      virtual ~Connection();

      /**
       * Connects to a database server without authenticating
       * If no connection to the server can be established a ServerException is thrown.
       *///
      virtual void connect();

      /**
       * Returns a new session object.
       * In case no more sessions can be established for the current physical connection,
       * a MaximumNumberOfSessionsException is thrown.
       *///
      virtual coral::ISession* newSession( const std::string& schemaName, coral::AccessMode mode = coral::Update ) const;

      /**
       * Returns the connection status. By default this is a logical operation.
       * One should pass true as an argument to force the probing of the physical connection as well.
       *///
      virtual bool isConnected( bool probePhysicalConnection = false );

      /**
       * Drops the physical connection with the database.
       *///
      virtual void disconnect();

      /**
       * Returns the version of the database server.
       * If a connection is not yet established, a ConnectionNotActiveException is thrown.
       *///
      virtual std::string serverVersion() const;

      /**
       * Returns the C++ <-> SQL type converter relevant to he current session.
       * If a connection is not yet established, a ConnectionNotActiveException is thrown.
       *///
      virtual coral::ITypeConverter& typeConverter();

    private:

      int parseVersionString( const std::string& versionString );

      bool ping();

      /// Copy constructor is private (fix Coverity MISSING_COPY)
      Connection( const Connection& rhs );

      /// Assignment operator is private (fix Coverity MISSING_ASSIGN)
      Connection& operator=( const Connection& rhs );

    private:
      /// The Frontier physical connection
      frontier::Connection* m_frontierConnection;
      /// The domain service name (set in ctor, valid in dtor - see bug #71210)
      const std::string m_domainServiceName;
      /// Connection string
      const std::string m_connectionString;
      /// "Physical" connectoin established flag
      bool m_connected;
      /// The server version
      std::string m_serverVersion;
      /// The type converter
      TypeConverter* m_typeConverter;
      /// The connection lock
      mutable coral::mutex m_lock;
    };
  }
}
#endif //  FRONTIER_ACCESS_CONNECTION_H
