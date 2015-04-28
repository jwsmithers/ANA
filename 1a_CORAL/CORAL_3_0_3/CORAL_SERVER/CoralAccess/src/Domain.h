#ifndef CORALACCESS_DOMAIN_H
#define CORALACCESS_DOMAIN_H 1

// Include files
//#include "CoralMonitor/CsvStatsReporter.h"
#include "CoralKernel/Service.h"
#include "RelationalAccess/IRelationalDomain.h"

namespace coral
{

  namespace CoralAccess
  {

    // Forward declaration
    class DomainProperties;

    /** @class Domain
     *
     *  Stripped-down version of the OracleAccess Domain class.
     *
     *  @author Andrea Valassi
     *  @date   2007-12-05
     *///

    class Domain : public Service, virtual public IRelationalDomain
    {

    public:

      /// Service constructor from the service name.
      Domain( const std::string& key );

      /// Destructor
      virtual ~Domain();

      /// Returns the name of the RDBMS technology
      std::string flavorName() const;

      /// Returns the name of the software implementation library
      std::string implementationName() const;

      /// Returns the version of the software implementation library
      std::string implementationVersion() const;

      /// Creates a new session object. The user acquires ownership of this object.
      IConnection* newConnection( const std::string& uriString ) const;

      /**
       * Decodes the user connection string into the real connection
       * string that should be passed to the Connection class and
       * the schema name that should be passed to the Session class
       *///
      std::pair<std::string, std::string >
      decodeUserConnectionString( const std::string& userConnectionString ) const;

      /**
       * Returns true if credentials have to be provided to start a session on
       * the specified connection. For the CoralAccess plugin it's always false
       * (authentication mechanisms are hardcoded, eg use X509_USER_PROXY).
       *///
      bool isAuthenticationRequired( const std::string& /*connectionString*/ ) const
      {
        return false;
      }

    private:

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
      DomainProperties*    m_properties;

      /// The CSV reporter for monitoring statistics
      //CsvStatsReporter*    m_csvReporter;

    };

  }

}
#endif // CORALACCESS_DOMAIN_H
