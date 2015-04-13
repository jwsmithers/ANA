// $Id: DatabaseSvcFactory.cpp,v 1.11 2009-12-16 17:40:00 avalassi Exp $

// Include files
#include <memory>
#include "CoolApplication/Application.h"
#include "CoolApplication/DatabaseSvcFactory.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

IDatabaseSvc&
DatabaseSvcFactory::databaseService()
{
  /*
  static std::auto_ptr<Application> pApp;
  if ( ! pApp.get() ) {
    pApp.reset( new Application() );
  }
  return pApp->databaseService();
  *///
  static Application app;
  return app.databaseService();
}

//-----------------------------------------------------------------------------
