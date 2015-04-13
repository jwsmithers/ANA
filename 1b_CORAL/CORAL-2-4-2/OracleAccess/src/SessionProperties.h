#ifndef ORACLE_SESSIONPROPERTIES_H
#define ORACLE_SESSIONPROPERTIES_H 1

#include <vector>
#include "CoralBase/../src/coral_thread_headers.h"
#include "ConnectionProperties.h"

struct OCIEnv;
struct OCIError;
struct OCIServer;
struct OCISession;
struct OCISvcCtx;
struct OCIStmt;

namespace coral
{
  class ISchema;
  class ISession;
  //class ITypeConverter;
  class IView;
  class Session;

  namespace monitor
  {
    class IMonitoringService;
  }

  namespace OracleAccess
  {
    class Transaction;

    /**
     * Class SessionProperties
     *
     * A proxy to OracleAccess::Session,
     * for internal use by OracleAccess classes.
     *///

    class SessionProperties
    {

    public:

      /// Constructor
      SessionProperties( boost::shared_ptr<ConnectionProperties> connectionProperties,
                         const std::string& schemaName,
                         Session& session,
                         bool readOnly );

      /// Destructor
      virtual ~SessionProperties();

      /// Mark the session as deleted ("nullify" session - bug #73834)
      /// [NB "invalidate" is used in IDevSession for connection sharing]
      void nullifySession();

      /// Sets the service context handle
      void setOciSvcCtxHandle( OCISvcCtx* ociSvcCtxHandle );

      /// Sets the session handle
      void setOciSessionHandle( OCISession* ociSessionHandle );

      /// Sets the monitoring service
      void setMonitoringService( coral::monitor::IMonitoringService* monitoringService );

      /// Returns the connection properties
      //const ConnectionProperties& connectionProperties() const;

      /// Returns the domain properties
      const DomainProperties& domainProperties() const;

      /// Returns the domain service name
      const std::string& domainServiceName() const;

      /// Returns the connection string
      std::string connectionString() const;

      /// Returns the type converter
      //coral::ITypeConverter& typeConverter();
      //const coral::ITypeConverter& typeConverter() const;

      /// Returns the OCI environment handle
      OCIEnv* ociEnvHandle() const;

      /// Returns the OCI error handle
      OCIError* ociErrorHandle() const;

      /// Returns the OCI server handle (optionally skip reconnection)
      /// Optionally update nConnectionRestarted (bug #94114)
      OCIServer* ociServerHandle( bool reconnect=true,
                                  bool updateNRestarted=false ) const;

      /// Returns the OCI service context handle (optionally skip reconnection)
      OCISvcCtx* ociSvcCtxHandle( bool reconnect=true ) const;

      /// Returns the OCI session handle (never attempt reconnection)
      OCISession* ociSessionHandle() const;

      /// Returns the monitoring service
      coral::monitor::IMonitoringService* monitoringService() const;

      /// Returns the transaction state
      bool isTransactionActive() const;

      /// Returns the transaction mode
      bool isTransactionReadOnly() const;

      /*
      /// Returns the RO transaction serializable mode
      bool isTransactionSerializableIfRO() const;
      *///

      /// Returns the server version
      int majorServerVersion() const;

      /// Returns the schema name
      std::string schemaName() const;

      /// Returns the readOnly flag
      bool isReadOnly() const;

      /// Can this session 'select any table'?
      /// Initially it is assumed that it can.
      bool selectAnyTable() const;

      /// Set the (mutable) 'select any table' flag to false.
      void cannotSelectAnyTable() const;

      // Checks if a table exists in a schema (fix MT bug #80065)
      // Schema name "" indicates the nominal schema
      bool existsTable( const std::string& schemaName,
                        const std::string& tableName ) const;

      // Checks if a view exists in a schema (fix MT bug #80065)
      // Schema name "" indicates the nominal schema
      bool existsView( const std::string& schemaName,
                       const std::string& viewName ) const;

      // Get column names of a table in a schema (fix MT bug #80065)
      // Schema name "" indicates the nominal schema
      const std::vector<std::string>
      describeTable( const std::string& schemaName,
                     const std::string& tableName ) const;

      // Get column names of a view in a schema (fix MT bug #80065)
      // Schema name "" indicates the nominal schema
      const std::vector<std::string>
      describeView( const std::string& schemaName,
                    const std::string& viewName ) const;

      // Get a view handle in a schema (fix MT bug #80065)
      // Schema name "" indicates the nominal schema
      IView& viewHandle( const std::string& schemaName,
                         const std::string& viewName ) const;

      // Returns the current C++ type for an SQL type (fix MT bug #80065)
      // Throws UnSupportedSqlTypeException is thrown if SQL type is invalid
      std::string cppTypeForSqlType( const std::string& sqlType ) const;

      // Returns the current SQL type for a C++ type (fix MT bug #80065)
      // Throws UnSupportedCppTypeException is thrown if C++ type is invalid
      std::string sqlTypeForCppType( const std::string& cppType ) const;

      // Refresh the transaction cache
      void refreshTransactionCache( bool isActive, bool isReadOnly, bool isSerializableIfRO ) const;

      /// NetworkGlitch: was the session lost?
      bool wasSessionLost() const;

      /// NetworkGlitch: restart session
      bool restartSession() const;

    private:

      /// The connection properties
      boost::shared_ptr<ConnectionProperties> m_connectionProperties;

      /// The domain service name (this is retrieved from DomainProperties
      /// only in the ctor and can be used in the dtor - fix bug #71210)
      const std::string m_domainServiceName;

      /// The session pointer (NULL if the session has been nullified)
      Session* m_session;

      /// The OCI service context handle
      OCISvcCtx* m_ociSvcCtxHandle;

      /// The OCI session handle
      OCISession* m_ociSessionHandle;

      /// The garbage bin of old OCI service context handles (bug #94385)
      std::vector<OCISvcCtx*> m_ociSvcCtxHandleBin;

      /// The garbage bin of old OCI session handles (bug #94385)
      std::vector<OCISession*> m_ociSessionHandleBin;

      /// The monitoring service
      coral::monitor::IMonitoringService* m_monitoringService;

      /// The schema name
      std::string m_schemaName;

      /// The read-only flag
      bool m_isReadOnly;

      /// The mutex lock
      mutable coral::mutex m_mutex;

      /// The mutex lock for the schema (fix bug #80065)
      mutable coral::mutex m_schemaMutex;

      /// The mutex lock for the transaction (fix bug #80174?)
      //mutable coral::mutex m_transactionMutex;

      /// The 'select any table' flag
      mutable bool m_selectAnyTable;

      /// Network glitch: the mutex lock for the transaction status cache
      mutable coral::mutex m_txCacheMutex;

      /// Network glitch: the transaction state cache
      mutable bool m_txCacheIsActive;

      /// Network glitch: the transaction mode cache
      mutable bool m_txCacheIsReadOnly;

      /// Network glitch: the RO transaction serializable mode cache
      mutable bool m_txCacheIsSerializableIfRO;

      /// Network glitch: how many times was the connection restarted so far?
      mutable unsigned long m_nConnectionRestarted;

    };
  }
}


// Inline methods
inline const coral::OracleAccess::DomainProperties&
coral::OracleAccess::SessionProperties::domainProperties() const
{
  return m_connectionProperties->domainProperties();
}


inline const std::string&
coral::OracleAccess::SessionProperties::domainServiceName() const
{
  return m_domainServiceName;
}


inline std::string
coral::OracleAccess::SessionProperties::connectionString() const
{
  return m_connectionProperties->connectionString();
}


inline int
coral::OracleAccess::SessionProperties::majorServerVersion() const
{
  return m_connectionProperties->majorServerVersion();
}


inline void
coral::OracleAccess::SessionProperties::setMonitoringService( coral::monitor::IMonitoringService* monitoringService )
{
  coral::lock_guard lock(m_mutex);
  m_monitoringService = monitoringService;
}


inline coral::monitor::IMonitoringService*
coral::OracleAccess::SessionProperties::monitoringService() const
{
  coral::lock_guard lock(m_mutex);
  return m_monitoringService;
}


inline bool
coral::OracleAccess::SessionProperties::isReadOnly() const
{
  return m_isReadOnly;
}


inline std::string
coral::OracleAccess::SessionProperties::schemaName() const
{
  return m_schemaName;
}

#endif
