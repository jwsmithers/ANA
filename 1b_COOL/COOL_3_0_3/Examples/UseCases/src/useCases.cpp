
#include <cstdio> // For sprintf on gcc45
#include <iomanip>
#include <iostream>
#include <iterator>
#include "CoralBase/Attribute.h"

// COOL API include files (CoolKernel)
#include "CoolKernel/Exception.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/IDatabase.h"
#include "CoolKernel/IFolder.h"
#include "CoolKernel/IFolderSet.h"
#include "CoolKernel/IObject.h"
#include "CoolKernel/IObjectIterator.h"
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordSpecification.h"

// COOL example library include files (ExampleBase)
#include "ExampleBase/ExampleApplication.h"

// COOL namespace
using namespace cool;

//-----------------------------------------------------------------------------

/// Pretty printout of a cool::Time
const std::string timeToString( const cool::Time& time )
{
  int year = time.year( );
  int month = time.month( ) + 1; // Months are in [0-11]
  int day = time.day( );
  int hour = time.hour( );
  int min = time.minute( );
  int sec = time.second( );
  long nsec = time.nanosecond();
  char timeString[] = "yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT";
  int nChar = std::string(timeString).size();
  if ( snprintf( timeString, 30, // Fix Coverity SECURE_CODING
                 "%4.4d-%2.2d-%2.2d_%2.2d:%2.2d:%2.2d.%9.9ld GMT",
                 year, month, day, hour, min, sec, nsec) == nChar ) {
    return std::string(timeString);
  } else {
    std::ostringstream msg;
    msg << "Error encoding cool::Time into string: " << time;
    throw cool::Exception( msg.str(), "cool::timeToString" );
  }
}

//-----------------------------------------------------------------------------

// Header for pretty printout of a cool::IObject table
//   "IObject:  3 ( 0) [2,+inf[  "
//   "[2|Object 2|0.002]  2005-07-07_09:14:58.987869000 GMT"
const std::string kHeaderRow =
           "         Id  Ch  IOV       "
           "Payload             Insertion time";


//-----------------------------------------------------------------------------

/** @class UseCases useCases.cpp
 *
 *  A collection of user examples that show key features of the COOL API.
 *
 *  @author Andrea Valassi and Sven A. Schmidt
 *  @date   2005-06-27
 *///

class UseCases {

private:

  ExampleApplication m_app;
  DatabaseId m_dbId;

public:

  //---------------------------------------------------------------------------

  /// Constructor from the command line arguments of 'main( argc, argv )'.
  /// Expect exactly one argument that ExampleApplication interprets
  /// as a COOL database connection identifier (cool::DatabaseId).
  UseCases( int argc, char* argv[] )
    : m_app( argc, argv )
  {
    m_dbId = m_app.dbIdFromArg( argc, argv );
  }

  //---------------------------------------------------------------------------

  ~UseCases() {
    IDatabaseSvc& dbSvc = m_app.databaseService();
    try {
      dbSvc.dropDatabase( m_dbId );
    }
    catch (...) {
      // ignore errors
    }
  }

  //---------------------------------------------------------------------------

  /// Drop and recreate the database specified in the dbId.
  IDatabasePtr recreateDb( const DatabaseId& dbId )
  {
    std::cout << "Recreating database '" << dbId << "'" << std::endl;
    IDatabaseSvc& dbSvc = m_app.databaseService();
    dbSvc.dropDatabase( dbId ); // do nothing if the database does not exist
    IDatabasePtr db = dbSvc.createDatabase( dbId );
    return db;
  }

  //---------------------------------------------------------------------------

  /// Create a conditions payload specification (RecordSpecification).
  /// All conditions payloads used in this example use this specification
  /// (with three fields I - Int32, S - String4k, X - Float: for instance,
  /// these may represent a status code, a comment and a temperature).
  cool::RecordSpecification createRecordSpec()
  {
    std::cout << "Preparing RecordSpecification" << std::endl;

    cool::RecordSpecification spec;
    spec.extend("I",cool_StorageType_TypeId::Int32);
    spec.extend("S",cool_StorageType_TypeId::String4k);
    spec.extend("X",cool_StorageType_TypeId::Float);

    return spec;
  }

  //---------------------------------------------------------------------------

  /// Create a fake 'indexed' conditions payload for the given specification.
  /// A payload with unique values is created for each value of the 'index'.
  cool::Record createPayload ( int index,
                               const cool::IRecordSpecification& spec )
  {
    cool::Record payload( spec );
    payload["I"].setValue<cool::Int32>( index );
    std::stringstream s; s << "Object " << index;
    payload["S"].setValue<cool::String4k>( s.str() );
    payload["X"].setValue<cool::Float>( (float)(index/1000.) );
    return payload;
  }

  //---------------------------------------------------------------------------

  /// This example creates a folder (set) hierarchy. It shows how to retrieve
  /// existing nodes (i.e. folders or folder sets) using getFolder(Set) and
  /// how to list the nodes in a folder set using listFolder(Set).
  void example_folders_foldersets()
  {
    IDatabasePtr db = recreateDb( m_dbId );
    cool::RecordSpecification spec = createRecordSpec();
    cool::FolderSpecification folderSpec( cool_FolderVersioning_Mode::SINGLE_VERSION,
                                          spec );

    std::cout << "Creating a folderset hierarchy" << std::endl;
    db->createFolderSet( "/folderset_A" );
    db->createFolderSet( "/folderset_B" );

    std::cout << "Creating IOV folders" << std::endl;
    db->createFolder( "/folderset_A/folder_1", folderSpec );
    db->createFolder( "/folderset_A/folder_2", folderSpec );
    db->createFolder( "/folderset_A/folder_3", folderSpec );

    std::cout << "Creating substructure" << std::endl;
    db->createFolderSet( "/folderset_B/folderset_C" );
    db->createFolderSet( "/folderset_B/folderset_D" );
    db->createFolderSet( "/folderset_B/folderset_D/folderset_E" );

    std::cout << "Creating more IOV folders" << std::endl;
    db->createFolder( "/folderset_B/folderset_C/folder_1", folderSpec );
    db->createFolder( "/folderset_B/folderset_C/folder_2", folderSpec );
    db->createFolder( "/folderset_B/folderset_D/folderset_E/folder_1", folderSpec );
    db->createFolder( "/folderset_B/folderset_D/folderset_E/folder_2", folderSpec );

    std::cout << "Complete node hierarchy:\n\t" << std::flush;
    std::vector<std::string> nodes = db->listAllNodes();
    copy( nodes.begin(), nodes.end(),
          std::ostream_iterator<std::string>( std::cout, "\n\t" ) );
    std::cout << std::endl;

    std::cout << "Folders inside '/folderset_A':\n\t" << std::flush;
    IFolderSetPtr fsetA = db->getFolderSet( "/folderset_A" );
    nodes = fsetA->listFolders();
    copy( nodes.begin(), nodes.end(),
          std::ostream_iterator<std::string>( std::cout, "\n\t" ) );
    std::cout << std::endl;

    std::cout << "There are no foldersets inside '/folderset_A':" << std::endl;
    std::vector<std::string> foldersets = fsetA->listFolderSets();
    std::cout << "\tcount: " << foldersets.size() << std::endl;
    std::cout << std::endl;

    std::cout << "However, there are foldersets inside '/folderset_B':\n\t"
              << std::flush;
    IFolderSetPtr fsetB = db->getFolderSet( "/folderset_B" );
    nodes = fsetB->listFolderSets();
    copy( nodes.begin(), nodes.end(),
          std::ostream_iterator<std::string>( std::cout, "\n\t" ) );
    std::cout << std::endl;

    std::cout << "and deeper in the hierarchy, inside "
              << "'/folderset_B/folderset_D':\n\t" << std::flush;
    IFolderSetPtr fsetD = db->getFolderSet( "/folderset_B/folderset_D" );
    nodes = fsetD->listFolderSets();
    copy( nodes.begin(), nodes.end(),
          std::ostream_iterator<std::string>( std::cout, "\n\t" ) );
    std::cout << std::endl;

    std::cout << "Note that folders and foldersets are not the same. "
              << "Fetching the wrong kind will throw an exception:"
              << std::endl;
    try {
      db->getFolder( "/folderset_A" );
    } catch ( cool::Exception& e ) {
      std::cout << "\t" << e.what() << std::endl;
    }
    try {
      db->getFolderSet( "/folderset_A/folder_1" );
    } catch ( cool::Exception& e ) {
      std::cout << "\t" << e.what() << std::endl;
    }

  }

  //---------------------------------------------------------------------------

  /// This example shows how to store/retrieve conditions objects from/into
  /// single version folders (in the same channel with channelId=0).
  void example_SV_storage()
  {
    IDatabasePtr db = recreateDb( m_dbId );
    cool::RecordSpecification spec = createRecordSpec();
    cool::FolderSpecification folderSpec( cool_FolderVersioning_Mode::SINGLE_VERSION,
                                          spec );

    std::cout << "\nStoring single objects" << std::endl;
    IFolderPtr f1 = db->createFolder( "/folder_1", folderSpec );
    for ( int i = 0; i < 10; ++i ) {
      ValidityKey since = i;
      ValidityKey until = ValidityKeyMax;
      cool::Record payload = createPayload( i, spec );
      f1->storeObject( since, until, payload, 0 ); // channel 0
    }

    std::cout << "Browsing objects:" << std::endl;
    ValidityKey since = 0;
    ValidityKey until = ValidityKeyMax;
    IObjectIteratorPtr objects = f1->browseObjects( since, until, 0 );
    std::cout << kHeaderRow << std::endl;
    while ( objects->goToNext() ) {
      std::cout << objects->currentRef() << std::endl;
    }

    std::cout << "\nStoring objects in bulk" << std::endl;
    IFolderPtr f2 = db->createFolder( "/folder_2", folderSpec );
    f2->setupStorageBuffer();
    for ( int i = 0; i < 10; ++i ) {
      ValidityKey since2 = i;
      ValidityKey until2 = ValidityKeyMax;
      cool::Record payload = createPayload( i, spec );
      f2->storeObject( since2, until2, payload, 0 );
    }
    f2->flushStorageBuffer();

    std::cout << "Browsing objects:" << std::endl;
    since = 0;
    until = ValidityKeyMax;
    objects = f2->browseObjects( since, until, 0 );
    std::cout << kHeaderRow << std::endl;
    while ( objects->goToNext() ) {
      std::cout << objects->currentRef() << std::endl;
    }
    std::cout << "Note how the insertion time is identical in this case."
              << std::endl;

    std::cout << "\nObjects IOVs must not overlap. "
              << "Doing so will throw an exception:"
              << "\n\t";
    IFolderPtr f3 = db->createFolder( "/folder_3", folderSpec );
    f3->storeObject( 1, 3, createPayload( 1, spec ), 0 );
    try {
      f3->storeObject( 2, 4, createPayload( 2, spec ), 0 );
    } catch ( cool::Exception& e ) {
      std::cout << e.what() << std::endl;
    }
    std::cout << "(The special 'until' of ValidityKeyMax is an exception "
              << "to this requirement, the so-called 'open-ended IOV')"
              << std::endl;

    std::cout << "\nObjects have to be stored with increasing 'since'. "
              << "Storing objects 'out of order' will throw an exception:"
              << "\n\t";
    IFolderPtr f4 = db->createFolder( "/folder_4", folderSpec );
    f4->storeObject( 5, ValidityKeyMax, createPayload( 1, spec ), 0 );
    try {
      f4->storeObject( 2, 4, createPayload( 2, spec ), 0 );
    } catch ( cool::Exception& e ) {
      std::cout << e.what() << std::endl;
    }

  }

  //---------------------------------------------------------------------------

  /// This example shows how to store/retrieve conditions objects from/into
  /// single version folders in different channels.
  void example_channels()
  {
    IDatabasePtr db = recreateDb( m_dbId );
    cool::RecordSpecification spec = createRecordSpec();
    cool::FolderSpecification folderSpec( cool_FolderVersioning_Mode::SINGLE_VERSION,
                                          spec );

    std::cout << "\nStoring in different channels" << std::endl;
    IFolderPtr f1 = db->createFolder( "/folder_1", folderSpec );
    for ( int i = 0; i < 10; ++i ) {
      ValidityKey since = i;
      ValidityKey until = ValidityKeyMax;
      ChannelId channel = i / 3;
      cool::Record payload = createPayload( i, spec );
      f1->storeObject( since, until, payload, channel );
    }

    std::cout << "Browsing objects:" << std::endl;
    ValidityKey since = 0;
    ValidityKey until = ValidityKeyMax;
    ChannelId channel = 0;
    IObjectIteratorPtr objects = f1->browseObjects( since, until, channel );

    std::cout << kHeaderRow << std::endl;
    std::cout << "Channel " << channel << std::endl;
    while ( objects->goToNext() ) {
      std::cout << objects->currentRef() << std::endl;
    }
    channel = 1;
    std::cout << "Channel " << channel << std::endl;
    objects = f1->browseObjects( since, until, channel );
    while ( objects->goToNext() ) {
      std::cout << objects->currentRef() << std::endl;
    }
    channel = 2;
    std::cout << "Channel " << channel << std::endl;
    objects = f1->browseObjects( since, until, channel );
    while ( objects->goToNext() ) {
      std::cout << objects->currentRef() << std::endl;
    }

  }

  //---------------------------------------------------------------------------

  /// This example shows how to store/retrieve conditions objects from/into
  /// multi version folders. It also shows how to create and use tags.
  void example_MV_storage()
  {
    IDatabasePtr db = recreateDb( m_dbId );
    cool::RecordSpecification spec = createRecordSpec();
    cool::FolderSpecification folderSpec( cool_FolderVersioning_Mode::MULTI_VERSION,
                                          spec );

    std::cout << "\nStoring objects in a MultiVersion folder" << std::endl;
    IFolderPtr f1 = db->createFolder( "/folder_1", folderSpec, "description" );

    cool::Time asOfObject2; // insertion time of Object 2 for tagging example
    for ( int i = 0; i < 10; ++i ) {
      ValidityKey since = i;
      ValidityKey until = ValidityKeyMax;
      cool::Record payload = createPayload( i, spec );
      f1->storeObject( since, until, payload, 0 );
      if ( i == 2 ) {
        ValidityKey pointInTime = since;
        IObjectPtr obj2 = f1->findObject( pointInTime, 0 );
        asOfObject2 = obj2->insertionTime(); // insertion time of Object 2
      }
    }

    std::cout << "Browsing objects:" << std::endl;
    {
      ValidityKey since = 0;
      ValidityKey until = ValidityKeyMax;
      IObjectIteratorPtr objects = f1->browseObjects( since, until, 0 );
      std::cout << kHeaderRow << std::endl;
      while ( objects->goToNext() ) {
        std::cout << objects->currentRef() << std::endl;
      }
    }
    std::cout << "Except for the object ids which are issued differently "
              << "in MultiVersion folders behavior is identical to "
              << "a SingleVersion folder." << std::endl;

    std::cout << "\nHowever, MultiVersion folders allow tagging, either "
              << "by tagging the HEAD or 'as of date'." << std::endl;

    std::cout << "\nTagging the HEAD as 'tag A'" << std::endl;
    f1->tagCurrentHead( "tag A", "a description" );
    std::cout << "Inserting two more objects, [0,5[ and [5,+inf[" << std::endl;
    f1->storeObject( 0, 5, createPayload( 10, spec ), 0 );
    f1->storeObject( 5, ValidityKeyMax, createPayload( 11, spec ), 0 );

    std::cout << "\nThis is what the HEAD looks like now:" << std::endl;
    {
      ValidityKey since = 0;
      ValidityKey until = ValidityKeyMax;
      IObjectIteratorPtr objects = f1->browseObjects( since, until, 0 );
      std::cout << kHeaderRow << std::endl;
      while ( objects->goToNext() ) {
        std::cout << objects->currentRef() << std::endl;
      }
    }

    std::cout << "\nAnd this is the 'content' of 'tag A':" << std::endl;
    {
      ValidityKey since = 0;
      ValidityKey until = ValidityKeyMax;
      ChannelId channel = 0;
      IObjectIteratorPtr objects = f1->browseObjects( since, until,
                                                      channel, "tag A" );
      std::cout << kHeaderRow << std::endl;
      while ( objects->goToNext() ) {
        std::cout << objects->currentRef() << std::endl;
      }
    }

    std::cout << "\nTagging the HEAD as it was after inserting "
              << "'Object 2' as 'tag B'" << std::endl;
    {
      std::cout << "Tagging with asOfDate = "
                << timeToString( asOfObject2 )
                << std::endl;
      f1->tagHeadAsOfDate( asOfObject2, "tag B", "tag description" );
    }

    std::cout << "\nThis is the 'content' of 'tag B':" << std::endl;
    {
      ValidityKey since = 0;
      ValidityKey until = ValidityKeyMax;
      ChannelId channel = 0;
      IObjectIteratorPtr objects = f1->browseObjects( since, until,
                                                      channel, "tag B" );
      std::cout << kHeaderRow << std::endl;
      while ( objects->goToNext() ) {
        std::cout << objects->currentRef() << std::endl;
      }
    }

  }

  //---------------------------------------------------------------------------

  /// Helper method - pretty printout of tag information
  void printTag( const std::string& name,
                 const std::string& desc,
                 const std::string& tagTime )
  {
    unsigned int tagNameWidth = 7;
    unsigned int tagDescWidth = 17;
    std::cout << std::setiosflags(std::ios::left)
              << std::setw(tagNameWidth) << name
              << std::setw(tagDescWidth) << desc
              << " " << tagTime
              << std::resetiosflags(std::ios::left) << std::endl;
  }

  //---------------------------------------------------------------------------

  /// Helper method - pretty printout of cool::IObject table in a tag
  void printTagContents( const IFolderPtr& folder,
                         const std::vector<std::string>& tagNames )
  {
    std::cout << kHeaderRow << std::endl;
    for ( std::vector<std::string>::const_iterator t = tagNames.begin();
          t != tagNames.end(); ++ t ) {
      ValidityKey since = 0;
      ValidityKey until = ValidityKeyMax;
      ChannelId channel = 0;
      std::string tagName( *t );
      IObjectIteratorPtr objects =
        folder->browseObjects( since, until, channel, tagName );
      std::cout << tagName << ":" << std::endl;
      while ( objects->goToNext() ) {
        std::cout << objects->currentRef() << std::endl;
      }
    }
  }

  //---------------------------------------------------------------------------

  /// This example shows more details about the tagging functionality.
  void example_tagging()
  {
    IDatabasePtr db = recreateDb( m_dbId );
    cool::RecordSpecification spec = createRecordSpec();
    cool::FolderSpecification folderSpec( cool_FolderVersioning_Mode::MULTI_VERSION,
                                          spec );

    std::cout << "\nStoring objects in a MultiVersion folder" << std::endl;
    IFolderPtr f1 = db->createFolder( "/folder_1", folderSpec, "description" );

    f1->storeObject( 0, ValidityKeyMax, createPayload( 0, spec ), 0 );
    f1->storeObject( 1, ValidityKeyMax, createPayload( 1, spec ), 0 );
    f1->storeObject( 2, ValidityKeyMax, createPayload( 2, spec ), 0 );
    f1->tagCurrentHead( "Tag 0", "after Object 2" );
    f1->storeObject( 3, ValidityKeyMax, createPayload( 3, spec ), 0 );
    f1->storeObject( 4, ValidityKeyMax, createPayload( 4, spec ), 0 );
    f1->storeObject( 5, ValidityKeyMax, createPayload( 5, spec ), 0 );
    f1->tagCurrentHead( "Tag 1", "after Object 5" );
    f1->storeObject( 6, ValidityKeyMax, createPayload( 6, spec ), 0 );
    f1->storeObject( 7, ValidityKeyMax, createPayload( 7, spec ), 0 );
    f1->tagCurrentHead( "Tag 2", "after Object 7" );
    f1->storeObject( 8, ValidityKeyMax, createPayload( 8, spec ), 0 );
    f1->storeObject( 9, ValidityKeyMax, createPayload( 9, spec ), 0 );

    std::cout << "\nThis is the tag list:" << std::endl;
    {
      std::vector<std::string> tags = f1->listTags();

      printTag( "Name", "Description", "Last object's insertion time" );
      for ( std::vector<std::string>::const_iterator t = tags.begin();
            t != tags.end(); ++ t ) {
        printTag( *t,
                  f1->tagDescription( *t ),
                  timeToString( f1->insertionTimeOfLastObjectInTag( *t ) ) );
      }
    }

    std::cout << "\nTag contents:" << std::endl;
    {
      std::vector<std::string> tags = f1->listTags();
      tags.push_back( "HEAD" );
      printTagContents( f1, tags );
    }

    std::cout << "\nTags can be deleted:" << std::endl;
    std::cout << "Deleting 'Tag 2'" << std::endl;
    f1->deleteTag( "Tag 2" );

    std::cout << "\nTag contents (omitting HEAD for brevity):" << std::endl;
    printTagContents( f1, f1->listTags() );

    std::cout << "\nTagging with an existing tag is not allowed and "
              << "throws an exception:" << std::endl;
    try {
      f1->tagCurrentHead( "Tag 0" );
    } catch ( cool::Exception& e ) {
      std::cout << "\t" << e.what() << std::endl;
    }

    std::cout << "\nAlso, HEAD (Head, HeAD, ...) is a reserved tag name and "
              << "attempting to tag with it throws an exception:" << std::endl;
    try {
      f1->tagCurrentHead( "HEAD" );
    } catch ( cool::Exception& e ) {
      std::cout << "\t" << e.what() << std::endl;
    }

    std::cout << "\nTag names other than HEAD are case sensitive:"
              << std::endl;
    std::cout << "Tagging 'TAG 0'" << std::endl;
    std::cout << "\nTag contents:" << std::endl;

    f1->tagCurrentHead( "TAG 0" );
    printTagContents( f1, f1->listTags() );

  }

  //---------------------------------------------------------------------------

  /// This example demonstrates how to rename a tag or change the contents
  /// of a tag (retagging) using the deleteTag() functionality.
  void example_retagging()
  {
    IDatabasePtr db = recreateDb( m_dbId );
    cool::RecordSpecification spec = createRecordSpec();
    cool::FolderSpecification folderSpec( cool_FolderVersioning_Mode::MULTI_VERSION,
                                          spec );

    std::cout << "\nStoring objects in a MultiVersion folder" << std::endl;
    IFolderPtr f1 = db->createFolder( "/folder_1", folderSpec, "description" );

    f1->storeObject( 0, ValidityKeyMax, createPayload( 0, spec ), 0 );
    f1->storeObject( 1, ValidityKeyMax, createPayload( 1, spec ), 0 );
    f1->tagCurrentHead( "Tag 0", "after Object 1" );
    f1->storeObject( 2, ValidityKeyMax, createPayload( 2, spec ), 0 );
    f1->storeObject( 3, ValidityKeyMax, createPayload( 3, spec ), 0 );
    f1->tagCurrentHead( "TAG XX", "after Object 3" );
    f1->storeObject( 4, ValidityKeyMax, createPayload( 4, spec ), 0 );
    f1->storeObject( 5, ValidityKeyMax, createPayload( 5, spec ), 0 );
    f1->tagCurrentHead( "Tag 2", "after Object 5" );
    f1->storeObject( 6, ValidityKeyMax, createPayload( 6, spec ), 0 );
    f1->storeObject( 7, ValidityKeyMax, createPayload( 7, spec ), 0 );

    std::cout << "\nThis is the tag list:" << std::endl;
    {
      std::vector<std::string> tags = f1->listTags();

      printTag( "Name", "Description", "Last object's insertion time" );
      for ( std::vector<std::string>::const_iterator t = tags.begin();
            t != tags.end(); ++ t ) {
        printTag( *t,
                  f1->tagDescription( *t ),
                  timeToString( f1->insertionTimeOfLastObjectInTag( *t ) ) );
      }
    }

    std::cout << "\nTag contents:" << std::endl;
    printTagContents( f1, f1->listTags() );

    std::cout << "\nA tag can be renamed by deleting it and retagging "
              << "as of the deleted tag's last object's insertion time:"
              << std::endl;
    cool::Time tagTime = f1->insertionTimeOfLastObjectInTag( "TAG XX" );
    std::cout << "Last object's insertion time of 'TAG XX': "
              << timeToString( tagTime ) << std::endl;
    std::cout << "Deleting 'TAG XX'" << std::endl;;
    f1->deleteTag( "TAG XX" );
    std::cout << "Renaming as 'Tag 1'" << std::endl;;
    f1->tagHeadAsOfDate( tagTime, "Tag 1", "fixed tagname" );

    std::cout << "\nThis is the tag list:" << std::endl;
    {
      std::vector<std::string> tags = f1->listTags();

      printTag( "Name", "Description", "Last object's insertion time" );
      for ( std::vector<std::string>::const_iterator t = tags.begin();
            t != tags.end(); ++ t ) {
        printTag( *t,
                  f1->tagDescription( *t ),
                  timeToString( f1->insertionTimeOfLastObjectInTag( *t ) ) );
      }
    }

    std::cout << "\nTag contents:" << std::endl;
    printTagContents( f1, f1->listTags() );

    std::cout << "\nSimilarly, retagging can be emulated:" << std::endl;
    std::cout << "Suppose 'Tag 0' should really tag the state in 'Tag 1'"
              << std::endl;
    cool::Time tag1Time = f1->insertionTimeOfLastObjectInTag( "Tag 1" );
    std::cout << "Last object's insertion time of 'Tag 1': "
              << timeToString( tag1Time ) << std::endl;

    std::cout << "Deleting 'Tag 0'" << std::endl;
    f1->deleteTag( "Tag 0" );
    std::cout << "Deleting 'Tag 1'" << std::endl;
    f1->deleteTag( "Tag 1" );
    std::cout << "Retagging 'Tag 0' as of "
              << timeToString( tag1Time ) << std::endl;
    f1->tagHeadAsOfDate( tag1Time, "Tag 0", "new tag" );

    std::cout << "\nThis is the tag list:" << std::endl;
    {
      std::vector<std::string> tags = f1->listTags();

      printTag( "Name", "Description", "Last object's insertion time" );
      for ( std::vector<std::string>::const_iterator t = tags.begin();
            t != tags.end(); ++ t ) {
        printTag( *t,
                  f1->tagDescription( *t ),
                  timeToString( f1->insertionTimeOfLastObjectInTag( *t ) ) );
      }
    }

    std::cout << "\nTag contents:" << std::endl;
    printTagContents( f1, f1->listTags() );

  }

  //---------------------------------------------------------------------------

  /// This example shows how to store/retrieve conditions objects from/into
  /// folders with CLOB (very long string) payload columns.
  void example_CLOB()
  {
    IDatabasePtr db = recreateDb( m_dbId );

    std::cout << "Preparing RecordSpecification" << std::endl;
    cool::RecordSpecification spec;
    spec.extend("I",cool_StorageType_TypeId::Int32);
    spec.extend("S",cool_StorageType_TypeId::String4k);
    spec.extend("X",cool_StorageType_TypeId::Float);
    std::cout << "Payload string S64k can contain up to 65535 characters"
              << std::endl;
    spec.extend("S64k",cool_StorageType_TypeId::String64k);
    std::cout << "Payload string S16M can contain up to 16777215 characters"
              << std::endl;
    spec.extend("S16M",cool_StorageType_TypeId::String16M);

    std::cout << "\nCreating the folder" << std::endl;
    cool::FolderSpecification folderSpec( cool_FolderVersioning_Mode::SINGLE_VERSION,
                                          spec );
    IFolderPtr f1 = db->createFolder( "/folder_1", folderSpec );

    std::cout << "\nStoring single objects" << std::endl;
    for ( int i = 1; i < 3; ++i ) {
      ValidityKey since = i;
      ValidityKey until = ValidityKeyMax;
      cool::Record payload( spec );
      payload["I"].setValue<cool::Int32>( i );
      std::stringstream s; s << i;
      payload["S"].setValue<cool::String4k>( "Object " + s.str() );
      payload["X"].setValue<cool::Float>( (float)(i/1000.) );
      char c = s.str().data()[0];
      payload["S64k"].setValue<cool::String64k>( std::string( 65535, c ) );
      payload["S16M"].setValue<cool::String16M>( std::string( 16777215, c ) );
      f1->storeObject( since, until, payload, 0 );
    }

    std::cout << "Browsing objects:" << std::endl;
    ValidityKey since = 0;
    ValidityKey until = ValidityKeyMax;
    IObjectIteratorPtr objects = f1->browseObjects( since, until, 0 );
    std::cout << "Id (Ch) IOV       \"I\" \"S\"      \"X\"   "
              << "length(\"S64k\") length(\"S16M\")" << std::endl;
    while ( objects->goToNext() ) {
      const IObject& obj = objects->currentRef();
      std::cout << " " << obj.objectId()
                << "   " << obj.channelId()
                << "  [" << obj.since() << ",...["
                << "   " << obj.payloadValue<cool::Int32>("I")
                << "   " << obj.payloadValue<cool::String4k>("S")
                << " " << obj.payloadValue<cool::Float>("X")
                << " " << obj.payloadValue<cool::String64k>("S64k").size()
                << "          " << obj.payloadValue<cool::String16M>("S16M").size()
                << std::endl;
    }

  }

  //---------------------------------------------------------------------------

}; // class UseCases

//-----------------------------------------------------------------------------

int main ( int argc, char* argv[] ) {

  try {
    UseCases app( argc, argv );

    std::cout << "\n*** Example: Folders and FolderSets ***\n" << std::endl;
    app.example_folders_foldersets();

    std::cout << "\n*** Example: SingleVersion Storage ***\n" << std::endl;
    app.example_SV_storage();

    std::cout << "\n*** Example: Channels ***\n" << std::endl;
    app.example_channels();

    std::cout << "\n*** Example: MultiVersion Storage ***\n" << std::endl;
    app.example_MV_storage();

    std::cout << "\n*** Example: Tagging Functionality ***\n" << std::endl;
    app.example_tagging();

    std::cout << "\n*** Example: Retagging and Renaming Tags ***\n"
              << std::endl;
    app.example_retagging();

    std::cout << "\n*** Example: Very long string (CLOB) payload ***\n"
              << std::endl;
    app.example_CLOB();
  }

  // Wrong number of command line arguments: print usage
  catch ( cool::ExampleApplication::CommandLineArgumentException& e ) {
    e.usage( argv[0], std::cout );
    return -1;
  }

  // COOL, CORAL POOL exceptions inherit from std exceptions: catching
  // std::exception will catch all errors from COOL, CORAL and POOL
  catch ( std::exception& e ) {
    std::cout << "std::exception caught: " << e.what() << std::endl;
    return -1;
  }

  catch (...) {
    std::cout << "Unknown exception caught!" << std::endl;
    return -1;
  }

}

//-----------------------------------------------------------------------------
