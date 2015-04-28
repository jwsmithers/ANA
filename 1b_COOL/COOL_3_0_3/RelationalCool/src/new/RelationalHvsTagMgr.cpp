
// Include files
#include "CoolKernel/Exception.h"
#include "CoolKernel/IHvsNodeMgr.h"
#include "CoolKernel/IHvsNodeRecord.h"
#include "CoolKernel/IHvsTagRecord.h"

// Local include files
#include "RelationalHvsTagMgr.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

const IHvsTagRecord&
RelationalHvsTagMgr::findTagRecord( const std::string& /*tagName*/ ) const
{
  throw Exception( "Not yet implemented", "RelationalHvsTagMgr" );
}

//-----------------------------------------------------------------------------

/*
const IHvsTag&
RelationalHvsTagMgr::findTag( const std::string& tagName ) const
{
}
*///

//-----------------------------------------------------------------------------

const bool
RelationalHvsTagMgr::existsTag( const std::string& tagName ) const
{
  if ( IHvsNode::isHeadTag( tagName ) ) return true;
  try {
    findTagRecord( tagName );
    return true;
  } catch ( TagNotFound& /* dummy */ ) {
    return false;
  }
}

//-----------------------------------------------------------------------------
/*
const IHvsNode::Type
RelationalHvsTagMgr::tagScope( const std::string& tagName ) const
{
  const IHvsTagRecord& tag = findTagRecord( tagName );
  return tag.scope();
}
*///
//-----------------------------------------------------------------------------

const std::string
RelationalHvsTagMgr::taggedNode( const std::string& tagName ) const
{
  const IHvsTagRecord& tag = findTagRecord( tagName );
  return hvsNodeMgr().findNodeRecord( tag.nodeId() ).fullPath();
}

//-----------------------------------------------------------------------------

const std::vector<std::string>
RelationalHvsTagMgr::taggedNodes( const std::string& tagName ) const
{
  // TEMPORARY IMPLEMENTATION!
  std::vector<std::string> nodes;
  nodes.push_back( taggedNode( tagName ) );
  return nodes;
}

//-----------------------------------------------------------------------------

const IHvsNodeMgr&
RelationalHvsTagMgr::hvsNodeMgr() const
{
  return *m_hvsNodeMgr;
}

//-----------------------------------------------------------------------------
