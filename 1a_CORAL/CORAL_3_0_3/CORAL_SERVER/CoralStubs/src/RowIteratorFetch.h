#ifndef CORALSTUBS_ROWITERATORFETCH_H
#define CORALSTUBS_ROWITERATORFETCH_H 1

// Include files
#include <list>
#include "CoralBase/AttributeList.h"
#include "CoralServerBase/ICoralFacade.h"
#include "CoralServerBase/IRequestHandler.h"
#include "CoralServerBase/IRowIterator.h"

// Local include files
#include "CppTypes.h"

namespace coral
{

  namespace CoralStubs
  {

    /** @class RowIteratorFetch
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

    class RowIteratorFetch : public IRowIterator
    {
    public:

      //pass by a predefined rowbuffer to replace the internal one
      RowIteratorFetch( IRequestHandler& requestHandler,
                        uint32_t cursorID,
                        AttributeList* rowBuffer );

      virtual ~RowIteratorFetch();

      bool nextRow();

      const AttributeList& currentRow() const;

      size_t getNumberOfRequests() { return m_requestno; };

    private:

      void fillBuffer();

      //reference to an IRequestHandler instance
      IRequestHandler& m_requestHandler;

      uint32_t m_cursor;

      AttributeList* m_obuffer;

      AttributeList* m_iterbuffer;

      bool m_waslast;

      std::list< AttributeList* > m_buffers;

      size_t m_requestno;

    };

  }

}
#endif
