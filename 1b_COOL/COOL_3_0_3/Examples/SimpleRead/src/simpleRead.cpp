#include <iostream>
#include <iomanip>
#include "CoralBase/Attribute.h"

// COOL API include files (CoolKernel)
#include "CoolKernel/DatabaseId.h"
#include "CoolKernel/Exception.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/IDatabase.h"
#include "CoolKernel/IFolder.h"
#include "CoolKernel/IObject.h"
#include "CoolKernel/IObjectIterator.h"
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordSpecification.h"

// COOL API include files (CoolApplication)
#include "CoolApplication/Application.h"

// Local include files
#include "CoolKernel/../src/scoped_enums.h"

// COOL namespace
using namespace cool;

//-----------------------------------------------------------------------------

/** @class SimpleRead simpleRead.cpp
 *
 *  Simple standalone user example to read from a database
 *  which was generated using simpleWrite using the COOL API.
 *
 *  @author Andrea Valassi, Sven A. Schmidt, Ulrich Moosbrugger
 *  @date   2005-08-09
 *///

class SimpleRead : public cool::Application
{

private:

  DatabaseId m_dbId;

public:

  //---------------------------------------------------------------------------

  /// Constructor from the command line arguments of 'main( argc, argv )'.
  /// Expect exactly one argument that ExampleApplication interprets
  /// as a COOL database connection identifier (cool::DatabaseId).
  SimpleRead( int argc, char* argv[] )
  {
    m_dbId = dbIdFromArg( argc, argv );
  }

  /// Retrieve DatabaseID from command line arguments
  const DatabaseId dbIdFromArg( int argc, char* argv[] ) const
  {
    if ( argc != 2 ) {
      std::stringstream msg;
      std::cout << "ERROR! Wrong number of arguments (" << argc-1
                << ") to " << argv[0] << std::endl;
      throw CommandLineArgumentException();
    }
    else {
      DatabaseId dbId = argv[1];
      return dbId;
    }
  }

  //---------------------------------------------------------------------------

  /// Open an existing database specified in the dbId. If the database
  /// does not exist, a DatabaseDoesNotExist exception is thrown.
  IDatabasePtr openDb( const DatabaseId& dbId )
  {
    try {
      std::cout << "Opening database '" << dbId << "'" << std::endl;
      IDatabaseSvc& dbSvc = databaseService();
      const bool readOnly = true;
      IDatabasePtr db = dbSvc.openDatabase( dbId, readOnly );
      return db;
    }
    // If the db does not exist, a DatabaseDoesNotExist exception is thrown
    catch ( DatabaseDoesNotExist& /*e*/ ) {
      std::cout << "Error! Database " << dbId << " does not exist!"
                << std::endl;
      throw;
    }
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
  coral::AttributeList createPayload
  ( int index,
    const cool::RecordSpecification& spec )
  {
    coral::AttributeList payload = Record( spec ).attributeList();
    payload["I"].data<cool::Int32>() = index;
    std::stringstream s; s << "Object " << index;
    payload["S"].data<cool::String4k>() = s.str();
    payload["X"].data<cool::Float>() = (float)(index/1000.);
    return payload;
  }

  //---------------------------------------------------------------------------

  /// This example shows how to retrieve conditions objects from
  /// single version folders (in the same channel with channelId=0).
  void example_SimpleRead()
  {
    try {
      IDatabasePtr db = openDb( m_dbId );

      std::cout << "Browsing objects of /folder_1:" << std::endl;
      IFolderPtr f1 = db->getFolder( "/folder_1" );
      ValidityKey since = 0;
      ValidityKey until = ValidityKeyMax;
      IObjectIteratorPtr objects = f1->browseObjects( since, until, 0 );
      std::cout
        << "         Id  Ch  IOV       Payload             Insertion time"
        << std::endl;
      while ( objects->goToNext() ) {
        std::cout << objects->currentRef() << std::endl;
      }
    } catch ( cool::Exception& e ) {
      std::cout << e.what() << std::endl;
    }

  }

  //---------------------------------------------------------------------------

  /// Exception thrown if dbIdFromArg is not called with one argument
  class CommandLineArgumentException : public cool::Exception
  {
  public:
    CommandLineArgumentException()
      : Exception( "Wrong #arguments to dbIdFromArg", "cool::ExampleApplication" ) {}
    virtual ~CommandLineArgumentException() throw() {}
    void usage( char* command, std::ostream& s )
    {
      s << "Usage:   " << command
        << " '<dbIdUrl>'" << std::endl;
      s << "Example: " << command
        << " 'oracle://devdb10;schema=lcg_cool;dbname=COOLTEST'"
        << std::endl;
      s << "Example: " << command
        << " 'mysql://pcitdb59;schema=COOLDB;dbname=COOLTEST'"
        << std::endl;
      s << "Example: " << command
        << " 'sqlite://none;schema=sqliteTest.db;dbname=COOLTEST'"
        << std::endl;
    }
  };

}; // class SimpleRead


//-----------------------------------------------------------------------------

int main ( int argc, char* argv[] ) {

  try {
    // instantiate new SimpleRead object and set m_dbId string
    SimpleRead app( argc, argv );

    std::cout << "\n*** Example: Simple read from a database ***\n"
              << std::endl;
    app.example_SimpleRead();

  }

  // Wrong number of command line arguments: print usage
  catch ( SimpleRead::CommandLineArgumentException& e ) {
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
