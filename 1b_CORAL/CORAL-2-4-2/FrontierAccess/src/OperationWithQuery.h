#ifndef FRONTIERACCESS_OPERATIONWITHQUERY_H
#define FRONTIERACCESS_OPERATIONWITHQUERY_H 1

#include <boost/shared_ptr.hpp>
#include <string>
#include "RelationalAccess/IOperationWithQuery.h"

namespace coral
{

  namespace FrontierAccess
  {

    class SessionProperties;
    class QueryDefinition;

    /**
     * Class OperationWithQuery
     *
     * Simple implementation of the IOperationWithQuery interface for the FrontierAccess module
     *///

    class OperationWithQuery : virtual public coral::IOperationWithQuery
    {
    public:

      /// Constructor
      OperationWithQuery( const std::string& sqlPrefix,
                          boost::shared_ptr<const SessionProperties> properties );

      /// Destructor
      virtual ~OperationWithQuery();

      /**
       * Returns a reference to the underlying query definition,
       * so that it can be filled-in by the client.
       *///
      coral::IQueryDefinition& query();

      /**
       * Executes the operation and returns the number of rows affected.
       *///
      long execute();

    private:

      /// Copy constructor is private (fix Coverity MISSING_COPY)
      OperationWithQuery( const OperationWithQuery& rhs );

      /// Assignment operator is private (fix Coverity MISSING_ASSIGN)
      OperationWithQuery& operator=( const OperationWithQuery& rhs );

    private:

      /// The underlying query definition
      QueryDefinition*  m_queryDefinition;

      /// The sql statement that is to be executed
      std::string m_statement;

    };

  }

}
#endif
