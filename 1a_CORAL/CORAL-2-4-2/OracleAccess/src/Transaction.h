#ifndef ORACLEACCESS_TRANSACTION_H
#define ORACLEACCESS_TRANSACTION_H 1

#include <boost/shared_ptr.hpp>
#include "CoralBase/../src/coral_thread_headers.h"
#include "RelationalAccess/ITransaction.h"

struct OCITrans;

namespace coral
{

  namespace OracleAccess
  {

    class SessionProperties;
    class ITransactionObserver;

    /**
     * Class Transaction
     * Implementation of the ITransaction interface for the OracleAccess plugin
     *///
    class Transaction : virtual public coral::ITransaction
    {
    public:
      /// Constructor
      Transaction( boost::shared_ptr<const SessionProperties> properties,
                   ITransactionObserver& observer );

      /// Destructor
      virtual ~Transaction();

      /**
       * Starts a new transaction.
       * In case of failure a TransactionNotStartedException is thrown.
       *
       *///
      void start( bool readOnly = false );

      /**
       * Commits the transaction.
       * In case of failure a TransactionNotCommittedException is thrown.
       *///
      void commit();

      /**
       * Aborts and rolls back a transaction.
       *///
      void rollback();

      /**
       * Returns the status of the transaction (if it is active or not)
       *///
      bool isActive() const;

      /**
       * Returns the mode of the transaction (read-only or not)
       *///
      bool isReadOnly() const;

      /**
       * Returns the mode of RO transactions (serializable or not)
       *///
      bool isSerializableIfRO() const
      {
        return m_isSerializableIfRO;
      }

      /// Mark the session as deleted ("nullify" session - bug #73834)
      /// [NB "invalidate" is used in IDevSession for connection sharing]
      void nullifySession(); // fix bug #80092

      /// Initialize this transaction because the user session has started
      /// (previously this is when the transaction was created - bug #80174)
      void startUserSession( bool isSerializableIfRO = true );

      /// Finalize this transaction because the user session has ended
      /// (previously this is when the transaction was deleted - bug #80174)
      void endUserSession();

    private:

      /// Allocates the necessary handles
      /// (NB const because it does NOT modify m_ociTransHandle)
      OCITrans* allocateOCIHandles() const;

      /// Releases the handles
      /// (NB const because it does NOT modify m_ociTransHandle)
      void releaseOCIHandles( OCITrans* ociTransHandle ) const;

    private:

      /// The session properties
      boost::shared_ptr<const SessionProperties> m_sessionProperties;

      /// The transaction observer
      ITransactionObserver& m_observer;

      /// Flag indicating whether RO transactions are serializable
      bool m_isSerializableIfRO;

      /// The OCI transaction handle
      OCITrans* m_ociTransHandle;

      /// Flag indicating whether a transaction is read-only
      bool m_isReadOnly;

      /// The mutex lock
      mutable coral::mutex m_mutex;

      /// Has the session been nullified?
      bool m_nullifiedSession; // fix bug #80092

      /// Has the user session started/ended?
      bool m_userSessionStarted; // related to bug #80174

    };

  }

}
#endif
