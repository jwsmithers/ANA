#ifndef SQLITEACCESS_BULKOPERATIONWITHQUERY_H
#define SQLITEACCESS_BULKOPERATIONWITHQUERY_H 1

#include <string>
#include <vector>
#include <boost/shared_ptr.hpp>
#include "RelationalAccess/IBulkOperationWithQuery.h"

namespace coral
{
  namespace SQLiteAccess
  {
    class BulkOperation;
    class QueryDefinition;
    class SessionProperties;
    /**
       @class BulkOperationWithQuery BulkOperationWithQuery.h
       Implementation of the IBulkOperationWithQuery interface for the SQLiteAccess plugin
       @author Zhen Xie
    *///

    class BulkOperationWithQuery : virtual public coral::IBulkOperationWithQuery {
    public:

      /// Constructor
      BulkOperationWithQuery(boost::shared_ptr<const SessionProperties> properties,
                             int cacheSize,
                             const std::string& statement);

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
      QueryDefinition*            m_queryDefinition;

      /// The bulk operation
      BulkOperation*              m_bulkOperation;

    };

  }

}
#endif
