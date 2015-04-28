#ifndef CORALACCESS_SOCKETCLIENTWRAPPER_H
#define CORALACCESS_SOCKETCLIENTWRAPPER_H 1

// Include files
#include "CoralSockets/SocketClient.h"

namespace coral
{

  namespace CoralAccess
  {

    /** @class SocketClientWrapper
     *
     *  @author Andrea Valassi
     *  @date   2009-02-05
     *///

    class SocketClientWrapper : virtual public IRequestHandler
    {

    public:

      // Constructor from host and port.
      SocketClientWrapper( const std::string& host,
                           int port
#ifdef HAVE_OPENSSL
                           , int sport=-1
#endif
                           )
        : m_client( host,
                    port
#ifdef HAVE_OPENSSL
                    , sport
#endif
                    ) {}

      // Destructor.
      virtual ~SocketClientWrapper(){}

      /// Set the connection properties for this request handler.
      /// May be called several times, for instance to add the certificate data.
      /// In this case the old properties should be discarded.
      void setConnectionProperties(
                                   std::auto_ptr<const coral::ConnectionProperties> props )
      {
        return m_client.getRequestHandler()->setConnectionProperties( props );
      }

      // Handle a request message and return an iterator over reply messages.
      // This method cannot be const because we need to lock mutexes in it!
      // The iterator is positioned before the first reply in the loop:
      // the next() method must be called to retrieve the first reply.
      // The request handler must be kept alive while the iterator is used:
      // the iterator uses a byte buffer pool owned by the request handler.
      IByteBufferIteratorPtr replyToRequest( IByteBufferIteratorPtr request,
                                             const RequestProperties& properties )
      {
        return m_client.getRequestHandler()->replyToRequest( request, properties );
      }

    private:

      // Standard constructor is private
      SocketClientWrapper();

      // Copy constructor is private
      SocketClientWrapper( const SocketClientWrapper& rhs );

      // Assignment operator is private
      SocketClientWrapper& operator=( const SocketClientWrapper& rhs );

    private:

      // The SocketClient
      CoralSockets::SocketClient m_client;

    };

  }

}
#endif // CORALACCESS_SOCKETCLIENTWRAPPER_H
