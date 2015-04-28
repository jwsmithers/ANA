
#include <iostream>
#include <iomanip>
#include <math.h>

// COOL API include files (CoolKernel)
#include "CoolKernel/Exception.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/IDatabase.h"
#include "CoolKernel/Record.h"
#include "CoolKernel/IFolder.h"
#include "CoolKernel/FieldSelection.h"
#include "CoolKernel/CompositeSelection.h"
#include "CoolKernel/IObjectIterator.h"

// COOL example library include files (ExampleBase)
#include "ExampleBase/ExampleApplication.h"

// COOL namespace
using namespace cool;

//-----------------------------------------------------------------------------

/** @class usePayloadQueries usePayloadQueries.cpp
 *
 *  A class demonstrating the use of payload queries.
 *
 *  @author Andrea Valassi, Sven A. Schmidt, Ulrich Moosbrugger, Martin Wache
 *  @date   2008-09-22
 *///

class usePayloadQueries {

private:

  ExampleApplication m_app;
  DatabaseId m_dbId;

public:

  //---------------------------------------------------------------------------

  /// Constructor from the command line arguments of 'main( argc, argv )'.
  /// Expect exactly one argument that ExampleApplication interprets
  /// as a COOL database connection identifier (cool::DatabaseId).
  usePayloadQueries( int argc, char* argv[] )
    : m_app( argc, argv )
  {
    m_dbId = m_app.dbIdFromArg( argc, argv );
  }

  //---------------------------------------------------------------------------

  /// This example creates first a new IDatabasePtr.
  void createExampleFolder()
  {
    IDatabasePtr db = m_app.recreateDb( m_dbId );
    cool::FolderSpecification spec = m_app.createFolderSpec();

    std::cout << "Creating folder with example data..." << std::endl;
    IFolderPtr f1 = db->createFolder("/f1", spec);
    for (int i=0; i<100; i++)
    {
      Record rec(spec.payloadSpecification());
      rec["X"].setValue<Float>( (float)(sin( ((float)i)/15.0 )) );
      rec["I"].setValue<Int32>( i );
      std::stringstream str;
      str << "Object " << i;
      rec["S"].setValue<String255>(str.str());
      f1->storeObject(i,i+1,rec,0);
    };

  }

  //---------------------------------------------------------------------------

  /// This example opens first an existing database.
  void readExampleWithPayloadQueries()
  {
    try {
      IDatabasePtr db = m_app.openDb( m_dbId );
      IFolderPtr f1 = db->getFolder("/f1");

      std::cout << std::endl
                << "Reading back data where X>0.999..." << std::endl;
      FieldSelection selectXGreater0999(
                                        "X",cool_StorageType_TypeId::Float, cool_FieldSelection_Relation::GT, (float)0.999);

      IObjectIteratorPtr objects = f1->browseObjects( 0, 100, 0,
                                                      "", &selectXGreater0999);
      while ( objects->goToNext() )
        std::cout << objects->currentRef() << std::endl;

      std::cout << std::endl
                <<"Reading back data where X > 0.999 or X < -0.999..."
                << std::endl;
      FieldSelection selectXLess0999(
                                     "X",cool_StorageType_TypeId::Float, cool_FieldSelection_Relation::LT, (float)-0.999);

      CompositeSelection selectGreaterOrLess0999( &selectXGreater0999,
                                                  cool_CompositeSelection_Connective::OR, &selectXLess0999);

      objects = f1->browseObjects( 0, 100, 0,
                                   "", &selectGreaterOrLess0999);
      while ( objects->goToNext() )
        std::cout << objects->currentRef() << std::endl;


      std::cout << std::endl
                << "Reading back data where S is equal to 'Object 10'..." << std::endl;
      FieldSelection selectSEqual(
                                  "S", cool_StorageType_TypeId::String4k, cool_FieldSelection_Relation::EQ,
                                  (String4k) "Object 10");

      objects = f1->browseObjects( 0, 100, 0,
                                   "", &selectSEqual);
      while ( objects->goToNext() )
        std::cout << objects->currentRef() << std::endl;



    } catch ( cool::Exception& e ) {
      std::cout << e.what() << std::endl;
    }

  }

  //---------------------------------------------------------------------------

}; // class usePayloadQueries

//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------

int main ( int argc, char* argv[] ) {

  try {
    // instantiate new skeleton object and set m_dbId string
    usePayloadQueries app( argc, argv );

    app.createExampleFolder();

    app.readExampleWithPayloadQueries();

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
