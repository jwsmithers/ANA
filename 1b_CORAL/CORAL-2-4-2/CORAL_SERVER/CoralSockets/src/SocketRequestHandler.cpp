// $Id: SocketRequestHandler.cpp,v 1.13.2.4.2.4 2013-02-08 09:40:09 avalassi Exp $

// Include files
#include <iostream>

// Local include files
#include "ControlMsg.h"
#include "PacketSocket.h"
#include "ReplyManager.h"
#include "SocketRequestHandler.h"
#include "ThreadManager.h"

// Logger
#define LOGGER_NAME "CoralSockets::SocketRequestHandler"
#include "logger.h"

//-----------------------------------------------------------------------------

namespace coral
{
  namespace CoralSockets
  {
    /// a class which does the receiving of packets in an own thread
    class SocketRequestHandler::ReceiveThread : public Runnable
    {
    public:

      ReceiveThread( SocketRequestHandler *parent,
                     const PacketSocketPtr & socket,
                     ReplyManager& rplMngr,
                     bool isSecure )
        : m_parent( parent)
        , m_Socket( socket )
        , m_rplMngr( rplMngr )
        , m_socketOpen( true )
        , m_isSecure( isSecure )
      {
        DEBUG("socketRequestHandler::ReceiveThread constructor");
      }

      virtual ~ReceiveThread()
      {
        DEBUG("socketRequestHandler::ReceiveThread destructor");
      }

      /// the main loop of the thread
      void operator()();

      /// tell the recieve thread that the socket is going to be closed
      void endThread()
      {
        m_socketOpen = false;
      }

      /// thread description
      const std::string desc() const
      {
        return std::string("Receiver Thread ")+m_Socket->desc();
      }

      void handleControlMsg( PacketPtr msg );

    private:

      SocketRequestHandler* m_parent;

      /// the socket which is used to receive data
      const PacketSocketPtr& m_Socket;

      /// storage container for the waiting requests
      ReplyManager& m_rplMngr;

      /// true while the socket is open
      /// if false, the recieve thread will end
      bool m_socketOpen;

      /// true when the receive thread is using a secure channel
      bool m_isSecure;
    };

  }
}

//-----------------------------------------------------------------------------

// Namespace
using namespace coral::CoralSockets;

//-----------------------------------------------------------------------------

void SocketRequestHandler::ReceiveThread::handleControlMsg( PacketPtr packet )
{
  DEBUG("got control message");

  ControlMsg msg( packet->getPayloadPointer() );

  if ( msg.getControl() == ControlCodes::RequestBind )
  {
    DEBUG("got requestBind reply "<< msg.getToken() << " isSecure: " << m_isSecure );
    m_parent->setToken( m_isSecure, msg.getToken() );
  }
  else if ( msg.getControl() == ControlCodes::Bind )
  {
    DEBUG("got bind reply "<< msg.getToken() << " isSecure: " << m_isSecure );
    m_parent->setToken( m_isSecure, 0 );
  };
}

//-----------------------------------------------------------------------------

// the main loop of the receiver thread
void SocketRequestHandler::ReceiveThread::operator()()
{
  DEBUG( "SocketRequestHandler::ReceiveThread main loop started" );
  while ( m_socketOpen )
  {
    try
    {
      PacketPtr packet( m_Socket->receivePacket() );

      if ( ControlMsg::isSocketsCtlMessage( packet->getPayload() ) )
      {
        handleControlMsg( packet );
        continue;
      };

      const int requestID = packet->getHeader().requestID();
      DEBUG("Got reply to request #" << requestID );
      static int csdebug = -1; //AV
      if ( csdebug == -1 )
        csdebug = ( getenv ( "CORALSOCKETS_DEBUG" ) ? 1 : 0 );  //AV
      if ( csdebug > 0 )
        std::cout << "Got reply to request #" << requestID << std::endl;  //AV

      // find sleeper slot
      ReplySlot &slot = m_rplMngr.findSlot( requestID );

      // put reply and wake up the sleeper!
      slot.appendReply( packet->getPayloadPointer(),
                        packet->getHeader().segmentNumber(),
                        !packet->getHeader().moreSegments() /* isLast */ );

    }
    catch( SocketClosedException& )
    {
      INFO("The socket has been closed. Stopping threads.");
      m_socketOpen = false;
      break;
    }
    catch( std::exception& e )
    {
      ERROR("ERROR! Standard C++ exception: '" << e.what() << "'");
      break;
    }
    catch( ... )
    {
      ERROR("ERROR! Unknown exception caught");
      break;
    }
  }

  // notify waiting threads that the socket has been closed
  m_rplMngr.close();

  INFO("SocketRequestHandler::ReceiveThread main loop ended");
}

//-----------------------------------------------------------------------------

void
SocketRequestHandler::setConnectionProperties( coral::ConnectionPropertiesConstPtr /*prop*/ )
{
  // Not needed - the SslSocket loads the certificate itself
}

//-----------------------------------------------------------------------------

coral::IByteBufferIteratorPtr
SocketRequestHandler::replyToRequest( coral::IByteBufferIteratorPtr requestItr,
                                      const RequestProperties& props )
{
  ReplySlot& slot = send( *requestItr, props.useSecureChannel );
  return IByteBufferIteratorPtr( new SocketReplyIterator( slot ) );
}

//-----------------------------------------------------------------------------

SocketRequestHandler::SocketRequestHandler( PacketSocketPtr socket,
                                            PacketSocketPtr sSocket )
  : IRequestHandler()
  , m_Socket( socket )
  , m_requestID( 0 )
  , m_rplMngr( new ReplyManager() )
  , m_receiveThread( 0 )
  , m_sReceiveThread( 0 )
  , m_sSocket( sSocket )
  , m_sRplMngr( new ReplyManager() )
  , m_secToken( 0 )
  , m_datToken( 0 )
  , m_thrManager( new ThreadManager() )
{
  INFO("SocketRequestHandler constructor connection:"
       << ( m_Socket.get() ?
            m_Socket->desc() : ( m_sSocket.get() ? m_sSocket->desc() : "none" ) ) );
  if ( m_sSocket.get() != 0 )
  {
    m_sReceiveThread = new ReceiveThread( this,
                                          m_sSocket,
                                          *m_sRplMngr,
                                          true /*isSecure*/ );
    // thrManager takes the owner ship of m_receiveThread
    m_thrManager->addThread( m_sReceiveThread );
  }
  if ( m_Socket.get() != 0 )
  {
    m_receiveThread =  new ReceiveThread( this,
                                          m_Socket,
                                          *m_rplMngr,
                                          false /*isSecure*/ );
    // thrManager takes the owner ship of m_receiveThread
    m_thrManager->addThread( m_receiveThread );
  }

  if ( m_sSocket.get() != 0 && m_Socket.get() != 0 )
  {
    // combined mode is requested, ask the server
    // to match secure and data channel

    // send "request bind"
    ByteBufferPtr msg = ControlMsg::requestBindMsg();

    PacketSLAC packet( m_requestID++ /* requestID */,
                       0 /*semgentNo*/,
                       0 /*clientID*/,
                       false /* more segments*/,
                       *msg );
    PacketSLAC spacket( m_requestID++ /* requestID */,
                        0 /*semgentNo*/,
                        0 /*clientID*/,
                        false /* more segments*/,
                        *msg );

    DEBUG("sending 'request bind' requests" );
    m_Socket->sendPacket( packet );
    m_sSocket->sendPacket( spacket );

#ifdef CORAL_HAS_CPP11
    std::chrono::seconds const delay(5);
#else
    boost::posix_time::seconds const delay(5);
#endif
    DEBUG("waiting for replies to 'request bind'" );
    // wait for replies
    int count = 0;
    coral::unique_lock lock( m_mutexForTokens );
    while ( ( (m_secToken == 0) || (m_datToken == 0) ) && count < 5 )
    {
#ifdef CORAL_HAS_CPP11
      m_condForTokens.wait_for( lock, delay );
#else
      m_condForTokens.timed_wait( lock, delay ); //FIXME timeouts?
#endif
      count++;
      DEBUG("wait timed out count "<< count );
      // wait for replies
    };

    if ( m_secToken == 0 || m_datToken == 0 )
    {
      // something went wrong
      m_Socket->close();
      m_sSocket->close();
      throw GenericSocketException( "timeout on waiting for bind token",
                                    "SocketRequestHandler::SocketRequestHandler");
    };

    DEBUG( "sending 'bind to' requests stoken " << m_secToken
           << " token " << m_datToken);
    // got replies, send "bind to"
    ByteBufferPtr bindData = ControlMsg::bindMsg( m_secToken );
    PacketSLAC packetBData( m_requestID++ /* requestID */,
                            0 /*semgentNo*/,
                            0 /*clientID*/,
                            false /* more segments*/,
                            *bindData );
    m_Socket->sendPacket( packetBData );

    ByteBufferPtr bindSec = ControlMsg::bindMsg( m_datToken );
    PacketSLAC packetBSec( m_requestID++ /* requestID */,
                           0 /*semgentNo*/,
                           0 /*clientID*/,
                           false /* more segments*/,
                           *bindSec );
    m_sSocket->sendPacket( packetBSec );

    // wait for replies
    count = 0;
    while ( ((m_secToken != 0) || (m_datToken != 0)) && ( count < 5 ) )
    {
#ifdef CORAL_HAS_CPP11
      m_condForTokens.wait_for( lock, delay );
#else
      m_condForTokens.timed_wait( lock, delay ); //FIXME timeout?
#endif
      count++;
      DEBUG("wait timed out count "<< count );
    }

    if ( m_secToken != 0 || m_datToken != 0 )
    {
      // something went wrong
      m_Socket->close();
      m_sSocket->close();
      throw GenericSocketException( "timeout on waiting for bind ok",
                                    "SocketRequestHandler::SocketRequestHandler");
    };

    INFO("secure and data channel binding finished");
  }
}

//-----------------------------------------------------------------------------

SocketRequestHandler::~SocketRequestHandler()
{
  INFO("Destructor SocketRequestHandler started");
  if ( m_Socket.get() != 0 )
  {
    m_receiveThread->endThread();
    m_Socket->close();
  }
  if ( m_sSocket.get() != 0 )
  {
    m_sReceiveThread->endThread();
    m_sSocket->close();
  }
  // wait until the receive thread has terminated
  m_thrManager->joinAll();
  DEBUG("Destructor SocketRequestHandler finished");
}

//-----------------------------------------------------------------------------

void SocketRequestHandler::setToken( bool isSecure, uint32_t token )
{
  coral::lock_guard lock( m_mutexForTokens );
  if ( isSecure )
    m_secToken=token;
  else
    m_datToken=token;
  m_condForTokens.notify_all();
}

//-----------------------------------------------------------------------------

ReplySlot& SocketRequestHandler::send( IByteBufferIterator& requestItr,
                                       bool useSecureChannel )
{
  PacketSocket *socket=0;
  ReplyManager *manager=0;
  if ( useSecureChannel )
  {
    // FIXME? Do we want to turn this into a warning, instead of to fail?
    if ( m_sSocket.get() == 0 )
    {
#if 0
      throw GenericSocketException( "Requested secure channel, but it is not available",
                                    "SocketRequestHandler::send()" );
#endif
      // warn about secure socket not available?
      socket =  m_Socket.get();
      manager = m_rplMngr.get();
      DEBUG( "request #" << m_requestID+1
             << " requested secure channel, but sending insecure");
    }
    else
    {
      socket = m_sSocket.get();
      manager = m_sRplMngr.get();
      DEBUG( "request #" << m_requestID+1
             << " requested secure channel, sending secure");
    }
  }
  else
  {
    if ( m_Socket.get() == 0 )
    {
      // no data channel, send everything through the secure channel
      socket = m_sSocket.get();
      manager = m_sRplMngr.get();
      DEBUG( "request #" << m_requestID+1
             << " requested insecure channel, but sending secure");
    }
    else
    {
      socket = m_Socket.get();
      manager = m_rplMngr.get();
      DEBUG( "request #" << m_requestID+1
             << " requested insecure channel, sending insecure");
    }
  }

 retry:
  try
  {
    coral::lock_guard lock( m_mutexForSend );
    m_requestID++;
    ReplySlot& slot=manager->requestSlot( m_requestID );
    int segment_no=0;
    while ( requestItr.nextBuffer() )
    {
      PacketSLAC packet( m_requestID,
                         segment_no,
                         0 /*clientID*/,
                         !requestItr.isLastBuffer() /* more segments*/,
                         requestItr.currentBuffer() );
      DEBUG("sending request #"<< m_requestID
            << " segment #" << segment_no);
      socket->sendPacket( packet );
      segment_no++;
    }
    return slot;
  }
  catch ( AllSlotsTakenException& )
  {
    ERROR("(non fatal) all slots for requests are taken. Sleeping.");
    sleep( 20 );
    goto retry;
  }
  catch( std::exception& e )
  {
    ERROR("ERROR! Standard C++ exception: '" << e.what() << "'");
    throw;
  }
  catch( ... )
  {
    ERROR("ERROR! Unknown exception caught");
    throw;
  }
}

//-----------------------------------------------------------------------------
