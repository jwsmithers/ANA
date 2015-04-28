#ifndef RELATIONALCOOL_MANUALTRANSACTION_H
#define RELATIONALCOOL_MANUALTRANSACTION_H 1

// First of all, set/unset COOL290, COOL300, COOL_HAS_CPP11 and COOL400 macros
#include "CoolKernel/VersionInfo.h"

// This class only exists in the COOL400 API
#ifdef COOL400

// Include files
#include <boost/shared_ptr.hpp>
#include "CoolKernel/ITransaction.h"

namespace cool
{

  // Forward declaration
  class IRelationalTransactionMgr;

  class ManualTransaction : public ITransaction
  {

  public:

    /// Destructor
    virtual ~ManualTransaction();

    /// Constructor from a IRelationalTransactionMgr
    ManualTransaction
    ( const boost::shared_ptr<IRelationalTransactionMgr>& transactionMgr,
      bool readOnly = false );

    /// Commit the transaction *and* re-enable auto-transaction mode
    void commit();

    /// Rollback the transaction *and* re-enable auto-transaction mode
    void rollback();

  private:

    /// Standard constructor is private
    ManualTransaction();

    /// Copy constructor is private
    ManualTransaction( const ManualTransaction& rhs );

    /// Assignment operator is private
    ManualTransaction& operator=( const ManualTransaction& rhs );

  private:

    /// Handle to the IRelationalTransactionMgr (shared ownership)
    boost::shared_ptr<IRelationalTransactionMgr> m_transactionMgr;

  };

} // namespace

#endif

#endif
