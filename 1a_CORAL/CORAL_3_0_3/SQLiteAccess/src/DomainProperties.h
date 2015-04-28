#ifndef SQLITEACCESS_DOMAINPROPERTIES_H
#define SQLITEACCESS_DOMAINPROPERTIES_H 1

#include <string>
#include "CoralBase/../src/coral_thread_headers.h"

namespace coral
{
  class Service;
}

namespace coral
{
  namespace SQLiteAccess
  {

    /**
     * A simple class holding the global domain properties
     *///

    class DomainProperties
    {
    public:

      /// Constructor
      explicit DomainProperties( coral::Service* service );

      /// Destructor
      ~DomainProperties();

      /// Returns the pointer to the service
      coral::Service* service() const;

      /// Returns the mutex
      coral::mutex* mutex() const { return m_mutex; }

    private:

      /// Copy constructor is private (fix Coverity MISSING_COPY)
      DomainProperties( const DomainProperties& rhs );

      /// Assignment operator is private (fix Coverity MISSING_ASSIGN)
      DomainProperties& operator=( const DomainProperties& rhs );

    private:

      /// The pointer to the service
      coral::Service*       m_service;

      /// The mutex
      coral::mutex* m_mutex;

    };

  }

}


inline coral::Service*
coral::SQLiteAccess::DomainProperties::service() const
{
  return m_service;
}

#endif
