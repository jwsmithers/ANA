#ifndef COMMON_COMMON_H 
#define COMMON_COMMON_H 1
#include "CoralServerBase/ByteBuffer.h"
#include "CoralServerBase/CALPacketHeader.h"
#include "../common/testPort.h"
#include "../../src/TcpSocket.h"

namespace coral
{
  typedef std::auto_ptr<ByteBuffer> ByteBufferPtr;

  namespace CoralSockets
  {

#if 0
    std::auto_ptr<RingBufferPipes> pipes;
#endif

    // ---------------------------------------------------
    // helpers

    void createSockets( ISocketPtr &src, ISocketPtr &dst )
    {
      TcpSocketPtr listenSocket = TcpSocketPtr( (TcpSocket*)0);
#if 0
      pipes = std::auto_ptr<RingBufferPipes>( new RingBufferPipes( 10000, "test pipes") );
      src=pipes->getSrc();
      dst=pipes->getDst();
#else
      // Use a well-defined test port per slot, do not retry (bug #102966)
      int testPort = getTestPort();
      listenSocket = TcpSocket::listenOn( "localhost", testPort );
      /*
      while ( listenSocket.get() == 0 )
      {
        try
        {
          listenSocket = TcpSocket::listenOn( "localhost", testPort );
        }
        catch (GenericSocketException &e) {
          std::string expMsg="Error binding socket";
          if (expMsg == std::string( e.what(), expMsg.size() ) ) {
            std::cout << "Caught exeption: '" << e.what()
                      << "' sleeping."<< std::endl;
            if (testPort > 50100)
              throw;
            testPort++;
            continue;
          }
          throw;
        }
      }
      */
      src = TcpSocket::connectTo( "localhost", testPort );
      dst = listenSocket->accept();
#endif
    }

    ByteBufferPtr createBuffer( int num ) {
      ByteBufferPtr buf( new ByteBuffer( CALPACKET_HEADER_SIZE + sizeof( int ) ) );
      new (buf->data())CALPacketHeader( 0, false, false, 0);
      *((int*)( buf->data()+CALPACKET_HEADER_SIZE )) = num;
      buf->setUsedSize( CALPACKET_HEADER_SIZE + sizeof( int ) );
      return buf;
    }

    int getBufferNum( ByteBufferPtr buf ) {
      return *(int*)( buf->data() + CALPACKET_HEADER_SIZE );
    }

    int getBufferNum( const ByteBuffer& buf ) {
      return *(int*)( buf.data() + CALPACKET_HEADER_SIZE );
    }

    ByteBufferPtr string2ByteBuffer( std::string str ) {
      ByteBufferPtr result( new ByteBuffer( str.length() ) );
      const char * cstr=str.c_str();

      for (unsigned int i=0; i<str.length(); i++ )
        *(result->data()+i) = (unsigned char)*(cstr+i);

      result->setUsedSize( str.length() );
      return result;
    }

    std::string byteBuffer2String( const ByteBuffer& buf ) {
      return std::string( (char*)buf.data(), buf.usedSize() );
    }

#define  checkByteBuffer( mesg, buf1, buf2 )                            \
    do {                                                                \
      CPPUNIT_ASSERT_EQUAL_MESSAGE( mesg " size",                       \
                                    buf1.usedSize(), buf2.usedSize() ); \
                                                                        \
      for (unsigned int i = 0; i< buf1.usedSize(); i++) {               \
        if ( *(buf1.data()+i) != *(buf2.data()+i) )                     \
          CPPUNIT_FAIL(mesg " content not equal");                      \
      };                                                                \
    } while (0)

  }
}

#endif
