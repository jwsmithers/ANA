#ifndef COOLKERNEL_PAYLOADMODE_H
#define COOLKERNEL_PAYLOADMODE_H 1

// First of all, set/unset CORAL290, COOL300, COOL400 and COOL_HAS_CPP11 macros
#include "CoolKernel/VersionInfo.h"

#ifdef COOL290VP

// Include files
#ifdef COOL400CPP11ENUM
#include <ostream>
#endif

namespace cool
{

  /** @file PayloadMode.h
   *
   *  Enum definition for the payload mode of a COOL folder.
   *
   *  Currently three different modes for storing payload exist in COOL:
   *  - In the default mode, the payload is stored inline in the IOV table,
   *    leading to an overhead from multiple payload copies in system objects.
   *  - The separate payload table mode was introduced to reduce this overhead:
   *    system object rows originating from the same user-inserted IOV contain
   *    multiple copies of the same payload ID, but not of the payload.
   *  - Later also the possibility to add a vector of payloads to one IOV was
   *    added (vector payload mode). This also needs a separate payload table.
   *
   *  @author Martin Wache
   *  @date 2010-05-18
   *///

  // Folder payload mode
  // [values are chosen to ease backward compatibility - see bug #103351]
  namespace PayloadMode
  {
#ifndef COOL400CPP11ENUM
    enum Mode { INLINEPAYLOAD=0, SEPARATEPAYLOAD=1, VECTORPAYLOAD=2 };
#else
    enum class Mode { INLINEPAYLOAD=0, SEPARATEPAYLOAD=1, VECTORPAYLOAD=2 };

    // Overloaded operator<< for cool::PayloadMode::Mode
    inline std::ostream&
    operator<<( std::ostream& s, const cool::PayloadMode::Mode& mode )
    {
      return s << (int)mode;
    }
#endif
  }

}
#endif

#endif // COOLKERNEL_PAYLOADMODE_H
