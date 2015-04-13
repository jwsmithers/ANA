// $Id: test_SocketContext.cpp,v 1.8.2.4 2013-02-08 09:40:13 avalassi Exp $

// Include files
#include <cstring>
#include <iostream>
#include "CoralServerBase/ConnectionProperties.h"
#include "CoralServerBase/RequestProperties.h"
#include "CoralBase/../tests/Common/CoralCppUnitTest.h"
#include "CoralSockets/GenericSocketException.h"

// Local include files
#include "../../src/DummyRequestHandler.h"
#include "../../src/RingBufferSocket.h"
#include "../../src/RequestIterator.h"
#include "../../src/SocketContext.h"
#include "../../src/TcpSocket.h"
#include "../../src/ThreadManager.h"
#include "../common/common.h"

// Namespace
using namespace coral::CoralSockets;

namespace coral
{

  class SocketContextTest : public CoralCppUnitTest
  {

    CPPUNIT_TEST_SUITE( SocketContextTest );
    CPPUNIT_TEST( test_Basic );
    CPPUNIT_TEST( test_multiSegments );
    CPPUNIT_TEST( test_multiSegmentsRequest );
    CPPUNIT_TEST( test_Close );
    CPPUNIT_TEST( test_WrongVersionPacket );
    CPPUNIT_TEST( test_WrongChecksumPacket );
    CPPUNIT_TEST( test_WrongMagicWordPacket );
    CPPUNIT_TEST_SUITE_END();

  public:

    void setUp() {}

    void tearDown() {
    }

    class RunHandleRequest : public Runnable
    {
    public:

      RunHandleRequest( SocketContext *SContext)
        : m_SContext( SContext)
      {
      }

      ~RunHandleRequest()
      {
        delete m_SContext;
      }

      const std::string desc() const
      {
        return "ReplyConsumerClass";
      }

      void endThread()
      {}

      void operator()() {
        while ( m_SContext->isActive() ) {
          PacketPtr packet = m_SContext->getNextRequest();
          m_SContext->handleRequest( packet );
        };
      }

    private:
      SocketContext *m_SContext;
    };

    // ------------------------------------------------------

    IByteBufferIteratorPtr getReply( IRequestHandler & handler, ByteBufferPtr buf )
    {
      RequestProperties prop;
      RequestIterator *it=new RequestIterator();
      it->addBuffer( buf, 0, true /*isLast*/ );
      return handler.replyToRequest( IByteBufferIteratorPtr( it ), prop );
    }

    // ------------------------------------------------------

    void test_Basic()
    {
      ISocketPtr src;
      ISocketPtr dst;

      // test if the normal case works as it should

      createSockets( src, dst );
      PacketSocket sSocket( src );
      PacketSocketPtr dSocket( new PacketSocket( dst ) );

      DummyRequestHandler handler;
      ThreadManager thrManager;

      thrManager.addThread(
                           new RunHandleRequest(
                                                new SocketContext( new DummyRequestHandler(), dSocket ) )
                           );


      try {
        ByteBufferPtr buf;

        // send a request
        buf = createBuffer( 10 );
        {
          PacketSLAC request( 1 /*requestID*/,
                              0 /*clientID*/,
                              0 /*segment number*/,
                              false /* more segments*/,
                              *buf );
          sSocket.sendPacket( request );
          PacketPtr reply=sSocket.receivePacket();
          IByteBufferIteratorPtr expectedReply=getReply( handler, buf );

          CPPUNIT_ASSERT_EQUAL_MESSAGE("requestID 1",
                                       (uint32_t) 1, reply->getHeader().requestID() );
          CPPUNIT_ASSERT_EQUAL_MESSAGE("clientID 1",
                                       (uint32_t) 0, reply->getHeader().clientID() );
          CPPUNIT_ASSERT_EQUAL_MESSAGE("segmentNumber 1",
                                       (uint32_t) 0, reply->getHeader().segmentNumber() );
          CPPUNIT_ASSERT_EQUAL_MESSAGE("more segments 1",
                                       false, reply->getHeader().moreSegments() );

          expectedReply->nextBuffer();
          checkByteBuffer( "check 1", reply->getPayload(),
                           expectedReply->currentBuffer() );
          CPPUNIT_ASSERT_EQUAL_MESSAGE( "nextBuffer 1", false, expectedReply->nextBuffer() );
        }

        {
          // send with a different clientID request, test if the answer
          // comes back with the same client ID
          buf = createBuffer( 10 );
          PacketSLAC request( 2 /*requestID*/, 1 /*clientID*/,
                              0 /*segment number*/, false /* more segments*/, *buf );
          sSocket.sendPacket( request );

          PacketPtr reply=sSocket.receivePacket();
          IByteBufferIteratorPtr expectedReply=getReply( handler, buf );

          CPPUNIT_ASSERT_EQUAL_MESSAGE("requestID 2",
                                       (uint32_t) 2, reply->getHeader().requestID() );
          CPPUNIT_ASSERT_EQUAL_MESSAGE("clientID 2",
                                       (uint32_t) 1, reply->getHeader().clientID() );
          CPPUNIT_ASSERT_EQUAL_MESSAGE("segmentNumber 2",
                                       (uint32_t) 0, reply->getHeader().segmentNumber() );
          CPPUNIT_ASSERT_EQUAL_MESSAGE("more segments 2",
                                       false, reply->getHeader().moreSegments() );

          expectedReply->nextBuffer();
          checkByteBuffer( "check 1", reply->getPayload(),
                           expectedReply->currentBuffer() );
          CPPUNIT_ASSERT_EQUAL_MESSAGE( "nextBuffer 1", false, expectedReply->nextBuffer() );
        }
      }
      catch(...) {
        sSocket.close();
        throw;
      }
      sSocket.close();

    }

    // ------------------------------------------------------

    void test_multiSegments()
    {
      ISocketPtr src;
      ISocketPtr dst;
      createSockets( src, dst );
      PacketSocket sSocket( src );
      PacketSocketPtr dSocket( new PacketSocket( dst ) );
      DummyRequestHandler handler;
      ThreadManager thrManager;
      thrManager.addThread(
                           new RunHandleRequest( new SocketContext( new DummyRequestHandler(), dSocket ) ) );

      // test if the normal case works as it should
      try {
        ByteBufferPtr buf=string2ByteBuffer("copy 5 this is a multi byte"
                                            " buffer request");

        // send a request
        PacketSLAC request( 1 /*requestID*/, 0 /*clientID*/,
                            0 /*segment number*/, false /* more segments*/, *buf );
        sSocket.sendPacket( request );
        IByteBufferIteratorPtr expectedReply=getReply( handler, buf );
        PacketPtr reply;

        reply=sSocket.receivePacket();
        CPPUNIT_ASSERT_EQUAL_MESSAGE("requestID 1",
                                     (uint32_t) 1, reply->getHeader().requestID() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("clientID 1",
                                     (uint32_t) 0, reply->getHeader().clientID() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("segmentNumber 1",
                                     (uint32_t) 0, reply->getHeader().segmentNumber() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("more segments 1",
                                     true, reply->getHeader().moreSegments() );

        CPPUNIT_ASSERT_EQUAL_MESSAGE( "nextBuffer 1", true, expectedReply->nextBuffer() );
        checkByteBuffer( "check 1", reply->getPayload(),
                         expectedReply->currentBuffer() );

        reply=sSocket.receivePacket();
        CPPUNIT_ASSERT_EQUAL_MESSAGE("requestID 2",
                                     (uint32_t) 1, reply->getHeader().requestID() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("clientID 2",
                                     (uint32_t) 0, reply->getHeader().clientID() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("segmentNumber 2",
                                     (uint32_t) 1, reply->getHeader().segmentNumber() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("more segments 2",
                                     true, reply->getHeader().moreSegments() );

        CPPUNIT_ASSERT_EQUAL_MESSAGE( "nextBuffer 2", true, expectedReply->nextBuffer() );
        checkByteBuffer( "check 2", reply->getPayload(),
                         expectedReply->currentBuffer() );


        reply=sSocket.receivePacket();
        CPPUNIT_ASSERT_EQUAL_MESSAGE("requestID 3",
                                     (uint32_t) 1, reply->getHeader().requestID() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("clientID 3",
                                     (uint32_t) 0, reply->getHeader().clientID() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("segmentNumber 3",
                                     (uint32_t) 2, reply->getHeader().segmentNumber() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("more segments 3",
                                     true, reply->getHeader().moreSegments() );

        CPPUNIT_ASSERT_EQUAL_MESSAGE( "nextBuffer 3", true, expectedReply->nextBuffer() );
        checkByteBuffer( "check 3", reply->getPayload(),
                         expectedReply->currentBuffer() );


        reply=sSocket.receivePacket();
        CPPUNIT_ASSERT_EQUAL_MESSAGE("requestID 4",
                                     (uint32_t)1, reply->getHeader().requestID() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("clientID 4",
                                     (uint32_t)0, reply->getHeader().clientID() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("segmentNumber 4",
                                     (uint32_t)3, reply->getHeader().segmentNumber() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("more segments 4",
                                     true, reply->getHeader().moreSegments() );

        CPPUNIT_ASSERT_EQUAL_MESSAGE( "nextBuffer 4", true, expectedReply->nextBuffer() );
        checkByteBuffer( "check 4", reply->getPayload(),
                         expectedReply->currentBuffer() );


        reply=sSocket.receivePacket();
        CPPUNIT_ASSERT_EQUAL_MESSAGE("requestID 5",
                                     (uint32_t)1, reply->getHeader().requestID() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("clientID 5",
                                     (uint32_t)0, reply->getHeader().clientID() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("segmentNumber 5",
                                     (uint32_t)4, reply->getHeader().segmentNumber() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("more segments 5",
                                     false, reply->getHeader().moreSegments() );

        CPPUNIT_ASSERT_EQUAL_MESSAGE( "nextBuffer 5", true, expectedReply->nextBuffer() );
        checkByteBuffer( "check 5", reply->getPayload(),
                         expectedReply->currentBuffer() );


        CPPUNIT_ASSERT_EQUAL_MESSAGE( "nextBuffer 6", false, expectedReply->nextBuffer() );
      }
      catch (...) {
        sSocket.close();
        throw;
      }
      sSocket.close();

    }

    // ------------------------------------------------------

    void test_multiSegmentsRequest()
    {
      ISocketPtr src;
      ISocketPtr dst;
      createSockets( src, dst );
      PacketSocket sSocket( src );
      PacketSocketPtr dSocket( new PacketSocket( dst ) );
      DummyRequestHandler handler;
      ThreadManager thrManager;
      thrManager.addThread(
                           new RunHandleRequest( new SocketContext( new DummyRequestHandler(), dSocket ) ) );

      // test if the normal case works as it should
      try {

        RequestIterator* it( new RequestIterator() );
        // send a request

        ByteBufferPtr reqBuf = string2ByteBuffer("this is a multi ByteBuffer request 1" );
        {
          PacketSLAC request( 1 /*requestID*/, 0 /*clientID*/,
                              0 /*segment number*/, true /* more segments*/,
                              *reqBuf );
          sSocket.sendPacket( request );
          it->addBuffer( reqBuf, 0, false);
        }

        {
          reqBuf = string2ByteBuffer("this is a multi ByteBuffer request 2" );
          PacketSLAC request( 1 /*requestID*/, 0 /*clientID*/,
                              1 /*segment number*/, true /* more segments*/,
                              *reqBuf );
          sSocket.sendPacket( request );
          it->addBuffer( reqBuf, 1, false);
        }

        {
          reqBuf = string2ByteBuffer("this is a multi ByteBuffer request 3" );
          PacketSLAC request( 1 /*requestID*/, 0 /*clientID*/,
                              2 /*segment number*/, true /* more segments*/,
                              *reqBuf );
          sSocket.sendPacket( request );
          it->addBuffer( reqBuf, 2, false);
        }

        {
          reqBuf = string2ByteBuffer("this is a multi ByteBuffer request 4" );
          PacketSLAC request( 1 /*requestID*/, 0 /*clientID*/,
                              3 /*segment number*/, false /* more segments*/, *reqBuf);
          sSocket.sendPacket( request );
          it->addBuffer( reqBuf, 3, true);
        }

        RequestProperties prop;
        IByteBufferIteratorPtr expectedReply=handler.replyToRequest(
                                                                    IByteBufferIteratorPtr( it ), prop );
        PacketPtr reply;

        reply=sSocket.receivePacket();
        CPPUNIT_ASSERT_EQUAL_MESSAGE("requestID 1",
                                     (uint32_t) 1, reply->getHeader().requestID() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("clientID 1",
                                     (uint32_t) 0, reply->getHeader().clientID() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("segmentNumber 1",
                                     (uint32_t) 0, reply->getHeader().segmentNumber() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("more segments 1",
                                     true, reply->getHeader().moreSegments() );

        CPPUNIT_ASSERT_EQUAL_MESSAGE( "nextBuffer 1", true, expectedReply->nextBuffer() );
        checkByteBuffer( "check 1", reply->getPayload(),
                         expectedReply->currentBuffer() );

        reply=sSocket.receivePacket();
        CPPUNIT_ASSERT_EQUAL_MESSAGE("requestID 2",
                                     (uint32_t) 1, reply->getHeader().requestID() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("clientID 2",
                                     (uint32_t) 0, reply->getHeader().clientID() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("segmentNumber 2",
                                     (uint32_t) 1, reply->getHeader().segmentNumber() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("more segments 2",
                                     true, reply->getHeader().moreSegments() );

        CPPUNIT_ASSERT_EQUAL_MESSAGE( "nextBuffer 2", true, expectedReply->nextBuffer() );
        checkByteBuffer( "check 2", reply->getPayload(),
                         expectedReply->currentBuffer() );


        reply=sSocket.receivePacket();
        CPPUNIT_ASSERT_EQUAL_MESSAGE("requestID 3",
                                     (uint32_t) 1, reply->getHeader().requestID() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("clientID 3",
                                     (uint32_t) 0, reply->getHeader().clientID() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("segmentNumber 3",
                                     (uint32_t) 2, reply->getHeader().segmentNumber() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("more segments 3",
                                     true, reply->getHeader().moreSegments() );

        CPPUNIT_ASSERT_EQUAL_MESSAGE( "nextBuffer 3", true, expectedReply->nextBuffer() );
        checkByteBuffer( "check 3", reply->getPayload(),
                         expectedReply->currentBuffer() );


        reply=sSocket.receivePacket();
        CPPUNIT_ASSERT_EQUAL_MESSAGE("requestID 4",
                                     (uint32_t)1, reply->getHeader().requestID() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("clientID 4",
                                     (uint32_t)0, reply->getHeader().clientID() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("segmentNumber 4",
                                     (uint32_t)3, reply->getHeader().segmentNumber() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("more segments 4",
                                     false, reply->getHeader().moreSegments() );

        CPPUNIT_ASSERT_EQUAL_MESSAGE( "nextBuffer 4", true, expectedReply->nextBuffer() );
        checkByteBuffer( "check 4", reply->getPayload(),
                         expectedReply->currentBuffer() );

        CPPUNIT_ASSERT_EQUAL_MESSAGE( "nextBuffer 5", false, expectedReply->nextBuffer() );

      }
      catch (...) {
        sSocket.close();
        throw;
      }
      sSocket.close();
    }

    // ------------------------------------------------------

    void test_Close()
    {
      ISocketPtr src;
      ISocketPtr dst;

      // test that the thread can handle closed connections properly

      createSockets( src, dst );
      PacketSocket sSocket( src );
      PacketSocketPtr dSocket( new PacketSocket( dst ) );

      ThreadManager thrManager;
      thrManager.addThread(
                           new RunHandleRequest( new SocketContext( new DummyRequestHandler(), dSocket ) ) );

      ByteBufferPtr buf;

      // send a request
      buf = createBuffer( 10 );
      PacketSLAC request( 1 /*requestID*/, 0 /*clientID*/,
                          0 /*segment number*/, false /* more segments*/, *buf );
      sSocket.sendPacket( request );

      // close the socket instead of waiting for a reply
      sSocket.close();

      // not sure how to test that properly... at least it should not
      // crash, or wait forever ;-)
    }

    // ------------------------------------------------------

    void test_WrongVersionPacket()
    {
      ISocketPtr src;
      ISocketPtr dst;

      // test if the server sends back a "wrong version packet"
      // if it receives a packet with the wrong ctl version

      createSockets( src, dst );
      PacketSocket sSocket( src );
      PacketSocketPtr dSocket( new PacketSocket( dst ) );

      DummyRequestHandler handler;
      ThreadManager thrManager;
      thrManager.addThread(
                           new RunHandleRequest( new SocketContext( new DummyRequestHandler(), dSocket ) ) );

      ByteBufferPtr buf;

      // send a request
      buf = createBuffer( 10 );

      CTLPacketHeader header(CTLOK,
                             CTLPACKET_HEADER_SIZE + buf->usedSize(), // packet size
                             0, // request id
                             0, //  client id
                             0, //  segment number
                             false, //  more segments
                             CTLPacketHeader::computeChecksum( buf->data(), buf->usedSize() )
                             );

      unsigned char charHeader[CTLPACKET_HEADER_SIZE];
      ::memcpy( &charHeader[0], header.data(), CTLPACKET_HEADER_SIZE );
      // manipulate the version
      charHeader[2] = 0x1 | 0x00;

      // send all
      src->writeAll( &charHeader[0], CTLPACKET_HEADER_SIZE );
      src->writeAll( buf->data(), buf->usedSize() );

      // receive the packet on the other end
      try
      {
        sSocket.receivePacket();
        CPPUNIT_FAIL("expected packet wrong version exception");
      }
      catch( PacketStatusNotOkException& e)
      {
        std::string expMsg="Received a packet with status WrongVersion";
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "exception message",
                                      expMsg, std::string( e.what(), expMsg.size() ) );
        // cut CORAL info

      }
      src->close();
    }

    // ------------------------------------------------------

    void test_WrongChecksumPacket()
    {
      ISocketPtr src;
      ISocketPtr dst;

      // test if the server sends back a "wrong checksum packet"
      // if it receives a packet with the wrong checksum

      createSockets( src, dst );
      PacketSocket sSocket( src );
      PacketSocketPtr dSocket( new PacketSocket( dst ) );

      ThreadManager thrManager;
      thrManager.addThread(
                           new RunHandleRequest( new SocketContext( new DummyRequestHandler(), dSocket ) ) );

      ByteBufferPtr buf;

      // send a request
      buf = createBuffer( 10 );

      CTLPacketHeader header(CTLOK,
                             CTLPACKET_HEADER_SIZE + buf->usedSize(), // packet size
                             0, // request id
                             0, //  client id
                             0, //  segment number
                             false, //  more segments
                             CTLPacketHeader::computeChecksum( buf->data(), buf->usedSize()-3 )
                             );


      // send all
      src->writeAll( header.data(), CTLPACKET_HEADER_SIZE );
      src->writeAll( buf->data(), buf->usedSize() );

      // receive the packet on the other end
      try
      {
        sSocket.receivePacket();
        CPPUNIT_FAIL("expected packet wrong checksum");
      }
      catch( PacketStatusNotOkException& e)
      {
        std::string expMsg="Received a packet with status WrongChecksum";
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "exception message",
                                      expMsg, std::string( e.what(), expMsg.size() ) );
        // cut CORAL info

      }
      src->close();
    }

    // ------------------------------------------------------

    void test_WrongMagicWordPacket()
    {
      ISocketPtr src;
      ISocketPtr dst;

      // test if the server sends back a "wrong magic word packet"
      // if it receives a packet with the wrong ctl version

      createSockets( src, dst );
      PacketSocket sSocket( src );
      PacketSocketPtr dSocket( new PacketSocket( dst ) );

      ThreadManager thrManager;
      thrManager.addThread(
                           new RunHandleRequest( new SocketContext( new DummyRequestHandler(), dSocket ) ) );

      ByteBufferPtr buf;

      // send a request
      buf = createBuffer( 10 );

      CTLPacketHeader header(CTLOK,
                             CTLPACKET_HEADER_SIZE + buf->usedSize(), // packet size
                             0, // request id
                             0, //  client id
                             0, //  segment number
                             false, //  more segments
                             CTLPacketHeader::computeChecksum( buf->data(), buf->usedSize() )
                             );

      unsigned char charHeader[CTLPACKET_HEADER_SIZE];
      ::memcpy( &charHeader[0], header.data(), CTLPACKET_HEADER_SIZE );
      // manipulate the magic word
      charHeader[1] = 0x1;

      // send all
      src->writeAll( &charHeader[0], CTLPACKET_HEADER_SIZE );
      src->writeAll( buf->data(), buf->usedSize() );

      // receive the packet on the other end
      try
      {
        sSocket.receivePacket();
        CPPUNIT_FAIL("expected packet wrong magic word exception");
      }
      catch( PacketStatusNotOkException& e)
      {
        std::string expMsg="Received a packet with status WrongMagicWord";
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "exception message",
                                      expMsg, std::string( e.what(), expMsg.size() ) );
        // cut CORAL info

      }
      src->close();
    }
  };

  CPPUNIT_TEST_SUITE_REGISTRATION( SocketContextTest );

}

CORALCPPUNITTEST_MAIN( SocketContextTest )
