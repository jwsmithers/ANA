#ifndef CORALSOCKETS_SOCKETCLIENT_H
#define CORALSOCKETS_SOCKETCLIENT_H 1

// Include files
#include <string>
// Local include files
#include "CoralServerBase/IRequestHandler.h"

namespace coral {

  namespace CoralSockets {
    // forward definition
    class SocketRequestHandler;

    /** @class SocketClient SocketClient.h
     *
     *  @author Andrea Valassi and Martin Wache
     *  @date   2007-12-26
     *///

    class SocketClient   {

    public:

      virtual ~SocketClient();

      SocketClient( const std::string& host,
                    int port
#ifdef HAVE_OPENSSL
                    , int sport =-1
#endif
                    );

      IRequestHandler *getRequestHandler();

    private:

      /// Standard constructor is private
      SocketClient();

      /// Copy constructor is private (fix Coverity MISSING_COPY)
      SocketClient( const SocketClient& rhs );

      /// Assignment operator is private (fix Coverity MISSING_ASSIGN)
      SocketClient& operator=( const SocketClient& rhs );

      SocketRequestHandler* m_handler;
    };

  }

}
#endif
