//#include <iostream>
#include <sstream>
#include <map>
#include "CoralBase/../src/coral_thread_headers.h"
#include "UidGenerator.h"

std::string
coral::UidGenerator::generateConnectionUid()
{
  std::stringstream uid;
  static unsigned long connection_guid = 0;
  uid << "C#" << ++connection_guid; // start at 1
  //std::cout << "UID: " << uid.str() << std::endl;
  return uid.str();
}

std::string
coral::UidGenerator::generateSessionUid( const std::string& connId )
{
  std::stringstream uid;
  // Temporary session handle
  if ( connId == "" )
  {
    static unsigned long tmpsess_guid = 0;
    uid << "TS#" << ++tmpsess_guid; // start at 1
    //std::cout << "UID: " << uid.str() << std::endl;
  }
  // Real session associated to a connection
  else
  {
    static unsigned long session_guid = 0;
    uid << "S#" << ++session_guid; // start at 1
    static std::map< std::string, unsigned long > session_ruids;
    static coral::mutex mutex_for_ruids;
    {
      coral::lock_guard lock( mutex_for_ruids );
      if ( session_ruids.find( connId ) == session_ruids.end() )
        session_ruids[connId] = 0;
      uid << "(" << connId
          << ".s#" << ++session_ruids[connId] << ")"; // start at 1
    }
    //std::cout << "UID: " << uid.str() << std::endl;
  }
  return uid.str();
}
