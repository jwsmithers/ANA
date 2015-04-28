#ifndef CORALSERVER_TOKENGENERATOR_H
#define CORALSERVER_TOKENGENERATOR_H 1

// Include files
#include "CoralBase/../src/coral_thread_headers.h"
#include "CoralServer/ITokenPool.h"

namespace coral
{

  namespace CoralServer
  {

    /** @class TokenGenerator
     *
     *  Simple implementation of a pool of Token's.
     *  The generated Token's are globally unique within the pool.
     *
     *  @author Andrea Valassi
     *  @date   2009-03-02
     *///

    class TokenGenerator : virtual public ITokenPool
    {

    public:

      /// Constructor.
      TokenGenerator() : m_guid( 0 ), m_mutex() {}

      /// Destructor.
      virtual ~TokenGenerator(){}

      /// Allocate (or generate) a Token from the pool.
      /// The implementation of this method must be thread-safe.
      Token allocateToken()
      {
        coral::lock_guard lock( m_mutex );
        return ++m_guid;
      }

      /// Release a Token previously allocated from the pool.
      /// The implementation of this method must be thread-safe.
      /// In some implementations the Token may then be reused (no guarantee).
      void releaseToken( Token /*token*/ )
      {
        // DO NOTHING...
      }

    private:

      // Globally Unique ID counter
      Token m_guid;

      /// The mutex lock
      coral::mutex m_mutex;

    };

  }

}
#endif // CORALSERVER_TOKENGENERATOR_H
