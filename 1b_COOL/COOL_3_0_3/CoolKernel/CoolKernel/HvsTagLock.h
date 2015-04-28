#ifndef COOLKERNEL_HVSTAGLOCK_H
#define COOLKERNEL_HVSTAGLOCK_H 1

// First of all, set/unset CORAL290, COOL300, COOL400 and COOL_HAS_CPP11 macros
#include "CoolKernel/VersionInfo.h"

// Include files
#ifdef COOL400CPP11ENUM
#include <ostream>
#endif

namespace cool
{

  /** @file HvsTagLock.h
   *
   * Enum definition for the lock status of an HVS tag.
   *
   * @author Andrea Valassi
   * @date 2007-03-20
   *///

  // HVS tag lock status.
  namespace HvsTagLock
  {
#ifndef COOL400CPP11ENUM
    enum Status { UNLOCKED=0, LOCKED=1, PARTIALLYLOCKED=2 };
#else
    enum class Status { UNLOCKED=0, LOCKED=1, PARTIALLYLOCKED=2 };

    // Overloaded operator<< for cool::HvsTagLock::Status
    inline std::ostream&
    operator<<( std::ostream& s, const cool::HvsTagLock::Status& status )
    {
      return s << (int)status;
    }
#endif
  }

}

#endif // COOLKERNEL_HVSTAGLOCK_H
