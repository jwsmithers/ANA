// $Id: test_SocketRequestHandler.cpp,v 1.3.2.5.2.3 2013-02-08 09:40:14 avalassi Exp $

// Include files
#include <iostream>
#include "CoralBase/../src/coral_thread_headers.h"
#include "CoralBase/MessageStream.h"
#include "CoralBase/../tests/Common/CoralCppUnitTest.h"
#include "CoralServerBase/RequestProperties.h"
#include "CoralSockets/GenericSocketException.h"

// Local include files
#include "../common/common.h"
#include "../../src/RequestIterator.h"
#include "../../src/RingBufferSocket.h"
#include "../../src/SocketRequestHandler.h"
#include "../../src/TcpSocket.h"

// Namespace
using namespace coral::CoralSockets;
using namespace coral;

typedef std::auto_ptr<ByteBuffer> ByteBufferPtr;

namespace coral
{

  class SocketRequestHandlerTest : public CoralCppUnitTest
  {

    CPPUNIT_TEST_SUITE( SocketRequestHandlerTest );
    CPPUNIT_TEST( test_Basic );
    CPPUNIT_TEST( test_Close );
    CPPUNIT_TEST( test_WrongVersionPacket );
    CPPUNIT_TEST( test_WrongChecksumPacket );
    CPPUNIT_TEST( test_WrongMagicWordPacket );
    CPPUNIT_TEST_SUITE_END();

  public:

    void setUp() {}

    void tearDown() {}

    // ---------------------------------------------------

    IByteBufferIteratorPtr getReply( IRequestHandler& handler,
                                     ByteBufferPtr buf )
    {
      RequestProperties prop;
      RequestIterator *it=new RequestIterator();
      it->addBuffer( buf, 0, true /*isLast*/ );
      return handler.replyToRequest( IByteBufferIteratorPtr( it ), prop );
    }

    // ---------------------------------------------------

    void test_Basic()
    {
      ISocketPtr src;
      ISocketPtr dst;

      // test if the normal case works as it should

      createSockets( src, dst );
      PacketSocket sSocket( src );
      PacketSocketPtr dSocket( new PacketSocket( dst ) );

      SocketRequestHandler handler( dSocket );

      ByteBufferPtr buf;

      buf = createBuffer( 10 );

      // requst a reply
      IByteBufferIteratorPtr it = getReply( handler, buf );

      // read the request from the socket
      PacketPtr packet;
      packet=sSocket.receivePacket();

      // check that this is really our packet
      CPPUNIT_ASSERT_EQUAL_MESSAGE("buffer num 1",
                                   10, getBufferNum( packet->getPayload() ) );

      // send back a reply
      buf = createBuffer( 20 );
      PacketSLAC reply( packet->getHeader().requestID(), 0 /*clientID*/,
                        0 /*segment number*/, false /* more segments*/, *buf );
      sSocket.sendPacket( reply );

      // check if the reply arrived
      CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 1", true,
                                   it->nextBuffer() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("buffer num 2",
                                   20, getBufferNum( it->currentBuffer() ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("isLastBuffer 1", true,
                                   it->isLastBuffer() );

      CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 2", false,
                                   it->nextBuffer() );

    }

    // ------------------------------------------------------
    void test_Close()
    {
      ISocketPtr src;
      ISocketPtr dst;

      // close this side of the socket before the reply arrived

      createSockets( src, dst );
      PacketSocket sSocket( src );
      PacketSocketPtr dSocket( new PacketSocket( dst ) );

      SocketRequestHandler handler( dSocket );

      ByteBufferPtr buf;

      buf = createBuffer( 10 );

      // requst a reply
      IByteBufferIteratorPtr it = getReply( handler, buf );

      // read the request from the socket
      PacketPtr packet;
      packet=sSocket.receivePacket();

      // check that this is really our packet
      CPPUNIT_ASSERT_EQUAL_MESSAGE("buffer num 1",
                                   10, getBufferNum( packet->getPayload() ) );

      // instead of replying, close the socket
      sSocket.close();

      try {
        it->nextBuffer();
        CPPUNIT_FAIL("connection closed exception expected");
      }
      catch( GenericSocketException & e) {
        std::string expMsg="connection closed";
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "exception message",
                                      expMsg, std::string( e.what(), expMsg.size() ) );
        // cut CORAL info
      }
    }

    // ------------------------------------------------------

    void test_WrongVersionPacket()
    {
      ISocketPtr src;
      ISocketPtr dst;

      // send "wrong version" packet as reply

      createSockets( src, dst );
      PacketSocket sSocket( src );
      PacketSocketPtr dSocket( new PacketSocket( dst ) );

      SocketRequestHandler handler( dSocket );

      ByteBufferPtr buf;

      buf = createBuffer( 10 );

      // requst a reply
      IByteBufferIteratorPtr it = getReply( handler, buf );

      // read the request from the socket
      PacketPtr packet;
      packet=sSocket.receivePacket();

      // check that this is really our packet
      CPPUNIT_ASSERT_EQUAL_MESSAGE("buffer num 1",
                                   10, getBufferNum( packet->getPayload() ) );

      // send back a reply with status "wrong version"
      buf = createBuffer( 20 );

      CTLPacketHeader header(
                             CTLWrongVersion,
                             CTLPACKET_HEADER_SIZE+buf->usedSize() /*packet size*/,
                             0, // request id
                             0, //  client id
                             0, //  segment number
                             false, //  more segments
                             CTLPacketHeader::computeChecksum( buf->data(), buf->usedSize() )+40
                             );

      src->writeAll( header.data(), CTLPACKET_HEADER_SIZE );
      src->writeAll( buf->data(), buf->usedSize() );

      MsgLevel lvl = MessageStream::msgVerbosity();
      try
      {
        MessageStream::setMsgVerbosity( Fatal );
        it->nextBuffer();
        CPPUNIT_FAIL("connection closed exception expected");
      }
      catch( GenericSocketException& e )
      {
        MessageStream::setMsgVerbosity( lvl );
        std::string expMsg="connection closed";
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "exception message",
                                      expMsg, std::string( e.what(), expMsg.size() ) ); // cut CORAL info
      }
      catch( ... )
      {
        MessageStream::setMsgVerbosity( lvl );
        throw;
      }

    }

    // ------------------------------------------------------
    void test_WrongChecksumPacket()
    {
      ISocketPtr src;
      ISocketPtr dst;

      // send "wrong checksum" packet as reply

      createSockets( src, dst );
      PacketSocket sSocket( src );
      PacketSocketPtr dSocket( new PacketSocket( dst ) );

      SocketRequestHandler handler( dSocket );

      ByteBufferPtr buf;

      buf = createBuffer( 10 );

      // requst a reply
      IByteBufferIteratorPtr it = getReply( handler, buf );

      // read the request from the socket
      PacketPtr packet;
      packet=sSocket.receivePacket();

      // check that this is really our packet
      CPPUNIT_ASSERT_EQUAL_MESSAGE("buffer num 1",
                                   10, getBufferNum( packet->getPayload() ) );

      // send back a reply with status "wrong version"
      buf = createBuffer( 20 );

      CTLPacketHeader header(
                             CTLWrongChecksum,
                             CTLPACKET_HEADER_SIZE+buf->usedSize() /*packet size*/,
                             0, // request id
                             0, //  client id
                             0, //  segment number
                             false, //  more segments
                             CTLPacketHeader::computeChecksum( buf->data(), buf->usedSize() )+40
                             );

      src->writeAll( header.data(), CTLPACKET_HEADER_SIZE );
      src->writeAll( buf->data(), buf->usedSize() );

      MsgLevel lvl = MessageStream::msgVerbosity();
      try
      {
        MessageStream::setMsgVerbosity( Fatal );
        it->nextBuffer();
        CPPUNIT_FAIL("connection closed exception expected");
      }
      catch( GenericSocketException& e )
      {
        MessageStream::setMsgVerbosity( lvl );
        std::string expMsg="connection closed";
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "exception message",
                                      expMsg, std::string( e.what(), expMsg.size() ) ); // cut CORAL info
      }
      catch( ... )
      {
        MessageStream::setMsgVerbosity( lvl );
        throw;
      }

    }

    // ------------------------------------------------------

    void test_WrongMagicWordPacket()
    {
      ISocketPtr src;
      ISocketPtr dst;

      // send "wrong checksum" packet as reply

      createSockets( src, dst );
      PacketSocket sSocket( src );
      PacketSocketPtr dSocket( new PacketSocket( dst ) );

      SocketRequestHandler handler( dSocket );

      ByteBufferPtr buf;

      buf = createBuffer( 10 );

      // requst a reply
      IByteBufferIteratorPtr it = getReply( handler, buf );

      // read the request from the socket
      PacketPtr packet;
      packet=sSocket.receivePacket();

      // check that this is really our packet
      CPPUNIT_ASSERT_EQUAL_MESSAGE("buffer num 1",
                                   10, getBufferNum( packet->getPayload() ) );

      // send back a reply with status "wrong version"
      buf = createBuffer( 20 );

      CTLPacketHeader header(
                             CTLWrongMagicWord,
                             CTLPACKET_HEADER_SIZE+buf->usedSize() /*packet size*/,
                             0, // request id
                             0, //  client id
                             0, //  segment number
                             false, //  more segments
                             CTLPacketHeader::computeChecksum( buf->data(), buf->usedSize() )+40
                             );

      src->writeAll( header.data(), CTLPACKET_HEADER_SIZE );
      src->writeAll( buf->data(), buf->usedSize() );

      MsgLevel lvl = MessageStream::msgVerbosity();
      try
      {
        MessageStream::setMsgVerbosity( Fatal );
        it->nextBuffer();
        CPPUNIT_FAIL("connection closed exception expected");
      }
      catch( GenericSocketException& e )
      {
        MessageStream::setMsgVerbosity( lvl );
        std::string expMsg="connection closed";
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "exception message",
                                      expMsg, std::string( e.what(), expMsg.size() ) ); // cut CORAL info
      }
      catch( ... )
      {
        MessageStream::setMsgVerbosity( lvl );
        throw;
      }

    }

  };

  CPPUNIT_TEST_SUITE_REGISTRATION( SocketRequestHandlerTest );

}

CORALCPPUNITTEST_MAIN( SocketRequestHandlerTest )
