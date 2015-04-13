#include <cstdlib>
#include <memory>
#include <iostream>
#include <string>
#include <sstream>
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"
#include "CoralBase/Exception.h"
#include "CoralBase/TimeStamp.h"
#include "CoralBase/../tests/Common/CoralCppUnitDBTest.h"
#include "CoralCommon/Utilities.h"
#include "CoralKernel/Context.h"
#include "RelationalAccess/AccessMode.h"
#include "RelationalAccess/ConnectionService.h"
#include "RelationalAccess/ConnectionServiceException.h"
#include "RelationalAccess/IAuthenticationCredentials.h"
#include "RelationalAccess/IAuthenticationService.h"
#include "RelationalAccess/IConnection.h"
#include "RelationalAccess/IConnectionServiceConfiguration.h"
#include "RelationalAccess/IDatabaseServiceDescription.h"
#include "RelationalAccess/IDatabaseServiceSet.h"
#include "RelationalAccess/ILookupService.h"
#include "RelationalAccess/IRelationalDomain.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ISession.h"
#include "RelationalAccess/ISessionProxy.h"
#include "RelationalAccess/ITable.h"
#include "RelationalAccess/ITransaction.h"
#include "RelationalAccess/IView.h"
#include "RelationalAccess/IViewFactory.h"
#include "RelationalAccess/RelationalServiceException.h"
#include "RelationalAccess/TableDescription.h"

namespace coral
{
  class AliasesSynonymsTest;
}

//----------------------------------------------------------------------------

class coral::AliasesSynonymsTest : public coral::CoralCppUnitDBTest
{
  CPPUNIT_TEST_SUITE( AliasesSynonymsTest );
  CPPUNIT_TEST( test_synonyms );
  CPPUNIT_TEST_SUITE_END();

public:

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_synonyms()
  {

    //The string for the table name is created coding the input of the
    // slot and platform name
    std::string T1 = BuildUniqueTableName( "SYN_T1" );

    // Get the credential for the UPDATE connection
    std::auto_ptr<coral::IDatabaseServiceSet> dbSet; // fix 2nd memory leak buh #100600
    coral::Context& context = coral::Context::instance();
    context.loadComponent( "CORAL/Services/XMLLookupService" );
    coral::IHandle<coral::ILookupService> lookupSvc = context.query<coral::ILookupService>( "CORAL/Services/XMLLookupService" );
    if ( ! lookupSvc.isValid() )
      throw std::runtime_error( "Can't load Lookup Service" );
    context.loadComponent( "CORAL/Services/XMLAuthenticationService" );
    coral::IHandle<coral::IAuthenticationService> authSvc =
      context.query<coral::IAuthenticationService>(  "CORAL/Services/XMLAuthenticationService" );
    if ( ! authSvc.isValid() )
      throw std::runtime_error( "Can't load Authentication Service" );
    dbSet.reset( lookupSvc->lookup( UrlRW() ) ); // fix bug #100760
    if( dbSet->numberOfReplicas() == 0 )
      throw std::runtime_error( "No replicas found" );
    const coral::IDatabaseServiceDescription& svdesc = dbSet->replica( 0 );
    const coral::IAuthenticationCredentials& creds = authSvc->credentials( svdesc.connectionString() );

    //=================================================================
    //
    // CREATION OF TABLE SECTION
    //
    //=================================================================

    coral::IConnection* connection = NULL;
    coral::ISession* session = NULL;
    {
      // Get session as previously in getSession()
      {
        // Load the oracle component
        context.loadComponent( "CORAL/RelationalPlugins/oracle" );
        coral::IHandle<coral::IRelationalDomain> iHandle =
          context.query<coral::IRelationalDomain>( "CORAL/RelationalPlugins/oracle" );
        if ( ! iHandle.isValid() )
        {
          throw coral::NonExistingDomainException( "oracle" );
        }
        std::pair<std::string, std::string> connectionAndSchema =
          iHandle->decodeUserConnectionString( svdesc.connectionString() );
        connection = iHandle->newConnection( connectionAndSchema.first );
        if ( ! connection->isConnected() )
          connection->connect();
        session = connection->newSession( connectionAndSchema.second );
        if ( session )
          session->startUserSession( creds.valueForItem( creds.userItem() ),
                                     creds.valueForItem( creds.passwordItem() ) );
        else
        {
          throw std::runtime_error( "Could not get a session" );
        }
      }
      session->transaction().start();
      coral::ISchema& schema = session->nominalSchema();
      //Create a new table with the selected name if it does not exist
      if( !schema.existsTable(T1) )
      {
        std::cout << "Table " << T1 << " was not created!!" << std::endl;
        coral::TableDescription description1( "Synonyms_Test" );
        description1.setName(T1);
        description1.insertColumn( "id", coral::AttributeSpecification::typeNameForId( typeid(long) ) );
        schema.createTable( description1 );
        coral::sleepSeconds( 1 );
      }
      session->transaction().commit();
    }

    //=================================================================
    //
    // CREATION SYNONYM SECTION
    //
    //=================================================================

    //Create strings for SYNONYM, SQL COMMAND, SQLPLUS CONNECTION STRING
    std::stringstream synonym;
    synonym<<"SYNONYM_OF_"<<T1;

    //Create string for the sql command
    std::stringstream cmd;
    cmd << "sqlplus -L -S "
        <<creds.valueForItem( creds.userItem() )<<"/"
        <<creds.valueForItem( creds.passwordItem() )
        << "@lcg_coral_nightly <<ENDOFSQL \n"
        << "create or replace synonym "
        << synonym.str() << " for "
        << creds.valueForItem( creds.userItem() )<< "." << T1 << "; \n"
        << "exit; \n"
        << "ENDOFSQL";

    //Execute the SQLPLUS command and create SYNONYM of the table
    system(cmd.str().c_str());

    //=================================================================
    //
    // TEST TABLE SYNONYM SECTION
    //
    //=================================================================

    {
      session->transaction().start();
      coral::ISchema& schema = session->nominalSchema();
      //Check if the TABLE and SYNONYM were properly created
      if( !schema.existsTable(T1) )
        throw std::runtime_error( "Table T1 does not exist" );
      if( !schema.existsTable(synonym.str()) )
        throw std::runtime_error( "Synonym does not exist or does not point to a existing table" );
      //Drop the table and the synonym if they exist
      schema.dropIfExistsTable( T1 );
      //If the drop of the synonym is executed, it does not work.
      //No error message appears for the method dropIfExistsTable or dropTable
      //but they results ineffective. This could be a BUG!!!!
      //if( schema.existsTable(synonym.str()) )
      //schema.dropTable( synonym.str() );
      session->transaction().commit();
      delete session;
      delete connection; // fix 1st memory leak bug #100600
    }

    //Create string for the sql command to drop SYNONYM
    std::stringstream cmd1;
    cmd1 << "sqlplus -L -S "
         <<creds.valueForItem( creds.userItem() )<<"/"
         <<creds.valueForItem( creds.passwordItem() )
         << "@lcg_coral_nightly <<ENDOFSQL \n"
         << "drop synonym " << synonym.str() << "; \n"
         << "exit; \n"
         << "ENDOFSQL";

    //Execute the SQLPLUS command and create SYNONYM of the table
    system(cmd1.str().c_str());
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  AliasesSynonymsTest(){}
  ~AliasesSynonymsTest(){}

};

CPPUNIT_TEST_SUITE_REGISTRATION( coral::AliasesSynonymsTest );

//----------------------------------------------------------------------------

CORALCPPUNITTEST_MAIN( AliasesSynonymsTest )
