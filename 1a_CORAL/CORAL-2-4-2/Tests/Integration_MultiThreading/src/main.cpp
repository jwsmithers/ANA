#include <cstdio>
#include <iostream>
#include <string>
#include "CoralBase/../src/coral_thread_headers.h"
#include "CoralBase/Exception.h"
#include "CoralBase/MessageStream.h"
#include "TestEnv/TestEnv.h"
#include "SingleThreadRead.h"
#include "SingleThreadWrite.h"
#include "ThreadApp.h"

#define LOG( msg ){ coral::MessageStream myMsg("MTHREAD"); myMsg << coral::Always << msg << coral::MessageStream::endmsg; }

int main( int argc, char *argv[] )
{
  try // Move everything inside try block to fix Coverity UNCAUGHT_EXCEPT
  {
    /* create new test environment *///
    TestEnv TC01("MTHREAD");
    /* check arguments *///
    if( !TC01.check(argc, argv) ) return 1;
    /* add the default connection strings to the test application *///
    TC01.addServiceName(TEST_CORE_SCHEME_ADMIN, TEST_CORE_SCHEME_ADMIN);
    /* start with the tests *///
    ThreadApp thread(TC01);
    LOG("Starting[write] one session with multithreaded requests");
    thread.createSession(0);
    thread.write();
    thread.deleteSession();
    LOG("Starting[read] one session with multithreaded requests");
    thread.createSession(0, coral::ReadOnly);
    thread.read();
    thread.deleteSession();
    unsigned nErrors = 0;
    // multithreaded sessions write
    LOG("Starting[write] one session per thread");
    {
      std::vector< SingleThreadWrite* > threadBodies;
      for ( int i = 0; i < 10; ++i )
      {
        SingleThreadWrite* swrite = new SingleThreadWrite(TC01, i, nErrors);
        threadBodies.push_back( swrite );
      }
      std::vector< boost::thread* > threads;
      for ( int i = 0; i < 10; ++i )
        threads.push_back( new boost::thread( *( threadBodies[i] ) ) );
      for ( int i = 0; i < 10; ++i )
        threads[i]->join();
      for ( int i = 0; i < 10; ++i )
      {
        delete threads[i];
        SingleThreadWrite* swrite = threadBodies[i];
        delete swrite;
      }
    }
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "#errors (write threads)", 0u, nErrors );
    // multithreaded sessions read
    LOG("Starting[read] one session per thread");
    {
      std::vector< SingleThreadRead* > threadBodies;
      for ( int i = 0; i < 10; ++i )
      {
        SingleThreadRead* sread = new SingleThreadRead(TC01, i, nErrors);
        threadBodies.push_back( sread );
      }
      std::vector< boost::thread* > threads;
      for ( int i = 0; i < 10; ++i )
        threads.push_back( new boost::thread( *( threadBodies[i] ) ) );
      for ( int i = 0; i < 10; ++i )
        threads[i]->join();
      for ( int i = 0; i < 10; ++i )
      {
        delete threads[i];
        SingleThreadRead* sread = threadBodies[i];
        delete sread;
      }
    }
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "#errors (read threads)", 0u, nErrors );
  }
  catch ( coral::Exception& e )
  {
    std::cerr << "CORAL Exception : " << e.what() << std::endl;
    return 1;
  }
  catch ( std::exception& e )
  {
    std::cerr << "C++ Exception : " << e.what() << std::endl;
    return 1;
  }
  catch ( ... )
  {
    std::cerr << "Unhandled exception " << std::endl;
    return 1;
  }
  std::cout << "[OVAL] Success" << std::endl;
  return 0;
}
