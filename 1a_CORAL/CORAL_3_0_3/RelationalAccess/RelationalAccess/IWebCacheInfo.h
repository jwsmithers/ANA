#ifndef RELATIONALACCESS_IWEBCACHEINFO_H
#define RELATIONALACCESS_IWEBCACHEINFO_H 1

// First of all, enable or disable the CORAL240 API extensions (bug #89707)
#include "CoralBase/VersionInfo.h"

// Include files
#include <string>

namespace coral
{

  /**
     @class IWebCacheInfo IWebCacheInfo.h RelationalAccess/IWebCacheInfo.h
     Interface for accessing the web cache policy for a given schema
  *///
  class IWebCacheInfo
  {

  public:

    /// Checks if the schema info (data dictionary) is cached, i.e. it does not need to be refreshed.
    /// Deprecated.  Returns true if the default timeToLive != 1.
    virtual bool isSchemaInfoCached() const = 0;

    /// Checks if a table in the schema is cached, i.e. it does not need to be refreshed.
    /// Deprecated: use instead tableTimeToLive( tableName ) != 1.
    virtual bool isTableCached( const std::string& tableName ) const = 0;

#ifdef CORAL300WC
    /// Returns timeToLive value (1=short, 2=long, 3=forever) for a table in the schema.
    virtual int tableTimeToLive( const std::string& tableName ) const = 0;
#endif

  protected:

    /// Protected empty destructor
    virtual ~IWebCacheInfo() {}

  };

}

#endif // RELATIONALACCESS_IWEBCACHEINFO_H
