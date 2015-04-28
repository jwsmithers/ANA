
// Include files
#include "CoolKernel/ChannelSelection.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/InternalErrorException.h"
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordSpecification.h"
#include "CoralBase/AttributeListException.h"
#include "CoralBase/Exception.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ITable.h"
#include "RelationalAccess/ITableDataEditor.h"

// Local include files
//#define COOLUNITTESTTIMER 1
//#define COOLDBUNITTESTDEBUG 1
#include "tests/Common/CoolDBUnitTest.h"
#include "src/HvsTagRecord.h"
#include "src/RalDatabase.h"
#include "src/RelationalChannelTable.h"
#include "src/RelationalFolder.h"
#include "src/RelationalObjectMgr.h"
#include "src/RelationalObjectTable.h"
#include "src/RelationalObjectTableRow.h"
#include "src/RelationalQueryDefinition.h"
#include "src/RelationalSequence.h"
#include "src/RelationalSequenceMgr.h"
#include "src/RelationalTagMgr.h"
#include "src/RelationalTransaction.h"
#include "src/TransRalDatabase.h"
#include "src/TransRelFolder.h"
#include "src/timeToString.h"

// Forward declaration (for easier indentation)
namespace cool
{
  class RelationalObjectTableTest;
}

// The test class
class cool::RelationalObjectTableTest : public cool::CoolDBUnitTest
{

private:

  CPPUNIT_TEST_SUITE( RelationalObjectTableTest );
  CPPUNIT_TEST( test_fetchRowForId_data );
  //CPPUNIT_TEST( test_fetchRowAtTimeSV );      // method is no longer used
  //CPPUNIT_TEST( test_fetchRowAtTimeSV64bit ); // method is no longer used
  CPPUNIT_TEST( test_fetchRowForId );
  //CPPUNIT_TEST( test_fetchRowsSV_channel_range );
  //CPPUNIT_TEST( test_fetchRowsSV_channel_range_ordering );
  //CPPUNIT_TEST( test_fetchRowsSV_all_channels );
  //CPPUNIT_TEST( test_fetchLastRowSV );
  CPPUNIT_TEST( test_fetchLastRowForTagId );
  CPPUNIT_TEST( test_fetchRowAtTimeInHead_5b );
  CPPUNIT_TEST( test_fetchRowAtTimeInHead_5b_with_userTag );
  CPPUNIT_TEST( test_findObjectAtTimeInTag_5b );
  CPPUNIT_TEST( test_fetchRowAtTimeInTag_5c );
  CPPUNIT_TEST( test_fetchRowsForTaggingCurrentHead_5c );
  CPPUNIT_TEST( test_fetchRowsForTaggingCurrentHead_5c_with_userTag );
  CPPUNIT_TEST( test_fetchRowsForTaggingHeadAsOfDate_5c );
  CPPUNIT_TEST( test_fetchRowsForTaggingHeadAsOfDate_5c_with_userTag );
  CPPUNIT_TEST( test_fetchRowsForTaggingHeadAsOfObjectId_5c );
  CPPUNIT_TEST( test_fetchRowsForTaggingHeadAsOfObjectId_duplIOV );
  CPPUNIT_TEST( test_fetchRowsForTaggingHeadAsOfObjectId_5c_with_userTag );
  CPPUNIT_TEST( test_fetchRowsInHead_5c );
  CPPUNIT_TEST( test_fetchRowsInHead_identicalRange );
  CPPUNIT_TEST( test_fetchRowsInHead_channel_range );
  CPPUNIT_TEST( test_fetchRowsInHead_channel_range_ordering );
  CPPUNIT_TEST( test_fetchRowsInHead_all_channels );
  CPPUNIT_TEST( test_fetchRowsInTag );
  CPPUNIT_TEST( test_fetchRowsInTag_channel_range );
  CPPUNIT_TEST( test_fetchRowsInTag_channel_range_ordering );
  CPPUNIT_TEST( test_fetchRowsInTag_all_channels );
  CPPUNIT_TEST( test_fetchRowsInPastHead_5c ); // this was hanging on RH73
  CPPUNIT_TEST( test_fetchRowsInPastHead_identicalRange );
  CPPUNIT_TEST( test_fetchRowsInPastHead_5c_with_userTag );
  CPPUNIT_TEST( test_objectCountSV_all_channels );
  CPPUNIT_TEST( test_objectCountSV_channel_range );
  CPPUNIT_TEST( test_objectCountSV_iov_range );
  CPPUNIT_TEST( test_objectCountInHead_all_channels );
  CPPUNIT_TEST( test_objectCountInHead_channel_range );
  CPPUNIT_TEST( test_objectCountInHead_iov_range );
  CPPUNIT_TEST( test_objectCountInHead_hidden_objects );
  CPPUNIT_TEST( test_objectCountInTag_all_channels );
  CPPUNIT_TEST( test_objectCountInTag_channel_range );
  CPPUNIT_TEST( test_objectCountInTag_iov_range );
  CPPUNIT_TEST_SUITE_END();

public:

  //-------------------------------------------------------------------------

  std::vector<RelationalObjectTableRow> fetchRowsInTag
  ( RelationalObjectTable& objectTable,
    const ValidityKey& since,
    const ValidityKey& until,
    const ChannelSelection& channels,
    const std::string& tagName )
  {
    //std::cout << "Fetch tag '" << tagName << "'"
    //          << " from table " << objectTable.objectTableName()
    //          << " for channel=[" << channels.firstChannel()
    //          << "," << channels.lastChannel() << "]"
    //          << ", since=" << since
    //          << ", until=" << until
    //          << std::endl;
    const std::auto_ptr<IRelationalQueryDefinition>
      def( objectTable.queryDefinitionTag( since, until, channels, tagName ) );
    try
    {
      std::string desc = "";
      const std::vector<RelationalTableRow> rows
        ( objectTable.queryMgr().fetchOrderedRows( *def, desc ) );
      std::vector<RelationalObjectTableRow> objectRows;
      for ( std::vector<RelationalTableRow>::const_iterator
              row = rows.begin(); row != rows.end(); ++row )
      {
        RelationalObjectTableRow objectRow( *row );
        objectRows.push_back( objectRow );
      }
      return objectRows;
    }
    catch( NoRowsFound& )
    {
      std::stringstream s;
      throw ObjectNotFound
        ( s.str(), objectTable.objectTableName(),
          "test_RelationalObjectTable" );
    }
  }

  //-------------------------------------------------------------------------

  std::vector<RelationalObjectTableRow> fetchRowsInHead
  ( RelationalObjectTable& objectTable,
    const ValidityKey& since,
    const ValidityKey& until,
    const ChannelSelection& channels )
  {
    //std::cout << "Fetch HEAD from table " << objectTable.objectTableName()
    //          << " for channel=[" << channels.firstChannel()
    //          << "," << channels.lastChannel() << "]"
    //          << ", since=" << since
    //          << ", until=" << until
    //          << std::endl;
    std::string tagName = "HEAD";
    const std::auto_ptr<IRelationalQueryDefinition>
      def( objectTable.queryDefinitionHeadAndUserTag
           ( since, until, channels, tagName ) );
    try
    {
      std::string desc = "";
      const std::vector<RelationalTableRow> rows
        ( objectTable.queryMgr().fetchOrderedRows( *def, desc ) );
      std::vector<RelationalObjectTableRow> objectRows;
      for ( std::vector<RelationalTableRow>::const_iterator
              row = rows.begin(); row != rows.end(); ++row )
      {
        RelationalObjectTableRow objectRow( *row );
        objectRows.push_back( objectRow );
      }
      return objectRows;
    }
    catch( NoRowsFound& )
    {
      std::stringstream s;
      throw ObjectNotFound
        ( s.str(), objectTable.objectTableName(), "RelationalObjectTable" );
    }
  }

  //-------------------------------------------------------------------------

  std::vector<RelationalObjectTableRow> fetchRowsInPastHead
  ( RelationalObjectTable& objectTable,
    const ValidityKey& since,
    const ValidityKey& until,
    const ChannelId& channelId,
    const ITime& asOfDate )
  {
    // Define the list of tables to query
    // NB Use UPPERCASE table aliases for Frontier (see task #3536)
    RelationalQueryDefinition queryDef;
    queryDef.addFromItem( objectTable.objectTableName(), "I" );
    queryDef.addFromItem( objectTable.objectTableName(), "O" );
    // Add all columns to the output list and define the output format
    queryDef.addSelectItems( objectTable.tableSpecification(), "I." );
    // Define the WHERE clause for the selection using bind variables
    // MIND THE ORDER! For MySQL, match the order in which they are bound!
    RecordSpecification spec;
    spec.extend( "userTagId",
                 RelationalObjectTable::columnTypeIds::userTagId );
    spec.extend( "since1",
                 RelationalObjectTable::columnTypeIds::iovSince );
    spec.extend( "since2",
                 RelationalObjectTable::columnTypeIds::iovSince );
    spec.extend( "since3",
                 RelationalObjectTable::columnTypeIds::iovSince );
    spec.extend( "until",
                 RelationalObjectTable::columnTypeIds::iovUntil );
    spec.extend( "asOfDate1",
                 RelationalObjectTable::columnTypeIds::sysInsTime );
    spec.extend( "channel",
                 RelationalObjectTable::columnTypeIds::channelId );
    spec.extend( "newHeadId",
                 RelationalObjectTable::columnTypeIds::newHeadId );
    spec.extend( "asOfDate2",
                 RelationalObjectTable::columnTypeIds::sysInsTime );
    Record whereData( spec );
    whereData["userTagId"].setValue( 0u );
    whereData["since1"].setValue( since );
    whereData["since2"].setValue( since );
    whereData["since3"].setValue( since );
    whereData["until"].setValue( until );
    whereData["asOfDate1"].setValue( timeToString( asOfDate ) );
    whereData["channel"].setValue( (unsigned int)channelId );
    whereData["newHeadId"].setValue( 0u );
    whereData["asOfDate2"].setValue( timeToString( asOfDate ) );
    // Also see SimpleObject::overlaps for this clause
    // but note that the upper end is *included* (<= :until)
    std::string s  = RelationalObjectTable::columnNames::iovSince();
    std::string u  = RelationalObjectTable::columnNames::iovUntil();
    std::string ch  = RelationalObjectTable::columnNames::channelId();
    std::string ins = RelationalObjectTable::columnNames::sysInsTime();
    std::string oid = RelationalObjectTable::columnNames::objectId();
    std::string nhid = RelationalObjectTable::columnNames::newHeadId();
    std::string
      whereClause = "I." + RelationalObjectTable::columnNames::userTagId();
    whereClause += "= :userTagId";
    whereClause += " AND ";
    whereClause += "(";
    whereClause += " ( ( I." + s + " <= :since1 )";
    whereClause += "   AND ( :since2 < I." + u + " ) )";
    whereClause += " OR ";
    whereClause += " ( ( :since3 <= I." + s + " )";
    whereClause += "   AND ( I." + s + " <= :until ) )";
    whereClause += ")";
    whereClause += " AND I." + ins + " <= :asOfDate1";
    whereClause += " AND I." + ch + " = :channel";
    whereClause += " AND ( ";
    whereClause += "( I." + nhid + " = :newHeadId";
    whereClause += " AND I." + oid + " = O." + oid; // constrains self join
    whereClause += " ) ";
    whereClause += " OR ";
    whereClause += "( I." + nhid + " = O." + oid;
    whereClause += " AND O." + ins + " > :asOfDate2";
    whereClause += " ) ";
    whereClause += ")";
    queryDef.setWhereClause( whereClause );
    queryDef.setBindVariables( whereData );
    /// Results are ordered by ascending values of the "since" start of IOV
    queryDef.addOrderItem
      ( std::string("I.") +
        RelationalObjectTable::columnNames::iovSince() + " ASC" );
    // Delegate the query to the RalQueryMgr
    std::vector<RelationalTableRow> rows =
      objectTable.queryMgr().fetchOrderedRows( queryDef );
    // TEMPORARY? Conversion to RelationalObjectTableRow
    std::vector<RelationalObjectTableRow> objectRows;
    for ( std::vector<RelationalTableRow>::const_iterator
            row = rows.begin(); row != rows.end(); ++row )
    {
      RelationalObjectTableRow objectRow( *row );
      objectRows.push_back( objectRow );
    }
    // Return the results
    return objectRows;
  }

  //-------------------------------------------------------------------------

  /// Tests countObjectInTag for all channels
  void test_objectCountInTag_all_channels()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->setupStorageBuffer();
    for ( ChannelId ch = 0; ch < 5; ++ch ) {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), ch );
      folder->storeObject( 1, ValidityKeyMax, dummyPayload( 1 ), ch );
    }
    folder->flushStorageBuffer();
    folder->tagCurrentHead( "A" );
    for ( ChannelId ch = 0; ch < 5; ++ch ) {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), ch );
    }
    folder->flushStorageBuffer();
    folder->tagCurrentHead( "B" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::auto_ptr<IRelationalQueryDefinition> pQueryDef =
      objectTable.queryDefinitionTag( ValidityKeyMin,
                                      ValidityKeyMax,
                                      ChannelSelection::all(),
                                      "A" );
    int count = objectTable.queryMgr().countRows( *pQueryDef );
    CPPUNIT_ASSERT_EQUAL( 10, count );
  }

  /// Tests countObjectInTag for a channel range
  void test_objectCountInTag_channel_range()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->setupStorageBuffer();
    for ( ChannelId ch = 0; ch < 5; ++ch ) {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), ch );
      folder->storeObject( 1, ValidityKeyMax, dummyPayload( 1 ), ch );
    }
    folder->flushStorageBuffer();
    folder->tagCurrentHead( "A" );
    for ( ChannelId ch = 0; ch < 5; ++ch ) {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), ch );
    }
    folder->flushStorageBuffer();
    folder->tagCurrentHead( "B" );
    ChannelSelection channels( 2, 3 );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::auto_ptr<IRelationalQueryDefinition> pQueryDef =
      objectTable.queryDefinitionTag( ValidityKeyMin,
                                      ValidityKeyMax,
                                      channels,
                                      "A" );
    int count = objectTable.queryMgr().countRows( *pQueryDef );
    CPPUNIT_ASSERT_EQUAL( 4, count );
  }

  /// Tests countObjectInTag for an IOV range
  void test_objectCountInTag_iov_range()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->setupStorageBuffer();
    for ( int i = 0; i < 10; ++i ) {
      folder->storeObject( i, ValidityKeyMax, dummyPayload( i ), 0 );
    }
    folder->flushStorageBuffer();
    folder->tagCurrentHead( "A" );
    for ( int i = 0; i < 5; ++i ) {
      folder->storeObject( i, ValidityKeyMax, dummyPayload( i ), 0 );
    }
    folder->flushStorageBuffer();
    folder->tagCurrentHead( "B" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::auto_ptr<IRelationalQueryDefinition> pQueryDef =
      objectTable.queryDefinitionTag( (ValidityKey)3,
                                      (ValidityKey)5,
                                      ChannelSelection::all(),
                                      "A" );
    int count = objectTable.queryMgr().countRows( *pQueryDef );
    CPPUNIT_ASSERT_EQUAL( 3, count );
  }

  /// Tests countObjectInHead for all channels
  void test_objectCountInHead_all_channels()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->setupStorageBuffer();
    for ( ChannelId ch = 0; ch < 5; ++ch ) {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), ch );
      folder->storeObject( 1, ValidityKeyMax, dummyPayload( 1 ), ch );
    }
    folder->flushStorageBuffer();
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::auto_ptr<IRelationalQueryDefinition> pQueryDef =
      objectTable.queryDefinitionHeadAndUserTag( ValidityKeyMin,
                                                 ValidityKeyMax,
                                                 ChannelSelection::all(),
                                                 "HEAD" );
    int count = objectTable.queryMgr().countRows( *pQueryDef );
    CPPUNIT_ASSERT_EQUAL( 10, count );
  }

  /// Tests countObjectInHead for a channel range
  void test_objectCountInHead_channel_range()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->setupStorageBuffer();
    for ( ChannelId ch = 0; ch < 5; ++ch ) {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), ch );
      folder->storeObject( 1, ValidityKeyMax, dummyPayload( 1 ), ch );
    }
    folder->flushStorageBuffer();
    ChannelSelection channels( 2, 3 );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::auto_ptr<IRelationalQueryDefinition> pQueryDef =
      objectTable.queryDefinitionHeadAndUserTag( ValidityKeyMin,
                                                 ValidityKeyMax,
                                                 channels,
                                                 "HEAD" );
    int count = objectTable.queryMgr().countRows( *pQueryDef );
    CPPUNIT_ASSERT_EQUAL( 4, count );
  }

  /// Tests countObjectInHead for an IOV range
  void test_objectCountInHead_iov_range()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->setupStorageBuffer();
    for ( int i = 0; i < 10; ++i ) {
      folder->storeObject( i, ValidityKeyMax, dummyPayload( i ), 0 );
    }
    folder->flushStorageBuffer();
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::auto_ptr<IRelationalQueryDefinition> pQueryDef =
      objectTable.queryDefinitionHeadAndUserTag( (ValidityKey)3,
                                                 (ValidityKey)5,
                                                 ChannelSelection::all(),
                                                 "HEAD" );
    int count = objectTable.queryMgr().countRows( *pQueryDef );
    CPPUNIT_ASSERT_EQUAL( 3, count );
  }

  /// Tests countObjectInHead with some objects being fully overlapped by
  /// later insertions.
  void test_objectCountInHead_hidden_objects()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->setupStorageBuffer();
    for ( int i = 0; i < 6; ++i ) {
      folder->storeObject( i, i+1, dummyPayload( i ), 0 );
    }
    folder->flushStorageBuffer();
    folder->storeObject( 0, 3, dummyPayload( 0 ), 0 );
    folder->flushStorageBuffer();
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::auto_ptr<IRelationalQueryDefinition> pQueryDef =
      objectTable.queryDefinitionHeadAndUserTag( ValidityKeyMin,
                                                 ValidityKeyMax,
                                                 ChannelSelection::all(),
                                                 "HEAD" );
    int count = objectTable.queryMgr().countRows( *pQueryDef );
    CPPUNIT_ASSERT_EQUAL( 4, count );
  }

  /// Tests countObjectSV for all channels
  void test_objectCountSV_all_channels()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    try{
      folder->setupStorageBuffer();
      for ( ChannelId ch = 0; ch < 5; ++ch ) {
        folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), ch );
        folder->storeObject( 1, ValidityKeyMax, dummyPayload( 1 ), ch );
      }
      folder->flushStorageBuffer();
      TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
      if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
      RelationalFolder* relfolder = trelfolder->getRelFolder();
      RelationalTransaction transaction( ralDb->transactionMgr() );
      RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
      std::auto_ptr<IRelationalQueryDefinition> pQueryDef =
        objectTable.queryDefinitionSV( ValidityKeyMin,
                                       ValidityKeyMax,
                                       ChannelSelection::all() );
      int count = objectTable.queryMgr().countRows( *pQueryDef );
      CPPUNIT_ASSERT_EQUAL( 10, count );
    }
    catch( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests countObjectSV for a channel range
  void test_objectCountSV_channel_range()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->setupStorageBuffer();
    for ( ChannelId ch = 0; ch < 5; ++ch ) {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( 0 ), ch );
      folder->storeObject( 1, ValidityKeyMax, dummyPayload( 1 ), ch );
    }
    folder->flushStorageBuffer();
    ChannelSelection channels( 2, 3 );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::auto_ptr<IRelationalQueryDefinition> pQueryDef =
      objectTable.queryDefinitionSV( ValidityKeyMin,
                                     ValidityKeyMax,
                                     channels );
    int count = objectTable.queryMgr().countRows( *pQueryDef );
    CPPUNIT_ASSERT_EQUAL( 4, count );
  }

  /// Tests countObjectSV for an IOV range
  void test_objectCountSV_iov_range()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    folder->setupStorageBuffer();
    for ( int i = 0; i < 10; ++i ) {
      folder->storeObject( i, ValidityKeyMax, dummyPayload( i ), 0 );
    }
    folder->flushStorageBuffer();
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::auto_ptr<IRelationalQueryDefinition> pQueryDef =
      objectTable.queryDefinitionSV( (ValidityKey)3,
                                     (ValidityKey)5,
                                     ChannelSelection::all() );
    int count = objectTable.queryMgr().countRows( *pQueryDef );
    CPPUNIT_ASSERT_EQUAL( 3, count );
  }

  /// Tests fetchRowAtTimeInHead
  void test_fetchRowAtTimeInHead_5b_with_userTag()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    try{
      folder->storeObject( 1, 3, dummyPayload( 1 ), 0 );
      folder->storeObject( 6, 8, dummyPayload( 2 ), (ChannelId)0, "A" );
      folder->storeObject( 2, 4, dummyPayload( 3 ), (ChannelId)0, "B" );
      folder->storeObject( 5, 7, dummyPayload( 4 ), (ChannelId)0, "A" );
      TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
      if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
      RelationalFolder* relfolder = trelfolder->getRelFolder();
      RelationalTransaction transaction( ralDb->transactionMgr() );
      RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
      RelationalObjectTableRow row =
        objectTable.fetchRowAtTimeInHead( (ValidityKey)1,
                                          (ChannelId)0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "object_id time 1", 14u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "since time 1", (ValidityKey)1, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "until time 1", (ValidityKey)2, row.until() );
      row = objectTable.fetchRowAtTimeInHead( (ValidityKey)3,
                                              (ChannelId)0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "object_id time 2", 13u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "since time 2", (ValidityKey)2, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "until time 2", (ValidityKey)4, row.until() );
      try {
        row = objectTable.fetchRowAtTimeInHead( (ValidityKey)4,
                                                (ChannelId)0 );
        CPPUNIT_FAIL( "expected RelationalObjectNotFound exception" );
      } catch ( ObjectNotFound& /* ignored */ ) { }
      row = objectTable.fetchRowAtTimeInHead( (ValidityKey)5,
                                              (ChannelId)0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "object_id time 4", 19u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "since time 4", (ValidityKey)5, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "until time 4", (ValidityKey)7, row.until() );
      row = objectTable.fetchRowAtTimeInHead( (ValidityKey)7,
                                              (ChannelId)0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "object_id time 5", 21u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "since time 5", (ValidityKey)7, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "until time 5", (ValidityKey)8, row.until() );
      transaction.commit();
    }
    catch( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests fetchRowAtTimeInHead
  void test_fetchRowAtTimeInHead_5b()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    try{
      folder->setupStorageBuffer();
      folder->storeObject( 1, 3, dummyPayload( 1 ), 0 );
      folder->storeObject( 6, 8, dummyPayload( 2 ), 0 );
      folder->storeObject( 2, 4, dummyPayload( 3 ), 0 );
      folder->storeObject( 5, 7, dummyPayload( 4 ), 0 );
      folder->flushStorageBuffer();
      TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
      if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
      RelationalFolder* relfolder = trelfolder->getRelFolder();
      RelationalTransaction transaction( ralDb->transactionMgr() );
      RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
      RelationalObjectTableRow row =
        objectTable.fetchRowAtTimeInHead( (ValidityKey)1,
                                          (ChannelId)0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "object_id time 1", 14u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "since time 1", (ValidityKey)1, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "until time 1", (ValidityKey)2, row.until() );
      row = objectTable.fetchRowAtTimeInHead( (ValidityKey)3,
                                              (ChannelId)0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "object_id time 2", 13u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "since time 2", (ValidityKey)2, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "until time 2", (ValidityKey)4, row.until() );
      try {
        row = objectTable.fetchRowAtTimeInHead( (ValidityKey)4,
                                                (ChannelId)0 );
        CPPUNIT_FAIL( "expected RelationalObjectNotFound exception" );
      } catch ( ObjectNotFound& /* ignored */ ) { }
      row = objectTable.fetchRowAtTimeInHead( (ValidityKey)5,
                                              (ChannelId)0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "object_id time 4", 19u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "since time 4", (ValidityKey)5, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "until time 4", (ValidityKey)7, row.until() );
      row = objectTable.fetchRowAtTimeInHead( (ValidityKey)7,
                                              (ChannelId)0 );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "object_id time 5", 21u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "since time 5", (ValidityKey)7, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "until time 5", (ValidityKey)8, row.until() );
      transaction.commit();
    }
    catch( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests tags in a way similar to fetchRowAtTimeInHead_5b (bug #33256)
  void test_findObjectAtTimeInTag_5b()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    try {
      folder->setupStorageBuffer();
      folder->storeObject( 1, 3, dummyPayload( 1 ), 0 );
      folder->storeObject( 6, 8, dummyPayload( 2 ), 0 );
      folder->storeObject( 2, 4, dummyPayload( 3 ), 0 );
      folder->storeObject( 5, 7, dummyPayload( 4 ), 0 );
      folder->flushStorageBuffer();
      std::string mytag = "mytag";
      folder->tagCurrentHead( mytag );
      IObjectPtr obj =
        folder->findObject( (ValidityKey)1, (ChannelId)0, mytag );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "object_id time 1", 14u, obj->objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "since time 1", (ValidityKey)1, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "until time 1", (ValidityKey)2, obj->until() );
      obj = folder->findObject( (ValidityKey)3, (ChannelId)0, mytag );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "object_id time 2", 13u, obj->objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "since time 2", (ValidityKey)2, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "until time 2", (ValidityKey)4, obj->until() );
      try {
        obj = folder->findObject( (ValidityKey)4, (ChannelId)0, mytag );
        CPPUNIT_FAIL( "expected ObjectNotFound exception" );
      } catch ( ObjectNotFound& /* ignored */ ) { }
      obj = folder->findObject( (ValidityKey)5, (ChannelId)0, mytag );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "object_id time 4", 19u, obj->objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "since time 4", (ValidityKey)5, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "until time 4", (ValidityKey)7, obj->until() );
      obj = folder->findObject( (ValidityKey)7, (ChannelId)0, mytag );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "object_id time 5", 21u, obj->objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "since time 5", (ValidityKey)7, obj->since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "until time 5", (ValidityKey)8, obj->until() );
    }
    catch( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests fetchRowsInPastHead for case 5c and selection
  /// between T2 and T3 in the context of user tags
  void test_fetchRowsInPastHead_5c_with_userTag()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->storeObject( 1, 3, dummyPayload( 1 ), (ChannelId)0, "A" );
    folder->storeObject( 6, 8, dummyPayload( 2 ), (ChannelId)0, "B" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction t1( ralDb->transactionMgr() );
    boost::shared_ptr<RelationalSequence> seq
      ( ralDb->queryMgr().sequenceMgr().getSequence
        ( RelationalObjectTable::sequenceName
          ( relfolder->objectTableName() ) ) );
    Time asOfDate = stringToTime( seq->currDate() );
    asOfDate = addOneNsToTime( asOfDate );
    t1.commit();
    // MySQL now() has 1 second granularity: need to sleep at least 1 second
    sleep(1);
    folder->storeObject( 2, 4, dummyPayload( 3 ), (ChannelId)0, "A" );
    folder->storeObject( 3, 5, dummyPayload( 4 ), (ChannelId)0, "B" );
    RelationalTransaction transaction( ralDb->transactionMgr() );
    ralDb->log()
      << "rh7 issue: I may soon crash (seg fault) or hang (mutex lock)"
      << coral::MessageStream::endmsg;
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::vector<RelationalObjectTableRow> rows =
      fetchRowsInPastHead( objectTable,
                           ValidityKeyMin,
                           ValidityKeyMax,
                           (ChannelId)0,
                           asOfDate );
    ralDb->log() << "rh7 issue: I did not crash or hang" << coral::MessageStream::endmsg;
    //copy( rows.begin(), rows.end(),
    //      std::ostream_iterator<RelationalObjectTableRow>( std::cout, "\n" ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count", 2u, (unsigned int)rows.size() );
    RelationalObjectTableRow& row = rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 13u, row.newHeadId() );
    row = rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)6, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 0u, row.newHeadId() );
  }

  /// Tests fetchRowsInPastHead for case 5c and selection
  /// between T2 and T3
  void test_fetchRowsInPastHead_5c()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->setupStorageBuffer();
    folder->storeObject( 1, 3, dummyPayload( 1 ), 0 );
    folder->storeObject( 6, 8, dummyPayload( 2 ), 0 );
    folder->flushStorageBuffer();
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction t1( ralDb->transactionMgr() );
    boost::shared_ptr<RelationalSequence> seq
      ( ralDb->queryMgr().sequenceMgr().getSequence
        ( RelationalObjectTable::sequenceName
          ( relfolder->objectTableName() ) ) );
    Time asOfDate = stringToTime( seq->currDate() );
    asOfDate = addOneNsToTime( asOfDate );
    t1.commit();
    // MySQL now() has 1 second granularity: need to sleep at least 1 second
    sleep(1);
    folder->storeObject( 2, 4, dummyPayload( 3 ), 0 );
    folder->storeObject( 3, 5, dummyPayload( 4 ), 0 );
    folder->flushStorageBuffer();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    ralDb->log()
      << "rh7 issue: I may soon crash (seg fault) or hang (mutex lock)"
      << coral::MessageStream::endmsg;
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::vector<RelationalObjectTableRow> rows =
      fetchRowsInPastHead( objectTable,
                           ValidityKeyMin,
                           ValidityKeyMax,
                           (ChannelId)0,
                           asOfDate );
    ralDb->log() << "rh7 issue: I did not crash or hang" << coral::MessageStream::endmsg;
    //copy( rows.begin(), rows.end(),
    //      std::ostream_iterator<RelationalObjectTableRow>( std::cout, "\n" ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count", 2u, (unsigned int)rows.size() );
    RelationalObjectTableRow& row = rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 13u, row.newHeadId() );
    row = rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)6, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 0u, row.newHeadId() );
  }

  /// Tests fetchRowsInTag
  void test_fetchRowsInTag()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->storeObject( 0, ValidityKeyMax, dummyPayload( 1 ), 0 );
    folder->tagCurrentHead( "mytagA", "a tag A" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::vector<RelationalObjectTableRow> rows =
      fetchRowsInTag( objectTable,
                      ValidityKeyMin,
                      ValidityKeyMax,
                      ChannelSelection( 0, 0 ),
                      "mytagA" );
    //copy( rows.begin(), rows.end(),
    //      std::ostream_iterator<RelationalObjectTableRow>( std::cout, "\n" ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count", 1u,
                                  (unsigned int)rows.size() );
    RelationalObjectTableRow& row = rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", ValidityKeyMax, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
  }

  /// Tests fetchRowsInPastHead
  void test_fetchRowsInPastHead_identicalRange()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->storeObject( 0, ValidityKeyMax, dummyPayload( 1 ), 0 );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    boost::shared_ptr<RelationalSequence> seq
      ( ralDb->queryMgr().sequenceMgr().getSequence
        ( RelationalObjectTable::sequenceName
          ( relfolder->objectTableName() ) ) );
    Time asOfDate = stringToTime( seq->currDate() );
    asOfDate = addOneNsToTime( asOfDate );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::vector<RelationalObjectTableRow> rows =
      fetchRowsInPastHead( objectTable,
                           ValidityKeyMin,
                           ValidityKeyMax,
                           (ChannelId)0,
                           asOfDate );
    //copy( rows.begin(), rows.end(),
    //      std::ostream_iterator<RelationalObjectTableRow>( std::cout, "\n" ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count", 1u,
                                  (unsigned int)rows.size() );
    RelationalObjectTableRow& row = rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", ValidityKeyMax, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
  }

  /// Tests fetchRowsInHead
  void test_fetchRowsInHead_5c()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->setupStorageBuffer();
    folder->storeObject( 1, 3, dummyPayload( 1 ), 0 );
    folder->storeObject( 6, 8, dummyPayload( 2 ), 0 );
    folder->flushStorageBuffer();
    folder->storeObject( 2, 4, dummyPayload( 3 ), 0 );
    folder->storeObject( 3, 5, dummyPayload( 4 ), 0 );
    folder->flushStorageBuffer();
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::vector<RelationalObjectTableRow> rows =
      fetchRowsInHead( objectTable,
                       ValidityKeyMin,
                       ValidityKeyMax,
                       ChannelSelection( 0, 0 ) );
    //copy( rows.begin(), rows.end(),
    //      std::ostream_iterator<RelationalObjectTableRow>( std::cout, "\n" ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count", 4u,
                                  (unsigned int)rows.size() );
    RelationalObjectTableRow& row = rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 14u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)2, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 original id", 1u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 new head id", 0u, row.newHeadId() );
    row = rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 20u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 13u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 0u, row.newHeadId() );
    row = rows[2];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 19u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)3, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)5, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 4"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 0u, row.newHeadId() );
    row = rows[3];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)6, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 payload", std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 original id", 0u, row.originalId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 new head id", 0u, row.newHeadId() );
  }

  /// Tests fetchRowsHead
  void test_fetchRowsInHead_identicalRange()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->storeObject( 0, ValidityKeyMax, dummyPayload( 1 ), 0 );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::vector<RelationalObjectTableRow> rows =
      fetchRowsInHead( objectTable,
                       ValidityKeyMin,
                       ValidityKeyMax,
                       ChannelSelection( 0, 0 ) );
    //copy( rows.begin(), rows.end(),
    //      std::ostream_iterator<RelationalObjectTableRow>( std::cout, "\n" ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "row count", 1u,
                                  (unsigned int)rows.size() );
    RelationalObjectTableRow& row = rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", ValidityKeyMax, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 payload", std::string("Object 1"),
                                  row["S"].data<std::string>() );
  }

  /// Tests fetchRowsForTaggingCurrentHead in the context of user tags
  void test_fetchRowsForTaggingCurrentHead_5c_with_userTag()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->storeObject( 1, 3, dummyPayload( 1 ), 0 );
    folder->storeObject( 6, 8, dummyPayload( 2 ), (ChannelId)0, "A" );
    folder->storeObject( 2, 4, dummyPayload( 3 ), (ChannelId)0, "B" );
    folder->storeObject( 3, 5, dummyPayload( 4 ), (ChannelId)0, "A" );
    folder->storeObject( 1, 5, dummyPayload( 5 ), (ChannelId)1 );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::vector<RelationalObjectTableRow> rows =
      objectTable.fetchRowsForTaggingCurrentHead( relfolder->payloadMode() );
    sort( rows.begin(), rows.end(), lt_objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "row count", 5u, (unsigned int)rows.size() );
    RelationalObjectTableRow& row = rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "0 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "0 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "0 since", (ValidityKey)6, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "0 until", (ValidityKey)8, row.until() );
    row = rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 14u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)2, row.until() );
    row = rows[2];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 19u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)3, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)5, row.until() );
    row = rows[3];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 object id", 20u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 until", (ValidityKey)3, row.until() );
    row = rows[4];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 object id", 25u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 channel id", 1u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 until", (ValidityKey)5, row.until() );
  }

  /// Tests fetchRowsForTaggingCurrentHead
  void test_fetchRowsForTaggingCurrentHead_5c()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->setupStorageBuffer();
    folder->storeObject( 1, 3, dummyPayload( 1 ), 0 );
    folder->storeObject( 6, 8, dummyPayload( 2 ), 0 );
    folder->flushStorageBuffer();
    folder->storeObject( 2, 4, dummyPayload( 3 ), 0 );
    folder->storeObject( 3, 5, dummyPayload( 4 ), 0 );
    folder->flushStorageBuffer();
    folder->storeObject( 1, 5, dummyPayload( 5 ), (ChannelId)1 );
    folder->flushStorageBuffer();
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::vector<RelationalObjectTableRow> rows =
      objectTable.fetchRowsForTaggingCurrentHead( relfolder->payloadMode() );
    sort( rows.begin(), rows.end(), lt_objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "row count", 5u, (unsigned int)rows.size() );
    RelationalObjectTableRow& row = rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "0 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "0 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "0 since", (ValidityKey)6, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "0 until", (ValidityKey)8, row.until() );
    row = rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 14u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)2, row.until() );
    row = rows[2];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 19u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)3, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)5, row.until() );
    row = rows[3];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 object id", 20u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 since", (ValidityKey)2, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "3 until", (ValidityKey)3, row.until() );
    row = rows[4];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 object id", 25u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 channel id", 1u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "4 until", (ValidityKey)5, row.until() );
  }

  /// Tests fetchRowsForTaggingHeadAsOfDate in the context of user tags
  void test_fetchRowsForTaggingHeadAsOfDate_5c_with_userTag()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->storeObject( 1, 3, dummyPayload( 1 ), (ChannelId)0, "A" );
    folder->storeObject( 6, 8, dummyPayload( 2 ), (ChannelId)0, "B" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction t1( ralDb->transactionMgr() );
    boost::shared_ptr<RelationalSequence> seq
      ( ralDb->queryMgr().sequenceMgr().getSequence
        ( RelationalObjectTable::sequenceName
          ( relfolder->objectTableName() ) ) );
    Time asOfDate = stringToTime( seq->currDate() );
    asOfDate = addOneNsToTime( asOfDate );
    t1.commit();
    // MySQL now() has 1 second granularity: need to sleep at least 1 second
    sleep(1);
    folder->storeObject( 2, 4, dummyPayload( 3 ), (ChannelId)0, "A" );
    folder->storeObject( 3, 5, dummyPayload( 4 ), (ChannelId)0, "B" );
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::vector<RelationalObjectTableRow> rows =
      objectTable.fetchRowsForTaggingHeadAsOfDate( asOfDate, relfolder->payloadMode() );
    //copy( rows.begin(), rows.end(),
    //      std::ostream_iterator<RelationalObjectTableRow>( std::cout, "\n" ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "row count", 2u, (unsigned int)rows.size() );
    RelationalObjectTableRow& row = rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "1 instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
        timeToString(row.insertionTime()).size() );
    row = rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)6, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "2 instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
        timeToString(row.insertionTime()).size() );
  }

  /// Tests fetchRowsForTaggingHeadAsOfDate
  void test_fetchRowsForTaggingHeadAsOfDate_5c()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->setupStorageBuffer();
    folder->storeObject( 1, 3, dummyPayload( 1 ), 0 );
    folder->storeObject( 6, 8, dummyPayload( 2 ), 0 );
    folder->flushStorageBuffer();
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction t1( ralDb->transactionMgr() );
    boost::shared_ptr<RelationalSequence> seq
      ( ralDb->queryMgr().sequenceMgr().getSequence
        ( RelationalObjectTable::sequenceName
          ( relfolder->objectTableName() ) ) );
    Time asOfDate = stringToTime( seq->currDate() );
    asOfDate = addOneNsToTime( asOfDate );
    t1.commit();
    // MySQL now() has 1 second granularity: need to sleep at least 1 second
    sleep(1);
    folder->storeObject( 2, 4, dummyPayload( 3 ), 0 );
    folder->storeObject( 3, 5, dummyPayload( 4 ), 0 );
    folder->flushStorageBuffer();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::vector<RelationalObjectTableRow> rows =
      objectTable.fetchRowsForTaggingHeadAsOfDate( asOfDate, relfolder->payloadMode() );
    //copy( rows.begin(), rows.end(),
    //      std::ostream_iterator<RelationalObjectTableRow>( std::cout, "\n" ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "row count", 2u, (unsigned int)rows.size() );
    RelationalObjectTableRow& row = rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "1 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "1 instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
        timeToString(row.insertionTime()).size() );
    row = rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 since", (ValidityKey)6, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "2 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "2 instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
        timeToString(row.insertionTime()).size() );
  }

  /// Tests fetchRowsInTag of all channels
  void test_fetchRowsInTag_all_channels()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    int index = 0;
    folder->setupStorageBuffer();
    for ( ChannelId ch = 0; ch < 2; ++ch ) {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( index++ ), ch );
      folder->storeObject( 1, ValidityKeyMax, dummyPayload( index++ ), ch );
    }
    folder->flushStorageBuffer();
    folder->tagCurrentHead( "A" );
    for ( ChannelId ch = 0; ch < 2; ++ch ) {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( index++ ), ch );
      folder->storeObject( 1, ValidityKeyMax, dummyPayload( index++ ), ch );
    }
    folder->flushStorageBuffer();
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::vector<RelationalObjectTableRow> rows =
      fetchRowsInTag( objectTable,
                      ValidityKeyMin,
                      ValidityKeyMax,
                      ChannelSelection::all(),
                      "A" );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "size", 4, (int)rows.size() );
    RelationalObjectTableRow row = rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 0",
                                  std::string("Object 0"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 0",
                                  (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 0",
                                  (ValidityKey)1, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 0",
                                  (ChannelId)0, row.channelId() );
    row = rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 1",
                                  std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 1",
                                  (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 1",
                                  ValidityKeyMax, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 1",
                                  (ChannelId)0, row.channelId() );
    row = rows[2];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 2",
                                  std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 2",
                                  (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 2",
                                  (ValidityKey)1, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 2",
                                  (ChannelId)1, row.channelId() );
    row = rows[3];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 3",
                                  std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 3",
                                  (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 3",
                                  ValidityKeyMax, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 3",
                                  (ChannelId)1, row.channelId() );
  }

  /// Tests fetchRowsInTag with a channel range and
  /// since-before-channel ordering
  void test_fetchRowsInTag_channel_range_ordering()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    int index = 0;
    folder->setupStorageBuffer();
    for ( ChannelId ch = 0; ch < 5; ++ch ) {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( index++ ), ch );
      folder->storeObject( 1, ValidityKeyMax, dummyPayload( index++ ), ch );
    }
    folder->flushStorageBuffer();
    folder->tagCurrentHead( "A" );
    for ( ChannelId ch = 0; ch < 5; ++ch ) {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( index++ ), ch );
      folder->storeObject( 1, ValidityKeyMax, dummyPayload( index++ ), ch );
    }
    folder->flushStorageBuffer();
    ChannelSelection channels( 2, 3, cool_ChannelSelection_Order::sinceBeforeChannel );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::vector<RelationalObjectTableRow> rows =
      fetchRowsInTag( objectTable,
                      ValidityKeyMin,
                      ValidityKeyMax,
                      channels,
                      "A" );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "size", 4, (int)rows.size() );
    RelationalObjectTableRow row = rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 0",
                                  std::string("Object 4"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 0",
                                  (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 0",
                                  (ValidityKey)1, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 0",
                                  (ChannelId)2, row.channelId() );
    row = rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 1",
                                  std::string("Object 6"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 1",
                                  (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 1",
                                  (ValidityKey)1, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 1",
                                  (ChannelId)3, row.channelId() );
    row = rows[2];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 2",
                                  std::string("Object 5"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 2",
                                  (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 2",
                                  ValidityKeyMax, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 2",
                                  (ChannelId)2, row.channelId() );
    row = rows[3];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 3",
                                  std::string("Object 7"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 3",
                                  (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 3",
                                  ValidityKeyMax, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 3",
                                  (ChannelId)3, row.channelId() );
  }

  /// Tests fetchRowsInTag with a channel range
  void test_fetchRowsInTag_channel_range()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    int index = 0;
    folder->setupStorageBuffer();
    for ( ChannelId ch = 0; ch < 5; ++ch ) {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( index++ ), ch );
      folder->storeObject( 1, ValidityKeyMax, dummyPayload( index++ ), ch );
    }
    folder->flushStorageBuffer();
    folder->tagCurrentHead( "A" );
    for ( ChannelId ch = 0; ch < 5; ++ch ) {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( index++ ), ch );
      folder->storeObject( 1, ValidityKeyMax, dummyPayload( index++ ), ch );
    }
    folder->flushStorageBuffer();
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::vector<RelationalObjectTableRow> rows =
      fetchRowsInTag( objectTable,
                      ValidityKeyMin,
                      ValidityKeyMax,
                      ChannelSelection( 2, 3 ),
                      "A" );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "size", 4, (int)rows.size() );
    RelationalObjectTableRow row = rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 0",
                                  std::string("Object 4"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 0",
                                  (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 0",
                                  (ValidityKey)1, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 0",
                                  (ChannelId)2, row.channelId() );
    row = rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 1",
                                  std::string("Object 5"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 1",
                                  (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 1",
                                  ValidityKeyMax, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 1",
                                  (ChannelId)2, row.channelId() );
    row = rows[2];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 2",
                                  std::string("Object 6"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 2",
                                  (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 2",
                                  (ValidityKey)1, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 2",
                                  (ChannelId)3, row.channelId() );
    row = rows[3];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 3",
                                  std::string("Object 7"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 3",
                                  (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 3",
                                  ValidityKeyMax, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 3",
                                  (ChannelId)3, row.channelId() );
  }

  /// Tests fetchRowsInHead of all channels
  void test_fetchRowsInHead_all_channels()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    int index = 0;
    folder->setupStorageBuffer();
    for ( ChannelId ch = 0; ch < 2; ++ch ) {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( index++ ), ch );
      folder->storeObject( 1, ValidityKeyMax, dummyPayload( index++ ), ch );
    }
    folder->flushStorageBuffer();
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::vector<RelationalObjectTableRow> rows =
      fetchRowsInHead( objectTable,
                       ValidityKeyMin,
                       ValidityKeyMax,
                       ChannelSelection::all() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "size", 4, (int)rows.size() );
    RelationalObjectTableRow row = rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 0",
                                  std::string("Object 0"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 0",
                                  (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 0",
                                  (ValidityKey)1, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 0",
                                  (ChannelId)0, row.channelId() );
    row = rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 1",
                                  std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 1",
                                  (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 1",
                                  ValidityKeyMax, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 1",
                                  (ChannelId)0, row.channelId() );
    row = rows[2];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 2",
                                  std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 2",
                                  (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 2",
                                  (ValidityKey)1, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 2",
                                  (ChannelId)1, row.channelId() );
    row = rows[3];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 3",
                                  std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 3",
                                  (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 3",
                                  ValidityKeyMax, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 3",
                                  (ChannelId)1, row.channelId() );
  }

  /// Tests fetchRowsInHead with a channel range and
  /// since-before-channel ordering
  void test_fetchRowsInHead_channel_range_ordering()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    int index = 0;
    folder->setupStorageBuffer();
    for ( ChannelId ch = 0; ch < 5; ++ch ) {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( index++ ), ch );
      folder->storeObject( 1, ValidityKeyMax, dummyPayload( index++ ), ch );
    }
    folder->flushStorageBuffer();
    ChannelSelection channels( 2, 3, cool_ChannelSelection_Order::sinceBeforeChannel );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::vector<RelationalObjectTableRow> rows =
      fetchRowsInHead( objectTable,
                       ValidityKeyMin,
                       ValidityKeyMax,
                       channels );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "size", 4, (int)rows.size() );
    RelationalObjectTableRow row = rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 0",
                                  std::string("Object 4"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 0",
                                  (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 0",
                                  (ValidityKey)1, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 0",
                                  (ChannelId)2, row.channelId() );
    row = rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 1",
                                  std::string("Object 6"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 1",
                                  (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 1",
                                  (ValidityKey)1, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 1",
                                  (ChannelId)3, row.channelId() );
    row = rows[2];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 2",
                                  std::string("Object 5"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 2",
                                  (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 2",
                                  ValidityKeyMax, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 2",
                                  (ChannelId)2, row.channelId() );
    row = rows[3];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 3",
                                  std::string("Object 7"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 3",
                                  (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 3",
                                  ValidityKeyMax, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 3",
                                  (ChannelId)3, row.channelId() );
  }

  /// Tests fetchRowsInHead with a channel range
  void test_fetchRowsInHead_channel_range()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    int index = 0;
    folder->setupStorageBuffer();
    for ( ChannelId ch = 0; ch < 5; ++ch ) {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( index++ ), ch );
      folder->storeObject( 1, ValidityKeyMax, dummyPayload( index++ ), ch );
    }
    folder->flushStorageBuffer();
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::vector<RelationalObjectTableRow> rows =
      fetchRowsInHead( objectTable,
                       ValidityKeyMin,
                       ValidityKeyMax,
                       ChannelSelection( 2, 3 ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "size", 4, (int)rows.size() );
    RelationalObjectTableRow row = rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 0",
                                  std::string("Object 4"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 0",
                                  (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 0",
                                  (ValidityKey)1, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 0",
                                  (ChannelId)2, row.channelId() );
    row = rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 1",
                                  std::string("Object 5"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 1",
                                  (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 1",
                                  ValidityKeyMax, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 1",
                                  (ChannelId)2, row.channelId() );
    row = rows[2];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 2",
                                  std::string("Object 6"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 2",
                                  (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 2",
                                  (ValidityKey)1, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 2",
                                  (ChannelId)3, row.channelId() );
    row = rows[3];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 3",
                                  std::string("Object 7"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 3",
                                  (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 3",
                                  ValidityKeyMax, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 3",
                                  (ChannelId)3, row.channelId() );
  }

  /// Tests fetchRowAtTimeInTag
  void test_fetchRowAtTimeInTag_5c()
  {
    try
    {
      IFolderPtr folder = s_db->getFolder( "/fMV" );
      folder->setupStorageBuffer();
      folder->storeObject( 1, 3, dummyPayload( 1 ), 0 );
      folder->storeObject( 6, 8, dummyPayload( 2 ), 0 );
      folder->flushStorageBuffer();
      folder->tagCurrentHead( "mytagA", "a tag A" );
      folder->storeObject( 2, 4, dummyPayload( 3 ), 0 );
      folder->storeObject( 3, 5, dummyPayload( 4 ), 0 );
      folder->flushStorageBuffer();
      TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
      if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
      RelationalFolder* relfolder = trelfolder->getRelFolder();
      RelationalTransaction transaction( ralDb->transactionMgr() );
      RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
      //RelationalObjectTableRow row =
      //  objectTable.fetchRowAtTimeInTag( (ValidityKey)2,
      //                                   (ChannelId)0,
      //                                   "mytagA" );
      RelationalTableRow row0;
      {
        const ValidityKey pointInTime = (ValidityKey)2;
        const ChannelId channelId = (ChannelId)0;
        const std::string tagName = "mytagA";
        const std::auto_ptr<IRelationalQueryDefinition>
          def( objectTable.queryDefinitionTag
               ( pointInTime, pointInTime, channelId, tagName ) );
        // Delegate the query to the RalQueryMgr
        try
        {
          std::string desc = "";
          const std::vector<RelationalTableRow> rows
            ( objectTable.queryMgr().fetchOrderedRows( *def, desc, 1 ) );
          row0 = rows[0];
        }
        catch( NoRowsFound& )
        {
          std::stringstream s;
          s << pointInTime;
          throw ObjectNotFound
            ( s.str(), objectTable.objectTableName(), "RelationalObjectTable" );
        }
      }
      RelationalObjectTableRow row(row0);
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object id", 1u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel id", 0u, row.channelId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "since", (ValidityKey)1, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "until", (ValidityKey)3, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload", std::string("Object 1"),
                                    row["S"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "original id", 0u, row.originalId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "new head id", 13u, row.newHeadId() );
    }
    catch ( std::exception& e )
    {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /// Tests test_fetchRowsForTaggingHeadAsOfObjectId_5c in the context of user
  /// tags
  void test_fetchRowsForTaggingHeadAsOfObjectId_5c_with_userTag()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    try {
      folder->storeObject( 1, 3, dummyPayload( 1 ), (ChannelId)0, "A" );
      folder->storeObject( 6, 8, dummyPayload( 2 ), (ChannelId)0, "B" );
      folder->storeObject( 2, 4, dummyPayload( 3 ), (ChannelId)0, "A" );
      folder->storeObject( 3, 5, dummyPayload( 4 ), (ChannelId)0, "B" );
      TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
      if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
      RelationalFolder* relfolder = trelfolder->getRelFolder();
      RelationalTransaction transaction( ralDb->transactionMgr() );
      RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
      unsigned int uObjectId = 7; // user object
      unsigned int lObjectId = 8; // left system object
      unsigned int rObjectId = 9; // right system object
      std::vector<RelationalObjectTableRow> uRows =
        objectTable.fetchRowsForTaggingHeadAsOfObjectId( uObjectId, relfolder->payloadMode() );
      std::vector<RelationalObjectTableRow> lRows =
        objectTable.fetchRowsForTaggingHeadAsOfObjectId( lObjectId, relfolder->payloadMode() );
      std::vector<RelationalObjectTableRow> rRows =
        objectTable.fetchRowsForTaggingHeadAsOfObjectId( rObjectId, relfolder->payloadMode() );
      //copy( uRows.begin(), uRows.end(),
      //      std::ostream_iterator<RelationalObjectTableRow>( std::cout, "\n" ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "(u) row count", 2u, (unsigned int)uRows.size() );
      RelationalObjectTableRow& row = uRows[0];
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 1 object id", 1u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 1 channel id", 0u, row.channelId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 1 since", (ValidityKey)1, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 1 until", (ValidityKey)3, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "(u) 1 instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
          timeToString(row.insertionTime()).size() );
      row = uRows[1];
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 2 object id", 7u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 2 channel id", 0u, row.channelId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 2 since", (ValidityKey)6, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 2 until", (ValidityKey)8, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "(u) 2 instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
          timeToString(row.insertionTime()).size() );
      //copy( lRows.begin(), lRows.end(),
      //      std::ostream_iterator<RelationalObjectTableRow>( std::cout, "\n" ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "(l) row count", 2u, (unsigned int)lRows.size() );
      row = lRows[0];
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 1 object id", 1u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 1 channel id", 0u, row.channelId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 1 since", (ValidityKey)1, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 1 until", (ValidityKey)3, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "(l) 1 instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
          timeToString(row.insertionTime()).size() );
      row = lRows[1];
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 2 object id", 7u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 2 channel id", 0u, row.channelId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 2 since", (ValidityKey)6, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 2 until", (ValidityKey)8, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "(l) 2 instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
          timeToString(row.insertionTime()).size() );
      //copy( rRows.begin(), rRows.end(),
      //      std::ostream_iterator<RelationalObjectTableRow>( std::cout, "\n" ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "(r) row count", 2u, (unsigned int)rRows.size() );
      row = rRows[0];
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 1 object id", 1u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 1 channel id", 0u, row.channelId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 1 since", (ValidityKey)1, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 1 until", (ValidityKey)3, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "(r) 1 instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
          timeToString(row.insertionTime()).size() );
      row = rRows[1];
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 2 object id", 7u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 2 channel id", 0u, row.channelId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 2 since", (ValidityKey)6, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 2 until", (ValidityKey)8, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "(r) 2 instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
          timeToString(row.insertionTime()).size() );
    } catch ( std::exception& e ) {
      std::cout << e.what() << std::endl;
      throw;
    }
  }

  /// Tests test_fetchRowsForTaggingHeadAsOfObjectId_5c
  void test_fetchRowsForTaggingHeadAsOfObjectId_5c()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    try {
      folder->setupStorageBuffer();
      folder->storeObject( 1, 3, dummyPayload( 1 ), 0 );
      folder->storeObject( 6, 8, dummyPayload( 2 ), 0 );
      folder->flushStorageBuffer();
      folder->storeObject( 2, 4, dummyPayload( 3 ), 0 );
      folder->storeObject( 3, 5, dummyPayload( 4 ), 0 );
      folder->flushStorageBuffer();
      TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
      if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
      RelationalFolder* relfolder = trelfolder->getRelFolder();
      RelationalTransaction transaction( ralDb->transactionMgr() );
      RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
      unsigned int uObjectId = 7; // user object
      unsigned int lObjectId = 8; // left system object
      unsigned int rObjectId = 9; // right system object
      std::vector<RelationalObjectTableRow> uRows =
        objectTable.fetchRowsForTaggingHeadAsOfObjectId( uObjectId, relfolder->payloadMode() );
      std::vector<RelationalObjectTableRow> lRows =
        objectTable.fetchRowsForTaggingHeadAsOfObjectId( lObjectId, relfolder->payloadMode() );
      std::vector<RelationalObjectTableRow> rRows =
        objectTable.fetchRowsForTaggingHeadAsOfObjectId( rObjectId, relfolder->payloadMode() );
      //copy( uRows.begin(), uRows.end(),
      //      std::ostream_iterator<RelationalObjectTableRow>( std::cout, "\n" ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "(u) row count", 2u, (unsigned int)uRows.size() );
      RelationalObjectTableRow& row = uRows[0];
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 1 object id", 1u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 1 channel id", 0u, row.channelId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 1 since", (ValidityKey)1, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 1 until", (ValidityKey)3, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "(u) 1 instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
          timeToString(row.insertionTime()).size() );
      row = uRows[1];
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 2 object id", 7u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 2 channel id", 0u, row.channelId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 2 since", (ValidityKey)6, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 2 until", (ValidityKey)8, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "(u) 2 instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
          timeToString(row.insertionTime()).size() );
      //copy( lRows.begin(), lRows.end(),
      //      std::ostream_iterator<RelationalObjectTableRow>( std::cout, "\n" ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "(l) row count", 2u, (unsigned int)lRows.size() );
      row = lRows[0];
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 1 object id", 1u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 1 channel id", 0u, row.channelId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 1 since", (ValidityKey)1, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 1 until", (ValidityKey)3, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "(l) 1 instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
          timeToString(row.insertionTime()).size() );
      row = lRows[1];
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 2 object id", 7u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 2 channel id", 0u, row.channelId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 2 since", (ValidityKey)6, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 2 until", (ValidityKey)8, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "(l) 2 instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
          timeToString(row.insertionTime()).size() );
      //copy( rRows.begin(), rRows.end(),
      //      std::ostream_iterator<RelationalObjectTableRow>( std::cout, "\n" ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "(r) row count", 2u, (unsigned int)rRows.size() );
      row = rRows[0];
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 1 object id", 1u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 1 channel id", 0u, row.channelId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 1 since", (ValidityKey)1, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 1 until", (ValidityKey)3, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "(r) 1 instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
          timeToString(row.insertionTime()).size() );
      row = rRows[1];
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 2 object id", 7u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 2 channel id", 0u, row.channelId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 2 since", (ValidityKey)6, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 2 until", (ValidityKey)8, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "(r) 2 instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
          timeToString(row.insertionTime()).size() );
    } catch ( std::exception& e ) {
      std::cout << e.what() << std::endl;
      throw;
    }
  }

  /// Tests fetchRowsForTaggingHeadAsOfObjectId for a duplicate IOV
  void test_fetchRowsForTaggingHeadAsOfObjectId_duplIOV()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    folder->setupStorageBuffer();
    folder->storeObject( 1, 3, dummyPayload( 1 ), 0 );
    folder->storeObject( 6, 8, dummyPayload( 2 ), 0 );
    // DUPLICATE!
    folder->storeObject( 6, 8, dummyPayload( 5 ), 0 );
    folder->flushStorageBuffer();
    folder->storeObject( 2, 4, dummyPayload( 3 ), 0 );
    folder->storeObject( 3, 5, dummyPayload( 4 ), 0 );
    folder->flushStorageBuffer();
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    unsigned int uObjectId = 7; // user object
    unsigned int lObjectId = 8; // left system object
    unsigned int rObjectId = 9; // right system object
    std::vector<RelationalObjectTableRow> uRows =
      objectTable.fetchRowsForTaggingHeadAsOfObjectId( uObjectId, relfolder->payloadMode() );
    std::vector<RelationalObjectTableRow> lRows =
      objectTable.fetchRowsForTaggingHeadAsOfObjectId( lObjectId, relfolder->payloadMode() );
    std::vector<RelationalObjectTableRow> rRows =
      objectTable.fetchRowsForTaggingHeadAsOfObjectId( rObjectId, relfolder->payloadMode() );
    //copy( uRows.begin(), uRows.end(),
    //      std::ostream_iterator<RelationalObjectTableRow>( std::cout, "\n" ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "(u) row count", 2u, (unsigned int)uRows.size() );
    RelationalObjectTableRow& row = uRows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 1 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 1 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 1 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "(u) 1 instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
        timeToString(row.insertionTime()).size() );
    row = uRows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 2 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 2 since", (ValidityKey)6, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(u) 2 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "(u) 2 instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
        timeToString(row.insertionTime()).size() );
    //copy( lRows.begin(), lRows.end(),
    //      std::ostream_iterator<RelationalObjectTableRow>( std::cout, "\n" ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "(l) row count", 2u, (unsigned int)lRows.size() );
    row = lRows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 1 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 1 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 1 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "(l) 1 instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
        timeToString(row.insertionTime()).size() );
    row = lRows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 2 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 2 since", (ValidityKey)6, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(l) 2 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "(l) 2 instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
        timeToString(row.insertionTime()).size() );
    //copy( rRows.begin(), rRows.end(),
    //      std::ostream_iterator<RelationalObjectTableRow>( std::cout, "\n" ) );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "(r) row count", 2u, (unsigned int)rRows.size() );
    row = rRows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 1 object id", 1u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 1 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 1 since", (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 1 until", (ValidityKey)3, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "(r) 1 instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
        timeToString(row.insertionTime()).size() );
    row = rRows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 2 object id", 7u, row.objectId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 2 channel id", 0u, row.channelId() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 2 since", (ValidityKey)6, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "(r) 2 until", (ValidityKey)8, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "(r) 2 instime", std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
        timeToString(row.insertionTime()).size() );
  }

  /// Tests fetchLastRowForTagId (bug #40812)
  void test_fetchLastRowForTagId()
  {
    IFolderPtr folder = s_db->getFolder( "/fMV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    folder->setupStorageBuffer();
    folder->storeObject( 0, 4, dummyPayload( 0 ), 0 );
    folder->storeObject( 1, 5, dummyPayload( 1 ), 0 );
    folder->storeObject( 2, 6, dummyPayload( 2 ), 0 );
    folder->flushStorageBuffer();
    folder->tagCurrentHead( "tag A" );
    folder->storeObject( 1, 5, dummyPayload( 1 ), 0 );
    folder->storeObject( 2, 6, dummyPayload( 2 ), 0 );
    folder->flushStorageBuffer();
    folder->storeObject( 3, 8, dummyPayload( 3 ), 0, "tag B");
    folder->storeObject( 2, 6, dummyPayload( 4 ), 0, "tag B");
    folder->flushStorageBuffer();
    folder->storeObject( 4, 5, dummyPayload( 5 ), 0);
    folder->flushStorageBuffer();
    // test IOV tag
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
      unsigned int tagId = 1;
      bool fetchPayload = true;
      RelationalObjectTableRow row =
        objectTable.fetchLastRowForTagId( tagId, fetchPayload );
      transaction.commit();
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "objectId", 14u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "since", (ValidityKey)1, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "until", (ValidityKey)2, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload",
                                    std::string( "Object 1" ),
                                    row["S"].data<std::string>() );
    }
    // test user tag
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
      unsigned int tagId = 2;
      bool fetchPayload = true;
      RelationalObjectTableRow row =
        objectTable.fetchLastRowForTagId( tagId, fetchPayload );
      transaction.commit();
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "objectId", 42u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "since", (ValidityKey)6, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "until", (ValidityKey)8, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload",
                                    std::string( "Object 3" ),
                                    row["S"].data<std::string>() );
    }
  }

  /*
  /// Tests fetchRowAtTimeSV
  void test_fetchRowAtTimeSV()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    try {
      TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
      if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" ); // Fix Coverity FORWARD_NULL
      RelationalFolder* relfolder = trelfolder->getRelFolder();
      folder->setupStorageBuffer();
      folder->storeObject( 0, 2, dummyPayload( 1 ), 0 );
      folder->storeObject( 2, 4, dummyPayload( 2 ), 0 );
      folder->flushStorageBuffer();
      RelationalTransaction transaction( ralDb->transactionMgr() );
      RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
      RelationalObjectTableRow
        row( objectTable.fetchRowAtTimeSV( (ValidityKey)3,
                                           (ChannelId)0 ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object_id", 2u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel id", 0u, row.channelId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "iov since", (ValidityKey)2, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "iov until", (ValidityKey)4, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "instime length",
          std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
          timeToString(row.insertionTime()).size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "field I", 2, row["I"].data<int>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "field S", std::string("Object 2"), row["S"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "field X", 0.002f, row["X"].data<float>() );
      transaction.commit();
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }
  *///

  /*
  /// Test for bug #16903 - all three backends fail with "No rows selected"
  /// (Oracle with "ORA-01455: converting column overflows integer datatype")
  void test_fetchRowAtTimeSV64bit()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    try {
      TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
      if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" ); // Fix Coverity FORWARD_NULL
      RelationalFolder* relfolder = trelfolder->getRelFolder();
      ValidityKey vk0 = ValidityKeyMax-10;
      folder->setupStorageBuffer();
      folder->storeObject( vk0, vk0+2, dummyPayload( 1 ), 0 );
      folder->storeObject( vk0+2, vk0+4, dummyPayload( 2 ), 0 );
      folder->flushStorageBuffer();
      RelationalTransaction transaction( ralDb->transactionMgr() );
      RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
      RelationalObjectTableRow
        row( objectTable.fetchRowAtTimeSV( vk0+3, (ChannelId)0 ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object_id", 2u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel id", 0u, row.channelId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "iov since", vk0+2, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "iov until", vk0+4, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "instime length",
          std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
          timeToString(row.insertionTime()).size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "field I", 2, row["I"].data<int>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "field S", std::string("Object 2"), row["S"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "field X", 0.002f, row["X"].data<float>() );
      transaction.commit();
    } catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }
  *///

  /// Tests fetchRowForId
  void test_fetchRowForId()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    try {
      TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
      if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
      RelationalFolder* relfolder = trelfolder->getRelFolder();
      folder->setupStorageBuffer();
      folder->storeObject( 0, 2, dummyPayload( 1 ), 0 );
      folder->storeObject( 2, 4, dummyPayload( 2 ), 0 );
      folder->flushStorageBuffer();
      unsigned int object_id = 1;
      RelationalTransaction transaction( ralDb->transactionMgr() );
      RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
      bool fetchPayload = true;
      RelationalObjectTableRow
        row1( objectTable.fetchRowForId( object_id, fetchPayload ) );
      fetchPayload = false;
      RelationalObjectTableRow
        row2( objectTable.fetchRowForId( object_id, fetchPayload ) );
      transaction.commit();
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "object_id", 1u, row1.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "channel id", 0u, row1.channelId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "iov since", (ValidityKey)0, row1.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "iov until", (ValidityKey)2, row1.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "NODE_INSTIME length",
          std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
          timeToString(row1.insertionTime()).size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "field I", 1, row1["I"].data<int>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "field S", std::string("Object 1"), row1["S"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "field X", 0.001f, row1["X"].data<float>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "object_id", 1u, row2.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "channel id", 0u, row2.channelId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "iov since", (ValidityKey)0, row2.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "iov until", (ValidityKey)2, row2.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "NODE_INSTIME length",
          std::string("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT").size(),
          timeToString(row2.insertionTime()).size() );
      try { row2["I"]; CPPUNIT_FAIL( "row2[I] - no exception thrown" ); }
      catch ( coral::AttributeListException& ) {}
      catch ( ... ) { CPPUNIT_FAIL( "row2[I] - unknown exception caught" ); }
      try { row2["S"]; CPPUNIT_FAIL( "row2[S] - no exception thrown" ); }
      catch ( coral::AttributeListException& ) {}
      catch ( ... ) { CPPUNIT_FAIL( "row2[S] - unknown exception caught" ); }
      try { row2["X"]; CPPUNIT_FAIL( "row2[X] - no exception thrown" ); }
      catch ( coral::AttributeListException& ) {}
      catch ( ... ) { CPPUNIT_FAIL( "row2[X] - unknown exception caught" ); }
    }
    catch( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  /*
  /// Tests fetchLastRowSV
  void test_fetchLastRowSV()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" ); // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    folder->setupStorageBuffer();
    folder->storeObject( 0, 2, dummyPayload( 0 ), 1 );
    folder->storeObject( 2, 4, dummyPayload( 0 ), 1 );
    folder->storeObject( 0, 2, dummyPayload( 0 ), 2 );
    folder->storeObject( 2, 4, dummyPayload( 0 ), 2 );
    folder->storeObject( 0, 2, dummyPayload( 0 ), 3 );
    folder->storeObject( 2, 4, dummyPayload( 0 ), 3 );
    folder->storeObject( 4, 6, dummyPayload( 0 ), 1 );
    folder->flushStorageBuffer();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    {
      RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
      RelationalObjectTableRow
        row( objectTable.fetchLastRowSV( (ChannelId)1 ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "first channel", 7u, row.objectId() );
    }
    {
      RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
      RelationalObjectTableRow
        row( objectTable.fetchLastRowSV( (ChannelId)2 ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "second channel", 4u, row.objectId() );
    }
    {
      RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
      RelationalObjectTableRow
        row( objectTable.fetchLastRowSV( (ChannelId)3 ) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "third channel", 6u, row.objectId() );
    }
    transaction.commit();
  }
  *///

  /// Tests fetchRowForId for a directly stored row (not via the API)
  void test_fetchRowForId_data()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      coral::ITable& chTable = ralDb->session().nominalSchema().tableHandle
        ( relfolder->channelTableName() );
      RecordSpecification chSpec =
        RelationalChannelTable::tableSpecification();
      coral::AttributeList chData = Record( chSpec ).attributeList();
      chData["CHANNEL_ID"].setValue( 2u );
      chTable.dataEditor().insertRow( chData );
      coral::ITable& table = ralDb->session().nominalSchema().tableHandle
        ( relfolder->objectTableName() );
      RecordSpecification spec =
        RelationalObjectTable::tableSpecification( payloadSpec, cool_PayloadMode_Mode::INLINEPAYLOAD );
      coral::AttributeList data = Record( spec ).attributeList();
      data["OBJECT_ID"].setValue( 1u );
      data["CHANNEL_ID"].setValue( 2u );
      data["IOV_SINCE"].setValue( (ValidityKey)3 );
      data["IOV_UNTIL"].setValue( (ValidityKey)4 );
      data["USER_TAG_ID"].setValue( 5u );
      std::string insertionTime = "2006-03-04_18:38:59.803342000 GMT";
      data["SYS_INSTIME"].setValue( insertionTime );
      data["ORIGINAL_ID"].setValue( 6u );
      data["NEW_HEAD_ID"].setValue( 7u );
      data["I"].setValue( 8 );
      data["S"].setValue( std::string( "9" ) );
      data["X"].setValue( 10.0f );
      table.dataEditor().insertRow( data );
      transaction.commit();
    }
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
      bool fetchPayload = true;
      RelationalObjectTableRow
        row( objectTable.fetchRowForId( 1, fetchPayload ) );
      transaction.commit();
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "object_id", 1u, row.objectId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel id", 2u, row.channelId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "iov since", (ValidityKey)3, row.since() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "iov until", (ValidityKey)4, row.until() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "user_tag_id", 5u, row.userTagId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( std::string("NODE_INSTIME"),
          std::string("2006-03-04_18:38:59.803342000 GMT"),
          timeToString(row.insertionTime()) );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "orignal id", 6u, row.originalId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "new head id", 7u, row.newHeadId() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "field I", 8, row["I"].data<int>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "field S", std::string("9"),
                                    row["S"].data<std::string>() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "field X", 10.0f, row["X"].data<float>() );
    }
  }

  /*
  /// Tests fetchRowsSV with a channel range and
  /// since-before-channel ordering
  void test_fetchRowsSV_channel_range_ordering()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" ); // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    int index = 0;
    folder->setupStorageBuffer();
    for ( ChannelId ch = 0; ch < 5; ++ch ) {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( index++ ), ch );
      folder->storeObject( 1, ValidityKeyMax, dummyPayload( index++ ), ch );
    }
    folder->flushStorageBuffer();
    ChannelSelection channels( 2, 3, cool_ChannelSelection_Order::sinceBeforeChannel );
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::vector<RelationalObjectTableRow> rows =
      objectTable.fetchRowsSV( relfolder->payloadSpecification(),
                               ValidityKeyMin,
                               ValidityKeyMax,
                               channels );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "size", 4, (int)rows.size() );
    RelationalObjectTableRow row = rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 0",
                                  std::string("Object 4"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 0",
                                  (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 0",
                                  (ValidityKey)1, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 0",
                                  (ChannelId)2, row.channelId() );
    row = rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 1",
                                  std::string("Object 6"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 1",
                                  (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 1",
                                  (ValidityKey)1, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 1",
                                  (ChannelId)3, row.channelId() );
    row = rows[2];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 2",
                                  std::string("Object 5"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 2",
                                  (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 2",
                                  ValidityKeyMax, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 2",
                                  (ChannelId)2, row.channelId() );
    row = rows[3];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 3",
                                  std::string("Object 7"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 3",
                                  (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 3",
                                  ValidityKeyMax, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 3",
                                  (ChannelId)3, row.channelId() );
  }

  /// Tests fetchRowsSV with a channel range
  void test_fetchRowsSV_channel_range()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" ); // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    int index = 0;
    folder->setupStorageBuffer();
    for ( ChannelId ch = 0; ch < 5; ++ch ) {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( index++ ), ch );
      folder->storeObject( 1, ValidityKeyMax, dummyPayload( index++ ), ch );
    }
    folder->flushStorageBuffer();
    ChannelSelection channels( 2, 3 );
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::vector<RelationalObjectTableRow> rows =
      objectTable.fetchRowsSV( relfolder->payloadSpecification(),
                               ValidityKeyMin,
                               ValidityKeyMax,
                               channels );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "size", 4u, (unsigned int)rows.size() );
    RelationalObjectTableRow row = rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 0",
                                  std::string("Object 4"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 0",
                                  (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 0",
                                  (ValidityKey)1, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 0",
                                  (ChannelId)2, row.channelId() );
    row = rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 1",
                                  std::string("Object 5"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 1",
                                  (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 1",
                                  ValidityKeyMax, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 1",
                                  (ChannelId)2, row.channelId() );
    row = rows[2];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 2",
                                  std::string("Object 6"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 2",
                                  (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 2",
                                  (ValidityKey)1, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 2",
                                  (ChannelId)3, row.channelId() );
    row = rows[3];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 3",
                                  std::string("Object 7"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 3",
                                  (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 3",
                                  ValidityKeyMax, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 3",
                                  (ChannelId)3, row.channelId() );
  }

  /// Tests fetchRowsSV of all channels
  void test_fetchRowsSV_all_channels()
  {
    IFolderPtr folder = s_db->getFolder( "/fSV" );
    int index = 0;
    folder->setupStorageBuffer();
    for ( ChannelId ch = 0; ch < 2; ++ch ) {
      folder->storeObject( 0, ValidityKeyMax, dummyPayload( index++ ), ch );
      folder->storeObject( 1, ValidityKeyMax, dummyPayload( index++ ), ch );
    }
    folder->flushStorageBuffer();
    TransRelFolder* trelfolder = dynamic_cast<TransRelFolder*>( folder.get() );
    if ( !trelfolder ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" ); // Fix Coverity FORWARD_NULL
    RelationalFolder* relfolder = trelfolder->getRelFolder();
    RelationalTransaction transaction( ralDb->transactionMgr() );
    RelationalObjectTable objectTable( ralDb->queryMgr(), *relfolder );
    std::vector<RelationalObjectTableRow> rows =
      objectTable.fetchRowsSV( relfolder->payloadSpecification(),
                               ValidityKeyMin,
                               ValidityKeyMax,
                               ChannelSelection::all() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "size", 4, (int)rows.size() );
    RelationalObjectTableRow row = rows[0];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 0",
                                  std::string("Object 0"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 0",
                                  (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 0",
                                  (ValidityKey)1, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 0",
                                  (ChannelId)0, row.channelId() );
    row = rows[1];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 1",
                                  std::string("Object 1"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 1",
                                  (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 1",
                                  ValidityKeyMax, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 1",
                                  (ChannelId)0, row.channelId() );
    row = rows[2];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 2",
                                  std::string("Object 2"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 2",
                                  (ValidityKey)0, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 2",
                                  (ValidityKey)1, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 2",
                                  (ChannelId)1, row.channelId() );
    row = rows[3];
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "payload 3",
                                  std::string("Object 3"),
                                  row["S"].data<std::string>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "since 3",
                                  (ValidityKey)1, row.since() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "until 3",
                                  ValidityKeyMax, row.until() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "channel 3",
                                  (ChannelId)1, row.channelId() );
  }
  *///

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  // Constructor (executed N times, _before_ all N test executions)
  RelationalObjectTableTest()
    : CoolDBUnitTest()
    , ralDb( 0 ) // Fix Coverity UNINIT_CTOR
    , payloadSpec()
  {
    payloadSpec.extend("I",cool_StorageType_TypeId::Int32);
    payloadSpec.extend("S",cool_StorageType_TypeId::String255);
    payloadSpec.extend("X",cool_StorageType_TypeId::Float);
  }

  // Destructor (executed N times, _after_ all N test executions)
  ~RelationalObjectTableTest()
  {
  }

private:

  RalDatabase* ralDb; // safely cast pointer to db
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
      TransRalDatabase* traldb = dynamic_cast<TransRalDatabase*>( s_db.get() );
      if ( !traldb ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
      ralDb = traldb->getRalDb();
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
  Time addOneNsToTime( ITime& time )
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
#ifdef COOL290CO
    // Create the SV folder
    s_db->createFolder( "/fSV", FolderSpecification( cool_FolderVersioning_Mode::SINGLE_VERSION, payloadSpec ), "SV folder" );
    // Create the MV folder
    s_db->createFolder( "/fMV", FolderSpecification( cool_FolderVersioning_Mode::MULTI_VERSION, payloadSpec ), "MV folder" );
#else
    // Create the SV folder
    s_db->createFolder( "/fSV", payloadSpec, "SV folder",
                        cool_FolderVersioning_Mode::SINGLE_VERSION );
    // Create the MV folder
    s_db->createFolder( "/fMV", payloadSpec, "MV folder",
                        cool_FolderVersioning_Mode::MULTI_VERSION );
#endif
  }

};

CPPUNIT_TEST_SUITE_REGISTRATION( cool::RelationalObjectTableTest );

COOLTEST_MAIN( RelationalObjectTableTest )
