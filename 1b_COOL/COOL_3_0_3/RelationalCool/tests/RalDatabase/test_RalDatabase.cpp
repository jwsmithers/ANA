// First of all, enable or disable the COOL290 API extensions (bug #92204)
#include "CoolKernel/VersionInfo.h"

// Include files
#include <string>
#include <sstream>
#include <vector>
#include "CoolKernel/IField.h"
#include "CoolKernel/IFolder.h"
#include "CoolKernel/InternalErrorException.h"
#include "CoolKernel/IObject.h"
#include "CoolKernel/IObjectIterator.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/ChannelSelection.h"
#include "CoolKernel/RecordException.h"
#include "CoolKernel/RecordSpecification.h"
#include "RelationalAccess/IConnectionService.h"
#include "RelationalAccess/IConnectionServiceConfiguration.h"
#include "RelationalAccess/IRelationalService.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ITable.h"
#include "RelationalAccess/ITableDataEditor.h"
#include "RelationalAccess/ITransaction.h"

// Local include files
//#define COOLUNITTESTTIMER 1
//#define COOLDBUNITTESTDEBUG 1
#include "tests/Common/CoolDBUnitTest.h"
#include "src/CoralApplication.h"
#include "src/HvsPathHandlerException.h"
#include "src/RalDatabase.h"
#include "src/RalDatabaseSvc.h"
#include "src/RalSessionMgr.h"
#include "src/RelationalDatabaseId.h"
#include "src/RelationalException.h"
#include "src/RelationalFolder.h"
#include "src/RelationalFolderUnsupported.h"
#include "src/RelationalFolderSet.h"
#include "src/RelationalFolderSetUnsupported.h"
#include "src/RelationalObject.h"
#include "src/RelationalObjectTable.h"
#include "src/RelationalObjectTableRow.h"
#include "src/RelationalNodeTable.h"
#include "src/RelationalSequence.h"
#include "src/RelationalSequenceMgr.h"
#include "src/RelationalTagMgr.h"
#include "src/RelationalTransaction.h"
#include "src/RelationalDatabaseTable.h"
#include "src/TransRelFolder.h"
#include "src/VersionInfo.h"
#include "src/timeToString.h"

// Forward declaration (for easier indentation)
namespace cool
{
  class RalDatabaseTest;
}

// The test class
class cool::RalDatabaseTest : public cool::CoolDBUnitTest
{

private:

  CPPUNIT_TEST_SUITE( RalDatabaseTest );
  CPPUNIT_TEST( test_createDatabase );
  CPPUNIT_TEST( test_openDatabase_rw );
  CPPUNIT_TEST( test_openDatabase_ro );
  CPPUNIT_TEST( test_dbNameLength );
  CPPUNIT_TEST( test_dbNameUppercase );
  CPPUNIT_TEST( test_dbNameLettersAndNumbers );
  CPPUNIT_TEST( test_dbNameStartsWithLetter );
  CPPUNIT_TEST( test_listAllNodes );
  CPPUNIT_TEST( test_listAllTables );
  CPPUNIT_TEST( test_fetchRootNodeTableRow );
  CPPUNIT_TEST( test_insertNodeTableRow );
  CPPUNIT_TEST( test_fetchNodeTableRow );
  CPPUNIT_TEST( test_fetchNodeTableRow_nestedScope );
  CPPUNIT_TEST( test_insertNodeTableRow_nonleaf );
  CPPUNIT_TEST( test_insertNodeTableRow_leaf );
  CPPUNIT_TEST( test_dropNode );
  CPPUNIT_TEST( test_dropAllNodes );
  CPPUNIT_TEST( test_dropDatabase );
  CPPUNIT_TEST( test_existsFolder );
  CPPUNIT_TEST( test_existsFolderSet );
  CPPUNIT_TEST( test_existsNode );
  CPPUNIT_TEST( test_createFolderSet );
  CPPUNIT_TEST( test_createFolderSet_alreadyExists );
  CPPUNIT_TEST( test_createFolder_SV );
  CPPUNIT_TEST( test_createFolder_MV );
  CPPUNIT_TEST( test_createFolder_MV_sepPayload );
  CPPUNIT_TEST( test_createFolder_MV_vector );
  CPPUNIT_TEST( test_createFolder_invalidVersioningMode );
  CPPUNIT_TEST( test_createFolder_withParents );
  CPPUNIT_TEST( test_createFolder_alreadyExists );
  CPPUNIT_TEST( test_createFolder_invalidName );
  CPPUNIT_TEST( test_createFolderSet_invalidName );
  CPPUNIT_TEST( test_getFolder );
  CPPUNIT_TEST( test_getFolderSet );
  CPPUNIT_TEST( test_folderAttributes_MV );
  CPPUNIT_TEST( test_folderAttributes_SV );
  CPPUNIT_TEST( test_createFolder_description );
  CPPUNIT_TEST( test_createFolderSet_description );
  CPPUNIT_TEST( test_updateRows );
  CPPUNIT_TEST( test_release_0_1_0 );
  CPPUNIT_TEST( test_release_4_0_0 );
  CPPUNIT_TEST( test_allProdReleases );
  CPPUNIT_TEST( test_useFolder_2_0_0 );
  CPPUNIT_TEST( test_dropFolder_2_0_0 );
  CPPUNIT_TEST( test_dropDatabaseWithFolder_2_0_0 );
  CPPUNIT_TEST( test_listAllTablesWithFolder_2_0_0 );
  CPPUNIT_TEST( test_listAllTablesWithNode_1_9_9 );
  CPPUNIT_TEST( test_useNode_2_0_9 );
  CPPUNIT_TEST( test_dropNode_2_0_9 );
  CPPUNIT_TEST( test_dropDatabaseWithNode_2_0_9 );
  CPPUNIT_TEST( test_listAllTablesWithNode_2_0_9 );
  CPPUNIT_TEST( test_useNode_3_10_0 );
  CPPUNIT_TEST( test_dropNode_3_10_0 );
  CPPUNIT_TEST( test_dropDatabaseWithNode_3_10_0 );
  CPPUNIT_TEST( test_listAllTablesWithNode_3_10_0 );
  CPPUNIT_TEST( test_listChannels_SV );
  CPPUNIT_TEST( test_listChannels_MV );
  CPPUNIT_TEST( test_tagInsertionTime_SV );
  CPPUNIT_TEST( test_tagInsertionTime_MV );
  CPPUNIT_TEST( test_tagInsertionTime_MV_nonexist );
  CPPUNIT_TEST( test_tagDescription_SV );
  CPPUNIT_TEST( test_tagDescription_MV );
  CPPUNIT_TEST( test_tagDescription_MV_nonexist );
  CPPUNIT_TEST( test_updateNodeTableDescription );
  //CPPUNIT_TEST( test_openCursorIssue ); // takes too long to run
  CPPUNIT_TEST( test_closeDatabase );
  CPPUNIT_TEST( test_closeDatabase_exceptional_folder_behavior );
  CPPUNIT_TEST( test_closeDatabase_exceptional_folderset_behavior );
  CPPUNIT_TEST( test_closeDatabase_exceptional_database_behavior );
  CPPUNIT_TEST( test_nodeTable_lastModDate );
  CPPUNIT_TEST( test_openDatabase_ro_updateExceptionBug30500 );
#ifdef COOL400
  CPPUNIT_TEST( test_manualTransaction_commit );
  CPPUNIT_TEST( test_manualTransaction_rollback );
  CPPUNIT_TEST( test_manualTransaction_tag_rollback );
  CPPUNIT_TEST( test_manualTransaction_userTag_rollback );
  CPPUNIT_TEST( test_manualTransaction_createFolder );
  CPPUNIT_TEST( test_manualTransaction_createFolderSet );
#endif
  CPPUNIT_TEST_SUITE_END();

public:

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#ifdef COOL400
  // Tests manual transaction commit
  void test_manualTransaction_commit()
  {
    setupDb();
    { // create initial folder
      FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
      IFolderPtr folder = ralDb->createFolder( "/A1", fSpec );
      folder->storeObject(  0, 10, dummyPayload( 010), 0 );
      folder->storeObject( 10, 25, dummyPayload(1025), 0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "Count 1", 2u,
                                    folder->countObjects( 0, 100, 0));
      forceDisconnect();
    }
    { // re-open db
      bool readOnlyFlag = false;
      openDB(readOnlyFlag);
      ITransactionPtr t = s_db->startTransaction();
      IFolderPtr folder = s_db->getFolder("/A1");
      folder->storeObject( 25, 30, dummyPayload( 010), 0 );
      folder->storeObject( 30, 40, dummyPayload(1025), 0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "Count 2", 4u,
                                    folder->countObjects( 0, 100, 0) );
      t->commit();
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "Count 3", 4u,
                                    folder->countObjects( 0, 100, 0) );
      t->rollback();
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "Count 4", 4u,
                                    folder->countObjects( 0, 100, 0) );
    }
  }

  // Tests manual transaction rollback
  void test_manualTransaction_rollback()
  {
    setupDb();
    { // create initial folder
      FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
      IFolderPtr folder = ralDb->createFolder( "/A1", fSpec );
      folder->storeObject(  0, 10, dummyPayload( 010), 0 );
      folder->storeObject( 10, 25, dummyPayload(1025), 0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "Count 1", 2u,
                                    folder->countObjects( 0, 100, 0));
      forceDisconnect();
    }
    { // re-open db
      bool readOnlyFlag = false;
      openDB(readOnlyFlag);
      ITransactionPtr t = s_db->startTransaction();
      IFolderPtr folder = s_db->getFolder("/A1");
      folder->storeObject( 25, 30, dummyPayload( 010), 0 );
      folder->storeObject( 30, 40, dummyPayload(1025), 0 );
      t->rollback();
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "Count 2", 2u,
                                    folder->countObjects( 0, 100, 0) );
    }
  }

  // Test createFolder behavior in manual transaction mode
  void test_manualTransaction_createFolder() {
    setupDb();
    ITransactionPtr t = ralDb->startTransaction();
    try {
      FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
      ralDb->createFolder( "/A1", fSpec );
      CPPUNIT_FAIL("createFolder in manual transaction mode must fail");
    } catch ( RelationalException& e ) {
      std::string expected = "Cannot create folder in manual transaction mode";
      CPPUNIT_ASSERT_EQUAL_MESSAGE("exception caught",
                                   expected, std::string(e.what()));
    }
  }

  // Tests createFolderSet behavior in manual transaction mode
  void test_manualTransaction_createFolderSet() {
    setupDb();
    ITransactionPtr t = ralDb->startTransaction();
    try {
      ralDb->createFolderSet( "/A1" );
      CPPUNIT_FAIL("createFolderSet in manual transaction mode must fail");
    } catch ( RelationalException& e ) {
      std::string expected = "Cannot create folder set in manual "
        "transaction mode";
      CPPUNIT_ASSERT_EQUAL_MESSAGE("exception caught",
                                   expected, std::string(e.what()));
    }
  }

  // Tests tag rollback in manual transaction mode
  void test_manualTransaction_tag_rollback()
  {
    setupDb();
    { // create initial folder
      FolderSpecification fSpec( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec );
      IFolderPtr folder = ralDb->createFolder("/A1",fSpec, "");
      folder->storeObject(  0, 10, dummyPayload( 010), 0 );
      forceDisconnect();
    }
    { // re-open db with auto-transactions disabled
      bool readOnlyFlag = false;
      openDB(readOnlyFlag);
      ITransactionPtr t = s_db->startTransaction();
      IFolderPtr folder = s_db->getFolder("/A1");
      folder->tagCurrentHead("testTag");
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "tag exists ",
                                    true, s_db->existsTag("testTag"));
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "Count", 1u,
                                    folder->countObjects(0, 100,
                                                         0, "testTag"));
      t->rollback();
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "tag rolled back",
                                    false, s_db->existsTag("testTag") );
    }
  }

  // Tests user tag rollback in manual transaction mode
  void test_manualTransaction_userTag_rollback()
  {
    setupDb();
    { // create initial folder
      FolderSpecification fSpec( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec );
      IFolderPtr folder = ralDb->createFolder("/A1",fSpec,"");
      folder->storeObject(  0, 10, dummyPayload( 010), 0 );
      forceDisconnect();
    }
    { // re-open db with auto-transactions disabled
      bool readOnlyFlag = false;
      openDB(readOnlyFlag);
      ITransactionPtr t = s_db->startTransaction();
      IFolderPtr folder = s_db->getFolder("/A1");
      folder->storeObject( 35, 40, dummyPayload(2030), 0, "testTag" );
      CPPUNIT_ASSERT_EQUAL_MESSAGE("tag exists ",
                                   true, s_db->existsTag("testTag"));
      CPPUNIT_ASSERT_EQUAL_MESSAGE("Count", 1u,
                                   folder->countObjects(0, 100,
                                                        0, "testTag"));
      t->rollback();
      CPPUNIT_ASSERT_EQUAL_MESSAGE("tag rolled back",
                                   false, s_db->existsTag("testTag"));
    }
  }
#endif

  /// Tests the exception thrown when updating a readonly database (bug #30500)
  void test_openDatabase_ro_updateExceptionBug30500()
  {
    CoralApplication app;
    IDatabaseSvc& dbSvc = app.databaseService();
    dbSvc.dropDatabase( s_connectionString );
    IDatabasePtr db = dbSvc.createDatabase( s_connectionString );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    db->createFolder( "/a", fSpec );
    s_db =  dbSvc.openDatabase( s_connectionString );
    CPPUNIT_ASSERT( s_db.get() != 0 );
    CPPUNIT_ASSERT( s_db->isOpen() );
    try
    {
      s_db->createFolder( "/b", fSpec );
      CPPUNIT_FAIL( "createFolder must fail" );
    }
    catch ( DatabaseOpenInReadOnlyMode& ) {}
    //catch ( coral::InvalidOperationInReadOnlyModeException& ) {}
    catch ( std::exception& e )
    {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
    try
    {
      Record dummyRec( payloadSpec );
      IFolderPtr folder = s_db->getFolder( "/a" );
      folder->storeObject( 0, 10, dummyRec, 0 );
      CPPUNIT_FAIL( "storeObject must fail" );
    }
    catch ( DatabaseOpenInReadOnlyMode& ) {}
    //catch ( coral::InvalidOperationInReadOnlyModeException& ) {}
    catch ( std::exception& e )
    {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests LASTMOD_DATE updating for description changes
  void test_nodeTable_lastModDate() {
    setupDb();
    s_db->createFolderSet( "/myfolder", "my desc" );
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      RelationalTableRow row = ralDb->fetchNodeTableRow( "/myfolder" );
      CPPUNIT_ASSERT_EQUAL( row["NODE_INSTIME"].data<std::string>(),
                            row["LASTMOD_DATE"].data<std::string>() );
      transaction.commit();
    }
    // sleep for one second to make sure the update time change is properly
    // picked up (MySQL has a 1s granularity for example)
    sleep(1);
    {
      RelationalTransaction transaction( ralDb->transactionMgr(), false ); // r/w
      ralDb->updateNodeTableDescription( "/myfolder", "new desc" );
      transaction.commit();
    }
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      RelationalTableRow row = ralDb->fetchNodeTableRow( "/myfolder" );
      CPPUNIT_ASSERT( row["NODE_INSTIME"].data<std::string>()
                      != row["LASTMOD_DATE"].data<std::string>() );
      transaction.commit();
    }
  }

  /// Tests exceptional behavior of a closed database.
  void test_closeDatabase_exceptional_database_behavior() {
    setupDb();
    s_db->closeDatabase();
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    try {
      s_db->createFolder( "/b", fSpec );
      CPPUNIT_FAIL( "createFolder must fail" );
    } catch ( DatabaseNotOpen& ) { }
    try {
      s_db->createFolderSet( "/fs" );
      CPPUNIT_FAIL( "createFolderSet must fail" );
    } catch ( DatabaseNotOpen& ) { }
    try {
      s_db->existsFolderSet( "/" );
      CPPUNIT_FAIL( "existsFolderSet must fail" );
    } catch ( DatabaseNotOpen& ) { }
    try {
      s_db->getFolderSet( "/" );
      CPPUNIT_FAIL( "getFolderSet must fail" );
    } catch ( DatabaseNotOpen& ) { }
    try {
      s_db->createFolder( "/f", fSpec );
      CPPUNIT_FAIL( "createFolder must fail" );
    } catch ( DatabaseNotOpen& ) { }
    try {
      s_db->existsFolder( "/f" );
      CPPUNIT_FAIL( "existsFolder must fail" );
    } catch ( DatabaseNotOpen& ) { }
    try {
      s_db->existsTag( "A" );
      CPPUNIT_FAIL( "existsTag must fail" );
    } catch ( DatabaseNotOpen& ) { }
    try {
      s_db->tagNameScope( "A" );
      CPPUNIT_FAIL( "tagScope must fail" );
    } catch ( DatabaseNotOpen& ) { }
    try {
      s_db->taggedNodes( "A" );
      CPPUNIT_FAIL( "taggedNodes must fail" );
    } catch ( DatabaseNotOpen& ) { }
    try {
      s_db->getFolder( "/f" );
      CPPUNIT_FAIL( "getFolder must fail" );
    } catch ( DatabaseNotOpen& ) { }
    try {
      s_db->dropNode( "/" );
      CPPUNIT_FAIL( "dropNode must fail" );
    } catch ( DatabaseNotOpen& ) { }
    try {
      s_db->listAllNodes();
      CPPUNIT_FAIL( "listAllNodes must fail" );
    } catch ( DatabaseNotOpen& ) { }
    try {
      ralDb->listAllTables();
      CPPUNIT_FAIL( "listAllTables must fail" );
    } catch ( DatabaseNotOpen& ) { }
  }

  /// Tests exceptional behavior of folderset with a closed database.
  void test_closeDatabase_exceptional_folderset_behavior() {
    setupDb();
    IFolderSetPtr root = s_db->getFolderSet( "/" );
    s_db->closeDatabase();
    try {
      root->listFolders();
      CPPUNIT_FAIL( "listFolders must fail" );
    } catch ( DatabaseNotOpen& ) { }
    try {
      root->listFolderSets();
      CPPUNIT_FAIL( "listFolderSets must fail" );
    } catch ( DatabaseNotOpen& ) { }
  }

  /// Tests exceptional behavior of folder methods with a closed database.
  void test_closeDatabase_exceptional_folder_behavior()
  {
    try
    {
      setupDb();
      FolderSpecification fSpec( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec );
      IFolderPtr folder = s_db->createFolder( "/b", fSpec, "desc" );
      folder->storeObject( 0, 10, dummyPayload(0), 0 );
      s_db->closeDatabase();
      try {
        folder->storeObject( 10, 20, dummyPayload(0), 0 );
        CPPUNIT_FAIL( "storeObject must fail" );
      } catch ( DatabaseNotOpen& ) { }
      try {
        folder->setupStorageBuffer();
        folder->storeObject( 10, 20, dummyPayload(0), 0 );
        folder->flushStorageBuffer();
        CPPUNIT_FAIL( "bulk insertion must fail" );
      } catch ( DatabaseNotOpen& ) { }
      try {
        folder->findObject( 5, 0 );
        CPPUNIT_FAIL( "findObject must fail" );
      } catch ( DatabaseNotOpen& ) { }
      try {
        folder->browseObjects( ValidityKeyMin, ValidityKeyMax, 0 );
        CPPUNIT_FAIL( "browseObjects 1 must fail" );
      } catch ( DatabaseNotOpen& ) { }
      try {
        folder->findObjects( 0, ChannelSelection::all() );
        CPPUNIT_FAIL( "findObjects 2 must fail" );
      } catch ( DatabaseNotOpen& ) { }
      try {
        folder->browseObjects( ValidityKeyMin,
                               ValidityKeyMax,
                               ChannelSelection::all() );
        CPPUNIT_FAIL( "browseObjects 3 must fail" );
      } catch ( DatabaseNotOpen& ) { }
      /*
        try {
        folder->fetchObjects( ValidityKeyMin, ValidityKeyMax );
        CPPUNIT_FAIL( "fetchObjects 1 must fail" );
        } catch ( DatabaseNotOpen& ) { }
        try {
        folder->fetchObjects( 0, ChannelSelection::all() );
        CPPUNIT_FAIL( "fetchObjects 2 must fail" );
        } catch ( DatabaseNotOpen& ) { }
        try {
        folder->fetchObjects( ValidityKeyMin,
        ValidityKeyMax,
        ChannelSelection::all() );
        CPPUNIT_FAIL( "fetchObjects 3 must fail" );
        } catch ( DatabaseNotOpen& ) { }
      *///
      try {
        folder->countObjects( ValidityKeyMin,
                              ValidityKeyMax,
                              ChannelSelection::all() );
        CPPUNIT_FAIL( "objectCount must fail" );
      } catch ( DatabaseNotOpen& ) { }
      try {
        folder->listChannels();
        CPPUNIT_FAIL( "listChannels must fail" );
      } catch ( DatabaseNotOpen& ) { }
      try {
        folder->listChannelsWithNames();
        CPPUNIT_FAIL( "listChannelsWithNames must fail" );
      } catch ( DatabaseNotOpen& ) { }
      try {
        folder->tagCurrentHead( "A" );
        CPPUNIT_FAIL( "tagCurrentHead must fail" );
      } catch ( DatabaseNotOpen& ) { }
      try {
        folder->tagHeadAsOfDate( Time(), "A" );
        CPPUNIT_FAIL( "tagHeadAsOfDate must fail" );
      } catch ( DatabaseNotOpen& ) { }
      try {
        folder->insertionTimeOfLastObjectInTag( "A" );
        CPPUNIT_FAIL( "insertionTimeOfLastObjectInTag must fail" );
      } catch ( DatabaseNotOpen& ) { }
      try {
        folder->deleteTag( "A" );
        CPPUNIT_FAIL( "deleteTag must fail" );
      } catch ( DatabaseNotOpen& ) { }
      try {
        folder->setDescription( "" );
        CPPUNIT_FAIL( "setDescription must fail" );
      } catch ( DatabaseNotOpen& ) { }
      try {
        folder->listTags();
        CPPUNIT_FAIL( "listTags must fail" );
      } catch ( DatabaseNotOpen& ) { }
      try {
        folder->tagInsertionTime( "A" );
        CPPUNIT_FAIL( "tagInsertionTime must fail" );
      } catch ( DatabaseNotOpen& ) { }
      try {
        folder->tagDescription( "A" );
        CPPUNIT_FAIL( "tagDescription must fail" );
      } catch ( DatabaseNotOpen& ) { }
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests closeDatabase and reopening.
  void test_closeDatabase()
  {
    setupDb();
    CPPUNIT_ASSERT_MESSAGE( "before disconnect", s_db->isOpen() );
    s_db->closeDatabase();
    CPPUNIT_ASSERT_MESSAGE( "after disconnect", ! s_db->isOpen() );
    s_db->openDatabase();
    CPPUNIT_ASSERT_MESSAGE( "after reconnect", s_db->isOpen() );
    // make sure writing works
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    s_db->createFolder( "/a", fSpec );
  }

  /// Tests the bug report from David Front about cursors not being closed
  void test_openCursorIssue()
  {
    try
    {
      setupDb();
      ralDb->setUseTimeout( false );
      int nFolders = 300;
      FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
      for ( int i = 0; i < nFolders; ++i )
      {
        std::stringstream s; s << "/f_" << i;
        std::cout << "Creating folder '" << s.str() << "'" << std::endl;
        s_db->createFolder( s.str(), fSpec );
      }
      std::vector<std::string> nodes = s_db->listAllNodes();
      CPPUNIT_ASSERT_EQUAL( nFolders +1, (int)nodes.size() );
      for ( int i = 0; i < nFolders; ++i )
      {
        std::stringstream s; s << "/f_" << i;
        std::cout << "Writing into '" << s.str() << "'" << std::endl;
        IFolderPtr f = s_db->getFolder( s.str() );
        f->setupStorageBuffer();
        for ( int j = 0; j < 10; ++j )
          f->storeObject( j, ValidityKeyMax, dummyPayload( j ), 0 );
        f->flushStorageBuffer();
        //sleep(1);
      }
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests updateNodeTableDescription
  void test_updateNodeTableDescription()
  {
    setupDb();
    s_db->createFolderSet( "/myfolder", "my desc" );
    {
      RelationalTransaction transaction( ralDb->transactionMgr(), false ); // r/w
      ralDb->updateNodeTableDescription( "/myfolder", "new desc" );
      transaction.commit();
    }
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      RelationalTableRow row = ralDb->fetchNodeTableRow( "/myfolder" );
      transaction.commit();
      CPPUNIT_ASSERT_EQUAL
        ( std::string("new desc"), row["NODE_DESCRIPTION"].data<std::string>() );
    }
  }

  /// Tests that tagDescription for MV folders for a nonexisting tag
  /// throws a TagNotFound exception
  void test_tagDescription_MV_nonexist()
  {
    setupDb();
    FolderSpecification fSpec( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec );
    IFolderPtr folder = s_db->createFolder( "/myfolder", fSpec, "my description" );
    folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), 0 );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    CPPUNIT_ASSERT_THROW( ralDb->tagMgr().tagDescription( relfolder, "A" ),
                          TagNotFound );
    transaction.commit();
  }

  /// Tests tagDescription for MV folders
  void test_tagDescription_MV()
  {
    setupDb();
    FolderSpecification fSpec( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec );
    IFolderPtr folder = s_db->createFolder( "/myfolder", fSpec, "my description" );
    folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), 0 );
    folder->tagCurrentHead( "A", "desc A" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    std::string desc = ralDb->tagMgr().tagDescription( relfolder, "A" );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "tag desc", std::string("desc A"), desc );
    transaction.commit();
  }

  /// Tests that tagDescription for SV folders throws an exception
  void test_tagDescription_SV()
  {
    setupDb();
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    IFolderPtr folder = s_db->createFolder( "/myfolder", fSpec, "my description" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    CPPUNIT_ASSERT_THROW
      ( ralDb->tagMgr().tagDescription( relfolder, "any tag" ), TagNotFound );
    transaction.commit();
  }

  /// Tests that tagInsertionTime for MV folders for a nonexisting tag
  /// throws a TagNotFound exception
  void test_tagInsertionTime_MV_nonexist()
  {
    setupDb();
    FolderSpecification fSpec( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec );
    IFolderPtr folder = s_db->createFolder( "/myfolder", fSpec, "my description" );
    folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), 0 );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    CPPUNIT_ASSERT_THROW( ralDb->tagMgr().tagInsertionTime( relfolder, "A" ),
                          TagNotFound );
    transaction.commit();
  }

  /// Tests tagInsertionTime for MV folders
  void test_tagInsertionTime_MV()
  {
    try
    {
      setupDb();
      FolderSpecification fSpec( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec );
      IFolderPtr folder = s_db->createFolder( "/myfolder", fSpec, "my description" );
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), 0 );
      // Create a temporary sequence to get the server SYSDATE before insertion
      Time before;
      std::string tmpSeqName = std::string( s_coolDBName + "_TMP_CLOCK" );
      {
        RelationalTransaction transaction( ralDb->transactionMgr() );
        if ( ralDb->queryMgr().sequenceMgr().existsSequence( tmpSeqName ) )
          ralDb->queryMgr().sequenceMgr().dropSequence( tmpSeqName );
        boost::shared_ptr<RelationalSequence> tmpSeq =
          ralDb->queryMgr().sequenceMgr().createSequence( tmpSeqName );
        tmpSeq->nextVal();
        before = stringToTime( tmpSeq->currDate() );
        transaction.commit();
      }
      // MySQL now() has 1 second granularity: need to sleep at least 1 second
      // (if test checks for strict < or >; not needed if checks for <= or >=)
      sleep(1);
      // Tag the folder
      folder->tagCurrentHead( "A" );
      // MySQL now() has 1 second granularity: need to sleep at least 1 second
      // (if test checks for strict < or >; not needed if checks for <= or >=)
      sleep(1);
      // Get the server SYSDATE after insertion
      Time after;
      {
        RelationalTransaction transaction( ralDb->transactionMgr() );
        boost::shared_ptr<RelationalSequence> tmpSeq =
          ralDb->queryMgr().sequenceMgr().getSequence( tmpSeqName );
        tmpSeq->nextVal();
        after = stringToTime( tmpSeq->currDate() );
        transaction.commit();
      }
      // Cleanup - drop the temporary sequence
      {
        RelationalTransaction transaction( ralDb->transactionMgr() );
        ralDb->queryMgr().sequenceMgr().dropSequence( tmpSeqName );
        transaction.commit();
      }
      TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
      if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
      RelationalFolder* relfolder = trelfolder->getRelFolder();
      //std::cout << "*** Windows will throw UNKNOWN exception?" << std::endl;
      RelationalTransaction transaction( ralDb->transactionMgr() );
      Time tagTime =
        ralDb->tagMgr().tagInsertionTime( relfolder, "A" );
      transaction.commit();
      //std::cout << "*** Windows has thrown UNKNOWN exception?" << std::endl;
      CPPUNIT_ASSERT_MESSAGE( "before < tagTime", before < tagTime );
      CPPUNIT_ASSERT_MESSAGE( "tagTime < after", tagTime < after );
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    } catch ( ... ) {
      std::cout << "UNKNOWN Exception caught!" << std::endl;
      throw;
    }
  }

  /// Tests that tagInsertionTime for SV folders throws an exception
  void test_tagInsertionTime_SV()
  {
    setupDb();
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    IFolderPtr folder = s_db->createFolder( "/myfolder", fSpec, "my description" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr(), true ); // r/o
    CPPUNIT_ASSERT_THROW(ralDb->tagMgr()
                         .tagInsertionTime( relfolder, "any tag" ),
                         TagNotFound);
    transaction.commit();
  }

  /// Tests listChannels for MV folders
  void test_listChannels_MV()
  {
    setupDb();
    FolderSpecification fSpec( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec );
    IFolderPtr folder = s_db->createFolder( "/myfolder", fSpec, "my description" );
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
  }

  /// Tests listChannels for SV folders
  void test_listChannels_SV()
  {
    setupDb();
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    IFolderPtr folder = s_db->createFolder( "/myfolder", fSpec, "my description" );
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
  }

  /// Updates the release number in the RELEASE column of the main table
  void updateRelease( const std::string& releaseNumber )
  {
    RalSessionMgr ralSessMgr( ppConnectionSvc(), s_connectionString, false );
    ralSessMgr.session().transaction().start();
    coral::ISchema& schema = ralSessMgr.session().nominalSchema();
    std::string mainTable = RelationalDatabaseTable::tableName( s_coolDBName );
    coral::ITable& table = schema.tableHandle( mainTable );
    coral::AttributeList updateData;
    updateData.extend( "newRelease", "string" );
    updateData.extend( "releaseColumn", "string" );
    updateData["newRelease"].setValue( releaseNumber );
    updateData["releaseColumn"].setValue( std::string("RELEASE") );
    std::string setClause = "DB_ATTRIBUTE_VALUE = :newRelease";
    std::string whereClause = "DB_ATTRIBUTE_NAME = :releaseColumn";
    int updatedRows =
      table.dataEditor().updateRows( setClause, whereClause, updateData );
    ralSessMgr.session().transaction().commit();
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( std::string( "release update row count (new release: " )
        + releaseNumber + ")", 1, updatedRows );
    ralSessMgr.disconnect();
    //forceDisconnect(); // NO! This will make ralDb unusable (segfault...)!
  }

  /// Updates the schema version in the SCHEMA_VERSION column of the main table
  void updateSchemaVersion( const std::string& schemaVersion )
  {
    RalSessionMgr ralSessMgr( ppConnectionSvc(), s_connectionString, false );
    ralSessMgr.session().transaction().start();
    coral::ISchema& schema = ralSessMgr.session().nominalSchema();
    std::string mainTable = RelationalDatabaseTable::tableName( s_coolDBName );
    coral::ITable& table = schema.tableHandle( mainTable );
    coral::AttributeList updateData;
    updateData.extend( "newSchemaVersion", "string" );
    updateData.extend( "schemaVersionColumn", "string" );
    updateData["newSchemaVersion"].setValue( schemaVersion );
    updateData["schemaVersionColumn"].setValue(std::string("SCHEMA_VERSION"));
    std::string setClause = "DB_ATTRIBUTE_VALUE = :newSchemaVersion";
    std::string whereClause = "DB_ATTRIBUTE_NAME = :schemaVersionColumn";
    int updatedRows =
      table.dataEditor().updateRows
      ( setClause, whereClause, updateData );
    ralSessMgr.session().transaction().commit();
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( std::string( "schema version update row count (new schema: " )
        + schemaVersion + ")", 1, updatedRows );
    ralSessMgr.disconnect();
    //forceDisconnect(); // NO! This will make ralDb unusable (segfault...)!
  }

  /// Updates the SCHEMA_VERSION column of the node table for the given node
  void updateNodeSchemaVersion( const std::string& fullPath,
                                const std::string& schemaVersion )
  {
    RalSessionMgr ralSessMgr( ppConnectionSvc(), s_connectionString, false );
    ralSessMgr.session().transaction().start();
    coral::ISchema& schema = ralSessMgr.session().nominalSchema();
    coral::ITable& table = schema.tableHandle( ralDb->nodeTableName() );
    coral::AttributeList updateData;
    updateData.extend( "newSchemaVersion", "string" );
    updateData.extend( "fullPath", "string" );
    updateData["newSchemaVersion"].setValue( schemaVersion );
    updateData["fullPath"].setValue( fullPath );
    std::string setClause = RelationalNodeTable::columnNames::nodeSchemaVersion
      + " = :newSchemaVersion";
    std::string whereClause = RelationalNodeTable::columnNames::nodeFullPath
      + " = :fullPath";
    int updatedRows = table.dataEditor().updateRows
      ( setClause, whereClause, updateData );
    ralSessMgr.session().transaction().commit();
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( std::string( "node schema version update row count (new schema: " )
        + schemaVersion + ")", 1, updatedRows );
    ralSessMgr.disconnect();
    //forceDisconnect(); // NO! This will make ralDb unusable (segfault...)!
  }

  /// Function to test a release version that should _NOT_ be opened.
  void checkReleaseFAIL_NoSchemaEvolution(const std::string& rel)
  {
    //std::cout << "checkRelFAIL_NoSchEv " << rel << "..." << std::endl;
    setupDb(); // faster than createDB (allow database refresh)
    updateRelease( rel );
    try
    {
      openDB();
      forceDisconnect();
      updateRelease( VersionInfo::release );
      CPPUNIT_ASSERT_MESSAGE( "exception expected for "+rel, false );
    }
    catch ( RelationalException& e )
    {
      forceDisconnect();
      updateRelease( VersionInfo::release );
      std::string expected = "IncompatibleReleaseNumber exception. "
        "Release number mismatch - SCHEMA EVOLUTION NOT POSSIBLE: "
        "database with OLDER release number " + rel +
        " (older than 1.2.0)"
        " cannot be opened using CURRENT client release number "
        + std::string(VersionInfo::release);
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "exception caught",
                                    expected, std::string( e.what() ) );
    }
    catch ( ... )
    {
      forceDisconnect();
      updateRelease( VersionInfo::release );
      throw;
    }
    openDB(); // cleanup for faster tests (allow database refresh)
    //std::cout << "checkRelFAIL_NoSchEv " << rel << "... DONE" << std::endl;
  }

  /// Function to test a release version that should _NOT_ be opened.
  void checkReleaseFAIL_SchemaEvolution(const std::string& rel)
  {
    //std::cout << "checkRelFAIL_SchEv " << rel << "..." << std::endl;
    setupDb(); // faster than createDB (allow database refresh)
    updateRelease( rel );
    try
    {
      openDB();
      forceDisconnect();
      updateRelease( VersionInfo::release );
      CPPUNIT_ASSERT_MESSAGE( "exception expected for "+rel, false );
    }
    catch ( RelationalException& e )
    {
      forceDisconnect();
      updateRelease( VersionInfo::release );
      std::string expected = "IncompatibleReleaseNumber exception. "
        "Release number mismatch - SCHEMA EVOLUTION REQUIRED: "
        "database with OLDER release number " + rel +
        " cannot be opened using CURRENT client release number "
        + std::string(VersionInfo::release);
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "exception caught",
                                    expected, std::string( e.what() ) );
    }
    catch ( ... )
    {
      forceDisconnect();
      updateRelease( VersionInfo::release );
      throw;
    }
    openDB(); // cleanup for faster tests (allow database refresh)
    //std::cout << "checkRelFAIL_SchEv " << rel << "... DONE" << std::endl;
  }

  /// Function to test a release version that should be opened.
  void checkReleaseOK(const std::string& rel)
  {
    //std::cout << "checkRelOK " << rel << "..." << std::endl;
    setupDb(); // faster than createDB (allow database refresh)
    updateRelease( rel );
    try
    {
      openDB();
      CPPUNIT_ASSERT( s_db.get() != 0 );
      CPPUNIT_ASSERT( s_db->isOpen() );
    }
    catch ( RelationalException& )
    {
      forceDisconnect();
      updateRelease( VersionInfo::release );
      CPPUNIT_ASSERT_MESSAGE( "could not open version "+rel, false );
    }
    catch ( ... )
    {
      forceDisconnect();
      updateRelease( VersionInfo::release );
      throw;
    }
    forceDisconnect();
    updateRelease( VersionInfo::release );
    openDB(); // cleanup for faster tests (allow database refresh)
    //std::cout << "checkRelOK " << rel << "... DONE" << std::endl;
  }

  /// Cross-check the present release against all production releases
  /// REMEMBER TO UPDATE THIS AT EVERY RELEASE! This includes a check against
  /// the current release (which will become a former release when the next
  /// one is out, and will fail the test if you forget to update it!)
  void test_allProdReleases()
  {
    std::vector<std::string> not_openable_no_schema_evolution;
    not_openable_no_schema_evolution.push_back( "1.0.0" );
    not_openable_no_schema_evolution.push_back( "1.0.1" );
    not_openable_no_schema_evolution.push_back( "1.0.2" );
    not_openable_no_schema_evolution.push_back( "1.1.0" );
    std::vector<std::string> not_openable_schema_evolution;
    not_openable_schema_evolution.push_back( "1.2.0" );
    not_openable_schema_evolution.push_back( "1.2.1" );
    not_openable_schema_evolution.push_back( "1.2.2" );
    not_openable_schema_evolution.push_back( "1.2.3" );
    not_openable_schema_evolution.push_back( "1.2.4" );
    not_openable_schema_evolution.push_back( "1.2.5" );
    not_openable_schema_evolution.push_back( "1.2.6" );
    not_openable_schema_evolution.push_back( "1.2.7" );
    not_openable_schema_evolution.push_back( "1.2.8" );
    not_openable_schema_evolution.push_back( "1.2.9" );
    not_openable_schema_evolution.push_back( "1.3.0" );
    not_openable_schema_evolution.push_back( "1.3.1" );
    not_openable_schema_evolution.push_back( "1.3.2" );
    not_openable_schema_evolution.push_back( "1.3.3" );
    not_openable_schema_evolution.push_back( "1.3.4" );
    std::vector<std::string> openable; // current can (needs not) be included
    openable.push_back( "2.0.0" );
    openable.push_back( "2.1.0" );
    openable.push_back( "2.1.1" );
    openable.push_back( "2.2.0" );
    openable.push_back( "2.2.1" );
    openable.push_back( "2.2.2" );
    openable.push_back( "2.3.0" );
    openable.push_back( "2.3.1" );
    openable.push_back( "2.4.0" );
    openable.push_back( "2.5.0" );
    openable.push_back( "2.6.0" );
    openable.push_back( "2.7.0" );
    openable.push_back( "2.8.0" );
    openable.push_back( "2.8.1" );
    openable.push_back( "2.8.2" );
    openable.push_back( "2.8.3" );
    openable.push_back( "2.8.4" );
    openable.push_back( "2.8.5" );
    openable.push_back( "2.8.6" );
    openable.push_back( "2.8.7" );
    openable.push_back( "2.8.8" );
    openable.push_back( "2.8.9" );
    openable.push_back( "2.8.10" );
    openable.push_back( "2.8.11" );
    openable.push_back( "2.8.12" );
    openable.push_back( "2.8.13" );
    openable.push_back( "2.8.14" );
    openable.push_back( "2.8.15" );
    openable.push_back( "2.8.16" );
    openable.push_back( "2.8.17" );
    openable.push_back( "2.8.18" );
    openable.push_back( "2.8.19" );
    openable.push_back( "2.8.20" );
#if defined(COOL290CO) || defined(COOL290EX) || defined(COOL290VP)
    openable.push_back( "2.9.0" );
    openable.push_back( "2.9.1" );
    openable.push_back( "2.9.2" );
    openable.push_back( "2.9.3" );
    openable.push_back( "2.9.4" );
    openable.push_back( "2.9.5" );
    openable.push_back( "2.9.6" );
#if defined(COOL300)
    openable.push_back( "3.0.0" );
    openable.push_back( "3.0.1" );
    openable.push_back( "3.0.2" );
    openable.push_back( "3.0.3" );
#endif
#endif
    // Check for failure - too old even for schema evolution
    std::vector<std::string> ::iterator rel;
    for ( rel = not_openable_no_schema_evolution.begin();
          rel != not_openable_no_schema_evolution.end();
          ++rel )
    {
      checkReleaseFAIL_NoSchemaEvolution( *rel );
    }
    // Check for failure - need schema evolution
    for ( rel = not_openable_schema_evolution.begin();
          rel != not_openable_schema_evolution.end();
          ++rel )
    {
      checkReleaseFAIL_SchemaEvolution( *rel );
    }
    // Check for success - forward compatible
    for( rel = openable.begin(); rel != openable.end(); ++rel )
    {
      checkReleaseOK( *rel );
    }
    // Current Version - can be opened
    setupDb(); // faster than createDB (allow database refresh)
    updateRelease( VersionInfo::release ); // not needed, but make the point
    try
    {
      openDB();
      CPPUNIT_ASSERT( s_db.get() != 0 );
      CPPUNIT_ASSERT( s_db->isOpen() );
    }
    catch ( ... )
    {
      forceDisconnect();
      throw;
    }
    forceDisconnect();
    openDB(); // cleanup for faster tests (allow database refresh)
  }

  /// This is actually a test of the CORAL updateRows method (sr #101074)
  void test_updateRows()
  {
    setupDb(); // faster than createDB (allow database refresh)
    // The following three calls update rows without changing any column
    // values: all three calls fail on MySQL if sr #101074 is not fixed,
    // because the return value of updateRows is 0 instead of 1
    updateRelease( VersionInfo::release );
    updateSchemaVersion( VersionInfo::schemaVersion );
    openDB(false);
    TransRalDatabase* traldb = dynamic_cast<TransRalDatabase*>( s_db.get() );
    if ( !traldb ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    ralDb = traldb->getRalDb();
    updateNodeSchemaVersion( "/", VersionInfo::schemaVersion );
  }

  /// Tests that an exception is thrown when the current API is used to
  /// access a release 0.1.0 database (the object_id ordering change was
  /// data incompatible -- 1.0.0 and later cannot reliably read 0.1.0 data)
  void test_release_0_1_0()
  {
    checkReleaseFAIL_NoSchemaEvolution("0.1.0");
  }

  /// Tests what happens when the current API is used
  /// to access a newer release 4.0.0 database
  void test_release_4_0_0()
  {
    std::string newRel("4.0.0");
    std::string newSch("4.0.0");
    std::string oldSch("1.0.0");
    setupDb(); // faster than createDB (allow database refresh)
    updateRelease( newRel );
    try {
      // 1. Newer release, same schema - it can be opened
      openDB();
      // 2. Newer release, newer schema - it cannot be opened
      try {
        updateSchemaVersion( newSch );
        openDB();
        CPPUNIT_FAIL( "Exception expected for newer schema " + newSch );
      }
      catch ( IncompatibleReleaseNumber& e ) {
        std::stringstream s;
        s << "IncompatibleReleaseNumber exception. "
          << "Release number and schema version mismatch"
          << " - SCHEMA NOT BACKWARD COMPATIBLE: "
          << "database with NEWER release number " << newRel
          << " and NEWER schema version " << newSch
          << " cannot be opened using CURRENT client release number "
          << VersionInfo::release
          << " (CURRENT schema version " << VersionInfo::schemaVersion << ")";
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "exception caught", s.str(), std::string( e.what() ) );
      }
      // 3. Newer release, older schema - panic!
      try {
        updateSchemaVersion( oldSch );
        openDB();
        CPPUNIT_FAIL( "Exception expected for older schema " + newSch );
      }
      catch ( IncompatibleReleaseNumber& e ) {
        std::stringstream s;
        s << "IncompatibleReleaseNumber exception. "
          << "PANIC! Release number and schema version mismatch: "
          << "database with NEWER release number " << newRel
          << " than CURRENT client release number " << VersionInfo::release
          << " has OLDER schema version " << oldSch
          << " (CURRENT schema version " << VersionInfo::schemaVersion << ")";
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "exception caught", s.str(), std::string( e.what() ) );
      }
      forceDisconnect();
      updateRelease( VersionInfo::release );
      updateSchemaVersion( VersionInfo::schemaVersion );
    }
    catch ( ... )
    {
      forceDisconnect();
      updateRelease( VersionInfo::release );
      updateSchemaVersion( VersionInfo::schemaVersion );
      throw;
    }
    openDB(); // cleanup for faster tests (allow database refresh)
  }

  /// Tests what happens when the current API is used
  /// to access a folder with obsolete schema version 2.0.0
  void test_useFolder_2_0_0()
  {
    setupDb();
    s_db->createFolderSet( "/my" );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec );
    s_db->createFolder( "/my/folder", fSpec, "" );
    std::string newSch("2.0.0");
    PayloadMode::Mode pMode = cool_PayloadMode_Mode::INLINEPAYLOAD; // no payload table (default)
    std::string oldFoldSch( RelationalFolder::folderSchemaVersion( pMode ) );
    /// 1. Test folder using its original schema version
    IFolderPtr folder;
    folder = s_db->getFolder( "/my/folder" );
    CPPUNIT_ASSERT( folder.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "1. folder name", std::string( "/my/folder" ), folder->fullPath() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "1. folder schema", oldFoldSch, folder->folderAttributes()
        ["NODE_SCHEMA_VERSION"].data<std::string>() );
    folder->folderSpecification(); // Should not throw
    /// 2. Test folder using an obsolete schema version
    updateNodeSchemaVersion( "/my/folder", newSch );
    folder = s_db->getFolder( "/my/folder" );
    CPPUNIT_ASSERT( folder.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "2. folder name", std::string( "/my/folder" ), folder->fullPath() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "2. folder schema", newSch, folder->folderAttributes()
        ["NODE_SCHEMA_VERSION"].data<std::string>() );
    try {
      CPPUNIT_ASSERT_THROW
        ( folder->folderSpecification(), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->payloadSpecification(), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->versioningMode(), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->setupStorageBuffer(), UnsupportedFolderSchema );
      Record dummyRec( payloadSpec );
      CPPUNIT_ASSERT_THROW
        ( folder->storeObject( 0, 10, dummyRec, 0 ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->flushStorageBuffer(), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->findObject( 0, 0 ), UnsupportedFolderSchema );
      ChannelSelection dummyChSel( 0 );
      CPPUNIT_ASSERT_THROW
        ( folder->findObjects( 0, dummyChSel ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->setPrefetchAll( true ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->browseObjects( 0, 10, dummyChSel ),
          UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->countObjects( 0, 10, dummyChSel ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->renamePayload( "I", "J" ), UnsupportedFolderSchema );
      RecordSpecification extSpec;
      extSpec.extend("I",cool_StorageType_TypeId::Int32);
      Record extRec( extSpec );
      CPPUNIT_ASSERT_THROW
        ( folder->extendPayloadSpecification( extRec ),
          UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->tagCurrentHead( "a" ), UnsupportedFolderSchema );
      Time now;
      CPPUNIT_ASSERT_THROW
        ( folder->insertionTimeOfLastObjectInTag("a"),
          UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->deleteTag( "a" ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->tagHeadAsOfDate( now, "a" ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->existsUserTag( "a" ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->listChannels(), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->listChannelsWithNames(), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->createChannel( 1, "b" ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->setChannelName( 1, "a" ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->channelName( 1 ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->channelId( "a" ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->existsChannel( 0 ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->existsChannel( "a" ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->setChannelDescription( 1, "a" ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->channelDescription( 1 ), UnsupportedFolderSchema );
    } catch (...) {
      updateNodeSchemaVersion( "/my/folder", oldFoldSch );
      throw;
    }
    /// 3. Test folder using its original schema version again
    updateNodeSchemaVersion( "/my/folder", oldFoldSch );
    folder = s_db->getFolder( "/my/folder" );
    CPPUNIT_ASSERT( folder.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "3. folder name", std::string( "/my/folder" ), folder->fullPath() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "3. folder schema", oldFoldSch, folder->folderAttributes()
        ["NODE_SCHEMA_VERSION"].data<std::string>() );
    folder->folderSpecification(); // Should not throw
  }

  /// Tests what happens when the current API is used
  /// to drop a folder with obsolete schema version 2.0.0
  void test_dropFolder_2_0_0()
  {
    setupDb();
    s_db->createFolderSet( "/my" );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    s_db->createFolder( "/my/folder", fSpec );
    std::string newSch("2.0.0");
    PayloadMode::Mode pMode = cool_PayloadMode_Mode::INLINEPAYLOAD; // no payload table (default)
    std::string oldFoldSch( RelationalFolder::folderSchemaVersion( pMode ) );
    updateNodeSchemaVersion( "/my/folder", newSch );
    try {
      CPPUNIT_ASSERT_THROW
        ( s_db->dropNode( "/my/folder" ), Exception );
    } catch (...) {
      updateNodeSchemaVersion( "/my/folder", oldFoldSch );
      throw;
    }
    updateNodeSchemaVersion( "/my/folder", oldFoldSch );
  }

  /// Tests listAllTables if there is an obsolete folder version 2.0.0
  void test_listAllTablesWithFolder_2_0_0()
  {
    // Create folders
    setupDb();
    s_db->createFolderSet( "/f1" );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    s_db->createFolder( "/f1/folderA", fSpec );
    s_db->createFolder( "/f1/folderB", fSpec );
    // Prepare list of expected tables
    std::vector<std::string> suffixes;
    suffixes.push_back( "_DB_ATTRIBUTES" );
    suffixes.push_back( "_F0000_TAGS_SEQ" );
    suffixes.push_back( "_F0001_TAGS_SEQ" );
    suffixes.push_back( "_F0002_CHANNELS" );
    suffixes.push_back( "_F0002_IOVS" );
    suffixes.push_back( "_F0002_IOVS_SEQ" );
    suffixes.push_back( "_F0003_CHANNELS" );
    suffixes.push_back( "_F0003_IOVS" );
    suffixes.push_back( "_F0003_IOVS_SEQ" );
    suffixes.push_back( "_NODES" );
    suffixes.push_back( "_NODES_SEQ" );
    suffixes.push_back( "_TAG2TAG" );
    suffixes.push_back( "_TAG2TAG_SEQ" );
    suffixes.push_back( "_TAGS" );
    // Change a folder schema to 2.0.0
    std::string newSch("2.0.0");
    PayloadMode::Mode pMode = cool_PayloadMode_Mode::INLINEPAYLOAD; // no payload table (default)
    std::string oldFoldSch( RelationalFolder::folderSchemaVersion( pMode ) );
    updateNodeSchemaVersion( "/f1/folderA", newSch );
    try {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      std::vector<std::string> tables = ralDb->listAllTables();
      transaction.commit();
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "tables count", (size_t)14, tables.size() );
      std::vector<std::string>::const_iterator suffix;
      for ( suffix = suffixes.begin(); suffix != suffixes.end(); suffix++ )
      {
        std::string table;
        table = s_coolDBName + *suffix;
        CPPUNIT_ASSERT_MESSAGE
          ( table,
            find( tables.begin(), tables.end(), table ) != tables.end() );
      }
    } catch (...) {
      updateNodeSchemaVersion( "/f1/folderA", oldFoldSch );
      throw;
    }
    updateNodeSchemaVersion( "/f1/folderA", oldFoldSch );
  }

  /// Tests listAllTables if there are obsolete node versions 1.9.9
  void test_listAllTablesWithNode_1_9_9()
  {
    // Create folders
    setupDb();
    s_db->createFolderSet( "/f1" );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    s_db->createFolder( "/f1/folderA", fSpec );
    s_db->createFolder( "/f1/folderB", fSpec );
    // Change a folder set schema to 1.9.9
    {
      std::string newSch("1.9.9");
      std::string oldFsetSch( RelationalFolderSet::folderSetSchemaVersion() );
      updateNodeSchemaVersion( "/f1", newSch );
      try {
        RelationalTransaction transaction( ralDb->transactionMgr() );
        CPPUNIT_ASSERT_THROW
          ( ralDb->listAllTables(), PanicException );
        transaction.commit();
      } catch (...) {
        updateNodeSchemaVersion( "/f1", oldFsetSch );
        throw;
      }
      updateNodeSchemaVersion( "/f1", oldFsetSch );
    }
    // Change a folder schema to 1.9.9
    {
      std::string newSch("1.9.9");
      PayloadMode::Mode pMode = cool_PayloadMode_Mode::INLINEPAYLOAD; // no payload table (default)
      std::string oldFoldSch( RelationalFolder::folderSchemaVersion( pMode ) );
      updateNodeSchemaVersion( "/f1/folderA", newSch );
      try {
        RelationalTransaction transaction( ralDb->transactionMgr() );
        CPPUNIT_ASSERT_THROW
          ( ralDb->listAllTables(), PanicException );
        transaction.commit();
      } catch (...) {
        updateNodeSchemaVersion( "/f1/folderA", oldFoldSch );
        throw;
      }
      updateNodeSchemaVersion( "/f1/folderA", oldFoldSch );
    }
  }

  /// Tests listAllTables if there are new node versions 2.0.9
  void test_listAllTablesWithNode_2_0_9()
  {
    // Create folders
    setupDb();
    s_db->createFolderSet( "/f1" );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    s_db->createFolder( "/f1/folderA", fSpec );
    s_db->createFolder( "/f1/folderB", fSpec );
    // Prepare list of expected tables
    std::vector<std::string> suffixes;
    suffixes.push_back( "_DB_ATTRIBUTES" );
    suffixes.push_back( "_F0000_TAGS_SEQ" );
    suffixes.push_back( "_F0001_TAGS_SEQ" );
    suffixes.push_back( "_F0002_CHANNELS" );
    suffixes.push_back( "_F0002_IOVS" );
    suffixes.push_back( "_F0002_IOVS_SEQ" );
    suffixes.push_back( "_F0003_CHANNELS" );
    suffixes.push_back( "_F0003_IOVS" );
    suffixes.push_back( "_F0003_IOVS_SEQ" );
    suffixes.push_back( "_NODES" );
    suffixes.push_back( "_NODES_SEQ" );
    suffixes.push_back( "_TAG2TAG" );
    suffixes.push_back( "_TAG2TAG_SEQ" );
    suffixes.push_back( "_TAGS" );
    // Change a folder schema and a folder set to 2.0.9
    std::string newSch("2.0.9");
    std::string oldFsetSch( RelationalFolderSet::folderSetSchemaVersion() );
    PayloadMode::Mode pMode = cool_PayloadMode_Mode::INLINEPAYLOAD; // no payload table (default)
    std::string oldFoldSch( RelationalFolder::folderSchemaVersion( pMode ) );
    updateNodeSchemaVersion( "/f1", newSch );
    updateNodeSchemaVersion( "/f1/folderA", newSch );
    try {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      std::vector<std::string> tables = ralDb->listAllTables();
      transaction.commit();
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "tables count", (size_t)14, tables.size() );
      std::vector<std::string>::const_iterator suffix;
      for ( suffix = suffixes.begin(); suffix != suffixes.end(); suffix++ )
      {
        std::string table;
        table = s_coolDBName + *suffix;
        CPPUNIT_ASSERT_MESSAGE
          ( table,
            find( tables.begin(), tables.end(), table ) != tables.end() );
      }
    } catch (...) {
      updateNodeSchemaVersion( "/f1", oldFsetSch );
      updateNodeSchemaVersion( "/f1/folderA", oldFoldSch );
      throw;
    }
    updateNodeSchemaVersion( "/f1", oldFsetSch );
    updateNodeSchemaVersion( "/f1/folderA", oldFoldSch );
  }

  /// Tests listAllTables if there are new node versions 3.10.0
  void test_listAllTablesWithNode_3_10_0()
  {
    // Create folders
    setupDb();
    s_db->createFolderSet( "/f1" );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    s_db->createFolder( "/f1/folderA", fSpec );
    s_db->createFolder( "/f1/folderB", fSpec );
    // Change a folder set schema to 3.10.0
    {
      std::string newSch("3.10.0");
      std::string oldFsetSch( RelationalFolderSet::folderSetSchemaVersion() );
      updateNodeSchemaVersion( "/f1", newSch );
      try {
        //CPPUNIT_ASSERT_THROW
        //  ( ralDb->listAllTables(), UnsupportedFolderSetSchema );
      } catch (...) {
        updateNodeSchemaVersion( "/f1", oldFsetSch );
        throw;
      }
      updateNodeSchemaVersion( "/f1", oldFsetSch );
    }
    // Change a folder schema to 3.10.0
    {
      std::string newSch("3.10.0");
      PayloadMode::Mode pMode = cool_PayloadMode_Mode::INLINEPAYLOAD; // no payload table (default)
      std::string oldFoldSch( RelationalFolder::folderSchemaVersion( pMode ) );
      updateNodeSchemaVersion( "/f1/folderA", newSch );
      try {
        RelationalTransaction transaction( ralDb->transactionMgr() );
        CPPUNIT_ASSERT_THROW
          ( ralDb->listAllTables(), UnsupportedFolderSchema );
        transaction.commit();
      } catch (...) {
        updateNodeSchemaVersion( "/f1/folderA", oldFoldSch );
        throw;
      }
      updateNodeSchemaVersion( "/f1/folderA", oldFoldSch );
    }
  }

  /// Tests what happens when the current API is used to drop a database
  /// containing a folder with obsolete schema version 2.0.0
  void test_dropDatabaseWithFolder_2_0_0()
  {
    setupDb();
    s_db->createFolderSet( "/my" );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    s_db->createFolder( "/my/folder1", fSpec );
    s_db->createFolder( "/my/folder2", fSpec );
    s_db->createFolder( "/my/folder3", fSpec );
    std::string newSch("2.0.0");
    PayloadMode::Mode pMode = cool_PayloadMode_Mode::INLINEPAYLOAD; // no payload table (default)
    std::string oldFoldSch( RelationalFolder::folderSchemaVersion( pMode ) );
    updateNodeSchemaVersion( "/my/folder2", newSch );
    try {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      CPPUNIT_ASSERT_THROW
        ( ralDb->dropDatabase(), Exception );
      transaction.commit();
      IFolderSetPtr folderset = s_db->getFolderSet( "/my" );
      CPPUNIT_ASSERT( folderset.get() != 0 );
      IFolderPtr folder;
      folder = s_db->getFolder( "/my/folder1" );
      CPPUNIT_ASSERT( folder.get() != 0 );
      folder = s_db->getFolder( "/my/folder2" );
      CPPUNIT_ASSERT( folder.get() != 0 );
      folder = s_db->getFolder( "/my/folder3" );
      CPPUNIT_ASSERT( folder.get() != 0 );
    } catch (...) {
      updateNodeSchemaVersion( "/my/folder2", oldFoldSch );
      throw;
    }
    updateNodeSchemaVersion( "/my/folder2", oldFoldSch );
  }

  /// Tests what happens when the current API is used
  /// to access a node with newer schema version 2.0.9
  void test_useNode_2_0_9()
  {
    setupDb();
    s_db->createFolderSet( "/my" );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec );
    s_db->createFolder( "/my/folder", fSpec, "" );
    std::string newSch("2.0.9");
    //std::string newSch("2.9.0"); // test error recovery in catch(...) clause
    PayloadMode::Mode pMode = cool_PayloadMode_Mode::INLINEPAYLOAD; // no payload table (default)
    std::string oldFoldSch( RelationalFolder::folderSchemaVersion( pMode ) );
    std::string oldFsetSch( RelationalFolderSet::folderSetSchemaVersion() );
    /// 1. Test folderset and folder using their original schema version
    IFolderSetPtr folderset;
    IFolderPtr folder;
    folderset = s_db->getFolderSet( "/my" );
    CPPUNIT_ASSERT( folderset.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "1. folderset name", std::string( "/my" ), folderset->fullPath() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "1. folderset schema", oldFsetSch, folderset->folderSetAttributes()
        ["NODE_SCHEMA_VERSION"].data<std::string>() );
    folderset->listFolders(); // Should not throw
    folder = s_db->getFolder( "/my/folder" );
    CPPUNIT_ASSERT( folder.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "1. folder name", std::string( "/my/folder" ), folder->fullPath() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "1. folder schema", oldFoldSch, folder->folderAttributes()
        ["NODE_SCHEMA_VERSION"].data<std::string>() );
    folder->folderSpecification(); // Should not throw
    /// 2. Test folderset and folder using a newer schema version
    updateNodeSchemaVersion( "/my", newSch );
    updateNodeSchemaVersion( "/my/folder", newSch );
    folderset = s_db->getFolderSet( "/my" );
    CPPUNIT_ASSERT( folderset.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "2. folderset name", std::string( "/my" ), folderset->fullPath() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "2. folderset schema", newSch, folderset->folderSetAttributes()
        ["NODE_SCHEMA_VERSION"].data<std::string>() );
    folder = s_db->getFolder( "/my/folder" );
    CPPUNIT_ASSERT( folder.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "2. folder name", std::string( "/my/folder" ), folder->fullPath() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "2. folder schema", newSch, folder->folderAttributes()
        ["NODE_SCHEMA_VERSION"].data<std::string>() );
    // None of the following methods should throw
    try {
      folderset->listFolders();
      folderset->listFolderSets();
      folder->folderSpecification();
      folder->payloadSpecification();
      folder->versioningMode();
      folder->setupStorageBuffer();
      Record dummyRec( payloadSpec );
      folder->storeObject( 0, 10, dummyRec, 0 );
      folder->flushStorageBuffer();
      IObjectPtr obj = folder->findObject( 0, 0 );
      // We cannot use the current time to tag if the client
      // and server are not synchronized  (see bug #24481 for details)
      Time insertion_time = obj->insertionTime();
      obj.reset();
      ChannelSelection dummyChSel( 0 );
      folder->findObjects( 0, dummyChSel );
      folder->setPrefetchAll( true );
      folder->browseObjects( 0, 10, dummyChSel );
      folder->countObjects( 0, 10, dummyChSel );
      folder->renamePayload( "I", "J" );
      RecordSpecification extSpec;
      extSpec.extend("I",cool_StorageType_TypeId::Int32);
      Record extRec( extSpec );
      folder->extendPayloadSpecification( extRec );
      sleep(1); // Patch for the ORA-01466 problem: sleep one second
      folder->tagCurrentHead( "a" );
      // We cannot use the current time if the client and server are not
      // synchronized (see bug #24481 for details)
      // Time now;
      folder->insertionTimeOfLastObjectInTag("a");
      folder->deleteTag( "a" );
      // folder->tagHeadAsOfDate( now, "a" );
      folder->tagHeadAsOfDate( insertion_time, "a" );
      folder->existsUserTag( "a" );
      folder->listChannels();
      folder->listChannelsWithNames();
      folder->createChannel( 1, "b" );
      folder->setChannelName( 1, "a" );
      folder->channelName( 1 );
      folder->channelId( "a" );
      folder->existsChannel( 0 );
      folder->existsChannel( "a" );
      folder->setChannelDescription( 1, "a" );
      folder->channelDescription( 1 );
    } catch (...) {
      updateNodeSchemaVersion( "/my/folder", oldFoldSch );
      updateNodeSchemaVersion( "/my", oldFsetSch );
      throw;
    }
    /// 3. Test folderset and folder using their original schema version again
    updateNodeSchemaVersion( "/my", oldFsetSch );
    updateNodeSchemaVersion( "/my/folder", oldFoldSch );
    folderset = s_db->getFolderSet( "/my" );
    CPPUNIT_ASSERT( folderset.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "3. folderset name", std::string( "/my" ), folderset->fullPath() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "3. folderset schema", oldFsetSch, folderset->folderSetAttributes()
        ["NODE_SCHEMA_VERSION"].data<std::string>() );
    folderset->listFolders(); // Should not throw
    folder = s_db->getFolder( "/my/folder" );
    CPPUNIT_ASSERT( folder.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "3. folder name", std::string( "/my/folder" ), folder->fullPath() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "3. folder schema", oldFoldSch, folder->folderAttributes()
        ["NODE_SCHEMA_VERSION"].data<std::string>() );
    folder->folderSpecification(); // Should not throw
  }

  /// Tests what happens when the current API is used
  /// to drop a node with newer schema version 2.0.9
  void test_dropNode_2_0_9()
  {
    setupDb();
    s_db->createFolderSet( "/my" );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    s_db->createFolder( "/my/folder", fSpec );
    std::string newSch("2.0.9");
    //std::string newSch("2.9.0"); // test error recovery in catch(...) clause
    PayloadMode::Mode pMode = cool_PayloadMode_Mode::INLINEPAYLOAD; // no payload table (default)
    std::string oldFoldSch( RelationalFolder::folderSchemaVersion( pMode ) );
    std::string oldFsetSch( RelationalFolderSet::folderSetSchemaVersion() );
    updateNodeSchemaVersion( "/my", newSch );
    updateNodeSchemaVersion( "/my/folder", newSch );
    try {
      s_db->dropNode( "/my/folder" );
      s_db->dropNode( "/my" );
    } catch (...) {
      updateNodeSchemaVersion( "/my/folder", oldFoldSch );
      updateNodeSchemaVersion( "/my", oldFsetSch );
      throw;
    }
  }

  /// Tests what happens when the current API is used
  /// to drop a database containing node with newer schema version 2.0.9
  void test_dropDatabaseWithNode_2_0_9()
  {
    setupDb();
    s_db->createFolderSet( "/my" );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    s_db->createFolder( "/my/folder1", fSpec );
    s_db->createFolder( "/my/folder2", fSpec );
    s_db->createFolder( "/my/folder3", fSpec );
    std::string newSch("2.0.9");
    //std::string newSch("2.9.0"); // test error recovery in catch(...) clause
    PayloadMode::Mode pMode = cool_PayloadMode_Mode::INLINEPAYLOAD; // no payload table (default)
    std::string oldFoldSch( RelationalFolder::folderSchemaVersion( pMode ) );
    updateNodeSchemaVersion( "/my/folder2", newSch );
    try {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      ralDb->dropDatabase();
      transaction.commit();
    } catch (...) {
      updateNodeSchemaVersion( "/my/folder2", oldFoldSch );
      throw;
    }
  }

  /// Tests what happens when the current API is used
  /// to access a node with newer schema version 3.10.0
  void test_useNode_3_10_0()
  {
    setupDb();
    s_db->createFolderSet( "/my" );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec );
    s_db->createFolder( "/my/folder", fSpec, "" );
    std::string newSch("3.10.0");
    PayloadMode::Mode pMode = cool_PayloadMode_Mode::INLINEPAYLOAD; // no payload table (default)
    std::string oldFoldSch( RelationalFolder::folderSchemaVersion( pMode ) );
    std::string oldFsetSch( RelationalFolderSet::folderSetSchemaVersion() );
    /// 1. Test folderset and folder using their original schema version
    IFolderSetPtr folderset;
    IFolderPtr folder;
    folderset = s_db->getFolderSet( "/my" );
    CPPUNIT_ASSERT( folderset.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "1. folderset name", std::string( "/my" ), folderset->fullPath() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "1. folderset schema", oldFsetSch, folderset->folderSetAttributes()
        ["NODE_SCHEMA_VERSION"].data<std::string>() );
    folderset->listFolders(); // Should not throw
    folder = s_db->getFolder( "/my/folder" );
    CPPUNIT_ASSERT( folder.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "1. folder name", std::string( "/my/folder" ), folder->fullPath() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "1. folder schema", oldFoldSch, folder->folderAttributes()
        ["NODE_SCHEMA_VERSION"].data<std::string>() );
    folder->folderSpecification(); // Should not throw
    /// 2. Test folderset and folder using a newer schema version
    updateNodeSchemaVersion( "/my", newSch );
    updateNodeSchemaVersion( "/my/folder", newSch );
    folderset = s_db->getFolderSet( "/my" );
    CPPUNIT_ASSERT( folderset.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "2. folderset name", std::string( "/my" ), folderset->fullPath() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "2. folderset schema", newSch, folderset->folderSetAttributes()
        ["NODE_SCHEMA_VERSION"].data<std::string>() );
    folder = s_db->getFolder( "/my/folder" );
    CPPUNIT_ASSERT( folder.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "2. folder name", std::string( "/my/folder" ), folder->fullPath() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "2. folder schema", newSch, folder->folderAttributes()
        ["NODE_SCHEMA_VERSION"].data<std::string>() );
    try {
      CPPUNIT_ASSERT_THROW
        ( folderset->listFolders(), UnsupportedFolderSetSchema );
      CPPUNIT_ASSERT_THROW
        ( folderset->listFolderSets(), UnsupportedFolderSetSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->folderSpecification(), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->payloadSpecification(), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->versioningMode(), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->setupStorageBuffer(), UnsupportedFolderSchema );
      Record dummyRec( payloadSpec );
      CPPUNIT_ASSERT_THROW
        ( folder->storeObject( 0, 10, dummyRec, 0 ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->flushStorageBuffer(), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->findObject( 0, 0 ), UnsupportedFolderSchema );
      ChannelSelection dummyChSel( 0 );
      CPPUNIT_ASSERT_THROW
        ( folder->findObjects( 0, dummyChSel ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->setPrefetchAll( true ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->browseObjects( 0, 10, dummyChSel ),
          UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->countObjects( 0, 10, dummyChSel ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->renamePayload( "I", "J" ), UnsupportedFolderSchema );
      RecordSpecification extSpec;
      extSpec.extend("I",cool_StorageType_TypeId::Int32);
      Record extRec( extSpec );
      CPPUNIT_ASSERT_THROW
        ( folder->extendPayloadSpecification( extRec ),
          UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->tagCurrentHead( "a" ), UnsupportedFolderSchema );
      Time now;
      CPPUNIT_ASSERT_THROW
        ( folder->insertionTimeOfLastObjectInTag("a"),
          UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->deleteTag( "a" ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->tagHeadAsOfDate( now, "a" ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->existsUserTag( "a" ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->listChannels(), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->listChannelsWithNames(), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->createChannel( 1, "b" ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->setChannelName( 1, "a" ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->channelName( 1 ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->channelId( "a" ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->existsChannel( 0 ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->existsChannel( "a" ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->setChannelDescription( 1, "a" ), UnsupportedFolderSchema );
      CPPUNIT_ASSERT_THROW
        ( folder->channelDescription( 1 ), UnsupportedFolderSchema );
    } catch (...) {
      updateNodeSchemaVersion( "/my/folder", oldFoldSch );
      updateNodeSchemaVersion( "/my", oldFsetSch );
      throw;
    }
    /// 3. Test folderset and folder using their original schema version again
    updateNodeSchemaVersion( "/my", oldFsetSch );
    updateNodeSchemaVersion( "/my/folder", oldFoldSch );
    folderset = s_db->getFolderSet( "/my" );
    CPPUNIT_ASSERT( folderset.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "3. folderset name", std::string( "/my" ), folderset->fullPath() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "3. folderset schema", oldFsetSch, folderset->folderSetAttributes()
        ["NODE_SCHEMA_VERSION"].data<std::string>() );
    folderset->listFolders(); // Should not throw
    folder = s_db->getFolder( "/my/folder" );
    CPPUNIT_ASSERT( folder.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "3. folder name", std::string( "/my/folder" ), folder->fullPath() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "3. folder schema", oldFoldSch, folder->folderAttributes()
        ["NODE_SCHEMA_VERSION"].data<std::string>() );
    folder->folderSpecification(); // Should not throw
  }

  /// Tests what happens when the current API is used
  /// to drop a node with newer schema version 3.10.0
  void test_dropNode_3_10_0()
  {
    setupDb();
    s_db->createFolderSet( "/my" );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    s_db->createFolder( "/my/folder", fSpec );
    std::string newSch("3.10.0");
    PayloadMode::Mode pMode = cool_PayloadMode_Mode::INLINEPAYLOAD; // no payload table (default)
    std::string oldFoldSch( RelationalFolder::folderSchemaVersion( pMode ) );
    std::string oldFsetSch( RelationalFolderSet::folderSetSchemaVersion() );
    updateNodeSchemaVersion( "/my", newSch );
    updateNodeSchemaVersion( "/my/folder", newSch );
    try {
      CPPUNIT_ASSERT_THROW
        ( ralDb->dropNode( "/my/folder" ), Exception );
      CPPUNIT_ASSERT_THROW
        ( ralDb->dropNode( "/my" ), Exception );
    } catch (...) {
      updateNodeSchemaVersion( "/my", oldFsetSch );
      updateNodeSchemaVersion( "/my/folder", oldFoldSch );
      throw;
    }
    updateNodeSchemaVersion( "/my", oldFsetSch );
    updateNodeSchemaVersion( "/my/folder", oldFoldSch );
  }

  /// Tests what happens when the current API is used
  /// to drop a database containing node with newer schema version 3.10.0
  void test_dropDatabaseWithNode_3_10_0()
  {
    setupDb();
    s_db->createFolderSet( "/my" );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    s_db->createFolder( "/my/folder1", fSpec );
    s_db->createFolder( "/my/folder2", fSpec );
    s_db->createFolder( "/my/folder3", fSpec );
    std::string newSch("3.10.0");
    PayloadMode::Mode pMode = cool_PayloadMode_Mode::INLINEPAYLOAD; // no payload table (default)
    std::string oldFoldSch( RelationalFolder::folderSchemaVersion( pMode ) );
    updateNodeSchemaVersion( "/my/folder2", newSch );
    try {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      CPPUNIT_ASSERT_THROW
        ( ralDb->dropDatabase(), Exception );
      transaction.commit();
      IFolderSetPtr folderset = s_db->getFolderSet( "/my" );
      CPPUNIT_ASSERT( folderset.get() != 0 );
      IFolderPtr folder;
      folder = s_db->getFolder( "/my/folder1" );
      CPPUNIT_ASSERT( folder.get() != 0 );
      folder = s_db->getFolder( "/my/folder2" );
      CPPUNIT_ASSERT( folder.get() != 0 );
      folder = s_db->getFolder( "/my/folder3" );
      CPPUNIT_ASSERT( folder.get() != 0 );
    } catch (...) {
      updateNodeSchemaVersion( "/my/folder2", oldFoldSch );
      throw;
    }
    updateNodeSchemaVersion( "/my/folder2", oldFoldSch );
  }

  /// Tests createFolderSet with an invalid name (task #4371 and bug #30751)
  void test_createFolderSet_invalidName()
  {
    setupDb();
    const MSG::Level oldOutputLevel = application().outputLevel();
    application().setOutputLevel( MSG::FATAL );
    try {
      CPPUNIT_ASSERT_THROW
        ( s_db->createFolderSet( "/myfolderset " ),
          HvsPathHandlerException );
      CPPUNIT_ASSERT_THROW
        ( s_db->createFolderSet( "/my\folderset" ),
          HvsPathHandlerException );
      CPPUNIT_ASSERT_THROW
        ( s_db->createFolderSet( "/my folderset" ),
          HvsPathHandlerException );
      CPPUNIT_ASSERT_THROW
        ( s_db->createFolderSet( "/my$folderset" ),
          HvsPathHandlerException );
      s_db->createFolderSet( "/my.folderset" );
      s_db->createFolderSet( "/my-folderset" );
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      application().setOutputLevel( oldOutputLevel );
      throw;
    }
    application().setOutputLevel( oldOutputLevel );
  }

  /// Tests createFolder with an invalid name (task #4371 and bug #30751)
  void test_createFolder_invalidName()
  {
    setupDb();
    const MSG::Level oldOutputLevel = application().outputLevel();
    application().setOutputLevel( MSG::FATAL );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    try
    {
      CPPUNIT_ASSERT_THROW
        ( s_db->createFolder( "/myfolder ", fSpec ),
          HvsPathHandlerException );
      CPPUNIT_ASSERT_THROW
        ( s_db->createFolder( "/my\folder", fSpec ),
          HvsPathHandlerException );
      CPPUNIT_ASSERT_THROW
        ( s_db->createFolder( "/my folder", fSpec ),
          HvsPathHandlerException );
      CPPUNIT_ASSERT_THROW
        ( s_db->createFolder( "/my$folder", fSpec ),
          HvsPathHandlerException );
      s_db->createFolder( "/my.folder", fSpec );
      s_db->createFolder( "/my-folder", fSpec );
    }
    catch ( std::exception& e )
    {
      std::cout << "Exception caught: " << e.what() << std::endl;
      application().setOutputLevel( oldOutputLevel );
      throw;
    }
    application().setOutputLevel( oldOutputLevel );
  }

  /// Tests writing of the folder description
  void test_createFolderSet_description()
  {
    setupDb();
    s_db->createFolderSet( "/myfolder", "my description" );
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalTableRow row( ralDb->fetchNodeTableRow( "/myfolder" ) );
    transaction.commit();
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "db content",
        std::string("my description"),
        row["NODE_DESCRIPTION"].data<std::string>() );
  }

  /// Tests writing of the folder description
  void test_createFolder_description()
  {
    setupDb();
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    IFolderPtr folder = s_db->createFolder( "/myfolder", fSpec, "my description" );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "description from create",
                                  std::string("my description"),
                                  folder->description() );
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalTableRow row( ralDb->fetchNodeTableRow( "/myfolder" ) );
    transaction.commit();
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "db content",
        std::string("my description"),
        row["NODE_DESCRIPTION"].data<std::string>()
        );
  }

  /// Tests getFolderSet
  /// This test only ensures that the returned pointer is not null. The more
  /// detailed test of the folderset read back is in test_RelationalFolderSet.
  void test_getFolderSet()
  {
    setupDb();
    s_db->createFolderSet( "/folderset" );
    IFolderSetPtr folderset = s_db->getFolderSet( "/folderset" );
    CPPUNIT_ASSERT( folderset.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "folderset name test",
                                  std::string( "/folderset" ),
                                  folderset->fullPath() );
  }

  /// Tests getFolder
  /// This test only ensures that the returned pointer is not null. The more
  /// detailed test of the folder read back is in test_RelationalFolder.
  void test_getFolder()
  {
    setupDb();
    std::string folderName( "/myfolder" );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    s_db->createFolder( folderName, fSpec );
    IFolderPtr folder = s_db->getFolder( folderName );
    CPPUNIT_ASSERT( folder.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "folder name test",
                                  folderName,
                                  folder->fullPath() );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "compare object table name",
                                  std::string(s_coolDBName+"_F0001_IOVS"),
                                  relfolder->objectTableName() );
    CPPUNIT_ASSERT_MESSAGE( "compare payload spec",
                            payloadSpec
                            == folder->payloadSpecification() );
  }

  /// Tests folderAttributes for MV folder
  void test_folderAttributes_MV()
  {
    try
    {
      setupDb();
      std::string folderName( "/myfolder" );
      FolderSpecification fSpec( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec );
      s_db->createFolder( folderName, fSpec, "my description" );
      IFolderPtr folder = s_db->getFolder( folderName );
      CPPUNIT_ASSERT( folder.get() != 0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "folder name test",
          folderName,
          folder->fullPath() );
      TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
      if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
      RelationalFolder* relfolder = trelfolder->getRelFolder();
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "compare object table name",
          std::string(s_coolDBName+"_F0001_IOVS"),
          relfolder->objectTableName() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "compare tag table name",
          std::string(s_coolDBName+"_F0001_TAGS"),
          relfolder->tagTableName() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "compare object2tag table name",
          std::string(s_coolDBName+"_F0001_IOV2TAG"),
          relfolder->object2TagTableName() );
      CPPUNIT_ASSERT_MESSAGE
        ( "compare payload spec",
          payloadSpec == folder->payloadSpecification() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "compare object table name from folder properties",
          std::string(s_coolDBName+"_F0001_IOVS"),
          relfolder->folderAttributes()[ "FOLDER_IOVTABLENAME" ]
          .data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "compare tag table name from folder properties",
          std::string(s_coolDBName+"_F0001_TAGS"),
          relfolder->folderAttributes()[ "FOLDER_TAGTABLENAME" ]
          .data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "compare object2tag table name from folder properties",
          std::string(s_coolDBName+"_F0001_IOV2TAG"),
          relfolder->folderAttributes()[ "FOLDER_IOV2TAGTABLENAME" ]
          .data<std::string>() );
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests folderAttributes for SV folder
  void test_folderAttributes_SV()
  {
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    try
    {
      setupDb();
      std::string folderName( "/myfolder" );
      s_db->createFolder( folderName, fSpec, "my description" );
      IFolderPtr folder = s_db->getFolder( folderName );
      CPPUNIT_ASSERT( folder.get() != 0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "folder name test",
          folderName,
          folder->fullPath() );
      TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
      if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
      RelationalFolder* relfolder = trelfolder->getRelFolder();
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "compare object table name",
          std::string(s_coolDBName+"_F0001_IOVS"),
          relfolder->objectTableName() );
      CPPUNIT_ASSERT_MESSAGE
        ( "compare payload spec",
          payloadSpec == folder->payloadSpecification() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "compare object table name from folder properties",
          std::string(s_coolDBName+"_F0001_IOVS"),
          relfolder->folderAttributes()[ "FOLDER_IOVTABLENAME" ]
          .data<std::string>() );
      try {
        relfolder->folderAttributes()
          [ "FOLDER_TAGTABLENAME" ].data<std::string>();
        CPPUNIT_ASSERT_MESSAGE
          ( "exception expected for FOLDER_TAGTABLENAME", false );
      } catch ( RecordSpecificationUnknownField& e ) {
        RecordSpecificationUnknownField exp( "FOLDER_TAGTABLENAME", "" );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "exception message for FOLDER_TAGTABLENAME",
            std::string( exp.what() ), std::string( e.what() ) );
      }
      try {
        relfolder->folderAttributes()
          [ "FOLDER_IOV2TAGTABLENAME" ].data<std::string>();
        CPPUNIT_ASSERT_MESSAGE
          ( "exception expected for FOLDER_IOV2TAGTABLENAME", false );
      } catch ( RecordSpecificationUnknownField& e ) {
        RecordSpecificationUnknownField exp( "FOLDER_IOV2TAGTABLENAME", "" );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "exception message for FOLDER_IOV2TAGTABLENAME",
            std::string( exp.what() ), std::string( e.what() ) );
      }
      CPPUNIT_ASSERT_EQUAL
        ( std::string(s_coolDBName+"_F0001_CHANNELS"),
          relfolder->folderAttributes
          ()[ "FOLDER_CHANNELTABLENAME" ].data<std::string>() );
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests that an exception is thrown when an invalid versioning mode
  /// is specified on folder creation
  void test_createFolder_invalidVersioningMode()
  {
    setupDb();
#ifndef COOL300DP
#if defined(__GNUC__) && defined (__GNUC_MINOR__) && ( (__GNUC__==4 && __GNUC_MINOR__ >=6 ) || __GNUC__>4 )
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#endif
    CPPUNIT_ASSERT_THROW( s_db->createFolder( "/myfolder",
                                              payloadSpec,
                                              "my description",
                                              // invalid mode
                                              (FolderVersioning::Mode)-10 ),
                          InvalidFolderSpecification );
#if defined(__GNUC__) && defined (__GNUC_MINOR__) && ( (__GNUC__==4 && __GNUC_MINOR__ >=6 ) || __GNUC__>4 )
#pragma GCC diagnostic pop
#endif
#endif
    CPPUNIT_ASSERT_THROW( FolderSpecification( cool_FolderVersioning_Mode::NONE, payloadSpec ), InvalidFolderSpecification ); // test bug #103343
    CPPUNIT_ASSERT_THROW( FolderSpecification( (FolderVersioning::Mode)-10, payloadSpec ), InvalidFolderSpecification ); // test bug #103343
  }

  /// Tests creating a folder in MV mode
  void test_createFolder_MV()
  {
    setupDb();
    FolderSpecification fSpec( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec );
    IFolderPtr folder = s_db->createFolder( "/myfolder", fSpec, "my description" );
    CPPUNIT_ASSERT( folder.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "versioning mode",
                                  cool_FolderVersioning_Mode::MULTI_VERSION,
                                  folder->versioningMode() );
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      RelationalTableRow row( ralDb->fetchNodeTableRow( "/myfolder" ) );
      transaction.commit();
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "FOLDER_VERSIONING", (int)cool_FolderVersioning_Mode::MULTI_VERSION,
          row["FOLDER_VERSIONING"].data<int>() );
    }
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      CPPUNIT_ASSERT_MESSAGE
        ( "object table existence",
          ralDb->queryMgr().existsTable( s_coolDBName + "_F0001_IOVS" ) );
      CPPUNIT_ASSERT_MESSAGE
        ( "tag table existence",
          ralDb->queryMgr().existsTable( s_coolDBName + "_F0001_TAGS" ) );
      CPPUNIT_ASSERT_MESSAGE
        ( "iov2tag table existence",
          ralDb->queryMgr().existsTable( s_coolDBName + "_F0001_IOV2TAG" ) );
      transaction.commit();
    }
  }

  /// Tests creating a folder in MV with separate payload table mode
  void test_createFolder_MV_sepPayload()
  {
    setupDb();
#ifdef COOL290VP
    FolderSpecification folderSpec( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec, cool_PayloadMode_Mode::SEPARATEPAYLOAD );
#else
    FolderSpecification folderSpec( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec );
    folderSpec.hasPayloadTable() = true;
#endif
    IFolderPtr folder = s_db->createFolder( "/myfolder",
                                            folderSpec,
                                            "my description" );
    CPPUNIT_ASSERT( folder.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "versioning mode",
                                  cool_FolderVersioning_Mode::MULTI_VERSION,
                                  folder->versioningMode() );
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      RelationalTableRow row( ralDb->fetchNodeTableRow( "/myfolder" ) );
      transaction.commit();
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "FOLDER_VERSIONING", (int)cool_FolderVersioning_Mode::MULTI_VERSION,
          row["FOLDER_VERSIONING"].data<int>() );
    }
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      CPPUNIT_ASSERT_MESSAGE
        ( "object table existence",
          ralDb->queryMgr().existsTable( s_coolDBName + "_F0001_IOVS" ) );
      CPPUNIT_ASSERT_MESSAGE
        ( "tag table existence",
          ralDb->queryMgr().existsTable( s_coolDBName + "_F0001_TAGS" ) );
      CPPUNIT_ASSERT_MESSAGE
        ( "iov2tag table existence",
          ralDb->queryMgr().existsTable( s_coolDBName + "_F0001_IOV2TAG" ) );
      CPPUNIT_ASSERT_MESSAGE
        ( "payload table existence",
          ralDb->queryMgr().existsTable( s_coolDBName + "_F0001_PAYLOAD" ) );
      transaction.commit();
    }
  }

  /// Tests creating a folder in MV with vector payload table mode
  void test_createFolder_MV_vector()
  {
#ifdef COOL290VP
    setupDb();
    FolderSpecification folderSpec( cool_FolderVersioning_Mode::MULTI_VERSION,
                                    payloadSpec,
                                    cool_PayloadMode_Mode::VECTORPAYLOAD );
    IFolderPtr folder = s_db->createFolder( "/myfolder",
                                            folderSpec,
                                            "my description" );
    CPPUNIT_ASSERT( folder.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "versioning mode",
                                  cool_FolderVersioning_Mode::MULTI_VERSION,
                                  folder->versioningMode() );
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      RelationalTableRow row( ralDb->fetchNodeTableRow( "/myfolder" ) );
      transaction.commit();
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "FOLDER_VERSIONING", (int)cool_FolderVersioning_Mode::MULTI_VERSION,
          row["FOLDER_VERSIONING"].data<int>() );
    }
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      CPPUNIT_ASSERT_MESSAGE
        ( "object table existence",
          ralDb->queryMgr().existsTable( s_coolDBName + "_F0001_IOVS" ) );
      CPPUNIT_ASSERT_MESSAGE
        ( "tag table existence",
          ralDb->queryMgr().existsTable( s_coolDBName + "_F0001_TAGS" ) );
      CPPUNIT_ASSERT_MESSAGE
        ( "iov2tag table existence",
          ralDb->queryMgr().existsTable( s_coolDBName + "_F0001_IOV2TAG" ) );
      CPPUNIT_ASSERT_MESSAGE
        ( "payload table existence",
          ralDb->queryMgr().existsTable( s_coolDBName + "_F0001_PAYLOAD" ) );
      transaction.commit();
    }
#endif
  }

  /// Tests createFolder in SV mode
  void test_createFolder_SV()
  {
    setupDb();
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    std::string folderName( "/myfolder" );
    IFolderPtr folder = s_db->createFolder( folderName, fSpec );
    CPPUNIT_ASSERT( folder.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "folder name test",
                                  std::string("/myfolder"),
                                  folder->fullPath() );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "object table name",
                                  std::string(s_coolDBName+"_F0001_IOVS"),
                                  relfolder->objectTableName() );
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      CPPUNIT_ASSERT_MESSAGE
        ( "object table existence",
          ralDb->queryMgr().existsTable( s_coolDBName + "_F0001_IOVS" ) );
      CPPUNIT_ASSERT
        ( ralDb->queryMgr().existsTable( s_coolDBName + "_F0001_CHANNELS" ) );
      transaction.commit();
    }
  }

  /// Tests createFolder when the given folder already exists
  void test_createFolder_alreadyExists()
  {
    setupDb();
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    s_db->createFolder( "/myfolder", fSpec );
    // expected to throw a RelationalNodeExists exception
    CPPUNIT_ASSERT_THROW( s_db->createFolder( "/myfolder", fSpec ),
                          NodeExists );
  }

  /// Tests createFolder with createParents = true
  void test_createFolder_withParents()
  {
    setupDb();
    std::string folderName( "/a/b/c" );
    bool createParents = true;
    std::string description = "";
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    IFolderPtr folder = s_db->createFolder( folderName,
                                            fSpec,
                                            description,
                                            createParents );
    CPPUNIT_ASSERT_MESSAGE( "/a/b/c not null", folder.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "/a/b/c folder name test",
                                  std::string("/a/b/c"),
                                  folder->fullPath() );
    IFolderSetPtr folderset = s_db->getFolderSet( "/a/b" );
    CPPUNIT_ASSERT_MESSAGE( "/a/b not null", folderset.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "/a/b folderset name test",
                                  std::string("/a/b"),
                                  folderset->fullPath() );
    folderset = s_db->getFolderSet( "/a" );
    CPPUNIT_ASSERT_MESSAGE( "/a not null", folderset.get() != 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "/a folder name test",
                                  std::string("/a"),
                                  folderset->fullPath() );
  }

  /// Tests existsNode
  void test_existsNode()
  {
    setupDb();
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    s_db->createFolder( "/myfolder", fSpec );
    s_db->createFolderSet( "/myfolderset" );
    RelationalTransaction transaction( ralDb->transactionMgr(), true );
    CPPUNIT_ASSERT_MESSAGE( "myfolder",
                            ralDb->existsNode( "/myfolder" ) );
    CPPUNIT_ASSERT_MESSAGE( "myfolderset",
                            ralDb->existsNode( "/myfolderset" ) );
    CPPUNIT_ASSERT_MESSAGE( "negative test",
                            !ralDb->existsNode( "/nofolder" ) );
    transaction.commit();
  }

  /// Tests existsFolderSet
  void test_existsFolderSet()
  {
    setupDb();
    CPPUNIT_ASSERT_MESSAGE( "folderset does not exist yet",
                            ! s_db->existsFolderSet( "/myfolderset" ) );
    s_db->createFolderSet( "/myfolderset" );
    CPPUNIT_ASSERT_MESSAGE( "folderset exists",
                            s_db->existsFolderSet( "/myfolderset" ) );
  }

  /// Tests existsFolder
  void test_existsFolder()
  {
    setupDb();
    CPPUNIT_ASSERT_MESSAGE( "folder does not exist yet",
                            ! s_db->existsFolder( "/myfolder" ) );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    s_db->createFolder( "/myfolder", fSpec );
    CPPUNIT_ASSERT_MESSAGE( "folder exists",
                            s_db->existsFolder( "/myfolder" ) );
  }

  /// Tests createFolder
  void test_createFolderSet_alreadyExists()
  {
    setupDb();
    s_db->createFolderSet( "/myfolder" );
    // expected to throw a RelationalNodeExists exception
    CPPUNIT_ASSERT_THROW( s_db->createFolderSet( "/myfolder" ),
                          NodeExists );
  }

  /// Tests createFolderSet
  void test_createFolderSet()
  {
    setupDb();
    s_db->createFolderSet( "/myfolderset", "my description" );
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalTableRow row = ralDb->fetchNodeTableRow( "/myfolderset" );
    transaction.commit();
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "NODE_ID", 1u,
        row["NODE_ID"].data<unsigned int>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "NODE_PARENTID", 0u,
        row["NODE_PARENTID"].data<unsigned int>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "NODE_NAME", std::string("myfolderset"),
        row["NODE_NAME"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "NODE_FULLPATH", std::string("/myfolderset"),
        row["NODE_FULLPATH"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "NODE_DESCRIPTION", std::string("my description"),
        row["NODE_DESCRIPTION"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "NODE_ISLEAF", false,
        row["NODE_ISLEAF"].data<bool>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "NODE_INSTIME length",
        std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
        row["NODE_INSTIME"].data<std::string>().size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "FOLDER_PAYLOADSPEC", std::string(""),
        row["FOLDER_PAYLOADSPEC"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "FOLDER_VERSIONING", (int)cool_FolderVersioning_Mode::NONE,
        row["FOLDER_VERSIONING"].data<int>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "FOLDER_IOVTABLENAME", std::string(""),
        row["FOLDER_IOVTABLENAME"].data<std::string>() );
  }

  /// Tests dropAllNodes
  void test_dropAllNodes() {
    setupDb();
    std::vector<std::string> folderNames;
    folderNames.push_back( "/f1" );
    folderNames.push_back( "/f2" );
    folderNames.push_back( "/f3" );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    for ( std::vector<std::string>::const_iterator f = folderNames.begin();
          f != folderNames.end();
          ++f )
    {
      s_db->createFolder( *f, fSpec );
    }
    for ( std::vector<std::string>::const_iterator f = folderNames.begin();
          f != folderNames.end();
          ++f )
    {
      CPPUNIT_ASSERT_MESSAGE( std::string("folder exists: ") + *f,
                              s_db->existsFolder( *f ) );
    }
    RelationalTransaction transaction( ralDb->transactionMgr() );
    ralDb->dropAllNodes();
    transaction.commit();
    for ( std::vector<std::string>::const_iterator f = folderNames.begin();
          f != folderNames.end();
          ++f ) {
      CPPUNIT_ASSERT_MESSAGE( std::string("folder is deleted: ") + *f,
                              ! s_db->existsFolder( *f ) );
    }
  }

  /// Tests dropNode
  void test_dropNode()
  {
    setupDb();
    try
    {
      {
        // Test dropping a SV folder
        FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
        IFolderPtr folder = s_db->createFolder( "/myfolder_sv", fSpec );
        CPPUNIT_ASSERT_MESSAGE( "/myfolder_sv exists",
                                s_db->existsFolder( "/myfolder_sv" ) );
        std::stringstream prefix;
        prefix << s_coolDBName << "_F000" << folder->id();
        {
          RelationalTransaction transaction( ralDb->transactionMgr() );
          CPPUNIT_ASSERT_MESSAGE
            ( "SV object table exists",
              ralDb->queryMgr().existsTable( prefix.str() + "_IOVS" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "SV object sequence exists",
              ralDb->queryMgr().existsTable( prefix.str() + "_IOVS_SEQ" ) );
          transaction.commit();
        }
        s_db->dropNode( "/myfolder_sv" );
        CPPUNIT_ASSERT_MESSAGE
          ( "/folder_sv is deleted",
            ! s_db->existsFolder( "/myfolder_sv" ) );
        {
          RelationalTransaction transaction( ralDb->transactionMgr() );
          CPPUNIT_ASSERT_MESSAGE
            ( "SV object table removed",
              ! ralDb->queryMgr().existsTable( prefix.str() + "_IOVS" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "SV object sequence removed",
              ! ralDb->queryMgr().existsTable( prefix.str() + "_IOVS_SEQ" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "SV tag table removed",
              ! ralDb->queryMgr().existsTable( prefix.str() + "_TAGS" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "SV tag sequence removed",
              ! ralDb->queryMgr().existsTable( prefix.str() + "_TAGS_SEQ" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "SV iov2tag table removed",
              ! ralDb->queryMgr().existsTable( prefix.str() + "_IOV2TAG" ) );
          transaction.commit();
        }
      }
      {
        // Test dropping a MV folder
        FolderSpecification fSpec( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec );
        IFolderPtr folder = s_db->createFolder( "/myfolder_mv", fSpec, "" );
        CPPUNIT_ASSERT_MESSAGE( "/myfolder_mv exists",
                                s_db->existsFolder( "/myfolder_mv" ) );
        std::stringstream prefix;
        prefix << s_coolDBName << "_F000" << folder->id();
        {
          RelationalTransaction transaction( ralDb->transactionMgr() );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV object table exists",
              ralDb->queryMgr().existsTable( prefix.str() + "_IOVS" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV object sequence exists",
              ralDb->queryMgr().existsTable( prefix.str() + "_IOVS_SEQ" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV tag table exists",
              ralDb->queryMgr().existsTable( prefix.str() + "_TAGS" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV tag sequence exists",
              ralDb->queryMgr().existsTable( prefix.str() + "_TAGS_SEQ" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV iov2tag table exists",
              ralDb->queryMgr().existsTable( prefix.str() + "_IOV2TAG" ) );
          transaction.commit();
        }
        s_db->dropNode( "/myfolder_mv" );
        CPPUNIT_ASSERT_MESSAGE
          ( "/folder_mv is deleted",
            ! s_db->existsFolder( "/myfolder_mv" ) );
        {
          RelationalTransaction transaction( ralDb->transactionMgr() );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV object table removed",
              ! ralDb->queryMgr().existsTable( prefix.str() + "_IOVS" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV object sequence removed",
              ! ralDb->queryMgr().existsTable( prefix.str() + "_IOVS_SEQ" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV tag table removed",
              ! ralDb->queryMgr().existsTable( prefix.str() + "_TAGS" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV tag sequence removed",
              ! ralDb->queryMgr().existsTable( prefix.str() + "_TAGS_SEQ" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV iov2tag table removed",
              ! ralDb->queryMgr().existsTable( prefix.str() + "_IOV2TAG" ) );
          transaction.commit();
        }
      }
      {
        // Test dropping a MV folder with separate payload table
#ifdef COOL290VP
        FolderSpecification folderSpec( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec, cool_PayloadMode_Mode::SEPARATEPAYLOAD );
#else
        FolderSpecification folderSpec( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec);
        folderSpec.hasPayloadTable() = true;
#endif
        IFolderPtr folder = s_db->createFolder( "/myfolder_mv", folderSpec, "");
        CPPUNIT_ASSERT_MESSAGE( "/myfolder_mv exists",
                                s_db->existsFolder( "/myfolder_mv" ) );
        std::stringstream prefix;
        prefix << s_coolDBName << "_F000" << folder->id();
        {
          RelationalTransaction transaction( ralDb->transactionMgr() );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV object table exists",
              ralDb->queryMgr().existsTable( prefix.str() + "_IOVS" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV object sequence exists",
              ralDb->queryMgr().existsTable( prefix.str() + "_IOVS_SEQ" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV tag table exists",
              ralDb->queryMgr().existsTable( prefix.str() + "_TAGS" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV tag sequence exists",
              ralDb->queryMgr().existsTable( prefix.str() + "_TAGS_SEQ" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV iov2tag table exists",
              ralDb->queryMgr().existsTable( prefix.str() + "_IOV2TAG" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV payload table exists",
              ralDb->queryMgr().existsTable( prefix.str() + "_PAYLOAD" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV payload sequence table exists",
              ralDb->queryMgr().existsTable( prefix.str() + "_PAYLOAD_SEQ" ) );
          transaction.commit();
        }
        s_db->dropNode( "/myfolder_mv" );
        CPPUNIT_ASSERT_MESSAGE
          ( "/folder_mv is deleted",
            ! s_db->existsFolder( "/myfolder_mv" ) );
        {
          RelationalTransaction transaction( ralDb->transactionMgr() );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV object table removed",
              ! ralDb->queryMgr().existsTable( prefix.str() + "_IOVS" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV object sequence removed",
              ! ralDb->queryMgr().existsTable( prefix.str() + "_IOVS_SEQ" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV tag table removed",
              ! ralDb->queryMgr().existsTable( prefix.str() + "_TAGS" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV tag sequence removed",
              ! ralDb->queryMgr().existsTable( prefix.str() + "_TAGS_SEQ" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV iov2tag table removed",
              ! ralDb->queryMgr().existsTable( prefix.str() + "_IOV2TAG" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV payload table removed",
              ! ralDb->queryMgr().existsTable( prefix.str() + "_PAYLOAD" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV payload sequence table removed",
              ! ralDb->queryMgr().existsTable
              ( prefix.str() + "_PAYLOAD_SEQ" ) );
          transaction.commit();
        }
      }
#ifdef COOL290VP
      {
        // Test dropping a MV folder with vector payload table
        FolderSpecification folderSpec( cool_FolderVersioning_Mode::MULTI_VERSION,
                                        payloadSpec,
                                        cool_PayloadMode_Mode::VECTORPAYLOAD );
        IFolderPtr
          folder = s_db->createFolder( "/myfolder_mv", folderSpec,"" );
        CPPUNIT_ASSERT_MESSAGE( "/myfolder_mv exists",
                                s_db->existsFolder( "/myfolder_mv" ) );
        std::stringstream prefix;
        prefix << s_coolDBName << "_F000" << folder->id();
        {
          RelationalTransaction transaction( ralDb->transactionMgr() );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV object table exists",
              ralDb->queryMgr().existsTable( prefix.str() + "_IOVS" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV object sequence exists",
              ralDb->queryMgr().existsTable( prefix.str() + "_IOVS_SEQ" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV tag table exists",
              ralDb->queryMgr().existsTable( prefix.str() + "_TAGS" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV tag sequence exists",
              ralDb->queryMgr().existsTable( prefix.str() + "_TAGS_SEQ" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV iov2tag table exists",
              ralDb->queryMgr().existsTable( prefix.str() + "_IOV2TAG" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV payload table exists",
              ralDb->queryMgr().existsTable( prefix.str() + "_PAYLOAD" ) );
          //CPPUNIT_ASSERT_MESSAGE
          //  ( "MV payload sequence table exists",
          //    ralDb->queryMgr().existsTable( prefix.str() + "_PAYLOAD_SEQ" ) );
          transaction.commit();
        }
        s_db->dropNode( "/myfolder_mv" );
        CPPUNIT_ASSERT_MESSAGE
          ( "/folder_mv is deleted",
            ! s_db->existsFolder( "/myfolder_mv" ) );
        {
          RelationalTransaction transaction( ralDb->transactionMgr() );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV object table removed",
              ! ralDb->queryMgr().existsTable( prefix.str() + "_IOVS" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV object sequence removed",
              ! ralDb->queryMgr().existsTable( prefix.str() + "_IOVS_SEQ" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV tag table removed",
              ! ralDb->queryMgr().existsTable( prefix.str() + "_TAGS" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV tag sequence removed",
              ! ralDb->queryMgr().existsTable( prefix.str() + "_TAGS_SEQ" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV iov2tag table removed",
              ! ralDb->queryMgr().existsTable( prefix.str() + "_IOV2TAG" ) );
          CPPUNIT_ASSERT_MESSAGE
            ( "MV payload table removed",
              ! ralDb->queryMgr().existsTable( prefix.str() + "_PAYLOAD" ) );
          //CPPUNIT_ASSERT_MESSAGE
          //  ( "MV payload sequence table removed",
          //    ! ralDb->queryMgr().existsTable
          //    ( prefix.str() + "_PAYLOAD_SEQ" ) );
          transaction.commit();
        }
      }
#endif
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests listAllNodes
  void test_listAllNodes()
  {
    setupDb();
    s_db->createFolderSet( "/f1" );
    s_db->createFolderSet( "/f2" );
    s_db->createFolderSet( "/f3" );
    s_db->createFolderSet( "/f4" );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    s_db->createFolder( "/f1/folderA", fSpec );
    s_db->createFolder( "/f1/folderB", fSpec );
    s_db->createFolder( "/f3/folderA", fSpec );
    s_db->createFolder( "/f3/folderB", fSpec );
    RelationalTransaction transaction( ralDb->transactionMgr() );
    std::vector<std::string> readbackNames = ralDb->listAllNodes();
    transaction.commit();
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "node count",
                                  (size_t)9, readbackNames.size() );
    CPPUNIT_ASSERT_MESSAGE( "/f1",
                            find( readbackNames.begin(), readbackNames.end(),
                                  "/f1" ) != readbackNames.end() );
    CPPUNIT_ASSERT_MESSAGE( "/f2",
                            find( readbackNames.begin(), readbackNames.end(),
                                  "/f2" ) != readbackNames.end() );
    CPPUNIT_ASSERT_MESSAGE( "/f3",
                            find( readbackNames.begin(), readbackNames.end(),
                                  "/f3" ) != readbackNames.end() );
    CPPUNIT_ASSERT_MESSAGE( "/f4",
                            find( readbackNames.begin(), readbackNames.end(),
                                  "/f4" ) != readbackNames.end() );
    CPPUNIT_ASSERT_MESSAGE( "/f1/folderA",
                            find( readbackNames.begin(), readbackNames.end(),
                                  "/f1/folderA" ) != readbackNames.end() );
    CPPUNIT_ASSERT_MESSAGE( "/f1/folderB",
                            find( readbackNames.begin(), readbackNames.end(),
                                  "/f3/folderB" ) != readbackNames.end() );
    CPPUNIT_ASSERT_MESSAGE( "/f3/folderA",
                            find( readbackNames.begin(), readbackNames.end(),
                                  "/f3/folderA" ) != readbackNames.end() );
    CPPUNIT_ASSERT_MESSAGE( "/f3/folderB",
                            find( readbackNames.begin(), readbackNames.end(),
                                  "/f3/folderB" ) != readbackNames.end() );
    CPPUNIT_ASSERT_MESSAGE( "root",
                            find( readbackNames.begin(), readbackNames.end(),
                                  "/" ) != readbackNames.end() );
  }

  /// Tests listAllTables
  void test_listAllTables()
  {
    setupDb();
    s_db->createFolderSet( "/f1" );
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    s_db->createFolder( "/f1/folderA", fSpec );
    s_db->createFolder( "/f1/folderB", fSpec );
    RelationalTransaction transaction( ralDb->transactionMgr() );
    std::vector<std::string> tables = ralDb->listAllTables();
    transaction.commit();
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "tables count", (size_t)14, tables.size() );
    std::vector<std::string> suffixes;
    suffixes.push_back( "_DB_ATTRIBUTES" );
    suffixes.push_back( "_F0000_TAGS_SEQ" );
    suffixes.push_back( "_F0001_TAGS_SEQ" );
    suffixes.push_back( "_F0002_CHANNELS" );
    suffixes.push_back( "_F0002_IOVS" );
    suffixes.push_back( "_F0002_IOVS_SEQ" );
    suffixes.push_back( "_F0003_CHANNELS" );
    suffixes.push_back( "_F0003_IOVS" );
    suffixes.push_back( "_F0003_IOVS_SEQ" );
    suffixes.push_back( "_NODES" );
    suffixes.push_back( "_NODES_SEQ" );
    suffixes.push_back( "_TAG2TAG" );
    suffixes.push_back( "_TAG2TAG_SEQ" );
    suffixes.push_back( "_TAGS" );
    std::vector<std::string>::const_iterator suffix;
    for ( suffix = suffixes.begin(); suffix != suffixes.end(); suffix++ )
    {
      std::string table;
      table = s_coolDBName + *suffix;
      CPPUNIT_ASSERT_MESSAGE
        ( table, find( tables.begin(), tables.end(), table ) != tables.end() );
    }
  }

  /// Tests insertNodeTableRow for a leaf node
  /// [NB - This test bypasses the public API and causes data corruption!]
  /// [Cleanup fails unless exception throwing in dropDatabase() is disabled]
  void test_insertNodeTableRow_leaf() {
    setupDb();
    bool createParents = true;
    bool isLeaf = true;
    std::string payloadSpecDesc = "I:int";
    try {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      unsigned int nodeId =
        ralDb->insertNodeTableRow( "/a/b/c",
                                   "my description",
                                   createParents,
                                   isLeaf,
                                   payloadSpecDesc,
                                   cool_FolderVersioning_Mode::SINGLE_VERSION );
      RelationalTableRow row( ralDb->fetchNodeTableRow( "/a/b/c" ) );
      transaction.commit();
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "return value", 3u, nodeId );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "NODE_ID", 3u,
          row["NODE_ID"].data<unsigned int>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "NODE_PARENTID", 2u,
          row["NODE_PARENTID"].data<unsigned int>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "NODE_NAME", std::string("c"),
          row["NODE_NAME"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "NODE_FULLPATH", std::string("/a/b/c"),
          row["NODE_FULLPATH"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "NODE_DESCRIPTION", std::string("my description"),
          row["NODE_DESCRIPTION"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "NODE_ISLEAF", true,
          row["NODE_ISLEAF"].data<bool>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "NODE_INSTIME length",
          std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
          row["NODE_INSTIME"].data<std::string>().size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "FOLDER_PAYLOADSPEC", std::string("I:int"),
          row["FOLDER_PAYLOADSPEC"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "FOLDER_VERSIONING",
          (int)cool_FolderVersioning_Mode::SINGLE_VERSION,
          row["FOLDER_VERSIONING"].data<int>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "FOLDER_IOVTABLENAME",
          std::string(s_coolDBName+"_F0003_IOVS"),
          row["FOLDER_IOVTABLENAME"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "FOLDER_TAGTABLENAME",
          std::string(s_coolDBName+"_F0003_TAGS"),
          row["FOLDER_TAGTABLENAME"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "FOLDER_IOV2TAGTABLENAME",
          std::string(s_coolDBName+"_F0003_IOV2TAG"),
          row["FOLDER_IOV2TAGTABLENAME"].data<std::string>() );
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests insertNodeTableRow for a nonleaf node
  void test_insertNodeTableRow_nonleaf() {
    setupDb();
    bool createParents = true;
    bool isLeaf = false;
    std::string payloadSpecDesc = "";
    RelationalTransaction transaction( ralDb->transactionMgr() );
    unsigned int nodeId
      = ralDb->insertNodeTableRow( "/a/b/c",
                                   "my description",
                                   createParents,
                                   isLeaf,
                                   payloadSpecDesc,
                                   cool_FolderVersioning_Mode::NONE );
    RelationalTableRow row( ralDb->fetchNodeTableRow( "/a/b/c" ) );
    transaction.commit();
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "return value", 3u, nodeId );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "NODE_ID", 3u,
        row["NODE_ID"].data<unsigned int>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "NODE_PARENTID", 2u,
        row["NODE_PARENTID"].data<unsigned int>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "NODE_NAME", std::string("c"),
        row["NODE_NAME"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "NODE_FULLPATH", std::string("/a/b/c"),
        row["NODE_FULLPATH"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "NODE_DESCRIPTION", std::string("my description"),
        row["NODE_DESCRIPTION"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "NODE_ISLEAF", false,
        row["NODE_ISLEAF"].data<bool>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "NODE_INSTIME length",
        std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
        row["NODE_INSTIME"].data<std::string>().size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "FOLDER_PAYLOADSPEC", std::string(""),
        row["FOLDER_PAYLOADSPEC"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "FOLDER_VERSIONING", (int)cool_FolderVersioning_Mode::NONE,
        row["FOLDER_VERSIONING"].data<int>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "FOLDER_IOVTABLENAME", std::string(""),
        row["FOLDER_IOVTABLENAME"].data<std::string>() );
  }

  /// utility method to test AttributeList handling
  RelationalTableRow nestedScope( RalDatabase* aDb,
                                  const std::string& foldername ) {
    static int callDepth = 0;
    if ( callDepth < 10 ) {
      ++callDepth;
      return nestedScope( aDb, foldername );
    } else {
      callDepth = 0;
      return aDb->fetchNodeTableRow( foldername );
    }
  }

  /// Tests copying of AttributeList from the fetch methods
  void test_fetchNodeTableRow_nestedScope() {
    setupDb();
    bool createParents = true;
    bool isLeaf = false;
    std::string payloadSpecDesc = "";
    RelationalTransaction transaction( ralDb->transactionMgr() );
    ralDb->insertNodeTableRow( "/myfolder",
                               "my description",
                               createParents,
                               isLeaf,
                               payloadSpecDesc,
                               cool_FolderVersioning_Mode::NONE );
    RelationalTableRow row( nestedScope( ralDb, "/myfolder" ) );
    transaction.commit();
    CPPUNIT_ASSERT_EQUAL( std::string("/myfolder"),
                          row["NODE_FULLPATH"].data<std::string>() );
  }

  /// Tests fetchNodeTableRow
  void test_fetchNodeTableRow() {
    try {
      setupDb();
      bool createParents = true;
      bool isLeaf = false;
      std::string payloadSpecDesc = "";
      RelationalTransaction transaction( ralDb->transactionMgr() );
      ralDb->insertNodeTableRow( "/myfolder",
                                 "my description",
                                 createParents,
                                 isLeaf,
                                 payloadSpecDesc,
                                 cool_FolderVersioning_Mode::NONE );
      RelationalTableRow row( ralDb->fetchNodeTableRow( "/myfolder" ) );
      transaction.commit();
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "NODE_ID", 1u,
          row["NODE_ID"].data<unsigned int>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "NODE_PARENTID", 0u,
          row["NODE_PARENTID"].data<unsigned int>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "NODE_NAME", std::string("myfolder"),
          row["NODE_NAME"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "NODE_FULLPATH", std::string("/myfolder"),
          row["NODE_FULLPATH"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "NODE_DESCRIPTION", std::string("my description"),
          row["NODE_DESCRIPTION"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "NODE_ISLEAF", false,
          row["NODE_ISLEAF"].data<bool>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "NODE_INSTIME length",
          std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
          row["NODE_INSTIME"].data<std::string>().size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "FOLDER_PAYLOADSPEC", std::string(""),
          row["FOLDER_PAYLOADSPEC"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "FOLDER_VERSIONING",
          (int)cool_FolderVersioning_Mode::NONE,
          row["FOLDER_VERSIONING"].data<int>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "FOLDER_IOVTABLENAME", std::string(""),
          row["FOLDER_IOVTABLENAME"].data<std::string>() );
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests insertNodeTableRow
  /// (if this fails, test_fetchNodeTableRow will also fail)
  void test_insertNodeTableRow() {
    try {
      setupDb();
      bool createParents = true;
      bool isLeaf = false;
      std::string payloadSpecDesc = "";
      RelationalTransaction transaction( ralDb->transactionMgr() );
      ralDb->insertNodeTableRow( "/myfolder",
                                 "my description",
                                 createParents,
                                 isLeaf,
                                 payloadSpecDesc,
                                 cool_FolderVersioning_Mode::NONE );
      transaction.commit();
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests fetchRootNodeTableRow
  /// (if this fails, test_insertNodeTableRow will also fail)
  void test_fetchRootNodeTableRow() {
    try {
      setupDb();
      RelationalTransaction transaction( ralDb->transactionMgr(), true );
      RelationalTableRow row( ralDb->fetchNodeTableRow( "/" ) );
      transaction.commit();
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "NODE_ID", 0u,
          row["NODE_ID"].data<unsigned int>() );
      CPPUNIT_ASSERT_MESSAGE
        ( "NODE_PARENTID", row["NODE_PARENTID"].isNull() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "NODE_NAME", std::string(""),
          row["NODE_NAME"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "NODE_FULLPATH", std::string("/"),
          row["NODE_FULLPATH"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "NODE_DESCRIPTION", std::string(""),
          row["NODE_DESCRIPTION"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "NODE_ISLEAF", false,
          row["NODE_ISLEAF"].data<bool>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "NODE_INSTIME length",
          std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
          row["NODE_INSTIME"].data<std::string>().size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "FOLDER_PAYLOADSPEC", std::string(""),
          row["FOLDER_PAYLOADSPEC"].data<std::string>() );
      //CPPUNIT_ASSERT_MESSAGE
      //  ( "FOLDER_PAYLOADSPEC", row["FOLDER_PAYLOADSPEC"].isNull() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "FOLDER_VERSIONING",
          (int)cool_FolderVersioning_Mode::NONE, // BUG: null - should be -1!
          row["FOLDER_VERSIONING"].data<int>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "FOLDER_IOVTABLENAME", std::string(""),
          row["FOLDER_IOVTABLENAME"].data<std::string>() );
      //CPPUNIT_ASSERT_MESSAGE
      //  ( "FOLDER_IOVTABLENAME", row["FOLDER_IOVTABLENAME"].isNull() );
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests dropDatabase
  void test_dropDatabase() {
    std::vector<std::string> folderNames;
    folderNames.push_back( "/f1" );
    folderNames.push_back( "/f2" );
    folderNames.push_back( "/f3" );
    folderNames.push_back( "/f4" );
    std::vector<std::string> objectTables;
    CoralApplication app;
    IDatabaseSvc& dbSvc = app.databaseService();
    s_db.reset(); // Work around MySQL hang (bug #103684)
    dbSvc.dropDatabase( s_connectionString );
    s_db = dbSvc.createDatabase( s_connectionString );
    TransRalDatabase* traldb = dynamic_cast<TransRalDatabase*>( s_db.get() );
    if ( !traldb ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    ralDb = traldb->getRalDb();
    FolderSpecification fSpec( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec );
    for ( std::vector<std::string>::const_iterator f = folderNames.begin();
          f != folderNames.end();
          ++f )
    {
      IFolderPtr folder = s_db->createFolder( *f, fSpec );
      TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
      if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
      RelationalFolder* rf = trelfolder->getRelFolder();
      objectTables.push_back( rf->objectTableName() );
    }
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      ralDb->dropDatabase();
      transaction.commit();
    }
    bool readOnly = true;
    RelationalTransaction transaction( ralDb->transactionMgr(), readOnly );
    coral::ISessionProxy& session = ralDb->session();
    coral::ISchema& schema = session.nominalSchema();
    //coral::ISchema& schema = ralDb->session().nominalSchema();
    CPPUNIT_ASSERT_MESSAGE( "main table deleted",
                            ! schema.existsTable( ralDb->mainTableName() ) );
    std::string folderSeqName =
      RelationalNodeTable::sequenceName( ralDb->nodeTableName() );
    CPPUNIT_ASSERT_MESSAGE( "sequence table deleted",
                            ! schema.existsTable( folderSeqName ) );
    CPPUNIT_ASSERT_MESSAGE( "folder table deleted",
                            ! schema.existsTable( ralDb->nodeTableName() ) );
    for ( std::vector<std::string>::const_iterator
            objTable = objectTables.begin();
          objTable != objectTables.end();
          ++objTable ) {
      CPPUNIT_ASSERT_MESSAGE( *objTable + " table deleted",
                              ! schema.existsTable( *objTable ) );
    }
    CPPUNIT_ASSERT_MESSAGE
      ( "tag table deleted",
        ! schema.existsTable( ralDb->globalTagTableName() ) );
    CPPUNIT_ASSERT_MESSAGE
      ( "tag2tag table deleted",
        ! schema.existsTable( ralDb->tag2TagTableName() ) );
  }

  /// Tests the length of database names
  void test_dbNameLength() {
    RelationalDatabaseId id( s_connectionString );
    std::string newId;
    if ( id.alias().empty() ) {
      newId = id.technology() + "://";
      newId += id.server() + ";";
      newId += "schema=" + id.schema() + ";";
      if ( id.user() != "" ) {
        newId += "user=" + id.user() + ";";
        newId += "password=" + id.password() + ";";
      }
      newId += "dbname=123456789;";
    } else {
      newId = id.alias() + "/123456789";
    }
    try {
      CoralApplication app;
      IDatabaseSvc& dbSvc = app.databaseService();
      s_db.reset(); // db will be dropped: cleanup before next test
      dbSvc.dropDatabase( newId );
      s_db = dbSvc.createDatabase( newId );
      CPPUNIT_ASSERT_MESSAGE( "exception expected", false );
    } catch ( RelationalException& e ) {
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "exception caught",
          std::string( "Invalid COOL database name '123456789': "
                       "the database name length must not exceed 8 characters" ),
          std::string( e.what() ) );
    }
  }

  /// Tests that database names are uppercase
  void test_dbNameUppercase() {
    RelationalDatabaseId id( s_connectionString );
    std::string newId;
    if ( id.alias().empty() ) {
      newId = id.technology() + "://";
      newId += id.server() + ";";
      newId += "schema=" + id.schema() + ";";
      if ( id.user() != "" ) {
        newId += "user=" + id.user() + ";";
        newId += "password=" + id.password() + ";";
      }
      newId += "dbname=aBcDeFgH;";
    } else {
      newId = id.alias() + "/aBcDeFgH";
    }
    try {
      CoralApplication app;
      IDatabaseSvc& dbSvc = app.databaseService();
      s_db.reset(); // db will be dropped: cleanup before next test
      dbSvc.dropDatabase( newId );
      s_db = dbSvc.createDatabase( newId );
      CPPUNIT_ASSERT_MESSAGE( "exception expected", false );
    } catch ( RelationalException& e ) {
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "exception caught",
          std::string( "Invalid COOL database name 'aBcDeFgH': "
                       "the database name must be UPPERCASE" ),
          std::string( e.what() ) );
    }
  }

  /// Tests that database names only contain letters and numbers
  void test_dbNameLettersAndNumbers() {
    RelationalDatabaseId id( s_connectionString );
    std::string newId;
    if ( id.alias().empty() ) {
      newId = id.technology() + "://";
      newId += id.server() + ";";
      newId += "schema=" + id.schema() + ";";
      if ( id.user() != "" ) {
        newId += "user=" + id.user() + ";";
        newId += "password=" + id.password() + ";";
      }
      newId += "dbname=ABCD#FGH;";
    } else {
      newId = id.alias() + "/ABCD#FGH";
    }
    try {
      CoralApplication app;
      IDatabaseSvc& dbSvc = app.databaseService();
      s_db.reset(); // db will be dropped: cleanup before next test
      dbSvc.dropDatabase( newId );
      s_db = dbSvc.createDatabase( newId );
      CPPUNIT_ASSERT_MESSAGE( "exception expected", false );
    } catch ( RelationalException& e ) {
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "exception caught",
          std::string( "Invalid COOL database name 'ABCD#FGH': "
                       "the database name must contain only letters, numbers"
                       " or the '_' character" ),
          std::string( e.what() ) );
    }
  }

  /// Tests that database names start with a letter
  void test_dbNameStartsWithLetter() {
    RelationalDatabaseId id( s_connectionString );
    std::string newId;
    if ( id.alias().empty() ) {
      newId = id.technology() + "://";
      newId += id.server() + ";";
      newId += "schema=" + id.schema() + ";";
      if ( id.user() != "" ) {
        newId += "user=" + id.user() + ";";
        newId += "password=" + id.password() + ";";
      }
      newId += "dbname=1BCDEFGH;";
    } else {
      newId = id.alias() + "/1BCDEFGH";
    }
    try {
      CoralApplication app;
      IDatabaseSvc& dbSvc = app.databaseService();
      s_db.reset(); // db will be dropped: cleanup before next test
      dbSvc.dropDatabase( newId );
      s_db = dbSvc.createDatabase( newId );
      CPPUNIT_ASSERT_MESSAGE( "exception expected", false );
    } catch ( RelationalException& e ) {
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "exception caught",
          std::string( "Invalid COOL database name '1BCDEFGH': "
                       "the database name must start with a letter" ),
          std::string( e.what() ) );
    }
  }

  /// Tests openDatabase
  void test_openDatabase_rw() {
    try {
      CoralApplication app;
      IDatabaseSvc& dbSvc = app.databaseService();
      //std::cout << "OpenDB_RW drop" << std::endl; // debug bug #103684
      dbSvc.dropDatabase( s_connectionString );
      //std::cout << "OpenDB_RW create" << std::endl; // debug bug #103684
      dbSvc.createDatabase( s_connectionString );
      //std::cout << "OpenDB_RW open" << std::endl; // debug bug #103684
      s_db =  dbSvc.openDatabase( s_connectionString, false );
      CPPUNIT_ASSERT( s_db.get() != 0 );
      CPPUNIT_ASSERT( s_db->isOpen() );
      s_db.reset(); // Work around MySQL hang (bug #103684)
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests openDatabase
  void test_openDatabase_ro() {
    try {
      CoralApplication app;
      IDatabaseSvc& dbSvc = app.databaseService();
      //std::cout << "OpenDB_RO drop" << std::endl; // debug bug #103684
      dbSvc.dropDatabase( s_connectionString );
      //std::cout << "OpenDB_RO create" << std::endl; // debug bug #103684
      dbSvc.createDatabase( s_connectionString );
      //std::cout << "OpenDB_RO open" << std::endl; // debug bug #103684
      s_db =  dbSvc.openDatabase( s_connectionString );
      CPPUNIT_ASSERT( s_db.get() != 0 );
      CPPUNIT_ASSERT( s_db->isOpen() );
      s_db.reset(); // current s_db is read-only
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests createDatabase
  void test_createDatabase() {
    try {
      CoralApplication app;
      IDatabaseSvc& dbSvc = app.databaseService();
      dbSvc.dropDatabase( s_connectionString );
      s_db = dbSvc.createDatabase( s_connectionString );
      CPPUNIT_ASSERT( s_db.get() != 0 );
      CPPUNIT_ASSERT( s_db->isOpen() );
      {
        TransRalDatabase* traldb = dynamic_cast<TransRalDatabase*>( s_db.get() );
        if ( !traldb ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
        ralDb = traldb->getRalDb();
        RelationalDatabaseId id( s_connectionString );
        std::string s_coolDBName = id.dbName();
        RelationalTransaction transaction( ralDb->transactionMgr() );
        CPPUNIT_ASSERT
          ( ralDb->queryMgr().existsTable( s_coolDBName + "_DB_ATTRIBUTES" ) );
        CPPUNIT_ASSERT
          ( ralDb->queryMgr().existsTable( s_coolDBName + "_F0000_TAGS_SEQ" ));
        CPPUNIT_ASSERT
          ( ralDb->queryMgr().existsTable( s_coolDBName + "_NODES" ) );
        CPPUNIT_ASSERT
          ( ralDb->queryMgr().existsTable( s_coolDBName + "_NODES_SEQ" ) );
        CPPUNIT_ASSERT
          ( ralDb->queryMgr().existsTable( s_coolDBName + "_TAG2TAG" ) );
        CPPUNIT_ASSERT
          ( ralDb->queryMgr().existsTable( s_coolDBName + "_TAG2TAG_SEQ" ) );
        CPPUNIT_ASSERT
          ( ralDb->queryMgr().existsTable( s_coolDBName + "_TAGS" ) );
        transaction.commit();
      }
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

public:

  // Constructor (executed N times, _before_ all N test executions)
  RalDatabaseTest()
    : CoolDBUnitTest()
    , ralDb( 0 ) // Fix Coverity UNINIT_CTOR
    , payloadSpec()
  {
    payloadSpec.extend("I",cool_StorageType_TypeId::Int32);
    payloadSpec.extend("S",cool_StorageType_TypeId::String255);
    payloadSpec.extend("X",cool_StorageType_TypeId::Float);
  }

  // Destructor (executed N times, _after_ all N test executions)
  ~RalDatabaseTest()
  {
  }

private:

  RalDatabase* ralDb; // safely cast pointer to db
  RecordSpecification payloadSpec;

  // Setup (executed N times, at the start of each test execution)
  void coolUnitTest_setUp()
  {
  }

  // TearDown (executed N times, at the end of each test execution)
  void coolUnitTest_tearDown()
  {
  }

  /// Setup the database. This code is not in setup() because some
  /// of its methods need to be tested in this unit test class.
  void setupDb()
  {
    static bool notMySQL = false;
    if ( !notMySQL ) s_db.reset(); // Work around MySQL hang (bug #103684)
    try
    {
      if ( !s_db ) createDB(); else refreshDB();
      openDB( false );
      TransRalDatabase* traldb = dynamic_cast<TransRalDatabase*>( s_db.get() );
      if ( !traldb ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
      ralDb = traldb->getRalDb();
      if ( ralDb->queryMgr().databaseTechnology() != "MySQL" ) notMySQL = true;
    }
    catch ( cool::DatabaseDoesNotExist& )
    {
      createDB(); // some tests drop the database
      openDB( false );
      TransRalDatabase* traldb = dynamic_cast<TransRalDatabase*>( s_db.get() );
      if ( !traldb ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
      ralDb = traldb->getRalDb();
    }
    catch ( std::exception& e )
    {
      std::cout << "Exception caught in setupDb(): " << e.what() << std::endl;
      throw;
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

};

CPPUNIT_TEST_SUITE_REGISTRATION( cool::RalDatabaseTest );

COOLTEST_MAIN( RalDatabaseTest )
