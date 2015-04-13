// $Id: ServerContext.cpp,v 1.9.2.4 2013-01-01 18:11:11 avalassi Exp $

//#if 0

// Include files
#include "CoralSockets/GenericSocketException.h"
#include "CoralSockets/NonFatalSocketException.h"

// Local include files
#include "ControlMsg.h"
#include "PacketSocket.h"
#include "ServerContext.h"
#ifdef HAVE_OPENSSL
#include "SslSocket.h"
#endif
#include "SocketContext.h"
#include "TcpSocket.h"

// Logger
#define LOGGER_NAME "CoralSockets::ServerContext"
#include "logger.h"

// Debug
#undef DEBUG
#define DEBUG(out)

// Namespace
using namespace coral::CoralSockets;

//-----------------------------------------------------------------------------

ServerContext::ServerContext( coral::IRequestHandlerFactory& handlerFactory,
                              TcpSocketPtr lSocket,
#ifdef HAVE_OPENSSL
                              SslSocketPtr slSocket,
#endif
                              int timeout )
  : m_handlerFactory( handlerFactory )
  , m_lSocket( lSocket )
#ifdef HAVE_OPENSSL
  , m_slSocket( slSocket )
#endif
  , m_poll()
  , m_sockets_ready( 0 )
  , m_busyReadMutexes( 0 )
  , m_conMgr()
  , m_isActive( true )
  , m_timeout( timeout )
{
  INFO("Create ServerContext ");
  m_poll.addSocket( m_lSocket, Poll::P_READ );
#ifdef HAVE_OPENSSL
  if ( m_slSocket.get() != 0 )
    m_poll.addSocket( m_slSocket, Poll::P_READ );
#endif
}

//-----------------------------------------------------------------------------

void ServerContext::closeConnection( const ISocketPtr& socket )
{
  INFO("Removing socket '" << socket->desc() << "' from poll");
  // remove context from socket
  socket->setSContext( boost::shared_ptr<SocketContext>( (SocketContext*)0 ) );
  m_poll.removeSocket( socket );
  m_sockets_ready = 0; // restart poll iterator
}

//-----------------------------------------------------------------------------

void ServerContext::acceptConnection()
{
  try
  {
    INFO("Accepting new connection");
    ISocketPtr socket( m_lSocket->accept() );
    PacketSocketPtr cSocket( new PacketSocket( socket ) );
    SocketContext *sContext =
      new SocketContext( m_handlerFactory.newRequestHandler(),
                         cSocket );
    socket->setSContext( boost::shared_ptr<SocketContext>( sContext) );
    m_poll.addSocket( socket, Poll::P_READ );
    m_sockets_ready = 0; // restart poll iterator. Not really needed?
    INFO("Accepted new connection from "<< socket->remoteEnd() );
  }
  catch (NonFatalSocketException &e) {
    INFO("Caught non fatal exception during accept: " << e.what());
  }
  catch (GenericSocketException &e) {
    ERROR("Caught exception during accept: " << e.what());
  };
}

//-----------------------------------------------------------------------------

void ServerContext::acceptSecureConnection()
{
#ifdef HAVE_OPENSSL
  try {
    INFO("Accepting new secure connection");
    ISocketPtr socket( m_slSocket->accept() );
    PacketSocketPtr cSocket( new PacketSocket( socket ) );
    SocketContext *sContext =
      new SocketContext( m_handlerFactory.newRequestHandler(),
                         cSocket,
                         true /*isSecure*/ );
    socket->setSContext( boost::shared_ptr<SocketContext>( sContext) );
    m_poll.addSocket( socket, Poll::P_READ );
    m_sockets_ready = 0; // restart poll iterator. Not really needed?
    INFO("Accepted new secure connection from "<< socket->remoteEnd() );
  }
  catch( NonFatalSocketException& e )
  {
    INFO("Caught non fatal exception during accept: " << e.what());
  }
  catch( GenericSocketException& e )
  {
    ERROR("Caught exception during accept: " << e.what());
  };
#endif
}

//-----------------------------------------------------------------------------

bool ServerContext::doWork()
{
  // this is the main loop of the server. All threads will
  // try to run it concurrently, the idle threads will be waiting
  // for mutexForPoll
  coral::unique_lock pollLock(m_mutexForPoll);
 restart:
  int tries = 0;
  bool pollCalled = false;
  // poll until sockets are ready or server shuts down
  while ( m_sockets_ready == 0 && m_isActive )
  {
    DEBUG("calling poll :"<< m_busyReadMutexes);
    m_sockets_ready = m_poll.poll( 500 );
    pollCalled=true;
    tries++;
    if ( m_timeout>0 && tries>m_timeout*2 )
    {
      // no events in timeout seconds -> shut down
      stopServer();
      return false;
    };
  }
  if ( pollCalled )
  {
    // poll has just been called
    if ( m_busyReadMutexes == m_sockets_ready )
    {
      // during the last poll iterator round we found as many
      // busy (mutex locked) sockets as we have now ready.
      // To avoid a possible busy loop, we sleep a while
      // and try again after that.
      usleep(10000);
      m_busyReadMutexes=0;
      DEBUG("busyReadMutexes equals ready sockets, sleeping");
      goto restart;
    };
    m_busyReadMutexes = 0;
  };
  // there are some sockets which are ready, check them
  while ( m_sockets_ready > 0 )
  {
    m_sockets_ready--;
    const ISocketPtr& socket_ref( m_poll.getNextReadySocket() );
    if ( m_poll.currSocketClosed() || !socket_ref->isOpen() )
      closeConnection( socket_ref );
    else if ( socket_ref.get() == m_lSocket.get() )
      acceptConnection();
#ifdef HAVE_OPENSSL
    else if ( socket_ref.get() == m_slSocket.get() )
      acceptSecureConnection();
#endif
    else {
      // found a socket ready to read
      // now check if an other thread is already reading
      // by trying to lock the mutex (should not happen that often)
      // try to lock the read mutex
      std::auto_ptr<coral::unique_lock>
        readLock( socket_ref->getSContext()->tryLockReadMutex() );
      if ( !readLock->owns_lock() )
      {
        // This thread failed to lock the mutex, another thread is already
        // reading data. Go on to the next ready socket.
        // FIXME: Possible busy loop, if there is only one socket ready and
        // one thread is already reading. Then another thread will continuosly
        // poll and try to lock this mutex -> busy loop (but only as long
        // as the other thread reads...)
        // Possible fix: temporarily disable the poll on the sockets
        // where a thread is reading. -> locking nightmare
        DEBUG("found a socket ready to read, but coudn't lock read mutex");
        m_busyReadMutexes++;
        continue;
      }
      // we got the read lock:
      // take copies of the shared pointers, to make sure they
      // can't get out of scope
      boost::shared_ptr<SocketContext> ctx( socket_ref->getSContext() );
      ISocketPtr socket( socket_ref );
      // release the poll lock and start handling
      // requests from "our" socket
      pollLock.unlock();
      //--------------------------------------------------------------------
      // from this point on, we have to leave the method, or
      // we have to relock the pollLock!
      DEBUG( "handling requests on socket " << ctx->desc()
             << " secure " << ctx->isSecure() );
      doWorkOnContext( ctx, readLock );
      // explicitly delete readLock, to make shure we don't have any
      // references to readMutex any more, or it might race with
      // the deletion of a SocketContext on socket closing.
      readLock = std::auto_ptr<coral::unique_lock>(
                                                          (coral::unique_lock *) 0);
      // we released the pollLock, that means we can't access poll any more.
      // The best is just to leave the method and try again
      return m_isActive;
    }
  }
  // if we get here, we still own the pollLock and no sockets are ready. Rather
  // than leaving this method and releasing the pollLock
  // we just restart and try again.
  if (m_isActive)
    goto restart;
  return m_isActive;
}

//-----------------------------------------------------------------------------

bool
ServerContext::doWorkOnContext( boost::shared_ptr<SocketContext>& ctx,
                                std::auto_ptr<coral::unique_lock>& readLock )
{
  try
  {
    // we have a SocketContext and a read lock which owns the mutex.
    // Lets do some work on the socket :-)
    PacketPtr packet = ctx->getNextRequest();
    // finished reading -> release the read lock
    readLock->unlock();
    if ( packet.get() == 0 )
      // false positive from poll, or the socket has been closed
      // Leave this method and look for a new socket to work on.
      return m_isActive;

    if ( ControlMsg::isSocketsCtlMessage( packet->getPayload() ) )
    {
      handleControlMsg( ctx, packet );
      return m_isActive;
    }

    ctx->handleRequest( packet );
    // we just finished one request, check if there are more (just in case),
    // while the cache is still hot ;-)
    // But only if we can lock the read lock
    DEBUG("just handled one packet, see if there are more packets");
    while ( readLock->try_lock() && ctx->isActive() )
    {
      // we succeded to lock read mutex
      // try to get an request
      packet = ctx->getNextRequest();
      // release the readLock
      readLock->unlock();
      if ( packet.get() == 0)
        // no new packet, or socket has been closed. We leave this socket
        // and try to get another one
        return m_isActive;
      DEBUG("handling additional packet");
      ctx->handleRequest( packet );
    }
    // if we got here, we failed to lock the read lock on "our"
    // socket. Leave this method and look for a new socket to work on.
    return m_isActive;
  }
  catch ( std::exception& e )
  {
    ERROR( "( " << ctx->desc() << " ) EXCEPTION CAUGHT: " << e.what()
           << " - CLOSE THE SOCKET" );
    ctx->closeSocket();
  }
  catch ( ... )
  {
    ERROR( "( " << ctx->desc()
           << " ) UNKNOWN EXCEPTION CAUGHT - CLOSE THE SOCKET" );
    ctx->closeSocket();
  }
  return m_isActive;
}

//-----------------------------------------------------------------------------

void ServerContext::handleControlMsg( SocketContextSPtr& ctx,
                                      PacketPtr ctlPacket )
{
  try
  {
    DEBUG("got a sockets control message");

    ControlMsg cmsg( ctlPacket->getPayloadPointer() );

    if ( cmsg.getControl() == ControlCodes::RequestBind )
    {
      DEBUG("got ctl 'requestBind'" );
#if 0
      // FIXME locking? FIXME reactivate!
      if ( m_cSocket->getRecPackets() != 1 )
      {
        ERROR("received 'RequestBind' after receiving other packets!");
        closeSocket();
        return;
      };
#endif
      uint32_t token = m_conMgr.addContext( ctx );
      // Ste the current token to the socket context
      ctx->setConnectionProperties( token );

      ByteBufferPtr msg = ControlMsg::okRequestBindMsg( token );

      PacketSLAC packet( ctlPacket->getHeader().requestID() /* requestID */,
                         0 /*semgentNo*/,
                         ctlPacket->getHeader().clientID() /*clientID*/,
                         false /* more segments*/,
                         *msg );

      DEBUG("sending request bind ok reply with token "<< token );
      ctx->send( packet );
    }
    else if ( cmsg.getControl() == ControlCodes::Bind )
    {
      DEBUG("got ctl request 'bind' to token " << cmsg.getToken() );
      // to bind a data context we overwrite the request handler
      // of the data channel with the one of the secure channel
      // FIXME! make this secure, or write into the docu, that
      // this is not safe!
      if ( ctx->isSecure() )
      {
        SocketContextSPtr dataCtx = m_conMgr.getContext( cmsg.getToken() );
        dataCtx->setHandler( ctx->getHandler() );

        ByteBufferPtr msg = ControlMsg::okBindMsg( );
        PacketSLAC packet( ctlPacket->getHeader().requestID() /* requestID */,
                           0 /*semgentNo*/,
                           ctlPacket->getHeader().clientID() /*clientID*/,
                           false /* more segments*/,
                           *msg );
        DEBUG("sending 'bind ok' reply");
        ctx->send( packet );
      }
      else // not the secure channel
      {
        // for the data channel, we just check that the secure
        // channel also requested a bind
        // FIXME! make this secure, or write into the docu, that
        // this is not safe!
        m_conMgr.getContext( cmsg.getToken() );

        ByteBufferPtr msg = ControlMsg::okBindMsg( );
        PacketSLAC packet( ctlPacket->getHeader().requestID() /* requestID */,
                           0 /*semgentNo*/,
                           ctlPacket->getHeader().clientID() /*clientID*/,
                           false /* more segments*/,
                           *msg );
        DEBUG("sending 'bind ok' reply");
        ctx->send( packet );
      }
    }
    else
      throw GenericSocketException("Unhandled control message!",
                                   "SocketContext::handleControlMsg");
  }
  catch( GenericSocketException& e ) {
    ERROR("caught exception '" << e.what() << "'. Closing socket.");
    ctx->closeSocket();
    throw;
  }
}
