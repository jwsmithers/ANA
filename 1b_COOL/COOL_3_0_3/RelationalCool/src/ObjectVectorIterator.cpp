
// Include files
#include "CoolKernel/IObject.h"
#include "CoolKernel/types.h"

// Local include files
#include "IteratorException.h"
#include "ObjectVectorIterator.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

ObjectVectorIterator::ObjectVectorIterator( const IObjectVectorPtr& objects )
  : m_objects( objects )
  , m_size( objects->size() )
  , m_current1toN( 0 )
  , m_isClosed( false )
{
}

//-----------------------------------------------------------------------------

ObjectVectorIterator::~ObjectVectorIterator()
{
  close();
}

//-----------------------------------------------------------------------------

bool ObjectVectorIterator::isEmpty()
{
  if ( m_isClosed ) throw IteratorIsClosed( "ObjectVectorIterator" );
  return ( m_size == 0 );
}

//-----------------------------------------------------------------------------

const IObject& ObjectVectorIterator::currentRef()
{
  if ( m_isClosed ) throw IteratorIsClosed( "ObjectVectorIterator" );
  if ( m_current1toN < 1 ) {
    throw Exception( "Current position is before the first object in the loop",
                     "ObjectVectorIterator" );
  } else if ( m_current1toN > m_size ) {
    throw Exception( "Current position is after the last object in the loop",
                     "ObjectVectorIterator" );
  } else {
    return *(*m_objects)[m_current1toN-1];
  }
}

//-----------------------------------------------------------------------------

bool ObjectVectorIterator::goToNext()
{
  if ( m_isClosed ) throw IteratorIsClosed( "ObjectVectorIterator" );
  if ( ( m_current1toN < m_size ) ) {
    m_current1toN++;
    return true;
  }
  return false;
}

//-----------------------------------------------------------------------------

unsigned int ObjectVectorIterator::size()
{
  if ( m_isClosed ) throw IteratorIsClosed( "ObjectVectorIterator" );
  return m_size;
}

//-----------------------------------------------------------------------------

const IObjectVectorPtr ObjectVectorIterator::fetchAllAsVector()
{
  if ( m_isClosed ) throw IteratorIsClosed( "ObjectVectorIterator" );
  if ( m_current1toN > 0 ) throw IteratorIsActive( "ObjectVectorIterator" );
  return m_objects;
}

//-----------------------------------------------------------------------------

void ObjectVectorIterator::close()
{
  m_isClosed = true;
}

//-----------------------------------------------------------------------------
