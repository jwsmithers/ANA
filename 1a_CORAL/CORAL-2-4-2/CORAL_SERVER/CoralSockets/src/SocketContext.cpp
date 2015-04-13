// $Id: SocketContext.cpp,v 1.10.2.5 2013-02-08 09:40:09 avalassi Exp $

// Include files
#include <sstream>
#include "CoralServerBase/CTLMagicWordException.h"
#include "CoralServerBase/IRequestHandler.h"
#include "CoralServerBase/RequestProperties.h"
#include "CoralSockets/GenericSocketException.h"

// Local include files
#include "ConnectionManager.h"
#include "SocketContext.h"
#include "SegmentationError.h"

// Logger
#define LOGGER_NAME "CoralSockets::SocketContext"
#include "logger.h"

// Debug
#undef DEBUG
#define DEBUG(out)

// Namespace
using namespace coral::CoralSockets;

//-----------------------------------------------------------------------------

SocketContext::SocketContext( coral::IRequestHandler* handler,
                              PacketSocketPtr cSocket,
                              bool isSecure )
  : m_handler( handler )
  , m_cSocket( cSocket )
  , m_isActive( true )
  , m_isSecure( isSecure )
{
  INFO("SocketContext constructor: " << m_cSocket->desc() );
}

//-----------------------------------------------------------------------------

SocketContext::~SocketContext()
{
  INFO( "SocketContext destructor: " << m_cSocket->desc() );
  // delete any left multi ByteBuffer requests
  coral::lock_guard qlock( m_mutexForRequestMap );
  for( std::map<int,RequestIterator*>::const_iterator
         it = m_requestMap.begin(); it != m_requestMap.end(); ++it)
  {
    delete it->second;
  };
}

//-----------------------------------------------------------------------------

boost::shared_ptr<coral::IRequestHandler> SocketContext::getHandler() const
{
  return m_handler;
}

//-----------------------------------------------------------------------------

void SocketContext::setHandler( boost::shared_ptr<coral::IRequestHandler> handler )
{
  m_handler = handler;
}

//-----------------------------------------------------------------------------

void SocketContext::handleRequest( PacketPtr requestPacket )
{
  if ( !m_isActive )
  {
    // the socket is closed -> the thread should end
    INFO( "NON-FATAL: isActive false handleRequest. What's going on?" );
    return;
  }
  try
  {
    if ( requestPacket.get() == 0 )
    {
      INFO( "handleRequest got no new request." );
      return;
    }
    DEBUG("received new packet");

    const CTLPacketHeader & header( requestPacket->getHeader() );
    const int requestID = header.requestID();
    const int clientID = header.clientID();
    DEBUG( "( " << m_cSocket->desc() << " ) "
           << " recieved Request #" << requestID
           << " segement " << header.segmentNumber()
           << " moreSeg " << header.moreSegments()
           << " clientID " << clientID );
    IByteBufferIteratorPtr requestItr;
    if ( header.segmentNumber() == 0 && !header.moreSegments() )
    {
      // this is the default case, single ByteBuffer requests
      requestItr = IByteBufferIteratorPtr( new RequestIterator(1) );
      dynamic_cast<RequestIterator*>( requestItr.get() )
        ->addBuffer( requestPacket->getPayloadPointer(),
                     0 /* segmentNo */,
                     true /* isLast */ );
    }
    else
    {
      // multi ByteBuffer request
      coral::lock_guard qlock( m_mutexForRequestMap );
      RequestIterator *it;
      if ( m_requestMap.find( requestID ) == m_requestMap.end() )
      {
        m_requestMap[ requestID ] = it = new RequestIterator();
      }
      else
        it = m_requestMap[ requestID ];
      it->addBuffer( requestPacket->getPayloadPointer(),
                     header.segmentNumber(),
                     !header.moreSegments() /*isLast*/);
      if ( header.moreSegments() )
        // this request still needs more ByteBuffers
        return;
      // this request has all ByteBuffers, erase it from the map
      m_requestMap.erase( requestID );
      requestItr = IByteBufferIteratorPtr( it );
    };
    //ScopedTimerStats timer( myStats );
    RequestProperties prop;
    prop.requestId = requestID;
    prop.useSecureChannel = m_isSecure;
    std::auto_ptr<IByteBufferIterator> replyIt(
                                               m_handler->replyToRequest( requestItr, prop ) );

    uint32_t segmentID=0;
    while ( replyIt->nextBuffer() && isActive() )
    {
      DEBUG( "( " << m_cSocket->desc() << " ) sending Reply #" << requestID
             << " SegmentID " << segmentID << " from thread " << this );
      static int csdebug = -1; //AV
      if ( csdebug == -1 )
        csdebug = ( getenv ( "CORALSOCKETS_DEBUG" ) ? 1 : 0 );  //AV
      if ( csdebug > 0 )
        std::cout << "Sending reply to request #" << requestID
                  << " (segment #" << segmentID
                  << ") on socket " << m_cSocket->desc() <<  std::endl;  //AV
      PacketSLAC packet( requestID, clientID, segmentID,
                         !replyIt->isLastBuffer() /* moreSegments */,
                         replyIt->currentBuffer() );
      send( packet );
      segmentID++;
    };
    DEBUG( "( " << m_cSocket->desc() << " ) Reply #" << requestID
           << " finished" );
  }
  catch ( SegmentationErrorException &e )
  {
    ERROR( "( " << m_cSocket->desc()
           << " ) EXCEPTION CAUGHT: " << e.what()
           << " - CLOSE THE SOCKET" );
    // send back a general checksum error
    PacketSLAC errPacket( CTLWrongChecksum,
                          requestPacket->getHeader().requestID(),
                          requestPacket->getHeader().clientID() );
    send( errPacket );
    closeSocket();
  }
  catch ( std::exception& e )
  {
    ERROR( "( " << m_cSocket->desc() << " ) EXCEPTION CAUGHT: " << e.what()
           << " - CLOSE THE SOCKET" );
    closeSocket();
  }
  catch ( ... )
  {
    ERROR( "( " << m_cSocket->desc()
           << " ) UNKNOWN EXCEPTION CAUGHT - CLOSE THE SOCKET" );
    closeSocket();
  }
}

//-----------------------------------------------------------------------------

void SocketContext::send( const PacketSLAC& packet )
{
  coral::lock_guard lock( m_mutexForSend );
  m_cSocket->sendPacket( packet );
}

//-----------------------------------------------------------------------------

std::auto_ptr<coral::unique_lock>
SocketContext::tryLockReadMutex()
{
#ifdef CORAL_HAS_CPP11
  return std::auto_ptr<coral::unique_lock>(new coral::unique_lock( m_mutexForRead, std::try_to_lock ) );
#else
  return std::auto_ptr<coral::unique_lock>(new coral::unique_lock( m_mutexForRead, boost::try_to_lock ) );
#endif
}

//-----------------------------------------------------------------------------

PacketPtr SocketContext::getNextRequest( )
{
  // should be called with mutexForRead held
  //  coral::lock_guard lock( m_mutexForRead );
  try
  {
    PacketPtr packet( m_cSocket->receivePacket( 0 ) ); // no timeout
    return packet;
  }
  catch( SocketClosedException& )
  {
    INFO( "The connection '" << m_cSocket->desc() <<"' has been closed." );
  }
  catch ( CTLMagicWordException& e )
  {
    ERROR( "Received packet with errors in the header '" << e.what() << "'" );
    // send error msg packet back
    PacketSLAC errPacket( CTLWrongMagicWord );
    send( errPacket );
  }
  catch( ErrorInHeaderException& e)
  {
    ERROR("Received packet with errors in the header '"<< e.what() << "'");
    // send error msg packet back
    if ( e.getErrorCode() == ErrorInHeaderException::ErrWrongVersion ) {
      PacketSLAC errPacket( CTLWrongVersion );
      send( errPacket );
    }
    else if ( e.getErrorCode() == ErrorInHeaderException::ErrWrongChecksum )
    {
      PacketSLAC errPacket( CTLWrongChecksum );
      send( errPacket );
    }
    else
    {
      // send back a general checksum error
      PacketSLAC errPacket( CTLWrongChecksum );
      send( errPacket );
    }
  }
  // close socket and mark context as inactive
  closeSocket();
  return PacketPtr( (PacketSLAC*) 0 );
}

//-----------------------------------------------------------------------------

void
SocketContext::setConnectionProperties( uint32_t token )
{
  // Create a new properties object
  ConnectionProperties *props( new ConnectionProperties() );
  // Set all data
  props->cert = m_cSocket->getCertificateData();
  props->remoteEnd = m_cSocket->remoteEnd();
  // Set it temporary to ZERO unless we get one
  props->connid = token;
  // Set the properties to the handler, within an auto_ptr
  m_handler->setConnectionProperties( std::auto_ptr<const ConnectionProperties>(props) );
}

//-----------------------------------------------------------------------------
