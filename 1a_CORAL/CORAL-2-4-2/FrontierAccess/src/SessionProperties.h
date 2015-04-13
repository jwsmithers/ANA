#ifndef FRONTIERACCESS_SESSIONPROPERTIES_H
#define FRONTIERACCESS_SESSIONPROPERTIES_H 1

#include <string>
#include <vector>
#include <boost/shared_ptr.hpp>
#include "CoralBase/../src/coral_thread_headers.h"
#include "CoralBase/TimeStamp.h"
#include "RelationalAccess/IMonitoringService.h"

namespace frontier
{
  class Connection;
}

namespace coral
{
  class ISchema;
  class ISession;
  class ITypeConverter;

  namespace monitor
  {
    class IMonitoringService;
  }

  namespace FrontierAccess
  {
    class Session;
    
    struct LogEntry
    {
      LogEntry()
        : ts( coral::TimeStamp::now() ), sql( "" ), err( 0 ), errmsg( "" )
      {}
      explicit LogEntry( const std::string& query,
                         int error_code=0,
                         const std::string& error_message="",
                         coral::TimeStamp t=coral::TimeStamp::now() )
        : ts( t ), sql( query ), err( error_code ), errmsg( error_message )
      {}
      coral::TimeStamp ts;
      std::string sql;
      int err;
      std::string errmsg;
    };
    typedef std::vector<LogEntry> SessionLog;

    class SessionProperties
    {
    public:
      /// Constructor
      SessionProperties( const std::string& domainServiceName,
                         const std::string& connectionString,
                         frontier::Connection& fconnection,
                         coral::mutex& flock,
                         const std::string& schemaName,
                         coral::ITypeConverter& converter,
                         Session& session );
      /// Destructor
      virtual ~SessionProperties();
      /// Mark the session as deleted ("nullify" session - bug #73834)
      /// [NB "invalidate" is used in IDevSession for connection sharing]
      void nullifySession();
      /// Return the log
      virtual coral::FrontierAccess::SessionLog& log() const;
      /// Sets the major server version and resets the type converter
      void setMajorServerVersion( int majorServerVersion );
      /// Sets the monitoring service
      void setMonitoringService( coral::monitor::IMonitoringService* monitoringService ) const;
      /// Returns the domain service name
      const std::string& domainServiceName() const;
      /// Returns the type converter
      virtual coral::ITypeConverter& typeConverter();
      virtual const coral::ITypeConverter& typeConverter() const;
      /// Returns the connection string
      std::string connectionString() const;
      void setConnectionString( const std::string& );
      std::string connectionURL() const;
      void setConnectionURL( const std::string& );
      /// The Frontier physical connection handle
      frontier::Connection& frontierConnection() const;
      /// Returns the monitoring service
      coral::monitor::IMonitoringService* monitoringService() const;
      /// Returns the transaction state
      bool isTransactionActive() const;
      /// Returns the major server version
      int majorServerVersion() const;
      /// Returns the corresponding schema
      coral::ISchema& schema() const;
      /// Returns the schema name
      std::string schemaName() const;
      void setSchemaName( const std::string& );
      /// Access to the connection lock
      coral::mutex& lock() const;
      /// Get the handle to the connection service
      // AV 16.04.2008 Fix for bug #35528
      //coral::IHandle<coral::IConnectionService> coral::FrontierAccess::SessionProperties::connectionService() const;
      //coral::IHandle<coral::IConnectionService> connectionService() const;
    private:
      /// The domain service name (this is retrieved from DomainProperties
      /// only in the ctor and can be used in the dtor - fix bug #71210)
      const std::string m_domainServiceName;
      /// The connection string
      std::string m_connectionString;
      /// The connection URL
      std::string m_connectionURL;
      /// The physical connection
      frontier::Connection& m_frontierConnection;
      /// The session pointer (NULL if the session has been nullified)
      Session* m_session;
      /// Type converter
      coral::ITypeConverter& m_typeConverter;
      /// Monitoring service
      mutable coral::monitor::IMonitoringService* m_monitoringService;
      /// The major server version
      int m_majorServerVersion;
      /// The schema name
      std::string m_schemaName;
      /// Session query log
      mutable coral::FrontierAccess::SessionLog m_log;
      /// Access to the connection lock
      coral::mutex& m_lock;
    };
  }
}

// Inline methods
inline coral::FrontierAccess::SessionLog&
coral::FrontierAccess::SessionProperties::log() const
{
  return m_log;
}

inline const std::string&
coral::FrontierAccess::SessionProperties::domainServiceName() const
{
  return m_domainServiceName;
}

inline std::string
coral::FrontierAccess::SessionProperties::connectionString() const
{
  return m_connectionString;
}

inline void
coral::FrontierAccess::SessionProperties::setConnectionString( const std::string& newCs )
{
  m_connectionString = newCs;
}

inline std::string
coral::FrontierAccess::SessionProperties::connectionURL() const
{
  return m_connectionURL;
}

inline void
coral::FrontierAccess::SessionProperties::setConnectionURL( const std::string& newCs )
{
  m_connectionURL = newCs;
}

inline coral::monitor::IMonitoringService*
coral::FrontierAccess::SessionProperties::monitoringService() const
{
  return m_monitoringService;
}

inline int
coral::FrontierAccess::SessionProperties::majorServerVersion() const
{
  return m_majorServerVersion;
}

inline coral::mutex&
coral::FrontierAccess::SessionProperties::lock() const
{
  return m_lock;
}

#endif
