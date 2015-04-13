// $Id: test_RelationalObjectMgr.cpp,v 1.51 2013-03-08 11:44:45 avalassi Exp $

// Include files
#include <string>
#include <sstream>
#include <vector>
#include "CoolKernel/FolderSpecification.h"
#include "CoolKernel/InternalErrorException.h"
#include "CoolKernel/IObjectIterator.h"
#include "CoolKernel/IObject.h"
#include "CoolKernel/types.h"
#include "RelationalAccess/ICursor.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ITable.h"

// Local include files
//#define COOLUNITTESTTIMER 1
//#define COOLDBUNITTESTDEBUG 1
#include "tests/Common/CoolDBUnitTest.h"
#include "src/HvsTagRecord.h"
#include "src/RalDatabase.h"
#include "src/RelationalObjectMgr.h"
#include "src/RalQueryMgr.h"
#include "src/RalSequenceMgr.h"
#include "src/RelationalChannelTable.h"
#include "src/RelationalObject.h"
#include "src/RelationalObjectTable.h"
#include "src/RelationalObjectTableRow.h"
#include "src/RelationalPayloadTableRow.h"
#include "src/RelationalSequence.h"
#include "src/RelationalTagMgr.h"
#include "src/RelationalTransaction.h"
#include "src/SimpleObject.h"
#include "src/timeToString.h"
#include "src/TransRelFolder.h"

// Forward declaration (for easier indentation)
namespace cool
{
  class RelationalObjectMgrTest;

  /// Less than comparison functor to compare RelationalObjectTableRow
  /// by their objectId
  struct lt_ptr_objectId : public std::binary_function< RelationalObjectTableRowPtr, RelationalObjectTableRowPtr, bool>
  {
    bool operator()( const RelationalObjectTableRowPtr& lhs,
                     const RelationalObjectTableRowPtr& rhs ) const {
      return lhs->objectId() < rhs->objectId();
    }
  };

  /// Comparison functor to compare RelationalObjectTableRow by their objectId
  struct eq__ptr_objectId : public std::binary_function<RelationalObjectTableRowPtr, unsigned int, bool>
  {
    bool operator()( const RelationalObjectTableRowPtr& r,
                     unsigned int objectId ) const
    {
      return r->objectId() == objectId;
    }
  };

}

// The test class
class cool::RelationalObjectMgrTest : public cool::CoolDBUnitTest
{
  CPPUNIT_TEST_SUITE( RelationalObjectMgrTest );
  CPPUNIT_TEST( test_bulkUpdateObjectTableIov );
  CPPUNIT_TEST( test_findObject );
  CPPUNIT_TEST( test_storeObjects_SV );
  CPPUNIT_TEST( test_storeObjects_SV_backwards );
  CPPUNIT_TEST( test_storeObjects_SV_different_channel );
  CPPUNIT_TEST( test_storeObjects_empty_list );
  CPPUNIT_TEST( test_storeObjects_bulk_100 );
  CPPUNIT_TEST( test_browseObjects_SV );
  CPPUNIT_TEST( test_browseObjects_MV );
  CPPUNIT_TEST( test_browseObjects_SV_reverse );
  CPPUNIT_TEST( test_browseObjects_MV_reverse );
  CPPUNIT_TEST( test_mv_UInt64Max_iov );
  CPPUNIT_TEST( test_sv_UInt64Max_iov );
  CPPUNIT_TEST( test_storeObjects_bulk_multichannel );
  // ------ MV tests ------
  CPPUNIT_TEST( test_SimpleObject_filter );
  CPPUNIT_TEST( test_SimpleObject_intersect );
  CPPUNIT_TEST( test_SimpleObject_visisbleThrough );
  CPPUNIT_TEST( test_SimpleObject_visisbleThrough2 );
  CPPUNIT_TEST( test_processMultiVersionObjects_case_0a );
  CPPUNIT_TEST( test_processMultiVersionObjects_case_0b );
  CPPUNIT_TEST( test_processMultiVersionObjects_case_1a );
  CPPUNIT_TEST( test_processMultiVersionObjects_case_1b );
  CPPUNIT_TEST( test_processMultiVersionObjects_case_1c );
  CPPUNIT_TEST( test_processMultiVersionObjects_case_2 );
  CPPUNIT_TEST( test_processMultiVersionObjects_case_3 );
  CPPUNIT_TEST( test_processMultiVersionObjects_case_4 );
  CPPUNIT_TEST( test_processMultiVersionObjects_case_5b );
  CPPUNIT_TEST( test_updateObjectTableNewHeadId_1 );
  CPPUNIT_TEST( test_updateObjectTableNewHeadId_2 );
  CPPUNIT_TEST( test_updateObjectTableNewHeadId_3 );
  // new algo, with prefetch
  CPPUNIT_TEST( test_mergeWithHead_case_1a_prefetch );
  CPPUNIT_TEST( test_mergeWithHead_case_1b_prefetch );
  CPPUNIT_TEST( test_mergeWithHead_case_3_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_backwards );
  CPPUNIT_TEST( test_storeObjects_MV_newInsert_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_case_0a_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_case_0b_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_case_1a_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_case_2_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_case_3_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_case_4_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_case_5b_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_case_6_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_case_0a_channels_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_case_5b_6_channels_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_identicalIov_case_1_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_identicalIov_case_2_prefetch );
#ifndef WIN32
  // old algo, without prefetch (except on Windows)
  CPPUNIT_TEST( test_mergeWithHead_case_1a_no_prefetch );
  CPPUNIT_TEST( test_mergeWithHead_case_1b_no_prefetch );
  CPPUNIT_TEST( test_mergeWithHead_case_3_no_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_newInsert_no_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_case_0a_no_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_case_0b_no_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_case_1a_no_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_case_2_no_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_case_3_no_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_case_4_no_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_case_5b_no_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_case_6_no_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_case_0a_channels_no_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_case_5b_6_channels_no_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_identicalIov_case_1_no_prefetch );
  CPPUNIT_TEST( test_storeObjects_MV_identicalIov_case_2_no_prefetch );
#endif
  /// \todo these should be in a TagMgr test instead
  CPPUNIT_TEST( test_insertTagTableRow_fetchTagTableRow );
  CPPUNIT_TEST( test_insertTagTableRow_exists );
  CPPUNIT_TEST( test_insertTagTableRow_HEAD );
  CPPUNIT_TEST( test_fetchTagTableRow_notFound );
  CPPUNIT_TEST( test_existsTag_global );
  CPPUNIT_TEST( test_insertObject2TagTableRows_fetchObject2TagTableRow );
  CPPUNIT_TEST( test_tag_asOfDate_5c );
  CPPUNIT_TEST( test_tag_HEAD_5c );
  CPPUNIT_TEST( test_tag_exists );
  CPPUNIT_TEST( test_findObject_tag_5c );
  CPPUNIT_TEST( test_findObject_HEAD_5c );
  CPPUNIT_TEST( test_insertGlobalTagTableRow_fetchGlobalTagTableRow ); // DDL
  CPPUNIT_TEST( test_tag_differentFolders_sameTag ); // DDL
  CPPUNIT_TEST( test_tag_asOfObjectId_userObject_5c );
  CPPUNIT_TEST( test_deleteObject2TagTableRows );
  CPPUNIT_TEST( test_deleteTagTableRow );
  CPPUNIT_TEST( test_deleteGlobalTagTableRow );
  CPPUNIT_TEST( test_deleteTag );
  CPPUNIT_TEST( test_deleteTag_nonexisting );
  CPPUNIT_TEST( test_insertionTimeOfLastObjectInTag );
  CPPUNIT_TEST( test_updateObjectTableNewHeadId_userTag );
  CPPUNIT_TEST( test_existsUserTag );
  CPPUNIT_TEST( test_existsUserTag_normal_tag );
  CPPUNIT_TEST( test_userTag_systemObjects );
  // ----------- Channels table tests -----------
  CPPUNIT_TEST( test_insertChannelTableRow );
  CPPUNIT_TEST( test_updateChannelTable );
  CPPUNIT_TEST( test_bulkUpdateChannelTable );
  CPPUNIT_TEST( test_fetchLastRowsWithNewData );
  CPPUNIT_TEST( test_channelTableFK );
  // ----------- lastUpdate tests ---------------
  CPPUNIT_TEST( test_lastUpdate_SV );
  CPPUNIT_TEST( test_lastUpdate_MV );
  //CPPUNIT_TEST( test_svIovNotClosed_bug57502 );
  CPPUNIT_TEST_SUITE_END();

  /* COOLCPPCLEAN-NOINDENT-START *///
  // Use strdup to fix Coverity TAINTED_STRING
  // Use free to free memory allocated by strdup and fix Coverity RESOURCE_LEAK
  // See https://www.securecoding.cert.org/confluence/pages/viewpage.action?pageId=1703960
#ifndef WIN32
#define TEST_WITH_AND_WITHOUT_PREFETCH(test) \
  void test ## _prefetch() { \
    const char* env0 = getenv( "COOL_MVINSERTION_PREFETCH_MAXROWS" ); \
    char* env = ( env0 ? strdup( env0 ) : 0 ); \
    unsetenv( "COOL_MVINSERTION_PREFETCH_MAXROWS" ); \
    test(); \
    if ( env ) setenv( "COOL_MVINSERTION_PREFETCH_MAXROWS", env, 1 ); \
    if ( env ) free( env ); \
  }; \
  void test ## _no_prefetch() { \
    const char* env0 = getenv( "COOL_MVINSERTION_PREFETCH_MAXROWS" ); \
    char* env = ( env0 ? strdup( env0 ) : 0 ); \
    setenv( "COOL_MVINSERTION_PREFETCH_MAXROWS", "0", 1 ); \
    test(); \
    if ( env ) setenv( "COOL_MVINSERTION_PREFETCH_MAXROWS", env, 1 ); \
    if ( env ) free( env ); \
    else unsetenv( "COOL_MVINSERTION_PREFETCH_MAXROWS" ); \
  }
#else
  // Test only the default case on Windows
#define TEST_WITH_AND_WITHOUT_PREFETCH(test) \
  void test ## _prefetch() { \
    test(); \
  }
#endif
  /* COOLCPPCLEAN-NOINDENT-END *///

  // test with old and new algo (with and without prefetch)
  TEST_WITH_AND_WITHOUT_PREFETCH( test_mergeWithHead_case_1a );
  TEST_WITH_AND_WITHOUT_PREFETCH( test_mergeWithHead_case_1b );
  TEST_WITH_AND_WITHOUT_PREFETCH( test_mergeWithHead_case_3 );
  TEST_WITH_AND_WITHOUT_PREFETCH( test_storeObjects_MV_newInsert );
  TEST_WITH_AND_WITHOUT_PREFETCH( test_storeObjects_MV_case_0a );
  TEST_WITH_AND_WITHOUT_PREFETCH( test_storeObjects_MV_case_0b );
  TEST_WITH_AND_WITHOUT_PREFETCH( test_storeObjects_MV_case_1a );
  TEST_WITH_AND_WITHOUT_PREFETCH( test_storeObjects_MV_case_2 );
  TEST_WITH_AND_WITHOUT_PREFETCH( test_storeObjects_MV_case_3 );
  TEST_WITH_AND_WITHOUT_PREFETCH( test_storeObjects_MV_case_4 );
  TEST_WITH_AND_WITHOUT_PREFETCH( test_storeObjects_MV_case_5b );
  TEST_WITH_AND_WITHOUT_PREFETCH( test_storeObjects_MV_case_6 );
  TEST_WITH_AND_WITHOUT_PREFETCH( test_storeObjects_MV_case_0a_channels );
  TEST_WITH_AND_WITHOUT_PREFETCH( test_storeObjects_MV_case_5b_6_channels );
  TEST_WITH_AND_WITHOUT_PREFETCH( test_storeObjects_MV_identicalIov_case_1 );
  TEST_WITH_AND_WITHOUT_PREFETCH( test_storeObjects_MV_identicalIov_case_2 );

public:

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  /// Tests findObject
  void test_findObject()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    try{
      // Create a temporary sequence to get the server SYSDATE before insertion
      Time timeBef;
      std::string tmpSeqName = std::string( s_coolDBName + "_TMP_CLOCK" );
      {
        RelationalTransaction transaction( ralDb->transactionMgr() );
        if ( ralDb->queryMgr().sequenceMgr().existsSequence( tmpSeqName ) )
          ralDb->queryMgr().sequenceMgr().dropSequence( tmpSeqName );
        boost::shared_ptr<RelationalSequence> tmpSeq =
          ralDb->queryMgr().sequenceMgr().createSequence( tmpSeqName );
        tmpSeq->nextVal();
        timeBef = stringToTime( tmpSeq->currDate() ); // Time before insertion
                                                      //std::cout << "Time before insertion: " << timeBef << std::endl;
        transaction.commit();
      }
      // MySQL now() has 1 second granularity: need to sleep at least 1 second
      // (if test checks for strict < or >; not needed if checks for <= or >=)
      if ( ralDb->queryMgr().databaseTechnology() == "MySQL" ) sleep(1);
      // Insert the objects into the folder
      std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 1, 0, 2 ) );
      objs.push_back( dummyObject( 2, 2, 4 ) );
      storeObjects( relfolder, objs );
      // MySQL now() has 1 second granularity: need to sleep at least 1 second
      // (if test checks for strict < or >; not needed if checks for <= or >=)
      if ( ralDb->queryMgr().databaseTechnology() == "MySQL" ) sleep(1);
      // Get the server SYSDATE after insertion
      Time timeAft;
      {
        RelationalTransaction transaction( ralDb->transactionMgr() );
        boost::shared_ptr<RelationalSequence> tmpSeq =
          ralDb->queryMgr().sequenceMgr().getSequence( tmpSeqName );
        tmpSeq->nextVal();
        timeAft = stringToTime( tmpSeq->currDate() ); // Time before insertion
                                                      //std::cout << "Time after  insertion: " << timeAft << std::endl;
        transaction.commit();
      }
      // Cleanup - drop the temporary sequence
      {
        RelationalTransaction transaction( ralDb->transactionMgr() );
        ralDb->queryMgr().sequenceMgr().dropSequence( tmpSeqName );
        transaction.commit();
      }
      // Retrieve the first object
      RelationalTransaction transaction( ralDb->transactionMgr(), true ); // r/o
      IObjectPtr obj1 = objMgr->findObject( relfolder, 1, 0 );
      transaction.commit();
      CPPUNIT_ASSERT_MESSAGE( "first object",
                              dummyPayload( 1 ) == obj1->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "first object since",
                                    (ValidityKey)0, obj1->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "first object until",
                                    (ValidityKey)2, obj1->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "first object id",
                                    1u, obj1->objectId() );
      // Analyse the object insertion time
      Time timeIns = obj1->insertionTime();
      //std::cout << "Time before insertion: " << timeBef << std::endl;
      //std::cout << "Time at     insertion: " << timeIns << std::endl;
      //std::cout << "Time after  insertion: " << timeAft << std::endl;
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "year of insertion time is 201x",
                                    201, timeIns.year()/10 );
      CPPUNIT_ASSERT_MESSAGE( "insertion time > time before insertion",
                              timeIns > timeBef );
      CPPUNIT_ASSERT_MESSAGE( "insertion time < time after insertion",
                              timeIns < timeAft );
      // Retrieve the second object
      RelationalTransaction transaction1( ralDb->transactionMgr(), true ); // r/o
      IObjectPtr obj2 = objMgr->findObject( relfolder, 3, 0 );
      transaction1.commit();
      CPPUNIT_ASSERT_MESSAGE( "second object",
                              dummyPayload( 2 ) == obj2->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "second object since",
                                    (ValidityKey)2, obj2->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "second object until",
                                    (ValidityKey)4, obj2->until() );
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests storeObject for SV objects
  void test_storeObjects_SV()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    try
    {
      {
        std::vector<RelationalObjectPtr> objs;
        objs.push_back( dummyObject( 2, 2, ValidityKeyMax ) );
        objs.push_back( dummyObject( 4, 4, ValidityKeyMax ) );
        storeObjects( relfolder, objs );
      }
      {
        std::vector<RelationalObjectPtr> objs;
        objs.push_back( dummyObject( 6, 6, ValidityKeyMax ) );
        objs.push_back( dummyObject( 8, 8, ValidityKeyMax ) );
        storeObjects( relfolder, objs );
      }
      RelationalTransaction transaction( ralDb->transactionMgr(), true ); //r/o
      IObjectPtr obj = objMgr->findObject( relfolder, 2, 0 );
      CPPUNIT_ASSERT_MESSAGE( "first object",
                              dummyPayload( 2 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "first object since",
                                    (ValidityKey)2, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "first object until",
                                    (ValidityKey)4, obj->until() );
      obj = objMgr->findObject( relfolder, 4, 0 );
      CPPUNIT_ASSERT_MESSAGE( "second object",
                              dummyPayload( 4 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "second object since",
                                    (ValidityKey)4, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "second object until",
                                    (ValidityKey)6, obj->until() );
      obj = objMgr->findObject( relfolder, 6, 0 );
      CPPUNIT_ASSERT_MESSAGE( "third object",
                              dummyPayload( 6 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "third object since",
                                    (ValidityKey)6, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "third object until",
                                    (ValidityKey)8, obj->until() );
      obj = objMgr->findObject( relfolder, 8, 0 );
      CPPUNIT_ASSERT_MESSAGE( "fourth object",
                              dummyPayload( 8 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "fourth object since",
                                    (ValidityKey)8, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "fourth object until",
                                    ValidityKeyMax, obj->until() );
      transaction.commit();
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests storeObject for SV objects with backwards IOV
  void test_storeObjects_SV_backwards()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    try
    {
      {
        std::vector<RelationalObjectPtr> objs;
        objs.push_back( dummyObject( 2, 2, ValidityKeyMax ) );
        objs.push_back( dummyObject( 6, 10, 8 ) );
        storeObjects( relfolder, objs );
      }
    }
    catch( ValidityIntervalBackwards& )
    {
      // expected exception -> test is ok
    }
    catch ( std::exception& e )
    {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests storeObject for SV objects in different channels
  void test_storeObjects_SV_different_channel()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    folder->createChannel( 0, "0" );
    folder->createChannel( 1, "1" );
    std::vector<RelationalObjectPtr> objs;
    objs.push_back( dummyObject( 1, 0, ValidityKeyMax, 0 ) );
    objs.push_back( dummyObject( 2, 2, ValidityKeyMax, 0 ) );
    storeObjects( relfolder, objs );
    objs.clear();
    objs.push_back( dummyObject( 3, 4, ValidityKeyMax, 0 ) );
    storeObjects( relfolder, objs );
    objs.clear();
    objs.push_back( dummyObject( 4, 0, ValidityKeyMax, 1 ) );
    objs.push_back( dummyObject( 5, 2, ValidityKeyMax, 1 ) );
    storeObjects( relfolder, objs );
    objs.clear();
    objs.push_back( dummyObject( 6, 4, ValidityKeyMax, 1 ) );
    storeObjects( relfolder, objs );
    RelationalTransaction transaction( ralDb->transactionMgr(), true ); // r/o
    IObjectPtr obj = objMgr->findObject( relfolder, 0, 0 );
    CPPUNIT_ASSERT( dummyPayload( 1 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)0, obj->since() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)2, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)0, obj->channelId() );
    obj = objMgr->findObject( relfolder, 2, 0 );
    CPPUNIT_ASSERT( dummyPayload( 2 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)2, obj->since() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)4, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)0, obj->channelId() );
    obj = objMgr->findObject( relfolder, 4, 0 );
    CPPUNIT_ASSERT( dummyPayload( 3 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)4, obj->since() );
    CPPUNIT_ASSERT_EQUAL( ValidityKeyMax, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)0, obj->channelId() );
    obj = objMgr->findObject( relfolder, 0, 1 );
    CPPUNIT_ASSERT( dummyPayload( 4 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)0, obj->since() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)2, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)1, obj->channelId() );
    obj = objMgr->findObject( relfolder, 2, 1 );
    CPPUNIT_ASSERT( dummyPayload( 5 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)2, obj->since() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)4, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)1, obj->channelId() );
    obj = objMgr->findObject( relfolder, 4, 1 );
    CPPUNIT_ASSERT( dummyPayload( 6 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)4, obj->since() );
    CPPUNIT_ASSERT_EQUAL( ValidityKeyMax, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)1, obj->channelId() );
    transaction.commit();
  }

  /// Tests storeObject with an empty list of objects
  void test_storeObjects_empty_list()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    std::vector<RelationalObjectPtr> objs;
    storeObjects( relfolder, objs );
    CPPUNIT_ASSERT_MESSAGE( "reached without exception", true );
  }

  /// Tests storeObject for bulk r/w of 100 SV objects
  void test_storeObjects_bulk_100()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    std::vector<RelationalObjectPtr> objs;
    unsigned int nObjs = 100;
    for ( unsigned int i = 0; i < nObjs; ++i ) {
      objs.push_back( dummyObject( i, i, ValidityKeyMax ) );
    }
    storeObjects( relfolder, objs );
    IObjectPtr obj;
    for ( unsigned int i = 0; i < nObjs; ++i ) {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      obj = objMgr->findObject( relfolder, i, 0 );
      std::stringstream s;
      s << "object " << i << " ";
      CPPUNIT_ASSERT_MESSAGE( ( s.str() + "payload" ).c_str(),
                              dummyPayload( i ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "since" ).c_str(),
                                    (ValidityKey)i, obj->since() );
      // last object's until extends to ValidityKeyMax
      if ( i < nObjs-1 ) {
        CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "until" ).c_str(),
                                      (ValidityKey)i+1, obj->until() );
      } else {
        CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "until" ).c_str(),
                                      ValidityKeyMax, obj->until() );
      }
      transaction.commit();
    }
  }

  IObjectPtr getNext( IObjectIteratorPtr objs)
  {
    if (!objs->goToNext())
      CPPUNIT_FAIL("no next object");
    return IObjectPtr( objs->currentRef().clone() );
  }

  /// Tests bulkUpdateObjectTableIov
  void test_bulkUpdateObjectTableIov()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    {
      std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 1, 0, 1 ) );
      objs.push_back( dummyObject( 2, 10, 11 ) );
      objs.push_back( dummyObject( 3, 20, 21 ) );
      storeObjects( relfolder, objs );
    }
    std::map<unsigned int,ValidityKey> objectIdNewUntil;
    objectIdNewUntil[1] = 9;
    objectIdNewUntil[2] = 19;
    objectIdNewUntil[3] = 29;
    {
      RelationalTransaction transaction( ralDb->transactionMgr() ); // RW
      objMgr->bulkUpdateObjectTableIov( relfolder->objectTableName(),
                                        objectIdNewUntil );
      transaction.commit();
    }
    {
      RelationalTransaction transaction( ralDb->transactionMgr(), true ); // RO
      IObjectIteratorPtr objs =
        relfolder->browseObjects( ValidityKeyMin,
                                  ValidityKeyMax,
                                  ChannelSelection::all() );
      transaction.commit();
      CPPUNIT_ASSERT_EQUAL( 3u, objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Payload size", dummyPayload( 1 ).size(), obj->payload().size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Payload[I]", dummyPayload( 1 )["I"], obj->payload()["I"] );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Payload[S]", dummyPayload( 1 )["S"], obj->payload()["S"] );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Payload[X]", dummyPayload( 1 )["X"], obj->payload()["X"] );
      try {
        CPPUNIT_ASSERT( dummyPayload( 1 ) == obj->payload() );
      }
      catch (...) {
        std::cout << "Expected: " << dummyPayload( 1 ) << std::endl;
        std::cout << "Actual: " << obj->payload() << std::endl;
        throw;
      }
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Payload", (const IRecord &)dummyPayload( 1 ), obj->payload() );
      CPPUNIT_ASSERT_EQUAL( (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL( (ValidityKey)9, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT( dummyPayload( 2 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL( (ValidityKey)10, obj->since() );
      CPPUNIT_ASSERT_EQUAL( (ValidityKey)19, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT( dummyPayload( 3 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL( (ValidityKey)20, obj->since() );
      CPPUNIT_ASSERT_EQUAL( (ValidityKey)29, obj->until() );
    }
  }

  /// Tests browseObjects for a SV folder in reverse order
  void test_browseObjects_SV_reverse()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    unsigned int nObjs = 100;
    for ( ChannelId channel = 0; channel < 5; ++channel ) {
      std::vector<RelationalObjectPtr> objs;
      for ( unsigned int i = 0; i < nObjs; ++i ) {
        objs.push_back( dummyObject( i, i, ValidityKeyMax, channel ) );
      }
      storeObjects( relfolder, objs );
    }
    try {
      ValidityKey since = 50;
      ValidityKey until = 70;
      ChannelSelection channels( 2, 2,
                                 ChannelSelection::sinceDescBeforeChannel );
      std::string tag = "";
      RelationalTransaction transaction( ralDb->transactionMgr(), true ); // r/o
      IObjectIteratorPtr cursor =
        objMgr->browseObjects( relfolder, since, until, channels, tag );
      CPPUNIT_ASSERT_MESSAGE( "no cursor", cursor != 0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "size", 21u,
                                    (unsigned int)cursor->size() );
      // test content
      unsigned int nBObjs = 0;
      while ( cursor->goToNext() ) {
        IObjectPtr obj( cursor->currentRef().clone() );
        std::stringstream s;
        s << "object " << nBObjs << " ";
        CPPUNIT_ASSERT_MESSAGE
          ( ( s.str() + "payload" ).c_str(),
            dummyPayload( (int)(until - nBObjs) ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "since" ).c_str(),
                                      until - nBObjs, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "until" ).c_str(),
                                      until - nBObjs +1, obj->until() );
        ++nBObjs;
      }
      transaction.commit();
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "number of objects", 21u, nBObjs );
    } catch ( std::exception& e ) {
      std::cout << e.what() << std::endl;
      throw;
    }
  }

  /// Tests browseObjects for a MV folder in reverse order
  void test_browseObjects_MV_reverse()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    unsigned int nObjs = 100;
    for ( ChannelId channel = 0; channel < 5; ++channel ) {
      std::vector<RelationalObjectPtr> objs;
      for ( unsigned int i = 0; i < nObjs; ++i ) {
        objs.push_back( dummyObject( i, i, ValidityKeyMax, channel ) );
      }
      storeObjects( relfolder, objs );
    }
    try {
      ValidityKey since = 50;
      ValidityKey until = 70;
      ChannelSelection channels( 2, 2,
                                 ChannelSelection::sinceDescBeforeChannel );
      std::string tag = "";
      RelationalTransaction transaction( ralDb->transactionMgr() );
      IObjectIteratorPtr cursor =
        objMgr->browseObjects( relfolder, since, until, channels, tag );
      CPPUNIT_ASSERT_MESSAGE( "no cursor", cursor != 0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "size", 21u,
                                    (unsigned int)cursor->size() );
      // test content
      unsigned int nBObjs = 0;
      while ( cursor->goToNext() ) {
        IObjectPtr obj( cursor->currentRef().clone() );
        std::stringstream s;
        s << "object " << nBObjs << " ";
        CPPUNIT_ASSERT_MESSAGE
          ( ( s.str() + "payload" ).c_str(),
            dummyPayload( (int)(until - nBObjs) ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "since" ).c_str(),
                                      until - nBObjs, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "until" ).c_str(),
                                      until - nBObjs + 1, obj->until() );
        nBObjs++;
      }
      transaction.commit();
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "number of objects", 21u, nBObjs );
    } catch ( std::exception& e ) {
      std::cout << e.what() << std::endl;
      throw;
    }
  }

  /// Tests browseObjects for a SV folder
  void test_browseObjects_SV()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    unsigned int nObjs = 100;
    for ( ChannelId channel = 0; channel < 5; ++channel ) {
      std::vector<RelationalObjectPtr> objs;
      for ( unsigned int i = 0; i < nObjs; ++i ) {
        objs.push_back( dummyObject( i, i, ValidityKeyMax, channel ) );
      }
      storeObjects( relfolder, objs );
    }
    try {
      ValidityKey since = 50;
      ValidityKey until = 70;
      ChannelSelection channels( 2, 2 );
      std::string tag = "";
      RelationalTransaction transaction( ralDb->transactionMgr() );
      IObjectIteratorPtr cursor =
        objMgr->browseObjects( relfolder, since, until, channels, tag );
      CPPUNIT_ASSERT_MESSAGE( "no cursor", cursor != 0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "size", 21u,
                                    (unsigned int)cursor->size() );
      // test content
      unsigned int nBObjs = 0;
      //for ( IObjectIterator::const_iterator i = cursor->begin();
      //      i != cursor->end(); ++ i ) {
      //  IObjectPtr obj = *i;
      while ( cursor->goToNext() ) {
        IObjectPtr obj( cursor->currentRef().clone() );
        std::stringstream s;
        s << "object " << nBObjs << " ";
        CPPUNIT_ASSERT_MESSAGE
          ( ( s.str() + "payload" ).c_str(),
            dummyPayload( (int)(since+nBObjs) ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "since" ).c_str(),
                                      since + nBObjs, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "until" ).c_str(),
                                      since + nBObjs + 1, obj->until() );
        nBObjs++;
      }
      transaction.commit();
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "number of objects", 21u, nBObjs );
    } catch ( std::exception& e ) {
      std::cout << e.what() << std::endl;
      throw;
    }
  }

  /// Tests browseObjects for a MV folder
  void test_browseObjects_MV()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    unsigned int nObjs = 100;
    for ( ChannelId channel = 0; channel < 5; ++channel ) {
      std::vector<RelationalObjectPtr> objs;
      for ( unsigned int i = 0; i < nObjs; ++i ) {
        objs.push_back( dummyObject( i, i, ValidityKeyMax, channel ) );
      }
      storeObjects( relfolder, objs );
    }
    try {
      ValidityKey since = 50;
      ValidityKey until = 70;
      ChannelSelection channels( 2, 2 );
      std::string tag = "";
      RelationalTransaction transaction( ralDb->transactionMgr() );
      IObjectIteratorPtr cursor =
        objMgr->browseObjects( relfolder, since, until, channels, tag );
      CPPUNIT_ASSERT_MESSAGE( "no cursor", cursor != 0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "size", 21u,
                                    (unsigned int)cursor->size() );
      // test content
      unsigned int nBObjs = 0;
      //for ( IObjectIterator::const_iterator
      //      i = cursor->begin(); i != cursor->end(); ++ i ) {
      //  IObjectPtr obj = *i;
      while ( cursor->goToNext() ) {
        IObjectPtr obj( cursor->currentRef().clone() );
        std::stringstream s;
        s << "object " << nBObjs << " ";
        CPPUNIT_ASSERT_MESSAGE
          ( ( s.str() + "payload" ).c_str(),
            dummyPayload( (int)(since+nBObjs) ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "since" ).c_str(),
                                      since + nBObjs, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "until" ).c_str(),
                                      since + nBObjs + 1, obj->until() );
        nBObjs++;
      }
      transaction.commit();
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "number of objects", 21u, nBObjs );
    } catch ( std::exception& e ) {
      std::cout << e.what() << std::endl;
      throw;
    }
  }

  /// Checks that storing an until value of more that int63 (the current
  /// limitation) throws a ValidityKeyOutOfBoundaries exception (SV storage)
  void test_sv_UInt64Max_iov()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalObjectPtr object
      ( new RelationalObject( 0, UInt64Max, dummyPayload( 0 ), 0 ) );
    std::vector<RelationalObjectPtr> objs( 1, object );
    CPPUNIT_ASSERT_THROW(storeObjects( relfolder, objs ),
                         ValidityKeyOutOfBoundaries);
  }

  /// Checks that storing an until value of more that int63 (the current
  /// limitation) throws a ValidityKeyOutOfBoundaries exception (MV storage)
  void test_mv_UInt64Max_iov()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalObjectPtr object
      ( new RelationalObject( 0, UInt64Max, dummyPayload( 0 ), 0 ) );
    std::vector<RelationalObjectPtr> objs( 1, object );
    CPPUNIT_ASSERT_THROW(storeObjects( relfolder, objs ),
                         ValidityKeyOutOfBoundaries);
  }

  /// Tests storeObject for bulk r/w into multiple channels (SV mode)
  void test_storeObjects_bulk_multichannel()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    ChannelId nChannels = 10;
    {
      std::vector<RelationalObjectPtr> objs;
      for ( ChannelId ch = 0; ch < nChannels; ++ch ) {
        objs.push_back( dummyObject( (int)ch, (ValidityKey)0, ValidityKeyMax,
                                     ch ) );
      }
      for ( ChannelId ch = 0; ch < nChannels; ++ch ) {
        objs.push_back( dummyObject( (int)ch, (ValidityKey)5, ValidityKeyMax,
                                     ch ) );
      }
      storeObjects( relfolder, objs );
    }
    {
      std::vector<RelationalObjectPtr> objs;
      for ( ChannelId ch = 0; ch < nChannels; ++ch ) {
        objs.push_back( dummyObject( (int)ch, (ValidityKey)10, ValidityKeyMax,
                                     ch ) );
      }
      for ( ChannelId ch = 0; ch < nChannels; ++ch ) {
        objs.push_back( dummyObject( (int)ch, (ValidityKey)15, ValidityKeyMax,
                                     ch ) );
      }
      storeObjects( relfolder, objs );
    }
    unsigned int nObjs = 4;
    IObjectPtr obj;
    for ( ChannelId ch = 0; ch < nChannels; ++ch ) {
      for ( unsigned int i = 0; i < nObjs; ++i ) {
        std::stringstream s;
        s << "object " << i << ", channel " << ch << " ";
        ValidityKey pointInTime = 5 * i; // 0, 5, 10, 15
        RelationalTransaction transaction( ralDb->transactionMgr() );
        obj = objMgr->findObject( relfolder, pointInTime, ch );
        CPPUNIT_ASSERT_MESSAGE( ( s.str() + "payload" ).c_str(),
                                dummyPayload( (int)ch ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "since" ).c_str(),
                                      pointInTime, obj->since() );
        // until of object 3 extends to ValidityKeyMax
        if ( i < nObjs-1 ) {
          CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "until" ).c_str(),
                                        pointInTime +5, obj->until() );
        } else {
          CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "until" ).c_str(),
                                        ValidityKeyMax, obj->until() );
        }
        transaction.commit();
      }
    }
  }

  /// Tests SimpleObject::filter
  void test_SimpleObject_filter()
  {
    SOVector i;
    i = SimpleObject( 1, 0, 2, 3 ).filter( SimpleObject( 1, 0, 1, 2 ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 size", 1u, (unsigned int)i.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)1, i[0].since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)2, i[0].until );
    i = SimpleObject( 1, 0, 1, 2 ).filter( SimpleObject( 1, 0, 2, 3 ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 size", 1u, (unsigned int)i.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)2, i[0].since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)3, i[0].until );
    i = SimpleObject( 1, 0, 1, 3 ).filter( SimpleObject( 1, 0, 1, 2 ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 size", 0u, (unsigned int)i.size() );
    i = SimpleObject( 1, 0, 1, 3 ).filter( SimpleObject( 1, 0, 2, 3 ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 size", 0u, (unsigned int)i.size() );
    i = SimpleObject( 1, 0, 1, 2 ).filter( SimpleObject( 1, 0, 1, 2 ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 size", 0u, (unsigned int)i.size() );
    i = SimpleObject( 1, 0, 1, 4 ).filter( SimpleObject( 1, 0, 2, 3 ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 size", 0u, (unsigned int)i.size() );
    i = SimpleObject( 1, 0, 2, 3 ).filter( SimpleObject( 1, 0, 1, 4 ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 size", 2u, (unsigned int)i.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 since", (ValidityKey)1, i[0].since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 until", (ValidityKey)2, i[0].until );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 since", (ValidityKey)3, i[1].since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 until", (ValidityKey)4, i[1].until );
    i = SimpleObject( 1, 0, 2, 3 ).filter( SimpleObject( 1, 0, 1, 3 ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 size", 1u, (unsigned int)i.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 since", (ValidityKey)1, i[0].since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 until", (ValidityKey)2, i[0].until );
    i = SimpleObject( 1, 0, 1, 2 ).filter( SimpleObject( 1, 0, 1, 3 ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 size", 1u, (unsigned int)i.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 since", (ValidityKey)2, i[0].since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 until", (ValidityKey)3, i[0].until );
  }

  /// Tests SimpleObject::intersect
  void test_SimpleObject_intersect()
  {
    SOVector v( 1, SimpleObject( 1, 0, 2, 4 ) );
    SOVector i = SimpleObject( 2, 0, 2, 4 ).intersect( v );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "size", 1u, (unsigned int)i.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "objectId", 1u, i[0].objectId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since", (ValidityKey)2, i[0].since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until", (ValidityKey)4, i[0].until );
  }

  /// Tests SimpleObject::visibleThrough
  void test_SimpleObject_visisbleThrough()
  {
    SOVector v( 1, SimpleObject( 1, 0, 2, 4 ) );
    SOVector i = SimpleObject( 2, 0, 2, 4 ).visibleThrough( v );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "size", 0u, (unsigned int)i.size() );
    v.clear();
    v.push_back( SimpleObject( 1, 0, 1, 2 ) );
    v.push_back( SimpleObject( 1, 0, 3, 4 ) );
    i = SimpleObject( 2, 0, 1, 4 ).visibleThrough( v );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "size", 1u, (unsigned int)i.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since", (ValidityKey)2, i[0].since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until", (ValidityKey)3, i[0].until );
    v.clear();
    v.push_back( SimpleObject( 1, 0, 2, 3 ) );
    i = SimpleObject( 2, 0, 1, 4 ).visibleThrough( v );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "size", 2u, (unsigned int)i.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since", (ValidityKey)1, i[0].since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until", (ValidityKey)2, i[0].until );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since", (ValidityKey)3, i[1].since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until", (ValidityKey)4, i[1].until );
    v.clear();
    v.push_back( SimpleObject( 1, 0, 2, 4 ) );
    i = SimpleObject( 2, 0, 2, 4 ).visibleThrough( v );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "size", 0u, (unsigned int)i.size() );
    v.clear();
    v.push_back( SimpleObject( 1, 0, 1, 3 ) );
    v.push_back( SimpleObject( 1, 0, 6, 8 ) );
    i = SimpleObject( 2, 0, 2, 4 ).visibleThrough( v );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "size", 1u, (unsigned int)i.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since", (ValidityKey)3, i[0].since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until", (ValidityKey)4, i[0].until );
  }

  /// Tests SimpleObject::visibleThrough
  void test_SimpleObject_visisbleThrough2()
  {
    SOVector v;
    v.push_back( SimpleObject( 1, 0, 1, 3 ) );
    v.push_back( SimpleObject( 1, 0, 6, 8 ) );
    SOVector i = SimpleObject( 2, 0, 2, 4 ).visibleThrough( v );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "size", 1u, (unsigned int)i.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since", (ValidityKey)3, i[0].since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until", (ValidityKey)4, i[0].until );
  }

  /// Tests processMultiVersionObjects
  void test_processMultiVersionObjects_case_0a()
  {
    RelationalDatabasePtr dbPtr;
    std::vector<RelationalObjectPtr> objects;
    objects.push_back( dummyObject( 1, 1, 2 ) );
    objects.push_back( dummyObject( 2, 1, 2 ) );
    std::vector<RelationalObjectTableRowPtr> rows;
    std::vector<RelationalPayloadTableRowPtr> payloadRows;
    unsigned int idOffset = 1;
    std::map<unsigned int, unsigned int> idToIndex;
    std::vector<SimpleObject> splitters
      = objMgr->processMultiVersionObjects( objects, rows, payloadRows,
                                            idOffset, idToIndex );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "splitters size",
                                  1u, (unsigned int)splitters.size() );
    SimpleObject s = splitters[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 object id", 1u, s.objectId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 since", (ValidityKey)1, s.since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 until", (ValidityKey)2, s.until );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count", 2u, (unsigned int)rows.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload row count", 0u, (unsigned int)payloadRows.size() );
    RelationalObjectTableRow row = *rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)2, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 7u, row.newHeadId() );
    row = *rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)2, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 0u, row.newHeadId() );
  }

  /// Tests processMultiVersionObjects
  void test_processMultiVersionObjects_case_0b()
  {
    RelationalDatabasePtr dbPtr;
    std::vector<RelationalObjectPtr> objects;
    objects.push_back( dummyObject( 1, 2, 3 ) );
    objects.push_back( dummyObject( 2, 1, 4 ) );
    std::vector<RelationalObjectTableRowPtr> rows;
    std::vector<RelationalPayloadTableRowPtr> payloadRows;
    unsigned int idOffset = 1;
    std::map<unsigned int, unsigned int> idToIndex;
    std::vector<SimpleObject> splitters
      = objMgr->processMultiVersionObjects( objects, rows, payloadRows,
                                            idOffset, idToIndex );
    /*std::cout << "splitters:\n";
      copy( splitters.begin(), splitters.end(),
      std::ostream_iterator<SimpleObject>( std::cout, "\n" ) );*///
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "splitters size",
                                  3u, (unsigned int)splitters.size() );
    SimpleObject s = splitters[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 object id", 1u, s.objectId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 since", (ValidityKey)2, s.since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 until", (ValidityKey)3, s.until );
    s = splitters[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 2 object id", 7u, s.objectId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 2 since", (ValidityKey)1, s.since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 2 until", (ValidityKey)2, s.until );
    s = splitters[2];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 3 object id", 7u, s.objectId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 3 since", (ValidityKey)3, s.since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 3 until", (ValidityKey)4, s.until );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload row count", 0u,
                                  (unsigned int)payloadRows.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count", 2u,
                                  (unsigned int)rows.size() );
    RelationalObjectTableRow row = *rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 7u, row.newHeadId() );
    row = *rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 0u, row.newHeadId() );
  }

  /// Tests processMultiVersionObjects
  void test_processMultiVersionObjects_case_1a()
  {
    RelationalDatabasePtr dbPtr;
    std::vector<RelationalObjectPtr> objects;
    objects.push_back( dummyObject( 1, 1, 3 ) );
    objects.push_back( dummyObject( 2, 2, 4 ) );
    std::vector<RelationalObjectTableRowPtr> rows;
    std::vector<RelationalPayloadTableRowPtr> payloadRows;
    unsigned int idOffset = 1;
    std::map<unsigned int, unsigned int> idToIndex;
    std::vector<SimpleObject> splitters
      = objMgr->processMultiVersionObjects( objects, rows, payloadRows,
                                            idOffset, idToIndex );
    //copy( splitters.begin(), splitters.end(),
    //      std::ostream_iterator<SimpleObject>( std::cout, "\n" ) );
    //copy( rows.begin(), rows.end(),
    //      std::ostream_iterator<RelationalObjectTableRow>( std::cout, "\n" ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "splitters size",
                                  2u, (unsigned int)splitters.size() );
    SimpleObject s = splitters[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 object id", 1u, s.objectId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 since", (ValidityKey)1, s.since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 until", (ValidityKey)3, s.until );
    s = splitters[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 2 object id", 7u, s.objectId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 2 since", (ValidityKey)3, s.since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 2 until", (ValidityKey)4, s.until );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count", 3u, (unsigned int)rows.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "paylod row count", 0u, (unsigned int)payloadRows.size() );
    RelationalObjectTableRow row = *rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 7u, row.newHeadId() );
    row = *rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 0u, row.newHeadId() );
    row = *rows[2];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 object id", 8u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 until", (ValidityKey)2, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 original id", 1u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 new head id", 0u, row.newHeadId() );
  }

  /// Tests processMultiVersionObjects
  void test_processMultiVersionObjects_case_1b()
  {
    RelationalDatabasePtr dbPtr;
    std::vector<RelationalObjectPtr> objects;
    objects.push_back( dummyObject( 1, 2, 4 ) );
    objects.push_back( dummyObject( 2, 1, 3 ) );
    std::vector<RelationalObjectTableRowPtr> rows;
    std::vector<RelationalPayloadTableRowPtr> payloadRows;
    unsigned int idOffset = 1;
    std::map<unsigned int, unsigned int> idToIndex;
    std::vector<SimpleObject> splitters
      = objMgr->processMultiVersionObjects( objects, rows, payloadRows,
                                            idOffset, idToIndex );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "splitters size",
                                  2u, (unsigned int)splitters.size() );
    SimpleObject s = splitters[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 object id", 1u, s.objectId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 since", (ValidityKey)2, s.since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 until", (ValidityKey)4, s.until );
    s = splitters[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 2 object id", 7u, s.objectId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 2 since", (ValidityKey)1, s.since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 2 until", (ValidityKey)2, s.until );
    //copy( rows.begin(), rows.end(),
    //      std::ostream_iterator<RelationalObjectTableRow>( std::cout, "\n" ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count", 3u, (unsigned int)rows.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload row count", 0u, (unsigned int)payloadRows.size() );
    RelationalObjectTableRow row = *rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 7u, row.newHeadId() );
    row = *rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 0u, row.newHeadId() );
    row = *rows[2];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 object id", 9u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 since", (ValidityKey)3, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 original id", 1u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 new head id", 0u, row.newHeadId() );
  }

  /// Tests processMultiVersionObjects
  void test_processMultiVersionObjects_case_1c()
  {
    RelationalDatabasePtr dbPtr;
    std::vector<RelationalObjectPtr> objects;
    objects.push_back( dummyObject( 1, 1, 4 ) );
    objects.push_back( dummyObject( 2, 2, 3 ) );
    std::vector<RelationalObjectTableRowPtr> rows;
    std::vector<RelationalPayloadTableRowPtr> payloadRows;
    unsigned int idOffset = 1;
    std::map<unsigned int, unsigned int> idToIndex;
    std::vector<SimpleObject> splitters
      = objMgr->processMultiVersionObjects( objects, rows, payloadRows,
                                            idOffset, idToIndex );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "splitters size",
                                  1u, (unsigned int)splitters.size() );
    SimpleObject s = splitters[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 object id", 1u, s.objectId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 since", (ValidityKey)1, s.since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 until", (ValidityKey)4, s.until );
    //copy( rows.begin(), rows.end(),
    //      std::ostream_iterator<RelationalObjectTableRow>( std::cout, "\n" ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count", 4u, (unsigned int)rows.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload row count", 0u, (unsigned int)payloadRows.size() );
    RelationalObjectTableRow row = *rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 7u, row.newHeadId() );
    row = *rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 0u, row.newHeadId() );
    row = *rows[2];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 object id", 8u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 until", (ValidityKey)2, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 original id", 1u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 new head id", 0u, row.newHeadId() );
    row = *rows[3];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 object id", 9u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 since", (ValidityKey)3, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 original id", 1u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 new head id", 0u, row.newHeadId() );
  }

  /// Tests processMultiVersionObjects
  void test_processMultiVersionObjects_case_2()
  {
    RelationalDatabasePtr dbPtr;
    std::vector<RelationalObjectPtr> objects;
    objects.push_back( dummyObject( 1, 1, 5 ) );
    objects.push_back( dummyObject( 2, 3, 6 ) );
    objects.push_back( dummyObject( 3, 2, 4 ) );
    std::vector<RelationalObjectTableRowPtr> rows;
    std::vector<RelationalPayloadTableRowPtr> payloadRows;
    unsigned int idOffset = 1;
    std::map<unsigned int, unsigned int> idToIndex;
    std::vector<SimpleObject> splitters
      = objMgr->processMultiVersionObjects( objects, rows, payloadRows,
                                            idOffset, idToIndex );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "splitters size",
                                  2u, (unsigned int)splitters.size() );
    SimpleObject s = splitters[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 object id", 1u, s.objectId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 since", (ValidityKey)1, s.since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 until", (ValidityKey)5, s.until );
    s = splitters[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 2 object id", 7u, s.objectId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 2 since", (ValidityKey)5, s.since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 2 until", (ValidityKey)6, s.until );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count", 6u, (unsigned int)rows.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload row count", 0u, (unsigned int)payloadRows.size() );
    RelationalObjectTableRow row = *rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)5, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 7u, row.newHeadId() );
    row = *rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)3, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)6, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 13u, row.newHeadId() );
    row = *rows[2];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 object id", 8u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 original id", 1u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 new head id", 13u, row.newHeadId() );
    row = *rows[3];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 object id", 13u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 new head id", 0u, row.newHeadId() );
    row = *rows[4];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 object id", 14u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 until", (ValidityKey)2, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 original id", 8u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 new head id", 0u, row.newHeadId() );
    row = *rows[5];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 object id", 15u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 since", (ValidityKey)4, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 until", (ValidityKey)6, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 original id", 7u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 new head id", 0u, row.newHeadId() );
  }

  /// Tests processMultiVersionObjects
  void test_processMultiVersionObjects_case_3()
  {
    RelationalDatabasePtr dbPtr;
    std::vector<RelationalObjectPtr> objects;
    objects.push_back( dummyObject( 1, 1, 8 ) );
    objects.push_back( dummyObject( 2, 2, 5 ) );
    objects.push_back( dummyObject( 3, 3, 6 ) );
    objects.push_back( dummyObject( 4, 4, 7 ) );
    std::vector<RelationalObjectTableRowPtr> rows;
    std::vector<RelationalPayloadTableRowPtr> payloadRows;
    unsigned int idOffset = 1;
    std::map<unsigned int, unsigned int> idToIndex;
    std::vector<SimpleObject> splitters
      = objMgr->processMultiVersionObjects( objects, rows, payloadRows,
                                            idOffset, idToIndex );
    /*std::cout << "splitters:\n";
      copy( splitters.begin(), splitters.end(),
      std::ostream_iterator<SimpleObject>( std::cout, "\n" ) );
      std::cout << "rows:\n";
      copy( rows.begin(), rows.end(),
      std::ostream_iterator<RelationalObjectTableRow>( std::cout, "\n" ) );*///
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "splitters size",
                                  1u, (unsigned int)splitters.size() );
    SimpleObject s = splitters[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 object id", 1u, s.objectId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 since", (ValidityKey)1, s.since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 until", (ValidityKey)8, s.until );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count", 10u, (unsigned int)rows.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload row count", 0u, (unsigned int)payloadRows.size() );
    RelationalObjectTableRow row = *rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 7u, row.newHeadId() );
    row = *rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)5, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 13u, row.newHeadId() );
    row = *rows[2];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 object id", 8u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 until", (ValidityKey)2, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 original id", 1u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 new head id", 0u, row.newHeadId() );
    row = *rows[3];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 object id", 9u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 since", (ValidityKey)5, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 original id", 1u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 new head id", 13u, row.newHeadId() );
    row = *rows[4];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 object id", 13u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 since", (ValidityKey)3, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 until", (ValidityKey)6, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 new head id", 19u, row.newHeadId() );
    row = *rows[5];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 object id", 14u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 original id", 7u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 new head id", 0u, row.newHeadId() );
    row = *rows[6];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 object id", 15u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 since", (ValidityKey)6, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 original id", 9u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 new head id", 19u, row.newHeadId() );
    row = *rows[7];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 object id", 19u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 since", (ValidityKey)4, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 until", (ValidityKey)7, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 payload", std::string("Object 4"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 new head id", 0u, row.newHeadId() );
    row = *rows[8];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 object id", 20u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 since", (ValidityKey)3, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 original id", 13u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 new head id", 0u, row.newHeadId() );
    row = *rows[9];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 object id", 21u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 since", (ValidityKey)7, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 original id", 15u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 new head id", 0u, row.newHeadId() );
  }

  /// Tests processMultiVersionObjects
  void test_processMultiVersionObjects_case_4()
  {
    RelationalDatabasePtr dbPtr;
    std::vector<RelationalObjectPtr> objects;
    objects.push_back( dummyObject( 1, 1, 4 ) );
    objects.push_back( dummyObject( 2, 3, 7 ) );
    objects.push_back( dummyObject( 3, 6, 8 ) );
    objects.push_back( dummyObject( 4, 2, 5 ) );
    std::vector<RelationalObjectTableRowPtr> rows;
    std::vector<RelationalPayloadTableRowPtr> payloadRows;
    unsigned int idOffset = 1;
    std::map<unsigned int, unsigned int> idToIndex;
    std::vector<SimpleObject> splitters
      = objMgr->processMultiVersionObjects( objects, rows, payloadRows,
                                            idOffset, idToIndex );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "splitters size",
                                  3u, (unsigned int)splitters.size() );
    SimpleObject s = splitters[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 object id", 1u, s.objectId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 since", (ValidityKey)1, s.since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 until", (ValidityKey)4, s.until );
    s = splitters[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 2 object id", 7u, s.objectId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 2 since", (ValidityKey)4, s.since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 2 until", (ValidityKey)7, s.until );
    s = splitters[2];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 3 object id", 13u, s.objectId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 3 since", (ValidityKey)7, s.since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 3 until", (ValidityKey)8, s.until );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count", 8u, (unsigned int)rows.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload row count", 0u, (unsigned int)payloadRows.size() );
    RelationalObjectTableRow row = *rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 7u, row.newHeadId() );
    row = *rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)3, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)7, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 13u, row.newHeadId() );
    row = *rows[2];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 object id", 8u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 original id", 1u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 new head id", 19u, row.newHeadId() );
    row = *rows[3];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 object id", 13u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 since", (ValidityKey)6, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 new head id", 0u, row.newHeadId() );
    row = *rows[4];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 object id", 14u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 since", (ValidityKey)3, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 until", (ValidityKey)6, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 original id", 7u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 new head id", 19u, row.newHeadId() );
    row = *rows[5];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 object id", 19u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 until", (ValidityKey)5, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 payload", std::string("Object 4"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 new head id", 0u, row.newHeadId() );
    row = *rows[6];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 object id", 20u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 until", (ValidityKey)2, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 original id", 8u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 new head id", 0u, row.newHeadId() );
    row = *rows[7];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 object id", 21u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 since", (ValidityKey)5, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 until", (ValidityKey)6, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 original id", 14u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 new head id", 0u, row.newHeadId() );
  }

  /// Tests processMultiVersionObjects
  void test_processMultiVersionObjects_case_5b()
  {
    RelationalDatabasePtr dbPtr;
    std::vector<RelationalObjectPtr> objects;
    objects.push_back( dummyObject( 1, 1, 3 ) );
    objects.push_back( dummyObject( 2, 6, 8 ) );
    objects.push_back( dummyObject( 3, 2, 4 ) );
    objects.push_back( dummyObject( 4, 5, 7 ) );
    std::vector<RelationalObjectTableRowPtr> rows;
    std::vector<RelationalPayloadTableRowPtr> payloadRows;
    unsigned int idOffset = 1;
    std::map<unsigned int, unsigned int> idToIndex;
    std::vector<SimpleObject> splitters
      = objMgr->processMultiVersionObjects( objects, rows, payloadRows,
                                            idOffset, idToIndex );
    /*std::cout << "splitters:\n";
      copy( splitters.begin(), splitters.end(),
      std::ostream_iterator<SimpleObject>( std::cout, "\n" ) );
      std::cout << "rows:\n";
      copy( rows.begin(), rows.end(),
      std::ostream_iterator<RelationalObjectTableRow>( std::cout, "\n" ) );*///
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "splitters size",
                                  4u, (unsigned int)splitters.size() );
    SimpleObject s = splitters[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 object id", 1u, s.objectId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 since", (ValidityKey)1, s.since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 1 until", (ValidityKey)3, s.until );
    s = splitters[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 2 object id", 7u, s.objectId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 2 since", (ValidityKey)6, s.since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 2 until", (ValidityKey)8, s.until );
    s = splitters[2];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 3 object id", 13u, s.objectId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 3 since", (ValidityKey)3, s.since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 3 until", (ValidityKey)4, s.until );
    s = splitters[3];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 2 object id", 19u, s.objectId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 2 since", (ValidityKey)5, s.since );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "int 2 until", (ValidityKey)6, s.until );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count", 6u, (unsigned int)rows.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload row count", 0u, (unsigned int)payloadRows.size() );
    RelationalObjectTableRow row = *rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 13u, row.newHeadId() );
    row = *rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)6, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 19u, row.newHeadId() );
    row = *rows[2];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 object id", 13u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 new head id", 0u, row.newHeadId() );
    row = *rows[3];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 object id", 14u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 until", (ValidityKey)2, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 original id", 1u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 new head id", 0u, row.newHeadId() );
    row = *rows[4];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 object id", 19u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 since", (ValidityKey)5, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 until", (ValidityKey)7, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 payload", std::string("Object 4"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 new head id", 0u, row.newHeadId() );
    row = *rows[5];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 object id", 21u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 since", (ValidityKey)7, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 original id", 7u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 new head id", 0u, row.newHeadId() );
  }

  /// Tests updateObjectTableNewHeadId
  void test_updateObjectTableNewHeadId_1()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    std::vector<RelationalObjectPtr> objs;
    objs.push_back( dummyObject( 1, 1, 3 ) );
    storeObjects( relfolder, objs );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      bool fetchPayload = true;
      RelationalObjectTableRow
        row( objectTable.fetchRowForId( 1u, fetchPayload ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object_id 1", 1u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "new_head_id 1", 0u, row.newHeadId() );
      transaction.commit();
    }
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      // now update the new head id
      updateObjectTableNewHeadId( objMgr.get(),
                                  relfolder->objectTableName(),
                                  relfolder->channelTableName(),
                                  (ValidityKey)2,
                                  (ValidityKey)4,
                                  (ChannelId)0,
                                  5u );
      transaction.commit();
    }
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      bool fetchPayload = true;
      RelationalObjectTableRow
        row( objectTable.fetchRowForId( 1u, fetchPayload ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object_id 2", 1u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "new_head_id 2", 5u, row.newHeadId() );
      transaction.commit();
    }
  }

  /// Tests updateObjectTableNewHeadId
  void test_updateObjectTableNewHeadId_2()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    std::vector<RelationalObjectPtr> objs;
    objs.push_back( dummyObject( 1, 0, 2 ) );
    objs.push_back( dummyObject( 2, 2, 4 ) );
    storeObjects( relfolder, objs );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      bool fetchPayload = true;
      RelationalObjectTableRow
        row1( objectTable.fetchRowForId( 1u, fetchPayload ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object_id 1", 1u, row1.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "new_head_id 1", 0u, row1.newHeadId() );
      RelationalObjectTableRow
        row2( objectTable.fetchRowForId( 2u, fetchPayload ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object_id 2", 2u, row2.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "new_head_id 2", 0u,row2.newHeadId() );
      transaction.commit();
    }
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      // now update the new head id
      updateObjectTableNewHeadId( objMgr.get(),
                                  relfolder->objectTableName(),
                                  relfolder->channelTableName(),
                                  (ValidityKey)1,
                                  (ValidityKey)2,
                                  (ChannelId)0,
                                  5u );
      transaction.commit();
    }
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      bool fetchPayload = true;
      RelationalObjectTableRow
        row1( objectTable.fetchRowForId( 1u, fetchPayload ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object_id 3", 1u, row1.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "new_head_id 3", 5u, row1.newHeadId() );
      RelationalObjectTableRow
        row2( objectTable.fetchRowForId( 2u, fetchPayload ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object_id 4", 2u, row2.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "new_head_id 4", 0u, row2.newHeadId() );
      transaction.commit();
    }
  }

  /// Tests updateObjectTableNewHeadId
  void test_updateObjectTableNewHeadId_3()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    std::vector<RelationalObjectPtr> objs;
    objs.push_back( dummyObject( 1, 2, 4 ) );
    storeObjects( relfolder, objs );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      bool fetchPayload = true;
      RelationalObjectTableRow
        row( objectTable.fetchRowForId( 1u, fetchPayload ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object_id 1", 1u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "new_head_id 1", 0u, row.newHeadId() );
      transaction.commit();
    }
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      // now update the new head id
      updateObjectTableNewHeadId( objMgr.get(),
                                  relfolder->objectTableName(),
                                  relfolder->channelTableName(),
                                  (ValidityKey)1,
                                  (ValidityKey)3,
                                  (ChannelId)0,
                                  5u );
      transaction.commit();
    }
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      bool fetchPayload = true;
      RelationalObjectTableRow
        row( objectTable.fetchRowForId( 1u, fetchPayload ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object_id 2", 1u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "new_head_id 2", 5u, row.newHeadId() );
      transaction.commit();
    }
  }

  /// Tests mergeWithHead
  void test_mergeWithHead_case_3()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    // Prepare a persistent HEAD
    { std::vector<RelationalObjectPtr> objects;
      objects.push_back( dummyObject( 1, 1, 8 ) );
      storeObjects( relfolder, objects ); }
    // Run the prerequisite logic of storeMultiVersionObjects
    std::vector<RelationalObjectPtr> objects;
    objects.push_back( dummyObject( 2, 2, 5 ) );
    objects.push_back( dummyObject( 3, 3, 6 ) );
    objects.push_back( dummyObject( 4, 4, 7 ) );
    std::vector<RelationalObjectTableRowPtr> rows;
    std::vector<RelationalPayloadTableRowPtr> payloadRows;
    RelationalTransaction transaction( ralDb->transactionMgr() );
    boost::shared_ptr<RelationalSequence> seq
      ( ralDb->queryMgr().sequenceMgr().getSequence
        ( RelationalObjectTable::sequenceName
          ( relfolder->objectTableName() ) ) );
    unsigned int objectIdOffset = seq->currVal() +1;
    std::map<unsigned int, unsigned int> idToIndex;
    std::vector<SimpleObject> intersectors
      = objMgr->processMultiVersionObjects( objects, rows, payloadRows,
                                            objectIdOffset, idToIndex );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count 1",
                                  5u, (unsigned int)rows.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "intersector count",
                                  3u, (unsigned int)intersectors.size() );
    objMgr->mergeWithHead( relfolder, intersectors,
                           rows, idToIndex );
    sort( rows.begin(), rows.end(), lt_ptr_objectId() );
    transaction.commit();
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count 2",
                                  9u, (unsigned int)rows.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload row count 2",
                                  0u, (unsigned int)payloadRows.size() );
    RelationalObjectTableRow row = *rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)5, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 13u, row.newHeadId() );
    row = *rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 object id", 8u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 until", (ValidityKey)2, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 original id", 1u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 new head id", 0u, row.newHeadId() );
    row = *rows[2];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 object id", 9u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 since", (ValidityKey)5, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 original id", 1u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 new head id", 13u, row.newHeadId() );
    row = *rows[3];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 object id", 13u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 since", (ValidityKey)3, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 until", (ValidityKey)6, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 new head id", 19u, row.newHeadId() );
    row = *rows[4];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 object id", 14u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 original id", 7u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 new head id", 0u, row.newHeadId() );
    row = *rows[5];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 object id", 15u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 since", (ValidityKey)6, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 original id", 9u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 new head id", 19u, row.newHeadId() );
    row = *rows[6];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 object id", 19u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 since", (ValidityKey)4, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 until", (ValidityKey)7, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 payload", std::string("Object 4"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 new head id", 0u, row.newHeadId() );
    row = *rows[7];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 object id", 20u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 since", (ValidityKey)3, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 original id", 13u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 new head id", 0u, row.newHeadId() );
    row = *rows[8];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 object id", 21u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 since", (ValidityKey)7, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 original id", 15u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 new head id", 0u, row.newHeadId() );
  }

  /// Tests mergeWithHead
  void test_mergeWithHead_case_1b()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    // Prepare a persistent HEAD
    { std::vector<RelationalObjectPtr> objects;
      objects.push_back( dummyObject( 1, 2, 4 ) );
      storeObjects( relfolder, objects ); }
    // Run the prerequisite logic of storeMultiVersionObjects
    std::vector<RelationalObjectPtr> objects;
    objects.push_back( dummyObject( 2, 1, 3 ) );
    std::vector<RelationalObjectTableRowPtr> rows;
    std::vector<RelationalPayloadTableRowPtr> payloadRows;
    RelationalTransaction transaction( ralDb->transactionMgr() );
    boost::shared_ptr<RelationalSequence> seq
      ( ralDb->queryMgr().sequenceMgr().getSequence
        ( RelationalObjectTable::sequenceName
          ( relfolder->objectTableName() ) ) );
    unsigned int objectIdOffset = seq->currVal() +1;
    std::map<unsigned int, unsigned int> idToIndex;
    std::vector<SimpleObject> intersectors
      = objMgr->processMultiVersionObjects( objects, rows, payloadRows,
                                            objectIdOffset, idToIndex );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count 1", 1u,
                                  (unsigned int)rows.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "intersector count",
                                  1u, (unsigned int)intersectors.size() );
    objMgr->mergeWithHead( relfolder, intersectors,
                           rows, idToIndex );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count 2", 2u,
                                  (unsigned int)rows.size() );
    // check the persistent head
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    bool fetchPayload = true;
    RelationalObjectTableRow
      row( objectTable.fetchRowForId( 1u, fetchPayload ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 7u, row.newHeadId() );
    // and the transient rows
    row = *rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 0u, row.newHeadId() );
    row = *rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 object id", 9u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 since", (ValidityKey)3, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 original id", 1u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 new head id", 0u, row.newHeadId() );
  }

  /// Tests mergeWithHead
  void test_mergeWithHead_case_1a()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    try
    {
      // Prepare a persistent HEAD
      { std::vector<RelationalObjectPtr> objects;
        objects.push_back( dummyObject( 1, 1, 3 ) );
        storeObjects( relfolder, objects ); }
      // Run the prerequisite logic of storeMultiVersionObjects
      std::vector<RelationalObjectPtr> objects;
      objects.push_back( dummyObject( 2, 2, 4 ) );
      std::vector<RelationalObjectTableRowPtr> rows;
      std::vector<RelationalPayloadTableRowPtr> payloadRows;
      RelationalTransaction transaction( ralDb->transactionMgr() );
      boost::shared_ptr<RelationalSequence> seq
        ( ralDb->queryMgr().sequenceMgr().getSequence
          ( RelationalObjectTable::sequenceName
            ( relfolder->objectTableName() ) ) );
      unsigned int objectIdOffset = seq->currVal() +1;
      std::map<unsigned int, unsigned int> idToIndex;
      std::vector<SimpleObject> intersectors
        = objMgr->processMultiVersionObjects( objects, rows, payloadRows,
                                              objectIdOffset, idToIndex );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count 1",
                                    1u, (unsigned int)rows.size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "intersector count",
                                    1u, (unsigned int)intersectors.size() );
      objMgr->mergeWithHead( relfolder, intersectors,
                             rows, idToIndex );
      //copy( rows.begin(), rows.end(),
      //      std::ostream_iterator<RelationalObjectTableRow>( std::cout, "\n" ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count 2",
                                    2u, (unsigned int)rows.size() );
      // check the persistent head
      RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
      bool fetchPayload = true;
      RelationalObjectTableRow
        row( objectTable.fetchRowForId( 1u, fetchPayload ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)1, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)3, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                    row["S"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 7u, row.newHeadId() );
      // and the transient rows
      row = *rows[0];
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)2, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)4, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                    row["S"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 0u, row.newHeadId() );
      row = *rows[1];
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 object id", 8u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 since", (ValidityKey)1, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 until", (ValidityKey)2, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 payload", std::string("Object 1"),
                                    row["S"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 original id", 1u, row.originalId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 new head id", 0u, row.newHeadId() );
    } catch ( std::exception& e ) {
      std::cout << e.what() << std::endl;
      throw;
    }
  }

  /// Tests the writing of all object attributes in the MV mode
  void test_storeObjects_MV_newInsert()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    try
    {
      std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 2, 2, 10 ) );
      storeObjects( relfolder, objs );
      unsigned int object_id = 1;
      RelationalTransaction transaction( ralDb->transactionMgr() );
      RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
      bool fetchPayload = true;
      RelationalObjectTableRow
        row( objectTable.fetchRowForId( object_id, fetchPayload ) );
      transaction.commit();
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object_id", 1u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel id", 0u, row.channelId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "since", (ValidityKey)2, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "until", (ValidityKey)10, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
          timeToString(row.insertionTime()).size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "field I", 2,
                                    row["I"].data<int>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "field S", std::string("Object 2"),
                                    row["S"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "field X", 0.002f,
                                    row["X"].data<float>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "original id", 0u, row.originalId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "new_head id", 0u, row.newHeadId() );
    } catch ( std::exception& e ) {
      std::cout << e.what() << std::endl;
      throw;
    }
  }

  /// Tests storeObjects in MV mode when inserting over an object with
  /// identical IOVs
  /// Followup on bug report by Marco Clemencic 2005-03-17
  void test_storeObjects_MV_identicalIov_case_2()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 1, 0, 2 ) );
      objs.push_back( dummyObject( 2, 2, 4 ) );
      storeObjects( relfolder, objs ); }
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 3, 0, 2 ) );
      storeObjects( relfolder, objs ); }
    RelationalTransaction transaction( ralDb->transactionMgr() );
    {
      coral::ITable& objectTable =
        ralDb->session().nominalSchema().tableHandle
        ( relfolder->objectTableName() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count",
                                    3u, rowCount( objectTable ) );
    }
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    bool fetchPayload = true;
    RelationalObjectTableRow
      row( objectTable.fetchRowForId( 1u, fetchPayload ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)2, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 13u, row.newHeadId() );
    row = objectTable.fetchRowForId( 7u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 13u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 object id", 13u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 since", (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 until", (ValidityKey)2, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 new head id", 0u, row.newHeadId() );
  }

  /// Tests storeObjects in MV mode when inserting over an object with
  /// identical IOVs
  /// Followup on bug report by Marco Clemencic 2005-03-17
  void test_storeObjects_MV_identicalIov_case_1()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 1, 0, 2 ) );
      objs.push_back( dummyObject( 2, 2, 4 ) );
      storeObjects( relfolder, objs ); }
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 3, 2, 4 ) );
      storeObjects( relfolder, objs ); }
    RelationalTransaction transaction( ralDb->transactionMgr() );
    {
      coral::ITable& objectTable =
        ralDb->session().nominalSchema().tableHandle
        ( relfolder->objectTableName() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count",
                                    3u, rowCount( objectTable ) );
    }
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    bool fetchPayload = true;
    RelationalObjectTableRow
      row( objectTable.fetchRowForId( 1u, fetchPayload ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)2, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 7u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 13u, row.newHeadId() );
    row = objectTable.fetchRowForId( 13u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 object id", 13u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 new head id", 0u, row.newHeadId() );
  }

  /// Tests storeObjects in MV mode for different channels
  /// This stores the same objects as the single channel test case_5b
  /// into channel 1 and those from case_6 into channel 0
  void test_storeObjects_MV_case_5b_6_channels()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    { // begin case_5b storage in channel 1
      ChannelId ch = 1;
      { std::vector<RelationalObjectPtr> objs;
        objs.push_back( dummyObject( 1, 1, 3, ch ) );
        objs.push_back( dummyObject( 2, 6, 8, ch ) );
        storeObjects( relfolder, objs ); }
      { std::vector<RelationalObjectPtr> objs;
        objs.push_back( dummyObject( 3, 2, 4, ch ) );
        objs.push_back( dummyObject( 4, 5, 7, ch ) );
        storeObjects( relfolder, objs ); }
    } // end
    { // begin case_6 storage in channel 2
      ChannelId ch = 2;
      { std::vector<RelationalObjectPtr> objs;
        objs.push_back( dummyObject( 1, 7, 9, ch ) );
        objs.push_back( dummyObject( 2, 6, 7, ch ) );
        objs.push_back( dummyObject( 3, 1, 5, ch ) );
        storeObjects( relfolder, objs ); }
      { std::vector<RelationalObjectPtr> objs;
        objs.push_back( dummyObject( 4, 2, 3, ch ) );
        objs.push_back( dummyObject( 5, 4, 8, ch ) );
        storeObjects( relfolder, objs ); }
    } // end
    RelationalTransaction transaction( ralDb->transactionMgr() );
    {
      coral::ITable& objectTable =
        ralDb->session().nominalSchema().tableHandle
        ( relfolder->objectTableName() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count",
                                    15u, rowCount( objectTable ) );
    }
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    // read back objects in channel 1
    bool fetchPayload = true;
    RelationalObjectTableRow
      row( objectTable.fetchRowForId( 1u, fetchPayload ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 channel id", 1u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 13u, row.newHeadId() );
    row = objectTable.fetchRowForId( 7u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 channel id", 1u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)6, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 19u, row.newHeadId() );
    row = objectTable.fetchRowForId( 13u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 object id", 13u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 channel id", 1u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 14u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 object id", 14u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 channel id", 1u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 until", (ValidityKey)2, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 original id", 1u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 19u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 object id", 19u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 channel id", 1u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 since", (ValidityKey)5, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 until", (ValidityKey)7, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 payload", std::string("Object 4"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 21u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 object id", 21u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 channel id", 1u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 since", (ValidityKey)7, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 original id", 7u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 new head id", 0u, row.newHeadId() );
    // read back objects in channel 2
    row = objectTable.fetchRowForId( 25u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 object id", 25u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 channel id", 2u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 since", (ValidityKey)7, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 until", (ValidityKey)9, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 new head id", 49u, row.newHeadId() );
    row = objectTable.fetchRowForId( 31u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 object id", 31u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 channel id", 2u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 since", (ValidityKey)6, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 until", (ValidityKey)7, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 new head id", 49u, row.newHeadId() );
    row = objectTable.fetchRowForId( 37u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 object id", 37u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 channel id", 2u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 until", (ValidityKey)5, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 new head id", 43u, row.newHeadId() );
    row = objectTable.fetchRowForId( 43u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 object id", 43u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 channel id", 2u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 payload", std::string("Object 4"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 44u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "11 object id", 44u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "11 channel id", 2u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "11 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "11 until", (ValidityKey)2, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "11 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "11 original id", 37u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "11 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 45u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "12 object id", 45u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "12 channel id", 2u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "12 since", (ValidityKey)3, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "12 until", (ValidityKey)5, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "12 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "12 original id", 37u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "12 new head id", 49u, row.newHeadId() );
    row = objectTable.fetchRowForId( 49u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "13 object id", 49u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "13 channel id", 2u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "13 since", (ValidityKey)4, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "13 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "13 payload", std::string("Object 5"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "13 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "13 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 50u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "14 object id", 50u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "14 channel id", 2u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "14 since", (ValidityKey)3, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "14 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "14 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "14 original id", 45u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "14 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 51u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "15 object id", 51u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "15 channel id", 2u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "15 since", (ValidityKey)8, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "15 until", (ValidityKey)9, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "15 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "15 original id", 25u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "15 new head id", 0u, row.newHeadId() );
  }

  /// Tests storeObjects in MV mode in different channels
  void test_storeObjects_MV_case_0a_channels()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    { std::vector<RelationalObjectPtr> objs;
      ChannelId ch = 0;
      objs.push_back( dummyObject( 1, 2, 4, ch ) );
      storeObjects( relfolder, objs ); }
    { std::vector<RelationalObjectPtr> objs;
      ChannelId ch = 1;
      objs.push_back( dummyObject( 2, 2, 4, ch ) );
      storeObjects( relfolder, objs ); }
    RelationalTransaction transaction( ralDb->transactionMgr() );
    {
      coral::ITable& objectTable = ralDb->session().nominalSchema().tableHandle
        ( relfolder->objectTableName() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count",
                                    2u, rowCount( objectTable ) );
    }
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    bool fetchPayload = true;
    RelationalObjectTableRow
      row( objectTable.fetchRowForId( 1u, fetchPayload ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 7u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 channel id", 1u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 0u, row.newHeadId() );
  }

  /// Tests storeObjects in MV mode
  void test_storeObjects_MV_case_6()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 1, 7, 9 ) );
      objs.push_back( dummyObject( 2, 6, 7 ) );
      objs.push_back( dummyObject( 3, 1, 5 ) );
      storeObjects( relfolder, objs ); }
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 4, 2, 3 ) );
      objs.push_back( dummyObject( 5, 4, 8 ) );
      storeObjects( relfolder, objs ); }
    RelationalTransaction transaction( ralDb->transactionMgr() );
    {
      coral::ITable& objectTable = ralDb->session().nominalSchema().tableHandle
        ( relfolder->objectTableName() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count",
                                    9u, rowCount( objectTable ) );
    }
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    bool fetchPayload = true;
    RelationalObjectTableRow
      row( objectTable.fetchRowForId( 1u, fetchPayload ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)7, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)9, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 25u, row.newHeadId() );
    row = objectTable.fetchRowForId( 7u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)6, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)7, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 25u, row.newHeadId() );
    row = objectTable.fetchRowForId( 13u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 object id", 13u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 until", (ValidityKey)5, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 new head id", 19u, row.newHeadId() );
    row = objectTable.fetchRowForId( 19u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 object id", 19u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 payload", std::string("Object 4"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 20u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 object id", 20u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 until", (ValidityKey)2, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 original id", 13u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 21u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 object id", 21u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 since", (ValidityKey)3, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 until", (ValidityKey)5, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 original id", 13u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 new head id", 25u, row.newHeadId() );
    row = objectTable.fetchRowForId( 25u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 object id", 25u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 since", (ValidityKey)4, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 payload", std::string("Object 5"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 26u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 object id", 26u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 since", (ValidityKey)3, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 original id", 21u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 27u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 object id", 27u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 since", (ValidityKey)8, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 until", (ValidityKey)9, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 original id", 1u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 new head id", 0u, row.newHeadId() );
  }

  /// Tests storeObjects in MV mode
  void test_storeObjects_MV_case_5b()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 1, 1, 3 ) );
      objs.push_back( dummyObject( 2, 6, 8 ) );
      storeObjects( relfolder, objs ); }
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 3, 2, 4 ) );
      objs.push_back( dummyObject( 4, 5, 7 ) );
      storeObjects( relfolder, objs ); }
    RelationalTransaction transaction( ralDb->transactionMgr() );
    {
      coral::ITable& objectTable = ralDb->session().nominalSchema().tableHandle
        ( relfolder->objectTableName() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count",
                                    6u, rowCount( objectTable ) );
    }
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    bool fetchPayload = true;
    RelationalObjectTableRow
      row( objectTable.fetchRowForId( 1u, fetchPayload ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 13u, row.newHeadId() );
    row = objectTable.fetchRowForId( 7u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)6, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 19u, row.newHeadId() );
    row = objectTable.fetchRowForId( 13u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 object id", 13u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 14u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 object id", 14u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 until", (ValidityKey)2, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 original id", 1u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 19u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 object id", 19u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 since", (ValidityKey)5, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 until", (ValidityKey)7, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 payload", std::string("Object 4"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 21u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 object id", 21u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 since", (ValidityKey)7, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 original id", 7u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 new head id", 0u, row.newHeadId() );
  }

  /// Tests storeObjects in MV mode
  void test_storeObjects_MV_case_4()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 1, 1, 4 ) );
      storeObjects( relfolder, objs ); }
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 2, 3, 7 ) );
      objs.push_back( dummyObject( 3, 6, 8 ) );
      objs.push_back( dummyObject( 4, 2, 5 ) );
      storeObjects( relfolder, objs ); }
    RelationalTransaction transaction( ralDb->transactionMgr() );
    {
      coral::ITable& objectTable = ralDb->session().nominalSchema().tableHandle
        ( relfolder->objectTableName() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count",
                                    8u, rowCount( objectTable ) );
    }
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    bool fetchPayload = true;
    RelationalObjectTableRow
      row( objectTable.fetchRowForId( 1u, fetchPayload ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 7u, row.newHeadId() );
    row = objectTable.fetchRowForId( 7u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)3, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)7, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 13u, row.newHeadId() );
    row = objectTable.fetchRowForId( 8u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 object id", 8u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 original id", 1u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 new head id", 19u, row.newHeadId() );
    row = objectTable.fetchRowForId( 13u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 object id", 13u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 since", (ValidityKey)6, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 14u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 object id", 14u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 since", (ValidityKey)3, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 until", (ValidityKey)6, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 original id", 7u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 new head id", 19u, row.newHeadId() );
    row = objectTable.fetchRowForId( 19u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 object id", 19u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 until", (ValidityKey)5, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 payload", std::string("Object 4"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 20u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 object id", 20u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 until", (ValidityKey)2, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 original id", 8u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 21u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 object id", 21u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 since", (ValidityKey)5, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 until", (ValidityKey)6, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 original id", 14u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 new head id", 0u, row.newHeadId() );
  }

  /// Tests storeObjects in MV mode
  void test_storeObjects_MV_case_3()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 1, 1, 8 ) );
      storeObjects( relfolder, objs ); }
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 2, 2, 5 ) );
      objs.push_back( dummyObject( 3, 3, 6 ) );
      objs.push_back( dummyObject( 4, 4, 7 ) );
      storeObjects( relfolder, objs ); }
    RelationalTransaction transaction( ralDb->transactionMgr() );
    {
      coral::ITable& objectTable = ralDb->session().nominalSchema().tableHandle
        ( relfolder->objectTableName() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count",
                                    10u, rowCount( objectTable ) );
    }
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    bool fetchPayload = true;
    RelationalObjectTableRow
      row( objectTable.fetchRowForId( 1u, fetchPayload ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 7u, row.newHeadId() );
    row = objectTable.fetchRowForId( 7u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)5, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 13u, row.newHeadId() );
    row = objectTable.fetchRowForId( 8u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 object id", 8u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 until", (ValidityKey)2, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 original id", 1u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 9u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 object id", 9u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 since", (ValidityKey)5, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 original id", 1u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 new head id", 13u, row.newHeadId() );
    row = objectTable.fetchRowForId( 13u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 object id", 13u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 since", (ValidityKey)3, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 until", (ValidityKey)6, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 new head id", 19u, row.newHeadId() );
    row = objectTable.fetchRowForId( 14u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 object id", 14u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 original id", 7u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 15u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 object id", 15u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 since", (ValidityKey)6, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 original id", 9u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 new head id", 19u, row.newHeadId() );
    row = objectTable.fetchRowForId( 19u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 object id", 19u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 since", (ValidityKey)4, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 until", (ValidityKey)7, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 payload", std::string("Object 4"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 20u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 object id", 20u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 since", (ValidityKey)3, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 original id", 13u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 21u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 object id", 21u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 since", (ValidityKey)7, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 original id", 15u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 new head id", 0u, row.newHeadId() );
    transaction.commit();
  }

  /// Tests storeObjects in MV mode
  void test_storeObjects_MV_case_2()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 1, 1, 5 ) );
      objs.push_back( dummyObject( 2, 3, 6 ) );
      storeObjects( relfolder, objs ); }
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 3, 2, 4 ) );
      storeObjects( relfolder, objs ); }
    RelationalTransaction transaction( ralDb->transactionMgr() );
    {
      coral::ITable& objectTable = ralDb->session().nominalSchema().tableHandle
        ( relfolder->objectTableName() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count",
                                    6u, rowCount( objectTable ) );
    }
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    bool fetchPayload = true;
    RelationalObjectTableRow
      row( objectTable.fetchRowForId( 1u, fetchPayload ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)5, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 7u, row.newHeadId() );
    row = objectTable.fetchRowForId( 7u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)3, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)6, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 13u, row.newHeadId() );
    row = objectTable.fetchRowForId( 8u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 object id", 8u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 original id", 1u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 new head id", 13u, row.newHeadId() );
    row = objectTable.fetchRowForId( 13u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 object id", 13u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 14u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 object id", 14u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 until", (ValidityKey)2, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 original id", 8u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 15u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 object id", 15u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 since", (ValidityKey)4, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 until", (ValidityKey)6, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 original id", 7u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 new head id", 0u, row.newHeadId() );
  }

  /// Tests storeObjects in MV mode
  void test_storeObjects_MV_case_1a()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    { std::vector<RelationalObjectPtr>
        objs( 1, dummyObject( 1, 1, 3 ) );
      storeObjects( relfolder, objs ); }
    { std::vector<RelationalObjectPtr>
        objs( 1, dummyObject( 2, 2, 4 ) );
      storeObjects( relfolder, objs ); }
    RelationalTransaction transaction( ralDb->transactionMgr() );
    {
      coral::ITable& objectTable = ralDb->session().nominalSchema().tableHandle
        ( relfolder->objectTableName() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count",
                                    3u, rowCount( objectTable ) );
    }
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    bool fetchPayload = true;
    RelationalObjectTableRow
      row( objectTable.fetchRowForId( 1u, fetchPayload ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 7u, row.newHeadId() );
    row = objectTable.fetchRowForId( 7u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 8u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 object id", 8u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 until", (ValidityKey)2, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 original id", 1u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 new head id", 0u, row.newHeadId() );
  }

  /// Tests storeObjects in MV mode
  void test_storeObjects_MV_case_0b()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 1, 2, 3 ) );
      storeObjects( relfolder, objs ); }
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 2, 1, 4 ) );
      storeObjects( relfolder, objs ); }
    RelationalTransaction transaction( ralDb->transactionMgr() );
    {
      coral::ITable& objectTable = ralDb->session().nominalSchema().tableHandle
        ( relfolder->objectTableName() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count",
                                    2u, rowCount( objectTable ) );
    }
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    bool fetchPayload = true;
    RelationalObjectTableRow
      row( objectTable.fetchRowForId( 1u, fetchPayload ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 7u, row.newHeadId() );
    row = objectTable.fetchRowForId( 7u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)4, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 0u, row.newHeadId() );
  }

  /// Tests storeObjects in MV mode
  void test_storeObjects_MV_case_0a()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    try
    {
      {
        std::vector<RelationalObjectPtr>
          objs( 1, dummyObject( 1, 2, 4 ) );
        storeObjects( relfolder, objs );
      }
      {
        std::vector<RelationalObjectPtr>
          objs( 1, dummyObject( 2, 2, 4 ) );
        storeObjects( relfolder, objs );
      }
      RelationalTransaction transaction( ralDb->transactionMgr() );
      {
        coral::ITable& objectTable =
          ralDb->session().nominalSchema().tableHandle
          ( relfolder->objectTableName() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count",
                                      2u, rowCount( objectTable ) );
      }
      RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
      bool fetchPayload = true;
      RelationalObjectTableRow
        row( objectTable.fetchRowForId( 1u, fetchPayload ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)2, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)4, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                    row["S"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 7u, row.newHeadId() );
      row = objectTable.fetchRowForId( 7u, fetchPayload );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)2, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)4, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                    row["S"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 0u, row.newHeadId() );
    } catch ( std::exception& e ) {
      std::cout << e.what() << std::endl;
      throw;
    }
  }

  /// Tests storeObject for MV objects with backwards IOV
  void test_storeObjects_MV_backwards()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    try
    {
      {
        std::vector<RelationalObjectPtr> objs;
        objs.push_back( dummyObject( 2, 2, ValidityKeyMax ) );
        objs.push_back( dummyObject( 6, 10, 8 ) );
        storeObjects( relfolder, objs );
      }
    }
    catch( ValidityIntervalBackwards& )
    {
      // expected exception -> test is ok
    }
    catch ( std::exception& e )
    {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }


  /// Tests a combination of insertTagTableRow and fetchTagTableRow
  void test_insertTagTableRow_fetchTagTableRow()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    unsigned int tagId =
      ralDb->tagMgr().createTag( relfolder->id(), "mytagA", "desc A" ).id();
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "tag A id", 1u, tagId );
    tagId =
      ralDb->tagMgr().createTag( relfolder->id(), "mytagB", "desc B" ).id();
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "tag B id", 2u, tagId );
    RelationalTableRow row =
      ralDb->tagMgr().fetchGlobalTagTableRows( "mytagB" )[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "id", 2u, row["TAG_ID"].data<unsigned int>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "name", std::string("mytagB"), row["TAG_NAME"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "description", std::string("desc B"),
        row["TAG_DESCRIPTION"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
        row["SYS_INSTIME"].data<std::string>().size() );
    transaction.commit();
  }

  /// Tests insertTagTableRow if a tag already exists
  void test_insertTagTableRow_exists()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    ralDb->tagMgr().createTag( relfolder->id(), "mytagA", "desc A" );
    CPPUNIT_ASSERT_THROW( ralDb->tagMgr().createTag( relfolder->id(),
                                                     "mytagA", "desc A" ),
                          TagExists );
    transaction.commit();
  }

  /// Tests insertTagTableRow to confirm that trying to insert "HEAD"
  /// throws an exception
  void test_insertTagTableRow_HEAD()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    try {
      ralDb->tagMgr().createTag( relfolder->id(), "HEAD", "" );
      CPPUNIT_FAIL( "inserting HEAD tag did not throw" );
    } catch ( TagExists& /* ignored */ ) { }
    try {
      ralDb->tagMgr().createTag( relfolder->id(), "head", "" );
      CPPUNIT_FAIL( "inserting head tag did not throw" );
    } catch ( TagExists& /* ignored */ ) { }
    try {
      ralDb->tagMgr().createTag( relfolder->id(), "Head", "" );
      CPPUNIT_FAIL( "inserting Head tag did not throw" );
    } catch ( TagExists& /* ignored */ ) { }
    transaction.commit();
  }

  /// Tests fetchTagTableRow for a nonexisting tag
  void test_fetchTagTableRow_notFound()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    ralDb->tagMgr().createTag( relfolder->id(), "mytagA", "desc A" );
    CPPUNIT_ASSERT_THROW( ralDb->tagMgr().fetchGlobalTagTableRows( "mytagB" )[0],
                          TagNotFound );
    transaction.commit();
  }

  /// Tests the global version of existsTag
  void test_existsTag_global()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->storeObject( 0, 4, dummyPayload( 0 ), 0 );
    folder->tagCurrentHead( "mytagA", "" );
    CPPUNIT_ASSERT_MESSAGE( "positive", s_db->existsTag( "mytagA" ) );
    CPPUNIT_ASSERT_MESSAGE( "negative", ! s_db->existsTag( "mytagB" ) );
    FolderSpecification fSpec( FolderVersioning::MULTI_VERSION, payloadSpec );
    folder = s_db->createFolder( "/myfolder2", fSpec, "my description" );
    folder->storeObject( 0, 4, dummyPayload( 0 ), 0 );
    folder->tagCurrentHead( "mytagC", "" );
    CPPUNIT_ASSERT_MESSAGE( "positive", s_db->existsTag( "mytagC" ) );
  }

  /// Tests a combination of insertObject2TagTableRows and
  /// fetchObject2TagTableRow
  void test_insertObject2TagTableRows_fetchObject2TagTableRow()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 1, 1, 3 ) );
      objs.push_back( dummyObject( 2, 6, 8 ) );
      storeObjects( relfolder, objs ); }
    RelationalTransaction transaction( ralDb->transactionMgr() );
    boost::shared_ptr<RelationalSequence> seq
      ( ralDb->queryMgr().sequenceMgr().getSequence
        ( RelationalObjectTable::sequenceName
          ( relfolder->objectTableName() ) ) );
    Time now = stringToTime( seq->currDate() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::vector<RelationalObjectTableRow> rows =
      objectTable.fetchRowsForTaggingHeadAsOfDate( now, relfolder->payloadMode() );
    unsigned int tagId =
      ralDb->tagMgr().createTag( relfolder->id(), "mytagA", "desc A" ).id();
    std::string insertionTime = seq->currDate();
    relfolder->insertObject2TagTableRows( relfolder->object2TagTableName(),
                                          tagId,
                                          insertionTime,
                                          rows,
                                          relfolder->payloadMode() );
    coral::ITable& table =
      ralDb->session().nominalSchema().tableHandle
      ( relfolder->object2TagTableName() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count", 2u, rowCount( table ) );
    unsigned int objectId = 1;
    RelationalTableRow row = ralDb->fetchObject2TagTableRow
      ( relfolder->object2TagTableName(), tagId, objectId, relfolder->payloadMode() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "1 tag id", 1u, row["TAG_ID"].data<unsigned int>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "1 obj id", 1u, row["OBJECT_ID"].data<unsigned int>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "1 channel", (ChannelId)0, row["CHANNEL_ID"].data<ChannelId>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "1 since", (ValidityKey)1, row["IOV_SINCE"].data<ValidityKey>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "1 until", (ValidityKey)3, row["IOV_UNTIL"].data<ValidityKey>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "instime", insertionTime, row["SYS_INSTIME"].data<std::string>() );
    objectId = 7;
    row = ralDb->fetchObject2TagTableRow
      ( relfolder->object2TagTableName(), tagId, objectId, relfolder->payloadMode() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "2 tag id", 1u, row["TAG_ID"].data<unsigned int>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "2 obj id", 7u, row["OBJECT_ID"].data<unsigned int>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "2 channel", (ChannelId)0, row["CHANNEL_ID"].data<ChannelId>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "2 since", (ValidityKey)6, row["IOV_SINCE"].data<ValidityKey>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "2 until", (ValidityKey)8, row["IOV_UNTIL"].data<ValidityKey>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "instime", insertionTime, row["SYS_INSTIME"].data<std::string>() );
    transaction.commit();
  }

  /// Tests tagging the HEAD as of a given date
  void test_tag_asOfDate_5c()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    try
    {
      { std::vector<RelationalObjectPtr> objs;
        objs.push_back( dummyObject( 1, 1, 3 ) );
        objs.push_back( dummyObject( 2, 6, 8 ) );
        storeObjects( relfolder, objs ); }
      RelationalTransaction t1( ralDb->transactionMgr() );
      boost::shared_ptr<RelationalSequence> seq
        ( ralDb->queryMgr().sequenceMgr().getSequence
          ( RelationalObjectTable::sequenceName
            ( relfolder->objectTableName() ) ) );
      Time asOfDate = stringToTime( seq->currDate() );
      asOfDate = addOneNsToTime( asOfDate );
      t1.commit();
      // MySQL now() has 1 second granularity: need to sleep at least 1 second
      if ( ralDb->queryMgr().databaseTechnology() == "MySQL" ) sleep(1);
      //std::cout << "### Before 2nd insert: " << timeToString(asOfDate) << std::endl;
      { std::vector<RelationalObjectPtr> objs;
        objs.push_back( dummyObject( 3, 2, 4 ) );
        objs.push_back( dummyObject( 4, 3, 5 ) );
        storeObjects( relfolder, objs ); }
      folder->tagHeadAsOfDate( asOfDate, "mytagA", "a tag A" );
      folder->tagHeadAsOfDate( asOfDate, "mytagB", "a tag B" );
      RelationalTransaction transaction( ralDb->transactionMgr() );
      {
        coral::ITable& table =
          ralDb->session().nominalSchema().tableHandle
          ( relfolder->tagTableName() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tag table row count",
                                      2u, rowCount( table ) );
        // check tag table content (more detailed test in the insert/fetch test)
        RelationalTableRow row =
          ralDb->tagMgr().fetchGlobalTagTableRows( "mytagB" )[0];
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "id", 2u, row["TAG_ID"].data<unsigned int>() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "name", std::string("mytagB"), row["TAG_NAME"].data<std::string>() );
      }
      {
        coral::ITable& table =
          ralDb->session().nominalSchema().tableHandle
          ( relfolder->object2TagTableName() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj2tag table row count",
                                      4u, rowCount( table ) );
        // check tag2iov table content
        unsigned int tagId = 2;
        RelationalTableRow row = ralDb->fetchObject2TagTableRow
          ( relfolder->object2TagTableName(), tagId, 1u, relfolder->payloadMode() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "1 since", (ValidityKey)1, row["IOV_SINCE"].data<ValidityKey>() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "1 until", (ValidityKey)3, row["IOV_UNTIL"].data<ValidityKey>() );
        row = ralDb->fetchObject2TagTableRow
          ( relfolder->object2TagTableName(), tagId, 7u, relfolder->payloadMode() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "1 since", (ValidityKey)6, row["IOV_SINCE"].data<ValidityKey>() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "1 until", (ValidityKey)8, row["IOV_UNTIL"].data<ValidityKey>() );
      }
    } catch ( std::exception& e ) {
      std::cout << std::endl << e.what() << std::endl;
      throw;
    }
  }

  /// Tests tagging the HEAD
  void test_tag_HEAD_5c()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 1, 1, 3 ) );
      objs.push_back( dummyObject( 2, 6, 8 ) );
      storeObjects( relfolder, objs ); }
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 3, 2, 4 ) );
      objs.push_back( dummyObject( 4, 3, 5 ) );
      storeObjects( relfolder, objs ); }
    folder->tagCurrentHead( "mytagA", "a tag A" );
    folder->tagCurrentHead( "mytagB", "a tag B" );
    RelationalTransaction transaction( ralDb->transactionMgr() );
    {
      coral::ITable& table =
        ralDb->session().nominalSchema().tableHandle( relfolder->tagTableName() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "tag table row count",
                                    2u, rowCount( table ) );
      // check tag table content (more detailed test in the insert/fetch test)
      RelationalTableRow row =
        ralDb->tagMgr().fetchGlobalTagTableRows( "mytagB" )[0];
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "id", 2u, row["TAG_ID"].data<unsigned int>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "name", std::string("mytagB"), row["TAG_NAME"].data<std::string>() );
    }
    {
      coral::ITable& table =
        ralDb->session().nominalSchema().tableHandle
        ( relfolder->object2TagTableName() );
      // 4 rows from each tag
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj2tag table row count",
                                    8u, rowCount( table ) );
      // check tag2iov table content
      unsigned int tagId = 2;
      RelationalTableRow row = ralDb->fetchObject2TagTableRow
        ( relfolder->object2TagTableName(), tagId, 14u, relfolder->payloadMode() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "1 since", (ValidityKey)1, row["IOV_SINCE"].data<ValidityKey>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "1 until", (ValidityKey)2, row["IOV_UNTIL"].data<ValidityKey>() );
      row = ralDb->fetchObject2TagTableRow
        ( relfolder->object2TagTableName(), tagId, 20u, relfolder->payloadMode() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "1 since", (ValidityKey)2, row["IOV_SINCE"].data<ValidityKey>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "1 until", (ValidityKey)3, row["IOV_UNTIL"].data<ValidityKey>() );
      row = ralDb->fetchObject2TagTableRow
        ( relfolder->object2TagTableName(), tagId, 19u, relfolder->payloadMode() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "1 since", (ValidityKey)3, row["IOV_SINCE"].data<ValidityKey>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "1 until", (ValidityKey)5, row["IOV_UNTIL"].data<ValidityKey>() );
      row = ralDb->fetchObject2TagTableRow
        ( relfolder->object2TagTableName(), tagId, 7u, relfolder->payloadMode() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "1 since", (ValidityKey)6, row["IOV_SINCE"].data<ValidityKey>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "1 until", (ValidityKey)8, row["IOV_UNTIL"].data<ValidityKey>() );
    }
  }

  /// Tests tagging with an existing tag throws an exception
  void test_tag_exists()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    std::vector<RelationalObjectPtr> objs;
    objs.push_back( dummyObject( 1, 1, 3 ) );
    objs.push_back( dummyObject( 2, 6, 8 ) );
    storeObjects( relfolder, objs );
    folder->tagCurrentHead( "mytagA", "a tag A" );
    CPPUNIT_ASSERT_THROW( folder->tagCurrentHead( "mytagA", "a tag A" ),
                          TagExists );
  }

  /// Tests findObject for a tag
  void test_findObject_tag_5c()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 1, 1, 3 ) );
      objs.push_back( dummyObject( 2, 6, 8 ) );
      storeObjects( relfolder, objs ); }
    folder->tagCurrentHead( "mytagA", "a tag A" );
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 3, 2, 4 ) );
      objs.push_back( dummyObject( 4, 3, 5 ) );
      storeObjects( relfolder, objs ); }
    RelationalTransaction transaction( ralDb->transactionMgr(), false ); // r/o
    IObjectPtr obj
      = objMgr->findObject( relfolder,
                            (ValidityKey)2,
                            (ChannelId)0,
                            "mytagA" );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object id", 1u, obj->objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel id", 0u, obj->channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since", (ValidityKey)1, obj->since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until", (ValidityKey)3, obj->until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload", std::string("Object 1"),
                                  obj->payload()["S"].data<std::string>() );
    transaction.commit();
  }

  /// Tests findObject for the HEAD
  void test_findObject_HEAD_5c()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 1, 1, 3 ) );
      objs.push_back( dummyObject( 2, 6, 8 ) );
      storeObjects( relfolder, objs ); }
    folder->tagCurrentHead( "mytagA", "a tag A" );
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 3, 2, 4 ) );
      objs.push_back( dummyObject( 4, 3, 5 ) );
      storeObjects( relfolder, objs ); }
    RelationalTransaction transaction( ralDb->transactionMgr(), false ); // r/o
    IObjectPtr obj
      = objMgr->findObject( relfolder,
                            (ValidityKey)2,
                            (ChannelId)0,
                            "HEAD" );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object id", 20u, obj->objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel id", 0u, obj->channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since", (ValidityKey)2, obj->since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until", (ValidityKey)3, obj->until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload", std::string("Object 3"),
                                  obj->payload()["S"].data<std::string>() );
    transaction.commit();
  }

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  /// Tests a combination of insertGlobalTagTableRow and fetchGlobalTagTableRow
  void test_insertGlobalTagTableRow_fetchGlobalTagTableRow()
  {
    ScopedRecreateFolders theCleaner( this );
    s_db->createFolderSet( "/fs1" ); // Make sure node 1 exists
    s_db->createFolderSet( "/fs1/fs2" ); // Needed to create node 3
    s_db->createFolderSet( "/fs1/fs2/fs3" ); // Make sure node 3 exists
    RelationalTransaction transaction( ralDb->transactionMgr() );
    Time now;
    ralDb->tagMgr().insertGlobalTagTableRow
      ( 1, 1, "mytagA", HvsTagLock::UNLOCKED, "desc A", timeToString( now ) );
    ralDb->tagMgr().insertGlobalTagTableRow
      ( 3, 2, "mytagB", HvsTagLock::UNLOCKED, "desc B", timeToString( now ) );
    RelationalTableRow row =
      ralDb->tagMgr().fetchGlobalTagTableRows( "mytagB" )[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "folder id", 3u,
        row["NODE_ID"].data<unsigned int>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "tag id", 2u,
        row["TAG_ID"].data<unsigned int>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "name", std::string("mytagB"),
        row["TAG_NAME"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "description", std::string("desc B"),
        row["TAG_DESCRIPTION"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
        row["SYS_INSTIME"].data<std::string>().size() );
    transaction.commit();
  }

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  /// Tests global uniqueness of tags -- tagging in a folder with a tag
  /// that exists in another folder throws an exception
  void test_tag_differentFolders_sameTag()
  {
    ScopedRecreateFolders theCleaner( this );
    FolderSpecification fSpec( FolderVersioning::MULTI_VERSION, payloadSpec );
    IFolderPtr folder1 = s_db->createFolder( "/myfolderA", fSpec, "my description" );
    IFolderPtr folder2 = s_db->createFolder( "/myfolderB", fSpec, "my description" );
    RelationalTransaction transaction( ralDb->transactionMgr() ); // read-write
    folder1 = ralDb->getFolder( "/myfolderA" );
    folder2 = ralDb->getFolder( "/myfolderB" );
    RelationalFolder* f1 = dynamic_cast<RelationalFolder*>(folder1.get());
    RelationalFolder* f2 = dynamic_cast<RelationalFolder*>(folder2.get());
    f1->storeObject( 0, 4, dummyPayload( 0 ), 0 );
    f2->storeObject( 0, 4, dummyPayload( 0 ), 0 );
    f1->tagCurrentHead( "tag A", "desc" );
    CPPUNIT_ASSERT_THROW( f2->tagCurrentHead( "tag A", "desc" ), TagExists );
    transaction.commit();
  }

  /// Tests tagging the HEAD as of a given object_id (for a user object)
  void test_tag_asOfObjectId_userObject_5c()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 1, 1, 3 ) );
      objs.push_back( dummyObject( 2, 6, 8 ) );
      storeObjects( relfolder, objs ); }
    { std::vector<RelationalObjectPtr> objs;
      objs.push_back( dummyObject( 3, 2, 4 ) );
      objs.push_back( dummyObject( 4, 3, 5 ) );
      storeObjects( relfolder, objs ); }
    // Ultimately this could be set from a storeObjects return value:
    //   objectId = storeObjects( relfolder, objs );
    unsigned int objectId = 7;
    // WARNING! The tag asOfDate and asOfObjectId used to take compatible
    // arguments (implicit conversion from unsigned int to Time)
    {
      RelationalTransaction transaction( ralDb->transactionMgr() ); // read-write
      relfolder->tagHeadAsOfObjectId
        ( objectId,   "mytagA", "tag from user object" );
      relfolder->tagHeadAsOfObjectId
        ( objectId+1, "mytagB", "tag from left sys object" );
      relfolder->tagHeadAsOfObjectId
        ( objectId+2, "mytagC", "tag from right sys object" );
      transaction.commit();
    }
    RelationalTransaction transaction( ralDb->transactionMgr() );
    {
      coral::ITable& table =
        ralDb->session().nominalSchema().tableHandle( relfolder->tagTableName() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "tag table row count",
                                    3u, rowCount( table ) );
      // check tag table content (more detailed test in the insert/fetch test)
      RelationalTableRow row =
        ralDb->tagMgr().fetchGlobalTagTableRows( "mytagB" )[0];
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "id", 2u, row["TAG_ID"].data<unsigned int>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "name", std::string("mytagB"), row["TAG_NAME"].data<std::string>() );
    }
    {
      coral::ITable& table =
        ralDb->session().nominalSchema().tableHandle
        ( relfolder->object2TagTableName() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj2tag table row count",
                                    6u, rowCount( table ) );
      // check tag2iov table content
      unsigned int tagId = 2;
      RelationalTableRow row = ralDb->fetchObject2TagTableRow
        ( relfolder->object2TagTableName(), tagId, 1u, relfolder->payloadMode() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "1 since", (ValidityKey)1, row["IOV_SINCE"].data<ValidityKey>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "1 until", (ValidityKey)3, row["IOV_UNTIL"].data<ValidityKey>() );
      row = ralDb->fetchObject2TagTableRow
        ( relfolder->object2TagTableName(), tagId, 7u, relfolder->payloadMode() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "1 since", (ValidityKey)6, row["IOV_SINCE"].data<ValidityKey>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "1 until", (ValidityKey)8, row["IOV_UNTIL"].data<ValidityKey>() );
    }
  }

  /// Tests that deleteTag throws a TagNotFound exception when deleting
  /// a nonexisting tag.
  void test_deleteTag_nonexisting()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->storeObject( 0, 4, dummyPayload( 0 ), 0 );
    folder->tagCurrentHead( "tagA" );
    CPPUNIT_ASSERT_THROW( folder->deleteTag( "nonexisting tag" ),
                          TagNotFound );
  }

  /// Tests deleteTag
  void test_deleteTag()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    try
    {
      folder->storeObject( 0, 4, dummyPayload( 0 ), 0 );
      folder->tagCurrentHead( "tagA" );
      folder->tagCurrentHead( "tagB" );
      folder->deleteTag( "tagA" );
      CPPUNIT_ASSERT_MESSAGE( "tagA deleted", ! s_db->existsTag( "tagA" ) );
      folder->storeObject( 2, 6, dummyPayload( 1 ), 0 );
      folder->tagCurrentHead( "tagA" );
      // fetch tagA
      //std::cout << "fetch objects in tagA" << std::endl;
      IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                       ValidityKeyMax,
                                                       (ChannelId)0,
                                                       "tagA" );
      //std::cout << "tagA object count is " << objs->size() << std::endl;
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagA object count", 2u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "tagA obj 1 payload",
                              dummyPayload( 0 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagA obj 1 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagA obj 1 until",
                                    (ValidityKey)2, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "tagA obj 2 payload",
                              dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagA obj 2 since",
                                    (ValidityKey)2, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagA obj 2 until",
                                    (ValidityKey)6, obj->until() );
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests deleteGlobalTagTableRow
  void test_deleteGlobalTagTableRow()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->storeObject( 0, 4, dummyPayload( 0 ), 0 );
    folder->storeObject( 2, 6, dummyPayload( 1 ), 0 );
    folder->storeObject( 4, 8, dummyPayload( 2 ), 0 );
    folder->tagCurrentHead( "tagA" );
    folder->storeObject( 0, 5, dummyPayload( 3 ), 0 );
    folder->storeObject( 3, 7, dummyPayload( 4 ), 0 );
    folder->storeObject( 5, 9, dummyPayload( 5 ), 0 );
    folder->tagCurrentHead( "tagB" );
    RelationalTransaction transaction( ralDb->transactionMgr() );
    coral::ITable& table = ralDb->session().nominalSchema().tableHandle
      ( ralDb->globalTagTableName() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count before delete",
                                  2u, rowCount( table ) );
    // Delete the first tagA (we know it has id = 1 in a new db)
    // We need to delete from the object2tag table first or we violate
    // the integrity constraint.
    unsigned int tagId = 1;
    ralDb->tagMgr().deleteGlobalTagTableRow( folder->id(), tagId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count after delete",
                                  1u, rowCount( table ) );
    // Check the values of the remaining row
    RelationalTableRow row =
      ralDb->tagMgr().fetchGlobalTagTableRows( "tagB" )[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "tag id", 2u,
                                  row["TAG_ID"].data<unsigned int>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "tag name", std::string("tagB"),
                                  row["TAG_NAME"].data<std::string>() );
    transaction.commit();
  }

  /// Tests deleteTagTableRow
  void test_deleteTagTableRow()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    folder->storeObject( 0, 4, dummyPayload( 0 ), 0 );
    folder->storeObject( 2, 6, dummyPayload( 1 ), 0 );
    folder->storeObject( 4, 8, dummyPayload( 2 ), 0 );
    folder->tagCurrentHead( "tagA" );
    folder->storeObject( 0, 5, dummyPayload( 3 ), 0 );
    folder->storeObject( 3, 7, dummyPayload( 4 ), 0 );
    folder->storeObject( 5, 9, dummyPayload( 5 ), 0 );
    folder->tagCurrentHead( "tagB" );
    RelationalTransaction transaction( ralDb->transactionMgr() );
    coral::ITable& table = ralDb->session().nominalSchema().tableHandle
      ( ralDb->globalTagTableName() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count before delete",
                                  2u, rowCount( table ) );
    // Delete the first tagA (we know it has id = 1 in a new db)
    // We need to delete from the object2tag table first or we violate
    // the integrity constraint.
    unsigned int tagId = 1;
    relfolder->deleteObject2TagTableRows
      ( relfolder->object2TagTableName(), tagId );
    ralDb->tagMgr().deleteGlobalTagTableRow( folder->id(), tagId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count after delete",
                                  1u, rowCount( table ) );
    // Check the values of the remaining row
    RelationalTableRow row
      = ralDb->tagMgr().fetchGlobalTagTableRows( "tagB" )[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 tag id", 2u,
                                  row["TAG_ID"].data<unsigned int>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 obj id", std::string("tagB"),
                                  row["TAG_NAME"].data<std::string>() );
    transaction.commit();
  }

  /// Tests deleteObject2TagTableRows
  void test_deleteObject2TagTableRows()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    folder->storeObject( 0, 4, dummyPayload( 0 ), 0 );
    folder->storeObject( 2, 6, dummyPayload( 1 ), 0 );
    folder->storeObject( 4, 8, dummyPayload( 2 ), 0 );
    folder->tagCurrentHead( "tagA" );
    folder->storeObject( 0, 5, dummyPayload( 3 ), 0 );
    folder->storeObject( 3, 7, dummyPayload( 4 ), 0 );
    folder->storeObject( 5, 9, dummyPayload( 5 ), 0 );
    folder->tagCurrentHead( "tagB" );
    RelationalTransaction transaction( ralDb->transactionMgr() );
    coral::ITable& table = ralDb->session().nominalSchema().tableHandle
      ( relfolder->object2TagTableName() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count before delete",
                                  6u, rowCount( table ) );
    // Delete the first tagA (we know it has id = 1 in a new db)
    unsigned int tagId = 1;
    relfolder->deleteObject2TagTableRows
      ( relfolder->object2TagTableName(), tagId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count after delete",
                                  3u, rowCount( table ) );
    // Check the values of the remaining rows (tagB == tagId 2)
    tagId = 2;
    unsigned int objectId = 26;
    RelationalTableRow row = ralDb->fetchObject2TagTableRow
      ( relfolder->object2TagTableName(), tagId, objectId, relfolder->payloadMode() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "1 tag id", 2u, row["TAG_ID"].data<unsigned int>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "1 obj id", 26u, row["OBJECT_ID"].data<unsigned int>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "1 since", (ValidityKey)0, row["IOV_SINCE"].data<ValidityKey>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "1 until", (ValidityKey)3, row["IOV_UNTIL"].data<ValidityKey>() );
    objectId = 31;
    row = ralDb->fetchObject2TagTableRow
      ( relfolder->object2TagTableName(), tagId, objectId, relfolder->payloadMode() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "2 tag id", 2u, row["TAG_ID"].data<unsigned int>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "2 obj id", 31u, row["OBJECT_ID"].data<unsigned int>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "2 since", (ValidityKey)5, row["IOV_SINCE"].data<ValidityKey>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "2 until", (ValidityKey)9, row["IOV_UNTIL"].data<ValidityKey>() );
    objectId = 32;
    row = ralDb->fetchObject2TagTableRow
      ( relfolder->object2TagTableName(), tagId, objectId, relfolder->payloadMode() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "3 tag id", 2u, row["TAG_ID"].data<unsigned int>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "3 obj id", 32u, row["OBJECT_ID"].data<unsigned int>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "3 since", (ValidityKey)3, row["IOV_SINCE"].data<ValidityKey>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "3 until", (ValidityKey)5, row["IOV_UNTIL"].data<ValidityKey>() );
    transaction.commit();
  }

  /// Tests insertionTimeOfLastObjectInTag (bug #40812 and task #16559)
  void test_insertionTimeOfLastObjectInTag()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->storeObject( 0, 4, dummyPayload( 0 ), 0 );
    IObjectPtr obj0 = folder->findObject( 1, 0 );
    Time lastObjectInsTime0 = obj0->insertionTime();
    folder->tagCurrentHead( "tag A" );
    folder->storeObject( 1, 5, dummyPayload( 1 ), 0 );
    folder->storeObject( 2, 6, dummyPayload( 2 ), 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "tag time #0",
        lastObjectInsTime0,
        folder->insertionTimeOfLastObjectInTag( "tag A" ) );
    // test user tags (bug #40812)
    folder->storeObject( 3, 8, dummyPayload( 3 ), 0, "tag B" );
    IObjectPtr obj3 = folder->findObject( 3, 0, "tag B" );
    Time lastObjectInsTime3  = obj3->insertionTime();
    folder->storeObject( 4, 9, dummyPayload( 3 ), 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "user tag time #3",
        lastObjectInsTime3,
        folder->insertionTimeOfLastObjectInTag( "tag B" ) );
    // test updates of user tags (task #16559)
    sleep(1); // make sure time #5 > time #3 (bug #93118)
    folder->storeObject( 5, 10, dummyPayload( 5 ), 0, "tag B" );
    IObjectPtr obj5 = folder->findObject( 3, 0, "tag B" );
    Time lastObjectInsTime5  = obj5->insertionTime();
    folder->storeObject( 6, 11, dummyPayload( 3 ), 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "user tag time #5",
        lastObjectInsTime5,
        folder->insertionTimeOfLastObjectInTag( "tag B" ) );
    CPPUNIT_ASSERT_MESSAGE
      ( "user tag time #5 > user tag time #3",
        lastObjectInsTime5 > lastObjectInsTime3 );
  }

  /// Tests that user tagged objects correctly create system objects
  /// in their 'tag space'
  void test_userTag_systemObjects()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    ChannelId ch = 0;
    folder->storeObject( 0, 10, dummyPayload( 1 ), ch, "A" );
    folder->storeObject( 1, 5, dummyPayload( 2 ), ch, "A" );
    RelationalTransaction transaction( ralDb->transactionMgr() );
    coral::ITable& table = ralDb->session().nominalSchema().tableHandle
      ( relfolder->objectTableName() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count", 8u, rowCount( table ) );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    bool fetchPayload = true;
    RelationalObjectTableRow
      row( objectTable.fetchRowForId( 1u, fetchPayload ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since", (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until", (ValidityKey)10
                                  , row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "user tag id", 0u, row.userTagId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "new head id", 7u, row.newHeadId() );
    row = objectTable.fetchRowForId( 4u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object id", 4u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since", (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until", (ValidityKey)10, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "user tag id", 1u, row.userTagId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "new head id", 10u, row.newHeadId() );
    row = objectTable.fetchRowForId( 7u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until", (ValidityKey)5, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "user tag id", 0u, row.userTagId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 8u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object id", 8u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since", (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until", (ValidityKey)1, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "user tag id", 0u, row.userTagId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "original id", 1u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 9u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object id", 9u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since", (ValidityKey)5, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until", (ValidityKey)10, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "user tag id", 0u, row.userTagId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "original id", 1u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 10u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object id", 10u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until", (ValidityKey)5, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "user tag id", 1u, row.userTagId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 11u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object id", 11u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since", (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until", (ValidityKey)1, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "user tag id", 1u, row.userTagId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "original id", 4u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "new head id", 0u, row.newHeadId() );
    row = objectTable.fetchRowForId( 12u, fetchPayload );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object id", 12u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since", (ValidityKey)5, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until", (ValidityKey)10, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "user tag id", 1u, row.userTagId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "original id", 4u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "new head id", 0u, row.newHeadId() );
    transaction.commit();
  }

  /// Tests existsUserTag behavior in concert with normal tags
  void test_existsUserTag_normal_tag()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    CPPUNIT_ASSERT_MESSAGE( "no user tag yet",
                            ! folder->existsUserTag( "A" ) );
    CPPUNIT_ASSERT_MESSAGE( "no tag yet", ! s_db->existsTag( "A" ) );
    folder->storeObject( 0, 10, dummyPayload( 1 ), (ChannelId)0 );
    folder->tagCurrentHead( "A" );
    CPPUNIT_ASSERT_MESSAGE( "user tag does not exist",
                            ! folder->existsUserTag( "A" ) );
    CPPUNIT_ASSERT_MESSAGE( "tag exists", s_db->existsTag( "A" ) );
  }

  /// Tests existsUserTag
  void test_existsUserTag()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    CPPUNIT_ASSERT_MESSAGE( "no user tag yet",
                            ! folder->existsUserTag( "A" ) );
    CPPUNIT_ASSERT_MESSAGE( "no tag yet", ! s_db->existsTag( "A" ) );
    folder->storeObject( 0, 10, dummyPayload( 1 ), (ChannelId)0, "A" );
    CPPUNIT_ASSERT_MESSAGE( "user tag exists",
                            folder->existsUserTag( "A" ) );
    CPPUNIT_ASSERT_MESSAGE( "tag exists", s_db->existsTag( "A" ) );
  }

  /// Tests updateObjectTableNewHeadId for a given user tag id and makes
  /// sure the userTagId parameter correctly selects the intended row
  /// for updating.
  void test_updateObjectTableNewHeadId_userTag()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    // this creates two objects, ids 1 (tagId 0) and 4 (tagId 1)
    folder->storeObject( 0, 10, dummyPayload( 1 ), (ChannelId)0, "A" );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      bool fetchPayload = true;
      RelationalObjectTableRow
        row( objectTable.fetchRowForId( 1u, fetchPayload ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object_id 1", 1u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "new_head_id 1", 0u,row.newHeadId() );
      row = objectTable.fetchRowForId( 4u, fetchPayload );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object_id 2", 4u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "new_head_id 2", 0u,row.newHeadId() );
      transaction.commit();
    }
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      // now update the new head ids
      unsigned int newHeadId = 5;
      unsigned int userTagId = 0;
      updateObjectTableNewHeadId( objMgr.get(),
                                  relfolder->objectTableName(),
                                  relfolder->channelTableName(),
                                  (ValidityKey)2,
                                  (ValidityKey)4,
                                  (ChannelId)0,
                                  newHeadId,
                                  userTagId );
      newHeadId = 6;
      userTagId = 1;
      updateObjectTableNewHeadId( objMgr.get(),
                                  relfolder->objectTableName(),
                                  relfolder->channelTableName(),
                                  (ValidityKey)2,
                                  (ValidityKey)4,
                                  (ChannelId)0,
                                  newHeadId,
                                  userTagId );
      transaction.commit();
    }
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      bool fetchPayload = true;
      RelationalObjectTableRow
        row( objectTable.fetchRowForId( 1u, fetchPayload ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object_id 3", 1u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "new_head_id 3", 5u,row.newHeadId() );
      row = objectTable.fetchRowForId( 4u, fetchPayload );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object_id 4", 4u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "new_head_id 4", 6u,row.newHeadId() );
      transaction.commit();
    }
  }

  // Test insertChannelTableRow
  void test_insertChannelTableRow()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalObjectMgr objMgr( *ralDb );
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      objMgr.insertChannelTableRow( relfolder->channelTableName(),
                                    (ChannelId)1,
                                    2u,
                                    true,
                                    "ch name",
                                    "ch desc" );
      transaction.commit();
    }
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      RelationalChannelTable channelTable( *ralDb, *relfolder );
      RelationalTableRow row = channelTable.fetchRowForId( 1 );
      CPPUNIT_ASSERT_EQUAL
        ( (ChannelId)1, row["CHANNEL_ID"].data<ChannelId>() );
      CPPUNIT_ASSERT_EQUAL
        ( 2u, row["LAST_OBJECT_ID"].data<unsigned int>() );
      CPPUNIT_ASSERT_EQUAL
        ( true, row["HAS_NEW_DATA"].data<bool>() );
      CPPUNIT_ASSERT_EQUAL
        ( std::string("ch name"), row["CHANNEL_NAME"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL
        ( std::string("ch desc"), row["DESCRIPTION"].data<std::string>() );
      transaction.commit();
    }
  }

  // Test updateChannelTable
  void test_updateChannelTable()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    try
    {
      RelationalObjectMgr objMgr( *ralDb );
      {
        RelationalTransaction transaction( ralDb->transactionMgr() );
        objMgr.updateChannelTable
          ( relfolder->channelTableName(), (ChannelId)2, 0, true );
        transaction.commit();
      }
      {
        RelationalTransaction transaction( ralDb->transactionMgr() );
        RelationalChannelTable channelTable( *ralDb, *relfolder );
        RelationalTableRow row = channelTable.fetchRowForId( 2 );
        CPPUNIT_ASSERT_EQUAL
          ( (ChannelId)2, row["CHANNEL_ID"].data<ChannelId>() );
        CPPUNIT_ASSERT_EQUAL
          ( 0u, row["LAST_OBJECT_ID"].data<unsigned int>() );
        CPPUNIT_ASSERT_EQUAL
          ( true, row["HAS_NEW_DATA"].data<bool>() );
        CPPUNIT_ASSERT_EQUAL
          ( std::string(""), row["CHANNEL_NAME"].data<std::string>() );
        transaction.commit();
      }
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  // Test bulkUpdateChannelTable
  void test_bulkUpdateChannelTable()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    try
    {
      RelationalObjectMgr objMgr( *ralDb );
      {
        RelationalTransaction transaction( ralDb->transactionMgr() );
        // use updateChannelTable to populate the channels table
        objMgr.updateChannelTable
          ( relfolder->channelTableName(), (ChannelId)2, 0, true );
        objMgr.updateChannelTable
          ( relfolder->channelTableName(), (ChannelId)3, 0, false );
        objMgr.updateChannelTable
          ( relfolder->channelTableName(), (ChannelId)4, 0, true );
        objMgr.updateChannelTable
          ( relfolder->channelTableName(), (ChannelId)5, 0, false );
        std::map< ChannelId, unsigned int > updateDataMap;
        updateDataMap[3] = 30;
        updateDataMap[4] = 40;
        objMgr.bulkUpdateChannelTable
          ( relfolder->channelTableName(), updateDataMap, false );
        transaction.commit();
      }
      {
        RelationalTransaction transaction( ralDb->transactionMgr() );
        RelationalChannelTable channelTable( *ralDb, *relfolder );
        RelationalTableRow row = channelTable.fetchRowForId( 2 );
        CPPUNIT_ASSERT_EQUAL
          ( (ChannelId)2, row["CHANNEL_ID"].data<ChannelId>() );
        CPPUNIT_ASSERT_EQUAL
          ( 0u, row["LAST_OBJECT_ID"].data<unsigned int>() );
        CPPUNIT_ASSERT_EQUAL
          ( true, row["HAS_NEW_DATA"].data<bool>() );
        CPPUNIT_ASSERT_EQUAL
          ( std::string(""), row["CHANNEL_NAME"].data<std::string>() );
        transaction.commit();
      }
      {
        RelationalTransaction transaction( ralDb->transactionMgr() );
        RelationalChannelTable channelTable( *ralDb, *relfolder );
        RelationalTableRow row = channelTable.fetchRowForId( 3 );
        CPPUNIT_ASSERT_EQUAL
          ( (ChannelId)3, row["CHANNEL_ID"].data<ChannelId>() );
        CPPUNIT_ASSERT_EQUAL
          ( 30u, row["LAST_OBJECT_ID"].data<unsigned int>() );
        CPPUNIT_ASSERT_EQUAL
          ( false, row["HAS_NEW_DATA"].data<bool>() );
        CPPUNIT_ASSERT_EQUAL
          ( std::string(""), row["CHANNEL_NAME"].data<std::string>() );
        transaction.commit();
      }
      {
        RelationalTransaction transaction( ralDb->transactionMgr() );
        RelationalChannelTable channelTable( *ralDb, *relfolder );
        RelationalTableRow row = channelTable.fetchRowForId( 4 );
        CPPUNIT_ASSERT_EQUAL
          ( (ChannelId)4, row["CHANNEL_ID"].data<ChannelId>() );
        CPPUNIT_ASSERT_EQUAL
          ( 40u, row["LAST_OBJECT_ID"].data<unsigned int>() );
        CPPUNIT_ASSERT_EQUAL
          ( false, row["HAS_NEW_DATA"].data<bool>() );
        CPPUNIT_ASSERT_EQUAL
          ( std::string(""), row["CHANNEL_NAME"].data<std::string>() );
        transaction.commit();
      }
      {
        RelationalTransaction transaction( ralDb->transactionMgr() );
        RelationalChannelTable channelTable( *ralDb, *relfolder );
        RelationalTableRow row = channelTable.fetchRowForId( 5 );
        CPPUNIT_ASSERT_EQUAL
          ( (ChannelId)5, row["CHANNEL_ID"].data<ChannelId>() );
        CPPUNIT_ASSERT_EQUAL
          ( 0u, row["LAST_OBJECT_ID"].data<unsigned int>() );
        CPPUNIT_ASSERT_EQUAL
          ( false, row["HAS_NEW_DATA"].data<bool>() );
        CPPUNIT_ASSERT_EQUAL
          ( std::string(""), row["CHANNEL_NAME"].data<std::string>() );
        transaction.commit();
      }
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  // Test fetchLastRowsWithNewData
  void test_fetchLastRowsWithNewData()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalObjectMgr objMgr( *ralDb );
    std::vector<RelationalObjectTableRowPtr> rows;
    std::vector<RelationalPayloadTableRowPtr> pRows;
    for ( int i = 0; i < 10; ++i )
    {
      ChannelId ch = i;
      rows.push_back( RelationalObjectTableRowPtr( new RelationalObjectTableRow( dummyObject( i, 0, 1, ch ) ) ) );
      rows[rows.size()-1]->setObjectId( i );
    }
    {
      // First fill the channels table
      RelationalTransaction transaction( ralDb->transactionMgr() );
      // use updateChannelTable to populate the channels table
      for ( int i = 0; i < 10; ++i )
      {
        objMgr.updateChannelTable
          ( relfolder->channelTableName(), (ChannelId)i, 0, false );
      }
      transaction.commit();
    }
    {
      // Then populate the object table
      RelationalTransaction transaction( ralDb->transactionMgr() );
      objMgr.bulkInsertObjectTableRows( relfolder, rows, pRows );
      transaction.commit();
    }
    {
      // Update rows with new data in the channels table
      RelationalTransaction transaction( ralDb->transactionMgr() );
      std::map< ChannelId, unsigned int > updateDataMap;
      updateDataMap[2] = 2;
      updateDataMap[3] = 3;
      objMgr.bulkUpdateChannelTable
        ( relfolder->channelTableName(), updateDataMap, false );
      objMgr.updateChannelTable
        ( relfolder->channelTableName(), (ChannelId)2, 0, true );
      objMgr.updateChannelTable
        ( relfolder->channelTableName(), (ChannelId)3, 0, true );
      transaction.commit();
    }
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      std::vector<RelationalObjectTableRow> rowsNew;
      objMgr.fetchLastRowsWithNewData( relfolder, rowsNew );
      CPPUNIT_ASSERT_EQUAL( (size_t)2, rowsNew.size() );
      CPPUNIT_ASSERT_EQUAL( (ChannelId)2, rowsNew[0].channelId() );
      CPPUNIT_ASSERT_EQUAL( (ChannelId)3, rowsNew[1].channelId() );
      transaction.commit();
    }
  }

  // Test channelTableFK
  void test_channelTableFK()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    const MSG::Level oldOutputLevel = application().outputLevel();
    // Remove "ORA-02291 integrity constraint violated" printout from CORAL
    application().setOutputLevel( MSG::FATAL );
    try
    {
      RelationalObjectMgr objMgr( *ralDb );
      // Prepare some rows to insert into the IOV table
      std::vector<RelationalObjectTableRowPtr> rows;
      std::vector<RelationalPayloadTableRowPtr> pRows;
      for ( int i = 0; i < 10; ++i )
      {
        ChannelId ch = i;
        rows.push_back( RelationalObjectTableRowPtr( new RelationalObjectTableRow( dummyObject(i,0,1,ch) ) ) );
        rows[rows.size()-1]->setObjectId( i );
      }
      // Try to populate the IOV table without first filling the channel table
      try
      {
        // TODO: Fix behaviour depening on sqlite version when FKs are enabled
        //std::cout << "ServerVersion: " << ralDb->sessionMgr()->serverVersion() << std::endl;
        RelationalTransaction transaction( ralDb->transactionMgr() );
        objMgr.bulkInsertObjectTableRows( relfolder, rows, pRows );
        transaction.commit();
        if ( ralDb->sessionMgr()->databaseTechnology() != "SQLite" )
          CPPUNIT_FAIL( "Expected FK to be enforced (except on sqlite)" );
      }
      // Warning: the test will succeed on Oracle (exception is caught),
      // but it will print an error message from OracleAccess anyway
      catch ( std::exception& )
      {
        if ( ralDb->sessionMgr()->databaseTechnology() == "SQLite" )
          CPPUNIT_FAIL( "Expected FK not to be enforced on sqlite" );
      }
    }
    catch ( ... )
    {
      application().setOutputLevel( oldOutputLevel );
      throw;
    }
    application().setOutputLevel( oldOutputLevel );
  }

  // Test lastUpdate_SV
  void test_lastUpdate_SV()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    try
    {
      {
        std::vector<RelationalObjectPtr> objs;
        objs.push_back( dummyObject( 1, 0, ValidityKeyMax ) );
        storeObjects( relfolder, objs );
      }
      // sleep for one second to make sure the update time change is properly
      // picked up (MySQL has a 1s granularity for example)
      if ( ralDb->queryMgr().databaseTechnology() == "MySQL" ) sleep(1);
      {
        std::vector<RelationalObjectPtr> objs;
        objs.push_back( dummyObject( 2, 10, ValidityKeyMax ) );
        storeObjects( relfolder, objs );
      }
      RelationalTransaction transaction( ralDb->transactionMgr() );
      RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
      bool fetchPayload = true;
      RelationalObjectTableRow row =
        objectTable.fetchRowForId( 1u, fetchPayload );
      CPPUNIT_ASSERT( row.insertionTime() < row.lastModDate() );
      row = objectTable.fetchRowForId( 2u, fetchPayload );
      CPPUNIT_ASSERT( row.insertionTime() == row.lastModDate() );
      transaction.commit();
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  // Test lastUpdate_MV
  void test_lastUpdate_MV()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    try
    {
      {
        std::vector<RelationalObjectPtr> objs;
        objs.push_back( dummyObject( 1, 0, ValidityKeyMax ) );
        storeObjects( relfolder, objs );
      }
      // sleep for one second to make sure the update time change is properly
      // picked up (MySQL has a 1s granularity for example)
      if ( ralDb->queryMgr().databaseTechnology() == "MySQL" ) sleep(1);
      {
        std::vector<RelationalObjectPtr> objs;
        objs.push_back( dummyObject( 2, 10, ValidityKeyMax ) );
        storeObjects( relfolder, objs );
      }
      RelationalTransaction transaction( ralDb->transactionMgr() );
      RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
      bool fetchPayload = true;
      RelationalObjectTableRow row =
        objectTable.fetchRowForId( 1u, fetchPayload );
      CPPUNIT_ASSERT( row.insertionTime() < row.lastModDate() );
      row = objectTable.fetchRowForId( 7u, fetchPayload );
      CPPUNIT_ASSERT( row.insertionTime() == row.lastModDate() );
      transaction.commit();
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  // Test data corruption in manual data changes (bug #57502)
  void test_svIovNotClosed_bug57502()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->storeObject(  1, ValidityKeyMax, dummyPayload( 1 ), 0 ); //#id=1
    folder->storeObject(  2, ValidityKeyMax, dummyPayload( 2 ), 0 ); //#id=2
    folder->storeObject(  3, ValidityKeyMax, dummyPayload( 3 ), 0 ); //#id=3
    {
      TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
      if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
      RelationalFolder* relfolder = trelfolder->getRelFolder();
      RelationalTransaction transaction( ralDb->transactionMgr() );
      Record whereData;
      ralDb->queryMgr().deleteTableRows( relfolder->objectTableName(),
                                         "OBJECT_ID=3",
                                         whereData );
      ralDb->queryMgr().updateTableRows( relfolder->objectTableName(),
                                         "IOV_UNTIL=9223372036854775807",
                                         "OBJECT_ID=2",
                                         whereData );
      // Not updating the channel table row causes data corruption (bug #57502)
      //ralDb->queryMgr().updateTableRows( relfolder->channelTableName(),
      //                                   "LAST_OBJECT_ID=2",
      //                                   "CHANNEL_ID=0",
      //                                   whereData );
      transaction.commit();
    }
    folder->storeObject(  4, ValidityKeyMax, dummyPayload( 4 ), 0 ); //#id=4
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  // Constructor (executed N times, _before_ all N test executions)
  RelationalObjectMgrTest()
    : CoolDBUnitTest()
    , ralDb( 0 ) // Fix Coverity UNINIT_CTOR
    , objMgr( 0 )
    , payloadSpec()
  {
    payloadSpec.extend( "I", StorageType::Int32 );
    payloadSpec.extend( "S", StorageType::String255 );
    payloadSpec.extend( "X", StorageType::Float );
  }

  // Destructor (executed N times, _after_ all N test executions)
  ~RelationalObjectMgrTest()
  {
  }

private:

  RalDatabase* ralDb; // safely cast pointer to db
  std::auto_ptr<RelationalObjectMgr> objMgr;
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
      }
      openDB( false ); // reopen in RO mode
      TransRalDatabase* traldb = dynamic_cast<TransRalDatabase*>( s_db.get() );
      if ( !traldb ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
      ralDb = traldb->getRalDb();
      objMgr = std::auto_ptr<RelationalObjectMgr>
        ( new RelationalObjectMgr( *ralDb ) );
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

  // Private helper
  bool updateObjectTableNewHeadId( RelationalObjectMgr* mgr,
                                   const std::string& objectTableName,
                                   const std::string& channelTableName,
                                   const ValidityKey& since,
                                   const ValidityKey& until,
                                   const ChannelId& channelId,
                                   const unsigned int newHeadId,
                                   const unsigned int userTagId = 0 )
  {
    SOVector newHeadUpdaters;
    SimpleObject so( newHeadId, // NOTE THE MISUSE...
                     channelId,
                     since,
                     until );
    newHeadUpdaters.push_back( so );
    return mgr->bulkUpdateObjectTableNewHeadId( objectTableName,
                                                channelTableName,
                                                newHeadUpdaters,
                                                userTagId );
  }

  // Private helper
  inline void storeObjects( RelationalFolder* folder,
                            const std::vector<RelationalObjectPtr>& objects,
                            const bool userTagOnly = false ) const
  {
    RelationalTransaction transaction( ralDb->transactionMgr() ); // read-write
    objMgr->storeObjects( folder, objects, userTagOnly );
    transaction.commit();
  }

  // Private helper
  unsigned int rowCount( const coral::ITable& tableHandle )
  {
    std::auto_ptr<coral::IQuery> query( tableHandle.newQuery() );
    std::string countStar = "COUNT(*)"; // UPPERCASE for CORAL bug #16621
    query->addToOutputList( countStar );
    coral::AttributeList output;
    output.extend( countStar, "unsigned int" );
    query->defineOutput( output ); // For all backends (workaround bug #54756)
    coral::ICursor& cursor = query->execute();
    if ( cursor.next() )
    {
      const coral::AttributeList& row( cursor.currentRow() );
      return row[ countStar ].data<unsigned int>();
    }
    else
    {
      throw RelationalException
        ( "Could not fetch row count", "RalObjectTable" );
    }
  }

  /// Utility method to return a dummy object with a distinct payload
  /// (determined by 'index') for a given set of since/until/channel
  RelationalObjectPtr dummyObject( int index,
                                   const ValidityKey& since,
                                   const ValidityKey& until,
                                   const ChannelId& channel = 0 )
  {
    RelationalObjectPtr obj( new RelationalObject( since,
                                                   until,
                                                   dummyPayload( index ),
                                                   channel ) );
    return obj;
  }

  /// Utility method to generate a distinct payload for a given index
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

  // Private helper
  inline Time addOneNsToTime( ITime& time )
  {
    return Time( time.year(),
                 time.month(),
                 time.day(),
                 time.hour(),
                 time.minute(),
                 time.second(),
                 time.nanosecond()+1 );
  }

  // Create all folders (overloads virtual base method)
  void createFolders()
  {
    // Create the SV folder
    FolderSpecification fSpecS( FolderVersioning::SINGLE_VERSION, payloadSpec );
    s_db->createFolder( "/fSV", fSpecS, "SV folder" );
    // Create the MV folder
    FolderSpecification fSpecM( FolderVersioning::MULTI_VERSION, payloadSpec );
    s_db->createFolder( "/fMV", fSpecM, "MV folder" );
  }

};

CPPUNIT_TEST_SUITE_REGISTRATION( cool::RelationalObjectMgrTest );

COOLTEST_MAIN( RelationalObjectMgrTest )
