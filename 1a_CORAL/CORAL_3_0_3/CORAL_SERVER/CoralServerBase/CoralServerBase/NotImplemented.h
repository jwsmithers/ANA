#ifndef CORALSERVERBASE_NOTIMPLEMENTED_H
#define CORALSERVERBASE_NOTIMPLEMENTED_H 1

// Include files
#include "CoralBase/Exception.h"

namespace coral
{

  /** @class NotImplemented
   *
   *  @author Andrea Valassi
   *  @date   2007-12-04
   *///

  class NotImplemented : public Exception
  {

  public:

    /// Constructor
    NotImplemented( const std::string& methodName )
      : Exception( "This method is not yet implemented",
                   methodName,
                   "coral::CoralServerBase" ) {}

    /// Destructor
    virtual ~NotImplemented() throw() {}

  };

}
#endif // CORALSERVERBASE_NOTIMPLEMENTED_H
