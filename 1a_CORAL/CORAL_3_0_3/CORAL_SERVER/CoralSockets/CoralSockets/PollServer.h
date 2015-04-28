#ifndef CORALSOCKETS_POLLSERVER_H
#define CORALSOCKETS_POLLSERVER_H 1

// Include files
#include <map>

#include "CoralServerBase/IRequestHandlerFactory.h"
#include "CoralBase/../src/coral_thread_headers.h"
#include "CoralSockets/GenericSocketException.h"

namespace coral {

  // Forward declaration
  class IThreadMonitor;

  namespace CoralSockets {

    // Forward declaration
    class ThreadManager;
    class ServerContext;

    /** @class PollServer PollServer.h
     *
     *  @author Andrea Valassi and Martin Wache
     *  @date   2009-12-3
     *///

    class PollServer
    {
    public:

      virtual ~PollServer();

      /// you have to make sure, that the handler is valid over the lifetime
      /// of the SocketServer
      PollServer( coral::IRequestHandlerFactory& handlerFactory,
                  const std::string& host,
                  int port,
#ifdef HAVE_OPENSSL
                  const std::string& shost,
                  int sport,
#endif
                  int nHandlerThreads=20 );

      /// main loop of socket server
      /// if timeout > 0 the server will shutdown after timeout seconds
      /// with no new connection
      void run( int timeout=-1 );

      /// signal the server to stop
      void stopServer();

      /// get the thread monitor for this socket server
      const IThreadMonitor* threadMonitor() const;

    private:

      /// Standard constructor is private
      PollServer();

      /// if false, the server will shut down
      bool m_isActive;

      /// the request handler factory which is used to produce
      /// request handler for a new connection
      coral::IRequestHandlerFactory& m_handlerFactory;

      /// connection details
      std::string m_host;
      int m_port;
#ifdef HAVE_OPENSSL
      std::string m_shost;
      int m_sport;
#endif
      int m_nHandlerThreads;

      /// a thread manager
      std::auto_ptr<ThreadManager> m_thrManager;

      /// server context
      std::auto_ptr<ServerContext> m_serverCtx;

    };

  }

}
#endif
