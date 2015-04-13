// $Id: ServerContext.h,v 1.4.2.2 2012-06-07 12:19:57 avalassi Exp $
#ifndef CORALSOCKETS_SERVERCONTEXT_H
#define CORALSOCKETS_SERVERCONTEXT_H 1

#include "CoralServerBase/IRequestHandlerFactory.h"
#include "CoralBase/../src/coral_thread_headers.h"

#include "ConnectionManager.h"
#include "ISocket.h"
#include "Poll.h"
#ifdef HAVE_OPENSSL
#include "SslSocket.h"
#endif
#include "TcpSocket.h"

namespace coral {

  namespace CoralSockets {

    // forward declaration
    class SocketContext;

    class ServerContext {

    private:

      // copy constructor and assignment operator are private
      ServerContext( const ServerContext& rhs );
      ServerContext& operator=( const ServerContext& );

    public:

      virtual ~ServerContext() {}

      /// one ServerContext instance per server instance
      ///
      ///
      /// Takes the listening socket as parameter
      ServerContext( coral::IRequestHandlerFactory& handlerFactory,
                     TcpSocketPtr lSocket,
#ifdef HAVE_OPENSSL
                     SslSocketPtr sSocket,
#endif
                     int timeout );

      /// tells the server to stop
      void stopServer()
      { m_isActive=false; };

      bool isActive()
      { return m_isActive; };

      /// doWork()
      /// "Main-Loop" of a server. May be called by several threads at once.
      /// doWork() checks for events on all sockets, and handles them.
      /// If doWork() returns false, the server will shut down and the threads
      /// should quit.
      bool doWork();

    private:

      /// Standard constructor is private
      ServerContext();

      // to be called with m_mutexForPoll held
      void closeConnection( const ISocketPtr& socket );

      // to be called with m_mutexForPoll held
      void acceptConnection();

      // to be called with m_mutexForPoll held
      void acceptSecureConnection();

      bool doWorkOnContext( boost::shared_ptr<SocketContext> &ctx,
                            std::auto_ptr<coral::unique_lock> & readLock );

      void handleControlMsg( SocketContextSPtr& ctx,
                             PacketPtr ctlPacket );

      coral::IRequestHandlerFactory& m_handlerFactory;

      TcpSocketPtr m_lSocket;
#ifdef HAVE_OPENSSL
      SslSocketPtr m_slSocket;
#endif

      coral::mutex m_mutexForPoll;
      Poll m_poll;
      int m_sockets_ready;
      int m_busyReadMutexes;

      ConnectionManager m_conMgr;

      /// false if this server should shut down
      bool m_isActive;

      /// timeout after which we shut down
      int m_timeout;

    };
  }
}

#endif //CORALSOCKETS_SERVERCONTEXT_H
