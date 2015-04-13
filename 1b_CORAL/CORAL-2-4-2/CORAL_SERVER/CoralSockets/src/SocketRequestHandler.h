// $Id: SocketRequestHandler.h,v 1.4.2.2.2.4 2013-02-08 09:40:10 avalassi Exp $
#ifndef CORALSOCKETS_SOCKETREQUESTHANDLER_H
#define CORALSOCKETS_SOCKETREQUESTHANDLER_H 1

// Include files
#include <memory>
#include "CoralServerBase/ConnectionProperties.h"
#include "CoralServerBase/IRequestHandler.h"
#include "CoralServerBase/RequestProperties.h"
#include "CoralSockets/GenericSocketException.h"

// Local include files
#include "PacketSocket.h"
#include "ReplyManager.h"

namespace coral
{

  namespace CoralSockets
  {

    // Forward declaration
    class ThreadManager;

    /** @class SocketRequestHandler SocketRequestHandler.h
     *
     *  @author Andrea Valassi and Martin Wache
     *  @date   2007-12-26
     *///

    class SocketRequestHandler : public coral::IRequestHandler
    {

    public:

      virtual ~SocketRequestHandler();

      SocketRequestHandler( PacketSocketPtr socket,
                            PacketSocketPtr sSocket = PacketSocketPtr() );

      void setConnectionProperties( coral::ConnectionPropertiesConstPtr properties );

      /// reply to the request (thread safe)
      IByteBufferIteratorPtr replyToRequest( IByteBufferIteratorPtr request,
                                             const RequestProperties &properties );

      // set tokens for data and secure channel binding
      void setToken( bool secure, uint32_t token );

    protected:

      // sends the request over the sockets, registers a replySlot for the
      // request and returns the replySlot
      ReplySlot& send( IByteBufferIterator& requestIt, bool useSecureChannel );

    private:

      /// Standard constructor is private
      SocketRequestHandler();

      /// copy constructor is private
      SocketRequestHandler( const SocketRequestHandler &handler);

      /// assignment operator as well
      SocketRequestHandler& operator=( const SocketRequestHandler& );

      /// packet socket for connection
      PacketSocketPtr m_Socket;

      /// a mutex to protect the sending and m_requestID
      coral::mutex m_mutexForSend;

      /// the current requestID
      int m_requestID;

      /// storage for the waiting requests
      std::auto_ptr<ReplyManager> m_rplMngr;

      // Forward declaration
      class ReceiveThread; // thread for receiving packets

      /// one thread for receiving packets
      ReceiveThread* m_receiveThread;

      /// secure packet socket and corresponding receive thread
      ReceiveThread *m_sReceiveThread;
      PacketSocketPtr m_sSocket;
      /// storage for the waiting secure requests
      std::auto_ptr<ReplyManager> m_sRplMngr;

      /// tokens for binding secure and data channel
      uint32_t m_secToken;
      uint32_t m_datToken;
      coral::mutex m_mutexForTokens;
      coral::condition_variable m_condForTokens;

      /// thread manager to handle receive thread
      std::auto_ptr<ThreadManager> m_thrManager;

    };

  }

}
#endif
