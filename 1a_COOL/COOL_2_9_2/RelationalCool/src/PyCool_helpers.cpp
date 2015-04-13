// $Id: PyCool_helpers.cpp,v 1.10 2011-04-09 21:06:26 avalassi Exp $

// Include files
//#include <iostream>

// Local include files
#include "PyCool_helpers.h"
#include "TransRalDatabase.h"
#include "RalDatabaseSvc.h"
#include "RelationalException.h"

//-----------------------------------------------------------------------------

void
cool::PyCool::Helpers::refreshDatabaseFromDbSvc( cool::IDatabaseSvc* dbSvc,
                                                 const DatabaseId& dbId,
                                                 bool keepNodes )
{
  //std::cout << "PyCool::Helpers::refreshDatabaseFromDbSvc" << std::endl;
  if ( !dbSvc )
    throw RelationalException
      ( "Null IDatabaseSvc* in PyCool::Helpers::refreshDatabaseFromDbSvc" );
  RalDatabaseSvc* rdbSvc = dynamic_cast<RalDatabaseSvc*>( dbSvc );
  if ( !rdbSvc )
    throw RelationalException
      ( "Cannot cast to RalDatabaseSvc* "
        "in PyCool::Helpers::refreshDatabaseFromDbSvc" );
  rdbSvc->refreshDatabase( dbId, keepNodes );
}

//-----------------------------------------------------------------------------

void
cool::PyCool::Helpers::refreshDatabaseFromDb( cool::IDatabase* db,
                                              bool keepNodes )
{
  //std::cout << "PyCool::Helpers::refreshDatabaseFromDb" << std::endl;
  if ( !db )
    throw RelationalException
      ( "Null IDatabase* in PyCool::Helpers::refreshDatabaseFromDb" );
  TransRalDatabase* rdb = dynamic_cast<TransRalDatabase*>( db );
  if ( !rdb )
    throw RelationalException
      ( "Cannot cast to TransRalDatabase* "
        "in PyCool::Helpers::refreshDatabaseFromDb" );
  rdb->refreshDatabase( keepNodes );
}

//-----------------------------------------------------------------------------
