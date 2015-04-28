#ifndef RELATIONALACCESS_IWEBCACHECONTROL_H
#define RELATIONALACCESS_IWEBCACHECONTROL_H 1

// First of all, enable or disable the CORAL240 API extensions (bug #89707)
#include "CoralBase/VersionInfo.h"

// Include files
#include <string>
#include <vector>

namespace coral
{

  // forward declarations
  class IWebCacheInfo;

  /**
     @class IWebCacheControl IWebCacheControl.h RelationalAccess/IWebCacheControl.h
     Interface for controlling the behaviour of web caches. By default data residing
     on a web cache are not refreshed unless it is set otherwise through this interface.
  *///
  class IWebCacheControl
  {

  public:

    /**
       Instructs the RDBMS backend that all the tables within the schema specified
       by the physical or logical connection should be refreshed, in case they are accessed.
       Deprecated. Sets default timeToLive to 1 for tables not identified.
    *///
    virtual void refreshSchemaInfo( const std::string& connection ) = 0;

    /**
       Instructs the RDBMS backend that the specified table within the schema specified
       by the physical or logical connection should be refreshed in case it is accessed.
       Deprecated: use instead setTabletimeToLive( connection, tableName, 1 ).
    *///
    virtual void refreshTable( const std::string& connection,
                               const std::string& tableName ) = 0;

#ifdef CORAL300WC
    /**
       Instructs the RDBMS backend to cache queries that use the table specified by tableName
       within the schema specified by connection for the time length specified by timeToLive,
       1=short, 2=long, 3=forever.  Default 2.
    *///
    virtual void setTableTimeToLive( const std::string& connection,
                                     const std::string& tableName,
                                     int timeToLive ) = 0;
#endif

    /**
       Returns the web cache information for a schema given the corresponding physical or
       logical connection.
    *///
    virtual const IWebCacheInfo& webCacheInfo( const std::string& connection ) const = 0;

    /**
       Returns the previous compression level
    *///
    virtual int compressionLevel() = 0;

    /**
       Sets the compression level for data transfer, 0 - off, 1 - fast, 5 - default, 9 - maximum
    *///
    virtual void setCompressionLevel( int level ) = 0;

    /**
       Sets the list of the web cache proxies for the fail-over mechanism
    *///
    virtual void setProxyList( const std::vector<std::string>& proxyList ) = 0;

  protected:

    /// Protected empty destructor
    virtual ~IWebCacheControl() {}

  };

}

#endif // RELATIONALACCESS_IWEBCACHECONTROL_H
