
// Include files
#include <cstring>
#include <iostream>
#include <sstream>
#include "CoralServerBase/CALPacketHeader.h"
#include "CoralServerBase/CTLPacketHeader.h"
#include "CoralServerBase/CTLStatus.h"
#include "CoralServerBase/IRequestHandler.h"
#include "CoralMonitor/StopTimer.h"
#include "CoralBase/../src/coral_thread_headers.h"
#include "CoralSockets/GenericSocketException.h"
#include "CoralSockets/SocketClient.h"

// Local include files
#include "../../src/DummyRequestHandler.h"
#include "../../src/ISocket.h"
#include "../../src/Poll.h"
#include "../../src/ThreadManager.h"
#include "../../src/TcpSocket.h"

// Message output
#define LOG std::cout

//-----------------------------------------------------------------------------

namespace coral
{

  namespace CoralSockets
  {

    bool compareResult( IByteBufferIteratorPtr it1,
                        IByteBufferIteratorPtr it2 )
    {
      while ( it1->nextBuffer() )
      {
        if ( !it2->nextBuffer() )
          return false;

        if ( it1->currentBuffer().usedSize() != it2->currentBuffer().usedSize() )
          return false;

        for (unsigned int i=0; i<it1->currentBuffer().usedSize(); i++ )
          if ( *(it1->currentBuffer().data()+i) != *(it2->currentBuffer().data()+i) )
            return false;
      };
      if (it2->nextBuffer() )
        return false;

      return true;
    }

    //-------------------------------------------------------------------------

#define MESSAGE_SIZE 110
    struct Message {
      unsigned char ctlHeader[ CTLPACKET_HEADER_SIZE ];
      unsigned char calHeader[ CALPACKET_HEADER_SIZE ];
#if 0
      CTLPacketHeader ctlHeader( 0, //MESSAGE_SIZE + CTLPACKET_HEADER_SIZE,
                                    //  0 /*messageNo*/, 0 /*clientId*/, 0, false /* ctlMoreSegments */,
                                 //                0 //   ctlPayloadChecksum
                                 );
#endif
      char Message[MESSAGE_SIZE];
    };

    //-------------------------------------------------------------------------

    void int2str( char * dest, unsigned int num )
    {
      char *out=dest+5;
      while (out>dest) {
        *out = (num % 10) + 0x30;
        num /=10;
        out--;
      }
    }

    //-------------------------------------------------------------------------

    void int2hex( char * dest, unsigned int num )
    {
      static char hex[]="0123456789ABCDEF";
      char *out=dest+5;
      while (out>dest) {
        *out = hex[num & 0xF];
        num = num >>4;
        out--;
      }
    }

    //-------------------------------------------------------------------------

    class stressClientSendThread : public Runnable
    {
    public:
#define m_messageBurst  100
#define m_maxSockets    20000
      struct Message m_messages[m_messageBurst];
      int m_maxBursts;
      int m_threadBurstPos[m_maxSockets];
      int m_threadBurstNo[m_maxSockets];
      size_t m_threads;
      size_t m_finished;
      Poll m_poll;
      coral::mutex m_pollMutex;

      stressClientSendThread( int maxBursts )
        : m_threads(0)
        , m_finished(0)
        , m_poll( m_maxSockets )
      {
        initMessages();
        m_maxBursts = maxBursts;
      };

      virtual ~stressClientSendThread() {};

      void endThread() {};
      const std::string desc() const
      {
        return "sendThread";
      };

      void initMessages()
      {
        char message[MESSAGE_SIZE]="This is a dummy request......................"
          "........................";
        for ( int i = 0; i<m_messageBurst; i++) {
          strncpy(m_messages[i].Message, message, MESSAGE_SIZE);
          new (m_messages[i].ctlHeader)CTLPacketHeader( CTLOK,
                                                        sizeof( m_messages[i] ),
                                                        i,0 /* clientId*/, 0, false /* ctlMoreSegments */,
                                                        0 /*  ctlPayloadChecksum */ );

          new (m_messages[i].calHeader)CALPacketHeader( 0, //  opcode
                                                        false /* from Proxy */,
                                                        false /* cacheable*/,
                                                        0 );

        }
      };

      void prepareMessageBurst( int startMessage) {
        for ( int i = 0; i< m_messageBurst; i++ )
        {
          int messageNo= startMessage + i;
          Message &m=m_messages[i];
          int2str( &m.Message[MESSAGE_SIZE-10], messageNo );
#if 0
          new (m.ctlHeader)CTLPacketHeader( CTLOK,
                                            MESSAGE_SIZE + CTLPACKET_HEADER_SIZE,
                                            messageNo, clientId, 0, false /* ctlMoreSegments */,
                                            0 /*  ctlPayloadChecksum */ );
#else
          //     ::memcpy( m.ctlHeader+7, &messageNo, 4 );
#endif
        }
      };

      void addSocket( ISocketPtr socket )
      {
        m_threads++;
        if (m_threads>=m_maxSockets)
          throw GenericSocketException("too many sockets in sender thread");

        m_threadBurstPos[m_threads]=0;
        m_threadBurstNo[m_threads]=0;

        socket->setContext( m_threads );

        coral::lock_guard lock(m_pollMutex);
        m_poll.addSocket( socket, Poll::P_WRITE );
      };


      void operator()()
      {
        while ( (m_finished == 0) || (m_finished != m_threads) )
        {
          // protect with mutex?
          int ready = m_poll.poll(200);
          while (ready>0) {
            const ISocketPtr& socket = m_poll.getNextReadySocket();
            size_t currSocket = (size_t)socket->getContext();
            int &pos = m_threadBurstPos[ currSocket ];
#if 0
            std::cout << currSocket << " writing burst no "
                      << m_threadBurstNo[ currSocket ]
                      << " pos " << pos << std::endl;
#endif
            prepareMessageBurst( m_threadBurstNo[ currSocket ] );
            int written=socket->write( ((unsigned char*)m_messages)
                                       + pos,
                                       sizeof( m_messages ) - pos );
            pos+=written;
            if ( pos == sizeof( m_messages ) )
            {
#if 0
              std::cout << currSocket << " finished one burst "
                        <<  m_threadBurstNo[ currSocket ] << std::endl;
#endif
              m_threadBurstNo[ currSocket ]++;
              pos = 0;
              if ( m_threadBurstNo[ currSocket ] == m_maxBursts )
              {
                m_finished++;
                m_poll.removeSocket( socket );
                // iterator restart needed after removeSocket
                break;
              };

            }
            ready --;
          }
        };


#if 0
        int n=0;
        while ( n < m_maxBursts)
        {
          LOG << "sending messages burst " << n << std::endl;
          prepareMessageBurst( n*m_messageBurst );
          m_socket->writeAll( (unsigned char*)m_messages, sizeof( m_messages ) );
          n++;
        };
#endif
        LOG << "send thread finished. " << std::endl;
      };
    };

    //-------------------------------------------------------------------------

    class stressClientReceiveThread : public Runnable
    {
    public:
      ISocketPtr m_socket;
      int m_maxBursts;
      int m_threadMessageNo[m_maxSockets];
      unsigned char m_messageBuffer[m_maxSockets][1000];
      size_t m_messagePos[ m_maxSockets ];
      int m_threads;
      int m_finished;
      Poll m_poll;

      stressClientReceiveThread( int maxBursts )
        : m_threads( 0 )
        , m_finished( 0 )
        , m_poll( m_maxSockets )
      {
        m_maxBursts = maxBursts;
      };

      virtual ~stressClientReceiveThread() {};

      void endThread() {};
      const std::string desc() const
      {
        return "recThread";
      };

      void addSocket( ISocketPtr socket )
      {
        m_threads++;
        if (m_threads>=m_maxSockets)
          throw GenericSocketException("too many sockets in sender thread");
        m_threadMessageNo[m_threads]=0;
        m_messagePos[m_threads]=0;
        socket->setContext( m_threads );

        //coral::lock_guard lock(m_pollMutex);
        m_poll.addSocket( socket, Poll::P_READ );
      };

      void operator()()
      {
        while ((m_finished == 0) || (m_finished != m_threads))
        {
          // protect with mutex?
        nextPoll:
          int ready = m_poll.poll(200);
          while (ready>0) {
            ISocketPtr socket=m_poll.getNextReadySocket();
            size_t no = (size_t)socket->getContext();
            unsigned char* buffer=m_messageBuffer[ no ];
            size_t &pos( m_messagePos[ no ] );
            CTLPacketHeader *ctlHeader=(CTLPacketHeader*)buffer;

          read_again:
            //std::cout << no <<" reading header pos " << pos << std::endl;;
            if ( pos < CTLPACKET_HEADER_SIZE )
              pos+=socket->read( buffer + pos,
                                 CTLPACKET_HEADER_SIZE - pos,
                                 0 );
            if ( pos < CTLPACKET_HEADER_SIZE)
            {
              //std::cout << no << " header not complete pos " << pos << std::endl;
              ready--;
              continue;
            };

            //std::cout << no <<" reading payload " << pos << std::endl;
            pos += socket->read( buffer + pos,
                                 ctlHeader->packetSize() - pos,
                                 0 );
            if ( pos != ctlHeader->packetSize() )
            {
              //std::cout << no <<" payload not complete" << pos << std::endl;
              ready--;
              continue;
            };

            //std::cout << no <<" payload complete" << pos << std::endl;
            // recieved full packet
            pos = 0;
            m_threadMessageNo[no]++;
            if ( m_threadMessageNo[no] == m_maxBursts*m_messageBurst)
            {
              m_poll.removeSocket(socket);
              m_finished++;
              goto nextPoll;
            }

            goto read_again;
          };
        };
        LOG << "receive thread finished " << std::endl;
      };
    };

  }
}

//-----------------------------------------------------------------------------

// Namespace
using namespace coral::CoralSockets;

/** @file dummySocketClient.cpp
 *
 *  @author Andrea Valassi and Martin Wache
 *  @date   2007-12-26
 *///

int main( int argc, char** argv )
{

  try
  {

    // Get the server parameters
    std::string host;
    int port;
    //bool debug = false;
    int nBursts=100;
    int nSockets=10;
    if ( argc == 1 )
    {
      host = "localhost";
      port = 50017;
      //debug = true;
    }

    else if ( (argc == 4) || (argc == 5) )
    {
      host = argv[1];
      port = atoi( argv[2] );
      nSockets = atoi( argv[3] );
      if ( argc == 5  ) nBursts= atoi( argv[4] );
    }
    else
    {
      LOG << "Usage:   " << argv[0] << " [host port bufferSize sockets bursts]" << std::endl;
      LOG << "Example: " << argv[0] << " localhost 50017 10 100" << std::endl;
      //     LOG << "Example: " << argv[0] << " localhost 60017 256 1 SLAC" << std::endl;
      return 1;
    }
    // Create a client
    LOG << "Entering main" << std::endl;
    LOG << "Stress client connecting to the server on "
        << host << ":" << port << std::endl;
    LOG << "with " << nSockets << " sockets each sending " << nBursts << " bursts of " << m_messageBurst
        << " requests." << std::endl;


    ThreadManager thrMgr;
    stressClientSendThread *sendThread= new stressClientSendThread( nBursts);
    stressClientReceiveThread *recThread= new stressClientReceiveThread( nBursts);

    for (int i = 0; i<nSockets; i++)
    {
      ISocketPtr connection= TcpSocket::connectTo( host, port);
      sendThread->addSocket( connection );
      recThread->addSocket( connection );
    };

    thrMgr.addThread( recThread );
    thrMgr.addThread( sendThread );

    thrMgr.joinAll();

    LOG << "Exiting main" << std::endl;
  }

  catch( std::exception& e )
  {
    LOG << "ERROR! Standard C++ exception: '" << e.what() << "'" << std::endl;
    return 1;
  }

  catch( ... )
  {
    LOG << "ERROR! Unknown exception caught" << std::endl;
    return 1;
  }

  //printTimers();
  // Successful program termination
  return 0;

}

//-----------------------------------------------------------------------------
