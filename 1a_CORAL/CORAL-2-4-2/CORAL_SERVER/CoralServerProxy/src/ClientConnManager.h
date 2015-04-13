#ifndef CORALSERVERPROXY_CLIENTCONNMANAGER_H
#define CORALSERVERPROXY_CLIENTCONNMANAGER_H

//--------------------------------------------------------------------------
// File and Version Information:
// 	$Id: ClientConnManager.h,v 1.1.2.2.2.1 2012-11-21 10:59:01 avalassi Exp $
//
// Description:
//	Class ClientConnManager.
//
//------------------------------------------------------------------------

//-----------------
// C/C++ Headers --
//-----------------
#include <map>
#include <boost/shared_ptr.hpp>
#include "CoralBase/../src/coral_thread_headers.h"

//----------------------
// Base Class Headers --
//----------------------

//-------------------------------
// Collaborating Class Headers --
//-------------------------------
#include "ClientReaderFactory.h"
#include "NetSocket.h"
#include "ServerReaderFactory.h"

//------------------------------------
// Collaborating Class Declarations --
//------------------------------------

//		---------------------
// 		-- Class Interface --
//		---------------------

/**
 *  Client Connection manager class. Tracks all active client
 *  connections. Thread-safe.
 *
 *  @see ClientWriter, SingleClientReader
 *
 *  @version $Id: ClientConnManager.h,v 1.1.2.2.2.1 2012-11-21 10:59:01 avalassi Exp $
 *
 *  @author Andy Salnikov
 */

namespace coral {
namespace CoralServerProxy {

class PacketQueue;
class PacketHeaderQueue;
class RoutingTables;

class ClientConnManager  {
public:

  // Default constructor
  ClientConnManager(const ServerReaderFactory& serverReaderFactory,
      const ClientReaderFactory& clientReaderFactory,
      PacketQueue& rcvQueue,
      PacketQueue& serverQueue,
      PacketHeaderQueue& clientQueue,
      RoutingTables& routing) ;

  // Destructor
  ~ClientConnManager () ;

  // add one active connection
  bool addConnection ( NetSocket s ) ;

  // remove one connection
  void removeConnection ( NetSocket s ) ;

  // get server socket
  NetSocket serverConnection() const ;

  // close all connections
  void closeAllConnections () ;

protected:

private:

  typedef std::map<NetSocket, boost::shared_ptr<boost::thread> > Connections ;

  // Data members
  ServerReaderFactory m_serverReaderFactory ;
  ClientReaderFactory m_clientReaderFactory ;
  PacketQueue& m_rcvQueue;
  PacketQueue& m_serverQueue;
  PacketHeaderQueue& m_clientQueue;
  RoutingTables& m_routing;
  NetSocket m_serverConn ;
  boost::shared_ptr<boost::thread> m_serverReaderThread;
  Connections m_clientConnections ;
  
  coral::mutex m_mutex ;
  mutable coral::mutex m_sock_mutex ;

  // Copy constructor and assignment are disabled by default
  ClientConnManager ( const ClientConnManager& ) ;
  ClientConnManager operator = ( const ClientConnManager& ) ;

};

} // namespace CoralServerProxy
} // namespace coral

#endif // CORALSERVERPROXY_CLIENTCONNMANAGER_H
