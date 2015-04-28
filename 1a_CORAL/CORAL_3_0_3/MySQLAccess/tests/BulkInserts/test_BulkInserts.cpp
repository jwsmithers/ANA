#include <exception>
#include <iostream>
#include <sstream>
#include <stdexcept>
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"
#include "CoralBase/AttributeSpecification.h"
#include "CoralBase/Blob.h"
#include "CoralBase/Exception.h"
#include "RelationalAccess/IBulkOperation.h"
#include "RelationalAccess/ICursor.h"
#include "RelationalAccess/IQuery.h"
#include "RelationalAccess/ISchema.h"
#include "CoralCommon/ISession.h"
#include "RelationalAccess/ITable.h"
#include "RelationalAccess/ITableDataEditor.h"
#include "RelationalAccess/ITransaction.h"
#include "RelationalAccess/TableDescription.h"
#include "../Common/TestBase.h"


class BulkInsertApp : virtual public TestBase
{
public:
  BulkInsertApp( const std::string& connectionString, const std::string& userName, const std::string& password, coral::AccessMode=coral::Update );
  virtual ~BulkInsertApp();
  void run();
private:
  void fillData();
  void readData();
private:
  std::string m_connectionString;
  std::string m_userName;
  std::string m_password;
  coral::AccessMode m_accessMode;
};


BulkInsertApp::BulkInsertApp( const std::string& connectionString,
                              const std::string& userName, const std::string& password,
                              coral::AccessMode mode )
  : TestBase(),
    m_connectionString( connectionString ),
    m_userName( userName ),
    m_password( password ),
    m_accessMode( mode )
{
}


BulkInsertApp::~BulkInsertApp()
{
}


void BulkInsertApp::run()
{
  this->fillData();
  this->readData();
}


void
BulkInsertApp::fillData()
{
  coral::ISession* session = this->connect( m_connectionString, m_userName, m_password, m_accessMode );
  session->transaction().start();
  coral::ISchema& schema = session->nominalSchema();
  std::cout << "About to drop previous table" << std::endl;
  schema.dropIfExistsTable( "T" );
  std::cout << "Describing new table" << std::endl;
  coral::TableDescription description;
  description.setName( "T" );
  description.insertColumn( "ID",    coral::AttributeSpecification::typeNameForId( typeid(int)      ) ); description.setPrimaryKey( "ID" );
  description.insertColumn( "x",     coral::AttributeSpecification::typeNameForId( typeid(float)     ) ); description.setNotNullConstraint( "x" );
  description.insertColumn( "Y",     coral::AttributeSpecification::typeNameForId( typeid(double)    ) );
  description.insertColumn( "Z",     coral::AttributeSpecification::typeNameForId( typeid(double)    ) );
  description.insertColumn( "uc",    coral::AttributeSpecification::typeNameForId( typeid(unsigned char)    ) );
  description.insertColumn( "b",     coral::AttributeSpecification::typeNameForId( typeid(bool)    ) );
  description.insertColumn( "data1", coral::AttributeSpecification::typeNameForId( typeid(std::string) ), 100, false );
  description.insertColumn( "data2", coral::AttributeSpecification::typeNameForId( typeid(coral::Blob) ) );
  std::cout << "About to create the table" << std::endl;
  coral::ITable& table = schema.createTable( description );
  coral::AttributeList rowBuffer;
  table.dataEditor().rowBuffer( rowBuffer );
  coral::IBulkOperation* bulkInserter = table.dataEditor().bulkInsert( rowBuffer, 3 );
  for ( int i = 0; i < 5; ++i )
  {
    rowBuffer["ID"].data<int>() = i;
    rowBuffer["x"].data<float>() = (float)( i + 0.1 * i );
    rowBuffer["Y"].data<double>() = i + 0.01 * i;
    if ( i%2 == 1 ) rowBuffer["Y"].setNull( true );
    else rowBuffer["Y"].setNull( false );
    rowBuffer["Z"].data<double>() = i + 0.001 * i;
    rowBuffer["uc"].data<unsigned char>() = i * i;
    rowBuffer["b"].data<bool>() = (i%2 > 0);
    std::ostringstream os;
    os << "Data for " << i;
    rowBuffer["data1"].data<std::string>() = os.str();
    coral::Blob& blob = rowBuffer["data2"].data<coral::Blob>();
    int blobSize = ( i + 1 ) * 1000;
    blob.resize( blobSize );
    unsigned char* p = static_cast<unsigned char*>( blob.startingAddress() );
    for ( int j = 0; j < blobSize; ++j, ++p ) *p = j%256;
    if ( i%2 == 1 ) rowBuffer["data2"].setNull( true );
    else rowBuffer["data2"].setNull( false );
    bulkInserter->processNextIteration();
  }
  bulkInserter->flush();
  delete bulkInserter;
  session->transaction().commit();
  delete session;
}


void
BulkInsertApp::readData()
{
  coral::ISession* session = this->connect( m_connectionString, m_userName, m_password, m_accessMode );
  session->transaction().start( true );
  coral::ISchema& schema = session->nominalSchema();
  coral::IQuery* query = schema.tableHandle("T").newQuery();
  coral::ICursor& cursor = query->execute();
  int i = 0;
  while ( cursor.next() ) {
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
  delete session;
}


int main( int, char** )
{
  try
  {
    BulkInsertApp app( "mysql://pcitdb59.cern.ch/test", "rado_pool", "rado_pool", coral::Update );
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
