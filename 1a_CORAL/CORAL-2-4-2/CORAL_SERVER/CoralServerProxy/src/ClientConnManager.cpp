//--------------------------------------------------------------------------
// File and Version Information:
// 	$Id: ClientConnManager.cpp,v 1.3.2.1.2.1 2012-11-21 10:59:01 avalassi Exp $
//
// Description:
//	Class ClientConnManager...
//
// Author List:
//      Andy Salnikov
//
//------------------------------------------------------------------------

//-----------------------
// This Class's Header --
//-----------------------
#include "ClientConnManager.h"

//-----------------
// C/C++ Headers --
//-----------------

//-------------------------------
// Collaborating Class Headers --
//-------------------------------
#include "MsgLogger.h"
#include "Packet.h"
#include "PacketHeaderQueue.h"
#include "PacketQueue.h"
#include "RoutingTables.h"

//-----------------------------------------------------------------------
// Local Macros, Typedefs, Structures, Unions and Forward Declarations --
//-----------------------------------------------------------------------

//		----------------------------------------
// 		-- Public Function Member Definitions --
//		----------------------------------------

namespace coral {
namespace CoralServerProxy {

//----------------
// Constructors --
//----------------
ClientConnManager::ClientConnManager ( const ServerReaderFactory& serverReaderFactory,
          const ClientReaderFactory& clientReaderFactory,
          PacketQueue& rcvQueue,
          PacketQueue& serverQueue,
          PacketHeaderQueue& clientQueue,
          RoutingTables& routing)
  : m_serverReaderFactory(serverReaderFactory)
  , m_clientReaderFactory(clientReaderFactory)
  , m_rcvQueue(rcvQueue)
  , m_serverQueue(serverQueue)
  , m_clientQueue(clientQueue)
  , m_routing(routing)
  , m_serverConn()
  , m_serverReaderThread()
  , m_clientConnections()
  , m_mutex()
  , m_sock_mutex()
{
}

//--------------
// Destructor --
//--------------
ClientConnManager::~ClientConnManager ()
{
}

// add one active connection
bool
ClientConnManager::addConnection ( NetSocket s )
{
  PXY_DEBUG ( "ClientConnManager: adding new connection: " << s ) ;

  // lock the whole thing
  coral::lock_guard qlock ( m_mutex ) ;

  // if we are not connected to server yet then do connect and
  // spawn server reader thread
  if ( not m_serverConn.isOpen() ) {

    PXY_DEBUG ( "ClientConnManager: opening server connection" ) ;

    coral::lock_guard qlock_sock ( m_sock_mutex ) ;

    // open connection to server
    m_serverConn = m_serverReaderFactory.serverConnect();
    if ( not m_serverConn.isOpen() ) {
      return false ;
    }

    m_serverReaderThread = m_serverReaderFactory.readerThread(*this);
    if (not m_serverReaderThread) {
      m_serverConn.close();
      return false;
    }
    
  }

  // start client reader thread
  PXY_TRACE ( "starting new client thread" ) ;
  boost::shared_ptr<boost::thread> clientReader = m_clientReaderFactory.readerThread(s, *this);
  if (not clientReader) {
    return false;
  }

  // just store it in the active connections set
  m_clientConnections.insert( std::make_pair(s, clientReader) ) ;

  return true ;
}

// remove one connection
void
ClientConnManager::removeConnection ( NetSocket s )
{
  PXY_DEBUG ( "ClientConnManager: removing connection: " << s ) ;

  // lock the whole thing
  coral::lock_guard qlock ( m_mutex ) ;

  // just remove it from the active connections set
  m_clientConnections.erase( s ) ;

  // when all clients disconnect shutdown server connection too
  // we don't need to wait until all client threads finish, this method is called
  // from the (last) client thread which is about to finish
  if ( m_clientConnections.empty() and m_serverConn.isOpen() ) {

    // close server connection too, the socket is closed which is a sign to a server reader thread
    // that we are closing it on our side instead of server itself closing remote side.
    PXY_DEBUG ( "ClientConnManager: closing server socket" ) ;
    {
      PXY_DEBUG ( "ClientConnManager: closing server socket" ) ;
      coral::lock_guard qlock_sock ( m_sock_mutex ) ;
      NetSocket sock;
      std::swap(m_serverConn, sock);
      sock.shutdown();
      sock.close();
    }

    // and wait for the server reader thread to die off
    PXY_DEBUG ( "ClientConnManager: joining server thread" ) ;
    m_serverReaderThread->join();
    
    // now clean all queues from remaining stuff
    PXY_DEBUG ( "ClientConnManager: clearing all queues" ) ;
    m_rcvQueue.clear();
    m_serverQueue.clear();
    m_clientQueue.clear();

    // reset routing info too
    PXY_DEBUG ( "ClientConnManager: clearing routing tables" ) ;
    m_routing.clear();

    // add special packet to receive queue which will trigger cleanup in dispatcher
    PacketPtr p = Packet::buildControl ( Packet::ServerShutdown, 0 ) ;
    PXY_INFO ( "ClientConnManager: sending server shutdown packet " << *p ) ;
    m_rcvQueue.push(p);

  }
}

// get server socket
NetSocket 
ClientConnManager::serverConnection() const 
{
  coral::lock_guard qlock_sock ( m_sock_mutex ) ;
  return m_serverConn;
}


// close all connections
void
ClientConnManager::closeAllConnections ()
{
  // lock the whole thing
  coral::unique_lock qlock ( m_mutex ) ;

  // will copy the threads here, the code below needs a copy
  std::vector<boost::shared_ptr<boost::thread> > clientThreads;
  clientThreads.reserve(m_clientConnections.size());
  
  // close every socket, use shutdown here, actual close will be done by client thread
  for ( Connections::iterator i = m_clientConnections.begin() ; i != m_clientConnections.end() ; ++ i ) {
    NetSocket s = i->first ;
    PXY_DEBUG ( "ClientConnManager: closing connection: " << s ) ;
    s.shutdown() ;
    clientThreads.push_back(i->second);
  }
  
  // close server connection too, the socket is closed which is a sign to a server reader thread
  // that we are closing it on our side instead of server itself closing remote side.
  if ( m_serverConn.isOpen() ) {
    PXY_DEBUG ( "ClientConnManager: closing server socket" ) ;
    coral::lock_guard qlock_sock ( m_sock_mutex ) ;
    NetSocket sock;
    std::swap(m_serverConn, sock);
    sock.shutdown();
    sock.close();
  }

  // wait until all client threads finish, if this method is called from one of the client 
  // threads it means that thread is already finishing and will not do any harm, skip wait.
  // need to unlock the mutex here, otherwise clients will deadlock on call to removeConnection()
  for ( std::vector<boost::shared_ptr<boost::thread> >::iterator i = clientThreads.begin() ; i != clientThreads.end() ; ++ i ) {
    if ((*i)->get_id() != boost::this_thread::get_id()) {
      qlock.unlock();
      PXY_DEBUG ( "ClientConnManager: joining thread: " << (*i)->get_id() ) ;
      (*i)->join();
      qlock.lock();
    }
  }
  
  // and wait for the server reader thread to die off
  if (m_serverReaderThread->get_id() != boost::this_thread::get_id()) {
    PXY_DEBUG ( "ClientConnManager: joining server thread" ) ;
    m_serverReaderThread->join();
  }
  
  // forget all clients
  m_clientConnections.clear() ;
  
  // now clean all queues from remaining stuff
  PXY_DEBUG ( "ClientConnManager: clearing all queues" ) ;
  m_rcvQueue.clear();
  m_serverQueue.clear();
  m_clientQueue.clear();

  // reset routing info too
  PXY_DEBUG ( "ClientConnManager: clearing routing tables" ) ;
  m_routing.clear();
  
  // add special packet to receive queue which will trigger cleanup in dispatcher
  PacketPtr p = Packet::buildControl ( Packet::ServerShutdown, 0 ) ;
  PXY_INFO ( "ClientConnManager: sending server shutdown packet " << *p ) ;
  m_rcvQueue.push(p);

}

} // namespace CoralServerProxy
} // namespace coral
