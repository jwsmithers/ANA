
#include <iostream>
#include <iomanip>

// COOL API include files (CoolKernel)
#include "CoolKernel/Exception.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/IDatabase.h"
#include "CoolKernel/IFolder.h"
#include "CoolKernel/IObject.h"
#include "CoolKernel/IObjectIterator.h"
#include "CoolKernel/ChannelSelection.h"

// COOL example library include files (ExampleBase)
#include "ExampleBase/ExampleApplication.h"

// COOL namespace
using namespace cool;

//-----------------------------------------------------------------------------

/** @class McBulkRetrieval mcBulkRetrieval.cpp
 *
 *  User example that shows the use of browsing using a
 *  channel selection (multi channel bulk retrieval).
 *
 *  @author Andrea Valassi, Sven A. Schmidt, Ulrich Moosbrugger
 *  @date   2005-09-08
 *///

class McBulkRetrieval {

private:

  ExampleApplication m_app;
  DatabaseId m_dbId;

public:

  //---------------------------------------------------------------------------

  /// Constructor from the command line arguments of 'main( argc, argv )'.
  /// Expect exactly one argument that ExampleApplication interprets
  /// as a COOL database connection identifier (cool::DatabaseId).
  McBulkRetrieval( int argc, char* argv[] )
    : m_app( argc, argv )
  {
    m_dbId = m_app.dbIdFromArg( argc, argv );
  }

  //---------------------------------------------------------------------------

  /// This example shows how to store conditions objects into
  /// single version folders in different channels.
  void example_channels_write()
  {
    IDatabasePtr db = m_app.recreateDb( m_dbId );
    cool::FolderSpecification spec = m_app.createFolderSpec();
    IFolderPtr f1 = db->createFolder( "/folder_1", spec );

    std::cout << std::endl
              << "\nStoring objects in different channels (Channel 0-6)"
              << std::endl;
    for ( int i = 0; i < 20; ++i )
    {
      ValidityKey since = i;
      ValidityKey until = ValidityKeyMax;
      ChannelId channel = i / 3;
      cool::Record payload = m_app.createPayload( i, spec.payloadSpecification() );
      f1->storeObject( since, until, payload, (ChannelId)channel );
    }
  }

  //---------------------------------------------------------------------------

  /// This example shows how to retrieve conditions objects from
  /// single version folders in a channel selection.
  void example_channels_browse()
  {
    try
    {
      IDatabasePtr db = m_app.openDb( m_dbId );
      IFolderPtr f1 = db->getFolder( "/folder_1" );

      std::cout << std::endl
                << "Browsing objects (multi channel bulk: Channel 2-5):"
                << std::endl;
      ValidityKey since = 0;
      ValidityKey until = ValidityKeyMax;

      // define a channel selection range
      ChannelSelection channels( 2, 5 );

      IObjectIteratorPtr objects = f1->browseObjects( since,
                                                      until,
                                                      channels );

      std::cout << m_app.headerRow() << std::endl;
      while ( objects->goToNext() )
      {
        std::cout << objects->currentRef() << std::endl;
      }

    }
    catch ( cool::Exception& e )
    {
      std::cout << e.what() << std::endl;
    }


  }

  //---------------------------------------------------------------------------

}; // class McBulkRetrieval

//-----------------------------------------------------------------------------

int main ( int argc, char* argv[] )
{

  try {
    // instantiate new McBulkRetrieval object and set m_dbId string
    McBulkRetrieval app( argc, argv );

    std::cout << "\n*** Example: Multi Channel Bulk Retrieval ***\n" << std::endl;
    app.example_channels_write();
    app.example_channels_browse();

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
