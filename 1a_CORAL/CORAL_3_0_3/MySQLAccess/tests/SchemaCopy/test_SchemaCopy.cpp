#include <iostream>
#include <exception>
#include <list>
#include <map>
#include <set>
#include <stdexcept>
#include "CoralBase/AttributeSpecification.h"
#include "CoralBase/Blob.h"
#include "CoralBase/Date.h"
#include "CoralBase/Exception.h"
#include "RelationalAccess/IColumn.h"
#include "RelationalAccess/IForeignKey.h"
#include "RelationalAccess/IIndex.h"
#include "RelationalAccess/IPrimaryKey.h"
#include "RelationalAccess/ISchema.h"
#include "CoralCommon/ISession.h"
#include "RelationalAccess/ITable.h"
#include "RelationalAccess/ITableDescription.h"
#include "RelationalAccess/ITablePrivilegeManager.h"
#include "RelationalAccess/ITransaction.h"
#include "RelationalAccess/SchemaException.h"
#include "RelationalAccess/TableDescription.h"
#include "../Common/TestBase.h"


class SchemaCopyApp : virtual public TestBase
{
public:
  struct TabDesc
  {
  public:
    TabDesc( const std::string& name, const coral::ITableDescription& tabdesc )
      : m_name( name )
      , m_desc( tabdesc )
    {
    }
    std::string m_name;
    const coral::ITableDescription& m_desc;
  };
public:
  SchemaCopyApp( const std::string& connectionString,
                 const std::string& source,
                 const std::string& dest,
                 const std::string& userName,
                 const std::string& password );
  virtual ~SchemaCopyApp();
  void readDbObjects();
  void cpDbObjects();
  void run();
private:
  // Connection params
  std::string m_connectionString;
  std::string m_source;
  std::string m_dest;
  std::string m_userName;
  std::string m_password;
  // Schema objects
  std::list<TabDesc> m_tables;
  // Schema copy session
  coral::ISession* m_session;
};


SchemaCopyApp::SchemaCopyApp( const std::string& connectionString,
                              const std::string& source,
                              const std::string& dest,
                              const std::string& userName,
                              const std::string& password )
  : TestBase()
  , m_connectionString( connectionString )
  , m_source( source )
  , m_dest( dest )
  , m_userName( userName )
  , m_password( password )
  , m_session( 0 ) // Fix Coverity UNINIT_CTOR
{
}


SchemaCopyApp::~SchemaCopyApp()
{
  if( this->m_session != 0 )
  {
    delete this->m_session;
    this->m_session = 0;
  }
}


void SchemaCopyApp::readDbObjects()
{
  m_session = this->connect( m_connectionString + "/" + m_source, m_userName, m_password, coral::ReadOnly );
  m_session->transaction().start();
  coral::ISchema& schema = m_session->nominalSchema();
  // Read the source schema objects
  std::set<std::string> tableList = schema.listTables();
  if( tableList.empty() )
  {
    std::cout << "Source schema " << m_connectionString << "/" << m_source << " has no database objects..." << std::endl;
    return;
  }
  for( std::set<std::string>::iterator sit = tableList.begin(); sit != tableList.end(); ++sit )
  {
    m_tables.push_back( TabDesc( (*sit) , schema.tableHandle(*sit).description() ) );
    std::cout << "Reading \"" << schema.tableHandle(*sit).description().name() << "\"(" << (*sit) << ") table description from schema " << m_source << std::endl;
  }
  m_session->transaction().commit();
}


void SchemaCopyApp::cpDbObjects()
{
  coral::ISession* session = this->connect( m_connectionString + "/" + m_dest, m_userName, m_password, coral::Update );
  session->transaction().start();
  try
  {
    coral::ISchema& schema = session->nominalSchema();
    for( std::list<TabDesc>::iterator sit = m_tables.begin(); sit != m_tables.end(); ++sit )
    {
      std::cout << "Copying table database object \""  << (*sit).m_desc.name() << "\" to schema \"" << m_dest << std::endl;
      const coral::ITableDescription& tdesc = (*sit).m_desc;
      // List of all indices read from the source
      std::cout << "Table " << tdesc.name() << " has the fillowing indices: " << std::endl;
      int numIdx = tdesc.numberOfIndices();
      for( int i = 0; i < numIdx; i++ )
      {
        std::cout << tdesc.index(i).name() << std::endl;
      }
      schema.createTable( tdesc );
      std::cout << "Table " << tdesc.name() << " created................................" << std::endl;
    }
    session->transaction().commit();
    session->transaction().start();
    std::set<std::string> tableList = schema.listTables();
    if( tableList.size() != m_tables.size() )
    {
      session->transaction().rollback();
      throw coral::SchemaException( "Could not copy table database objects from schema " + m_source + " to schema " + m_dest, "SchemaCopyApp", "copyDbObjects" );
    }
    session->transaction().commit();
  }
  catch(const std::exception& e )
  {
    std::cerr << "Caught exception: " << e.what() << std::endl;
    throw;
  }
  delete session;
}


void SchemaCopyApp::run()
{
  this->readDbObjects();
  this->cpDbObjects();
}


int main( int, char** )
{
  try {
    SchemaCopyApp app( "mysql://itrac424.cern.ch", "RADO_POOL", "test", "rado_pool", "rado_pool" );
    //SchemaCopyApp app( "mysql://pcitdb59.cern.ch", "Schema_A", "Schema_B", "rado_pool", "rado_pool" );
    //SchemaCopyApp app( "mysql://pcitdb29.cern.ch/rado_pool", "rado_pool", "rado_pool" );
    app.run();
  }
  catch ( coral::Exception& e ) {
    std::cerr << "CORAL Exception : " << e.what() << std::endl;
    return 1;
  }
  catch ( std::exception& e ) {
    std::cerr << "C++ Exception : " << e.what() << std::endl;
    return 1;
  }
  catch (...) {
    std::cerr << "Unknown exception ..." << std::endl;
    return 1;
  }
  std::cout << "[OVAL] Success" << std::endl;
  return 0;
}
