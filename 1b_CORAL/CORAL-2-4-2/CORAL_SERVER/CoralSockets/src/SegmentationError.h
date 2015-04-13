// $Id: SegmentationError.h,v 1.2.2.2.2.1 2012-06-07 12:19:57 avalassi Exp $
#ifndef CORALSOCKETS_SEGMENTATIONERROR_H
#define CORALSOCKETS_SEGMENTATIONERROR_H 1

#include "CoralBase/Exception.h"

namespace coral {

  namespace CoralSockets {

    class SegmentationErrorException : public Exception
    {

    public:

      /// Constructor
      SegmentationErrorException( const std::string& what,
                                  const std::string& methodName = "" )
        : Exception( what, methodName, "coral::CoralSockets" ) {}

      /// Destructor
      virtual ~SegmentationErrorException() throw() {}

    };
  }
}
#endif // CORALSOCKETS_SEGMENTATIONERROR_H
