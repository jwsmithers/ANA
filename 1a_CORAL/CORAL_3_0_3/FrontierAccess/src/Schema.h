#ifndef FRONTIER_ACCESS_SCHEMA_H
#define FRONTIER_ACCESS_SCHEMA_H 1

// First of all, set/unset CORAL240, CORAL300 and CORAL_HAS_CPP11 macros
#include "CoralBase/VersionInfo.h"

// Include files
#include <map>
#include <vector>
#include "RelationalAccess/ISchema.h"
#include "ITransactionObserver.h"

namespace coral
{
  namespace FrontierAccess
  {
    class SessionProperties;
    class Table;
    class View;

    /**
     * Class Schema
     *
     * Implementation of the ISchema interface for the FrontierAccess package
     *///
    class Schema : virtual public coral::ISchema,
                   virtual public ITransactionObserver
    {
    public:
      /// Constructor
      explicit Schema( boost::shared_ptr<const SessionProperties> sessionProperties,
                       const std::string& schemaName );

      /// Destructor
      virtual ~Schema();

      /**
       * Returns the names of all tables in the schema.
       *///
      std::set<std::string> listTables() const;

      /*
       * Returns the name of this schema.
       *///
      std::string schemaName() const;

      /**
       * Checks the existence of a table with the specified name.
       *///
      bool existsTable( const std::string& tableName ) const;

      /**
       * Drops the table with the specified name.
       * If the table does not exist a TableNotExistingException is thrown.
       *///
      void dropTable( const std::string& tableName
#ifdef CORAL300CC
                      , bool dropTableCascade = false
#endif
                      );

      /**
       * Drops the table with the specified name in case it exists.
       *///
      void dropIfExistsTable( const std::string& tableName
#ifdef CORAL300CC
                              , bool dropTableCascade = false
#endif
                              );

      /**
       * Creates a new table with the specified description and returns the corresponding table handle.
       * If a table with the same name already exists TableAlreadyExistingException is thrown.
       *///
      coral::ITable& createTable( const coral::ITableDescription& description );

      /**
       * Returns a reference to an ITable object corresponding to the table with the specified name.
       * In case no table with such a name exists, a TableNotExistingException is thrown.
       *///
      coral::ITable& tableHandle( const std::string& tableName );

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
       * Returns a new query object.
       *///
      coral::IQuery* newQuery() const;

      /**
       * Returns a new view factory object in order to define and create a view.
       *///
      coral::IViewFactory* viewFactory();

      /**
       * Checks the existence of a view with the specified name.
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

      /**
       * Returns vector of column names for the table with the specified name.
       * In case no table with such a name exists, a TableNotExistingException is thrown.
       *///
      const std::vector< std::string >* tableColumns( const std::string& tableName );

      /// Reacts on an End-Of-Transaction signal
      void reactOnEndOfTransaction();

    private:
      /// Reads the column names for table with the specified name, or all
      ///   tables if the name is the empty string
      void readTableColumns(const std::string& tableName ) const;

      /// Reads the full view list from the data dictionary
      void readViewsFromDataDictionary() const;

    private:
      /// The session properties
      boost::shared_ptr<const SessionProperties> m_sessionProperties;

      /// The schema name for this schema
      const std::string m_schemaName;

      /// The map of existing tables
      mutable std::map< std::string, Table* > m_tables;

      /// Set of known not-existing tables
      mutable std::set< std::string > m_notExistingTables;

      /// Map of table names to vector of column names
      mutable std::map< std::string, std::vector< std::string >* > m_tableColumns;
      /// The map of existing views
      mutable std::map< std::string, View* >  m_views;

      /// Set of known not-existing views
      mutable std::set< std::string > m_notExistingViews;

      /// Flag indicating whether the view list has been read from the data dictionary
      mutable bool m_viewsReadFromDataDictionary;
    };
  }
}

#endif
