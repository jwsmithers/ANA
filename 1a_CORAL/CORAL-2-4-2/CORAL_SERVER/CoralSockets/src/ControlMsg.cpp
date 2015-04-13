// $Id: ControlMsg.cpp,v 1.4.2.2 2012-06-07 12:19:56 avalassi Exp $

// Include files
#include <cstring>
#include "arpa/inet.h"
#include "CoralServerBase/ByteBuffer.h"
#include "CoralServerBase/CALPacketHeader.h"
#include "CoralSockets/GenericSocketException.h"

// Local include files
#include "ControlMsg.h"

// Logger
#define LOGGER_NAME "CoralSockets::ControlMsg"
#include "logger.h"

// Debug
#undef DEBUG
#define DEBUG(out)

// Namespace
using namespace coral::CoralSockets;

//-----------------------------------------------------------------------------

ByteBufferPtr ControlMsg::createMessage( bool reply,
                                         uint16_t control,
                                         uint32_t token)
{
  ByteBufferPtr buffer( new ByteBuffer( CALPACKET_HEADER_SIZE +
                                        ControlMessageSize ) );
  new (buffer->data())CALPacketHeader( CALOpcodes:: SocketsCtlMsg
                                       + ( reply ? 0x40 : 0 ),
                                       false /* fromProxy */,
                                       false /*cacheable*/, 0);

  uint16_t controlN=htons(control);
  ::memcpy( buffer->data() + CALPACKET_HEADER_SIZE, &controlN,
            sizeof( controlN )  );

  uint32_t tokenN=htonl(token);
  ::memcpy( buffer->data() + CALPACKET_HEADER_SIZE + sizeof( controlN ),
            &tokenN, sizeof( tokenN) );

  buffer->setUsedSize( CALPACKET_HEADER_SIZE + ControlMessageSize );

  return buffer;
}

//-----------------------------------------------------------------------------

ByteBufferPtr ControlMsg::requestBindMsg()
{
  return createMessage( false, ControlCodes::RequestBind, 0 );
}

//-----------------------------------------------------------------------------

ByteBufferPtr ControlMsg::okRequestBindMsg( uint32_t token )
{
  return createMessage( true, ControlCodes::RequestBind, token );
}

//-----------------------------------------------------------------------------

ByteBufferPtr ControlMsg::bindMsg( uint32_t token )
{
  return createMessage( false, ControlCodes::Bind, token );
}

//-----------------------------------------------------------------------------

ByteBufferPtr ControlMsg::okBindMsg( )
{
  return createMessage( true, ControlCodes::Bind, 0 );
}

//-----------------------------------------------------------------------------

ByteBufferPtr ControlMsg::startSecureMsg( )
{
  return createMessage( false, ControlCodes::StartSecure, 0 );
}

//-----------------------------------------------------------------------------

ByteBufferPtr ControlMsg::okSecureMsg( )
{
  return createMessage( true, ControlCodes::StartSecure, 0 );
}

//-----------------------------------------------------------------------------

bool ControlMsg::isSocketsCtlMessage( const ByteBuffer& buffer )
{
  CALPacketHeader header(buffer.data(), buffer.usedSize() );
  DEBUG("isSocketsCtlMessage: opcode " << header.opcode() );

  if ( header.opcode() != CALOpcodes::SocketsCtlMsg &&
       header.opcode() != CALOpcodes::SocketsCtlMsg + 0x40 )
    return false;

  if ( buffer.usedSize() != CALPACKET_HEADER_SIZE + ControlMessageSize )
    throw GenericSocketException( "Wrong size of Sockets Control Message",
                                  "ControlMsg::isSocketsCtlMessage()");

  return true;
}

//-----------------------------------------------------------------------------

ControlMsg::ControlMsg( ByteBufferPtr buffer )
{
  if ( !isSocketsCtlMessage( *buffer ) )
    throw GenericSocketException( "Buffer doesn't contain a ControlMsg!",
                                  "ControlMsg::ControlMsg");
  m_buffer = buffer;

  ::memcpy( &m_control,
            m_buffer->data() + CALPACKET_HEADER_SIZE,
            sizeof( m_control ) );
  m_control = ntohs( m_control );

  ::memcpy( &m_token,
            m_buffer->data() + CALPACKET_HEADER_SIZE + sizeof( m_control ),
            sizeof( m_token ) );
  m_token = ntohl( m_token );
}
