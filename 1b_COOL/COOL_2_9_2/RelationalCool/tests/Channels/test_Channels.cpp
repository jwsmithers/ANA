// $Id: test_Channels.cpp,v 1.15 2013-03-08 11:44:43 avalassi Exp $

// Include files
#include <string>
#include <vector>
#include "CoolKernel/ChannelSelection.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/IField.h"
#include "CoolKernel/IFolder.h"
#include "CoolKernel/IObject.h"
#include "CoolKernel/IObjectIterator.h"
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordException.h"
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
#include "src/RalDatabase.h"
#include "src/RalDatabaseSvc.h"
#include "src/RelationalChannelTable.h"
#include "src/RelationalException.h"
#include "src/RelationalFolder.h"
#include "src/RelationalTableRow.h"
#include "src/RelationalTransaction.h"
#include "src/timeToString.h"

// Forward declaration (for easier indentation)
namespace cool
{
  class ChannelsTest;
}

// The test class
class cool::ChannelsTest : public cool::CoolDBUnitTest
{

private:

  CPPUNIT_TEST_SUITE( ChannelsTest );
  CPPUNIT_TEST( test_listChannels );
  CPPUNIT_TEST( test_listChannels_order );
  CPPUNIT_TEST( test_listChannelsWithNames );
  CPPUNIT_TEST( test_createChannel );
  CPPUNIT_TEST( test_dropChannel );
  CPPUNIT_TEST( test_dropChannel_exceptionSV );
  CPPUNIT_TEST( test_dropChannel_exceptionMV );
  CPPUNIT_TEST( test_existsChannel );
  CPPUNIT_TEST( test_channelId );
  CPPUNIT_TEST( test_channelName_exception );
  CPPUNIT_TEST( test_channelDescription_exception );
  CPPUNIT_TEST( test_channelId_exception );
  CPPUNIT_TEST( test_setChannelName );
  CPPUNIT_TEST( test_setChannelDescription );
  CPPUNIT_TEST( test_channelNameUnique );
  CPPUNIT_TEST( test_setChannelName_sameName );
  CPPUNIT_TEST( test_existsChannelSV_withoutCreateChannel );
  CPPUNIT_TEST( test_existsChannelMV_withoutCreateChannel );
  CPPUNIT_TEST( test_setChannelNameSV_withoutCreateChannel );
  CPPUNIT_TEST( test_setChannelNameMV_withoutCreateChannel );
  CPPUNIT_TEST( test_setChannelDescSV_withoutCreateChannel );
  CPPUNIT_TEST( test_setChannelDescMV_withoutCreateChannel );
  CPPUNIT_TEST( test_channelNameSV_withoutCreateChannel );
  CPPUNIT_TEST( test_channelNameMV_withoutCreateChannel );
  CPPUNIT_TEST( test_channelDescSV_withoutCreateChannel );
  CPPUNIT_TEST( test_channelDescMV_withoutCreateChannel );
  CPPUNIT_TEST( test_existsChannelSV_withCreateChannel_withoutIOVs );
  CPPUNIT_TEST( test_existsChannelMV_withCreateChannel_withoutIOVs );
  CPPUNIT_TEST( test_listChannelsSV_withoutCreateChannel );
  CPPUNIT_TEST( test_listChannelsMV_withoutCreateChannel );
  CPPUNIT_TEST( test_listChannelsSV_withCreateChannel_withoutIOVs );
  CPPUNIT_TEST( test_listChannelsMV_withCreateChannel_withoutIOVs );
  CPPUNIT_TEST( test_listChannelsSV_withAndWithoutCreateChannel );
  CPPUNIT_TEST( test_listChannelsMV_withAndWithoutCreateChannel );
  CPPUNIT_TEST_SUITE_END();

public:

  /// Tests setChannelDescription()
  void test_setChannelDescription()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->createChannel( 1, "ch 1", "desc 1" );
    CPPUNIT_ASSERT_EQUAL( std::string("desc 1"),
                          folder->channelDescription( 1 ) );
    folder->setChannelDescription( 1, "new desc" );
    CPPUNIT_ASSERT_EQUAL( std::string("new desc"),
                          folder->channelDescription( 1 ) );
    try {
      folder->setChannelDescription( 2, "new desc" );
      CPPUNIT_FAIL( "ChannelNotFound exception expected" );
    } catch ( ChannelNotFound& ) {}
  }

  /// Tests setChannelName()
  void test_setChannelName()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->createChannel( 1, "ch 1", "desc 1" );
    CPPUNIT_ASSERT_EQUAL( std::string("ch 1"),
                          folder->channelName( 1 ) );
    folder->setChannelName( 1, "new name 1" );
    CPPUNIT_ASSERT_EQUAL( std::string("new name 1"),
                          folder->channelName( 1 ) );
    try {
      folder->setChannelName( 2, "new name 2" );
      CPPUNIT_FAIL( "ChannelNotFound exception expected" );
    } catch ( ChannelNotFound& ) {}
    folder->createChannel( 2, "ch 2", "desc 2" );
    CPPUNIT_ASSERT_EQUAL( std::string("ch 2"),
                          folder->channelName( 2 ) );
    try {
      folder->setChannelName( 2, "new name 1" );
      CPPUNIT_FAIL( "ChannelExists exception expected" );
    } catch ( ChannelExists& ) {}
  }

  /// Tests setChannelName() with the same name (bug #23754)
  void test_setChannelName_sameName()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->createChannel( 1, "ch 1", "desc 1" );
    CPPUNIT_ASSERT_EQUAL( std::string("ch 1"),
                          folder->channelName( 1 ) );
    folder->setChannelName( 1, "ch 1" );
    CPPUNIT_ASSERT_EQUAL( std::string("ch 1"),
                          folder->channelName( 1 ) );
  }

  /// Tests existsChannel() for SV folders if createChannel was not called
  void test_existsChannelSV_withoutCreateChannel()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    Record payload( payloadSpec );
    ChannelId chId = 1;
    folder->storeObject( 0, 10, payload, chId );
    CPPUNIT_ASSERT_EQUAL
      ( true, folder->existsChannel( chId ) );
  }

  /// Tests existsChannel() for MV folders if createChannel was not called
  /// (bug #24449 - also related to bug #23755)
  void test_existsChannelMV_withoutCreateChannel()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    Record payload( payloadSpec );
    ChannelId chId = 1;
    folder->storeObject( 0, 10, payload, chId );
    CPPUNIT_ASSERT_EQUAL
      ( true, folder->existsChannel( chId ) );
  }

  /// Tests existsChannel() for SV folders if createChannel was called
  /// but there are no IOVs
  void test_existsChannelSV_withCreateChannel_withoutIOVs()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    Record payload( payloadSpec );
    ChannelId chId = 1;
    //folder->storeObject( 0, 10, payload, chId );
    folder->createChannel( chId, "MyChannel", " A channel" );
    CPPUNIT_ASSERT_EQUAL
      ( true, folder->existsChannel( chId ) );
  }

  /// Tests existsChannel() for MV folders if createChannel was called
  /// but there are no IOVs (bug #30431 - also related to bug #23755)
  void test_existsChannelMV_withCreateChannel_withoutIOVs()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    Record payload( payloadSpec );
    ChannelId chId = 1;
    //folder->storeObject( 0, 10, payload, chId );
    folder->createChannel( chId, "MyChannel", "A channel" );
    CPPUNIT_ASSERT_EQUAL
      ( true, folder->existsChannel( chId ) );
  }

  /// Tests listChannels() for SV folders if createChannel was not called
  void test_listChannelsSV_withoutCreateChannel()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    Record payload( payloadSpec );
    ChannelId chId = 1;
    folder->storeObject( 0, 10, payload, chId );
    //folder->createChannel( chId, "MyChannel", " A channel" );
    std::vector<ChannelId> channels = folder->listChannels();
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "channel count", 1u, (unsigned int)channels.size() );
  }

  /// Tests listChannels() for MV folders if createChannel was not called
  void test_listChannelsMV_withoutCreateChannel()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    Record payload( payloadSpec );
    ChannelId chId = 1;
    folder->storeObject( 0, 10, payload, chId );
    //folder->createChannel( chId, "MyChannel", "A channel" );
    std::vector<ChannelId> channels = folder->listChannels();
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "channel count", 1u, (unsigned int)channels.size() );
  }

  /// Tests listChannels() for SV folders if createChannel was called
  /// but there are no IOVs
  void test_listChannelsSV_withCreateChannel_withoutIOVs()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    Record payload( payloadSpec );
    ChannelId chId = 1;
    //folder->storeObject( 0, 10, payload, chId );
    folder->createChannel( chId, "MyChannel", " A channel" );
    std::vector<ChannelId> channels = folder->listChannels();
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "channel count", 1u, (unsigned int)channels.size() );
  }

  /// Tests listChannels() for MV folders if createChannel was called
  /// but there are no IOVs (bug #30443)
  void test_listChannelsMV_withCreateChannel_withoutIOVs()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    Record payload( payloadSpec );
    ChannelId chId = 1;
    //folder->storeObject( 0, 10, payload, chId );
    folder->createChannel( chId, "MyChannel", "A channel" );
    std::vector<ChannelId> channels = folder->listChannels();
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "channel count", 1u, (unsigned int)channels.size() );
  }

  /// Tests listChannels() for SV folders in a complex case
  void test_listChannelsSV_withAndWithoutCreateChannel()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    Record payload( payloadSpec );
    ChannelId chId1 = 1;
    folder->storeObject( 0, 10, payload, chId1 );
    ChannelId chId2 = 2;
    folder->createChannel( chId2, "MyChannel", " A channel" );
    std::vector<ChannelId> channels = folder->listChannels();
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "channel count", 2u, (unsigned int)channels.size() );
  }

  /// Tests listChannels() for MV folders in a complex case
  /// This is also affected by bug #30443 in COOL221
  void test_listChannelsMV_withAndWithoutCreateChannel()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    Record payload( payloadSpec );
    ChannelId chId1 = 1;
    folder->storeObject( 0, 10, payload, chId1 );
    ChannelId chId2 = 2;
    folder->createChannel( chId2, "MyChannel", "A channel" );
    std::vector<ChannelId> channels = folder->listChannels();
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "channel count", 2u, (unsigned int)channels.size() );
  }

  /// Tests setChannelName() for SV folders if createChannel was not called
  void test_setChannelNameSV_withoutCreateChannel()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    Record payload( payloadSpec );
    ChannelId chId = 1;
    folder->storeObject( 0, 10, payload, chId );
    folder->setChannelName( chId, "ch 1" );
    CPPUNIT_ASSERT_EQUAL( std::string("ch 1"), folder->channelName( chId ) );
  }

  /// Tests setChannelName() for MV folders if createChannel was not called
  /// (bug #24445 - also related to bug #23755)
  void test_setChannelNameMV_withoutCreateChannel()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    Record payload( payloadSpec );
    ChannelId chId = 1;
    folder->storeObject( 0, 10, payload, chId );
    folder->setChannelName( chId, "ch 1" );
    CPPUNIT_ASSERT_EQUAL( std::string("ch 1"), folder->channelName( chId ) );
  }

  /// Tests setChannelDescription() for SV if createChannel was not called
  void test_setChannelDescSV_withoutCreateChannel()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    Record payload( payloadSpec );
    ChannelId chId = 1;
    folder->storeObject( 0, 10, payload, chId );
    folder->setChannelDescription( chId, "ch 1 desc" );
    CPPUNIT_ASSERT_EQUAL
      ( std::string("ch 1 desc"), folder->channelDescription( chId ) );
  }

  /// Tests setChannelDescription() for MV if createChannel was not called
  /// (bug #244461 - also related to bug #23755)
  void test_setChannelDescMV_withoutCreateChannel()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    Record payload( payloadSpec );
    ChannelId chId = 1;
    folder->storeObject( 0, 10, payload, chId );
    folder->setChannelDescription( chId, "ch 1 desc" );
    CPPUNIT_ASSERT_EQUAL
      ( std::string("ch 1 desc"), folder->channelDescription( chId ) );
  }

  /// Tests channelName() for MV folders if createChannel was not called
  void test_channelNameSV_withoutCreateChannel()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    Record payload( payloadSpec );
    ChannelId chId = 1;
    folder->storeObject( 0, 10, payload, chId );
    CPPUNIT_ASSERT_EQUAL
      ( std::string(""), folder->channelName( chId ) );
  }

  /// Tests channelName() for MV folders if createChannel was not called
  /// (bug #24463 - also related to bug #23755)
  void test_channelNameMV_withoutCreateChannel()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    Record payload( payloadSpec );
    ChannelId chId = 1;
    folder->storeObject( 0, 10, payload, chId );
    CPPUNIT_ASSERT_EQUAL
      ( std::string(""), folder->channelName( chId ) );
  }

  /// Tests channelDesc() for SV folders if createChannel was not called
  void test_channelDescSV_withoutCreateChannel()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    Record payload( payloadSpec );
    ChannelId chId = 1;
    folder->storeObject( 0, 10, payload, chId );
    CPPUNIT_ASSERT_EQUAL
      ( std::string(""), folder->channelDescription( chId ) );
  }

  /// Tests channelDesc() for MV folders if createChannel was not called
  /// (bug #24463 - also related to bug #23755)
  void test_channelDescMV_withoutCreateChannel()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    Record payload( payloadSpec );
    ChannelId chId = 1;
    folder->storeObject( 0, 10, payload, chId );
    CPPUNIT_ASSERT_EQUAL
      ( std::string(""), folder->channelDescription( chId ) );
  }

  /// Tests channelId() exceptional behavior
  void test_channelId_exception()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    CPPUNIT_ASSERT_THROW( folder->channelId( "unknown channel" ),
                          ChannelNotFound );
  }

  /// Tests channelDescription() exceptional behavior
  void test_channelDescription_exception()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    CPPUNIT_ASSERT_THROW( folder->channelDescription( 1 ),
                          ChannelNotFound );
  }

  /// Tests channelName() exceptional behavior
  void test_channelName_exception()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    CPPUNIT_ASSERT_THROW( folder->channelName( 1 ),
                          ChannelNotFound );
  }

  /// Tests channelId( channelName )
  void test_channelId()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->createChannel( 1, "ch 1", "desc 1" );
    folder->createChannel( 2, "ch 2", "desc 2" );
    folder->createChannel( 3, "ch 3", "desc 3" );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)2,
                          folder->channelId( "ch 2" ) );
  }

  /// Tests existsChannel()
  void test_existsChannel()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->createChannel( 1, "ch 1", "desc 1" );
    CPPUNIT_ASSERT( folder->existsChannel( 1 ) );
    CPPUNIT_ASSERT( ! folder->existsChannel( 2 ) );
    CPPUNIT_ASSERT( folder->existsChannel( "ch 1" ) );
    CPPUNIT_ASSERT( ! folder->existsChannel( "ch 2" ) );
  }

  /// Tests UK on channel name and channel id in createChannel()
  void test_channelNameUnique()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    std::string name0 = "";
    std::string name1 = "my channel 1";
    std::string name2 = "my channel 2";
    std::string name3 = "my channel 3";
    std::string desc = "my description";
    folder->createChannel( 0, name0, desc );
    CPPUNIT_ASSERT_EQUAL( name0, folder->channelName( 0 ) );
    CPPUNIT_ASSERT_EQUAL( desc, folder->channelDescription( 0 ) );
    folder->createChannel( 1, name1, desc );
    CPPUNIT_ASSERT_EQUAL( name1, folder->channelName( 1 ) );
    CPPUNIT_ASSERT_EQUAL( desc, folder->channelDescription( 1 ) );
    folder->createChannel( 2, name2, desc );
    CPPUNIT_ASSERT_EQUAL( name2, folder->channelName( 2 ) );
    CPPUNIT_ASSERT_EQUAL( desc, folder->channelDescription( 2 ) );
    try
    {
      //std::cout << std::endl;
      folder->createChannel( 0, name3, desc );
      CPPUNIT_FAIL( "Creating channel with duplicate id=0 should fail" );
    }
    catch ( ChannelExists& ) {}
    try {
      folder->createChannel( 3, name0, desc );
      CPPUNIT_ASSERT_EQUAL( name0, folder->channelName( 3 ) );
      CPPUNIT_ASSERT_EQUAL( desc, folder->channelDescription( 3 ) );
    }
    catch ( std::exception& e ) {
      std::cout << "ERROR! Exception caught: '"
                << e.what() << "'" << std::endl;
      throw;
    }
    try {
      folder->createChannel( 4, name1, desc );
      CPPUNIT_FAIL
        ( "Creating channel with duplicate name=" + name1 + " should fail" );
    }
    catch ( ChannelExists& ) {
    }
    try {
      folder->setChannelName( 1, name2 );
      CPPUNIT_FAIL
        ( "Setting channel duplicate name=" + name1 + " should fail" );
    }
    catch ( ChannelExists& ) {
    }
    CPPUNIT_ASSERT_EQUAL( (ChannelId)1, folder->channelId( name1 ) );
  }

  /// Tests createChannel(), channelName(), and channelDescription()
  void test_createChannel()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->createChannel( 1, "ch 1", "desc 1" );
    CPPUNIT_ASSERT_EQUAL( std::string("ch 1"),
                          folder->channelName( 1 ) );
    CPPUNIT_ASSERT_EQUAL( std::string("desc 1"),
                          folder->channelDescription( 1 ) );
  }

  /// Tests dropChannel()
  void test_dropChannel()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->createChannel( 1, "ch 1", "desc 1" );
    CPPUNIT_ASSERT_EQUAL( true, folder->existsChannel( 1 ) );
    folder->dropChannel( 1 );
    CPPUNIT_ASSERT_EQUAL( false, folder->existsChannel( 1 ) );
  }

  /// Tests dropChannel() with an exception (SV IOVs)
  void test_dropChannel_exceptionSV()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    Record payload( payloadSpec );
    folder->storeObject( 0, 1, payload, 1 );
    CPPUNIT_ASSERT_EQUAL( true, folder->existsChannel( 1 ) );
    try
    {
      folder->dropChannel( 1 );
      CPPUNIT_FAIL( "exception expected" );
    }
    catch ( RelationalException& ) {}
    CPPUNIT_ASSERT_EQUAL( true, folder->existsChannel( 1 ) );
  }

  /// Tests dropChannel() with an exception (MV IOVs)
  void test_dropChannel_exceptionMV()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    Record payload( payloadSpec );
    folder->storeObject( 0, 1, payload, 1 );
    CPPUNIT_ASSERT_EQUAL( true, folder->existsChannel( 1 ) );
    try
    {
      folder->dropChannel( 1 );
      CPPUNIT_FAIL( "exception expected" );
    }
    catch ( RelationalException& ) {}
    CPPUNIT_ASSERT_EQUAL( true, folder->existsChannel( 1 ) );
  }

  /// Tests listChannels (SingleVersion only, MultiVersion test in
  /// test_RalDatabase)
  void test_listChannels()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    ChannelId channel = 1;
    folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), channel );
    channel = 3;
    folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), channel );
    channel = 5;
    folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), channel );
    std::vector<ChannelId> channels = folder->listChannels();
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "channel count", 3u, (unsigned int)channels.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 1", (ChannelId)1, channels[0] );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 2", (ChannelId)3, channels[1] );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 3", (ChannelId)5, channels[2] );
    // check exceptional behavior
    IFolderPtr folder2 = s_db->getFolder( "/fMV" );
    // a folder without data has no channels
    channels = folder2->listChannels();
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "channel list size", 0u, (unsigned int)channels.size() );
  }

  /// Test the odering of the list of channels when the highest bit is set.
  /// Used to fail for SQLite with bug #15128 and later bug #24103.
  void test_listChannels_order()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    ChannelId channel = 1;
    folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), channel );
    channel = 2147483648u;
    folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), channel );
    //MSG::Level outLvl = application().outputLevel();
    //application().setOutputLevel( MSG::VERBOSE );
    std::vector<ChannelId> channels = folder->listChannels();
    //application().setOutputLevel( outLvl );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "channel list size", 2u, (unsigned int)channels.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "channel 1", (ChannelId)1, channels[0] );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "channel 2147483648", (ChannelId)2147483648u, channels[1] );
  }

  /// Tests listChannelsWithNames
  void test_listChannelsWithNames()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    ChannelId channel = 1;
    folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), channel );
    channel = 3;
    folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), channel );
    channel = 5;
    folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), channel );
    folder->setChannelName( 3, "channel 3" );
    folder->setChannelName( 5, "channel 5" );
    std::map<ChannelId,std::string> channelsWithNames =
      folder->listChannelsWithNames();
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "channel count", 3u, (unsigned int)channelsWithNames.size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "channel 1", std::string(""), channelsWithNames[1] );
    CPPUNIT_ASSERT_MESSAGE
      ( "channel 2", channelsWithNames.find(2) == channelsWithNames.end() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "channel 3", std::string("channel 3"), channelsWithNames[3] );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "channel 5", std::string("channel 5"), channelsWithNames[5] );
    // check exceptional behavior
    IFolderPtr folder2 = s_db->getFolder( "/fMV" );
    // a folder without data has no channels
    channelsWithNames = folder2->listChannelsWithNames();
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "channel list size", 0u, (unsigned int)channelsWithNames.size() );
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  // Constructor (executed N times, _before_ all N test executions)
  ChannelsTest() : CoolDBUnitTest(), payloadSpec()
  {
    payloadSpec.extend("I",StorageType::Int32);
    payloadSpec.extend("S",StorageType::String255);
    payloadSpec.extend("X",StorageType::Float);
  }

  // Destructor (executed N times, _after_ all N test executions)
  ~ChannelsTest()
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

  // Create all folders
  void createFolders()
  {
#ifdef COOL290CO
    // Create the SV folder
    s_db->createFolder( "/fSV", FolderSpecification( FolderVersioning::SINGLE_VERSION, payloadSpec ), "SV folder" );
    // Create the MV folder
    s_db->createFolder( "/fMV", FolderSpecification( FolderVersioning::MULTI_VERSION, payloadSpec ), "MV folder" );
#else
    // Create the SV folder
    s_db->createFolder( "/fSV", payloadSpec, "SV folder",
                        FolderVersioning::SINGLE_VERSION );
    // Create the MV folder
    s_db->createFolder( "/fMV", payloadSpec, "MV folder",
                        FolderVersioning::MULTI_VERSION );
#endif
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

CPPUNIT_TEST_SUITE_REGISTRATION( cool::ChannelsTest );

COOLTEST_MAIN( ChannelsTest )
