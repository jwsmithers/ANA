// $Id: RequestIterator.cpp,v 1.4.2.3 2013-02-08 09:40:09 avalassi Exp $

// Include files
#include "CoralSockets/GenericSocketException.h"

// Local include files
#include "RequestIterator.h"
#include "SegmentationError.h"

// Logger
#define LOGGER_NAME "CoralSockets::RequestIterator"
#include "logger.h"

// Debug
#undef DEBUG
#define DEBUG(out)

// Namespace
using namespace coral::CoralSockets;

//-----------------------------------------------------------------------------

RequestIterator::RequestIterator( size_t startSize )
  : m_size( startSize )
  , m_buffers( 0 )
  , m_currBuffer( -1 )
  , m_bufferCount( 0 )
  , m_gotLast( false )
{
  m_buffers=new std::auto_ptr<ByteBuffer>[ m_size ]();
}

//-----------------------------------------------------------------------------

RequestIterator::~RequestIterator()
{
  delete[] m_buffers;
}

//-----------------------------------------------------------------------------

bool RequestIterator::nextBuffer()
{
  if ( ! m_gotLast )
    throw GenericSocketException( "nextBuffer() called before all buffers are inserted"
                                  "RequestIterator::nextBuffer()");

  // release last buffer
  if (m_currBuffer>=0)
    m_buffers[ m_currBuffer ].reset(0);
  if (m_currBuffer < m_bufferCount)
    m_currBuffer++;

  return ( m_currBuffer < m_bufferCount );
}

//-----------------------------------------------------------------------------

bool RequestIterator::isLastBuffer() const
{
  if ( m_currBuffer<0 || m_currBuffer>=m_bufferCount )
    throw GenericSocketException("isLastBuffer() called on invalid buffer",
                                 "RequestIterator::isLastBuffer()");
  return m_currBuffer+1 == m_bufferCount;
}

//-----------------------------------------------------------------------------

void RequestIterator::addBuffer( std::auto_ptr<coral::ByteBuffer> buffer,
                                 int segmentNo,
                                 bool isLast )
{
  if (m_gotLast)
    throw GenericSocketException("addBuffer called, after adding last buffer",
                                 "RequestIterator::addBuffer()");
  m_gotLast = isLast;
  if ( m_size <= m_bufferCount ) resize();
  if ( segmentNo != m_bufferCount )
  {
    throw SegmentationErrorException("Wrong segment number in received packet",
                                     "RequestIterator::addBuffer");
  }
  m_buffers[ m_bufferCount++ ] = buffer;
}

//-----------------------------------------------------------------------------

const coral::ByteBuffer& RequestIterator::currentBuffer() const
{
  if ( m_currBuffer<0 || m_currBuffer>=m_bufferCount )
    throw GenericSocketException("currentBuffer() called on invalid buffer",
                                 "RequestIterator::currentBuffer()");
  return *m_buffers[ m_currBuffer ].get();
}

//-----------------------------------------------------------------------------

void RequestIterator::resize()
{
  m_size*=2;
  std::auto_ptr<ByteBuffer> *new_buffers =
    new std::auto_ptr<ByteBuffer>[ m_size ]();
  for (int i = 0; i<m_bufferCount; i++)
    new_buffers[i]=m_buffers[i];
  delete[] m_buffers;
  m_buffers = new_buffers;
}
