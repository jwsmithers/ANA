#ifndef MYSQLACCESS_SESSIONPROPERTIES_H
#define MYSQLACCESS_SESSIONPROPERTIES_H 1

#include "CoralBase/../src/coral_thread_headers.h"
#include "RelationalAccess/AccessMode.h"
#include "RelationalAccess/IMonitoringService.h"
//#include "SessionProperties.h" // Fix Coverity PW.INCLUDE_RECURSION
#include "TypeConverter.h"

namespace coral
{
  class ISchema;

  namespace MySQLAccess
  {
    class DomainProperties;
    class Session;

    struct ServerRevision
    {
      unsigned long major; unsigned long minor; unsigned long revision;
    };

    /**
     * Class SessionProperties
     *
     *///

    class SessionProperties
    {
    public:
      /// Constructor
      SessionProperties( const DomainProperties& domainProperties,
                         const std::string& connectionString,
                         const std::string& schemaName,
                         MYSQL*& m_mysql,
                         bool& connected,
                         coral::mutex& conlock,
                         Session& session,
                         coral::AccessMode mode );

      /// Destructor
      virtual ~SessionProperties();

      /// Mark the session as deleted ("nullify" session - bug #73834)
      /// [NB "invalidate" is used in IDevSession for connection sharing]
      void nullifySession();

      /// Returns the domain properties
      const DomainProperties& domainProperties() const;

      /// Returns the domain service name
      const std::string& domainServiceName() const;

      /// Returns the connection string
      std::string connectionString() const;

      /// Sets the monitoring service
      /// HACK! Declare it const and declare the monitoringservice mutable!
      void setMonitoringService( coral::monitor::IMonitoringService* monitoringService ) const;

      /// Returns the monitoring service
      coral::monitor::IMonitoringService* monitoringService();
      coral::monitor::IMonitoringService* monitoringService() const;

      /// Returns the type converter
      coral::ITypeConverter& typeConverter();
      const coral::ITypeConverter& typeConverter() const;

      /// Returns the connection handle
      MYSQL*& connectionHandle() const;

      /// Sets the connect flag
      void setConnected( bool isConnected = true );

      /// Returns the connection status
      bool isConnected() const;

      /// Sets the user-session flag
      void setUserSession( bool started = true );

      /// Returns the status is the user session
      bool hasUserSessionStarted() const;

      /// Returns the transaction state
      bool isTransactionActive() const;

      /// Returns the transaction mode
      bool isTransactionReadOnly() const;

      /// Returns the corresponding schema
      coral::ISchema& schema() const;

      /// Returns the schema name
      std::string schemaName() const;

      /// The database server version
      std::string serverVersion() const;

      /// Set the database server version
      void setServerVersion( const std::string& );

      /// The database server version
      ServerRevision serverRevision() const;

      /// Set the database server revision
      void setServerRevision( unsigned long, unsigned long, unsigned long );

      /// Access to the connection mutex lock
      coral::mutex& lock() const;

      /// Returns the readOnly flag
      bool isReadOnly() const;

    private:
      /// The domain properties
      const DomainProperties& m_domainProperties;

      /// The domain service name (this is retrieved from DomainProperties
      /// only in the ctor and can be used in the dtor - fix bug #71210)
      const std::string m_domainServiceName;

      /// The connection string
      std::string m_connectionString;

      /// The session pointer (NULL if the session has been nullified)
      Session* m_session;

      /// Access mode: ReadOnly or Update
      coral::AccessMode m_accessMode;

      /// The connectionHandle
      MYSQL*& m_connectionHandle;

      /// The connect flag
      bool& m_isConnected;

      /// The user-session flag
      bool m_userSessionStarted;

      /// The monitoring service
      mutable coral::monitor::IMonitoringService* m_monitoringService;

      /// The type converter
      coral::ITypeConverter& m_typeConverter;

      /// The schema name
      std::string m_schemaName;

      /// Server version
      std::string m_serverVersion;

      /// Server revision
      ServerRevision m_serverRevision;

      /// Connection lock
      coral::mutex& m_lock;

    };
  }
}

// Inline methods
inline const coral::MySQLAccess::DomainProperties&
coral::MySQLAccess::SessionProperties::domainProperties() const
{
  return m_domainProperties;
}

inline const std::string&
coral::MySQLAccess::SessionProperties::domainServiceName() const
{
  return m_domainServiceName;
}

inline std::string
coral::MySQLAccess::SessionProperties::connectionString() const
{
  return m_connectionString;
}

inline MYSQL*&
coral::MySQLAccess::SessionProperties::connectionHandle() const
{
  return const_cast<MYSQL*&>( this->m_connectionHandle );
}

inline void
coral::MySQLAccess::SessionProperties::setConnected( bool isConnected )
{
  m_isConnected = isConnected;
}

inline bool
coral::MySQLAccess::SessionProperties::isConnected() const
{
  return m_isConnected;
}

inline void
coral::MySQLAccess::SessionProperties::setUserSession( bool started )
{
  m_userSessionStarted = started;
}

inline bool
coral::MySQLAccess::SessionProperties::hasUserSessionStarted() const
{
  return m_userSessionStarted;
}

inline void
coral::MySQLAccess::SessionProperties::setMonitoringService( coral::monitor::IMonitoringService* monitoringService ) const
{
  m_monitoringService = monitoringService;
}

inline coral::monitor::IMonitoringService*
coral::MySQLAccess::SessionProperties::monitoringService()
{
  return m_monitoringService;
}

inline coral::monitor::IMonitoringService*
coral::MySQLAccess::SessionProperties::monitoringService() const
{
  return m_monitoringService;
}

inline coral::mutex&
coral::MySQLAccess::SessionProperties::lock() const
{
  return m_lock;
}

#endif // MYSQL_SESSION_PROPERTIES_H
