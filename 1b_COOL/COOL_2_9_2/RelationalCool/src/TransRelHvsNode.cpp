// $Id: TransRelHvsNode.cpp,v 1.1 2011-04-08 16:08:10 avalassi Exp $

// include files

// Local include files
#include "RelationalException.h"
#include "RelationalTransaction.h"
#include "TransRelHvsNode.h"


// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

void TransRelHvsNode::setDescription( const std::string& description )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelHvsNode::setDescription");
  std::auto_ptr<RelationalTransaction>
    trans( new RelationalTransaction( db().transactionMgr(), false ) ); // r/w

  m_hvsNode->setDescription( description );
  trans->commit();
}

//-----------------------------------------------------------------------------

const std::vector<std::string> TransRelHvsNode::listTags() const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelHvsNode::listTags");
  std::auto_ptr<RelationalTransaction>
    trans( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  std::vector<std::string> retValue =
    m_hvsNode->listTags();

  trans->commit();
  return retValue;
}

//-----------------------------------------------------------------------------

const Time TransRelHvsNode::tagInsertionTime(const std::string& tagName ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelHvsNode::tagInsertionTime");
  std::auto_ptr<RelationalTransaction>
    trans( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  const Time retValue =
    m_hvsNode->tagInsertionTime( tagName );

  trans->commit();
  return retValue;
}

//-----------------------------------------------------------------------------

const std::string TransRelHvsNode::tagDescription( const std::string& tagName ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelHvsNode::tagDescription");
  std::auto_ptr<RelationalTransaction>
    trans( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  const std::string retValue =
    m_hvsNode->tagDescription( tagName );

  trans->commit();
  return retValue;
}

//-----------------------------------------------------------------------------

void TransRelHvsNode::setTagLockStatus( const std::string& tagName,
                                        HvsTagLock::Status tagLockStatus )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelHvsNode::setTagLockStatus");
  std::auto_ptr<RelationalTransaction>
    trans( new RelationalTransaction( db().transactionMgr(), false ) ); // r/w

  m_hvsNode->setTagLockStatus( tagName, tagLockStatus );

  trans->commit();
}

//-----------------------------------------------------------------------------

HvsTagLock::Status TransRelHvsNode::tagLockStatus( const std::string& tagName ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelHvsNode::tagLockStatus");
  std::auto_ptr<RelationalTransaction>
    trans( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  HvsTagLock::Status retValue =
    m_hvsNode->tagLockStatus( tagName );

  trans->commit();
  return retValue;
}

//-----------------------------------------------------------------------------

void TransRelHvsNode::createTagRelation( const std::string& parentTagName,
                                         const std::string& tagName ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelHvsNode::createTagRelation");
  std::auto_ptr<RelationalTransaction>
    trans( new RelationalTransaction( db().transactionMgr(), false ) ); // r/w

  m_hvsNode->createTagRelation( parentTagName, tagName );

  trans->commit();
}

//-----------------------------------------------------------------------------

void TransRelHvsNode::deleteTagRelation( const std::string& parentTagName ) const

{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelHvsNode::deleteTagRelation");
  std::auto_ptr<RelationalTransaction>
    trans( new RelationalTransaction( db().transactionMgr(), false ) ); // r/w

  m_hvsNode->deleteTagRelation( parentTagName );

  trans->commit();
}

//-----------------------------------------------------------------------------

const std::string TransRelHvsNode::findTagRelation( const std::string& parentTagName ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelHvsNode::findTagRelation");
  std::auto_ptr<RelationalTransaction>
    trans( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  const std::string retValue =
    m_hvsNode->findTagRelation( parentTagName );

  trans->commit();
  return retValue;
}

//-----------------------------------------------------------------------------

const std::string TransRelHvsNode::resolveTag( const std::string& parentTagName ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelHvsNode::resolveTag");
  std::auto_ptr<RelationalTransaction>
    trans( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  const std::string retValue =
    m_hvsNode->resolveTag( parentTagName );

  trans->commit();
  return retValue;
}

//-----------------------------------------------------------------------------

void TransRelHvsNode::setTagDescription( const std::string& tagName,
                                         const std::string& description )

{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelHvsNode::setTagDescription");
  std::auto_ptr<RelationalTransaction>
    trans( new RelationalTransaction( db().transactionMgr(), false ) ); // r/w

  m_hvsNode->setTagDescription( tagName,
                                description );

  trans->commit();
}

//-----------------------------------------------------------------------------
