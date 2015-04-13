// $Id: SchemaEditor.h,v 1.7 2012-03-06 16:20:40 avalassi Exp $
#ifndef CORAL_MYSQLACCESS_SCHEMAEDITOR_H
#define CORAL_MYSQLACCESS_SCHEMAEDITOR_H 1

#include <set>
#include <string>

namespace coral
{
  namespace MySQLAccess
  {
    class SessionProperties;
    class ISchemaProperties;

    /** The class allows to physically perform schema ("database" in MySQL jargon) inspection *///
    struct SchemaEditor
    {
      /// Constructor
      SchemaEditor( boost::shared_ptr<const SessionProperties> sessionProperties, ISchemaProperties& schemaProperties );
      /// Get the list of table for the current schema from the db server
      std::set<std::string> listTables();
      /// Wipe out all the rows in the table in the current schema
      void truncateTable( const std::string& );
      /// Drop the table in the current schema
      void dropTable( const std::string& );
      /// Create the table in the current schema
      void createTable( const std::string&, const std::string& );
      /// The session properties
      boost::shared_ptr<const SessionProperties> m_sessionProperties;
      /// The schema properties
      ISchemaProperties&  m_schemaProperties;
    };
  }
}

#endif // CORAL_MYSQLACCESS_SCHEMAEDITOR_H
