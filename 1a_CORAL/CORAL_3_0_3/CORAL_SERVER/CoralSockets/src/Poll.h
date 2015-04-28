#ifndef CORALSOCKETS_POLL_H
#define CORALSOCKETS_POLL_H 1

#include <boost/shared_ptr.hpp>

#include "ISocket.h"

namespace coral {

  namespace CoralSockets {

    // forward definition
    class PollFDs;

    class Poll  {
    public:
      enum PMode {
        P_READ,
        P_WRITE,
        P_READ_WRITE
      };


      /// a class which polls the state of severall ISockets
      ///
      /// NOT THREAD SAFE!
      Poll(unsigned int maxFDs=5000);

      virtual ~Poll();

      /// add a socket to poll call
      void addSocket( const ISocketPtr& Socket, PMode mode );

      /// remove a socket from the poll call
      void removeSocket( const ISocketPtr& Socket );

      /// polls all previously added sockets and returns
      /// the number of sockets which are ready for the
      /// requested operations.
      /// Iterate over the sockets with getNextReadySocket.
      int poll( int timeout );

      /// returns the next socket which is ready for
      /// an operation.
      /// Throws if there is no next socket.
      const ISocketPtr& getNextReadySocket();

      bool currSocketClosed();

    protected:

      /// wrapper class to handle array of struct pollfd
      std::auto_ptr<PollFDs> m_pollFD;

      /// current socket (for getNextReadySocket() )
      int m_currentSocket;

      /// how many sockets are ready for an operation
      int m_maxReadySockets;

    };
  }
}

#endif // CORALSOCKETS_TCPSOCKET_H
