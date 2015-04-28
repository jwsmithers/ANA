
#include <iostream>
#include <iomanip>

// COOL API include files (CoolKernel)
#include "CoolKernel/Exception.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/IDatabase.h"

// COOL example library include files (ExampleBase)
#include "ExampleBase/ExampleApplication.h"

// COOL namespace
using namespace cool;

//-----------------------------------------------------------------------------

/** @class Skeleton skeleton.cpp
 *
 *  A template for building user examples.
 *
 *  @author Andrea Valassi, Sven A. Schmidt, Ulrich Moosbrugger
 *  @date   2005-09-08
 *///

class Skeleton {

private:

  ExampleApplication m_app;
  DatabaseId m_dbId;

public:

  //---------------------------------------------------------------------------

  /// Constructor from the command line arguments of 'main( argc, argv )'.
  /// Expect exactly one argument that ExampleApplication interprets
  /// as a COOL database connection identifier (cool::DatabaseId).
  Skeleton( int argc, char* argv[] )
    : m_app( argc, argv )
  {
    m_dbId = m_app.dbIdFromArg( argc, argv );
  }

  //---------------------------------------------------------------------------

  /// This example creates first a new IDatabasePtr.
  void example_doanything_write()
  {
    IDatabasePtr db = m_app.recreateDb( m_dbId );
    cool::FolderSpecification spec = m_app.createFolderSpec();
    // cool::Record payload = m_app.createPayload( i, spec.payloadSpecification() );
    // or
    // coral::AttributeList payload = spec.createAttributeList();

    std::cout << "  Example to do anything (write)..." << std::endl;
  }

  //---------------------------------------------------------------------------

  /// This example opens first an existing database.
  void example_doanything_read()
  {
    try {
      IDatabasePtr db = m_app.openDb( m_dbId );
      std::cout << "  Example to do anything (read)..." << std::endl;
    } catch ( cool::Exception& e ) {
      std::cout << e.what() << std::endl;
    }

  }

  //---------------------------------------------------------------------------

}; // class Skeleton

//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------

int main ( int argc, char* argv[] ) {

  try {
    // instantiate new skeleton object and set m_dbId string
    Skeleton app( argc, argv );

    std::cout << "\n*** Example: Do anything (write)  ***\n" << std::endl;
    app.example_doanything_write();

    std::cout << "\n*** Example: Do anything (read)  ***\n" << std::endl;
    app.example_doanything_read();

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
