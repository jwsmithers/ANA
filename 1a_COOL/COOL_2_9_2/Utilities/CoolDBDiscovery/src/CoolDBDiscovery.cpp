// $Id: CoolDBDiscovery.cpp,v 1.10 2009-12-17 18:56:50 avalassi Exp $
// Include files

#include <iostream>
#include <memory>
#include <stdexcept>

#include "CoralBase/Exception.h"
#include "RelationalAccess/ConnectionService.h"
#include "RelationalAccess/ISessionProxy.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ITransaction.h"
#include "RelationalAccess/IConnectionServiceConfiguration.h"

//-----------------------------------------------------------------------------
// 2006-12-10 : Marco CLEMENCIC
//
// Small utility program to print the list of available databases in a given
// schema or coral DB alias.
//
//-----------------------------------------------------------------------------

using namespace coral;

/// Print usage message
void usage(char *name)
{
  std::cout << "Print the list of available databases in a given schema"
            << " or coral DB alias.\n" << std::endl;

  std::cout <<  "Usage: " << name
            << " [options] databaseId [databaseId2 ...]\n" << std::endl;
  //std::cout << "Options:\t -v      : increase verbosity" << std::endl;
  std::cout << "Options:\t -lfc    : use LFC Replica Service from CORAL" << std::endl;
  std::cout << "        \t -r role : CORAL role to use" << std::endl;
  std::cout << "        \t -h      : print this message and exit" << std::endl;
}

/// Main function
int main (int argc, char *argv[])
{
  //int verbosity = Msg::Error;
  bool useLFC  = false;
  std::set<std::string> dbIds;
  std::string role;

  // parse command line options
  for ( int i = 1 ; i < argc ; ++i ) {
    /* @TODO: (MCl) resurrect the '-v' option as soon as it becomes
     *        possible again to control the output level.
    if ( std::string("-v") == argv[i] ) {
      if ( verbosity > Msg::Verbose )
        --verbosity;
    }
    else */if ( std::string("-lfc") == argv[i] ) {
      useLFC = true;
    }
    else if ( std::string("-r") == argv[i] ) {
      role = argv[++i];
    }
    else if ( std::string("-h") == argv[i] ) {
      usage(argv[0]);
      return 0;
    }
    else {
      dbIds.insert(argv[i]);
    }
  }

  if ( dbIds.empty() ) {
    usage(argv[0]);
    return 1;
  }

  // Instantiate a new CORAL connection service (on the stack).
  coral::ConnectionService connSvc;

  coral::IConnectionServiceConfiguration &connSvcConf =
    connSvc.configuration();
  connSvcConf.disablePoolAutomaticCleanUp();
  connSvcConf.setConnectionTimeOut( 0 );

  if (useLFC) {
    // try to use CORAL LFCReplicaService
    connSvcConf.setAuthenticationService("CORAL/Services/LFCReplicaService");
    connSvcConf.setLookupService("CORAL/Services/LFCReplicaService");
  }

  try {
    std::set<std::string>::iterator dbId;

    // The DB main table is like '[A-Z_]{1,8}_DB_ATTRIBUTES'
    std::string control_table_name = "_DB_ATTRIBUTES";

    for ( dbId = dbIds.begin(); dbId != dbIds.end(); ++dbId ) {

      // Connect to database
      std::auto_ptr<ISessionProxy> session;
      if (role.empty()) {
        session = std::auto_ptr<ISessionProxy>(connSvc.connect(*dbId,ReadOnly));
        //std::auto_ptr<ISessionProxy> session(connSvc.connect(*dbId,Update));
      } else {
        session = std::auto_ptr<ISessionProxy>(connSvc.connect(*dbId,role,ReadOnly));
      }

      // Get the list of tables
      session->transaction().start(true);
      std::set<std::string> tables = session->nominalSchema().listTables();
      session->transaction().commit();

      // search for main table candidates
      for ( std::set<std::string>::iterator s = tables.begin() ; s != tables.end() ; ++s ) {
        if ( s->size() > control_table_name.size() &&
             s->size() <= ( control_table_name.size() + 8 ) ) {
          std::string::size_type pos = s->size()-control_table_name.size();
          if ( s->substr(pos) == control_table_name ) {
            // print out the guessed DB name
            std::cout << *dbId << "/" << s->substr(0,pos) << std::endl;
          }
        }
      }
    }

  }
  catch ( Exception& e ) {
    std::cerr << "Exception caught: " << e.what() << std::endl;
    return 1;
  }
  catch ( std::exception& e ) {
    std::cerr << "Exception caught: " << e.what() << std::endl;
    return 1;
  }
  catch ( ... ) {
    std::cerr << "Unknown exception caught" << std::endl;
    return 1;
  }

  return 0;
}

//=============================================================================
