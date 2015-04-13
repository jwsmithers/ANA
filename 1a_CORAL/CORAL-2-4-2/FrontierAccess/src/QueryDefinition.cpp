#include "QueryDefinition.h"
#include "SessionProperties.h"
#include "DomainProperties.h"
#include "View.h"
#include "Schema.h"

#include "RelationalAccess/SchemaException.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ITable.h"
#include "RelationalAccess/ITableDescription.h"
#include "RelationalAccess/IColumn.h"
#include "RelationalAccess/ConnectionService.h"
#include "RelationalAccess/IWebCacheControl.h"
#include "RelationalAccess/IWebCacheInfo.h"

#include "CoralBase/AttributeList.h"
#include "CoralBase/Attribute.h"

#include "CoralBase/MessageStream.h"

#include "CoralKernel/Service.h"

#include "CoralCommon/ExpressionParser.h"

#include <sstream>
#include <stdexcept>
#include <iostream>

using coral::CoralCommon::ExpressionParser;

coral::FrontierAccess::QueryDefinition::QueryDefinition( boost::shared_ptr<const SessionProperties> properties )
  : m_sessionProperties( properties ),
    m_singleTable( false ),
    m_sqlFragment( "" ),
    m_inputData( 0 ),
    m_distinct( false ),
    m_outputList(),
    m_tableList(),
    m_subQueries(),
    m_condition( "" ),
    m_grouping( "" ),
    m_orderList(),
    m_rowLimit( 0 ),
    m_rowOffset( 0 ),
    m_setQuery( 0, coral::IQueryDefinition::Union ),
    m_output(),
    m_reload( false )
{
}

coral::FrontierAccess::QueryDefinition::QueryDefinition( boost::shared_ptr<const SessionProperties> properties, const std::string& tableName )
  : m_sessionProperties( properties ),
    m_singleTable( true ),
    m_sqlFragment( "" ),
    m_inputData( 0 ),
    m_distinct( false ),
    m_outputList(),
    m_tableList(),
    m_subQueries(),
    m_condition( "" ),
    m_grouping( "" ),
    m_orderList(),
    m_rowLimit( 0 ),
    m_rowOffset( 0 ),
    m_setQuery( 0, coral::IQueryDefinition::Union ),
    m_output(),
    m_reload( false )
{
  m_tableList.push_back( std::make_pair( tableName, tableName ) );
}

coral::FrontierAccess::QueryDefinition::~QueryDefinition()
{
  if ( m_setQuery.first )
    delete m_setQuery.first;
  if ( m_inputData )
    delete m_inputData;
}

std::string coral::FrontierAccess::QueryDefinition::sqlFragment() const
{
  if ( m_sqlFragment.empty() )
    const_cast< coral::FrontierAccess::QueryDefinition* >( this )->process();
  return m_sqlFragment;
}


const coral::AttributeList& coral::FrontierAccess::QueryDefinition::bindData() const
{
  if ( m_sqlFragment.empty() )
    const_cast< coral::FrontierAccess::QueryDefinition* >( this )->process();
  return *m_inputData;
}

const std::vector<std::string> coral::FrontierAccess::QueryDefinition::outputVariables() const
{
  if ( m_sqlFragment.empty() )
    const_cast< coral::FrontierAccess::QueryDefinition* >( this )->process();
  return m_output;
}

boost::shared_ptr<const coral::FrontierAccess::SessionProperties>
coral::FrontierAccess::QueryDefinition::sessionProperties() const
{
  return m_sessionProperties;
}


void coral::FrontierAccess::QueryDefinition::setDistinct()
{
  if ( ! m_sqlFragment.empty() )
    throw coral::QueryExecutedException( m_sessionProperties->domainServiceName(),
                                         "IQueryDefinition::setDistinct" );
  m_distinct = true;
}


void coral::FrontierAccess::QueryDefinition::addToOutputList( const std::string& expression, std::string alias )
{
  if ( ! m_sqlFragment.empty() )
    throw coral::QueryExecutedException( m_sessionProperties->domainServiceName(),
                                         "IQueryDefinition::addToOutputList" );
  m_outputList.push_back( std::make_pair( expression, alias ) );
}


void coral::FrontierAccess::QueryDefinition::addToTableList( const std::string& tableName, std::string alias )
{
  if ( ! m_sqlFragment.empty() )
    throw coral::QueryExecutedException( m_sessionProperties->domainServiceName(), "IQueryDefinition::addToTableList" );
  if ( m_singleTable )
    throw coral::QueryException( m_sessionProperties->domainServiceName(), "method cannot be invoked on queries on a single table", "IQueryDefinition::addToTableList" );

  m_tableList.push_back( std::make_pair( tableName, (alias.empty() ? tableName : alias) ) );
}


coral::IQueryDefinition& coral::FrontierAccess::QueryDefinition::defineSubQuery( const std::string& alias )
{
  if ( ! m_sqlFragment.empty() )
    throw coral::QueryExecutedException( m_sessionProperties->domainServiceName(),"IQueryDefinition::defineSubQuery" );

  if ( m_singleTable ) {
    return m_subQueries.insert( std::make_pair( alias, coral::FrontierAccess::QueryDefinition( m_sessionProperties, m_tableList.begin()->first ) ) ).first->second;
  }
  else {
    return m_subQueries.insert( std::make_pair( alias, coral::FrontierAccess::QueryDefinition( m_sessionProperties ) ) ).first->second;
  }
}


void coral::FrontierAccess::QueryDefinition::setCondition( const std::string& condition, const coral::AttributeList& inputData )
{
  if ( ! m_sqlFragment.empty() )
    throw coral::QueryExecutedException( m_sessionProperties->domainServiceName(), "IQueryDefinition::setCondition" );

  if ( m_inputData )
  {
    delete m_inputData;
    m_inputData = 0;
  }

  if ( inputData.size() > 0 )
  {
    m_inputData = new coral::AttributeList( inputData );
    const unsigned int numberOfVariables = inputData.size();
    for ( unsigned int i = 0; i < numberOfVariables; ++i )
    {
      (*m_inputData)[i].shareData( inputData[i] );
    }
  }

  m_condition = condition;
}


void coral::FrontierAccess::QueryDefinition::groupBy( const std::string& expression )
{
  if ( ! m_sqlFragment.empty() )
    throw coral::QueryExecutedException( m_sessionProperties->domainServiceName(),
                                         "IQueryDefinition::groupBy" );
  m_grouping = expression;
}


void coral::FrontierAccess::QueryDefinition::addToOrderList( const std::string& expression )
{
  if ( ! m_sqlFragment.empty() )
    throw coral::QueryExecutedException( m_sessionProperties->domainServiceName(), "IQueryDefinition::addToOrderList" );
  m_orderList.push_back( expression );
}


void coral::FrontierAccess::QueryDefinition::limitReturnedRows( int maxRows, int offset )
{
  if ( ! m_sqlFragment.empty() )
    throw coral::QueryExecutedException( m_sessionProperties->domainServiceName(), "IQueryDefinition::limitReturnedRows" );
  m_rowLimit = maxRows;
  m_rowOffset = offset;
}


coral::IQueryDefinition& coral::FrontierAccess::QueryDefinition::applySetOperation( coral::IQueryDefinition::SetOperation opetationType )
{
  if ( ! m_sqlFragment.empty() )
    throw coral::QueryExecutedException( m_sessionProperties->domainServiceName(), "IQueryDefinition::applySetOperation" );

  if ( m_setQuery.first )
    delete m_setQuery.first;

  m_setQuery.second = opetationType;

  if ( m_singleTable )
    m_setQuery.first = new coral::FrontierAccess::QueryDefinition( m_sessionProperties, m_tableList.begin()->first );
  else
    m_setQuery.first = new coral::FrontierAccess::QueryDefinition( m_sessionProperties );

  return *( m_setQuery.first );
}


void coral::FrontierAccess::QueryDefinition::process()
{
  coral::MessageStream log( m_sessionProperties->domainServiceName() );

  if ( ! m_inputData )
    m_inputData = new coral::AttributeList;

  // An expression parser for the subsequent calls
  ExpressionParser expressionParser;

  for ( std::vector< std::pair< std::string, std::string > >::const_iterator iTable = m_tableList.begin(); iTable != m_tableList.end(); ++iTable )
  {
    const std::string& tableName  = iTable->first;
    const std::string& tableAlias = iTable->second;

    if( ! tableAlias.empty() )
    {
      expressionParser.addToAliases( tableAlias );
    }

    // Check if it is a subquery...
    std::map< std::string, coral::FrontierAccess::QueryDefinition >::const_iterator iTableQ = m_subQueries.find( tableName );

    if ( iTableQ != m_subQueries.end() )
    {
      expressionParser.addToTableList( iTableQ->first, iTableQ->second.outputVariables() );
    }
    else if ( m_sessionProperties->schema().existsTable( tableName ) )
      expressionParser.addToTableList( tableName, *( dynamic_cast< coral::FrontierAccess::Schema& >( m_sessionProperties->schema() ).tableColumns( tableName ) ) );
    else if ( m_sessionProperties->schema().existsView( tableName ) )
      expressionParser.addToTableList( dynamic_cast< const ::coral::FrontierAccess::View& >( m_sessionProperties->schema().viewHandle( tableName ) ).description() );
  }

  // Check if the current schema is to be refreshed
  try
  {
    coral::ConnectionService connSvc;
    coral::IWebCacheControl& cachectrl = connSvc.webCacheControl();
    const coral::IWebCacheInfo& cacheinfo = cachectrl.webCacheInfo( m_sessionProperties->connectionString() );

    log << coral::Verbose << "Checking web cache control for connection " << m_sessionProperties->connectionString() << coral::MessageStream::endmsg;

    if( ! cacheinfo.isSchemaInfoCached() )
      this->setReload();
    else
      this->setReload( false );
  }
  catch( const std::exception& e )
  {
    //log << coral::Verbose << "Connection string: " << m_sessionProperties->connectionString() << coral::MessageStream::endmsg;
    log << coral::Verbose << e.what() << coral::MessageStream::endmsg;
    log << coral::Verbose << "Running query in cached mode..." << coral::MessageStream::endmsg;
  }

  // Construct the query.
  std::ostringstream os;
  os << "SELECT ";

  if( this->m_distinct )
    os << "DISTINCT ";

  if ( m_outputList.empty() && m_tableList.size() == 1 )
  { // wildcard query on a table or view.
    os << "*";
    const std::string& tableName = m_tableList.begin()->first;

    if ( m_singleTable || m_sessionProperties->schema().existsTable( tableName ) ) // Check if it is a table
    {
      const std::vector< std::string >* columns = dynamic_cast< coral::FrontierAccess::Schema& >( m_sessionProperties->schema() ).tableColumns( tableName );
      for ( std::vector< std::string >::const_iterator iColumns = columns->begin(); iColumns != columns->end(); ++iColumns )
        m_output.push_back( *iColumns );
    }
    else if ( m_sessionProperties->schema().existsView( tableName ) ) // Check if it is a query
    {
      const coral::IView& view = m_sessionProperties->schema().viewHandle( tableName );
      int numberOfColumns = view.numberOfColumns();
      for ( int i = 0; i < numberOfColumns; ++i )
        m_output.push_back( view.column(i).name() );
    }
    else // Check if it is a sub-query
    {
      std::map< std::string, coral::FrontierAccess::QueryDefinition >::const_iterator iTable = m_subQueries.find( tableName );
      if ( iTable != m_subQueries.end() )
      {
        const std::vector< std::string >& outputColumns = iTable->second.outputVariables();
        for ( std::vector< std::string >::const_iterator iColumn = outputColumns.begin(); iColumn != outputColumns.end(); ++iColumn )
        {
          m_output.push_back( *iColumn );
        }
      }
    }
  }

  // The output variables
  for ( std::vector< std::pair< std::string, std::string > >::const_iterator iVariable = m_outputList.begin(); iVariable != m_outputList.end(); ++iVariable )
  {
    if ( iVariable != m_outputList.begin() ) os << ", ";
    m_output.push_back( iVariable->first );

    os << expressionParser.parseExpression( iVariable->first );

    if ( ! ( iVariable->second.empty() ) )
    {
      os << " AS \"" << iVariable->second << "\"";
      m_output.back() = iVariable->second;
    }
  }

  // The table list.
  os << " FROM ";
  for ( std::vector< std::pair< std::string, std::string > >::const_iterator iTable = m_tableList.begin(); iTable != m_tableList.end(); ++iTable )
  {
    if ( iTable != m_tableList.begin() ) os << ", ";

    // Check if this is a subquery
    const std::string& tableName = iTable->first;
    const std::string& aliasName = iTable->second;

    std::map< std::string, coral::FrontierAccess::QueryDefinition >::const_iterator iSubQuery = m_subQueries.find( tableName );

    if ( iSubQuery != m_subQueries.end() )
      os << "( " << iSubQuery->second.sqlFragment() << " ) ";
    else
      os << "\"" << m_sessionProperties->schemaName() << "\".\"" << tableName << "\" ";


    // Negotiate the table name against the web cache control (NOT SURE IT IS GONNA BE USED....)
    try
    {
      coral::ConnectionService connSvc;
      coral::IWebCacheControl& cachectrl = connSvc.webCacheControl();
      const coral::IWebCacheInfo& cacheinfo = cachectrl.webCacheInfo( m_sessionProperties->connectionString() );
      if( ! cacheinfo.isTableCached( tableName ) )
      {
        log << coral::Verbose << "Table " << tableName << " is not cached: reload it" << coral::MessageStream::endmsg;
        this->setReload( true );
      }
      else
      {
        log << coral::Verbose << "Table " << tableName << " is cached: do not reload it" << coral::MessageStream::endmsg;
      }
    }
    catch( const std::exception& e )
    {
      //log << coral::Verbose << "Connection string: " << m_sessionProperties->connectionString() << coral::MessageStream::endmsg;
      log << coral::Verbose << e.what() << coral::MessageStream::endmsg;
      log << coral::Verbose << "Running query in cached mode..." << coral::MessageStream::endmsg;
    }

    if( !aliasName.empty() )
    {
      if ( m_subQueries.find( aliasName ) != m_subQueries.end() ||
           m_sessionProperties->schema().existsTable( aliasName ) ||
           m_sessionProperties->schema().existsView( aliasName ) )
        os << "\"" << aliasName << "\"";
      else
        os << "\"" << aliasName << "\"";

      expressionParser.addToAliases( aliasName );
    }
  }

  // The WHERE clause.
  if ( ! m_condition.empty() )
  {
    if ( m_inputData )
      expressionParser.appendToBindVariables( *m_inputData );
    os << " WHERE " << expressionParser.parseExpression( m_condition );
  }

  // The GROUP BY clause.
  if ( ! m_grouping.empty() ) {
    os << " GROUP BY " << expressionParser.parseExpression( m_grouping );
  }

  // The ORDER BY clause.
  if ( ! m_orderList.empty() )
  {
    os << " ORDER BY ";
    for ( std::vector< std::string>::const_iterator iExpression = m_orderList.begin(); iExpression != m_orderList.end(); ++iExpression )
    {
      if ( iExpression != m_orderList.begin() )
        os << ", ";

      os << expressionParser.parseExpression( *iExpression );
    }
  }

  std::string sqlStatement = os.str();

  // The limiting rows.
  if ( m_rowLimit > 0 )
  {
    std::ostringstream osFinalStatement;
    if ( m_rowOffset == 0 )
    {
      osFinalStatement << "SELECT * FROM (" << sqlStatement << ") WHERE ROWNUM < " << m_rowLimit + m_rowOffset + 1;
    }
    else
    {
      osFinalStatement << "SELECT";
      for ( std::vector<std::string>::const_iterator iOutput = m_output.begin(); iOutput != m_output.end(); ++iOutput )
      {
        if ( iOutput == m_output.begin() )
          osFinalStatement << " \"" << *iOutput << "\"";
        else
          osFinalStatement << ", \"" << *iOutput << "\"";
      }

      osFinalStatement << " FROM (SELECT ROWNUM ROW#";

      for ( std::vector<std::string>::const_iterator iOutput = m_output.begin(); iOutput != m_output.end(); ++iOutput )
        osFinalStatement << ", \"" << *iOutput << "\"";

      osFinalStatement << " FROM (" << sqlStatement << ") ) WHERE ROW# BETWEEN " << 1 + m_rowOffset << " AND " << m_rowLimit + m_rowOffset;
    }

    sqlStatement = osFinalStatement.str();
  }

  // The set operation
  m_sqlFragment = sqlStatement;
  if ( m_setQuery.first )
  {
    switch ( m_setQuery.second )
    {
    case coral::IQueryDefinition::Union:
      m_sqlFragment += " UNION ";
      break;
    case coral::IQueryDefinition::Minus:
      m_sqlFragment += " MINUS ";
      break;
    case coral::IQueryDefinition::Intersect:
      m_sqlFragment += " INTERSECT ";
      break;
    default:
      break;
    };

    m_sqlFragment += m_setQuery.first->sqlFragment();
  }

  // Merge the input data
  for ( std::map< std::string, QueryDefinition >::const_iterator iSubQuery = m_subQueries.begin(); iSubQuery != m_subQueries.end(); ++iSubQuery )
    m_inputData->merge( iSubQuery->second.bindData() );

  if (  m_setQuery.first )
    m_inputData->merge( m_setQuery.first->bindData() );

  // Now we can clean up all the underlying stuff
  m_outputList.clear();
  m_tableList.clear();
  m_subQueries.clear();
  m_orderList.clear();
  if ( m_setQuery.first ) {
    delete m_setQuery.first;
    m_setQuery.first = 0;
  }
}
