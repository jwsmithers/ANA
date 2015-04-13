// Disable warnings triggered by the Boost 1.50.0 headers on icc (bug #100415)
#ifdef __ICC
#pragma warning ( disable: 522 )
#endif

// Disable warnings triggered by the Boost 1.53.0 headers on clang (bug #102097)
#ifdef __clang__
#pragma GCC diagnostic ignored "-Wunused-parameter"
#ifndef __APPLE__
#if ( __clang_major__ > 3 ) || ( __clang_major__ == 3 && __clang_minor__ >= 3 )
#pragma GCC diagnostic ignored "-Wconstexpr-not-const" // only clang >= 3.3
#endif
#endif
#endif

#include <cstdlib>
#include <iostream>
#include <map>
#include <memory>
#include <string>
#include <sstream>
#include <unistd.h>
#include <boost/date_time/posix_time/posix_time.hpp>
#include <boost/thread/thread.hpp>

const std::string now()
{
  // This gives UTC (while 'date +"%a %d %b %Y %H:%M:%S:%N"' gives local)
  return to_simple_string(boost::posix_time::microsec_clock::universal_time());
}

void mysleep( unsigned sec, const std::string desc="" )
{
  std::cout << desc << " Sleep " << sec << "s" << std::endl;
  std::cout << desc << " " << now() << std::endl;
  //::sleep(sec); // does not sleep with igprof/gperf real time profiling?!?
  for ( unsigned i=0; i<345000000*sec; ++i ) {} // 1s on my PC in dbg builds
  std::cout << desc << " " << now() << std::endl;
}

class SleepingThread
{
protected:
  SleepingThread( unsigned sec )
    : m_sec( sec ), m_ithread( s_nthreads++ )
  {
    std::cout << "__Thread #" << m_ithread
              << " Creating thread " << this << std::endl;
    s_threadMap[m_ithread]=this;
  }
  SleepingThread( const SleepingThread& rhs )
    : m_sec( rhs.m_sec ), m_ithread( rhs.m_ithread )
  {
    //std::cout << "__Thread #" << m_ithread
    //          << " Copy-Creating thread " << this << std::endl;
    s_threadMap[m_ithread]=this;
  }
  virtual ~SleepingThread()
  {
    if ( s_threadMap[m_ithread]==this )
      std::cout << "__Thread #" << m_ithread
                << " Deleting thread " << this << std::endl;
  }
  virtual void operator()()
  {
    std::stringstream desc;
    desc << "__Thread #" << m_ithread;
    mysleep( m_sec, desc.str() );
  }
private:
  unsigned m_sec;
  unsigned m_ithread;
  static unsigned s_nthreads;
  static std::map<unsigned,void*> s_threadMap;
};

unsigned SleepingThread::s_nthreads = 0;
std::map<unsigned,void*> SleepingThread::s_threadMap;

//---------------------------------------------------------------------------

void mysleepA( unsigned sec, const std::string desc="" )
{
  mysleep( sec, desc );
}

//---------------------------------------------------------------------------

class SleepingThreadB : public SleepingThread
{
public:
  SleepingThreadB( unsigned sec ) : SleepingThread( sec ) {}
  SleepingThreadB( const SleepingThreadB& rhs ) : SleepingThread( rhs ) {}
  virtual ~SleepingThreadB() {}
  void operator()()
  {
    SleepingThread::operator()();
  }
};

void mysleepIn1ThreadB( unsigned sec )
{
  std::auto_ptr<boost::thread> pThread;
  pThread.reset( new boost::thread( SleepingThreadB( sec ) ) );
  pThread->join();
}

//---------------------------------------------------------------------------

class SleepingThreadC1 : public SleepingThread
{
public:
  SleepingThreadC1( unsigned sec ) : SleepingThread( sec ) {}
  SleepingThreadC1( const SleepingThreadC1& rhs ) : SleepingThread( rhs ) {}
  virtual ~SleepingThreadC1() {}
  void operator()()
  {
    SleepingThread::operator()();
  }
};

void mysleepC2( unsigned sec, const std::string desc="" )
{
  mysleep( sec, desc );
}

class SleepingThreadC3 : public SleepingThread
{
public:
  SleepingThreadC3( unsigned sec ) : SleepingThread( sec ) {}
  SleepingThreadC3( const SleepingThreadC3& rhs ) : SleepingThread( rhs ) {}
  virtual ~SleepingThreadC3() {}
  void operator()()
  {
    SleepingThread::operator()();
  }
};

void mysleepIn2ThreadsC( unsigned sec )
{
  if ( sec < 3 )
  {
    std::cout << "ERROR! sec<3" << std::endl;
    exit(1);
  }
  std::auto_ptr<boost::thread> pThread1;
  pThread1.reset( new boost::thread( SleepingThreadC1( sec ) ) );
  mysleepC2(1,"__in_between_threads");
  std::auto_ptr<boost::thread> pThread2;
  pThread2.reset( new boost::thread( SleepingThreadC3( sec ) ) );
  pThread1->join();
  pThread2->join();
}

//---------------------------------------------------------------------------

void mysleepD( unsigned sec, const std::string desc="" )
{
  mysleep( sec, desc );
}

//---------------------------------------------------------------------------

int main()
{
  mysleepA(2,"__main");
  mysleepIn1ThreadB(1);
  mysleepIn2ThreadsC(3); // total sleep 3+1=4
  mysleepD(3,"__main");
  return 0;
}

//---------------------------------------------------------------------------
