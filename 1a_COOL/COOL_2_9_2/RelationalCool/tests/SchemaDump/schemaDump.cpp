// $Id: schemaDump.cpp,v 1.12 2009-12-17 18:38:56 avalassi Exp $

// Include files
#include <iostream>
#include <sstream>
#include <string>
#include "CoolKernel/DatabaseId.h"
#include "CoolKernel/IDatabase.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/IFolder.h"
#include "CoolKernel/IObject.h"
#include "CoolKernel/IObjectIterator.h"
#include "CoralBase/AttributeList.h"
#include "src/CoralApplication.h"
#include "src/sleep.h"
#include "src/timeToString.h"
#include "src/uppercaseString.h"
#include "../Common/releaser.h"

// Environment variable name (connection string)
namespace cool {
  const char* COOLTESTDB = "COOLTESTDB";
}

// Namespace
using namespace cool;

// Message output
#define LOG std::cout << "__main "

//-----------------------------------------------------------------------------

int main ( int /*argc*/, char* /*argv[]*/ )
{

  LOG << "Entering main" << std::endl;
  int status = -1;

  try {

    //------------------------
    // DEFINE THE DATABASE ID
    //------------------------

    // Command line input: connection string
    std::string dbIdString;
    if ( getenv( COOLTESTDB ) ) {
      dbIdString = getenv( COOLTESTDB );
    } else {
      std::cout << "ERROR! Please provide a connect string "
                << "in the environment variable COOLTESTDB" << std::endl;
      exit(-1);
    }
    cool::DatabaseId dbId = dbIdString;

    //-------------------------------
    // RETRIEVE THE DATABASE SERVICE
    //-------------------------------

    LOG << "Get a handle to the COOL database service" << std::endl;
    CoralApplication app;
    IDatabaseSvc& dbSvc = app.databaseService();

    //--------------------------------
    // DROP THE DATABASE IF IT EXISTS
    //--------------------------------

    // Drop the COOL conditions database if it already exists
    LOG << "Drop if it exists the conditions database: " << dbId << std::endl;
    dbSvc.dropDatabase( dbId );

    //-----------------------
    // CREATE A NEW DATABASE
    //-----------------------

    // Create a new COOL conditions database
    LOG << "Create a new conditions database: " << dbId << std::endl;
    cool::IDatabasePtr db = dbSvc.createDatabase( dbId );
    LOG << "Conditions database created: " << std::endl;
    LOG << "-> Database ID: " << db->databaseId() << std::endl;
    std::ostringstream dbAttr;
    db->databaseAttributes().toOutputStream( dbAttr );
    LOG << "-> Database attributes: " << dbAttr.str() << std::endl;

    // TEMPORARY? Patch for the ORA-01466 problem: sleep one second
    cool::sleep(1);

    // Create two new folders (one SV, one MV) with the same payload spec
    boost::shared_ptr<coral::AttributeListSpecification>
      spec( new coral::AttributeListSpecification(), releaser() );
    spec->extend( "A_BOOL", "bool" );
    //spec->extend( "A_CHAR", "char" ); // RAL MySQL error on retrieval
    //spec->extend( "A_UCHAR", "unsigned char" ); // Bad RAL MYSQL mapping
    spec->extend( "A_SHRT", "short" );
    spec->extend( "A_USHRT", "unsigned short" );
    spec->extend( "A_INT", "int" );
    spec->extend( "A_UINT", "unsigned int" );
    spec->extend( "A_LONG", "long" );
    spec->extend( "A_ULONG", "unsigned long" );
    //spec->extend( "A_LONGLONG", "long long" ); // OCI-22053 must be fixed
    spec->extend( "A_ULONGLONG", "unsigned long long" );
    spec->extend( "A_FLOAT", "float" );
    spec->extend( "A_DOUBLE", "double" );
    //spec->extend( "A_LONGDOUBLE", "long double" ); // NO RAL MySQL DEFAULT
    spec->extend( "A_STRING", "string" );
    //spec->extend( "A_TOKEN", "Token" ); // THIS WILL NOT BE SUPPORTED!

    // Create SV folder
    std::string folderNameSV( "/myfolders/SV" );
    cool::IFolderPtr folderSV = db->createFolder
      ( folderNameSV, *spec, "", FolderVersioning::SINGLE_VERSION, true );
    LOG << "Folder created: " << std::endl;
    LOG << "-> Folder name: " << folderSV->fullPath() << std::endl;
    //std::ostringstream folderAttrSV;
    //folderSV->payloadSpecification().print( folderAttrSV );
    //LOG << "-> Folder payload specification: "
    //    << folderAttrSV.str() << std::endl;

    // Create MV folder
    std::string folderNameMV( "/myfolders/MV" );
    cool::IFolderPtr folderMV = db->createFolder
      ( folderNameMV, *spec, "", FolderVersioning::MULTI_VERSION, true );
    LOG << "Folder created: " << std::endl;
    LOG << "-> Folder name: " << folderMV->fullPath() << std::endl;
    //std::ostringstream folderAttrMV;
    //folderMV->payloadSpecification().print( folderAttrMV );
    //LOG << "-> Folder payload specification: "
    //    << folderAttrMV.str() << std::endl;

    // TEMPORARY? Patch for the ORA-01466 problem: sleep one second
    cool::sleep(1);

    /*
    // Print the list of folders
    std::vector<std::string> folderList;
    std::vector<std::string>::iterator folderIt;
    folderList = db->listFolders();
    LOG << "-> List of folders in the database:" << std::endl;
    for( folderIt = folderList.begin();
         folderIt != folderList.end();
         folderIt++ ) {
      std::cout << *folderIt << std::endl;
    }
    *///

    // Successful completion
    LOG << "Program terminating succesfully" << std::endl;
    status = 0;

  }
  catch(std::exception& e)
  {
    LOG << "ERROR! Standard C++ exception: '" << e.what() << "'" << std::endl;
    status = 1;
  }
  catch(...)
  {
    LOG << "ERROR! Unknown exception caught" << std::endl;
    status = 1;
  }

  // Program termination
  LOG << "Exiting main" << std::endl;
  return status;

}

//-----------------------------------------------------------------------------
