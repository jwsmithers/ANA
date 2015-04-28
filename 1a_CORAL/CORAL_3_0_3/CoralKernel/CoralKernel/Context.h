#ifndef CORALKERNEL_CONTEXT_H
#define CORALKERNEL_CONTEXT_H 1

// First of all, set/unset CORAL240, CORAL300 and CORAL_HAS_CPP11 macros
#include "CoralBase/VersionInfo.h"

// Replace Boost by c++11 in the CORAL3 API (task #49014)
#ifndef CORAL300CPP11
#include <boost/scoped_ptr.hpp>
#include "CoralBase/boost_thread_headers.h"
#else
#include <memory>
#include <mutex>
#endif

// Include files
#include <map>
#include <set>
#include <string>
#include "CoralKernel/IHandle.h"
#include "CoralKernel/ILoadableComponent.h"

namespace coral
{

  class IPluginManager;
  class IPropertyManager;
  class PluginManager;

  /// The context singleton class.
  class Context
  {
  public:

    /// Returns the instance of the singleton
#ifndef CORAL300CX
    static Context& instance( coral::IPluginManager* pluginManager = 0 );
#else
    static Context& instance(); // See bug #73566
#endif

    /**
       Loads a component given its name and an optional pointer
       to an external plugin manager (this option is used by CMS).
       Throws an exception in case of a problem
    *///
    void loadComponent( const std::string& componentName,
                        coral::IPluginManager* pluginManager = 0 );

    /// Returns a handle for a specified interface
    template< typename T > IHandle<T> query()
    {
#ifndef CORAL300CPP11
      boost::mutex::scoped_lock lock( m_mutex );
#else
      std::lock_guard<std::mutex> lock( m_mutex );
#endif
      for ( std::map<std::string, ILoadableComponent*>::iterator
              iComponent = m_components.begin(); iComponent != m_components.end(); ++iComponent )
      {
        T* component = dynamic_cast<T*>( iComponent->second );
        if ( component != 0 )
        {
          iComponent->second->addReference();
          return IHandle<T>( component );
        }
      }
      // Return an empty handle
      return IHandle<T>();
    }

    /// Returns a handle for a specified interface given a name
    template< typename T > IHandle<T> query( const std::string& name )
    {
#ifndef CORAL300CPP11
      boost::mutex::scoped_lock lock( m_mutex );
#else
      std::lock_guard<std::mutex> lock( m_mutex );
#endif
      std::map<std::string, ILoadableComponent*>::iterator iComponent = m_components.find( name );
      if ( iComponent == m_components.end() ) return IHandle<T>();
      T* component = dynamic_cast<T*>( iComponent->second );
      if ( component != 0 )
      {
        iComponent->second->addReference();
        return IHandle<T>( component );
      }
      else
      {
        return IHandle<T>();
      }
    }

    /// Returns the CORAL property manager component
    /// This was requested by CMS to avoid environment variables (task #6857)
#ifdef CORAL240PM
    /// Change the name from upper to lowercase for consistency (task #30840)
    IPropertyManager& propertyManager();
#else
    IPropertyManager& PropertyManager();
#endif

    /// Returns the list of plugins known by the internal CORAL plugin manager
    std::set<std::string> knownComponents() const;

    /// Returns the list of plugins loaded into the Context,
    /// by the internal or an external plugin manager
    std::set<std::string> loadedComponents() const;

  private:

    /// Constructor
#ifndef CORAL300CX
    Context( coral::IPluginManager* pluginManager = 0 );
#else
    Context(); // See bug #73566
#endif

    /// Copy constructor is private
    Context( const Context& );

    /// Assignment operator is private
    Context& operator=( const Context& );

    /// Destructor
    ~Context();

    /// Checks if a plugin has been loaded into the Context,
    /// by the internal or an external plugin manager
    bool existsComponent( const std::string& componentName );

  private:

    /// The mutex lock for the component map
#ifndef CORAL300CPP11
    boost::mutex m_mutex;
#else
    std::mutex m_mutex;
#endif

    /// The type of the loaded plugin map
    typedef std::map<std::string, ILoadableComponent*> m_components_type;

    /// The map of plugins loaded by the internal or an external plugin manager
    m_components_type m_components;

#ifndef CORAL300CX
    /// The internal plugin manager
    mutable coral::PluginManager*  m_nativePluginManager;

    /// The plugin manager proxy
    mutable coral::IPluginManager* m_pluginManager;
#else
#ifndef CORAL300CPP11
#error("ERROR: CORAL300CX extensions require CORAL300CPP11")
#else
    /// The internal plugin manager
    std::unique_ptr<coral::PluginManager> m_pluginManager;
#endif
#endif

    /// The property manager
#ifndef CORAL300CPP11
    boost::scoped_ptr<coral::IPropertyManager> m_propertyManager;
#else
    std::unique_ptr<coral::IPropertyManager> m_propertyManager;
#endif
  };

}
#endif
