// $Id: ServerStubWrapper.h,v 1.1.2.2.2.1 2012-12-21 13:24:30 avalassi Exp $
#ifndef CORALSERVER_SERVERSTUBWRAPPER_H
#define CORALSERVER_SERVERSTUBWRAPPER_H

// Include files
#include "CoralServerBase/ICoralFacade.h"
#include "CoralStubs/ServerStub.h"

namespace coral
{

  namespace CoralServer
  {

    /** @class ServerStubWrapper
     *
     *  Wrapper to a ServerStub owning its own ICoralFacade.
     *
     *  @author Andrea Valassi
     *  @date   2009-03-02
     *///

    class ServerStubWrapper : virtual public IRequestHandler
    {

    public:

      /// Constructor from an ICoralFacade: the ServerStubWrapper
      /// becomes its owner and must delete it in the destructor.
      ServerStubWrapper( ICoralFacade& facade )
        : m_pFacade( &facade )
        , m_pServerStub( new CoralStubs::ServerStub( facade ) )
      {
      }

      /// Destructor.
      virtual ~ServerStubWrapper()
      {
        delete m_pServerStub;
        delete m_pFacade;
      }

      void setConnectionProperties( coral::ConnectionPropertiesConstPtr properties )
      {
        m_pServerStub->setConnectionProperties( properties );
      }

      /// Handle a request message and return an iterator over reply messages.
      IByteBufferIteratorPtr replyToRequest( IByteBufferIteratorPtr request,
                                             const RequestProperties& properties )
      {
        return m_pServerStub->replyToRequest( request, properties );
      }

    private:

      /// The ICoralFacade pointer (owned by this instance).
      ICoralFacade* m_pFacade;

      /// The wrapped ServerStub pointer (owned by this instance).
      CoralStubs::ServerStub* m_pServerStub;

    };

  }

}
#endif // CORALSERVER_SERVERSTUBWRAPPER_H
