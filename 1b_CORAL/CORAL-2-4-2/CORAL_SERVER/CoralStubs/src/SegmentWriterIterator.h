#ifndef CORALSTUBS_SEGMENTWRITERITERATOR_H
#define CORALSTUBS_SEGMENTWRITERITERATOR_H

// Include files
#include <list>
#include <map>
#include <set>
#include <string>
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"
#include "CoralBase/Blob.h"
#include "CoralBase/Date.h"
#include "CoralBase/TimeStamp.h"
#include "CoralServerBase/ByteBuffer.h"
#include "CoralServerBase/CALOpcode.h"
#include "CoralServerBase/CTLPacketHeader.h"
#include "CoralServerBase/IByteBufferIterator.h"
#include "CoralServerBase/QueryDefinition.h"
#include "RelationalAccess/IQueryDefinition.h"
#include "RelationalAccess/TableDescription.h"

// Local include files
#include "CppTypes.h"

namespace coral
{

  namespace CoralStubs
  {

    /** @class SegmentWriteIterator
     *
     *  This class contains a buffer mechanism to append
     *  several types.
     *  The basic buffer used inside is static, and can
     *  be retrieved over the currentBuffer() method.
     *  Overflows of the static buffer are handled by adding
     *  this one to a list. Calling nextBuffer() will first clear
     *  the list before continue appending types.
     *
     *  @author Alexander Kalkhof
     *  @date   2009-03-31
     *///

    class SegmentWriterIterator : public IByteBufferIterator
    {
    public:
      //constructor
      SegmentWriterIterator(CALOpcode opcode,
                            bool cacheable,
                            bool reply,
                            size_t buffersize = (CTLPACKET_MAX_SIZE - CTLPACKET_HEADER_SIZE) );
      //destructor
      ~SegmentWriterIterator();
      //get the next buffer
      bool nextBuffer();
      //get the current buffer
      const ByteBuffer& currentBuffer() const;
      //check if we have the last buffer
      bool isLastBuffer() const;
      //get a single byte buffer from the iterator
      //in the case of two byte buffers an exception is thrown
      //this method can be used to transform from iterator
      //to a single bytebuffer without influence on the iterator
      const ByteBuffer& singleBuffer();
      //writes the current buffer to the iterator
      //the header will be added to each buffer inside the iterator
      void flush();
      //change the current buffer to an exception
      //the header will be written and flush is called
      size_t written();

      void setProxy(bool proxy);

      void exception(const CALOpcode,
                     const CALOpcode,
                     const std::string,
                     const std::string,
                     const std::string);

      void append(const bool);

      void append(const uint16_t);

      void append(const uint32_t);

      void append(const uint64_t);

      void append(const uint128_t&);

      void appendN(const unsigned int);

      void appendN(const unsigned long);

      void appendN(const unsigned long long);

      void append16(const std::string&);

      void append32(const std::string&);

      void append(const Blob&);

      void append(const coral::Date&);

      void append(const coral::TimeStamp&);

      void append(const CALOpcode);

      void append(const std::vector<std::string>&);

      void append(const std::set<std::string>&);

      void append(const std::vector< std::pair<std::string, std::string> >&);

      void append(const std::map< std::string, std::string >&);

      void append(const TableDescription&);

      void append(const std::map< std::string, TableDescription >&);

      void append(const QueryDefinition&);

      void append(const IQueryDefinition::SetOperation&);

      void appendV(const AttributeList&);

      void appendE(const AttributeList&);

      void appendD(void*);

      void appendD(void*, const AttributeList&);

      void* getStructure(const AttributeList&);

      void print() const;

    private:

      /// Copy constructor is private (fix Coverity MISSING_COPY)
      SegmentWriterIterator( const SegmentWriterIterator& rhs );

      /// Assignment operator is private (fix Coverity MISSING_ASSIGN)
      SegmentWriterIterator& operator=( const SegmentWriterIterator& rhs );

      void extend();

      void newbuffer();

      void append(const std::string&, size_t);

      template<class T>
      void appendAttribute(const coral::CALOpcode&,
                           const bool,
                           const Attribute&);

      template<class T>
      void appendAttributeN(const coral::CALOpcode&,
                            const bool,
                            const Attribute&);

    private:

      typedef void (*WriteAttributeFunction)( const void*,
                                              SegmentWriterIterator& );

      struct AttributeAndWriteFunction
      {
        const Attribute* attr;
        WriteAttributeFunction fct;
      };

      static const size_t size_AttributeAndWriteFunction = sizeof(AttributeAndWriteFunction);

      static void writeAttribute_bool( const void*, SegmentWriterIterator& );

      static void writeAttribute_char( const void*, SegmentWriterIterator& );

      static void writeAttribute_short( const void*, SegmentWriterIterator& );

      static void writeAttribute_uint( const void*, SegmentWriterIterator& );

      static void writeAttribute_ul( const void*, SegmentWriterIterator& );

      static void writeAttribute_ull( const void*, SegmentWriterIterator& );

      static void writeAttribute_float( const void*, SegmentWriterIterator& );

      static void writeAttribute_double( const void*, SegmentWriterIterator& );

      static void writeAttribute_longdouble( const void*, SegmentWriterIterator& );

      static void writeAttribute_string( const void*, SegmentWriterIterator& );

      static void writeAttribute_blob( const void*, SegmentWriterIterator& );

      static void writeAttribute_date( const void*, SegmentWriterIterator& );

      static void writeAttribute_time( const void*, SegmentWriterIterator& );

    private:

      unsigned char* m_bufferpos;

      unsigned char* m_bufferend;

      std::list<ByteBuffer*> m_buffers;

      ByteBuffer* m_currentbuffer;

      ByteBuffer* m_iterbuffer;

      CALOpcode m_opcode;

      bool m_cacheable;

      bool m_proxy;

      bool m_reply;

      int m_nocache;

      size_t m_buffersize;

    };

    // Declaration of template specialization must be in namespace scope
    template<>
    void
    SegmentWriterIterator::appendAttribute<std::string>( const CALOpcode& opcode, const bool isnull, const Attribute& attr );

  }

}

#endif
