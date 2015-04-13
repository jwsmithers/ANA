// Include files
#include <cstdio>
#include <iostream>
#include <pthread.h>
#include <sstream>
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"
#include "CoralBase/Blob.h"
#include "CoralBase/Exception.h"
#include "CoralBase/TimeStamp.h"
#include "CoralServerBase/ByteBuffer.h"
#include "CoralServerBase/CALPacketHeader.h"
#include "CoralServerBase/CALOpcode.h"
#include "CoralServerBase/ICoralFacade.h"
#include "CoralServerBase/IRequestHandler.h"
#include "CoralServerBase/QueryDefinition.h"
#include "CoralBase/../tests/Common/CoralCppUnitTest.h"
#include "CoralStubs/ServerStub.h"
#include "CoralStubs/ClientStub.h"
#include "RelationalAccess/AuthenticationServiceException.h"
#include "RelationalAccess/ConnectionServiceException.h"
#include "RelationalAccess/RelationalServiceException.h"
#include "RelationalAccess/SchemaException.h"
#include "RelationalAccess/SessionException.h"
#include "RelationalAccess/TableDescription.h"

// Local include files
#include "../../src/DummyFacade.h"
#include "../../src/Exceptions.h"
#include "../../src/RowIteratorAll.h"
#include "../../src/RowIteratorFetch.h"

namespace coral
{

  class AllPartsTest : public CoralCppUnitTest
  {

    CPPUNIT_TEST_SUITE( AllPartsTest );
    CPPUNIT_TEST( test_Basic );
    CPPUNIT_TEST( test_FetchRowsWithoutBuffer );
    CPPUNIT_TEST( test_FetchRowsWithBuffer );
    CPPUNIT_TEST( test_FetchAllRowsWithoutBuffer );
    CPPUNIT_TEST( test_FetchAllRowsWithBuffer );
    CPPUNIT_TEST( test_ExceptionRAL );
    CPPUNIT_TEST( test_MultiThreadCursor );
    CPPUNIT_TEST_SUITE_END();

  public:

    void
    test_Basic()
    {
      //create a test dummy facade
      CoralStubs::DummyFacade df;
      //create a request handler
      CoralStubs::ServerStub sstub(df);
      //create a coral facade
      CoralStubs::ClientStub cstub(sstub);
      bool fromProxy;
      Token session = cstub.connect("http://hello_world", coral::ReadOnly, fromProxy);
      cstub.startTransaction(session, true);
      cstub.commitTransaction(session);
      cstub.releaseSession(session);
    }

    void
    test_FetchRowsWithoutBuffer()
    {
      //create a test dummy facade
      CoralStubs::DummyFacade df;
      //create a request handler
      CoralStubs::ServerStub sstub(df);
      //create a coral facade
      CoralStubs::ClientStub cstub(sstub);
      //connect
      bool fromProxy;
      Token session = cstub.connect("http://hello_world", coral::ReadOnly, fromProxy);
      cstub.startTransaction(session, true);
      QueryDefinition qd;
      qd.addToOrderList( "Col01" );
      qd.addToTableList( "Table01", "T1" );
      qd.limitReturnedRows( 5, 32342 );
      std::cout << std::endl << "Test without RowBuffer at 10 rows per request" << std::endl;
      {
        IRowIteratorPtr rowa = cstub.fetchRows( session, qd, NULL, 10, false );
        size_t counter = 0;
        while(rowa->nextRow())
        {
          counter++;
          const coral::AttributeList& alh = rowa->currentRow();
          alh.toOutputStream(std::cout) << std::endl;
        }
        if(counter != 5)
          CPPUNIT_FAIL("Fetched wrong amount of rows #1");
        coral::CoralStubs::RowIteratorFetch* rif = dynamic_cast<coral::CoralStubs::RowIteratorFetch*>(rowa.get()); if ( rif ) std::cout << "Number of requests " << rif->getNumberOfRequests() << std::endl;  // Fix Coverity FORWARD_NULL
        std::cout << std::endl << "Test without RowBuffer at 2 rows per request" << std::endl;
      }
      {
        IRowIteratorPtr rowa = cstub.fetchRows( session, qd, NULL, 2, false );
        size_t counter = 0;
        while(rowa->nextRow())
        {
          counter++;
          const coral::AttributeList& alh = rowa->currentRow();
          alh.toOutputStream(std::cout) << std::endl;
        }
        if(counter != 5)
          CPPUNIT_FAIL("Fetched wrong amount of rows #2");
        coral::CoralStubs::RowIteratorFetch* rif = dynamic_cast<coral::CoralStubs::RowIteratorFetch*>(rowa.get()); if ( rif ) std::cout << "Number of requests " << rif->getNumberOfRequests() << std::endl;  // Fix Coverity FORWARD_NULL
        std::cout << std::endl << "Test without RowBuffer at 10MB per request" << std::endl;
      }
      {
        IRowIteratorPtr rowa = cstub.fetchRows( session, qd, NULL, 10, true );
        size_t counter = 0;
        while(rowa->nextRow())
        {
          counter++;
          const coral::AttributeList& alh = rowa->currentRow();
          alh.toOutputStream(std::cout) << std::endl;
        }
        if(counter != 5)
          CPPUNIT_FAIL("Fetched wrong amount of rows #3");
        coral::CoralStubs::RowIteratorFetch* rif = dynamic_cast<coral::CoralStubs::RowIteratorFetch*>(rowa.get()); if ( rif ) std::cout << "Number of requests " << rif->getNumberOfRequests() << std::endl;  // Fix Coverity FORWARD_NULL
        std::cout << std::endl << "Test without RowBuffer at 2MB per request" << std::endl;
      }
      {
        IRowIteratorPtr rowa = cstub.fetchRows( session, qd, NULL, 2, true );
        size_t counter = 0;
        while(rowa->nextRow())
        {
          counter++;
          const coral::AttributeList& alh = rowa->currentRow();
          alh.toOutputStream(std::cout) << std::endl;
        }
        if(counter != 5)
          CPPUNIT_FAIL("Fetched wrong amount of rows #4");
        coral::CoralStubs::RowIteratorFetch* rif = dynamic_cast<coral::CoralStubs::RowIteratorFetch*>(rowa.get()); if ( rif ) std::cout << "Number of requests " << rif->getNumberOfRequests() << std::endl;  // Fix Coverity FORWARD_NULL
      }
      cstub.commitTransaction(session);
      cstub.releaseSession(session);
    }

    void
    test_FetchRowsWithBuffer()
    {
      //create a test dummy facade
      CoralStubs::DummyFacade df;
      //create a request handler
      CoralStubs::ServerStub sstub(df);
      //create a coral facade
      CoralStubs::ClientStub cstub(sstub);
      //connect
      bool fromProxy;
      Token session = cstub.connect("http://hello_world", coral::ReadOnly, fromProxy);
      cstub.startTransaction(session, true);
      QueryDefinition qd;
      qd.addToOrderList( "Col01" );
      qd.addToTableList( "Table01", "T1" );
      qd.limitReturnedRows( 5, 32342 );
      AttributeList al01;
      al01.extend("A", typeid(coral::TimeStamp));
      al01.extend("B", typeid(double));
      al01.extend("C1", typeid(std::string));
      al01.extend("C2", typeid(std::string));
      al01.extend("D", typeid(int));
      al01.extend("E", typeid(coral::Blob));
      /*
      al01[0].data<std::string>() = "hello world";
      al01[1].data<int>() = -45;
      *///
      //use maxsize 10 rows here
      std::cout << std::endl << "Test with RowBuffer at 10 rows per request, output via currentrow" << std::endl;
      {
        IRowIteratorPtr rowa = cstub.fetchRows( session, qd, &al01, 10, false );
        size_t counter = 0;
        while(rowa->nextRow())
        {
          counter++;
          const coral::AttributeList& alh = rowa->currentRow();
          if(alh.size() == 0)
            CPPUNIT_FAIL("AttributeList size is zero");
          if(&alh != &al01)
            CPPUNIT_FAIL("AttributeBuffer missmatch");
          alh.toOutputStream(std::cout) << std::endl;
        }
        if(counter != 5)
          CPPUNIT_FAIL("Fetched wrong amount of rows #1");
        coral::CoralStubs::RowIteratorFetch* rif = dynamic_cast<coral::CoralStubs::RowIteratorFetch*>(rowa.get()); if ( rif ) std::cout << "Number of requests " << rif->getNumberOfRequests() << std::endl;  // Fix Coverity FORWARD_NULL
        std::cout << std::endl << "Test with RowBuffer at 10 rows per request, output via rowbuffer" << std::endl;
      }
      {
        IRowIteratorPtr rowa = cstub.fetchRows( session, qd, &al01, 10, false );
        size_t counter = 0;
        while(rowa->nextRow())
        {
          counter++;
          if(al01.size() == 0)
            CPPUNIT_FAIL("AttributeList size is zero");
          al01.toOutputStream(std::cout) << std::endl;
        }
        if(counter != 5)
          CPPUNIT_FAIL("Fetched wrong amount of rows #2");
        coral::CoralStubs::RowIteratorFetch* rif = dynamic_cast<coral::CoralStubs::RowIteratorFetch*>(rowa.get()); if ( rif ) std::cout << "Number of requests " << rif->getNumberOfRequests() << std::endl;  // Fix Coverity FORWARD_NULL
        //use 2 rows
        std::cout << "Test with RowBuffer at 2 rows per request, output via currentrow" << std::endl;
      }
      {
        IRowIteratorPtr rowa = cstub.fetchRows( session, qd, &al01, 2, false );
        size_t counter = 0;
        while(rowa->nextRow())
        {
          counter++;
          const coral::AttributeList& alh = rowa->currentRow();
          if(alh.size() == 0)
            CPPUNIT_FAIL("AttributeList size is zero");
          if(&alh != &al01)
            CPPUNIT_FAIL("AttributeBuffer missmatch");
          alh.toOutputStream(std::cout) << std::endl;
        }
        if(counter != 5)
          CPPUNIT_FAIL("Fetched wrong amount of rows #3");
        coral::CoralStubs::RowIteratorFetch* rif = dynamic_cast<coral::CoralStubs::RowIteratorFetch*>(rowa.get()); if ( rif ) std::cout << "Number of requests " << rif->getNumberOfRequests() << std::endl;  // Fix Coverity FORWARD_NULL
        std::cout << "Test with RowBuffer at 2 rows per request, output via rowbuffer" << std::endl;
      }
      {
        IRowIteratorPtr rowa = cstub.fetchRows( session, qd, &al01, 2, false );
        size_t counter = 0;
        while(rowa->nextRow())
        {
          counter++;
          if(al01.size() == 0)
            CPPUNIT_FAIL("AttributeList size is zero");
          al01.toOutputStream(std::cout) << std::endl;
        }
        if(counter != 5)
          CPPUNIT_FAIL("Fetched wrong amount of rows #4");
        coral::CoralStubs::RowIteratorFetch* rif = dynamic_cast<coral::CoralStubs::RowIteratorFetch*>(rowa.get()); if ( rif ) std::cout << "Number of requests " << rif->getNumberOfRequests() << std::endl;  // Fix Coverity FORWARD_NULL
        std::cout << "Test with RowBuffer at 10MB per request, output via rowbuffer" << std::endl;
      }
      {
        IRowIteratorPtr rowa = cstub.fetchRows( session, qd, &al01, 10, true );
        size_t counter = 0;
        while(rowa->nextRow())
        {
          counter++;
          if(al01.size() == 0)
            CPPUNIT_FAIL("AttributeList size is zero");
          al01.toOutputStream(std::cout) << std::endl;
        }
        if(counter != 5)
          CPPUNIT_FAIL("Fetched wrong amount of rows #5");
        coral::CoralStubs::RowIteratorFetch* rif = dynamic_cast<coral::CoralStubs::RowIteratorFetch*>(rowa.get()); if ( rif ) std::cout << "Number of requests " << rif->getNumberOfRequests() << std::endl;  // Fix Coverity FORWARD_NULL
        std::cout << "Test with RowBuffer at 2MB per request, output via rowbuffer" << std::endl;
      }
      {
        IRowIteratorPtr rowa = cstub.fetchRows( session, qd, &al01, 2, true );
        size_t counter = 0;
        while(rowa->nextRow())
        {
          counter++;
          if(al01.size() == 0)
            CPPUNIT_FAIL("AttributeList size is zero");
          al01.toOutputStream(std::cout) << std::endl;
        }
        if(counter != 5)
          CPPUNIT_FAIL("Fetched wrong amount of rows #6");
        coral::CoralStubs::RowIteratorFetch* rif = dynamic_cast<coral::CoralStubs::RowIteratorFetch*>(rowa.get()); if ( rif ) std::cout << "Number of requests " << rif->getNumberOfRequests() << std::endl;  // Fix Coverity FORWARD_NULL
      }
      cstub.commitTransaction(session);
      cstub.releaseSession(session);
    }

    void
    test_FetchAllRowsWithoutBuffer()
    {
      //create a test dummy facade
      CoralStubs::DummyFacade df;
      //create a request handler
      CoralStubs::ServerStub sstub(df);
      //create a coral facade
      CoralStubs::ClientStub cstub(sstub);
      //connect
      bool fromProxy;
      Token session = cstub.connect("http://hello_world", coral::ReadOnly, fromProxy);
      cstub.startTransaction(session, true);
      QueryDefinition qd;
      qd.addToOrderList( "Col01" );
      qd.addToTableList( "Table01", "T1" );
      qd.limitReturnedRows( 5, 32342 );
      IRowIteratorPtr rowa = cstub.fetchAllRows( session, qd, NULL );
      size_t counter = 0;
      while(rowa->nextRow())
      {
        const coral::AttributeList& alh = rowa->currentRow();
        if(alh.size() == 0)
          CPPUNIT_FAIL("AttributeList size is zero");
        alh.toOutputStream(std::cout) << std::endl;
        counter++;
      }
      if(counter != 30)
        CPPUNIT_FAIL("Fetched wrong amount of rows #0");
      cstub.commitTransaction(session);
      cstub.releaseSession(session);
    }

    void
    test_FetchAllRowsWithBuffer()
    {
      //create a test dummy facade
      CoralStubs::DummyFacade df;
      //create a request handler
      CoralStubs::ServerStub sstub(df);
      //create a coral facade
      CoralStubs::ClientStub cstub(sstub);
      //connect
      bool fromProxy;
      Token session = cstub.connect("http://hello_world", coral::ReadOnly, fromProxy);
      cstub.startTransaction(session, true);
      QueryDefinition qd;
      qd.addToOrderList( "Col01" );
      qd.addToTableList( "Table01", "T1" );
      qd.limitReturnedRows( 5, 32342 );
      AttributeList al01;
      IRowIteratorPtr rowa = cstub.fetchAllRows( session, qd, &al01 );
      while(rowa->nextRow())
      {
        const coral::AttributeList& alh = rowa->currentRow();
        if(alh.size() == 0)
          CPPUNIT_FAIL("AttributeList size is zero");
        if(&alh != &al01)
          CPPUNIT_FAIL("AttributeBuffer missmatch");
        alh.toOutputStream(std::cout) << std::endl;
      }
      cstub.commitTransaction(session);
      cstub.releaseSession(session);
    }

    void
    test_ExceptionRAL()
    {
      //create a test dummy facade
      CoralStubs::DummyFacade df;
      //create a request handler
      CoralStubs::ServerStub sstub(df);
      //create a coral facade
      CoralStubs::ClientStub cstub(sstub);
      //connect
      bool fromProxy;
      Token session = cstub.connect("http://hello_world", coral::ReadOnly, fromProxy);
      try
      {
        cstub.startTransaction(session, false);
        CPPUNIT_FAIL("Exception was not catched");
      }
      catch ( coral::Exception& )
      {
      }
      cstub.releaseSession(session);
    }

    static void*
    test_MT_01(void* f)
    {
      CoralStubs::ClientStub& cstub = *((CoralStubs::ClientStub*)f);
      bool fromProxy;
      Token session = cstub.connect("http://hello_world", coral::ReadOnly, fromProxy);
      cstub.startTransaction(session, true);
      QueryDefinition qd;
      qd.addToOrderList( "Col01" );
      qd.addToTableList( "Table01", "T1" );
      qd.limitReturnedRows( 5, 32342 );
      AttributeList al01;
      IRowIteratorPtr rowa = cstub.fetchAllRows( session, qd, &al01 );
      //     IRowIteratorPtr rowa = cstub.fetchRows( session, qd, NULL, 10, false );
      while(rowa->nextRow())
      {
        const coral::AttributeList& alh = rowa->currentRow();
        alh.toOutputStream(std::cout) << std::endl;
      }
      cstub.commitTransaction(session);
      cstub.releaseSession(session);
      return NULL;
    }

    void
    test_MultiThreadCursor()
    {
      //create a test dummy facade
      CoralStubs::DummyFacade df;
      //create a request handler
      CoralStubs::ServerStub sstub(df);
      //create a coral facade
      CoralStubs::ClientStub cstub(sstub);
      //connect
      //create 10 threads doing something
      pthread_t id[11];
      pthread_attr_t attr;
      pthread_attr_init(&attr);
      pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
      for( size_t i = 1; i < 10; i++ ) {
        pthread_create(&id[i], &attr, test_MT_01, (void*)&cstub);
      }
      void *status;
      for( size_t i = 1; i < 10; i++ ) {
        pthread_join(id[i], &status);
      }
    }

  };

  CPPUNIT_TEST_SUITE_REGISTRATION( AllPartsTest );

}

CORALCPPUNITTEST_MAIN( AllPartsTest )
