#ifndef CORALSTUBS_ROWITERATORALL_H
#define CORALSTUBS_ROWITERATORALL_H 1

// Include files
#include "CoralBase/AttributeList.h"
#include "CoralServerBase/CALOpcode.h"
#include "CoralServerBase/IRequestHandler.h"
#include "CoralServerBase/IRowIterator.h"

// Local include files
#include "SegmentReaderIterator.h"

namespace coral
{

  namespace CoralStubs
  {

    /** @class RowIteratorAll
     *
     *  An implementation of the RowIterator
     *
     *  This class transforms from IByteBufferIterator
     *  to a rowIterator. It uses the SegmentReaderIterator
     *  for handling of segments and decoding/unmarshalling
     *
     *  @author Alexander Kalkhof
     *  @date   2009-04-15
     *///

    class RowIteratorAll : public IRowIterator
    {
    public:

      // Constructor acquires ownership of the reply iterator,
      // but it simply references the row buffer (if any is provided)
      RowIteratorAll( IByteBufferIteratorPtr reply,
                      AttributeList* rowBuffer,
                      CALOpcode opcode );

      virtual ~RowIteratorAll();

      bool nextRow();

      const AttributeList& currentRow() const;

    private:

      /// Copy constructor is private (fix Coverity MISSING_COPY)
      RowIteratorAll( const RowIteratorAll& rhs );

      /// Assignment operator is private (fix Coverity MISSING_ASSIGN)
      RowIteratorAll& operator=( const RowIteratorAll& rhs );

    private:

      IByteBufferIteratorPtr m_reply;

      AttributeList* m_obuffer;

      bool m_cbuffer;

      bool m_ibuffer;

      bool m_fbuffer;

      SegmentReaderIterator* m_sri;

      void* m_structure;

    };

  }

}
#endif
