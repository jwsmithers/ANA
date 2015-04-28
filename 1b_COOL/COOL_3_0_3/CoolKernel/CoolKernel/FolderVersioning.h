#ifndef COOLKERNEL_FOLDERVERSIONING_H
#define COOLKERNEL_FOLDERVERSIONING_H 1

// First of all, set/unset CORAL290, COOL300, COOL400 and COOL_HAS_CPP11 macros
#include "CoolKernel/VersionInfo.h"

// Include files
#ifdef COOL400CPP11ENUM
#include <ostream>
#endif

namespace cool
{

  /** @file FolderVersioning.h
   *
   * Enum definition for the versioning mode of a COOL folder.
   *
   * IOV versioning in a folder is enabled only in the "MultiVersion" mode.
   * In the "SingleVersion" mode, a new object can be inserted only if its
   * IOV begins after the end of the IOV of the last object inserted.
   * The NONE value is only used internally for folder sets.
   *
   * @author Sven A. Schmidt and Andrea Valassi
   * @date 2004-11-05
   *///

  // Folder versioning mode.
  namespace FolderVersioning
  {
#ifndef COOL400CPP11ENUM
    enum Mode { NONE=-1, SINGLE_VERSION=0, MULTI_VERSION };
#else
    enum class Mode { NONE=-1, SINGLE_VERSION=0, MULTI_VERSION };

    // Overloaded operator<< for cool::FolderVersioning::Mode
    inline std::ostream&
    operator<<( std::ostream& s, const cool::FolderVersioning::Mode& mode )
    {
      return s << (int)mode;
    }
#endif
  }

}

#endif // COOLKERNEL_FOLDERVERSIONING_H
