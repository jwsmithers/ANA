#include "SessionHandle.h"
#include "TransactionProxy.h"
#include "CoralBase/MessageStream.h"
#include "CoralCommon/ISession.h"
#include "RelationalAccess/SessionException.h"

coral::ConnectionService::TransactionProxy::TransactionProxy( const SessionHandle& sessionHandle )
  : m_session( sessionHandle )
  , m_mutex()
  , m_wasActive( false )
  , m_wasReadOnly( false )
{
}

coral::ConnectionService::TransactionProxy::~TransactionProxy()
{
}

void
coral::ConnectionService::TransactionProxy::start( bool readOnly )
{
  coral::lock_guard lock(m_mutex);

  m_wasActive = false;
  m_wasReadOnly = readOnly;
  // start the real transaction
  m_session.physicalSession()->transaction().start(readOnly);
  // set now active
  m_wasActive = true;
}


void
coral::ConnectionService::TransactionProxy::commit()
{
  coral::lock_guard lock(m_mutex);

  m_session.physicalSession()->transaction().commit();
  m_wasActive = false;
}

void
coral::ConnectionService::TransactionProxy::rollback()
{
  coral::lock_guard lock(m_mutex);

  m_session.physicalSession()->transaction().rollback();
  m_wasActive = false;
}

bool
coral::ConnectionService::TransactionProxy::isActive() const
{
  return m_session.physicalSession()->transaction().isActive();
}

bool
coral::ConnectionService::TransactionProxy::isReadOnly() const
{
  return m_session.physicalSession()->transaction().isReadOnly();
}
