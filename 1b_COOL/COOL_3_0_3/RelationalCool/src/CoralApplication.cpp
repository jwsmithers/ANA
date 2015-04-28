
// Include files
#include <iostream>
#include "CoolKernel/Exception.h"
#include "CoolKernel/IDatabaseSvc.h"
//#include "SealBase/Signal.h"
//#include "SealBase/ProcessInfo.h"
#include "RelationalAccess/ConnectionService.h"

// Local include files
#include "CoralApplication.h"
#include "RalDatabaseSvc.h"
#ifndef __APPLE__
#ifndef WIN32
#include "sigsegv.h"
#endif
#endif

// Message output
#define COUT std::cout << "__cool::CoralApplication "
#define ENDL std::endl

// Workaround for Windows (win32_vc9_dbg)
// ERROR seems to be defined in a Windows VC9 header
// See also CoolKernel/CoolKernel/MessageLevels.h
// See also RelationalCool/utilities/coolPrivileges/RalPrivilegeManager.cpp
#ifdef WIN32
#ifdef ERROR
#undef ERROR
#pragma message ("WARN!NG: in RelationalCool/src/CoralApplication.cpp")
#pragma message ("WARN!NG: 'ERROR' was defined and has been undefined")
#endif
#endif

//-----------------------------------------------------------------------------

namespace cool
{
  class MessageReporter : virtual public coral::IMsgReporter
  {

  public:

    /// Default constructor
    MessageReporter( coral::MsgLevel dummyLvl = coral::Info ) :
      m_level( dummyLvl ) {} // dummy as it will be changed by setMsgVerbosity

    /// Destructor (called only by sub-classes)
    virtual ~MessageReporter() {}

    /// Release reference to reporter
    void release()
    {
      delete this; // only one instance...
    }

    /// Access output level
    coral::MsgLevel outputLevel() const { return m_level; }

    /// Modify output level
    void setOutputLevel( coral::MsgLevel lvl ) { m_level = lvl; }

    /// Report a message
    void report( int level, const std::string& src, const std::string& msg )
    {
      if ( level >= m_level )
      {
        std::ostream& out = std::cout;
        const std::string::size_type src_name_maxsize = 36;
        if ( src.size() <= src_name_maxsize )
        {
          out << src << std::string( src_name_maxsize-src.size(), ' ' );
        }
        else
        {
          out << src.substr( 0, src_name_maxsize-3 ) << "...";
        }
        switch ( level )
        {
        case 0:  out << " Nil      "; break;
        case 1:  out << " Verbose  "; break;
        case 2:  out << " Debug    "; break;
        case 3:  out << " Info     "; break;
        case 4:  out << " Warning  "; break;
        case 5:  out << " Error    "; break;
        case 6:  out << " Fatal    "; break;
        case 7:  out << " Always   "; break;
        default: out << " Unknown  "; break;
        }
        out << msg << std::endl;
      }
    }

  private:

    coral::MsgLevel m_level; //< threshold for the messages

  };
}

//-----------------------------------------------------------------------------

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

CoralApplication::CoralApplication( coral::IConnectionService* connSvc )
{

  //COUT << "CoralApplication(): ** START **" << ENDL;

  try
  {

    //--------------------------------------------
    // 1. Create a message stream
    //--------------------------------------------

    // Install the COOL implementation of the message reporter
    if ( getenv( "COOL_ENABLE_COOLMSGREPORTER" ) )
    {
      coral::MessageStream::installMsgReporter( new cool::MessageReporter() );
    }

    // Set the verbosity for COOL and CORAL if COOL_MSGLEVEL is set
    if ( getenv( "COOL_MSGLEVEL" ) )
    {
      // Use MSG::ERROR if COOL_MSGLEVEL is set to an invalid value
      cool::MSG::Level level = cool::MSG::ERROR;

      // Check only the first char of the environment variable
      switch ( *getenv( "COOL_MSGLEVEL" ) )
      {
      case '0':
      case 'n':
      case 'N': level = cool::MSG::NIL; break;

      case '1':
      case 'v':
      case 'V': level = cool::MSG::VERBOSE; break;

      case '2':
      case 'd':
      case 'D': level = cool::MSG::DEBUG; break;

      case '3':
      case 'i':
      case 'I': level = cool::MSG::INFO; break;

      case '4':
      case 'w':
      case 'W': level = cool::MSG::WARNING; break;

      case '5':
      case 'e':
      case 'E': level = cool::MSG::ERROR; break;

      case '6':
      case 'f':
      case 'F': level = cool::MSG::FATAL; break;

      case '7':
      case 'a':
      case 'A': level = cool::MSG::ALWAYS; break;

      default: break; // keep cool::MSG::ERROR by default
      }

      setOutputLevel( level );
    }
    else
    {
      // Do not modify the verbosity if COOL_MSGLEVEL is not set (bug #40353)
    }

    // Create a message stream
    m_log.reset( new coral::MessageStream( "CoralApplication" ) );
    log() << coral::Info << "Create a cool::CoralApplication..."
          << coral::MessageStream::endmsg;

    //--------------------------------------------
    // 2. Install the COOL signal handler
    //--------------------------------------------

#ifndef WIN32
    // Install the COOL signal handler
    if ( getenv( "COOL_ENABLE_COOLSIGNALHANDLER" ) )
    {
      log() << coral::Info << "Enable the COOL signal handler"
            << coral::MessageStream::endmsg;
#ifndef __APPLE__
      setup_sigsegv();
#endif
      //seal::Signal::handleFatal ( seal::ProcessInfo::argv()[0] );
      //COUT << "CoralApplication(): SignalHandler ok" << ENDL;
    }
#endif

    //--------------------------------------------
    // 3. Create the CORAL connection service
    //--------------------------------------------

    if ( connSvc )
    {
      log() << coral::Info << "Use the user-provided CORAL connection service"
            << coral::MessageStream::endmsg;
      m_connSvc = connSvc;
      m_ownConnSvc = false;
    }
    else
    {
      log() << coral::Info << "Create a new own CORAL connection service"
            << coral::MessageStream::endmsg;
      m_connSvc = new coral::ConnectionService();
      m_ownConnSvc = true;
    }

    //--------------------------------------------
    // 4. Create the COOL database service
    //--------------------------------------------

    log() << coral::Info << "Create the COOL database service"
          << coral::MessageStream::endmsg;
    m_dbSvc = new RalDatabaseSvc( *m_connSvc );

    //--------------------------------------------

    log() << coral::Info << "Create a cool::CoralApplication... DONE"
          << coral::MessageStream::endmsg;

  }

  catch( std::exception& e )
  {
    COUT << "ERROR! Standard exception: '" << e.what() << "'" << ENDL;
    throw e;
  }

  catch( ... )
  {
    COUT << "ERROR! Unknown exception caught" << ENDL;
    throw;
  }

  //COUT << "CoralApplication(): *** END ***" << ENDL;

}

//-----------------------------------------------------------------------------

CoralApplication::~CoralApplication()
{
  log() << coral::Info << "Delete the COOL CoralApplication..."
        << coral::MessageStream::endmsg;
  log() << coral::Info << "Delete the COOL database service"
        << coral::MessageStream::endmsg;
  delete m_dbSvc;
  m_dbSvc = 0;
  //log() << coral::Info << "Purge the CORAL connection pool"
  //      << coral::MessageStream::endmsg;
  //m_connSvc->purgeConnectionPool();
  if ( m_ownConnSvc )
  {
    log() << coral::Info << "Delete the CORAL connection service"
          << coral::MessageStream::endmsg;
    coral::ConnectionService* connSvc =
      dynamic_cast< coral::ConnectionService* >( m_connSvc );
    if ( connSvc )
    {
      // Hack: ~IConnectionService is protected
      delete connSvc;
    }
    else
    {
      // This can never happen! We know the type of the own m_connSvc!
      std::string msg = "PANIC! m_connSvc is not a coral::ConnectionService!";
      log() << coral::Fatal << msg << coral::MessageStream::endmsg;
      throw Exception( msg, "CoralApplication::~CoralApplication" );
    }
  }
  m_connSvc = 0;
  log() << coral::Info << "Delete the COOL CoralApplication... DONE"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

IDatabaseSvc& CoralApplication::databaseService()
{
  return *m_dbSvc;
}

//-----------------------------------------------------------------------------

cool::MSG::Level CoralApplication::outputLevel()
{
  coral::MsgLevel coralLevel = coral::MessageStream::msgVerbosity();
  switch ( coralLevel ) {
  case coral::Nil:       return cool::MSG::NIL;        break;
  case coral::Fatal:     return cool::MSG::FATAL;      break;
  case coral::Error:     return cool::MSG::ERROR;      break;
  case coral::Warning:   return cool::MSG::WARNING;    break;
  case coral::Info:      return cool::MSG::INFO;       break;
  case coral::Debug:     return cool::MSG::DEBUG;      break;
  case coral::Verbose:   return cool::MSG::VERBOSE;    break;
  case coral::Always:    return cool::MSG::ALWAYS;     break;
  case coral::NumLevels: return cool::MSG::NUM_LEVELS; break;
  }
  throw Exception( "PANIC! Unknown CORAL MsgLevel value", "CoralApplication" );
}

//-----------------------------------------------------------------------------

void CoralApplication::setOutputLevel( const cool::MSG::Level level )
{
  coral::MsgLevel coralLevel;
  switch ( level ) {
  case cool::MSG::NIL:        coralLevel=coral::Nil;       break;
  case cool::MSG::FATAL:      coralLevel=coral::Fatal;     break;
  case cool::MSG::ERROR:      coralLevel=coral::Error;     break;
  case cool::MSG::WARNING:    coralLevel=coral::Warning;   break;
  case cool::MSG::INFO:       coralLevel=coral::Info;      break;
  case cool::MSG::DEBUG:      coralLevel=coral::Debug;     break;
  case cool::MSG::VERBOSE:    coralLevel=coral::Verbose;   break;
  case cool::MSG::ALWAYS:     coralLevel=coral::Always;    break;
  case cool::MSG::NUM_LEVELS: coralLevel=coral::NumLevels; break;
  default:
    throw Exception( "PANIC! Unknown cool::MSG::Level value",
                     "CoralApplication" );
  }
  coral::MessageStream::setMsgVerbosity( coralLevel );
}

//-----------------------------------------------------------------------------

seal::Context* CoralApplication::context() const
{
  std::stringstream msg;
  msg << "COOL is not based on SEAL any longer: please upgrade your user code";
  throw Exception( msg.str(), "CoralApplication" );
}

//-----------------------------------------------------------------------------

coral::IConnectionService& CoralApplication::connectionSvc() const
{
  return *m_connSvc;
}

//-----------------------------------------------------------------------------

coral::MessageStream& CoralApplication::log()
{
  *m_log << coral::Info;
  return *m_log;
}

//-----------------------------------------------------------------------------

/*
// Implementation copied from SEAL Foundation/PluginRefresh/src/main.cpp
void CoralApplication::feedback ( seal::PluginManager::FeedbackData data )
{
  std::string explanation;
  if ( data.error )
    explanation =
      seal::StringOps::replace( data.error->explain (), '\n', "\n\t" );

  if ( getenv ( "COOL_PLUGINMANAGER_DEBUG" ) ) {
    if ( data.code == seal::PluginManager::StatusLoading )
      COUT << "INFO: Loading module '" << data.scope << "'" << ENDL;
  }

  if ( data.code == seal::PluginManager::ErrorLoadFailure )
    COUT << "WARNING! Module '" << data.scope
         << "' failed to load for the following reason: \""
         << explanation << "\"" << ENDL;

  else if ( data.code == seal::PluginManager::ErrorBadModule )
    COUT << "WARNING! Module '" << data.scope
         << "' ignored until problems with it are fixed" << ENDL;

  else if ( data.code == seal::PluginManager::ErrorBadCacheFile )
    COUT << "WARNING! Cache file '" << data.scope
         << "' is corrupted" << ENDL;

  else if ( data.code == seal::PluginManager::ErrorEntryFailure )
    COUT << "WARNING! Module '" << data.scope
         << "' does not have the required entry point: \""
         << explanation << "\"" << ENDL;

  else if ( data.code == seal::PluginManager::ErrorNoFactory )
    COUT << "WARNING! Module '" << data.scope
         << "' missing one or more factories for plug-ins" << ENDL;
}
*///

//-----------------------------------------------------------------------------
