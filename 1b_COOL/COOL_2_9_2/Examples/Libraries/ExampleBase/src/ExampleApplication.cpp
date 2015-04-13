// $Id: ExampleApplication.cpp,v 1.25 2012-06-29 12:54:13 avalassi Exp $

// Include files
#include <cstdio> // For sprintf on gcc45
#include <iomanip>
#include <iostream>
#include <sstream>
#include "CoolKernel/Exception.h"
#include "CoolKernel/IDatabase.h"
#include "CoolKernel/IFolder.h"
#include "CoolKernel/IObjectIterator.h"
#include "CoolKernel/Record.h"
#include "CoolKernel/Time.h"
#include "CoralBase/Attribute.h"
#include "ExampleBase/ExampleApplication.h"

//-----------------------------------------------------------------------------

cool::ExampleApplication::ExampleApplication( int, char** ) {
}

//-----------------------------------------------------------------------------

cool::ExampleApplication::~ExampleApplication()
{
}

//-----------------------------------------------------------------------------

const std::string
cool::ExampleApplication::dbIdFromArg( int argc, char* argv[] ) const
{
  if ( argc != 2 ) {
    std::stringstream msg;
    std::cerr << "ERROR! Wrong number of arguments (" << argc-1
              << ") to cool::ExampleApplication::dbIdFromArg" << std::endl;
    throw CommandLineArgumentException();
  }
  else {
    DatabaseId dbId = argv[1];
    return dbId;
  }
}

//---------------------------------------------------------------------------

cool::IDatabasePtr
cool::ExampleApplication::recreateDb( const DatabaseId& dbId )
{
  std::cout << "Recreating database '" << dbId << "'" << std::endl;
  IDatabaseSvc& dbSvc = databaseService();
  dbSvc.dropDatabase( dbId ); // do nothing if the database does not exist
  IDatabasePtr db = dbSvc.createDatabase( dbId );
  return db;
}

//---------------------------------------------------------------------------

cool::IDatabasePtr
cool::ExampleApplication::openDb( const DatabaseId& dbId, bool readOnly )
{
  try {
    std::cout << "Opening database '" << dbId << "'" << std::endl;
    IDatabaseSvc& dbSvc = databaseService();
    IDatabasePtr db = dbSvc.openDatabase( dbId, readOnly );
    return db;
  }
  // If the database does not exist, an exception is thrown
  catch ( cool::DatabaseDoesNotExist& /*e*/ ) {
    std::cerr << "Error! Database " << dbId << " does not exist!" << std::endl;
    throw;
  }
}

//---------------------------------------------------------------------------

cool::RecordSpecification
cool::ExampleApplication::createRecordSpec()
{
  std::cout << "Preparing RecordSpecification" << std::endl;

  RecordSpecification spec;
  spec.extend("I",StorageType::Int32);
  spec.extend("S",StorageType::String4k);
  spec.extend("X",StorageType::Float);

  return spec;
}

//---------------------------------------------------------------------------

cool::Record
cool::ExampleApplication::createPayload
( int index,
  const cool::IRecordSpecification &spec )
{
  cool::Record payload( spec );
  payload["I"].setValue<cool::Int32>( index );
  std::stringstream s; s << "Object " << index;
  payload["S"].setValue<cool::String4k>( s.str() );
  payload["X"].setValue<cool::Float>( (float)(index/1000.) );
  return payload;
}

//-----------------------------------------------------------------------------

const std::string
cool::ExampleApplication::timeToString( const cool::Time& time )
{
  int year = time.year( );
  int month = time.month( ) + 1; // Months are in [0-11]
  int day = time.day( );
  int hour = time.hour( );
  int min = time.minute( );
  int sec = time.second( );
  long nsec = time.nanosecond();
  char timeString[] = "yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT";
  int nChar = std::string(timeString).size();
  if ( snprintf( timeString, 30, // Fix Coverity SECURE_CODING
                 "%4.4d-%2.2d-%2.2d_%2.2d:%2.2d:%2.2d.%9.9ld GMT",
                 year, month, day, hour, min, sec, nsec) == nChar ) {
    return std::string(timeString);
  } else {
    std::ostringstream msg;
    msg << "Error encoding cool::Time into string: " << time;
    throw cool::Exception( msg.str(), "cool::timeToString" );
  }
}

//-----------------------------------------------------------------------------

void cool::ExampleApplication::printTag( const std::string& name,
                                         const std::string& desc,
                                         const std::string& tagTime )
{
  unsigned int tagNameWidth = 7;
  unsigned int tagDescWidth = 17;
  std::cout << std::setiosflags(std::ios::left)
            << std::setw(tagNameWidth) << name
            << std::setw(tagDescWidth) << desc
            << " " << tagTime
            << std::resetiosflags(std::ios::left) << std::endl;
}

//---------------------------------------------------------------------------

void cool::ExampleApplication::printTagContents
( const IFolderPtr& folder,
  const std::vector<std::string>& tagNames )
{
  std::cout << headerRow() << std::endl;
  for ( std::vector<std::string>::const_iterator t = tagNames.begin();
        t != tagNames.end(); ++ t ) {
    ValidityKey since = 0;
    ValidityKey until = ValidityKeyMax;
    ChannelId channel = 0;
    std::string tagName( *t );
    IObjectIteratorPtr objects =
      folder->browseObjects( since, until, channel, tagName );
    std::cout << tagName << ":" << std::endl;
    while ( objects->goToNext() ) {
      std::cout << objects->currentRef() << std::endl;
    }
  }
}

//---------------------------------------------------------------------------

const std::string& cool::ExampleApplication::headerRow() {
  static std::string header( "         Id  Ch  IOV       "
                             "Payload             Insertion time" );
  return header;
}

//---------------------------------------------------------------------------
