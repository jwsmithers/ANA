// $Id: cool200API.cpp,v 1.4 2009-12-17 18:54:58 avalassi Exp $

#include <iostream>
#include <stdexcept>

// COOL API include files (CoolKernel)
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/FolderSpecification.h"
#include "CoolKernel/IDatabase.h"
#include "CoolKernel/IFolder.h"
#include "CoolKernel/IObject.h"
#include "CoolKernel/Record.h"

// COOL API include files (CoolApplication)
#include "CoolApplication/Application.h"

//--------------------------------------------------------------------------

int main ()
{

  try {
    // Fetch the URL from the environment variable
    const char* COOLTESTDB = "COOLTESTDB";
    std::string url;
    if ( getenv( COOLTESTDB ) ) url = getenv( COOLTESTDB );
    else throw std::runtime_error( "COOLTESTDB env variable is not set" );
    // Drop the database and recreate it
    {
      std::cout << "Drop the database and recreate it" << std::endl;
      cool::Application app;
      app.databaseService().dropDatabase( url );
      app.databaseService().createDatabase( url );
    }
    // Open the database and create a new folder
    {
      std::cout << "Open the database and create a new folder" << std::endl;
      cool::Application app;
      bool readOnly = false;
      cool::IDatabasePtr db =
        app.databaseService().openDatabase( url, readOnly );
      cool::RecordSpecification payloadSpec;
      payloadSpec.extend( "I64", cool::StorageType::Int64 );
      cool::FolderSpecification folderSpec
        ( cool::FolderVersioning::SINGLE_VERSION, payloadSpec );
      cool::IFolderPtr folder = db->createFolder( "/myfolder", folderSpec );
      cool::Int64 i64 = cool::Int64Max;
      cool::Record payload( payloadSpec );
      payload["I64"].setValue( i64 );
      folder->storeObject( 0, 100, payload, 1 ); // t=[0,100] in channel#1
    }
    // Open the database and read back from the folder
    {
      std::cout << "Open the database and read from the folder" << std::endl;
      cool::Application app;
      cool::IDatabasePtr db = app.databaseService().openDatabase( url );
      cool::IFolderPtr folder = db->getFolder( "/myfolder" );
      cool::MSG::Level oldLevel = app.outputLevel();
      app.setOutputLevel( cool::MSG::VERBOSE );
      cool::IObjectPtr obj = folder->findObject( 50, 1 ); // t=50 in channel#1
      app.setOutputLevel( oldLevel );
      std::cout << "Payload at t=50 in ch#1: " << obj->payload() << std::endl;
      const cool::IField& field = obj->payload()["I64"];
      std::cout << "Payload['I64'] at t=50 in ch#1: " << field << std::endl;
      cool::Int64 i64 = field.data<cool::Int64>();
      std::cout << "I64 at t=50 in ch#1: " << i64 << std::endl;
    }
  }

  catch ( std::exception& e ) {
    std::cout << "std::exception caught: '" << e.what() << "'" << std::endl;
    return -1;
  }

  catch (...) {
    std::cout << "Unknown exception caught!" << std::endl;
    return -1;
  }

}

//---------------------------------------------------------------------------
