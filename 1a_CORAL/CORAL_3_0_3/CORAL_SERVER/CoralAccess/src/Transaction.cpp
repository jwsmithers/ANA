
// Include files
#include <iostream>
#include "CoralServerBase/NotImplemented.h"
#include "RelationalAccess/SessionException.h"

// Local include files
#include "ConnectionProperties.h"
#include "Transaction.h"
#include "SessionProperties.h"
#include "logger.h"
#include "monitoring.h"

// Namespace
using namespace coral::CoralAccess;

//-----------------------------------------------------------------------------

Transaction::Transaction( const SessionProperties& sessionProperties )
  : m_sessionProperties( sessionProperties )
  , m_isActive( false )
  , m_isReadOnly( false )
{
  logger << "Create Transaction" << endlog;
}

//-----------------------------------------------------------------------------

Transaction::~Transaction()
{
  logger << "Delete Transaction" << endlog;
}

//-----------------------------------------------------------------------------

void Transaction::start( bool readOnly )
{
  SCOPED_TIMER( "CoralAccess::Transaction::start" );
  if ( readOnly ) logger << "Start RO Transaction" << endlog;
  else logger << "Start RW Transaction" << endlog;
  if ( isActive() ) logger << Warning << "A transaction is already active" << endlog;
  if ( ! readOnly && m_sessionProperties.accessMode() == ReadOnly )
    throw coral::InvalidOperationInReadOnlyModeException( "coral::CoralAccess", "Transaction::start" );
  facade().startTransaction( m_sessionProperties.sessionID(), readOnly ); // may throw
  m_isActive = true;
  m_isReadOnly = readOnly;
}

//-----------------------------------------------------------------------------

void Transaction::commit()
{
  SCOPED_TIMER( "CoralAccess::Transaction::commit" );
  logger << "Commit Transaction" << endlog;
  if ( ! isActive() ) logger << Warning << "No active transaction to commit" << endlog;
  facade().commitTransaction( m_sessionProperties.sessionID() ); // may throw
  m_isActive = false;
  m_isReadOnly = false;
}

//-----------------------------------------------------------------------------

void Transaction::rollback()
{
  SCOPED_TIMER( "CoralAccess::Transaction::rollback" );
  logger << "Rollback Transaction" << endlog;
  if ( !isActive() ) logger << Warning << "No active transaction to rollback" << endlog;
  facade().rollbackTransaction( m_sessionProperties.sessionID() ); // may throw
  m_isActive = false;
  m_isReadOnly = false;
}

//-----------------------------------------------------------------------------

bool Transaction::isActive() const
{
  return m_isActive;
}

//-----------------------------------------------------------------------------

bool Transaction::isReadOnly() const
{
  if ( !isActive() ) throw TransactionNotActiveException( "coral::CoralAccess", "Transaction::isReadOnly" );
  return m_isReadOnly;
}

//-----------------------------------------------------------------------------

const coral::ICoralFacade& Transaction::facade() const
{
  return m_sessionProperties.connectionProperties().facade();
}

//-----------------------------------------------------------------------------
