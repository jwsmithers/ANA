// $Id: SchemaEditor.cpp,v 1.28 2012-03-06 16:56:49 avalassi Exp $
#include "MySQL_headers.h"

#include "CoralBase/MessageStream.h"
#include "CoralBase/../src/coral_thread_headers.h"
#include "CoralKernel/Service.h"
#include "RelationalAccess/SessionException.h"

#include "DomainProperties.h"
#include "ErrorHandler.h"
#include "ISchemaProperties.h"
#include "SessionProperties.h"
#include "SchemaEditor.h"

namespace coral
{
  namespace MySQLAccess
  {
    SchemaEditor::SchemaEditor( boost::shared_ptr<const SessionProperties> sessionProperties, ISchemaProperties& schemaProperties )
      : m_sessionProperties( sessionProperties )
      , m_schemaProperties( schemaProperties )
    {
    }

    std::set<std::string> SchemaEditor::listTables()
    {
      std::set<std::string>& names = m_schemaProperties.tableNames();

      std::string listTablesSql = "SHOW TABLES FROM \"" + m_schemaProperties.schemaName() + "\"";

      {
        coral::lock_guard lock( m_sessionProperties->lock() );

        if( mysql_query( m_sessionProperties->connectionHandle(), listTablesSql.c_str() ) )
        {
          ErrorHandler errorHandler;
          MYSQL_HANDLE_ERR(errorHandler,m_sessionProperties->connectionHandle(),("Getting list of tables in schema " + m_schemaProperties.schemaName()));
          throw coral::SessionException( errorHandler.message(), "MySQLAccess::SchemaEditor", m_sessionProperties->domainServiceName() );
        }
        else
        {
          MYSQL_RES* result = 0;

          if( ( result = mysql_store_result( m_sessionProperties->connectionHandle() ) ) != 0 )
          {
            MYSQL_ROW row;

            while( (row = mysql_fetch_row(result)) )
            {
              names.insert( row[0] );
            }

            mysql_free_result( result );
          }
        }
      }

      return names;
    }

    void SchemaEditor::truncateTable( const std::string& tableName )
    {
      coral::MessageStream log( m_sessionProperties->domainServiceName() );

      std::string sql = "TRUNCATE TABLE \"" + m_schemaProperties.schemaName() + "\".\"" + tableName + "\"";

      {
        coral::lock_guard lock( m_sessionProperties->lock() );
        log << coral::Debug << "Executing: " << sql << std::endl << coral::MessageStream::endmsg;

        // Try to drop the table physically
        if( mysql_query( m_sessionProperties->connectionHandle(), sql.c_str() ) )
        {
          ErrorHandler errorHandler;
          MYSQL_HANDLE_ERR(errorHandler,m_sessionProperties->connectionHandle(),("Truncating table in schema " + m_schemaProperties.schemaName()));
          throw coral::SessionException( errorHandler.message(), "MySQLAccess::SchemaEditor", m_sessionProperties->domainServiceName() );
        }
      }
    }

    void SchemaEditor::dropTable( const std::string& tableName )
    {
      coral::MessageStream log( m_sessionProperties->domainServiceName() );

      std::string sql = "DROP TABLE \"" + m_schemaProperties.schemaName() + "\".\"" + tableName + "\"";

      {
        coral::lock_guard lock( m_sessionProperties->lock() );
        log << coral::Debug << "Executing: " << sql << std::endl << coral::MessageStream::endmsg;

        // Try to drop the table physically
        if( mysql_query( m_sessionProperties->connectionHandle(), sql.c_str() ) )
        {
          ErrorHandler errorHandler;
          MYSQL_HANDLE_ERR(errorHandler,m_sessionProperties->connectionHandle(),("Dropping table in schema " + m_schemaProperties.schemaName()));
          throw coral::SessionException( errorHandler.message(), "MySQLAccess::SchemaEditor", m_sessionProperties->domainServiceName() );
        }

        std::set<std::string>& cache = m_schemaProperties.tableNames();
        cache.erase( tableName );
      }
    }

    void SchemaEditor::createTable( const std::string& tableName, const std::string& tableDDL )
    {
      coral::lock_guard lock( m_sessionProperties->lock() );

      // Try to create the table
      if( mysql_query( m_sessionProperties->connectionHandle(), tableDDL.c_str() ) ) {
        ErrorHandler errorHandler;
        MYSQL_HANDLE_ERR(errorHandler,m_sessionProperties->connectionHandle(),("Creating table in schema " + m_schemaProperties.schemaName() + " using DDL: " + tableDDL));
        throw coral::SessionException( errorHandler.message(), "MySQLAccess::SchemaEditor", m_sessionProperties->domainServiceName() );
      }

      std::set<std::string>& cache = m_schemaProperties.tableNames();
      cache.insert( tableName );
    }

  } // namespace MaySQLAccess
} // namespace coral
