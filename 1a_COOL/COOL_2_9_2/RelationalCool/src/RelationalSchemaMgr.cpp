// $Id: RelationalSchemaMgr.cpp,v 1.12 2012-01-30 14:56:20 avalassi Exp $

// Local include files
#include "RelationalDatabase.h"
#include "RelationalSchemaMgr.h"
#include "uppercaseString.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

RelationalSchemaMgr::RelationalSchemaMgr( const RelationalDatabase& aDb )
  : m_db( aDb )
  , m_log( new coral::MessageStream( "RelationalSchemaMgr" ) )
{
  log() << coral::Debug << "Instantiate a RelationalSchemaMgr"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

RelationalSchemaMgr::~RelationalSchemaMgr()
{
  log() << coral::Debug << "Delete the RelationalSchemaMgr"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------


coral::MessageStream& RelationalSchemaMgr::log() const
{
  *m_log << coral::Verbose;
  return *m_log;
}

//-----------------------------------------------------------------------------

const RelationalQueryMgr& RelationalSchemaMgr::queryMgr() const
{
  return db().queryMgr();
}

//-----------------------------------------------------------------------------

bool
RelationalSchemaMgr::isValidColumnName( const std::string& name ) const
{
  static std::string allowedChar =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ_1234567890";
  const std::string ucName = uppercaseString( name );
  if ( name.size() < 1 ||
       name.size() > 30 ||
       ucName.find_first_not_of( allowedChar ) != ucName.npos ||
       ucName.find_first_not_of( "_1234567890" ) != 0 )
    return false;
  else
    return true;
}

//-----------------------------------------------------------------------------
