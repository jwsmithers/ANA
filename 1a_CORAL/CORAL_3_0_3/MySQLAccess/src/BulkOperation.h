#ifndef MYSQLACCESS_BULK_OPERATION_H
#define MYSQLACCESS_BULK_OPERATION_H 1

#include <string>
#include <vector>
#include <boost/shared_ptr.hpp>
#include "RelationalAccess/IBulkOperation.h"

#include "BulkDataCache.h"

namespace coral
{
  class AttributeList;

  namespace MySQLAccess
  {

    class SessionProperties;
    class Statement;

    /**
     * Class BulkOperation
     *
     * Implementation of the IBulkOperation interface
     *///

    class BulkOperation : virtual public coral::IBulkOperation
    {
    public:

      /// Constructor
      BulkOperation( boost::shared_ptr<const SessionProperties> properties, const coral::AttributeList& inputBuffer, int cacheSize, const std::string& statement );

      /// Destructor
      virtual ~BulkOperation();

      /**
       * Processes the next iteration
       *///
      void processNextIteration();

      /**
       * Flushes the data on the client side to the server.
       *///
      void flush();

    private:

      /// Resets the operation and closes the statement handle
      void reset();

      /// Copy constructor is private (fix Coverity MISSING_COPY)
      BulkOperation( const BulkOperation& rhs );

      /// Assignment operator is private (fix Coverity MISSING_ASSIGN)
      BulkOperation& operator=( const BulkOperation& rhs );

    private:

      /// A reference to the sessopm properties
      boost::shared_ptr<const SessionProperties>         m_sessionProperties;

      /// The OCI statement handle
      coral::MySQLAccess::Statement*    m_statement;

      /// Data buffer
      coral::MySQLAccess::BulkDataCache m_data;

    };

  }

}
#endif
