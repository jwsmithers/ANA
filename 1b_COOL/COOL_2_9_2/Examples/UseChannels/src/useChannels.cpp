// $Id: useChannels.cpp,v 1.10 2009-12-17 18:55:01 avalassi Exp $

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

/** @class UseChannels useChannels.cpp
 *
 *  User example that shows the use of channels of the COOL API.
 *
 *  @author Andrea Valassi, Sven A. Schmidt, Ulrich Moosbrugger
 *  @date   2005-09-08
 *///

class UseChannels {

private:

  ExampleApplication m_app;
  DatabaseId m_dbId;

public:

  //---------------------------------------------------------------------------

  /// Constructor from the command line arguments of 'main( argc, argv )'.
  /// Expect exactly one argument that ExampleApplication interprets
  /// as a COOL database connection identifier (cool::DatabaseId).
  UseChannels( int argc, char* argv[] )
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

    std::cout << "\nStoring in different channels" << std::endl;
    IFolderPtr f1 = db->createFolder( "/folder_1", spec );
    for ( int i = 0; i < 10; ++i ) {
      ValidityKey since = i;
      ValidityKey until = ValidityKeyMax;
      ChannelId channel = i / 3;
      cool::Record payload = m_app.createPayload( i, spec.payloadSpecification() );
      f1->storeObject( since, until, payload, channel );
    }
  }

  //---------------------------------------------------------------------------

  /// This example shows how to retrieve conditions objects from
  /// single version folders in different channels.
  void example_channels_browse()
  {
    try {
      IDatabasePtr db = m_app.openDb( m_dbId );
      IFolderPtr f1 = db->getFolder( "/folder_1" );

      std::cout << "Browsing objects:" << std::endl;
      ValidityKey since = 0;
      ValidityKey until = ValidityKeyMax;
      ChannelId channel = 0;
      IObjectIteratorPtr objects = f1->browseObjects( since, until, channel );

      std::cout << m_app.headerRow() << std::endl;
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
    } catch ( cool::Exception& e ) {
      std::cout << e.what() << std::endl;
    }

  }

  //---------------------------------------------------------------------------

}; // class UseChannels

//-----------------------------------------------------------------------------

int main ( int argc, char* argv[] ) {

  try {
    // instantiate new UseChannels object and set m_dbId string
    UseChannels app( argc, argv );

    std::cout << "\n*** Example: Channels ***\n" << std::endl;
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
