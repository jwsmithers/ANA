// -*- C++ -*-
#ifndef CORALBASE_ATTRIBUTE_EXCEPTION_H
#define CORALBASE_ATTRIBUTE_EXCEPTION_H 1

#include "Exception.h"

namespace coral
{
  /// Exception class for the AttributeList-related classes
  class AttributeException : public Exception
  {
  public:
    /// Constructor
    AttributeException( std::string errorMessage = "" ) :
      Exception( errorMessage, "Attribute", "CoralBase" )
    {
    }

    virtual ~AttributeException() throw()
    {
    }
  };
}

#endif
