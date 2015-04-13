// $Id: ControlMsg.h,v 1.7.2.2 2012-06-07 12:19:56 avalassi Exp $
#ifndef CORALSOCKETS_CONTROLMSG_H
#define CORALSOCKETS_CONTROLMSG_H 1

// Include files
#include "CoralServerBase/ByteBuffer.h"
#include <stdint.h> // For uint32_t
#include <memory>

namespace coral
{

  // forward declaration
  class ControlMsgTest;

  namespace CoralSockets
  {

    // forward declaration
    class SocketContext;

    static const uint32_t ControlMessageSize = 6;
    // 2 byte control + 4 byte token

    namespace ControlCodes
    {
      static const uint16_t RequestBind = 0x01;
      static const uint16_t Bind        = 0x02;
      static const uint16_t StartSecure = 0x03;
    }

    typedef std::auto_ptr<ByteBuffer> ByteBufferPtr;

    /**
     *
     * Class ControlMsg
     *
     *
     * Contructs ByteBuffers which contains a CAL header with an appended
     * private CoralSockets control message
     *
     *///

    class ControlMsg
    {
      // test class is a friend
      friend class coral::ControlMsgTest;

    public:

      static bool isSocketsCtlMessage( const ByteBuffer& buffer );

      static ByteBufferPtr requestBindMsg();
      static ByteBufferPtr okRequestBindMsg( uint32_t token );

      static ByteBufferPtr bindMsg( uint32_t token );
      static ByteBufferPtr okBindMsg();

      static ByteBufferPtr startSecureMsg();
      static ByteBufferPtr okSecureMsg();

      ControlMsg( ByteBufferPtr buffer );

      uint16_t getControl()
      {
        return m_control;
      }

      uint32_t getToken()
      {
        return m_token;
      }

    private:

      static ByteBufferPtr createMessage( bool reply,
                                          uint16_t control,
                                          uint32_t token );

      ByteBufferPtr m_buffer;

      uint32_t m_token;

      uint16_t m_control;

    };

  }

}
#endif
