#ifndef CORAL_CORALSTUBS_REQUESTHANDLER_H
#define CORAL_CORALSTUBS_REQUESTHANDLER_H 1

// Include files
#include "CoralServerBase/ConnectionProperties.h"
#include "CoralServerBase/ICoralFacade.h"
#include "CoralServerBase/IRequestHandler.h"

namespace coral
{

  class ByteBuffer;

  namespace CoralStubs
  {

    // forward declarations
    struct RowIteratorMap;

    /** @class ServerStub
     *
     *  An inheritance of the IRequestHandler used for the server side
     *
     *  @author Alexander Kalkhof
     *  @date   2009-01-28
     *///

    class ServerStub : public IRequestHandler
    {

    public:

      // Constructor from an ICoralFacade.
      ServerStub( ICoralFacade& coralFacade );

      // Virtual destructor.
      virtual ~ServerStub();

      void setConnectionProperties( coral::ConnectionPropertiesConstPtr );

      IByteBufferIteratorPtr replyToRequest( IByteBufferIteratorPtr request,
                                             const RequestProperties& );

    private:

      /// Copy constructor is private (fix Coverity MISSING_COPY)
      ServerStub( const ServerStub& rhs );

      /// Assignment operator is private (fix Coverity MISSING_ASSIGN)
      ServerStub& operator=( const ServerStub& rhs );

    private:

      ICoralFacade& m_facade;

      RowIteratorMap* m_rowimap;

      const coral::ConnectionProperties* m_connprop;

    };

  }

}
#endif
