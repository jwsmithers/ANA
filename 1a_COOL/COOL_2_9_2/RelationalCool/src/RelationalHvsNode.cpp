// $Id: RelationalHvsNode.cpp,v 1.43 2011-04-08 16:08:10 avalassi Exp $

// Include files
#include <algorithm>
#include "CoralBase/Attribute.h"

// Local include files
#include "HvsTagRecord.h" // move to CoolKernel?
#include "RelationalDatabase.h"
#include "RelationalGlobalTagTable.h"
#include "RelationalHvsNode.h"
#include "RelationalTableRow.h"
#include "RelationalTagMgr.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

RelationalHvsNode::RelationalHvsNode
( const RelationalDatabasePtr& db,
  const coral::AttributeList& nodeTableRow )
  : RelationalHvsNodeRecord( nodeTableRow )
  , m_db( db )
{
}

//-----------------------------------------------------------------------------

RelationalHvsNode::~RelationalHvsNode()
{
}

//-----------------------------------------------------------------------------

void RelationalHvsNode::setDescription( const std::string& description )
{
  db().updateNodeTableDescription( fullPath(), description );
  RelationalHvsNodeRecord::setDescription( description );
}

//-----------------------------------------------------------------------------

const std::vector<std::string> RelationalHvsNode::listTags() const
{
  db().checkDbOpenTransaction( "RelationalHvsNode::listTags", cool::ReadOnly );
  std::vector<std::string> tags;
  std::vector<RelationalTableRow> rows =
    db().tagMgr().fetchGlobalTagTableRows( id() );
  for ( std::vector<RelationalTableRow>::const_iterator
          row = rows.begin(); row != rows.end(); ++row ) {
    std::string tagName =
      (*row)[RelationalGlobalTagTable::columnNames::tagName]
      .data<std::string>();
    tags.push_back( tagName );
  }
  std::sort( tags.begin(), tags.end() ); // this was missing (bug #54723)
  return tags;
}

//-----------------------------------------------------------------------------

const Time
RelationalHvsNode::tagInsertionTime( const std::string& tagName ) const
{
  return db().tagMgr().tagInsertionTime( this, tagName );
}

//-----------------------------------------------------------------------------

void
RelationalHvsNode::setTagDescription( const std::string& tagName,
                                      const std::string& description )
{
  return db().tagMgr().setTagDescription( this, tagName, description );
}

//-----------------------------------------------------------------------------

const std::string
RelationalHvsNode::tagDescription( const std::string& tagName ) const
{
  return db().tagMgr().tagDescription( this, tagName );
}

//-----------------------------------------------------------------------------

void
RelationalHvsNode::setTagLockStatus( const std::string& tagName,
                                     HvsTagLock::Status tagLockStatus )
{
  return db().tagMgr().setTagLockStatus( this, tagName, tagLockStatus );
}

//-----------------------------------------------------------------------------

HvsTagLock::Status
RelationalHvsNode::tagLockStatus( const std::string& tagName ) const
{
  return db().tagMgr().tagLockStatus( this, tagName );
}

//-----------------------------------------------------------------------------

void
RelationalHvsNode::createTagRelation( const std::string& parentTagName,
                                      const std::string& tagName ) const
{
  db().checkDbOpenTransaction( "RelationalHvsNode::createTagRelation", cool::ReadWrite );
  // WARNING: if this is the root node, this method must fail (bug #35891);
  // tagMgr().createTagRelation() is called with id() == parentid() == 0,
  // which throws an InvalidTagRelation (child node has no parent)
  db().tagMgr().createTagRelation( parentId(), parentTagName, id(), tagName );
}

//-----------------------------------------------------------------------------

void
RelationalHvsNode::deleteTagRelation( const std::string& parentTagName ) const
{
  db().checkDbOpenTransaction( "RelationalHvsNode::deleteTagRelation",
                               cool::ReadWrite );
  // TEMPORARY - START
  //db().tagMgr().deleteTagRelation( parentId(), parentTagName, id() );
  db().tagMgr().deleteTagRelation( *this, parentTagName );
  // TEMPORARY - END
}

//-----------------------------------------------------------------------------

const std::string
RelationalHvsNode::findTagRelation( const std::string& parentTagName ) const
{
  db().checkDbOpenTransaction( "RelationalHvsNode::findTagRelation",
                               cool::ReadOnly );
  UInt32 tagId =
    db().tagMgr().findTagRelation( parentId(), parentTagName, id() );
  std::string tag = db().tagMgr().findTagRecord( id(), tagId ).name();
  return tag;
}

//-----------------------------------------------------------------------------

const std::string
RelationalHvsNode::resolveTag( const std::string& ancestorTagName ) const
{
  db().checkDbOpenTransaction( "RelationalHvsNode::resolveTag",
                               cool::ReadOnly );
  UInt32 tagId =
    db().tagMgr().resolveTag( ancestorTagName, id() );
  std::string tag = db().tagMgr().findTagRecord( id(), tagId ).name();
  return tag;
}

//-----------------------------------------------------------------------------
/*
bool
RelationalHvsNode::isTagUsed( UInt32 tagId ) const
{
  // Is the tag referenced in the TAG2TAG table?
  return db().tagMgr().existsTagInTag2TagTable( id(), tagId );
}
*///
//-----------------------------------------------------------------------------
