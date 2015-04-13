// $Id: mvStorage.cpp,v 1.15 2009-12-17 18:54:59 avalassi Exp $

#include <iostream>
#include <iomanip>

// COOL API include files (CoolKernel)
#include "CoolKernel/Exception.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/IDatabase.h"
#include "CoolKernel/IFolder.h"
#include "CoolKernel/IFolderSet.h"
#include "CoolKernel/IObject.h"
#include "CoolKernel/IObjectIterator.h"

// COOL example library include files (ExampleBase)
#include "ExampleBase/ExampleApplication.h"

// COOL namespace
using namespace cool;

//-----------------------------------------------------------------------------

/** @class MVstorage mvStorage.cpp
 *
 *  User example that shows the use of multiversion storage of the COOL API.
 *
 *  @author Andrea Valassi, Sven A. Schmidt, Ulrich Moosbrugger
 *  @date   2005-08-09
 *///

class MVstorage {

private:

  ExampleApplication m_app;
  DatabaseId m_dbId;

public:

  //---------------------------------------------------------------------------

  /// Constructor from the command line arguments of 'main( argc, argv )'.
  /// Expect exactly one argument that ExampleApplication interprets
  /// as a COOL database connection identifier (cool::DatabaseId).
  MVstorage( int argc, char* argv[] )
    : m_app( argc, argv )
  {
    m_dbId = m_app.dbIdFromArg( argc, argv );
  }

  //---------------------------------------------------------------------------

  /// This example shows how to store/retrieve conditions objects from/into
  /// multi version folders. It also shows how to create and use tags.
  void example_MV_storage()
  {
    IDatabasePtr db = m_app.recreateDb( m_dbId );
    cool::RecordSpecification recordSpec( m_app.createRecordSpec() );
    cool::FolderSpecification folderSpec( FolderVersioning::MULTI_VERSION,
                                          recordSpec );
    std::cout << "\nStoring objects in a MultiVersion folder" << std::endl;
    IFolderPtr f1 = db->createFolder( "/folder_1", folderSpec, "description" );

    cool::Time asOfObject2; // insertion time of Object 2 for tagging example
    for ( int i = 0; i < 10; ++i ) {
      ValidityKey since = i;
      ValidityKey until = ValidityKeyMax;
      cool::Record payload = m_app.createPayload( i, recordSpec );
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
      std::cout << m_app.headerRow() << std::endl;
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
    f1->storeObject( 0, 5, m_app.createPayload( 10, recordSpec ), 0 );
    f1->storeObject( 5, ValidityKeyMax, m_app.createPayload( 11, recordSpec ), 0 );

    std::cout << "\nThis is what the HEAD looks like now:" << std::endl;
    {
      ValidityKey since = 0;
      ValidityKey until = ValidityKeyMax;
      IObjectIteratorPtr objects = f1->browseObjects( since, until, 0 );
      std::cout << m_app.headerRow() << std::endl;
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
      std::cout << m_app.headerRow() << std::endl;
      while ( objects->goToNext() ) {
        std::cout << objects->currentRef() << std::endl;
      }
    }

    std::cout << "\nTagging the HEAD as it was after inserting "
              << "'Object 2' as 'tag B'" << std::endl;
    {
      std::cout << "Tagging with asOfDate = "
                << m_app.timeToString( asOfObject2 )
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
      std::cout << m_app.headerRow() << std::endl;
      while ( objects->goToNext() ) {
        std::cout << objects->currentRef() << std::endl;
      }
    }

  }

  //---------------------------------------------------------------------------

}; // class MVstorage

//-----------------------------------------------------------------------------

int main ( int argc, char* argv[] ) {

  try {
    // instantiate new MVstorage object and set m_dbId string
    MVstorage app( argc, argv );

    std::cout << "\n*** Example: MultiVersion Storage ***\n" << std::endl;
    app.example_MV_storage();

  }

  // Wrong number of command line arguments: print usage
  catch ( cool::ExampleApplication::CommandLineArgumentException& e ) {
    e.usage( argv[0], std::cout );
    return -1;
  }

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
