// First of all, enable or disable the CORAL240 API extensions (bug #89707)
#include "CoralBase/VersionInfo.h"

#include "CoralKernel/Property.h"

using namespace coral;

Property::Property() :
#ifndef CORAL240PM
  m_actualID(0)
#else
  m_lastID(0), m_mutex()
#endif
{
  //std::cout << "Create Property " << this << std::endl;
}

Property::~Property()
{
  //std::cout << "Delete Property " << this << std::endl;
}

bool Property::set(const std::string& value)
{
  {
    // MONITOR_START_CRITICAL
#ifndef CORAL240PM
    ThreadTraits::LOCK MONITOR_LOCK(this->_monitor_lock);
#else
#ifdef CORAL300CPP11
    std::lock_guard<std::mutex> lock( m_mutex );
#else
    boost::mutex::scoped_lock lock( m_mutex );
#endif
#endif
    m_value = value;
    for( std::map<CallbackID, Callback>::iterator i = m_callbacks.begin();
         i != m_callbacks.end(); ++i ) i->second( m_value );
    return true;
    // MONITOR_END_CRITICAL
  }
}

const std::string& Property::get() const
{
  {
    // MONITOR_START_CRITICAL
#ifndef CORAL240PM
    ThreadTraits::LOCK MONITOR_LOCK(this->_monitor_lock);
#else
#ifdef CORAL300CPP11
    std::lock_guard<std::mutex> lock( m_mutex );
#else
    boost::mutex::scoped_lock lock( m_mutex );
#endif
#endif
    return m_value;
    // MONITOR_END_CRITICAL
  }
}


Property::CallbackID Property::registerCallback(Property::Callback& cb)
{
  {
    // MONITOR_START_CRITICAL
#ifndef CORAL240PM
    ThreadTraits::LOCK MONITOR_LOCK(this->_monitor_lock);
    m_callbacks[m_actualID] = cb;
    return m_actualID++;
#else
#ifdef CORAL300CPP11
    std::lock_guard<std::mutex> lock( m_mutex );
#else
    boost::mutex::scoped_lock lock( m_mutex );
#endif
    m_callbacks[m_lastID] = cb;
    return m_lastID++;
#endif
    // MONITOR_END_CRITICAL
  }
}

bool Property::unregisterCallback(Property::CallbackID& id)
{
  {
    // MONITOR_START_CRITICAL
#ifndef CORAL240PM
    ThreadTraits::LOCK MONITOR_LOCK(this->_monitor_lock);
#else
#ifdef CORAL300CPP11
    std::lock_guard<std::mutex> lock( m_mutex );
#else
    boost::mutex::scoped_lock lock( m_mutex );
#endif
#endif
    return m_callbacks.erase(id) > 0;
    // MONITOR_END_CRITICAL
  }
}
