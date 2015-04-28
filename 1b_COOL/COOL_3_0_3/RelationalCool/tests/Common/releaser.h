#ifndef RELATIONALCOOL_RELEASER_H
#define RELATIONALCOOL_RELEASER_H 1

// Include files
#include "CoralBase/AttributeListSpecification.h"

namespace cool
{

  class releaser {
  public:
    void operator()( coral::AttributeListSpecification* p ) { p->release(); }
  };

}

#endif // RELEASER_H
