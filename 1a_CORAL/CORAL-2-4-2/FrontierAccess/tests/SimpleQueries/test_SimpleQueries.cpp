#include <iostream>
#include <memory>
#include <stdexcept>
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"
#include "CoralBase/AttributeSpecification.h"
#include "CoralBase/Blob.h"
#include "CoralBase/Exception.h"
#include "CoralCommon/Utilities.h"
#include "RelationalAccess/IConnectionService.h"
#include "RelationalAccess/ICursor.h"
#include "RelationalAccess/IQuery.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ISessionProxy.h"
#include "RelationalAccess/ITable.h"
#include "RelationalAccess/ITableDataEditor.h"
#include "RelationalAccess/ITablePrivilegeManager.h"
#include "RelationalAccess/ITransaction.h"
#include "RelationalAccess/TableDescription.h"
#include "../Common/TestBase.h"


class QueriesApp : virtual public TestBase
{
public:
  QueriesApp( const std::string& connectionString1, const std::string& connectionString2, const std::string& userName, const std::string& password );
  virtual ~QueriesApp();
  void run();
private:
  void fillData();
  void readData();
private:
  std::string m_connectionString1;
  std::string m_connectionString2;
  std::string m_userName;
  std::string m_password;
};


QueriesApp::QueriesApp( const std::string& connectionString1,
                        const std::string& connectionString2,
                        const std::string& userName,
                        const std::string& password )
  : TestBase(),
    m_connectionString1( connectionString1 ),
    m_connectionString2( connectionString2 ),
    m_userName( userName ), m_password( password )
{
}


QueriesApp::~QueriesApp()
{
}


void QueriesApp::run()
{
  this->fillData();
  coral::sleepSeconds(1);
  this->readData();
}


void QueriesApp::fillData()
{
  try
  {
    std::auto_ptr<coral::ISessionProxy> session( connectionService()->connect( m_connectionString1 ) );
    session->transaction().start();
    coral::ISchema& schema = session->nominalSchema();
    std::cout << "About to drop previous table" << std::endl;
    schema.dropIfExistsTable( "T" );
    std::cout << "Describing new table" << std::endl;
    coral::TableDescription description;
    description.setName( "T" );
    description.insertColumn( "ID",
                              coral::AttributeSpecification::typeNameForId( typeid(int) ) );
    description.setPrimaryKey( "ID" );
    description.insertColumn( "x",
                              coral::AttributeSpecification::typeNameForId( typeid(float) ) );
    description.setNotNullConstraint( "x" );
    description.insertColumn( "Y",
                              coral::AttributeSpecification::typeNameForId( typeid(double) ) );
    description.insertColumn( "Z",
                              coral::AttributeSpecification::typeNameForId( typeid(double) ) );
    description.insertColumn( "data1",
                              coral::AttributeSpecification::typeNameForId( typeid(std::string) ),
                              100,
                              false );
    description.insertColumn( "data2",
                              coral::AttributeSpecification::typeNameForId( typeid(coral::Blob) ) );
    std::cout << "About to create the table" << std::endl;
    coral::ITable& table = schema.createTable( description );
    table.privilegeManager().grantToPublic( coral::ITablePrivilegeManager::Select ); // DON'T FORGET THIS FOR FRONTIER!!!!!
    coral::AttributeList rowBuffer;
    table.dataEditor().rowBuffer( rowBuffer );
    for ( int i = 0; i < 5; ++i )
    {
      rowBuffer["ID"].data<int>() = i;
      rowBuffer["x"].data<float>() = i + 0.1 * i;
      rowBuffer["Y"].data<double>() = i + 0.01 * i;
      if ( i%2 == 1 ) rowBuffer["Y"].setNull( true );
      else rowBuffer["Y"].setNull( false );
      rowBuffer["Z"].data<double>() = i + 0.001 * i;
      rowBuffer["data1"].data<std::string>() = "Data";
      coral::Blob& blob = rowBuffer["data2"].data<coral::Blob>();
      int blobSize = ( i + 1 ) * 1000;
      blob.resize( blobSize );
      unsigned char* p = static_cast<unsigned char*>( blob.startingAddress() );
      for ( int j = 0; j < blobSize; ++j, ++p ) *p = j%256;
      if ( i%2 == 1 ) rowBuffer["data2"].setNull( true );
      else rowBuffer["data2"].setNull( false );
      table.dataEditor().insertRow( rowBuffer );
    }
    session->transaction().commit();
  }
  catch( const std::exception& e )
  {
    std::cerr << "Problem filling data: " << e.what() << std::endl;
    throw;
  }
  //  delete session;
}

void QueriesApp::readData()
{
  try
  {
    std::auto_ptr<coral::ISessionProxy> session( connectionService()->connect( m_connectionString2, coral::ReadOnly ) );
    session->transaction().start( true );
    coral::ISchema& schema = session->nominalSchema();
    coral::ITable& table   = schema.tableHandle("T");
    coral::IQuery* query   = table.newQuery();
    coral::ICursor& cursor = query->execute();
    int i = 0;
    while ( cursor.next() )
    {
      const coral::AttributeList& currentRow = cursor.currentRow();
      currentRow.toOutputStream( std::cout ) << std::endl;
      const coral::Attribute& blobAttribute = currentRow["data2"];
      if ( ! blobAttribute.isNull() ) {
        const coral::Blob& blob = blobAttribute.data<coral::Blob>();
        long blobSize = ( i + 1 ) * 1000;
        if ( blob.size() != blobSize )
          throw std::runtime_error( "Unexpected blob size" );
        const unsigned char* p = static_cast<const unsigned char*>( blob.startingAddress() );
        for ( long j = 0; j < blobSize; ++j, ++p )
          if( *p != j%256 )
            throw std::runtime_error( "Unexpected blob data" );
      }
      ++i;
    }
    if ( i != 5 )
      throw std::runtime_error( "Unexpected number of rows" );
    delete query;
    session->transaction().commit();
  }
  catch( const std::exception& e )
  {
    std::cerr << "Problem reading data: " << e.what() << std::endl;
    throw;
  }
  //  delete session;
}

int main( int, char** )
{
  try {
    //QueriesApp app( "oracle://cms_val_lb/CORAL", "frontier://lxfs6043.cern.ch:8080/Frontier3D/CORAL", "CORAL", "Frontier24" );
    //QueriesApp app( "oracle://bd3d/RADOVAN", "frontier://frontier3d.cern.ch:8080/Frontier/RADOVAN", "radovan", "radovan" );
    //QueriesApp app( "/dbdev/Frontier3DUpdate", "/dbdev/Frontier3DRead", "radovan", "radovan" );
    QueriesApp app( "/dbdev/Frontier3D", "/dbdev/Frontier3DRead", "radovan", "radovan" );
    app.run();
  }
  catch ( const coral::Exception& e ) {
    std::cerr << "CORAL Exception : " << e.what() << std::endl;
    return 1;
  }
  catch ( const std::exception& e ) {
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
