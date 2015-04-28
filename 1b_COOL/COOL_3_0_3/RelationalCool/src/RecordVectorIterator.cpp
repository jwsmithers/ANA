
// Include files
#include <iostream>
#include "CoolKernel/IObject.h"
#include "CoolKernel/Record.h"
#include "CoolKernel/types.h"

// Local include files
#include "IteratorException.h"
#include "RecordVectorIterator.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

#if 0
RecordVectorIterator::RecordVectorIterator(  )
  : m_objects(  )
  , m_current1toN( 0 )
  , m_isClosed( false )
{
}
#endif

//-----------------------------------------------------------------------------

RecordVectorIterator::RecordVectorIterator( const IRecordVector& objects )
  : m_objects( objects )
  , m_current1toN( 0 )
  , m_isClosed( false )
{
}

//-----------------------------------------------------------------------------

RecordVectorIterator::~RecordVectorIterator()
{
  close();
}

//-----------------------------------------------------------------------------

bool RecordVectorIterator::isEmpty()
{
  if ( m_isClosed ) throw IteratorIsClosed( "RecordVectorIterator" );
  return ( m_objects.size() == 0 );
}

//-----------------------------------------------------------------------------

const IRecord& RecordVectorIterator::currentRef()
{
  if ( m_isClosed ) throw IteratorIsClosed( "RecordVectorIterator" );
  if ( m_current1toN < 1 ) {
    throw Exception( "Current position is before the first object in the loop",
                     "RecordVectorIterator" );
  } else if ( m_current1toN > m_objects.size() ) {
    throw Exception( "Current position is after the last object in the loop",
                     "RecordVectorIterator" );
  } else {
    return *(m_objects[m_current1toN-1]);
  }
}

//-----------------------------------------------------------------------------

bool RecordVectorIterator::goToNext()
{
  if ( m_isClosed ) throw IteratorIsClosed( "RecordVectorIterator" );
  if ( ( m_current1toN < m_objects.size() ) ) {
    m_current1toN++;
    return true;
  }
  return false;
}

//-----------------------------------------------------------------------------

unsigned int RecordVectorIterator::size()
{
  if ( m_isClosed ) throw IteratorIsClosed( "RecordVectorIterator" );
  return m_objects.size();
}

//-----------------------------------------------------------------------------

const IRecordVectorPtr RecordVectorIterator::fetchAllAsVector()
{
  if ( m_isClosed ) throw IteratorIsClosed( "RecordVectorIterator" );
  if ( m_current1toN > 0 ) throw IteratorIsActive( "RecordVectorIterator" );

  IRecordVectorPtr ret( new IRecordVector() );

  ret->reserve( m_objects.size() );
  for ( std::vector<IRecordPtr>::const_iterator it=m_objects.begin();
        it!= m_objects.end(); ++it )
  {
    ret->push_back( IRecordPtr( new Record( *(*it) ) ) );
  };

  return ret;
}

//-----------------------------------------------------------------------------

void RecordVectorIterator::close()
{
  m_isClosed = true;
}

//-----------------------------------------------------------------------------
