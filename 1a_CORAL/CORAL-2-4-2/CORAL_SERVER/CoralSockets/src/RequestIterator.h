// $Id: RequestIterator.h,v 1.4.2.3 2013-02-08 09:40:09 avalassi Exp $
#ifndef CORALSOCKETS_REQUESTITERATOR_H
#define CORALSOCKETS_REQUESTITERATOR_H 1

// Include files
#include <memory>
#include "CoralServerBase/ByteBuffer.h"
#include "CoralServerBase/IByteBufferIterator.h"

namespace coral
{

  namespace CoralSockets
  {

    /** @class RequestIterator
     *
     *  Iterator over an array of std::auto_ptr<ByteBuffer>.
     *
     *  @author Martin Wache
     *  @date   2009-12-08
     *///

    class RequestIterator : virtual public coral::IByteBufferIterator
    {
    public:

      /// Constructor.
      RequestIterator( size_t startSize=5 );

      /// Destructor.
      virtual ~RequestIterator();

      /// Get the next buffer.
      virtual bool nextBuffer();

      /// Is the current buffer the last one?
      /// Throws an exception if next() was never called (<first buffer).
      /// Throws an exception if next() returned false (>last buffer).
      virtual bool isLastBuffer() const;

      /// Get a reference to the current buffer.
      /// Throws an exception if next() was never called (<first buffer).
      /// Throws an exception if next() returned false (>last buffer).
      virtual const ByteBuffer& currentBuffer() const;

      /// adds the payload of the packet to the request,
      /// checking the segment number and throwing a SegmentError exception
      /// in case something is wrong.
      void addBuffer( std::auto_ptr<ByteBuffer> buffer, int segmentNo,
                      bool isLast );

    private:

      // doubles the size of the iterator
      void resize();

      int m_size;
      std::auto_ptr<ByteBuffer> *m_buffers;
      int m_currBuffer;
      int m_bufferCount;
      bool m_gotLast;

    };

    typedef std::auto_ptr<RequestIterator> RequestIteratorPtr;

  }

}
#endif // CORALSOCKETS_REQUESTITERATOR_H
