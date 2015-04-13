#include <memory>
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"
#include "RelationalAccess/ICursor.h"
#include "RelationalAccess/IQuery.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ITable.h"
#include "RelationalAccess/ITransaction.h"
#include "SingleThreadRead.h"

//-----------------------------------------------------------------------------

SingleThreadRead::SingleThreadRead( const TestEnv& env,
                                    size_t no,
                                    unsigned& nErrors )
  : Testing(env)
  , m_tableno( no )
  , m_nErrors( nErrors )
{
}

//-----------------------------------------------------------------------------

SingleThreadRead::~SingleThreadRead()
{
}

//-----------------------------------------------------------------------------

void
SingleThreadRead::operator()()
{
  try
  {
    std::auto_ptr<coral::ISessionProxy> session( newSession( 0, coral::ReadOnly, false ) );
    session->transaction().start( true );
    coral::ISchema& schema = session->nominalSchema();
    std::ostringstream osTableName;
    osTableName << T2 << "_" << m_tableno;
    const std::string tableName = osTableName.str();
    std::auto_ptr<coral::IQuery> query( schema.tableHandle( tableName ).newQuery() );
    coral::AttributeList outputBuffer;
    outputBuffer.extend<double>( "RES" );
    query->addToOutputList( "F+D", "RES" );
    query->addToOrderList( "I" );
    query->defineOutput( outputBuffer );
    coral::ICursor& cursor = query->execute();
    int row02 = 0;
    double& res = outputBuffer[0].data<double>();
    while ( cursor.next() ) {
      if ( ::fabs( res - ( 2* row02 + 0.001001 * m_tableno ) ) > 0.00001 )
        throw std::runtime_error( "Unexpected data" );
      ++row02;
    }
    if ( row02 != 100 )
      throw std::runtime_error( "Unexpected number of rows" );
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
