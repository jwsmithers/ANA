#ifdef WIN32
#include <WTypes.h> // fix bug #35683, bug #73144, bug #76882, bug #79849
#endif

#include <iostream>
#include "RelationalAccess/SchemaException.h"
#include "Cursor.h"
#include "OracleStatement.h"

coral::OracleAccess::Cursor::Cursor( const std::string& domainServiceName,
                                     std::auto_ptr<OracleStatement> statement,
                                     const coral::AttributeList& rowBuffer )
  : m_domainServiceName( domainServiceName )
  , m_statement( statement )
  , m_rowBuffer( rowBuffer )
  , m_started( false )
{
  //std::cout << "Create Cursor " << this << std::endl; // debug bug #73334
}


coral::OracleAccess::Cursor::~Cursor()
{
  //std::cout << "Delete Cursor " << this << std::endl; // debug bug #73334
  this->close();
}


bool
coral::OracleAccess::Cursor::next()
{
  //std::cout << "Cursor " << this << ": next" << std::endl; // debug bug #73334
  if ( !m_statement.get() ) return false;
  //std::cout << "Cursor::next: fetchNext" << std::endl; // debug bug #73334
  bool result = m_statement->fetchNext();
  //std::cout << "Cursor::next: fetchNext OK" << std::endl; // debug bug #73334
  if ( result && !m_started ) m_started=true;  // fix bug #91028
  if ( ! result ) this->close();
  return result;
}


const coral::AttributeList&
coral::OracleAccess::Cursor::currentRow() const
{
  if ( !m_started ) // fix bug #91028
    throw coral::QueryException( m_domainServiceName,
                                 "Cursor loop has not started yet",
                                 "ICursor::currentRow()" );
  return m_rowBuffer;
}


void
coral::OracleAccess::Cursor::close()
{
  m_statement.reset(); // Delete here explicitly like previous ptr (bug #90898)
}
