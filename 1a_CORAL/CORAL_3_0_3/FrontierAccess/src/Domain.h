#ifndef FRONTIERACCESS_DOMAIN_H
#define FRONTIERACCESS_DOMAIN_H 1

#include "CoralKernel/Service.h"
#include "RelationalAccess/IRelationalDomain.h"

namespace coral
{

  class IConnection;
  class IConnectionService;

  namespace FrontierAccess
  {
    class DomainProperties;

    /**
       @class Domain Domain.h
       Implementation of the IRelationalDomain interface for FrontierAccess
    *///

    class Domain : public coral::Service, public coral::IRelationalDomain
    {
    public:

      /// Standard Constructor
      Domain( const std::string& componentName );

      /// Standard Destructor
      virtual ~Domain();

      /// Returns the name of the RDBMS technology
      virtual std::string flavorName() const;

      /// Returns the name of the software implementation library
      virtual std::string implementationName() const;

      /// Returns the version of the software implementation library
      virtual std::string implementationVersion() const;

      /// Creates a new connection object
      virtual coral::IConnection* newConnection( const std::string& uriString ) const;

      /**
       * Decodes the user connection string into the real connection string
       * that should be passed to the Connection class and the schema name
       * that should be passed to the Session class
       *///
      virtual std::pair<std::string, std::string >
      decodeUserConnectionString( const std::string& userConnectionString ) const;

      /**
       * Returns true if credentials have to be provided to start a session on the specified connection
       *///
      virtual bool isAuthenticationRequired( const std::string& /*connectionString*/ ) const
      {
        return false;
      }

      /// Sets the table space for the tables
      void setTableSpaceForTables( const std::string& tableSpace );

      /// Sets the table space for the indices
      void setTableSpaceForIndices( const std::string& tableSpace );

      /// Sets the table space for the lobs
      void setTableSpaceForLobs( const std::string& tableSpace );

      /// Sets the lob chunk size
      void setLobChunkSize( int lobChunkSize );

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
      DomainProperties* m_domainProperties;

    };

  }

}
#endif
