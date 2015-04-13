#ifndef CORALKERNEL_REFCOUNTED_H
#define CORALKERNEL_REFCOUNTED_H 1

// First of all, set/unset CORAL240, CORAL300 and CORAL_HAS_CPP11 macros
#include "CoralBase/VersionInfo.h"

// Replace Boost by c++11 in the CORAL3 API (task #49014)
#ifdef CORAL300CPP11
#include <mutex>
#else
#include "CoralBase/boost_thread_headers.h"
#endif

namespace coral
{

  // A reference counted class
  class RefCounted
  {
  public:

    /// Increments the reference counter
    void addReference()
    {
#ifdef CORAL300CPP11
      std::lock_guard<std::mutex> lock( m_mutex );
#else
      boost::mutex::scoped_lock lock( m_mutex );
#endif
      ++m_referenceCounter;
    }

    /// Decrements the reference counter
    int removeReference()
    {
      int result = 0;
      {
#ifdef CORAL300CPP11
        std::lock_guard<std::mutex> lock( m_mutex );
#else
        boost::mutex::scoped_lock lock( m_mutex );
#endif
        if ( m_referenceCounter == 0 ) return result;
        --m_referenceCounter;
        result = m_referenceCounter;
      }
      if ( m_referenceCounter == 0 )
        delete this;
      return result;
    }

  protected:

    /// Constructor. Initializes the reference count to 1.
    RefCounted() :
      m_mutex(),
      m_referenceCounter( 1 )
    {}

    /// Protected destructor
    virtual ~RefCounted() {}

  private:

    /// No copy constructor
    RefCounted( const RefCounted& );

    /// No assignment operator
    RefCounted& operator=( const RefCounted& );

  private:

    /// The mutex lock for the reference counter
#ifdef CORAL300CPP11
    std::mutex m_mutex;
#else
    boost::mutex m_mutex;
#endif

    /// Reference counter
    int m_referenceCounter;

  };

}
#endif
