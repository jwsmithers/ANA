#ifndef CORALSTUBS_DUMMYBYTEBUFFERITERATOR_H
#define CORALSTUBS_DUMMYBYTEBUFFERITERATOR_H 1

// Include files
#include <list>
#include "CoralServerBase/ByteBuffer.h"
#include "CoralServerBase/IByteBufferIterator.h"

namespace coral
{

  namespace CoralStubs
  {

    /** @class DummyByteBufferIterator
     *   *
     *  @author Alexander Kalkhof
     *  @date   2009-04-08
     *///

    class DummyByteBufferIterator : public IByteBufferIterator
    {

    public:

      DummyByteBufferIterator();

      virtual ~DummyByteBufferIterator();

      bool nextBuffer();

      bool isLastBuffer() const;

      const ByteBuffer& currentBuffer() const;

      void addBuffer(const ByteBuffer&);

    private:

      std::list< const ByteBuffer* > m_buffers;

      const ByteBuffer* m_currentbuffer;

    };

  }

}
#endif
