#ifndef CORALSERVERPROXY_CLIENTREADERFACTORY_H
#define CORALSERVERPROXY_CLIENTREADERFACTORY_H

//--------------------------------------------------------------------------
// File and Version Information:
// 	$Id: ClientReaderFactory.h,v 1.2.2.2 2012-11-21 10:59:01 avalassi Exp $
//
// Description:
//	Class ClientReaderFactory.
//
//------------------------------------------------------------------------

//-----------------
// C/C++ Headers --
//-----------------
#include <utility>
#include <boost/shared_ptr.hpp>
#include "CoralBase/../src/coral_thread_headers.h"

//----------------------
// Base Class Headers --
//----------------------


//-------------------------------
// Collaborating Class Headers --
//-------------------------------

//------------------------------------
// Collaborating Class Declarations --
//------------------------------------

//		---------------------
// 		-- Class Interface --
//		---------------------

/**
 *  Class which is responsible for the connection to the upstream server and
 *  creation of the server reader thread.
 *
 *  @see AdditionalClass
 *
 *  @version $Id: ClientReaderFactory.h,v 1.2.2.2 2012-11-21 10:59:01 avalassi Exp $
 *
 *  @author Andrei Salnikov
 */

namespace coral {
namespace CoralServerProxy {

class ClientConnManager ;
class NetSocket ;
class PacketQueue ;
class RoutingTables ;

class ClientReaderFactory  {
public:

  // Default constructor
  ClientReaderFactory ( PacketQueue& rcvQueue,
                        RoutingTables& routing,
                        unsigned timeoutSec ) ;

  // start new thread serving the server socket
  boost::shared_ptr<boost::thread> readerThread(const NetSocket& sock, ClientConnManager& connManager) const;

protected:

private:

  // Data members

  PacketQueue& m_rcvQueue ;
  RoutingTables& m_routing ;
  unsigned m_timeoutSec ;

  // Copy constructor and assignment are disabled by default
  ClientReaderFactory operator = ( const ClientReaderFactory& ) ;

};

} // namespace CoralServerProxy
} // namespace coral

#endif // CORALSERVERPROXY_CLIENTREADERFACTORY_H
