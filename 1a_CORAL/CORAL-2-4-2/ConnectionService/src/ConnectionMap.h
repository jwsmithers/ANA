#ifndef CONNECTIONSERVICE_CONNECTIONMAP_H
#define CONNECTIONSERVICE_CONNECTIONMAP_H

#include "ConnectionHandle.h"
#include <map>

namespace coral
{
  namespace ConnectionService
  {

    /// wrapper on std::map container for storing coral IConnection objects
    class ConnectionMap
    {

    public:

      /// constructor
      ConnectionMap();

      /// destructor
      virtual ~ConnectionMap();

      class Iterator
      {
      public:
        explicit Iterator(std::multimap<std::string, ConnectionHandle >::iterator theIterator) : m_iterator(theIterator){}
        virtual ~Iterator() {}
        Iterator(const Iterator& rhs) : m_iterator(rhs.m_iterator){}
        Iterator& operator=(const Iterator& rhs){
          if ( this != &rhs ) // Fix Coverity SELF_ASSIGN
            m_iterator = rhs.m_iterator;
          return *this;
        }
        bool operator==( const Iterator& rhs ) const { return m_iterator == rhs.m_iterator; }
        bool operator!=( const Iterator& rhs ) const { return m_iterator != rhs.m_iterator; }
        void operator++() { ++m_iterator; }
        ConnectionHandle* operator->() { return &m_iterator->second; }
        ConnectionHandle& operator*() { return m_iterator->second; }
      private:
        friend class ConnectionMap;
        std::multimap<std::string, ConnectionHandle >::iterator m_iterator;

      };

      /// adds the specified connection in the map associated to the specified connection handle key.
      bool add( const ConnectionHandle& connectionHandle );

      /// lookup the specified connection string in the available connections
      Iterator lookup( const std::string& technology, const std::string& serviceName );

      /// removes the connection entry for the specified connectionId key
      bool remove( const ConnectionHandle& connectionHandle );

      /// removes the connection entry for the specified connectionId ke
      void remove( Iterator theElement );

      /// returns the valid map iterator
      Iterator find( const ConnectionHandle& connectionHandle );

      /// returns the valid map iterator
      Iterator begin();

      /// returns the end map iterator
      Iterator end();

      /// clear the underlying map
      void clear();

      /// returns the size of the map
      size_t size();

    private:

      /// map of the available connections
      std::multimap<std::string, ConnectionHandle > m_connections;

    };

  }

}

#endif
