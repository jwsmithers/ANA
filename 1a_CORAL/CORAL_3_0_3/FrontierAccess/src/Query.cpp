// First of all, enable or disable the CORAL240 API extensions (bug #89707)
#include "CoralBase/VersionInfo.h"

#include "Query.h"
#include "SessionProperties.h"
#include "DomainProperties.h"
#include "Cursor.h"
#include "Statement.h"

#include "RelationalAccess/SchemaException.h"

#include "CoralBase/AttributeList.h"
#include "CoralBase/Attribute.h"

#include "CoralKernel/Service.h"

coral::FrontierAccess::Query::Query( boost::shared_ptr<const SessionProperties> properties, const std::string& tableName )
  : coral::FrontierAccess::QueryDefinition( properties, tableName ),
    m_cursor( 0 ),
    m_cacheSize( 0 ),
    m_outputBuffer( 0 ),
    m_outputTypes()
{
}

coral::FrontierAccess::Query::Query( boost::shared_ptr<const SessionProperties> properties )
  : coral::FrontierAccess::QueryDefinition( properties ),
    m_cursor( 0 ),
    m_cacheSize( 0 ),
    m_outputBuffer( 0 ),
    m_outputTypes()
{
}

coral::FrontierAccess::Query::~Query()
{
  if ( m_outputBuffer ) delete m_outputBuffer;
  if ( m_cursor ) delete m_cursor;
}

void coral::FrontierAccess::Query::setForUpdate()
{
  throw coral::InvalidOperationInReadOnlyModeException( m_sessionProperties->domainServiceName(), "FrontierAccess::Query::setForUpdate" );
}

void coral::FrontierAccess::Query::setRowCacheSize( int numberOfCachedRows )
{
  if ( m_cursor )
    throw coral::QueryExecutedException( m_sessionProperties->domainServiceName(), "IQuery::setRowCacheSize" );
  m_cacheSize = numberOfCachedRows;
}

void coral::FrontierAccess::Query::setMemoryCacheSize( int sizeInMB )
{
  if ( m_cursor )
    throw coral::QueryExecutedException( m_sessionProperties->domainServiceName(), "IQuery::setMemoryCacheSize" );
  m_cacheSize = -sizeInMB;
}

void coral::FrontierAccess::Query::defineOutputType( const std::string& outputIdentifier, const std::string& cppTypeName )
{
  if ( m_cursor )
    throw coral::QueryExecutedException( m_sessionProperties->domainServiceName(), "IQuery::defineOutputTypes" );
  if ( m_outputBuffer ) {
    delete m_outputBuffer;
    m_outputBuffer = 0;
  }
  m_outputTypes.insert( std::make_pair( outputIdentifier, cppTypeName ) );
}

void coral::FrontierAccess::Query::defineOutput( coral::AttributeList& outputDataBuffer )
{
  if ( m_cursor )
    throw coral::QueryExecutedException( m_sessionProperties->domainServiceName(), "IQuery::defineOutput" );

  if ( m_outputBuffer )
    delete m_outputBuffer;

  m_outputBuffer = new coral::AttributeList( outputDataBuffer );
  const unsigned int numberOfVariables = outputDataBuffer.size();

  for ( unsigned int i = 0; i < numberOfVariables; ++i )
  {
    (*m_outputBuffer)[i].shareData( outputDataBuffer[i] );
  }
}

coral::ICursor& coral::FrontierAccess::Query::execute()
{
  if ( m_cursor )
    throw coral::QueryExecutedException( m_sessionProperties->domainServiceName(), "IQuery::execute" );

  // Get the sql fragment from the definition
  std::string sqlStatement = this->sqlFragment();

  // Prepare the statement.
  coral::FrontierAccess::Statement* statement = new coral::FrontierAccess::Statement( this->sessionProperties(), sqlStatement );

  // Define the cache size.
  if ( m_cacheSize < 0 ) {
    statement->setCacheSize( -m_cacheSize );
  }
  else if ( m_cacheSize > 0 ) {
    statement->setNumberOfPrefetchedRows( m_cacheSize );
  }

#ifndef CORAL300WC
  bool result = statement->execute( this->bindData(), this->reload() );
#else
  bool result = statement->execute( this->bindData(), this->timeToLive() );
#endif

  if ( ! result )
    throw coral::QueryException( m_sessionProperties->domainServiceName(), "Could not execute a query", "IQuery::execute" );

  const std::vector< std::string >& outputNames = this->outputVariables();

  // Define the output.
  if ( ! m_outputBuffer )
  {
    m_outputBuffer = new coral::AttributeList;
    int position = 0;
    for ( std::vector<std::string>::const_iterator iOutput = outputNames.begin(); iOutput != outputNames.end(); ++iOutput, ++position )
    {
      // Check if the type is known.
      std::map< std::string, std::string >::const_iterator iType = m_outputTypes.find( *iOutput );

      if ( iType != m_outputTypes.end() )
      {
        m_outputBuffer->extend( iType->first, iType->second );
      }
      else
      {
        const std::type_info* typeId = statement->typeForOutputColumn( position );
        if ( typeId == 0 )
          throw coral::QueryException( m_sessionProperties->domainServiceName(), "Could not identify output type for \"" + *iOutput + "\"", "IQuery::execute" );
        m_outputBuffer->extend( *iOutput,*typeId );
      }
    }
  }

  statement->defineOutput( *m_outputBuffer );

  // Return the cursor
  m_cursor = new coral::FrontierAccess::Cursor( statement, *m_outputBuffer );
  return *m_cursor;
}
