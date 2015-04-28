
// Include files
#include <string>

// Local include files
#include "ISessionMgr.h"
#include "RalTransactionMgr.h"
#include "RelationalException.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

RalTransactionMgr::RalTransactionMgr( const boost::shared_ptr<ISessionMgr>& sessionMgr,
                                      bool autoTransactions )
  : m_sessionMgr( sessionMgr )
  , m_autoTransactions( autoTransactions )
{
  m_sessionMgr->log() << "Instantiate a RalTransactionMgr"
                      << coral::MessageStream::endmsg;
  if ( ! autoTransactions )
  {
    //std::cout << "auto transation handling disabled" << std::endl;
  }
}

//-----------------------------------------------------------------------------

RalTransactionMgr::~RalTransactionMgr()
{
  m_sessionMgr->log() << "Delete the RalTransactionMgr"
                      << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

coral::ITransaction&
RalTransactionMgr::coralTransaction( const std::string& source ) const
{
  try
  {
    return m_sessionMgr->session().transaction();
  }
  catch ( std::exception& e )
  {
    m_sessionMgr->log()
      << coral::Error
      << "Exception caught while retrieving the coral::ITransaction: "
      << e.what() << " (" << source << ")" << coral::MessageStream::endmsg;
    throw;
  }
}

//-----------------------------------------------------------------------------

void RalTransactionMgr::start( bool readOnly )
{
  if ( isActive() )
    throw RelationalException("A transaction is already active!",
                              "RalTransactionMgr::start()");
  std::string msg;
  if( readOnly ) msg = "read-only transaction";
  else msg = "read-write transaction";
  m_sessionMgr->log() << "Start a new " << msg << coral::MessageStream::endmsg;
  if ( !readOnly && m_sessionMgr->isReadOnly() )
    throw DatabaseOpenInReadOnlyMode( "RalTransactionMgr" );
  // in case of manual transactions only initiate a new one if none is active
  // (there is no start transaction hook)
  if ( autoTransactions() )
  {
    coralTransaction( "Automatic start "+msg ).start( readOnly );
  }
  else
  {
    //std::cout << "start " << msg << " in semi-manual mode" << std::endl;
    if ( ! isActive() )
    {
      //std::cout << "starting new " << msg << std::endl;
      coralTransaction( "Semi-manual start "+msg ).start( readOnly );
    }
    else
    {
      if ( isReadOnly() )
      {
        //std::cout << "read-only transaction already active" << std::endl;
        if ( ! readOnly )
        {
          // TODO! I DO NOT LIKE THIS... (AV)
          //std::cout << "starting new " << msg << std::endl;
          coralTransaction( "Semi-manual restart "+msg ).start( readOnly );
        }
      }
    }
  }
  //std::cout << "transaction started" << std::endl;
}

//-----------------------------------------------------------------------------

void RalTransactionMgr::commit()
{
  m_sessionMgr->log() << "Commit any open transaction"
                      << coral::MessageStream::endmsg;
  if ( isActive() )
  {
    if ( autoTransactions() )
    {
      // auto transactions always commit
      coralTransaction( "Auto commit" ).commit();
    }
    else if ( isReadOnly() )
    {
      // semi-manual transactions only commit if they are read-only
      // (this is the 'semi' part of manual: only r/w transactions are
      // manually committed)
      coralTransaction( "Semi-manual commit" ).commit();
    }
  }
}

//-----------------------------------------------------------------------------

void RalTransactionMgr::rollback()
{
  m_sessionMgr->log() << "Rollback any open transaction"
                      << coral::MessageStream::endmsg;
  // Better not to check if the transaction is active or not.
  // If there is no active transaction, CORAL will issue a warning.
  if ( autoTransactions() )
  {
    coralTransaction( "Auto rollback" ).rollback();
    //std::cout << "transaction rolled back" << std::endl;
  }
  else
  {
    // TODO! YOU __MUST__ ROLLBACK HERE (AV)
  }
}

//-----------------------------------------------------------------------------

bool RalTransactionMgr::isActive()
{
  return coralTransaction( "Check isActive" ).isActive();
}

//-----------------------------------------------------------------------------

bool RalTransactionMgr::isReadOnly()
{
  return coralTransaction( "Check isReadOnly" ).isReadOnly();
}

//-----------------------------------------------------------------------------
