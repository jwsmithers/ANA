// Local include files
#include "Exceptions.h"
#include "SimpleByteBufferIterator.h"

// Namespace
using namespace coral::CoralStubs;

//----------------------------------------------------------------------------

SimpleByteBufferIterator::SimpleByteBufferIterator( const ByteBuffer& buffer )
  : m_buffer( buffer )
  , m_active( true )
  , m_last( false )
{
}

//----------------------------------------------------------------------------

SimpleByteBufferIterator::~SimpleByteBufferIterator()
{
}

//----------------------------------------------------------------------------

bool
SimpleByteBufferIterator::nextBuffer()
{
  if(m_active)
  {
    m_active = false;
    return true;
  }
  m_last = true;
  return false;
}

//----------------------------------------------------------------------------

bool
SimpleByteBufferIterator::isLastBuffer() const
{
  return !m_active;
}

//----------------------------------------------------------------------------

const coral::ByteBuffer&
SimpleByteBufferIterator::currentBuffer() const
{
  if(m_last)
    throw StubsException("SimpleByteBufferIterator already called");
  return m_buffer;
}

//----------------------------------------------------------------------------
