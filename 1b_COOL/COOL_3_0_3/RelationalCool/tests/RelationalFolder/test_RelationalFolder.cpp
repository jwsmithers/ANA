// First of all, enable or disable the COOL290 API extensions (bug #92204)
#include "CoolKernel/VersionInfo.h"

// Include files
#include <string>
#include <vector>
#include "CoolKernel/ChannelSelection.h"
#include "CoolKernel/CompositeSelection.h"
#include "CoolKernel/FieldSelection.h"
#include "CoolKernel/FolderSpecification.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/IField.h"
#include "CoolKernel/IFolder.h"
#include "CoolKernel/IFolderSpecification.h"
#include "CoolKernel/InternalErrorException.h"
#include "CoolKernel/IObject.h"
#include "CoolKernel/IObjectIterator.h"
#include "CoolKernel/IRecordSelection.h"
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordException.h"
#include "CoolKernel/RecordSelectionException.h"
#include "CoolKernel/RecordSpecification.h"
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeListException.h"
#include "RelationalAccess/IConnectionService.h"
#include "RelationalAccess/IConnectionServiceConfiguration.h"
#include "RelationalAccess/IRelationalService.h"

// Local include files
//#define COOLUNITTESTTIMER 1
//#define COOLDBUNITTESTDEBUG 1
#include "tests/Common/CoolDBUnitTest.h"
#include "src/CoralApplication.h"
#include "src/RalDatabase.h"
#include "src/RalDatabaseSvc.h"
#include "src/RelationalChannelTable.h"
#include "src/RelationalException.h"
#include "src/RelationalFolder.h"
#include "src/RelationalObject.h"
#include "src/RelationalTableRow.h"
#include "src/RelationalTransaction.h"
#include "src/RelationalPayloadQuery.h"
#include "src/TransRalDatabase.h"
#include "src/TransRelFolder.h"
#include "src/timeToString.h"

// Forward declaration (for easier indentation)
namespace cool {
  class RelationalFolderTest;
}

// The test class
class cool::RelationalFolderTest : public cool::CoolDBUnitTest
{

private:

  CPPUNIT_TEST_SUITE( RelationalFolderTest );
  CPPUNIT_TEST( test_getFolder );
  CPPUNIT_TEST( test_folderSpecification ); // NB: DDL
  CPPUNIT_TEST( test_findObject );
  CPPUNIT_TEST( test_findObject_MV );
  CPPUNIT_TEST( test_findObject_MV_sepPayload );
  CPPUNIT_TEST( test_findObject_MV_vector );
  CPPUNIT_TEST( test_findObject_wrongChannel );
  CPPUNIT_TEST( test_findObject_after_dropNode_SV ); // NB: DDL
  CPPUNIT_TEST( test_findObject_after_dropNode_MV ); // NB: DDL
  CPPUNIT_TEST( test_findObject_after_dropNode_MV_sepPayload ); // NB: DDL
  CPPUNIT_TEST( test_findObject_after_dropNode_MV_vector ); // NB: DDL
  CPPUNIT_TEST( test_access_outofscope_db ); // NB: DDL
  CPPUNIT_TEST( test_flushStorageBuffer );
  CPPUNIT_TEST( test_storeObject_bulk_SV );
  CPPUNIT_TEST( test_storeObject_bulk_SV_listReused );
  // This takes ~33s Oracle, ~130s MySQL, ~33s sqlite
  //CPPUNIT_TEST( test_storeObject_bulk_70k ); // keep this disabled
  // This takes ~55s Oracle, ~200s MySQL, ~66s sqlite (after fixing bug #17903)
  //CPPUNIT_TEST( test_tagObject_bulk_70k ); // keep this disabled
  CPPUNIT_TEST( test_storeObject_bulk_MV );
  CPPUNIT_TEST( test_storeObject_bulk_MV_sepPayload );
  CPPUNIT_TEST( test_storeObject_bulk_MV_vector );
  CPPUNIT_TEST( test_storeObject_reinsert_with_payloadId );
  CPPUNIT_TEST( test_MV_tag_and_retrieve );
  CPPUNIT_TEST( test_MV_tag_and_retrieve_sepPayload );
  CPPUNIT_TEST( test_MV_tag_and_retrieve_vector );
  CPPUNIT_TEST( test_deleteTag_andRetag );
  CPPUNIT_TEST( test_deleteTag_andRetag_sepPayload );
  CPPUNIT_TEST( test_deleteTag_andRetag_vector );
  CPPUNIT_TEST( test_deleteTag_HEAD );
  CPPUNIT_TEST( test_tagExistsElsewhere );
  CPPUNIT_TEST( test_tagNameScope );
  CPPUNIT_TEST( test_taggedNodes );
  CPPUNIT_TEST( test_tagName_case_sensitivity );
  CPPUNIT_TEST( test_multiple_folders ); // NB: DDL
  CPPUNIT_TEST( test_ValidityKey_boundaries );
  CPPUNIT_TEST( test_ValidityKeyException );
  CPPUNIT_TEST( test_flushStorageBuffer_exception );
  CPPUNIT_TEST( test_flushStorageBuffer_exception_bug22474 );
  CPPUNIT_TEST( test_browseObjects_SV );
  CPPUNIT_TEST( test_browseObjects_SV_lowercasePayload ); // NB: DDL
  CPPUNIT_TEST( test_browseObjects_SV_bug42101 );
  CPPUNIT_TEST( test_browseObjects_MV );
  CPPUNIT_TEST( test_browseObjects_MV_sepPayload );
  CPPUNIT_TEST( test_browseObjects_MV_vector );
  CPPUNIT_TEST( test_browseObjects_MV_tag );
  CPPUNIT_TEST( test_browseObjects_MV_tag_sepPayload );
  CPPUNIT_TEST( test_browseObjects_MV_tag_vector );
  CPPUNIT_TEST( test_listTags_MV );
  CPPUNIT_TEST( test_listTags_SV );
  CPPUNIT_TEST( test_tagInsertionTime );
  CPPUNIT_TEST( test_tagDescription );
  CPPUNIT_TEST( test_storeObjects_bulk_multichannel );
  CPPUNIT_TEST( test_setDescription ); // NB: DDL
  CPPUNIT_TEST( test_storeObject_SV_overlap1 );
  CPPUNIT_TEST( test_storeObject_SV_overlap2 );
  CPPUNIT_TEST( test_storeObject_SV_overlap3 );
  CPPUNIT_TEST( test_storeObject_SV_overlap_bulk1 );
  CPPUNIT_TEST( test_storeObject_SV_overlap_bulk2 );
  CPPUNIT_TEST( test_storeObject_SV_overlap_bulk3 );
  CPPUNIT_TEST( test_storeObject_SV_unordered_closed );
  CPPUNIT_TEST( test_storeObject_SV_unordered_open );
  CPPUNIT_TEST( test_storeObject_SV_unordered_bulk_closed );
  CPPUNIT_TEST( test_storeObject_SV_unordered_bulk_open );
  CPPUNIT_TEST( test_storeObject_SV_unordered_bulk_open_2 );
  CPPUNIT_TEST( test_storeObject_SV_unordered_bulk_open_3 );
  CPPUNIT_TEST( test_storeObject_SV_unordered_MC_closed );
  CPPUNIT_TEST( test_storeObject_SV_unordered_MC_bulk_closed );
  CPPUNIT_TEST( test_storeObject_SV_unordered_MC_bulk_closed_oneperchannel );
  CPPUNIT_TEST( test_storeObject_SV_unordered_MC_bulk_closed_oneperchannel_2 );
  CPPUNIT_TEST( test_storeObject_SV_unordered_bulk_closed_oneback );
  CPPUNIT_TEST( test_storeObject_SV_unordered_has_new_data_flag );
  CPPUNIT_TEST( test_browseObjects_channel_range_SV );
  CPPUNIT_TEST( test_browseObjects_all_channels_SV );
  CPPUNIT_TEST( test_browseObjects_channel_range_MV );
  CPPUNIT_TEST( test_browseObjects_channel_range_MV_sepPayload );
  CPPUNIT_TEST( test_browseObjects_channel_range_MV_vector );
  CPPUNIT_TEST( test_browseObjects_all_channels_MV );
  CPPUNIT_TEST( test_browseObjects_all_channels_MV_sepPayload );
  CPPUNIT_TEST( test_browseObjects_all_channels_MV_vector );
  CPPUNIT_TEST( test_objectCount_SV );
  CPPUNIT_TEST( test_objectCount_MV );
  CPPUNIT_TEST( test_objectCount_MV_sepPayload );
  CPPUNIT_TEST( test_objectCount_MV_vector );
  CPPUNIT_TEST( test_node_nameclash ); // NB: DDL
  CPPUNIT_TEST( test_existsUserTag );
  CPPUNIT_TEST( test_userTag_browseObjects_HEAD_insulation );
  CPPUNIT_TEST( test_userTag_browseObjects_HEAD_insulation_sepPayload );
  CPPUNIT_TEST( test_userTag_browseObjects_HEAD_insulation_vector );
  CPPUNIT_TEST( test_browseObjects_userTag );
  CPPUNIT_TEST( test_browseObjects_userTag_sepPayload );
  CPPUNIT_TEST( test_browseObjects_userTag_vector );
  CPPUNIT_TEST( test_userTag_example1 );
  CPPUNIT_TEST( test_userTag_example1_sepPayload );
  CPPUNIT_TEST( test_userTag_example1_vector );
  CPPUNIT_TEST( test_storeObject_userTag_SV );
  CPPUNIT_TEST( test_tag_with_userTag );
  CPPUNIT_TEST( test_userTag_with_tag );
  CPPUNIT_TEST( test_storeObject_userTag_userTagOnly );
  CPPUNIT_TEST( test_storeObject_userTag_userTagOnly_exceptions );
  CPPUNIT_TEST( test_userTag_HEAD );
  CPPUNIT_TEST( test_attribute_names ); // NB: DDL
  CPPUNIT_TEST( test_attribute_names_isa ); // NB: DDL
  CPPUNIT_TEST( test_attribute_name_order_string ); // NB: DDL
  CPPUNIT_TEST( test_renamePayload ); // NB: DDL
  CPPUNIT_TEST( test_renamePayload_sepPayload ); // NB: DDL
  CPPUNIT_TEST( test_renamePayload_vector ); // NB: DDL
  CPPUNIT_TEST( test_extendPayloadSpecification ); // NB: DDL
  CPPUNIT_TEST( test_extendPayloadSpecification_sepPayload ); // NB: DDL
  CPPUNIT_TEST( test_extendPayloadSpecification_vector ); // NB: DDL
  CPPUNIT_TEST( test_extendPayloadSpecificationExceptions ); // NB: DDL
  CPPUNIT_TEST( test_storeObject_emptyRecord );
  CPPUNIT_TEST( test_browseObjects_channelName_SV_all );
  CPPUNIT_TEST( test_browseObjects_channelName_SV_range );
  CPPUNIT_TEST( test_browseObjects_channelName_MV_all );
  CPPUNIT_TEST( test_browseObjects_channelName_MV_all_sepPayload );
  CPPUNIT_TEST( test_browseObjects_channelName_MV_all_vector );
  CPPUNIT_TEST( test_browseObjects_channelName_MV_tag );
  CPPUNIT_TEST( test_browseObjects_channelName_MV_tag_sepPayload );
  CPPUNIT_TEST( test_browseObjects_channelName_MV_tag_vector );
  CPPUNIT_TEST( test_browseObjects_channelName_MV_userTag );
  CPPUNIT_TEST( test_browseObjects_channelName_MV_userTag_sepPayload );
  CPPUNIT_TEST( test_browseObjects_channelName_MV_userTag_vector );
  CPPUNIT_TEST( test_findObjects_channelName_SV );
  CPPUNIT_TEST( test_findObjects_channelName_MV );
  CPPUNIT_TEST( test_findObjects_channelName_MV_sepPayload );
  CPPUNIT_TEST( test_findObjects_channelName_MV_vector );
  CPPUNIT_TEST( test_findObjects_channelName_MV_tag );
  CPPUNIT_TEST( test_findObjects_channelName_MV_tag_sepPayload );
  CPPUNIT_TEST( test_findObjects_channelName_MV_tag_vector );
  CPPUNIT_TEST( test_findObjects_channelName_MV_userTag );
  CPPUNIT_TEST( test_findObjects_channelName_MV_userTag_sepPayload );
  CPPUNIT_TEST( test_findObjects_channelName_MV_userTag_vector );
  CPPUNIT_TEST( test_countObjects_channelName_SV_all );
  CPPUNIT_TEST( test_countObjects_channelName_SV_range );
  CPPUNIT_TEST( test_countObjects_channelName_MV_all );
  CPPUNIT_TEST( test_countObjects_channelName_MV_all_sepPayload );
  CPPUNIT_TEST( test_countObjects_channelName_MV_all_vector );
  CPPUNIT_TEST( test_countObjects_channelName_MV_tag );
  CPPUNIT_TEST( test_countObjects_channelName_MV_tag_sepPayload );
  CPPUNIT_TEST( test_countObjects_channelName_MV_tag_vector );
  CPPUNIT_TEST( test_countObjects_channelName_MV_userTag );
  CPPUNIT_TEST( test_setTagDescription_currentHeadTag );
  CPPUNIT_TEST( test_setTagDescription_headAsOfDateTag );
  CPPUNIT_TEST( test_setTagDescription_userTag );
  CPPUNIT_TEST( test_setTagDescription_TagNotFound );
  CPPUNIT_TEST( test_setTagDescription_256 );
  CPPUNIT_TEST( test_setTagDescription_headTag ); // bug #33989
  CPPUNIT_TEST( test_cloneHeadTag );
  CPPUNIT_TEST( test_cloneHeadTag_sepPayload );
  CPPUNIT_TEST( test_cloneHeadTag_vector );
#ifdef COOL400
  CPPUNIT_TEST( test_manualTransaction_renamePayload );
  CPPUNIT_TEST( test_manualTransaction_extendPayloadSpecification );
#endif
  CPPUNIT_TEST( test_RecordSelectionBrowseObjects );
  CPPUNIT_TEST( test_RecordSelectionBrowseObjects_sepPayload );
  CPPUNIT_TEST( test_RecordSelectionBrowseObjects_vector );
  CPPUNIT_TEST( test_truncateIOV );
  CPPUNIT_TEST( test_browseObjects_bug42708 );
  CPPUNIT_TEST( test_browseObjects_bug42708_exception );
  CPPUNIT_TEST( test_clobOptimization ); // NB: DDL
  CPPUNIT_TEST( test_clobShortWithLongName_bug64710 ); // NB: DDL
  CPPUNIT_TEST_SUITE_END();

public:

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_browseObjects_bug42708_exception()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    for ( int i = 0; i < 100; ++i )
      folder->storeObject(  0, 10, dummyPayload( i ), (ChannelId)i );
    ChannelSelection channels( 0 );
    for ( int i = 1; i < 51; ++i )
      channels.addRange( 2*i, 2*i );  // [0,0], [2,2]... [100,100] (51 ranges)
    try
    {
      folder->browseObjects(0, ValidityKeyMax, channels );
      CPPUNIT_FAIL("browsing with 51 non-contiguous channel selection ranges "
                   "must fail");
    } catch ( RelationalException& e ) {
      std::string expected = "Non-contiguous channel selection only "
        "supported for up to 50 ranges";
      CPPUNIT_ASSERT_EQUAL_MESSAGE("exception caught",
                                   expected, std::string(e.what()));
    }
  }

  void test_browseObjects_bug42708()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    for ( int i = 0; i < 100; ++i )
      folder->storeObject(  0, 10, dummyPayload( i ), (ChannelId)i );
    ChannelSelection channels( 0 );
    for ( int i = 1; i < 50; ++i )
      channels.addRange( 2*i, 2*i );  // [0,0], [2,2]... [98,98] (50 ranges)
    IObjectIteratorPtr objs = folder->browseObjects(0,
                                                    ValidityKeyMax,
                                                    channels );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 50u,
                                  (unsigned int)objs->size() );
    // Only test the first 5 objects
    IObjectPtr obj = getNext(objs);
    CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
                            dummyPayload( 0 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 channel",
                                  (ChannelId)0, obj->channelId() );
    obj = getNext(objs);
    CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                            dummyPayload( 2 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 channel",
                                  (ChannelId)2, obj->channelId() );
    obj = getNext(objs);
    CPPUNIT_ASSERT_MESSAGE( "obj 3 payload",
                            dummyPayload( 4 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 channel",
                                  (ChannelId)4, obj->channelId() );
    obj = getNext(objs);
    CPPUNIT_ASSERT_MESSAGE( "obj 4 payload",
                            dummyPayload( 6 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 4 channel",
                                  (ChannelId)6, obj->channelId() );
    obj = getNext(objs);
    CPPUNIT_ASSERT_MESSAGE( "obj 5 payload",
                            dummyPayload( 8 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 5 channel",
                                  (ChannelId)8, obj->channelId() );
  }

#ifdef COOL400
  /// Tests renamePayload behavior in manual transaction mode
  void test_manualTransaction_renamePayload()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    ITransactionPtr t = s_db->startTransaction();
    try {
      folder->renamePayload("I", "J");
      CPPUNIT_FAIL("renamePayload in manual transaction mode must fail");
    } catch ( RelationalException& e ) {
      std::string expected = "Cannot rename payload fields in manual "
        "transaction mode";
      CPPUNIT_ASSERT_EQUAL_MESSAGE("exception caught",
                                   expected, std::string(e.what()));
    }
  }

  /// Tests extendPayloadSpecification behavior in manual transaction mode
  void test_manualTransaction_extendPayloadSpecification()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    ITransactionPtr t = s_db->startTransaction();
    try {
      RecordSpecification newFields;
      newFields.extend("Y", cool_StorageType_TypeId::Int32);
      folder->extendPayloadSpecification(Record(newFields));
      CPPUNIT_FAIL("extendPayloadSpecification in manual transaction mode "
                   "must fail");
    } catch ( RelationalException& e ) {
      std::string expected = ("Cannot extend payload specification in manual "
                              "transaction mode");
      CPPUNIT_ASSERT_EQUAL_MESSAGE("exception caught",
                                   expected, std::string(e.what()));
    }
  }
#endif

  /// Tests setTagDescription for the HEAD tag (bug #33989)
  void test_setTagDescription_headTag()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0 );
    try {
      folder->setTagDescription( "HEAD", "desc" );
      CPPUNIT_FAIL( "setTagDescription for HEAD tag should fail!" );
    }
    catch ( Exception& ) {}
  }

  /// Tests setTagDesction for a description exceeding the 255 character limit
  /// (task #6394).
  void test_setTagDescription_256()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0, "user tag" );
    std::string s256(256, '*');
    try {
      folder->setTagDescription( "user tag", s256 );
      CPPUNIT_FAIL( "setTagDescription with >255 chars should fail!" );
    }
    catch ( Exception& ) {}
  }

  /// Tests setTagDesction for a non-existing tag (task #6394).
  void test_setTagDescription_TagNotFound()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0, "user tag" );
    try
    {
      folder->setTagDescription( "non-existing tag", "new description" );
      CPPUNIT_FAIL( "setTagDescription with non-existing tag should fail!" );
    }
    catch ( TagNotFound& ) {}
  }

  /// Tests setTagDesction for a user tag (task #6394).
  void test_setTagDescription_userTag()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0, "user tag" );
    folder->setTagDescription( "user tag", "new description" );
    CPPUNIT_ASSERT_EQUAL( std::string("new description"),
                          folder->tagDescription("user tag") );
  }

  /// Tests setTagDesction for an 'asof' date tag (task #6394).
  void test_setTagDescription_headAsOfDateTag()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0 );
    IObjectPtr obj = folder->findObject( 0, 0 );
    folder->tagHeadAsOfDate( obj->insertionTime(),
                             "head tag", "original description" );
    CPPUNIT_ASSERT_EQUAL( std::string("original description"),
                          folder->tagDescription("head tag") );
    folder->setTagDescription( "head tag", "new description" );
    CPPUNIT_ASSERT_EQUAL( std::string("new description"),
                          folder->tagDescription("head tag") );
  }

  /// Tests setTagDesction for a current head tag (task #6394).
  void test_setTagDescription_currentHeadTag()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0 );
    folder->tagCurrentHead( "head tag", "original description" );
    CPPUNIT_ASSERT_EQUAL( std::string("original description"),
                          folder->tagDescription("head tag") );
    folder->setTagDescription( "head tag", "new description" );
    CPPUNIT_ASSERT_EQUAL( std::string("new description"),
                          folder->tagDescription("head tag") );
  }

  void test_countObjects_channelName_MV_userTag()
  {
    test_countObjects_channelName_MV_userTag( cool_PayloadMode_Mode::INLINEPAYLOAD );
  }

  void test_countObjects_channelName_MV_userTag_sepPayload()
  {
    test_countObjects_channelName_MV_userTag( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  }

  void test_countObjects_channelName_MV_userTag_vector()
  {
    test_countObjects_channelName_MV_userTag( cool_PayloadMode_Mode::VECTORPAYLOAD );
  }

  /// Tests countObjects (MV folder) via the channel name interface
  /// selecting user tagged IOVs
  void test_countObjects_channelName_MV_userTag( PayloadMode::Mode pMode)
  {
    IFolderPtr folder = s_db->getFolder( payloadMode2Folder( pMode ) );
    folder->createChannel( 1, "ch 1" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0, "user tag" );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 0, "user tag" );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload(2), 0, "user tag" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 1, "user tag" );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 1, "user tag" );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload(2), 1, "user tag" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 2, "user tag" );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 2, "user tag" );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload(2), 2, "user tag" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 1 );
    ChannelSelection chsel( "ch 1" );
    unsigned int count = folder->countObjects( 0,
                                               ValidityKeyMax,
                                               chsel,
                                               "user tag" );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 3u, count );
    s_db->dropNode( "/myfolder" ); // cleanup
  }

  void test_countObjects_channelName_MV_tag()
  {
    test_countObjects_channelName_MV_tag( cool_PayloadMode_Mode::INLINEPAYLOAD );
  };

  void test_countObjects_channelName_MV_tag_sepPayload()
  {
    test_countObjects_channelName_MV_tag( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  };

  void test_countObjects_channelName_MV_tag_vector()
  {
    test_countObjects_channelName_MV_tag( cool_PayloadMode_Mode::VECTORPAYLOAD );
  };

  /// Tests countObjects (MV folder) via the channel name interface
  /// selecting tagged IOVs
  void test_countObjects_channelName_MV_tag( PayloadMode::Mode pMode )
  {
    IFolderPtr folder = s_db->getFolder( payloadMode2Folder( pMode ) );
    folder->createChannel( 1, "ch 1" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 0 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 0 );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 1 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 1 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 1 );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 2 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 2 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 2 );
    folder->tagCurrentHead( "tag" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 1 );
    ChannelSelection chsel( "ch 1" );
    unsigned int count = folder->countObjects( 0,
                                               ValidityKeyMax,
                                               chsel,
                                               "tag" );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 3u, count );
  }

  void test_countObjects_channelName_MV_all()
  {
    test_countObjects_channelName_MV_all( cool_PayloadMode_Mode::INLINEPAYLOAD );
  };

  void test_countObjects_channelName_MV_all_sepPayload()
  {
    test_countObjects_channelName_MV_all( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  };

  void test_countObjects_channelName_MV_all_vector()
  {
    test_countObjects_channelName_MV_all( cool_PayloadMode_Mode::VECTORPAYLOAD );
  };

  /// Tests countObjects (MV folder) via the channel name interface
  /// selecting all IOVs
  void test_countObjects_channelName_MV_all( PayloadMode::Mode pMode )
  {
    IFolderPtr folder = s_db->getFolder( payloadMode2Folder( pMode ) );
    folder->createChannel( 1, "ch 1" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 0 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 0 );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 1 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 1 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 1 );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 2 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 2 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 2 );
    ChannelSelection chsel( "ch 1" );
    unsigned int count = folder->countObjects( 0, ValidityKeyMax, chsel );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 3u, count );
  }

  /// Tests countObjects (SV folder) via the channel name interface
  /// selecting a range of IOVs
  void test_countObjects_channelName_SV_range()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->createChannel( 1, "ch 1" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 0 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 0 );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 1 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 1 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 1 );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 2 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 2 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 2 );
    ChannelSelection chsel( "ch 1" );
    unsigned int count = folder->countObjects( 5, 15, chsel );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 2u, count );
  }

  /// Tests countObjects (SV folder) via the channel name interface
  /// selecting all IOVs
  void test_countObjects_channelName_SV_all()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->createChannel( 1, "ch 1" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 0 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 0 );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 1 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 1 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 1 );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 2 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 2 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 2 );
    ChannelSelection chsel( "ch 1" );
    unsigned int count = folder->countObjects( 0, ValidityKeyMax, chsel );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 3u, count );
  }

  IObjectPtr getNext( IObjectIteratorPtr objs)
  {
    if ( !objs->goToNext() )
      CPPUNIT_FAIL( "objs has no next row" );
    return IObjectPtr( objs->currentRef().clone() );
  };

  void test_findObjects_channelName_MV_userTag()
  {
    test_findObjects_channelName_MV_userTag( cool_PayloadMode_Mode::INLINEPAYLOAD );
  };

  void test_findObjects_channelName_MV_userTag_sepPayload()
  {
    test_findObjects_channelName_MV_userTag( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  };

  void test_findObjects_channelName_MV_userTag_vector()
  {
    test_findObjects_channelName_MV_userTag( cool_PayloadMode_Mode::VECTORPAYLOAD );
  };

  /// Tests findObjects for a MV folder with the channel name interface
  /// selecting from a user tag.
  void test_findObjects_channelName_MV_userTag( PayloadMode::Mode pMode )
  {
    IFolderPtr folder = s_db->getFolder( payloadMode2Folder( pMode ) );
    folder->createChannel( 1, "ch 1" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0, "user tag" );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 0, "user tag" );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload(2), 0, "user tag" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 1, "user tag" );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 1, "user tag" );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload(2), 1, "user tag" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 2, "user tag" );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 2, "user tag" );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload(2), 2, "user tag" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 1 );
    ChannelSelection chsel( "ch 1" );
    IObjectIteratorPtr objs = folder->findObjects( 5, chsel, "user tag" );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 1u,
                                  (unsigned int)objs->size() );
    IObjectPtr obj = getNext(objs);
    CPPUNIT_ASSERT( dummyPayload( 0 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)0, obj->since() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)10, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)1, obj->channelId() );
  }

  void test_findObjects_channelName_MV_tag()
  {
    test_findObjects_channelName_MV_tag( cool_PayloadMode_Mode::INLINEPAYLOAD );
  };

  void test_findObjects_channelName_MV_tag_sepPayload()
  {
    test_findObjects_channelName_MV_tag( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  };

  void test_findObjects_channelName_MV_tag_vector()
  {
    test_findObjects_channelName_MV_tag( cool_PayloadMode_Mode::VECTORPAYLOAD );
  };

  /// Tests findObjects for a MV folder with the channel name interface
  /// selecting from a tag.
  void test_findObjects_channelName_MV_tag( PayloadMode::Mode pMode )
  {
    IFolderPtr folder = s_db->getFolder( payloadMode2Folder( pMode ) );
    folder->createChannel( 1, "ch 1" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 0 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 0 );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 1 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 1 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 1 );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 2 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 2 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 2 );
    folder->tagCurrentHead( "tag" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 1 );
    ChannelSelection chsel( "ch 1" );
    IObjectIteratorPtr objs = folder->findObjects( 5, chsel, "tag" );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 1u,
                                  (unsigned int)objs->size() );
    IObjectPtr obj = getNext(objs);
    CPPUNIT_ASSERT( dummyPayload( 0 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)0, obj->since() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)10, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)1, obj->channelId() );
  }

  void test_findObjects_channelName_MV()
  {
    test_findObjects_channelName_MV( cool_PayloadMode_Mode::INLINEPAYLOAD );
  };

  void test_findObjects_channelName_MV_sepPayload()
  {
    test_findObjects_channelName_MV( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  };

  void test_findObjects_channelName_MV_vector()
  {
    test_findObjects_channelName_MV( cool_PayloadMode_Mode::VECTORPAYLOAD );
  };

  /// Tests findObjects for a MV folder with the channel name interface
  void test_findObjects_channelName_MV( PayloadMode::Mode pMode )
  {
    IFolderPtr folder = s_db->getFolder( payloadMode2Folder( pMode ) );
    folder->createChannel( 1, "ch 1" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 0 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 0 );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 1 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 1 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 1 );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 2 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 2 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 2 );
    ChannelSelection chsel( "ch 1" );
    IObjectIteratorPtr objs = folder->findObjects( 5, chsel );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 1u,
                                  (unsigned int)objs->size() );
    IObjectPtr obj = getNext(objs);
    CPPUNIT_ASSERT( dummyPayload( 0 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)0, obj->since() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)10, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)1, obj->channelId() );
  }

  /// Tests findObjects for a SV folder with the channel name interface
  void test_findObjects_channelName_SV()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->createChannel( 1, "ch 1" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 0 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 0 );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 1 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 1 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 1 );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 2 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 2 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 2 );
    ChannelSelection chsel( "ch 1" );
    IObjectIteratorPtr objs = folder->findObjects( 5, chsel );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 1u,
                                  (unsigned int)objs->size() );
    IObjectPtr obj = getNext(objs);
    CPPUNIT_ASSERT( dummyPayload( 0 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)0, obj->since() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)10, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)1, obj->channelId() );
  }

  void test_browseObjects_channelName_MV_userTag()
  {
    test_browseObjects_channelName_MV_userTag( cool_PayloadMode_Mode::INLINEPAYLOAD );
  };

  void test_browseObjects_channelName_MV_userTag_sepPayload()
  {
    test_browseObjects_channelName_MV_userTag( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  };

  void test_browseObjects_channelName_MV_userTag_vector()
  {
    test_browseObjects_channelName_MV_userTag( cool_PayloadMode_Mode::VECTORPAYLOAD );
  };

  /// Tests object browsing (MV folder) via the channel name interface
  /// selecting user tagged IOVs
  void test_browseObjects_channelName_MV_userTag( PayloadMode::Mode pMode )
  {
    IFolderPtr folder = s_db->getFolder( payloadMode2Folder( pMode ) );
    folder->createChannel( 1, "ch 1" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0, "user tag" );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 0, "user tag" );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload(2), 0, "user tag" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 1, "user tag" );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 1, "user tag" );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload(2), 1, "user tag" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 2, "user tag" );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 2, "user tag" );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload(2), 2, "user tag" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 1 );
    ChannelSelection chsel( "ch 1" );
    IObjectIteratorPtr objs = folder->browseObjects( 0,
                                                     ValidityKeyMax,
                                                     chsel,
                                                     "user tag" );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 3u,
                                  (unsigned int)objs->size() );
    IObjectPtr obj = getNext(objs);
    CPPUNIT_ASSERT( dummyPayload( 0 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)0, obj->since() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)10, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)1, obj->channelId() );
    obj = getNext(objs);
    CPPUNIT_ASSERT( dummyPayload( 1 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)10, obj->since() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)20, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)1, obj->channelId() );
    obj = getNext(objs);
    CPPUNIT_ASSERT( dummyPayload( 2 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)20, obj->since() );
    CPPUNIT_ASSERT_EQUAL( ValidityKeyMax, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)1, obj->channelId() );
  }

  void test_browseObjects_channelName_MV_tag()
  {
    test_browseObjects_channelName_MV_tag( cool_PayloadMode_Mode::INLINEPAYLOAD );
  }

  void test_browseObjects_channelName_MV_tag_sepPayload()
  {
    test_browseObjects_channelName_MV_tag( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  }

  void test_browseObjects_channelName_MV_tag_vector()
  {
    test_browseObjects_channelName_MV_tag( cool_PayloadMode_Mode::VECTORPAYLOAD );
  }

  /// Tests object browsing (MV folder) via the channel name interface
  /// selecting tagged IOVs
  void test_browseObjects_channelName_MV_tag( PayloadMode::Mode pMode )
  {
    IFolderPtr folder = s_db->getFolder( payloadMode2Folder( pMode ) );
    folder->createChannel( 1, "ch 1" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 0 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 0 );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 1 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 1 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 1 );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 2 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 2 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 2 );
    folder->tagCurrentHead( "tag" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 1 );
    ChannelSelection chsel( "ch 1" );
    IObjectIteratorPtr objs = folder->browseObjects( 0,
                                                     ValidityKeyMax,
                                                     chsel,
                                                     "tag" );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 3u,
                                  (unsigned int)objs->size() );
    IObjectPtr obj = getNext(objs);
    CPPUNIT_ASSERT( dummyPayload( 0 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)0, obj->since() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)10, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)1, obj->channelId() );
    obj = getNext(objs);
    CPPUNIT_ASSERT( dummyPayload( 1 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)10, obj->since() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)20, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)1, obj->channelId() );
    obj = getNext(objs);
    CPPUNIT_ASSERT( dummyPayload( 2 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)20, obj->since() );
    CPPUNIT_ASSERT_EQUAL( ValidityKeyMax, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)1, obj->channelId() );
  }

  void test_browseObjects_channelName_MV_all()
  {
    test_browseObjects_channelName_MV_all( cool_PayloadMode_Mode::INLINEPAYLOAD );
  };

  void test_browseObjects_channelName_MV_all_sepPayload()
  {
    test_browseObjects_channelName_MV_all( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  };

  void test_browseObjects_channelName_MV_all_vector()
  {
    test_browseObjects_channelName_MV_all( cool_PayloadMode_Mode::VECTORPAYLOAD );
  };

  /// Tests object browsing (MV folder) via the channel name interface
  /// selecting all IOVs
  void test_browseObjects_channelName_MV_all( PayloadMode::Mode pMode )
  {
    IFolderPtr folder = s_db->getFolder( payloadMode2Folder( pMode ) );
    folder->createChannel( 1, "ch 1" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 0 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 0 );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 1 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 1 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 1 );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 2 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 2 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 2 );
    ChannelSelection chsel( "ch 1" );
    IObjectIteratorPtr objs = folder->browseObjects( 0,
                                                     ValidityKeyMax,
                                                     chsel );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 3u,
                                  (unsigned int)objs->size() );
    IObjectPtr obj = getNext(objs);
    CPPUNIT_ASSERT( dummyPayload( 0 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)0, obj->since() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)10, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)1, obj->channelId() );
    obj = getNext(objs);
    CPPUNIT_ASSERT( dummyPayload( 1 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)10, obj->since() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)20, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)1, obj->channelId() );
    obj = getNext(objs);
    CPPUNIT_ASSERT( dummyPayload( 2 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)20, obj->since() );
    CPPUNIT_ASSERT_EQUAL( ValidityKeyMax, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)1, obj->channelId() );
  }

  /// Tests object browsing (SV folder) via the channel name interface
  /// selecting a range of IOVs
  void test_browseObjects_channelName_SV_range()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->createChannel( 1, "ch 1" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 0 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 0 );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 1 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 1 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 1 );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 2 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 2 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 2 );
    ChannelSelection chsel( "ch 1" );
    IObjectIteratorPtr objs = folder->browseObjects( 5, 15, chsel );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 2u,
                                  (unsigned int)objs->size() );
    IObjectPtr obj = getNext(objs);
    CPPUNIT_ASSERT( dummyPayload( 0 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)0, obj->since() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)10, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)1, obj->channelId() );
    obj = getNext(objs);
    CPPUNIT_ASSERT( dummyPayload( 1 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)10, obj->since() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)20, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)1, obj->channelId() );
  }

  /// Tests object browsing (SV folder) via the channel name interface
  /// selecting all IOVs
  void test_browseObjects_channelName_SV_all()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->createChannel( 1, "ch 1" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 0 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 0 );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 1 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 1 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 1 );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 2 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 2 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 2 );
    ChannelSelection chsel( "ch 1" );
    IObjectIteratorPtr objs = folder->browseObjects( 0,
                                                     ValidityKeyMax,
                                                     chsel );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 3u,
                                  (unsigned int)objs->size() );
    IObjectPtr obj = getNext(objs);
    CPPUNIT_ASSERT( dummyPayload( 0 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)0, obj->since() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)10, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)1, obj->channelId() );
    obj = getNext(objs);
    CPPUNIT_ASSERT( dummyPayload( 1 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)10, obj->since() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)20, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)1, obj->channelId() );
    obj = getNext(objs);
    CPPUNIT_ASSERT( dummyPayload( 2 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL( (ValidityKey)20, obj->since() );
    CPPUNIT_ASSERT_EQUAL( ValidityKeyMax, obj->until() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)1, obj->channelId() );
  }


  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  /// Tests creating and retrieving a folder. This test is implemented in more
  /// with respect to the folder attributes in test_RalDatabase.
  void test_folderSpecification()
  {
    ScopedRecreateFolders theCleaner( this );
    try
    {
      FolderSpecification fs_sv( cool_FolderVersioning_Mode::SINGLE_VERSION,
                                 payloadSpec );
      FolderSpecification fs_mv( cool_FolderVersioning_Mode::MULTI_VERSION,
                                 payloadSpec );

      s_db->createFolder( "/f_sv", fs_sv, "a description" );
      s_db->createFolder( "/f_mv", fs_mv, "a description" );

      s_db->createFolder( "/fs_sv", fs_sv, "a description" );
      s_db->createFolder( "/fs_mv", fs_mv, "a description" );

      IFolderPtr folder = s_db->getFolder( "/f_sv" );
      CPPUNIT_ASSERT( fs_sv == folder->folderSpecification() );

      folder = s_db->getFolder( "/f_mv" );
      CPPUNIT_ASSERT( fs_mv == folder->folderSpecification() );

      folder = s_db->getFolder( "/fs_sv" );
      CPPUNIT_ASSERT( fs_sv == folder->folderSpecification() );

      folder = s_db->getFolder( "/fs_mv" );
      CPPUNIT_ASSERT( fs_mv == folder->folderSpecification() );
    } catch ( Exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }


  /// Tests storeObject using an empty Record (bug #24464)
  /// Also test the payloadValue templated method (task #2859)
  void test_storeObject_emptyRecord()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    Record payload10;
    Record payload20( dummyPayload( 20 ) );
    Record payload30;
    RecordSpecification payload40Spec; // reshuffle the order
    {
      payload40Spec.extend("X",cool_StorageType_TypeId::Float);
      payload40Spec.extend("I",cool_StorageType_TypeId::Int32);
      payload40Spec.extend("S",cool_StorageType_TypeId::String4k);
    }
    Record payload40( payload40Spec );
    {
      int index = 40;
      payload40["I"].setValue<Int32>( index );
      std::stringstream s;
      s << "Object " << index;
      payload40["S"].setValue<String4k>( s.str() );
      payload40["X"].setValue<Float>( (float)(index/1000.) );
    }
    Record payload50;
    ChannelId chId = 1;
    folder->setupStorageBuffer();
    folder->storeObject( 10, 20, payload10, chId );
    folder->storeObject( 20, 30, payload20, chId );
    folder->storeObject( 30, 40, payload30, chId );
    folder->storeObject( 40, 50, payload40, chId );
    folder->storeObject( 50, 60, payload50, chId );
    folder->flushStorageBuffer();
    // Read back
    IObjectPtr obj = folder->findObject( 10, chId );
    CPPUNIT_ASSERT( obj.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p10 size", dummyPayload( 20 ).size() , obj->payload().size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p10[I] null", true, obj->payload()["I"].isNull() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p10[I] value", std::string("NULL"), obj->payloadValue("I") );
    CPPUNIT_ASSERT_THROW
      ( obj->payloadValue<Int32>("I"), FieldIsNull );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p10[X] null", true, obj->payload()["X"].isNull() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p10[X] value", std::string("NULL"), obj->payloadValue("X") );
    CPPUNIT_ASSERT_THROW
      ( obj->payloadValue<Float>("X"), FieldIsNull );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p10[S]", std::string(""), obj->payload()["S"].data<std::string>() );
    //std::cout << std::endl << "p10()[S] NULL is " << ( obj->payload()["S"].isNull() ? "T" : "F" ) << std::endl;
    //std::cout << "p10()[S] = '" << obj->payload()["S"].data<std::string>() << "'" << std::endl;
    //std::cout << "p10(S) = '" << obj->payloadValue("S") << "'" << std::endl;
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p10[S] null", false, obj->payload()["S"].isNull() ); // "", not null
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p10[S] value", std::string(""), obj->payloadValue("S") );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p10[S] val<>", std::string(""), obj->payloadValue<String4k>("S") );
    // Warning: hardcode string representations of dummyPayload
    obj = folder->findObject( 20, chId );
    CPPUNIT_ASSERT( obj.get() != 0 );
    CPPUNIT_ASSERT_MESSAGE( "p20", obj->payload() == payload20 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p20[I] value", std::string("20"), obj->payloadValue("I") );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p20[I] val<>", 20, obj->payloadValue<Int32>("I") );
    CPPUNIT_ASSERT_THROW
      ( obj->payloadValue<Float>("I"), FieldWrongCppType );
    CPPUNIT_ASSERT_THROW
      ( obj->payloadValue<String4k>("I"), FieldWrongCppType );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p20[X] value", std::string("0.02"), obj->payloadValue("X") );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p20[X] val<>", (Float)0.02, obj->payloadValue<Float>("X") );
    CPPUNIT_ASSERT_THROW
      ( obj->payloadValue<Int32>("X"), FieldWrongCppType );
    CPPUNIT_ASSERT_THROW
      ( obj->payloadValue<String4k>("X"), FieldWrongCppType );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p20[S] value", std::string("Object 20"), obj->payloadValue("S") );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p20[S] val<>", std::string("Object 20"),
        obj->payloadValue<String4k>("S") );
    CPPUNIT_ASSERT_THROW
      ( obj->payloadValue<Int32>("S"), FieldWrongCppType );
    CPPUNIT_ASSERT_THROW
      ( obj->payloadValue<Float>("S"), FieldWrongCppType );
    obj = folder->findObject( 30, chId );
    CPPUNIT_ASSERT( obj.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p30 size", dummyPayload( 30 ).size(), obj->payload().size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p30[I] null", true, obj->payload()["I"].isNull() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p30[X] null", true, obj->payload()["X"].isNull() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p30[S]", std::string(""), obj->payload()["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p30[S] null", false, obj->payload()["S"].isNull() ); // "", not null
    obj = folder->findObject( 40, chId );
    CPPUNIT_ASSERT( obj.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p40 size", dummyPayload( 40 ).size(), obj->payload().size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p40[I] null", false, obj->payload()["I"].isNull() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p40[I]", payload40["I"].data<int>(),
        obj->payload()["I"].data<int>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p40[X] null", false, obj->payload()["X"].isNull() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p40[X]", payload40["X"].data<float>(),
        obj->payload()["X"].data<float>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p40[S] null", false, obj->payload()["S"].isNull() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p40[S]", payload40["S"].data<std::string>(),
        obj->payload()["S"].data<std::string>() );
    obj = folder->findObject( 50, chId );
    CPPUNIT_ASSERT( obj.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p50 size", dummyPayload( 50 ).size() , obj->payload().size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p50[I] null", true, obj->payload()["I"].isNull() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p50[X] null", true, obj->payload()["X"].isNull() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p50[S]", std::string(""), obj->payload()["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "p50[S] null", false, obj->payload()["S"].isNull() ); // "", not null
  }

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  /// Tests a special case (bug) related to an order column in conjunction
  /// with a string type field. (Related to bug #16189.)
  void test_attribute_name_order_string()
  {
    ScopedRecreateFolders theCleaner( this );
    RecordSpecification spec;
    spec.extend( "order", cool_StorageType_TypeId::String4k );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, spec );
    IFolderPtr f = s_db->createFolder( "/f", fSpec );
    CPPUNIT_ASSERT( s_db->existsFolder( "/f" ) );
    Record payload( spec );
    f->storeObject( 0, 2, payload, 0 );
    IObjectPtr obj = f->findObject( 1, 0 );
    CPPUNIT_ASSERT( obj.get() != 0 );
  }

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  /// Related to bug #15871.
  /// As of COOL_2_0_0 it is impossible to create a payload name "is-a".
  void test_attribute_names_isa()
  {
    //ScopedRecreateFolders theCleaner( this ); // not needed
    RecordSpecification spec;
    spec.extend( "is-a", cool_StorageType_TypeId::Int32 );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, spec );
    CPPUNIT_ASSERT_THROW( s_db->createFolder( "/f", fSpec ),
                          PayloadSpecificationInvalidFieldName );
    CPPUNIT_ASSERT( ! s_db->existsFolder( "/f" ) );
  }

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  /// Tests that attribute names are properly quoted by the backends,
  /// i.e. that for example reserved words like 'order' can be used as
  /// attribute names. (Related to bug #16189.)
  void test_attribute_names()
  {
    ScopedRecreateFolders theCleaner( this );
    RecordSpecification spec;
    spec.extend( "select", cool_StorageType_TypeId::Int32 );
    spec.extend( "from", cool_StorageType_TypeId::Int32 );
    spec.extend( "where", cool_StorageType_TypeId::Int32 );
    spec.extend( "order", cool_StorageType_TypeId::Int32 );
    spec.extend( "by", cool_StorageType_TypeId::Int32 );
    spec.extend( "in", cool_StorageType_TypeId::Int32 );
    spec.extend( "group", cool_StorageType_TypeId::Int32 );
    spec.extend( "delete", cool_StorageType_TypeId::Int32 );
    spec.extend( "drop", cool_StorageType_TypeId::Int32 );
    spec.extend( "int", cool_StorageType_TypeId::Int32 );
    spec.extend( "float", cool_StorageType_TypeId::Int32 );
    spec.extend( "double", cool_StorageType_TypeId::Int32 );
    spec.extend( "varchar", cool_StorageType_TypeId::Int32 );
    spec.extend( "varchar2", cool_StorageType_TypeId::Int32 );
    spec.extend( "char", cool_StorageType_TypeId::Int32 );
    spec.extend( "number", cool_StorageType_TypeId::Int32 );
    spec.extend( "decimal", cool_StorageType_TypeId::Int32 );
    spec.extend( "blob", cool_StorageType_TypeId::Int32 );
    spec.extend( "clob", cool_StorageType_TypeId::Int32 );
    spec.extend( "string", cool_StorageType_TypeId::Int32 );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, spec );
    IFolderPtr f = s_db->createFolder( "/f", fSpec );
    CPPUNIT_ASSERT( s_db->existsFolder( "/f" ) );
    Record payload( spec );
    f->storeObject( 0, 2, payload, 0 );
    IObjectPtr obj = f->findObject( 1, 0 );
    CPPUNIT_ASSERT( obj.get() != 0 );
  }

  /// Tests user tag behavior with the reserved name 'HEAD'
  void test_userTag_HEAD()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    try
    {
      ChannelId ch = 0;
      folder->storeObject( 0, 10, dummyPayload( 1 ), ch, "HEAD" );
      // AV The above should not trow: "" and "HEAD" are equivalent,
      // this is the default argument for storing IOVs with no user tag!
      //CPPUNIT_FAIL( "Using HEAD as a user tag should fail" );
    }
    //catch ( ReservedHeadTag& ) {}
    catch ( std::exception& e ) {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  void test_cloneHeadTag( )
  {
    test_cloneHeadTag( cool_PayloadMode_Mode::INLINEPAYLOAD );
  };

  void test_cloneHeadTag_sepPayload( )
  {
    test_cloneHeadTag( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  };

  void test_cloneHeadTag_vector( )
  {
    test_cloneHeadTag( cool_PayloadMode_Mode::VECTORPAYLOAD );
  };

  void test_cloneHeadTag( PayloadMode::Mode pMode )
  {
    IFolderPtr folder = s_db->getFolder( payloadMode2Folder( pMode ) );
    try
    {
      folder->storeObject(  0, 10, dummyPayload( 0010 ), 0);
      folder->storeObject(  5, 20, dummyPayload( 0520 ), 0);
      folder->storeObject(  3, 30, dummyPayload( 0330 ), 1);
      folder->storeObject( 20, 40, dummyPayload( 2040 ), 1);
      folder->storeObject(  3, 30, dummyPayload( 0330 ), 9);
      folder->storeObject( 20, 40, dummyPayload( 2040 ), 9);
      folder->storeObject( 40, 60, dummyPayload( 2040 ), 9);
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Count ",
                                    2u, folder->countObjects(0,100,0));
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Count ",
                                    2u, folder->countObjects(0,100,1));
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Count ",
                                    3u, folder->countObjects(0,100,9));
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Exist ", false,
                                    s_db->existsTag("A1") );
      folder->tagCurrentHead("A1","tag1");
      folder->storeObject(  35, 50, dummyPayload( 3550 ), 1);
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Count ",
                                    3u, folder->countObjects(0,100,1));
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Exist ", false,
                                    s_db->existsTag("A1_clone") );
      folder->cloneTagAsUserTag("A1","A1_clone","clone of tag A1");
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Exist ", true,
                                    s_db->existsTag("A1_clone") );
      // check if A1_clone is correct
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "5 Count ", 2u, folder->countObjects(0,100,0,"A1_clone"));
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "6 Count ", 2u, folder->countObjects(0,100,1,"A1_clone"));
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "7 Count ", 3u, folder->countObjects(0,100,9,"A1_clone"));
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Clone tag description ",
          std::string("clone of tag A1"),
          folder->tagDescription("A1_clone"));
      // head remains unchanged
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 Count ",
                                    2u, folder->countObjects(0,100,0));
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "9 Count ",
                                    3u, folder->countObjects(0,100,1));
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "10 Count ",
                                    3u, folder->countObjects(0,100,9));
      // inserting into head still works without bulk buffer
      folder->storeObject( 55, 70, dummyPayload( 5570 ), 9);
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "11 Count ",
                                    4u, folder->countObjects(0,100,9));
      // can't reuse tag names for cloning
      CPPUNIT_ASSERT_THROW( folder->cloneTagAsUserTag( "HEAD", "A1" ),
                            TagExists);
      CPPUNIT_ASSERT_THROW( folder->cloneTagAsUserTag( "HEAD", "A1_clone" ),
                            TagExists);
      // but we can force to overwrite user tags
      folder->cloneTagAsUserTag( "HEAD", "A1_clone",
                                 "updated clone of tag HEAD",true);
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "12 Count ", 2u, folder->countObjects(0,100,0,"A1_clone"));
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "13 Count ", 3u, folder->countObjects(0,100,1,"A1_clone"));
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "14 Count ", 4u, folder->countObjects(0,100,9,"A1_clone"));
      // now compare the result when browsing both channels
      IObjectIteratorPtr objs =
        folder->browseObjects( ValidityKeyMin, ValidityKeyMax,
                               ChannelSelection::all(), "HEAD" );
      IObjectIteratorPtr objs1 =
        folder->browseObjects( ValidityKeyMin, ValidityKeyMax,
                               ChannelSelection::all(), "A1_clone");
      for ( unsigned int i = 0; i < objs->size(); ++i ) {
        IObjectPtr obj = getNext(objs);
        IObjectPtr obj1 = getNext(objs1);
        std::stringstream s;
        s << "object " << i << " ";
        if (pMode == cool_PayloadMode_Mode::SEPARATEPAYLOAD)
        {
          // check that we didn't reinsert the payload during cloning
          RelationalObject* relobj = dynamic_cast<RelationalObject*>(&*obj);
          if ( !relobj ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
          unsigned int payloadId = relobj->payloadId();
          RelationalObject* relobj1 = dynamic_cast<RelationalObject*>(&*obj1);
          if ( !relobj1 ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
          unsigned int payloadId1 = relobj1->payloadId();
          CPPUNIT_ASSERT_MESSAGE( ( s.str() + "payloadId" ).c_str(),
                                  payloadId == payloadId1 );
        }
        else if ( pMode == cool_PayloadMode_Mode::VECTORPAYLOAD )
        {
          // check that we didn't reinsert the payload during cloning
          RelationalObject* relobj = dynamic_cast<RelationalObject*>(&*obj);
          if ( !relobj ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
          unsigned int payloadSetId = relobj->payloadSetId();
          RelationalObject* relobj1 = dynamic_cast<RelationalObject*>(&*obj1);
          if ( !relobj1 ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
          unsigned int payloadSetId1 = relobj1->payloadSetId();
          CPPUNIT_ASSERT_MESSAGE( ( s.str() + "payloadSetId" ).c_str(),
                                  payloadSetId == payloadSetId1 );
        };
        CPPUNIT_ASSERT_MESSAGE( ( s.str() + "payload" ).c_str(),
                                obj1->payload() == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "since" ).c_str(),
                                      obj1->since(), obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "until" ).c_str(),
                                      obj1->until(), obj->until() );
      }
    }
    catch ( std::exception& e )
    {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  /// Tests tagging behavior for user tagging with an already issued tag
  void test_userTag_with_tag()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    try
    {
      ChannelId ch = 0;
      folder->storeObject( 0, 10, dummyPayload( 1 ), ch );
      folder->tagCurrentHead( "A" );
      CPPUNIT_ASSERT_MESSAGE( "tag exists", s_db->existsTag( "A" ) );
      folder->storeObject( 0, 10, dummyPayload( 1 ), ch, "A" );
      CPPUNIT_FAIL( "this point should not be reached - exception expected" );
    } catch ( TagExists& e ) {
      CPPUNIT_ASSERT_EQUAL( std::string("Tag 'A' already exists"),
                            std::string( e.what() ) );
    }
  }

  /// Tests tagging behavior for tagging with an already issued user tag
  void test_tag_with_userTag()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    try
    {
      ChannelId ch = 0;
      folder->storeObject( 0, 10, dummyPayload( 1 ), ch, "A" );
      CPPUNIT_ASSERT_MESSAGE( "user tag exists",
                              folder->existsUserTag( "A" ) );
      folder->tagCurrentHead( "A" );
      CPPUNIT_FAIL( "this point should not be reached - exception expected" );
    } catch ( TagExists& e ) {
      CPPUNIT_ASSERT_EQUAL( std::string("Tag 'A' already exists"),
                            std::string( e.what() ) );
    }
  }

  /// Tests that storeObjects with a user tag on a SV folder throws an
  /// exception.
  void test_storeObject_userTag_SV()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    try
    {
      ChannelId ch = 0;
      folder->storeObject( 0, 10, dummyPayload( 1 ), ch, "A" );
      CPPUNIT_FAIL( "this point should not be reached - exception expected" );
    }
    catch ( FolderIsSingleVersion& e )
    {
      FolderIsSingleVersion
        eExp( "/fSV", "Cannot store a SV object with user tag: A", "" );
      CPPUNIT_ASSERT_EQUAL
        ( std::string( eExp.what() ), std::string( e.what() ) );
    }
  }

  /// Tests storeObjects with a user tag and flag userTagOnly==true
  void test_storeObject_userTag_userTagOnly()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    ChannelId ch = 0;
    try
    {
      folder->storeObject(  0, 100, dummyPayload( 1 ), ch, "A", false );
      folder->storeObject( 10,  20, dummyPayload( 2 ), ch,  "", false );
      folder->storeObject( 80,  90, dummyPayload( 3 ), ch, "A", true );
      folder->storeObject( 10,  90, dummyPayload( 4 ), ch, "B", true );
      folder->storeObject( 30,  70, dummyPayload( 5 ), ch, "B", false );
      {
        IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                         ValidityKeyMax,
                                                         ch,
                                                         "" );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 5u,
                                      (unsigned int)objs->size() );
        IObjectPtr obj = getNext(objs);
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 id", 8u, obj->objectId() );
        CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
                                dummyPayload( 1 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
                                      (ValidityKey)0, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
                                      (ValidityKey)10, obj->until() );
        obj = getNext(objs);
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 id", 7u, obj->objectId() );
        CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                                dummyPayload( 2 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
                                      (ValidityKey)10, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
                                      (ValidityKey)20, obj->until() );
        obj = getNext(objs);
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 id", 26u, obj->objectId() );
        CPPUNIT_ASSERT_MESSAGE( "obj 3 payload",
                                dummyPayload( 1 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 since",
                                      (ValidityKey)20, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 until",
                                      (ValidityKey)30, obj->until() );
        obj = getNext(objs);
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 4 id", 25u, obj->objectId() );
        CPPUNIT_ASSERT_MESSAGE( "obj 4 payload",
                                dummyPayload( 5 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 4 since",
                                      (ValidityKey)30, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 4 until",
                                      (ValidityKey)70, obj->until() );
        obj = getNext(objs);
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 5 id", 27u, obj->objectId() );
        CPPUNIT_ASSERT_MESSAGE( "obj 5 payload",
                                dummyPayload( 1 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 5 since",
                                      (ValidityKey)70, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 5 until",
                                      (ValidityKey)100, obj->until() );
      }
      {
        IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                         ValidityKeyMax,
                                                         ch,
                                                         "A" );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 3u,
                                      (unsigned int)objs->size() );
        IObjectPtr obj = getNext(objs);
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 id", 17u, obj->objectId() );
        CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
                                dummyPayload( 1 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
                                      (ValidityKey)0, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
                                      (ValidityKey)80, obj->until() );
        obj = getNext(objs);
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 id", 16u, obj->objectId() );
        CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                                dummyPayload( 3 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
                                      (ValidityKey)80, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
                                      (ValidityKey)90, obj->until() );
        obj = getNext(objs);
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 id", 18u, obj->objectId() );
        CPPUNIT_ASSERT_MESSAGE( "obj 3 payload",
                                dummyPayload( 1 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 since",
                                      (ValidityKey)90, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 until",
                                      (ValidityKey)100, obj->until() );
      }
      {
        IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                         ValidityKeyMax,
                                                         ch,
                                                         "B" );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 3u,
                                      (unsigned int)objs->size() );
        IObjectPtr obj = getNext(objs);
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 id", 29u, obj->objectId() );
        CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
                                dummyPayload( 4 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
                                      (ValidityKey)10, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
                                      (ValidityKey)30, obj->until() );
        obj = getNext(objs);
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 id", 28u, obj->objectId() );
        CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                                dummyPayload( 5 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
                                      (ValidityKey)30, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
                                      (ValidityKey)70, obj->until() );
        obj = getNext(objs);
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 id", 30u, obj->objectId() );
        CPPUNIT_ASSERT_MESSAGE( "obj 3 payload",
                                dummyPayload( 4 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 since",
                                      (ValidityKey)70, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 until",
                                      (ValidityKey)90, obj->until() );
      }
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests exceptions from storeObjects with a user tag
  /// and flag userTagOnly==true
  void test_storeObject_userTag_userTagOnly_exceptions()
  {
    IFolderPtr fSV = s_db->getFolder( "/fSV" );
    IFolderPtr fMV = s_db->getFolder( "/fMV" );
    ChannelId ch = 0;
    // SV exceptions
    {
      try
      {
        bool userTagOnly = true;
        fSV->storeObject( 0, 10, dummyPayload( 1 ), ch, "A", userTagOnly );
        CPPUNIT_FAIL( "userTagOnly==true should throw for SV" );
      }
      catch ( RelationalException& ) {}
    }
    // MV exception - userTag=""
    {
      try
      {
        bool userTagOnly = true;
        fMV->storeObject( 0, 10, dummyPayload( 1 ), ch, "", userTagOnly );
        CPPUNIT_FAIL( "userTagOnly==true should throw for HEAD" );
      }
      catch ( RelationalException& ) {}
    }
    // MV exception - mix in bulk insertion
    {
      fMV->setupStorageBuffer( true );
      bool userTagOnly = true;
      fMV->storeObject( 0, 10, dummyPayload( 1 ), ch, "A", userTagOnly );
      try
      {
        userTagOnly = false;
        fMV->storeObject( 10, 20, dummyPayload( 2 ), ch, "A", userTagOnly );
        CPPUNIT_FAIL( "userTagOnly should throw if mixed" );
      }
      catch ( RelationalException& ) {}
      try
      {
        userTagOnly = true;
        fMV->storeObject( 20, 30, dummyPayload( 3 ), ch, "A", userTagOnly );
        fMV->flushStorageBuffer();
      }
      catch ( std::exception& e)
      {
        std::cout << "Exception caught: " << e.what() << std::endl;
        throw;
      }
    }
  }

  void test_userTag_example1()
  {
    test_userTag_example1( cool_PayloadMode_Mode::INLINEPAYLOAD );
  };

  void test_userTag_example1_sepPayload()
  {
    test_userTag_example1( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  };

  void test_userTag_example1_vector()
  {
    test_userTag_example1( cool_PayloadMode_Mode::VECTORPAYLOAD );
  };

  // Tests the user tag implementation for example #1
  void test_userTag_example1( PayloadMode::Mode pMode )
  {
    IFolderPtr folder = s_db->getFolder( payloadMode2Folder( pMode ) );
    ChannelId ch = 0;
    folder->storeObject( 0, 10, dummyPayload( 1 ), ch );
    folder->storeObject( 1, 5, dummyPayload( 2 ), ch, "A" );
    folder->storeObject( 3, 8, dummyPayload( 3 ), ch, "B" );
    folder->storeObject( 2, 4, dummyPayload( 4 ), ch, "A" );
    folder->storeObject( 3, 7, dummyPayload( 5 ), ch, "B" );
    {
      IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                       ValidityKeyMax,
                                                       ch );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "HEAD object count", 6u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
                              dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
                                    (ValidityKey)1, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                              dummyPayload( 2 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
                                    (ValidityKey)1, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
                                    (ValidityKey)2, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 3 payload",
                              dummyPayload( 4 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 since",
                                    (ValidityKey)2, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 until",
                                    (ValidityKey)3, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 4 payload",
                              dummyPayload( 5 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 4 since",
                                    (ValidityKey)3, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 4 until",
                                    (ValidityKey)7, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 5 payload",
                              dummyPayload( 3 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 5 since",
                                    (ValidityKey)7, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 5 until",
                                    (ValidityKey)8, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 6 payload",
                              dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 5 since",
                                    (ValidityKey)8, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 5 until",
                                    (ValidityKey)10, obj->until() );
    }
    {
      CPPUNIT_ASSERT_MESSAGE( "tag 'A'", s_db->existsTag( "A" ) );
      IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                       ValidityKeyMax,
                                                       ch,
                                                       "A");
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "tag A object count", 3u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
                              dummyPayload( 2 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
                                    (ValidityKey)1, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
                                    (ValidityKey)2, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                              dummyPayload( 4 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
                                    (ValidityKey)2, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
                                    (ValidityKey)4, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 3 payload",
                              dummyPayload( 2 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 since",
                                    (ValidityKey)4, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 until",
                                    (ValidityKey)5, obj->until() );
    }
    {
      CPPUNIT_ASSERT_MESSAGE( "tag 'B'", s_db->existsTag( "B" ) );
      IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                       ValidityKeyMax,
                                                       ch,
                                                       "B" );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "tag B object count", 2u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
                              dummyPayload( 5 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
                                    (ValidityKey)3, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
                                    (ValidityKey)7, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                              dummyPayload( 3 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
                                    (ValidityKey)7, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
                                    (ValidityKey)8, obj->until() );
    }
  }

  void test_browseObjects_userTag()
  {
    test_browseObjects_userTag( cool_PayloadMode_Mode::INLINEPAYLOAD );
  };

  void test_browseObjects_userTag_sepPayload()
  {
    test_browseObjects_userTag( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  };

  void test_browseObjects_userTag_vector()
  {
    test_browseObjects_userTag( cool_PayloadMode_Mode::VECTORPAYLOAD );
  };

  /// Tests browsing a user tag selection
  void test_browseObjects_userTag( PayloadMode::Mode pMode )
  {
    IFolderPtr folder = s_db->getFolder( payloadMode2Folder( pMode ) );
    try
    {
      ChannelId ch = 0;
      folder->storeObject( 0, 10, dummyPayload( 1 ), ch, "A" );
      folder->storeObject( 1, 5, dummyPayload( 2 ), ch, "A" );
      IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                       ValidityKeyMax,
                                                       ch,
                                                       "A" );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 3u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 id", 11u, obj->objectId() );
      CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
                              dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
                                    (ValidityKey)1, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 id", 10u, obj->objectId() );
      CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                              dummyPayload( 2 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
                                    (ValidityKey)1, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
                                    (ValidityKey)5, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 id", 12u, obj->objectId() );
      CPPUNIT_ASSERT_MESSAGE( "obj 3 payload",
                              dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 since",
                                    (ValidityKey)5, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 until",
                                    (ValidityKey)10, obj->until() );
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  void test_userTag_browseObjects_HEAD_insulation()
  {
    test_userTag_browseObjects_HEAD_insulation( cool_PayloadMode_Mode::INLINEPAYLOAD );
  };

  void test_userTag_browseObjects_HEAD_insulation_sepPayload()
  {
    test_userTag_browseObjects_HEAD_insulation( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  };

  void test_userTag_browseObjects_HEAD_insulation_vector()
  {
    test_userTag_browseObjects_HEAD_insulation( cool_PayloadMode_Mode::VECTORPAYLOAD );
  };

  // Tests that user tag insertion is treated like normal insertion
  // with respect to the HEAD
  // In other words when the HEAD is browsed the following two insertions
  // are absolutely identical:
  // 1)
  //    folder->storeObject( 0, 10, dummyPayload( 1 ), ch );
  //    folder->storeObject( 1, 5, dummyPayload( 2 ), ch );
  // 2)
  //    folder->storeObject( 0, 10, dummyPayload( 1 ), ch );
  //    folder->storeObject( 1, 5, dummyPayload( 2 ), ch, "A" );
  void test_userTag_browseObjects_HEAD_insulation( PayloadMode::Mode pMode )
  {
    IFolderPtr folder = s_db->getFolder( payloadMode2Folder( pMode ) );
    ChannelId ch = 0;
    folder->storeObject( 0, 10, dummyPayload( 1 ), ch );
    folder->storeObject( 1, 5, dummyPayload( 2 ), ch, "A" );
    IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                     ValidityKeyMax,
                                                     ch );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "HEAD object count", 3u,
                                  (unsigned int)objs->size() );
    IObjectPtr obj = getNext(objs);
    CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
                            dummyPayload( 1 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
                                  (ValidityKey)0, obj->since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
                                  (ValidityKey)1, obj->until() );
    obj = getNext(objs);
    CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                            dummyPayload( 2 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
                                  (ValidityKey)1, obj->since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
                                  (ValidityKey)5, obj->until() );
    obj = getNext(objs);
    CPPUNIT_ASSERT_MESSAGE( "obj 3 payload",
                            dummyPayload( 1 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 since",
                                  (ValidityKey)5, obj->since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 until",
                                  (ValidityKey)10, obj->until() );
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

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  /// Tests behavior when nodes with conflicting names are attempted to be
  /// created. Issue raised by Shaun Roe 2005-12-14. Bug #14248
  void test_node_nameclash()
  {
    //ScopedRecreateFolders theCleaner( this ); // not needed
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    try
    {
      IFolderPtr folder = s_db->getFolder( "/fSV" );
      folder = s_db->createFolder( "/fSV/sub", fSpec );
      CPPUNIT_FAIL( "exception expected" );
    }
    catch ( cool::RelationalException& e )
    {
      std::string msg = "Cannot create node '/fSV/sub', because the parent "
        "path contains a leaf node";
      CPPUNIT_ASSERT_EQUAL( msg, std::string( e.what() ) );
    }
  }

  void test_objectCount_MV()
  {
    test_objectCount_MV( cool_PayloadMode_Mode::INLINEPAYLOAD );
  };

  void test_objectCount_MV_sepPayload()
  {
    test_objectCount_MV( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  };

  void test_objectCount_MV_vector()
  {
    test_objectCount_MV( cool_PayloadMode_Mode::VECTORPAYLOAD );
  };

  /// Tests countObject for a MV folder
  void test_objectCount_MV( PayloadMode::Mode pMode )
  {
    IFolderPtr folder = s_db->getFolder( payloadMode2Folder( pMode ) );
    folder->setupStorageBuffer();
    for ( ChannelId ch = 0; ch < 5; ++ch ) {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), ch );
      folder->storeObject( 1, ValidityKeyMax, dummyPayload( 1 ), ch );
      folder->storeObject( 2, ValidityKeyMax, dummyPayload( 2 ), ch );
      folder->storeObject( 3, ValidityKeyMax, dummyPayload( 3 ), ch );
      folder->storeObject( 4, ValidityKeyMax, dummyPayload( 4 ), ch );
    }
    folder->flushStorageBuffer();
    folder->tagCurrentHead( "A" );
    for ( ChannelId ch = 0; ch < 5; ++ch ) {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), ch );
    }
    folder->flushStorageBuffer();
    folder->tagCurrentHead( "B" );
    ValidityKey since = 1;
    ValidityKey until = 3;
    ChannelSelection channels( 2, 3 );
    int count = folder->countObjects( since, until, channels, "A" );
    CPPUNIT_ASSERT_EQUAL( 6, count );
  }

  /// Tests countObject for a SV folder
  void test_objectCount_SV()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->setupStorageBuffer();
    for ( ChannelId ch = 0; ch < 5; ++ch ) {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), ch );
      folder->storeObject( 1, ValidityKeyMax, dummyPayload( 1 ), ch );
      folder->storeObject( 2, ValidityKeyMax, dummyPayload( 2 ), ch );
      folder->storeObject( 3, ValidityKeyMax, dummyPayload( 3 ), ch );
      folder->storeObject( 4, ValidityKeyMax, dummyPayload( 4 ), ch );
    }
    folder->flushStorageBuffer();
    ValidityKey since = 1;
    ValidityKey until = 3;
    ChannelSelection channels( 2, 3 );
    int count = folder->countObjects( since, until, channels );
    CPPUNIT_ASSERT_EQUAL( 6, count );
  }

  /// Tests storing unordered, non-overlapping SV IOVS (all closed).
  /// See https://savannah.cern.ch/task/?func=detailitem&item_id=3138:
  /// tests that the functionality of use case #3 is provided
  /// (back-insertion is allowed for single-IOV single-channel insertion).
  void test_storeObject_SV_unordered_closed()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->storeObject( 2, 4, dummyPayload( 2 ), 0 );
    folder->storeObject( 0, 2, dummyPayload( 1 ), 0 );
    IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                     ValidityKeyMax, 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 2u,
                                  (unsigned int)objs->size() );
    IObjectPtr obj = getNext(objs);
    CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
                            dummyPayload( 1 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
                                  (ValidityKey)0, obj->since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
                                  (ValidityKey)2, obj->until() );
    obj = getNext(objs);
    CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                            dummyPayload( 2 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
                                  (ValidityKey)2, obj->since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
                                  (ValidityKey)4, obj->until() );
  }

  /// Tests that the HAS_NEW_DATA flag is properly reset for back-inserted
  /// IOVs.
  void test_storeObject_SV_unordered_has_new_data_flag()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->storeObject( 2, 4, dummyPayload( 2 ), 0 );
    folder->storeObject( 0, 2, dummyPayload( 1 ), 0 );
    /// We don't typically go below the public/relational interface layer
    /// in this unit test suite. For that reason this test belongs more in
    /// test_RalObjectMgr. However, with respect to what functionality is
    /// being tested this test is more at home here.
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    TransRalDatabase* traldb = dynamic_cast<TransRalDatabase*>( s_db.get() );
    if ( !traldb ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RalDatabase* ralDb = traldb->getRalDb();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalChannelTable channelTable( *ralDb, *relfolder );
    RelationalTableRow row = channelTable.fetchRowForId( 0 );
    CPPUNIT_ASSERT_EQUAL
      ( (ChannelId)0, row["CHANNEL_ID"].data<ChannelId>() );
    CPPUNIT_ASSERT_EQUAL
      ( 1u, row["LAST_OBJECT_ID"].data<unsigned int>() );
    CPPUNIT_ASSERT_EQUAL
      ( false, row["HAS_NEW_DATA"].data<bool>() );
    CPPUNIT_ASSERT_EQUAL
      ( std::string(""), row["CHANNEL_NAME"].data<std::string>() );
    transaction.commit();
  }

  /// Tests storing unordered, non-overlapping SV IOVS (all closed but one).
  /// See https://savannah.cern.ch/task/?func=detailitem&item_id=3138:
  /// tests that the functionality of use case #3 is provided
  /// (back-insertion is allowed for single-IOV single-channel insertion).
  void test_storeObject_SV_unordered_open()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->storeObject( 4, ValidityKeyMax, dummyPayload( 1 ), 0 );
    folder->storeObject( 2, 3, dummyPayload( 2 ), 0 );
    folder->storeObject( 5, 6, dummyPayload( 3 ), 0 );
    IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                     ValidityKeyMax, 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 3u,
                                  (unsigned int)objs->size() );
    IObjectPtr obj = getNext(objs);
    CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
                            dummyPayload( 2 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
                                  (ValidityKey)2, obj->since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
                                  (ValidityKey)3, obj->until() );
    obj = getNext(objs);
    CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                            dummyPayload( 1 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
                                  (ValidityKey)4, obj->since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
                                  (ValidityKey)5, obj->until() );
    obj = getNext(objs);
    CPPUNIT_ASSERT_MESSAGE( "obj 3 payload",
                            dummyPayload( 3 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 since",
                                  (ValidityKey)5, obj->since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 until",
                                  (ValidityKey)6, obj->until() );
  }

  /// Tests storing unordered, non-overlapping SV IOVS (all closed).
  /// See https://savannah.cern.ch/task/?func=detailitem&item_id=3138:
  /// tests that the functionality of use case #1 is NOT YET provided
  /// (back-insertion is not yet allowed for bulk inserting
  /// more than one IOV per channel - in single or multi channel mode).
  void test_storeObject_SV_unordered_bulk_closed()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->setupStorageBuffer();
    folder->storeObject( 2, 4, dummyPayload( 2 ), 0 );
    folder->storeObject( 0, 2, dummyPayload( 1 ), 0 );
    try
    {
      folder->flushStorageBuffer();
    }
    catch ( std::exception& e )
    {
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "4 until",
          std::string( "Overlapping intervals "
                       "not allowed in SINGLE_VERSION mode" ),
          std::string( e.what() ) );
    }
    IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                     ValidityKeyMax, 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 0u,
                                  (unsigned int)objs->size() );
    /*
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 2u,
      (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
      dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
      (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
      (ValidityKey)2, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
      dummyPayload( 2 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
      (ValidityKey)2, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
      (ValidityKey)4, obj->until() );
    *///
  }

  /// Tests storing unordered, non-overlapping SV IOVS (all closed but one).
  /// See https://savannah.cern.ch/task/?func=detailitem&item_id=3138:
  /// tests that the functionality of use case #1 is NOT YET provided
  /// (back-insertion is not yet allowed for bulk inserting
  /// more than one IOV per channel - in single or multi channel mode).
  void test_storeObject_SV_unordered_bulk_open()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->setupStorageBuffer();
    folder->storeObject( 4, ValidityKeyMax, dummyPayload( 1 ), 0 );
    folder->storeObject( 2, 3, dummyPayload( 1 ), 0 );
    folder->storeObject( 5, 6, dummyPayload( 1 ), 0 );
    try
    {
      folder->flushStorageBuffer();
    }
    catch ( std::exception& e )
    {
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "4 until",
          std::string( "Overlapping intervals "
                       "not allowed in SINGLE_VERSION mode" ),
          //std::string( "Back-insertion not possible "
          //        "due to multiple objects in channel" ),
          std::string( e.what() ) );
    }
    IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                     ValidityKeyMax, 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 0u,
                                  (unsigned int)objs->size() );
    /*
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 3u,
      (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
      dummyPayload( 2 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
      (ValidityKey)2, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
      (ValidityKey)3, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
      dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
      (ValidityKey)4, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
      (ValidityKey)5, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 3 payload",
      dummyPayload( 3 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 since",
      (ValidityKey)5, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 until",
      (ValidityKey)6, obj->until() );
    *///
  }

  /// Tests storing unordered, non-overlapping SV IOVS (all closed but one).
  /// See https://savannah.cern.ch/task/?func=detailitem&item_id=3138:
  /// tests that the functionality of use case #1 is NOT YET provided
  /// (back-insertion is not yet allowed for bulk inserting
  /// more than one IOV per channel - in single or multi channel mode).
  /// NB - note the different exception message with respect to the
  /// previous test (different code segments)... is this correct?
  /// sas: Yes, that's intentional to
  /// a) provide better feedback for the user in case of an exception. By
  ///    giving them a clear idea what went wrong they can rearrange
  ///    insertion to comply with the implemented case #1 more easily
  /// b) allow me/us to find which part is actually throwing the exception
  ///    while we try to extend the functionality
  void test_storeObject_SV_unordered_bulk_open_2()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->storeObject( 4, ValidityKeyMax, dummyPayload( 1 ), 0 );
    folder->setupStorageBuffer();
    folder->storeObject( 2, 3, dummyPayload( 1 ), 0 );
    folder->storeObject( 5, 6, dummyPayload( 1 ), 0 );
    try
    {
      folder->flushStorageBuffer();
    }
    catch ( std::exception& e )
    {
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "4 until",
          //std::string( "Overlapping intervals "
          //        "not allowed in SINGLE_VERSION mode" ),
          std::string( "Back-insertion not possible "
                       "due to multiple objects in channel" ),
          std::string( e.what() ) );
    }
    IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                     ValidityKeyMax, 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 1u,
                                  (unsigned int)objs->size() );
    IObjectPtr obj = getNext(objs);
    CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                            dummyPayload( 1 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
                                  (ValidityKey)4, obj->since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
                                  ValidityKeyMax, obj->until() );
    /*
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 3u,
      (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
      dummyPayload( 2 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
      (ValidityKey)2, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
      (ValidityKey)3, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
      dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
      (ValidityKey)4, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
      (ValidityKey)5, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 3 payload",
      dummyPayload( 3 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 since",
      (ValidityKey)5, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 until",
      (ValidityKey)6, obj->until() );
    *///
  }

  /// Tests storing unordered, non-overlapping SV IOVS (all closed but one).
  /// See https://savannah.cern.ch/task/?func=detailitem&item_id=3138:
  /// tests that the functionality of use case #1 is NOT YET provided
  /// (back-insertion is not yet allowed for bulk inserting
  /// more than one IOV per channel - in single or multi channel mode).
  void test_storeObject_SV_unordered_bulk_open_3()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->setupStorageBuffer();
    folder->storeObject( 4, ValidityKeyMax, dummyPayload( 1 ), 0 );
    folder->storeObject( 2, 3, dummyPayload( 1 ), 0 );
    try
    {
      folder->flushStorageBuffer();
    }
    catch ( std::exception& e )
    {
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "4 until",
          std::string( "Overlapping intervals "
                       "not allowed in SINGLE_VERSION mode" ),
          //std::string( "Back-insertion not possible "
          //        "due to multiple objects in channel" ),
          std::string( e.what() ) );
    }
    IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                     ValidityKeyMax, 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 0u,
                                  (unsigned int)objs->size() );
    /*
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 2u,
      (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
      dummyPayload( 2 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
      (ValidityKey)2, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
      (ValidityKey)3, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
      dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
      (ValidityKey)4, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
      (ValidityKey)5, obj->until() );
    *///
  }

  /// Tests storing unordered, non-overlapping SV MC IOVS (all closed).
  /// See https://savannah.cern.ch/task/?func=detailitem&item_id=3138:
  /// tests that the functionality of use case #3 is provided
  /// (back-insertion is allowed for single-IOV multi-channel insertion).
  void test_storeObject_SV_unordered_MC_closed()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->storeObject( 0, 2, dummyPayload( 1 ), 1 );
    folder->storeObject( 2, 4, dummyPayload( 2 ), 1 );
    folder->storeObject( 2, 4, dummyPayload( 2 ), 2 );
    folder->storeObject( 0, 2, dummyPayload( 1 ), 2 );
    {
      IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                       ValidityKeyMax, 1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 2u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
                              dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
                                    (ValidityKey)2, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                              dummyPayload( 2 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
                                    (ValidityKey)2, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
                                    (ValidityKey)4, obj->until() );
    }
    {
      IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                       ValidityKeyMax, 2 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 2u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
                              dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
                                    (ValidityKey)2, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                              dummyPayload( 2 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
                                    (ValidityKey)2, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
                                    (ValidityKey)4, obj->until() );
    }
  }

  /// Tests storing unordered, non-overlapping SV MC IOVS (all closed).
  /// See https://savannah.cern.ch/task/?func=detailitem&item_id=3138:
  /// tests that the functionality of use case #1 is NOT YET provided
  /// (back-insertion is not yet allowed for bulk inserting
  /// more than one IOV per channel - in single or multi channel mode).
  void test_storeObject_SV_unordered_MC_bulk_closed()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->setupStorageBuffer();
    folder->storeObject( 0, 2, dummyPayload( 1 ), 1 );
    folder->storeObject( 2, 4, dummyPayload( 2 ), 1 );
    folder->storeObject( 2, 4, dummyPayload( 2 ), 2 );
    folder->storeObject( 0, 2, dummyPayload( 1 ), 2 );
    try
    {
      folder->flushStorageBuffer();
    }
    catch ( std::exception& e )
    {
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "multichannel",
          std::string( "Overlapping intervals "
                       "not allowed in SINGLE_VERSION mode" ),
          std::string( e.what() ) );
    }
    {
      IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                       ValidityKeyMax, 1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 0u,
                                    (unsigned int)objs->size() );
      /*
        IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
        ValidityKeyMax, 1 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 2u,
        (unsigned int)objs->size() );
        IObjectPtr obj = getNext(objs);
        CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
        dummyPayload( 1 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
        (ValidityKey)0, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
        (ValidityKey)2, obj->until() );
        obj = getNext(objs);
        CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
        dummyPayload( 2 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
        (ValidityKey)2, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
        (ValidityKey)4, obj->until() );
      *///
    }
    {
      IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                       ValidityKeyMax, 2 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 0u,
                                    (unsigned int)objs->size() );
      /*
        IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
        ValidityKeyMax, 2 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 2u,
        (unsigned int)objs->size() );
        IObjectPtr obj = getNext(objs);
        CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
        dummyPayload( 1 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
        (ValidityKey)0, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
        (ValidityKey)2, obj->until() );
        obj = getNext(objs);
        CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
        dummyPayload( 2 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
        (ValidityKey)2, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
        (ValidityKey)4, obj->until() );
      *///
    }
  }

  /// Tests storing unordered, non-overlapping SV MC IOVS (all closed).
  /// See https://savannah.cern.ch/task/?func=detailitem&item_id=3138:
  /// tests that the functionality of use case #2 is provided
  /// (back-insertion is allowed for bulk inserting
  /// at most one IOV per channel - in multi channel mode).
  void test_storeObject_SV_unordered_MC_bulk_closed_oneperchannel()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->setupStorageBuffer();
    folder->storeObject( 2, 4, dummyPayload( 2 ), 1 );
    folder->storeObject( 2, 4, dummyPayload( 2 ), 2 );
    folder->flushStorageBuffer();
    folder->storeObject( 0, 2, dummyPayload( 1 ), 1 );
    folder->storeObject( 0, 2, dummyPayload( 1 ), 2 );
    folder->flushStorageBuffer(); // Bulk-back-insert two IOVs (one per ch)
    {
      IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                       ValidityKeyMax, 1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 2u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
                              dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
                                    (ValidityKey)2, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                              dummyPayload( 2 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
                                    (ValidityKey)2, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
                                    (ValidityKey)4, obj->until() );
    }
    {
      IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                       ValidityKeyMax, 2 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 2u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
                              dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
                                    (ValidityKey)2, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                              dummyPayload( 2 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
                                    (ValidityKey)2, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
                                    (ValidityKey)4, obj->until() );
    }
  }
  /// Tests storing unordered, non-overlapping SV MC IOVS (all closed).
  /// See https://savannah.cern.ch/task/?func=detailitem&item_id=3138:
  /// tests that the functionality of use case #2 is provided
  /// (back-insertion is allowed for bulk inserting
  /// at most one IOV per channel - in multi channel mode:
  /// it is also allowed for inserting several IOVs per channel,
  /// as long as there is only IOV per channel in the channels
  /// where one IOV is back-inserted).
  void test_storeObject_SV_unordered_MC_bulk_closed_oneperchannel_2()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->setupStorageBuffer();
    folder->storeObject( 2, 4, dummyPayload( 2 ), 1 );
    folder->storeObject( 2, 4, dummyPayload( 2 ), 2 );
    folder->flushStorageBuffer();
    folder->storeObject( 0, 2, dummyPayload( 1 ), 1 );
    folder->storeObject( 4, 6, dummyPayload( 3 ), 2 );
    folder->storeObject( 6, 8, dummyPayload( 4 ), 2 );
    folder->flushStorageBuffer(); // Bulk-back-insert three IOVs
    {
      IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                       ValidityKeyMax, 1 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 2u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
                              dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
                                    (ValidityKey)2, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                              dummyPayload( 2 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
                                    (ValidityKey)2, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
                                    (ValidityKey)4, obj->until() );
    }
    {
      IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                       ValidityKeyMax, 2 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 3u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                              dummyPayload( 2 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
                                    (ValidityKey)2, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
                                    (ValidityKey)4, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 3 payload",
                              dummyPayload( 3 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 since",
                                    (ValidityKey)4, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 until",
                                    (ValidityKey)6, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 4 payload",
                              dummyPayload( 4 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 4 since",
                                    (ValidityKey)6, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 4 until",
                                    (ValidityKey)8, obj->until() );
    }
  }
  /// Tests storing unordered, non-overlapping SV IOVS (all closed).
  /// See https://savannah.cern.ch/task/?func=detailitem&item_id=3138:
  /// tests that the functionality of use case #1 is NOT YET provided
  /// (back-insertion is not yet allowed for bulk inserting
  /// more than one IOV per channel - in single or multi channel mode,
  /// even if only one IOV is back-inserted and the others are not).
  void test_storeObject_SV_unordered_bulk_closed_oneback()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->storeObject( 2, 4, dummyPayload( 2 ), 0 );
    folder->setupStorageBuffer();
    folder->storeObject( 0, 2, dummyPayload( 1 ), 0 );
    folder->storeObject( 4, 6, dummyPayload( 3 ), 0 );
    try
    {
      folder->flushStorageBuffer();
    }
    catch ( std::exception& e )
    {
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "6 until",
          std::string( "Back-insertion not possible "
                       "due to multiple objects in channel" ),
          std::string( e.what() ) );
    }
    IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                     ValidityKeyMax, 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 1u,
                                  (unsigned int)objs->size() );
    IObjectPtr obj = getNext(objs);
    CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                            dummyPayload( 2 ) == obj->payload() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
                                  (ValidityKey)2, obj->since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
                                  (ValidityKey)4, obj->until() );
    /*
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 3u,
      (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
      dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
      (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
      (ValidityKey)2, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
      dummyPayload( 2 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
      (ValidityKey)2, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
      (ValidityKey)4, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 3 payload",
      dummyPayload( 3 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 since",
      (ValidityKey)4, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 until",
      (ValidityKey)6, obj->until() );
    *///
  }

  /// Tests storeObject with overlapping intervals
  /// bug #9212 reported 2005-06-24 by Federico
  void test_storeObject_SV_overlap_bulk1()
  {
    try
    {
      IFolderPtr folder = s_db->getFolder( "/fSV" );
      folder->setupStorageBuffer();
      folder->storeObject( 300, 400, dummyPayload( 1 ), 0 );
      folder->storeObject( 200, 400, dummyPayload( 1 ), 0 );
      folder->flushStorageBuffer();
      CPPUNIT_FAIL( "400 until exception expected" );
    }
    catch ( std::exception& e )
    {
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "400 until",
          std::string( "Overlapping intervals "
                       "not allowed in SINGLE_VERSION mode" ),
          std::string( e.what() ) );
    }
  }

  void test_storeObject_SV_overlap_bulk2()
  {
    try
    {
      IFolderPtr folder = s_db->getFolder( "/fSV" );
      folder->setupStorageBuffer();
      folder->storeObject( 300, 350, dummyPayload( 1 ), 0 );
      folder->storeObject( 200, 400, dummyPayload( 1 ), 0 );
      folder->flushStorageBuffer();
      CPPUNIT_FAIL( "non-equal until exception expected" );
    }
    catch ( std::exception& e )
    {
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "non-equal until",
          std::string( "Overlapping intervals not allowed in SINGLE_VERSION mode" ),
          std::string( e.what() ) );
    }
  }

  void test_storeObject_SV_overlap_bulk3()
  {
    try
    {
      IFolderPtr folder = s_db->getFolder( "/fSV" );
      folder->setupStorageBuffer();
      folder->storeObject( 300, ValidityKeyMax, dummyPayload( 1 ), 0 );
      folder->storeObject( 200, ValidityKeyMax, dummyPayload( 1 ), 0 );
      folder->flushStorageBuffer();
      CPPUNIT_FAIL( "ValidityKeyMax until exception expected" );
    }
    catch ( std::exception& e )
    {
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "ValidityKeyMax until",
          std::string( "Overlapping intervals not allowed in SINGLE_VERSION mode" ),
          std::string( e.what() ) );
    }
  }

  /// Tests storeObject with overlapping intervals
  /// bug #9212 reported 2005-06-24 by Federico
  void test_storeObject_SV_overlap1()
  {
    try
    {
      IFolderPtr folder = s_db->getFolder( "/fSV" );
      folder->storeObject( 300, 400, dummyPayload( 1 ), 0 );
      folder->storeObject( 200, 400, dummyPayload( 1 ), 0 );
      CPPUNIT_FAIL( "400 until exception expected" );
    }
    catch ( std::exception& e )
    {
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "400 until",
          std::string( "Back-insertion collision: overlapping intervals "
                       "not allowed in SINGLE_VERSION mode" ),
          std::string( e.what() ) );
    }
  }

  void test_storeObject_SV_overlap2()
  {
    try
    {
      IFolderPtr folder = s_db->getFolder( "/fSV" );
      folder->storeObject( 300, 350, dummyPayload( 1 ), 0 );
      folder->storeObject( 200, 400, dummyPayload( 1 ), 0 );
      CPPUNIT_FAIL( "non-equal until exception expected" );
    }
    catch ( std::exception& e )
    {
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "non-equal until",
          std::string( "Back-insertion collision: overlapping intervals "
                       "not allowed in SINGLE_VERSION mode" ),
          std::string( e.what() ) );
    }
  }

  void test_storeObject_SV_overlap3()
  {
    try
    {
      IFolderPtr folder = s_db->getFolder( "/fSV" );
      folder->storeObject( 300, ValidityKeyMax, dummyPayload( 1 ), 0 );
      folder->storeObject( 200, ValidityKeyMax, dummyPayload( 1 ), 0 );
      CPPUNIT_FAIL( "ValidityKeyMax until exception expected" );
    }
    catch ( std::exception& e )
    {
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "ValidityKeyMax until",
          std::string( "Back-insertion collision: overlapping intervals "
                       "not allowed in SINGLE_VERSION mode" ),
          std::string( e.what() ) );
    }
  }

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  /// Tests updating the folder description
  void test_setDescription()
  {
    //ScopedRecreateFolders theCleaner( this ); // not needed
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    std::string desc = folder->description();
    {
      folder->setDescription( "new description" );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "internal desc update",
                                    std::string( "new description" ),
                                    folder->description() );
    }
    {
      folder = s_db->getFolder( "/fSV" );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "db desc update",
                                    std::string( "new description" ),
                                    folder->description() );
    }
    folder->setDescription( desc );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "desc cleanup",
                                  desc,
                                  folder->description() );
  }

  /// Tests bulk insertion into multiple channels (SV mode)
  void test_storeObjects_bulk_multichannel()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->setupStorageBuffer();
    ChannelId nChannels = 10;
    {
      for ( ChannelId ch = 0; ch < nChannels; ++ch ) {
        folder->storeObject( (ValidityKey)0, ValidityKeyMax,
                             dummyPayload( (int)ch ), ch );
      }
      for ( ChannelId ch = 0; ch < nChannels; ++ch ) {
        folder->storeObject( (ValidityKey)5, ValidityKeyMax,
                             dummyPayload( (int)ch ), ch );
      }
    }
    folder->flushStorageBuffer();
    unsigned int nObjsPerChannel = 2;
    IObjectPtr obj;
    for ( ChannelId ch = 0; ch < nChannels; ++ch ) {
      for ( unsigned int i = 0; i < nObjsPerChannel; ++i ) {
        std::stringstream s;
        s << "object " << i << ", channel " << ch << " ";
        ValidityKey pointInTime = 5 * i; // 0, 5
        obj = folder->findObject( pointInTime, ch );
        CPPUNIT_ASSERT_MESSAGE( ( s.str() + "payload" ).c_str(),
                                dummyPayload( (int)ch ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "since" ).c_str(),
                                      pointInTime, obj->since() );
        // until of last extends to ValidityKeyMax
        if ( i < nObjsPerChannel-1 ) {
          CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "until" ).c_str(),
                                        pointInTime +5, obj->until() );
        } else {
          CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "until" ).c_str(),
                                        ValidityKeyMax, obj->until() );
        }
      }
    }
  }

  /// Tests tagDescription (MultiVersion only, SingleVersion does not have
  /// tags and throws a RelationalException)
  void test_tagDescription()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    try
    {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), 0 );
      folder->tagCurrentHead( "A", "desc A" );
      std::string desc = folder->tagDescription( "A" );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "tag desc", std::string("desc A"), desc );
      try {
        folder->tagDescription( "nonexisting tag" );
        CPPUNIT_FAIL( "exception not thrown for nonexisting tag" );
      } catch ( TagNotFound& /* ignored */ ) { }
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests tagInsertionTime (MultiVersion only, SingleVersion does not have
  /// tags and throws a RelationalException)
  void test_tagInsertionTime()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    try
    {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), 0 );
      folder->tagCurrentHead( "A" );
      Time tagTime = folder->tagInsertionTime( "A" );
      // the real time functionality test
      // is implemented in test_RalDatabase.cpp
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "tagTime size",
          std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
          timeToString(tagTime).size() );
      try {
        folder->tagInsertionTime( "nonexisting tag" );
        CPPUNIT_FAIL( "exception not thrown for nonexisting tag" );
      } catch ( TagNotFound& /* ignored */ ) { }
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests listTags for MV folders
  void test_listTags_MV()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    try
    {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), 0 );
      folder->tagCurrentHead( "A" );
      folder->tagCurrentHead( "B" );
      std::vector<std::string> tags = folder->listTags();
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "tag count", 2u, (unsigned int)tags.size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "tag 1", std::string("A"), tags[0] );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "tag 2", std::string("B"), tags[1] );
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests listTags for SV folders: there are no tags
  void test_listTags_SV()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    try
    {
      std::vector<std::string> tags = folder->listTags();
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "tag count", 0u, (unsigned int)tags.size() );
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  void test_browseObjects_MV_tag()
  {
    test_browseObjects_MV_tag( cool_PayloadMode_Mode::INLINEPAYLOAD );
  };

  void test_browseObjects_MV_tag_sepPayload()
  {
    test_browseObjects_MV_tag( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  };

  void test_browseObjects_MV_tag_vector()
  {
    test_browseObjects_MV_tag( cool_PayloadMode_Mode::VECTORPAYLOAD );
  };

  /// Tests object browsing in tags (MV folders)
  void test_browseObjects_MV_tag( PayloadMode::Mode pMode )
  {
    IFolderPtr folder = s_db->getFolder( payloadMode2Folder( pMode ) );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 0 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 0 );
    folder->tagCurrentHead( "mytag" );
    {
      IObjectIteratorPtr objs = folder->browseObjects( 5, 15, 0, "mytag" );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 2u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 1.1 payload",
                              dummyPayload( 0 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.1 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.1 until",
                                    (ValidityKey)10, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 1.2 payload",
                              dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.2 since",
                                    (ValidityKey)10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.2 until",
                                    (ValidityKey)20, obj->until() );
    }
    {
      IObjectIteratorPtr objs = folder->browseObjects( 10, 20, 0, "mytag" );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 2u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2.1 payload",
                              dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2.1 since",
                                    (ValidityKey)10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2.1 until",
                                    (ValidityKey)20, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2.2 payload",
                              dummyPayload( 2 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2.1 since",
                                    (ValidityKey)20, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2.1 until",
                                    ValidityKeyMax, obj->until() );
    }
    {
      IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                       ValidityKeyMax,
                                                       0, "mytag" );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 3u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 3.1 payload",
                              dummyPayload( 0 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.1 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.1 until",
                                    (ValidityKey)10, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 3.2 payload",
                              dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.2 since",
                                    (ValidityKey)10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.2 until",
                                    (ValidityKey)20, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 3.3 payload",
                              dummyPayload( 2 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.3 since",
                                    (ValidityKey)20, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.3 until",
                                    ValidityKeyMax, obj->until() );
    }
  }

  void test_browseObjects_MV()
  {
    test_browseObjects_MV( cool_PayloadMode_Mode::INLINEPAYLOAD );
  };

  void test_browseObjects_MV_sepPayload()
  {
    test_browseObjects_MV( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  };

  void test_browseObjects_MV_vector()
  {
    test_browseObjects_MV( cool_PayloadMode_Mode::VECTORPAYLOAD );
  };

  /// Tests object browsing (MV folders)
  void test_browseObjects_MV( PayloadMode::Mode pMode )
  {
    IFolderPtr folder = s_db->getFolder( payloadMode2Folder( pMode ) );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 0 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 0 );
    {
      IObjectIteratorPtr objs = folder->browseObjects( 5, 15, 0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 2u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 1.1 payload",
                              dummyPayload( 0 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.1 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.1 until",
                                    (ValidityKey)10, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 1.2 payload",
                              dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.2 since",
                                    (ValidityKey)10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.2 until",
                                    (ValidityKey)20, obj->until() );
    }
    {
      IObjectIteratorPtr objs = folder->browseObjects( 10, 20, 0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 2u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2.1 payload",
                              dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2.1 since",
                                    (ValidityKey)10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2.1 until",
                                    (ValidityKey)20, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2.2 payload",
                              dummyPayload( 2 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2.1 since",
                                    (ValidityKey)20, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2.1 until",
                                    ValidityKeyMax, obj->until() );
    }
    {
      IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                       ValidityKeyMax, 0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 3u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 3.1 payload",
                              dummyPayload( 0 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.1 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.1 until",
                                    (ValidityKey)10, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 3.2 payload",
                              dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.2 since",
                                    (ValidityKey)10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.2 until",
                                    (ValidityKey)20, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 3.3 payload",
                              dummyPayload( 2 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.3 since",
                                    (ValidityKey)20, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.3 until",
                                    ValidityKeyMax, obj->until() );
    }
  }

  void test_browseObjects_all_channels_MV()
  {
    test_browseObjects_all_channels_MV( cool_PayloadMode_Mode::INLINEPAYLOAD );
  };

  void test_browseObjects_all_channels_MV_sepPayload()
  {
    test_browseObjects_all_channels_MV( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  };

  void test_browseObjects_all_channels_MV_vector()
  {
    test_browseObjects_all_channels_MV( cool_PayloadMode_Mode::VECTORPAYLOAD );
  };

  /// Tests object browsing all channels (MV folders)
  void test_browseObjects_all_channels_MV( PayloadMode::Mode pMode )
  {
    IFolderPtr folder = s_db->getFolder( payloadMode2Folder( pMode ) );
    int index = 0;
    for ( int i = 0; i < 3; ++i ) {
      folder->storeObject(  0, 10, dummyPayload( index++ ), (ChannelId)i );
      folder->storeObject( 10, 20, dummyPayload( index++ ), (ChannelId)i );
      folder->storeObject( 20, ValidityKeyMax,
                           dummyPayload( index++ ), (ChannelId)i );
    }
    {
      ValidityKey since = 5;
      ValidityKey until = 15;
      IObjectIteratorPtr
        objs = folder->browseObjects( since, until,
                                      ChannelSelection::all() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 6u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
                              dummyPayload( 0 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
                                    (ValidityKey)10, obj->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 channel",
                                    (ChannelId)0, obj->channelId() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                              dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
                                    (ValidityKey)10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
                                    (ValidityKey)20, obj->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 channel",
                                    (ChannelId)0, obj->channelId() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 3 payload",
                              dummyPayload( 3 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 until",
                                    (ValidityKey)10, obj->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 channel",
                                    (ChannelId)1, obj->channelId() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 4 payload",
                              dummyPayload( 4 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 4 since",
                                    (ValidityKey)10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 4 until",
                                    (ValidityKey)20, obj->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 4 channel",
                                    (ChannelId)1, obj->channelId() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 5 payload",
                              dummyPayload( 6 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 5 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 5 until",
                                    (ValidityKey)10, obj->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 5 channel",
                                    (ChannelId)2, obj->channelId() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 6 payload",
                              dummyPayload( 7 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 6 since",
                                    (ValidityKey)10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 6 until",
                                    (ValidityKey)20, obj->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 4 channel",
                                    (ChannelId)2, obj->channelId() );
    }
  }

  void test_browseObjects_channel_range_MV()
  {
    test_browseObjects_channel_range_MV( cool_PayloadMode_Mode::INLINEPAYLOAD );
  };

  void test_browseObjects_channel_range_MV_sepPayload()
  {
    test_browseObjects_channel_range_MV( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  };

  void test_browseObjects_channel_range_MV_vector()
  {
    test_browseObjects_channel_range_MV( cool_PayloadMode_Mode::VECTORPAYLOAD );
  };

  /// Tests object browsing a channel range (MV folders)
  void test_browseObjects_channel_range_MV( PayloadMode::Mode pMode )
  {
    IFolderPtr folder = s_db->getFolder( payloadMode2Folder( pMode ) );
    int index = 0;
    for ( int i = 0; i < 5; ++i ) {
      folder->storeObject(  0, 10, dummyPayload( index++ ), (ChannelId)i );
      folder->storeObject( 10, 20, dummyPayload( index++ ), (ChannelId)i );
      folder->storeObject( 20, ValidityKeyMax,
                           dummyPayload( index++ ), (ChannelId)i );
    }
    {
      ValidityKey since = 5;
      ValidityKey until = 15;
      ChannelSelection channels( 2, 3 );
      IObjectIteratorPtr objs = folder->browseObjects( since,
                                                       until,
                                                       channels );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 4u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
                              dummyPayload( 6 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
                                    (ValidityKey)10, obj->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 channel",
                                    (ChannelId)2, obj->channelId() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                              dummyPayload( 7 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
                                    (ValidityKey)10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
                                    (ValidityKey)20, obj->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 channel",
                                    (ChannelId)2, obj->channelId() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 3 payload",
                              dummyPayload( 9 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 until",
                                    (ValidityKey)10, obj->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 channel",
                                    (ChannelId)3, obj->channelId() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 4 payload",
                              dummyPayload( 10 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 4 since",
                                    (ValidityKey)10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 4 until",
                                    (ValidityKey)20, obj->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 4 channel",
                                    (ChannelId)3, obj->channelId() );
    }
  }

  /// Tests object browsing all channels (SV folders)
  void test_browseObjects_all_channels_SV()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    int index = 0;
    for ( int i = 0; i < 3; ++i ) {
      folder->storeObject(  0, 10, dummyPayload( index++ ), (ChannelId)i );
      folder->storeObject( 10, 20, dummyPayload( index++ ), (ChannelId)i );
      folder->storeObject( 20, ValidityKeyMax,
                           dummyPayload( index++ ), (ChannelId)i );
    }
    {
      ValidityKey since = 5;
      ValidityKey until = 15;
      IObjectIteratorPtr
        objs = folder->browseObjects( since, until,
                                      ChannelSelection::all() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 6u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
                              dummyPayload( 0 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
                                    (ValidityKey)10, obj->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 channel",
                                    (ChannelId)0, obj->channelId() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                              dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
                                    (ValidityKey)10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
                                    (ValidityKey)20, obj->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 channel",
                                    (ChannelId)0, obj->channelId() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 3 payload",
                              dummyPayload( 3 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 until",
                                    (ValidityKey)10, obj->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 channel",
                                    (ChannelId)1, obj->channelId() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 4 payload",
                              dummyPayload( 4 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 4 since",
                                    (ValidityKey)10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 4 until",
                                    (ValidityKey)20, obj->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 4 channel",
                                    (ChannelId)1, obj->channelId() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 5 payload",
                              dummyPayload( 6 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 5 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 5 until",
                                    (ValidityKey)10, obj->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 5 channel",
                                    (ChannelId)2, obj->channelId() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 6 payload",
                              dummyPayload( 7 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 6 since",
                                    (ValidityKey)10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 6 until",
                                    (ValidityKey)20, obj->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 4 channel",
                                    (ChannelId)2, obj->channelId() );
    }
  }

  /// Tests object browsing a channel range (SV folders)
  void test_browseObjects_channel_range_SV()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    int index = 0;
    for ( int i = 0; i < 5; ++i ) {
      folder->storeObject(  0, 10, dummyPayload( index++ ), (ChannelId)i );
      folder->storeObject( 10, 20, dummyPayload( index++ ), (ChannelId)i );
      folder->storeObject( 20, ValidityKeyMax,
                           dummyPayload( index++ ), (ChannelId)i );
    }
    {
      ValidityKey since = 5;
      ValidityKey until = 15;
      ChannelSelection channels( 2, 3 );
      IObjectIteratorPtr objs = folder->browseObjects( since,
                                                       until,
                                                       channels );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 4u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 1 payload",
                              dummyPayload( 6 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 until",
                                    (ValidityKey)10, obj->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1 channel",
                                    (ChannelId)2, obj->channelId() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2 payload",
                              dummyPayload( 7 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 since",
                                    (ValidityKey)10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 until",
                                    (ValidityKey)20, obj->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2 channel",
                                    (ChannelId)2, obj->channelId() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 3 payload",
                              dummyPayload( 9 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 until",
                                    (ValidityKey)10, obj->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3 channel",
                                    (ChannelId)3, obj->channelId() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 4 payload",
                              dummyPayload( 10 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 4 since",
                                    (ValidityKey)10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 4 until",
                                    (ValidityKey)20, obj->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 4 channel",
                                    (ChannelId)3, obj->channelId() );
    }
  }

  /// Tests object browsing (SV folders)
  void test_browseObjects_SV()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 0 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 0 );
    {
      IObjectIteratorPtr objs = folder->browseObjects( 5, 15, 0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 2u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 1.1 payload",
                              dummyPayload( 0 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.1 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.1 until",
                                    (ValidityKey)10, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 1.2 payload",
                              dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.2 since",
                                    (ValidityKey)10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 1.2 until",
                                    (ValidityKey)20, obj->until() );
    }
    {
      IObjectIteratorPtr objs = folder->browseObjects( 10, 20, 0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 2u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2.1 payload",
                              dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2.1 since",
                                    (ValidityKey)10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2.1 until",
                                    (ValidityKey)20, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 2.2 payload",
                              dummyPayload( 2 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2.1 since",
                                    (ValidityKey)20, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 2.1 until",
                                    ValidityKeyMax, obj->until() );
    }
    {
      IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                       ValidityKeyMax, 0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 3u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 3.1 payload",
                              dummyPayload( 0 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.1 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.1 until",
                                    (ValidityKey)10, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 3.2 payload",
                              dummyPayload( 1 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.2 since",
                                    (ValidityKey)10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.2 until",
                                    (ValidityKey)20, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_MESSAGE( "obj 3.3 payload",
                              dummyPayload( 2 ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.3 since",
                                    (ValidityKey)20, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.3 until",
                                    ValidityKeyMax, obj->until() );
    }
  }

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  /// Tests browsing a SV selection with lowercase payload
  /// Test for Richard's ORA-00904 bug report
  void test_browseObjects_SV_lowercasePayload()
  {
    ScopedRecreateFolders theCleaner( this );
    RecordSpecification payloadSpecNew( payloadSpec );
    payloadSpecNew.extend( "float2", cool_StorageType_TypeId::Float);
    Record payload( payloadSpecNew );
    payload["I"].setValue<Int32>( 123 );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpecNew );
    IFolderPtr folder = s_db->createFolder( "/myfolder", fSpec, "my description" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 0 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 0 );
    {
      IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                       ValidityKeyMax, 0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object count", 3u,
                                    (unsigned int)objs->size() );
      IObjectPtr obj = getNext(objs);
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.1 since",
                                    (ValidityKey)0, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.1 until",
                                    (ValidityKey)10, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.2 since",
                                    (ValidityKey)10, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.2 until",
                                    (ValidityKey)20, obj->until() );
      obj = getNext(objs);
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.3 since",
                                    (ValidityKey)20, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "obj 3.3 until",
                                    ValidityKeyMax, obj->until() );
    }
  }

  /// Tests object browsing (SV folders)
  void test_browseObjects_SV_bug42101()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->storeObject(  0, 10, dummyPayload( 0 ), 0 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 0 );
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 0 );
    IObjectIteratorPtr objs = folder->browseObjects( 5, 15, 0, "HEAD" );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "object count", 2u, (unsigned int)objs->size() );
  }

  /// Tests that the storage buffer is cleared and none of the objects
  /// is stored if an exception is thrown during the bulk operation
  /// 'flushStorageBuffer' (for instance, because one IOV has until<since)
  void test_flushStorageBuffer_exception()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->setupStorageBuffer();
    folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), 0 );
    folder->storeObject( 10, 20, dummyPayload( 1 ), 0 );
    folder->flushStorageBuffer();
    folder->setupStorageBuffer();
    folder->storeObject( 20, ValidityKeyMax, dummyPayload( 2 ), 0 );
    folder->storeObject( 30, 20, dummyPayload( 3 ), 0 ); // INVALID!
    folder->storeObject( 40, 50, dummyPayload( 4 ), 0 );
    bool flushFailed = false;
    try {
      folder->flushStorageBuffer();
    } catch ( ValidityKeyException& /* dummy */ ) {
      flushFailed = true;
    }
    CPPUNIT_ASSERT_MESSAGE( "second insertion not OK", flushFailed );
    folder->setupStorageBuffer();
    folder->storeObject( 50, ValidityKeyMax, dummyPayload( 5 ), 0 );
    folder->storeObject( 60, 70, dummyPayload( 6 ), 0 );
    folder->flushStorageBuffer();
    IObjectPtr obj0 = folder->findObject( 0, 0 );
    CPPUNIT_ASSERT_MESSAGE( "object 0 found",
                            dummyPayload(0) == obj0->payload() );
    IObjectPtr obj1 = folder->findObject( 10, 0 );
    CPPUNIT_ASSERT_MESSAGE( "object 1 found",
                            dummyPayload(1) == obj1->payload() );
    bool objectNotFound = false;
    try {
      IObjectPtr obj2 = folder->findObject( 20, 0 );
      std::cout << "ERROR! Found object2: " << obj2 << std::endl;
    } catch( ObjectNotFound& /* dummy */ ) {
      objectNotFound = true;
    }
    CPPUNIT_ASSERT_MESSAGE( "object 2 not found", objectNotFound );
    objectNotFound = false;
    try {
      folder->findObject( 30, 0 );
    } catch( ObjectNotFound& /* dummy */ ) {
      objectNotFound = true;
    }
    CPPUNIT_ASSERT_MESSAGE( "object 3 not found", objectNotFound );
    objectNotFound = false;
    try {
      folder->findObject( 40, 0 );
    } catch( ObjectNotFound& /* dummy */ ) {
      objectNotFound = true;
    }
    CPPUNIT_ASSERT_MESSAGE( "object 4 not found", objectNotFound );
    IObjectPtr obj5 = folder->findObject( 50, 0 );
    CPPUNIT_ASSERT_MESSAGE( "object 5 found",
                            dummyPayload(5) == obj5->payload() );
    IObjectPtr obj6 = folder->findObject( 60, 0 );
    CPPUNIT_ASSERT_MESSAGE( "object 6 found",
                            dummyPayload(6) == obj6->payload() );
  }

  /// Tests that the storage buffer is cleared and none of the objects
  /// is stored if an exception is thrown during the bulk operation
  /// 'flushStorageBuffer' (for instance, because one IOV has until<since),
  /// even if more than maxBufferSize objects are stored (bug #22474)
  void test_flushStorageBuffer_exception_bug22474()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    unsigned maxBufferSize = relfolder->bulkOpRowCacheSize();
    folder->setupStorageBuffer();
    for ( unsigned key = 0; key < maxBufferSize; key++ )
    {
      folder->storeObject( key*10, (key+1)*10, dummyPayload( key ), 0 );
    }
    folder->storeObject( 1, 0, dummyPayload( 0 ), 0 ); // INVALID!
    bool flushFailed = false;
    try {
      folder->flushStorageBuffer();
    } catch ( ValidityKeyException& /* dummy */ ) {
      flushFailed = true;
    }
    CPPUNIT_ASSERT_MESSAGE( "Flush should have failed", flushFailed );
    bool objectNotFound = false;
    try {
      IObjectPtr obj = folder->findObject( 0, 0 );
      std::cout << "ERROR! Found object at 0: " << obj << std::endl;
    } catch( ObjectNotFound& /* dummy */ ) {
      objectNotFound = true;
    }
    CPPUNIT_ASSERT_MESSAGE( "Object at 0 should not exist", objectNotFound );
  }

  /// Tests that a ValidityKeyException is thrown when since>until
  /// and when since or until are out of boundaries
  void test_ValidityKeyException()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    bool storeFailed = false;
    try {
      folder->storeObject( 100, 0, dummyPayload( 0 ), 0 );
    } catch ( ValidityKeyException& /* dummy */ ) {
      storeFailed = true;
    }
    CPPUNIT_ASSERT_MESSAGE( "exception for [100,0]", storeFailed );
    storeFailed = false;
    try {
      folder->storeObject( 100, 100, dummyPayload( 0 ), 0 );
    } catch ( ValidityKeyException& /* dummy */ ) {
      storeFailed = true;
    }
    CPPUNIT_ASSERT_MESSAGE( "exception for [100,100]", storeFailed );
    storeFailed = false;
    try {
      // Split the following line on two lines (Windows compiler warning)
      //ValidityKey since = ValidityKeyMin-1;
      ValidityKey since = ValidityKeyMin;
      since = since-1;
      ValidityKey until = ValidityKeyMin;
      // NB: Now (ValidityKey=long_long, ValidityKeyMin=LONG_LONG_MIN)
      //     ==> LONG_LONG_MIN-1 is an invalid int64 LONG_LONG_MAX > since
      // NB: Previously (ValidityKey=long_long, ValidityKeyMin=LONG_MIN)
      //     ==> LONG_MIN-1 is an invalid int64 > LONG_MIN=ValidityKeyMin
      folder->storeObject( since, until, dummyPayload( 0 ), 0 );
    } catch ( ValidityKeyException& /* dummy */ ) {
      storeFailed = true;
    }
    CPPUNIT_ASSERT_MESSAGE( "exception for [min-1,min]", storeFailed );
    storeFailed = false;
    try {
      ValidityKey since = ValidityKeyMax;
      // Split the following line on two lines (Windows compiler warning)
      //ValidityKey until = ValidityKeyMax+1;
      ValidityKey until = ValidityKeyMax;
      until = until+1;
      // NB: Now (ValidityKey=long_long, ValidityKeyMin=LONG_LONG_MIN)
      //     ==> LONG_LONG_MIN-1 is an invalid int64 LONG_LONG_MAX > since
      // NB: Previously (ValidityKey=long_long, ValidityKeyMin=LONG_MIN)
      //     ==> LONG_MIN-1 is an invalid int64 > LONG_MIN=ValidityKeyMin
      folder->storeObject( since, until, dummyPayload( 0 ), 0 );
    } catch ( ValidityKeyException& /* dummy */ ) {
      storeFailed = true;
    }
    CPPUNIT_ASSERT_MESSAGE( "exception for [max,max+1]", storeFailed );
  }

  /// Tests that the ValidityKey boundaries are those we expect
  /// (use hardcoded numerical values)
  void test_ValidityKey_boundaries()
  {
    //CPPUNIT_ASSERT_EQUAL_MESSAGE
    //  ( "ValidityKeyMin hardcoded",
    //    (ValidityKey)0, ValidityKeyMin + 9223372036854775808ULL );
    //CPPUNIT_ASSERT_EQUAL_MESSAGE
    //  ( "ValidityKeyMax hardcoded",
    //    (ValidityKey)0, ValidityKeyMax - 18446744073709551615ULL );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "ValidityKeyMin hardcoded",
        (ValidityKey)0, ValidityKeyMin );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "ValidityKeyMax hardcoded",
        (ValidityKey)0,
        (ValidityKey)(ValidityKeyMax - 9223372036854775807LL) );
    //CPPUNIT_ASSERT_EQUAL_MESSAGE
    //  ( "ValidityKeyMin Int64Min",
    //    (ValidityKey)Int64Min, ValidityKeyMin );
    //CPPUNIT_ASSERT_EQUAL_MESSAGE
    //  ( "ValidityKeyMin UInt64Max",
    //    (ValidityKey)UInt64Max, ValidityKeyMax );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "ValidityKeyMin UInt64Min",
        (ValidityKey)UInt64Min, ValidityKeyMin );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "ValidityKeyMin Int64Max",
        (ValidityKey)Int64Max, ValidityKeyMax );
  }

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  /// Stores objects to multiple folders and retrieves them in a loop
  /// Tests against a problem first reported by Marco Clemencic on
  /// 2005-01-27 -- cannot reproduce at the moment
  void test_multiple_folders()
  {
    ScopedRecreateFolders theCleaner( this );
    bool showPrintout = false;
    int nFolders = 5;
    std::vector<std::string> foldernames;
    for ( int i = 0; i < nFolders; ++i ) {
      std::stringstream s;
      s << "/f_" << i;
      foldernames.push_back( s.str() );
    }
    long nObjs = 100;
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    for ( std::vector<std::string>::const_iterator fname = foldernames.begin();
          fname != foldernames.end(); ++fname )
    {
      s_db->createFolder( *fname, fSpec );
    }
    for ( std::vector<std::string>::const_iterator fname = foldernames.begin();
          fname != foldernames.end(); ++fname ) {
      IFolderPtr folder = s_db->getFolder( *fname );
      folder->setupStorageBuffer();
      for ( long i = 0; i < nObjs; ++i ) {
        folder->storeObject( i, ValidityKeyMax, dummyPayload( i ), 0 );
      }
      folder->flushStorageBuffer();
      if ( showPrintout )
        std::cout << "wrote " << nObjs
                  << " objects in folder '" << *fname << std::endl;
    }
    for ( std::vector<std::string>::const_iterator fname = foldernames.begin();
          fname != foldernames.end(); ++fname ) {
      IFolderPtr folder = s_db->getFolder( *fname );
      IObjectIteratorPtr objs
        = folder->browseObjects( ValidityKeyMin, ValidityKeyMax, 0, "" );
      CPPUNIT_ASSERT_MESSAGE( "not empty", objs->size() > 0 );
      long objIndex = 0;
      //for ( IObjectIterator::const_iterator
      //      i = objs->begin(); i != objs->end(); ++i ) {
      //  const IObjectPtr& obj = *i;
      while ( objs->goToNext() ) {
        IObjectPtr obj( objs->currentRef().clone() );
        std::stringstream s;
        s << "folder " << *fname << ": object " << objIndex << " ";
        CPPUNIT_ASSERT_MESSAGE( ( s.str() + "payload" ).c_str(),
                                dummyPayload( objIndex )
                                == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "since" ).c_str(),
                                      objIndex, (long)obj->since() );
        // last object's until extends to ValidityKeyMax
        if ( objIndex < nObjs-1 ) {
          CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "until" ).c_str(),
                                        objIndex+1, (long)obj->until() );
        } else {
          CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "until" ).c_str(),
                                        ValidityKeyMax, obj->until() );
        }
        ++objIndex;
      }
      if ( showPrintout )
        std::cout << "checked " << objIndex
                  << " objects in folder " << *fname << std::endl;
    }
  }

  /// Tests tagging and retagging when a tag exists in another folder
  void test_tagExistsElsewhere()
  {
    IFolderPtr folder1 = s_db->getFolder( "/fMV" );
    IFolderPtr folder2 = s_db->getFolder( "/fMVp" );
    folder1->storeObject( 0, 10, dummyPayload( 0 ), 0 );
    folder2->storeObject( 10, 20, dummyPayload( 1 ), 0 );
    folder2->storeObject( 20, 30, dummyPayload( 2 ), 0 );
    std::string tagA = "tagA";
    std::string descA = "tagA description";
    std::string tagB = "tagB";
    std::string descB = "tagB description";
    // TagA cannot be created in folder2 if it exists in folder1 already
    folder1->tagCurrentHead( tagA, descA );
    try {
      folder2->tagCurrentHead( tagA, descA );
      CPPUNIT_FAIL( "exception expected" );
    }
    catch ( cool::TagExists& /*dummy*/) {
      try {
        folder2->deleteTag( tagA );
        folder2->tagCurrentHead( tagA, descA );
      }
      catch ( cool::TagNotFound& /*e*/ ) {
        //std::cout << "Caught as expected: " << e.what() << std::endl;
      }
      catch ( std::exception& e ) {
        std::cout << "Exception caught: " << e.what() << std::endl;
        throw;
      }
    }
    // Create tagB in folder2: this has the same tagId=1 as tagA in folder1
    // BUG in COOL_1_2_2: folder1->delete(tagA) also deletes tagB and fails
    folder2->tagCurrentHead( tagB, descB );
    try {
      folder1->deleteTag( tagA );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests IDatabase::tagNameScope
  void test_tagNameScope()
  {
    IFolderPtr folder1 = s_db->getFolder( "/fMV" );
    IFolderPtr folder2 = s_db->getFolder( "/fMVp" );
    folder1->storeObject( 0, 10, dummyPayload( 0 ), 0 );
    folder2->storeObject( 10, 20, dummyPayload( 1 ), 0 );
    folder2->storeObject( 20, 30, dummyPayload( 2 ), 0 );
    std::string tag1A = "tag1A";
    std::string tag1B = "tag1B";
    std::string tag1C = "tag1C";
    std::string tag2A = "tag2A";
    std::string tag2B = "tag2B";
    std::string tag2C = "tag2C";
    folder1->tagCurrentHead( tag1A, "tag description" );
    folder1->tagCurrentHead( tag1B, "tag description" );
    folder1->tagCurrentHead( tag1C, "tag description" );
    folder2->tagCurrentHead( tag2A, "tag description" );
    folder2->tagCurrentHead( tag2B, "tag description" );
    folder2->tagCurrentHead( tag2C, "tag description" );
    try {
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "tag1A scope", cool_IHvsNode_Type::LEAF_NODE, s_db->tagNameScope( tag1A ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "tag1B scope", cool_IHvsNode_Type::LEAF_NODE, s_db->tagNameScope( tag1B ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "tag1C scope", cool_IHvsNode_Type::LEAF_NODE, s_db->tagNameScope( tag1C ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "tag2A scope", cool_IHvsNode_Type::LEAF_NODE, s_db->tagNameScope( tag2A ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "tag2B scope", cool_IHvsNode_Type::LEAF_NODE, s_db->tagNameScope( tag2B ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "tag2C scope", cool_IHvsNode_Type::LEAF_NODE, s_db->tagNameScope( tag2C ) );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests IDatabase::taggedNodes
  void test_taggedNodes()
  {
    std::string path1 = "/fMV";
    std::string path2 = "/fMVp";
    IFolderPtr folder1 = s_db->getFolder( path1 );
    IFolderPtr folder2 = s_db->getFolder( path2 );
    folder1->storeObject( 0, 10, dummyPayload( 0 ), 0 );
    folder2->storeObject( 10, 20, dummyPayload( 1 ), 0 );
    folder2->storeObject( 20, 30, dummyPayload( 2 ), 0 );
    std::string tag1A = "tag1A";
    std::string tag1B = "tag1B";
    std::string tag1C = "tag1C";
    std::string tag2A = "tag2A";
    std::string tag2B = "tag2B";
    std::string tag2C = "tag2C";
    folder1->tagCurrentHead( tag1A, "tag description" );
    folder1->tagCurrentHead( tag1B, "tag description" );
    folder1->tagCurrentHead( tag1C, "tag description" );
    folder2->tagCurrentHead( tag2A, "tag description" );
    folder2->tagCurrentHead( tag2B, "tag description" );
    folder2->tagCurrentHead( tag2C, "tag description" );
    try {
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "tag1A scope", path1, s_db->taggedNodes( tag1A )[0] );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "tag1B scope", path1, s_db->taggedNodes( tag1B )[0] );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "tag1C scope", path1, s_db->taggedNodes( tag1C )[0] );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "tag2A scope", path2, s_db->taggedNodes( tag2A )[0] );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "tag2B scope", path2, s_db->taggedNodes( tag2B )[0] );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "tag2C scope", path2, s_db->taggedNodes( tag2C )[0] );
    }
    catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  void test_deleteTag_andRetag()
  {
    test_deleteTag_andRetag( cool_PayloadMode_Mode::INLINEPAYLOAD );
  }

  void test_deleteTag_andRetag_sepPayload()
  {
    test_deleteTag_andRetag( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  };

  void test_deleteTag_andRetag_vector()
  {
    test_deleteTag_andRetag( cool_PayloadMode_Mode::VECTORPAYLOAD );
  };

  /// Tests deleting a tag and retagging
  void test_deleteTag_andRetag( PayloadMode::Mode pMode )
  {
    IFolderPtr folder = s_db->getFolder( payloadMode2Folder( pMode ) );
    try
    {
      // First version of tagA
      folder->storeObject( 0, 4, dummyPayload( 0 ), 0 );
      folder->tagCurrentHead( "tagA", "an optional description" );
      {
        IObjectIteratorPtr objs1a = folder->browseObjects
          ( ValidityKeyMin, ValidityKeyMax, (ChannelId)0, "tagA" );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "tagA1 object count", 1u, (unsigned int)objs1a->size() );
        IObjectPtr obj1a = getNext(objs1a);
        CPPUNIT_ASSERT_MESSAGE( "tagA1 obj 1 payload",
                                dummyPayload( 0 ) == obj1a->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagA1 obj 1 since",
                                      (ValidityKey)0, obj1a->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagA1 obj 1 until",
                                      (ValidityKey)4, obj1a->until() );
      }
      // Retagging as tagA will fail now
      try {
        folder->tagCurrentHead( "tagA", "an optional description" );
        CPPUNIT_FAIL( "retag as tagA succeeeds even with no deleteTag" );
      } catch ( TagExists& /* dummy */ ) {
      }
      // Second version of tagA
      folder->storeObject( 2, 6, dummyPayload( 1 ), 0 );
      folder->deleteTag( "tagA" );
      CPPUNIT_ASSERT_MESSAGE( "tagA deleted", ! s_db->existsTag( "tagA" ) );
      folder->tagCurrentHead( "tagA", "an optional description" );
      {
        IObjectIteratorPtr objs2a = folder->browseObjects
          ( ValidityKeyMin, ValidityKeyMax, (ChannelId)0, "tagA" );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "tagA2 object count", 2u, (unsigned int)objs2a->size() );
        IObjectPtr obj2a = getNext(objs2a);
        CPPUNIT_ASSERT_MESSAGE( "tagA2 obj 1 payload",
                                dummyPayload( 0 ) == obj2a->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagA2 obj 1 since",
                                      (ValidityKey)0, obj2a->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagA2 obj 1 until",
                                      (ValidityKey)2, obj2a->until() );
        obj2a = getNext(objs2a);
        CPPUNIT_ASSERT_MESSAGE( "tagA2 obj 2 payload",
                                dummyPayload( 1 ) == obj2a->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagA2 obj 2 since",
                                      (ValidityKey)2, obj2a->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagA2 obj 2 until",
                                      (ValidityKey)6, obj2a->until() );
      }
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests that attempting to delete the reserved HEAD tag throws
  /// an exception.
  void test_deleteTag_HEAD()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->storeObject( 0, 4, dummyPayload( 0 ), 0 );
    folder->tagCurrentHead( "tagA", "an optional description" );
    CPPUNIT_ASSERT_THROW( folder->deleteTag( "HEAD" ),
                          ReservedHeadTag );
  }

  void test_MV_tag_and_retrieve()
  {
    test_MV_tag_and_retrieve( cool_PayloadMode_Mode::INLINEPAYLOAD );
  };

  void test_MV_tag_and_retrieve_sepPayload()
  {
    test_MV_tag_and_retrieve( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  };

  void test_MV_tag_and_retrieve_vector()
  {
    test_MV_tag_and_retrieve( cool_PayloadMode_Mode::VECTORPAYLOAD );
  };

  /// Tests MV tagging and retrieving
  void test_MV_tag_and_retrieve( PayloadMode::Mode pMode )
  {
    IFolderPtr folder = s_db->getFolder( payloadMode2Folder( pMode ) );
    try
    {
      folder->setupStorageBuffer();
      folder->storeObject( 0, 4, dummyPayload( 0 ), 0 );
      folder->storeObject( 2, 6, dummyPayload( 1 ), 0 );
      folder->flushStorageBuffer();
      folder->tagCurrentHead( "tagA", "an optional description" );
      Time asOfDate = folder->findObject( 0, 0 )->insertionTime();
      // MySQL now() has 1 second granularity: sleep at least 1 second
      sleep(1);
      folder->setupStorageBuffer();
      folder->storeObject( 3, 7, dummyPayload( 2 ), 0 );
      folder->storeObject( 5, 9, dummyPayload( 3 ), 0 );
      folder->flushStorageBuffer();
      folder->tagCurrentHead( "tagB" );
      folder->tagHeadAsOfDate( asOfDate, "tagC" ); // == tagA
      // fetch tagA
      //std::cout << "Fetch tagA" << std::endl;
      {
        IObjectIteratorPtr objs =
          folder->browseObjects
          ( ValidityKeyMin, ValidityKeyMax, (ChannelId)0, "tagA" );
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
      }
      // fetch tagB
      //std::cout << "Fetch tagB" << std::endl;
      {
        IObjectIteratorPtr objs =
          folder->browseObjects
          ( ValidityKeyMin, ValidityKeyMax, (ChannelId)0, "tagB" );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagB object count", 4u,
                                      (unsigned int)objs->size() );
        IObjectPtr obj = getNext(objs);
        CPPUNIT_ASSERT_MESSAGE( "tagB obj 1 payload",
                                dummyPayload( 0 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagB obj 1 since",
                                      (ValidityKey)0, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagB obj 1 until",
                                      (ValidityKey)2, obj->until() );
        obj = getNext(objs);
        CPPUNIT_ASSERT_MESSAGE( "tagB obj 2 payload",
                                dummyPayload( 1 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagB obj 2 since",
                                      (ValidityKey)2, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagB obj 2 until",
                                      (ValidityKey)3, obj->until() );
        obj = getNext(objs);
        CPPUNIT_ASSERT_MESSAGE( "tagB obj 3 payload",
                                dummyPayload( 2 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagB obj 3 since",
                                      (ValidityKey)3, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagB obj 3 until",
                                      (ValidityKey)5, obj->until() );
        obj = getNext(objs);
        CPPUNIT_ASSERT_MESSAGE( "tagB obj 4 payload",
                                dummyPayload( 3 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagB obj 4 since",
                                      (ValidityKey)5, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagB obj 4 until",
                                      (ValidityKey)9, obj->until() );
      }
      // fetch head
      //std::cout << "Fetch HEAD" << std::endl;
      {
        IObjectIteratorPtr objs =
          folder->browseObjects
          ( ValidityKeyMin, ValidityKeyMax, (ChannelId)0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "HEAD object count", 4u,
                                      (unsigned int)objs->size() );
        IObjectPtr obj = getNext(objs);
        CPPUNIT_ASSERT_MESSAGE( "HEAD obj 1 payload",
                                dummyPayload( 0 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "HEAD obj 1 since",
                                      (ValidityKey)0, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "HEAD obj 1 until",
                                      (ValidityKey)2, obj->until() );
        obj = getNext(objs);
        CPPUNIT_ASSERT_MESSAGE( "HEAD obj 2 payload",
                                dummyPayload( 1 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "HEAD obj 2 since",
                                      (ValidityKey)2, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "HEAD obj 2 until",
                                      (ValidityKey)3, obj->until() );
        obj = getNext(objs);
        CPPUNIT_ASSERT_MESSAGE( "HEAD obj 3 payload",
                                dummyPayload( 2 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "HEAD obj 3 since",
                                      (ValidityKey)3, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "HEAD obj 3 until",
                                      (ValidityKey)5, obj->until() );
        obj = getNext(objs);
        CPPUNIT_ASSERT_MESSAGE( "HEAD obj 4 payload",
                                dummyPayload( 3 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "HEAD obj 4 since",
                                      (ValidityKey)5, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "HEAD obj 4 until",
                                      (ValidityKey)9, obj->until() );
      }
      // fetch tagC
      //std::cout << "Fetch tagC" << std::endl;
      {
        IObjectIteratorPtr objs =
          folder->browseObjects
          ( ValidityKeyMin, ValidityKeyMax, (ChannelId)0, "tagC" );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagC object count", 2u,
                                      (unsigned int)objs->size() );
        IObjectPtr obj = getNext(objs);
        CPPUNIT_ASSERT_MESSAGE( "tagC obj 1 payload",
                                dummyPayload( 0 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagC obj 1 since",
                                      (ValidityKey)0, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagC obj 1 until",
                                      (ValidityKey)2, obj->until() );
        obj = getNext(objs);
        CPPUNIT_ASSERT_MESSAGE( "tagC obj 2 payload",
                                dummyPayload( 1 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagC obj 2 since",
                                      (ValidityKey)2, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagC obj 2 until",
                                      (ValidityKey)6, obj->until() );
      }
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  void test_storeObject_bulk_MV()
  {
    test_storeObject_bulk_MV( cool_PayloadMode_Mode::INLINEPAYLOAD );
  };

  void test_storeObject_bulk_MV_sepPayload()
  {
    test_storeObject_bulk_MV( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  };

  void test_storeObject_bulk_MV_vector()
  {
    test_storeObject_bulk_MV( cool_PayloadMode_Mode::VECTORPAYLOAD );
  };

  /// Tests bulk storeObject of MV objects
  void test_storeObject_bulk_MV( PayloadMode::Mode pMode )
  {
    IFolderPtr folder = s_db->getFolder( payloadMode2Folder( pMode ) );
    folder->setupStorageBuffer();
    unsigned int nObjs = 10;
    for ( unsigned int i = 0; i < nObjs; ++i ) {
      folder->storeObject( i, ValidityKeyMax, dummyPayload( i ), 0 );
    }
    // cppunit 1.8.0 does not have CPPUNIT_ASSERT_EXCEPTION
    bool objectNotFound = false;
    try {
      folder->findObject( 0, 0 );
    } catch( ObjectNotFound& /* dummy */ ) {
      objectNotFound = true;
    }
    CPPUNIT_ASSERT_MESSAGE( "no objects", objectNotFound );
    folder->flushStorageBuffer();
    IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                     ValidityKeyMax, 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "size",
                                  10u, (unsigned int)objs->size() );
    for ( unsigned int i = 0; i < objs->size(); ++i ) {
      IObjectPtr obj = getNext(objs);
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
    }
  }

  /// Tests storeObject() with payloadId
  void test_storeObject_reinsert_with_payloadId( )
  {
    IFolderPtr folder = s_db->getFolder( "/fMVp" );
    folder->setupStorageBuffer();
    unsigned int nObjs = 10;
    for ( unsigned int i = 0; i < nObjs; ++i ) {
      folder->storeObject( i, ValidityKeyMax, dummyPayload( i ), 0 );
    }
    folder->flushStorageBuffer();
    IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                     ValidityKeyMax, 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "size",
                                  10u, (unsigned int)objs->size() );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>(&*folder);
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    for ( unsigned int i = 0; i < objs->size(); ++i )
    {
      // store the same payload in a different channel, without copying it
      IObjectPtr obj = getNext(objs);
      RelationalObject* relobj = dynamic_cast<RelationalObject*>(&*obj);
      if ( !relobj ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
      unsigned int payloadId = relobj->payloadId();
      CPPUNIT_ASSERT_MESSAGE( "payloadId == 0!", payloadId != 0 );
      relfolder->storeObject( i, ValidityKeyMax, payloadId, 1 );
    }
    folder->flushStorageBuffer();
    // now compare the result when browsing both channels
    objs = folder->browseObjects( ValidityKeyMin, ValidityKeyMax, 0 );
    IObjectIteratorPtr objs1 = folder->browseObjects( ValidityKeyMin,
                                                      ValidityKeyMax, 1 );
    for ( unsigned int i = 0; i < objs->size(); ++i )
    {
      IObjectPtr obj = getNext(objs);
      IObjectPtr obj1 = getNext(objs1);
      std::stringstream s;
      s << "object " << i << " ";
      RelationalObject* relobj = dynamic_cast<RelationalObject*>(&*obj);
      if ( !relobj ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
      unsigned int payloadId = relobj->payloadId();
      RelationalObject* relobj1 = dynamic_cast<RelationalObject*>(&*obj1);
      if ( !relobj1 ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
      unsigned int payloadId1 = relobj1->payloadId();
      CPPUNIT_ASSERT_MESSAGE( ( s.str() + "payloadId" ).c_str(),
                              payloadId == payloadId1 );
      CPPUNIT_ASSERT_MESSAGE( ( s.str() + "payload" ).c_str(),
                              obj1->payload() == obj->payload() );
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
    }
  }

  /// Tests tag name case sensitivity
  void test_tagName_case_sensitivity()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    try
    {
      folder->storeObject( 0, 4, dummyPayload( 0 ), 0 );
      folder->tagCurrentHead( "tagA" );
      folder->storeObject( 0, 4, dummyPayload( 1 ), 0 );
      folder->tagCurrentHead( "taga" );
      // fetch tagA
      {
        IObjectIteratorPtr objs =
          folder->browseObjects
          ( ValidityKeyMin, ValidityKeyMax, (ChannelId)0, "tagA" );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagA object count", 1u,
                                      (unsigned int)objs->size() );
        IObjectPtr obj = getNext(objs);
        CPPUNIT_ASSERT_MESSAGE( "tagA obj payload",
                                dummyPayload( 0 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagA obj since",
                                      (ValidityKey)0, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "tagA obj until",
                                      (ValidityKey)4, obj->until() );
      }
      // fetch taga
      {
        IObjectIteratorPtr objs =
          folder->browseObjects
          ( ValidityKeyMin, ValidityKeyMax, (ChannelId)0, "taga" );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "taga object count", 1u,
                                      (unsigned int)objs->size() );
        IObjectPtr obj = getNext(objs);
        CPPUNIT_ASSERT_MESSAGE( "taga obj payload",
                                dummyPayload( 1 ) == obj->payload() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "taga obj since",
                                      (ValidityKey)0, obj->since() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "taga obj until",
                                      (ValidityKey)4, obj->until() );
      }
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests bulk storeObject of 70k objects: this used to cause ORA-24381
  /// before a workaround was added in RelationalFolder::flushStorageBuffer
  /// (this is now fixed in CORAL for bulk inserts, but we keep our hack
  /// in COOL because of better performance with 10k bulks in MySQL).
  void test_storeObject_bulk_70k()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->setupStorageBuffer();
    long nObjs = 70*1000;
    for ( long i = 0; i < nObjs; ++i ) {
      folder->storeObject( i, ValidityKeyMax, dummyPayload( i ), 0 );
    }
    folder->flushStorageBuffer();
    IObjectPtr obj;
    for ( long i = 0; i < nObjs; i += 1000 ) {
      obj = folder->findObject( i, 0 );
      std::stringstream s;
      s << "object " << i << " ";
      CPPUNIT_ASSERT_MESSAGE( ( s.str() + "payload" ).c_str(),
                              dummyPayload( i ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "since" ).c_str(),
                                    i, (long)obj->since() );
      // last object's until extends to ValidityKeyMax
      if ( i < nObjs-1 ) {
        CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "until" ).c_str(),
                                      i+1, (long)obj->until() );
      } else {
        CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "until" ).c_str(),
                                      LONG_MAX, (long)obj->until() );
      }
    }
  }

  /// More recently the problem above reappeared for bulk updates: see bug
  /// #17755, due to CORAL bug #17757, which is now also fixed (only bulk
  /// inserts had been fixed, not bulk updates). In this case we do not
  /// have an internal COOL hack, we rely on CORAL: we test this here too.
  /// Keep the above test stand-alone because SV is much faster!
  /// The tagBulk70k test is disabled because it is very slow (roughly
  /// twice as slow as the storeObject_bulk_70k after fixing bug #17903)
  /// and it tests CORAL code already covered by storeObject_bulk_70k.
  void test_tagObject_bulk_70k()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->setupStorageBuffer();
    long nObjs = 70*1000;
    for ( long i = 0; i < nObjs; ++i ) {
      folder->storeObject( i, i+1, dummyPayload( i ), 0 );
    }
    folder->flushStorageBuffer();
    folder->tagCurrentHead( "MYTAG" );
    IObjectPtr obj;
    for ( long i = 0; i < nObjs; i += 1000 ) {
      obj = folder->findObject( i, 0, "MYTAG" );
      std::stringstream s;
      s << "object " << i << " ";
      CPPUNIT_ASSERT_MESSAGE( ( s.str() + "payload" ).c_str(),
                              dummyPayload( i ) == obj->payload() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "since" ).c_str(),
                                    i, (long)obj->since() );
      // last object's until extends to ValidityKeyMax
      if ( i < nObjs-1 ) {
        CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "until" ).c_str(),
                                      i+1, (long)obj->until() );
      } else {
        CPPUNIT_ASSERT_EQUAL_MESSAGE( ( s.str() + "until" ).c_str(),
                                      LONG_MAX, (long)obj->until() );
      }
    }
  }

  /// Tests bulk storeObject of SV objects with a reused AttributeList
  /// This test ensures that the payload data is copied, not referenced
  /// inside the storage buffer.
  void test_storeObject_bulk_SV_listReused()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    Record payload = dummyPayload( 0 );
    folder->setupStorageBuffer();
    unsigned int nObjs = 100;
    for ( unsigned int i = 0; i < nObjs; ++i ) {
      payload["I"].setValue<int>( (int)i );
      folder->storeObject( i, ValidityKeyMax, payload, 0 );
    }
    // cppunit 1.8.0 does not have CPPUNIT_ASSERT_EXCEPTION
    bool objectNotFound = false;
    try {
      folder->findObject( 0, 0 );
    } catch( ObjectNotFound& /* dummy */ ) {
      objectNotFound = true;
    }
    CPPUNIT_ASSERT_MESSAGE( "no objects", objectNotFound );
    folder->flushStorageBuffer();
    IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                     ValidityKeyMax, 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "size",
                                  100u, (unsigned int)objs->size() );
    for ( unsigned int i = 0; i < objs->size(); ++i ) {
      IObjectPtr obj = getNext(objs);
      std::stringstream s;
      s << "object " << i << " ";
      CPPUNIT_ASSERT_MESSAGE( ( s.str() + "payload I" ).c_str(),
                              (int)i == obj->payload()["I"].data<int>() );
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
    }
  }

  /// Tests bulk storeObject of SV objects
  void test_storeObject_bulk_SV()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    try
    {
      folder->setupStorageBuffer();
      unsigned int nObjs = 100;
      for ( unsigned int i = 0; i < nObjs; ++i ) {
        folder->storeObject( i, ValidityKeyMax, dummyPayload( i ), 0 );
      }
      // cppunit 1.8.0 does not have CPPUNIT_ASSERT_EXCEPTION
      bool objectNotFound = false;
      try {
        folder->findObject( 0, 0 );
      } catch( ObjectNotFound& /* dummy */ ) {
        objectNotFound = true;
      }
      CPPUNIT_ASSERT_MESSAGE( "no objects", objectNotFound );
      folder->flushStorageBuffer();
      IObjectIteratorPtr objs = folder->browseObjects( ValidityKeyMin,
                                                       ValidityKeyMax, 0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "size",
                                    100u, (unsigned int)objs->size() );
      for ( unsigned int i = 0; i < objs->size(); ++i ) {
        IObjectPtr obj = getNext(objs);
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
      }
    } catch ( std::exception& e ) {
      std::cout << e.what() << std::endl;
      throw;
    }
  }

  /// Tests bulk operation 'flushStorageBuffer'
  void test_flushStorageBuffer()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->setupStorageBuffer();
    folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), 0 );
    folder->storeObject( 1, ValidityKeyMax, dummyPayload( 1 ), 0 );
    // cppunit 1.8.0 does not have CPPUNIT_ASSERT_EXCEPTION
    bool objectNotFound = false;
    try {
      folder->findObject( 1, 0 );
    } catch( ObjectNotFound& /* dummy */ ) {
      objectNotFound = true;
    }
    CPPUNIT_ASSERT_MESSAGE( "no objects", objectNotFound );
    try {
      folder->flushStorageBuffer();
    } catch ( RelationalException& e ) {
      std::cout << e.what() << std::endl;
      throw;
    }
    IObjectPtr obj0 = folder->findObject( 0, 0 );
    CPPUNIT_ASSERT_MESSAGE( "object 1 found", obj0.get() != 0 );
    IObjectPtr obj1 = folder->findObject( 1, 0 );
    CPPUNIT_ASSERT_MESSAGE( "object 1 found", obj1.get() != 0 );
  }

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  /// Tests reading back of a folder from a db handle that went out of scope
  void test_access_outofscope_db()
  {
    ScopedRecreateFolders theCleaner( this );
    IFolderPtr folder;
    {
      CoralApplication app;
      IDatabaseSvc& dbSvc = app.databaseService();
      IDatabasePtr db1 = dbSvc.openDatabase( s_connectionString, false );
      FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
      folder = db1->createFolder( "/myfolder", fSpec );
      // db1 is going of of scope here but folder keeps its own db handle
      //std::cout << "db1 going out of scope" << std::endl;
    }
    //std::cout << "db1 went out of scope, store new IOVs" << std::endl;
    folder->storeObject( 0, 2, dummyPayload( 1 ), 0 );
    //std::cout << "folder going out of scope" << std::endl;
    // better (not needed?) if folder goes out of scope before theCleaner
    folder.reset();
    //std::cout << "folder went out of scope" << std::endl;
  }

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  void test_findObject_after_dropNode_MV()
  {
    test_findObject_after_dropNode_MV( cool_PayloadMode_Mode::INLINEPAYLOAD );
  };

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  void test_findObject_after_dropNode_MV_sepPayload()
  {
    test_findObject_after_dropNode_MV( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  };

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  void test_findObject_after_dropNode_MV_vector()
  {
    test_findObject_after_dropNode_MV( cool_PayloadMode_Mode::VECTORPAYLOAD );
  };

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  /// Tests reading back of an Object from a deleted MV folder
  void test_findObject_after_dropNode_MV( PayloadMode::Mode pMode )
  {
    ScopedRecreateFolders theCleaner( this );
    std::string folderName = ( payloadMode2Folder( pMode ) );
    IFolderPtr folder = s_db->getFolder( folderName );
    folder->storeObject( 0, 2, dummyPayload( 1 ), 0 );
    s_db->dropNode( folderName );
    CPPUNIT_ASSERT_THROW( folder->findObject( 1, 0 ), RelationalException );
  }

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  /// Tests reading back of an Object from a deleted SV folder
  void test_findObject_after_dropNode_SV()
  {
    ScopedRecreateFolders theCleaner( this );
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->storeObject( 0, 2, dummyPayload( 1 ), 0 );
    s_db->dropNode( "/fSV" );
    // This is expected to throw a cool::TableNotFound exception
    CPPUNIT_ASSERT_THROW( folder->findObject( 1, 0 ), RelationalException );
  }

  /// Tests reading back of an Object from a channel that does not exist
  void test_findObject_wrongChannel()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    ChannelId channel1 = 1;
    ChannelId channel2 = 2;
    folder->storeObject( 0, 2, dummyPayload( 1 ), channel1 );
    folder->storeObject( 2, 4, dummyPayload( 2 ), channel1 );
    CPPUNIT_ASSERT_THROW( folder->findObject( 1, channel2 ), ObjectNotFound );
  }

  /// Tests storing and reading back of an Object in a MultiVersion folder
  /// This test is implemented in more detail with respect to the object
  /// attributes in test_RalDatabase
  void test_findObject_MV()
  {
    test_findObject_MV( cool_PayloadMode_Mode::INLINEPAYLOAD );
  }

  void test_findObject_MV_sepPayload()
  {
    test_findObject_MV( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  }

  void test_findObject_MV_vector()
  {
    test_findObject_MV( cool_PayloadMode_Mode::VECTORPAYLOAD );
  }

  void test_findObject_MV( PayloadMode::Mode pMode )
  {
    IFolderPtr folder = s_db->getFolder( payloadMode2Folder( pMode ) );
    folder->storeObject( 0, 2, dummyPayload( 1 ), 0 );
    folder->storeObject( 2, 4, dummyPayload( 2 ), 0 );
    IObjectPtr obj1 = folder->findObject( 1, 0 );
    CPPUNIT_ASSERT_MESSAGE( "first object",
                            dummyPayload( 1 ) == obj1->payload() );
    IObjectPtr obj2 = folder->findObject( 3, 0 );
    CPPUNIT_ASSERT_MESSAGE( "second object",
                            dummyPayload( 2 ) == obj2->payload() );
  }

  /// Tests storing and reading back of an Object
  /// This test is implemented in more detail with respect to the object
  /// attributes in test_RalDatabase
  void test_findObject()
  {
    try
    {
      IFolderPtr folder = s_db->getFolder( "/fSV" );
      folder->storeObject( 0, 2, dummyPayload( 1 ), 0 );
      folder->storeObject( 2, 4, dummyPayload( 2 ), 0 );
      IObjectPtr obj1 = folder->findObject( 1, 0 );
      CPPUNIT_ASSERT_MESSAGE( "first object",
                              dummyPayload( 1 ) == obj1->payload() );
      IObjectPtr obj2 = folder->findObject( 3, 0 );
      CPPUNIT_ASSERT_MESSAGE( "second object",
                              dummyPayload( 2 ) == obj2->payload() );
    }
    catch ( std::exception& e )
    {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  /// Tests creating and retrieving a folder.
  /// This test is implemented in more detail with respect to the folder
  /// attributes in test_RalDatabase
  void test_getFolder()
  {
    std::string folderName = "/fSV";
    IFolderPtr folder = s_db->getFolder( folderName );
    try {
      CPPUNIT_ASSERT( folder.get() != 0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "name", folderName, folder->fullPath() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE // see setup()
        ( "description", std::string( "SV folder" ), folder->description() );
      CPPUNIT_ASSERT_MESSAGE
        ( "isLeaf", folder->isLeaf() );
      CPPUNIT_ASSERT_MESSAGE
        ( "isStored", folder->isStored() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "insertionTime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
          timeToString(folder->insertionTime()).size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "id", 1u, folder->id() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "parentId", 0u, folder->parentId() );
    } catch ( Exception& e ) {
      std::cout << e.what() << std::endl;
      throw;
    }
  }

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  void test_renamePayload()
  {
    test_renamePayload( cool_PayloadMode_Mode::INLINEPAYLOAD );
  }

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  void test_renamePayload_sepPayload()
  {
    test_renamePayload( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  }

  void test_renamePayload_vector()
  {
    test_renamePayload( cool_PayloadMode_Mode::VECTORPAYLOAD );
  }

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  void test_renamePayload( PayloadMode::Mode pMode )
  {
    //ScopedRecreateFolders theCleaner( this ); // not needed
    std::string folderName = ( payloadMode2Folder( pMode ) );
    IFolderPtr folder = s_db->getFolder( folderName );
    folder->storeObject( 0, 2, dummyPayload( 1 ), 0 );
    folder->renamePayload("I","NewColumn");
    folder.reset();
    sleep(1); // Avoid ORA-01466: table definition has changed
    folder = s_db->getFolder( folderName );
    IObjectPtr obj = folder->findObject( 1, 0 );
    CPPUNIT_ASSERT_THROW( obj->payload()["I"] ,
                          cool::RecordSpecificationUnknownField );
    CPPUNIT_ASSERT( obj->payload()["NewColumn"].data<Int32>() == 1 );
    CPPUNIT_ASSERT_THROW( folder->renamePayload("S","X"),
                          cool::RelationalException );
    CPPUNIT_ASSERT_THROW( folder->renamePayload("Z","DoesNotExists"),
                          cool::RelationalException );
    CPPUNIT_ASSERT_THROW( folder->renamePayload("X","not-allowed name"),
                          cool::RelationalException );
    // test storing into the renamed column
    Record new_payload( folder->payloadSpecification() );
    new_payload["NewColumn"].setValue<Int32>( 10 );
    folder->storeObject( 3, 5, new_payload, 0 );
    coral::MsgLevel oldLevel = coral::MessageStream::msgVerbosity();
    coral::MsgLevel newLevel = oldLevel;
    //coral::MsgLevel newLevel = coral::Verbose; // debug bug #73530
    coral::MessageStream::setMsgVerbosity( newLevel );
    try { obj = folder->findObject( 4, 0 ); }
    catch(...)
    {
      coral::MessageStream::setMsgVerbosity( oldLevel );
      throw;
    }
    coral::MessageStream::setMsgVerbosity( oldLevel );
    CPPUNIT_ASSERT( obj->payload()["NewColumn"].data<Int32>() == 10 );
    // cleanup
    openDB(); // this is needed on MySQL to avoid InvalidColumnNameException
    folder = s_db->getFolder( folderName );
    folder->renamePayload("NewColumn","I");
  }

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  void test_extendPayloadSpecificationExceptions()
  {
    //ScopedRecreateFolders theCleaner( this ); // not needed
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    {
      RecordSpecification spec;
      spec.extend("I",cool_StorageType_TypeId::Int32); // already exists
      Record rec( spec );
      CPPUNIT_ASSERT_THROW
        ( folder->extendPayloadSpecification( rec ),
          cool::RelationalException );
    }
    {
      RecordSpecification spec;
      CPPUNIT_ASSERT_THROW
        ( spec.extend("",cool_StorageType_TypeId::Int32),
          cool::FieldSpecificationInvalidName );
      //spec.extend("",cool_StorageType_TypeId::Int32);
      //Record rec( spec );
      //CPPUNIT_ASSERT_THROW
      //  ( folder->extendPayloadSpecification( rec ),
      //    cool::RelationalException );
    }
    {
      RecordSpecification spec;
      spec.extend("not-allowed name",cool_StorageType_TypeId::Int32);
      Record rec( spec );
      CPPUNIT_ASSERT_THROW
        ( folder->extendPayloadSpecification( rec ),
          cool::RelationalException );
    }
  }

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  void test_extendPayloadSpecification()
  {
    test_extendPayloadSpecification( cool_PayloadMode_Mode::INLINEPAYLOAD );
  };

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  void test_extendPayloadSpecification_sepPayload()
  {
    test_extendPayloadSpecification( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  };

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  void test_extendPayloadSpecification_vector()
  {
    test_extendPayloadSpecification( cool_PayloadMode_Mode::VECTORPAYLOAD );
  };

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  void test_extendPayloadSpecification( PayloadMode::Mode pMode )
  {
    ScopedRecreateFolders theCleaner( this );
    std::string folderName = ( payloadMode2Folder( pMode ) );
    IFolderPtr folder = s_db->getFolder( folderName );
    folder->storeObject( 0, 2, dummyPayload( 1 ), 0 );
    RecordSpecification spec;
    spec.extend( "J1", cool_StorageType_TypeId::Int32 );
    spec.extend( "J2", cool_StorageType_TypeId::Int32 );
    spec.extend( "J3", cool_StorageType_TypeId::Int32 );
    Record rec( spec );
    rec["J1"].setValue<Int32>( 1 );
    rec["J2"].setNull();
    rec["J3"].setValue<Int32>( 3 );
    folder->extendPayloadSpecification(rec);
    folder.reset();
    sleep(1); // Avoid ORA-01466: table definition has changed
    folder = s_db->getFolder( folderName );
    IObjectPtr obj = folder->findObject( 1, 0 );
    CPPUNIT_ASSERT( !obj->payload()["J1"].isNull() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "J1", 1, obj->payload()["J1"].data<Int32>() );
    CPPUNIT_ASSERT( obj->payload()["J2"].isNull() );
    CPPUNIT_ASSERT( !obj->payload()["J3"].isNull() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "J3", 3, obj->payload()["J3"].data<Int32>() );
    // test storing into the new column
    Record new_payload( folder->payloadSpecification() );
    new_payload["J1"].setValue<Int32>( 10 );
    folder->storeObject( 3, 5, new_payload, 0 );
    obj = folder->findObject( 4, 0);
    CPPUNIT_ASSERT( obj->payload()["J1"].data<Int32>() == 10 );
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  IObjectVectorPtr RecordSelect( const IRecordSelection& sel,
                                 IObjectIteratorPtr iter)
  {
    IObjectVectorPtr objects( new IObjectVector() );
    while( iter->goToNext() )
    {
      IObjectPtr obj( iter->currentRef().clone() );
      if (sel.select(obj->payload()))
        objects->push_back( obj );
    }
    return objects;
  }

  void test_RecordSelectionBrowseObjects() {
    test_RecordSelectionBrowseObjects( cool_PayloadMode_Mode::INLINEPAYLOAD );
  };

  void test_RecordSelectionBrowseObjects_sepPayload() {
    test_RecordSelectionBrowseObjects( cool_PayloadMode_Mode::SEPARATEPAYLOAD );
  };

  void test_RecordSelectionBrowseObjects_vector() {
    //test_RecordSelectionBrowseObjects( cool_PayloadMode_Mode::VECTORPAYLOAD );
    // DISABLE currently no RecordSelections on vector payload folders
  };

  void test_RecordSelectionBrowseObjects( PayloadMode::Mode pMode )
  {
    IFolderPtr folder = s_db->getFolder( payloadMode2Folder( pMode ) );
    try
    {
      {
        const RecordSpecification& spec = payloadSpec;
        // fill with some test data
        for ( int i=0; i<10; i++ )
        {
          Record rec( spec );
          rec["I"].setValue<Int32>( i );
          rec["X"].setValue<Float>( 1 - ((float)i)/10 );
          std::stringstream str_value;
          str_value << "Payload #" << i;
          rec["S"].setValue<String4k>( str_value.str() );
          folder->storeObject( i, i+2, rec, 0 );
        }
        // store a null record
        Record null_rec(spec);
        null_rec["I"].setNull();
        null_rec["X"].setNull();
        null_rec["S"].setNull();
        folder->storeObject(10,12,null_rec,0);
        // invalid selection (I is not a Float in this folder)
        FieldSelection invalid_sel
          ( "I", cool_StorageType_TypeId::Float, cool_FieldSelection_Relation::EQ, (Float)6.0 );
        CPPUNIT_ASSERT_THROW
          ( folder->countObjects( 0, 300, 0, "", &invalid_sel ),
            RelationalException );
        // invalid selection (DUMMY does not exist in this folder)
        FieldSelection invalid_sel2
          ( "DUMMY", cool_StorageType_TypeId::Float, cool_FieldSelection_Relation::EQ, (Float)6.0 );
        CPPUNIT_ASSERT_THROW
          ( folder->countObjects( 0, 300, 0, "", &invalid_sel2 ),
            RelationalException );
      }
      // To test untrusted user selections, we wrap a class
      // around FieldSelection
      class SelectionWrapper : public IRecordSelection
      {
      public:
        IRecordSelection *sel;
        SelectionWrapper( const IRecordSelection * sel) {
          this->sel=sel->clone();
        };
        virtual ~SelectionWrapper() {
          delete sel;
        };
        bool canSelect( const IRecordSpecification& spec ) const
        {
          return sel->canSelect( spec );
        };
        bool select( const IRecord& record ) const
        {
          return sel->select( record );
        };
        IRecordSelection* clone( ) const
        {
          return new SelectionWrapper( sel );
        };
      };
      // switch on prefetching of rows to allow browseObject()->size()
      // (otherwise this will throw on untrusted selections)
      folder->setPrefetchAll(true);
      // selections on int (all 6 relations)
      IObjectIteratorPtr objects;
      {
        FieldSelection sel
          ( "I", cool_StorageType_TypeId::Int32, cool_FieldSelection_Relation::EQ, (Int32)5 );
        SelectionWrapper u_sel(&sel);
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "1-I-EQ count objects",
            1u, folder->countObjects( 0, 300, 0, "", &sel) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "untrusted 1-I-EQ count objects",
            1u, folder->browseObjects( 0, 300, 0, "", &u_sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "1-I-EQ browse Objects size",
            (size_t)1, RecordSelect(sel, objects )->size() );
      }
      {
        FieldSelection sel
          ( "I", cool_StorageType_TypeId::Int32, cool_FieldSelection_Relation::NE, (Int32)5 );
        SelectionWrapper u_sel(&sel);
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "2-I-NE count objects",
            9u, folder->countObjects( 0, 300, 0, "", &sel) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "untrusted 2-I-NE count objects",
            9u, folder->browseObjects( 0, 300, 0, "", &u_sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "2-I-NE browse Objects size",
            (size_t)9, RecordSelect(sel, objects )->size() );
      }
      {
        FieldSelection sel
          ( "I", cool_StorageType_TypeId::Int32, cool_FieldSelection_Relation::GT, (Int32)5 );
        SelectionWrapper u_sel(&sel);
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "3-I-GT count objects",
            4u, folder->countObjects( 0, 300, 0, "", &sel) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "untrusted 3-I-GT count objects",
            4u, folder->browseObjects( 0, 300, 0, "", &u_sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "3-I-GT browse Objects size",
            (size_t)4, RecordSelect(sel, objects )->size() );
      }
      {
        FieldSelection sel
          ( "I", cool_StorageType_TypeId::Int32, cool_FieldSelection_Relation::GE, (Int32)5 );
        SelectionWrapper u_sel(&sel);
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "4-I-GE count objects",
            5u, folder->countObjects( 0, 300, 0, "", &sel) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "untrusted 4-I-GE count objects",
            5u, folder->browseObjects( 0, 300, 0, "", &u_sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "4-I-GE browse Objects size",
            (size_t)5, RecordSelect(sel, objects )->size() );
      }
      {
        FieldSelection sel
          ( "I", cool_StorageType_TypeId::Int32, cool_FieldSelection_Relation::LT, (Int32)5 );
        SelectionWrapper u_sel(&sel);
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "5-I-LT count objects",
            5u, folder->countObjects( 0, 300, 0, "", &sel) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "untrusted 5-I-LT count objects",
            5u, folder->browseObjects( 0, 300, 0, "", &u_sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "5-I-LT browse Objects size",
            (size_t)5, RecordSelect(sel, objects )->size() );
      }
      {
        FieldSelection sel
          ( "I", cool_StorageType_TypeId::Int32, cool_FieldSelection_Relation::LE, (Int32)5 );
        SelectionWrapper u_sel(&sel);
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "6-I-LE count objects",
            6u, folder->countObjects( 0, 300, 0, "", &sel) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "untrusted 6-I-LE count objects",
            6u, folder->browseObjects( 0, 300, 0, "", &u_sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "6-I-LE browse Objects size",
            (size_t)6, RecordSelect(sel, objects )->size() );
      }
      // selections on int (nullness checks)
      {
        FieldSelection sel
          ( "I", cool_StorageType_TypeId::Int32, cool_FieldSelection_Nullness::IS_NULL );
        SelectionWrapper u_sel(&sel);
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "7-I-NULL count objects",
            1u, folder->countObjects( 0, 300, 0, "", &sel) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "untrusted 7-I-NULL count objects",
            1u, folder->browseObjects( 0, 300, 0, "", &u_sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "7-I-NULL browse Objects size",
            (size_t)1, RecordSelect(sel, objects )->size() );
      }
      {
        FieldSelection sel
          ( "I", cool_StorageType_TypeId::Int32, cool_FieldSelection_Nullness::IS_NOT_NULL );
        SelectionWrapper u_sel(&sel);
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "8-I-NOTNULL count objects",
            10u, folder->countObjects( 0, 300, 0, "", &sel) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "untrusted 8-I-NOTNULL count objects",
            10u, folder->browseObjects( 0, 300, 0, "", &u_sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "8-I-NOTNULL browse Objects size",
            (size_t)10, RecordSelect(sel, objects )->size() );
      }
      // selections on float (all 6 relations)
      {
        FieldSelection sel
          ( "X", cool_StorageType_TypeId::Float, cool_FieldSelection_Relation::EQ, (Float)0.5 );
        SelectionWrapper u_sel(&sel);
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "1-X-EQ count objects",
            1u, folder->countObjects( 0, 300, 0, "", &sel) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "1-X-EQ count objects",
            1u, folder->browseObjects( 0, 300, 0, "", &u_sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "1-X-EQ browse Objects size",
            (size_t)1, RecordSelect(sel, objects )->size() );
      }
      {
        FieldSelection sel
          ( "X", cool_StorageType_TypeId::Float, cool_FieldSelection_Relation::NE, (Float)0.5 );
        SelectionWrapper u_sel(&sel);
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "2-X-NE count objects",
            9u, folder->countObjects( 0, 300, 0, "", &sel) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "unstrusted 2-X-NE count objects",
            9u, folder->browseObjects( 0, 300, 0, "", &sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "2-X-NE browse Objects size",
            (size_t)9, RecordSelect(sel, objects )->size() );
      }
      {
        FieldSelection sel
          ( "X", cool_StorageType_TypeId::Float, cool_FieldSelection_Relation::GT, (Float)0.5 );
        SelectionWrapper u_sel(&sel);
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "3-X-GT count objects",
            5u, folder->countObjects( 0, 300, 0, "", &sel) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "untrusted 3-X-GT count objects",
            5u, folder->browseObjects( 0, 300, 0, "", &u_sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "3-X-GT browse Objects size",
            (size_t)5, RecordSelect(sel, objects )->size() );
      }
      {
        FieldSelection sel
          ( "X", cool_StorageType_TypeId::Float, cool_FieldSelection_Relation::GE, (Float)0.5 );
        SelectionWrapper u_sel(&sel);
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "4-X-GE count objects",
            6u, folder->countObjects( 0, 300, 0, "", &sel) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "untrusted 4-X-GE count objects",
            6u, folder->browseObjects( 0, 300, 0, "", &u_sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "4-X-GE browse Objects size",
            (size_t)6, RecordSelect(sel, objects )->size() );
      }
      {
        FieldSelection sel
          ( "X", cool_StorageType_TypeId::Float, cool_FieldSelection_Relation::LT, (Float)0.5 );
        SelectionWrapper u_sel(&sel);
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "5-X-LT count objects",
            4u, folder->countObjects( 0, 300, 0, "", &sel) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "untrusted 5-X-LT count objects",
            4u, folder->browseObjects( 0, 300, 0, "", &u_sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "5-X-LT browse Objects size",
            (size_t)4, RecordSelect(sel, objects )->size() );
      }
      {
        FieldSelection sel
          ( "X", cool_StorageType_TypeId::Float, cool_FieldSelection_Relation::LE, (Float)0.5 );
        SelectionWrapper u_sel(&sel);
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "6-X-LE count objects",
            5u, folder->countObjects( 0, 300, 0, "", &sel) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "untrusted 6-X-LE count objects",
            5u, folder->browseObjects( 0, 300, 0, "", &u_sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "6-X-LE browse Objects size",
            (size_t)5, RecordSelect(sel, objects )->size() );
      }
      // selections on float (nullness checks)
      {
        FieldSelection sel
          ( "X", cool_StorageType_TypeId::Float, cool_FieldSelection_Nullness::IS_NULL );
        SelectionWrapper u_sel(&sel);
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "7-X-NULL count objects",
            1u, folder->countObjects( 0, 300, 0, "", &sel) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "untrusted 7-X-NULL count objects",
            1u, folder->browseObjects( 0, 300, 0, "", &u_sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "7-X-NULL browse Objects size",
            (size_t)1, RecordSelect(sel, objects )->size() );
      }
      {
        FieldSelection sel
          ( "X", cool_StorageType_TypeId::Float, cool_FieldSelection_Nullness::IS_NOT_NULL );
        SelectionWrapper u_sel(&sel);
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "8-X-NOTNULL count objects",
            10u, folder->countObjects( 0, 300, 0, "", &sel) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "untrusted 8-X-NOTNULL count objects",
            10u, folder->browseObjects( 0, 300, 0, "", &u_sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "8-X-NOTNULL browse Objects size",
            (size_t)10, RecordSelect(sel, objects )->size() );
      }
      // composite selections
      {
        FieldSelection sel1
          ( "X", cool_StorageType_TypeId::Float, cool_FieldSelection_Nullness::IS_NULL );
        FieldSelection sel2
          ( "X", cool_StorageType_TypeId::Float, cool_FieldSelection_Relation::LT, (Float)0.5 );
        CompositeSelection comp( &sel1, cool_CompositeSelection_Connective::OR, &sel2 );
        SelectionWrapper u_sel(&comp);
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "X-OR count objects",
            5u, folder->countObjects( 0, 300, 0, "", &comp) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "untrusted X-OR count objects",
            5u, folder->browseObjects( 0, 300, 0, "", &u_sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "X-OR browse Objects size",
            (size_t)5, RecordSelect(comp, objects )->size() );
      }
      {
        FieldSelection sel1
          ( "X", cool_StorageType_TypeId::Float, cool_FieldSelection_Relation::GT, (Float)0.21 );
        FieldSelection sel2
          ( "X", cool_StorageType_TypeId::Float, cool_FieldSelection_Relation::LT, (Float)0.49 );
        CompositeSelection comp( &sel1, cool_CompositeSelection_Connective::AND, &sel2 );
        SelectionWrapper u_sel(&comp);
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "X-AND count objects",
            2u, folder->countObjects( 0, 300, 0, "", &comp) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "untrusted X-AND count objects",
            2u, folder->browseObjects( 0, 300, 0, "", &u_sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "X-AND browse Objects size",
            (size_t)2, RecordSelect(comp, objects )->size() );
      }
      {
        FieldSelection sel1
          ( "X", cool_StorageType_TypeId::Float, cool_FieldSelection_Relation::GT, (Float)0.21 );
        FieldSelection sel2
          ( "X", cool_StorageType_TypeId::Float, cool_FieldSelection_Relation::LT, (Float)0.49 );
        FieldSelection sel3
          ( "I", cool_StorageType_TypeId::Int32, cool_FieldSelection_Relation::EQ, (Int32)0 );
        CompositeSelection comp12( &sel1, cool_CompositeSelection_Connective::AND, &sel2 );
        CompositeSelection comp( &comp12, cool_CompositeSelection_Connective::OR, &sel3 );
        SelectionWrapper u_sel(&comp);
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "AND-OR count objects",
            3u, folder->countObjects( 0, 300, 0, "", &comp) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "AND-OR count objects",
            3u, folder->browseObjects( 0, 300, 0, "", &u_sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "AND-OR browse Objects size",
            (size_t)3, RecordSelect(comp, objects )->size() );
      }
      {
        std::vector<const IRecordSelection *> sel_vec(5);
        for ( int i=0; i<5; i++ )
        {
          FieldSelection sel
            ( "I", cool_StorageType_TypeId::Int32, cool_FieldSelection_Relation::EQ, (Int32)i );
          sel_vec[i] = sel.clone();
        }
        CompositeSelection comp( cool_CompositeSelection_Connective::OR, sel_vec );
        SelectionWrapper u_sel(&comp);
        //objects = folder->browseObjects( 0, 300, 0  );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "OR-vec count objects",
            5u, folder->countObjects( 0, 300, 0, "", &comp) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "OR-vec count objects",
            5u, folder->browseObjects( 0, 300, 0, "", &u_sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "OR-vec browse Objects size",
            (size_t)5, RecordSelect(comp, objects )->size() );
        for ( int i=0; i<5; i++ )
        {
          delete sel_vec[i];
        }
      }
      // selections on string (only 2 of 6 relations allowed)
      {
        FieldSelection sel
          ( "S", cool_StorageType_TypeId::String4k, cool_FieldSelection_Relation::EQ,
            (String4k)"Payload #1" );
        SelectionWrapper u_sel(&sel);
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "1-S-EQ count objects",
            1u, folder->countObjects( 0, 300, 0, "", &sel) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "untrusted 1-S-EQ count objects",
            1u, folder->browseObjects( 0, 300, 0, "", &u_sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "1-S-EQ browse Objects size",
            (size_t)1, RecordSelect(sel, objects )->size() );
      }
      {
        FieldSelection sel
          ( "S", cool_StorageType_TypeId::String4k, cool_FieldSelection_Relation::NE,
            (String4k)"Payload #1" );
        SelectionWrapper u_sel(&sel);
        // NB: the NULL value (stored as "") is counted ("" != "Payload #1")
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "2-S-NE count objects",
            10u, folder->countObjects( 0, 300, 0, "", &sel) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "untrusted 2-S-NE count objects",
            10u, folder->browseObjects( 0, 300, 0, "", &u_sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "2-S-NE browse Objects size",
            (size_t)10, RecordSelect(sel, objects )->size() );
      }
      {
        CPPUNIT_ASSERT_THROW
          ( FieldSelection( "S", cool_StorageType_TypeId::String4k, cool_FieldSelection_Relation::GT,
                            (String4k)"Payload #1" ),
            RecordSelectionException );
      }
      {
        CPPUNIT_ASSERT_THROW
          ( FieldSelection( "S", cool_StorageType_TypeId::String4k, cool_FieldSelection_Relation::GE,
                            (String4k)"Payload #1" ),
            RecordSelectionException );
      }
      {
        CPPUNIT_ASSERT_THROW
          ( FieldSelection( "S", cool_StorageType_TypeId::String4k, cool_FieldSelection_Relation::LT,
                            (String4k)"Payload #1" ),
            RecordSelectionException );
      }
      {
        CPPUNIT_ASSERT_THROW
          ( FieldSelection( "S", cool_StorageType_TypeId::String4k, cool_FieldSelection_Relation::LE,
                            (String4k)"Payload #1" ),
            RecordSelectionException );
      }
      // selections on string (nullness checks)
      {
        CPPUNIT_ASSERT_THROW
          ( FieldSelection sel
            ( "S", cool_StorageType_TypeId::String4k, cool_FieldSelection_Nullness::IS_NULL ),
            RecordSelectionException );
      }
      {
        CPPUNIT_ASSERT_THROW
          ( FieldSelection sel
            ( "S", cool_StorageType_TypeId::String4k, cool_FieldSelection_Nullness::IS_NOT_NULL ),
            RecordSelectionException );
      }
      {
        FieldSelection sel
          ( "S", cool_StorageType_TypeId::String4k, cool_FieldSelection_Relation::EQ, (String4k)"" );
        SelectionWrapper u_sel(&sel);
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "7-S-EQ-EMPTYSTRING count objects",
            1u, folder->countObjects( 0, 300, 0, "", &sel) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "untrusted 7-S-EQ-EMPTYSTRING count objects",
            1u, folder->browseObjects( 0, 300, 0, "", &u_sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "7-S-EQ-EMPTYSTRING browse Objects size",
            (size_t)1, RecordSelect(sel, objects )->size() );
      }
      {
        FieldSelection sel
          ( "S", cool_StorageType_TypeId::String4k, cool_FieldSelection_Relation::NE, (String4k)"" );
        SelectionWrapper u_sel(&sel);
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "8-S-NE-EMPTYSTRING count objects",
            10u, folder->countObjects( 0, 300, 0, "", &sel) );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "untrusted 8-S-NE-EMPTYSTRING count objects",
            10u, folder->browseObjects( 0, 300, 0, "", &u_sel)->size() );
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "8-S-NE-EMPTYSTRING browse Objects size",
            (size_t)10, RecordSelect(sel, objects )->size() );
      }

      class UserPayloadSelection : public IRecordSelection
      {
      public:
        UserPayloadSelection() {};
        virtual ~UserPayloadSelection() {};
        /// Can the selection be applied to a record with the given spec?
        bool canSelect( const IRecordSpecification& spec ) const
        {
          return spec.exists("I") &&
            spec["I"].storageType()==cool_StorageType_TypeId::Int32;
        };
        /// Apply the selection to the given record.
        bool select( const IRecord& record ) const
        {
          return !record["I"].isNull() && record["I"].data<Int32>()%2 ==0;
        };
        /// Clone the record selection (and any objects referenced therein).
        IRecordSelection* clone( ) const
        {
          return new UserPayloadSelection();
        };
      };

      {
        UserPayloadSelection untrusted_sel;
        // countObject throws on untrusted selections
        CPPUNIT_ASSERT_THROW
          ( folder->countObjects( 0, 300, 0, "",&untrusted_sel),
            RelationalException);
        objects = folder->browseObjects( 0, 300, 0 );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "UserSel browse Objects size",
            (size_t)5, RecordSelect(untrusted_sel, objects )->size() );
        folder->setPrefetchAll(true);
        objects = folder->browseObjects( 0, 300, 0, "", &untrusted_sel );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "UserSel Objects size", 5u, objects->size() );
        folder->setPrefetchAll(false);
        objects = folder->browseObjects( 0, 300, 0 ,"",&untrusted_sel);
        // can't query the size of the iterator for untrusted selections
        // if prefetching is disabled
        CPPUNIT_ASSERT_THROW( objects->size(), RelationalException );
      }
    }
    catch ( std::exception& e )
    {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_truncateIOV()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    try
    {
      folder->storeObject(  0,             10, dummyPayload( 0010 ), 0);
      folder->storeObject( 10, ValidityKeyMax, dummyPayload( 0520 ), 0);
      folder->storeObject(  3,             30, dummyPayload( 0330 ), 1);
      folder->storeObject( 30,          40000, dummyPayload( 2040 ), 1);
      folder->storeObject(  3,             30, dummyPayload( 0330 ), 2);
      folder->storeObject( 30,             40, dummyPayload( 2040 ), 2);
      folder->storeObject( 40, ValidityKeyMax, dummyPayload( 2040 ), 2);
      folder->storeObject(  0,          50000, dummyPayload( 2040 ), 3);
      folder->storeObject(  0, ValidityKeyMax, dummyPayload( 2040 ), 4);
      folder->storeObject(  0,             10, dummyPayload( 2040 ), 5);
      folder->storeObject(  0, ValidityKeyMax, dummyPayload( 2040 ), 6);
      folder->storeObject(  0,          80000, dummyPayload( 2040 ), 7);
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 Count ",
                                    2u, folder->countObjects(0,100,0));
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 Count ",
                                    2u, folder->countObjects(0,100,1));
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 Count ",
                                    3u, folder->countObjects(0,100,2));
      // test truncating of a single channel
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 Count ",
                                    1u, folder->countObjects(40,100,0));
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 IOV until ",
                                    ValidityKeyMax,
                                    folder->findObject(10,0)->until());
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 truncate ",
                                    1,folder->truncateObjectValidity( 35, 0));
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 Count ",
                                    0u, folder->countObjects(40,100,0));
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 IOV until ",
                                    (ValidityKey)35,
                                    folder->findObject(10,0)->until());
      // can't truncate this IOV again
      CPPUNIT_ASSERT_THROW( folder->truncateObjectValidity( 34, 0 ),
                            RelationalException );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 truncate ",
                                    0,
                                    folder->truncateObjectValidity( 45, 0 ) );
      // truncating of an IOV with until < ValidityKeyMax doesn't work
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 Count ",
                                    1u, folder->countObjects(40,100,1));
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 IOV until ",
                                    (ValidityKey)40000,
                                    folder->findObject(30,1)->until());
      CPPUNIT_ASSERT_THROW( folder->truncateObjectValidity( 35, 1),
                            RelationalException );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 Count ",
                                    1u, folder->countObjects(40,100,1));
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 IOV until ",
                                    (ValidityKey)40000,
                                    folder->findObject(30,1)->until());
      // truncating of an IOV with until < ValidityKeyMax doesn't work
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 IOV until ",
                                    (ValidityKey)40,
                                    folder->findObject(30,2)->until());
      CPPUNIT_ASSERT_THROW( folder->truncateObjectValidity( 35, 1),
                            RelationalException );
      // check that nothing has changed
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "5 IOV until ",
                                    (ValidityKey)40,
                                    folder->findObject(30,2)->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "6 IOV until ",
                                    ValidityKeyMax,
                                    folder->findObject(40,2)->until() );
      // but truncating [40, ValidityKeyMax[ works
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 truncate",
                                    1,
                                    folder->truncateObjectValidity( 45, 2) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "7 IOV until ",
                                    (ValidityKey)45,
                                    folder->findObject(40,2)->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "8 IOV until ",
                                    (ValidityKey)40,
                                    folder->findObject(30,2)->until() );
      // truncate more channels at once
      CPPUNIT_ASSERT_EQUAL_MESSAGE("10 IOV until ",
                                   (ValidityKey) 50000,
                                   folder->findObject( 80, 3)->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("9 IOV until ",
                                   ValidityKeyMax,
                                   folder->findObject( 80, 4)->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("10 IOV until ",
                                   (ValidityKey) 10,
                                   folder->findObject( 5, 5)->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("11 IOV until ",
                                   ValidityKeyMax,
                                   folder->findObject( 80, 6)->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("12 IOV until ",
                                   (ValidityKey)80000,
                                   folder->findObject( 80, 7)->until() );
      CPPUNIT_ASSERT_THROW( folder->truncateObjectValidity( 70,
                                                            ChannelSelection::all() ),
                            RelationalException );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("10 IOV until ",
                                   (ValidityKey) 50000,
                                   folder->findObject( 80, 3)->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("9 IOV until ",
                                   ValidityKeyMax,
                                   folder->findObject( 80, 4)->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("10 IOV until ",
                                   (ValidityKey) 10,
                                   folder->findObject( 5, 5)->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("11 IOV until ",
                                   ValidityKeyMax,
                                   folder->findObject( 80, 6)->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("12 IOV until ",
                                   (ValidityKey)80000,
                                   folder->findObject( 80, 7)->until() );
      ChannelSelection csel(4,6);
      CPPUNIT_ASSERT_EQUAL_MESSAGE("4 truncate",
                                   2,
                                   folder->truncateObjectValidity( 70,
                                                                   csel ) );
      CPPUNIT_ASSERT_THROW( folder->findObject( 80, 4), ObjectNotFound );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("13 IOV until ",
                                   (ValidityKey)70,
                                   folder->findObject( 50, 4)->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("14 IOV until ",
                                   (ValidityKey) 50000,
                                   folder->findObject( 50, 3)->until() );
      CPPUNIT_ASSERT_THROW( folder->findObject( 80, 4), ObjectNotFound );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("15 IOV until ",
                                   (ValidityKey)70,
                                   folder->findObject( 50, 4)->until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("16 IOV until ",
                                   (ValidityKey)80000,
                                   folder->findObject( 50, 7)->until() );
      // multi version folders are not allowed
      IFolderPtr folderM = s_db->getFolder( "/fMV" );
      folderM->storeObject(  0,             10, dummyPayload( 0010 ), 0);
      folderM->storeObject( 10, ValidityKeyMax, dummyPayload( 0520 ), 0);
      CPPUNIT_ASSERT_THROW( folderM->truncateObjectValidity(30,0),
                            RelationalException );
    }
    catch ( std::exception& e )
    {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
  }

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  /// Test retrieving short and long CLOB (bug #51429 and bug #57722).
  void test_clobOptimization()
  {
    //ScopedRecreateFolders theCleaner( this ); // not needed
    coral::MsgLevel oldLevel = coral::MessageStream::msgVerbosity();
    coral::MsgLevel newLevel = oldLevel;
    //newLevel = coral::Verbose; // for debugging...
    RecordSpecification spec;
    spec.extend( "I", cool_StorageType_TypeId::Int32 );
    spec.extend( "CLOB", cool_StorageType_TypeId::String64k ); // CLOB
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, spec );
    IFolderPtr f = s_db->createFolder( "/f", fSpec );
    CPPUNIT_ASSERT( s_db->existsFolder( "/f" ) );
    Record payload( spec );
    std::string clob1 = "A short CLOB";
    payload["I"].setValue<Int32>( 1 );
    payload["CLOB"].setValue<String64k>( clob1 );
    f->storeObject( 0, 2, payload, 0 );
    std::stringstream c;
    for ( int i = 0; i<100; i++ )
      c << "12345678901234567890123456789012345678901234567890";  // 50 chars
    std::string clob2 = c.str();
    size_t clob2Size = clob2.size();
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "Long CLOB size stored",
                                  (size_t)5000, clob2Size );
    payload["I"].setValue<Int32>( 2 );
    payload["CLOB"].setValue<String64k>( clob2 );
    f->storeObject( 2, 4, payload, 0 );
    try
    {
      coral::MessageStream::setMsgVerbosity( newLevel );
      IObjectPtr obj = f->findObject( 1, 0 );
      CPPUNIT_ASSERT( obj.get() != 0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "Short CLOB size retrieved",
                                    clob1.size(),
                                    obj->payloadValue( "CLOB" ).size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "Short CLOB value retrieved",
                                    clob1, obj->payloadValue( "CLOB" ) );
      obj = f->findObject( 3, 0 );
      CPPUNIT_ASSERT( obj.get() != 0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "Long CLOB size retrieved",
                                    clob2.size(),
                                    obj->payloadValue( "CLOB" ).size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "Long CLOB value retrieved",
                                    clob2, obj->payloadValue( "CLOB" ) );
      coral::MessageStream::setMsgVerbosity( oldLevel );
    }
    catch(...)
    {
      coral::MessageStream::setMsgVerbosity( oldLevel );
      throw;
    }
  }

  /// NB: INVOLVES DDL (SCHEMA MODIFICATIONS) DURING THE TEST.
  /// Test retrieving short CLOB with a long payload name (bug #64710).
  void test_clobShortWithLongName_bug64710()
  {
    ScopedRecreateFolders theCleaner( this );
    std::string clobName = "CLOBshort_but_with_long_name";
    coral::MsgLevel oldLevel = coral::MessageStream::msgVerbosity();
    coral::MsgLevel newLevel = oldLevel;
    //newLevel = coral::Verbose; // for debugging...
    // Reference test should not fail (string SQL type)
    try
    {
      RecordSpecification spec;
      spec.extend( "I", cool_StorageType_TypeId::Int32 );
      spec.extend( clobName, cool_StorageType_TypeId::String4k ); // String
      FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, spec );
      IFolderPtr f = s_db->createFolder( "/f1", fSpec );
      CPPUNIT_ASSERT( s_db->existsFolder( "/f1" ) );
      Record payload( spec );
      payload["I"].setValue<Int32>( 1 );
      payload[clobName].setValue<String4k>( "A short string" );
      f->storeObject( 0, 2, payload, 0 );
      coral::MessageStream::setMsgVerbosity( newLevel );
      IObjectPtr obj = f->findObject( 1, 0 );
      coral::MessageStream::setMsgVerbosity( oldLevel );
      CPPUNIT_ASSERT( obj.get() != 0 );
    }
    catch(...)
    {
      coral::MessageStream::setMsgVerbosity( oldLevel );
      throw;
    }
    // Test for the bug may fail (CLOB type)
    try
    {
      RecordSpecification spec;
      spec.extend( "I", cool_StorageType_TypeId::Int32 );
      spec.extend( clobName, cool_StorageType_TypeId::String64k ); // CLOB
      FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, spec );
      IFolderPtr f = s_db->createFolder( "/f2", fSpec );
      CPPUNIT_ASSERT( s_db->existsFolder( "/f2" ) );
      Record payload( spec );
      payload["I"].setValue<Int32>( 1 );
      payload[clobName].setValue<String64k>( "A short string" );
      f->storeObject( 0, 2, payload, 0 );
      coral::MessageStream::setMsgVerbosity( newLevel );
      IObjectPtr obj = f->findObject( 1, 0 );
      coral::MessageStream::setMsgVerbosity( oldLevel );
      CPPUNIT_ASSERT( obj.get() != 0 );
    }
    catch(...)
    {
      coral::MessageStream::setMsgVerbosity( oldLevel );
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  // Constructor (executed N times, _before_ all N test executions)
  RelationalFolderTest() : CoolDBUnitTest(), payloadSpec()
  {
    payloadSpec.extend( "I", cool_StorageType_TypeId::Int32 );
    payloadSpec.extend( "S", cool_StorageType_TypeId::String4k );
    payloadSpec.extend( "X", cool_StorageType_TypeId::Float );
  }

  // Destructor (executed N times, _after_ all N test executions)
  ~RelationalFolderTest()
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

  /// Creates a dummy payload AttributeList for a given index
  Record dummyPayload( int index )
  {
    Record payload( payloadSpec );
    payload["I"].setValue<Int32>( index );
    std::stringstream s;
    s << "Object " << index;
    payload["S"].setValue<String4k>( s.str() );
    payload["X"].setValue<Float>( (float)(index/1000.) );
    return payload;
  }

  // Create all folders (overloads virtual base method)
  void createFolders()
  {
    // Create the SV folder
    FolderSpecification fSpecS( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    s_db->createFolder( "/fSV", fSpecS, "SV folder" );
    // Create the MV folder
    FolderSpecification fSpecM( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec );
    s_db->createFolder( "/fMV", fSpecM, "MV folder" );
    // Create the MV folder with payload table
#ifdef COOL290VP
    FolderSpecification fmSp( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec, cool_PayloadMode_Mode::SEPARATEPAYLOAD );
#else
    FolderSpecification fmSp( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec, true );
#endif
    s_db->createFolder( "/fMVp", fmSp, "MV folder with payload table" );
    // Create the MV folder with vector payload
#ifdef COOL290VP
    FolderSpecification fmSv( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec, cool_PayloadMode_Mode::VECTORPAYLOAD );
#else
    FolderSpecification fmSv( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec, true );
#endif
    s_db->createFolder( "/fMVv", fmSv, "MV folder with vector payload" );
  }

  std::string payloadMode2Folder( PayloadMode::Mode pMode )
  {
    if ( pMode == cool_PayloadMode_Mode::INLINEPAYLOAD )
      return "/fMV";
    else if ( pMode == cool_PayloadMode_Mode::SEPARATEPAYLOAD )
      return "/fMVp";
    else if ( pMode == cool_PayloadMode_Mode::VECTORPAYLOAD )
      return "/fMVv";
    return "";
  }

};

CPPUNIT_TEST_SUITE_REGISTRATION( cool::RelationalFolderTest );

COOLTEST_MAIN( RelationalFolderTest )
