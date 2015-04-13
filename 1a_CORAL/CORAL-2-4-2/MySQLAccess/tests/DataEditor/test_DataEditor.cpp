#include <iostream>
#include <exception>
#include <stdexcept>
#include <sstream>
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"
#include "CoralBase/AttributeSpecification.h"
#include "CoralBase/Exception.h"
#include "RelationalAccess/ICursor.h"
#include "RelationalAccess/IQuery.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ISession.h"
#include "RelationalAccess/ITable.h"
#include "RelationalAccess/ITableDataEditor.h"
#include "RelationalAccess/ITransaction.h"
#include "RelationalAccess/SchemaException.h"
#include "RelationalAccess/TableDescription.h"
#include "../Common/TestBase.h"


class DmlApp : virtual public TestBase
{
public:
  DmlApp( const std::string& connectionString,
          const std::string& userName,
          const std::string& password );
  virtual ~DmlApp();
  void run();
private:
  std::string m_connectionString;
  std::string m_userName;
  std::string m_password;
};


DmlApp::DmlApp( const std::string& connectionString,
                const std::string& userName,
                const std::string& password ) :
  TestBase(),
  m_connectionString( connectionString ),
  m_userName( userName ),
  m_password( password )
{
}


DmlApp::~DmlApp()
{
}


void
DmlApp::run()
{
  coral::ISession* session = this->connect( m_connectionString, m_userName, m_password, coral::Update );
  session->transaction().start();
  coral::ISchema& schema = session->nominalSchema();
  std::cout << "About to drop previous table" << std::endl;
  schema.dropIfExistsTable( "T_1" );
  std::cout << "Describing new tables" << std::endl;
  coral::TableDescription description;
  description.setName( "T_1" );
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
  description.insertColumn( "b",
                            coral::AttributeSpecification::typeNameForId( typeid(bool) ) );
  description.insertColumn( "data0",
                            coral::AttributeSpecification::typeNameForId( typeid(std::string) ) );
  description.insertColumn( "data1",
                            coral::AttributeSpecification::typeNameForId( typeid(std::string) ),
                            2,
                            true );
  description.insertColumn( "data2",
                            coral::AttributeSpecification::typeNameForId( typeid(std::string) ),
                            321,
                            false );
  std::cout << "About to create the tables" << std::endl;
  coral::ITableDataEditor& editor = schema.createTable( description ).dataEditor();
  coral::AttributeList rowBuffer;
  editor.rowBuffer( rowBuffer );
  for ( int i = 0; i < 10; ++i ) {
    rowBuffer["ID"].data<int>() = i; // Original value is int but this issue hits all CORAL back-ends
    rowBuffer["x"].data<float>() = (float)( i + 0.01*i );
    rowBuffer["Y"].data<double>() = i + 0.001*i;
    rowBuffer["Z"].data<double>() = i + 0.0001*i;
    rowBuffer["b"].data<bool>() = ( i%2 > 0 );
    std::string dstr;
    // 'after 'Object 2''
    std::ostringstream os0; os0 << "The data0 is '" << i << "'"; dstr = os0.str();
    rowBuffer["data0"].setValueFromAddress(&dstr);
    std::ostringstream os1; os1 << i; dstr = os1.str();
    rowBuffer["data1"].setValueFromAddress(&dstr);
    std::string vls = "This is a very looooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong string to be stored";
    std::ostringstream os2; os2 << "Hello we test storing CLOB here up to the maximum limit, so ..................................... " << 1000000000*(i-1) + i << ">>>>>" << vls << "<<<<<"; dstr = os2.str();
    rowBuffer["data2"].setValueFromAddress(&dstr);
    if ( i%3 == 1 ) {
      rowBuffer["Y"].setNull();
    }
    else {
      rowBuffer["Y"].setNull( false );
    }
    editor.insertRow( rowBuffer );
  }
  // Now try to insert a duplicate entry
  bool exceptionCaught = false;
  try {
    editor.insertRow( rowBuffer );
  }
  catch ( coral::DuplicateEntryInUniqueKeyException& ) {
    exceptionCaught = true;
  }
  if ( ! exceptionCaught )
    throw std::runtime_error( "DuplicateEntryInUniqueKeyException not thrown !!!" );
  coral::AttributeList inputData;
  // Remove all entries...
  int rowsDeleted = editor.deleteRows("",inputData);
  std::cout << "Removed " << rowsDeleted << " rows" << std::endl;
  for ( int i = 0; i < 10; ++i ) {
    rowBuffer["ID"].data<int>() = i; // Original value is int but this issue hits all CORAL back-ends
    rowBuffer["x"].data<float>() = (float)( i + 0.01*i );
    rowBuffer["Y"].data<double>() = i + 0.001*i;
    rowBuffer["Z"].data<double>() = i + 0.0001*i;
    rowBuffer["b"].data<bool>() = ( i%2 > 0 );
    std::string dstr;
    // 'after 'Object 2''
    std::ostringstream os0; os0 << "The data0 is '" << i << "'"; dstr = os0.str();
    rowBuffer["data0"].setValueFromAddress(&dstr);
    std::ostringstream os1; os1 << i; dstr = os1.str();
    rowBuffer["data1"].setValueFromAddress(&dstr);
    std::string vls = "This is a very looooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong string to be stored";
    std::ostringstream os2; os2 << "Hello we test storing CLOB here up to the maximum limit, so ..................................... " << 1000000000*(i-1) + i << ">>>>>" << vls << "<<<<<"; dstr = os2.str();
    rowBuffer["data2"].setValueFromAddress(&dstr);
    if ( i%3 == 1 ) {
      rowBuffer["Y"].setNull();
    }
    else {
      rowBuffer["Y"].setNull( false );
    }
    editor.insertRow( rowBuffer );
  }
  // Now try to insert a duplicate entry
  exceptionCaught = false;
  try {
    editor.insertRow( rowBuffer );
  }
  catch ( coral::DuplicateEntryInUniqueKeyException& ) {
    exceptionCaught = true;
  }
  if ( ! exceptionCaught )
    throw std::runtime_error( "DuplicateEntryInUniqueKeyException not thrown !!!" );
  // Remove a few entries...
  inputData.extend<int>( "id" );
  inputData.begin()->data<int>() = 5;
  rowsDeleted = editor.deleteRows( "ID<:id", inputData );
  std::cout << "Removed " << rowsDeleted << " rows" << std::endl;
  // Udpate the entries;
  inputData.extend<double>("increment");
  inputData[1].data<double>() = 1.111;
  inputData[0].data<int>() += 2;
  int rowsUpdated = editor.updateRows( "Y   = Y+ :increment", "ID>:id", inputData );
  std::cout << "Updated " << rowsUpdated << " rows" << std::endl;
  session->transaction().commit();
  // Test for bug #23382
  session->transaction().start();
  coral::IQuery* query = schema.tableHandle("T_1").newQuery();
  query->limitReturnedRows( 2 );
  coral::ICursor& cursor = query->execute();
  int j = 0;
  while ( cursor.next() )
  {
    const coral::AttributeList& currentRow = cursor.currentRow();
    currentRow.toOutputStream( std::cout ) << std::endl;
    const std::string& clob = currentRow["data2"].data<std::string>();
    j++;
    std::cout << "The size of the current CLOB should be more than 255 and is: " << clob.size() << std::endl;
  }
  session->transaction().commit();
  delete session;
}


int main( int, char** )
{
  try {
    DmlApp app( "mysql://itrac424.cern.ch/test", "rado_pool", "rado_pool" );
    //DmlApp app( "mysql://pcitdb59.cern.ch/test", "rado_pool", "rado_pool" );
    //DmlApp app( "mysql://pcitdb59.cern.ch:3307/test", "rado_pool", "rado_pool" );
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
