// $Id: Cursor.cpp,v 1.10.2.1.2.3 2013-02-08 09:40:06 avalassi Exp $

// Include files
#include <iostream>
//#include "CoralServerBase/attributeListToString.h"
#include "CoralServerBase/NotImplemented.h"

// Local include files
#include "ConnectionProperties.h"
#include "Cursor.h"
#include "SessionProperties.h"
#include "logger.h"
#include "monitoring.h"

// Namespace
using namespace coral::CoralAccess;

//-----------------------------------------------------------------------------

Cursor::Cursor( const SessionProperties& sessionProperties,
                const coral::QueryDefinition& queryDef,
                coral::AttributeList* pOutputBuffer,
                unsigned int rowCacheSize,
                unsigned int memoryCacheSize )
  : m_sessionProperties( sessionProperties )
{
  SCOPED_TIMER( "CoralAccess::Cursor::CursorOB" );
  if ( pOutputBuffer )
    logger << "Create Cursor with non-null output buffer" << endlog;
  else
    logger << "Create Cursor with null output buffer" << endlog;

  std::string enableOpenCursorsEnv = "CORALACCESS_ENABLEOPENCURSORS";
  static int enableOpenCursors = -1;
  if ( enableOpenCursors == -1 ) enableOpenCursors = ( getenv ( enableOpenCursorsEnv.c_str() ) ? 1 : 0 );

  if ( rowCacheSize == 0 && memoryCacheSize == 0 )
  {
    logger << "Cursor with unlimited cache size (in rows and MB): call fetchAllRows" << endlog;
    m_rows = facade().fetchAllRows( m_sessionProperties.sessionID(),
                                    queryDef,
                                    pOutputBuffer );
  }
  else if ( m_sessionProperties.fromProxy() )
  {
    logger << "Cursor with limited cache size (in rows and/or MB), but fromProxy=true: call fetchAllRows" << endlog;
    m_rows = facade().fetchAllRows( m_sessionProperties.sessionID(),
                                    queryDef,
                                    pOutputBuffer );
  }
  else if ( enableOpenCursors == 0 )
  {
    logger << "Cursor with limited cache size (in rows and/or MB) and fromProxy=false, but " << enableOpenCursorsEnv << " is not set: call fetchAllRows" << endlog;
    m_rows = facade().fetchAllRows( m_sessionProperties.sessionID(),
                                    queryDef,
                                    pOutputBuffer );
  }
  else
  {
    logger << "Cursor with limited cache size (in rows and/or MB) and fromProxy=false and " << enableOpenCursorsEnv << " is set: call fetchRows" << endlog;
    m_rows = facade().fetchRows( m_sessionProperties.sessionID(),
                                 queryDef,
                                 pOutputBuffer,
                                 rowCacheSize,
                                 memoryCacheSize );
  }
}

//-----------------------------------------------------------------------------

Cursor::Cursor( const SessionProperties& sessionProperties,
                const coral::QueryDefinition& queryDef,
                const std::map< std::string, std::string > outputTypes,
                unsigned int rowCacheSize,
                unsigned int memoryCacheSize )
  : m_sessionProperties( sessionProperties )
{
  SCOPED_TIMER( "CoralAccess::Cursor::CursorOT" );
  logger << "Create Cursor with output types" << endlog;

  std::string enableOpenCursorsEnv = "CORALACCESS_ENABLEOPENCURSORS";
  static int enableOpenCursors = -1;
  if ( enableOpenCursors == -1 ) enableOpenCursors = ( getenv ( enableOpenCursorsEnv.c_str() ) ? 1 : 0 );

  if ( rowCacheSize == 0 && memoryCacheSize == 0 )
  {
    logger << "Cursor with unlimited cache size (in rows and MB): call fetchAllRows" << endlog;
    m_rows = facade().fetchAllRows( m_sessionProperties.sessionID(),
                                    queryDef,
                                    outputTypes );
  }
  else if ( m_sessionProperties.fromProxy() )
  {
    logger << "Cursor with limited cache size (in rows and/or MB), but fromProxy=true: call fetchAllRows" << endlog;
    m_rows = facade().fetchAllRows( m_sessionProperties.sessionID(),
                                    queryDef,
                                    outputTypes );
  }
  else if ( enableOpenCursors == 0 )
  {
    logger << "Cursor with limited cache size (in rows and/or MB) and fromProxy=false, but " << enableOpenCursorsEnv << " is not set: call fetchAllRows" << endlog;
    m_rows = facade().fetchAllRows( m_sessionProperties.sessionID(),
                                    queryDef,
                                    outputTypes );
  }
  else
  {
    logger << "Cursor with limited cache size (in rows and/or MB) and fromProxy=false and " << enableOpenCursorsEnv << " is set: call fetchRows" << endlog;
    m_rows = facade().fetchRows( m_sessionProperties.sessionID(),
                                 queryDef,
                                 outputTypes,
                                 rowCacheSize,
                                 memoryCacheSize );
  }
}

//-----------------------------------------------------------------------------

Cursor::~Cursor()
{
  logger << "Delete Cursor" << endlog;
  close();
}

//-----------------------------------------------------------------------------

bool Cursor::next()
{
  SCOPED_TIMER( "CoralAccess::Cursor::next" );
  if ( !m_rows.get() )
    throw Exception( "The cursor is already closed",
                     "Cursor::next",
                     "coral::CoralAccess" );
  return m_rows->nextRow();
}

//-----------------------------------------------------------------------------

const coral::AttributeList& Cursor::currentRow() const
{
  if ( !m_rows.get() )
    throw Exception( "The cursor is already closed",
                     "Cursor::currentRow",
                     "coral::CoralAccess" );
  //logger << "Cursor::currentRow: " << attributeListToString( m_rows->currentRow() ) << endlog;
  return m_rows->currentRow();
}

//-----------------------------------------------------------------------------

void Cursor::close()
{
  m_rows.reset(0);
}

//-----------------------------------------------------------------------------

const coral::ICoralFacade& Cursor::facade() const
{
  return m_sessionProperties.connectionProperties().facade();
}

//-----------------------------------------------------------------------------
