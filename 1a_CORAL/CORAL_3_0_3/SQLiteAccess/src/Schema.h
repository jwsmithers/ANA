#ifndef SQLITEACCESS_SCHEMA_H
#define SQLITEACCESS_SCHEMA_H 1

// First of all, set/unset CORAL240, CORAL300 and CORAL_HAS_CPP11 macros
#include "CoralBase/VersionInfo.h"

// Include files
#include <map>
#include "RelationalAccess/ISchema.h"
#include <boost/shared_ptr.hpp>

namespace coral
{

  namespace SQLiteAccess
  {

    class Table;
    class View;
    class SessionProperties;
    /**
       @class Schema Schema.h

       Implementation of the ISchema interface for the SQLiteAccess module
    *///

    class Schema : virtual public coral::ISchema
    //           , virtual public coral::ITransactionObserver
    {

    public:

      /// Constructor
      explicit Schema( boost::shared_ptr<const SessionProperties> properties );

      /// Destructor
      virtual ~Schema();

      /**
       * Returns the name of this schema.
       *///
      std::string schemaName() const;

      /**
       * Lists the names of the tables in this schema.
       *///
      std::set<std::string> listTables() const;

      /**
       * Checks for the existence of a table
       *
       * @param name The name of the table whose existence is checked.
       *
       *///
      bool existsTable( const std::string& name ) const;

      /**
       * Creates a table with a given description. Returns a reference to the table object, or throws a RelationalTableNotCreated exception
       *
       * @param name The name of the new table.
       *
       * @param description The description of the new table.
       *
       *///
      coral::ITable& createTable(const coral::ITableDescription& description);

      /**
       * Drops a table from the schema.
       *
       * @param name The name of the table to be dropped.
       *
       *///
      void dropTable( const std::string& name
#ifdef CORAL300CC
                      , bool dropTableCascade = false
#endif
                      );

      /**
       * Drops a table from the schema in case it exists
       *
       * @param name The name of the table to be dropped.
       *
       *///
      void dropIfExistsTable( const std::string& name
#ifdef CORAL300CC
                              , bool dropTableCascade = false
#endif
                              );

      /**
       * Returns a reference to a table object its name. If the table does not exist a RelationalTableNotFound exception is thrown
       *
       * @param name The name of the table.
       *
       *///
      coral::ITable& tableHandle( const std::string& name );

      /**
       * Truncates the data of the the table with the specified name.
       * In case no table with such a name exists, a TableNotExistingException is thrown.
       *///
      void truncateTable( const std::string& tableName );

      /**
       * Calls a stored procedure with input parameters.
       * In case of an error a SchemaException is thrown.
       *///
      void callProcedure( const std::string& procedureName,
                          const coral::AttributeList& inputArguments );
      /**
       * Returns a new object for performing queries involving more than one tables. The user acquires the ownership of this object.
       *///
      coral::IQuery* newQuery() const;

      /**
       * Returns a new view factory object in order to define and create a view.
       *///
      coral::IViewFactory* viewFactory();

      /**
       * Checks the existence of a view with the specified name.
       * @param viewName The name of the view
       *///
      bool existsView( const std::string& viewName ) const;

      /**
       * Drops the view with the specified name.
       * If the view does not exist a ViewNotExistingException is thrown.
       *///
      void dropView( const std::string& viewName );

      /**
       * Drops the view with the specified name in case it exists
       *///
      void dropIfExistsView( const std::string& viewName );

      /**
       * Returns the names of all views in the schema.
       *///
      std::set<std::string> listViews() const;

      /**
       * Returns a reference to an IView object corresponding to the view with the specified name.
       * In case no view with such a name exists, a ViewNotExistingException is thrown.
       *///
      coral::IView& viewHandle( const std::string& viewName );

      /// Reacts on an End-Of-Transaction signal
      void reactOnEndOfTransaction();

    private:

      /// Reads the full table list from the data dictionary
      void readTablesFromDataDictionary() const;

      /// Reads the full view list from the data dictionary
      void readViewsFromDataDictionary() const;

    private:

      /// A shared pointer to the session properties
      boost::shared_ptr<const SessionProperties> m_properties;

      /// table registry
      mutable std::map< std::string, Table* > m_tables;

      /// Flag indicating whether the table list has been read from the data dictionary
      mutable bool m_tablesReadFromDataDictionary;

      /// The map of existing views
      mutable std::map< std::string, View* >  m_views;

      /// Flag indicating whether the view list has been read from the data dictionary
      mutable bool m_viewsReadFromDataDictionary;

    };

  }

}
#endif // SQLITEACCESS_SCHEMA_H
