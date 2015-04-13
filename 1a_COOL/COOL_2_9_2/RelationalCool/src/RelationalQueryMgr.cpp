// $Id: RelationalQueryMgr.cpp,v 1.30 2010-03-29 21:47:53 avalassi Exp $

// Local include files
#include "RelationalException.h"
#include "RelationalQueryMgr.h"
#include "RelationalTableRow.h"
#include "timeToString.h"

// Namespace
using namespace cool;

//---------------------------------------------------------------------------

RelationalQueryMgr::RelationalQueryMgr(  )
  : m_log( new coral::MessageStream( "RelationalQueryMgr" ) )
{
  log() << coral::Debug
        << "Instantiate a RelationalQueryMgr" << coral::MessageStream::endmsg;
}

//---------------------------------------------------------------------------

RelationalQueryMgr::~RelationalQueryMgr()
{
  log() << coral::Debug
        << "Delete the RelationalQueryMgr" << coral::MessageStream::endmsg;
}

//---------------------------------------------------------------------------

const std::string
RelationalQueryMgr::serverTimeClause( const std::string& technology )
{
  std::string clause;
  if ( technology == "MySQL" )
  {
    // TEMPORARY! Store MySQL now() __ AS IS __ ASSUMING IT IS GMT!
    // MySQL does not handle timezones until 4.1.3
    clause = "DATE_FORMAT(now(),'%Y-%m-%d_%H:%i:%s.000000000 GMT')";
  }
  else if ( technology == "Oracle" || technology == "frontier" )
  {
    // Store Oracle SYSTIMESTAMP converted to GMT
    clause = "TO_CHAR(SYSTIMESTAMP AT TIME ZONE 'GMT',";
    clause += "'yyyy-mm-dd_hh24:mi:ss.ff6')||'000 GMT'";
  }
  else if ( technology == "SQLite" )
  {
    // Use GMT time from C++ client with SQLite (there is no server)
    // TEMPORARY! Use seal::Time (CURRENT_TIMESTAMP only in SQLite 3.1.0)
    // TODO: Use SQLite's CURRENT_TIMESTAMP.
    clause = "'";
    clause += timeToString( cool::Time() );
    clause += "'";
  }
  else
  {
    throw RelationalException
      ( std::string( "Unknown technology " ) + technology, "RalQueryMgr" );
  }
  return clause;
}

//---------------------------------------------------------------------------
