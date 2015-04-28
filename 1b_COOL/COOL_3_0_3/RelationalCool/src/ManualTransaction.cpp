
// First of all, set/unset COOL290, COOL300, COOL_HAS_CPP11 and COOL400 macros
#include "CoolKernel/VersionInfo.h"

#ifdef COOL400

// Include files
#include <string>
#include <iostream>

// Local include files
#include "IRelationalTransactionMgr.h"
#include "ManualTransaction.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

ManualTransaction::ManualTransaction
( const boost::shared_ptr<IRelationalTransactionMgr>& transactionMgr,
  bool readOnly )
  : m_transactionMgr( transactionMgr )
{
  std::string msg;
  if( readOnly ) msg = "read-only transaction";
  else msg = "read-write transaction";
  m_transactionMgr->start( readOnly );
}

//-----------------------------------------------------------------------------

ManualTransaction::~ManualTransaction()
{
  rollback();
}

//-----------------------------------------------------------------------------

void ManualTransaction::commit()
{
  // reset the transaction manager to auto-transaction mode -- this needs
  // to be done first, because the commit would otherwise be ignored
  m_transactionMgr->setAutoTransactions( true );
  if ( m_transactionMgr->isActive() ) {
    m_transactionMgr->commit();
  }
}

//-----------------------------------------------------------------------------

void ManualTransaction::rollback()
{
  // reset the transaction manager to auto-transaction mode -- this needs
  // to be done first, because the rollback would otherwise be ignored
  m_transactionMgr->setAutoTransactions( true );
  if ( m_transactionMgr->isActive() ) {
    m_transactionMgr->rollback();
  }
}

//-----------------------------------------------------------------------------

#endif
