
// Include files
#include <iostream>
#include <sys/time.h> // for gettimeof day debug
#include "CoralBase/../tests/Common/CoralCppUnitTest.h"
#include "CoralBase/../src/coral_thread_headers.h"
#include "CoralSockets/GenericSocketException.h"
#include "CoralSockets/NonFatalSocketException.h"

// Local include files
#include "../../src/TcpSocket.h"
#include "../../src/Poll.h"
#include "../common/testPort.h"

const unsigned char testMessage[] ="0123456789012345789";
const int testMessageLen = sizeof( testMessage ) / sizeof( testMessage[0] );

// Namespace
using namespace coral::CoralSockets;

namespace coral
{

  uint64_t getTimeMS()
  {
    timeval val;
    gettimeofday( &val, 0);
    return (uint64_t) val.tv_usec/1000 + (uint64_t) val.tv_sec*1000;
  }

  class PollTest : public CoralCppUnitTest
  {

    CPPUNIT_TEST_SUITE( PollTest );
    CPPUNIT_TEST( test_add_remove );
    CPPUNIT_TEST( test_poll );
    CPPUNIT_TEST( test_getNextReadySocket );
    CPPUNIT_TEST( test_closeSocket );
    CPPUNIT_TEST_SUITE_END();

  public:

    void setUp() {}

    void tearDown()
    {
      // Use a well-defined test port per slot, do not retry (bug #102966)
      TcpSocket::listenOn( "localhost", getTestPort() );
      /*
    retry:
      int testPort = getTestPort();
      try
      {
        TcpSocket::listenOn( "localhost", testPort );
      }
      catch (GenericSocketException &e)
      {
        std::string expMsg="Error binding socket";
        if ( expMsg == std::string( e.what(), expMsg.size() ) ) {
          testPort+=1;
          if (testPort > 50100)
            throw;
          goto retry;
        }
        else throw;
      };
      */

      //std::cout << "starting teardown sleep" << std::endl;
      //sleep(50); // to make sure old connnections are properly closed
    }

    // ------------------------------------------------------
    void test_add_remove()
    {
      Poll poller(4);
      TcpSocketPtr listenSocket = TcpSocket::listenOn( "localhost", getTestPort() );
      TcpSocketPtr conSocket1 = TcpSocket::connectTo( "localhost", getTestPort() );
      TcpSocketPtr acceptSocket1  = listenSocket->accept();


      // nothing in the poller, so one can't remove anything
      CPPUNIT_ASSERT_THROW( poller.removeSocket( listenSocket ),
                            GenericSocketException );

      poller.addSocket( listenSocket, Poll::P_READ );
      poller.addSocket( conSocket1, Poll::P_READ_WRITE );
      poller.addSocket( acceptSocket1, Poll::P_WRITE );

      // can't add one socket twice
      CPPUNIT_ASSERT_THROW( poller.addSocket( listenSocket, Poll::P_WRITE ),
                            GenericSocketException );

      poller.removeSocket( listenSocket );
      // can't remove the socket twice
      CPPUNIT_ASSERT_THROW( poller.removeSocket( listenSocket ),
                            GenericSocketException );

      poller.removeSocket(conSocket1);
      CPPUNIT_ASSERT_THROW( poller.removeSocket( conSocket1 ),
                            GenericSocketException );

      poller.removeSocket( acceptSocket1 );
      CPPUNIT_ASSERT_THROW( poller.removeSocket( acceptSocket1 ),
                            GenericSocketException );

      poller.addSocket( acceptSocket1, Poll::P_READ );
      poller.removeSocket( acceptSocket1 );

      // can't add more than slots sockets
      Poll poller2(2);
      poller2.addSocket( listenSocket, Poll::P_READ );
      poller2.addSocket( conSocket1, Poll::P_WRITE );
      CPPUNIT_ASSERT_THROW( poller2.addSocket( acceptSocket1, Poll::P_READ ),
                            GenericSocketException );
      CPPUNIT_ASSERT_THROW( poller2.removeSocket( acceptSocket1 ),
                            GenericSocketException );
      poller2.removeSocket( listenSocket );
      poller2.removeSocket( conSocket1 );
      CPPUNIT_ASSERT_THROW( poller2.removeSocket( listenSocket ),
                            GenericSocketException );
      CPPUNIT_ASSERT_THROW( poller2.removeSocket( conSocket1 ),
                            GenericSocketException );
    };
    // ------------------------------------------------------

    void test_poll()
    {
      {
        uint64_t start;
        Poll poller(5);

        CPPUNIT_ASSERT_THROW( poller.getNextReadySocket(),
                              GenericSocketException );

        // what happens if poll is called with no sockets?
        start=getTimeMS();
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "poll empty", poller.poll( 200 ), (int) 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "poll empty timeout", getTimeMS() - start > 150,
                                      true );
        CPPUNIT_ASSERT_THROW( poller.getNextReadySocket(),
                              GenericSocketException );

#if 0
        // not important, in the server we will never have the case, that
        // no sockets are in the poll class
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "poll empty no timeout ",
                                      poller.poll( 0 ), (int) 0 );
        std::cout << " timeout " << getTimeMS() - start << std::endl;
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "poll empty no timeout", getTimeMS() - start < 20,
                                      true );
        CPPUNIT_ASSERT_THROW( poller.getNextReadySocket(),
                              GenericSocketException );
#endif

        // establish a connection
        TcpSocketPtr listen=TcpSocket::listenOn( "localhost", getTestPort() );
        TcpSocketPtr connect=TcpSocket::connectTo( "localhost", getTestPort() );
        TcpSocketPtr accept=listen->accept();

        // make sure read queue is empty
        {
          const int len=3000;
          unsigned char buf[len];
          int res=0;
          do {
            res = accept->read(buf,len,100);
          } while ( res == len );
        };

        poller.addSocket( accept, Poll::P_READ );
        start=getTimeMS();
        CPPUNIT_ASSERT_EQUAL_MESSAGE("poll 1 ", poller.poll( 200 ), 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("timeout 1",  getTimeMS() - start > 150, true );
        CPPUNIT_ASSERT_THROW( poller.getNextReadySocket(),
                              GenericSocketException );

        connect->write( testMessage, testMessageLen);
        start=getTimeMS();
        CPPUNIT_ASSERT_EQUAL_MESSAGE("poll 2 ", poller.poll( 200 ), 1 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("timeout 2",  getTimeMS() - start < 20, true );

        // check that we get the correct socket back
        CPPUNIT_ASSERT_EQUAL_MESSAGE("poll 2 socket", poller.getNextReadySocket().get(),
                                     dynamic_cast<ISocket*>(accept.get()) );
        // but only one
        CPPUNIT_ASSERT_THROW( poller.getNextReadySocket(),
                              GenericSocketException );
        poller.removeSocket( accept );


        // test write poll
        // write queue is empty, so poll should return immediatly
        poller.addSocket( connect, Poll::P_WRITE );
        //poller.addSocket( listen, Poll::P_READ );
        start=getTimeMS();
        CPPUNIT_ASSERT_EQUAL_MESSAGE("poll 3", poller.poll( 200 ), 1 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "timeout 3", getTimeMS() - start < 20, true );

        // now fill the write queue and check write poll
        {
          int res=0;
          const int len=30000;
          unsigned char message[len];
          for (int i = 0; i<len; i++)
            message[i]=(unsigned char) i&0xff;

          uint64_t max_sleep=0;
          uint64_t time;

          for (int i = 0; i<10; i++ ) {
            do {
              res=connect->write( message, len);
            } while ( res == len );

            time=getTimeMS();
            poller.poll( 200 );
            time=getTimeMS()-time;

            if ( time >max_sleep )
              max_sleep = time;
            if ( time > 150 )
              break;
          };
          CPPUNIT_ASSERT_EQUAL_MESSAGE("timeout 4", max_sleep > 150, true );
#if 0
          CPPUNIT_ASSERT_EQUAL_MESSAGE("ready sockets ", ready, 1 );

          CPPUNIT_ASSERT_EQUAL_MESSAGE("poll 4 socket", poller.getNextReadySocket().get(),
                                       dynamic_cast<ISocket*>(connect.get()) );
          CPPUNIT_ASSERT_THROW( poller.getNextReadySocket(), GenericSocketException );
#endif
        };
        /*
        // this test seems to be unreliable
       // write queue is full, so poll should wait and return false
       start=getTimeMS();
       CPPUNIT_ASSERT_EQUAL_MESSAGE("poll 4", accept->poll(
            TcpSocket::P_WRITE, 200), false );
       CPPUNIT_ASSERT_EQUAL_MESSAGE( "timeout 4", getTimeMS() - start > 150, true );
        *///
        accept->close();
        connect->close();
        listen->close();

      }
    };

    // ------------------------------------------------------

    void test_getNextReadySocket()
    {
      {
        uint64_t start;
        Poll poller(10);

        // establish a connection
        TcpSocketPtr listen=TcpSocket::listenOn( "localhost", getTestPort() );

        TcpSocketPtr connect1=TcpSocket::connectTo( "localhost", getTestPort() );
        TcpSocketPtr accept1=listen->accept();
        TcpSocketPtr connect2=TcpSocket::connectTo( "localhost", getTestPort() );
        TcpSocketPtr accept2=listen->accept();
        TcpSocketPtr connect3=TcpSocket::connectTo( "localhost", getTestPort() );
        TcpSocketPtr accept3=listen->accept();
        TcpSocketPtr connect4=TcpSocket::connectTo( "localhost", getTestPort() );
        TcpSocketPtr accept4=listen->accept();
        TcpSocketPtr connect5=TcpSocket::connectTo( "localhost", getTestPort() );
        TcpSocketPtr accept5=listen->accept();

        poller.addSocket(connect1, Poll::P_READ);
        poller.addSocket(accept1, Poll::P_READ);
        poller.addSocket(connect2, Poll::P_READ);
        poller.addSocket(accept2, Poll::P_READ);
        poller.addSocket(connect3, Poll::P_READ);
        poller.addSocket(accept3, Poll::P_READ);
        poller.addSocket(connect4, Poll::P_READ);
        poller.addSocket(accept4, Poll::P_READ);
        poller.addSocket(connect5, Poll::P_READ);
        poller.addSocket(accept5, Poll::P_READ);

        start=getTimeMS();
        CPPUNIT_ASSERT_EQUAL_MESSAGE("poll 1 ", poller.poll( 200 ), 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("timeout 1",  getTimeMS() - start > 150, true );

        CPPUNIT_ASSERT_THROW( poller.getNextReadySocket(),
                              GenericSocketException );

        // write to one socket
        connect2->write( testMessage, testMessageLen);

        start=getTimeMS();
        CPPUNIT_ASSERT_EQUAL_MESSAGE("poll 2 ", poller.poll( 200 ), 1 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("timeout 2",  getTimeMS() - start < 20, true );

        CPPUNIT_ASSERT_EQUAL_MESSAGE("socket 2 ", poller.getNextReadySocket().get(),
                                     dynamic_cast<ISocket*>(accept2.get()) );

        CPPUNIT_ASSERT_THROW( poller.getNextReadySocket(),
                              GenericSocketException );

        // write to another socket
        connect5->write( testMessage, testMessageLen);

        start=getTimeMS();
        CPPUNIT_ASSERT_EQUAL_MESSAGE("poll 3 ", poller.poll( 200 ), 2 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("timeout 3",  getTimeMS() - start < 20, true );

        CPPUNIT_ASSERT_EQUAL_MESSAGE("socket 3 ", poller.getNextReadySocket().get(),
                                     dynamic_cast<ISocket*>(accept2.get()) );

        CPPUNIT_ASSERT_EQUAL_MESSAGE("socket 3 ", poller.getNextReadySocket().get(),
                                     dynamic_cast<ISocket*>(accept5.get()) );

        CPPUNIT_ASSERT_THROW( poller.getNextReadySocket(),
                              GenericSocketException );

        // remove accept2 and try again
        poller.removeSocket( accept2 );

        start=getTimeMS();
        CPPUNIT_ASSERT_EQUAL_MESSAGE("poll 4 ", poller.poll( 200 ), 1 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("timeout 4",  getTimeMS() - start < 20, true );

        CPPUNIT_ASSERT_EQUAL_MESSAGE("socket 4 ", poller.getNextReadySocket().get(),
                                     dynamic_cast<ISocket*>(accept5.get()) );

        CPPUNIT_ASSERT_THROW( poller.getNextReadySocket(),
                              GenericSocketException );


        start=getTimeMS();
        CPPUNIT_ASSERT_EQUAL_MESSAGE("poll 5 ", poller.poll( 200 ), 1 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("timeout 5",  getTimeMS() - start < 20, true );

        // this should reset the iterator
        poller.removeSocket( connect1);

        CPPUNIT_ASSERT_THROW( poller.getNextReadySocket(),
                              GenericSocketException );
      };
    };

    // ------------------------------------------------------

    void test_closeSocket()
    {
      {
        Poll poller(10);

        // establish a connection
        TcpSocketPtr listen=TcpSocket::listenOn( "localhost", getTestPort() );

        TcpSocketPtr connect1=TcpSocket::connectTo( "localhost", getTestPort() );
        TcpSocketPtr accept1=listen->accept();

        poller.addSocket(connect1, Poll::P_READ);
        poller.addSocket(accept1, Poll::P_READ);

        accept1->close();
        unsigned char dummy[100];
        CPPUNIT_ASSERT_THROW( connect1->readAll( (unsigned char*)&dummy,
                                                 sizeof(dummy )), SocketClosedException );

        int ready = poller.poll(100);
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "closed socket ready", 2, ready );

        CPPUNIT_ASSERT_EQUAL_MESSAGE("socket 1 ", poller.getNextReadySocket().get(),
                                     dynamic_cast<ISocket*>(connect1.get()) );

        CPPUNIT_ASSERT_EQUAL_MESSAGE("socket 1 closed", true,
                                     poller.currSocketClosed() );

        CPPUNIT_ASSERT_EQUAL_MESSAGE("socket 2 ", poller.getNextReadySocket().get(),
                                     dynamic_cast<ISocket*>(accept1.get()) );

        CPPUNIT_ASSERT_EQUAL_MESSAGE("socket 2 closed", true,
                                     poller.currSocketClosed() );

      };
    };

  };

  CPPUNIT_TEST_SUITE_REGISTRATION( PollTest );

}

CORALCPPUNITTEST_MAIN( PollTest )
