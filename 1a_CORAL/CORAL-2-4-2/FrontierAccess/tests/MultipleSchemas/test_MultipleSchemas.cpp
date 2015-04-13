#include <iostream>
#include <exception>
#include <memory>
#include <stdexcept>
#include "CoralBase/Exception.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ISession.h"
#include "RelationalAccess/ITransaction.h"
#include "RelationalAccess/ITypeConverter.h"
#include "RelationalAccess/SessionException.h"
#include "../Common/TestBase.h"


class MultipleSchemasApp : virtual public TestBase
{
public:
  MultipleSchemasApp( const std::string& connectionString,
                      const std::string& userName,
                      const std::string& password,
                      const std::string& otherSchema );
  virtual ~MultipleSchemasApp();
  void run();
private:
  std::string m_connectionString;
  std::string m_userName;
  std::string m_password;
  std::string m_otherSchema;
};


MultipleSchemasApp::MultipleSchemasApp( const std::string& connectionString,
                                        const std::string& userName,
                                        const std::string& password,
                                        const std::string& otherSchema ) :
  TestBase(),
  m_connectionString( connectionString ),
  m_userName( userName ),
  m_password( password ),
  m_otherSchema( otherSchema )
{
}


MultipleSchemasApp::~MultipleSchemasApp()
{
}


void
MultipleSchemasApp::run()
{
  std::auto_ptr< coral::ISession> session( this->connect( m_connectionString, m_userName, m_password ) );
  if ( ! session->isUserSessionActive() )
  {
    throw std::runtime_error( "Session not valid..." );
  }
  session->transaction().start( true );
  std::cout << "Tables in the nominal schema:" << std::endl;
  std::set< std::string > listOfTables = session->nominalSchema().listTables();
  for ( std::set< std::string >::const_iterator iTable = listOfTables.begin();
        iTable != listOfTables.end(); ++iTable ) std::cout << *iTable << std::endl;
  std::cout << "Tables in the other schema:" << std::endl;
  listOfTables = session->schema( m_otherSchema ).listTables();
  for ( std::set< std::string >::const_iterator iTable = listOfTables.begin();
        iTable != listOfTables.end(); ++iTable ) std::cout << *iTable << std::endl;
  std::cout << "Attempting to catch a specific exception for accessing an unknown schema" << std::endl;
  try {
    session->schema( m_otherSchema + "X" );
  }
  catch ( coral::InvalidSchemaNameException& ) {}
  std::cout << "Exception caught." << std::endl;
}


int main( int, char** )
{
  try
  {
    MultipleSchemasApp app( "frontier://lxfs6043.cern.ch:8080/Frontier3D)", "CORAL", "Frontier24", "RADOVAN" );
    app.run();
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
  catch (...)
  {
    std::cerr << "Unknown exception ..." << std::endl;
    return 1;
  }
  std::cout << "[OVAL] Success" << std::endl;
  return 0;
}
