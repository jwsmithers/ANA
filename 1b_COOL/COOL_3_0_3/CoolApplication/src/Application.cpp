
// Include files
//#include <iostream>
#include "CoolApplication/Application.h"
#include "../RelationalCool/src/CoralApplication.h"

// Namespace
using namespace cool;

// Message output
//#define COUT std::cout << "__cool::Application "
//#define ENDL std::endl

//-----------------------------------------------------------------------------

Application::Application( coral::IConnectionService* connSvc )
{
  //COUT << "Application(): ** START **" << std::endl;
  m_application = new CoralApplication( connSvc );
  //COUT << "Application(): *** END ***" << ENDL;
}

//-----------------------------------------------------------------------------

Application::~Application()
{
  //COUT << "~Application(): ** START **" << ENDL;
  delete m_application;
  //COUT << "~Application(): *** END ***" << ENDL;
}

//-----------------------------------------------------------------------------
