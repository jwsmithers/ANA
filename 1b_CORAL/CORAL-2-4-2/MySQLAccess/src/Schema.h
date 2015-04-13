// $Id: Schema.h,v 1.30 2012-06-20 15:36:00 avalassi Exp $
#ifndef MYSQLACCESS_SCHEMA_H
#define MYSQLACCESS_SCHEMA_H 1

#include "CoralBase/../src/coral_thread_headers.h"
#include "RelationalAccess/ISchema.h"
#include "ITransactionObserver.h"

namespace coral
{
  namespace MySQLAccess
  {

    class SessionProperties;
    class ISchemaProperties;

    /**
     * Class Schema
     *
     * Implementation of the ISchema interface for the MySQLAccess package
     *///
    class Schema : virtual public coral::ISchema,
                   virtual public ITransactionObserver
    {
    public:

      /// Constructor
      explicit Schema( boost::shared_ptr<const SessionProperties> properties,
                       const std::string& );

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
       * Flag to invalidate cached schema metadata
       *///
      void setTableListStale();

      /**
       * Checks the existence of a table with the specified name.
       *///
      bool existsTable( const std::string& tableName ) const;

      /**
       * Drops the table with the specified name.
       * If the table does not exist a TableNotExistingException is thrown.
       *///
      void dropTable( const std::string& tableName );

      /**
       * Drops the table with the specified name in case it exists.
       *///
      void dropIfExistsTable( const std::string& tableName );

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

    private:

      /// Copy constructor is private (fix Coverity MISSING_COPY)
      Schema( const Schema& rhs );

      /// Assignment operator is private (fix Coverity MISSING_ASSIGN)
      Schema& operator=( const Schema& rhs );

    private:
      /// The session properties
      boost::shared_ptr<const SessionProperties> m_sessionProperties;
      /// The schema properties & objects registry
      ISchemaProperties*         m_schemaProperties;
      /// Flag inidicating that list of tables has been retrieved
      mutable bool m_tableListFresh;
      /// Flag inidicating that description of tables has been retrieved from DB server
      mutable bool m_tableDescriptionFresh;
      /// Schema lock
      mutable coral::mutex m_lock;
    };
  }
}
#endif // MYSQLACCESS_SCHEMA_H
