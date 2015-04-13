// $Id: TransRalDatabase.cpp,v 1.2 2011-04-09 20:41:47 avalassi Exp $

// Include files

// Local include files
#include "RelationalTransaction.h"
#include "TransRalDatabase.h"
#include "TransRelFolder.h"
#include "TransRelFolderSet.h"

// Namespace
using namespace cool;

//------------------------------------------------------------------

IFolderSetPtr TransRalDatabase::createFolderSet( const std::string& fullPath,
                                                 const std::string& description,
                                                 bool createParents )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelDatabase::createFolderSet");
  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr() ) ); // r/w

  IFolderSetPtr retValue =
    db().createFolderSet( fullPath, description, createParents );

  trans->commit();
  // if we return a RelationalFolder, wrap it into a TransRelFolderSet
  if ( dynamic_cast<RelationalFolderSet*>( retValue.get() ) )
    retValue = IFolderSetPtr( new TransRelFolderSet( retValue ) );
  return retValue;
}

//------------------------------------------------------------------

bool TransRalDatabase::existsFolderSet( const std::string& folderSetName )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelDatabase::existsFolderSet");
  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  bool retValue =
    db().existsFolderSet( folderSetName );

  trans->commit();
  return retValue;
}

//------------------------------------------------------------------

IFolderSetPtr TransRalDatabase::getFolderSet( const std::string& fullPath )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelDatabase::getFolderSet");
  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  IFolderSetPtr retValue =
    db().getFolderSet( fullPath );

  trans->commit();
  // if we return a RelationalFolder, wrap it into a TransRelFolderSet
  if ( dynamic_cast<RelationalFolderSet*>( retValue.get() ) )
    retValue = IFolderSetPtr( new TransRelFolderSet( retValue ) );
  return retValue;
}

//------------------------------------------------------------------

IFolderPtr TransRalDatabase::createFolder( const std::string& fullPath,
                                           const IFolderSpecification& folderSpec,
                                           const std::string& description,
                                           bool createParents )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelDatabase::createFolder");
  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), false ) ); // r/w

  IFolderPtr retValue =
    db().createFolder( fullPath, folderSpec, description, createParents );

  trans->commit();

  // if we return a RelationalFolder, wrap it into a TransRelFolder
  if ( dynamic_cast<RelationalFolder*>( retValue.get() ) )
    retValue = IFolderPtr( new TransRelFolder( retValue ) );

  return retValue;
}

//------------------------------------------------------------------

IFolderPtr TransRalDatabase::createFolder( const std::string& fullPath,
                                           const IRecordSpecification& payloadSpec,
                                           const std::string& description,
                                           FolderVersioning::Mode mode,
                                           bool createParents )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelDatabase::createFolder");
  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), false ) ); // r/w

  IFolderPtr retValue =
    db().createFolder( fullPath, payloadSpec, description, mode, createParents );

  trans->commit();

  // if we return a RelationalFolder, wrap it into a TransRelFolder
  if ( dynamic_cast<RelationalFolder*>( retValue.get() ) )
    retValue = IFolderPtr( new TransRelFolder( retValue ) );

  return retValue;
}

//------------------------------------------------------------------

bool TransRalDatabase::existsFolder( const std::string& fullPath )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelDatabase::existsFolder");
  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  bool retValue =
    db().existsFolder( fullPath );

  trans->commit();
  return retValue;
}

//------------------------------------------------------------------

IFolderPtr TransRalDatabase::getFolder( const std::string& fullPath )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelDatabase::getFolder");
  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  IFolderPtr retValue =
    db().getFolder( fullPath );

  trans->commit();

  // if we return a RelationalFolder, wrap it into a TransRelFolder
  if ( dynamic_cast<RelationalFolder*>( retValue.get() ) )
    retValue = IFolderPtr( new TransRelFolder( retValue ) );

  return retValue;
}

//------------------------------------------------------------------

const std::vector<std::string>
TransRalDatabase::listAllNodes( bool ascending )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelDatabase::listAllNodes");
  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  const std::vector<std::string> retValue =
    db().listAllNodes( ascending );

  trans->commit();
  return retValue;
}

//------------------------------------------------------------------

bool TransRalDatabase::dropNode( const std::string& fullPath )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelDatabase::dropNode");
  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), false ) ); // r/w

  bool retValue =
    db().dropNode( fullPath );

  trans->commit();
  return retValue;
}

//------------------------------------------------------------------

bool TransRalDatabase::existsTag( const std::string& tagName ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelDatabase::exitsTag");
  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  bool retValue =
    db().existsTag( tagName );

  trans->commit();
  return retValue;
}

//------------------------------------------------------------------

IHvsNode::Type TransRalDatabase::tagNameScope( const std::string& tagName ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelDatabase::tagNameScope");
  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  IHvsNode::Type retValue =
    db().tagNameScope( tagName );

  trans->commit();
  return retValue;
}

//------------------------------------------------------------------

const std::vector<std::string>
TransRalDatabase::taggedNodes( const std::string& tagName ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelDatabase::taggedNodes");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  const std::vector<std::string> retValue =
    db().taggedNodes( tagName );

  trans->commit();
  return retValue;
}

//------------------------------------------------------------------

void TransRalDatabase::openDatabase()
{
  if ( !db().isConnected() )
    db().connect();

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  db().openDatabase();

  trans->commit();
}

//------------------------------------------------------------------

void TransRalDatabase::createDatabase()
{
  if ( !db().isConnected() )
    db().connect();

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), false ) ); // r/w

  db().createDatabase();

  trans->commit();
}

//------------------------------------------------------------------

void TransRalDatabase::createDatabase( const IRecord& dbAttr )
{
  if ( !db().isConnected() )
    db().connect();

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), false ) ); // r/w

  db().createDatabase( dbAttr );

  trans->commit();
}

//------------------------------------------------------------------

void TransRalDatabase::refreshDatabase( bool keepNodes )
{
  if ( !db().isConnected() )
    db().connect();

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), false ) ); // r/w

  db().refreshDatabase( keepNodes );

  trans->commit();
}

//------------------------------------------------------------------

bool TransRalDatabase::dropDatabase()
{
  if ( !db().isConnected() )
    db().connect();

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), false ) ); // r/w

  bool retValue=db().dropDatabase();

  trans->commit();
  return retValue;
}

//------------------------------------------------------------------
