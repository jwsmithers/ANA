// $Id: svStorage.cpp,v 1.11 2009-12-17 18:54:59 avalassi Exp $

#include <iostream>
#include <iomanip>

// COOL API include files (CoolKernel)
#include "CoolKernel/Exception.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/IDatabase.h"
#include "CoolKernel/IFolder.h"
#include "CoolKernel/IObject.h"
#include "CoolKernel/IObjectIterator.h"

// COOL example library include files (ExampleBase)
#include "ExampleBase/ExampleApplication.h"

// COOL namespace
using namespace cool;

//-----------------------------------------------------------------------------

/** @class SVstorage svStorage.cpp
 *
 *  User example that shows the use of single version storage of the COOL API.
 *
 *  @author Andrea Valassi, Sven A. Schmidt, Ulrich Moosbrugger
 *  @date   2005-08-09
 *///

class SVstorage {

private:

  ExampleApplication m_app;
  DatabaseId m_dbId;

public:

  //---------------------------------------------------------------------------

  /// Constructor from the command line arguments of 'main( argc, argv )'.
  /// Expect exactly one argument that ExampleApplication interprets
  /// as a COOL database connection identifier (cool::DatabaseId).
  SVstorage( int argc, char* argv[] )
    : m_app( argc, argv )
  {
    m_dbId = m_app.dbIdFromArg( argc, argv );
  }

  //---------------------------------------------------------------------------

  /// This example shows how to store conditions objects into
  /// single version folders (in the same channel with channelId=0).
  void example_SV_storage()
  {
    IDatabasePtr db = m_app.recreateDb( m_dbId );
    cool::RecordSpecification recordSpec( m_app.createRecordSpec() );
    cool::FolderSpecification folderSpec( FolderVersioning::SINGLE_VERSION,
                                          recordSpec );

    std::cout << "\nStoring single objects in /folder_1" << std::endl;
    IFolderPtr f1 = db->createFolder( "/folder_1", folderSpec );
    for ( int i = 0; i < 10; ++i ) {
      ValidityKey since = i;
      ValidityKey until = ValidityKeyMax;
      cool::Record payload = m_app.createPayload( i, recordSpec );
      f1->storeObject( since, until, payload, 0 ); // channel 0
    }

    std::cout << "\nStoring objects in bulk in /folder_2" << std::endl;
    IFolderPtr f2 = db->createFolder( "/folder_2", folderSpec );
    f2->setupStorageBuffer();
    for ( int i = 0; i < 10; ++i ) {
      ValidityKey since = i;
      ValidityKey until = ValidityKeyMax;
      cool::Record payload = m_app.createPayload( i, recordSpec );
      f2->storeObject( since, until, payload, 0 );
    }
    f2->flushStorageBuffer();

    std::cout << "\nObjects IOVs must not overlap. "
              << "Doing so will throw an exception:"
              << "\n\t";
    IFolderPtr f3 = db->createFolder( "/folder_3", folderSpec );
    f3->storeObject( 1, 3, m_app.createPayload( 1, recordSpec ), 0 );
    try {
      f3->storeObject( 2, 4, m_app.createPayload( 2, recordSpec ), 0 );
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
    f4->storeObject( 5, ValidityKeyMax, m_app.createPayload( 1, recordSpec ), 0 );
    try {
      f4->storeObject( 2, 4, m_app.createPayload( 2, recordSpec ), 0 );
    } catch ( cool::Exception& e ) {
      std::cout << e.what() << std::endl;
    }
  }

  //---------------------------------------------------------------------------

  /// This example shows how to retrieve conditions objects from
  /// single version folders (in the same channel with channelId=0).
  void example_SV_browse()
  {
    try {
      IDatabasePtr db = m_app.openDb( m_dbId );

      std::cout << "Browsing objects of /folder_1:" << std::endl;
      IFolderPtr f1 = db->getFolder( "/folder_1" );
      ValidityKey since = 0;
      ValidityKey until = ValidityKeyMax;
      IObjectIteratorPtr objects = f1->browseObjects( since, until, 0 );
      std::cout << m_app.headerRow() << std::endl;
      while ( objects->goToNext() ) {
        std::cout << objects->currentRef() << std::endl;
      }

      std::cout << "Browsing objects of /folder_2 (bulk):" << std::endl;
      IFolderPtr f2 = db->getFolder( "/folder_2" );
      since = 0;
      until = ValidityKeyMax;
      objects = f2->browseObjects( since, until, 0 );
      std::cout << m_app.headerRow() << std::endl;
      while ( objects->goToNext() ) {
        std::cout << objects->currentRef() << std::endl;
      }
      std::cout << "Note how the insertion time is identical in the bulk storage case."
                << std::endl;
    } catch ( cool::Exception& e ) {
      std::cout << e.what() << std::endl;
    }

  }

  //---------------------------------------------------------------------------

}; // class SVstorage


//-----------------------------------------------------------------------------

int main ( int argc, char* argv[] ) {

  try {
    // instantiate new SVstorage object and set m_dbId string
    SVstorage app( argc, argv );

    std::cout << "\n*** Example: SingleVersion Storage ***\n" << std::endl;
    app.example_SV_storage();

    std::cout << "\n*** Example: SingleVersion Browsing ***\n" << std::endl;
    app.example_SV_browse();
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
