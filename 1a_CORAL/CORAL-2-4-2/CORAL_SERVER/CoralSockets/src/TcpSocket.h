// $Id: TcpSocket.h,v 1.6.2.1.2.2 2013-01-01 18:24:01 avalassi Exp $
#ifndef CORALSOCKETS_TCPSOCKET_H
#define CORALSOCKETS_TCPSOCKET_H 1

#include <memory>
#include <arpa/inet.h>
#include <boost/shared_ptr.hpp>
//#include "CoralMonitor/CounterStats.h"
#include "ISocket.h"

namespace coral {

  namespace CoralSockets {

    // forward declaration
    class TcpSocket;
    class SslSocket;

    typedef boost::shared_ptr<TcpSocket> TcpSocketPtr;

    class TcpSocket : virtual public ISocket {
      friend class SslSocket;
    public:

      /// needed by Poll class
      int getFd() const { return m_fd; };

      /// create new socket connected to remote host
      /// throws exceptions on errors
      static TcpSocketPtr connectTo( const std::string& host, unsigned int port);

      /// create a listening socket
      /// throws exceptions on errors
      static TcpSocketPtr listenOn( const std::string& ip, unsigned int port);

      /// accept new connections on listening sockets
      TcpSocketPtr accept();

      /// reads at most len bytes from the socket into *buf
      virtual size_t read( unsigned char *buf, size_t len,
                           int timeout = 0);

      /// writes len bytes from *buf to the socket
      virtual size_t write( const unsigned char *buf, size_t len,
                            int timeout = 0 );

      /// reads len bytes from the socket into *buf
      /// doesn't return until all bytes are read, or some error occurs
      virtual void readAll( unsigned char *buf, size_t len);

      /// writes len bytes into the socket into *buf
      /// doesn't return until all bytes are read, or some error occurs
      virtual void writeAll( const unsigned char *buf, size_t len);

      /// polls if the socket is available
      /// if timeout > 0 the request will timeout after timeout ms, timeout = 0
      /// means return immediately, < 0 wait for ever
      virtual bool poll( ISocket::PMode mode, int timeout );

      /// returns a string describing the socket
      virtual const std::string& desc() const;

      /// closes the socket
      virtual void close();

      /// cork the socket
      /// tells the socket to only send full packets
      virtual void cork();

      /// uncork the socket
      /// send all remaining data in the buffer out and return to normal
      /// operation mode
      virtual void uncork();

      /// returns true if the socket is open
      virtual bool isOpen() const;

      std::string remoteEnd() const;

      std::string localEnd() const;

      virtual ~TcpSocket();

    protected:
      TcpSocket( int socket, const std::string& desc);

      /// standard constructor is private
      TcpSocket();
      /// copy constructor is private
      TcpSocket(const TcpSocket& );
      /// assignment operator as well
      TcpSocket& operator=(const TcpSocket& );

      /// Release the socket out of the control of TcpSocket
      /// class without closing it.
      /// Needed to create a secure SslSocket from a TcpSocket
      /// Returns the FD, the TcpSocket class can be deleted afterwards
      /// without affecting the socket.
      int releaseFD();

      /// create new fd connected to remote host
      /// throws exceptions on errors
      /// returns the file descriptor and the description in desc
      static int connectTo( std::string & desc,
                            const std::string& host, unsigned int port);

      /// create a listening socket
      /// throws exceptions on errors
      /// returns the file descriptor and the description in desc
      static int listenOn( std::string & desc,
                           const std::string& ip, unsigned int port);

      /// accept new connections on listening sockets
      /// returns the file descriptor and the descriptin in desc
      int accept( std::string & desc );

      /// sets default options on the socket
      void configureSocket();

      static void fillAddr( const std::string& hostName,
                            int port, sockaddr_in& addr);

      inline void setSockOpt(int level, int option, int value);

      inline void setFdFlags(int getCMD, int setCMD, int flags);
      inline void clearFdFlags(int getCMD, int setCMD, int flags);

      void setNonBlocking();
      void unsetNonBlocking();

      /// raw read/write method all other methods use this one
      virtual size_t read_write( PMode mode,
                                 unsigned char *buf, size_t len, int timeout );


      /// file descriptor of the socket
      int m_fd;

      /// short description of the connection
      const std::string m_desc;

      /// bytes send through the connection
      mutable uint64_t m_sendBytes;

      /// bytes send through the connection
      mutable uint64_t m_recBytes;

      //CounterStatsHandle m_stats_sockets;
      //CounterStatsHandle m_stats_connections;
    };
  }
}

#endif // CORALSOCKETS_TCPSOCKET_H
