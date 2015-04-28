#ifndef CORALCOMMON_IDEVCONNECTION_H
#define CORALCOMMON_IDEVCONNECTION_H 1

#include <set>
#include "CoralBase/../src/coral_thread_headers.h"
#include "CoralCommon/IConnection.h"

namespace coral {

  class IDevSession;

  class IDevConnection : public IConnection
  {
  public:
    /// Deregisters a session. This method is called at the destructor of IDevSession.
    void deregisterSession( IDevSession* session );

    /// Registers a new IDevSession object. This method is called by the constructor of IDevSession.
    void registerSession( IDevSession* session );

    /// The current size of the session pool
    size_t size() const;

  protected:
    /// Constructor. Initializes the session pool
    IDevConnection();

    /// Destructor. Invalidates all active sessions and cleans up the session pool
    virtual ~IDevConnection();

    /// Invalidates all active sessions
    void invalidateAllSessions();

  private:
    /// The sessions
    std::set< IDevSession* > m_sessions;

    /// The mutex protecting the session pool
    mutable coral::mutex m_mutex;
  };

}

#endif
