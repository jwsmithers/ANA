#include <iostream>
#include <string>
#include <sstream>

//#include "CoralBase/Attribute.h" // 1. INCLUDE THIS HERE TO FIX IT

#undef CORALBASE_CLANGTEST_ATLASTEST
//#define CORALBASE_CLANGTEST_ATLASTEST 1

// From /afs/cern.ch/atlas/software/builds/nightlies/lcg/GAUDI/rel_3/InstallArea/include/GaudiKernel/IMessageSvc.h

namespace MSG {
  enum Level {
    NIL = 0,
    VERBOSE,
    DEBUG,
    INFO,
    WARNING,
    ERROR,
    FATAL,
    ALWAYS,
    NUM_LEVELS
  };
}

// From /afs/cern.ch/atlas/software/builds/nightlies/lcg/GAUDI/rel_3/InstallArea/include/GaudiKernel/MsgStream.h

class MsgStream
{
public:
  MsgStream() {}
  ~MsgStream() {}
  std::ostringstream& stream() { return m_stream; }
  MsgStream& operator<< (MSG::Level level) { return report(level); }
  MsgStream& report(int) { return *this; } // ignore int lvl argument
  virtual MsgStream& doOutput() { return *this; } // do nothing
private:
  std::ostringstream m_stream;
};

inline MsgStream& endmsg(MsgStream& s)
{
  return s.doOutput();
}

template <typename T>
MsgStream& operator<< ( MsgStream& lhs, const T& arg )
{
  try { lhs.stream() << arg; } catch (...) {} // 2. OR COMMENT OUT TO FIX IT
  return lhs;
}

#ifdef CORALBASE_CLANGTEST_ATLASTEST

// From /afs/cern.ch/atlas/software/builds/nightlies/lcg/AtlasCore/rel_3/InstallArea/include/AthenaBaseComps/AthenaBaseComps/AthMsgStreamMacros.h
#define ATH_MSG_LVL_NOCHK(lvl, x)               \
  this->msg(lvl) << x << endmsg
#define ATH_MSG_LVL(lvl, x)                     \
  do { ATH_MSG_LVL_NOCHK(lvl, x); } while (0)
#define ATH_MSG_DEBUG(x) ATH_MSG_LVL(MSG::DEBUG, x)

// From /afs/cern.ch/atlas/software/builds/nightlies/lcg/AtlasCore/rel_3/InstallArea/include/AthenaBaseComps/AthenaBaseComps/AthMessaging.h

class AthMessaging
{
public:
  AthMessaging(){}
  virtual ~AthMessaging() {}
  MsgStream& msg() const;
  MsgStream& msg (const MSG::Level lvl) const;
private:
  AthMessaging( const AthMessaging& rhs ); //> not implemented
  AthMessaging& operator=( const AthMessaging& rhs ); //> not implemented
private:
  mutable MsgStream m_msg;
};

inline
MsgStream&
AthMessaging::msg() const
{ return m_msg; }

inline
MsgStream&
AthMessaging::msg (const MSG::Level lvl) const
{ return m_msg << lvl; }

// From  /afs/cern.ch/atlas/software/builds/nightlies/lcg/AtlasCore/rel_3/InstallArea/include/AthenaBaseComps/AthenaBaseComps/AthAlgTool.h

class AthAlgTool : public ::AthMessaging
{
public:
  using AthMessaging::msg;
  AthAlgTool() : ::AthMessaging() {}
  virtual ~AthAlgTool() {}
};

#endif

// From ATLAS/Database/IOVDbMetaDataTools (IOVDbMetaDataTools-00-00-38)

class IOVDbMetaDataTool
#ifdef CORALBASE_CLANGTEST_ATLASTEST
  : virtual public AthAlgTool
#endif
{
public:
  IOVDbMetaDataTool();
  virtual ~IOVDbMetaDataTool() {}
};

#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"

IOVDbMetaDataTool::IOVDbMetaDataTool()
#ifdef CORALBASE_CLANGTEST_ATLASTEST
  : AthAlgTool()
#endif
{
  coral::AttributeList atl;
  atl.extend( "i", "int" );
  atl["i"].setValue( 1 );
  coral::Attribute& at = atl["i"];
  std::cout << "Print out Attribute " << at << std::endl;
#ifdef CORALBASE_CLANGTEST_ATLASTEST
  ATH_MSG_DEBUG( "Print AttributeList " << atl ); // BUILD FAILS bug #100663
  this->msg() << atl << endmsg; // BUILD FAILS bug #100663
  ATH_MSG_DEBUG( "Print Attribute " << at ); // BUILD FAILS bug #100663
  this->msg() << at << endmsg; // BUILD FAILS bug #100663
#endif
  MsgStream msg; msg << atl << ", " << at << endmsg; // BUILD FAILS bug #100663
}

int main()
{
  IOVDbMetaDataTool tool;
  return 0;
}
