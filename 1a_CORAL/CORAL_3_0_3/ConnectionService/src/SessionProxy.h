#ifndef CONNECTIONSERVICE_SESSIONPROXY_H
#define CONNECTIONSERVICE_SESSIONPROXY_H 1

// First of all, set/unset CORAL240, CORAL300 and CORAL_HAS_CPP11 macros
#include "CoralBase/VersionInfo.h"

#include "RelationalAccess/ISessionProxy.h"
#include "RelationalAccess/ISessionProperties.h"
#include "SessionHandle.h"

namespace coral
{

  class ISession;
  class ICertificateData;

  namespace ConnectionService
  {

    class ConnectionService;

    /// implementation of the ISessionProperties interface (local properties)
    class SessionProperties : virtual public coral::ISessionProperties
    {
    public:

      /// constructor
      explicit SessionProperties(const SessionHandle& sessionHandle);

      /// destructor
      virtual ~SessionProperties();

      /// Returns the name of the RDBMS flavour..
      std::string flavorName() const;

      /// Returns the version of the database server.
      std::string serverVersion() const;

    private:

      const SessionHandle& m_session;

    };

    /// implementation of the ISessionProperties interface (remote properties)
    class RemoteSessionProperties : virtual public coral::ISessionProperties
    {
    public:

      /// constructor
      explicit RemoteSessionProperties(const SessionHandle& sessionHandle);

      /// destructor
      virtual ~RemoteSessionProperties();

      /// Returns the name of the RDBMS flavour..
      std::string flavorName() const;

      /// Returns the version of the database server.
      std::string serverVersion() const;

    private:

      const SessionHandle& m_session;

    };

    /// implementation of the ISessionProxy interface
    class SessionProxy : virtual public coral::ISessionProxy
    {
    public:

      /// constructor
      SessionProxy(const std::string& connectionString,
                   coral::AccessMode accessMode,
                   ConnectionService* connectionService);

      /// constructor
      SessionProxy(const std::string& connectionString,
                   const std::string& asRole,
                   coral::AccessMode accessMode,
                   ConnectionService* connectionService);

      /// destructor
      virtual ~SessionProxy() ;

      /// get the properties of the session opened in the local client plugin
      ISessionProperties& properties();

      /// get the properties of the remote session.
      const ISessionProperties& remoteProperties();

      /// forward of the method of the underlying session object
      ITransaction& transaction();

      /// forward of the method of the underlying session object
      ITypeConverter& typeConverter();

      /// forward of the method of the underlying session object
      ISchema& nominalSchema();

      /// forward of the method of the underlying session object
      ISchema& schema( const std::string& schemaName );

#ifdef CORAL300MG
      /// Returns the monitoring controller of the active session (task #12498).
      /// WARNING! THIS METHOD IS NOT YET IMPLEMENTED AND THROWS IN CORAL300!
      IMonitoringController& monitoringController();
#endif

      /// is the underlying connection shared with other sessions?
      bool isConnectionShared() const;

      /// hook to access the underlying session object
      coral::ISession* session();

      /// force the session to be open
      void open( const ICertificateData *cert );

      /// invalidate the stored handle to the ConnectionService
      void invalidate();

    private:

      /// the stored connection parameters
      std::string m_connectionString;

      /// the stored role parameter
      std::string m_role;

      /// the accessMode
      coral::AccessMode m_accessMode;

      /// the reference to the connection service
      coral::ConnectionService::ConnectionService* m_connectionService;

      /// the underlying session handle
      SessionHandle m_session;

      /// the stored SessionProperties object (local properties)
      SessionProperties m_properties;

      /// the stored RemoteSessionProperties object (remote properties)
      RemoteSessionProperties m_remoteProperties;

    };

  }

}
#endif
