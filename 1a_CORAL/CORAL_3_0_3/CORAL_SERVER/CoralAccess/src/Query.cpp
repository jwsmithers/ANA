
// Include files
#include <iostream>
#include <sstream>
#include "CoralBase/Attribute.h"
#include "CoralServerBase/InternalErrorException.h"
#include "CoralServerBase/NotImplemented.h"
#include "RelationalAccess/SchemaException.h"

// Local include files
#include "ConnectionProperties.h"
#include "Cursor.h"
#include "Query.h"
#include "SessionProperties.h"
#include "logger.h"

// Namespace
using namespace coral::CoralAccess;

//-----------------------------------------------------------------------------

Query::Query( const SessionProperties& sessionProperties,
              const std::string& schemaName,
              const std::string& tableName )
  : QueryDefinition( schemaName, tableName )
  , m_sessionProperties( sessionProperties )
  , m_rowCacheSize( 0 ) // use the backend default
  , m_memoryCacheSize( 0 ) // use the backend default
  , m_outputTypes()
  , m_pOutputBuffer( 0 )
  , m_pCursor( 0 )
{
  logger << "Create Query" << endlog;
}

//-----------------------------------------------------------------------------

Query::~Query()
{
  logger << "Delete Query" << endlog;
  if ( m_pCursor ) delete m_pCursor;
  m_pCursor = 0;
  if ( m_pOutputBuffer ) delete m_pOutputBuffer;
  m_pOutputBuffer = 0;
}

//-----------------------------------------------------------------------------

void Query::setForUpdate()
{
  throw NotImplemented("Query::setForUpdate");
}

//-----------------------------------------------------------------------------

void Query::setRowCacheSize( int numberOfCachedRows )
{
  if ( numberOfCachedRows < 0 )
  {
    logger << Warning << "Query::setRowCacheSize called with #rows < 0 : will use 0" << endlog;
    m_rowCacheSize = 0;
  }
  else
    m_rowCacheSize = numberOfCachedRows;
}

//-----------------------------------------------------------------------------

void Query::setMemoryCacheSize( int sizeInMB )
{
  if ( sizeInMB < 0 )
  {
    logger << Warning << "Query::setMemoryCacheSize called with sizeInMB < 0 : will use 0" << endlog;
    m_memoryCacheSize = 0;
  }
  else
    m_memoryCacheSize = sizeInMB;
}

//-----------------------------------------------------------------------------

void Query::defineOutputType( const std::string& outputIdentifier,
                              const std::string& cppTypeName )
{
  if ( m_pCursor )
    throw coral::QueryExecutedException( "coral::CoralAccess",
                                         "Query::defineOutputType" );

  // Create a new AttributeList with the required specification
  if ( m_pOutputBuffer )
  {
    logger << Warning << "Query::defineOutputType supersedes previous call to Query::defineOutput" << endlog;
    delete m_pOutputBuffer;
    m_pOutputBuffer = 0;
    if ( m_outputTypes.size() > 0 )
      throw InternalErrorException( "PANIC! Output buffer and types are both defined",
                                    "Query::defineOutputType",
                                    "coral::CoralAccess" );
  }
  m_outputTypes.insert( std::make_pair( outputIdentifier, cppTypeName ) );
}

//-----------------------------------------------------------------------------

void Query::defineOutput( coral::AttributeList& outputDataBuffer )
{
  if ( m_pCursor )
    throw coral::QueryExecutedException( "coral::CoralAccess",
                                         "Query::defineOutput" );

  // Create a new AttributeList sharing the given data buffer
  if ( m_outputTypes.size() > 0 )
  {
    logger << Warning << "Query::defineOutput supersedes previous call to Query::defineOutputTypes" << endlog;
    m_outputTypes.clear();
    if ( m_pOutputBuffer )
      throw InternalErrorException( "PANIC! Output buffer and types are both defined",
                                    "Query::defineOutput",
                                    "coral::CoralAccess" );

  }
  else if ( m_pOutputBuffer )
  {
    logger << Warning << "Query::defineOutput supersedes previous call to Query::defineOutput" << endlog;
    delete m_pOutputBuffer;
  }
  m_pOutputBuffer = new coral::AttributeList( outputDataBuffer );
  //std::cout << "Define new output buffer " << m_pOutputBuffer << " sharing data of " << &outputDataBuffer << std::endl;
  //logger << "Define new output buffer " << m_pOutputBuffer << " sharing data of " << &outputDataBuffer << endlog;
  //logger << "Attribute #0 is " << &((*m_pOutputBuffer)[0]) << " sharing data of " << &(outputDataBuffer[0]) << endlog;
  const unsigned int numberOfVariables = outputDataBuffer.size();
  for ( unsigned int i = 0; i < numberOfVariables; ++i )
    (*m_pOutputBuffer)[i].shareData( outputDataBuffer[i] );
  //for ( unsigned int i = 0; i < numberOfVariables; ++i )
  //  logger << "\nAL "<<&outputDataBuffer<<" #"<<i<<" is " << &(outputDataBuffer[i]) << endlog;
}

//-----------------------------------------------------------------------------

coral::ICursor& Query::execute()
{
  if ( m_pCursor )
    throw Exception( "Query is already executing",
                     "Query::execute",
                     "coral::CoralAccess" );

  // Debug printout
  std::stringstream msg;
  msg << "Execute query (row cache size = ";
  if ( m_rowCacheSize>0 ) msg << m_rowCacheSize;
  else msg << "unlimited";
  msg << ", memory cache size = ";
  if ( m_memoryCacheSize>0 ) msg << m_memoryCacheSize << " MB)";
  else msg << "unlimited)";
  logger << msg.str() << endlog;

  // Check if output buffer or types are defined and create appropriate cursor
  if ( m_outputTypes.size() > 0 )
  {
    if ( m_pOutputBuffer )
      throw InternalErrorException( "PANIC! Output buffer and types are both defined",
                                    "Query::execute",
                                    "coral::CoralAccess" );
    m_pCursor = new Cursor( m_sessionProperties,
                            *this,
                            m_outputTypes,
                            m_rowCacheSize,
                            m_memoryCacheSize );
  }
  else
    m_pCursor = new Cursor( m_sessionProperties,
                            *this,
                            m_pOutputBuffer,
                            m_rowCacheSize,
                            m_memoryCacheSize );
  // Return the cursor
  return *m_pCursor;
}

//-----------------------------------------------------------------------------

const coral::ICoralFacade& Query::facade() const
{
  return m_sessionProperties.connectionProperties().facade();
}

//-----------------------------------------------------------------------------
