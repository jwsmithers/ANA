#ifndef CORALSOCKETS_SOCKETCONTEXT_H
#define CORALSOCKETS_SOCKETCONTEXT_H 1

#include "boost/shared_ptr.hpp"
#include "CoralServerBase/IRequestHandler.h"
#include "CoralServerBase/IThreadMonitor.h"
#include "CoralBase/../src/coral_thread_headers.h"

#include "PacketSocket.h"
#include "RequestIterator.h"

namespace coral {

  namespace CoralSockets {

    // forward declaration
    class ConnectionManager;
    class SocketContext;

    typedef boost::shared_ptr<SocketContext> SocketContextSPtr;

    class SocketContext {

    private:

      // copy constructor and assignment operator are private
      SocketContext( const SocketContext& rhs );
      SocketContext& operator=( const SocketContext& );

    public:
      /// one SocketContext instance per socket
      ///
      /// Handles all the requests which are send over one socket
      ///
      SocketContext( coral::IRequestHandler* handler,
                     PacketSocketPtr cSocket,
                     bool isSecure=false );

      virtual ~SocketContext();


      /// methods for getting/setting the request handler.
      /// needed for binding data and secure channel
      boost::shared_ptr<coral::IRequestHandler> getHandler() const;

      void setHandler( boost::shared_ptr<coral::IRequestHandler> handler );

      /// send packets over the socket
      ///
      /// thread safe
      void send( const PacketSLAC& packet );

      /// will try to lock the read mutex,
      /// a scoped lock is returned in any case
      /// _you_ have to make sure that locking succeded by
      /// checking owns_lock()!
      std::auto_ptr<coral::unique_lock>
      tryLockReadMutex();

      /// get new incomming request
      ///
      /// the caller has to make sure that the read mutex is locked!
      /// See tryLockReadMutex()!
      PacketPtr getNextRequest( );

      /// Handle request passed to it
      /// and send back the reply. May sleep, and is threadsafe
      void handleRequest( PacketPtr requestPacket );

      bool isActive() const
      {
        return m_isActive;
      }

      void closeSocket()
      {
        m_isActive=false;
        m_cSocket->close();
      }

      /// get socket description
      const std::string& desc() const
      {
        return m_cSocket->desc();
      }

      bool isSecure() const
      {
        return m_isSecure;
      }

      /// sets or overrides the connection properties
      /// use this method to setup a new token
      void setConnectionProperties( uint32_t token );

    private:

      /// Standard constructor is private
      SocketContext();

      // mutex for sending
      coral::mutex m_mutexForSend;
      /// the request handler for this socket
      boost::shared_ptr<coral::IRequestHandler> m_handler;

      PacketSocketPtr m_cSocket;

      const std::string m_cHost;

      coral::mutex m_mutexForRead;


      /// map for storing multi segment requests
      std::map<int,RequestIterator*> m_requestMap;
      coral::mutex m_mutexForRequestMap;

      bool m_isActive;

      /// true if we are using a secure channel
      bool m_isSecure;

    };

  }
}

#endif //CORALSOCKETS_SOCKETTHREAD_H
