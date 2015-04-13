// $Id: test_RelationalObjectSet.cpp,v 1.29 2013-03-08 11:44:45 avalassi Exp $

// Include files
#include <iostream>
#include <string>
#include <cppunit/extensions/HelperMacros.h>
#include "CoolKernel/FolderSpecification.h"
#include "CoolKernel/IDatabase.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/IFolder.h"
#include "CoolKernel/IObject.h"
#include "CoolKernel/IObjectIterator.h"
#include "CoolKernel/types.h"
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordSpecification.h"
#include "CoralBase/Attribute.h"

// Local include files
//#define COOLUNITTESTTIMER 1
//#define COOLDBUNITTESTDEBUG 1
#include "tests/Common/CoolDBUnitTest.h"
#include "src/CoralApplication.h"
#include "src/RalDatabaseSvc.h"
#include "src/timeToString.h"

// Forward declaration (for easier indentation)
namespace cool
{
  class ObjectSetTest;
}

// The test class
class cool::ObjectSetTest : public cool::CoolDBUnitTest
{

private:

  CPPUNIT_TEST_SUITE( ObjectSetTest );
  CPPUNIT_TEST( test_begin );
  CPPUNIT_TEST( test_iterator_prefix_increment );
  CPPUNIT_TEST( test_end );
  CPPUNIT_TEST( test_iterator_equality );
  CPPUNIT_TEST( test_iterator_copy_constructor );
  CPPUNIT_TEST_SUITE_END();

public:

  // Tests that iterator copies are equal and iterate independently.
  void test_iterator_copy_constructor()
  {
    folder->setPrefetchAll( true );
    IObjectVectorPtr objs =
      folder->browseObjects( 5, 25, 0 )->fetchAllAsVector();
    IObjectVector::const_iterator iter = objs->begin();
    IObjectVector::const_iterator
      iter_copy = IObjectVector::const_iterator( iter );
    CPPUNIT_ASSERT_MESSAGE( "iter_copy before increment",
                            dummyPayload( 0 ) == (*iter_copy)->payload() );
    ++iter;
    CPPUNIT_ASSERT_MESSAGE( "iter after after first increment",
                            dummyPayload( 1 ) == (*iter)->payload() );
    CPPUNIT_ASSERT_MESSAGE( "iter_copy after first increment",
                            dummyPayload( 0 ) == (*iter_copy)->payload() );
    ++iter_copy;
    CPPUNIT_ASSERT_MESSAGE( "iter after second increment",
                            dummyPayload( 1 ) == (*iter)->payload() );
    CPPUNIT_ASSERT_MESSAGE( "iter_copy after second increment",
                            dummyPayload( 1 ) == (*iter_copy)->payload() );
  }


  /// Tests const_iterator::operator==.
  void test_iterator_equality()
  {
    folder->setPrefetchAll( true );
    IObjectVectorPtr objs =
      folder->browseObjects( 5, 25, 0 )->fetchAllAsVector();
    IObjectVector::const_iterator i1 = objs->begin();
    IObjectVector::const_iterator i2 = objs->begin();
    CPPUNIT_ASSERT_MESSAGE( "before increment", i1 == i2 );
    ++i1;
    CPPUNIT_ASSERT_MESSAGE( "iter after i1 increment", i1 != i2 );
    ++i2;
    CPPUNIT_ASSERT_MESSAGE( "iter after i2 increment", i1 == i2 );
  }


  /// Tests that the iterator correctly points at the end after the container
  /// has been exhausted.
  void test_end()
  {
    folder->setPrefetchAll( true );
    IObjectVectorPtr objs =
      folder->browseObjects( 5, 25, 0 )->fetchAllAsVector();
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "object count", 3ul, (unsigned long)objs->size() );
    IObjectVector::const_iterator iter = objs->begin();
    ++iter;
    ++iter;
    ++iter;
    CPPUNIT_ASSERT_MESSAGE
      ( "Iterator pointing at end", iter == objs->end() );
  }


  /// Tests that prefix operator++ correctly iterates through the container.
  void test_iterator_prefix_increment()
  {
    folder->setPrefetchAll( true );
    IObjectVectorPtr objs =
      folder->browseObjects( 5, 25, 0 )->fetchAllAsVector();
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "object count", 3ul, (unsigned long)objs->size() );
    IObjectVector::const_iterator iter = objs->begin();
    CPPUNIT_ASSERT_MESSAGE( "obj 1.1 payload",
                            dummyPayload( 0 ) == (*iter)->payload() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.1 since",
                                  (ValidityKey)0, (*iter)->since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.1 until",
                                  (ValidityKey)10, (*iter)->until() );
    ++iter;
    CPPUNIT_ASSERT_MESSAGE( "obj 1.2 payload",
                            dummyPayload( 1 ) == (*iter)->payload() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.2 since",
                                  (ValidityKey)10, (*iter)->since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.2 until",
                                  (ValidityKey)20, (*iter)->until() );
    ++iter;
    CPPUNIT_ASSERT_MESSAGE( "obj 1.3 payload",
                            dummyPayload( 2 ) == (*iter)->payload() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.3 since",
                                  (ValidityKey)20, (*iter)->since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.3 until",
                                  ValidityKeyMax, (*iter)->until() );
  }


  /// Tests that begin returns an iterator pointing to the first item.
  void test_begin()
  {
    folder->setPrefetchAll( true );
    IObjectVectorPtr objs =
      folder->browseObjects( 5, 25, 0 )->fetchAllAsVector();
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "object count", 3ul, (unsigned long)objs->size() );
    IObjectVector::const_iterator iter = objs->begin();
    CPPUNIT_ASSERT_MESSAGE( "obj 1.1 payload",
                            dummyPayload( 0 ) == (*iter)->payload() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.1 since",
                                  (ValidityKey)0, (*iter)->since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.1 until",
                                  (ValidityKey)10, (*iter)->until() );
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  // Constructor (executed N times, _before_ all N test executions)
  ObjectSetTest() : CoolDBUnitTest(), payloadSpec()
  {
    payloadSpec.extend("I",StorageType::Int32);
    payloadSpec.extend("S",StorageType::String255);
    payloadSpec.extend("X",StorageType::Float);
  }

  // Destructor (executed N times, _after_ all N test executions)
  ~ObjectSetTest()
  {
  }

private:

  IFolderPtr folder;
  RecordSpecification payloadSpec;

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
        // Do nothing! All tests are RO: create and fill folders only once!
      }
      openDB( false ); // reopen in RO mode
      std::string folderName( "/folder_1" );
      folder = s_db->getFolder( folderName );
    }
    catch ( std::exception& e )
    {
      std::cout << "Exception caught in setUp: " << e.what() << std::endl;
      throw;
    }
  }

  // TearDown (executed N times, at the end of each test execution)
  void coolUnitTest_tearDown()
  {
  }

  // Create all folders (overloads virtual base method)
  void createFolders()
  {
    std::string folderName( "/folder_1" );
    FolderSpecification fSpec( FolderVersioning::SINGLE_VERSION, payloadSpec );
    folder = s_db->createFolder( folderName, fSpec );
    for ( int i = 0; i < 3; ++i )
    {
      ValidityKey since = i*10;
      ValidityKey until = ValidityKeyMax;
      Record payload = dummyPayload( i );
      folder->storeObject( since, until, payload, 0 );
    }
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
    return payload;
  }

};

CPPUNIT_TEST_SUITE_REGISTRATION( cool::ObjectSetTest );

COOLTEST_MAIN( ObjectSetTest )
