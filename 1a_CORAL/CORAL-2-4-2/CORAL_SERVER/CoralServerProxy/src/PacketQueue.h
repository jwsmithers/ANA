#ifndef CORALSERVERPROXY_PACKETQUEUE_H
#define CORALSERVERPROXY_PACKETQUEUE_H

//--------------------------------------------------------------------------
// File and Version Information:
// 	$Id: PacketQueue.h,v 1.1.2.3 2010-12-20 13:23:32 avalassi Exp $
//
// Description:
//	Class PacketQueue.
//
//------------------------------------------------------------------------

//-----------------
// C/C++ Headers --
//-----------------
#include <queue>
#include <unistd.h>
#include "CoralBase/../src/coral_thread_headers.h"
#ifdef CORAL_HAS_CPP11
#include <condition_variable>
#else
#include "boost_condition_headers.h"
#endif

//----------------------
// Base Class Headers --
//----------------------

//-------------------------------
// Collaborating Class Headers --
//-------------------------------
#include "Packet.h"

//------------------------------------
// Collaborating Class Declarations --
//------------------------------------

//		---------------------
// 		-- Class Interface --
//		---------------------

/**
 *  This class represents synchronized packet queue.
 *
 *  @see AdditionalClass
 *
 *  @version $Id: PacketQueue.h,v 1.1.2.3 2010-12-20 13:23:32 avalassi Exp $
 *
 *  @author
 */

namespace coral {
namespace CoralServerProxy {

class PacketQueue  {
public:

  // Default constructor
  PacketQueue ( size_t maxSize ) ;

  // Destructor
  ~PacketQueue () ;

  // add one more packet to the queue, if the queue
  // is full already then wait until somebody calls pop()
  void push ( PacketPtr packet ) ;

  // add one more packet to the queue, if the queue
  // is full already then wait until somebody calls pop() or timeout
  // is expired. If timeout is expeired return false.
  bool timed_push ( PacketPtr packet, unsigned timeoutSec ) ;

  // get one packet from the head of the queue, if the queue is
  // empty then wait until somebody calls push()
  PacketPtr pop() ;

  // clear the queue
  void clear() ;

  // get current queue size
  size_t size() ;

  // check queue size
  bool empty() ;

protected:

private:

  // Data members
  size_t m_maxSize ;
  std::queue<PacketPtr> m_queue ;
  coral::mutex m_mutex ;
#ifdef CORAL_HAS_CPP11
  std::condition_variable m_condFull ;
  std::condition_variable m_condEmpty ;
#else
  boost::condition m_condFull ;
  boost::condition m_condEmpty ;
#endif

  // Copy constructor and assignment are disabled by default
  PacketQueue ( const PacketQueue& ) ;
  PacketQueue operator = ( const PacketQueue& ) ;

};

} // namespace CoralServerProxy
} // namespace coral

#endif // CORALSERVERPROXY_PACKETQUEUE_H
