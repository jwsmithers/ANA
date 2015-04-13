#ifndef ORACLE_CONNECTION_PROPERTIES_H
#define ORACLE_CONNECTION_PROPERTIES_H 1

// Switch on/off debugging for Create/Delete all objects (bug #98736)
//#define ORACLE_CONNECTION_PROPERTIES_DEBUG 1
#undef ORACLE_CONNECTION_PROPERTIES_DEBUG

#include <string>
#include <vector>
#include "CoralBase/../src/coral_thread_headers.h"

struct OCIEnv;
struct OCIError;
struct OCIServer;

namespace coral
{
  class ITypeConverter;

  namespace OracleAccess
  {
    class Connection;
    class DomainProperties;
    class TypeConverter;

    /**
     * Class ConnectionProperties
     *
     * A class holding the running parameters of a database connection
     *///

    class ConnectionProperties
    {

    public:

      /// Constructor
      ConnectionProperties( const DomainProperties& domainProperties,
                            const std::string& connectionString,
                            Connection& connection );

      /// Destructor
      virtual ~ConnectionProperties();

      /// Mark the connection as deleted ("nullify" connection - bug #73834)
      /// [NB "invalidate" is used in IDevSession for connection sharing]
      void nullifyConnection();

      /// Sets the OCI handles
      void setHandles( OCIEnv* ociEnvHandle,
                       OCIError* ociErrorHandle,
                       OCIServer* ociServerHandle );

      /// Returns the domain properties
      const DomainProperties& domainProperties() const;

      /// Returns the domain service name
      const std::string& domainServiceName() const;

      /// Returns the connection string
      std::string connectionString() const;

      /// Returns the type converter
      coral::ITypeConverter& typeConverter();

      /// Returns the type converter (const)
      const coral::ITypeConverter& typeConverter() const;

      /// Returns the OCI environment handle
      OCIEnv* ociEnvHandle() const;

      /// Returns the OCI error handle
      OCIError* ociErrorHandle() const;

      /// Returns the OCI server handle
      OCIServer* ociServerHandle( bool reconnect=true ) const;

      /// Returns the server version
      std::string serverVersion();

      /// Returns the major server version
      int majorServerVersion();

      /// Returns the mutex for this connection
      //coral::mutex& connectionMutex() const;

      /// NetworkGlitch: is the current connection down?
      bool wasConnectionLost();

      /// NetworkGlitch: reconnect with time out
      bool restartConnectionWithTimeOut();

      /// NetworkGlitch: how many times was the connection restarted
      unsigned long nRestarted();

    private:

      /// Returns the connection object
      //Connection& connection() const; // TO BE CHECKED...

      /// Copy constructor is private (fix Coverity MISSING_COPY)
      ConnectionProperties( const ConnectionProperties& rhs );

      /// Assignment operator is private (fix Coverity MISSING_ASSIGN)
      ConnectionProperties& operator=( const ConnectionProperties& rhs );

      /// Fetch server version if not already done and resets type converter
      void fetchServerVersion();

    private:

      /// The domain properties
      const DomainProperties& m_domainProperties;

      /// The domain service name (this is retrieved from DomainProperties
      /// only in the ctor and can be used in the dtor - fix bug #71210)
      const std::string m_domainServiceName;

      /// The connection string
      std::string m_connectionString;

      /// The type converter
      TypeConverter* m_typeConverter;

      /// The OCI environment handle
      OCIEnv* m_ociEnvHandle;

      /// The OCI error handle
      OCIError* m_ociErrorHandle;

      /// The OCI server handle
      OCIServer* m_ociServerHandle;

      /// The garbage bin of old OCI environment handles (bug #94385)
      std::vector<OCIEnv*> m_ociEnvHandleBin;

      /// The garbage bin of old OCI error handles (bug #94385)
      std::vector<OCIError*> m_ociErrorHandleBin;

      /// The garbage bin of old OCI server handles (bug #94385)
      std::vector<OCIServer*> m_ociServerHandleBin;

      /// The server version (e.g. 11.2.0.3.0)
      std::string m_serverVersion;

      /// The major server version (e.g. 11)
      int m_majorServerVersion;

      /// The connection pointer (NULL if the connection has been nullified)
      Connection* m_connection;

      /// The external mutex lock (over OCI calls on shared connections).
      //mutable coral::mutex m_connectionMutex;

      /// The internal mutex lock (over the connection properties).
      mutable coral::mutex m_mutex;

      /// NetworkGlitch: how many times was the connection restarted
      unsigned long m_nRestarted;

    };
  }
}


// Inline methods
inline void
coral::OracleAccess::ConnectionProperties::nullifyConnection()
{
  m_connection = NULL;
}


inline const coral::OracleAccess::DomainProperties&
coral::OracleAccess::ConnectionProperties::domainProperties() const
{
  return m_domainProperties;
}


inline const std::string&
coral::OracleAccess::ConnectionProperties::domainServiceName() const
{
  return m_domainServiceName;
}


inline std::string
coral::OracleAccess::ConnectionProperties::connectionString() const
{
  return m_connectionString;
}


inline OCIEnv*
coral::OracleAccess::ConnectionProperties::ociEnvHandle() const
{
  coral::lock_guard lock( m_mutex );
  return m_ociEnvHandle;
}


inline OCIError*
coral::OracleAccess::ConnectionProperties::ociErrorHandle() const
{
  coral::lock_guard lock( m_mutex );
  return m_ociErrorHandle;
}


/*
inline coral::mutex&
coral::OracleAccess::ConnectionProperties::connectionMutex() const
{
  return m_connectionMutex;
}
*///

#endif
