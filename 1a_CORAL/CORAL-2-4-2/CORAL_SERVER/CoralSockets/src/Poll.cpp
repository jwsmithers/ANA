// $Id: Poll.cpp,v 1.3.2.2 2012-06-07 12:19:56 avalassi Exp $

// Include files
#if 0
#include <arpa/inet.h>
#include <sys/socket.h>
#include <netinet/tcp.h> //  for TCP_NODELAY
#include <fcntl.h>
#include <netdb.h>
#endif
#include <sys/errno.h>
#include <poll.h>

#include <cstring>
#include <iostream>
#if 0
#include <sstream>
#endif

#include "CoralSockets/GenericSocketException.h"
#include "CoralSockets/NonFatalSocketException.h"

#include "Poll.h"

#define LOGGER_NAME "CoralSockets::Poll"
#include "logger.h"

#undef DEBUG
#define DEBUG( out )

// Namespace
using namespace coral::CoralSockets;

//---------------------------------------------------------------------------

namespace coral {

  namespace CoralSockets {

    class PollFDs {
    public:
      PollFDs( unsigned int maxFDs );

      virtual ~PollFDs();

      void addSocket( const ISocketPtr& socket, Poll::PMode mode );

      void removeSocket( const ISocketPtr& socket );

      inline int countFD() const
      {
        return m_countFD;
      };

      inline pollfd* getPollFDs() const
      {
        return m_pollFD;
      };

      inline ISocketPtr* getSockets() const
      {
        return m_socketPtr;
      };

    private:
      struct pollfd *m_pollFD;

      ISocketPtr *m_socketPtr;

      int m_countFD;

      int m_maxFDs;
    };
  }
}

//---------------------------------------------------------------------------

PollFDs::PollFDs( unsigned int maxFDs)
{
  m_maxFDs = maxFDs;
  m_pollFD = new pollfd[ m_maxFDs ];
  m_socketPtr = new ISocketPtr[ m_maxFDs ];
  m_countFD = 0;
}

//---------------------------------------------------------------------------

PollFDs::~PollFDs()
{
  delete[] m_pollFD;
  delete[] m_socketPtr;
}

//---------------------------------------------------------------------------

void PollFDs::addSocket(const ISocketPtr& socket, Poll::PMode mode )
{
  if (m_countFD >= m_maxFDs)
    throw GenericSocketException("not enough slots in PollFD","addSocket");

  // check that socket is not already added
  int i = 0;
  while ( i<m_countFD && socket.get() != m_socketPtr[i].get() )
    i++;

  if ( i < m_countFD)
    throw GenericSocketException("socket allready in PollFDs","addSocket");


  m_socketPtr[ m_countFD ] = socket;
  pollfd &pfd = m_pollFD[m_countFD];

  pfd.fd = socket->getFd();

  if (mode == Poll::P_READ )
    pfd.events = POLLIN;
  else if ( mode == Poll::P_WRITE )
    pfd.events = POLLOUT;
  else if ( mode == Poll::P_READ_WRITE )
    pfd.events = POLLOUT | POLLIN;
  DEBUG("socket " << pfd.fd << " pmode " << mode << " events " << pfd.events );

  m_countFD++;
}

//---------------------------------------------------------------------------

void PollFDs::removeSocket(const ISocketPtr& socket )
{
  int i=0;
  while ( i<m_countFD && socket.get() != m_socketPtr[i].get() )
    i++;

  if ( i >= m_countFD)
    throw GenericSocketException("socket not found in PollFDs","removeSocket");

  m_countFD--;
  m_socketPtr[i] =  m_socketPtr[ m_countFD ];
  m_pollFD[i] = m_pollFD[ m_countFD ];

}

//---------------------------------------------------------------------------

Poll::Poll( unsigned int maxFDs )
  : m_pollFD( new PollFDs( maxFDs ) )
{
  INFO("Poll constructor ");
  m_currentSocket = -1;
  m_maxReadySockets = 0;
}

//---------------------------------------------------------------------------

Poll::~Poll()
{
}

//---------------------------------------------------------------------------

void Poll::addSocket( const ISocketPtr& Socket, Poll::PMode mode )
{
  m_pollFD->addSocket( Socket, mode );
}

//---------------------------------------------------------------------------

void Poll::removeSocket( const ISocketPtr& socket )
{
  // reset any open iterators
  m_currentSocket = -1;
  m_maxReadySockets = 0;

  m_pollFD->removeSocket( socket );
}

//---------------------------------------------------------------------------

int Poll::poll( int timeout )
{
  // reset iterator
  m_currentSocket=-1;
  m_maxReadySockets = 0;

  DEBUG("calling poll with " << m_pollFD->countFD() << " sockets ");
  //std::cout << "poll fd " << m_pollFD->getPollFDs()[0].fd << " status " << m_pollFD->getPollFDs()[0].events << std::endl;
  int ret = ::poll( m_pollFD->getPollFDs(), m_pollFD->countFD(), timeout );
  DEBUG("returned from poll ret value " << ret );
  //std::cout << "poll fd " << m_pollFD->getPollFDs()[0].fd << " rstatus " << m_pollFD->getPollFDs()[0].revents << std::endl;

  if (ret < 0 ) {
    if (errno == EINTR)
      // not fatal error
      // and there is no really correct way to handle interrupts
      // we just return 0 and hope to get called again
      return 0;

    std::stringstream errStr;
    errStr << "Error in Poll::poll() :'" <<strerror(errno) << "'";
    throw GenericSocketException( errStr.str() );
  }

  m_maxReadySockets = ret;
  return ret;
}

//---------------------------------------------------------------------------

const ISocketPtr& Poll::getNextReadySocket()
{
  if ( m_maxReadySockets <= 0 )
    throw GenericSocketException("no more sockets are ready",
                                 "Poll::getNextReadySocket");

  pollfd *fds = m_pollFD->getPollFDs();

  // advance at least one socket
  m_currentSocket++;
  while ( m_currentSocket < m_pollFD->countFD() &&
          fds[m_currentSocket].revents ==0 )
    m_currentSocket++;

  if ( m_currentSocket >= m_pollFD->countFD() )
    throw GenericSocketException("no more sockets in array");

  m_maxReadySockets--;
  return m_pollFD->getSockets()[ m_currentSocket ];
}

//-------------------------------------------------------------------------

bool Poll::currSocketClosed()
{
  pollfd *fds = m_pollFD->getPollFDs();
  return ( fds[ m_currentSocket ].revents & ( POLLHUP | POLLNVAL ) ) != 0;
}
