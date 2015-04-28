
#include <iostream>
#include <iomanip>
#include "CoralBase/Attribute.h"

// COOL API include files (CoolKernel)
#include "CoolKernel/Exception.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/IDatabase.h"
#include "CoolKernel/IFolder.h"
#include "CoolKernel/IObject.h"
#include "CoolKernel/IObjectIterator.h"
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordSpecification.h"

// COOL example library include files (ExampleBase)
#include "ExampleBase/ExampleApplication.h"

// COOL namespace
using namespace cool;

//-----------------------------------------------------------------------------

/** @class UseClob useClob.cpp
 *
 *  User example that shows the how to store condition objects
 *  with CLOB payload columns using the COOL API.
 *
 *  @author Andrea Valassi, Sven A. Schmidt, Ulrich Moosbrugger
 *  @date   2005-06-27
 *///

class UseClob {

private:

  ExampleApplication m_app;
  DatabaseId m_dbId;

public:

  //---------------------------------------------------------------------------

  /// Constructor from the command line arguments of 'main( argc, argv )'.
  /// Expect exactly one argument that ExampleApplication interprets
  /// as a COOL database connection identifier (cool::DatabaseId).
  UseClob( int argc, char* argv[] )
    : m_app( argc, argv )
  {
    m_dbId = m_app.dbIdFromArg( argc, argv );
  }

  //---------------------------------------------------------------------------

  /// This example shows how to store/retrieve conditions objects from/into
  /// folders with CLOB (very long string) payload columns.
  void example_CLOB()
  {
    IDatabasePtr db = m_app.recreateDb( m_dbId );

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
    for ( int i = 1; i < 9; ++i ) {
      ValidityKey since = i;
      ValidityKey until = ValidityKeyMax;
      Record payload( spec );
      payload["I"].setValue<cool::Int32>( i );
      std::stringstream s; s << i;
      payload["S"].setValue<cool::String4k>( "Object " + s.str() );
      payload["X"].setValue<cool::Float>( (float)(i/1000.) );
      char c = s.str().data()[0];
      payload["S64k"].setValue<cool::String64k>( std::string( 65535, c ) );
      payload["S16M"].setValue<cool::String16M>( std::string( 16777215, c ) );
      f1->storeObject( since, until, payload, 0 ); // channel 0
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

}; // class UseClob

//-----------------------------------------------------------------------------

int main ( int argc, char* argv[] ) {

  try {
    // instantiate new UseClob object and set m_dbId string
    UseClob app( argc, argv );

    std::cout << "\n*** Example: Very long string (CLOB) payload ***\n"
              << std::endl;
    app.example_CLOB();

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
