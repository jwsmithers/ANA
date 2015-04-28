
// Include files
#include <string>

// Local include files
#include "IRelationalTransactionMgr.h"
#include "RelationalTransaction.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

RelationalTransaction::RelationalTransaction
( const boost::shared_ptr<IRelationalTransactionMgr>& transactionMgr,
  bool readOnly )
  : m_transactionMgr( transactionMgr )
{
  //std::string msg;
  //if( readOnly ) msg = "read-only transaction";
  //else msg = "read-write transaction";
  //m_transactionMgr->log() << "Start a new " << msg << seal::flush;
  m_transactionMgr->start( readOnly );
}

//-----------------------------------------------------------------------------

RelationalTransaction::~RelationalTransaction()
{
  rollback();
}

//-----------------------------------------------------------------------------

void RelationalTransaction::commit()
{
  //m_transactionMgr->log() << "Commit any open transaction" << seal::flush;
  if ( m_transactionMgr->isActive() ) {
    m_transactionMgr->commit();
  }
}

//-----------------------------------------------------------------------------

void RelationalTransaction::rollback()
{
  //m_transactionMgr->log() << "Rollback any open transaction" << seal::flush;
  if ( m_transactionMgr->isActive() ) {
    m_transactionMgr->rollback();
  }
}

//-----------------------------------------------------------------------------
