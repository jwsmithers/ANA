#include "MySQL_headers.h"

#include "CoralBase/MessageStream.h"
#include "CoralBase/../src/coral_thread_headers.h"
#include "CoralCommon/MonitoringEventDescription.h"
#include "CoralCommon/SimpleTimer.h"
#include "CoralKernel/Service.h"
#include "RelationalAccess/IMonitoringService.h"
#include "RelationalAccess/SessionException.h"

#include "DomainProperties.h"
#include "ErrorHandler.h"
#include "ITransactionObserver.h"
#include "SessionProperties.h"
#include "Transaction.h"

namespace coral
{
  namespace MySQLAccess
  {
    struct Committer
    {
      virtual ~Committer() {};
      virtual bool commit() = 0;
      virtual bool rollback() = 0;
    };

    struct Committer40 : virtual public Committer
    {
      Committer40( boost::shared_ptr<const SessionProperties> p ) : m_properties( p ) {}

      virtual ~Committer40() {};

      virtual bool commit()
      {
        coral::lock_guard lock( m_properties->lock() );
        // We have to do it for via SQL
        if( mysql_query( m_properties->connectionHandle(), "COMMIT" ) )
          return false;

        return true;
      }

      virtual bool rollback()
      {
        coral::lock_guard lock( m_properties->lock() );
        // We have to do it for via SQL
        if( mysql_query( m_properties->connectionHandle(), "ROLLBACK" ) )
          return false;

        return true;
      }

      boost::shared_ptr<const SessionProperties> m_properties;
    };

#if (  MYSQL_VERSION_ID > 40100 )
    struct Committer5x : virtual public Committer
    {
      Committer5x( boost::shared_ptr<const SessionProperties> p ) : m_properties( p ) {}

      virtual ~Committer5x() {};

      virtual bool commit()
      {
        coral::lock_guard lock( m_properties->lock() );
        if( mysql_commit( m_properties->connectionHandle() ))
          return false;

        return true;
      }

      virtual bool rollback()
      {
        coral::lock_guard lock( m_properties->lock() );
        if( mysql_rollback( m_properties->connectionHandle() ))
          return false;

        return true;
      }

      boost::shared_ptr<const SessionProperties> m_properties;
    };
#endif

    struct CommitterFactory
    {
      static Committer* getCommitter( boost::shared_ptr<const SessionProperties> props )
      {
#if (  MYSQL_VERSION_ID > 40100 )
        return new Committer5x( props );
#else
        return new Committer40( props );
#endif
      }
    };
  }
}

coral::MySQLAccess::Transaction::Transaction( boost::shared_ptr<const SessionProperties> properties, ITransactionObserver& observer )
  : m_sessionProperties( properties )
  , m_observer( observer )
  , m_transactionActive( false )
  , m_isReadOnly( false )
{
}

coral::MySQLAccess::Transaction::~Transaction()
{
  if ( this->isActive() ) this->rollback();
}

void coral::MySQLAccess::Transaction::start( bool readOnly )
{
  if ( this->isActive() )
  {
    coral::MessageStream log( m_sessionProperties->domainServiceName() );
    log << coral::Warning << "A transaction is already active" << coral::MessageStream::endmsg;
    return;
  }

  if ( ! readOnly && m_sessionProperties->isReadOnly() ) {
    throw coral::InvalidOperationInReadOnlyModeException( m_sessionProperties->domainServiceName(),
                                                          "ITransaction::start" );
  }

  if ( ! m_isReadOnly )
  {
    coral::lock_guard lock( m_sessionProperties->lock() );
    if ( mysql_query( m_sessionProperties->connectionHandle(), "START TRANSACTION" ) != 0 )
    {
      coral::MySQLAccess::ErrorHandler errorHandler;
      errorHandler.handleCase( m_sessionProperties->connectionHandle(), "Starting a new transaction" );
      coral::MessageStream log( m_sessionProperties->domainServiceName() );
      log << coral::Error << errorHandler.message() << coral::MessageStream::endmsg;
      throw coral::TransactionNotStartedException( m_sessionProperties->domainServiceName() );
    }
  }

  m_transactionActive = true;
  m_isReadOnly = readOnly;

  if ( m_sessionProperties->monitoringService() )
  {
    m_sessionProperties->monitoringService()->record( m_sessionProperties->connectionString(), coral::monitor::Transaction, coral::monitor::Info, monitoringEventDescription.sessionBegin(),
                                                      ( m_isReadOnly ? monitoringEventDescription.transactionReadOnly() : monitoringEventDescription.transactionUpdate() ) );
  }
}

void coral::MySQLAccess::Transaction::commit()
{
  if ( ! ( this->isActive() ) )
  {
    coral::MessageStream log( m_sessionProperties->domainServiceName() );
    log << coral::Warning << "No active transaction to commit" << coral::MessageStream::endmsg;
    return;
  }

  coral::SimpleTimer timer;

  if ( m_sessionProperties->monitoringService() )
    timer.start();

  if ( ! m_isReadOnly )
  {
    std::auto_ptr<coral::MySQLAccess::Committer>
      committer( coral::MySQLAccess::CommitterFactory::getCommitter( m_sessionProperties ) );

    if ( ! committer->commit() )
    {
      coral::MySQLAccess::ErrorHandler errorHandler;
      errorHandler.handleCase( m_sessionProperties->connectionHandle(), "Committing a transaction" );
      coral::MessageStream log( m_sessionProperties->domainServiceName() );
      log << coral::Error << errorHandler.message() << coral::MessageStream::endmsg;
      throw coral::TransactionNotCommittedException( m_sessionProperties->domainServiceName() );
    }
  }


  m_transactionActive = false;


  if ( m_sessionProperties->monitoringService() )
  {
    timer.stop();
    double idleTimeSeconds = 0.0;
    idleTimeSeconds = timer.total() * 1e-6;
    m_sessionProperties->monitoringService()->record( m_sessionProperties->connectionString()
                                                      , coral::monitor::Transaction, coral::monitor::Time
                                                      , monitoringEventDescription.transactionCommit(), idleTimeSeconds );
  }

  m_observer.reactOnEndOfTransaction();
}

void coral::MySQLAccess::Transaction::rollback()
{
  if ( ! ( this->isActive() ) )
  {
    coral::MessageStream log( m_sessionProperties->domainServiceName() );
    log << coral::Warning << "No active transaction to roll back" << coral::MessageStream::endmsg;
    return;
  }

  coral::SimpleTimer timer;

  if ( m_sessionProperties->monitoringService() )
    timer.start();

  if ( ! m_isReadOnly )
  {
    std::auto_ptr<coral::MySQLAccess::Committer>
      committer( coral::MySQLAccess::CommitterFactory::getCommitter( m_sessionProperties ) );

    if ( ! committer->rollback() )
    {
      coral::MySQLAccess::ErrorHandler errorHandler;
      errorHandler.handleCase( m_sessionProperties->connectionHandle(), "Rolling back a transaction" );
      coral::MessageStream log( m_sessionProperties->domainServiceName() );
      log << coral::Error << errorHandler.message() << coral::MessageStream::endmsg;
    }
  }

  m_transactionActive = false;



  if ( m_sessionProperties->monitoringService() )
  {
    timer.stop();
    double idleTimeSeconds = 0.0;
    idleTimeSeconds = timer.total() * 1e-6;
    m_sessionProperties->monitoringService()->record( m_sessionProperties->connectionString()
                                                      , coral::monitor::Transaction, coral::monitor::Time
                                                      , monitoringEventDescription.transactionRollback(), idleTimeSeconds );
  }

  m_observer.reactOnEndOfTransaction();
}

bool coral::MySQLAccess::Transaction::isActive() const
{
  return m_transactionActive;
}

bool coral::MySQLAccess::Transaction::isReadOnly() const
{
  return m_isReadOnly;
}
