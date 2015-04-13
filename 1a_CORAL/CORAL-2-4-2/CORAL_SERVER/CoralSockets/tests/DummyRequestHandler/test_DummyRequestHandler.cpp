// $Id: test_DummyRequestHandler.cpp,v 1.2.2.4.2.4 2013-02-08 09:40:11 avalassi Exp $

// Include files
#include <iostream>
//#include "CoralBase/../src/coral_thread_headers.h"
#include "CoralBase/../tests/Common/CoralCppUnitTest.h"
#include "CoralServerBase/ConnectionProperties.h"
#include "CoralServerBase/RequestProperties.h"
#include "CoralSockets/GenericSocketException.h"

// Local include files
#include "../../src/DummyRequestHandler.h"

// Namespace
using namespace coral::CoralSockets;

namespace coral
{

  class DummyRequestHandlerTest : public CoralCppUnitTest
  {

    CPPUNIT_TEST_SUITE( DummyRequestHandlerTest );
    // CPPUNIT_TEST( test_SimpleReplyIterator );
    CPPUNIT_TEST( test_DummyRequestHandler );
    CPPUNIT_TEST( test_DummyRequestHandler_MultiReply );
    CPPUNIT_TEST( test_DummyRequestHandler_MultiRequest );
    CPPUNIT_TEST_SUITE_END();

  public:

    void setUp() {}

    void tearDown() {}

    // ---------------------------------------------------

    // helpers
    static std::auto_ptr<ByteBuffer> createBuffer( int num )
    {
      std::auto_ptr<ByteBuffer> buf( new ByteBuffer( sizeof( int ) ) );
      *((int*)buf->data()) = num;
      return buf;
    };

    static int getBufferNum( std::auto_ptr<ByteBuffer> buf )
    {
      return *(int*)buf->data();
    };

    static int getBufferNum( const ByteBuffer& buf ) {
      return *(int*)buf.data();
    };

    std::auto_ptr<ByteBuffer> string2ByteBuffer( std::string str )
    {
      std::auto_ptr<ByteBuffer> result( new ByteBuffer( str.length() ) );
      const char * cstr=str.c_str();
      for (unsigned int i=0; i<str.length(); i++ )
        *(result->data()+i) = *(cstr+i);
      result->setUsedSize( str.length() );
      return result;
    }

    std::string byteBuffer2String( const ByteBuffer& buf ) {
      return std::string( (char*)buf.data(), buf.usedSize() );
    };

    // ------------------------------------------------------

#if 0
    void test_SimpleReplyIterator()
    {
      {
        SimpleReplyIterator it( createBuffer( 1 ), false );

        // nextBuffer() throws before it received the last message
        CPPUNIT_ASSERT_THROW( it.nextBuffer(),
                              GenericSocketException );

        it.addBuffer( createBuffer( 2 ), false );
        it.addBuffer( createBuffer( 3 ), true );

        // after inserting a last buffer, no buffers are accepted any more
        CPPUNIT_ASSERT_THROW( it.addBuffer( createBuffer( 4 ), true ),
                              GenericSocketException );

        // currentBuffer throws before calling nextBuffer()
        CPPUNIT_ASSERT_THROW( it.currentBuffer(),
                              GenericSocketException );
        CPPUNIT_ASSERT_THROW( it.isLastBuffer(),
                              GenericSocketException );

        CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 1",
                                     true, it.nextBuffer() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("buffer 1",
                                     1, getBufferNum( it.currentBuffer() ) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("isLastBuffer 1",
                                     false, it.isLastBuffer() );

        CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 2",
                                     true, it.nextBuffer() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("buffer 2",
                                     2, getBufferNum( it.currentBuffer() ) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("isLastBuffer 2",
                                     false, it.isLastBuffer() );

        CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 3",
                                     true, it.nextBuffer() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("buffer 3",
                                     3, getBufferNum( it.currentBuffer() ) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE("isLastBuffer 3",
                                     true, it.isLastBuffer() );

        CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 4",
                                     false, it.nextBuffer() );

        // currentBuffer throws after nextBuffer() return false
        CPPUNIT_ASSERT_THROW( it.currentBuffer(),
                              GenericSocketException );
        CPPUNIT_ASSERT_THROW( it.isLastBuffer(),
                              GenericSocketException );
      }
    }
#endif

    // ------------------------------------------------------

    void test_DummyRequestHandler()
    {
      DummyRequestHandler handler;

      std::auto_ptr<ByteBuffer> buf =
        string2ByteBuffer("This is a request");

      RequestIterator* req( new RequestIterator() );
      req->addBuffer( buf, 0, true);
      RequestProperties prop;
      IByteBufferIteratorPtr it =
        handler.replyToRequest( IByteBufferIteratorPtr( req ), prop );

      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 1 nextBuffer",
                                   it->nextBuffer(), true );

      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 1 buffer",
                                   byteBuffer2String( it->currentBuffer() ),
                                   std::string( "Thank you for your request 'This is a request") );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 1 isLastBuffer",
                                   it->isLastBuffer(), true );

      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 1 nextBuffer last",
                                   it->nextBuffer(), false );
    }

    // ------------------------------------------------------

    void test_DummyRequestHandler_MultiReply()
    {
      DummyRequestHandler handler;

      std::auto_ptr<ByteBuffer> buf =
        string2ByteBuffer("copy 5 This is a request");
      RequestIterator* req( new RequestIterator() );
      req->addBuffer( buf, 0, true);
      RequestProperties prop;
      IByteBufferIteratorPtr it=handler.replyToRequest(
                                                       IByteBufferIteratorPtr( req ), prop );

      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 1 nextBuffer",
                                   it->nextBuffer(), true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 1 buffer",
                                   byteBuffer2String( it->currentBuffer() ),
                                   std::string( "Thank you for your request 0 'copy 5 This is a request") );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 1 isLastBuffer",
                                   it->isLastBuffer(), false );


      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 2 nextBuffer",
                                   it->nextBuffer(), true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 2 buffer",
                                   byteBuffer2String( it->currentBuffer() ),
                                   std::string( "Thank you for your request 1 'copy 5 This is a request") );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 2 isLastBuffer",
                                   it->isLastBuffer(), false );


      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 3 nextBuffer",
                                   it->nextBuffer(), true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 3 buffer",
                                   byteBuffer2String( it->currentBuffer() ),
                                   std::string( "Thank you for your request 2 'copy 5 This is a request") );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 3 isLastBuffer",
                                   it->isLastBuffer(), false );


      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 4 nextBuffer",
                                   it->nextBuffer(), true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 4 buffer",
                                   byteBuffer2String( it->currentBuffer() ),
                                   std::string( "Thank you for your request 3 'copy 5 This is a request") );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 4 isLastBuffer",
                                   it->isLastBuffer(), false );


      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 5 nextBuffer",
                                   it->nextBuffer(), true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 5 buffer",
                                   byteBuffer2String( it->currentBuffer() ),
                                   std::string( "Thank you for your request 4 'copy 5 This is a request") );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 5 isLastBuffer",
                                   it->isLastBuffer(), true );


      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 6 nextBuffer last",
                                   it->nextBuffer(), false );
    }

    // ------------------------------------------------------

    void test_DummyRequestHandler_MultiRequest()
    {
      DummyRequestHandler handler;

      RequestIterator* req( new RequestIterator() );
      req->addBuffer( string2ByteBuffer("This is a multi request 1"), 0, false );
      req->addBuffer( string2ByteBuffer("This is a multi request 2"), 1, false );
      req->addBuffer( string2ByteBuffer("This is a multi request 3"), 2, false );
      req->addBuffer( string2ByteBuffer("This is a multi request 4"), 3, true );
      RequestProperties prop;
      IByteBufferIteratorPtr it=handler.replyToRequest(
                                                       IByteBufferIteratorPtr( req ), prop );

      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 1 nextBuffer",
                                   it->nextBuffer(), true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 1 buffer",
                                   byteBuffer2String( it->currentBuffer() ),
                                   std::string( "Thank you for your request 'This is a multi request 1") );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 1 isLastBuffer",
                                   it->isLastBuffer(), false );


      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 2 nextBuffer",
                                   it->nextBuffer(), true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 2 buffer",
                                   byteBuffer2String( it->currentBuffer() ),
                                   std::string( "Thank you for your request 'This is a multi request 2") );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 2 isLastBuffer",
                                   it->isLastBuffer(), false );


      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 3 nextBuffer",
                                   it->nextBuffer(), true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 3 buffer",
                                   byteBuffer2String( it->currentBuffer() ),
                                   std::string( "Thank you for your request 'This is a multi request 3") );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 3 isLastBuffer",
                                   it->isLastBuffer(), false );


      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 4 nextBuffer",
                                   it->nextBuffer(), true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 4 buffer",
                                   byteBuffer2String( it->currentBuffer() ),
                                   std::string( "Thank you for your request 'This is a multi request 4") );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 4 isLastBuffer",
                                   it->isLastBuffer(), true );



      CPPUNIT_ASSERT_EQUAL_MESSAGE("reply 6 nextBuffer last",
                                   it->nextBuffer(), false );
    }


  };

  CPPUNIT_TEST_SUITE_REGISTRATION( DummyRequestHandlerTest );

}

CORALCPPUNITTEST_MAIN( DummyRequestHandlerTest )
