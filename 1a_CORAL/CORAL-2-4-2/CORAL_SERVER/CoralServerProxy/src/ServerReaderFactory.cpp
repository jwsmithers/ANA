//--------------------------------------------------------------------------
// File and Version Information:
// 	$Id: ServerReaderFactory.cpp,v 1.2.2.4 2012-11-20 22:27:51 salnikov Exp $
//
// Description:
//	Class ServerReaderFactory...
//
// Author List:
//      Andrei Salnikov
//
//------------------------------------------------------------------------

//-----------------------
// This Class's Header --
//-----------------------
#include "ServerReaderFactory.h"

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
#include "NetEndpointAddress.h"
#include "NetSocket.h"
#include "ServerReader.h"

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
ServerReaderFactory::ServerReaderFactory (const NetEndpointAddress& serverAddress,
                                          PacketQueue& rcvQueue,
                                          unsigned timeoutSec)
  : m_serverAddress( serverAddress )
  , m_rcvQueue( rcvQueue )
  , m_timeoutSec ( timeoutSec )
{
}

//--------------
// Destructor --
//--------------
ServerReaderFactory::~ServerReaderFactory ()
{
}

// opens connection to upstream server, returns -1 on failure
NetSocket
ServerReaderFactory::serverConnect() const
{
 // create socket
  PXY_DEBUG ( "ServerReaderFactory: Creating server-side socket" );
  NetSocket sock ( PF_INET, SOCK_STREAM, 0 ) ;
  if ( not sock.isOpen() ) {
    PXY_ERR ( "ServerReaderFactory: Failed to create a socket: " << strerror(errno) );
    return sock ;
  }

  // set socket options
  if ( setSocketOptions( sock ) < 0 ) {
    PXY_ERR ( "ServerReaderFactory: Failed to set socket options " << sock << ": " << strerror(errno) );
    sock.close() ;
    return sock ;
  }

  // now try to connect
  if ( sock.connect ( m_serverAddress ) < 0 ) {
    PXY_ERR ( "ServerReaderFactory: Failed to connect to a server (" << m_serverAddress <<  "): " << strerror(errno) );
    sock.close() ;
    return sock ;
  }

  // OK
  return sock ;
}  

// start new thread serving the server socket
boost::shared_ptr<boost::thread> 
ServerReaderFactory::readerThread(ClientConnManager& connManager) const
{
  return boost::make_shared<boost::thread>(ServerReader(connManager, m_rcvQueue, m_timeoutSec));
}

int
ServerReaderFactory::setSocketOptions( NetSocket& sock ) const
{
  // reuse the address
  if ( sock.setSocketOptions ( SOL_SOCKET, SO_REUSEADDR, 1 ) < 0 ) {
    return -1 ;
  }
  if ( sock.setSocketOptions ( SOL_SOCKET, SO_KEEPALIVE, 1 ) < 0 ) {
    return -1 ;
  }
  // disable Naggle algorithm
  if ( sock.setSocketOptions ( IPPROTO_TCP, TCP_NODELAY, 1 ) < 0 ) {
    return -1 ;
  }
  return 0 ;
}

} // namespace CoralServerProxy
} // namespace coral
