
#include <iostream>
#include <string>
#include <set>

// CORAL API
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"
#include "RelationalAccess/ConnectionService.h"
#include "RelationalAccess/IConnectionServiceConfiguration.h"
#include "RelationalAccess/AccessMode.h"
#include "RelationalAccess/ISessionProxy.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ITransaction.h"

// COOL API include files (CoolKernel)
#include "CoolKernel/Exception.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/IDatabase.h"
#include "CoolKernel/IFolder.h"
#include "CoolKernel/IObject.h"

// COOL API include files (CoolApplication)
#include "CoolApplication/Application.h"

//-----------------------------------------------------------------------------

/** @class COOLClient shareConnection.cpp
 *
 *  Simple class connecting to a COOL database.
 *  Use the SimpleWrite example to populate the database first.
 *
 *  @author Marco Clemencic
 *  @date   2006-03-21
 *///

class COOLClient {

private:

  /// Copy of the connection string.
  cool::DatabaseId m_dbId;

  /// Pointer to the opened database.
  cool::IDatabasePtr m_db;

public:

  //---------------------------------------------------------------------------
  /// Constructor.
  /// Open an existing database identified by the connection string.
  COOLClient( std::string id, cool::Application &app ) : m_dbId(id)
  {

    // get IDatabaseSvc
    cool::IDatabaseSvc &databaseService = app.databaseService();

    std::cout << "\nCOOL Client: Connecting to COOL database '" << m_dbId << "'" << std::endl;

    m_db = databaseService.openDatabase( m_dbId, false ); // open a read-write connection (else a single transaction is started)

    std::cout << "\nCOOL Client: Connected to COOL database '" << m_dbId << "'" << std::endl;

  }
  //---------------------------------------------------------------------------
  /// Destructor.
  ~COOLClient()
  {
    std::cout << "\nCOOL Client: Exiting" << std::endl;
  }

  //---------------------------------------------------------------------------

  std::string databaseName()
  {
    return m_db->databaseName();
  }

  //---------------------------------------------------------------------------

  /// This example creates first a new IDatabasePtr.
  void get_data()
  {
    std::cout << "\nCOOL Client: Reading data" << std::endl;

    cool::IFolderPtr f = m_db->getFolder("/folder_1");

    coral::AttributeList payload = f->findObject(1,0)->payload().attributeList();

    std::cout << "COOL Client: object found:\n\t";
    payload.toOutputStream(std::cout);
    std::cout << std::endl;

  }

  //---------------------------------------------------------------------------

}; // class COOLClient

//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------

/** @class CORALClient shareConnection.cpp
 *
 *  Simple class connecting to a database using CORAL.
 *
 *  @author Marco Clemencic
 *  @date   2006-03-21
 *///
class CORALClient {

private:
  std::string m_connString;

  coral::ISessionProxy *m_session;

public:
  //---------------------------------------------------------------------------
  /// Constructor.
  /// Open a database identified by the connection string.
  CORALClient( std::string id, coral::IConnectionService &connectionService) :
    m_connString(id), m_session(0)
  {
    std::cout << "\nCORAL Client: Connecting to database '" << m_connString << "'" << std::endl;

    m_session = connectionService.connect( m_connString, coral::ReadOnly );

    std::cout << "\nCORAL Client: Connected to database '" << m_connString << "'" << std::endl;
  }

  //---------------------------------------------------------------------------
  /// Destructor.
  /// Close the connection
  ~CORALClient() {
    if (m_session) {
      std::cout << "\nCORAL Client: Exiting" << std::endl;
      delete m_session;
    }
  }

  //---------------------------------------------------------------------------
  /// Get the list of tables on the database and print it on stdout.
  void printTables( const std::string& dbName )
  {
    std::cout << "\nCORAL Client: list of tables" << std::endl;

    m_session->transaction().start( true );
    std::set<std::string> tables = m_session->nominalSchema().listTables();
    m_session->transaction().commit();

    for ( std::set<std::string>::iterator tName = tables.begin(); tName != tables.end(); ++tName )
    {
      if ( tName->find(dbName) == 0 ) // print only the tables in the COOL db
        std::cout << "\t" << *tName << std::endl;
    }
    //    std::cout << std::endl;
  }

};

//-----------------------------------------------------------------------------

int main ( int argc, char* argv[] ) {

  // --------------------------------------------------
  // Parse command line arguments
  // --------------------------------------------------

  if ( argc != 2 ) {
    std::cout << "ERROR! Wrong number of arguments (" << argc-1
              << ") to " << argv[0] << std::endl;
    std::cout << "Usage:   " << argv[0]
              << " '<dbIdUrl>'" << std::endl;
    std::cout << "Example: " <<  argv[0]
              << " 'oracle://devdb10;schema=lcg_cool;dbname=COOLTEST'"
              << std::endl;
    std::cout << "Example: " << argv[0]
              << " 'mysql://pcitdb59;schema=COOLDB;dbname=COOLTEST'"
              << std::endl;
    std::cout << "Example: " << argv[0]
              << " 'sqlite://none;schema=sqliteTest.db;dbname=COOLTEST'"
              << std::endl;

    return 1;
  }

  // --------------------------------------------------
  // Parse the connection string
  // --------------------------------------------------

  // Set the connection string
  std::string coolConnStr = argv[1];

  // Generate CORAL connection string from COOL one.
  // - start with the server
  size_t pos = coolConnStr.find(";");
  if (pos == coolConnStr.npos) {
    std::cerr << "Bad connection string provided" << std::endl;
    return 1;
  }
  std::string coralConnStr(coolConnStr,0,pos); // copy the first part ("oracle://server")

  // - extract the schema name
  pos = coolConnStr.find("schema=");
  if (pos == coolConnStr.npos) {
    std::cerr << "Bad connection string provided: no schema name found" << std::endl;
    return 1;
  }
  pos += 7; // position after the "="

  size_t pos2 = coolConnStr.find(";",pos);
  if (pos2 == coolConnStr.npos) pos2 = coolConnStr.size();

  coralConnStr += "/";
  coralConnStr += coolConnStr.substr(pos,pos2-pos);


  // --------------------------------------------------
  // Main part
  // --------------------------------------------------

  try {

    // Create a coral ConnectionService
    coral::ConnectionService connSvc;

    // Start CORAL client
    CORALClient coralClient(coralConnStr,connSvc);

    // Create a COOL application using the given ConnectionService
    cool::Application app(&connSvc);

    // Start COOL client
    COOLClient coolClient(coolConnStr,app);

    coralClient.printTables( coolClient.databaseName() );

    coolClient.get_data();

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

  return 0;

}

//-----------------------------------------------------------------------------
