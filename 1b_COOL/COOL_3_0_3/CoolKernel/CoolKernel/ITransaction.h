#ifndef COOLKERNEL_ITRANSACTION_H
#define COOLKERNEL_ITRANSACTION_H 1

// First of all, enable or disable the COOL290 API extensions (see bug #92204)
#include "CoolKernel/VersionInfo.h"

// This class only exists in the COOL400 API
#ifdef COOL400

namespace cool
{

  /** @file ITransaction.h
   *
   * Transaction interface for manual transaction handling.
   *
   * @author Sven A. Schmidt
   * @date 2008-06-29
   *///

  class ITransaction
  {

  public:

    virtual ~ITransaction() {}

    /// Commit the transaction
    virtual void commit() = 0;

    /// Rollback the transaction
    virtual void rollback() = 0;

#ifdef COOL290CO
  private:

    /// Assignment operator is private (see bug #95823)
    ITransaction& operator=( const ITransaction& rhs );
#endif

  };

}

#endif // COOL400

#endif // COOLKERNEL_ITRANSACTION_H
