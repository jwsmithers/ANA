// $Id: Schema.cpp,v 1.43 2012-06-26 14:27:07 avalassi Exp $
#include "MySQL_headers.h"

#include "CoralBase/MessageStream.h"
#include "CoralKernel/Service.h"
#include "RelationalAccess/ITable.h"
#include "RelationalAccess/ITableDescription.h"
#include "RelationalAccess/ITableSchemaEditor.h"
#include "RelationalAccess/ITypeConverter.h"
#include "RelationalAccess/SchemaException.h"
#include "RelationalAccess/TableDescription.h"

#include "DomainProperties.h"
#include "ErrorHandler.h"
#include "SessionProperties.h"
#include "Query.h"
#include "Schema.h"
#include "SchemaEditor.h"
#include "SchemaProperties.h"
#include "Table.h"
#include "TableDDLBuilder.h"
#include "ViewFactory.h"

coral::MySQLAccess::Schema::Schema( boost::shared_ptr<const SessionProperties> sessionProperties, const std::string& schemaName )
  : m_sessionProperties( sessionProperties )
  , m_schemaProperties( 0 )
  , m_tableListFresh( false )
  , m_tableDescriptionFresh( false )
{
  m_schemaProperties = new coral::MySQLAccess::SchemaProperties( sessionProperties, schemaName, *this );
}

coral::MySQLAccess::Schema::~Schema()
{
  if( m_schemaProperties != 0 )
  {
    delete m_schemaProperties;
    m_schemaProperties= 0;
  }

  this->reactOnEndOfTransaction();
}

std::string coral::MySQLAccess::Schema::schemaName() const
{
  return m_schemaProperties->schemaName();
}

std::set<std::string> coral::MySQLAccess::Schema::listTables() const
{
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::listTables" );

  SchemaEditor sb( this->m_sessionProperties, *m_schemaProperties );

  coral::lock_guard lock( m_lock );

  return sb.listTables();
}

bool coral::MySQLAccess::Schema::existsTable( const std::string& tableName ) const
{
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::existsTable" );

  coral::lock_guard lock( m_lock );
  /* Get the set for the schema *///
  std::set<std::string>& names = m_schemaProperties->tableNames();
  /* Check if we need to fill it *///
  if( names.size() == 0 )
  {
    /* New scheam editor *///
    SchemaEditor sb( this->m_sessionProperties, *m_schemaProperties );
    /* Fetch the list of tables form the database *///
    sb.listTables();
  }
  /* Try to find the table in the cache *///
  return names.find( tableName ) != names.end();
}

void coral::MySQLAccess::Schema::dropTable( const std::string& tableName )
{
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::dropTable" );
  if ( m_sessionProperties->isReadOnly() )
    throw coral::InvalidOperationInReadOnlyModeException( m_sessionProperties->domainServiceName(), "ISchema::dropTable" );
  if ( m_sessionProperties->isTransactionReadOnly() )
    throw coral::InvalidOperationInReadOnlyTransactionException( m_sessionProperties->domainServiceName(), "ISchema::dropTable" );
  if ( ! this->existsTable( tableName ) ) {
    throw coral::TableNotExistingException( m_sessionProperties->domainServiceName(), tableName, "ISchema::dropTable" );
  }

  SchemaEditor sb( this->m_sessionProperties, *m_schemaProperties );
  sb.dropTable( tableName );

  {
    coral::lock_guard lock( m_lock );

    // Update schema registry
    TableRegistry::iterator tri = m_schemaProperties->tableRegistry().find( tableName );
    if( tri != m_schemaProperties->tableRegistry().end() )
    {
      delete (*tri).second;
      m_schemaProperties->tableRegistry().erase( tableName );
    }

    TableDescriptionRegistry::iterator tdri = m_schemaProperties->tableDescriptionRegistry().find( tableName );
    if( tdri != m_schemaProperties->tableDescriptionRegistry().end() )
    {
      delete (*tdri).second;
      m_schemaProperties->tableDescriptionRegistry().erase( tableName );
    }
  } // End of critical section
}

void coral::MySQLAccess::Schema::dropIfExistsTable( const std::string& tableName )
{
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::dropIfExistsTable" );
  if ( m_sessionProperties->isReadOnly() )
    throw coral::InvalidOperationInReadOnlyModeException( m_sessionProperties->domainServiceName(), "ISchema::dropIfExistsTable" );
  if ( m_sessionProperties->isTransactionReadOnly() )
    throw coral::InvalidOperationInReadOnlyTransactionException( m_sessionProperties->domainServiceName(), "ISchema::dropIfExistsTable" );
  if ( this->existsTable( tableName ) )
    this->dropTable( tableName );
}

coral::ITable& coral::MySQLAccess::Schema::createTable( const coral::ITableDescription& description )
{
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::createTable" );
  if ( m_sessionProperties->isReadOnly() )
    throw coral::InvalidOperationInReadOnlyModeException( m_sessionProperties->domainServiceName(), "ISchema::createTable" );
  if ( m_sessionProperties->isTransactionReadOnly() )
    throw coral::InvalidOperationInReadOnlyTransactionException( m_sessionProperties->domainServiceName(), "ISchema::createTable" );

  // Get the name of the table
  std::string tableName = description.name();

  // Check if a table with this name already exists
  if ( this->existsTable( tableName ) )
    throw coral::TableAlreadyExistingException( m_sessionProperties->domainServiceName(), tableName );

  coral::MySQLAccess::TableDDLBuilder tbuilder( m_sessionProperties->typeConverter(), description, m_schemaProperties->schemaName() );

  std::string tableDDL = tbuilder.sql();

  //std::cout << "Table DDL: " << tableDDL << std::endl;

  SchemaEditor sb( this->m_sessionProperties, *m_schemaProperties );
  sb.createTable( tableName, tableDDL );

  {
    coral::lock_guard lock( m_lock );
    coral::MessageStream log( m_sessionProperties->domainServiceName() );
    log << coral::Debug << "Table DDL: " << tableDDL << coral::MessageStream::endmsg;
    this->m_tableDescriptionFresh = false;
  }

  // This call makes sure the table handle registry gets in sync
  coral::ITable& table = this->tableHandle( tableName );

  return table;
}

coral::ITable& coral::MySQLAccess::Schema::tableHandle( const std::string& tableName )
{
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::tableHandle" );

  // Check if the table exists at all, this may trigger access to DB server eventually
  if( ! this->existsTable( tableName ) )
  {
    throw coral::TableNotExistingException( m_sessionProperties->domainServiceName(), (m_schemaProperties->schemaName() +"." + tableName) );
  }

  // Go to the schema properties to pick up the table handle from the cache
  TableRegistry::iterator tri;

  {
    coral::lock_guard lock( m_lock );

    tri = m_schemaProperties->tableRegistry().find( tableName );

    if( tri == m_schemaProperties->tableRegistry().end() )
    {
      // We know the table exists so we make the registry update
      // and the table handle makes sure its table description gets updated as well
      coral::MySQLAccess::Table* newHandle = new coral::MySQLAccess::Table( tableName, m_sessionProperties, *m_schemaProperties );
      tri = m_schemaProperties->tableRegistry().insert( std::make_pair( tableName, newHandle ) ).first;
    }
  }

  return *((*tri).second);
}

/* In case no table with such a name exists, a TableNotExistingException is thrown.  *///
void coral::MySQLAccess::Schema::truncateTable( const std::string& tableName )
{
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::truncateTable" );
  if ( m_sessionProperties->isReadOnly() )
    throw coral::InvalidOperationInReadOnlyModeException( m_sessionProperties->domainServiceName(), "ISchema::truncateTable" );
  if ( m_sessionProperties->isTransactionReadOnly() )
    throw coral::InvalidOperationInReadOnlyTransactionException( m_sessionProperties->domainServiceName(), "ISchema::truncateTable" );

  if( ! this->existsTable( tableName ) )
  {
    throw coral::TableNotExistingException( m_sessionProperties->domainServiceName(), (m_schemaProperties->schemaName() +"." + tableName) );
  }

  SchemaEditor sb( this->m_sessionProperties, *m_schemaProperties );
  sb.truncateTable( tableName );
}

/**
 * Calls a stored procedure with input parameters.
 * In case of an error a SchemaException is thrown.
 *///
void coral::MySQLAccess::Schema::callProcedure( const std::string& /* procedureName */,
                                                const coral::AttributeList& /* inputArguments*/ )
{
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::callProcedure" );
  if ( m_sessionProperties->isReadOnly() )
    throw coral::InvalidOperationInReadOnlyModeException( m_sessionProperties->domainServiceName(), "ISchema::callProcedure" );
  if ( m_sessionProperties->isTransactionReadOnly() )
    throw coral::InvalidOperationInReadOnlyTransactionException( m_sessionProperties->domainServiceName(), "ISchema::callProcedure" );
}

coral::IQuery* coral::MySQLAccess::Schema::newQuery() const
{
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::newQuery" );

  return new coral::MySQLAccess::Query( m_sessionProperties );
}

coral::IViewFactory* coral::MySQLAccess::Schema::viewFactory()
{
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::viewFactory" );
  if ( m_sessionProperties->isReadOnly() )
    throw coral::InvalidOperationInReadOnlyModeException( m_sessionProperties->domainServiceName(), "ISchema::viewFactory" );
  if ( m_sessionProperties->isTransactionReadOnly() )
    throw coral::InvalidOperationInReadOnlyTransactionException( m_sessionProperties->domainServiceName(), "ISchema::viewFactory" );
  return new coral::MySQLAccess::ViewFactory( m_sessionProperties );
}

bool coral::MySQLAccess::Schema::existsView( const std::string& /*viewName*/ ) const
{
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::existsView" );
  //throw coral::Exception( "Views are not fully supported in MySQLAccess (bug #36512)", m_sessionProperties->domainServiceName(), "ISchema::existsView" );
  return false; // DO NOT THROW AN EXCEPTION (OTHERWISE MOST TESTS BREAK!)
}

void coral::MySQLAccess::Schema::dropView( const std::string& /*viewName*/ )
{
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::dropView" );
  if ( m_sessionProperties->isReadOnly() )
    throw coral::InvalidOperationInReadOnlyModeException( m_sessionProperties->domainServiceName(), "ISchema::dropView" );
  if ( m_sessionProperties->isTransactionReadOnly() )
    throw coral::InvalidOperationInReadOnlyTransactionException( m_sessionProperties->domainServiceName(), "ISchema::dropView" );
  throw coral::Exception( "Views are not fully supported in MySQLAccess (bug #36512)", m_sessionProperties->domainServiceName(), "ISchema::dropView" );
}

void coral::MySQLAccess::Schema::dropIfExistsView( const std::string& /*viewName*/ )
{
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::dropIfExistsView" );
  if ( m_sessionProperties->isReadOnly() )
    throw coral::InvalidOperationInReadOnlyModeException( m_sessionProperties->domainServiceName(), "ISchema::dropIfExistsView" );
  if ( m_sessionProperties->isTransactionReadOnly() )
    throw coral::InvalidOperationInReadOnlyTransactionException( m_sessionProperties->domainServiceName(), "ISchema::dropIfExistsView" );
  throw coral::Exception( "Views are not fully supported in MySQLAccess (bug #36512)", m_sessionProperties->domainServiceName(), "ISchema::dropIfExistsView" );
}

coral::IView& coral::MySQLAccess::Schema::viewHandle( const std::string& /* FIXME - viewName */ )
{
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::viewHandle" );
  throw coral::Exception( "Views are not fully supported in MySQLAccess (bug #36512)", m_sessionProperties->domainServiceName(), "ISchema::viewHandle" );
}

std::set<std::string> coral::MySQLAccess::Schema::listViews() const
{
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::listViews" );
  throw coral::Exception( "Views are not fully supported in MySQLAccess (bug #36512)", m_sessionProperties->domainServiceName(), "ISchema::viewHandle" );
}

void coral::MySQLAccess::Schema::reactOnEndOfTransaction()
{
}

void coral::MySQLAccess::Schema::setTableListStale()
{
  coral::lock_guard lock( m_lock );
  this->m_tableListFresh = false;
}
