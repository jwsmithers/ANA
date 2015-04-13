// $Id: useTags.cpp,v 1.13 2009-12-17 18:55:03 avalassi Exp $

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

/** @class UseTags useTags.cpp
 *
 *  User example that shows the use of tags of the COOL API.
 *
 *  @author Andrea Valassi, Sven A. Schmidt, Ulrich Moosbrugger
 *  @date   2005-08-09
 *///

class UseTags {

private:

  ExampleApplication m_app;
  DatabaseId m_dbId;

public:

  //---------------------------------------------------------------------------

  /// Constructor from the command line arguments of 'main( argc, argv )'.
  /// Expect exactly one argument that ExampleApplication interprets
  /// as a COOL database connection identifier (cool::DatabaseId).
  UseTags( int argc, char* argv[] )
    : m_app( argc, argv )
  {
    m_dbId = m_app.dbIdFromArg( argc, argv );
  }

  //---------------------------------------------------------------------------

  /// This example shows more details about the tagging functionality.
  void example_tagging()
  {
    IDatabasePtr db = m_app.recreateDb( m_dbId );
    cool::RecordSpecification recordSpec( m_app.createRecordSpec() );
    cool::FolderSpecification folderSpec( FolderVersioning::MULTI_VERSION,
                                          recordSpec );

    std::cout << "\nStoring objects in a MultiVersion folder" << std::endl;
    IFolderPtr f1 = db->createFolder( "/folder_1", folderSpec, "description" );

    f1->storeObject( 0, ValidityKeyMax, m_app.createPayload( 0, recordSpec ), 0 );
    f1->storeObject( 1, ValidityKeyMax, m_app.createPayload( 1, recordSpec ), 0 );
    f1->storeObject( 2, ValidityKeyMax, m_app.createPayload( 2, recordSpec ), 0 );
    f1->tagCurrentHead( "Tag 0", "after 'Object 2'" );
    f1->storeObject( 3, ValidityKeyMax, m_app.createPayload( 3, recordSpec ), 0 );
    f1->storeObject( 4, ValidityKeyMax, m_app.createPayload( 4, recordSpec ), 0 );
    f1->storeObject( 5, ValidityKeyMax, m_app.createPayload( 5, recordSpec ), 0 );
    f1->tagCurrentHead( "Tag 1", "after 'Object 5'" );
    f1->storeObject( 6, ValidityKeyMax, m_app.createPayload( 6, recordSpec ), 0 );
    f1->storeObject( 7, ValidityKeyMax, m_app.createPayload( 7, recordSpec ), 0 );
    f1->tagCurrentHead( "Tag 2", "after 'Object 7'" );
    f1->storeObject( 8, ValidityKeyMax, m_app.createPayload( 8, recordSpec ), 0 );
    f1->storeObject( 9, ValidityKeyMax, m_app.createPayload( 9, recordSpec ), 0 );

    std::cout << "\nThis is the tag list:" << std::endl;
    {
      std::vector<std::string> tags = f1->listTags();

      m_app.printTag( "Name", "Description", "Last object's insertion time" );
      for ( std::vector<std::string>::const_iterator t = tags.begin();
            t != tags.end(); ++ t ) {
        m_app.printTag( *t,
                        f1->tagDescription( *t ),
                        m_app.timeToString( f1->insertionTimeOfLastObjectInTag( *t ) ) );
      }
    }

    std::cout << "\nTag contents:" << std::endl;
    {
      std::vector<std::string> tags = f1->listTags();
      tags.push_back( "HEAD" );
      m_app.printTagContents( f1, tags );
    }

    std::cout << "\nTags can be deleted:" << std::endl;
    std::cout << "Deleting 'Tag 2'" << std::endl;
    f1->deleteTag( "Tag 2" );

    std::cout << "\nTag contents (omitting HEAD for brevity):" << std::endl;
    m_app.printTagContents( f1, f1->listTags() );

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
    m_app.printTagContents( f1, f1->listTags() );

  }

  //---------------------------------------------------------------------------

}; // class UseTags

//-----------------------------------------------------------------------------

int main ( int argc, char* argv[] ) {

  try {
    // instantiate new UseTags object and set m_dbId string
    UseTags app( argc, argv );

    std::cout << "\n*** Example: Tagging Functionality ***\n" << std::endl;
    app.example_tagging();

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
