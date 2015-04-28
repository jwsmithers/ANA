
// Include files
#include <iostream>
#include <sstream>
#include "CoralSockets/PollServer.h"
#include "CoralSockets/NonFatalSocketException.h"

// Local include files
#include "ThreadManager.h"
#include "SocketContext.h"
#include "ServerContext.h"
#include "TcpSocket.h"
#ifdef HAVE_OPENSSL
#include "SslSocket.h"
#endif
#include "PacketSocket.h"

// Namespace
using namespace coral::CoralSockets;

#define LOGGER_NAME "CoralSockets::PollServer"
#include "logger.h"

#undef DEBUG
#define DEBUG( out )

class WorkerThread : public Runnable
{
public:
  WorkerThread( ServerContext *ctx )
    : m_ctx(ctx)
  {
    DEBUG("Enter WorkerThread: "<< this);
  };

  /// signal the thread that it should end
  virtual void endThread()
  {};

  /// this method is the main method of the thread
  virtual void operator()()
  {
    while ( m_ctx->doWork() )
      DEBUG("WorkerThread end loop " << this);
  };

  // return a description of the thread
  const std::string desc() const
  {
    return "WorkerThread";
  };

  // destructor
  virtual ~WorkerThread()
  {
    DEBUG("WorkerThread shutting down: "<< this);
  };

private:
  ServerContext * m_ctx;

};

//-----------------------------------------------------------------------------

PollServer::PollServer( coral::IRequestHandlerFactory& handlerFactory,
                        const std::string& host,
                        int port,
#ifdef HAVE_OPENSSL
                        const std::string& shost,
                        int sport,
#endif
                        int nHandlerThreads )
  : m_isActive(true)
  , m_handlerFactory( handlerFactory )
  , m_host( host )
  , m_port( port )
#ifdef HAVE_OPENSSL
  , m_shost( shost )
  , m_sport( sport )
#endif
  , m_nHandlerThreads( nHandlerThreads )
  , m_thrManager( new ThreadManager() )
  , m_serverCtx( 0 )
{
  INFO("Create PollServer on host " << host << " and port " << port);
  if (!nHandlerThreads)
    throw GenericSocketException( "Invalid # handler threads" );
}

//-----------------------------------------------------------------------------

PollServer::~PollServer()
{
  INFO("Delete PollServer");
}

//-----------------------------------------------------------------------------

const coral::IThreadMonitor* PollServer::threadMonitor() const
{
  return m_thrManager.get();
}

//-----------------------------------------------------------------------------

void PollServer::stopServer()
{
  m_isActive=false;
  if ( m_serverCtx.get() != 0 )
    m_serverCtx->stopServer();
}

//-----------------------------------------------------------------------------

void PollServer::run( int timeout ) {
  INFO("Open listening  socket on host " << m_host << " and port " << m_port);
#ifdef HAVE_OPENSSL
  SslSocketPtr slisten;
  if (m_sport>0 && !m_shost.empty() )
    slisten=SslSocket::listenOn( m_shost, m_sport );
#endif
  TcpSocketPtr listen=TcpSocket::listenOn( m_host, m_port );

  m_serverCtx = std::auto_ptr<ServerContext>(
                                             new ServerContext(m_handlerFactory, listen,
#ifdef HAVE_OPENSSL
                                                               slisten,
#endif
                                                               timeout ) );

  for (int i = 0; i< m_nHandlerThreads; i++)
    m_thrManager->addThread( new WorkerThread( m_serverCtx.get() ) );

  while ( m_isActive && m_serverCtx->isActive()  ) {
    m_thrManager->housekeeping();
    sleep( 1 );
  };
  INFO( "Close the server socket");
  listen->close();

  INFO("Waiting for client connections to terminate:");

  m_thrManager->joinAll();

  INFO("All client connections are closed");
  INFO("Shutdown the server");
}

//-----------------------------------------------------------------------------
