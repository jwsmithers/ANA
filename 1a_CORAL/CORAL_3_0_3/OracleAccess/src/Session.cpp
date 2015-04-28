// First of all, set/unset CORAL240, CORAL300 and CORAL_HAS_CPP11 macros
#include "CoralBase/VersionInfo.h"

#ifdef WIN32
#include <WTypes.h> // fix bug #35683, bug #73144, bug #76882, bug #79849
#endif

#include <cstring> // fix bug #58581
#include <iostream>
#include <locale>

#include "oci.h"

#include "CoralBase/../src/coral_datetime_headers.h"
#include "CoralBase/AttributeList.h"
#include "CoralKernel/Context.h"
#include "CoralKernel/Service.h"
#include "CoralCommon/MonitoringEventDescription.h"
#include "CoralCommon/Utilities.h"
#include "RelationalAccess/IMonitoringService.h"
#include "RelationalAccess/SessionException.h"

#include "ConnectionProperties.h"
#include "DomainProperties.h"
#include "MonitorController.h"
#include "OracleErrorHandler.h"
#include "Schema.h"
#include "Session.h"
#include "SessionProperties.h"
#include "Transaction.h"


coral::OracleAccess::Session::Session( coral::IDevConnection& connection,
                                       boost::shared_ptr<ConnectionProperties> connectionProperties,
                                       const std::string& _schemaName,
                                       coral::AccessMode mode )
  : coral::IDevSession( connection )
  , m_schema( 0 )
  , m_transaction( 0 )
  , m_mutex()
  , m_mutexForSchemas()
  , m_schemas()
{
#ifdef ORACLE_CONNECTION_PROPERTIES_DEBUG
  std::cout << std::endl; // Improve formatting (eg for tests)
  std::cout << "Create Session " << this << std::endl; // debug bug #98736
#endif
  // Convert the schema name to uppercase
  std::string schemaName = _schemaName;
  for ( std::string::size_type i = 0; i < schemaName.size(); ++i )
  {
    schemaName[i] = std::toupper( schemaName[i], std::locale::classic() );
  }
  m_properties.reset( new SessionProperties( connectionProperties, schemaName, *this, mode == coral::ReadOnly ) );
  m_monitorController = new MonitorController( m_properties );
  m_schema = new Schema( m_properties, m_properties->schemaName() );
  m_transaction = new Transaction( m_properties, *m_schema );
}


coral::OracleAccess::Session::~Session()
{
#ifdef ORACLE_CONNECTION_PROPERTIES_DEBUG
  std::cout << "Delete Session " << this << std::endl; // debug bug #98736
#endif
  //m_properties->nullifySession(); // move here to fix bug #80174?
  if ( this->isUserSessionActive() ) this->endUserSession();
  delete m_monitorController;
  //std::cout << "Call nullifySession" << std::endl; // debug bug #80174
  m_properties->nullifySession(); // fix bug #73834!
  //m_properties.reset(); // move lower down (see bug #98514)
  // Delete transaction & schemas if endUserSession was not called (bug #80016)
  if ( m_transaction )
  {
    m_transaction->nullifySession(); // WORKAROUND for OCI bug #80092
    //std::cout << "Delete transaction..." << std::endl; // debug bug #80092
    delete m_transaction;
    //std::cout << "Delete transaction OK" << std::endl; // debug bug #80092
  }
  coral::lock_guard lockS( m_mutexForSchemas );
  for ( std::map< std::string, Schema* >::iterator iSchema = m_schemas.begin(); iSchema != m_schemas.end(); ++iSchema )
    delete iSchema->second;
  if ( m_schema ) delete m_schema;
  //std::cout << "Deleted Session " << this << std::endl; // debug bug #80016
  m_properties.reset(); // move from higher up (see bug #98514)
}


#ifndef CORAL300MG
coral::IMonitoring&
coral::OracleAccess::Session::monitoring()
{
  return *m_monitorController;
}
#else
coral::IMonitoringController&
coral::OracleAccess::Session::monitoringController()
{
  return *m_monitorController;
}
#endif

void
coral::OracleAccess::Session::startUserSession( const std::string& userName,
                                                const std::string& password )
{
  //std::cout << "Session " << this << ": startUserSession" << std::endl; // debug bug #80174
  if ( ! this->isSessionValid() ) return;

  coral::lock_guard lock( m_mutex );
  m_userName = userName;
  m_password = password;

  // Allocate the OCI handles and begin the OCI session
  beginOciSession();

  // "Create" schema (call startUserSession instead: fix bug #80178 and #81112)
  m_schema->startUserSession();
  for ( std::map< std::string, coral::OracleAccess::Schema* >::iterator iSchema = m_schemas.begin();
        iSchema != m_schemas.end(); ++iSchema )
  {
    // There may be some schemas previously created... then, refresh them!
    if ( iSchema->second ) iSchema->second->startUserSession();
  }

  // "Create" transaction (call startUserSession instead: fix bug #80174)
  bool skipTransRO = ( ::getenv( "CORAL_ORA_SKIP_TRANS_READONLY" ) != 0 );
  {
    coral::MessageStream log( m_properties->domainServiceName() );
    if ( skipTransRO )
      log << coral::Warning << "CORAL_ORA_SKIP_TRANS_READONLY is set: this session will skip OCI serializable read-only transactions" << coral::MessageStream::endmsg;
    else
      log << coral::Info << "CORAL_ORA_SKIP_TRANS_READONLY is not set: this session will use OCI serializable read-only transactions" << coral::MessageStream::endmsg;  // Demote from Warning to Info (bug #83290)
  }
  m_transaction->startUserSession( !skipTransRO );

  // Record the beginning of the session
  if ( m_properties->monitoringService() )
  {
    m_properties->monitoringService()->record( "oracle://" + m_properties->connectionString() + "/" + m_properties->schemaName(),
                                               coral::monitor::Session,
                                               coral::monitor::Info,
                                               monitoringEventDescription.sessionBegin() );
  }
}


void
coral::OracleAccess::Session::beginOciSession()
{
  // Creating an error handler to be used in the subsequent calls.
  coral::OracleAccess::OracleErrorHandler errorHandler( m_properties->ociErrorHandle() );

  // Creating a service context handle
  void* temporaryPointer = 0;
  sword status = OCIHandleAlloc( m_properties->ociEnvHandle(),
                                 &temporaryPointer,
                                 OCI_HTYPE_SVCCTX, 0, 0 );
  if ( status != OCI_SUCCESS )
  {
    throw coral::SessionException( "Could not allocate an OCI service context handle",
                                   "ISession::connectAsUser",
                                   m_properties->domainServiceName() );
  }
  OCISvcCtx* ociSvcCtxHandle = static_cast< OCISvcCtx* >( temporaryPointer );
  //std::cout << "OCISvcCtx created " << this << std::endl; // bug #83601

  // Get the server handle
  // Update nConnectionRestarted if needed (fix bug #94114)
  OCIServer* ociServerHandle = m_properties->ociServerHandle( true, true );

  // Set the server reference in the service context
  status = OCIAttrSet( ociSvcCtxHandle, OCI_HTYPE_SVCCTX,
                       ociServerHandle, 0, OCI_ATTR_SERVER,
                       m_properties->ociErrorHandle() );
  if ( status != OCI_SUCCESS )
  {
    errorHandler.handleCase( status, "setting the server reference in the service context" );
    coral::MessageStream log( m_properties->domainServiceName() );
    if ( errorHandler.isError() )
    {
      OCIHandleFree( ociSvcCtxHandle, OCI_HTYPE_SVCCTX );
      log << coral::Error << errorHandler.message() << coral::MessageStream::endmsg;
      throw coral::SessionException( "Could not set the server to the service context",
                                     "ISession::connectAsUser",
                                     m_properties->domainServiceName() );
    }
    else
    {
      log << coral::Warning << errorHandler.message() << coral::MessageStream::endmsg;
    }
  }

  // Updating the context handle
  m_properties->setOciSvcCtxHandle( ociSvcCtxHandle );

  // Allocating the user session handle
  temporaryPointer = 0;
  status = OCIHandleAlloc( m_properties->ociEnvHandle(), &temporaryPointer,
                           OCI_HTYPE_SESSION, 0, 0 );
  if ( status != OCI_SUCCESS )
  {
    throw coral::SessionException( "Could not allocate a user session handle",
                                   "ISession::startUserSession",
                                   m_properties->domainServiceName() );
  }
  OCISession* ociSessionHandle = static_cast<OCISession*>( temporaryPointer );
  //std::cout << "OCISession created " << this << std::endl; // bug #83601

  // Set the user session reference in the service context
  status = OCIAttrSet( ociSvcCtxHandle, OCI_HTYPE_SVCCTX,
                       ociSessionHandle, 0, OCI_ATTR_SESSION,
                       m_properties->ociErrorHandle() );
  if ( status != OCI_SUCCESS )
  {
    errorHandler.handleCase( status, "setting the user session reference in the service context" );
    coral::MessageStream log( m_properties->domainServiceName() );
    if ( errorHandler.isError() )
    {
      log << coral::Error << errorHandler.message() << coral::MessageStream::endmsg;
      OCIHandleFree( ociSessionHandle, OCI_HTYPE_SESSION );
      throw coral::SessionException( "Could not allocate a user session handle",
                                     "ISession::startUserSession",
                                     m_properties->domainServiceName() );
    }
    else
    {
      log << coral::Warning << errorHandler.message() << coral::MessageStream::endmsg;
    }
  }
  //std::cout << "OCISession set in ctx " << this << std::endl; // bug #83601
  m_properties->setOciSessionHandle( ociSessionHandle );

  // Option 1: password is not null, authenticate via username/password
  std::string authenticating = "authenticating";
  if ( m_password != "" )
  {
    authenticating += " via username/password";
    // Set the user name and the password
    status = OCIAttrSet( ociSessionHandle, OCI_HTYPE_SESSION,
                         const_cast< char *>( m_userName.c_str() ), m_userName.size(),
                         OCI_ATTR_USERNAME, m_properties->ociErrorHandle() );
    if ( status == OCI_SUCCESS )
    {
      status = OCIAttrSet( ociSessionHandle, OCI_HTYPE_SESSION,
                           const_cast< char *>( m_password.c_str() ), m_password.size(),
                           OCI_ATTR_PASSWORD, m_properties->ociErrorHandle() );
    }
    if ( status != OCI_SUCCESS )
    {
      errorHandler.handleCase( status, "setting the user name and the password" );
      coral::MessageStream log( m_properties->domainServiceName() );
      if ( errorHandler.isError() )
      {
        log << coral::Error << errorHandler.message() << coral::MessageStream::endmsg;
        m_properties->setOciSessionHandle( 0 );
        throw coral::SessionException( "Could not set user name and password",
                                       "ISession::startUserSession",
                                       m_properties->domainServiceName() );
      }
      else
      {
        log << coral::Warning << errorHandler.message() << coral::MessageStream::endmsg;
      }
    }
    // Authenticate with username and password
    status = OCISessionBegin( ociSvcCtxHandle,
                              m_properties->ociErrorHandle(),
                              ociSessionHandle,
                              OCI_CRED_RDBMS, // username/password
                              OCI_DEFAULT );
  }

  // Option 2: password is null, username is null, authenticate as Kerberos user
  else if ( m_userName == "" )
  {
    authenticating += " as Kerberos user";
    // Authenticate as Kerberos user (task #30593)
    status = OCISessionBegin( ociSvcCtxHandle,
                              m_properties->ociErrorHandle(),
                              ociSessionHandle,
                              OCI_CRED_EXT, // Kerberos
                              OCI_DEFAULT );
  }

  // Option 3: password is null, username is not null, authenticate as Kerberos proxy
  else
  {
    authenticating += " as Kerberos proxy";
    // Set the proxy client
    status = OCIAttrSet( ociSessionHandle, OCI_HTYPE_SESSION,
                         const_cast< char *>( m_userName.c_str() ), m_userName.size(),
                         OCI_ATTR_PROXY_CLIENT, m_properties->ociErrorHandle() );
    if ( status != OCI_SUCCESS )
    {
      errorHandler.handleCase( status, "setting the Kerberos proxy client" );
      coral::MessageStream log( m_properties->domainServiceName() );
      if ( errorHandler.isError() )
      {
        log << coral::Error << errorHandler.message() << coral::MessageStream::endmsg;
        m_properties->setOciSessionHandle( 0 );
        throw coral::SessionException( "Could not set Kerberos proxy client",
                                       "ISession::startUserSession",
                                       m_properties->domainServiceName() );
      }
      else
      {
        log << coral::Warning << errorHandler.message() << coral::MessageStream::endmsg;
      }
    }
    // Authenticate as Kerberos proxy (task #30593)
    status = OCISessionBegin( ociSvcCtxHandle,
                              m_properties->ociErrorHandle(),
                              ociSessionHandle,
                              OCI_CRED_EXT, // Kerberos
                              OCI_DEFAULT );
  }

  // Check status from OCISessionBegin
  if ( status != OCI_SUCCESS )
  {
    errorHandler.handleCase( status, authenticating );
    coral::MessageStream log( m_properties->domainServiceName() );
    if ( errorHandler.isError() )
    {
      log << coral::Error << errorHandler.message() << coral::MessageStream::endmsg;
      m_properties->setOciSessionHandle( 0 );
      if ( errorHandler.lastErrorCode() == 1017 )
      { // ORA-01017 Failed to authenticate. Do not retry!
        throw coral::AuthenticationFailureException( m_properties->domainServiceName() );
      }
      // Fix for bug #99489
      else if ( errorHandler.lastErrorCode() == 28000 )
      { // ORA-28000 Account locked. Do not retry!
        throw coral::AuthenticationFailureException( m_properties->domainServiceName() );
      }
      // Fix for bug #77440
      else if ( errorHandler.lastErrorCode() == 28001 )
      { // ORA-28001 Password expired. Do not retry!
        throw coral::AuthenticationFailureException( m_properties->domainServiceName() );
      }
      // Partial workaround for bug #103532
      else if ( errorHandler.lastErrorCode() == 12687 )
      { // ORA-12687 Credentials expired. Do not retry!
        throw coral::AuthenticationFailureException( m_properties->domainServiceName() );
      }
      // Fix for bug #98746
      else if ( errorHandler.lastErrorCode() == 1005 )
      { // ORA-01005 Null password given, logon denied. Do not retry!
        throw coral::AuthenticationFailureException( m_properties->domainServiceName() );
      }
      // Fix for bug #102112 (hangs are more likely than success on retrial)
      else if ( errorHandler.lastErrorCode() == 2391 )
      { // ORA-02391 Max simultaneous sessions per user exceeded. Do not retry!
        throw coral::AuthenticationFailureException( m_properties->domainServiceName() );
      }
      // Workaround for bug #58522 (ORA-24327), aka bug #65709, aka bug #75596
      // Do not retry to start a session if connection was lost with ORA-03113
      // or ORA-03135 (or other signals that eventually result in ORA-24327)
      else if ( errorHandler.lastErrorCode() == 3113 ||
                errorHandler.lastErrorCode() == 3135 ||
                errorHandler.lastErrorCode() == 24327 )
      { // Connection lost. Do not retry to start a session on this connection!
        throw coral::SessionException( errorHandler.message(),
                                       "ISession::startUserSession",
                                       m_properties->domainServiceName() );
      }
      else if ( true )
      { // Temporarily unavailable. Retry!
        throw coral::StartSessionException( m_properties->domainServiceName(),
                                            "ISession::startUserSession" );
      }
      else
      { // All other failures (NO PATH TO THIS STATEMENT)
        throw coral::SessionException( errorHandler.message(),
                                       "ISession::startUserSession",
                                       m_properties->domainServiceName() );
      }
    }
    else
    {
      log << coral::Warning << errorHandler.message() << coral::MessageStream::endmsg;
    }
  }
  //std::cout << "OCISession begun " << this << std::endl; // bug #83601

  // Debug
  {
    coral::MessageStream log( m_properties->domainServiceName() );
    log << coral::Verbose << "New user session started with OCISessionBegin"
        << " (OCISession*=" << ociSessionHandle
        << ", OCISvcCtx*=" << ociSvcCtxHandle
        << ") on connection (OCIServer*=" << ociServerHandle << ")"
        << coral::MessageStream::endmsg;
  }

  // Enable sql trace
  static const char* cerntrace_on = ::getenv( "CORAL_ORA_CERN_TRACE_ON" );
  if ( cerntrace_on )
  {
    coral::MessageStream log( m_properties->domainServiceName() );
    log << coral::Info << "Enable CERN SQL trace" << coral::MessageStream::endmsg;
    std::string sqlStatement = "BEGIN CERN_TRACE.CSTART_TRACE( 2 ); END;";
    if ( !executeSimpleSQL( ociSvcCtxHandle, sqlStatement ) )
    {
      log << coral::Warning << "Could not enable CERN SQL trace" << coral::MessageStream::endmsg;
    }
  }
  else
  {
    static const char* sqltrace_on = ::getenv( "CORAL_ORA_SQL_TRACE_ON" );
    if ( sqltrace_on )
    {
      // SQL trace identifier
      static const char* sqltrace_id = ::getenv( "CORAL_ORA_SQL_TRACE_IDENTIFIER" );
      if ( sqltrace_id )
      {
        coral::MessageStream log( m_properties->domainServiceName() );
        log << coral::Info << "Set the SQL trace identifier" << coral::MessageStream::endmsg;
        static std::string sqlStatement = "ALTER SESSION SET tracefile_identifier='" + std::string( sqltrace_id ) + "'";
        if ( !executeSimpleSQL( ociSvcCtxHandle, sqlStatement ) )
        {
          log << coral::Warning << "Could not set the SQL trace identifier" << coral::MessageStream::endmsg;
        }
      }
      // Turn on the appropriate SQL trace
      static std::string sqlStatement = "";
      if ( sqlStatement == "" )
      {
        if ( std::string( sqltrace_on ) == "3106" )
          sqlStatement = "ALTER SESSION SET EVENTS '3106 TRACE NAME ERRORSTACK LEVEL 10'";
        else if ( std::string( sqltrace_on ) == "10046" )
          sqlStatement = "ALTER SESSION SET EVENTS '10046 TRACE NAME CONTEXT FOREVER, LEVEL 12'";
        else if ( std::string( sqltrace_on ) == "10053" )
          sqlStatement = "ALTER SESSION SET EVENTS '10053 TRACE NAME CONTEXT FOREVER, LEVEL 1'";
        else if ( std::string( sqltrace_on ) == "10132" )
          sqlStatement = "ALTER SESSION SET EVENTS '10132 TRACE NAME CONTEXT FOREVER, LEVEL 12'";
        else
          sqlStatement = "ALTER SESSION SET SQL_TRACE=TRUE";
      }
      coral::MessageStream log( m_properties->domainServiceName() );
      log << coral::Info << "Enable SQL trace by " << sqlStatement << coral::MessageStream::endmsg;
      if ( !executeSimpleSQL( ociSvcCtxHandle, sqlStatement ) )
      {
        log << coral::Warning << "Could not enable SQL trace" << coral::MessageStream::endmsg;
      }
    }
  }

  // Enable automatic plan baseline capture (Oracle 11g)
  static const char* capture_on = ::getenv( "CORAL_ORA_CAPTURE_SQL_PLAN_BASELINES" );
  if ( capture_on && m_properties->majorServerVersion() >= 11 )
  {
    std::string sqlStatement = "ALTER SESSION SET OPTIMIZER_CAPTURE_SQL_PLAN_BASELINES=TRUE";
    coral::MessageStream log( m_properties->domainServiceName() );
    log << coral::Info << "Enable automatic plan baseline capture by " << sqlStatement << coral::MessageStream::endmsg;
    if ( !executeSimpleSQL( ociSvcCtxHandle, sqlStatement ) )
    {
      log << coral::Warning << "Could not enable automatic plan baseline capture" << coral::MessageStream::endmsg;
    }
  }

  // Enable automatic plan baseline use (Oracle 11g);
  // by default this is now disabled in CORAL (task #24486)
  // even if it would normally enabled by default in Oracle 11g
  static const char* use_on = ::getenv( "CORAL_ORA_USE_SQL_PLAN_BASELINES" );
  if ( use_on && m_properties->majorServerVersion() >= 11 )
  {
    // This is normally enabled by default on Oracle 11g, but we enable it
    // explicitly as it may be disabled by default on this specific server
    std::string sqlStatement = "ALTER SESSION SET OPTIMIZER_USE_SQL_PLAN_BASELINES=TRUE";
    coral::MessageStream log( m_properties->domainServiceName() );
    log << coral::Info << "Enable plan baseline use by " << sqlStatement << coral::MessageStream::endmsg;
    if ( !executeSimpleSQL( ociSvcCtxHandle, sqlStatement ) )
    {
      log << coral::Warning << "Could not enable plan baseline use" << coral::MessageStream::endmsg;
    }
  }
  else if ( m_properties->majorServerVersion() >= 11 )
  {
    std::string sqlStatement = "ALTER SESSION SET OPTIMIZER_USE_SQL_PLAN_BASELINES=FALSE";
    coral::MessageStream log( m_properties->domainServiceName() );
    log << coral::Info << "Disable plan baseline use by " << sqlStatement << coral::MessageStream::endmsg;
    if ( !executeSimpleSQL( ociSvcCtxHandle, sqlStatement ) )
    {
      log << coral::Warning << "Could not disable plan baseline use" << coral::MessageStream::endmsg;
    }
  }

  // Use an optimizer older than the current Oracle server version
  static const char* optimizer = ::getenv( "CORAL_ORA_OPTIMIZER_FEATURES" );
  if ( optimizer )
  {
    coral::MessageStream log( m_properties->domainServiceName() );
    log << coral::Info << "Set optimizer features '" << optimizer << "'" << coral::MessageStream::endmsg;
    static std::string sqlStatement = "ALTER SESSION SET optimizer_features_enable='" + std::string( optimizer ) + "'";
    if ( !executeSimpleSQL( ociSvcCtxHandle, sqlStatement ) )
    {
      log << coral::Warning << "Could not set optimizer features" << coral::MessageStream::endmsg;
    }
  }

  // Disable specific bug fixes in the Oracle optimizer
  static const char* fixControl = ::getenv( "CORAL_ORA_FIX_CONTROL" );
  if ( fixControl )
  {
    coral::MessageStream log( m_properties->domainServiceName() );
    log << coral::Info << "Set optimizer fix control '" << fixControl << "'" << coral::MessageStream::endmsg;
    static std::string sqlStatement = "ALTER SESSION SET \"_fix_control\" = '" + std::string( fixControl ) + "'";
    if ( !executeSimpleSQL( ociSvcCtxHandle, sqlStatement ) )
    {
      log << coral::Warning << "Could not set optimizer fix control" << coral::MessageStream::endmsg;
    }
  }

  // Disable dynamic sampling (workaround for ORA-04031 bug #94270)
  static const char* noDynSamp = ::getenv( "CORAL_ORA_DISABLE_OPT_DYN_SAMP" );
  if ( noDynSamp )
  {
    coral::MessageStream log( m_properties->domainServiceName() );
    log << coral::Info << "Disable optimizer dynamic sampling (CORAL_ORA_DISABLE_OPT_DYN_SAMP is set)" << coral::MessageStream::endmsg;
    static std::string sqlStatement = "ALTER SESSION SET OPTIMIZER_DYNAMIC_SAMPLING=0";
    if ( !executeSimpleSQL( ociSvcCtxHandle, sqlStatement ) )
    {
      log << coral::Warning << "Could not disable optimizer dynamic sampling" << coral::MessageStream::endmsg;
    }
  }
  else
  {
    coral::MessageStream log( m_properties->domainServiceName() );
    log << coral::Info << "Will not disable optimizer dynamic sampling (CORAL_ORA_DISABLE_OPT_DYN_SAMP is not set)" << coral::MessageStream::endmsg;
  }

  /*
  // Disable cardinality feedback on 11g (workaround for ORA-04031 bug #94270)
  if ( m_properties->majorServerVersion() >= 11 )
  {
    coral::MessageStream log( m_properties->domainServiceName() );
    log << coral::Info << "Disable cardinality feedback" << coral::MessageStream::endmsg;
    static std::string sqlStatement = "ALTER SESSION SET \"_optimizer_use_feedback\"=false";
    if ( !executeSimpleSQL( ociSvcCtxHandle, sqlStatement ) )
    {
      log << coral::Warning << "Could not disable cardinality feedback" << coral::MessageStream::endmsg;
    }
  }
  *///

  // Disable adaptive optimization on 12c (bug #102272 and task #44885)
  // to avoid second SQL parse with OPT_ESTIMATE in trace files
  // See http://docs.oracle.com/cd/E16655_01/server.121/e15858/tgsql_influence.htm#BBAIBDDJ
  if ( m_properties->majorServerVersion() >= 12 )
  {
    coral::MessageStream log( m_properties->domainServiceName() );
    static const char* noAdaptive = ::getenv( "CORAL_ORA_DISABLE_ADAPTIVE_OPT" );
    if ( noAdaptive )
    {
      log << coral::Info << "Disable optimizer adaptive features (CORAL_ORA_DISABLE_ADAPTIVE_OPT is set)" << coral::MessageStream::endmsg;
      static const std::string sqlStatement1 = "ALTER SESSION SET \"OPTIMIZER_ADAPTIVE_FEATURES\"=FALSE";
      if ( !executeSimpleSQL( ociSvcCtxHandle, sqlStatement1 ) )
      {
        log << coral::Warning << "Could not disable optimizer adaptive features (1)" << coral::MessageStream::endmsg;
      }
      static const std::string sqlStatement2 = "ALTER SESSION SET \"OPTIMIZER_ADAPTIVE_REPORTING_ONLY\"=TRUE";
      if ( !executeSimpleSQL( ociSvcCtxHandle, sqlStatement2 ) )
      {
        log << coral::Warning << "Could not disable optimizer adaptive features (2)" << coral::MessageStream::endmsg;
      }
    }
    else
    {
      log << coral::Info << "Will not disable optimizer adaptive features (CORAL_ORA_DISABLE_ADAPTIVE_OPT is not set)" << coral::MessageStream::endmsg;
    }
  }

  // Task #10775 (performance optimization for data dictionary queries)
  // Special settings for special CERN accounts (nightly and release tests)
  static const char* selectsys_on = ::getenv( "CORAL_ORA_SELECT_FROM_SYS_TABLES" );
  if ( !selectsys_on )
  {
    std::string userNameUp = m_userName;
    std::transform( userNameUp.begin(), userNameUp.end(), userNameUp.begin(), (int (*)(int)) std::toupper );
    //std::cout << "USER: " << userNameUp << std::endl;
    if ( userNameUp != "AVALASSI" &&
         userNameUp != "LCG_COOL" &&
         userNameUp != "LCG_COOL_NIGHTLY" &&
         userNameUp != "LCG_CORAL_NIGHTLY" &&
         userNameUp != "LCG_POOL_NIGHTLY" )
      m_properties->cannotSelectAnyTable();
  }
  else
  {
    // Allow also the special accounts to use the default slower queries
    // (these accounts may have special privileges only on some databases)
    std::string selectsysUp = selectsys_on;
    std::transform( selectsysUp.begin(), selectsysUp.end(), selectsysUp.begin(), (int (*)(int)) std::toupper );
    //std::cout << "CORAL_ORA_SELECT_FROM_SYS_TABLES: " << selectsysUp << std::endl;
    if ( selectsysUp == "NO" ||
         selectsysUp == "OFF" )
      m_properties->cannotSelectAnyTable();
  }
}


bool
coral::OracleAccess::Session::isUserSessionActive() const
{
  if ( ! this->isSessionValid() ) return false;
  //coral::lock_guard lock(m_mutex); // USELESS AND MAY CAUSE DEADLOCKS
  return ( m_properties->ociSessionHandle() != 0 );
}


void
coral::OracleAccess::Session::endUserSession()
{
  //std::cout << "Session " << this << ": endUserSession" << std::endl; // debug bug #80174
  if ( ! this->isUserSessionActive() ) return;

  // Abort any active transaction
  if ( this->transaction().isActive() ) this->transaction().rollback();

  coral::lock_guard lock( m_mutex );

  // Get the OCISvcCtx handle (but do not try to reconnect!)
  bool reconnect = false;
  OCISvcCtx* ociSvcCtxHandle = m_properties->ociSvcCtxHandle( reconnect );
  OCISession* ociSessionHandle = m_properties->ociSessionHandle();

  // Stop the tracing
  static const char* cerntrace_on = ::getenv( "CORAL_ORA_CERN_TRACE_ON" );
  if ( cerntrace_on )
  {
    this->transaction().start();
    static const std::string sqlStatement = "BEGIN CERN_TRACE.CSTOP_TRACE('" + std::string( cerntrace_on ) + "'); END;";
    if ( !executeSimpleSQL( ociSvcCtxHandle, sqlStatement ) )
    {
      coral::MessageStream log( m_properties->domainServiceName() );
      log << coral::Warning << "Could not enable SQL TRACE" << coral::MessageStream::endmsg;
    }
    this->transaction().commit();
  }

  // "Delete" transaction (call endUserSession instead: fix bug #80174)
  if ( m_transaction ) m_transaction->endUserSession();

  // "Delete" schemas (call endUserSession instead: fix bug #80178 and #81112)
  {
    coral::lock_guard lockS( m_mutexForSchemas );
    for ( std::map< std::string, coral::OracleAccess::Schema* >::iterator iSchema = m_schemas.begin();
          iSchema != m_schemas.end(); ++iSchema )
    {
      if ( iSchema->second ) iSchema->second->endUserSession();
    }
    if ( m_schema ) m_schema->endUserSession();
  }

  // Debug
  {
    OCIServer* ociServerHandle = m_properties->ociServerHandle( reconnect );
    coral::MessageStream log( m_properties->domainServiceName() );
    log << coral::Verbose << "End user session with OCISessionEnd"
        << " (OCISession*=" << ociSessionHandle
        << ", OCISvcCtx*=" << ociSvcCtxHandle
        << ") on connection (OCIServer*=" << ociServerHandle << ")"
        << coral::MessageStream::endmsg;
  }

  // Close the user session
  if ( ociSvcCtxHandle )
    OCISessionEnd( ociSvcCtxHandle,
                   m_properties->ociErrorHandle(),
                   ociSessionHandle, OCI_DEFAULT );
  //std::cout << "OCISession ended " << this << std::endl; // bug #83601
  m_properties->setOciSessionHandle( 0 );

  // Record the ending of the session
  if ( m_properties->monitoringService() )
  {
    m_properties->monitoringService()->record( "oracle://" + m_properties->connectionString() + "/" + m_properties->schemaName(),
                                               coral::monitor::Session,
                                               coral::monitor::Info,
                                               monitoringEventDescription.sessionEnd() );
  }

  // Defer deletion of OCI service context handle (bug #94385)
  //if ( ociSvcCtxHandle ) OCIHandleFree( ociSvcCtxHandle, OCI_HTYPE_SVCCTX );
  //std::cout << "OCISvcCtx deleted " << this << std::endl; // bug #83601
  m_properties->setOciSvcCtxHandle( 0 );
}


coral::ITransaction&
coral::OracleAccess::Session::transaction()
{
  if ( ! this->isUserSessionActive() )
    throw coral::ConnectionNotActiveException( m_properties->domainServiceName(),
                                               "ISession::transaction" );
  // Test multi-threaded bug #80098: START
  // AV sleep here and you can cause a crash?
  // 1. isUserSessionActive() may change after you evaluated
  // 2. m_transaction may have been deleted anyway (fix memleak bug #80016)
  // => but maybe TransactionProxy in ConnectionService saves the situation?
  if ( getenv( "CORAL_ORA_TEST_BUG80098_SLEEP5S" ) )
  {
    std::string time1 = boost::posix_time::to_simple_string( boost::posix_time::microsec_clock::local_time() ).substr(12);
    std::cout << "__Session::transaction() @"
              << time1 << " sleep 5s (test bug #80098)" << std::endl;
    coral::sleepSeconds(5);
    std::string time2 = boost::posix_time::to_simple_string( boost::posix_time::microsec_clock::local_time() ).substr(12);
    std::cout << "__Session::transaction() @"
              << time2 << " slept 5s (test bug #80098)" << std::endl;
  }
  // Test multi-threaded bug #80098: END
  coral::lock_guard lock( m_mutex );
  // AV 23.01.2014 I am no longer convinced this makes any sense here:
  // m_transaction is never set back to 0 anywhere in Session.cpp...
  if ( !m_transaction ) // fix bug #80098!
    throw coral::SessionException( "Transaction has been nullified",
                                   "SessionProperties::transaction()",
                                   m_properties->domainServiceName() );
  return *m_transaction;
}


coral::ISchema&
coral::OracleAccess::Session::nominalSchema()
{
  if ( ! this->isUserSessionActive() )
    throw coral::ConnectionNotActiveException( m_properties->domainServiceName() );
  //coral::lock_guard lock(m_mutex); // USELESS AND MAY CAUSE DEADLOCKS
  return *m_schema;
}


coral::ISchema&
coral::OracleAccess::Session::schema( const std::string& _schemaName )
{
  if ( ! this->isUserSessionActive() )
    throw coral::ConnectionNotActiveException( m_properties->domainServiceName() );

  // Convert the schema name to uppercase
  std::string schemaName = _schemaName;
  for ( std::string::size_type i = 0; i < schemaName.size(); ++i )
  {
    schemaName[i] = std::toupper( schemaName[i], std::locale::classic() );
  }

  // If this is the nominal schema then return it (fix bug #73530)
  if ( schemaName == m_properties->schemaName() ) return *m_schema;

  // Check first is the schema with the corresponding name exists in the map
  coral::lock_guard lock( m_mutexForSchemas );
  std::map< std::string, coral::OracleAccess::Schema* >::iterator iSchema =
    m_schemas.find( schemaName );
  if ( iSchema != m_schemas.end() ) return *( iSchema->second );

  // Check in the database if a schema with such a name exists
  void* temporaryPointer = 0;
  sword status = OCIHandleAlloc( m_properties->ociEnvHandle(),
                                 &temporaryPointer,
                                 OCI_HTYPE_DESCRIBE, 0, 0 );
  if ( status != OCI_SUCCESS )
  {
    throw coral::SessionException( "Could not allocate a describe handle",
                                   "ISession::schema",
                                   m_properties->domainServiceName() );
  }
  OCIDescribe* ociDescribeHandle = static_cast<OCIDescribe*>(temporaryPointer);

  status = OCIDescribeAny( m_properties->ociSvcCtxHandle(),
                           m_properties->ociErrorHandle(),
                           const_cast<char *>( schemaName.c_str() ),
                           ::strlen( schemaName.c_str() ),
                           OCI_OTYPE_NAME,
                           OCI_DEFAULT,
                           OCI_PTYPE_SCHEMA,
                           ociDescribeHandle );
  coral::OracleAccess::OracleErrorHandler errorHandler( m_properties->ociErrorHandle() );
  errorHandler.handleCase( status, "retrieving the describe handle of schema " + schemaName );
  OCIHandleFree( ociDescribeHandle, OCI_HTYPE_DESCRIBE );

  if ( status != OCI_SUCCESS )
  {
    // Handle special case
    if ( errorHandler.lastErrorCode() == 4043 )
    {
      coral::MessageStream log( m_properties->domainServiceName() );
      log << coral::Debug << errorHandler.message() << coral::MessageStream::endmsg;
      throw coral::InvalidSchemaNameException( m_properties->domainServiceName() );
    }
    // Throw other error messages (fix bug #80951 aka bug #73024)
    throw coral::SessionException( "Could not retrieve the describe handle",
                                   "ISession::schema",
                                   m_properties->domainServiceName() );
  }

  // The schema exists. Insert it into the map of the known ones
  coral::OracleAccess::Schema* schema = new Schema( m_properties, schemaName );
  m_schemas.insert( std::make_pair( schemaName, schema ) );

  // We checked already that user session started (this was missing in first
  // patch for bug #80178, causing bug #81116 and failing tests for bug #81112)
  schema->startUserSession(); // fix bug #81116 (incomplete fix for bug #80178)

  // Return the schema
  return *schema;
}


bool
coral::OracleAccess::Session::restartSession()
{
  // Mark old OCI session for garbage collection in SessionProperties dtor
  m_properties->setOciSessionHandle( 0 );
  m_properties->setOciSvcCtxHandle( 0 );
  // Start a new OCI session
  beginOciSession();
  return true;
}


bool
coral::OracleAccess::Session::executeSimpleSQL( OCISvcCtx* ociSvcCtxHandle,
                                                const std::string& sql ) const
{
  OCIStmt* ociStmtHandle;
  // Prepare the statement
  sword status = OCIStmtPrepare2( ociSvcCtxHandle,
                                  &ociStmtHandle,
                                  m_properties->ociErrorHandle(),
                                  reinterpret_cast<CONST text*>( sql.c_str() ),
                                  ::strlen( sql.c_str() ),
                                  0, 0, OCI_NTV_SYNTAX, OCI_DEFAULT );
  if ( status != OCI_SUCCESS )
  {
    OracleErrorHandler errorHandler( m_properties->ociErrorHandle() );
    errorHandler.handleCase( status, "Preparing statement \"" + sql + "\"" );
    coral::MessageStream log( m_properties->domainServiceName() );
    log << coral::Error << errorHandler.message()
        << coral::MessageStream::endmsg;
    throw coral::QueryException( m_properties->domainServiceName(), "Could not prepare statement \"" + sql + "\"", "OracleSession::executeSQL" );
  }
  // Execute the statement
  status = OCIStmtExecute( ociSvcCtxHandle,
                           ociStmtHandle,
                           m_properties->ociErrorHandle(),
                           1, 0, 0, 0,
                           OCI_DEFAULT );
  if ( status != OCI_SUCCESS )
  {
    OracleErrorHandler errorHandler( m_properties->ociErrorHandle() );
    errorHandler.handleCase( status, "Executing statement \"" + sql + "\"" );
    coral::MessageStream log( m_properties->domainServiceName() );
    log << coral::Error << errorHandler.message()
        << coral::MessageStream::endmsg;
    // Remove old workaround for bug #86301: need not go via sessionProperties
    OCIStmtRelease( ociStmtHandle, m_properties->ociErrorHandle(), 0, 0, OCI_DEFAULT );
    return false;
  }
  return true;
}
