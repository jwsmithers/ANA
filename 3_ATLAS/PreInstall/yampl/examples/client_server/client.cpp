#include <unistd.h>
#include <iostream>

#include "yampl.h"

using namespace std;
using namespace yampl;

int main(int argc, char *argv[]){
  char pong[100];
  const string ping = "ping from " + to_string(getpid());
  
  Channel channel("service", LOCAL_SHM);
  ISocketFactory *factory = new SocketFactory();
  ISocket *socket = factory->createClientSocket(channel);

  while(true){
    socket->send(ping);
    socket->recv(pong);
    cout << pong << endl;
  }
}
