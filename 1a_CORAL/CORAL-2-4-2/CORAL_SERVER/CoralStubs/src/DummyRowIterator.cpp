// Local include files
#include "DummyRowIterator.h"
#include "Exceptions.h"

// Namespace
using namespace coral::CoralStubs;

//-----------------------------------------------------------------------------

DummyRowIterator::DummyRowIterator()
  : m_pos( 0 )
{
}

//-----------------------------------------------------------------------------

DummyRowIterator::~DummyRowIterator()
{
  // Delete all attribute lists
  std::vector<AttributeList*>::iterator i;
  for( i = m_data.begin(); i != m_data.end(); ++i )
  {
    delete *i;
  }
  m_data.clear();
}

//-----------------------------------------------------------------------------

bool
DummyRowIterator::nextRow()
{
  if( m_pos < m_data.size() )
  {
    m_pos++;
    return true;
  }
  return false;
}

//-----------------------------------------------------------------------------

const coral::AttributeList&
DummyRowIterator::currentRow() const
{
  if ( m_pos == 0 )
  {
    throw ReplyIteratorException( "Wrong access to RowIterator, call nextRow() first", "DummyRowIterator::currentRow" );
  }
  return *(m_data[m_pos - 1]);
}

//-----------------------------------------------------------------------------

coral::AttributeList&
DummyRowIterator::addRow()
{
  AttributeList* attrp = new AttributeList;
  m_data.push_back( attrp );
  return *attrp;
}

//-----------------------------------------------------------------------------
