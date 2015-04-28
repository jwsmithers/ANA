
// Local include files
#include "CoralConnectionServiceProxy.h"
#include "RelationalException.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

CoralConnectionServiceProxy::CoralConnectionServiceProxy( coral::IConnectionService* pConnSvc )
  : m_pConnSvc( pConnSvc )
  , m_mutex()
{
  //std::cout << "Create CoralConnectionServiceProxy " << this
  //          << " -> " << m_pConnSvc << " ***" << std::endl;
}

//-----------------------------------------------------------------------------

CoralConnectionServiceProxy::~CoralConnectionServiceProxy()
{
  //std::cout << "Delete CoralConnectionServiceProxy " << this
  //          << " -> " << m_pConnSvc << " ***" << std::endl;
}

//-----------------------------------------------------------------------------

const coral::IConnectionService* CoralConnectionServiceProxy::getICS() const
{
  if ( m_pConnSvc == 0 ) throw RelationalException( "Null pointer in CoralConnectionServiceProxy",
                                                    "CoralConnectionServiceProxy::getICS()" );
  //std::cout << "CoralConnectionServiceProxy::getICS " << m_pConnSvc << std::endl;
  return m_pConnSvc;
}

//-----------------------------------------------------------------------------

coral::IConnectionService* CoralConnectionServiceProxy::getICS()
{
  if ( m_pConnSvc == 0 ) throw RelationalException( "Null pointer in CoralConnectionServiceProxy",
                                                    "CoralConnectionServiceProxy::getICS()" );
  //std::cout << "CoralConnectionServiceProxy::getICS " << m_pConnSvc << std::endl;
  return m_pConnSvc;
}

//-----------------------------------------------------------------------------
