#ifndef MYSQLACCESS_BULK_OPERATION_WITH_QUERY_H
#define MYSQLACCESS_BULK_OPERATION_WITH_QUERY_H 1

#include <string>
#include <boost/shared_ptr.hpp>
#include "CoralBase/AttributeList.h"
#include "RelationalAccess/IBulkOperationWithQuery.h"

namespace coral
{
  namespace MySQLAccess
  {
    class BulkOperation;
    class QueryDefinition;
    class SessionProperties;

    /**
     * Class IBulkOperationWithQuery
     * Implementation of the IBulkOperationWithQuery interface
     *///
    class BulkOperationWithQuery : virtual public IBulkOperationWithQuery
    {
    public:

      /// Constructor
      BulkOperationWithQuery( boost::shared_ptr<const SessionProperties> properties,
                              int cacheSize,
                              const std::string& statement );

      /// Destructor
      virtual ~BulkOperationWithQuery();

      /**
       * Returns a reference to the underlying query definition,
       * so that it can be filled-in by the client.
       *///
      coral::IQueryDefinition& query();

      /**
       * Processes the next iteration
       *///
      void processNextIteration();

      /**
       * Flushes the data on the client side to the server.
       *///
      void flush();

    private:

      /// Copy constructor is private (fix Coverity MISSING_COPY)
      BulkOperationWithQuery( const BulkOperationWithQuery& rhs );

      /// Assignment operator is private (fix Coverity MISSING_ASSIGN)
      BulkOperationWithQuery& operator=( const BulkOperationWithQuery& rhs );

    private:

      /// A reference to the sessopm properties
      boost::shared_ptr<const SessionProperties> m_properties;

      /// The cache size
      int m_rowsInCache;

      /// The sql prefix
      std::string m_sqlPrefix;

      /// The query definition object
      QueryDefinition* m_queryDefinition;

      /// The bulk operation
      BulkOperation* m_bulkOperation;

    };

  }

}
#endif
