// $Id: test_RelationalObjectIterator.cpp,v 1.33 2013-03-08 11:44:44 avalassi Exp $

// First of all, enable or disable the COOL290 API extensions (bug #92204)
#include "CoolKernel/VersionInfo.h"

// Include files
#include <string>
#include "CoolKernel/FolderSpecification.h"
#include "CoolKernel/IDatabase.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/IFolder.h"
#include "CoolKernel/InternalErrorException.h"
#include "CoolKernel/IObject.h"
#include "CoolKernel/IObjectIterator.h"
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordSpecification.h"
#include "CoralBase/Attribute.h"
#include "RelationalAccess/IConnectionService.h"
#include "RelationalAccess/IConnectionServiceConfiguration.h"

// Local include files
//#define COOLUNITTESTTIMER 1
//#define COOLDBUNITTESTDEBUG 1
#include "tests/Common/CoolDBUnitTest.h"
#include "src/CoralApplication.h"
#include "src/attributeListToString.h"
#include "src/IteratorException.h"
#include "src/IRelationalCursor.h"
#include "src/IRelationalQueryDefinition.h"
#include "src/RalDatabaseSvc.h"
#include "src/RelationalObjectIterator.h"
#include "src/TransRelObjectIterator.h"

// Forward declaration (for easier indentation)
namespace cool
{
  class RelationalObjectIteratorTest;
}

// The test class
class cool::RelationalObjectIteratorTest : public cool::CoolDBUnitTest
{

private:

  CPPUNIT_TEST_SUITE( RelationalObjectIteratorTest );
  CPPUNIT_TEST( test_browseObjects );
  CPPUNIT_TEST( test_begin );
  CPPUNIT_TEST( test_iterator_prefix_increment );
  CPPUNIT_TEST( test_end );
  CPPUNIT_TEST( test_for_loop );
  CPPUNIT_TEST( test_cursor_read_concurrency );
  CPPUNIT_TEST( test_cursor_read_concurrency2 );
  CPPUNIT_TEST( test_cursor_write_concurrency );
  CPPUNIT_TEST( test_goToNext );
  CPPUNIT_TEST( test_close );
  CPPUNIT_TEST( test_destructor );
  CPPUNIT_TEST( test_reverse );
  CPPUNIT_TEST( test_bug36646 );
  CPPUNIT_TEST( test_opt_CLOB_fails_without_checkLength_call );
  CPPUNIT_TEST( test_vector );
  CPPUNIT_TEST( test_vector_SV );
  CPPUNIT_TEST( test_vector_skip_payload );
  CPPUNIT_TEST_SUITE_END();

public:

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  /// Test for bug #36646 in ConstRecordAdapter
  void test_bug36646()
  {
    folder->storeObject( 0, 2, dummyPayload( 1 ), 0 );
    folder->setPrefetchAll( false );
    IObjectIteratorPtr objs =
      folder->browseObjects( 0, 10, ChannelSelection::all() );
    CPPUNIT_ASSERT_MESSAGE( "goToNext", objs->goToNext() ); // Fix Coverity CHECKED_RETURN
    const IObject& obj1 = objs->currentRef();
    CPPUNIT_ASSERT_MESSAGE
      ( "first object", dummyPayload( 1 ) == obj1.payload() );
    const IRecord& p = obj1.payload();
    const coral::AttributeList& a = p.attributeList();
    try
    {
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "payload IRecord.size == AttributeList.size",
          (int)p.specification().size(), (int)a.size() );
    }
    catch( ... )
    {
      std::cout << "\npayload(): " << p << std::endl;
      std::cout << "payload().attributeList(): "
                << attributeListToString(a) << std::endl;
      throw;
    }
  }

  // Private helper
  IObjectPtr getNext( IObjectIteratorPtr objs )
  {
    if ( !objs->goToNext() ) CPPUNIT_FAIL( "no next object" );
    return IObjectPtr( objs->currentRef().clone() );
  }

  /// Tests basic reverse iterator behavior.
  /// More complex scenarios are tested in higher level tests.
  void test_reverse()
  {
    fillFolders();
    ChannelSelection ch( 0, 0, ChannelSelection::sinceDescBeforeChannel );
    IObjectIteratorPtr objs = folder->browseObjects( 0, 30, ch, "" );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count",
                                  3u, (unsigned int)objs->size() );
    IObjectPtr iter = getNext(objs);
    CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                            dummyPayload( 2 ) == iter->payload() );
    iter = getNext(objs);
    CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
                            dummyPayload( 1 ) == iter->payload() );
    iter = getNext(objs);
    CPPUNIT_ASSERT_MESSAGE( "obj 0 payload",
                            dummyPayload( 0 ) == iter->payload() );
  }

  /// Tests that the destructor ends the transaction
  void test_destructor()
  {
    fillFolders();
    try
    {
      folder->setPrefetchAll( false );
      IObjectIteratorPtr objs = folder->browseObjects( 5, 25, 0 );
      IObjectIteratorPtr null;
      //std::cout << "Delete iterator" << std::endl;
      objs = null;
      //std::cout << "Deleted iterator" << std::endl;
      objs = folder->browseObjects( 5, 25, 0 );
      CPPUNIT_ASSERT_MESSAGE( "goToNext", objs->goToNext() );
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests that close ends the transaction
  void test_close()
  {
    fillFolders();
    try
    {
      folder->setPrefetchAll( false );
      IObjectIteratorPtr objs = folder->browseObjects( 5, 25, 0 );
      //std::cout << "Close iterator" << std::endl;
      objs->close();
      //std::cout << "Closed iterator" << std::endl;
      objs = folder->browseObjects( 5, 25, 0 );
      CPPUNIT_ASSERT_MESSAGE( "goToNext", objs->goToNext() );
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Test goToNext
  void test_goToNext()
  {
    fillFolders();
    IObjectIteratorPtr objs = folder->browseObjects( 5, 25, 0 );
    CPPUNIT_ASSERT_MESSAGE( "goToNext", objs->goToNext() );
  }

  /// Test browse_performance
  void test_browse_performance()
  {
    fillFolders();
    int nObjs = 100;
    {
      folder->setupStorageBuffer();
      for ( int i = 0; i < nObjs; ++i ) {
        folder->storeObject( i, ValidityKeyMax, dummyPayload( i ), 0 );
      }
      folder->flushStorageBuffer();
    }
    if (1) {
      SimpleTimer timer;
      //folder->setPrefetchAll( false ); // needed or not for this benchmark?
      IObjectIteratorPtr objs =
        folder->browseObjects( ValidityKeyMin, ValidityKeyMax, 0 );
      int nReadObjects = 0;
      //for ( IObjectIterator::const_iterator
      //      i = objs->begin(); i != objs->end(); ++i ) {
      //  ++nReadObjects;
      //}
      while ( objs->goToNext() )
      {
        ++nReadObjects;
      }
      double secElapsed = timer.elapsedSecondsReal();
      std::cout << "** browsing " << nObjs << " objects **" << std::endl;
      std::cout << "read back " << nReadObjects << " objects" << std::endl;
      std::cout << "sec total: " << secElapsed << std::endl;
      std::cout << "obj/s:     " << nReadObjects/secElapsed << std::endl;
    }
  }

  /// Tests behavior of a cursor with a concurrent write operation.
  void test_cursor_write_concurrency()
  {
    fillFolders();
    folder->setPrefetchAll( false );
    IObjectIteratorPtr objs1 = folder->browseObjects( 5, 25, 0 );
    CPPUNIT_ASSERT_MESSAGE( "goToNext", objs1->goToNext() ); // Fix Coverity CHECKED_RETURN
    try
    {
      folder->storeObject( 0, 2, dummyPayload( 0 ), 0 );
      CPPUNIT_FAIL( "exception expected" );
    }
    catch ( std::exception& e )
    {
      CPPUNIT_ASSERT_EQUAL
        ( std::string( "Cannot start a concurrent write transaction" ),
          std::string( e.what() ) );
    }
  }

  /// Tests behavior of concurrent read-only cursors.
  void test_cursor_read_concurrency()
  {
    fillFolders();
    bool debug = false;
    folder->setPrefetchAll( false );
    IObjectIteratorPtr objs1 = folder->browseObjects( 5, 25, 0 );
    if ( debug ) std::cout << "1st iterator started" << std::endl;
    try
    {
      IObjectIteratorPtr objs2 = folder->browseObjects( 5, 25, 0 );
      if ( debug ) std::cout << "2nd iterator started" << std::endl;
      CPPUNIT_FAIL( "Should not be able to retrieve/start 2nd iterator" );
      // What follows is the old COOL210 test
      // (which succeeded before fixing bug #25151)
      IObjectPtr obj;
      CPPUNIT_ASSERT( objs1->goToNext() );
      obj = IObjectPtr( objs1->currentRef().clone() );
      CPPUNIT_ASSERT( dummyPayload( 0 ) == obj->payload() );
      if ( debug ) std::cout << "1st iterator: next() executed" << std::endl;
      CPPUNIT_ASSERT( objs2->goToNext() );
      obj = IObjectPtr( objs2->currentRef().clone() );
      CPPUNIT_ASSERT( dummyPayload( 0 ) == obj->payload() );
      if ( debug ) std::cout << "2nd iterator: next() executed" << std::endl;
      CPPUNIT_ASSERT( objs1->goToNext() );
      obj = IObjectPtr( objs1->currentRef().clone() );
      CPPUNIT_ASSERT( dummyPayload( 1 ) == obj->payload() );
      if ( debug ) std::cout << "1st iterator: next() executed" << std::endl;
      CPPUNIT_ASSERT( objs2->goToNext() );
      obj = IObjectPtr( objs2->currentRef().clone() );
      CPPUNIT_ASSERT( dummyPayload( 1 ) == obj->payload() );
      if ( debug ) std::cout << "2nd iterator: next() executed" << std::endl;
      CPPUNIT_ASSERT( objs1->goToNext() );
      obj = IObjectPtr( objs1->currentRef().clone() );
      CPPUNIT_ASSERT( dummyPayload( 2 ) == obj->payload() );
      if ( debug ) std::cout << "1st iterator: next() executed" << std::endl;
      CPPUNIT_ASSERT( objs2->goToNext() );
      obj = IObjectPtr( objs2->currentRef().clone() );
      CPPUNIT_ASSERT( dummyPayload( 2 ) == obj->payload() );
      if ( debug ) std::cout << "2nd iterator: next() executed" << std::endl;
    }
    catch ( TooManyIterators& ) {
    }
    catch ( std::exception& e ) {
      CPPUNIT_FAIL
        ( "Exception caught (TooManyIterators expected): " +
          std::string( e.what() ) );
    }
    catch ( ... )
    {
      CPPUNIT_FAIL
        ( "Unknown exception caught (TooManyIterators expected)" );
    }
  }

  /// Tests behavior of concurrent read-only cursors
  /// (when one is closed before the end).
  /// This fails catastrophically (abort and stack trace) in COOL210.
  void test_cursor_read_concurrency2()
  {
    fillFolders();
    bool debug = false;
    folder->setPrefetchAll( false );
    IObjectIteratorPtr objs1 = folder->browseObjects( 5, 25, 0 );
    if ( debug ) std::cout << "1st iterator started" << std::endl;
    try
    {
      IObjectIteratorPtr objs2 = folder->browseObjects( 5, 25, 0 );
      if ( debug ) std::cout << "2nd iterator started" << std::endl;
      CPPUNIT_FAIL( "Should not be able to retrieve/start 2nd iterator" );
      // What follows is the old COOL210 test
      // (which succeeded before fixing bug #25151)
      IObjectPtr obj;
      CPPUNIT_ASSERT( objs1->goToNext() );
      obj = IObjectPtr( objs1->currentRef().clone() );
      CPPUNIT_ASSERT( dummyPayload( 0 ) == obj->payload() );
      if ( debug ) std::cout << "1st iterator: currentRef().clone() executed"
                             << std::endl;
      CPPUNIT_ASSERT( objs2->goToNext() );
      obj = IObjectPtr( objs2->currentRef().clone() );
      CPPUNIT_ASSERT( dummyPayload( 0 ) == obj->payload() );
      if ( debug ) std::cout << "2nd iterator: currentRef().clone() executed"
                             << std::endl;
      CPPUNIT_ASSERT( objs1->goToNext() );
      obj = IObjectPtr( objs1->currentRef().clone() );
      CPPUNIT_ASSERT( dummyPayload( 1 ) == obj->payload() );
      if ( debug ) std::cout << "1st iterator: currentRef().clone() executed"
                             << std::endl;
      CPPUNIT_ASSERT( objs2->goToNext() );
      objs2->close();
      if ( debug ) std::cout << "2nd iterator: close() executed" << std::endl;
      CPPUNIT_ASSERT( objs1->goToNext() );
      obj = IObjectPtr( objs1->currentRef().clone() );
      CPPUNIT_ASSERT( dummyPayload( 2 ) == obj->payload() );
      if ( debug ) std::cout << "1st iterator: currentRef().clone() executed"
                             << std::endl;
    }
    catch ( TooManyIterators& ) {}
  }

  /// Tests correct for-loop behavior.
  void test_for_loop()
  {
    fillFolders();
    folder->setPrefetchAll( false );
    IObjectIteratorPtr objs = folder->browseObjects( 5, 25, 0 );
    int loop_count = 0;
    //for ( IObjectIterator::const_iterator
    //      obj = objs->begin(); obj != objs->end(); ++obj ) {
    while ( objs->goToNext() ) {
      IObjectPtr obj( objs->currentRef().clone() );
      CPPUNIT_ASSERT_MESSAGE
        ( "obj payload", dummyPayload( loop_count ) == obj->payload() );
      ++loop_count;
    }
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "loop count", 3, loop_count );
  }

  /// Tests that the iterator correctly points at the end after the container
  /// has been exhausted.
  void test_end()
  {
    fillFolders();
    folder->setPrefetchAll( false );
    try
    {
      IObjectIteratorPtr objs = folder->browseObjects( 5, 25, 0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "object count", 3u, (unsigned int)objs->size() );
      //IObjectIterator::const_iterator iter = objs->begin();
      CPPUNIT_ASSERT_MESSAGE( "goToNext", objs->goToNext() ); // Fix Coverity CHECKED_RETURN
      //CPPUNIT_ASSERT_MESSAGE
      //  ( "Iterator different from end()", iter != objs->end() );
      //CPPUNIT_ASSERT_MESSAGE
      //  ( "Iterator different from end()", objs->hasNext() );
      //++iter;
      //++iter;
      //++iter;
      CPPUNIT_ASSERT_MESSAGE( "goToNext", objs->goToNext() ); // Fix Coverity CHECKED_RETURN
      CPPUNIT_ASSERT_MESSAGE( "goToNext", objs->goToNext() ); // Fix Coverity CHECKED_RETURN
      //objs->next(); // next() can be called ONLY three times!
      //CPPUNIT_ASSERT_MESSAGE
      //  ( "Iterator pointing at end", iter == objs->end() );
      CPPUNIT_ASSERT_MESSAGE
        ( "Iterator pointing at end", !objs->goToNext() );
      try {
        objs->currentRef(); // goToNext() can be called ONLY three times!
        CPPUNIT_FAIL( "exception expected" );
      } catch ( IteratorHasNoCurrentItem& ) {
      } catch ( std::exception& e ) {
        CPPUNIT_FAIL
          ( "Exception caught (IteratorHasNoCurrentItem expected): " +
            std::string( e.what() ) );
      } catch ( ... ) {
        CPPUNIT_FAIL
          ( "Unknown exception caught, IteratorHasNoNextItem expected" );
      }
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests that prefix operator++ correctly iterates through the container.
  void test_iterator_prefix_increment()
  {
    fillFolders();
    folder->setPrefetchAll( false );
    IObjectIteratorPtr objs = folder->browseObjects( 5, 25, 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "object count", 3u, (unsigned int)objs->size() );
    //IObjectIterator::const_iterator iter = objs->begin();
    IObjectPtr iter;
    //++iter;
    iter=getNext( objs );
    CPPUNIT_ASSERT_MESSAGE( "obj 1.1 payload",
                            dummyPayload( 0 ) == iter->payload() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.1 since",
                                  (ValidityKey)0, iter->since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.1 until",
                                  (ValidityKey)10, iter->until() );
    //++iter;
    iter = getNext( objs );
    CPPUNIT_ASSERT_MESSAGE( "obj 1.2 payload",
                            dummyPayload( 1 ) == iter->payload() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.2 since",
                                  (ValidityKey)10, iter->since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.2 until",
                                  (ValidityKey)20, iter->until() );
    //++iter;
    iter= getNext( objs );
    CPPUNIT_ASSERT_MESSAGE( "obj 1.3 payload",
                            dummyPayload( 2 ) == iter->payload() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.3 since",
                                  (ValidityKey)20, iter->since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.3 until",
                                  ValidityKeyMax, iter->until() );
  }

  /// Tests that begin returns an iterator pointing at the first item.
  void test_begin()
  {
    fillFolders();
    folder->setPrefetchAll( false );
    try {
      IObjectIteratorPtr objs = folder->browseObjects( 5, 25, 0 );
      CPPUNIT_ASSERT_MESSAGE( "no cursor", objs != 0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "object count", 3u, (unsigned int)objs->size() );
      //IObjectIterator::const_iterator iter = objs->begin();
      if ( !objs->goToNext() )
        CPPUNIT_FAIL("no next object");
      const IObject &obj( objs->currentRef() );
      CPPUNIT_ASSERT_MESSAGE( "obj 1.1 payload",
                              dummyPayload( 0 ) == obj.payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.1 since",
                                    (ValidityKey)0, obj.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.1 until",
                                    (ValidityKey)10, obj.until() );
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests that browseObjects does not fail
  /// (if this fails, test_begin will also fail)
  void test_browseObjects()
  {
    fillFolders();
    folder->setPrefetchAll( false );
    try {
      folder->browseObjects( 5, 25, 0 );
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  // Check that optimized access to CLOBs fails when checkLength
  //
  // This needs internal details of RelationalObjectIterator
  void test_opt_CLOB_fails_without_checkLength_call()
  {
    fillFolders();
    folder->setPrefetchAll( false );
    IObjectIteratorPtr objs = folder->browseObjects( 5, 25, 0 );
    int loop_count = 0;
    TransRelObjectIterator *transIt = dynamic_cast<TransRelObjectIterator*> ( objs.get() );
    if ( !transIt ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectIteratorTest" );  // Fix Coverity FORWARD_NULL
    RelationalObjectIterator *it = dynamic_cast<RelationalObjectIterator*> ( transIt->getIt().get() );
    if ( !it ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectIteratorTest" );  // Fix Coverity FORWARD_NULL
    if ( !it->optimizeClobs() )
    {
      // only test this if clobs are fetched as char 4000...
      return;
    }

    {
      // emulate goToNext()
      // this simplifies goToNext quite a bit...
      // but don't call checkLengthClobs
      it->m_currentObject++;
      CPPUNIT_ASSERT( it->m_cursor->next() );
      // if the following line is enabled the test should failed
      //it->m_queryDef->checkLengthClobs( it->m_dataBuffer.get(), it->m_queryMgr.get() );
      IObjectPtr obj( objs->currentRef().clone() );

      CPPUNIT_ASSERT_MESSAGE( "obj payload without checkLengthClobs",
                              dummyPayload( loop_count ) != obj->payload() );
      loop_count++;
    }
  }

  // check the iterator in iterator functionality for vector folders
  void test_vector_SV()
  {
#ifdef COOL290VP
    folder = s_db->getFolder( "/fSVv" );
    folder->setPrefetchAll( false );
    for ( int i = 0; i < 10; ++i )
    {
      ValidityKey since = i*10;
      ValidityKey until = (i+1)*10;
      std::vector<IRecordPtr> pVector;
      for ( int j=0; j<i; ++j)
        pVector.push_back( IRecordPtr( new Record( dummyPayload( i+j ) ) ) );
      folder->storeObject( since, until, pVector, 0 );
    }

    IObjectIteratorPtr objs = folder->browseObjects( 0, 1000, 0 );
    CPPUNIT_ASSERT_MESSAGE( "no cursor", objs != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "object count", 10u, (unsigned int)objs->size() );

    for ( int i = 0; i < 10; ++i )
    {
      //std::cout << "in object loop " << i << std::endl;
      if ( !objs->goToNext() )
        CPPUNIT_FAIL("no next object");

      const IObject *obj( &objs->currentRef() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.1 since",
                                    (ValidityKey)i*10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.1 until",
                                    (ValidityKey)(i+1)*10, obj->until() );

      for ( int j = 0 ; j < i ; j++ )
      {
        //std::cout << "in payload loop " << j << std::endl;
        if ( !obj->payloadIterator().goToNext() )
          CPPUNIT_FAIL("no next payload");


        CPPUNIT_ASSERT_MESSAGE( "obj 1.1 payload",
                                dummyPayload( i+j ) ==
                                obj->payloadIterator().currentRef() );
      }

      if (  obj->payloadIterator().goToNext() )
        CPPUNIT_FAIL("next payload, but none expected");

      CPPUNIT_ASSERT_EQUAL_MESSAGE( "after payload obj 1.1 since",
                                    (ValidityKey)i*10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "after payload obj 1.1 until",
                                    (ValidityKey)(i+1)*10, obj->until() );

    }
    if (  objs->goToNext() )
      CPPUNIT_FAIL("next object, but none expected");
#endif
  }

  // check the iterator in iterator functionality for vector folders
  void test_vector()
  {
#ifdef COOL290VP
    folder = s_db->getFolder( "/fMVv" );
    folder->setPrefetchAll( false );
    for ( int i = 0; i < 10; ++i )
    {
      ValidityKey since = i*10;
      ValidityKey until = (i+1)*10;
      std::vector<IRecordPtr> pVector;
      for ( int j=0; j<i; ++j)
        pVector.push_back( IRecordPtr( new Record( dummyPayload( i+j ) ) ) );
      folder->storeObject( since, until, pVector, 0 );
    }

    IObjectIteratorPtr objs = folder->browseObjects( 0, 1000, 0 );
    CPPUNIT_ASSERT_MESSAGE( "no cursor", objs != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "object count", 10u, (unsigned int)objs->size() );

    for ( int i = 0; i < 10; ++i )
    {
      //std::cout << "in object loop " << i << std::endl;
      if ( !objs->goToNext() )
        CPPUNIT_FAIL("no next object");

      const IObject *obj( &objs->currentRef() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.1 since",
                                    (ValidityKey)i*10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.1 until",
                                    (ValidityKey)(i+1)*10, obj->until() );

      for ( int j = 0 ; j < i ; j++ )
      {
        //std::cout << "in payload loop " << j << std::endl;
        if ( !obj->payloadIterator().goToNext() )
          CPPUNIT_FAIL("no next payload");


        CPPUNIT_ASSERT_MESSAGE( "obj 1.1 payload",
                                dummyPayload( i+j ) ==
                                obj->payloadIterator().currentRef() );
      }

      if (  obj->payloadIterator().goToNext() )
        CPPUNIT_FAIL("next payload, but none expected");

      CPPUNIT_ASSERT_EQUAL_MESSAGE( "after payload obj 1.1 since",
                                    (ValidityKey)i*10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "after payload obj 1.1 until",
                                    (ValidityKey)(i+1)*10, obj->until() );

    }
    if (  objs->goToNext() )
      CPPUNIT_FAIL("next object, but none expected");
#endif
  }


  // test vector folders, skipping some payloads
  void test_vector_skip_payload()
  {
#ifdef COOL290VP
    folder = s_db->getFolder( "/fMVv" );
    folder->setPrefetchAll( false );
    for ( int i = 0; i < 10; ++i )
    {
      ValidityKey since = i*10;
      ValidityKey until = (i+1)*10;
      std::vector<IRecordPtr> pVector;
      for ( int j=0; j<i; ++j)
        pVector.push_back( IRecordPtr( new Record( dummyPayload( i+j ) ) ) );
      folder->storeObject( since, until, pVector, 0 );
    }

    IObjectIteratorPtr objs = folder->browseObjects( 0, 1000, 0 );
    CPPUNIT_ASSERT_MESSAGE( "no cursor", objs != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "object count", 10u, (unsigned int)objs->size() );

    for ( int i = 0; i < 10; ++i )
    {
      if ( !objs->goToNext() )
        CPPUNIT_FAIL("no next object");

      const IObject *obj( &objs->currentRef() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.1 since",
                                    (ValidityKey)i*10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.1 until",
                                    (ValidityKey)(i+1)*10, obj->until() );

      if ( i % 2 == 0 )
      {
        //std::cout << "skipping payload " << std::endl;
        continue;
      }


      for ( int j = 0 ; j < i ; j++ )
      {
        if ( !obj->payloadIterator().goToNext() )
          CPPUNIT_FAIL("no next payload");


        CPPUNIT_ASSERT_MESSAGE( "obj 1.1 payload",
                                dummyPayload( i+j ) ==
                                obj->payloadIterator().currentRef() );
      }

      if (  obj->payloadIterator().goToNext() )
        CPPUNIT_FAIL("next payload, but none expected");
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "after payload obj 1.1 since",
                                    (ValidityKey)i*10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "after payload obj 1.1 until",
                                    (ValidityKey)(i+1)*10, obj->until() );

    }
    if (  objs->goToNext() )
      CPPUNIT_FAIL("next object, but none expected");
#endif
  }




  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  // Constructor (executed N times, _before_ all N test executions)
  RelationalObjectIteratorTest() : CoolDBUnitTest(), payloadSpec()
  {
    payloadSpec.extend("I",StorageType::Int32);
    payloadSpec.extend("S",StorageType::String255);
    payloadSpec.extend("X",StorageType::Float);
    payloadSpec.extend("CLOB",StorageType::String64k);
  }

  // Destructor (executed N times, _after_ all N test executions)
  ~RelationalObjectIteratorTest()
  {
  }

private:

  RecordSpecification payloadSpec;
  IFolderPtr folder;

  // Setup (executed N times, at the start of each test execution)
  void coolUnitTest_setUp()
  {
    try
    {
      if ( !s_db )
      {
        createDB();
        openDB();
        createFolders();
      }
      else
      {
        refreshDB( true ); // refresh folders too
        openDB();
      }
      folder = s_db->getFolder( "/fSV" );
    }
    catch ( std::exception& e )
    {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  // TearDown (executed N times, at the end of each test execution)
  void coolUnitTest_tearDown()
  {
  }

  /// Creates a dummy payload AttributeList for a given index
  Record dummyPayload( int index )
  {
    Record payload( payloadSpec );
    payload["I"].setValue<Int32>( index );
    std::stringstream s;
    s << "Object " << index;
    payload["S"].setValue<String255>( s.str() );
    payload["X"].setValue<Float>( (float)(index/1000.) );
    payload["CLOB"].setValue<String64k>( s.str() );
    return payload;
  }

  // Create all folders
  void createFolders()
  {
    // Create the SV folder
    FolderSpecification fSv( FolderVersioning::SINGLE_VERSION, payloadSpec );
    s_db->createFolder( "/fSV", fSv, "SV folder" );
#ifdef COOL290VP
    // Create the MV folder with vector payload
    FolderSpecification fmMv( FolderVersioning::MULTI_VERSION, payloadSpec, PayloadMode::VECTORPAYLOAD );
    s_db->createFolder( "/fMVv", fmMv, "MV folder with vector payload" );
    // Create the SV folder with vector payload
    FolderSpecification fmSv( FolderVersioning::SINGLE_VERSION, payloadSpec, PayloadMode::VECTORPAYLOAD );
    s_db->createFolder( "/fSVv", fmSv, "SV folder with vector payload" );
#endif
  }

  // Store new IOVs into the folders
  void fillFolders()
  {
    folder = s_db->getFolder( "/fSV" );
    for ( int i = 0; i < 3; ++i )
    {
      ValidityKey since = i*10;
      ValidityKey until = ValidityKeyMax;
      Record payload = dummyPayload( i );
      folder->storeObject( since, until, payload, 0 );
    }
  }

};

CPPUNIT_TEST_SUITE_REGISTRATION( cool::RelationalObjectIteratorTest );

COOLTEST_MAIN( RelationalObjectIteratorTest )
