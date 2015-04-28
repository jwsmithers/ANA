#ifndef ORACLEACCESS_SCHEMA_H
#define ORACLEACCESS_SCHEMA_H 1

// First of all, set/unset CORAL240, CORAL300 and CORAL_HAS_CPP11 macros
#include "CoralBase/VersionInfo.h"

// Include files
#include <map>
#include <boost/shared_ptr.hpp>
#include "CoralBase/../src/coral_thread_headers.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/SchemaException.h"
#include "ITransactionObserver.h"

namespace coral
{

  namespace OracleAccess
  {

    class SessionProperties;
    class Table;
    class View;

    /**
     * Class Schema
     *
     * Implementation of the ISchema interface for the OracleAccess package
     *///
    class Schema : virtual public coral::ISchema,
                   virtual public ITransactionObserver
    {
    public:
      /// Constructor
      explicit Schema( boost::shared_ptr<const SessionProperties> properties,
                       const std::string& schemaName );

      /// Destructor
      virtual ~Schema();

      /**
       * Returns the name of this schema.
       *///
      std::string schemaName() const;

      /**
       * Returns the names of all tables in the schema.
       *///
      std::set<std::string> listTables() const;

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

      /// Reacts on an End-Of-Transaction signal
      void reactOnEndOfTransaction();

      /// Initialize this schema because the user session has started
      /// (previously this is when the schema was created - bug #80178)
      void startUserSession();

      /// Finalize this schema because the user session has ended
      /// (previously this is when the schema was deleted - bug #80178)
      void endUserSession();

    private:
      /// Reads the full table list from the data dictionary
      void readTablesFromDataDictionary() const;

      /// Reads the full view list from the data dictionary
      void readViewsFromDataDictionary() const;

      /// Returns the table name for a synonym. If the synonym is not defined for a table an empty string is returned
      std::string synonymForTable( const std::string& tableName ) const;

    private:
      /// The session properties
      boost::shared_ptr<const SessionProperties> m_sessionProperties;

      /// The schema name for this schema
      const std::string m_schemaName;

      /// The map of existing tables
      mutable std::map< std::string, Table* > m_tables;

      /// Flag indicating whether the table list has been read from the data dictionary
      mutable bool m_tablesReadFromDataDictionary;

      /// The map of existing views
      mutable std::map< std::string, View* >  m_views;

      /// Flag indicating whether the view list has been read from the data dictionary
      mutable bool m_viewsReadFromDataDictionary;

      /// The mutex protecting the table map
      mutable coral::mutex m_tableMutex;

      /// The mutex protecting the view map
      mutable coral::mutex m_viewMutex;

      /// Has the user session started/ended?
      bool m_userSessionStarted; // related to bug #80178

    public:

      /// InvalidViewException for ORA-24372 (bug #92418)
      class InvalidViewException : public coral::SchemaException
      {
      public:
        InvalidViewException( const std::string& moduleName,
                              const std::string& viewName ) :
          SchemaException( moduleName, "A view named \"" + viewName + "\" exists but is invalid (ORA-24372)", "ISchema::existsView" ) {}
        virtual ~InvalidViewException() throw() {}
      };

    };

  }

}

#endif
