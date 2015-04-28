
// Include files
#include <iostream>
#include "CoolKernel/FolderSpecification.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/IDatabase.h"
#include "CoolKernel/IFolder.h"
#include "CoolKernel/IFolderSet.h"
#include "CoolKernel/IObject.h"
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordSpecification.h"
#include "CoolKernel/Time.h"
#include "CoralBase/Attribute.h"
#include "CoralBase/MessageStream.h"

// Local include files
//#define COOLUNITTESTTIMER 1
//#define COOLDBUNITTESTDEBUG 1
#include "tests/Common/CoolDBUnitTest.h"
#include "src/CoralApplication.h"
#include "src/RalDatabase.h"
#include "src/RalDatabaseSvc.h"

// Forward declaration (for easier indentation)
namespace cool
{
  class HvsTagTest;
}

// The test class
class cool::HvsTagTest : public cool::CoolDBUnitTest
{

private:

  CPPUNIT_TEST_SUITE( HvsTagTest );
  CPPUNIT_TEST( test_hvsTags );
  CPPUNIT_TEST( test_iovHeadAndUserTags );
  CPPUNIT_TEST( test_iovAndHvsTags );
  CPPUNIT_TEST( test_userAndHvsTags );
  CPPUNIT_TEST( test_hvsAndIovTags );
  CPPUNIT_TEST( test_hvsAndUserTags );
  CPPUNIT_TEST( test_createParentsTrue ); // DDL
  CPPUNIT_TEST( test_createParentsFalse ); // DDL
  CPPUNIT_TEST( test_svFolder );
  CPPUNIT_TEST( test_listTags );
  CPPUNIT_TEST( test_resolveLocalTag );
  CPPUNIT_TEST( test_resolveTagFails );
  CPPUNIT_TEST( test_tagRelationExists );
  CPPUNIT_TEST( test_lockTag_fails );
  CPPUNIT_TEST( test_tagLocked_dropNode ); //DDL
  CPPUNIT_TEST( test_tagLocked_storeObjectWithUserTag );
  CPPUNIT_TEST( test_tagLocked_tagCurrentHead );
  CPPUNIT_TEST( test_tagLocked_tagHeadAsOfDate );
  CPPUNIT_TEST( test_tagLocked_deleteTag );
  CPPUNIT_TEST( test_tagLocked_createTagRelation );
  CPPUNIT_TEST( test_tagLocked_deleteTagRelation );
  CPPUNIT_TEST( test_partiallyLockTag_fails );
  CPPUNIT_TEST( test_tagPartiallyLocked_dropNode ); // DDL
  CPPUNIT_TEST( test_tagPartiallyLocked_storeObjectWithUserTag );
  CPPUNIT_TEST( test_tagPartiallyLocked_tagCurrentHead );
  CPPUNIT_TEST( test_tagPartiallyLocked_tagHeadAsOfDate );
  CPPUNIT_TEST( test_tagPartiallyLocked_deleteTag );
  CPPUNIT_TEST( test_tagPartiallyLocked_createTagRelation );
  CPPUNIT_TEST( test_tagPartiallyLocked_deleteTagRelation );
  CPPUNIT_TEST( test_tagPartiallyLocked_storeObjectWithUserTagNoOverlap );
  CPPUNIT_TEST( test_emptyTag );
  CPPUNIT_TEST_SUITE_END();

public:

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_hvsTags()
  {
    try {
      // Node hierarchy
      // -> fldset /
      // -> fldset /A
      // -> folder /A/mX
      // -> folder /A/mY
      IFolderSetPtr sA  = s_db->getFolderSet( "/A" );
      IFolderPtr fAX = getAndFillFolder( "/A/mX" );
      IFolderPtr fAY = getAndFillFolder( "/A/mY" );
      // Tag hierarchy for "/A    version #1"
      // -> fldset '/A    version #1'
      // -> folder '/A/mX version #1'
      // -> folder '/A/mY version #1'
      std::string tA_1  = "/A    version #1";
      std::string tAX_1 = "/A/mX version #1";
      std::string tAY_1 = "/A/mY version #1";
      fAX->createTagRelation( tA_1,  tAX_1 );
      fAY->createTagRelation( tA_1,  tAY_1 );
      // Query parent-child tag relations
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Find /A/mX tag for " + tA_1, tAX_1, fAX->findTagRelation( tA_1 ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Find /A/mY tag for " + tA_1, tAY_1, fAY->findTagRelation( tA_1 ) );
      // Tag hierarchy for "/A    version #2"
      // -> fldset '/A    version #2'
      // -> folder '/A/mX version #2'
      // -> folder '/A/mY version #2'
      std::string tA_2  = "/A    version #2";
      std::string tAX_2 = "/A/mX version #2";
      std::string tAY_2 = "/A/mY version #2";
      fAX->createTagRelation( tA_2,  tAX_2 );
      fAY->createTagRelation( tA_2,  tAY_2 );
      // Query parent-child tag relations
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Find /A/mX tag for " + tA_2, tAX_2, fAX->findTagRelation( tA_2 ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Find /A/mY tag for " + tA_2, tAY_2, fAY->findTagRelation( tA_2 ) );
      // Tag hierarchy for "/     version PROD"
      // -> fldset '/     version PROD'
      // -> fldset '/A    version PROD'
      // -> folder '/A/mX version #2'
      // -> folder '/A/mY version #1'
      std::string tA_PR = "/A    version PROD";
      std::string t_PR  = "/     version PROD";
      // Test existance of tags in any node
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + tA_PR + " exist?", false, s_db->existsTag( tA_PR ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + t_PR + " exist?", false, s_db->existsTag( t_PR ) );
      // Create tag relations for /A PROD version
      fAX->createTagRelation( tA_PR, tAX_2 );
      fAY->createTagRelation( tA_PR, tAY_1 );
      // Test existance of tags in any node
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + tA_PR + " exist?", true, s_db->existsTag( tA_PR ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + t_PR + " exist?", false, s_db->existsTag( t_PR ) );
      // Create tag relations for / PROD version
      sA->createTagRelation(  t_PR,  tA_PR );
      // Test existance of tags in any node
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + tA_PR + " exist?", true, s_db->existsTag( tA_PR ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + t_PR + " exist?", true, s_db->existsTag( t_PR ) );
      // Query parent-child tag relations
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Find /A/mX tag for " + tA_PR,
          tAX_2, fAX->findTagRelation( tA_PR ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Find /A/mY tag for " + tA_PR,
          tAY_1, fAY->findTagRelation( tA_PR ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Find /A tag for " + t_PR, tA_PR, sA->findTagRelation( t_PR ) );
      // Resolve parent-child tag relations (w/o assuming parent-child nodes)
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Find /A/mX tag for " + tA_PR, tAX_2, fAX->resolveTag( tA_PR ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Find /A/mY tag for " + tA_PR, tAY_1, fAY->resolveTag( tA_PR ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Find /A tag for " + t_PR, tA_PR, sA->resolveTag( t_PR ) );
      // Resolve ancestor-descendant tag relations
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Find /A/mX tag for " + t_PR, tAX_2, fAX->resolveTag( t_PR ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Find /A/mY tag for " + t_PR, tAY_1, fAY->resolveTag( t_PR ) );
      // Test existance of tags in any node
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + tA_PR + " exist?", true, s_db->existsTag( tA_PR ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + t_PR + " exist?", true, s_db->existsTag( t_PR ) );
      // Delete tag relation for / PROD version
      sA->deleteTagRelation( t_PR );
      // Test existance of tag relation
      try {
        sA->findTagRelation( t_PR );
        CPPUNIT_FAIL( "Find /A tag for " + t_PR + " should fail" );
      }
      catch ( TagNotFound& ) {}
      catch ( TagRelationNotFound& ) {
        CPPUNIT_FAIL( "Find /A tag for " + t_PR + " TagNotFound expected" );
      }
      // Test existance of tags in any node
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + tA_PR + " exist?", true, s_db->existsTag( tA_PR ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + t_PR + " exist?", false, s_db->existsTag( t_PR ) );
      // Create tag relations for / PROD version - again
      sA->createTagRelation(  t_PR,  tA_PR );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Find /A tag for " + t_PR, tA_PR, sA->findTagRelation( t_PR ) );
      // Delete tag relation for / PROD version - again
      sA->deleteTagRelation( t_PR );
      try {
        sA->findTagRelation( t_PR );
        CPPUNIT_FAIL( "Find /A tag for " + t_PR + " should fail" );
      }
      catch ( TagNotFound& ) {}
      catch ( TagRelationNotFound& ) {
        CPPUNIT_FAIL( "Find /A tag for " + t_PR + " TagNotFound expected" );
      }
      // Test existance of tags in any node
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + tA_PR + " exist?", true, s_db->existsTag( tA_PR ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + t_PR + " exist?", false, s_db->existsTag( t_PR ) );
      // Delete /A/mX tag relation for /A PROD version
      fAX->deleteTagRelation( tA_PR );
      try {
        fAX->findTagRelation( tA_PR );
        CPPUNIT_FAIL( "Find /A/mX tag for " + tA_PR + " should fail" );
      }
      catch ( TagRelationNotFound& ) {}
      // Test existance of tags in any node
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + tAX_2 + " exist?", true, s_db->existsTag( tAX_2 ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + tA_PR + " exist?", true, s_db->existsTag( tA_PR ) );
      // Delete /A/mY tag relation for /A PROD version
      fAY->deleteTagRelation( tA_PR );
      try {
        fAY->findTagRelation( tA_PR );
        CPPUNIT_FAIL( "Find /A/mY tag for " + tA_PR + " should fail" );
      }
      catch ( TagNotFound& ) {}
      catch ( TagRelationNotFound& ) {
        CPPUNIT_FAIL( "Find /A/mY tag for " + t_PR + " TagNotFound expected" );
      }
      // Test existance of tags in any node
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + tAY_1 + " exist?", true, s_db->existsTag( tAY_1 ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + tA_PR + " exist?", false, s_db->existsTag( tA_PR ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + tA_1 + " exist?", true, s_db->existsTag( tA_1 ) );
      // Delete /A/mY tag relation for /A version #1
      fAY->deleteTagRelation( tA_1 );
      try {
        fAY->findTagRelation( tA_1 );
        CPPUNIT_FAIL( "Find /A/mY tag for " + tA_1 + " should fail" );
      }
      catch ( TagRelationNotFound& ) {}
      // Test existance of tags in any node
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + tAY_1 + " exist?", false, s_db->existsTag( tAY_1 ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + tA_1 + " exist?", true, s_db->existsTag( tA_1 ) );
      // Attempt to create tag relation between two tags in "/" (bug #35891)
      IFolderSetPtr sROOT = s_db->getFolderSet( "/" );
      std::string t_1 = "dummy version #1";
      std::string t_2 = "dummy version #2";
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + t_1 + " exist?", false, s_db->existsTag( t_1 ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + t_2 + " exist?", false, s_db->existsTag( t_2 ) );
      CPPUNIT_ASSERT_THROW
        ( sROOT->createTagRelation( t_1,  t_2 ), InvalidTagRelation );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + t_1 + " exist?", false, s_db->existsTag( t_1 ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + t_2 + " exist?", false, s_db->existsTag( t_2 ) );
      // Attempt to create tag relation between the same tag in "/A" and "/"
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + t_1 + " exist?", false, s_db->existsTag( t_1 ) );
      CPPUNIT_ASSERT_THROW
        ( sA->createTagRelation( t_1,  t_1 ), InvalidTagRelation );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Does tag " + t_1 + " exist?", false, s_db->existsTag( t_1 ) );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_iovHeadAndUserTags()
  {
    bool debug = false;
    try {
      // Folder /A/mX
      if ( debug ) std::cout << "Test A" << std::endl;
      IFolderPtr fa = getAndFillFolder( "/A/mX" );
      std::string ah1 = "AH1";
      std::string ad1 = "AD1";
      std::string au1 = "AU1";
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "1 Exst "+ah1, false, s_db->existsTag(ah1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "1 Exst "+ad1, false, s_db->existsTag(ad1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "1 Exst "+au1, false, s_db->existsTag(au1) );
      if ( debug ) std::cout << "Test A count AH1" << std::endl;
      CPPUNIT_ASSERT_THROW
        ( fa->countObjects(0,100,0,ah1), TagNotFound );
      if ( debug ) std::cout << "Test A count AD1" << std::endl;
      CPPUNIT_ASSERT_THROW
        ( fa->countObjects(0,100,0,ad1), TagNotFound );
      if ( debug ) std::cout << "Test A count AU1" << std::endl;
      CPPUNIT_ASSERT_THROW
        ( fa->countObjects(0,100,0,au1), TagNotFound );
      // - create AH1 as IOV head tag
      //   > using AH1 as IOV date tag fails
      //   > using AH1 as IOV user tag fails
      if ( debug ) std::cout << "Test AH1" << std::endl;
      fa->tagCurrentHead( ah1 );
      Time date = fa->findObject( 20, 0 )->insertionTime();
      Record payload = dummyPayload( 10 );
      try {
        fa->tagHeadAsOfDate( date, ah1 );
        CPPUNIT_FAIL( "Using AH1 as date tag should fail" );
      } catch ( TagExists& ) {}
      try {
        fa->storeObject( 5, 15, payload, 0, ah1 );
        CPPUNIT_FAIL( "Using AH1 as user tag should fail" );
      } catch ( TagExists& ) {}
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "2 Exst "+ah1, true, s_db->existsTag(ah1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "2 Exst "+ad1, false, s_db->existsTag(ad1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "2 Exst "+au1, false, s_db->existsTag(au1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "2 # "+ah1, 3u, fa->countObjects(0,100,0,ah1) );
      CPPUNIT_ASSERT_THROW
        ( fa->countObjects(0,100,0,ad1), TagNotFound );
      CPPUNIT_ASSERT_THROW
        ( fa->countObjects(0,100,0,au1), TagNotFound );
      // - create AD1 as IOV date tag
      //   > using AD1 as IOV head tag fails
      //   > using AD1 as IOV user tag fails
      if ( debug ) std::cout << "Test AD1" << std::endl;
      fa->tagHeadAsOfDate( date, ad1 );
      try {
        fa->tagCurrentHead( ad1 );
        CPPUNIT_FAIL( "Using AD1 as head tag should fail" );
      } catch ( TagExists& ) {}
      try {
        fa->storeObject( 5, 15, payload, 0, ad1 );
        CPPUNIT_FAIL( "Using AD1 as user tag should fail" );
      } catch ( TagExists& ) {}
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "3 Exst "+ah1, true, s_db->existsTag(ah1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "3 Exst "+ad1, true, s_db->existsTag(ad1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "3 Exst "+au1, false, s_db->existsTag(au1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "3 # "+ah1, 3u, fa->countObjects(0,100,0,ah1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "3 # "+ad1, 3u, fa->countObjects(0,100,0,ad1) );
      CPPUNIT_ASSERT_THROW
        ( fa->countObjects(0,100,0,au1), TagNotFound );
      // - create AU1 as IOV user tag
      //   > using AU1 as IOV head tag fails
      //   > using AU1 as IOV date tag fails
      if ( debug ) std::cout << "Test AU1" << std::endl;
      fa->storeObject( 5, 15, payload, 0, au1 );
      try {
        fa->tagCurrentHead( au1 );
        CPPUNIT_FAIL( "Using AU1 as head tag should fail" );
      } catch ( TagExists& ) {}
      try {
        fa->tagHeadAsOfDate( date, au1 );
        CPPUNIT_FAIL( "Using AU1 as date tag should fail" );
      } catch ( TagExists& ) {}
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "4 Exst "+ah1, true, s_db->existsTag(ah1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "4 Exst "+ad1, true, s_db->existsTag(ad1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "4 Exst "+au1, true, s_db->existsTag(au1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "4 # "+ah1, 3u, fa->countObjects(0,100,0,ah1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "4 # "+ad1, 3u, fa->countObjects(0,100,0,ad1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "4 # "+au1, 1u, fa->countObjects(0,100,0,au1) );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_iovAndHvsTags()
  {
    try {
      Record payload = dummyPayload( 10 );
      // Folder /A/mX
      // - create A1 as IOV head tag
      //   > using A1 as IOV user tag fails
      // - create A1 as HVS tag (create relation)
      // - delete A1 as IOV tag
      // - delete A1 as HVS tag (delete relation)
      IFolderPtr fa = getAndFillFolder( "/A/mX" );
      std::string prod = "PROD";
      std::string a1 = "A1";
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_THROW( fa->countObjects(0,100,0,a1), TagNotFound );
      fa->tagCurrentHead( a1 );
      try {
        fa->storeObject( 5, 15, payload, 0, a1 );
        CPPUNIT_FAIL( "Using A1 as user tag should fail" );
      } catch ( TagExists& ) {}
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 #", 3u, fa->countObjects(0,100,0,a1) );
      fa->createTagRelation( prod, a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 - "+a1, a1, fa->findTagRelation(prod) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 #", 3u, fa->countObjects(0,100,0,a1) );
      // This may be a bit confusing: the tag still exists after being deleted!
      // A better name for this method may be 'untag' (remove IOV2TAG links).
      fa->deleteTag( a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 - "+a1, a1, fa->findTagRelation(prod) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 #", 0u, fa->countObjects(0,100,0,a1) );
      fa->deleteTagRelation( prod );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+a1, false, s_db->existsTag(a1) );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_userAndHvsTags()
  {
    try {
      Record payload = dummyPayload( 10 );
      // Folder /A/mX
      // - create A1 as IOV user tag
      //   > using A1 as IOV head tag fails
      // - create A1 as HVS tag (create relation)
      // - delete A1 as IOV tag
      // - delete A1 as HVS tag (delete relation)
      IFolderPtr fa = getAndFillFolder( "/A/mX" );
      std::string prod = "PROD";
      std::string a1 = "A1";
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_THROW( fa->countObjects(0,100,0,a1), TagNotFound );
      fa->storeObject( 5, 15, payload, 0, a1 );
      try {
        fa->tagCurrentHead( a1 );
        CPPUNIT_FAIL( "Using A1 as head tag should fail" );
      } catch ( TagExists& ) {}
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 #", 1u, fa->countObjects(0,100,0,a1) );
      fa->createTagRelation( prod, a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 - "+a1, a1, fa->findTagRelation(prod) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 #", 1u, fa->countObjects(0,100,0,a1) );
      fa->deleteTag( a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 - "+a1, a1, fa->findTagRelation(prod) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 #", 0u, fa->countObjects(0,100,0,a1) );
      fa->deleteTagRelation( prod );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+a1, false, s_db->existsTag(a1) );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_hvsAndIovTags()
  {
    try {
      Record payload = dummyPayload( 10 );
      // Folder /A/mX
      // - create A1 as HVS tag (create relation)
      // - create A1 as IOV head tag
      //   > using A1 as IOV user tag fails
      // - delete A1 as HVS tag (delete relation)
      // - delete A1 as IOV tag
      IFolderPtr fa = getAndFillFolder( "/A/mX" );
      std::string prod = "PROD";
      std::string a1 = "A1";
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+a1, false, s_db->existsTag(a1) );
      fa->createTagRelation( prod, a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 - "+a1, a1, fa->findTagRelation(prod) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 #", 0u, fa->countObjects(0,100,0,a1) );
      fa->tagCurrentHead( a1 );
      try {
        fa->storeObject( 5, 15, payload, 0, a1 );
        CPPUNIT_FAIL( "Using A1 as user tag should fail" );
      } catch ( TagExists& ) {}
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 #", 3u, fa->countObjects(0,100,0,a1) );
      fa->deleteTagRelation( prod );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 #", 3u, fa->countObjects(0,100,0,a1) );
      try {
        fa->findTagRelation(prod);
        CPPUNIT_FAIL( "Solving the PROD-A1 relation should fail" );
      } catch ( TagNotFound& ) {}
      fa->deleteTag( a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_THROW( fa->countObjects(0,100,0,a1), TagNotFound );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_hvsAndUserTags()
  {
    try {
      Record payload = dummyPayload( 10 );
      // Folder /A/mX
      // - create A1 as HVS tag (create relation)
      // - create A1 as IOV user tag
      //   > using A1 as IOV head tag fails
      // - delete A1 as HVS tag (delete relation)
      // - delete A1 as IOV tag
      IFolderPtr fa = getAndFillFolder( "/A/mX" );
      std::string prod = "PROD";
      std::string a1 = "A1";
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+a1, false, s_db->existsTag(a1) );
      fa->createTagRelation( prod, a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 #", 0u, fa->countObjects(0,100,0,a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 - "+a1, a1, fa->findTagRelation(prod) );
      fa->storeObject( 5, 15, payload, 0, a1 );
      try {
        fa->tagCurrentHead( a1 );
        CPPUNIT_FAIL( "Using A1 as head tag should fail" );
      } catch ( TagExists& ) {}
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 #", 1u, fa->countObjects(0,100,0,a1) );
      fa->deleteTagRelation( prod );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 #", 1u, fa->countObjects(0,100,0,a1) );
      try {
        fa->findTagRelation(prod);
        CPPUNIT_FAIL( "Solving the PROD-A1 relation should fail" );
      } catch ( TagNotFound& ) {}
      fa->deleteTag( a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_THROW( fa->countObjects(0,100,0,a1), TagNotFound );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  /// Tests that the tag sequence table is created for folder sets that are
  /// not automatically generated (control sample for bug #16257)
  void test_createParentsFalse()
  {
    ScopedRecreateFolders theCleaner( this );
    refreshDB(); // drop all nodes before this test
    openDB();
    try
    {
      bool createParents = false;
      s_db->createFolderSet( "/top" );
      FolderSpecification fSpec( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec );
      IFolderPtr fa = s_db->createFolder( "/top/A1", fSpec, "desc", createParents );
      Record payload = dummyPayload( 10 );
      fa->storeObject( 5, 15, payload, 0, "user tag" );
      fa->createTagRelation( "PROD", "user tag" );
      CPPUNIT_ASSERT_EQUAL( std::string("user tag"),
                            fa->resolveTag( "PROD" ) );
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  /// Tests that the tag sequence table is created also for folder sets
  /// that are automatically generated for createParents=true (bug #16257)
  void test_createParentsTrue()
  {
    ScopedRecreateFolders theCleaner( this );
    refreshDB(); // drop all nodes before this test
    openDB();
    try {
      bool createParents = true;
      FolderSpecification fSpec( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec );
      IFolderPtr fa = s_db->createFolder( "/top/A1", fSpec, "desc", createParents );
      Record payload = dummyPayload( 10 );
      fa->storeObject( 5, 15, payload, 0, "user tag" );
      fa->createTagRelation( "PROD", "user tag" );
      CPPUNIT_ASSERT_EQUAL( std::string("user tag"),
                            fa->resolveTag( "PROD" ) );
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_svFolder()
  {
    try {
      // Node hierarchy
      // -> fldset /
      // -> fldset /A
      // -> folder /A/mX
      // -> folder /A/sX
      IFolderPtr fmv  = getAndFillFolder( "/A/mX" );
      IFolderPtr fsv  = getAndFillFolder( "/A/sX" );
      std::string prod = "PROD";
      std::string s1 = "S1";
      std::string m1 = "M1";
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+s1, false, s_db->existsTag(s1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+m1, false, s_db->existsTag(m1) );
      fmv->createTagRelation( prod, m1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+s1, false, s_db->existsTag(s1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+m1, true, s_db->existsTag(m1) );
      try {
        fsv->createTagRelation( prod, s1 );
        CPPUNIT_FAIL( "Creating HVS relation for SV folder should fail" );
      }
      catch ( FolderIsSingleVersion& ) {}
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_listTags()
  {
    try {
      // Node hierarchy
      // -> fldset /
      // -> fldset /A
      // -> folder /A/mX
      // -> folder /A/sX
      IFolderSetPtr sA  = s_db->getFolderSet( "/A" );
      IFolderPtr fAM  = getAndFillFolder( "/A/mX" );
      IFolderPtr fAS  = getAndFillFolder( "/A/sX" );
      // Tag hierarchy for "/A    version #1"
      // -> fldset '/A    version #1'
      // -> folder '/A/mX version #1'
      std::string tA_1  = "/A    version #1";
      std::string tAM_1 = "/A/mX version #1";
      fAM->createTagRelation( tA_1,  tAM_1 );
      // Tag hierarchy for "/A    version #2"
      // -> fldset '/A    version #2'
      // -> folder '/A/mX version #2'
      std::string tA_2  = "/A    version #2";
      std::string tAM_2 = "/A/mX version #2";
      fAM->createTagRelation( tA_2,  tAM_2 );
      // Tag hierarchy for "/     version PROD"
      // -> fldset '/     version PROD'
      // -> fldset '/A    version PROD'
      // -> folder '/A/mX version #1'
      std::string t_PR  = "/     version PROD";
      std::string tA_PR = "/A    version PROD";
      sA->createTagRelation(  t_PR,  tA_PR );
      fAM->createTagRelation( tA_PR, tAM_1 );
      // List tags for MV folder "/A/mX"
      std::vector<std::string> tagsAM = fAM->listTags();
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "/A/mX tag count", 2u, (unsigned int)tagsAM.size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "/A/mX tag 1", tAM_1, tagsAM[0] );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "/A/mX tag 2", tAM_2, tagsAM[1] );
      // List tags for SV folder "/A/sX"
      std::vector<std::string> tagsAS = fAS->listTags();
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "/A/sX tag count", 0u, (unsigned int)tagsAS.size() );
      // List tags for folder set "/A"
      std::vector<std::string> tagsA = sA->listTags();
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "/A tag count", 3u, (unsigned int)tagsA.size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "/A tag 1", tA_1, tagsA[0] );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "/A tag 2", tA_2, tagsA[1] );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "/A tag 3", tA_PR, tagsA[2] );
      // List tags for folder set "/"
      IFolderSetPtr sROOT  = s_db->getFolderSet( "/" );
      std::vector<std::string> tagsROOT = sROOT->listTags();
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "/ tag count", 1u, (unsigned int)tagsROOT.size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "/ tag 1", t_PR, tagsROOT[0] );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  // Test for bug #16566
  void test_resolveLocalTag()
  {
    try
    {
      IFolderPtr f = getAndFillFolder( "/A/mX" );
      std::string folderTag = "local_tag_1";
      std::string folderSetTag = "prod_v1";
      f->tagCurrentHead( folderTag );
      // COOL_1_3_1 exception: "Tag 'local_tag_1' not found in any inner node"
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Resolve (1) " + folderTag,
          folderTag, f->resolveTag( folderTag ) );
      f->createTagRelation( folderSetTag, folderTag );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Resolve (2) " + folderTag,
          folderTag, f->resolveTag( folderTag ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Resolve " + folderSetTag,
          folderTag, f->resolveTag( folderSetTag ) );
      std::vector<std::string> fTags = f->listTags();
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "/folder tag count", 1u, (unsigned int)fTags.size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "/folder tag 1", folderTag, fTags[0] );
      IFolderSetPtr rf = s_db->getFolderSet("/A");
      std::vector<std::string> rfTags = rf->listTags();
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "/ tag count", 1u, (unsigned int)rfTags.size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "/ tag 1", folderSetTag, rfTags[0] );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_resolveTagFails()
  {
    try {
      // Node hierarchy
      // -> fldset /
      // -> fldset /A
      // -> folder /A/mX
      IFolderSetPtr sA  = s_db->getFolderSet( "/A" );
      IFolderPtr fAX  = getAndFillFolder( "/A/mX" );
      // Tag hierarchy for "/     version PROD"
      // -> fldset '/     version PROD'
      // -> fldset '/A    version #1'
      std::string tA_1 = "/A    version #1";
      std::string t_PR = "/     version PROD";
      // Create tag relations for / PROD version
      sA->createTagRelation( t_PR, tA_1 );
      // Test that resolveTag should fail at this stage
      try {
        fAX->resolveTag( t_PR );
        CPPUNIT_FAIL( "Resolve /A/mX tag for " + t_PR + " should fail" );
      }
      catch ( TagRelationNotFound& ) {}
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  // Test for bug #18201
  void test_tagRelationExists()
  {
    try {
      // Node hierarchy
      // -> fldset /
      // -> fldset /A
      IFolderSetPtr sA  = s_db->getFolderSet( "/A" );
      // Tag hierarchy for "/     version PROD"
      // -> fldset '/     version PROD'
      // -> fldset '/A    version #1'
      // OR fldset '/A    version #2'
      std::string tA_1 = "/A    version #1";
      std::string tA_2 = "/A    version #2";
      std::string t_PR = "/     version PROD";
      // Create tag relations for / PROD version
      sA->createTagRelation( t_PR, tA_1 );
      // Test that resolveTag should fail at this stage
      try {
        sA->createTagRelation( t_PR, tA_2 );
        CPPUNIT_FAIL( "Creating tag relation between " + t_PR + " and " + tA_2
                      + " should fail" );
      }
      catch ( TagRelationExists& ) {}
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_lockTag_fails()
  {
    try {
      // Node hierarchy
      // -> fldset /
      // -> fldset /A
      // -> folder /A/mX
      std::string nameA = "/A";
      std::string nameAX = "/A/mX";
      IFolderSetPtr sA  = s_db->getFolderSet( nameA );
      IFolderPtr fAX  = getAndFillFolder( nameAX );
      // Tag hierarchy for "/A    version #1"
      // -> fldset '/A    version #1'
      // -> folder '/A/mX version #1'
      std::string a1  = "/A    version #1";
      std::string x1 = "/A/mX version #1";
      // Attempt to lock tags before they are created fails
      // (fails with private RowNotUpdated exception)
      CPPUNIT_ASSERT_THROW
        ( sA->setTagLockStatus( a1, cool_HvsTagLock_Status::LOCKED ), Exception );
      CPPUNIT_ASSERT_THROW
        ( fAX->setTagLockStatus( x1, cool_HvsTagLock_Status::LOCKED ), Exception );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "1 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "1 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_THROW( sA->tagLockStatus( a1 ), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAX->tagLockStatus( x1 ), TagNotFound );
      // Attempt to lock tags after they are created succeds
      fAX->createTagRelation( a1, x1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "2 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "2 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "2 Locked "+a1,
          (int)cool_HvsTagLock_Status::UNLOCKED, (int)sA->tagLockStatus(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "2 Locked "+x1,
          (int)cool_HvsTagLock_Status::UNLOCKED, (int)fAX->tagLockStatus(x1) );
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::LOCKED );
      fAX->setTagLockStatus( x1, cool_HvsTagLock_Status::LOCKED );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "3 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "3 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "3 Locked "+a1,
          (int)cool_HvsTagLock_Status::LOCKED, (int)sA->tagLockStatus(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "3 Locked "+x1,
          (int)cool_HvsTagLock_Status::LOCKED, (int)fAX->tagLockStatus(x1) );
      // Cleanup - unlock all tags
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::UNLOCKED );
      fAX->setTagLockStatus( x1, cool_HvsTagLock_Status::UNLOCKED );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "4 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "4 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "4 Locked "+a1,
          (int)cool_HvsTagLock_Status::UNLOCKED, (int)sA->tagLockStatus(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "4 Locked "+x1,
          (int)cool_HvsTagLock_Status::UNLOCKED, (int)fAX->tagLockStatus(x1) );
      // Attempt to lock HEAD tag always fails - HEAD is always unlocked
      std::string h1 = "HEAD";
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "5 Exst "+h1, true, s_db->existsTag(h1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "5 Locked "+h1,
          (int)cool_HvsTagLock_Status::UNLOCKED, (int)fAX->tagLockStatus(h1) );
      CPPUNIT_ASSERT_THROW
        ( fAX->setTagLockStatus( h1, cool_HvsTagLock_Status::LOCKED ), ReservedHeadTag );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "6 Exst "+h1, true, s_db->existsTag(h1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "6 Locked "+h1,
          (int)cool_HvsTagLock_Status::UNLOCKED, (int)fAX->tagLockStatus(h1) );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  void test_tagLocked_dropNode()
  {
    ScopedRecreateFolders theCleaner( this );
    refreshDB(); // drop all nodes before this test
    openDB();
    try {
      // Node hierarchy
      // -> fldset /
      // -> fldset /A
      // -> folder /A/mX
      // -> folder /A/mY
      std::string nameA = "/A";
      std::string nameAX = "/A/mX";
      std::string nameAY = "/A/mY";
      IFolderSetPtr sA  = s_db->createFolderSet( nameA );
      IFolderPtr fAX  = createAndFillMVFolder( nameAX );
      IFolderPtr fAY  = createAndFillMVFolder( nameAY );
      // Tag hierarchy for "/A    version #1"
      // -> fldset '/A    version #1'
      // -> folder '/A/mX version #1'
      // -> folder '/A/mY version #1'
      std::string tA_1  = "/A    version #1";
      std::string tAX_1 = "/A/mX version #1";
      std::string tAY_1 = "/A/mY version #1";
      fAX->createTagRelation( tA_1,  tAX_1 );
      fAY->createTagRelation( tA_1,  tAY_1 );
      // Lock a tag in /A/mY
      fAY->setTagLockStatus( tAY_1, cool_HvsTagLock_Status::LOCKED );
      // Attempt to drop nodes
      s_db->dropNode( nameAX );
      CPPUNIT_ASSERT_THROW( s_db->dropNode( nameAY ), TagIsLocked );
      CPPUNIT_ASSERT_THROW( s_db->dropNode( nameA ), Exception ); // not empty
      // Unlock all tags in /A/mY
      fAY->setTagLockStatus( tAY_1, cool_HvsTagLock_Status::UNLOCKED );
      // Lock a tag in /A
      sA->setTagLockStatus( tA_1, cool_HvsTagLock_Status::LOCKED );
      // Attempt to drop nodes again
      s_db->dropNode( nameAY );
      CPPUNIT_ASSERT_THROW( s_db->dropNode( nameA ), TagIsLocked );
      // Unlock all tags in /A
      sA->setTagLockStatus( tA_1, cool_HvsTagLock_Status::UNLOCKED );
      // Attempt to drop nodes again
      s_db->dropNode( nameA );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_tagLocked_storeObjectWithUserTag()
  {
    try {
      // Folder /A/mX
      // - create A1 as child HVS tag (create relation)
      // - create A1 as IOV user tag
      //   > attempt to use A1 as IOV head tag fails
      IFolderPtr fA = getAndFillFolder( "/A/mX" );
      std::string prod = "PROD";
      std::string a1 = "A1";
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+a1, false, s_db->existsTag(a1) );
      fA->createTagRelation( prod, a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 #", 0u, fA->countObjects(0,100,0,a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 - "+a1, a1, fA->findTagRelation(prod) );
      Record payload = dummyPayload( 10 );
      fA->storeObject( 5, 15, payload, 0, a1 );
      try {
        fA->tagCurrentHead( a1 );
        CPPUNIT_FAIL( "Using A1 as head tag should fail" );
      } catch ( TagExists& ) {}
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 #", 1u, fA->countObjects(0,100,0,a1) );
      // - lock A1 user tag
      // - delete A1 as child HVS tag (delete relation)
      // - attempt to add another object to A1 user tag fails
      // - attempt to delete A1 as IOV tag fails
      fA->setTagLockStatus( a1, cool_HvsTagLock_Status::LOCKED );
      fA->deleteTagRelation( prod );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 #", 1u, fA->countObjects(0,100,0,a1) );
      CPPUNIT_ASSERT_THROW
        ( fA->storeObject( 15, 25, payload, 0, a1 ), TagIsLocked );
      CPPUNIT_ASSERT_THROW
        ( fA->deleteTag( a1 ), TagIsLocked );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 #", 1u, fA->countObjects(0,100,0,a1) );
      // - unlock A1 user tag
      // - attempt to add another object to A1 user tag succeeds
      // - attempt to delete A1 as IOV tag succeeds
      fA->setTagLockStatus( a1, cool_HvsTagLock_Status::UNLOCKED );
      fA->storeObject( 15, 25, payload, 0, a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 #", 2u, fA->countObjects(0,100,0,a1) );
      fA->deleteTag( a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_THROW( fA->countObjects(0,100,0,a1), TagNotFound );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_tagLocked_tagCurrentHead()
  {
    try {
      // Node hierarchy
      // -> fldset /
      // -> fldset /A
      // -> folder /A/mX
      std::string nameA = "/A";
      std::string nameAX = "/A/mX";
      IFolderSetPtr sA  = s_db->getFolderSet( nameA );
      IFolderPtr fAX  = getAndFillFolder( nameAX );
      // Tag hierarchy for "/A    version #1"
      // -> fldset '/A    version #1'
      // -> folder '/A/mX version #1'
      std::string a1 = "/A    version #1";
      std::string x1 = "/A/mX version #1";
      // - create X1 as IOV head tag
      //   > using X1 as IOV user tag fails
      // - create X1 as HVS tag (create relation)
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_THROW( fAX->countObjects(0,100,0,x1), TagNotFound );
      fAX->tagCurrentHead( x1 );
      Record payload = dummyPayload( 10 );
      try {
        fAX->storeObject( 5, 15, payload, 0, x1 );
        CPPUNIT_FAIL( "Using X1 as user tag should fail" );
      } catch ( TagExists& ) {}
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 #", 3u, fAX->countObjects(0,100,0,x1) );
      fAX->createTagRelation( a1, x1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 #", 3u, fAX->countObjects(0,100,0,x1) );
      // - lock folder set A1 tag
      // - lock folder X1 head tag
      // - attempt to add another object to HEAD succeeds
      // - attempt to delete X1 as IOV tag fails
      // - attempt to retag the current HEAD fails
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::LOCKED );
      fAX->setTagLockStatus( x1, cool_HvsTagLock_Status::LOCKED );
      fAX->storeObject( 5, 15, payload, 0 );
      CPPUNIT_ASSERT_THROW( fAX->deleteTag( x1 ), TagIsLocked );
      CPPUNIT_ASSERT_THROW( fAX->tagCurrentHead( x1 ), TagExists );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 #", 3u, fAX->countObjects(0,100,0,x1) );
      // - unlock folder X1 head tag
      // - attempt to delete X1 as IOV tag succeeds
      //   > tag X1 still exists as HVS tag
      // - attempt to retag the current HEAD succeeds
      fAX->setTagLockStatus( x1, cool_HvsTagLock_Status::UNLOCKED );
      fAX->deleteTag( x1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 #", 0u, fAX->countObjects(0,100,0,x1) );
      fAX->tagCurrentHead( x1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 #", 4u, fAX->countObjects(0,100,0,x1) );
      // - attempt to delete A1 as folder set tag fails
      // - unlock folder set tag A1
      // - attempt to delete A1 as folder set tag succeeds
      // - attempt to delete X1 as IOV tag succeeds
      CPPUNIT_ASSERT_THROW( fAX->deleteTagRelation( a1 ), TagIsLocked );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+x1, true, s_db->existsTag(x1) );
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::UNLOCKED );
      fAX->deleteTagRelation( a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 Exst "+x1, true, s_db->existsTag(x1) );
      fAX->deleteTag( x1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 Exst "+x1, false, s_db->existsTag(x1) );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_tagLocked_tagHeadAsOfDate()
  {
    try {
      // Node hierarchy
      // -> fldset /
      // -> fldset /A
      // -> folder /A/mX
      std::string nameA = "/A";
      std::string nameAX = "/A/mX";
      IFolderSetPtr sA  = s_db->getFolderSet( nameA );
      IFolderPtr fAX  = getAndFillFolder( nameAX );
      // Tag hierarchy for "/A    version #1"
      // -> fldset '/A    version #1'
      // -> folder '/A/mX version #1'
      std::string a1 = "/A    version #1";
      std::string x1 = "/A/mX version #1";
      // - create X1 as IOV date tag
      //   > using X1 as IOV user tag fails
      // - create X1 as HVS tag (create relation)
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_THROW( fAX->countObjects(0,100,0,x1), TagNotFound );
      Time date = fAX->findObject( 20, 0 )->insertionTime();
      fAX->tagHeadAsOfDate( date, x1 );
      Record payload = dummyPayload( 10 );
      try {
        fAX->storeObject( 5, 15, payload, 0, x1 );
        CPPUNIT_FAIL( "Using X1 as user tag should fail" );
      } catch ( TagExists& ) {}
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 #", 3u, fAX->countObjects(0,100,0,x1) );
      fAX->createTagRelation( a1, x1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 #", 3u, fAX->countObjects(0,100,0,x1) );
      // - lock folder set A1 tag
      // - lock folder X1 head tag
      // - attempt to add another object to HEAD succeeds
      // - attempt to delete X1 as IOV tag fails
      // - attempt to retag at new date fails
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::LOCKED );
      fAX->setTagLockStatus( x1, cool_HvsTagLock_Status::LOCKED );
      fAX->storeObject( 5, 15, payload, 0 );
      date = fAX->findObject( 5, 0 )->insertionTime();
      CPPUNIT_ASSERT_THROW( fAX->deleteTag( x1 ), TagIsLocked );
      CPPUNIT_ASSERT_THROW
        ( fAX->tagHeadAsOfDate( date, x1 ), TagExists );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 #", 3u, fAX->countObjects(0,100,0,x1) );
      // - unlock folder X1 head tag
      // - attempt to delete X1 as IOV tag succeeds
      //   > tag X1 still exists as HVS tag
      // - attempt to retag at new date succeeds
      fAX->setTagLockStatus( x1, cool_HvsTagLock_Status::UNLOCKED );
      fAX->deleteTag( x1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 #", 0u, fAX->countObjects(0,100,0,x1) );
      fAX->tagHeadAsOfDate( date, x1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 #", 4u, fAX->countObjects(0,100,0,x1) );
      // - attempt to delete A1 as folder set tag fails
      // - unlock folder set tag A1
      // - attempt to delete A1 as folder set tag succeeds
      // - attempt to delete X1 as IOV tag succeeds
      CPPUNIT_ASSERT_THROW( fAX->deleteTagRelation( a1 ), TagIsLocked );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+x1, true, s_db->existsTag(x1) );
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::UNLOCKED );
      fAX->deleteTagRelation( a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 Exst "+x1, true, s_db->existsTag(x1) );
      fAX->deleteTag( x1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 Exst "+x1, false, s_db->existsTag(x1) );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_tagLocked_deleteTag()
  {
    try {
      // Node hierarchy
      // -> fldset /
      // -> fldset /A
      // -> folder /A/mX
      // -> folder /A/mY
      std::string nameA = "/A";
      std::string nameAX = "/A/mX";
      std::string nameAY = "/A/mY";
      IFolderSetPtr sA  = s_db->getFolderSet( nameA );
      IFolderPtr fAX  = getAndFillFolder( nameAX );
      IFolderPtr fAY  = getAndFillFolder( nameAY );
      // Tag hierarchy for "/A    version #1"
      // -> fldset '/A    version #1'
      // -> folder '/A/mX version #1'
      // -> folder '/A/mY version #1'
      std::string a1 = "/A    version #1";
      std::string x1 = "/A/mX version #1";
      std::string y1 = "/A/mY version #1";
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+y1, false, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAX->countObjects(0,100,0,x1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->countObjects(0,100,0,y1), TagNotFound );
      // Create tag relations
      fAX->createTagRelation( a1, x1 );
      fAY->createTagRelation( a1, y1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 #", 0u, fAX->countObjects(0,100,0,x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 - "+y1, y1, fAY->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 #", 0u, fAY->countObjects(0,100,0,y1) );
      // Lock a tag in /A/mY
      fAY->setTagLockStatus( y1, cool_HvsTagLock_Status::LOCKED );
      // Attempt to delete folder tags
      // Note that actually these folder tags have no IOVs associated... even
      // if deleteTag( x1 ) succceds, it actually does nothing because the
      // relation to a1 still exists (hence do not attempt to recreate it!)
      fAX->deleteTag( x1 );
      CPPUNIT_ASSERT_THROW( fAY->deleteTag( y1 ), TagIsLocked );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 #", 0u, fAX->countObjects(0,100,0,x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 - "+y1, y1, fAY->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 #", 0u, fAY->countObjects(0,100,0,y1) );
      // Unlock all tags in /A/mY
      fAY->setTagLockStatus( y1, cool_HvsTagLock_Status::UNLOCKED );
      // Lock a tag in /A
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::LOCKED );
      // Attempt to delete folder tags again
      fAX->deleteTag( x1 );
      fAY->deleteTag( y1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 #", 0u, fAX->countObjects(0,100,0,x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 - "+y1, y1, fAY->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 #", 0u, fAY->countObjects(0,100,0,y1) );
      // Unlock all tags in /A
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::UNLOCKED );
      // Delete all tag relations
      fAX->deleteTagRelation( a1 );
      fAY->deleteTagRelation( a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+y1, false, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAX->countObjects(0,100,0,x1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->countObjects(0,100,0,y1), TagNotFound );
      // Tag current HEAD in /A/mY
      fAY->tagCurrentHead( y1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAX->countObjects(0,100,0,x1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 #", 3u, fAY->countObjects(0,100,0,y1) );
      // Lock a tag in /A/mY
      fAY->setTagLockStatus( y1, cool_HvsTagLock_Status::LOCKED );
      // Attempt to delete folder tags
      // Note that actually these folder tags have no IOVs associated... even
      // if deleteTag( x1 ) succceds, it actually does nothing because the
      // relation to a1 still exists (hence do not attempt to recreate it!)
      CPPUNIT_ASSERT_THROW( fAY->deleteTag( y1 ), TagIsLocked );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 #", 3u, fAY->countObjects(0,100,0,y1) );
      // Unlock all tags in /A/mY
      fAY->setTagLockStatus( y1, cool_HvsTagLock_Status::UNLOCKED );
      // Attempt to delete folder tags again
      fAY->deleteTag( y1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 Exst "+y1, false, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAY->countObjects(0,100,0,y1), TagNotFound );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_tagLocked_createTagRelation()
  {
    try {
      // Node hierarchy
      // -> fldset /
      // -> fldset /A
      // -> folder /A/mX
      // -> folder /A/mY
      std::string nameA = "/A";
      std::string nameAX = "/A/mX";
      std::string nameAY = "/A/mY";
      IFolderSetPtr sA  = s_db->getFolderSet( nameA );
      IFolderPtr fAX  = getAndFillFolder( nameAX );
      IFolderPtr fAY  = getAndFillFolder( nameAY );
      // Tag hierarchy for "/A    version #1"
      // -> fldset '/A    version #1'
      // -> folder '/A/mX version #1'
      // -> folder '/A/mY version #1'
      std::string a1 = "/A    version #1";
      std::string x1 = "/A/mX version #1";
      std::string y1 = "/A/mY version #1";
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+y1, false, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->findTagRelation(a1), TagNotFound );
      // Create tag relations
      fAX->createTagRelation( a1, x1 );
      fAY->createTagRelation( a1, y1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 - "+y1, y1, fAY->findTagRelation(a1) );
      // Delete tag relations
      fAX->deleteTagRelation( a1 );
      fAY->deleteTagRelation( a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+y1, false, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->findTagRelation(a1), TagNotFound );
      // Lock a tag in /A/mY
      // You must create the tag first (eg by tagCurrentHead)
      fAY->tagCurrentHead( y1 );
      fAY->setTagLockStatus( y1, cool_HvsTagLock_Status::LOCKED );
      // Create tag relations
      fAX->createTagRelation( a1, x1 );
      fAY->createTagRelation( a1, y1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 - "+y1, y1, fAY->findTagRelation(a1) );
      // Delete tag relations
      fAX->deleteTagRelation( a1 );
      fAY->deleteTagRelation( a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->findTagRelation(a1), TagNotFound );
      // Attempt to delete the /A/mY tag will fail
      CPPUNIT_ASSERT_THROW( fAY->deleteTag(y1), TagIsLocked );
      // Unlock all tags in /A/mY (and delete them)
      fAY->setTagLockStatus( y1, cool_HvsTagLock_Status::UNLOCKED );
      fAY->deleteTag(y1);
      // Attempt to lock a tag in /A
      // This will fail because the tag does not exist, i.e. has no associated
      // child node tags (and note that it throws Exception, not TagNotFound)
      CPPUNIT_ASSERT_THROW
        ( sA->setTagLockStatus( a1, cool_HvsTagLock_Status::LOCKED ), Exception );
      // Create /A/mX tag relation - this will create the /A tag
      fAX->createTagRelation( a1, x1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+y1, false, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_THROW( fAY->findTagRelation(a1), TagRelationNotFound );
      // Lock a tag in /A
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::LOCKED );
      // Attempt to create tag relations
      CPPUNIT_ASSERT_THROW( fAY->createTagRelation( a1, y1 ), TagIsLocked );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+y1, false, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_THROW( fAY->findTagRelation(a1), TagRelationNotFound );
      // Unlock all tags in /A
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::UNLOCKED );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_tagLocked_deleteTagRelation()
  {
    try {
      // Node hierarchy
      // -> fldset /
      // -> fldset /A
      // -> folder /A/mX
      // -> folder /A/mY
      std::string nameA = "/A";
      std::string nameAX = "/A/mX";
      std::string nameAY = "/A/mY";
      IFolderSetPtr sA  = s_db->getFolderSet( nameA );
      IFolderPtr fAX  = getAndFillFolder( nameAX );
      IFolderPtr fAY  = getAndFillFolder( nameAY );
      // Tag hierarchy for "/A    version #1"
      // -> fldset '/A    version #1'
      // -> folder '/A/mX version #1'
      // -> folder '/A/mY version #1'
      std::string a1 = "/A    version #1";
      std::string x1 = "/A/mX version #1";
      std::string y1 = "/A/mY version #1";
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+y1, false, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->findTagRelation(a1), TagNotFound );
      // Create tag relations
      fAX->createTagRelation( a1, x1 );
      fAY->createTagRelation( a1, y1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 - "+y1, y1, fAY->findTagRelation(a1) );
      // Lock a tag in /A/mY
      fAY->setTagLockStatus( y1, cool_HvsTagLock_Status::LOCKED );
      // Attempt to delete tag relations
      // Deleting the /A/mY tag relation fails because the child tag would
      // be deleted and is locked (it would not fail if the child tag were
      // locked but deleteTagRelation would not lead to deleting the tag)
      fAX->deleteTagRelation( a1 );
      CPPUNIT_ASSERT_THROW( fAY->deleteTagRelation( a1 ), TagIsLocked );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagRelationNotFound );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 - "+y1, y1, fAY->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 #", 0u, fAY->countObjects(0,100,0,y1) );
      // Unlock all tags in /A/mY
      fAY->setTagLockStatus( y1, cool_HvsTagLock_Status::UNLOCKED );
      // Use tags in /A/mY for the current HEAD and lock them again
      fAY->tagCurrentHead( y1 );
      fAY->setTagLockStatus( y1, cool_HvsTagLock_Status::LOCKED );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagRelationNotFound );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 - "+y1, y1, fAY->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 #", 3u, fAY->countObjects(0,100,0,y1) );
      // Attempt to delete tag relations again
      // Deleting the /A/mY tag relation does NOT fail even if the child tag is
      // locked, because deleteTagRelation would not lead to deleting the tag
      fAY->deleteTagRelation( a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 #", 3u, fAY->countObjects(0,100,0,y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->findTagRelation(a1), TagNotFound );
      // Unlock all tags in /A/mY (and delete them)
      fAY->setTagLockStatus( y1, cool_HvsTagLock_Status::UNLOCKED );
      fAY->deleteTag( y1 );
      // Create tag relations again
      fAX->createTagRelation( a1, x1 );
      fAY->createTagRelation( a1, y1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 - "+y1, y1, fAY->findTagRelation(a1) );
      // Lock a tag in /A
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::LOCKED );
      // Attempt to delete tag relations - will fail as parent tag is locked
      CPPUNIT_ASSERT_THROW( fAX->deleteTagRelation( a1 ), TagIsLocked );
      CPPUNIT_ASSERT_THROW( fAY->deleteTagRelation( a1 ), TagIsLocked );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 #", 0u, fAX->countObjects(0,100,0,x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 - "+y1, y1, fAY->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 #", 0u, fAY->countObjects(0,100,0,y1) );
      // Unlock all tags in /A
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::UNLOCKED );
      // Delete tag relations again
      fAX->deleteTagRelation( a1 );
      fAY->deleteTagRelation( a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 Exst "+y1, false, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAX->countObjects(0,100,0,x1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->countObjects(0,100,0,y1), TagNotFound );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_partiallyLockTag_fails()
  {
    try {
      // Node hierarchy
      // -> fldset /
      // -> fldset /A
      // -> folder /A/mX
      std::string nameA = "/A";
      std::string nameAX = "/A/mX";
      IFolderSetPtr sA  = s_db->getFolderSet( nameA );
      IFolderPtr fAX  = getAndFillFolder( nameAX );
      // Tag hierarchy for "/A    version #1"
      // -> fldset '/A    version #1'
      // -> folder '/A/mX version #1'
      std::string a1  = "/A    version #1";
      std::string x1 = "/A/mX version #1";
      // Attempt to lock tags before they are created fails
      // (fails with private RowNotUpdated exception)
      CPPUNIT_ASSERT_THROW
        ( sA->setTagLockStatus( a1, cool_HvsTagLock_Status::PARTIALLYLOCKED ), Exception );
      CPPUNIT_ASSERT_THROW
        ( fAX->setTagLockStatus( x1, cool_HvsTagLock_Status::PARTIALLYLOCKED ), Exception );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "1 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "1 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_THROW( sA->tagLockStatus( a1 ), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAX->tagLockStatus( x1 ), TagNotFound );
      // Attempt to lock tags after they are created succeds
      fAX->createTagRelation( a1, x1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "2 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "2 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "2 Locked "+a1,
          (int)cool_HvsTagLock_Status::UNLOCKED, (int)sA->tagLockStatus(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "2 Locked "+x1,
          (int)cool_HvsTagLock_Status::UNLOCKED, (int)fAX->tagLockStatus(x1) );
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::PARTIALLYLOCKED );
      fAX->setTagLockStatus( x1, cool_HvsTagLock_Status::PARTIALLYLOCKED );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "3 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "3 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "3 Locked "+a1,
          (int)cool_HvsTagLock_Status::PARTIALLYLOCKED, (int)sA->tagLockStatus(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "3 Locked "+x1,
          (int)cool_HvsTagLock_Status::PARTIALLYLOCKED, (int)fAX->tagLockStatus(x1) );
      // Cleanup - unlock all tags
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::UNLOCKED );
      fAX->setTagLockStatus( x1, cool_HvsTagLock_Status::UNLOCKED );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "4 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "4 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "4 Locked "+a1,
          (int)cool_HvsTagLock_Status::UNLOCKED, (int)sA->tagLockStatus(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "4 Locked "+x1,
          (int)cool_HvsTagLock_Status::UNLOCKED, (int)fAX->tagLockStatus(x1) );
      // Attempt to lock HEAD tag always fails - HEAD is always unlocked
      std::string h1 = "HEAD";
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "5 Exst "+h1, true, s_db->existsTag(h1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "5 Locked "+h1,
          (int)cool_HvsTagLock_Status::UNLOCKED, (int)fAX->tagLockStatus(h1) );
      CPPUNIT_ASSERT_THROW
        ( fAX->setTagLockStatus( h1, cool_HvsTagLock_Status::PARTIALLYLOCKED ), ReservedHeadTag );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "6 Exst "+h1, true, s_db->existsTag(h1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "6 Locked "+h1,
          (int)cool_HvsTagLock_Status::UNLOCKED, (int)fAX->tagLockStatus(h1) );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  void test_tagPartiallyLocked_dropNode()
  {
    ScopedRecreateFolders theCleaner( this );
    refreshDB(); // drop all nodes before this test
    openDB();
    try {
      // Node hierarchy
      // -> fldset /
      // -> fldset /A
      // -> folder /A/mX
      // -> folder /A/mY
      std::string nameA = "/A";
      std::string nameAX = "/A/mX";
      std::string nameAY = "/A/mY";
      IFolderSetPtr sA  = s_db->createFolderSet( nameA );
      IFolderPtr fAX  = createAndFillMVFolder( nameAX );
      IFolderPtr fAY  = createAndFillMVFolder( nameAY );
      // Tag hierarchy for "/A    version #1"
      // -> fldset '/A    version #1'
      // -> folder '/A/mX version #1'
      // -> folder '/A/mY version #1'
      std::string tA_1  = "/A    version #1";
      std::string tAX_1 = "/A/mX version #1";
      std::string tAY_1 = "/A/mY version #1";
      fAX->createTagRelation( tA_1,  tAX_1 );
      fAY->createTagRelation( tA_1,  tAY_1 );
      // Lock a tag in /A/mY
      fAY->setTagLockStatus( tAY_1, cool_HvsTagLock_Status::PARTIALLYLOCKED );
      // Attempt to drop nodes
      s_db->dropNode( nameAX );
      CPPUNIT_ASSERT_THROW( s_db->dropNode( nameAY ), TagIsLocked );
      CPPUNIT_ASSERT_THROW( s_db->dropNode( nameA ), Exception ); // not empty
      // Unlock all tags in /A/mY
      fAY->setTagLockStatus( tAY_1, cool_HvsTagLock_Status::UNLOCKED );
      // Lock a tag in /A
      sA->setTagLockStatus( tA_1, cool_HvsTagLock_Status::PARTIALLYLOCKED );
      // Attempt to drop nodes again
      s_db->dropNode( nameAY );
      CPPUNIT_ASSERT_THROW( s_db->dropNode( nameA ), TagIsLocked );
      // Unlock all tags in /A
      sA->setTagLockStatus( tA_1, cool_HvsTagLock_Status::UNLOCKED );
      // Attempt to drop nodes again
      s_db->dropNode( nameA );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_tagPartiallyLocked_storeObjectWithUserTag()
  {
    try {
      // Folder /A/mX
      // - create A1 as child HVS tag (create relation)
      // - create A1 as IOV user tag
      //   > attempt to use A1 as IOV head tag fails
      IFolderPtr fA = getAndFillFolder( "/A/mX" );
      std::string prod = "PROD";
      std::string a1 = "A1";
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+a1, false, s_db->existsTag(a1) );
      fA->createTagRelation( prod, a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 #", 0u, fA->countObjects(0,100,0,a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 - "+a1, a1, fA->findTagRelation(prod) );
      Record payload = dummyPayload( 10 );
      fA->storeObject( 5, 15, payload, 0, a1 );
      try {
        fA->tagCurrentHead( a1 );
        CPPUNIT_FAIL( "Using A1 as head tag should fail" );
      } catch ( TagExists& ) {}
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 #", 1u, fA->countObjects(0,100,0,a1) );
      // - lock A1 user tag
      // - delete A1 as child HVS tag (delete relation)
      // - attempt to add another object to A1 user tag fails
      // - attempt to delete A1 as IOV tag fails
      fA->setTagLockStatus( a1, cool_HvsTagLock_Status::PARTIALLYLOCKED );
      fA->deleteTagRelation( prod );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 #", 1u, fA->countObjects(0,100,0,a1) );
      CPPUNIT_ASSERT_THROW
        ( fA->storeObject( 14, 25, payload, 0, a1 ), TagIsLocked );
      CPPUNIT_ASSERT_THROW
        ( fA->deleteTag( a1 ), TagIsLocked );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 #", 1u, fA->countObjects(0,100,0,a1) );
      // - unlock A1 user tag
      // - attempt to add another object to A1 user tag succeeds
      // - attempt to delete A1 as IOV tag succeeds
      fA->setTagLockStatus( a1, cool_HvsTagLock_Status::UNLOCKED );
      fA->storeObject( 15, 25, payload, 0, a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 #", 2u, fA->countObjects(0,100,0,a1) );
      fA->deleteTag( a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_THROW( fA->countObjects(0,100,0,a1), TagNotFound );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_tagPartiallyLocked_storeObjectWithUserTagNoOverlap()
  {
    // Folder /A/mX
    // - create A1 as child HVS tag (create relation)
    // - create A1 as IOV user tag
    std::string prod = "PROD";
    std::string a1 = "A1";
    IFolderPtr fA = s_db->getFolder( "/A/mX" );
    try
    {
      Record payload = dummyPayload( 510 );
      // only store into user tag
      fA->storeObject( 5, 10, payload, 0, a1, true );
      //coral::MsgLevel coralLevel = coral::MessageStream::msgVerbosity();
      //coral::MessageStream::setMsgVerbosity( coral::Verbose );
      fA->storeObject( 7, 20, dummyPayload(720), 0, a1, true );
      //coral::MessageStream::setMsgVerbosity( coralLevel );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Count objects ", 2u,
                                    fA->countObjects(0,200,0, a1) );
      fA->storeObject(20, 30, dummyPayload(2030), 0, a1, true );
      // leave a hole from 30 to 40
      fA->storeObject(40, 50, dummyPayload(4050), 0, a1, true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Count objects ", 4u,
                                    fA->countObjects(0,200,0, a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+a1, true, s_db->existsTag(a1) );
      // - partially lock A1 user tag
      // - attempt to add another object with overlapping IOVs
      //   to A1 user tag fails
      // - attempt to add another object with no overlapping IOVs
      //   to A1 user tag succeeds
      fA->setTagLockStatus( a1, cool_HvsTagLock_Status::PARTIALLYLOCKED );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+a1, true, s_db->existsTag(a1) );
      // IOV covering all existing IOVs fails
      CPPUNIT_ASSERT_THROW
        ( fA->storeObject( 0, 80, payload, 0, a1 ), TagIsLocked );
      // since is one before the hole -> failure
      CPPUNIT_ASSERT_THROW
        ( fA->storeObject( 29, 35, payload, 0, a1 ), TagIsLocked );
      // until one after the hole -> failure
      CPPUNIT_ASSERT_THROW
        ( fA->storeObject( 30, 41, payload, 0, a1 ), TagIsLocked );
      // inside one IOV -> failure
      CPPUNIT_ASSERT_THROW
        ( fA->storeObject( 15, 18, payload, 0, a1 ), TagIsLocked );
      CPPUNIT_ASSERT_THROW
        ( fA->storeObject( 7, 15, payload, 0, a1 ), TagIsLocked );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "2 Count objects ", 4u, fA->countObjects(0,200,0, a1) );
      // no overlap succeeds
      // into the hole
      fA->storeObject(30, 40, payload, 0, a1, true);
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "3 Count objects ", 5u, fA->countObjects(0,200,0, a1) );
      // at the end
      fA->storeObject(50, 60, dummyPayload(5060), 0, a1, true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "4 Count objects ", 6u, fA->countObjects(0,200,0, a1) );
      // at the beginning
      fA->storeObject( 0, 5, payload, 0, a1, true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "5 Count objects ", 7u, fA->countObjects(0,200,0, a1) );
      // storing into head succeeds
      fA->storeObject( 0, 40, dummyPayload(2), 0);
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "6 Count objects ", 1u, fA->countObjects(0,200,0) );
      // store into user tag and head with overlaping head
      fA->storeObject(65, 75, payload, 0);
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ("7 Count objects ", 2u, fA->countObjects(0, 200, 0));
      fA->storeObject(60, 70, dummyPayload(3141), 0, a1, false);
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ("8 Count objects ", 8u, fA->countObjects(0, 200, 0, a1));
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ("9 Count objects ", 3u, fA->countObjects(0, 200, 0));
      // the same IOVs again fail now
      CPPUNIT_ASSERT_THROW
        ( fA->storeObject( 30, 40, payload, 0, a1 ), TagIsLocked );
      CPPUNIT_ASSERT_THROW
        ( fA->storeObject( 50, 60, payload, 0, a1 ), TagIsLocked );
      CPPUNIT_ASSERT_THROW
        ( fA->storeObject(  0, 5, payload, 0, a1 ), TagIsLocked );
      CPPUNIT_ASSERT_THROW( fA->deleteTag( a1 ), TagIsLocked );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+a1, true, s_db->existsTag(a1) );
      // test bulk storage
      fA->setupStorageBuffer( true );
      // overlap of objects to store
      fA->storeObject(90, 120, payload, 0, a1 );
      fA->storeObject(110, 130, payload, 0, a1 );
      fA->storeObject( 80, 90, payload, 0, a1 );
      CPPUNIT_ASSERT_THROW( fA->flushStorageBuffer(), TagIsLocked);
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "9 Count objects ", 8u, fA->countObjects(0,200,0, a1) );
      // no overlap of objects to store
      fA->storeObject(90, 120, payload, 0, a1 );
      fA->storeObject(120, 130, payload, 0, a1 );
      fA->storeObject( 80, 90, payload, 0, a1 );
      fA->flushStorageBuffer();
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "10 Count objects ", 11u, fA->countObjects(0,200,0, a1) );
      fA->setupStorageBuffer( false );
      // unlock tag
      fA->setTagLockStatus( a1, cool_HvsTagLock_Status::UNLOCKED );
      // storing is again possible
      fA->storeObject( 0, 80, payload, 0, a1 );
      fA->storeObject( 10, 11, payload, 0, a1 );
      fA->storeObject( 15, 18, payload, 0, a1 );
      fA->storeObject( 15, 25, payload, 0, a1 );
      fA->deleteTag( a1 );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      fA->setTagLockStatus( a1, cool_HvsTagLock_Status::UNLOCKED );
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_tagPartiallyLocked_tagCurrentHead()
  {
    try {
      // Node hierarchy
      // -> fldset /
      // -> fldset /A
      // -> folder /A/mX
      std::string nameA = "/A";
      std::string nameAX = "/A/mX";
      IFolderSetPtr sA  = s_db->getFolderSet( nameA );
      IFolderPtr fAX  = getAndFillFolder( nameAX );
      // Tag hierarchy for "/A    version #1"
      // -> fldset '/A    version #1'
      // -> folder '/A/mX version #1'
      std::string a1 = "/A    version #1";
      std::string x1 = "/A/mX version #1";
      // - create X1 as IOV head tag
      //   > using X1 as IOV user tag fails
      // - create X1 as HVS tag (create relation)
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_THROW( fAX->countObjects(0,100,0,x1), TagNotFound );
      fAX->tagCurrentHead( x1 );
      Record payload = dummyPayload( 10 );
      try {
        fAX->storeObject( 5, 15, payload, 0, x1 );
        CPPUNIT_FAIL( "Using X1 as user tag should fail" );
      } catch ( TagExists& ) {}
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 #", 3u, fAX->countObjects(0,100,0,x1) );
      fAX->createTagRelation( a1, x1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 #", 3u, fAX->countObjects(0,100,0,x1) );
      // - lock folder set A1 tag
      // - lock folder X1 head tag
      // - attempt to add another object to HEAD succeeds
      // - attempt to delete X1 as IOV tag fails
      // - attempt to retag the current HEAD fails
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::PARTIALLYLOCKED );
      fAX->setTagLockStatus( x1, cool_HvsTagLock_Status::PARTIALLYLOCKED );
      fAX->storeObject( 5, 15, payload, 0 );
      CPPUNIT_ASSERT_THROW( fAX->deleteTag( x1 ), TagIsLocked );
      CPPUNIT_ASSERT_THROW( fAX->tagCurrentHead( x1 ), TagExists );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 #", 3u, fAX->countObjects(0,100,0,x1) );
      // - unlock folder X1 head tag
      // - attempt to delete X1 as IOV tag succeeds
      //   > tag X1 still exists as HVS tag
      // - attempt to retag the current HEAD succeeds
      fAX->setTagLockStatus( x1, cool_HvsTagLock_Status::UNLOCKED );
      fAX->deleteTag( x1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 #", 0u, fAX->countObjects(0,100,0,x1) );
      fAX->tagCurrentHead( x1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 #", 4u, fAX->countObjects(0,100,0,x1) );
      // - attempt to delete A1 as folder set tag fails
      // - unlock folder set tag A1
      // - attempt to delete A1 as folder set tag succeeds
      // - attempt to delete X1 as IOV tag succeeds
      CPPUNIT_ASSERT_THROW( fAX->deleteTagRelation( a1 ), TagIsLocked );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+x1, true, s_db->existsTag(x1) );
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::UNLOCKED );
      fAX->deleteTagRelation( a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 Exst "+x1, true, s_db->existsTag(x1) );
      fAX->deleteTag( x1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 Exst "+x1, false, s_db->existsTag(x1) );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_tagPartiallyLocked_tagHeadAsOfDate()
  {
    try {
      // Node hierarchy
      // -> fldset /
      // -> fldset /A
      // -> folder /A/mX
      std::string nameA = "/A";
      std::string nameAX = "/A/mX";
      IFolderSetPtr sA  = s_db->getFolderSet( nameA );
      IFolderPtr fAX  = getAndFillFolder( nameAX );
      // Tag hierarchy for "/A    version #1"
      // -> fldset '/A    version #1'
      // -> folder '/A/mX version #1'
      std::string a1 = "/A    version #1";
      std::string x1 = "/A/mX version #1";
      // - create X1 as IOV date tag
      //   > using X1 as IOV user tag fails
      // - create X1 as HVS tag (create relation)
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_THROW( fAX->countObjects(0,100,0,x1), TagNotFound );
      Time date = fAX->findObject( 20, 0 )->insertionTime();
      fAX->tagHeadAsOfDate( date, x1 );
      Record payload = dummyPayload( 10 );
      try {
        fAX->storeObject( 5, 15, payload, 0, x1 );
        CPPUNIT_FAIL( "Using X1 as user tag should fail" );
      } catch ( TagExists& ) {}
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 #", 3u, fAX->countObjects(0,100,0,x1) );
      fAX->createTagRelation( a1, x1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 #", 3u, fAX->countObjects(0,100,0,x1) );
      // - lock folder set A1 tag
      // - lock folder X1 head tag
      // - attempt to add another object to HEAD succeeds
      // - attempt to delete X1 as IOV tag fails
      // - attempt to retag at new date fails
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::PARTIALLYLOCKED );
      fAX->setTagLockStatus( x1, cool_HvsTagLock_Status::PARTIALLYLOCKED );
      fAX->storeObject( 5, 15, payload, 0 );
      date = fAX->findObject( 5, 0 )->insertionTime();
      CPPUNIT_ASSERT_THROW( fAX->deleteTag( x1 ), TagIsLocked );
      CPPUNIT_ASSERT_THROW
        ( fAX->tagHeadAsOfDate( date, x1 ), TagExists );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 #", 3u, fAX->countObjects(0,100,0,x1) );
      // - unlock folder X1 head tag
      // - attempt to delete X1 as IOV tag succeeds
      //   > tag X1 still exists as HVS tag
      // - attempt to retag at new date succeeds
      fAX->setTagLockStatus( x1, cool_HvsTagLock_Status::UNLOCKED );
      fAX->deleteTag( x1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 #", 0u, fAX->countObjects(0,100,0,x1) );
      fAX->tagHeadAsOfDate( date, x1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 #", 4u, fAX->countObjects(0,100,0,x1) );
      // - attempt to delete A1 as folder set tag fails
      // - unlock folder set tag A1
      // - attempt to delete A1 as folder set tag succeeds
      // - attempt to delete X1 as IOV tag succeeds
      CPPUNIT_ASSERT_THROW( fAX->deleteTagRelation( a1 ), TagIsLocked );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+x1, true, s_db->existsTag(x1) );
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::UNLOCKED );
      fAX->deleteTagRelation( a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 Exst "+x1, true, s_db->existsTag(x1) );
      fAX->deleteTag( x1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 Exst "+x1, false, s_db->existsTag(x1) );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_tagPartiallyLocked_deleteTag()
  {
    try {
      // Node hierarchy
      // -> fldset /
      // -> fldset /A
      // -> folder /A/mX
      // -> folder /A/mY
      std::string nameA = "/A";
      std::string nameAX = "/A/mX";
      std::string nameAY = "/A/mY";
      IFolderSetPtr sA  = s_db->getFolderSet( nameA );
      IFolderPtr fAX  = getAndFillFolder( nameAX );
      IFolderPtr fAY  = getAndFillFolder( nameAY );
      // Tag hierarchy for "/A    version #1"
      // -> fldset '/A    version #1'
      // -> folder '/A/mX version #1'
      // -> folder '/A/mY version #1'
      std::string a1 = "/A    version #1";
      std::string x1 = "/A/mX version #1";
      std::string y1 = "/A/mY version #1";
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+y1, false, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAX->countObjects(0,100,0,x1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->countObjects(0,100,0,y1), TagNotFound );
      // Create tag relations
      fAX->createTagRelation( a1, x1 );
      fAY->createTagRelation( a1, y1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 #", 0u, fAX->countObjects(0,100,0,x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 - "+y1, y1, fAY->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 #", 0u, fAY->countObjects(0,100,0,y1) );
      // Lock a tag in /A/mY
      fAY->setTagLockStatus( y1, cool_HvsTagLock_Status::PARTIALLYLOCKED );
      // Attempt to delete folder tags
      // Note that actually these folder tags have no IOVs associated... even
      // if deleteTag( x1 ) succceds, it actually does nothing because the
      // relation to a1 still exists (hence do not attempt to recreate it!)
      fAX->deleteTag( x1 );
      CPPUNIT_ASSERT_THROW( fAY->deleteTag( y1 ), TagIsLocked );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 #", 0u, fAX->countObjects(0,100,0,x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 - "+y1, y1, fAY->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 #", 0u, fAY->countObjects(0,100,0,y1) );
      // Unlock all tags in /A/mY
      fAY->setTagLockStatus( y1, cool_HvsTagLock_Status::UNLOCKED );
      // Lock a tag in /A
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::PARTIALLYLOCKED );
      // Attempt to delete folder tags again
      fAX->deleteTag( x1 );
      fAY->deleteTag( y1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 #", 0u, fAX->countObjects(0,100,0,x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 - "+y1, y1, fAY->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 #", 0u, fAY->countObjects(0,100,0,y1) );
      // Unlock all tags in /A
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::UNLOCKED );
      // Delete all tag relations
      fAX->deleteTagRelation( a1 );
      fAY->deleteTagRelation( a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+y1, false, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAX->countObjects(0,100,0,x1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->countObjects(0,100,0,y1), TagNotFound );
      // Tag current HEAD in /A/mY
      fAY->tagCurrentHead( y1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAX->countObjects(0,100,0,x1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 #", 3u, fAY->countObjects(0,100,0,y1) );
      // Lock a tag in /A/mY
      fAY->setTagLockStatus( y1, cool_HvsTagLock_Status::PARTIALLYLOCKED );
      // Attempt to delete folder tags
      // Note that actually these folder tags have no IOVs associated... even
      // if deleteTag( x1 ) succceds, it actually does nothing because the
      // relation to a1 still exists (hence do not attempt to recreate it!)
      CPPUNIT_ASSERT_THROW( fAY->deleteTag( y1 ), TagIsLocked );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 #", 3u, fAY->countObjects(0,100,0,y1) );
      // Unlock all tags in /A/mY
      fAY->setTagLockStatus( y1, cool_HvsTagLock_Status::UNLOCKED );
      // Attempt to delete folder tags again
      fAY->deleteTag( y1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 Exst "+y1, false, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAY->countObjects(0,100,0,y1), TagNotFound );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_tagPartiallyLocked_createTagRelation()
  {
    try {
      // Node hierarchy
      // -> fldset /
      // -> fldset /A
      // -> folder /A/mX
      // -> folder /A/mY
      std::string nameA = "/A";
      std::string nameAX = "/A/mX";
      std::string nameAY = "/A/mY";
      IFolderSetPtr sA  = s_db->getFolderSet( nameA );
      IFolderPtr fAX  = getAndFillFolder( nameAX );
      IFolderPtr fAY  = getAndFillFolder( nameAY );
      // Tag hierarchy for "/A    version #1"
      // -> fldset '/A    version #1'
      // -> folder '/A/mX version #1'
      // -> folder '/A/mY version #1'
      std::string a1 = "/A    version #1";
      std::string x1 = "/A/mX version #1";
      std::string y1 = "/A/mY version #1";
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+y1, false, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->findTagRelation(a1), TagNotFound );
      // Create tag relations
      fAX->createTagRelation( a1, x1 );
      fAY->createTagRelation( a1, y1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 - "+y1, y1, fAY->findTagRelation(a1) );
      // Delete tag relations
      fAX->deleteTagRelation( a1 );
      fAY->deleteTagRelation( a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+y1, false, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->findTagRelation(a1), TagNotFound );
      // Lock a tag in /A/mY
      // You must create the tag first (eg by tagCurrentHead)
      fAY->tagCurrentHead( y1 );
      fAY->setTagLockStatus( y1, cool_HvsTagLock_Status::PARTIALLYLOCKED );
      // Create tag relations
      fAX->createTagRelation( a1, x1 );
      fAY->createTagRelation( a1, y1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 - "+y1, y1, fAY->findTagRelation(a1) );
      // Delete tag relations
      fAX->deleteTagRelation( a1 );
      fAY->deleteTagRelation( a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->findTagRelation(a1), TagNotFound );
      // Attempt to delete the /A/mY tag will fail
      CPPUNIT_ASSERT_THROW( fAY->deleteTag(y1), TagIsLocked );
      // Unlock all tags in /A/mY (and delete them)
      fAY->setTagLockStatus( y1, cool_HvsTagLock_Status::UNLOCKED );
      fAY->deleteTag(y1);
      // Attempt to lock a tag in /A
      // This will fail because the tag does not exist, i.e. has no associated
      // child node tags (and note that it throws Exception, not TagNotFound)
      CPPUNIT_ASSERT_THROW
        ( sA->setTagLockStatus( a1, cool_HvsTagLock_Status::PARTIALLYLOCKED ), Exception );
      // Create /A/mX tag relation - this will create the /A tag
      fAX->createTagRelation( a1, x1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+y1, false, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_THROW( fAY->findTagRelation(a1), TagRelationNotFound );
      // Lock a tag in /A
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::PARTIALLYLOCKED );
      // Create tag relations
      // Here LOCKED and PARTIALLYLOCKED behave differently!
      fAY->createTagRelation( a1, y1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 - "+y1, y1, fAY->findTagRelation(a1) );
      // Unlock all tags in /A
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::UNLOCKED );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_tagPartiallyLocked_deleteTagRelation()
  {
    try {
      // Node hierarchy
      // -> fldset /
      // -> fldset /A
      // -> folder /A/mX
      // -> folder /A/mY
      std::string nameA = "/A";
      std::string nameAX = "/A/mX";
      std::string nameAY = "/A/mY";
      IFolderSetPtr sA  = s_db->getFolderSet( nameA );
      IFolderPtr fAX  = getAndFillFolder( nameAX );
      IFolderPtr fAY  = getAndFillFolder( nameAY );
      // Tag hierarchy for "/A    version #1"
      // -> fldset '/A    version #1'
      // -> folder '/A/mX version #1'
      // -> folder '/A/mY version #1'
      std::string a1 = "/A    version #1";
      std::string x1 = "/A/mX version #1";
      std::string y1 = "/A/mY version #1";
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+y1, false, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->findTagRelation(a1), TagNotFound );
      // Create tag relations
      fAX->createTagRelation( a1, x1 );
      fAY->createTagRelation( a1, y1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 - "+y1, y1, fAY->findTagRelation(a1) );
      // Lock a tag in /A/mY
      fAY->setTagLockStatus( y1, cool_HvsTagLock_Status::PARTIALLYLOCKED );
      // Attempt to delete tag relations
      // Deleting the /A/mY tag relation fails because the child tag would
      // be deleted and is locked (it would not fail if the child tag were
      // locked but deleteTagRelation would not lead to deleting the tag)
      fAX->deleteTagRelation( a1 );
      CPPUNIT_ASSERT_THROW( fAY->deleteTagRelation( a1 ), TagIsLocked );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagRelationNotFound );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 - "+y1, y1, fAY->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 #", 0u, fAY->countObjects(0,100,0,y1) );
      // Unlock all tags in /A/mY
      fAY->setTagLockStatus( y1, cool_HvsTagLock_Status::UNLOCKED );
      // Use tags in /A/mY for the current HEAD and lock them again
      fAY->tagCurrentHead( y1 );
      fAY->setTagLockStatus( y1, cool_HvsTagLock_Status::PARTIALLYLOCKED );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagRelationNotFound );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 - "+y1, y1, fAY->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 #", 3u, fAY->countObjects(0,100,0,y1) );
      // Attempt to delete tag relations again
      // Deleting the /A/mY tag relation does NOT fail even if the child tag is
      // locked, because deleteTagRelation would not lead to deleting the tag
      fAY->deleteTagRelation( a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 #", 3u, fAY->countObjects(0,100,0,y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->findTagRelation(a1), TagNotFound );
      // Unlock all tags in /A/mY (and delete them)
      fAY->setTagLockStatus( y1, cool_HvsTagLock_Status::UNLOCKED );
      fAY->deleteTag( y1 );
      // Create tag relations again
      fAX->createTagRelation( a1, x1 );
      fAY->createTagRelation( a1, y1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 - "+y1, y1, fAY->findTagRelation(a1) );
      // Lock a tag in /A
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::PARTIALLYLOCKED );
      // Attempt to delete tag relations - will fail as parent tag is locked
      CPPUNIT_ASSERT_THROW( fAX->deleteTagRelation( a1 ), TagIsLocked );
      CPPUNIT_ASSERT_THROW( fAY->deleteTagRelation( a1 ), TagIsLocked );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+x1, true, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 - "+x1, x1, fAX->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 #", 0u, fAX->countObjects(0,100,0,x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 - "+y1, y1, fAY->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 #", 0u, fAY->countObjects(0,100,0,y1) );
      // Unlock all tags in /A
      sA->setTagLockStatus( a1, cool_HvsTagLock_Status::UNLOCKED );
      // Delete tag relations again
      fAX->deleteTagRelation( a1 );
      fAY->deleteTagRelation( a1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 Exst "+y1, false, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAX->countObjects(0,100,0,x1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->countObjects(0,100,0,y1), TagNotFound );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  // Tests for the issues discussed in bug #22951
  void test_emptyTag()
  {
    try {
      // Node hierarchy
      // -> fldset /
      // -> fldset /A
      // -> folder /A/mX
      // -> folder /A/mY
      std::string nameA = "/A";
      std::string nameAX = "/A/mX";
      std::string nameAY = "/A/mY";
      s_db->getFolderSet( nameA );
      IFolderPtr fAX = s_db->getFolder( nameAX );
      IFolderPtr fAY = getAndFillFolder( nameAY );
      // Tag hierarchy for "/A    version #1"
      // -> fldset '/A    version #1'
      // -> folder '/A/mX version #1'
      // -> folder '/A/mY version #1'
      std::string a1 = "/A    version #1";
      std::string x1 = "/A/mX version #1";
      std::string y1 = "/A/mY version #1";
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exst "+y1, false, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAX->countObjects(0,100,0,x1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->countObjects(0,100,0,y1), TagNotFound );
      // Attempt to tag current HEAD of /A/mX (with 0 objects) fails
      CPPUNIT_ASSERT_THROW( fAX->tagCurrentHead(x1), Exception );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+a1, false, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exst "+y1, false, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAX->countObjects(0,100,0,x1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->findTagRelation(a1), TagNotFound );
      CPPUNIT_ASSERT_THROW( fAY->countObjects(0,100,0,y1), TagNotFound );
      // Create a tag relation between /A and /A/mY
      fAY->createTagRelation( a1, y1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+a1, true, s_db->existsTag(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+x1, false, s_db->existsTag(x1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exst "+y1, true, s_db->existsTag(y1) );
      CPPUNIT_ASSERT_THROW( fAX->findTagRelation(a1), TagRelationNotFound );
      CPPUNIT_ASSERT_THROW( fAX->countObjects(0,100,0,x1), TagNotFound );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 - "+y1, y1, fAY->findTagRelation(a1) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 #", 0u, fAY->countObjects(0,100,0,y1) );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  // Constructor (executed N times, _before_ all N test executions)
  HvsTagTest() : CoolDBUnitTest(), payloadSpec()
  {
    payloadSpec.extend("I",cool_StorageType_TypeId::Int32);
    payloadSpec.extend("S",cool_StorageType_TypeId::String255);
    payloadSpec.extend("X",cool_StorageType_TypeId::Float);
  }

  // Destructor (executed N times, _after_ all N test executions)
  ~HvsTagTest()
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
        createFolders();
      }
      else
      {
        refreshDB( true ); // refresh folders too
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

  // Create and fill MV folder
  IFolderPtr createAndFillMVFolder( const std::string& folderName )
  {
    FolderSpecification fSpec( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec );
    s_db->createFolder( folderName, fSpec, "MV folder" );
    return getAndFillFolder( folderName );
  }

  // Get and fill folder (SV or MV)
  IFolderPtr getAndFillFolder( const std::string& folderName )
  {
    IFolderPtr folder = s_db->getFolder( folderName );
    for ( int i = 0; i < 3; ++i ) {
      ValidityKey since = i*10;
      ValidityKey until = ValidityKeyMax;
      Record payload = dummyPayload( i );
      folder->storeObject( since, until, payload, 0 );
    }
    return folder;
  }

  // Dummy payload
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

  // Create all folders (overloads virtual base method)
  void createFolders()
  {
    s_db->createFolderSet( "/A" );
    FolderSpecification fSpecS( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    FolderSpecification fSpecM( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec );
    s_db->createFolder( "/A/sX", fSpecS, "SV folder" );
    s_db->createFolder( "/A/mX", fSpecM, "MV folder" );
    s_db->createFolder( "/A/mY", fSpecM, "MV folder" );
  }

};

CPPUNIT_TEST_SUITE_REGISTRATION( cool::HvsTagTest );

COOLTEST_MAIN( HvsTagTest )
