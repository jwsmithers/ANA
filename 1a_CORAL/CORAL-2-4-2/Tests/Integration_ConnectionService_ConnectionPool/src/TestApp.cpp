#include "TestApp.h"
#include <stdexcept>
#include "RelationalAccess/ISession.h"
#include "RelationalAccess/ITable.h"
#include "RelationalAccess/TableDescription.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ITransaction.h"
#include "CoralBase/Exception.h"
#include "CoralBase/AttributeSpecification.h"
#include "RelationalAccess/ISession.h"
#include "RelationalAccess/ISessionProxy.h"
#include "RelationalAccess/IConnectionService.h"
#include "RelationalAccess/IConnectionServiceConfiguration.h"
#include "../../ConnectionService/src/ConnectionService.h"
#include "../../ConnectionService/src/SessionProxy.h"
#include "../../ConnectionService/src/ConnectionPool.h"
#include <iostream>
#include "CoralCommon/Utilities.h"

const std::string TestApp::OVALTAG = "[OVAL]";

TestApp::TestApp(const char * testName) : TestEnv(testName)
{
  addTablePrefix(T1, "T1");
}


TestApp::~TestApp()
{
}

//
void TestApp::setupDataSource( const std::string& connectionString){
  coral::IConnectionService& theConnectionService = sw.getConnectionService();

  coral::ISessionProxy* session = theConnectionService.connect( connectionString );
  session->transaction().start();
  // creates a dummy table to be looked up
  session->nominalSchema().dropIfExistsTable( T1 );
  coral::TableDescription descr;
  descr.setName( T1 );
  descr.insertColumn("N_X",coral::AttributeSpecification::typeNameForType<int>());
  descr.insertColumn("N_S",coral::AttributeSpecification::typeNameForType<std::string>());
  session->nominalSchema().createTable( descr );
  session->transaction().commit();
  delete session;
  coral::sleepSeconds( 1 );
}

void
TestApp::run(){

  setupDataSource(getServiceName(0));

  coral::IConnectionService& theConnectionService = sw.getConnectionService();

  try {
    theConnectionService.configuration().setConnectionTimeOut(10);
    std::cout << "Getting the first sessionProxy object "<<std::endl;
    std::string connectionString(getServiceName(1));
    coral::ISessionProxy* session1 = theConnectionService.connect( connectionString );
    session1->transaction().start( true );
    std::set<std::string> tables = session1->nominalSchema().listTables();
    session1->transaction().commit();
    if(tables.find( T1 )==tables.end()) {
      std::cout << OVALTAG <<"TEST ERROR with connection "<<connectionString<<" table " << T1 << " is not found."<<std::endl;
    } else {
      std::cout << OVALTAG << "Connection "<<connectionString<<" was ok."<<std::endl;
    }
    coral::ConnectionService::ConnectionService& myService = dynamic_cast<coral::ConnectionService::ConnectionService&>(theConnectionService);
    std::cout << "-------------------------(1)"<<std::endl;
    std::cout << OVALTAG <<"Number of idle connection:"<< myService.numberOfIdleConnectionsInPool()<<std::endl;
    std::cout << OVALTAG <<"Number of active connection:"<< myService.numberOfActiveConnectionsInPool()<<std::endl;
    delete session1;
    std::cout << "--------------------------(2)"<<std::endl;
    std::cout << OVALTAG <<"Number of idle connection:"<< myService.numberOfIdleConnectionsInPool()<<std::endl;
    std::cout << OVALTAG <<"Number of active connection:"<< myService.numberOfActiveConnectionsInPool()<<std::endl;
    coral::ISessionProxy* session2 = theConnectionService.connect( connectionString );
    std::cout << "--------------------------(3)"<<std::endl;
    std::cout << OVALTAG <<"Number of idle connection:"<< myService.numberOfIdleConnectionsInPool()<<std::endl;
    std::cout << OVALTAG <<"Number of active connection:"<< myService.numberOfActiveConnectionsInPool()<<std::endl;
    coral::ISessionProxy* session3 = theConnectionService.connect( connectionString );
    std::cout << "--------------------------(4)"<<std::endl;
    std::cout << OVALTAG <<"Number of idle connection:"<< myService.numberOfIdleConnectionsInPool()<<std::endl;
    std::cout << OVALTAG <<"Number of active connection:"<< myService.numberOfActiveConnectionsInPool()<<std::endl;
    coral::ISessionProxy* session4 = theConnectionService.connect( connectionString, coral::ReadOnly );
    std::cout << "--------------------------(5)"<<std::endl;
    std::cout << OVALTAG <<"Number of idle connection:"<< myService.numberOfIdleConnectionsInPool()<<std::endl;
    std::cout << OVALTAG <<"Number of active connection:"<< myService.numberOfActiveConnectionsInPool()<<std::endl;
    session4->transaction().start( true );
    tables = session4->nominalSchema().listTables();
    session4->transaction().commit();
    if(tables.find( T1 )==tables.end()) {
      std::cout << OVALTAG <<"TEST ERROR with connection "<<connectionString<<" table " << T1 << " is not found."<<std::endl;
    } else {
      std::cout << OVALTAG << "Connection "<<connectionString<<" was ok."<<std::endl;
    }
    delete session2;
    coral::ISessionProxy* session5 = theConnectionService.connect( connectionString, coral::ReadOnly );
    std::cout << "--------------------------(6)"<<std::endl;
    std::cout << OVALTAG <<"Number of idle connection:"<< myService.numberOfIdleConnectionsInPool()<<std::endl;
    std::cout << OVALTAG <<"Number of active connection:"<< myService.numberOfActiveConnectionsInPool()<<std::endl;
    session5->transaction().start( true );
    tables = session5->nominalSchema().listTables();
    session5->transaction().commit();
    if(tables.find( T1 )==tables.end()) {
      std::cout << OVALTAG <<"TEST ERROR with connection "<<connectionString<<" table " << T1 << " is not found."<<std::endl;
    } else {
      std::cout << OVALTAG << "Connection "<<connectionString<<" was ok."<<std::endl;
    }
    delete session3;
    delete session4;
    delete session5;
    std::cout << "--------------------------(7)"<<std::endl;
    std::cout << OVALTAG <<"Number of idle connection:"<< myService.numberOfIdleConnectionsInPool()<<std::endl;
    std::cout << OVALTAG <<"Number of active connection:"<< myService.numberOfActiveConnectionsInPool()<<std::endl;
    coral::sleepSeconds(20);
    theConnectionService.purgeConnectionPool();
    std::cout << "--------------------------(7-bis)"<<std::endl;
    std::cout << OVALTAG <<"Number of idle connection:"<< myService.numberOfIdleConnectionsInPool()<<std::endl;
    std::cout << OVALTAG <<"Number of active connection:"<< myService.numberOfActiveConnectionsInPool()<<std::endl;

  }catch ( const coral::Exception& exc) {
    std::cout << "TEST ERROR: "<<exc.what()<<std::endl;
  }


}
