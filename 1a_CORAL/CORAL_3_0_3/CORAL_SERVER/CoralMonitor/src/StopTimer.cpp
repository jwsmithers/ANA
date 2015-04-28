// Include files
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <sys/syscall.h> // For SYS_gettid
#ifdef __linux
#  include <fcntl.h>
#  include <unistd.h>
#  include <sys/types.h>
#  undef CLK_TCK
#  define CLK_TCK 100
#endif
#include "CoralBase/Exception.h"
#include "CoralMonitor/StopTimer.h"

// Namespace
using namespace coral;

//-----------------------------------------------------------------------------

// Taken from http://www.linuxforums.org/forum/linux-programming-scripting/101371-pthreads-thread-time-vs-process-time.html
// ** WARNING! ** "The operation isn't very fast, so it shouldn't be done in a
// tight loop, but it's more accurate than what rusage can provide me, and the
// processing is mostly done in system time, so it doesn't skew the results."

#ifdef __linux
void getThreadTimes( unsigned long& jiffies_user,
                     unsigned long& jiffies_system)
{
  char procFilename[256];
  char buffer[1024];
  pid_t pid = ::getpid();
  //pid_t tid = ::gettid();
  pid_t tid = ::syscall( SYS_gettid );
  snprintf( procFilename, 256, // Fix Coverity SECURE_CODING
            "/proc/%d/task/%d/stat", pid, tid );
  int fd, num_read;
  fd = open( procFilename, O_RDONLY, 0 );
  if ( fd < 0 ) // Fix Coverity NEGATIVE_RETURNS
    throw coral::Exception("Could not open proc file",
                           "StopTimer::getThreadTimes",
                           "coral::CoralMonitor");
  num_read = read(fd, buffer, 1023);
  close(fd);
  if ( num_read < 0 ) // Fix Coverity NEGATIVE_RETURNS
    throw coral::Exception("Could not read proc file",
                           "StopTimer::getThreadTimes",
                           "coral::CoralMonitor");
  buffer[num_read] = '\0';
  char* ptrUsr = strrchr(buffer, ')') + 1;
  for(int i = 3 ; i != 14 ; ++i) ptrUsr = strchr(ptrUsr+1, ' ');
  ptrUsr++;
  jiffies_user = atol(ptrUsr);
  jiffies_system = atol(strchr(ptrUsr,' ') + 1);
}
#endif

//-----------------------------------------------------------------------------

StopTimer::StopTimer()
  : m_isEnabled( false )
  , m_isRunning( false )
  , m_elapsedTime() // Fix Coverity UNINIT_CTOR
  , m_startTime()
  , m_elapsedReal()
  , m_startReal()
#ifdef __linux
  , m_startUserLinux( 0 )
  , m_startSystemLinux( 0 )
  , m_elapsedUserLinux( 0 )
  , m_elapsedSystemLinux( 0 )
#endif
{
  if ( getenv( "CORALSERVER_TIMING" ) != 0 )
  {
    m_isEnabled=true;
    static bool first = true;
    if ( first )
    {
      first = false;
      std::cout << "CORAL Server timings enabled" << std::endl;
    }
  }
  memset( &m_elapsedTime, 0, sizeof( m_elapsedTime ) );
  memset( &m_startTime, 0, sizeof( m_startTime ) );
}

//-----------------------------------------------------------------------------

void StopTimer::start()
{
  if ( !m_isEnabled ) return;
  if ( m_isRunning )
    throw coral::Exception("Timer is already running!",
                           "StopTimer::start",
                           "coral::CoralServerBase");
  m_startReal = times( &m_startTime );
#ifdef __linux
  getThreadTimes( m_startUserLinux, m_startSystemLinux);
#endif
  m_isRunning=true;
}

//-----------------------------------------------------------------------------

void StopTimer::stop()
{
  if ( !m_isEnabled ) return;
  if ( !m_isRunning )
    throw coral::Exception("Timer is not running!",
                           "StopTimer::stop",
                           "coral::CoralServerBase");
  m_elapsedReal = times( &m_elapsedTime );
  m_elapsedReal -= m_startReal;
  m_elapsedTime.tms_utime -= m_startTime.tms_utime;
  m_elapsedTime.tms_stime -= m_startTime.tms_stime;
  m_isRunning=false;
#ifdef __linux
  getThreadTimes( m_elapsedUserLinux, m_elapsedSystemLinux);
  m_elapsedUserLinux -= m_startUserLinux;
  m_elapsedSystemLinux -= m_startSystemLinux;
#endif
}

//-----------------------------------------------------------------------------

double StopTimer::getUserTime() const
{
  if ( !m_isEnabled ) return 0;
  if ( m_isRunning )
    throw coral::Exception("Timer is still running",
                           "StopTimer::start",
                           "coral::CoralServerBase");
#ifdef __linux
  return (double)m_elapsedUserLinux / (double) ( CLK_TCK );
#else
  return (double)m_elapsedTime.tms_utime / (double) ( CLK_TCK );
#endif
}

//-----------------------------------------------------------------------------

double StopTimer::getSystemTime() const
{
  if ( !m_isEnabled ) return 0;
  if ( m_isRunning )
    throw coral::Exception("Timer is still running",
                           "StopTimer::start",
                           "coral::CoralServerBase");
  return (double)m_elapsedTime.tms_stime / (double) ( CLK_TCK );
}

//-----------------------------------------------------------------------------

double StopTimer::getRealTime() const
{
  if ( !m_isEnabled ) return 0;
  if ( m_isRunning )
    throw coral::Exception("Timer is still running",
                           "StopTimer::start",
                           "coral::CoralServerBase");
  return (double)m_elapsedReal / (double) ( CLK_TCK );
}

//-----------------------------------------------------------------------------
