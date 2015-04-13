#include "CoralBase/Exception.h"
#include "CoralKernel/Property.h"
#include "PropertyManager.h"


coral::PropertyManager::PropertyManager()
  : m_cont()
#ifdef CORAL240PM
  , m_mutex()
#endif
{
  setDefaultProperties();
}


coral::PropertyManager::~PropertyManager()
{
}


coral::IProperty*
coral::PropertyManager::property(const std::string& key)
{
  {
    // MONITOR_START_CRITICAL
#ifndef CORAL240PM
    ThreadTraits::LOCK MONITOR_LOCK(this->_monitor_lock);
#else
    coral::lock_guard lock( m_mutex );
#endif
    std::map<std::string, boost::shared_ptr<IProperty> >::iterator loc = m_cont.find(key);
    return loc == m_cont.end() ? NULL : loc->second.get();
    //MONITOR_END_CRITICAL
  }
}


void
coral::PropertyManager::setDefaultProperties()
{
  addProperty("CredentialDatabase", "sqlite_file:coral_credentials.db");
  addProperty("EncryptionKey","");
  addProperty("AuthenticationFile", "authentication.xml");
  addProperty("DBLookupFile", "dblookup.xml");
  addProperty("Server_Hostname", "localhost");
  addProperty("Server_Port", "8080");
}


void
coral::PropertyManager::addProperty( const char* key, const char* value )
{
  boost::shared_ptr<IProperty> prop(new Property);
  if ( !prop->set(value) ) // Fix Coverity CHECKED_RETURN
    throw Exception( "Failed to set property", "addProperty", "PropertyManager" );
  m_cont[key] = prop;
}
