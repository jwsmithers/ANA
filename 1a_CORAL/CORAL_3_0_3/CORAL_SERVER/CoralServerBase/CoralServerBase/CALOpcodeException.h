#ifndef CORALSERVERBASE_CALOPCODEEXCEPTION_H
#define CORALSERVERBASE_CALOPCODEEXCEPTION_H 1

// Include files
#include "CoralBase/Exception.h"

namespace coral
{

  /** @class CALOpcodeException
   *
   *  Exception thrown when manipulating CAL opcodes.
   *
   *  @author Andrea Valassi
   *  @date   2009-01-23
   *///

  class CALOpcodeException : public Exception
  {

  public:

    /// Constructor
    CALOpcodeException( const std::string& message,
                        const std::string& method )
      : Exception( message, method, "coral::CoralServerBase" ){}

    /// Destructor
    virtual ~CALOpcodeException() throw() {}

  };

}
#endif // CORALSERVERBASE_CALOPCODEEXCEPTION_H
