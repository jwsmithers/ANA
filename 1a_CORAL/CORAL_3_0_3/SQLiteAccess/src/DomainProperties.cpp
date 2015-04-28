#include "CoralBase/../src/coral_thread_headers.h"
#include "DomainProperties.h"

namespace coral
{
  namespace SQLiteAccess
  {

    DomainProperties::DomainProperties( coral::Service* service )
      : m_service( service )
      , m_mutex( new coral::mutex() )
    {
    }


    DomainProperties::~DomainProperties()
    {
      delete m_mutex;
    }

  }
}
