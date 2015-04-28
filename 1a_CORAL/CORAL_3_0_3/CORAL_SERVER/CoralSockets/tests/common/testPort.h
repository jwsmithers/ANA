#ifndef COMMON_TESTPORT_H 
#define COMMON_TESTPORT_H 1

namespace coral
{
  namespace CoralSockets
  {
    // Get the port used for testing (bug #102966)
    static unsigned int BuildUniquePortNumber()
    {
      // The unique prefix across nightly slots
      static unsigned int slotSuffix = 0;
      if ( slotSuffix == 0 )
      {
        const char* slotname_c = ::getenv( "LCG_NGT_SLT_NAME" );
        const std::string slotname( slotname_c ? slotname_c : "" );
        if ( slotname == "" )
          slotSuffix = 0;
        else if ( slotname == "dev" )
          slotSuffix = 1;
        else if ( slotname == "dev1" )
          slotSuffix = 2;
        else if ( slotname == "dev2" )
          slotSuffix = 3;
        else if ( slotname == "dev3" )
          slotSuffix = 4;
        else if ( slotname == "dev4" )
          slotSuffix = 5;
        else if ( slotname == "release" )
          slotSuffix = 6;
        else if ( slotname == "test" )
          slotSuffix = 7;
        else if ( slotname == "test1" )
          slotSuffix = 8;
        else if ( slotname == "externals" )
          slotSuffix = 9;
        else
          slotSuffix = 0;
      }
      // The three-digit unique suffix across platforms
      static unsigned int platformSuffix = 999;
      if ( platformSuffix == 999 )
      {
        const char* cmtcfghash_c = ::getenv( "CORAL_CMTCONFIG_HASH" );
        if ( !cmtcfghash_c )
        {
          platformSuffix = 0;  // should print a warning?
        }
        else
        {
          std::string platformPrefix = "";
          platformPrefix = std::string( cmtcfghash_c );
          if ( platformPrefix.size() != 3 )
            throw std::runtime_error( "CORAL_CMTCONFIG_HASH '"+platformPrefix+"' is not three-character long" );
          else if ( platformPrefix == "999" )
            throw std::runtime_error( "No platform-specific CORAL_CMTCONFIG_HASH is defined: add CMTCONFIG to cmt/requirements" );
          platformSuffix = atoi( platformPrefix.c_str() );
        }
      }
      // Return the unique number
      return 40000 + slotSuffix*1000 + platformSuffix;
    }

    // Get the port used for testing
    static unsigned int getTestPort()
    {
      //return 50007;
      return BuildUniquePortNumber();
    }
  }
}

#endif // COMMON_TESTPORT_H
