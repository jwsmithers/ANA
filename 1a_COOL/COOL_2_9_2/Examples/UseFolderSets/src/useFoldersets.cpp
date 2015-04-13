// $Id: useFoldersets.cpp,v 1.10 2009-12-17 18:55:02 avalassi Exp $

#include <iostream>
#include <iomanip>
#include <iterator>

// COOL API include files (CoolKernel)
#include "CoolKernel/Exception.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/IDatabase.h"
#include "CoolKernel/IFolder.h"
#include "CoolKernel/IFolderSet.h"
#include "CoolKernel/IObject.h"

// COOL example library include files (ExampleBase)
#include "ExampleBase/ExampleApplication.h"

// COOL namespace
using namespace cool;

//-----------------------------------------------------------------------------

/** @class UseFolderSets useFoldersets.cpp
 *
 *  User example that shows the use of folders and foldersets of the COOL API.
 *
 *  @author Andrea Valassi, Sven A. Schmidt, Ulrich Moosbrugger
 *  @date   2005-08-09
 *///

class UseFolderSets {

private:

  ExampleApplication m_app;
  DatabaseId m_dbId;
public:

  //---------------------------------------------------------------------------

  /// Constructor from the command line arguments of 'main( argc, argv )'.
  /// Expect exactly one argument that ExampleApplication interprets
  /// as a COOL database connection identifier (cool::DatabaseId).
  UseFolderSets( int argc, char* argv[] )
    : m_app( argc, argv )
  {
    m_dbId = m_app.dbIdFromArg( argc, argv );
  }

  //---------------------------------------------------------------------------

  /// This example creates a folder (set) hierarchy
  /// using createFolder and createFolderSet
  /// and afterwards lists the complete node hierarchy.
  void example_create_folderhierarchy()
  {
    IDatabasePtr db = m_app.recreateDb( m_dbId );
    cool::FolderSpecification spec = m_app.createFolderSpec();

    std::cout << "Creating a folderset hierarchy" << std::endl;
    db->createFolderSet( "/folderset_A" );
    db->createFolderSet( "/folderset_B" );

    std::cout << "Creating substructure" << std::endl;
    db->createFolderSet( "/folderset_B/folderset_C" );
    db->createFolderSet( "/folderset_B/folderset_D" );
    db->createFolderSet( "/folderset_B/folderset_D/folderset_E" );

    std::cout << "Creating more IOV folders" << std::endl;
    db->createFolder( "/folderset_B/folderset_C/folder_1", spec );
    db->createFolder( "/folderset_B/folderset_C/folder_2", spec );
    db->createFolder( "/folderset_B/folderset_D/folderset_E/folder_1", spec );
    db->createFolder( "/folderset_B/folderset_D/folderset_E/folder_2", spec );

    std::vector<std::string> nodes = db->listAllNodes();
    std::cout << "Complete node hierarchy:\n\t";
    copy( nodes.begin(), nodes.end(),
          std::ostream_iterator<std::string>(std::cout, "\n\t") );
    std::cout << std::endl;
  }

  //---------------------------------------------------------------------------

  /// This example shows how to retrieve
  /// existing nodes (i.e. folders or folder sets) using getFolder(Set) and
  /// how to list the nodes in a folder set using listFolder(Set).
  void example_retrieve_folderhierarchy()
  {
    try {
      IDatabasePtr db = m_app.openDb( m_dbId );

      std::cout << "Folders inside '/folderset_A':\n\t";
      IFolderSetPtr fsetA = db->getFolderSet( "/folderset_A" );

      std::vector<std::string> nodes = fsetA->listFolders();
      copy( nodes.begin(), nodes.end(),
            std::ostream_iterator<std::string>( std::cout, "\n\t" ) );
      std::cout << std::endl;

      std::vector<std::string> foldersets = fsetA->listFolderSets();
      std::cout << "There are no foldersets inside '/folderset_A':" << std::endl;
      std::cout << "\tcount: " << foldersets.size() << std::endl;
      std::cout << std::endl;

      IFolderSetPtr fsetB = db->getFolderSet( "/folderset_B" );
      nodes = fsetB->listFolderSets();
      std::cout << "However, there are foldersets inside '/folderset_B':\n\t";
      copy( nodes.begin(), nodes.end(),
            std::ostream_iterator<std::string>( std::cout, "\n\t" ) );
      std::cout << std::endl;

      IFolderSetPtr fsetD = db->getFolderSet( "/folderset_B/folderset_D" );
      nodes = fsetD->listFolderSets();
      std::cout << "and deeper in the hierarchy, inside "
                << "'/folderset_B/folderset_D':\n\t";
      copy( nodes.begin(), nodes.end(),
            std::ostream_iterator<std::string>( std::cout, "\n\t" ) );
      std::cout << std::endl;

      std::cout << "Note that folders and foldersets are not the same. "
                << "Fetching the wrong kind will throw an exception:"
                << std::endl;
      try {
        db->getFolder( "/folderset_A" );
      } catch ( cool::Exception& e ) {
        std::cout << "\t" << e.what() << std::endl;
      }
      try {
        db->getFolderSet( "/folderset_A/folder_1" );
      } catch ( cool::Exception& e ) {
        std::cout << "\t" << e.what() << std::endl;
      }
    } catch ( cool::Exception& e ) {
      std::cout << e.what() << std::endl;
    }
  }
}; // class UseFolderSets

//-----------------------------------------------------------------------------

int main ( int argc, char* argv[] ) {

  try {
    // instantiate new UseFolderSets object and set m_dbId string
    UseFolderSets app( argc, argv );

    std::cout << "\n*** Example: Create a folder (set) hierarchy ***\n" << std::endl;
    app.example_create_folderhierarchy();

    std::cout << "\n*** Example: Retrieve a folder (set) hierarchy ***\n" << std::endl;
    app.example_retrieve_folderhierarchy();

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
