// $Id: ObjectIteratorCounter.cpp,v 1.16 2011-04-18 15:09:00 avalassi Exp $

// Include files
#include <iostream>
#include "CoolKernel/InternalErrorException.h"

// Local include files
#include "IteratorException.h"
#include "ObjectIteratorCounter.h"

//-----------------------------------------------------------------------------

namespace cool
{

  /// @class wrapper
  /// Minimal wrapper class that execute a unary function object
  /// to the wrapped class instance on destruction.
  /// For thread safe access also a boost mutex is provided.
  /// @author Marco Clemencic, Martin Wache
  template <class obj_type, class checker_type>
  struct wrapper
  {

    /// Wrapped instance
    obj_type m_obj;

    /// Boost mutex
    boost::mutex m_mutex;

    /// Constructor. Simply create a default wrapped instance.
    wrapper() : m_obj() {}

    /// Destructor. Call the checker object on the wrapped instance.
    ~wrapper()
    {
      checker_type checker;
      checker( m_obj );
    }

    /// Return reference to the wrapped instance.
    inline obj_type& getObj() { return m_obj; }

    /// Return reference to the mutex instance.
    inline boost::mutex& getMutex() { return m_mutex; }

  };

  /// @class ObjectIteratorCounterChecker
  /// Checker class that verifies that the ObjectIteratorCounter map is empty
  /// (which means all iterators deregistered).
  /// The type of the map is in a template because the typedef
  /// ObjectIteratorMap is private.
  /// @author Marco Clemencic
  template <class map_type>
  struct ObjectIteratorCounterChecker
  {
    /// Checks if the ObjectIteratorCounter is empty, if not dump
    /// the content to standard error (trigger a failure on QMtest)
    void operator() ( map_type& the_map )
    {
      if ( the_map.size() != 0 ) {
        std::cerr << "ObjectIteratorCounterWatchDog: "
                  << the_map.size()
                  << " sessionMgrs" << std::endl;
        typename map_type::iterator i;
        for ( i = the_map.begin(); i != the_map.end(); ++i ) {
          std::cerr << "-> sessionMgr: " << i->first
                    << ", iterators: "   << i->second.size() << std::endl;
        }
      }
    }
  };
}

//-----------------------------------------------------------------------------

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

wrapper<ObjectIteratorMap,ObjectIteratorCounterChecker<ObjectIteratorMap> >&
getMapWrapper()
{
  // static ObjectIteratorMap s_openIterators;
  static wrapper<ObjectIteratorMap,ObjectIteratorCounterChecker<ObjectIteratorMap> > s_mapWrapper;
  return s_mapWrapper;
}

//-----------------------------------------------------------------------------

ObjectIteratorMap&
ObjectIteratorCounter::openIterators()
{
  return getMapWrapper().getObj();
}

//-----------------------------------------------------------------------------

boost::mutex&
ObjectIteratorCounter::openIteratorsMutex()
{
  return getMapWrapper().getMutex();
}

//-----------------------------------------------------------------------------

bool
ObjectIteratorCounter::testIteratorActive
( const IRelationalTransactionMgr* sessionMgr )
{
  boost::mutex::scoped_lock lock( openIteratorsMutex() );
  //std::cout << "Register iterator  " << it << " " << sessionMgr << std::endl;
  if ( openIterators().find( sessionMgr ) != openIterators().end() )
  {
    return true;
  }
  return false;
}

//-----------------------------------------------------------------------------

void
ObjectIteratorCounter::registerIterator
( const IObjectIterator* it,
  const IRelationalTransactionMgr* sessionMgr )
{
  boost::mutex::scoped_lock lock( openIteratorsMutex() );
  //std::cout << "Register iterator  " << it << " " << sessionMgr << std::endl;
  if ( openIterators().find( sessionMgr ) != openIterators().end() )
  {
    //std::cout << "Counter size: " << openIterators().size() << std::endl;
    //std::cout << "Vector size:  "
    //          << openIterators()[sessionMgr].size() << std::endl;
    throw TooManyIterators( "ObjectIteratorCounter" );
  }
  ObjectIteratorVector itVector;
  itVector.push_back( it );
  openIterators()[sessionMgr] = itVector;
}

//-----------------------------------------------------------------------------

void
ObjectIteratorCounter::unregisterIterator
( const IObjectIterator* it,
  const IRelationalTransactionMgr* sessionMgr )
{
  boost::mutex::scoped_lock lock( openIteratorsMutex() );
  //std::cout << "Unregister iterator " << it << " " << sessionMgr <<std::endl;
  // This sessionMgr is unknown?
  if ( openIterators().find( sessionMgr ) == openIterators().end() )
  {
    throw InternalErrorException
      ( "PANIC! The iterator is not registered"
        " (this IRelationalTransactionMgr is unknown)",
        "ObjectIteratorCounter" );
  }
  ObjectIteratorVector& itVector = openIterators().find( sessionMgr )->second;

  // No iterator for this sessionMgr?
  if ( itVector.size() == 0 )
  {
    throw InternalErrorException
      ( "PANIC! The iterator is not registered"
        " (none is registered for this IRelationalTransactionMgr)",
        "ObjectIteratorCounter" );
  }

  // More than one iterator for this sessionMgr?
  if ( itVector.size() > 1 )
  {
    throw InternalErrorException
      ( "PANIC! More than one iterator is registered"
        " for this IRelationalTransactionMgr",
        "ObjectIteratorCounter" );
  }

  // A different iterator is registered for this sessionMgr?
  if ( itVector[0] != it )
  {
    throw InternalErrorException
      ( "PANIC! The iterator is not registered"
        " (a different one is registered for this IRelationalTransactionMgr)",
        "ObjectIteratorCounter" );
  }

  // OK: this is the only iterator registered for this sessionMgr - remove it
  openIterators().erase( openIterators().find( sessionMgr ) );
}

//-----------------------------------------------------------------------------
