#ifdef WIN32
#include <WTypes.h> // fix bug #35683, bug #73144, bug #76882, bug #79849
#endif

#include <iostream>
#include "oci.h"

#include "CoralBase/../src/coral_datetime_headers.h"
#include "CoralBase/MessageStream.h"
#include "CoralCommon/Utilities.h"
#include "CoralKernel/Service.h"
#include "RelationalAccess/IColumn.h"
#include "RelationalAccess/ISchema.h"
#include "CoralCommon/ISession.h"
#include "RelationalAccess/ITable.h"
#include "RelationalAccess/ITableDescription.h"
#include "RelationalAccess/ITransaction.h"
#include "RelationalAccess/ITypeConverter.h"
#include "RelationalAccess/IView.h"
#include "RelationalAccess/SessionException.h"

#include "ConnectionProperties.h"
#include "DomainProperties.h"
#include "Session.h"
#include "SessionProperties.h"
#include "Transaction.h"

coral::OracleAccess::SessionProperties::SessionProperties( boost::shared_ptr<ConnectionProperties> connectionProperties,
                                                           const std::string& schemaName,
                                                           Session& session,
                                                           bool readOnly ) :
  m_connectionProperties( connectionProperties ),
  m_domainServiceName( connectionProperties->domainServiceName() ),
  m_session( &session ),
  m_ociSvcCtxHandle( 0 ),
  m_ociSessionHandle( 0 ),
  m_ociSvcCtxHandleBin(),
  m_ociSessionHandleBin(),
  m_monitoringService( 0 ),
  m_schemaName( schemaName ),
  m_isReadOnly( readOnly ),
  m_mutex(),
  m_schemaMutex(),
  //m_transactionMutex(),
  m_selectAnyTable( true ),
  m_txCacheMutex(),
  m_txCacheIsActive( false ),
  m_txCacheIsReadOnly( false ),
  m_txCacheIsSerializableIfRO( false ),
  m_nConnectionRestarted( connectionProperties->nRestarted() )
{
#ifdef ORACLE_CONNECTION_PROPERTIES_DEBUG
  std::cout << "Create SessionProperties " << this << std::endl; // debug bug #98736
#endif
}

coral::OracleAccess::SessionProperties::~SessionProperties()
{
#ifdef ORACLE_CONNECTION_PROPERTIES_DEBUG
  std::cout << "Delete SessionProperties " << this << std::endl; // debug bug #98736
#endif
  /// Unset session reference in old OCI service context handles (bug #94385)
  for ( std::vector<OCISvcCtx*>::const_iterator
          ociSvcCtxHandle = m_ociSvcCtxHandleBin.begin();
        ociSvcCtxHandle != m_ociSvcCtxHandleBin.end();
        ociSvcCtxHandle++ )
  {
    OCIAttrSet( *ociSvcCtxHandle,
                OCI_HTYPE_SVCCTX, 0, 0, OCI_ATTR_SESSION,
                ociErrorHandle() );
  }
  /// Empty the garbage bin of old OCI session handles (bug #94385)
  for ( std::vector<OCISession*>::const_iterator
          ociSessionHandle = m_ociSessionHandleBin.begin();
        ociSessionHandle != m_ociSessionHandleBin.end();
        ociSessionHandle++ )
  {
    OCIHandleFree( *ociSessionHandle, OCI_HTYPE_SESSION );
  }
  /// Empty the garbage bin of old OCI service context handles (bug #94385)
  for ( std::vector<OCISvcCtx*>::const_iterator
          ociSvcCtxHandle = m_ociSvcCtxHandleBin.begin();
        ociSvcCtxHandle != m_ociSvcCtxHandleBin.end();
        ociSvcCtxHandle++ )
  {
    OCIHandleFree( *ociSvcCtxHandle, OCI_HTYPE_SVCCTX );
  }
  /// Finally release also the current handles (bug #98736)
  /// NB This should normally not be needed because the current handles should
  /// have already been moved to the garbage bin by Session::endUserSession
  if ( m_ociSessionHandle )
  {
    OCIHandleFree( m_ociSessionHandle, OCI_HTYPE_SESSION );
    m_ociSessionHandle = 0;
  }
  if ( m_ociSvcCtxHandle )
  {
    OCIHandleFree( m_ociSvcCtxHandle, OCI_HTYPE_SVCCTX );
    m_ociSvcCtxHandle = 0;
  }
}


void
coral::OracleAccess::SessionProperties::nullifySession()
{
  //std::cout << "SessionProperties " << this << ": nullifySession" << std::endl; // debug bug #80174
  if ( getenv( "CORAL_ORA_TEST_BUG80065_SLEEP5S" ) )
  {
    std::string time1 = boost::posix_time::to_simple_string( boost::posix_time::microsec_clock::local_time() ).substr(12);
    std::cout << "__SessionProperties::nullifySession() @"
              << time1 << "... (test bug #80065)" << std::endl;
  }
  coral::lock_guard lockS(m_schemaMutex); // fixes bug #80065 & #80174!
  //coral::lock_guard lockT(m_transactionMutex); // fixes bug #80174?
  m_session = NULL;
  if ( getenv( "CORAL_ORA_TEST_BUG80065_SLEEP5S" ) )
  {
    std::string time2 = boost::posix_time::to_simple_string( boost::posix_time::microsec_clock::local_time() ).substr(12);
    std::cout << "__SessionProperties::nullifySession() @"
              << time2 << " OK (test bug #80065)" << std::endl;
  }
}


bool
coral::OracleAccess::SessionProperties::isTransactionActive() const
{
  //coral::lock_guard lock(m_transactionMutex); // fix bug #80174?
  if ( !m_session )
    throw coral::SessionException( "Session has been nullified",
                                   "SessionProperties::isTransactionActive",
                                   domainServiceName() );
  // Test multi-threaded bug #80174
  // Without a mutex, this crashes...
  if ( getenv( "CORAL_ORA_TEST_BUG80174_SLEEP5S" ) )
  {
    coral::ITransaction& transaction = m_session->transaction();
    std::string time1 = boost::posix_time::to_simple_string( boost::posix_time::microsec_clock::local_time() ).substr(12);
    std::cout << "__SessionProperties::isTransactionActive() @"
              << time1 << " sleep 5s (test bug #80174)" << std::endl;
    coral::sleepSeconds(5);
    std::string time2 = boost::posix_time::to_simple_string( boost::posix_time::microsec_clock::local_time() ).substr(12);
    std::cout << "__SessionProperties::isTransactionActive() @"
              << time2 << " slept 5s (test bug #80174)" << std::endl;
    return transaction.isActive();
  }
  // Test multi-threaded bug #80174
  // TO BE CHECKED: IS THIS NEEDED IN RAFFAELLO'S NETGLITCH IMPLEMENTATION?
  // [RAFFAELLO'S VERSION USES 'this' INSTEAD OF 'm_session']
  //if ( !m_session->isUserSessionActive() ) // fix bug #80098?
  //  throw coral::SessionException( "Session has been nullified",
  //                                 "SessionProperties::isTransactionActive",
  //                                 domainServiceName() );
  //std::cout << "SessionProperties::isTransactionActive: Session is " << m_session << std::endl; // debug bug #80098
  return m_session->transaction().isActive();
}


bool
coral::OracleAccess::SessionProperties::isTransactionReadOnly() const
{
  if ( !m_session )
    throw coral::SessionException( "Session has been nullified",
                                   "SessionProperties::isTransactionReadOnly",
                                   domainServiceName() );
  return m_session->transaction().isReadOnly();
}


/*
bool
coral::OracleAccess::SessionProperties::isTransactionSerializableIfRO() const
{
  if ( !m_session )
    throw coral::SessionException( "Session has been nullified",
                                   "SessionProperties::isTransactionSerializableIfRO",
                                   domainServiceName() );
  const Transaction* tx = dynamic_cast<const Transaction*>( &( m_session->transaction() ) );
  if ( !tx )
    throw coral::SessionException( "Could not dynamic cast Transaction",
                                   "SessionProperties::isTransactionSerializableIfRO",
                                   domainServiceName() );
  return tx->isSerializableIfRO();
}
*///


bool
coral::OracleAccess::SessionProperties::selectAnyTable() const
{
  return m_selectAnyTable;
}


void
coral::OracleAccess::SessionProperties::cannotSelectAnyTable() const
{
  m_selectAnyTable = false;
}


bool
coral::OracleAccess::SessionProperties::existsTable( const std::string& schemaName,
                                                     const std::string& tableName ) const
{
  coral::lock_guard lock(m_schemaMutex); // fix bug #80065
  if ( !m_session )
    throw coral::SessionException( "Session has been nullified",
                                   "SessionProperties::session",
                                   domainServiceName() );
  return m_session->schema( schemaName ).existsTable( tableName );
}

bool
coral::OracleAccess::SessionProperties::existsView( const std::string& schemaName,
                                                    const std::string& viewName ) const
{
  coral::lock_guard lock(m_schemaMutex); // fix bug #80065
  if ( !m_session )
    throw coral::SessionException( "Session has been nullified",
                                   "SessionProperties::session",
                                   domainServiceName() );
  return m_session->schema( schemaName ).existsView( viewName );
}


const std::vector<std::string>
coral::OracleAccess::SessionProperties::describeTable( const std::string& schemaName,
                                                       const std::string& tableName ) const
{
  coral::lock_guard lock(m_schemaMutex); // fix bug #80065
  if ( !m_session )
    throw coral::SessionException( "Session has been nullified",
                                   "SessionProperties::session",
                                   domainServiceName() );
  // Test multi-threaded bug #80178 or bug #81112: START
  // Without a mutex, this crashes...
  if ( getenv( "CORAL_ORA_TEST_BUG80178_SLEEP5S" ) ||
       getenv( "CORAL_ORA_TEST_BUG81112_SLEEP5S" ) )
  {
    std::vector<std::string> colNames;
    ISchema& schema = m_session->schema( schemaName );
    std::string time1 = boost::posix_time::to_simple_string( boost::posix_time::microsec_clock::local_time() ).substr(12);
    std::cout << "__SessionProperties::describeTable() @"
              << time1 << " sleep 5s (test bug #80178 and bug #81112)"
              << std::endl;
    coral::sleepSeconds(5);
    std::string time2 = boost::posix_time::to_simple_string( boost::posix_time::microsec_clock::local_time() ).substr(12);
    std::cout << "__SessionProperties::describeTable() @"
              << time2 << " slept 5s (test bug #80178 and bug #81112)"
              << std::endl;
    const ITableDescription& desc = schema.tableHandle( tableName ).description();
    for ( int iCol = 0; iCol < desc.numberOfColumns(); ++iCol )
      colNames.push_back( desc.columnDescription(iCol).name() );
    return colNames;
  }
  // Test multi-threaded bug #80178 and bug #81112: END
  // Test multi-threaded bug #80065 (same as single-threaded bug #73834): START
  if ( getenv( "CORAL_ORA_TEST_BUG80065_SLEEP5S" ) )
  {
    std::string time1 = boost::posix_time::to_simple_string( boost::posix_time::microsec_clock::local_time() ).substr(12);
    std::cout << "__SessionProperties::describeTable() @"
              << time1 << " sleep 5s (test bug #80065)" << std::endl;
    coral::sleepSeconds(5);
    std::string time2 = boost::posix_time::to_simple_string( boost::posix_time::microsec_clock::local_time() ).substr(12);
    std::cout << "__SessionProperties::describeTable() @"
              << time2 << " slept 5s (test bug #80065)" << std::endl;
  }
  // Test multi-threaded bug #80065 (same as single-threaded bug #73834): END
  std::vector<std::string> colNames;
  const ITableDescription& desc = m_session->schema( schemaName ).tableHandle( tableName ).description();
  for ( int iCol = 0; iCol < desc.numberOfColumns(); ++iCol )
    colNames.push_back( desc.columnDescription(iCol).name() );
  return colNames;
}


const std::vector<std::string>
coral::OracleAccess::SessionProperties::describeView( const std::string& schemaName,
                                                      const std::string& viewName ) const
{
  coral::lock_guard lock(m_schemaMutex); // fix bug #80065
  if ( !m_session )
    throw coral::SessionException( "Session has been nullified",
                                   "SessionProperties::session",
                                   domainServiceName() );
  std::vector<std::string> colNames;
  const IView& view = m_session->schema( schemaName ).viewHandle( viewName );
  for ( int iCol = 0; iCol < view.numberOfColumns(); ++iCol )
    colNames.push_back( view.column(iCol).name() );
  return colNames;
}


coral::IView&
coral::OracleAccess::SessionProperties::viewHandle( const std::string& schemaName,
                                                    const std::string& viewName ) const
{
  coral::lock_guard lock(m_schemaMutex); // fix bug #80065
  if ( !m_session )
    throw coral::SessionException( "Session has been nullified",
                                   "SessionProperties::session",
                                   domainServiceName() );
  return m_session->schema( schemaName ).viewHandle( viewName );
}


std::string
coral::OracleAccess::SessionProperties::cppTypeForSqlType( const std::string& sqlType ) const
{
  // NB do not lock the schema mutex (deadlock due to recursive calls)
  // Test multi-threaded bug #80097: START
  if ( getenv( "CORAL_ORA_TEST_BUG80097_SLEEP5S" ) )
  {
    ITypeConverter& typeConverter = m_connectionProperties->typeConverter();
    std::string time1 = boost::posix_time::to_simple_string( boost::posix_time::microsec_clock::local_time() ).substr(12);
    std::cout << "__SessionProperties::cppTypeForSqlType() @"
              << time1 << " sleep 5s (test bug #80097)" << std::endl;
    coral::sleepSeconds(5);
    std::string time2 = boost::posix_time::to_simple_string( boost::posix_time::microsec_clock::local_time() ).substr(12);
    std::cout << "__SessionProperties::cppTypeForSqlType() @"
              << time2 << " slept 5s (test bug #80097)" << std::endl;
    return typeConverter.cppTypeForSqlType( sqlType );
  }
  // Test multi-threaded bug #80097: END
  return m_connectionProperties->typeConverter().cppTypeForSqlType( sqlType );
}


std::string
coral::OracleAccess::SessionProperties::sqlTypeForCppType( const std::string& cppType ) const
{
  // NB do not lock the schema mutex (deadlock due to recursive calls)
  return m_connectionProperties->typeConverter().sqlTypeForCppType( cppType );
}


OCIEnv*
coral::OracleAccess::SessionProperties::ociEnvHandle() const
{
  return m_connectionProperties->ociEnvHandle();
}


OCIError*
coral::OracleAccess::SessionProperties::ociErrorHandle() const
{
  return m_connectionProperties->ociErrorHandle();
}


OCIServer*
coral::OracleAccess::SessionProperties::ociServerHandle( bool reconnect, bool updateNRestarted ) const
{
  // Eventually move to ConnectionProperties? (beware of mutex!)
  if ( m_connectionProperties->ociServerHandle() &&
       m_connectionProperties->wasConnectionLost() ) // check connection only!
  {
    coral::MessageStream log( domainServiceName() );
    log << coral::Error << "The connection was lost (SessionProperties::ociServerHandle). Possibly a network glitch or ORA-03113 error." << coral::MessageStream::endmsg; // TOO VERBOSE?
    if ( getenv( "CORAL_ORA_TEST_ORA24327_KEEPSTALECONN" ) ) // fix bug #94103
    {
      std::string time1 = boost::posix_time::to_simple_string( boost::posix_time::microsec_clock::local_time() ).substr(12);
      std::cout << "__SP::ociServerHandle() @" << time1
                << " return stale OCIServer* (test ORA-24327)!" << std::endl;
      return m_connectionProperties->ociServerHandle();
    }
    if ( !reconnect )
    {
      log << coral::Error << "The connection was lost! Possibly a network glitch or ORA-03113 error. Reconnection is not attempted during session or transaction termination." << coral::MessageStream::endmsg;
      return 0;
    }
    coral::lock_guard lock( m_txCacheMutex );
    if ( m_txCacheIsActive )
    {
      if ( !m_txCacheIsReadOnly )
      {
        throw ConnectionLostException( domainServiceName(), "SessionProxy::ociServerHandle", "Possibly a network glitch or ORA-03113 error. Reconnection is not attempted in R/W transactions." );
      }
      else if( m_txCacheIsSerializableIfRO )
      {
        throw ConnectionLostException( domainServiceName(), "SessionProxy::ociServerHandle", "Possibly a network glitch or ORA-03113 error. Reconnection is not attempted in serializable R/O transactions." );
      }
      else
      {
        // Restart connection ONLY (session/transaction in ociSvcCtxHandle)
        if ( !m_connectionProperties->restartConnectionWithTimeOut() )
          throw ConnectionLostException( domainServiceName(), "SessionProxy::ociServerHandle", "Possibly a network glitch or ORA-03113 error. Reconnection was attempted but failed (non-serializable RO transaction is active)." );
      }
    }
    else
    {
      // Restart connection ONLY (session/transaction in ociSvcCtxHandle)
      if ( !m_connectionProperties->restartConnectionWithTimeOut() )
        throw ConnectionLostException( domainServiceName(), "SessionProxy::ociServerHandle", "Possibly a network glitch or ORA-03113 error. Reconnection was attempted but failed (transaction is inactive)" );
    }
    if ( updateNRestarted ) m_nConnectionRestarted = m_connectionProperties->nRestarted();  // fix bug #94114
  }
  return m_connectionProperties->ociServerHandle();
}


void
coral::OracleAccess::SessionProperties::setOciSvcCtxHandle( OCISvcCtx* ociSvcCtxHandle )
{
  coral::lock_guard lock(m_mutex);
  // Defer deletion of OCI service context handle (bug #94385)
  if ( m_ociSvcCtxHandle != 0 )
    m_ociSvcCtxHandleBin.push_back( m_ociSvcCtxHandle );
  m_ociSvcCtxHandle = ociSvcCtxHandle;
}


void
coral::OracleAccess::SessionProperties::setOciSessionHandle( OCISession* ociSessionHandle )
{
  coral::lock_guard lock(m_mutex);
  // Defer deletion of OCI session handle (bug #94385)
  if ( m_ociSessionHandle != 0 )
    m_ociSessionHandleBin.push_back( m_ociSessionHandle );
  m_ociSessionHandle = ociSessionHandle;
}


OCISvcCtx*
coral::OracleAccess::SessionProperties::ociSvcCtxHandle( bool reconnect ) const
{
  //coral::lock_guard lock(m_mutex); // USELESS AND MAY CAUSE DEADLOCKS
  if ( m_ociSvcCtxHandle && wasSessionLost() )
  {
    coral::MessageStream log( domainServiceName() );
    log << coral::Error << "The session was lost (SessionProperties::ociSvcCtxHandle). Possibly a network glitch or ORA-03113 error." << coral::MessageStream::endmsg; // TOO VERBOSE?
    if ( !reconnect )
    {
      log << coral::Error << "The connection was lost! Possibly a network glitch or ORA-03113 error. Reconnection is not attempted during session or transaction termination." << coral::MessageStream::endmsg;
      return 0;
    }
    coral::lock_guard lock( m_txCacheMutex );
    if ( m_txCacheIsActive )
    {
      if ( !m_txCacheIsReadOnly )
      {
        throw ConnectionLostException( domainServiceName(), "SessionProxy::ociSvcCtxHandle", "Possibly a network glitch or ORA-03113 error. Reconnection is not attempted in R/W transactions." );
      }
      else if( m_txCacheIsSerializableIfRO )
      {
        throw ConnectionLostException( domainServiceName(), "SessionProxy::ociSvcCtxHandle", "Possibly a network glitch or ORA-03113 error. Reconnection is not attempted in serializable R/O transactions." );
      }
      else
      {
        // Restart connection (if not yet done by another session sharing it)
        if ( m_connectionProperties->wasConnectionLost() )
        {
          if ( !m_connectionProperties->restartConnectionWithTimeOut() )
            throw ConnectionLostException( domainServiceName(), "SessionProxy::ociServerHandle", "Possibly a network glitch or ORA-03113 error. Reconnection was attempted but failed (non-serializable RO transaction is active)." );
        }
        // Restart session
        if ( !restartSession() )
          throw ConnectionLostException( domainServiceName(), "SessionProxy::ociServerHandle", "Possibly a network glitch or ORA-03113 error. Connection was reestablished but session could not be restarted (non-serializable RO transaction is active)." );
        // Restart transaction
      }
    }
    else
    {
      // Restart connection (if not yet done by another session sharing it)
      if ( m_connectionProperties->wasConnectionLost() )
      {
        if ( !m_connectionProperties->restartConnectionWithTimeOut() )
          throw ConnectionLostException( domainServiceName(), "SessionProxy::ociServerHandle", "Possibly a network glitch or ORA-03113 error. Reconnection was attempted but failed (transaction is inactive)." );
      }
      // Restart session
      if ( !restartSession() )
        throw ConnectionLostException( domainServiceName(), "SessionProxy::ociServerHandle", "Possibly a network glitch or ORA-03113 error. Connection was reestablished but session could not be restarted (transaction is inactive)." );
      // No need to restart transaction (it was inactive)
    }
  }
  return m_ociSvcCtxHandle;
}


OCISession*
coral::OracleAccess::SessionProperties::ociSessionHandle() const
{
  //coral::lock_guard lock(m_mutex); // USELESS AND MAY CAUSE DEADLOCKS
  return m_ociSessionHandle;
}


void
coral::OracleAccess::SessionProperties::refreshTransactionCache( bool isActive, bool isReadOnly, bool isSerializableIfRO ) const
{
  coral::lock_guard lock( m_txCacheMutex );
  m_txCacheIsActive = isActive;
  m_txCacheIsReadOnly = isReadOnly;
  m_txCacheIsSerializableIfRO = isSerializableIfRO;
}


bool
coral::OracleAccess::SessionProperties::wasSessionLost() const
{
  if ( m_connectionProperties->wasConnectionLost() )
  {

  }


  return ( m_connectionProperties->wasConnectionLost() ) ||
    ( m_nConnectionRestarted < m_connectionProperties->nRestarted() );
}


bool
coral::OracleAccess::SessionProperties::restartSession() const
{
  coral::MessageStream log( domainServiceName() );
  log << coral::Error << "The session was lost (SessionProperties::restartSession). Possibly a network glitch or ORA-03113 error. Restart OCI in the session." << coral::MessageStream::endmsg; // Would be nice to add session#id?...
  bool status = m_session->restartSession();
  if ( status ) m_nConnectionRestarted = m_connectionProperties->nRestarted();
  return status;
}
