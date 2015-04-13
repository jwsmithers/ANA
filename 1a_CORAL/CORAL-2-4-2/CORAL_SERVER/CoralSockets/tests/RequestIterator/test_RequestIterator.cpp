// $Id: test_RequestIterator.cpp,v 1.3.2.4 2013-02-08 09:40:13 avalassi Exp $

// Include files
#include <iostream>
#include "CoralBase/../tests/Common/CoralCppUnitTest.h"
#include "CoralSockets/GenericSocketException.h"

// Local include files
#include "../../src/RequestIterator.h"
#include "../../src/ThreadManager.h"

// Namespace
using namespace coral::CoralSockets;

namespace coral
{

  class RequestIteratorTest : public CoralCppUnitTest
  {

    CPPUNIT_TEST_SUITE( RequestIteratorTest );
    CPPUNIT_TEST( test_Basic );
    CPPUNIT_TEST( test_Resize );
    CPPUNIT_TEST_SUITE_END();

  public:

    void setUp() {}

    void tearDown() {}

    typedef std::auto_ptr<ByteBuffer> BufferPtr;

    typedef boost::shared_ptr<ByteBuffer> BufferSPtr;

    static BufferPtr createBuffer( int num )
    {
      BufferPtr buf( new ByteBuffer( sizeof( int ) ) );
      *((int*)buf->data()) = num;
      buf->setUsedSize( sizeof( int ) );
      return buf;
    }

    static int getBufferNum( BufferSPtr buf )
    {
      return *(int*)buf->data();
    }

    static int getBufferNum( const ByteBuffer& buf )
    {
      return *(int*)buf.data();
    }

    // ------------------------------------------------------

    void test_Basic()
    {
      RequestIterator it;
      BufferPtr buffer;

      CPPUNIT_ASSERT_THROW(it.nextBuffer(), GenericSocketException );
      buffer=createBuffer( 0 );
      it.addBuffer( buffer, 0, false /*isLast*/);
      buffer=createBuffer( 1 );
      it.addBuffer( buffer, 1, false /*isLast*/);
      buffer=createBuffer( 2 );
      it.addBuffer( buffer, 2, true /*isLast*/ );

      buffer=createBuffer( 3 );
      CPPUNIT_ASSERT_THROW( it.addBuffer( buffer, 3, true ),
                            GenericSocketException );

      // currBuffer throws before calling nextBuffer()
      CPPUNIT_ASSERT_THROW( it.currentBuffer(), GenericSocketException );

      CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 1", it.nextBuffer(), true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 1", it.isLastBuffer(), false );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("buffer 1", getBufferNum( it.currentBuffer() ),
                                   0 );

      CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 2", it.nextBuffer(), true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 2", it.isLastBuffer(), false );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("buffer 2", getBufferNum( it.currentBuffer() ),
                                   1 );

      CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 3", it.nextBuffer(), true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 3", it.isLastBuffer(), true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("buffer 3", getBufferNum( it.currentBuffer() ),
                                   2 );

      CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 4", it.nextBuffer(), false );
      // currBuffer throws after nextBuffer returned false
      CPPUNIT_ASSERT_THROW( it.currentBuffer(), GenericSocketException );
    }

    // ------------------------------------------------------

    void test_Resize()
    {
      RequestIterator it(1); // reserve only one buffer
      BufferPtr buffer;

      CPPUNIT_ASSERT_THROW(it.nextBuffer(), GenericSocketException );
      buffer=createBuffer( 0 );
      it.addBuffer( buffer, 0, false /*isLast*/);
      buffer=createBuffer( 1 ); // resize will be called
      it.addBuffer( buffer, 1, false /*isLast*/);
      buffer=createBuffer( 2 ); // resize will be called
      it.addBuffer( buffer, 2, false /*isLast*/ );
      buffer=createBuffer( 3 );
      it.addBuffer( buffer, 3, false /*isLast*/ );
      buffer=createBuffer( 4 );
      it.addBuffer( buffer, 4, false /*isLast*/ );
      buffer=createBuffer( 5 );
      it.addBuffer( buffer, 5, true /*isLast*/ );

      buffer=createBuffer( 6 );
      CPPUNIT_ASSERT_THROW( it.addBuffer( buffer, 6, true ),
                            GenericSocketException );

      // currBuffer throws before calling nextBuffer()
      CPPUNIT_ASSERT_THROW( it.currentBuffer(), GenericSocketException );

      CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 1", it.nextBuffer(), true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 1", it.isLastBuffer(), false );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("buffer 1", getBufferNum( it.currentBuffer() ),
                                   0 );

      CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 2", it.nextBuffer(), true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 2", it.isLastBuffer(), false );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("buffer 2", getBufferNum( it.currentBuffer() ),
                                   1 );

      CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 3", it.nextBuffer(), true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 3", it.isLastBuffer(), false );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("buffer 3", getBufferNum( it.currentBuffer() ),
                                   2 );

      CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 4", it.nextBuffer(), true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 4", it.isLastBuffer(), false );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("buffer 4", getBufferNum( it.currentBuffer() ),
                                   3 );

      CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 5", it.nextBuffer(), true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 5", it.isLastBuffer(), false );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("buffer 5", getBufferNum( it.currentBuffer() ),
                                   4 );

      CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 6", it.nextBuffer(), true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 6", it.isLastBuffer(), true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("buffer 6", getBufferNum( it.currentBuffer() ),
                                   5 );

      CPPUNIT_ASSERT_EQUAL_MESSAGE("nextBuffer 7", it.nextBuffer(), false );
      // currBuffer throws after nextBuffer returned false
      CPPUNIT_ASSERT_THROW( it.currentBuffer(), GenericSocketException );
    }

  };

  CPPUNIT_TEST_SUITE_REGISTRATION( RequestIteratorTest );

}

CORALCPPUNITTEST_MAIN( RequestIteratorTest )
