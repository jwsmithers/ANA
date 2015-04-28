#ifdef WIN32
#include <WTypes.h> // fix bug #35683, bug #73144, bug #76882, bug #79849
#endif

#include <cstdlib>
#include <iostream>

#include "oci.h"

#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"
#include "CoralBase/MessageStream.h"
#include "CoralCommon/MonitoringEventDescription.h"
#include "CoralCommon/SimpleTimer.h"
#include "CoralCommon/Utilities.h"
#include "CoralKernel/Service.h"
#include "RelationalAccess/IMonitoringService.h"
#include "RelationalAccess/SessionException.h"

#include "DomainProperties.h"
#include "ITransactionObserver.h"
#include "OracleErrorHandler.h"
#include "OracleStatement.h"
#include "SessionProperties.h"
#include "Transaction.h"


coral::OracleAccess::Transaction::Transaction( boost::shared_ptr<const SessionProperties> properties,
                                               ITransactionObserver& observer ) :
  m_sessionProperties( properties ),
  m_observer( observer ),
  m_isSerializableIfRO( true ), // actual value is set in startUserSession
  m_ociTransHandle( 0 ),
  m_isReadOnly( false ),
  m_mutex(),
  m_nullifiedSession( false ),
  m_userSessionStarted( false ) // startUserSession must be called explicitly
{
#ifdef ORACLE_CONNECTION_PROPERTIES_DEBUG
  std::cout << "Create Transaction " << this << std::endl; // debug bug #98736
#endif
}


coral::OracleAccess::Transaction::~Transaction()
{
#ifdef ORACLE_CONNECTION_PROPERTIES_DEBUG
  std::cout << "Delete Transaction " << this << std::endl; // debug bug #98736
#endif
  //coral::lock_guard lock(m_mutex); // fix bug #98753? NO, HANGS!!!
  if ( !m_userSessionStarted ) return;  // Transaction was already 'deleted'
  if ( ! m_nullifiedSession ) // this flag is only used here - fix bug #80092
  {
    if ( this->isActive() ) this->rollback();
  }
}


void
coral::OracleAccess::Transaction::start( bool readOnly )
{
  if ( !m_userSessionStarted ) // This transaction was "deleted" (bug #80174)
    throw SessionException( "User session has already ended",
                            "Transaction::start",
                            m_sessionProperties->domainServiceName() );
  if ( this->isActive() )
  {
    coral::MessageStream log( m_sessionProperties->domainServiceName() );
    log << coral::Warning
        << "A transaction is already active" << coral::MessageStream::endmsg;
    return;
  }

  // Workaround for ORA-01466 (bug #87935) - START
  if ( !readOnly || m_isSerializableIfRO ) // SKIP READONLY TRANSACTIONS
  {
    static char* sleepFor01466 = ::getenv( "CORAL_TESTSUITE_SLEEPFOR01466" );
    if ( sleepFor01466 )
    {
      static bool sleepFor01466Always = ( std::string(sleepFor01466) == "ALWAYS" );
      static char* sleepFor01466Prefix = ::getenv( "CORAL_TESTSUITE_SLEEPFOR01466_PREFIX" );
      coral::MessageStream log( m_sessionProperties->domainServiceName() );
      static bool first = true;
      if ( first )
        log << coral::Warning
            << "CORAL_TESTSUITE_SLEEPFOR01466 is set: "
            << "sleep 1s before readonly transactions..."
            << coral::MessageStream::endmsg;
      // Improved workaround: if you can select any table (nightly accounts),
      // sleep only if a table has been modified in the last two seconds.
      // If you cannot select any table (non-privileged account), sleep always.
      // Always sleep also if $CORAL_TESTSUITE_SLEEPFOR01466 == "ALWAYS"
      // (skip data dictionary queries in network glitch test, bug #92391).
      std::auto_ptr<coral::OracleAccess::OracleStatement> pStatement;
      if ( !sleepFor01466Always && m_sessionProperties->selectAnyTable() )
      {
        coral::AttributeList bindData;
        bindData.extend<std::string>( "OWNER" );
        bindData[0].data<std::string>() = m_sessionProperties->schemaName();
        std::string userDollar = "user$";
        if ( m_sessionProperties->majorServerVersion() >= 12 )
          userDollar = "ku$_user_mapping_view";  // workaround for bug #102231
        std::ostringstream os;
        os << "select /*+ INDEX(o I_OBJ2) */ o.name as TABLE_NAME, "
           << "to_char((sysdate-o.mtime)*86400) as SECONDS_SINCE_LASTDDL "
           << "from sys." << userDollar << " u, sys.obj$ o "
           << "where u.name=:OWNER "
           << "and o.owner#=u.user# and o.type#=2 "
           << "and (sysdate-o.mtime)*86400<=2 "; // 2s (1s is not enough)
        if ( sleepFor01466Prefix != 0 )
        {
          if ( first )
            log << coral::Warning
                << "CORAL_TESTSUITE_SLEEPFOR01466PREFIX is set to '"
                << sleepFor01466Prefix << "'"
                << coral::MessageStream::endmsg;
          os << "and o.name like :PREFIX ";
          bindData.extend<std::string>( "PREFIX" );
          bindData[1].data<std::string>() =
            std::string(sleepFor01466Prefix) + "%";
        }
        os << "order by o.mtime desc";
        if ( first )
          log << coral::Warning
              << "CORAL_TESTSUITE_SLEEPFOR01466 is set: "
              << "check last DDL using '" << os.str() << "' where " << bindData
              << coral::MessageStream::endmsg;
        pStatement.reset( new OracleStatement( m_sessionProperties, m_sessionProperties->schemaName(), os.str() ) );
        pStatement->setNumberOfPrefetchedRows( 100 );
        if ( ! pStatement->execute( bindData ) )
        {
          m_sessionProperties->cannotSelectAnyTable();
          pStatement.reset();
        }
      }
      // Data dictionary query was succesfully executed
      if ( pStatement.get() )
      {
        coral::AttributeList output;
        output.extend<std::string>( "TABLE_NAME" );
        output.extend<std::string>( "SECONDS_SINCE_LASTDDL" );
        pStatement->defineOutput( output );
        if( pStatement->fetchNext( false ) ) // ok even if tx is inactive
        {
          log << coral::Warning
              << "Recent DDL: " << output
              << " ==> sleep 1s to avoid ORA-01466"
              << coral::MessageStream::endmsg;
          coral::sleepSeconds(1);
        }
        else log << coral::Warning
                 << "No recent DDL: no need to sleep 1s to avoid ORA-01466"
                 << coral::MessageStream::endmsg;
      }
      // Data dictionary query could not be executed
      else
      {
        log << coral::Warning
            << "Cannot query recent DDL in the data dictionary:"
            << " ==> sleep 1s all the time to avoid ORA-01466"
            << coral::MessageStream::endmsg;
        coral::sleepSeconds(1);
      }
      first = false;
    }
  }
  // Workaround for ORA-01466 (bug #87935) - END

  // Lock the mutex AFTER querying the data dictionary tables...
  coral::lock_guard lock(m_mutex);
  if ( ! readOnly && m_sessionProperties->isReadOnly() )
  {
    throw InvalidOperationInReadOnlyModeException
      ( m_sessionProperties->domainServiceName(), "ITransaction::start" );
  }
  OCITrans* ociTransHandle = this->allocateOCIHandles();
  if ( !readOnly || m_isSerializableIfRO ) // SKIP READONLY TRANSACTIONS
  {
    sword status =
      OCITransStart( m_sessionProperties->ociSvcCtxHandle(),
                     m_sessionProperties->ociErrorHandle(),
                     0,
                     OCI_TRANS_NEW | ( readOnly ? OCI_TRANS_READONLY : 0 ) );
    if ( status != OCI_SUCCESS )
    {
      coral::MessageStream log( m_sessionProperties->domainServiceName() );
      OracleErrorHandler errorHandler( m_sessionProperties->ociErrorHandle() );
      errorHandler.handleCase( status, "start transaction" );
      if ( errorHandler.isError() )
      {
        log << coral::Error
            << errorHandler.message() << coral::MessageStream::endmsg;
        this->releaseOCIHandles( ociTransHandle );
        throw TransactionNotStartedException
          ( m_sessionProperties->domainServiceName() );
      }
      log << coral::Warning
          << errorHandler.message() << coral::MessageStream::endmsg;
    }
    //std::cout << "OCITrans started " << this << std::endl; // bug #83601
  }
  m_isReadOnly = readOnly;
  if ( m_sessionProperties->monitoringService() )
  {
    m_sessionProperties->monitoringService()->record
      ( "oracle://" + m_sessionProperties->connectionString() +
        "/" + m_sessionProperties->schemaName(),
        coral::monitor::Transaction,
        coral::monitor::Info,
        monitoringEventDescription.sessionBegin(),
        ( m_isReadOnly ?
          monitoringEventDescription.transactionReadOnly() :
          monitoringEventDescription.transactionUpdate() ) );
  }
  m_ociTransHandle = ociTransHandle; // NB sets the transaction as active
  //std::cout << "OCITrans is ACTIVE " << this << std::endl; // bug #83601
  m_sessionProperties->refreshTransactionCache( true, m_isReadOnly, m_isSerializableIfRO );
}


void
coral::OracleAccess::Transaction::commit()
{
  if ( !m_userSessionStarted ) // This transaction was "deleted" (bug #80174)
    throw SessionException( "User session has already ended",
                            "Transaction::commit",
                            m_sessionProperties->domainServiceName() );
  coral::MessageStream log( m_sessionProperties->domainServiceName() );
  if ( ! ( this->isActive() ) )
  {
    log << coral::Warning
        << "No active transaction to commit" << coral::MessageStream::endmsg;
    return;
  }

  coral::lock_guard lock(m_mutex);
  coral::SimpleTimer timer;
  if ( m_sessionProperties->monitoringService() ) timer.start();
  sword status = OCI_SUCCESS;
  if ( !m_isReadOnly || m_isSerializableIfRO ) // SKIP READONLY TRANSACTIONS
    status = OCITransCommit( m_sessionProperties->ociSvcCtxHandle(),
                             m_sessionProperties->ociErrorHandle(),
                             OCI_DEFAULT );
  if ( m_sessionProperties->monitoringService() )
  {
    timer.stop();
    double idleTimeSeconds = timer.total() * 1e-6;
    m_sessionProperties->monitoringService()->record
      ( "oracle://" + m_sessionProperties->connectionString() +
        "/" + m_sessionProperties->schemaName(),
        coral::monitor::Transaction,
        coral::monitor::Time,
        monitoringEventDescription.transactionCommit(),
        idleTimeSeconds );
  }
  m_observer.reactOnEndOfTransaction();
  if ( status != OCI_SUCCESS )
  {
    OracleErrorHandler errorHandler( m_sessionProperties->ociErrorHandle() );
    errorHandler.handleCase( status, "commit transaction" );
    log << coral::Error
        << errorHandler.message() << coral::MessageStream::endmsg;
    this->releaseOCIHandles( m_ociTransHandle );
    throw TransactionNotCommittedException
      ( m_sessionProperties->domainServiceName() );
  }
  //if ( !m_isReadOnly || m_isSerializableIfRO ) // SKIP READONLY TRANSACTIONS
  //  std::cout << "OCITrans committed " << this << std::endl; // bug #83601
  this->releaseOCIHandles( m_ociTransHandle );
  m_ociTransHandle = 0; // NB sets the transaction as inactive!
  //std::cout << "OCITrans is INACTIVE " << this << std::endl; // bug #83601
  m_sessionProperties->refreshTransactionCache( false, m_isReadOnly, m_isSerializableIfRO );
}


void
coral::OracleAccess::Transaction::rollback()
{
  if ( !m_userSessionStarted ) // This transaction was "deleted" (bug #80174)
    throw SessionException( "User session has already ended",
                            "Transaction::rollback",
                            m_sessionProperties->domainServiceName() );
  coral::MessageStream log( m_sessionProperties->domainServiceName() );
  if ( ! ( this->isActive() ) )
  {
    log << coral::Warning
        << "No active transaction to roll back"
        << coral::MessageStream::endmsg;
    return;
  }

  coral::lock_guard lock(m_mutex);
  sword status = OCI_SUCCESS;
  if ( !m_isReadOnly || m_isSerializableIfRO ) // SKIP READONLY TRANSACTIONS
  {
    bool reconnect = false; // Do not try to reconnect in getting OCISvcCtx
    OCISvcCtx* ociSvcCtxHandle = m_sessionProperties->ociSvcCtxHandle( reconnect );
    if ( ociSvcCtxHandle )
      status = OCITransRollback( ociSvcCtxHandle,
                                 m_sessionProperties->ociErrorHandle(),
                                 OCI_DEFAULT );
  }
  if ( m_sessionProperties->monitoringService() )
  {
    m_sessionProperties->monitoringService()->record
      ( "oracle://" + m_sessionProperties->connectionString() +
        "/" + m_sessionProperties->schemaName(),
        coral::monitor::Transaction,
        coral::monitor::Info,
        monitoringEventDescription.transactionRollback() );
  }
  m_observer.reactOnEndOfTransaction();
  if ( status != OCI_SUCCESS )
  {
    OracleErrorHandler errorHandler( m_sessionProperties->ociErrorHandle() );
    errorHandler.handleCase( status, "roll back transaction" );
    log << coral::Error
        << errorHandler.message() << coral::MessageStream::endmsg;
    // Added maybe temporarily to study the issue reported in bug #87164
    // (CMS observed an error involving ORA-25408 during a roll back)
    if ( errorHandler.lastErrorCode() == 25408 )
      throw coral::TransactionException( m_sessionProperties->domainServiceName(),
                                         "Transaction::rollback",
                                         errorHandler.message()  );
  }
  //if ( !m_isReadOnly || m_isSerializableIfRO ) // SKIP READONLY TRANSACTIONS
  //  std::cout << "OCITrans rolled back " << this << std::endl; // bug #83601
  this->releaseOCIHandles( m_ociTransHandle );
  m_ociTransHandle = 0; // NB sets the transaction as inactive!
  //std::cout << "OCITrans is INACTIVE " << this << std::endl; // bug #83601
  m_sessionProperties->refreshTransactionCache( false, m_isReadOnly, m_isSerializableIfRO );
}


OCITrans*
coral::OracleAccess::Transaction::allocateOCIHandles() const
{
  if ( !m_userSessionStarted ) // This transaction was "deleted" (bug #80174)
    throw SessionException( "User session has already ended",
                            "Transaction::allocateOCIHandles",
                            m_sessionProperties->domainServiceName() );
  coral::MessageStream log( m_sessionProperties->domainServiceName() );

  // Allocate a new transaction handle
  void* temporaryPointer = 0;
  sword status = OCIHandleAlloc( m_sessionProperties->ociEnvHandle(),
                                 &temporaryPointer,
                                 OCI_HTYPE_TRANS, 0, 0 );
  if ( status != OCI_SUCCESS )
  {
    throw TransactionNotStartedException
      ( m_sessionProperties->domainServiceName(),
        "Failed to allocate a new transaction handle" );
  }
  // NB Setting m_ociTransHandle marks the transaction as active: postpone it!
  OCITrans* ociTransHandle = static_cast< OCITrans* >( temporaryPointer );
  //std::cout << "OCITrans created " << this << std::endl; // bug #83601

  // Set the transaction attribute in the service context
  status = OCIAttrSet( m_sessionProperties->ociSvcCtxHandle(),
                       OCI_HTYPE_SVCCTX, ociTransHandle, 0,
                       OCI_ATTR_TRANS, m_sessionProperties->ociErrorHandle() );
  if ( status != OCI_SUCCESS )
  {
    OracleErrorHandler errorHandler(  m_sessionProperties->ociErrorHandle() );
    errorHandler.handleCase
      ( status, "Setting the transaction attribute in the service context" );
    if ( errorHandler.isError() )
    {
      log << coral::Error
          << errorHandler.message() << coral::MessageStream::endmsg;
      status = OCIHandleFree( ociTransHandle, OCI_HTYPE_TRANS );
      if ( status != OCI_SUCCESS ) // Fix Coverity CHECKED_RETURN
      {
        OracleErrorHandler errorHandler2(  m_sessionProperties->ociErrorHandle() );
        errorHandler2.handleCase( status, "Releasing the transaction handle" );
        if ( errorHandler2.isError() )
          log << coral::Error
              << errorHandler2.message() << coral::MessageStream::endmsg;
        else
          log << coral::Warning
              << errorHandler2.message() << coral::MessageStream::endmsg;
      }
      throw TransactionNotStartedException
        ( m_sessionProperties->domainServiceName(),
          "Failed to set the transaction attribute in the service context" );
    }
    else
    {
      log << coral::Warning
          << errorHandler.message() << coral::MessageStream::endmsg;
    }
  }
  //std::cout << "OCITrans set in ctx " << this << std::endl; // bug #83601
  return ociTransHandle;
}


void
coral::OracleAccess::Transaction::releaseOCIHandles( OCITrans* ociTransHandle ) const
{
  // This transaction was "deleted" (bug #80174)
  if ( !m_userSessionStarted )
    throw SessionException( "User session has already ended",
                            "Transaction::releaseOCIHandles",
                            m_sessionProperties->domainServiceName() );
  // Clear the transaction attribute in the service context (fix bug #61090)
  bool reconnect = false; // Do not try to reconnect in getting OCISvcCtx
  OCISvcCtx* ociSvcCtxHandle = m_sessionProperties->ociSvcCtxHandle( reconnect );
  if ( ociSvcCtxHandle )
  {
    sword status = OCIAttrSet( ociSvcCtxHandle,
                               OCI_HTYPE_SVCCTX, 0, 0, OCI_ATTR_TRANS,
                               m_sessionProperties->ociErrorHandle() );
    if ( status != OCI_SUCCESS )
    {
      OracleErrorHandler errorHandler( m_sessionProperties->ociErrorHandle() );
      errorHandler.handleCase
        ( status, "Clearing the transaction attribute in the service context" );
      coral::MessageStream log( m_sessionProperties->domainServiceName() );
      if ( errorHandler.isError() )
        log << coral::Error
            << errorHandler.message() << coral::MessageStream::endmsg;
      else
        log << coral::Warning
            << errorHandler.message() << coral::MessageStream::endmsg;
    }
    //std::cout << "OCITrans unset in ctx " << this << std::endl; // bug #83601
    // Release the transaction handle
  }
  sword status = OCIHandleFree( ociTransHandle, OCI_HTYPE_TRANS );
  if ( status != OCI_SUCCESS )
  {
    OracleErrorHandler errorHandler(  m_sessionProperties->ociErrorHandle() );
    errorHandler.handleCase( status, "Releasing the transaction handle" );
    coral::MessageStream log( m_sessionProperties->domainServiceName() );
    if ( errorHandler.isError() )
      log << coral::Error
          << errorHandler.message() << coral::MessageStream::endmsg;
    else
      log << coral::Warning
          << errorHandler.message() << coral::MessageStream::endmsg;
  }
  //std::cout << "OCITrans deleted " << this << std::endl; // bug #83601
}


bool
coral::OracleAccess::Transaction::isActive() const
{
  if ( !m_userSessionStarted ) // This transaction was "deleted" (bug #80174)
    throw SessionException( "User session has already ended",
                            "Transaction::isActive",
                            m_sessionProperties->domainServiceName() );
  coral::lock_guard lock(m_mutex); // USELESS AND MAY CAUSE DEADLOCKS?
  return ( m_ociTransHandle != 0 );
}


bool
coral::OracleAccess::Transaction::isReadOnly() const
{
  if ( !m_userSessionStarted ) // This transaction was "deleted" (bug #80174)
    throw SessionException( "User session has already ended",
                            "Transaction::isReadOnly",
                            m_sessionProperties->domainServiceName() );
  coral::lock_guard lock(m_mutex); // USELESS AND MAY CAUSE DEADLOCKS?
  return m_isReadOnly;
}


void
coral::OracleAccess::Transaction::nullifySession()
{
  m_nullifiedSession = true; // do not check m_userSessionStarted here
}


void
coral::OracleAccess::Transaction::startUserSession( bool isSerializableIfRO )
{
  // Sanity check: 'creating' an already 'created' transaction?
  if ( m_userSessionStarted )
    throw SessionException( "PANIC! User session has already started",
                            "Transaction::startUserSession",
                            m_sessionProperties->domainServiceName() );
  m_isSerializableIfRO = isSerializableIfRO;
  m_userSessionStarted = true;
}


void
coral::OracleAccess::Transaction::endUserSession()
{
  // Sanity check: 'deleting' an already 'deleted' transaction?
  if ( !m_userSessionStarted )
    throw SessionException( "PANIC! User session has already ended",
                            "Transaction::endUserSession",
                            m_sessionProperties->domainServiceName() );
  // Rollback the transaction (fully reset its state) if 'deleting' it
  if ( !m_nullifiedSession ) // this flag is only used here - fix bug #80092
  {
    if ( this->isActive() ) this->rollback();
  }
  m_userSessionStarted = false;
}
