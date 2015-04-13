#include <iostream>
#include "../../src/TcpSocket.h"
#include "../common/testPort.h"
using namespace coral::CoralSockets;

//TcpSocketPtr listenSocket;

class TcpSocketHolder
{
public:
  TcpSocketHolder( TcpSocketPtr socket ) : m_socket( socket )
  {
    std::cout << "TcpSocketHolder ctor" << std::endl;
  }
  ~TcpSocketHolder()
  {
    std::cout << "TcpSocketHolder dtor start" << std::endl;
    m_socket.reset();
    // Here is the ERROR "Assertion `!pthread_mutex_lock(&m)' failed."
    std::cout << "TcpSocketHolder dtor end" << std::endl;
  }
private:
  TcpSocketPtr m_socket;
};

boost::shared_ptr<TcpSocketHolder> listenSocket;

int main()
{
  std::cout << "Enter main" << std::endl;
  listenSocket.reset( new TcpSocketHolder( TcpSocket::listenOn("localhost",getTestPort()) ) );
  std::cout << "Exit main" << std::endl;
}
