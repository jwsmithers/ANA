#ifndef FRONTIERACCESS_TABLE_H
#define FRONTIERACCESS_TABLE_H 1

#include <string>
#include <boost/shared_ptr.hpp>
#include "RelationalAccess/ITable.h"

namespace coral
{

  namespace FrontierAccess
  {

    class SessionProperties;
    class TableDescriptionProxy;

    /**
     * Class Table
     *
     * Implementation of the ITable interface for the FrontierAccess package
     *///
    class Table : virtual public coral::ITable
    {
    public:

      /// Constructor
      Table( boost::shared_ptr<const SessionProperties> sessionProperties,
             const std::string& tableName );

      /// Destructor
      virtual ~Table();

      /**
       * Returns the description of the table.
       *///
      const coral::ITableDescription& description() const;

      /**
       * Returns a reference to the schema editor for the table.
       *///
      coral::ITableSchemaEditor& schemaEditor();

      /**
       * Returns a reference to the ITableDataEditor object  for the table.
       *///
      coral::ITableDataEditor& dataEditor();

      /**
       * Returns a reference to the privilege manager of the table.
       *///
      coral::ITablePrivilegeManager& privilegeManager();

      /**
       * Returns a new query object for performing a query involving this table only.
       *///
      coral::IQuery* newQuery() const;

    private:

      /// Copy constructor is private (fix Coverity MISSING_COPY)
      Table( const Table& rhs );

      /// Assignment operator is private (fix Coverity MISSING_ASSIGN)
      Table& operator=( const Table& rhs );

    private:

      /// The session properties
      boost::shared_ptr<const SessionProperties> m_sessionProperties;

      /// The proxy to the table description
      TableDescriptionProxy* m_descriptionProxy;

    };

  }

}
#endif
