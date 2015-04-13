#ifndef CORAL_CORALSTUBS_BYTEBUFFERITERATORALL_H
#define CORAL_CORALSTUBS_BYTEBUFFERITERATORALL_H

//CoralServer includes
#include "CoralServerBase/CALOpcode.h"
#include "CoralServerBase/IByteBufferIterator.h"
#include "CoralServerBase/IRowIterator.h"

//Coral includes
#include "CoralBase/AttributeList.h"

//CoralServerStubs includes
#include "SegmentWriterIterator.h"

namespace coral {

  // Forward declaration
  struct RequestProperties;
  struct ConnectionProperties;

  namespace CoralStubs {

    class ByteBufferIteratorAll : public IByteBufferIterator {
    public:

      ByteBufferIteratorAll(IRowIterator*,
                            CALOpcode opcode,
                            bool cacheable,
                            bool proxy,
                            bool isempty,
                            AttributeList*,
                            const std::string& schema,
                            const std::list< std::string >& tables,
                            const ConnectionProperties*,
                            const RequestProperties& );

      ~ByteBufferIteratorAll();

      bool nextBuffer();

      bool isLastBuffer() const;

      const ByteBuffer& currentBuffer() const;

    private:

      /// Copy constructor is private (fix Coverity MISSING_COPY)
      ByteBufferIteratorAll( const ByteBufferIteratorAll& rhs );

      /// Assignment operator is private (fix Coverity MISSING_ASSIGN)
      ByteBufferIteratorAll& operator=( const ByteBufferIteratorAll& rhs );

      void fillBuffer();

      SegmentWriterIterator m_swi;

      IRowIterator* m_rowi;

      AttributeList* m_rowBuffer;

      bool m_isempty;

      void* m_structure;

      bool m_islast;

      bool m_lastbuffer;

      // For Monitoring purpose
      std::string m_schema;

      std::list< std::string > m_tables;

      std::string m_address;

      uint32_t m_connid;

      int m_requestid;

      double m_montime;

      size_t m_monsize;

    };

  }

}

#endif
