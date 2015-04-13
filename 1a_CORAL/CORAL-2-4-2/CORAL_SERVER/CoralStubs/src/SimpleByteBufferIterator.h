#ifndef CORALSTUBS_SIMPLEBYTEBUFFERITERATOR_H
#define CORALSTUBS_SIMPLEBYTEBUFFERITERATOR_H 1

// Include files
#include <list>
#include "CoralServerBase/ByteBuffer.h"
#include "CoralServerBase/IByteBufferIterator.h"

namespace coral
{

  namespace CoralStubs
  {

    /** @class SimpleByteBufferIterator
     *   *
     *  @author Alexander Kalkhof
     *  @date   2009-04-28
     *///

    class SimpleByteBufferIterator : public IByteBufferIterator
    {

    public:

      SimpleByteBufferIterator( const ByteBuffer& );

      virtual ~SimpleByteBufferIterator();

      bool nextBuffer();

      bool isLastBuffer() const;

      const ByteBuffer& currentBuffer() const;

    private:

      const ByteBuffer& m_buffer;

      bool m_active;

      bool m_last;

    };

  }

}
#endif
