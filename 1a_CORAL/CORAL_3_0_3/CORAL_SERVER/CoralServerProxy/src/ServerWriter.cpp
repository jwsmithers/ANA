//--------------------------------------------------------------------------
// File and Version Information:
// 	$Id: ServerWriter.cpp,v 1.2.2.1.2.1 2012-11-21 10:59:02 avalassi Exp $
//
// Description:
//	Class ServerWriter...
//
// Author List:
//      Andy Salnikov
//
//------------------------------------------------------------------------

//-----------------------
// This Class's Header --
//-----------------------
#include "ServerWriter.h"

//-----------------
// C/C++ Headers --
//-----------------

//-------------------------------
// Collaborating Class Headers --
//-------------------------------
#include "MsgLogger.h"
#include "Packet.h"

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
ServerWriter::ServerWriter ( PacketQueue& queue, ClientConnManager& connMgr )
  : m_queue ( queue )
  , m_connMgr ( connMgr )
{
}

//--------------
// Destructor --
//--------------
ServerWriter::~ServerWriter ()
{
}

// this is the "run" method used by the Boost.thread
void
ServerWriter::operator() ()
{
  while ( true ) {

    // receive next packet from a queue
    PacketPtr p = m_queue.pop() ;
    PXY_DEBUG ( "ServerWriter: got packet from queue " << *p );

    if ( p->type() == Packet::Control ) {
      PXY_DEBUG ( "ServerWriter: got control packet" );
    } else  {
      
      NetSocket socket = m_connMgr.serverConnection() ;
      if (not socket.isOpen()) {
        PXY_ERR ( "ServerWriter: server connection is closed" );
      }
      
      // send it down to the wire
      int s = p->write ( socket ) ;
      if ( s <= 0 ) {
        PXY_ERR ( "ServerWriter " << socket << ": failed to send data to the server" );
      }
    }

  }
}

} // namespace CoralServerProxy
} // namespace coral
