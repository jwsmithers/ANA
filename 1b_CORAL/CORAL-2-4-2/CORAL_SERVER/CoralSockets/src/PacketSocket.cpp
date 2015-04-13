// $Id: PacketSocket.cpp,v 1.21.2.3.2.6 2013-01-01 18:17:07 avalassi Exp $

// Include files
#include <cerrno>
#include <cstring> // For strerror
#include <iostream>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
//#include "CoralMonitor/BandwidthStats.h"
#include "CoralSockets/GenericSocketException.h"

// Local include files
#include "PacketSocket.h"
//#include "PacketsStats.h"

// Logger
#define LOGGER_NAME "CoralSockets::PacketSocket"
#include "logger.h"

// Debug
#undef DEBUG
#define DEBUG( out )

// Namespace
using namespace coral::CoralSockets;

//---------------------------------------------------------------------------

// To test whether dumping is enabled check if dumpPath() != ""
static const std::string& dumpPath( bool disable = false )
{
  // Dumping is disabled by default (path=="")
  // Dumping is enabled only if "CORALSERVER_DUMPPACKET_PATH" is set
  static const char* env = ::getenv( "CORALSERVER_DUMPPACKET_PATH" );
  static std::string path( env!=0 ? env : "" );
  // Dumping can be disabled permanently by using disable=false once
  if ( disable ) path="";
  // Return the dump path ("" means that dumping is now disabled)
  return path;
}

//---------------------------------------------------------------------------

static inline uint64_t getTimeUS()
{
  struct timeval tv;
  gettimeofday(&tv, 0);
  return (uint64_t)tv.tv_sec*1000000+(uint64_t)tv.tv_usec;
}

//---------------------------------------------------------------------------

PacketSocket::PacketSocket( ISocketPtr socket)
  : m_socket( socket )
  , m_createTime( getTimeUS() )
  , m_recPackets( 0 )
  , m_sendPackets( 0 )
  , m_headerLen( 0 )
  , m_payloadLen( 0 )
  , m_expPayloadLen( 0 )
  , m_payload( 0 )
{
  // Initialize m_header
  memset( (void*)m_header, 0, sizeof(m_header) );
}

//---------------------------------------------------------------------------

PacketSocket::~PacketSocket()
{
  INFO("PacketSocket '"<<m_socket->desc()<<"' rec : " << m_recPackets
       << " packets send : " << m_sendPackets << " packets");
  if ( getenv("CORALSERVER_STATS") )
    std::cout << "PacketSocket '"<<m_socket->desc()<<"' rec : " << m_recPackets
              << " packets send : " << m_sendPackets << " packets"<< std::endl;
}

//---------------------------------------------------------------------------

void PacketSocket::sendPacket( const PacketSLAC& Message)
{
  //create static objects for statistics
  //static PacketsStatsHandle mySTPacketsOut("CoralSockets::PacketsOut");
  //static coral::BandwidthStatsHandle mySTBandwidthOut("CoralSockets::BandwidthOut");
  const CTLPacketHeader &ctlHeader( Message.getHeader() );
  const ByteBuffer &payload( Message.getPayload() );
  DEBUG("dumping header ver:" << ctlHeader.version()
        << " status:"  << ctlHeader.status()
        << " size:" << ctlHeader.packetSize()
        << " requestID:" << ctlHeader.requestID()
        << " clientID:" << ctlHeader.clientID()
        << " segmentNumber:" << ctlHeader.segmentNumber()
        << " moreSegments: " << ctlHeader.moreSegments()
        << std::endl
        );
  if ( dumpPath() != "" ) dumpPacket( dumpPath(), true, Message );
  m_socket->cork();
  m_socket->writeAll( ctlHeader.data(), CTLPACKET_HEADER_SIZE );
  m_socket->writeAll( payload.data(), payload.usedSize() );
  m_socket->uncork();
  m_sendPackets++;
  //mySTPacketsOut.add( CTLPACKET_HEADER_SIZE, payload.usedSize() );
  //mySTBandwidthOut.add( CTLPACKET_HEADER_SIZE + payload.usedSize() );
}

//---------------------------------------------------------------------------

PacketPtr PacketSocket::receivePacket( int timeout )
{
  //create static objects for statistics
  //static PacketsStatsHandle mySTPacketsIn("CoralSockets::PacketsIn");
  //static coral::BandwidthStatsHandle mySTBandwidthIn("CoralSockets::BandwidthIn");
  try
  {
    if ( m_headerLen < CTLPACKET_HEADER_SIZE )
    {
      // receive the header
      DEBUG("reading header already read len: " << m_headerLen << std::endl);
      m_headerLen+=m_socket->read( (unsigned char*)&m_header[m_headerLen],
                                   CTLPACKET_HEADER_SIZE-m_headerLen,
                                   timeout );
      if ( m_headerLen != CTLPACKET_HEADER_SIZE )
        // header not complete yet, and nothing more to read, return 0
        return PacketPtr( (PacketSLAC*) 0);
      // at this point we just received a complete header, check and parse it
      // this is a bit stupid, but I'll leave it for now
      // we need a CTLHeader to know the size
      // The Magic Word and the size are checked on construction time!
      CTLPacketHeader ctlHeader( (unsigned char*)m_header,
                                 CTLPACKET_HEADER_SIZE );
      DEBUG("dumping header ver:" << ctlHeader.version()
            << " status:"  << ctlHeader.status()
            << " size:" << ctlHeader.packetSize()
            << " requestID:" << ctlHeader.requestID()
            << " clientID:" << ctlHeader.clientID()
            << " segmentNumber:" << ctlHeader.segmentNumber()
            << " moreSegments: " << ctlHeader.moreSegments()
            << std::endl);
      // first check: version
      if ( ctlHeader.version() != CTLPACKET_CURRENT_VERSION )
        throw ErrorInHeaderException(ErrorInHeaderException::ErrWrongVersion,
                                     "received packet with wrong version number!",
                                     "PacketSocket::receivePacket()");
      // second check: status
      if ( ctlHeader.status() != CTLOK ) {
        if ( ctlHeader.status() == CTLWrongMagicWord )
          throw PacketStatusNotOkException("Received a packet with status WrongMagicWord",
                                           "PacketSocket::receivePacket()");
        else if ( ctlHeader.status() == CTLWrongVersion )
          throw PacketStatusNotOkException("Received a packet with status WrongVersion",
                                           "PacketSocket::receivePacket()");
        else if ( ctlHeader.status() == CTLWrongChecksum )
          throw PacketStatusNotOkException("Received a packet with status WrongChecksum",
                                           "PacketSocket::receivePacket()");
      };
      // ctlHeader.packetSize() throws if the size is smaller than < CLT+CAL
      // or the packet is larger than CTLPACKET_MAX_SIZE
      // so we only have to make sure ctlHeader is called and catch the exceptions
      if ( ctlHeader.packetSize() == 0 )
        throw GenericSocketException("PANIC! packet size ==0?!",
                                     "PacketSocket::receivePacket()");
      m_expPayloadLen = ctlHeader.packetSize() - CTLPACKET_HEADER_SIZE;
    }
    if ( m_payload.get() == 0 )
      m_payload = std::auto_ptr<ByteBuffer>( new ByteBuffer( m_expPayloadLen ) );
    DEBUG( "reading payload recieved :" << m_payloadLen
           << " expected " << m_expPayloadLen << std::endl );
    m_payloadLen += m_socket->read( m_payload->data() + m_payloadLen,
                                    m_expPayloadLen - m_payloadLen,
                                    timeout );
    if ( m_payloadLen != m_expPayloadLen )
      // not yet received full packet
      return PacketPtr( (PacketSLAC*)0);
    m_payload->setUsedSize( m_payloadLen );
    CTLPacketHeader ctlHeader( (unsigned char*)m_header,
                               CTLPACKET_HEADER_SIZE );
    static bool checksumDisabled = getenv("CORALSERVER_NOCRC") != 0;
    if ( !checksumDisabled && ctlHeader.payloadChecksum() != 0
         && ctlHeader.payloadChecksum() !=
         CTLPacketHeader::computeChecksum( m_payload->data(),
                                           m_payload->usedSize() ) )
      throw ErrorInHeaderException( ErrorInHeaderException::ErrWrongChecksum,
                                    "payload checksum in received header is wrong!",
                                    "PacketSocket::receivePacket()");
    //mySTPacketsIn->add( CTLPACKET_HEADER_SIZE, m_payload->usedSize() );
    //mySTBandwidthIn->add( CTLPACKET_HEADER_SIZE + m_payload->usedSize() );
    // construct PacketPtr
    PacketPtr ret( new PacketSLAC( ctlHeader, m_payload ) );
    m_recPackets++;
    if ( dumpPath() != "" ) dumpPacket( dumpPath(), false, ret );
    // reset variables nothing received
    m_payloadLen=0;
    m_expPayloadLen=0;
    m_headerLen=0;
    return ret;
  }
  catch (Exception &e) {
    const std::string expMsgShort="CTL packet is shorter than CTL+CAL headers";
    const std::string expMsgLong="CTL packet is longer than CTLPACKET_MAX_SIZE";
    if ( expMsgShort == std::string( e.what(), expMsgShort.size() ) ) {
      throw ErrorInHeaderException(ErrorInHeaderException::ErrPacketTooSmall,
                                   "packet size in received header is too small!",
                                   "PacketSocket::receivePacket()");
    } else if ( expMsgLong == std::string( e.what(), expMsgLong.size() ) ) {
      throw ErrorInHeaderException(ErrorInHeaderException::ErrPacketTooLarge,
                                   "packet size in received header is too large!",
                                   "PacketSocket::receivePacket()");
    } else throw;
  }
}

//---------------------------------------------------------------------------

bool PacketSocket::isOpen()
{
  return m_socket->isOpen();
}

//---------------------------------------------------------------------------

void PacketSocket::close()
{
  return m_socket->close();
}

//---------------------------------------------------------------------------

int PacketSocket::getFd()
{
  return m_socket->getFd();
}

//---------------------------------------------------------------------------

void PacketSocket::dumpPacket( const std::string& path, bool Send, const PacketPtr& packet )
{
  dumpPacket( path, Send, (*packet) );
}

//---------------------------------------------------------------------------

void PacketSocket::dumpPacket( const std::string& path, bool Send, const PacketSLAC& packet )
{
  std::ostringstream fullPath;
  fullPath << path << "/" << m_socket->desc();
  int error=mkdir( fullPath.str().c_str(), 0777);
  if (error != 0 && errno !=EEXIST )
  {
    ERROR( "could not create packet dump directory '"
           << fullPath <<"' error: " << strerror(errno) << "!" );
    dumpPath(false);
    return;
  }
  std::ostringstream filename;
  filename << fullPath.str() << "/";
  filename << std::right << std::setw(12) << std::setfill('0');
  filename << getTimeUS() - m_createTime;
  if (Send) filename << "S.bin";
  else filename << "R.bin";
  int fd = ::open( filename.str().c_str(), O_WRONLY | O_CREAT, 0666 );
  if (fd == -1)
  {
    ERROR("error opening file '" << filename.str() << "' for writing.");
    return;
  }
  size_t written=write(fd, packet.getHeader().data(), CTLPACKET_HEADER_SIZE );
  if (written == (size_t)-1 )
  {
    ERROR("could not write packet header to file, aborting. Error: " << strerror(errno) );
    ::close(fd); // Fix Coverity RESOURCE_LEAK
    return;
  }
  if (written != CTLPACKET_HEADER_SIZE )
  {
    ERROR("could not write all bytes of the header, aborting.");
    ::close(fd); // Fix Coverity RESOURCE_LEAK
    return;
  }
  written = 0;
  while (written < packet.getPayload().usedSize() )
  {
    size_t ret = ::write(fd, packet.getPayload().data()+written,
                         packet.getPayload().usedSize()-written);
    if (ret == (size_t)-1 )
    {
      ERROR("could not write payload to fiel, aborting.");
      ::close(fd); // Fix Coverity RESOURCE_LEAK
      return;
    }
    written +=ret;
  }
  ::close(fd);
}

//---------------------------------------------------------------------------
