#ifndef CONNECTIONSERVICE_UIDGENERATOR_H
#define CONNECTIONSERVICE_UIDGENERATOR_H 1

#include <string>

namespace coral
{
  namespace UidGenerator
  {
    std::string generateConnectionUid();
    std::string generateSessionUid( const std::string& connId ); // ("" => tmp)
  }
}

#endif
