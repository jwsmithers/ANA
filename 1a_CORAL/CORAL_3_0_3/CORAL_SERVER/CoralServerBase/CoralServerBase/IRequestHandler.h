#ifndef CORALSERVERBASE_IREQUESTHANDLER_H
#define CORALSERVERBASE_IREQUESTHANDLER_H 1

// Include files
#include "CoralServerBase/ConnectionProperties.h"
#include "CoralServerBase/IByteBufferIterator.h"

namespace coral
{
  // Forward declaration
  struct RequestProperties;

  /** @class IRequestHandler
   *
   *  Interface to a request handler for the CORAL server project.
   *
   *  A request handler delivers one logical reply to each logical request.
   *  One logical reply can be segmented in several physical buffers.
   *  One logical request can also be described by several physical buffer.
   *
   *  @author Andrea Valassi, Martin Wache and Alexander Kalkhof
   *  @date   2007-12-04
   *///

  class IRequestHandler
  {

  public:

    // Destructor.
    virtual ~IRequestHandler(){}

    /// Set the connection properties for this request handler.
    /// May be called several times, for instance to add the certificate data.
    /// In this case the old properties should be discarded.
    virtual void setConnectionProperties( coral::ConnectionPropertiesConstPtr /*properties*/ ) = 0;

    // Handle a request message and return an iterator over reply messages.
    // This method cannot be const because we need to lock mutexes in it!
    // The iterator is positioned before the first reply in the loop:
    // the next() method must be called to retrieve the first reply.
    // The request handler must be kept alive while the iterator is used:
    // the iterator uses a byte buffer pool owned by the request handler.
    virtual IByteBufferIteratorPtr
    replyToRequest( IByteBufferIteratorPtr request,
                    const RequestProperties& properties ) = 0;

  };

}
#endif // CORALSERVERBASE_IREQUESTHANDLER_H
