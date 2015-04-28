#ifndef MYSQLACCESS_MYSQLDOMAIN_PROPERTIES_H
#define MYSQLACCESS_MYSQLDOMAIN_PROPERTIES_H 1

#include <string>

namespace coral
{
  class ITypeConverter;
  class Service;

  namespace MySQLAccess
  {
    class Domain;
    class TypeConverter;

    /**
     * A simple class holding the global domain properties
     *///

    class DomainProperties
    {
    public:

      /// Constructor
      explicit DomainProperties( coral::MySQLAccess::Domain* service );

      /// Destructor
      ~DomainProperties();

      /// Returns the pointer to the service
      coral::Service* service() const;

      /// The type converter
      coral::ITypeConverter& typeConverter() const;

    private:

      /// Copy constructor is private (fix Coverity MISSING_COPY)
      DomainProperties( const DomainProperties& rhs );

      /// Assignment operator is private (fix Coverity MISSING_ASSIGN)
      DomainProperties& operator=( const DomainProperties& rhs );

    private:

      /// The pointer to the service
      coral::MySQLAccess::Domain*         m_service;

      /// The type converter
      coral::MySQLAccess::TypeConverter*  m_typeConverter;

    };

  }

}
#endif // MYSQLACCESS_MYSQLDOMAIN_PROPERTIES_H
