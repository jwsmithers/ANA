#include <memory>
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ITable.h"
#include "RelationalAccess/ITableDataEditor.h"
#include "RelationalAccess/ITablePrivilegeManager.h"
#include "RelationalAccess/ITransaction.h"
#include "RelationalAccess/TableDescription.h"
#include "SingleThreadWrite.h"

//-----------------------------------------------------------------------------

SingleThreadWrite::SingleThreadWrite( const TestEnv& env,
                                      size_t no,
                                      unsigned& nErrors )
  : Testing(env)
  , m_tableno( no )
  , m_nErrors( nErrors )
{
}

//-----------------------------------------------------------------------------

SingleThreadWrite::~SingleThreadWrite()
{
}

//-----------------------------------------------------------------------------

void
SingleThreadWrite::operator()()
{
  try
  {
    std::auto_ptr<coral::ISessionProxy> session( newSession( 0, coral::Update, false ) );
    session->transaction().start();
    coral::ISchema& schema = session->nominalSchema();
    std::ostringstream osTableName;
    osTableName << T2 << "_" << m_tableno;
    const std::string tableName = osTableName.str();
    schema.dropIfExistsTable( tableName );
    coral::TableDescription description;
    description.setName( tableName );
    description.insertColumn( "I", "int" );
    description.insertColumn( "F", "float" );
    description.insertColumn( "D", "double" );
    description.setPrimaryKey( "I" );
    description.setNotNullConstraint( "F" );
    coral::ITable& table = schema.createTable( description );
    table.privilegeManager().grantToPublic( coral::ITablePrivilegeManager::Select );
    coral::AttributeList rowBuffer;
    rowBuffer.extend<int>( "I" );
    rowBuffer.extend<float>( "F" );
    rowBuffer.extend<double>( "D" );
    int& i = rowBuffer[0].data<int>();
    float& f = rowBuffer[1].data<float>();
    double& d = rowBuffer[2].data<double>();
    for ( int row01 = 0; row01 < 100; ++row01 )
    {
      i = row01;
      f = row01 + (float)0.001 * m_tableno;
      d = row01 + 0.000001 * m_tableno;
      table.dataEditor().insertRow( rowBuffer );
    }
    coral::sleepSeconds( 1 );
    session->transaction().commit();
  }
  catch ( coral::Exception& e )
  {
    // Fix crash (bug #94505)
    std::cout << "Exception caught in thread:" << e.what() << std::endl;
    m_nErrors++;
  }
}

//-----------------------------------------------------------------------------
