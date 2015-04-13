// $Id: simpleWrite.cpp,v 1.12 2009-12-17 18:55:00 avalassi Exp $

#include <iostream>
#include <iomanip>
#include "CoralBase/Attribute.h"

// COOL API include files (CoolKernel)
#include "CoolKernel/DatabaseId.h"
#include "CoolKernel/Exception.h"
#include "CoolKernel/FolderSpecification.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/IDatabase.h"
#include "CoolKernel/IFolder.h"
#include "CoolKernel/IObject.h"
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordSpecification.h"

// COOL API include files (CoolApplication)
#include "CoolApplication/Application.h"

// COOL namespace
using namespace cool;

//-----------------------------------------------------------------------------

/** @class SimpleWrite simpleWrite.cpp
 *
 *  Simple standalone user example to write into a database using the COOL API.
 *
 *  @author Andrea Valassi, Sven A. Schmidt, Ulrich Moosbrugger
 *  @date   2005-08-09
 *///

class SimpleWrite : public cool::Application {

private:
  DatabaseId m_dbId;

public:

  //---------------------------------------------------------------------------

  /// Constructor from the command line arguments of 'main( argc, argv )'.
  /// Expect exactly one argument that ExampleApplication interprets
  /// as a COOL database connection identifier (cool::DatabaseId).
  SimpleWrite( int argc, char* argv[] )
  {
    m_dbId = dbIdFromArg( argc, argv );
  }

  /// Retrieve DatabaseID from command line arguments
  const DatabaseId dbIdFromArg( int argc, char* argv[] ) const
  {
    if ( argc != 2 ) {
      std::stringstream msg;
      std::cout << "ERROR! Wrong number of arguments (" << argc-1
                << ") to "<< *argv[0] << std::endl;
      throw CommandLineArgumentException();
    }
    else {
      DatabaseId dbId = argv[1];
      return dbId;
    }
  }

  //---------------------------------------------------------------------------

  /// Drop and recreate the database specified in the dbId.
  IDatabasePtr recreateDb( const DatabaseId& dbId )
  {
    std::cout << "Recreating database '" << dbId << "'" << std::endl;
    IDatabaseSvc& dbSvc = databaseService();
    dbSvc.dropDatabase( dbId ); // do nothing if the database does not exist
    IDatabasePtr db = dbSvc.createDatabase( dbId );
    return db;
  }

  //---------------------------------------------------------------------------

  /// Create a conditions payload specification (AttributeListSpecification).
  /// All conditions payloads used in this example use this specification
  /// (with three fields I - Int32, S - String4k, X - Float: for instance,
  /// these may represent a status code, a comment and a temperature).
  cool::RecordSpecification createRecordSpec()
  {
    std::cout << "Preparing RecordSpecification" << std::endl;

    cool::RecordSpecification spec;
    spec.extend("I",StorageType::Int32);
    spec.extend("S",StorageType::String4k);
    spec.extend("X",StorageType::Float);
    return spec;
  }

  //---------------------------------------------------------------------------

  /// Create a fake 'indexed' conditions payload for the given specification.
  /// A payload with unique values is created for each value of the 'index'.
  cool::Record
  createPayload( int index, const cool::IRecordSpecification& spec )
  {
    cool::Record payload( spec );
    payload["I"].setValue<cool::Int32>( index );
    std::stringstream s; s << "Object " << index;
    payload["S"].setValue<cool::String4k>( s.str() );
    payload["X"].setValue<cool::Float>( (float)(index/1000.) );
    return payload;
  }

  //---------------------------------------------------------------------------

  /// This example shows how to store conditions objects into
  /// single version folders (in the same channel with channelId=0).
  void example_SimpleWrite()
  {
    IDatabasePtr db = recreateDb( m_dbId );
    cool::RecordSpecification spec = createRecordSpec();
    cool::FolderSpecification folderSpec( FolderVersioning::SINGLE_VERSION,
                                          spec );

    std::cout << "\nStoring single objects in /folder_1" << std::endl;
    IFolderPtr f1 = db->createFolder( "/folder_1", folderSpec );
    for ( int i = 0; i < 10; ++i ) {
      ValidityKey since = i;
      ValidityKey until = ValidityKeyMax;
      cool::Record payload = createPayload( i, spec );
      f1->storeObject( since, until, payload, 0 );
    }
  }

  /// Exception thrown if dbIdFromArg is not called with one argument
  class CommandLineArgumentException : public cool::Exception
  {
  public:
    CommandLineArgumentException()
      : Exception( "Wrong #arguments to dbIdFromArg", "cool::ExampleApplication" ) {}
    virtual ~CommandLineArgumentException() throw() {}
    void usage( char* command, std::ostream& s ) {
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

}; // class SimpleWrite


//-----------------------------------------------------------------------------

int main ( int argc, char* argv[] ) {

  try {
    // instantiate new SimpleWrite object and set m_dbId string
    SimpleWrite app( argc, argv );

    std::cout << "\n*** Example: Simple write into a database ***\n" << std::endl;
    app.example_SimpleWrite();

  }

  // Wrong number of command line arguments: print usage
  catch ( SimpleWrite::CommandLineArgumentException& e ) {
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
