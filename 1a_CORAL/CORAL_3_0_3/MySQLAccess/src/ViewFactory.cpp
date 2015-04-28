#include "MySQL_headers.h"

#include "CoralKernel/Service.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/SchemaException.h"

#include "DomainProperties.h"
#include "SessionProperties.h"
#include "Statement.h"
#include "ViewFactory.h"

coral::MySQLAccess::ViewFactory::ViewFactory( boost::shared_ptr<const SessionProperties> properties )
  : coral::MySQLAccess::QueryDefinition( properties )
{
}

coral::MySQLAccess::ViewFactory::~ViewFactory()
{
}

coral::IView&
coral::MySQLAccess::ViewFactory::create( const std::string& /*viewName*/ )
{
  throw coral::Exception( "Views are not fully supported in MySQLAccess (bug #36512)", m_properties->domainServiceName(), "ISchema::dropIfExistsView" );
  /*
  if ( this->sessionProperties()->schema().existsView( viewName ) )
    throw coral::ViewAlreadyExistingException( this->sessionProperties()->domainServiceName(), viewName );
  std::string sqlStatement = "CREATE VIEW " + this->sessionProperties()->schemaName() + ".\"" + viewName + "\" AS ( " + this->sqlFragment() + " )";
  coral::MySQLAccess::Statement statement( this->sessionProperties(), sqlStatement );
  if ( ! statement.execute( this->bindData() ) )
    throw coral::SchemaException( this->sessionProperties()->domainServiceName(), "Could not create view \"" + viewName + "\"", "IViewFactory::create" );
  return this->sessionProperties()->schema().viewHandle( viewName );
  *///
}


coral::IView&
coral::MySQLAccess::ViewFactory::createOrReplace( const std::string& /*viewName(*/ )
{
  throw coral::Exception( "Views are not fully supported in MySQLAccess (bug #36512)", m_properties->domainServiceName(), "ISchema::dropIfExistsView" );
  /*
  std::string sqlStatement = "CREATE OR REPLACE VIEW " + this->sessionProperties()->schemaName() + ".\"" + viewName + "\" AS ( " + this->sqlFragment() + " )";
  coral::MySQLAccess::Statement statement( this->sessionProperties(), sqlStatement );
  if ( ! statement.execute( this->bindData() ) )
    throw coral::SchemaException( this->sessionProperties()->domainServiceName(), "Could not create view \"" + viewName + "\"", "IViewFactory::create" );
  return this->sessionProperties()->schema().viewHandle( viewName );
  *///
}
