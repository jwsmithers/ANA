
// Include files
#include "CoralServerBase/InternalErrorException.h"
#include "RelationalAccess/ICursor.h"
#include "RelationalAccess/IQuery.h"

// Local include files
#include "CursorIterator.h"
#include "monitoring.h"

// Logger
//#define LOGGER_NAME "CoralServer::CursorIterator"
//#include "logger.h"

// Namespace
using namespace coral::CoralServer;

//-----------------------------------------------------------------------------

CursorIterator::CursorIterator( IQuery* query )
  : m_pQuery( query )
  , m_cursor( query->execute() )
{
}

//-----------------------------------------------------------------------------

CursorIterator::~CursorIterator()
{
  if ( m_pQuery )
  {
    m_cursor.close();
    delete m_pQuery;
    m_pQuery = 0;
  }
}

//-----------------------------------------------------------------------------

bool CursorIterator::nextRow()
{
  SCOPED_TIMER( "ServerFacade::CursorIterator::nextRow" );
  if ( !m_pQuery ) return false;
  bool hasNext = m_cursor.next();
  if ( !hasNext )
  {
    m_cursor.close();
    delete m_pQuery;
    m_pQuery = 0;
  }
  return hasNext;
}

//-----------------------------------------------------------------------------

bool CursorIterator::isLast() const
{
  throw InternalErrorException( "PANIC! CursorIterator::isLast() is not implemented and should never be called!",
                                "CursorIterator::isLast()",
                                "coral::CoralServer" );
}

//-----------------------------------------------------------------------------

const coral::AttributeList& CursorIterator::currentRow() const
{
  if ( !m_pQuery )
    throw Exception( "Iterator is already past the end",
                     "CursorIterator::currentRow",
                     "coral::CoralServer" );
  return m_cursor.currentRow();
}

//-----------------------------------------------------------------------------
