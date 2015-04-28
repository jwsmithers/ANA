#ifndef CORAL_MYSQLACCESS_TABLESCHEMALOADER_H
#define CORAL_MYSQLACCESS_TABLESCHEMALOADER_H 1

#include <string>
#include <vector>
#include <boost/shared_ptr.hpp>

namespace coral
{
  class TableDescription;

  namespace MySQLAccess
  {
    class SessionProperties;
    class ISchemaProperties;

    struct ForeignKeyConstraint
    {
      std::string FKCname;
      std::vector<std::string> FKcolumns;
      std::string PKtable;
      std::vector<std::string> PKcolumns;
    };

    typedef std::vector<ForeignKeyConstraint> FKConstraints;

    /**
     * Class TableSchemaLoader
     * Provides means of altering the schema of an existing table
     * FIXME - refactor it!
     * FIXME - Make this abstract interface ITableSchemaLoader & provide
     * FIXME - MySQL 4.0, 4.1 and 5.0 versions
     *///
    class TableSchemaLoader
    {
    public:
      /**
       * Constructor
       *///
      TableSchemaLoader( coral::TableDescription& description, boost::shared_ptr<const SessionProperties> sessionProperties, ISchemaProperties& schemaProperties );

      /**
       * Destructor
       *///
      ~TableSchemaLoader();

      /**
       * Peforms complete reload of table schema metadata from database server, assumes empty target table description object
       *///
      void refreshTableDescription();

      /**
       * Loads the table columns metadata from the database
       *///
      void loadTableColumnsDescriptions();

      /**
       * Loads the table index metadata from the database
       *///
      void loadIndexDescriptions();

      /**
       * Loads the table foreign keys metadata from the database
       *///
      void loadForeignKeyDescriptions();

      void retrieveTableDDL( std::string& tableDDL );

      FKConstraints parseFKConstraints( const std::string& tableDDL );

      FKConstraints parseFKConstraints40( const std::string& tableDDL );

    private:
      /// Table name
      std::string m_tableName;
      /// Schema name / shortcut :->
      std::string m_schemaName;
      /// Session properties
      boost::shared_ptr<const SessionProperties> m_sessionProperties;
      /// Current table schema to be refreshed from database
      coral::TableDescription&  m_description;
    };
  }
}

#endif // CORAL_MYSQLACCESS_TABLESCHEMALOADER_H
