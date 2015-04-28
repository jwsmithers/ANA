// First of all, set/unset CORAL290, COOL300, COOL400 and COOL_HAS_CPP11 macros
#include "CoolKernel/VersionInfo.h"

// Include files
//#include <iostream>

// Local include files
#include "PyCool_helpers.h"
#include "TransRalDatabase.h"
#include "RalDatabaseSvc.h"
#include "RelationalException.h"

//-----------------------------------------------------------------------------

cool::IDatabasePtr
cool::PyCool::Helpers::createDatabaseNoThrow( const IDatabaseSvc* ptr,
                                              std::string& excThr,
                                              const DatabaseId& dbId )
{
  const std::string methodName = "PyCool::Helpers::createDatabaseNoThrow";
  //std::cout << methodName << std::endl;
  excThr = "";
  const IDatabasePtr dummyOut;
  if ( !ptr )
  {
    excThr = "Null pointer in " + methodName;
    return dummyOut;
  }
  try
  {
    return ptr->createDatabase( dbId );
  }
  catch( std::exception& e )
  {
    excThr = e.what();
    return dummyOut;
  }
  catch( ... )
  {
    excThr = "UNKNOWN exception caught in " + methodName;
    return dummyOut;
  }
}

//-----------------------------------------------------------------------------

cool::IDatabasePtr
cool::PyCool::Helpers::openDatabaseNoThrow( const IDatabaseSvc* ptr,
                                            std::string& excThr,
                                            const DatabaseId& dbId,
                                            bool readOnly )
{
  const std::string methodName = "PyCool::Helpers::openDatabaseNoThrow";
  //std::cout << methodName << std::endl;
  excThr = "";
  const IDatabasePtr dummyOut;
  if ( !ptr )
  {
    excThr = "Null pointer in " + methodName;
    return dummyOut;
  }
  try
  {
    return ptr->openDatabase( dbId, readOnly );
  }
  catch( std::exception& e )
  {
    excThr = e.what();
    return dummyOut;
  }
  catch( ... )
  {
    excThr = "UNKNOWN exception caught in " + methodName;
    return dummyOut;
  }
}

//-----------------------------------------------------------------------------

const std::string
cool::PyCool::Helpers::resolveTagNoThrow( const IHvsNode* ptr,
                                          std::string& excThr,
                                          const std::string& ancestorTagName )
{
  const std::string methodName = "PyCool::Helpers::resolveTagNoThrow";
  //std::cout << methodName << std::endl;
  excThr = "";
  const std::string dummyOut = "";
  if ( !ptr )
  {
    excThr = "Null pointer in " + methodName;
    return dummyOut;
  }
  try
  {
    return ptr->resolveTag( ancestorTagName );
  }
  catch( std::exception& e )
  {
    excThr = e.what();
    return dummyOut;
  }
  catch( ... )
  {
    excThr = "UNKNOWN exception caught in " + methodName;
    return dummyOut;
  }
}

//-----------------------------------------------------------------------------

void
cool::PyCool::Helpers::createTagRelationNoThrow( const IHvsNode* ptr,
                                                 std::string& excThr,
                                                 const std::string& parentTagName,
                                                 const std::string& tagName )
{
  const std::string methodName = "PyCool::Helpers::createTagRelationNoThrow";
  //std::cout << methodName << std::endl;
  excThr = "";
  if ( !ptr )
  {
    excThr = "Null pointer in " + methodName;
    return;
  }
  try
  {
    return ptr->createTagRelation( parentTagName, tagName );
  }
  catch( std::exception& e )
  {
    excThr = e.what();
    return;
  }
  catch( ... )
  {
    excThr = "UNKNOWN exception caught in " + methodName;
    return;
  }
}

//-----------------------------------------------------------------------------

void
cool::PyCool::Helpers::deleteTagRelationNoThrow( const IHvsNode* ptr,
                                                 std::string& excThr,
                                                 const std::string& parentTagName )
{
  const std::string methodName = "PyCool::Helpers::deleteTagRelationNoThrow";
  //std::cout << methodName << std::endl;
  excThr = "";
  if ( !ptr )
  {
    excThr = "Null pointer in " + methodName;
    return;
  }
  try
  {
    return ptr->deleteTagRelation( parentTagName );
  }
  catch( std::exception& e )
  {
    excThr = e.what();
    return;
  }
  catch( ... )
  {
    excThr = "UNKNOWN exception caught in " + methodName;
    return;
  }
}

//-----------------------------------------------------------------------------

const std::string
cool::PyCool::Helpers::findTagRelationNoThrow( const IHvsNode* ptr,
                                               std::string& excThr,
                                               const std::string& parentTagName )
{
  const std::string methodName = "PyCool::Helpers::findTagRelationNoThrow";
  //std::cout << methodName << std::endl;
  excThr = "";
  const std::string dummyOut = "";
  if ( !ptr )
  {
    excThr = "Null pointer in " + methodName;
    return dummyOut;
  }
  try
  {
    return ptr->findTagRelation( parentTagName );
  }
  catch( std::exception& e )
  {
    excThr = e.what();
    return dummyOut;
  }
  catch( ... )
  {
    excThr = "UNKNOWN exception caught in " + methodName;
    return dummyOut;
  }
}

//-----------------------------------------------------------------------------

void
cool::PyCool::Helpers::setTagLockStatusNoThrow( IHvsNode* ptr,
                                                std::string& excThr,
                                                const std::string& tagName,
                                                HvsTagLock::Status tagLockStatus )
{
  const std::string methodName = "PyCool::Helpers::setTagLockStatusNoThrow";
  //std::cout << methodName << std::endl;
  excThr = "";
  if ( !ptr )
  {
    excThr = "Null pointer in " + methodName;
    return;
  }
  try
  {
    return ptr->setTagLockStatus( tagName, tagLockStatus );
  }
  catch( std::exception& e )
  {
    excThr = e.what();
    return;
  }
  catch( ... )
  {
    excThr = "UNKNOWN exception caught in " + methodName;
    return;
  }
}

//-----------------------------------------------------------------------------

cool::IFolderSetPtr
cool::PyCool::Helpers::getFolderSetNoThrow( IDatabase* ptr,
                                            std::string& excThr,
                                            const std::string& fullPath )
{
  const std::string methodName = "PyCool::Helpers::getFolderSetNoThrow";
  //std::cout << methodName << std::endl;
  excThr = "";
  const IFolderSetPtr dummyOut;
  if ( !ptr )
  {
    excThr = "Null pointer in " + methodName;
    return dummyOut;
  }
  try
  {
    return ptr->getFolderSet( fullPath );
  }
  catch( std::exception& e )
  {
    excThr = e.what();
    return dummyOut;
  }
  catch( ... )
  {
    excThr = "UNKNOWN exception caught in " + methodName;
    return dummyOut;
  }
}

//-----------------------------------------------------------------------------

cool::IFolderPtr
cool::PyCool::Helpers::getFolderNoThrow( IDatabase* ptr,
                                         std::string& excThr,
                                         const std::string& fullPath )
{
  const std::string methodName = "PyCool::Helpers::getFolderNoThrow";
  //std::cout << methodName << std::endl;
  excThr = "";
  const IFolderPtr dummyOut;
  if ( !ptr )
  {
    excThr = "Null pointer in " + methodName;
    return dummyOut;
  }
  try
  {
    return ptr->getFolder( fullPath );
  }
  catch( std::exception& e )
  {
    excThr = e.what();
    return dummyOut;
  }
  catch( ... )
  {
    excThr = "UNKNOWN exception caught in " + methodName;
    return dummyOut;
  }
}

//-----------------------------------------------------------------------------

cool::IObjectPtr
cool::PyCool::Helpers::findObjectNoThrow( IFolder* ptr,
                                          std::string& excThr,
                                          const ValidityKey& pointInTime,
                                          const ChannelId& channelId,
                                          const std::string& tagName )
{
  const std::string methodName = "PyCool::Helpers::findObjectNoThrow";
  //std::cout << methodName << std::endl;
  excThr = "";
  const IObjectPtr dummyOut;
  if ( !ptr )
  {
    excThr = "Null pointer in " + methodName;
    return dummyOut;
  }
  try
  {
    return ptr->findObject( pointInTime, channelId, tagName );
  }
  catch( std::exception& e )
  {
    excThr = e.what();
    return dummyOut;
  }
  catch( ... )
  {
    excThr = "UNKNOWN exception caught in " + methodName;
    return dummyOut;
  }
}

//-----------------------------------------------------------------------------

cool::IObjectIteratorPtr
cool::PyCool::Helpers::browseObjectsNoThrow( IFolder* ptr,
                                             std::string& excThr,
                                             const ValidityKey& since,
                                             const ValidityKey& until,
                                             const ChannelSelection& channels,
                                             const std::string& tagName,
                                             const IRecordSelection* payloadQuery )
{
  const std::string methodName = "PyCool::Helpers::browseObjectsNoThrow";
  //std::cout << methodName << std::endl;
  excThr = "";
  const IObjectIteratorPtr dummyOut;
  if ( !ptr )
  {
    excThr = "Null pointer in " + methodName;
    return dummyOut;
  }
  try
  {
    return ptr->browseObjects( since, until, channels, tagName, payloadQuery);
  }
  catch( std::exception& e )
  {
    excThr = e.what();
    return dummyOut;
  }
  catch( ... )
  {
    excThr = "UNKNOWN exception caught in " + methodName;
    return dummyOut;
  }
}

//-----------------------------------------------------------------------------

void
cool::PyCool::Helpers::cloneTagAsUserTagNoThrow( IFolder* ptr,
                                                 std::string& excThr,
                                                 const std::string& tagName,
                                                 const std::string& tagClone,
                                                 const std::string& description,
                                                 bool forceOverwriteTag )
{
  const std::string methodName = "PyCool::Helpers::cloneTagAsUserTagNoThrow";
  //std::cout << methodName << std::endl;
  excThr = "";
  if ( !ptr )
  {
    excThr = "Null pointer in " + methodName;
    return;
  }
  try
  {
    return ptr->cloneTagAsUserTag( tagName, tagClone, description, forceOverwriteTag );
  }
  catch( std::exception& e )
  {
    excThr = e.what();
    return;
  }
  catch( ... )
  {
    excThr = "UNKNOWN exception caught in " + methodName;
    return;
  }
}

//-----------------------------------------------------------------------------

#ifdef COOL290VP
cool::FolderSpecification
cool::PyCool::Helpers::FolderSpecificationNoThrow( std::string& excThr,
                                                   FolderVersioning::Mode mode,
                                                   const IRecordSpecification& pSpec,
                                                   PayloadMode::Mode payloadMode )
{
  const std::string methodName = "PyCool::Helpers::FolderSpecificationNoThrow";
  //std::cout << methodName << std::endl;
  excThr = "";
  const FolderSpecification dummyOut( pSpec ); // need at least one argument...
  try
  {
    return FolderSpecification( mode, pSpec, payloadMode );
  }
  catch( std::exception& e )
  {
    excThr = e.what();
    return dummyOut;
  }
  catch( ... )
  {
    excThr = "UNKNOWN exception caught in " + methodName;
    return dummyOut;
  }
}
#endif

//-----------------------------------------------------------------------------

void
cool::PyCool::Helpers::refreshDatabaseFromDbSvc( IDatabaseSvc* dbSvc,
                                                 const DatabaseId& dbId,
                                                 bool keepNodes )
{
  //std::cout << "PyCool::Helpers::refreshDatabaseFromDbSvc" << std::endl;
  if ( !dbSvc )
    throw RelationalException
      ( "Null IDatabaseSvc* in PyCool::Helpers::refreshDatabaseFromDbSvc" );
  RalDatabaseSvc* rdbSvc = dynamic_cast<RalDatabaseSvc*>( dbSvc );
  if ( !rdbSvc )
    throw RelationalException
      ( "Cannot cast to RalDatabaseSvc* "
        "in PyCool::Helpers::refreshDatabaseFromDbSvc" );
  rdbSvc->refreshDatabase( dbId, keepNodes );
}

//-----------------------------------------------------------------------------

void
cool::PyCool::Helpers::refreshDatabaseFromDb( IDatabase* db,
                                              bool keepNodes )
{
  //std::cout << "PyCool::Helpers::refreshDatabaseFromDb" << std::endl;
  if ( !db )
    throw RelationalException
      ( "Null IDatabase* in PyCool::Helpers::refreshDatabaseFromDb" );
  TransRalDatabase* rdb = dynamic_cast<TransRalDatabase*>( db );
  if ( !rdb )
    throw RelationalException
      ( "Cannot cast to TransRalDatabase* "
        "in PyCool::Helpers::refreshDatabaseFromDb" );
  rdb->refreshDatabase( keepNodes );
}

//-----------------------------------------------------------------------------
