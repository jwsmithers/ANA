#ifndef CORALSOCKETS_CONNECTIONMANAGER_H
#define CORALSOCKETS_CONNECTIONMANAGER_H 1

// Include files
#include <map>

#include "SocketContext.h"

namespace coral {

  namespace CoralSockets {
    // forward declaration
    class SocketContext;

    /**
     *
     * Class ConnectionManager
     *
     * Used to match secure and data channel together by
     * exchanging uint32_t tokens
     *
     *///

    typedef uint32_t ConToken;

    class ConnectionManager {
    public:
      ConnectionManager();

      virtual ~ConnectionManager();

      /// adds the context to the map, and returns a unique,
      /// pseudo random token by which the context can be fetched
      ConToken addContext( SocketContextSPtr context);

      /// returns the context corresponding to the token and
      /// removes the context from the map
      SocketContextSPtr getContext( ConToken token );

    private:

      ConToken createToken();

      coral::mutex m_connectionMapMutex;

      std::map<ConToken,boost::shared_ptr<SocketContext> > m_connectionMap;
    };
  }
}
#endif
