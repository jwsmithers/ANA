// First of all, enable or disable the CORAL240 API extensions (bug #89707)
#include "CoralBase/VersionInfo.h"

// Include files
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <sstream>
#include <stdexcept>
#ifdef _WIN32
#include <windows.h>
#else
#include <dlfcn.h>
#endif
#include <unistd.h>
#include "CoralBase/boost_filesystem_headers.h"
#include "CoralBase/../src/coral_thread_headers.h"
#include "CoralBase/MessageStream.h"
#include "CoralKernel/ILoadableComponentFactory.h"
#include "PluginManager.h"

// See http://msdn.microsoft.com/en-us/library/ms680582(VS.85).aspx
#ifdef _WIN32
#include <strsafe.h>
std::string GetLastErrorMessage()
{
  LPVOID lpMsgBuf;
  DWORD dw = ::GetLastError();
  ::FormatMessage( FORMAT_MESSAGE_ALLOCATE_BUFFER |
                   FORMAT_MESSAGE_FROM_SYSTEM |
                   FORMAT_MESSAGE_IGNORE_INSERTS,
                   NULL,
                   dw,
                   MAKELANGID( LANG_NEUTRAL, SUBLANG_DEFAULT ),
                   (LPTSTR) &lpMsgBuf,
                   0,
                   NULL );
  std::string lpMsg( (LPCTSTR)lpMsgBuf );
  ::LocalFree(lpMsgBuf);
  lpMsg.erase( lpMsg.size()-2, 2 ); // Remove trailing newline
  std::stringstream msg;
  msg << "( GetLastError=" << dw << " : '" << lpMsg << "' )";
  return msg.str();
}
#endif


coral::ILoadableComponent*
coral::PluginManager::newComponent( const std::string& componentName )
{
  //std::cout << "PluginManager creating " << componentName << " component" << std::endl;
  coral::MessageStream log( "PluginManager" );
  log << coral::Info << "PluginManager creating " << componentName << " component" << coral::MessageStream::endmsg;

  coral::lock_guard lock( m_mutex );
  if ( ! m_initialized )
    this->initialize();

  for ( int i = 0; i < 2; ++i ) {
    std::map< std::string, std::pair< std::string, coral::ILoadableComponentFactory* > >::iterator iFactoryEntry = m_factories.find( componentName );
    std::string libraryToLoad = "";
    if ( iFactoryEntry != m_factories.end() ) {
      std::pair<std::string, coral::ILoadableComponentFactory*>& iFactory = iFactoryEntry->second;
      if ( iFactory.second ) return iFactory.second->component();
      else libraryToLoad = iFactory.first;
    }

    if ( ( ! libraryToLoad.empty() ) && i == 0 )
    {
      //std::cout << "PluginManager needs to load " << libraryToLoad << " library" << std::endl;
      log << coral::Info << "PluginManager needs to load " << componentName << " component" << coral::MessageStream::endmsg;
      this->loadLibrary( libraryToLoad );
    }
  }
  return 0;
}

std::set<std::string> coral::PluginManager::knownPlugins() const
{
  std::set<std::string> comlist;

  for( std::map<std::string,std::pair<std::string,coral::ILoadableComponentFactory*> >::const_iterator comsit = m_factories.begin();
       comsit != m_factories.end();
       ++comsit )
  {
    comlist.insert( (*comsit).first );
  }

  return comlist;
}

coral::PluginManager::PluginManager() :
  m_factories(),
  m_initialized( false ),
  m_mutex(),
  m_openLibraries()
{
  coral::ILoadableComponentFactory* p = 0;

  //========================================= CORAL SERVICES REGISTRY ========================================//
  std::string pluginName  = "CORAL/Services/ConnectionService"; std::string libraryName = "ConnectionService";
  m_factories.insert( std::make_pair( pluginName, std::make_pair( libraryName, p ) ) );

  pluginName  = "CORAL/Services/RelationalService"; libraryName = "RelationalService";
  m_factories.insert( std::make_pair( pluginName, std::make_pair( libraryName, p ) ) );

  pluginName  = "CORAL/Services/MonitoringService"; libraryName = "MonitoringService";
  m_factories.insert( std::make_pair( pluginName, std::make_pair( libraryName, p ) ) );

  pluginName  = "CORAL/Services/EnvironmentAuthenticationService"; libraryName = "EnvironmentAuthenticationService";
  m_factories.insert( std::make_pair( pluginName, std::make_pair( libraryName, p ) ) );

  pluginName  = "CORAL/Services/XMLAuthenticationService"; libraryName = "XMLAuthenticationService";
  m_factories.insert( std::make_pair( pluginName, std::make_pair( libraryName, p ) ) );

  pluginName  = "CORAL/Services/RelationalAuthenticationService"; libraryName = "RelationalAuthenticationService";
  m_factories.insert( std::make_pair( pluginName, std::make_pair( libraryName, p ) ) );

  pluginName  = "CORAL/Services/XMLLookupService"; libraryName = "XMLLookupService";
  m_factories.insert( std::make_pair( pluginName, std::make_pair( libraryName, p ) ) );

  pluginName  = "CORAL/Services/LFCReplicaService"; libraryName = "LFCReplicaService";
  m_factories.insert( std::make_pair( pluginName, std::make_pair( libraryName, p ) ) );

  pluginName  = "CORAL/Services/CoralAuthenticationService"; libraryName = "CoralAuthenticationService";
  m_factories.insert( std::make_pair( pluginName, std::make_pair( libraryName, p ) ) );

  pluginName  = "CORAL/Services/CoralServerFacade"; libraryName = "CoralServer";
  m_factories.insert( std::make_pair( pluginName, std::make_pair( libraryName, p ) ) );

  pluginName  = "CORAL/Services/CoralProxyFacade"; libraryName = "CoralProxy";
  m_factories.insert( std::make_pair( pluginName, std::make_pair( libraryName, p ) ) );

  pluginName  = "CORAL/Services/ConnectionService2"; libraryName = "ConnectionService";
  m_factories.insert( std::make_pair( pluginName, std::make_pair( libraryName, p ) ) );

  char* userAuthSvc = ::getenv ( "CORAL_AUTH_SERVICE_LIBRARY" );
  if ( userAuthSvc ) {
    pluginName  = "CORAL/Services/UserDefinedAuthenticationService"; libraryName = std::string( userAuthSvc );
    m_factories.insert( std::make_pair( pluginName, std::make_pair( libraryName, p ) ) );
  }

  char* userLookupSvc = ::getenv ( "CORAL_LOOKUP_SERVICE_LIBRARY" );
  if ( userLookupSvc ) {
    pluginName  = "CORAL/Services/UserDefinedLookupService"; libraryName = std::string( userLookupSvc );
    m_factories.insert( std::make_pair( pluginName, std::make_pair( libraryName, p ) ) );
  }

  //==================================== RELATIONAL ACCESS PLUGINS REGISTRY ==================================//
  pluginName  = "CORAL/RelationalPlugins/oracle"; libraryName = "OracleAccess";
  m_factories.insert( std::make_pair( pluginName, std::make_pair( libraryName, p ) ) );

  pluginName  = "CORAL/RelationalPlugins/mysql"; libraryName = "MySQLAccess";
  m_factories.insert( std::make_pair( pluginName, std::make_pair( libraryName, p ) ) );

  pluginName  = "CORAL/RelationalPlugins/sqlite"; libraryName = "SQLiteAccess";
  m_factories.insert( std::make_pair( pluginName, std::make_pair( libraryName, p ) ) );

  pluginName  = "CORAL/RelationalPlugins/frontier"; libraryName = "FrontierAccess";
  m_factories.insert( std::make_pair( pluginName, std::make_pair( libraryName, p ) ) );

  pluginName  = "CORAL/RelationalPlugins/coral"; libraryName = "CoralAccess";
  m_factories.insert( std::make_pair( pluginName, std::make_pair( libraryName, p ) ) );

  //==================================== CORALSERVER MONITORING ==============================================//
  pluginName  = "CORAL/Services/CoralMonitoringService"; libraryName = "CoralMonitor";
  m_factories.insert( std::make_pair( pluginName, std::make_pair( libraryName, p ) ) );

}


coral::PluginManager::~PluginManager()
{
  for ( std::list<void*>::reverse_iterator iHandle = m_openLibraries.rbegin();
        iHandle != m_openLibraries.rend(); ++iHandle ) {
#ifdef _WIN32
    //    ::FreeLibrary( (HMODULE) *iHandle );
#else
    //    ::dlclose( *iHandle );
#endif
  }
}


void
coral::PluginManager::initialize()
{
#ifdef _WIN32
  char* coral_plugins = ::getenv( "PATH" );
#else
  char* coral_plugins = ::getenv( "LD_LIBRARY_PATH" );
#endif
  if ( coral_plugins )
  {
    coral::MessageStream log( "PluginManager" );
    log << coral::Verbose << "PluginManager library search path is: [" << coral_plugins << "]" << coral::MessageStream::endmsg;
    // Scan the directories to find plugin definitition files "plugins.coral"
    // and populate the map. [NO LONGER SUPPORTED (bug #95491): only the
    // factories hardcoded in PluginManager.cpp are supported from now on.]
    //log << coral::Verbose << "PluginManager intializing using shared objects search path as: [" << coral_plugins << "]" << coral::MessageStream::endmsg;
  }
  // Set the flag to true
  m_initialized = true;
}


void
coral::PluginManager::loadLibrary( const std::string& libraryName )
{
  coral::MessageStream log( "PluginManager" );
  // Load the shared library and fetch the available plugins!
#ifdef _WIN32

  std::string libpath("");

  libpath.append("lcg_");
  libpath.append(libraryName);
  libpath.append(".dll");

  log << coral::Info << "Try to load shared library [" << libraryName << "] as [" << libpath << "]" << coral::MessageStream::endmsg;

  void* handle = ::LoadLibrary( libpath.c_str() );
  if ( ! handle )
  {
    throw std::runtime_error( "Could not load the shared library \"" + libraryName + "\" " + GetLastErrorMessage() );
  }
#else
#ifdef linux
  static bool ociDebug = true;
  if ( ociDebug && libraryName == "OracleAccess" && getenv( "CORAL_ORA_OCI_DEBUG_OCIENVCREATE2" ) )
  {
    ociDebug = false;
    std::stringstream cmd;
    cmd << "strace -p " << getpid() << " 2>&1 &";
    std::cout << "***** PluginManager CORAL_ORA_OCI_DEBUG_OCIENVCREATE2 is set  *****" << std::endl;
    if ( getenv( "LD_LIBRARY_PATH" ) ) std::cout << "LD_LIBRARY_PATH = " << std::string( getenv( "LD_LIBRARY_PATH" ) ) << std::endl;
    std::cout << "***** OracleAccess DEBUG: strace OCIEnvCreate calls (START) *****" << std::endl;
    system( cmd.str().c_str() );
    // Sleep 1 second (else dlopen may be executed before strace is attached)
    ::sleep(1);
  }
#endif
  static bool first = true;
  if ( first && !::getenv( "CORAL_PRELOADGLOBUS_FIXBUG70641" ) ) first = false;
  if ( first )
  {
    first = false;
    if ( sizeof( void* ) == 4 )
    {
      log << coral::Debug << "Preload the globus 32bit gssapi library (workaround for bug #70641)" << coral::MessageStream::endmsg;
      void* globus32 = ::dlopen( "libglobus_gssapi_gsi_gcc32dbgpthr.so", RTLD_GLOBAL | RTLD_LAZY );
      if ( globus32 )
      {
        log << coral::Info << "Preloaded the globus 32bit gssapi library (workaround for bug #70641)" << coral::MessageStream::endmsg;
        m_openLibraries.push_back( globus32 ); // Fix Coverity RESOURCE_LEAK
      }
      else
      {
        log << coral::Warning << "Could not preload the globus 32bit gssapi library (workaround for bug #70641)" << coral::MessageStream::endmsg;
      }
    }
    else
    {
      log << coral::Debug << "Preload the globus 64bit gssapi library (workaround for bug #70641)" << coral::MessageStream::endmsg;
      void* globus64 = ::dlopen( "libglobus_gssapi_gsi_gcc64dbgpthr.so", RTLD_GLOBAL | RTLD_LAZY );
      if ( globus64 )
      {
        log << coral::Info << "Preloaded the globus 64bit gssapi library (workaround for bug #70641)" << coral::MessageStream::endmsg;
        m_openLibraries.push_back( globus64 ); // Fix Coverity RESOURCE_LEAK
      }
      else
      {
        log << coral::Warning << "Could not preload the globus 64bit gssapi library (workaround for bug #70641)" << coral::MessageStream::endmsg;
      }
    }
  }
#ifdef __APPLE__
  //void* handle = ::dlopen( ( "liblcg_" + libraryName + ".so" ).c_str(), RTLD_GLOBAL | RTLD_LAZY ); // Use .so on mac instead of .dylib (bug #37371)
  void* handle = ::dlopen( ( "liblcg_" + libraryName + ".dylib" ).c_str(), RTLD_GLOBAL | RTLD_LAZY ); // Use .dylib again on mac (sr #141482)
#else
  void* handle = ::dlopen( ( "liblcg_" + libraryName + ".so" ).c_str(), RTLD_GLOBAL | RTLD_LAZY );
#endif
  if ( handle == 0 ) {
    throw std::runtime_error( "Could not load the shared library \"" + libraryName + "\" : " + std::string( ::dlerror() ) );
  }
#endif
  log << coral::Info << "PluginManager loaded " << libraryName << " library" << coral::MessageStream::endmsg;

  // All shared libraries must have at least one component factory
  {
    std::string symbolName = "coral_component_factory";
#if defined(_WIN32) || ( !defined(__clang__) && !defined(CORAL240PL) )
    // OLD IMPLEMENTATION: inside shared library, locate static factory ptr
    // Used always for Windows; never for clang; else if !defined(CORAL24PL)
#ifdef _WIN32
    void* symbol = ::GetProcAddress( (HMODULE) handle, symbolName.c_str() );
#else
    void* symbol = ::dlsym( handle, symbolName.c_str() );
#endif
    if ( ! symbol )
      throw std::runtime_error( "Could not find the symbol \"coral_component_factory\" in the shared library \"" + libraryName + "\"" );
    coral::ILoadableComponentFactory* factory = *( (coral::ILoadableComponentFactory**) symbol );
    if ( ! factory ) // Avoid segfault seen on clang (bug #91133)
      throw std::runtime_error( "Symbol \"coral_component_factory\" was found in the shared library \"" + libraryName + "\" but points to a NULL factory pointer?" );
#else
    // NEW IMPLEMENTATION: inside shared library, locate ptr to method
    // that instantiates a static factory (fix clang bug #92167)
    // Used never for Windows; always for clang; else if defined(CORAL24PL)
    typedef coral::ILoadableComponentFactory* getfactory_t ();
    getfactory_t* get_factory = 0;
#ifndef __APPLE__
    void* symbol = ::dlsym( handle, symbolName.c_str() );
    if ( ! symbol )
      throw std::runtime_error( "Could not find the symbol \"coral_component_factory\" in the shared library \"" + libraryName + "\" : " + std::string( ::dlerror() ) );
    get_factory = (getfactory_t*) symbol;
    if ( ! get_factory )
      throw std::runtime_error( "Symbol \"coral_component_factory\" was found in the shared library \"" + libraryName + "\" but could not be cast to a ptr to a get_factory method" );
#else
    // Fix ISO C++ warning on mac (bug #92345) in casting ptr2fun to ptr2obj
    // See http://blog.toidinamai.de/en/programming/dlsym:
    // cast dlsym from 'void*' dlsym(void*, const char*) to 'getfactory_t*'
    typedef getfactory_t *getfactory_dlsym_t (void*, const char*);
    getfactory_dlsym_t* getfactory_dlsym = ((getfactory_dlsym_t*)(&::dlsym));
    if ( ! getfactory_dlsym )
      throw std::runtime_error( "Could not cast the dlsym system call from a function finding a ptr to void to one finding a ptr to a get_factory method" );
    get_factory = (*getfactory_dlsym)( handle, symbolName.c_str() );
    if ( ! get_factory )
      throw std::runtime_error( "Could not find the symbol \"coral_component_factory\" in the shared library \"" + libraryName + "\" : " + std::string( ::dlerror() ) );
#endif
    coral::ILoadableComponentFactory* factory = get_factory();
    if ( ! factory )
      throw std::runtime_error( "Symbol \"coral_component_factory\" was found in the shared library \"" + libraryName + "\" but a factory could not be obtained from the get_factory method" );
#endif
    std::string componentName = factory->name();
    m_factories.find( componentName )->second.second = factory;
    log << coral::Info << "PluginManager loaded " << componentName << " factory from " << libraryName << " library" << coral::MessageStream::endmsg;
  }

  // Some shared libraries have a second component factory
  {
    std::string symbolName = "coral_component_factory2";
    coral::ILoadableComponentFactory* factory = 0;
#if defined(_WIN32) || ( !defined(__clang__) && !defined(CORAL240PL) )
    // OLD IMPLEMENTATION: inside shared library, locate static factory ptr
    // Used always for Windows; never for clang; else if !defined(CORAL24PL)
#ifdef _WIN32
    void* symbol = ::GetProcAddress( (HMODULE) handle, symbolName.c_str() );
#else
    void* symbol = ::dlsym( handle, symbolName.c_str() );
#endif
    if ( symbol )
    {
      factory = *( (coral::ILoadableComponentFactory**) symbol );
      if ( ! factory ) // Avoid segfault seen on clang (bug #91133)
        throw std::runtime_error( "Symbol \"coral_component_factory2\" was found in the shared library \"" + libraryName + "\" but points to a NULL factory pointer?" );
    }
#else
    // NEW IMPLEMENTATION: inside shared library, locate ptr to method
    // that instantiates a static factory (fix clang bug #92167)
    // Used never for Windows; always for clang; else if defined(CORAL24PL)
    typedef coral::ILoadableComponentFactory* getfactory_t ();
    getfactory_t* get_factory = 0;
#ifndef __APPLE__
    void* symbol = ::dlsym( handle, symbolName.c_str() );
    if ( symbol )
    {
      get_factory = (getfactory_t*) symbol;
      if ( ! get_factory )
        throw std::runtime_error( "Symbol \"coral_component_factory2\" was found in the shared library \"" + libraryName + "\" but could not be cast to a ptr to a get_factory method" );
    }
#else
    // Fix ISO C++ warning on mac (bug #92345) in casting ptr2fun to ptr2obj
    // See http://blog.toidinamai.de/en/programming/dlsym:
    // cast dlsym from 'void*' dlsym(void*, const char*) to 'getfactory_t*'
    typedef getfactory_t *getfactory_dlsym_t (void*, const char*);
    getfactory_dlsym_t* getfactory_dlsym = ((getfactory_dlsym_t*)(&::dlsym));
    if ( ! getfactory_dlsym )
      throw std::runtime_error( "Could not cast the dlsym system call from a function finding a ptr to void to one finding a ptr to a get_factory method" );
    get_factory = (*getfactory_dlsym)( handle, symbolName.c_str() );
#endif
    if ( get_factory )
    {
      factory = get_factory();
      if ( ! factory )
        throw std::runtime_error( "Symbol \"coral_component_factory2\" was found in the shared library \"" + libraryName + "\" but a factory could not be obtained from the get_factory method" );
    }
#endif
    if ( factory )
    {
      std::string componentName = factory->name();
      m_factories.find( componentName )->second.second = factory;
      log << coral::Info << "PluginManager loaded " << componentName << " factory from " << libraryName << " library" << coral::MessageStream::endmsg;
    }
  }

  // Register the shared library
  m_openLibraries.push_back( handle );
}
