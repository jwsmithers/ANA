// First of all, set/unset CORAL240, CORAL300 and CORAL_HAS_CPP11 macros
#include "CoralBase/VersionInfo.h"

// Include files
#ifdef WIN32
#include <WTypes.h> // fix bug #35683, bug #73144, bug #76882, bug #79849
#endif
#include <cstring> // fix bug #58581
#include <memory>
#include <sstream>
#include "oci.h"
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"
#include "CoralBase/MessageStream.h"
#include "CoralKernel/Service.h"
#include "RelationalAccess/IIndex.h"
#include "RelationalAccess/ITableDescription.h"
#include "RelationalAccess/ITable.h"
#include "RelationalAccess/ITableSchemaEditor.h"
#include "RelationalAccess/IUniqueConstraint.h"
#include "RelationalAccess/SchemaException.h"

// Local include files
#include "Cursor.h"
#include "DomainProperties.h"
#include "OracleErrorHandler.h"
#include "OracleStatement.h"
#include "OracleTableBuilder.h"
#include "Query.h"
#include "Schema.h"
#include "SessionProperties.h"
#include "Table.h"
#include "View.h"
#include "ViewFactory.h"

//-----------------------------------------------------------------------------

coral::OracleAccess::Schema::Schema( boost::shared_ptr<const SessionProperties> sessionProperties,
                                     const std::string& schemaName )
  : m_sessionProperties( sessionProperties )
  , m_schemaName( schemaName )
  , m_tables()
  , m_tablesReadFromDataDictionary( false )
  , m_views()
  , m_viewsReadFromDataDictionary( false )
  , m_tableMutex()
  , m_viewMutex()
  , m_userSessionStarted( false ) // startUserSession must be called explicitly
{
#ifdef ORACLE_CONNECTION_PROPERTIES_DEBUG
  std::cout << "Create Schema " << this << std::endl; // debug bug #98736
#endif
}

//-----------------------------------------------------------------------------

coral::OracleAccess::Schema::~Schema()
{
#ifdef ORACLE_CONNECTION_PROPERTIES_DEBUG
  std::cout << "Delete Schema " << this << std::endl; // debug bug #98736
#endif
  if ( !m_userSessionStarted ) return;  // Schema was already 'deleted'
  this->reactOnEndOfTransaction();
}

//-----------------------------------------------------------------------------

std::string
coral::OracleAccess::Schema::schemaName() const
{
  return m_schemaName;
}

//-----------------------------------------------------------------------------

std::set<std::string>
coral::OracleAccess::Schema::listTables() const
{
  if ( !m_userSessionStarted ) // This schema was "deleted" (bug #80178)
    throw SessionException( "User session has already ended",
                            "Schema::listTables",
                            m_sessionProperties->domainServiceName() );
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::listTables" );
  std::set<std::string> result;
  if ( ! m_tablesReadFromDataDictionary )
    this->readTablesFromDataDictionary();
  coral::lock_guard lock( m_tableMutex );
  for ( std::map< std::string, OracleAccess::Table*>::const_iterator iTable = m_tables.begin();
        iTable != m_tables.end(); ++iTable )
  {
    result.insert( iTable->first );
  }
  return result;
}

//-----------------------------------------------------------------------------

bool
coral::OracleAccess::Schema::existsTable( const std::string& tableName ) const
{
  if ( !m_userSessionStarted ) // This schema was "deleted" (bug #80178)
    throw SessionException( "User session has already ended",
                            "Schema::existsTable",
                            m_sessionProperties->domainServiceName() );
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::existsTable" );
  // Check if the table is already in the local cache.
  bool isInCache = false;
  {
    coral::lock_guard lock( m_tableMutex );
    isInCache = ( m_tables.find( tableName ) == m_tables.end() ? false : true );
  }
  if ( ! isInCache )
  {
    // Check inside the database.
    // The fully qualified table name
    std::string fullTableName = m_schemaName + ".\"" + tableName + "\"";
    // Try to get the descriptor handle
    void* temporaryPointer = 0;
    sword status = OCIHandleAlloc( m_sessionProperties->ociEnvHandle(),
                                   &temporaryPointer,
                                   OCI_HTYPE_DESCRIBE, 0, 0 );
    if ( status != OCI_SUCCESS )
    {
      throw coral::SchemaException( m_sessionProperties->domainServiceName(),
                                    "Could not allocate a describe handle",
                                    "ISchema::existsTable" );
    }
    OCIDescribe* ociDescribeHandle = static_cast< OCIDescribe* >( temporaryPointer );
    status = OCIDescribeAny( m_sessionProperties->ociSvcCtxHandle(),
                             m_sessionProperties->ociErrorHandle(),
                             const_cast<char *>( fullTableName.c_str() ),
                             ::strlen( fullTableName.c_str() ),
                             OCI_OTYPE_NAME, OCI_DEFAULT,
                             OCI_PTYPE_TABLE,
                             ociDescribeHandle );
    if ( status != OCI_SUCCESS )
    {
      OracleAccess::OracleErrorHandler errorHandler( m_sessionProperties->ociErrorHandle() );
      errorHandler.handleCase( status, "retrieving the describe handle of " + fullTableName + " (Schema::existsTable)" );
      OCIHandleFree( ociDescribeHandle, OCI_HTYPE_DESCRIBE );
      if ( errorHandler.lastErrorCode() != 4043 &&
           errorHandler.lastErrorCode() != 1403 )
      {
        // Errors other than 4043 or 1403: unexpected problem -> throw
        coral::MessageStream log( m_sessionProperties->domainServiceName() );
        log << coral::Error << errorHandler.message() << coral::MessageStream::endmsg;
        throw coral::SchemaException( m_sessionProperties->domainServiceName(),
                                      "Could not retrieve a describe handle",
                                      "ISchema::existsTable" );
      }
      else
      {
        // WARN that 1403 is handled as equivalent to 4043 (bug #49657)
        if ( errorHandler.lastErrorCode() == 1403 )
        {
          coral::MessageStream log( m_sessionProperties->domainServiceName() );
          log << coral::Verbose << errorHandler.message() << coral::MessageStream::endmsg;
        }
        // Error 4043 or 1403: no such table -> check if it is a synonym
        std::string tableForSynonym = this->synonymForTable( tableName );
        if ( tableForSynonym.empty() || (tableForSynonym == tableName) )
          return false;
        else
          return this->existsTable( tableForSynonym );
      }
    }
    else
    {
      coral::lock_guard lock( m_tableMutex );
      if ( m_tables.find( tableName ) != m_tables.end() )
      {
        // Another thread was faster...
        OCIHandleFree( ociDescribeHandle, OCI_HTYPE_DESCRIBE );
        return true;
      }
      // The table exists. Create the table object and insert it into the map.
      // Transfer ociDescribeHandle: will be deleted in ~TableDescriptionProxy.
      OracleAccess::Table* table = new OracleAccess::Table( m_sessionProperties,
                                                            m_schemaName,
                                                            tableName,
                                                            ociDescribeHandle );
      m_tables.insert( std::make_pair( tableName, table ) );
      return true;
    }
  }
  else
    return true;
}

//-----------------------------------------------------------------------------

std::string
coral::OracleAccess::Schema::synonymForTable( const std::string& tableName ) const
{
  if ( !m_userSessionStarted ) // This schema was "deleted" (bug #80178)
    throw SessionException( "User session has already ended",
                            "Schema::synonymForTable",
                            m_sessionProperties->domainServiceName() );
  // The fully qualified table name
  std::string fullTableName = m_schemaName + ".\"" + tableName + "\"";
  // Try to get the descriptor handle
  void* temporaryPointer = 0;
  sword status = OCIHandleAlloc( m_sessionProperties->ociEnvHandle(),
                                 &temporaryPointer,
                                 OCI_HTYPE_DESCRIBE, 0, 0 );
  if ( status != OCI_SUCCESS )
  {
    throw coral::SchemaException( m_sessionProperties->domainServiceName(),
                                  "Could not allocate a describe handle",
                                  "OracleAccess::Schema::synonymForTable" );
  }
  OCIDescribe* ociDescribeHandle = static_cast< OCIDescribe* >( temporaryPointer );
  status = OCIDescribeAny( m_sessionProperties->ociSvcCtxHandle(),
                           m_sessionProperties->ociErrorHandle(),
                           const_cast<char *>( fullTableName.c_str() ),
                           ::strlen( fullTableName.c_str() ),
                           OCI_OTYPE_NAME, OCI_DEFAULT,
                           OCI_PTYPE_SYN,
                           ociDescribeHandle );
  if ( status != OCI_SUCCESS )
  {
    OracleAccess::OracleErrorHandler errorHandler( m_sessionProperties->ociErrorHandle() );
    errorHandler.handleCase( status, "retrieving the describe handle of " + fullTableName + " (Schema::synonymForTable)" );
    OCIHandleFree( ociDescribeHandle, OCI_HTYPE_DESCRIBE );
    if ( errorHandler.lastErrorCode() != 4043 &&
         errorHandler.lastErrorCode() != 1403 )
    {
      // Errors other than 4043 or 1403: unexpected problem -> throw
      coral::MessageStream log( m_sessionProperties->domainServiceName() );
      log << coral::Error << errorHandler.message() << coral::MessageStream::endmsg;
      throw coral::SchemaException( m_sessionProperties->domainServiceName(),
                                    "Could not retrieve a describe handle",
                                    "OracleAccess::Schema::synonymForTable" );
    }
    else
    {
      // WARN that 1403 is handled as equivalent to 4043 (bug #49657)
      if ( errorHandler.lastErrorCode() == 1403 ) {
        coral::MessageStream log( m_sessionProperties->domainServiceName() );
        log << coral::Verbose << errorHandler.message() << coral::MessageStream::endmsg;
      }
      // Error 4043 or 1403: not a synonym -> return ""
      return "";
    }
  }
  // Retrieve the corresponding table name.
  OCIParam* ociParamHandle = 0;
  status = OCIAttrGet( ociDescribeHandle, OCI_HTYPE_DESCRIBE,
                       &ociParamHandle, 0, OCI_ATTR_PARAM,
                       m_sessionProperties->ociErrorHandle() );
  if ( status != OCI_SUCCESS )
  {
    OracleAccess::OracleErrorHandler errorHandler( m_sessionProperties->ociErrorHandle() );
    errorHandler.handleCase( status, "Retrieving the describe parameter for synonym " + fullTableName );
    coral::MessageStream log( m_sessionProperties->domainServiceName() );
    log << coral::Error << errorHandler.message() << coral::MessageStream::endmsg;
    OCIHandleFree( ociDescribeHandle, OCI_HTYPE_DESCRIBE );
    throw coral::SchemaException( m_sessionProperties->domainServiceName(),
                                  "Could not retrieve the OCI describe parameter for synonym " + fullTableName,
                                  "OracleAccess::Schema::synonymForTable" );
  }
  // Retrieving the table name
  text* textPlaceHolder = 0;
  ub4 textSize = 0;
  status = OCIAttrGet( ociParamHandle, OCI_DTYPE_PARAM,
                       &textPlaceHolder, &textSize,
                       OCI_ATTR_NAME,
                       m_sessionProperties->ociErrorHandle() );
  if ( status != OCI_SUCCESS )
  {
    OracleAccess::OracleErrorHandler errorHandler( m_sessionProperties->ociErrorHandle() );
    errorHandler.handleCase( status, "Retrieving the name of the object referenced by a synonym" );
    coral::MessageStream log( m_sessionProperties->domainServiceName() );
    log << coral::Error << errorHandler.message() << coral::MessageStream::endmsg;
    OCIHandleFree( ociDescribeHandle, OCI_HTYPE_DESCRIBE );
    throw coral::SchemaException( m_sessionProperties->domainServiceName(),
                                  "Could not retrieve the name of the object referenced by a synonym",
                                  "OracleAccess::Schema::synonymForTable" );
  }
  std::ostringstream osName;
  osName << textPlaceHolder;
  std::string sName = osName.str();
  OCIHandleFree( ociDescribeHandle, OCI_HTYPE_DESCRIBE );
  return sName.substr( 0, textSize );
}

//-----------------------------------------------------------------------------

void
coral::OracleAccess::Schema::dropTable( const std::string& tableName
#ifdef CORAL300CC
                                        , bool dropTableCascade
#endif
                                        )
{
  if ( !m_userSessionStarted ) // This schema was "deleted" (bug #80178)
    throw SessionException( "User session has already ended",
                            "Schema::dropTable",
                            m_sessionProperties->domainServiceName() );
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::dropTable" );
  if ( m_sessionProperties->isReadOnly() )
    throw coral::InvalidOperationInReadOnlyModeException( m_sessionProperties->domainServiceName(), "ISchema::dropTable" );
  if ( m_sessionProperties->isTransactionReadOnly() )
    throw coral::InvalidOperationInReadOnlyTransactionException( m_sessionProperties->domainServiceName(), "ISchema::dropTable" );
  if ( ! this->existsTable( tableName ) )
    throw coral::TableNotExistingException( m_sessionProperties->domainServiceName(), tableName, "ISchema::dropTable" );
  std::string dropTableCmd = "DROP TABLE " + m_schemaName + ".\"" + tableName + "\"";
#ifndef CORAL300CC
  // Temporary workaround for POOL bug #61888
  // Eventually extend API to support dropTableCascade (task #14095)
  if ( ::getenv( "CORAL_ORA_DROP_TABLE_CASCADE_CONSTRAINTS" ) ) dropTableCmd += " CASCADE CONSTRAINTS";
#else
  if ( dropTableCascade ) dropTableCmd += " CASCADE CONSTRAINTS";
#endif
  OracleAccess::OracleStatement statement( m_sessionProperties, m_schemaName, dropTableCmd );
  if ( ! statement.execute( coral::AttributeList() ) )
    throw coral::SchemaException( m_sessionProperties->domainServiceName(),
                                  "Could not drop a table",
                                  "ISchema::dropTable" );
  coral::lock_guard lock( m_tableMutex );
  std::map< std::string, OracleAccess::Table* >::iterator iTable = m_tables.find( tableName );
  if ( iTable->second ) delete iTable->second;
  m_tables.erase( iTable );
}

//-----------------------------------------------------------------------------

void
coral::OracleAccess::Schema::dropIfExistsTable( const std::string& tableName
#ifdef CORAL300CC
                                                , bool dropTableCascade
#endif
                                                )
{
  if ( !m_userSessionStarted ) // This schema was "deleted" (bug #80178)
    throw SessionException( "User session has already ended",
                            "Schema::dropIfExistsTable",
                            m_sessionProperties->domainServiceName() );
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::dropIfExistsTable" );
  if ( m_sessionProperties->isReadOnly() )
    throw coral::InvalidOperationInReadOnlyModeException( m_sessionProperties->domainServiceName(), "ISchema::dropIfExistsTable" );
  if ( m_sessionProperties->isTransactionReadOnly() )
    throw coral::InvalidOperationInReadOnlyTransactionException( m_sessionProperties->domainServiceName(), "ISchema::dropIfExistsTable" );
  if ( this->existsTable( tableName ) )
#ifndef CORAL300CC
    this->dropTable( tableName );
#else
  this->dropTable( tableName, dropTableCascade );
#endif
}

//-----------------------------------------------------------------------------

coral::ITable&
coral::OracleAccess::Schema::createTable( const coral::ITableDescription& description )
{
  if ( !m_userSessionStarted ) // This schema was "deleted" (bug #80178)
    throw SessionException( "User session has already ended",
                            "Schema::createTable",
                            m_sessionProperties->domainServiceName() );
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
  // Construct and execute the statement creating the table
  OracleAccess::OracleTableBuilder builder( description,
                                            m_sessionProperties,
                                            m_schemaName );
  OracleAccess::OracleStatement statement( m_sessionProperties,
                                           m_schemaName,
                                           builder.statement() );
  if ( ! statement.execute( coral::AttributeList() ) )
    throw coral::SchemaException( m_sessionProperties->domainServiceName(),
                                  "Could not create a new table",
                                  "ISchema::createTable" );
  // Get the table handle
  coral::ITable& table = this->tableHandle( tableName );
  // Use now the schema editor to add the indices
  coral::ITableSchemaEditor& editor = table.schemaEditor();
  for ( int i = 0; i < description.numberOfIndices(); ++i )
  {
    const coral::IIndex& index = description.index( i );
    editor.createIndex( index.name(), index.columnNames(), index.isUnique(), index.tableSpaceName() );
  }
  return table;
}

//-----------------------------------------------------------------------------

coral::ITable&
coral::OracleAccess::Schema::tableHandle( const std::string& tableName )
{
  if ( !m_userSessionStarted ) // This schema was "deleted" (bug #80178)
    throw SessionException( "User session has already ended",
                            "Schema::tableHandle",
                            m_sessionProperties->domainServiceName() );
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::tableHandle" );
  // Check if the table is already in the local cache.
  std::map< std::string, OracleAccess::Table* >::iterator iTable;
  bool needDescription = false;
  {
    coral::lock_guard lock( m_tableMutex );
    iTable = m_tables.find( tableName );
    needDescription = ( iTable == m_tables.end() || iTable->second == 0 );
  }
  if ( needDescription )
  {
    // The fully qualified table name
    const std::string fullTableName = m_schemaName + ".\"" + tableName + "\"";
    // Try to get the descriptor handle
    void* temporaryPointer = 0;
    sword status = OCIHandleAlloc( m_sessionProperties->ociEnvHandle(),
                                   &temporaryPointer,
                                   OCI_HTYPE_DESCRIBE, 0, 0 );
    if ( status != OCI_SUCCESS )
      throw coral::SchemaException( m_sessionProperties->domainServiceName(),
                                    "Could not allocate a describe handle",
                                    "ISchema::tableHandle" );
    OCIDescribe* ociDescribeHandle = static_cast< OCIDescribe* >( temporaryPointer );
    {
      //coral::lock_guard lock( m_sessionProperties->connectionProperties().connectionMutex() );
      status = OCIDescribeAny( m_sessionProperties->ociSvcCtxHandle(),
                               m_sessionProperties->ociErrorHandle(),
                               const_cast<char *>( fullTableName.c_str() ),
                               ::strlen( fullTableName.c_str() ),
                               OCI_OTYPE_NAME, OCI_DEFAULT,
                               OCI_PTYPE_TABLE,
                               ociDescribeHandle );
    }
    if ( status != OCI_SUCCESS )
    {
      OracleAccess::OracleErrorHandler errorHandler( m_sessionProperties->ociErrorHandle() );
      errorHandler.handleCase( status, "retrieving the describe handle of " + fullTableName + " (Schema::tableHandle)" );
      OCIHandleFree( ociDescribeHandle, OCI_HTYPE_DESCRIBE );
      if ( errorHandler.lastErrorCode() != 4043 &&
           errorHandler.lastErrorCode() != 1403 )
      {
        // Errors other than 4043 or 1403: unexpected problem -> throw
        coral::MessageStream log( m_sessionProperties->domainServiceName() );
        log << coral::Error << errorHandler.message() << coral::MessageStream::endmsg;
        throw coral::SchemaException( m_sessionProperties->domainServiceName(),
                                      "Could not retrieve a describe handle",
                                      "ISchema::tableHandle" );
      }
      else
      {
        // WARN that 1403 is handled as equivalent to 4043 (bug #49657)
        if ( errorHandler.lastErrorCode() == 1403 ) {
          coral::MessageStream log( m_sessionProperties->domainServiceName() );
          log << coral::Verbose << errorHandler.message() << coral::MessageStream::endmsg;
        }
        // Error 4043 or 1403: no such table -> check if it is a synonym
        std::string tableForSynonym = this->synonymForTable( tableName );
        if ( tableForSynonym.empty() )
          throw coral::TableNotExistingException( m_sessionProperties->domainServiceName(), fullTableName );
        else
          return this->tableHandle( tableForSynonym );
      }
    }
    coral::lock_guard lock( m_tableMutex );
    iTable = m_tables.find( tableName );
    if ( iTable != m_tables.end() && iTable->second != 0 )
    {
      // Another thread was faster...
      OCIHandleFree( ociDescribeHandle, OCI_HTYPE_DESCRIBE );
    }
    else
    {
      // The table exists. Create the table object and insert it into the map
      OracleAccess::Table* table = new OracleAccess::Table( m_sessionProperties,
                                                            m_schemaName,
                                                            tableName,
                                                            ociDescribeHandle );
      if ( iTable == m_tables.end() )
        iTable = m_tables.insert( std::make_pair( tableName, table ) ).first;
      else
        iTable->second = table;
    }
    return *( iTable->second );
  }
  return *( iTable->second );
}

//-----------------------------------------------------------------------------

void
coral::OracleAccess::Schema::truncateTable( const std::string& tableName )
{
  if ( !m_userSessionStarted ) // This schema was "deleted" (bug #80178)
    throw SessionException( "User session has already ended",
                            "Schema::truncateTable",
                            m_sessionProperties->domainServiceName() );
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::truncateTable" );
  if ( m_sessionProperties->isReadOnly() )
    throw coral::InvalidOperationInReadOnlyModeException( m_sessionProperties->domainServiceName(), "ISchema::truncateTable" );
  if ( m_sessionProperties->isTransactionReadOnly() )
    throw coral::InvalidOperationInReadOnlyTransactionException( m_sessionProperties->domainServiceName(), "ISchema::truncateTable" );
  if ( ! this->existsTable( tableName ) )
    throw coral::TableNotExistingException( m_sessionProperties->domainServiceName(), tableName, "truncateTable" );
  OracleAccess::OracleStatement statement( m_sessionProperties,
                                           m_schemaName,
                                           "TRUNCATE TABLE " + m_schemaName + ".\"" + tableName + "\"" );
  if ( ! statement.execute( coral::AttributeList() ) )
    throw coral::SchemaException( m_sessionProperties->domainServiceName(),
                                  "Could not truncate table \"" + tableName + "\"",
                                  "ISchema::truncateTable" );
}

//-----------------------------------------------------------------------------

void
coral::OracleAccess::Schema::callProcedure( const std::string& procedureName,
                                            const coral::AttributeList& inputArguments )
{
  if ( !m_userSessionStarted ) // This schema was "deleted" (bug #80178)
    throw SessionException( "User session has already ended",
                            "Schema::callProcedure",
                            m_sessionProperties->domainServiceName() );
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::callProcedure" );
  if ( m_sessionProperties->isReadOnly() )
    throw coral::InvalidOperationInReadOnlyModeException( m_sessionProperties->domainServiceName(), "ISchema::callProcedure" );
  if ( m_sessionProperties->isTransactionReadOnly() )
    throw coral::InvalidOperationInReadOnlyTransactionException( m_sessionProperties->domainServiceName(), "ISchema::callProcedure" );
  std::ostringstream os;
  std::string sqlProcName = procedureName;
  size_t dotPos = sqlProcName.find(".");
  if (dotPos != std::string::npos) sqlProcName.replace(dotPos, 1, "\".\"");
  os << "CALL " << m_schemaName << ".\"" << sqlProcName << "\" ( ";
  for ( coral::AttributeList::const_iterator iAttribute = inputArguments.begin();
        iAttribute != inputArguments.end(); ++iAttribute )
  {
    if ( iAttribute != inputArguments.begin() ) os << ", ";
    os << ":\"" << iAttribute->specification().name() << "\"";
  }
  os << " )";
  OracleAccess::OracleStatement statement( m_sessionProperties, m_schemaName, os.str() );
  if ( ! statement.execute( inputArguments ) )
    throw coral::SchemaException( m_sessionProperties->domainServiceName(),
                                  "Error calling \"" + sqlProcName + "\"",
                                  "ISchema::callProcedure" );
}

//-----------------------------------------------------------------------------

coral::IQuery*
coral::OracleAccess::Schema::newQuery() const
{
  if ( !m_userSessionStarted ) // This schema was "deleted" (bug #80178)
    throw SessionException( "User session has already ended",
                            "Schema::newQuery",
                            m_sessionProperties->domainServiceName() );
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::newQuery" );
  return new OracleAccess::Query( m_sessionProperties, m_schemaName );
}

//-----------------------------------------------------------------------------

coral::IViewFactory*
coral::OracleAccess::Schema::viewFactory()
{
  if ( !m_userSessionStarted ) // This schema was "deleted" (bug #80178)
    throw SessionException( "User session has already ended",
                            "Schema::viewFactory",
                            m_sessionProperties->domainServiceName() );
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::viewFactory" );
  if ( m_sessionProperties->isReadOnly() )
    throw coral::InvalidOperationInReadOnlyModeException( m_sessionProperties->domainServiceName(), "ISchema::viewFactory" );
  if ( m_sessionProperties->isTransactionReadOnly() )
    throw coral::InvalidOperationInReadOnlyTransactionException( m_sessionProperties->domainServiceName(), "ISchema::viewFactory" );
  return new OracleAccess::ViewFactory( m_sessionProperties, m_schemaName );
}

//-----------------------------------------------------------------------------

bool
coral::OracleAccess::Schema::existsView( const std::string& viewName ) const
{
  if ( !m_userSessionStarted ) // This schema was "deleted" (bug #80178)
    throw SessionException( "User session has already ended",
                            "Schema::existsView",
                            m_sessionProperties->domainServiceName() );
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::existsView" );
  // Check if the view is already in the local cache.
  bool isInCache = false;
  {
    coral::lock_guard lock( m_tableMutex );
    isInCache = ( m_views.find( viewName ) != m_views.end() );
  }
  if ( ! isInCache )
  {
    // Check inside the database.
    // The fully qualified view name
    std::string fullViewName = m_schemaName + ".\"" + viewName + "\"";
    // Try to get the descriptor handle
    void* temporaryPointer = 0;
    sword status = OCIHandleAlloc( m_sessionProperties->ociEnvHandle(),
                                   &temporaryPointer,
                                   OCI_HTYPE_DESCRIBE, 0, 0 );
    if ( status != OCI_SUCCESS )
    {
      throw coral::SchemaException( m_sessionProperties->domainServiceName(),
                                    "Could not allocate a describe handle",
                                    "ISchema::existsView" );
    }
    OCIDescribe* ociDescribeHandle = static_cast< OCIDescribe* >( temporaryPointer );
    status = OCIDescribeAny( m_sessionProperties->ociSvcCtxHandle(),
                             m_sessionProperties->ociErrorHandle(),
                             const_cast<char *>( fullViewName.c_str() ),
                             ::strlen( fullViewName.c_str() ),
                             OCI_OTYPE_NAME, OCI_DEFAULT,
                             OCI_PTYPE_VIEW,
                             ociDescribeHandle );
    if ( status != OCI_SUCCESS )
    {
      OracleAccess::OracleErrorHandler errorHandler( m_sessionProperties->ociErrorHandle() );
      errorHandler.handleCase( status, "retrieving the describe handle of " + fullViewName + " (Schema::existsView)" );
      OCIHandleFree( ociDescribeHandle, OCI_HTYPE_DESCRIBE );
      if ( errorHandler.lastErrorCode() != 4043 &&
           errorHandler.lastErrorCode() != 1403 )
      {
        // Errors other than 4043 or 1403: unexpected problem -> throw
        coral::MessageStream log( m_sessionProperties->domainServiceName() );
        log << coral::Error << errorHandler.message() << coral::MessageStream::endmsg;
        if ( errorHandler.lastErrorCode() == 24372 )
        {
          // Errors ORA-24372 invalid view (bug #92418)
          log << coral::Error << "(ORA-24372: the view exists but is invalid)" << coral::MessageStream::endmsg;
          throw InvalidViewException( m_sessionProperties->domainServiceName(), fullViewName );
        }
        else throw coral::SchemaException( m_sessionProperties->domainServiceName(), "Could not retrieve a describe handle", "ISchema::existsView" );
      }
      else
      {
        // WARN that 1403 is handled as equivalent to 4043 (bug #49657)
        if ( errorHandler.lastErrorCode() == 1403 )
        {
          coral::MessageStream log( m_sessionProperties->domainServiceName() );
          log << coral::Verbose << errorHandler.message() << coral::MessageStream::endmsg;
        }
        // Error 4043 or 1403: no such table -> check if it is a synonym
        std::string viewForSynonym = this->synonymForTable( viewName );
        if ( viewForSynonym.empty() || (viewForSynonym == viewName) )
          return false;
        else
          return this->existsView( viewForSynonym );
      }
    }
    else
    {
      coral::lock_guard lock( m_viewMutex );
      if ( m_views.find( viewName ) != m_views.end() )
      {
        // Another thread was faster...
        OCIHandleFree( ociDescribeHandle, OCI_HTYPE_DESCRIBE );
        return true;
      }
      // The view exists. Create the view object and insert it into the map
      OracleAccess::View* view = new OracleAccess::View( m_sessionProperties,
                                                         m_schemaName,
                                                         viewName,
                                                         ociDescribeHandle );
      m_views.insert( std::make_pair( viewName, view ) );
      return true;
    }
  }
  else
    return true;
}

//-----------------------------------------------------------------------------

void
coral::OracleAccess::Schema::dropView( const std::string& viewName )
{
  if ( !m_userSessionStarted ) // This schema was "deleted" (bug #80178)
    throw SessionException( "User session has already ended",
                            "Schema::dropView",
                            m_sessionProperties->domainServiceName() );
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::dropView" );
  if ( m_sessionProperties->isReadOnly() )
    throw coral::InvalidOperationInReadOnlyModeException( m_sessionProperties->domainServiceName(), "ISchema::dropView" );
  if ( m_sessionProperties->isTransactionReadOnly() )
    throw coral::InvalidOperationInReadOnlyTransactionException( m_sessionProperties->domainServiceName(), "ISchema::dropView" );
  try
  {
    if ( ! this->existsView( viewName ) )
      throw coral::ViewNotExistingException( m_sessionProperties->domainServiceName(), viewName, "ISchema::dropView" );
  }
  catch ( InvalidViewException& )
  {
    // The view is invalid, drop it anyway (bug #92418)
  }
  OracleAccess::OracleStatement statement( m_sessionProperties,
                                           m_schemaName,
                                           "DROP VIEW " + m_schemaName + ".\"" + viewName + "\"" );
  if ( ! statement.execute( coral::AttributeList() ) )
    throw coral::SchemaException( m_sessionProperties->domainServiceName(),
                                  "Could not drop a view",
                                  "ISchema::dropView" );
  coral::lock_guard lock( m_viewMutex );
  std::map< std::string, OracleAccess::View* >::iterator iView = m_views.find( viewName );
  // If the view is invalid, you may drop it in SQL, but it may be
  // missing in the OracleAccess schema cache (bug #92418)
  if ( iView != m_views.end() )
  {
    if ( iView->second ) delete iView->second;
    m_views.erase( iView );
  }
}

//-----------------------------------------------------------------------------

void
coral::OracleAccess::Schema::dropIfExistsView( const std::string& viewName )
{
  if ( !m_userSessionStarted ) // This schema was "deleted" (bug #80178)
    throw SessionException( "User session has already ended",
                            "Schema::dropIfExistsView",
                            m_sessionProperties->domainServiceName() );
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::dropIfExistsView" );
  if ( m_sessionProperties->isReadOnly() )
    throw coral::InvalidOperationInReadOnlyModeException( m_sessionProperties->domainServiceName(), "ISchema::dropIfExistsView" );
  if ( m_sessionProperties->isTransactionReadOnly() )
    throw coral::InvalidOperationInReadOnlyTransactionException( m_sessionProperties->domainServiceName(), "ISchema::dropIfExistsView" );
  try
  {
    if( this->existsView( viewName ) ) this->dropView( viewName );
  }
  catch ( InvalidViewException& )
  {
    // The view is invalid, drop it anyway (bug #92418)
    this->dropView( viewName );
  }
}

//-----------------------------------------------------------------------------

coral::IView&
coral::OracleAccess::Schema::viewHandle( const std::string& viewName )
{
  if ( !m_userSessionStarted ) // This schema was "deleted" (bug #80178)
    throw SessionException( "User session has already ended",
                            "Schema::viewHandle",
                            m_sessionProperties->domainServiceName() );
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::viewHandle" );
  // Check if the view is already in the local cache.
  std::map< std::string, OracleAccess::View* >::iterator iView;
  bool needDescription = false;
  {
    coral::lock_guard lock( m_viewMutex );
    iView = m_views.find( viewName );
    needDescription = ( iView == m_views.end() || iView->second == 0 );
  }
  if ( needDescription )
  {
    // The fully qualified view name
    const std::string fullViewName = m_schemaName + ".\"" + viewName + "\"";
    // Try to get the descriptor handle
    void* temporaryPointer = 0;
    sword status = OCIHandleAlloc( m_sessionProperties->ociEnvHandle(),
                                   &temporaryPointer,
                                   OCI_HTYPE_DESCRIBE, 0, 0 );
    if ( status != OCI_SUCCESS )
    {
      throw coral::SchemaException( m_sessionProperties->domainServiceName(),
                                    "Could not allocate a describe handle",
                                    "ISchema::viewHandle" );
    }
    OCIDescribe* ociDescribeHandle = static_cast< OCIDescribe* >( temporaryPointer );
    status = OCIDescribeAny( m_sessionProperties->ociSvcCtxHandle(),
                             m_sessionProperties->ociErrorHandle(),
                             const_cast<char *>( fullViewName.c_str() ),
                             ::strlen( fullViewName.c_str() ),
                             OCI_OTYPE_NAME, OCI_DEFAULT,
                             OCI_PTYPE_VIEW,
                             ociDescribeHandle );
    if ( status != OCI_SUCCESS )
    {
      OracleAccess::OracleErrorHandler errorHandler( m_sessionProperties->ociErrorHandle() );
      errorHandler.handleCase( status, "retrieving the describe handle of " + fullViewName );
      OCIHandleFree( ociDescribeHandle, OCI_HTYPE_DESCRIBE );
      if ( errorHandler.lastErrorCode() != 4043 &&
           errorHandler.lastErrorCode() != 1403 )
      {
        // Errors other than 4043 or 1403: unexpected problem -> throw
        coral::MessageStream log( m_sessionProperties->domainServiceName() );
        log << coral::Error << errorHandler.message() << coral::MessageStream::endmsg;
        throw coral::SchemaException( m_sessionProperties->domainServiceName(),
                                      "Could not retrieve a describe handle",
                                      "ISchema::viewHandle" );
      }
      else
      {
        // WARN that 1403 is handled as equivalent to 4043 (bug #49657)
        if ( errorHandler.lastErrorCode() == 1403 )
        {
          coral::MessageStream log( m_sessionProperties->domainServiceName() );
          log << coral::Verbose << errorHandler.message() << coral::MessageStream::endmsg;
        }
        // Error 4043 or 1403: no such view -> throw ViewNotExistingException
        throw coral::ViewNotExistingException( m_sessionProperties->domainServiceName(), fullViewName );
      }
    }
    coral::lock_guard lock( m_viewMutex );
    iView = m_views.find( viewName );
    if ( iView != m_views.end() && iView->second != 0 )
    {
      // Another thread was faster...
      OCIHandleFree( ociDescribeHandle, OCI_HTYPE_DESCRIBE );
    }
    else
    {
      // The view exists. Create the view object and insert it into the map
      OracleAccess::View* view = new OracleAccess::View( m_sessionProperties,
                                                         m_schemaName,
                                                         viewName,
                                                         ociDescribeHandle );
      if ( iView == m_views.end() )
        iView = m_views.insert( std::make_pair( viewName, view ) ).first;
      else
        iView->second = view;
    }
    return *( iView->second );
  }
  return *( iView->second );
}

//-----------------------------------------------------------------------------

std::set<std::string>
coral::OracleAccess::Schema::listViews() const
{
  if ( !m_userSessionStarted ) // This schema was "deleted" (bug #80178)
    throw SessionException( "User session has already ended",
                            "Schema::listViews",
                            m_sessionProperties->domainServiceName() );
  if ( ! m_sessionProperties->isTransactionActive() )
    throw coral::TransactionNotActiveException( m_sessionProperties->domainServiceName(), "ISchema::listViews" );
  std::set<std::string> result;
  if ( ! m_viewsReadFromDataDictionary )
    this->readViewsFromDataDictionary();
  coral::lock_guard lock( m_viewMutex );
  for ( std::map< std::string, OracleAccess::View*>::const_iterator iView = m_views.begin(); iView != m_views.end(); ++iView )
  {
    result.insert( iView->first );
  }
  return result;
}

//-----------------------------------------------------------------------------

void
coral::OracleAccess::Schema::reactOnEndOfTransaction()
{
  if ( !m_userSessionStarted ) // This schema was "deleted" (bug #80178)
    throw SessionException( "User session has already ended",
                            "Schema::reactOnEndOfTransaction",
                            m_sessionProperties->domainServiceName() );
  coral::lock_guard lock( m_tableMutex );
  for ( std::map< std::string, OracleAccess::Table* >::iterator iTable = m_tables.begin(); iTable != m_tables.end(); ++iTable )
  {
    if ( iTable->second ) delete iTable->second;
  }
  m_tables.clear();
  m_tablesReadFromDataDictionary = false;
  coral::lock_guard lockViews( m_viewMutex );
  for ( std::map< std::string, OracleAccess::View* >::iterator iView = m_views.begin(); iView != m_views.end(); ++iView )
  {
    if ( iView->second ) delete iView->second;
  }
  m_views.clear();
  m_viewsReadFromDataDictionary = false;
}

//-----------------------------------------------------------------------------

void
coral::OracleAccess::Schema::readTablesFromDataDictionary() const
{
  if ( !m_userSessionStarted ) // This schema was "deleted" (bug #80178)
    throw SessionException( "User session has already ended",
                            "Schema::readTablesFromDataDictionary",
                            m_sessionProperties->domainServiceName() );
  coral::AttributeList bindData;
  bindData.extend<std::string>( "OWNER" );
  bindData.begin()->data<std::string>() = m_schemaName;
  std::auto_ptr<OracleAccess::OracleStatement> pStatement;
  // Task #10775 (performance optimization for data dictionary queries)
  // Optimization (requires read access to sys tables)
  // The selectAnyTable is initially true but is set to false if query fails
  if ( m_sessionProperties->selectAnyTable() )
  {
    std::string userDollar = "user$";
    if ( m_sessionProperties->majorServerVersion() >= 12 )
      userDollar = "ku$_user_mapping_view";  // workaround for bug #102231
    std::ostringstream os;
    os << "select /*+ INDEX(o I_OBJ2) */ o.name as TABLE_NAME "
       << "from sys." << userDollar << " u, sys.obj$ o "
       << "where u.name=:OWNER "
       << "and o.owner#=u.user# and o.type#=2";
    //std::cout << std::endl << "EXECUTE: " << os.str() << std::endl;
    pStatement.reset( new OracleAccess::OracleStatement( m_sessionProperties, m_schemaName, os.str() ) );
    pStatement->setNumberOfPrefetchedRows( 100 );
    if ( ! pStatement->execute( bindData ) )
      m_sessionProperties->cannotSelectAnyTable();
  }
  // Task #10775 (performance optimization for data dictionary queries)
  // Query on ALL_TABLES (valid for all users)
  // The selectAnyTable has been set to false if the first attempt failed
  if ( !m_sessionProperties->selectAnyTable() )
  {
    std::ostringstream os;
    os << "SELECT /* user has no SELECT ANY TABLE privileges */ "
       << "TABLE_NAME FROM ALL_TABLES WHERE OWNER=:OWNER";
    //std::cout << std::endl << "EXECUTE: " << os.str() << std::endl;
    pStatement.reset( new OracleAccess::OracleStatement( m_sessionProperties, m_schemaName, os.str() ) );
    pStatement->setNumberOfPrefetchedRows( 100 );
    if ( ! pStatement->execute( bindData ) )
    {
      pStatement.reset();
      throw coral::SchemaException
        ( m_sessionProperties->domainServiceName(),
          "Could not retrieve the list of tables in a schema",
          "Schema::readTablesFromDataDictionary" );
    }
  }
  coral::lock_guard lock( m_tableMutex );
  coral::AttributeList output;
  output.extend<std::string>( "TABLE_NAME" );
  const std::string& tableName = output.begin()->data<std::string>();
  pStatement->defineOutput( output );
  while( pStatement->fetchNext() )
  {
    if ( m_tables.find( tableName ) == m_tables.end() )
    {
      m_tables[tableName] = 0;
    }
  }
  m_tablesReadFromDataDictionary = true;
  pStatement.reset();
}

//-----------------------------------------------------------------------------

void
coral::OracleAccess::Schema::readViewsFromDataDictionary() const
{
  if ( !m_userSessionStarted ) // This schema was "deleted" (bug #80178)
    throw SessionException( "User session has already ended",
                            "Schema::readViewsFromDataDictionary",
                            m_sessionProperties->domainServiceName() );
  OracleAccess::OracleStatement statement( m_sessionProperties,
                                           m_schemaName,
                                           "SELECT VIEW_NAME FROM ALL_VIEWS WHERE OWNER=:\"owner\"" );
  statement.setNumberOfPrefetchedRows( 100 );
  coral::AttributeList bindData;
  bindData.extend<std::string>( "owner" );
  bindData.begin()->data<std::string>() = m_schemaName;
  if ( ! statement.execute( bindData ) ) // Fix Coverity CHECKED_RETURN
    throw coral::SchemaException( m_sessionProperties->domainServiceName(),
                                  "Could not read views from data dictionary",
                                  "ISchema::readViewsFromDataDictionary" );
  coral::AttributeList output;
  output.extend<std::string>( "VIEW_NAME" );
  const std::string& viewName = output.begin()->data<std::string>();
  statement.defineOutput( output );
  coral::lock_guard lock( m_viewMutex );
  while( statement.fetchNext() )
  {
    if ( m_views.find( viewName ) == m_views.end() )
    {
      m_views[viewName] = 0;
    }
  }
  m_viewsReadFromDataDictionary = true;
}

//-----------------------------------------------------------------------------

void
coral::OracleAccess::Schema::startUserSession()
{
  // Sanity check: 'creating' an already 'created' schema?
  if ( m_userSessionStarted )
    throw SessionException( "PANIC! User session has already started",
                            "Schema::startUserSession",
                            m_sessionProperties->domainServiceName() );
  m_userSessionStarted = true;
}

//-----------------------------------------------------------------------------

void
coral::OracleAccess::Schema::endUserSession()
{
  // Sanity check: 'deleting' an already 'deleted' schema?
  if ( !m_userSessionStarted )
    throw SessionException( "PANIC! User session has already ended",
                            "Schema::endUserSession",
                            m_sessionProperties->domainServiceName() );
  this->reactOnEndOfTransaction();
  m_userSessionStarted = false;
}

//-----------------------------------------------------------------------------
