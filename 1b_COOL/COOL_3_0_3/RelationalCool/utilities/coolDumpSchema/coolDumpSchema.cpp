
// Include files
#include <algorithm>
#include <iostream>
#include "CoralBase/Exception.h"
#include "RelationalAccess/IColumn.h"
#include "RelationalAccess/IConnectionService.h"
#include "RelationalAccess/IConnectionServiceConfiguration.h"
#include "RelationalAccess/ISessionProxy.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ITable.h"
#include "RelationalAccess/ITableDescription.h"
#include "RelationalAccess/ITransaction.h"

// Local include files
#include "../../src/CoralApplication.h"
#include "../../src/CoralConnectionServiceProxy.h"
#include "../../src/RalSessionMgr.h"
#include "../../src/RelationalDatabaseId.h"

// Message output
#define LOG std::cout

int main( int argc, char** argv )
{
  try // Move everything inside try block to fix Coverity UNCAUGHT_EXCEPT
  {
    std::string dbId;
    if ( argc == 2 ) {
      dbId = argv[1];
    } else {
      LOG << "Usage: " << argv[0] << " dbId" << std:: endl;
      std::string dbId1 =
        "oracle://SERVER;schema=SCHEMA;user=USER;password=PSWD;dbname=DB";
      std::string dbId2 =
        "oracle://SERVER;schema=SCHEMA;dbname=DB";
      LOG << std::endl;
      LOG << "Example: " << argv[0] << " '" << dbId1 << "'\n"
          << "[Decode user and password from explicit credentials]"
          << std::endl;
      LOG << std::endl;
      LOG << "Example: " << argv[0] << " '" << dbId2 << "'\n"
          << "[Get user and password from authentication service]"
          << std::endl;
      return 1;
    }

    // Instantiate a COOL Application
    cool::CoralApplication app;

    // If we can access a LFC and the user is not explicitely forbidding it,
    // we try to use CORAL LFCReplicaService
    if ( ::getenv("COOL_IGNORE_LFC") == NULL &&
         ::getenv("LFC_HOST") != NULL ) {
      // try to load CORAL LFCReplicaService
      coral::IConnectionServiceConfiguration &connSvcConf =
        app.connectionSvc().configuration();
      connSvcConf.setAuthenticationService("CORAL/Services/LFCReplicaService");
      connSvcConf.setLookupService("CORAL/Services/LFCReplicaService");
    }

    cool::RelationalDatabaseId relationalDbId(dbId);
    std::string dbName = relationalDbId.dbName();

    LOG << "Dump COOL database schema \"" << relationalDbId.urlHidePswd() << "\"" << std::endl;

    const bool readOnly = true;
    cool::CoralConnectionServiceProxyPtr ppConnSvc
      ( new cool::CoralConnectionServiceProxy( &app.connectionSvc() ) );
    cool::RalSessionMgr rsm( ppConnSvc, dbId, readOnly );
    LOG << "Database technology: " << rsm.databaseTechnology() << std::endl;
    LOG << "Server version: " << rsm.serverVersion() << std::endl;
    LOG << "Start transaction." << std::endl;
    rsm.session().transaction().start();
    LOG << "Schema name: " << rsm.session().nominalSchema().schemaName() << std::endl;
    std::set<std::string> tableSet = rsm.session().nominalSchema().listTables();

    // need to copy this over as set sorting does not work
    std::vector<std::string> tables;
    for ( std::set<std::string>::const_iterator
            t = tableSet.begin(); t != tableSet.end(); ++t ) {
      tables.push_back( *t );
    }
    sort( tables.begin(), tables.end() );

    std::string signature = dbName + "_";
    for ( std::vector<std::string>::const_iterator
            t = tables.begin(); t != tables.end(); ++t ) {
      if ( t->find(signature) == 0 ) { // table name starts with dbName + "_"
        LOG << "------------------------------------------------" << std::endl;
        LOG << "Table " << *t << std::endl;
        LOG << "------------------------------------------------" << std::endl;
        coral::ITable& table( rsm.session().nominalSchema().tableHandle( *t ) );
        const coral::ITableDescription& tableDescription( table.description() );
        std::vector<std::string> colNames;
        for ( int i = 0; i < tableDescription.numberOfColumns(); ++i ) {
          const coral::IColumn& col( tableDescription.columnDescription( i ) );
          colNames.push_back( col.name() );
        }
        sort( colNames.begin(), colNames.end() );
        for ( std::vector<std::string>::const_iterator
                n = colNames.begin(); n != colNames.end(); ++n ) {
          const coral::IColumn& col( tableDescription.columnDescription( *n ) );
          LOG << col.name() << "\t" << col.type() << "\t" << col.size()
              << std::endl;
        }
      }
    }
    rsm.session().transaction().commit();
    LOG << "Commit transaction." << std::endl;
    ppConnSvc->purgeConnectionPool();
    ppConnSvc->resetICS();
    return 0;
  }
  catch ( coral::Exception& e )
  {
    std::cerr << "CORAL Exception : " << e.what() << std::endl;
    return 1;
  }
  catch ( std::exception& e )
  {
    std::cerr << "C++ Exception : " << e.what() << std::endl;
    return 1;
  }
  catch ( ... )
  {
    std::cerr << "Unhandled exception " << std::endl;
    return 1;
  }
}
