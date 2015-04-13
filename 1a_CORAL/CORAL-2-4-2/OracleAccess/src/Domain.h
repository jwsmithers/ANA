#ifndef ORACLEACCESS_ORACLEDOMAIN_H
#define ORACLEACCESS_ORACLEDOMAIN_H 1

#include "CoralKernel/Service.h"
#include "RelationalAccess/IRelationalDomain.h"

namespace coral
{

  namespace OracleAccess
  {

    class DomainProperties;

    /**
       @class Domain Domain.h
       Implementation of the IRelationalDomain interface for OracleAccess
    *///

    class Domain : public coral::Service,
                   virtual public coral::IRelationalDomain
    {
    public:

      /// Standard Constructor
      Domain( const std::string& componentName );

      /// Standard Destructor
      virtual ~Domain();

      /// Returns the name of the RDBMS technology
      std::string flavorName() const;

      /// Returns the name of the software implementation library
      std::string implementationName() const;

      /// Returns the version of the software implementation library
      std::string implementationVersion() const;

      /// Creates a new session object.
      /// The user acquires ownership of this object.
      coral::IConnection* newConnection( const std::string& uriString ) const;

      /// Sets the table space for the tables
      void setTableSpaceForTables( const std::string& tableSpace );

      /// Sets the table space for the indices
      void setTableSpaceForIndices( const std::string& tableSpace );

      /// Sets the table space for the lobs
      void setTableSpaceForLobs( const std::string& tableSpace );

      /// Sets the lob chunk size
      void setLobChunkSize( int lobChunkSize );

      /**
       * Decodes the user connection string into the real connection string
       * that should be passed to the Connection class
       * and the schema name that should be passed to the Session class
       *///
      std::pair<std::string, std::string > decodeUserConnectionString( const std::string& userConnectionString ) const;

      /**
       * Returns true if credentials have to be provided to start a session on the specified connection.
       * For the oracle plugin this is always true.
       *///
      bool isAuthenticationRequired( const std::string& ) const
      {
        return true;
      }

    private:

      void setProperties();

      /// Copy constructor is private (fix Coverity MISSING_COPY)
      Domain( const Domain& rhs );

      /// Assignment operator is private (fix Coverity MISSING_ASSIGN)
      Domain& operator=( const Domain& rhs );

    private:

      /// The flavor name
      std::string m_flavorName;

      /// The name of the software implementation library
      std::string m_implementationName;

      /// The version of the software implementation library
      std::string m_implementationVersion;

      /// The domain properties
      DomainProperties* m_properties;

    };

  }

}
#endif
