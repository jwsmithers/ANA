//--------------------------------------------------------------------------
// File and Version Information:
// 	$Id: ClientReaderFactory.cpp,v 1.1.2.1 2012-11-20 22:27:50 salnikov Exp $
//
// Description:
//	Class ClientReaderFactory...
//
// Author List:
//      Andrei Salnikov
//
//------------------------------------------------------------------------

//-----------------------
// This Class's Header --
//-----------------------
#include "ClientReaderFactory.h"

//-----------------
// C/C++ Headers --
//-----------------
#include <cerrno>
#include <cstring>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <sys/types.h>
#include <sys/socket.h>

//-------------------------------
// Collaborating Class Headers --
//-------------------------------
#include "boost_makeshared_headers.h"
#include "MsgLogger.h"
#include "NetSocket.h"
#include "SingleClientReader.h"

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
ClientReaderFactory::ClientReaderFactory (PacketQueue& rcvQueue,
                                          RoutingTables& routing,
                                          unsigned timeoutSec)
  : m_rcvQueue( rcvQueue )
  , m_routing(routing)
  , m_timeoutSec ( timeoutSec )
{
}

// start new thread serving the server socket
boost::shared_ptr<boost::thread> 
ClientReaderFactory::readerThread(const NetSocket& sock, ClientConnManager& connManager) const
{
  return boost::make_shared<boost::thread>(SingleClientReader(sock, m_rcvQueue, m_timeoutSec, m_routing, connManager));
}

} // namespace CoralServerProxy
} // namespace coral
