// $Id: ConstRecordIterator.cpp,v 1.3 2010-08-26 16:35:19 avalassi Exp $

// Include files
#include <iostream>
#include "CoralBase/Attribute.h"

// Local include files
#include "ConstRecordIterator.h"
#include "IteratorException.h"
#include "RelationalException.h"
#include "RelationalObjectIterator.h"
#include "RelationalObjectTable.h"
#include "RelationalPayloadTable.h"

// Namespace
using namespace cool;

//#define DEBUG(out) do { std::cout << out << std::endl; } while (0)
#define DEBUG(out)

//-----------------------------------------------------------------------------

ConstRecordIterator::ConstRecordIterator( RelationalObjectIterator& iterator,
                                          const coral::AttributeList& aList,
                                          const ConstRecordAdapter& record )
  : m_iterator( iterator )
  , m_aList( aList )
  , m_payload( record )
  , m_payloadSetId( 0 )
  , m_payloadSize( 0 )
  , m_currentObject( 0 )
  , m_state( ACTIVE )
{
}

//-----------------------------------------------------------------------------

bool ConstRecordIterator::isEmpty()
{
  return m_payloadSize == 0;
}

//-----------------------------------------------------------------------------

bool ConstRecordIterator::goToNext()
{
  DEBUG("goToNext m_currentObject " << m_currentObject );
  if ( m_state == CLOSED  || m_state == END_OF_ROWS )
    throw IteratorIsClosed( "RelationalObjectIterator" );

  if ( m_currentObject == 0 && m_payloadSize > 0 )
  {
    // iterator points before first row, but cursor should
    // already point to first payload

    if (  m_aList[ RelationalObjectTable::columnNames::payloadSetId() ].data<unsigned int>()
          != m_payloadSetId )
    {
      DEBUG("goToNext returns false, m_payloadSetId != m_aList " );
      // payload doesn't match payload set id
      // -> payload is empty ( or before first IOV )
      return false;
    }

    DEBUG("goToNext returns true, already on first object " );
    m_currentObject++;
    return true;
  }

#if 0
  DEBUG("goToNext calls fetchNext()+++++++++++++");
  bool gotNext = m_iterator.fetchNext();
  if ( !gotNext  ||
       m_aList[ RelationalObjectTable::columnNames::payloadSetId() ].data<unsigned int>()
       != m_payloadSetId )
  {
    DEBUG("goToNext returns false, beyond last object " );
    // no next object in cursor, or next object belongs to
    // next payload set id
    m_state = END_OF_ROWS;
    return false;
  }
#else
  if ( m_currentObject < m_payloadSize )
  {
    DEBUG("goToNext calling fetchNext");
    bool gotNext = m_iterator.fetchNext();

    DEBUG("new current item has payloadItemId "<<
          m_aList[ RelationalPayloadTable::columnNames::payloadItemId() ].data<unsigned int>()
          );
    if (  m_aList[ RelationalPayloadTable::columnNames::payloadItemId() ].data<unsigned int>()
          != m_currentObject )
      throw PanicException("wrong payload item id",
                           "ConstRecordIterator");

    if (!gotNext)
      throw PanicException("no more rows, but there should be more",
                           "ConstRecordIterator");
  }
  else
  {
    DEBUG("currentObject " << m_currentObject
          << " already on last row "
          << m_payloadSize  <<", return false ");
    m_state = END_OF_ROWS;
    return false;
  }
#endif

  DEBUG(" goToNext returns true, on next object " );
  m_currentObject++;
  return true;
}

//-----------------------------------------------------------------------------

bool ConstRecordIterator::nextPayloadSet()
{
  DEBUG(" nextPayloadSet calling close " );
  if ( m_state != CLOSED  &&
       m_state != END_OF_ROWS )
  {
    close();
  }

  // advance to next payload
  DEBUG("nextPayloadSEt calling fetchNext()");
  bool gotNext = m_iterator.fetchNext();
  if ( !gotNext )
  {
    DEBUG(" no more payload sets");
    return false;
  }

  // m_payloadSetId is initialized to 0, which is not a valid payload set id
  if ( m_aList[ RelationalObjectTable::columnNames::payloadSetId() ].data<unsigned int>()
       == m_payloadSetId )
  {
    DEBUG("nextPayloadSet returns false, no next set m_payloadSetId "
          << m_payloadSetId << " current "
          <<m_aList[ RelationalObjectTable::columnNames::payloadSetId() ].data<unsigned int>() );
    // we are still at the last payload of the
    // previous payload set
    // -> no next payload
    return false;
  };


  // here the cursor points to the first payload of
  // the new payload set, reset iterator to correct values
  m_currentObject=0;
  m_state = ACTIVE;
  m_payloadSetId = m_aList[ RelationalObjectTable::columnNames::payloadSetId() ].data<unsigned int>();
  m_payloadSize = m_aList[ RelationalObjectTable::columnNames::payloadSize() ].data<unsigned int>();

  if ( m_payloadSize > 0 &&
       m_aList[ RelationalPayloadTable::columnNames::payloadItemId() ].data<unsigned int>()
       != 0 )
    throw PanicException("should be at the start of payload vector but item id is not 0",
                         "ConstRecordIterator");

  DEBUG("nextPayloadSet returns true, on next payload, id " << m_payloadSetId );
  return true;
}

//-----------------------------------------------------------------------------

const IRecord& ConstRecordIterator::currentRef()
{
  if ( m_state == CLOSED )
    throw IteratorIsClosed( "ConstRecordIterator" );

  if ( m_currentObject == 0 || m_state == END_OF_ROWS )
    throw IteratorHasNoCurrentItem( "ConstRecordIterator" );

  DEBUG("currentRef() returns :" << m_payload);
  return m_payload;
}

//-----------------------------------------------------------------------------

const IRecordVectorPtr ConstRecordIterator::fetchAllAsVector()
{
  DEBUG("fetchAllAsVector called");
  if ( m_currentObject != 0 )
    throw IteratorIsActive( "ConstRecordIterator" );

  if ( m_state == CLOSED )
    throw IteratorIsClosed( "ConstRecordIterator" );

  IRecordVectorPtr objects( new IRecordVector() );

  while( goToNext() )
  {
    objects->push_back( IRecordPtr( new Record( currentRef() ) ) );
  }

  return objects;
}

//-----------------------------------------------------------------------------

void ConstRecordIterator::close()
{
  DEBUG("close called");
  if ( m_state == CLOSED )
    return;
  if ( m_state == END_OF_ROWS)
  {
    m_state = CLOSED;
    return;
  }

  // move the iterator to the end
  while ( goToNext() )
    ;
  m_state = CLOSED;
  DEBUG("close finished");
}

//-----------------------------------------------------------------------------
