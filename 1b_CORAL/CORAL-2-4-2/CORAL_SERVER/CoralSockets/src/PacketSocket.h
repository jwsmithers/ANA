// $Id: PacketSocket.h,v 1.11.2.2.2.1 2012-06-07 12:19:56 avalassi Exp $
#ifndef CORALSOCKETS_PACKETSOCKET_H
#define CORALSOCKETS_PACKETSOCKET_H 1

#include "CoralServerBase/CALPacketHeader.h"
#include "CoralServerBase/CTLPacketHeader.h"
#include "CoralServerBase/ByteBuffer.h"

#include "ISocket.h"

namespace coral
{
  namespace CoralSockets
  {

    class PacketSLAC
    {

    public:

      /// constructor for receiving
      PacketSLAC( CTLPacketHeader & header,
                  std::auto_ptr<ByteBuffer> payload)
        : m_payload( payload )
        , m_payloadRef( *m_payload)
        , m_header( header)
      {}

      /// constructor for sending
      /// you have to make sure, that the reference to the payload stays valid
      /// while this class exists!
      PacketSLAC( uint32_t ctlRequestID,
                  uint32_t clientID,
                  uint32_t ctlSegmentNumber,
                  bool ctlMoreSegments,
                  const ByteBuffer& payload)
        : m_payload( 0 )
        , m_payloadRef( payload )
        , m_header( CTLOK,
                    CTLPACKET_HEADER_SIZE + payload.usedSize(),
                    ctlRequestID,
                    clientID,
                    ctlSegmentNumber,
                    ctlMoreSegments,
                    CTLPacketHeader::computeChecksum( payload.data(),
                                                      payload.usedSize() ) )
      {}

      /// constructor for error notifying packets
      PacketSLAC( CTLStatus status,
                  uint32_t RequestID=0,
                  uint32_t clientID=0 )
        : m_payload( new ByteBuffer( CALPACKET_HEADER_SIZE ) )
        , m_payloadRef( *m_payload )
        , m_header( status,
                    CTLPACKET_HEADER_SIZE + CALPACKET_HEADER_SIZE,
                    RequestID,
                    clientID,
                    0 /*ctlSegmentNumber*/,
                    false /*ctlMoreSegments*/,
                    0 /* checksum, will be set later*/ )
      {
        new (m_payload->data())CALPacketHeader( 0 /*calOpcode FIXME*/,
                                                false /*fromProxy*/,
                                                false /*cacheable*/,
                                                0 /*cacheableSize*/);

        m_payload->setUsedSize( CALPACKET_HEADER_SIZE );

        m_header.setPayloadChecksum( CTLPacketHeader::computeChecksum( m_payload->data(), CALPACKET_HEADER_SIZE ) );
      }

      const CTLPacketHeader& getHeader() const
      {
        return m_header;
      }

      const ByteBuffer& getPayload() const
      {
        return m_payloadRef;
      }

      std::auto_ptr<ByteBuffer>& getPayloadPointer()
      {
        return m_payload;
      }

    private:

      /// payload buffer (only when owned by PacketSLAC)
      std::auto_ptr<ByteBuffer> m_payload;

      /// payload reference
      const ByteBuffer& m_payloadRef;

      /// CTL packet header
      CTLPacketHeader m_header;

    };

    typedef PacketSLAC& PacketRef;
    typedef boost::shared_ptr<PacketSLAC> PacketPtr;

    /** @class PacketSocket
     *
     *  @author Martin Wache
     *  @date   2009-1-5
     *
     * Interface for a wrapper class around an ISocket, which allows reading
     * and writing complete packets through the ISocket
     *
     *///

    class PacketSocket
    {

    public:

      PacketSocket( ISocketPtr socket );

      virtual ~PacketSocket();

      /// send a message through the socket
      void sendPacket( const PacketSLAC& message );

      /// receive a message through the socket
      /// timeout specifies the time to wait for a new header
      /// After a header has been recieved, the methods
      /// waits until the socket is closed or a full packet
      /// has been received
      PacketPtr receivePacket( int timeout=-1);

      /// check if the underlying socket is open
      bool isOpen();

      /// close the underlying socket
      void close();

      /// get socket description
      const std::string& desc() const
      {
        return m_socket->desc();
      }

      /// get certificate data if available
      const coral::ICertificateData *getCertificateData()
      {
        return m_socket->getCertificateData();
      }

      bool poll( ISocket::PMode mode, int timeout )
      {
        return m_socket->poll(mode,timeout);
      }

      int getRecPackets()
      {
        return m_recPackets;
      }

      std::string remoteEnd() const
      {
        return m_socket->remoteEnd();
      }

      std::string localEnd() const
      {
        return m_socket->localEnd();
      }

      /// temporary
      int getFd();

    private:

      /// dump the packet to file
      void dumpPacket( const std::string& path, bool Send, const PacketPtr& packet );
      void dumpPacket( const std::string& path, bool Send, const PacketSLAC& packet );

      /// the socket used to transfer the packets
      ISocketPtr m_socket;

      /// the creation time of this socket (for packet dumps)
      uint64_t m_createTime;

      /// how many packets have been received
      uint32_t m_recPackets;

      /// how many packets have been send
      uint32_t m_sendPackets;

      /// space for partial received headers
      unsigned char m_header[ CTLPACKET_HEADER_SIZE ];

      /// how much of the header has already been received
      size_t m_headerLen;

      /// the expected payload size
      size_t m_payloadLen;
      size_t m_expPayloadLen;

      /// pointer to the partial received payload
      std::auto_ptr<ByteBuffer> m_payload;
    };

    typedef boost::shared_ptr<PacketSocket> PacketSocketPtr;

    class PacketStatusNotOkException : public Exception
    {
    public:
      /// Constructor
      PacketStatusNotOkException( const std::string& what,
                                  const std::string& methodName = "" )
        : Exception( what, methodName, "coral::CoralSockets" ) {}

      /// Destructor
      virtual ~PacketStatusNotOkException() throw() {}
    };

    class ErrorInHeaderException : public Exception
    {
    public:
      enum ErrorCode {
        ErrWrongVersion,
        ErrPacketTooSmall,
        ErrPacketTooLarge,
        ErrWrongChecksum
      };

      /// Constructor
      ErrorInHeaderException( ErrorCode eCode, const std::string& what,
                              const std::string& methodName = "" )
        : Exception( what, methodName, "coral::CoralSockets" )
        , m_eCode( eCode ) {}

      /// Destructor
      virtual ~ErrorInHeaderException() throw() {}

      ErrorCode getErrorCode()
      {
        return m_eCode;
      }

    private:

      ErrorCode m_eCode;

    };

  }

}
#endif // CORALSOCKETS_PACKETSOCKET_H
