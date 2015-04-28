
// Include files
#include <cstring> // For memcpy
#include <sstream>
#include <unistd.h> // For sleep on gcc47 (bug #94230)
#include "CoralSockets/GenericSocketException.h"

// Local include files
#include "DummyRequestHandler.h"

// Namespace
using namespace coral;
using namespace coral::CoralSockets;
#if 0
//-----------------------------------------------------------------------------

SimpleReplyIterator::SimpleReplyIterator( ByteBuffer& buffer, bool isLast )
  : IByteBufferIterator()
  , m_currentBuffer( (ByteBuffer*) 0 )
  , m_buffers( )
  , m_gotLastBuffer( isLast )
{
  boost::shared_ptr<ByteBuffer> newBuf( new ByteBuffer( buffer.usedSize() ) );
  for (size_t i=0; i< buffer.usedSize(); i++)
    *(newBuf->data()+i) = *(buffer.data()+i);
  newBuf->setUsedSize( buffer.usedSize() );
  m_buffers.push( newBuf );
}

//-----------------------------------------------------------------------------

SimpleReplyIterator::SimpleReplyIterator( boost::shared_ptr<ByteBuffer> buffer, bool isLast )
  : IByteBufferIterator()
  , m_currentBuffer( (ByteBuffer*) 0 )
  , m_buffers( )
  , m_gotLastBuffer( isLast )
{
  m_buffers.push( buffer );
}

//-----------------------------------------------------------------------------

void SimpleReplyIterator::addBuffer( ByteBuffer& buffer, bool isLast)
{
  boost::shared_ptr<ByteBuffer> newBuf( new ByteBuffer( buffer.usedSize() ) );
  for (size_t i=0; i< buffer.usedSize(); i++)
    *(newBuf->data()+i) = *(buffer.data()+i);
  newBuf->setUsedSize( buffer.usedSize() );

  addBuffer( newBuf, isLast );
}

//-----------------------------------------------------------------------------

void SimpleReplyIterator::addBuffer( boost::shared_ptr<ByteBuffer> buffer, bool isLast)
{
  if ( m_gotLastBuffer )
    throw GenericSocketException("SimpleReplyIterator already as got the last"
                                 " buffer, you can't add more!", "SimpleReplyIterator::addBuffer");

  m_buffers.push( buffer );
  m_gotLastBuffer=isLast;
}

//-----------------------------------------------------------------------------

bool SimpleReplyIterator::nextBuffer()
{
  // the class is not thread safe
  if (!m_gotLastBuffer)
    throw GenericSocketException("can't call nextBuffer() before all buffers are "
                                 "added!","SimpleReplyIterator::nextBuffer()");

  if ( m_buffers.empty() && !m_gotLastBuffer )
    throw GenericSocketException("m_buffers is empty, m_gotLastBuffer is false",
                                 "SimpleReplyIterator::nextBuffer()");

  if ( m_buffers.empty() ) {
    m_currentBuffer = boost::shared_ptr<ByteBuffer>( (ByteBuffer*)0 );
    return false;
  };

  m_currentBuffer=m_buffers.front();
  m_buffers.pop();

  return true;
}

//-----------------------------------------------------------------------------

bool SimpleReplyIterator::isLastBuffer() const
{
  if ( m_currentBuffer.get() == 0 )
    throw GenericSocketException("no current buffer, did you call nextBuffer()?",
                                 "SimpleReplyIterator::isLastBuffer()");

  return (m_buffers.empty() && m_gotLastBuffer );
}

//-----------------------------------------------------------------------------

const ByteBuffer& SimpleReplyIterator::currentBuffer() const
{
  if (m_currentBuffer.get() == 0 )
    throw GenericSocketException("no current buffer, did you call nextBuffer()?",
                                 "SimpleReplyIterator::nextBuffer()");

  return *m_currentBuffer;
}
#endif
//-----------------------------------------------------------------------------

DummyRequestHandler::DummyRequestHandler()
{
}

//-----------------------------------------------------------------------------

DummyRequestHandler::~DummyRequestHandler()
{
}

//-----------------------------------------------------------------------------

void
DummyRequestHandler::setConnectionProperties(
                                             coral::ConnectionPropertiesConstPtr /*properties*/  )
{
  // DUMMY
}

//-----------------------------------------------------------------------------

void DummyRequestHandler::replyToBuffer( RequestIterator& iter,
                                         const ByteBuffer& request, int &bufCount, bool isLast )
{
  std::string requestStr( (char*)request.data(), request.usedSize() );
  if (requestStr.find("sleep ") == 0 ) {
    // sleep before reply requested
    unsigned int num=0;
    std::stringstream numStream( requestStr.substr( 5, requestStr.size() ) );
    numStream >> num;
    if (num>100)
      num=100;
    sleep( num );
  };
  if (requestStr.find("copy ") == 0 ) {
    // multi ByteBuffer reply requested
    unsigned int num=0;
    std::stringstream numStream( requestStr.substr( 5, requestStr.size() ) );
    numStream >> num;
    if (num>10)
      num=10;

    unsigned int count=0;
    do {
      std::stringstream stream;
      stream <<"Thank you for your request " << count << " '";
      std::string thanks( stream.str() );

      std::auto_ptr<ByteBuffer> reply(
                                      new ByteBuffer(thanks.size() + request.usedSize() ) );

      ::memcpy( reply->data(), thanks.data(), thanks.size() );
      ::memcpy( reply->data() + thanks.size(), request.data(),
                request.usedSize() );
      reply->setUsedSize( thanks.size() + request.usedSize() );

      count++;
      iter.addBuffer( reply, bufCount, count>=num && isLast );
      bufCount++;

    } while ( count < num );

    return;
  }

  std::string thanks = "Thank you for your request '";
  std::auto_ptr<ByteBuffer> reply(
                                  new ByteBuffer( thanks.size() + request.usedSize() ) );
  ::memcpy( reply->data(), thanks.data(), thanks.size() );
  ::memcpy( reply->data() + thanks.size(), request.data(), request.usedSize() );
  reply->setUsedSize( thanks.size() + request.usedSize() );
  iter.addBuffer( reply, bufCount, isLast );
  bufCount++;
}
//-----------------------------------------------------------------------------

IByteBufferIteratorPtr
DummyRequestHandler::replyToRequest( IByteBufferIteratorPtr request,
                                     const RequestProperties & /*properties*/ )
{
  RequestIterator *it=new RequestIterator();
  IByteBufferIteratorPtr retIt( it );

  int count = 0;
  while ( request->nextBuffer() )
  {
    replyToBuffer( *it, request->currentBuffer(), count, request->isLastBuffer() );
  }
  return retIt;
}

//-----------------------------------------------------------------------------
