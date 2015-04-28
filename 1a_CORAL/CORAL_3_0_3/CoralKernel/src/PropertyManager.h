#ifndef PROPERTYMANAGER_H
#define PROPERTYMANAGER_H 1

// First of all, enable or disable the CORAL240 API extensions (bug #89707)
#include "CoralBase/VersionInfo.h"

// Include files
#include <map>
#include <boost/shared_ptr.hpp>
#include "CoralBase/../src/coral_thread_headers.h"
#include "CoralKernel/IPropertyManager.h"
#ifndef CORAL240PM
#include "CoralKernel/MonitorObject.h"
#endif

namespace coral
{

  /**
   * Class PropertyManager
   * Implementation of the IPropertyManager class.
   * PropertyManager objects own a mutex to provide thread safety.
   * The object stores a fixed property set, the set cannot be modified
   * in runtime (the property values can be modified).
   *///
  class PropertyManager
    : public IPropertyManager
#ifndef CORAL240PM
    , public MonitorObject
#endif
  {
  public:

    PropertyManager();
    virtual ~PropertyManager();
    virtual IProperty* property(const std::string&);

  private:

    void setDefaultProperties();
    void addProperty( const char* key, const char* value );

  private:

    std::map<std::string, boost::shared_ptr<IProperty> > m_cont;
#ifdef CORAL240PM
    coral::mutex m_mutex;
#endif

  };

}

#endif // PROPERTYMANAGER_H
