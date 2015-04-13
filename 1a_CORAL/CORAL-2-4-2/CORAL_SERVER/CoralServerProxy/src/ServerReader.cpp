//--------------------------------------------------------------------------
// File and Version Information:
// 	$Id: ServerReader.cpp,v 1.3.2.3.2.1 2012-11-21 10:59:02 avalassi Exp $
//
// Description:
//	Class ServerReader...
//
// Author List:
//      Andy Salnikov
//
//------------------------------------------------------------------------

//-----------------------
// This Class's Header --
//-----------------------
#include "ServerReader.h"

//-----------------
// C/C++ Headers --
//-----------------
#include <unistd.h>
#include <errno.h>
#include <string.h>

//-------------------------------
// Collaborating Class Headers --
//-------------------------------
#include "MsgLogger.h"
#include "Packet.h"
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
ServerReader::ServerReader ( ClientConnManager& connManager,
                             PacketQueue& queue,
                             unsigned timeoutSec )
  : m_connManager ( connManager )
  , m_queue ( queue )
  , m_timeoutSec ( timeoutSec )
{
}

//--------------
// Destructor --
//--------------
ServerReader::~ServerReader ()
{
}

// this is the "run" method used by the Boost.thread
void
ServerReader::operator() ()
{
  // the whole purpose of the ServerReader object is to read
  // the data from the client socket and put it into a packet queue

  PXY_DEBUG ( "ServerReader: starting server reader on socket " << m_connManager.serverConnection() ) ;
  while (true) {

    NetSocket socket = m_connManager.serverConnection() ;
    if (not socket.isOpen()) {
      PXY_DEBUG ( "ServerReader: socket was closed, stop the loop" ) ;
      break;
    }
  
    PacketPtr p = Packet::read ( socket, Packet::Reply ) ;
    if ( not p ) {
      PXY_DEBUG ( "ServerReader: failed to read packet, stop the loop" ) ;
      break ;
    }

    PXY_DEBUG ( "ServerReader " << socket << ": received new packet " << *p ) ;

    // set a "proxy" flag for every packet
    p->buffer()[23] |= 0x40 ;

    // try to queue it for the processing but don't wait forever
    if ( m_queue.timed_push( p, m_timeoutSec ) ) {

      PXY_DEBUG ( "ServerReader " << socket << ": queued new packet " <<
          *p << ", new queue size = " << m_queue.size() ) ;

    } else {

      // the queue is filled up and nobody cares to clean it up
      // safest thing here is to disconnect all clients at least to let them know
      // that upstream server may be hanging. Another option is to send a reply
      // packet with specific opcode.
      // Consider also cleaning the queue from the packets coming from this connection.
      PXY_ERR ( "ServerReader " << socket << ": timeout (" <<
          m_timeoutSec << "sec) while queuing new packet" ) ;
      break ;

    }
  }

  // if socket is closed already it means that some other thread initiated server disconnect,
  // we do not need to do anything in this case. Otherwise call connection manager and tell
  // it to stop everything
  PXY_DEBUG ( "ServerReader: check server connection" ) ;
  if ( m_connManager.serverConnection().isOpen() ) {
    PXY_TRACE ( "ServerReader: stopping the world" ) ;
    m_connManager.closeAllConnections();
  }
}

} // namespace CoralServerProxy
} // namespace coral
