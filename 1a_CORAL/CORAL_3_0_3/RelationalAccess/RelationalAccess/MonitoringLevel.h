#ifndef RELATIONALACCESS_MONITORINGLEVEL_H
#define RELATIONALACCESS_MONITORINGLEVEL_H 1

// First of all, set/unset CORAL240, CORAL300 and CORAL_HAS_CPP11 macros
#include "CoralBase/VersionInfo.h"

#ifndef CORAL300MG
#include "RelationalAccess/IMonitoring.h"
#else

namespace coral
{

  namespace monitor
  {

    enum Type
      {
        Info    = 0x00000001,
        Time    = (Info<<2),
        Warning = (Info<<3),
        Error   = (Info<<4),
        Config  = (Info<<5)
      };

    enum Level
      {
        Off     = 0,
        Minimal = Error,
        Default = Info | Error,
        Debug   = Info | Warning | Error   | Config,
        Trace   = Info | Time    | Warning | Error | Config
      };

  }

}
#endif

#endif // RELATIONALACCESS_MONITORINGLEVEL_H
