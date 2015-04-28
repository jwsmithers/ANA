#ifndef MYSQLACCESS_MYSQLDOMAIN_H
#define MYSQLACCESS_MYSQLDOMAIN_H 1

#include "CoralKernel/Service.h"
#include "RelationalAccess/IRelationalDomain.h"

namespace coral
{
  class IConnection;

  namespace MySQLAccess
  {

    class DomainProperties;

    /**
       @class Domain Domain.h

       Implementation of the IRelationalDomain interface for the MySQLAccess module
    *///

    class Domain : public coral::Service,
                   public virtual coral::IRelationalDomain
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

      std::pair<std::string, std::string> decodeUserConnectionString(const std::string&) const;

      bool isAuthenticationRequired(const std::string&) const
      {
        return true;
      }

    private:

      /// Copy constructor is private (fix Coverity MISSING_COPY)
      Domain( const Domain& rhs );

      /// Assignment operator is private (fix Coverity MISSING_ASSIGN)
      Domain& operator=( const Domain& rhs );

      /// Perform service internal setup
      void initializeDomain();

    private:

      /// The flavor name
      std::string m_flavorName;

      /// The name of the software implementation library
      std::string m_implementationName;

      /// The version of the software implementation library
      std::string m_implementationVersion;

      /// The domain properties
      coral::MySQLAccess::DomainProperties* m_properties;

      /// Is it initialized?
      bool m_initialized;

    };

  }

}
#endif // MYSQLACCESS_MYSQLDOMAIN_H
