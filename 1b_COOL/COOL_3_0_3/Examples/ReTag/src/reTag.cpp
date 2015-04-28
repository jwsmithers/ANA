
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

/** @class ReTag reTag.cpp
 *
 *  User example that shows how to rename a tag using
 *  the deleteTag() of of the COOL API.
 *
 *  @author Andrea Valassi, Sven A. Schmidt, Ulrich Moosbrugger
 *  @date   2005-08-09
 *///

class ReTag {

private:

  ExampleApplication m_app;
  DatabaseId m_dbId;

public:

  //---------------------------------------------------------------------------

  /// Constructor from the command line arguments of 'main( argc, argv )'.
  /// Expect exactly one argument that ExampleApplication interprets
  /// as a COOL database connection identifier (cool::DatabaseId).
  ReTag( int argc, char* argv[] )
    : m_app( argc, argv )
  {
    m_dbId = m_app.dbIdFromArg( argc, argv );
  }

  //---------------------------------------------------------------------------

  /// This example demonstrates how to rename a tag or change the contents
  /// of a tag (retagging) using the deleteTag() functionality.
  void example_retagging()
  {
    IDatabasePtr db = m_app.recreateDb( m_dbId );
    cool::RecordSpecification recordSpec( m_app.createRecordSpec() );
    cool::FolderSpecification folderSpec( cool_FolderVersioning_Mode::MULTI_VERSION,
                                          recordSpec );

    std::cout << "\nStoring objects in a MultiVersion folder" << std::endl;
    IFolderPtr f1 = db->createFolder( "/folder_1", folderSpec, "description" );

    f1->storeObject( 0, ValidityKeyMax, m_app.createPayload( 0, recordSpec ), 0 );
    f1->storeObject( 1, ValidityKeyMax, m_app.createPayload( 1, recordSpec ), 0 );
    f1->tagCurrentHead( "Tag 0", "after 'Object 1'" );
    f1->storeObject( 2, ValidityKeyMax, m_app.createPayload( 2, recordSpec ), 0 );
    f1->storeObject( 3, ValidityKeyMax, m_app.createPayload( 3, recordSpec ), 0 );
    f1->tagCurrentHead( "TAG XX", "after 'Object 3'" );
    f1->storeObject( 4, ValidityKeyMax, m_app.createPayload( 4, recordSpec ), 0 );
    f1->storeObject( 5, ValidityKeyMax, m_app.createPayload( 5, recordSpec ), 0 );
    f1->tagCurrentHead( "Tag 2", "after 'Object 5'" );
    f1->storeObject( 6, ValidityKeyMax, m_app.createPayload( 6, recordSpec ), 0 );
    f1->storeObject( 7, ValidityKeyMax, m_app.createPayload( 7, recordSpec ), 0 );

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
    m_app.printTagContents( f1, f1->listTags() );

    std::cout << "\nA tag can be renamed by deleting it and retagging "
              << "as of the deleted tag's last object's insertion time:"
              << std::endl;
    cool::Time tagTime = f1->insertionTimeOfLastObjectInTag( "TAG XX" );
    std::cout << "Last object's insertion time of 'TAG XX': "
              << m_app.timeToString( tagTime ) << std::endl;
    std::cout << "Deleting 'TAG XX'" << std::endl;;
    f1->deleteTag( "TAG XX" );
    std::cout << "Renaming as 'Tag 1'" << std::endl;;
    f1->tagHeadAsOfDate( tagTime, "Tag 1", "fixed tagname" );

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
    m_app.printTagContents( f1, f1->listTags() );

    std::cout << "\nSimilarly, retagging can be emulated:" << std::endl;
    std::cout << "Suppose 'Tag 0' should really tag the state in 'Tag 1'"
              << std::endl;
    cool::Time tag1Time = f1->insertionTimeOfLastObjectInTag( "Tag 1" );
    std::cout << "Last object's insertion time of 'Tag 1': "
              << m_app.timeToString( tag1Time ) << std::endl;

    std::cout << "Deleting 'Tag 0'" << std::endl;
    f1->deleteTag( "Tag 0" );
    std::cout << "Deleting 'Tag 1'" << std::endl;
    f1->deleteTag( "Tag 1" );
    std::cout << "Retagging 'Tag 0' as of "
              << m_app.timeToString( tag1Time ) << std::endl;
    f1->tagHeadAsOfDate( tag1Time, "Tag 0", "new tag" );

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
    m_app.printTagContents( f1, f1->listTags() );

  }

  //---------------------------------------------------------------------------

}; // class ReTag

//-----------------------------------------------------------------------------

int main ( int argc, char* argv[] ) {

  try {
    // instantiate new ReTag object and set m_dbId string
    ReTag app( argc, argv );

    std::cout << "\n*** Example: Retagging and Renaming Tags ***\n"
              << std::endl;
    app.example_retagging();

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
