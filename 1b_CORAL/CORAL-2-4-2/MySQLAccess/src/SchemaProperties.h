// $Id: SchemaProperties.h,v 1.7 2012-03-06 16:20:40 avalassi Exp $
#ifndef MYSQLACCESS_SCHEMAPROPERTIES_H
#define MYSQLACCESS_SCHEMAPROPERTIES_H 1

#include "ISchemaProperties.h"

namespace coral
{
  namespace MySQLAccess
  {
    class SessionProperties;
    class Schema;

    /** Class coral::MySQLAccess::SchemaProperties
     *  Implements the registry of schema properties and its schema objects
     *///
    class SchemaProperties : virtual public ISchemaProperties
    {
    public:
      SchemaProperties( boost::shared_ptr<const SessionProperties>, const std::string&, Schema& );
      virtual ~SchemaProperties();

      /// Return the schema name
      virtual std::string schemaName() const;
      /// Return cached names of the tables
      virtual std::set<std::string>& tableNames();
      /// Return cached names of the views
      virtual std::set<std::string>& viewNames();
      /// Return the registry of table descriptions
      virtual TableDescriptionRegistry& tableDescriptionRegistry();
      /// Return the registry of tables
      virtual TableRegistry& tableRegistry();
      /// Return table description by table name
      virtual coral::TableDescription& tableDescription( const std::string& );
      /// Return table description by table name
      virtual const coral::ITableDescription& tableDescription( const std::string& ) const;

    private:
      SchemaProperties();
      SchemaProperties( const SchemaProperties& );

    private:
      /// The session properties
      boost::shared_ptr<const SessionProperties> m_sessprops;
      /// Current schema name
      std::string m_schemaName;
      /// Current schema
      Schema&                   m_schema;
      /// Cached table names
      std::set<std::string>     m_tableNames;
      /// Cached view names
      std::set<std::string>     m_viewNames;
      /// Currently opened table descriptions
      TableDescriptionRegistry m_tableDescriptions;
      /// Currently opened table handles
      TableRegistry m_tables;
    };
  }
}

#endif // MYSQLACCESS_SCHEMAPROPERTIES_H
