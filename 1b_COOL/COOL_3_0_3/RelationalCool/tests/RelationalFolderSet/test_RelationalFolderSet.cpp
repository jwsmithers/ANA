
// Include files
#include <iostream>
#include <string>
#include <vector>
#include "CoolKernel/FolderSpecification.h"
#include "CoolKernel/IDatabase.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/IFolder.h"
#include "CoolKernel/IFolderSet.h"
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordSpecification.h"
#include "CoolKernel/types.h"
#include "CoralBase/AttributeList.h"
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
  class RelationalFolderSetTest;
}

// The test class
class cool::RelationalFolderSetTest : public cool::CoolDBUnitTest
{

private:

  CPPUNIT_TEST_SUITE( RelationalFolderSetTest );
  CPPUNIT_TEST( test_getFolderSet );
  CPPUNIT_TEST( test_listFolders );
  CPPUNIT_TEST( test_listFolderSets );
  CPPUNIT_TEST( test_setDescription );
  CPPUNIT_TEST( test_dropNode_nonempty_folderset );
  CPPUNIT_TEST( test_setTagDescription );
  CPPUNIT_TEST( test_setTagDescription_bug33989 );
  CPPUNIT_TEST_SUITE_END();

public:

  // Test for bug #33989
  void test_setTagDescription_bug33989()
  {
    IFolderSetPtr fsetroot = s_db->getFolderSet("/");
    s_db->createFolderSet("/A");
    FolderSpecification fSpec( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec );
    IFolderPtr f = s_db->createFolder( "/A/f1", fSpec, "" );
    f->storeObject(0, 2, dummyPayload(0), 0);
    f->tagCurrentHead("F1");
    f->createTagRelation("A", "F1");
    try
    {
      f->setTagDescription("A", "new desc"); // should fail!
      CPPUNIT_FAIL( "setTagDescription from child should fail!" );
    }
    catch( Exception& /*e*/ ) {}
    try
    {
      fsetroot->setTagDescription("A", "new desc"); // should fail!
      CPPUNIT_FAIL( "setTagDescription from parent should fail!" );
    }
    catch( Exception& /*e*/ ) {}
  }

  // Tests setTagDescription
  void test_setTagDescription()
  {
    IFolderSetPtr fsetroot = s_db->getFolderSet("/");
    IFolderSetPtr fset = s_db->createFolderSet("/A");
    FolderSpecification fSpec( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec );
    IFolderPtr f = s_db->createFolder( "/A/f1", fSpec, "" );
    f->storeObject(0, 2, dummyPayload(0), 0);
    f->tagCurrentHead("F1");
    f->createTagRelation("A", "F1");
    CPPUNIT_ASSERT_EQUAL(std::string(""), fset->tagDescription("A"));
    //f->setTagDescription("A", "new desc"); // should fail!
    fset->setTagDescription("A", "new desc");
    CPPUNIT_ASSERT_EQUAL(std::string("new desc"), fset->tagDescription("A"));
    fset->createTagRelation("ROOT", "A");
    CPPUNIT_ASSERT_EQUAL(std::string(""), fsetroot->tagDescription("ROOT"));
    //f->setTagDescription("ROOT", "new desc2"); // should fail!
    fsetroot->setTagDescription("ROOT", "new desc2");
    CPPUNIT_ASSERT_EQUAL(std::string("new desc2"),
                         fsetroot->tagDescription("ROOT"));
  }

  /// Tests behavior of dropNode being called on a nonempty folder set
  void test_dropNode_nonempty_folderset()
  {
    // Test dropping with a contained folderset
    s_db->createFolderSet( "/folderset_1" );
    s_db->createFolderSet( "/folderset_1/folderset_1" );
    try {
      s_db->dropNode( "/folderset_1" );
    } catch ( Exception& e ) {
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "error message (containing folderset)",
          std::string( "Cannot drop folderset '/folderset_1', "
                       "because it is not empty" ),
          std::string( e.what() ) );
    }
    // Test dropping with a contained folder
    s_db->createFolderSet( "/folderset_2" );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    s_db->createFolder( "/folderset_2/folder", fSpec );
    try {
      s_db->dropNode( "/folderset_2" );
    } catch ( Exception& e ) {
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "error message (containing folderset)",
          std::string( "Cannot drop folderset '/folderset_2', "
                       "because it is not empty" ),
          std::string( e.what() ) );
    }
  }

  /// Tests updating the folder description
  void test_setDescription()
  {
    {
      IFolderSetPtr folderset = s_db->createFolderSet( "/myfolderset",
                                                       "a description" );
      folderset->setDescription( "new description" );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "internal desc update",
                                    std::string( "new description" ),
                                    folderset->description() );
    }
    {
      IFolderSetPtr folderset =s_db->getFolderSet( "/myfolderset" );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "db desc update",
                                    std::string( "new description" ),
                                    folderset->description() );
    }
  }

  /// Tests listFolderSets
  void test_listFolderSets() {
    try {
      IFolderSetPtr folderset =s_db->createFolderSet( "/folderset" );
      s_db->createFolderSet( "/folderset/folderset_2" );
      s_db->createFolderSet( "/folderset/folderset_3" );
      s_db->createFolderSet( "/folderset/folderset_1" );
      FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
      s_db->createFolder( "/folderset/folder", fSpec );
      bool ascending = true;
      std::vector<std::string> foldersets = folderset->listFolderSets( ascending );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "folderset count", 3u, (unsigned int)foldersets.size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "folderset_1", std::string( "/folderset/folderset_1" ), foldersets[0] );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "folderset_2", std::string( "/folderset/folderset_2" ), foldersets[1] );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "folderset_3", std::string( "/folderset/folderset_3" ), foldersets[2] );
      ascending = false;
      foldersets = folderset->listFolderSets( ascending );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "folderset_1", std::string( "/folderset/folderset_3" ), foldersets[0] );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "folderset_2", std::string( "/folderset/folderset_2" ), foldersets[1] );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "folderset_3", std::string( "/folderset/folderset_1" ), foldersets[2] );
    } catch ( std::exception& e ) {
      std::cout << e.what() << std::endl;
      throw;
    }
  }

  /// Tests listFolders
  void test_listFolders()
  {
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    try
    {
      IFolderSetPtr folderset =s_db->createFolderSet( "/folderset" );
      s_db->createFolder( "/folderset/folder_2", fSpec );
      s_db->createFolder( "/folderset/folder_3", fSpec );
      s_db->createFolder( "/folderset/folder_1", fSpec );
      s_db->createFolderSet( "/folderset/folderset" );
      bool ascending = true;
      std::vector<std::string> folders = folderset->listFolders( ascending );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "folder count", 3u, (unsigned int)folders.size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "folder_1", std::string( "/folderset/folder_1" ), folders[0] );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "folder_2", std::string( "/folderset/folder_2" ), folders[1] );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "folder_3", std::string( "/folderset/folder_3" ), folders[2] );
      ascending = false;
      folders = folderset->listFolders( ascending );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "folder_1", std::string( "/folderset/folder_3" ), folders[0] );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "folder_2", std::string( "/folderset/folder_2" ), folders[1] );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "folder_3", std::string( "/folderset/folder_1" ), folders[2] );
    } catch ( std::exception& e ) {
      std::cout << e.what() << std::endl;
      throw;
    }
  }

  /// Tests creating and retrieving a folderset.
  void test_getFolderSet()
  {
    try
    {
      s_db->createFolderSet( "/folderset", "a description" );
      IFolderSetPtr folderset =s_db->getFolderSet( "/folderset" );
      CPPUNIT_ASSERT( folderset.get() != 0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "name", std::string( "/folderset" ), folderset->fullPath() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "description", std::string( "a description" ), folderset->description() );
      CPPUNIT_ASSERT_MESSAGE
        ( "isLeaf", ! folderset->isLeaf() );
      CPPUNIT_ASSERT_MESSAGE
        ( "isStored", folderset->isStored() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "insertionTime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
          timeToString(folderset->insertionTime()).size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "id", 1u, folderset->id() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "parentId", 0u, folderset->parentId() );
    } catch ( Exception& e ) {
      std::cout << e.what() << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  // Constructor (executed N times, _before_ all N test executions)
  RelationalFolderSetTest() : cool::CoolDBUnitTest(), payloadSpec()
  {
    payloadSpec.extend("I",cool_StorageType_TypeId::Int32);
    payloadSpec.extend("S",cool_StorageType_TypeId::String255);
    payloadSpec.extend("X",cool_StorageType_TypeId::Float);
  }

  // Destructor (executed N times, _after_ all N test executions)
  ~RelationalFolderSetTest()
  {
  }

private:

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
        //createFolders();
      }
      else
      {
        refreshDB();
        //refreshDB( true ); // refresh folders too
        openDB();
      }
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

CPPUNIT_TEST_SUITE_REGISTRATION( cool::RelationalFolderSetTest );

COOLTEST_MAIN( RelationalFolderSetTest )
