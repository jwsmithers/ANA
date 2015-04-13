// $Id: RalDatabaseSvc.cpp,v 1.59 2011-09-23 17:44:27 avalassi Exp $

// Include files
#include <iostream>

// Local include files
#include "RalDatabase.h"
#include "RalDatabaseSvc.h"
#include "RelationalException.h"
//#include "TimingReportMgr.h"
#include "TransRalDatabase.h"
#include "VersionInfo.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

RalDatabaseSvc::RalDatabaseSvc
( coral::IConnectionService& connSvc )
  : m_log( new coral::MessageStream( "RalDatabaseSvc" ) )
  , m_ppConnSvc( new CoralConnectionServiceProxy( &connSvc ) )
{
  initialize();
}

//-----------------------------------------------------------------------------

void RalDatabaseSvc::initialize()
{
  log() << coral::Info << "Instantiate the RalDatabaseSvc"
        << coral::MessageStream::endmsg;

  // Initialize timing reports
  //std::cout << "Initialize timing reports" << std::endl;
  //TimingReportMgr::initialize();
  //TimingReportMgr::startTimer( "TOTAL - RalDatabaseSvc" );
}

//-----------------------------------------------------------------------------

RalDatabaseSvc::~RalDatabaseSvc()
{
  log() << coral::Info << "Delete the RalDatabaseSvc..."
        << coral::MessageStream::endmsg;

  // Finalize timing reports
  // WARNING: RalDatabaseSvc is generally not deleted (eg in PyCool)...
  //std::cout << "Finalize timing reports" << std::endl;
  //TimingReportMgr::stopTimer( "TOTAL - RalDatabaseSvc" );
  //TimingReportMgr::finalize();

  log() << coral::Info << "Purge the connection pool"
        << coral::MessageStream::endmsg;
  m_ppConnSvc->purgeConnectionPool();
  log() << coral::Info << "Reset the ICS pointer"
        << coral::MessageStream::endmsg;
  m_ppConnSvc->resetICS();

  log() << coral::Info << "Delete the RalDatabaseSvc... DONE"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

coral::MessageStream& RalDatabaseSvc::log() const
{
  *m_log << coral::Verbose;
  return *m_log;
}

//-----------------------------------------------------------------------------

IDatabasePtr
RalDatabaseSvc::createDatabase( const DatabaseId& dbId ) const
{
  log() << coral::Verbose << "Create database"
        << coral::MessageStream::endmsg;
  RalDatabase* ralDb = 0;
  try {
    bool readOnly = false;
    ralDb = new RalDatabase( m_ppConnSvc, dbId, readOnly );
    IDatabasePtr db ( ralDb, RalDatabase::deleter() );
    // wrap database in a transaction aware wrapper
    TransRalDatabase *transRalDb=new TransRalDatabase( db );
    db = IDatabasePtr( transRalDb );
    transRalDb->createDatabase();
    log() << coral::Verbose << "Create database - success"
          << coral::MessageStream::endmsg;
    return db;
  } catch ( ... ) {
    //if (ralDb) delete ralDb; // this was removed in task #3271: ok or notok?
    log() << coral::Verbose << "Create database - failure"
          << coral::MessageStream::endmsg;
    throw;
  }
}

//-----------------------------------------------------------------------------

/*
IDatabasePtr
RalDatabaseSvc::createDatabase( const DatabaseId& dbId,
                                const coral::AttributeList& dbAttr ) const
{
  RalDatabase* ralDb = new RalDatabase( localContext(), dbId );
  ralDb->createDatabase( dbAttr );
  IDatabasePtr db ( ralDb );
  return db;
}
*///

//-----------------------------------------------------------------------------

IDatabasePtr RalDatabaseSvc::openDatabase( const DatabaseId& dbId,
                                           bool readOnly ) const
{
  log() << coral::Verbose << "Open database"
        << coral::MessageStream::endmsg;
  RalDatabase* ralDb = 0;
  try {
    ralDb = new RalDatabase( m_ppConnSvc, dbId, readOnly );
    IDatabasePtr db ( ralDb, RalDatabase::deleter() );
    // wrap database in a transaction aware wrapper
    db = IDatabasePtr( new TransRalDatabase( db ) );
    db->openDatabase();
    log() << coral::Verbose << "Open database - success"
          << coral::MessageStream::endmsg;
    return db;
  } catch ( ... ) {
    //if (ralDb) delete ralDb; // this was removed in task #3271: ok or notok?
    log() << coral::Verbose << "Open database - failure"
          << coral::MessageStream::endmsg;
    throw;
  }
}

//-----------------------------------------------------------------------------

bool RalDatabaseSvc::dropDatabase( const DatabaseId& dbId ) const
{
  log() << coral::Verbose << "Drop database"
        << coral::MessageStream::endmsg;
  try {
    bool readOnly = false;
    RalDatabase *ralDb = new RalDatabase( m_ppConnSvc, dbId, readOnly );
    IDatabasePtr db( ralDb, RalDatabase::deleter() );
    // wrap database in a transaction aware wrapper
    TransRalDatabase *transRalDb = new TransRalDatabase( db );
    db = IDatabasePtr( transRalDb );
    // Open the database (also check if the database exists)
    try {
      transRalDb->openDatabase();
    } catch ( DatabaseDoesNotExist& /* dummy */ ) {
      log() << coral::Verbose << "Drop database - success (database not found)"
            << coral::MessageStream::endmsg;
      return false;
    }
    // The database exists: drop it
    bool status = transRalDb->dropDatabase();
    log() << coral::Verbose << "Drop database - success"
          << coral::MessageStream::endmsg;
    return status;
  }
  // Throw an exception if the database exists but cannot be dropped
  catch ( ... ) {
    log() << coral::Verbose << "Drop database - failure"
          << coral::MessageStream::endmsg;
    throw;
  }
}

//-----------------------------------------------------------------------------

void RalDatabaseSvc::refreshDatabase( const DatabaseId& dbId,
                                      bool keepNodes ) const
{
  log() << coral::Verbose << "Refresh database"
        << coral::MessageStream::endmsg;
  try {
    bool readOnly = false;
    RalDatabase *ralDb = new RalDatabase( m_ppConnSvc, dbId, readOnly );
    IDatabasePtr db( ralDb, RalDatabase::deleter() );
    // wrap database in a transaction aware wrapper
    TransRalDatabase *transRalDb = new TransRalDatabase( db );
    db = IDatabasePtr( transRalDb );
    // Open the database (also check if the database exists)
    try {
      db->openDatabase();
    } catch ( DatabaseDoesNotExist& /* dummy */ ) {
      log() << coral::Verbose
            << "Refresh database - failure (database not found)"
            << coral::MessageStream::endmsg;
      throw;
    }
    // The database exists: refresh it
    transRalDb->refreshDatabase( keepNodes );
    log() << coral::Verbose << "Refresh database - success"
          << coral::MessageStream::endmsg;
  }
  // Throw an exception if the database exists but cannot be refreshed
  catch ( ... ) {
    log() << coral::Verbose << "Refresh database - failure"
          << coral::MessageStream::endmsg;
    throw;
  }
}

//-----------------------------------------------------------------------------

const std::string RalDatabaseSvc::serviceVersion() const
{
  return VersionInfo::release;
}

//-----------------------------------------------------------------------------

coral::IConnectionService& RalDatabaseSvc::connectionSvc() const
{
  // Return the CORAL connection service PROXY!
  return *m_ppConnSvc;
}

//-----------------------------------------------------------------------------
