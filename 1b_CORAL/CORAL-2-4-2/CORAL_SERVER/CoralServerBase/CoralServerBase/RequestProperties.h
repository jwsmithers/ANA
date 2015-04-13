// $Id: RequestProperties.h,v 1.7.2.2 2012-12-21 13:24:30 avalassi Exp $
#ifndef CORALSERVERBASE_REQUESTPROPERTIES_H
#define CORALSERVERBASE_REQUESTPROPERTIES_H 1

#include <stdint.h> // For uint32_t

namespace coral
{

  /** @struct RequestProperties
   *
   *  Structure for holding all the informations about a single request,
   *  for instance the request id.
   *
   *  @author Martin Wache and Alexander Kalkhof
   *  @date   2009-12-07
   *///

  struct RequestProperties
  {
  public:

    /// Default constructor to initialise the members
    RequestProperties()
      : requestId( 0 )
      , useSecureChannel( false )
    {
    }

    /// Request ID of this request in this connection.
    uint32_t requestId;

    /// True if this request should be handled via a secure channel.
    bool useSecureChannel;

  };

}
#endif // CORALSERVERBASE_REQUESTPROPERTIES_H
