// First of all, enable or disable the CORAL240 API extensions (bug #89707)
#include "CoralBase/VersionInfo.h"

#include "OperationWithQuery.h"
#include "QueryDefinition.h"
#include "Statement.h"

#include <cstdlib>

coral::FrontierAccess::OperationWithQuery::OperationWithQuery( const std::string& sqlPrefix, boost::shared_ptr<const SessionProperties> properties )
  : m_queryDefinition( new coral::FrontierAccess::QueryDefinition( properties ) ), m_statement( sqlPrefix )
{
}

coral::FrontierAccess::OperationWithQuery::~OperationWithQuery()
{
  if ( m_queryDefinition ) delete m_queryDefinition;
}

coral::IQueryDefinition& coral::FrontierAccess::OperationWithQuery::query()
{
  return *m_queryDefinition;
}

long coral::FrontierAccess::OperationWithQuery::execute()
{
  if ( m_statement.empty() )
    return 0;

#ifndef CORAL300WC
  const char* reloadEnv = ::getenv( "CORAL_FRONTIER_RELOAD" ); bool reload = false;
  if( reloadEnv != 0 )
    reload = true;
#endif

  m_statement += " ( " + m_queryDefinition->sqlFragment() + " )";

  coral::FrontierAccess::Statement statement( m_queryDefinition->sessionProperties(), m_statement );

#ifndef CORAL300WC
  if ( ! statement.execute( m_queryDefinition->bindData(), reload ) )
    return 0;
#else
  if ( ! statement.execute( m_queryDefinition->bindData() ) )
    return 0;
#endif

  long result = statement.numberOfRowsProcessed();
  m_statement = "";
  return result;
}
