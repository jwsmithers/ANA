// $Id: coolAuthentication.cpp,v 1.24 2013-06-05 14:23:33 avalassi Exp $

// Include files
#include <iostream>
#include "CoolKernel/Exception.h"
#include "CoolKernel/InternalErrorException.h"
#include "CoralBase/MessageStream.h"
#include "CoralKernel/Context.h"
#include "RelationalAccess/AuthenticationServiceException.h"
#include "RelationalAccess/IAuthenticationService.h"
#include "RelationalAccess/IAuthenticationCredentials.h"
#include "RelationalAccess/IDatabaseServiceSet.h"
#include "RelationalAccess/IDatabaseServiceDescription.h"
#include "RelationalAccess/ILookupService.h"

// Local include files
#include "../../src/RalSessionMgr.h"
#include "../../src/RelationalDatabaseId.h"

// Namespace
using namespace cool;

// Message output
#define LOG std::cout
#define DEB if ( false ) std::cout << "DEBUG: " // DEBUG printout (disabled)

// flag to know if we already loaded the LFCReplicaSvc
static bool lfcReplicaSvcLoaded = false;

static coral::Context& context() {
  static coral::Context& context = coral::Context::instance();
  return context;
}

static void load(const std::string &component) {
  context().loadComponent(component);
}

//-----------------------------------------------------------------------------

coral::IHandle<coral::ILookupService> lookupSvc()
{
  std::string svc_name;
  // If we can access a LFC and the user is not explicitely forbidding it,
  // we try to use CORAL LFCReplicaService
  if ( ::getenv("COOL_IGNORE_LFC") == NULL && ::getenv("LFC_HOST") != NULL ) {
    svc_name = "CORAL/Services/LFCReplicaService";
    if ( ! lfcReplicaSvcLoaded ) {
      // try to load CORAL LFCReplicaService
      load( svc_name );
      lfcReplicaSvcLoaded = true;
    }
  } else {
    // We should check if the component is already loaded before loading it,
    // but I know that it will be loaded only once by the application
    svc_name = "CORAL/Services/XMLLookupService";
    load( svc_name );
  }

  coral::IHandle<coral::ILookupService> svc =
    context().query<coral::ILookupService>();
  if ( ! svc.isValid() )
    throw Exception
      ( "Could not retrieve "+svc_name, "coolAuthentication" );
  return svc;
}

//-----------------------------------------------------------------------------

coral::IHandle<coral::IAuthenticationService> authSvc()
{
  std::string svc_name;
  // If we can access a LFC and the user is not explicitely forbidding it,
  // we try to use CORAL LFCReplicaService
  if ( ::getenv("COOL_IGNORE_LFC") == NULL && ::getenv("LFC_HOST") != NULL ) {
    svc_name = "CORAL/Services/LFCReplicaService";
    if ( ! lfcReplicaSvcLoaded ) {
      // try to load CORAL LFCReplicaService
      load( svc_name );
      lfcReplicaSvcLoaded = true;
    }
  } else {
    // We should check if the component is already loaded before loading it,
    // but I know that it will be loaded only once by the application
    svc_name = "CORAL/Services/XMLAuthenticationService";
    load( svc_name );
  }

  coral::IHandle<coral::IAuthenticationService> svc =
    context().query<coral::IAuthenticationService>();
  if ( ! svc.isValid() )
    throw Exception
      ( "Could not retrieve "+svc_name, "coolAuthentication" );
  return svc;
}

//-----------------------------------------------------------------------------

void authenticate( const std::string& coralReplica,
                   const std::string& technology,
                   std::string& user,
                   std::string& password )
{
  try
  {
    DEB << "Get credentials for '" << coralReplica << "'" << std::endl;
    // Get the authentication credentials from CORAL
    const coral::IAuthenticationCredentials& cred =
      authSvc()->credentials( coralReplica );
    user = cred.valueForItem( "user" );
    password = cred.valueForItem( "password" );
    // Do not allow empty usernames for Kerberos non-proxy authentication
    if ( user == "" )
      throw Exception
        ( "Empty username credentials found for " + coralReplica,
          "coolAuthentication" );
    // Allow empty password for Kerberos proxy authentication (task #30593)
    /*
    if ( password == "" )
      throw Exception
        ( "Empty password credentials found for " + coralReplica,
          "coolAuthentication" );
    *///
    if ( user == "" && password != "" )
      throw Exception
        ( "Empty username credentials with non-empty password found for "
          + coralReplica, "coolAuthentication" );
  }
  catch( coral::UnknownConnectionException& /*exc*/ )
  {
    if ( technology == "sqlite" || technology == "frontier" )
    {
      //LOG << "WARNING: '" << exc.what() << "'" << std::endl;
      //LOG << "WARNING: set DUMMY user and DUMMY password" << std::endl;
      user = "DUMMY";
      password = "DUMMY";
    }
    else throw;
  }
}

//-----------------------------------------------------------------------------

void printOut( const std::string& coralReplica,
               const std::string& coralMode,
               const std::string& middleTier2,
               const std::string& technology,
               const std::string& server,
               const std::string& schema,
               const std::string& user,
               const std::string& password )
{
  // Print out the database server properties
  // [NB This 2nd middleTier may only come from resolving a local dblookup.xml]
  // [NB ie original connection string is an alias with a coralserver replica!]
  LOG << "==> coralReplica = " << coralReplica << std::endl;
  LOG << "==> coralMode    = " << coralMode << std::endl;
  LOG << "==> middleTier   = " << middleTier2 << std::endl;
  LOG << "==> technology   = " << technology << std::endl;
  LOG << "==> server       = " << server << std::endl;
  LOG << "==> schema       = " << schema << std::endl;

  // Print out the authentication credentials
  //LOG << "CORAL authentication credentials:" << std::endl;
  LOG << "==> user         = " << user << std::endl;
  LOG << "==> password     = " << password << std::endl;
}

//-----------------------------------------------------------------------------

int main( int argc, char** argv )
{

  // *** TRY ***

  try {

    // Get the COOL database identifier
    bool rwOnly = false;
    bool firstOnly = false;
    std::string dbId;
    if ( argc == 3 && std::string(argv[1]) == "-1" )
    {
      firstOnly = true;
      dbId = argv[2];
    }
    else if ( argc == 3 && std::string(argv[1]) == "-1RW" )
    {
      rwOnly = true;
      firstOnly = true;
      dbId = argv[2];
    }
    else if ( argc == 2 )
    {
      dbId = argv[1];
    }
    else
    {
      LOG << "Usage: " << argv[0] << " [-1|-1RW] dbId" << std:: endl;
      LOG << "[Option -1: display only the first replica]" << std::endl;
      LOG << "[Option -1RW: display only the first RW replica]" << std::endl;
      std::string dbId1 =
        "oracle://SERVER;schema=SCHEMA;user=USER;password=PSWD;dbname=DB";
      std::string dbId2 =
        "oracle://SERVER;schema=SCHEMA;dbname=DB";
      std::string dbId3 =
        "alias/DB";
      LOG << std::endl;
      LOG << "Example: " << argv[0] << " '" << dbId1 << "'\n"
          << "[Decode user and password from explicit credentials]"
          << std::endl;
      LOG << std::endl;
      LOG << "Example: " << argv[0] << " '" << dbId2 << "'\n"
          << "[Get user and password from authentication service]"
          << std::endl;
      LOG << std::endl;
      LOG << "Example: " << argv[0] << " '" << dbId3 << "'\n"
          << "[Get alias translation from dblookup service]"
          << std::endl
          << "[Get user and password from authentication service]"
          << std::endl;
      return 1;
    }

    // --- TRANSLATE COOL URL into CORAL alias or explicit replica

    // Parse the dbId URL as RelationalDatabaseId connection parameters
    RelationalDatabaseId relationalDbId( dbId );

    // Print out the database identification
    // [NB If 1st middleTier is followed by an alias, need remote dblookup.xml]
    // [NB BUT we use the local dblookup.xml here (for regression tests only!)]
    LOG << "COOL databaseId" << std::endl;
    LOG << "==> middleTier   = " // remote dblookup.xml
        << relationalDbId.middleTier() << std::endl; // remote dblookup.xml
    LOG << "==> url          = "
        << relationalDbId.url() << std::endl;
    LOG << "==> urlHidePswd  = "
        << relationalDbId.urlHidePswd() << std::endl;

    // Extract the connection parameters from the RelationalDbId
    std::string middleTier1( relationalDbId.middleTier() );
    std::string technology ( relationalDbId.technology() );
    std::string server     ( relationalDbId.server()     );
    std::string schema     ( relationalDbId.schema()     );
    std::string dbName     ( relationalDbId.dbName()     );
    std::string user       ( relationalDbId.user()       );
    std::string password   ( relationalDbId.password()   );

    // PANIC if the database name is not given explicitly
    // (RelationalDatabaseId should have already failed!)
    if ( dbName == "" )
      throw InternalErrorException
        ( "PANIC! No database name specified in COOL database URL",
          "coolAuthentication" );
    LOG << "==> dbName       = "
        << dbName << std::endl;

    // Get the CORAL connection string
    std::string coralUrl;
    if ( middleTier1 == "" )
      coralUrl = RalConnectionString( relationalDbId );
    else
      coralUrl = RalConnectionString( relationalDbId.url() );
    std::string coralMode = "N/A";

    // --- Case 1: CORAL alias (loop over replicas)

    // If the connection string looks like an alias, pass it to the LookupSvc
    if ( coralUrl.find("://") == std::string::npos &&
         coralUrl.substr(0,12) != "sqlite_file:" )
    {
      LOG << "CORAL logical alias" << std::endl;
      LOG << "==> coralAlias   = " << coralUrl << std::endl;

      // PANIC if technology, server, schema, user or password
      // are defined at this point (this should never happen!)
      if ( technology != "" )
        throw InternalErrorException
          ( "PANIC! COOL URL based on CORAL alias explicitly contains "
            "technology '" + technology + "'",
            "coolAuthentication" );
      if ( server != "" )
        throw InternalErrorException
          ( "PANIC! COOL URL based on CORAL alias explicitly contains "
            "server '" + server + "'",
            "coolAuthentication" );
      if ( schema != "" )
        throw InternalErrorException
          ( "PANIC! COOL URL based on CORAL alias explicitly contains "
            "schema '" + schema + "'",
            "coolAuthentication" );
      if ( user != "" )
        throw InternalErrorException
          ( "PANIC! COOL URL based on CORAL alias explicitly contains "
            "user '" + user + "'",
            "coolAuthentication" );
      if ( password != "" )
        throw InternalErrorException
          ( "PANIC! COOL URL based on CORAL alias explicitly contains "
            "password '" + password + "'",
            "coolAuthentication" );

      // Lookup the replicas
      coral::AccessMode mode = ( rwOnly ? coral::Update : coral::ReadOnly );
      std::auto_ptr<coral::IDatabaseServiceSet> replicas
        ( lookupSvc()->lookup( coralUrl, mode ) );
      int nReplicas = replicas->numberOfReplicas();
      if ( nReplicas  == 0 )
        throw Exception
          ( "No dblookup replicas found for " + coralUrl,
            "coolAuthentication" );

      // Loop over the replicas
      // Reuse variables coralUrl, technology, server, schema, user, password
      DEB << "Loop over " << nReplicas
          << " replicas for alias '" << coralUrl << "'" << std::endl;
      for ( int iReplica = 0; iReplica < nReplicas; iReplica++ )
      {
        const coral::IDatabaseServiceDescription&
          dsd = replicas->replica( iReplica );
        coralUrl = dsd.connectionString();
        coralMode = ( dsd.accessMode() == coral::ReadOnly ? "R/O" : "R/W" );
        DEB << "Analyse replica '" << coralUrl << "'" << std::endl;

        // Does the dblookup replica point to a middle-tier?
        // [NB From now on the REMOTE coralUrl may differ from coralFullUrl]
        std::string coralFullUrl = coralUrl;
        std::string middleTier2;
        middleTier2 = RelationalDatabaseId::stripMiddleTier( coralUrl );

        // Extract technology, server and schema
        // [NB These are the REMOTE technology, server and schema]
        if ( coralUrl.substr(0,12) == "sqlite_file:" )
        {
          // Special case for SQLite
          technology = "sqlite";
          server = "";
          schema = coralUrl.substr(12);
        }
        else
        {
          // Backends other than SQLite
          std::string::size_type pos = coralUrl.find("://");
          if ( pos == std::string::npos )
            throw Exception
              ( "The connection string returned by the lookup service "
                "does not contain \"://\": " + coralUrl,
                "coolAuthentication" );
          technology = coralUrl.substr(0,pos);
          pos += 3;
          std::string::size_type pos2 = coralUrl.find_last_of('/');
          if ( pos2 == std::string::npos )
            throw Exception
              ( "The connection string returned by the lookup service "
                "does not contain the schema name: " + coralUrl,
                "coolAuthentication" );
          server = coralUrl.substr(pos,pos2 - pos);
          schema = coralUrl.substr(pos2+1);
        }

        // Retrieve user and password using the authentication service
        user = "";
        password = "";
        authenticate( coralUrl, technology, user, password );

        // Print out the results
        LOG << "CORAL physical replica ("
            << iReplica+1 << " of " << nReplicas << ")" << std::endl;
        printOut( coralFullUrl, coralMode, middleTier2, // LOCAL
                  technology, server, schema, user, password ); // REMOTE

        // Use only the first replica if required
        if ( firstOnly ) break;

      }

    }

    // --- Case 2: explicit CORAL replica

    else

    {

      // If the user name or password are not given explicitly,
      // retrieve them using the CORAL authentication service
      if ( user == "" || password == "" )
        authenticate( coralUrl, technology, user, password );

      // Print out the results
      LOG << "CORAL physical replica (1 of 1)" << std::endl;
      printOut( coralUrl, coralMode, "", // LOCAL
                technology, server, schema, user, password ); // REMOTE

    }

  }

  // *** CATCH exceptions ***

  catch( std::exception& e )
  {
    LOG << "ERROR! Standard C++ exception: '" << e.what() << "'" << std::endl;
    return 1;
  }

  catch( ... )
  {
    LOG << "ERROR! Unknown exception caught" << std::endl;
    return 1;
  }

  // Successful program termination
  return 0;

}

//-----------------------------------------------------------------------------
