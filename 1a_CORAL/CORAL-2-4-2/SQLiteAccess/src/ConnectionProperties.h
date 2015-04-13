#ifndef SQLITEACCESS_CONNECTIONPROPERTIES_H
#define SQLITEACCESS_CONNECTIONPROPERTIES_H 1

#include <string>
#include "CoralBase/boost_filesystem_headers.h"
#include "CoralBase/../src/coral_thread_headers.h"

namespace coral
{

  // Forward declaration
  class ITypeConverter;

  namespace SQLiteAccess
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
                            //Connection& connection,
                            const std::string& connectionString );

      /// Destructor
      virtual ~ConnectionProperties();


      /// Mark the connection as deleted ("nullify" connection - bug #73834)
      /// [NB "invalidate" is used in IDevSession for connection sharing]
      //void nullifyConnection();

      /// Sets the read-only flag
      void setReadOnly( bool flag );

      /// Sets the database file name
      void setFileName( const boost::filesystem::path& inFileName );

      /// Returns the database file name
      boost::filesystem::path databaseFileName() const;

      /// Returns the domain properties
      const DomainProperties& domainProperties() const;

      /// Returns the domain service name
      const std::string& domainServiceName() const;

      /// Returns the connection string
      std::string connectionString() const;

      /// Returns the connection object
      //Connection& connection() const;

      /// Returns the type converter
      coral::ITypeConverter& typeConverter();

      /// Returns the type converter
      const coral::ITypeConverter& typeConverter() const;

      /// Returns the readOnly flag
      bool isReadOnly() const;

      /// Returns the mutex
      coral::mutex* mutex() const { return m_mutex; };

    private:

      /// Copy constructor is private (fix Coverity MISSING_COPY)
      ConnectionProperties( const ConnectionProperties& rhs );

      /// Assignment operator is private (fix Coverity MISSING_ASSIGN)
      ConnectionProperties& operator=( const ConnectionProperties& rhs );

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

      /// The read-only flag
      bool m_isReadOnly;

      /// The sqlite file name
      boost::filesystem::path m_inFileName;

      /// The connection pointer (NULL if the connection has been nullified)
      //Connection* m_connection;

      // The mutex
      coral::mutex* m_mutex;

      /// The server version
      //std::string m_serverVersion;
    };

  }

}


/*
inline void
coral::SQLiteAccess::ConnectionProperties::nullifyConnection()
{
  m_connection = NULL;
}
*///


inline const coral::SQLiteAccess::DomainProperties&
coral::SQLiteAccess::ConnectionProperties::domainProperties() const
{
  return m_domainProperties;
}


inline const std::string&
coral::SQLiteAccess::ConnectionProperties::domainServiceName() const
{
  return m_domainServiceName;
}


inline std::string
coral::SQLiteAccess::ConnectionProperties::connectionString() const
{
  return m_connectionString;
}


inline bool
coral::SQLiteAccess::ConnectionProperties::isReadOnly() const
{
  return m_isReadOnly;
}


inline void
coral::SQLiteAccess::ConnectionProperties::setReadOnly( bool flag )
{
  m_isReadOnly = flag;
}


inline void
coral::SQLiteAccess::ConnectionProperties::setFileName( const boost::filesystem::path& inFileName )
{
  m_inFileName = inFileName;
}


inline boost::filesystem::path
coral::SQLiteAccess::ConnectionProperties::databaseFileName() const
{
  return m_inFileName;
}

#endif
