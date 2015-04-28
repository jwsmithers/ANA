
// Include files
#include <cstdlib>
#include <iostream>
#include "RelationalAccess/IConnectionServiceConfiguration.h"
#include "RelationalAccess/IRelationalDomain.h"
#include "RelationalAccess/IRelationalService.h"
#include "RelationalAccess/ITransaction.h"

// Local include files
#include "RalSessionMgr.h"
#include "RelationalException.h"
#include "TimingReportMgr.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

/// \todo FIX-ME: I do not like this, but it looks like it is the only way
/// of using SQLite if you do not have the appropriate lines in the
/// authentication.xml file.
std::string cool::RalConnectionString( const RelationalDatabaseId& dbId )
{
  std::string connectString = dbId.middleTier();
  if ( dbId.alias().empty() )
  {
    if ( dbId.technology() == "sqlite" )
      connectString +=
        "sqlite_file:" + dbId.schema();
    else
      connectString +=
        dbId.technology() + "://" + dbId.server() + "/" + dbId.schema();
  }
  else
    connectString += dbId.alias();
  return connectString;
}

//-----------------------------------------------------------------------------

RalSessionMgr::RalSessionMgr( CoralConnectionServiceProxyPtr ppConnSvc,
                              const DatabaseId& dbId,
                              bool readOnly )
  : m_ppConnSvc( ppConnSvc )
  , m_relationalDbId( dbId )
  , m_log( new coral::MessageStream( "RalSessionMgr" ) )
  , m_session( 0 )
{
  std::string ro;
  if ( !readOnly )
  {
    m_sessionMode = Update;
    ro = "R/W";
  }
  else if ( getenv( "COOL_READONLYSESSION_MANYTRANSACTIONS" ) )
  {
    m_sessionMode = ReadOnlyManyTx;
    ro = "R/O (many tx)";
  }
  else
  {
    m_sessionMode = ReadOnly;
    ro = "R/O";
  }
  log() << coral::Info << "Instantiate a " << ro << " RalSessionMgr for '"
        << m_relationalDbId.urlHidePswd() << "'"
        << coral::MessageStream::endmsg;
  // Create the appropriate RAL session and connect to the database server
  connect();
}

//-----------------------------------------------------------------------------

RalSessionMgr::~RalSessionMgr()
{
  log() << coral::Info << "Delete the RalSessionMgr for '"
        << m_relationalDbId.urlHidePswd() << "'"
        << coral::MessageStream::endmsg;
  // Disconnect from the database server and delete the RAL session
  disconnect();
}

//-----------------------------------------------------------------------------

const std::string RalSessionMgr::databaseTechnology() const
{
#ifdef NOCORAL210
  return m_session->properties().flavorName();
#else
  return m_session->remoteProperties().flavorName();
#endif
}

//-----------------------------------------------------------------------------

const std::string RalSessionMgr::serverVersion() const
{
#ifdef NOCORAL210
  return m_session->properties().serverVersion();
#else
  return m_session->remoteProperties().serverVersion();
#endif
}

//-----------------------------------------------------------------------------

bool RalSessionMgr::isConnected() const
{
  return ( m_session != 0 );
}

//-----------------------------------------------------------------------------

coral::IConnectionService& RalSessionMgr::connectionSvc() const
{
  // Disable CORAL connection pool automatic cleanup if requested
  // Disable CORAL connection sharing if requested
  static bool first = true;
  if ( first )
  {
    first = false;
    if ( getenv( "COOL_DISABLE_CORALCONNECTIONPOOLCLEANUP" ) )
    {
      log() << coral::Warning << "Use COOL_DISABLE_CORALCONNECTIONPOOLCLEANUP"
            << coral::MessageStream::endmsg; // Use log, not cout (bug #75501)
      m_ppConnSvc->configuration().disablePoolAutomaticCleanUp();
      m_ppConnSvc->configuration().setConnectionTimeOut( 0 );
    }
    if ( getenv( "COOL_DISABLE_CORALCONNECTIONSHARING" ) )
    {
      log() << coral::Warning << "Use COOL_DISABLE_CORALCONNECTIONSHARING"
            << coral::MessageStream::endmsg; // Use log, not cout (bug #75501)
      m_ppConnSvc->configuration().disableConnectionSharing();
    }
  }
  // Return the CORAL connection service PROXY!
  return *m_ppConnSvc;
}

//-----------------------------------------------------------------------------

inline static int SetEnv( const std::string& name, const std::string& value )
{
#ifndef WIN32
  // UNIX version
  return value.empty() ?
    ::unsetenv(name.c_str()) , 0 :
    ::setenv(name.c_str(),value.c_str(), 1);
#else
  // Windows version
  return ::_putenv((name+"="+value).c_str());
#endif
}

//-----------------------------------------------------------------------------

void RalSessionMgr::connect()
{
  if ( ! isConnected() )
  {
    if ( TimingReport::enabled() )
    {
      TimingReportMgr::initialize();
      TimingReportMgr::startTimer( "EXTRA cool::RalSessionMgr::connect()" );
    }

    log() << coral::Info
          << "Connect to the database server" << coral::MessageStream::endmsg;

    bool environmentAuthenticationUsed = false;
    std::auto_ptr<std::string> old_env_content[2];

    std::string ralConnectString = RalConnectionString( m_relationalDbId );
    // To pass user and password to CORAL ConnectionService we can only
    // use the environment
    if ( m_relationalDbId.technology() != "sqlite" &&
         m_relationalDbId.password() != "" && m_relationalDbId.user() != "" )
    {
      log() << "explicit credentials in the connection string: I use them"
            << coral::MessageStream::endmsg;
      log() << coral::Warning
            << "You are using explicit credentials in the connection string"
            << ": this is deprecated"
            << ", please use either XML or LFC based authentication"
            << coral::MessageStream::endmsg;

      // If the user specified _BOTH_ user name and password, we can use the
      // environment variables to pass those values to CORAL
      environmentAuthenticationUsed = true; // need to revert to old values

      // Keep a copy of the old env values
      char *tmp = ::getenv("CORAL_AUTH_USER");
      if (tmp)
        old_env_content[0] =
          std::auto_ptr<std::string>( new std::string(tmp) );
      tmp = ::getenv("CORAL_AUTH_PASSWORD");
      if (tmp)
        old_env_content[1] =
          std::auto_ptr<std::string>( new std::string(tmp) );

      // Put new values in the environment variables
      if ( SetEnv("CORAL_AUTH_USER", m_relationalDbId.user()) < 0 ||
           SetEnv("CORAL_AUTH_PASSWORD",m_relationalDbId.password()) < 0 )
      {
        // something went wrong with the environment :-(
        // revert to old values and forget
        log() << coral::Warning <<
          "Problems when trying to set authentication env. variables, ignoring"
          " specified credentials." << coral::MessageStream::endmsg;
        if ( old_env_content[0].get() )
        {
          SetEnv("CORAL_AUTH_USER", *(old_env_content[0]));
        }
        else
        {
          SetEnv("CORAL_AUTH_USER", "");
        }
        if ( old_env_content[1].get() )
        {
          SetEnv("CORAL_AUTH_PASSWORD", *(old_env_content[1]));
        }
        else
        {
          SetEnv("CORAL_AUTH_PASSWORD", "");
        }
        environmentAuthenticationUsed = false;
      }
    }

    // Set the CORAL/Services/EnvironmentAuthenticationService
    if ( environmentAuthenticationUsed )
    {
      connectionSvc().configuration().
        setAuthenticationService
        ( "CORAL/Services/EnvironmentAuthenticationService" );
    }

    // Get the session proxy
    coral::AccessMode accessMode;
    if ( isReadOnly() ) accessMode = coral::ReadOnly;
    else accessMode = coral::Update;
    if ( m_relationalDbId.role().empty() )
    {
      m_session = connectionSvc().connect( ralConnectString,
                                           accessMode );
    }
    else
    {
      m_session = connectionSvc().connect( ralConnectString,
                                           m_relationalDbId.role(),
                                           accessMode );
    }

    // Clean up environment variables
    if ( environmentAuthenticationUsed )
    {
      // revert to old values
      if ( old_env_content[0].get() )
      {
        SetEnv( "CORAL_AUTH_USER", *( old_env_content[0] ) );
      }
      else
      {
        SetEnv( "CORAL_AUTH_USER", "" );
      }
      if ( old_env_content[1].get() )
      {
        SetEnv( "CORAL_AUTH_PASSWORD", *(old_env_content[1]) );
      }
      else
      {
        SetEnv( "CORAL_AUTH_PASSWORD", "" );
      }
    }

    // Was a connection established successfully?
    if ( !m_session )
    {
      throw RelationalException( "Failed to connect to the server",
                                 "RalSessionMgr::connect" );
    }
    log() << "Connection established successfully"
          << coral::MessageStream::endmsg;

    // In ReadOnly mode start a single transaction for the duration of
    // the session (all other clients use a dummy transaction manager).
    //if ( m_sessionMode==ReadOnly || m_sessionMode==ReadOnlyManyTx )
    if ( m_sessionMode == ReadOnly ) // NB: m_sessionMode != ReadOnlyManyTx
    {
      log() << coral::Info
            << "Start a read-only transaction active"
            << " for the duration of the database connection"
            << coral::MessageStream::endmsg;
      session().transaction().start( true ); // R/O transaction
    }

    if ( TimingReportMgr::isActive() )
    {
      TimingReportMgr::stopTimer( "EXTRA cool::RalSessionMgr::connect()" );
      TimingReportMgr::finalize();
    }

  }
}

//-----------------------------------------------------------------------------

void RalSessionMgr::disconnect()
{
  if ( TimingReport::enabled() )
  {
    TimingReportMgr::initialize();
    TimingReportMgr::startTimer( "EXTRA cool::RalSessionMgr::disconnect()" );
  }

  if ( isConnected() )
  {

    // In Update mode there should be no active transactions unless the
    // session manager is being killed as a result of an exception thrown.
    // Check if there is an open transaction, and in that case rollback
    // (do not rollback all the time, else CORAL will issue a warning!).
    if ( m_sessionMode == Update )
    {
      if ( session().transaction().isActive() )
      {
        log() << coral::Warning
              << "Active transactions found while disconnecting"
              << " from an Update session will be rolled back"
              << coral::MessageStream::endmsg;
        session().transaction().rollback();
      }
    }
    // In ReadOnlyManyTx mode there should be no active transactions unless
    // the session manager is being killed as a result of an exception thrown.
    // Check if there is an open transaction, and in that case rollback
    // (do not rollback all the time, else CORAL will issue a warning!).
    else if ( m_sessionMode == ReadOnlyManyTx ) // fix bug #90949
    {
      if ( session().transaction().isActive() )
      {
        log() << coral::Warning
              << "Active transactions found while disconnecting from a"
              << " ReadOnly (many transactions) session will be rolled back"
              << coral::MessageStream::endmsg;
        session().transaction().rollback();
      }
    }
    // In ReadOnly mode there should be one active transaction.
    else
    {
      if ( session().transaction().isActive() )
      {
        log() << coral::Info
              << "Commit the read-only transaction active"
              << " for the duration of the database connection"
              << coral::MessageStream::endmsg;
        session().transaction().commit();
      }
      else
      {
        log() << coral::Warning
              << "PANIC! No active transactions found while disconnecting"
              << " from a ReadOnly (single transaction) session"
              << coral::MessageStream::endmsg;
      }
    }

    // Disconnect from the database server
    log() << coral::Info
          << "Disconnect from the database server"
          << coral::MessageStream::endmsg;
    delete m_session;
    m_session = 0;

  }

  // TEMPORARY? Should/will be done by CORAL inside ~ISessionProxy?
  // Purge the CORAL connection pool (see task #3546) to ensure
  // that the connection is physically dropped if the timeout is 0
  try { m_ppConnSvc->purgeConnectionPool(); } catch( ... ) { }

  if ( TimingReportMgr::isActive() )
  {
    TimingReportMgr::stopTimer( "EXTRA cool::RalSessionMgr::disconnect()" );
    TimingReportMgr::finalize();
  }

}

//-----------------------------------------------------------------------------

coral::MessageStream& RalSessionMgr::log() const
{
  *m_log << coral::Verbose;
  return *m_log;
}

//-----------------------------------------------------------------------------

coral::ISessionProxy& RalSessionMgr::session() const
{
  if ( isConnected() )
    return *m_session;
  else
    throw RelationalException
      ( "Not connected to the database server", "RalSessionMgr" );
}

//-----------------------------------------------------------------------------
