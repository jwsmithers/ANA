
// Include files
#include "CoralSockets/SocketClient.h"

// Local include files
#include "SocketRequestHandler.h"
#ifdef HAVE_OPENSSL
#include "SslSocket.h"
#endif
#include "TcpSocket.h"

// Namespace
using namespace coral::CoralSockets;

// Logger
#define LOGGER_NAME "CoralSockets::SocketClient"
#include "logger.h"

SocketClient::SocketClient( const std::string& host,
                            int port
#ifdef HAVE_OPENSSL
                            , int sport
#endif
                            )
{
  INFO("Connect to host " << host << " and port " << port );
  PacketSocketPtr rSocket( (PacketSocket*) 0 );
  PacketSocketPtr sSocket( (PacketSocket*) 0 );
#ifdef HAVE_OPENSSL
  if ( sport>=0 )
    sSocket= PacketSocketPtr( new PacketSocket( SslSocket::connectTo( host, sport ) ) );
  if ( port >=0 )
#endif
    rSocket= PacketSocketPtr( new PacketSocket( TcpSocket::connectTo( host, port ) ) );
  INFO("Connection established");
  m_handler =  new SocketRequestHandler( rSocket, sSocket );
}

//-----------------------------------------------------------------------------

SocketClient::~SocketClient()
{
  INFO("SocketClient destructor");
  delete m_handler;
}

//-----------------------------------------------------------------------------

coral::IRequestHandler* SocketClient::getRequestHandler()
{
  return m_handler;
}

//-----------------------------------------------------------------------------
