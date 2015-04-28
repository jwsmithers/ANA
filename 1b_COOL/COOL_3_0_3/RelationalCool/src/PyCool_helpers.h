#ifndef RELATIONALCOOL_PYCOOLHELPERS_H
#define RELATIONALCOOL_PYCOOLHELPERS_H 1

// First of all, set/unset CORAL290, COOL300, COOL400 and COOL_HAS_CPP11 macros
#include "CoolKernel/VersionInfo.h"

// Include files
#include "CoolKernel/FolderSpecification.h"
#include "CoolKernel/IDatabase.h"
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/IFolder.h"
#include "CoolKernel/IHvsNode.h"

namespace cool
{
  namespace PyCool
  {
    namespace Helpers
    {

      // Wrapper for exceptions in IDatabaseSvc::createDatabase (CORALCOOL-2743).
      // The "exceptionThrown" string is always reset to "" at the beginning
      // of this method: it is then set to a non-empty error message if an
      // exception is thrown (in which case a dummy retun value is returned).
      IDatabasePtr createDatabaseNoThrow( const IDatabaseSvc* ptr,
                                          std::string& excThr,
                                          const DatabaseId& dbId );

      // Wrapper for exceptions in IDatabaseSvc::openDatabase (CORALCOOL-2743).
      // The "exceptionThrown" string is always reset to "" at the beginning
      // of this method: it is then set to a non-empty error message if an
      // exception is thrown (in which case a dummy retun value is returned).
      IDatabasePtr openDatabaseNoThrow( const IDatabaseSvc* ptr,
                                        std::string& excThr,
                                        const DatabaseId& dbId,
                                        bool readOnly = true );

      // Wrapper for exceptions in IHvsNode::resolveTag (ATCONDDB-13).
      // The "exceptionThrown" string is always reset to "" at the beginning
      // of this method: it is then set to a non-empty error message if an
      // exception is thrown (in which case a dummy retun value is returned).
      const std::string resolveTagNoThrow( const IHvsNode* ptr,
                                           std::string& excThr,
                                           const std::string& ancestorTagName );

      // Wrapper for exceptions in IHvsNode::createTagRelation (ATCONDDB-13).
      // The "exceptionThrown" string is always reset to "" at the beginning
      // of this method: it is then set to a non-empty error message if an
      // exception is thrown (in which case a dummy retun value is returned).
      void createTagRelationNoThrow( const IHvsNode* ptr,
                                     std::string& excThr,
                                     const std::string& parentTagName,
                                     const std::string& tagName );

      // Wrapper for exceptions in IHvsNode::deleteTagRelation (ATCONDDB-13).
      // The "exceptionThrown" string is always reset to "" at the beginning
      // of this method: it is then set to a non-empty error message if an
      // exception is thrown (in which case a dummy retun value is returned).
      void deleteTagRelationNoThrow( const IHvsNode* ptr,
                                     std::string& excThr,
                                     const std::string& parentTagName );

      // Wrapper for exceptions in IHvsNode::findTagRelation (ATCONDDB-13).
      // The "exceptionThrown" string is always reset to "" at the beginning
      // of this method: it is then set to a non-empty error message if an
      // exception is thrown (in which case a dummy retun value is returned).
      const std::string findTagRelationNoThrow( const IHvsNode* ptr,
                                                std::string& excThr,
                                                const std::string& parentTagName );

      // Wrapper for exceptions in IHvsNode::setTagLockStatus (ATCONDDB-13).
      // The "exceptionThrown" string is always reset to "" at the beginning
      // of this method: it is then set to a non-empty error message if an
      // exception is thrown (in which case a dummy retun value is returned).
      void setTagLockStatusNoThrow( IHvsNode* ptr,
                                    std::string& excThr,
                                    const std::string& tagName,
                                    HvsTagLock::Status tagLockStatus );

      // Wrapper for exceptions in IDatabase::getFolderSet.
      // The "exceptionThrown" string is always reset to "" at the beginning
      // of this method: it is then set to a non-empty error message if an
      // exception is thrown (in which case a dummy retun value is returned).
      IFolderSetPtr getFolderSetNoThrow( IDatabase* ptr,
                                         std::string& excThr,
                                         const std::string& fullPath );

      // Wrapper for exceptions in IDatabase::getFolder.
      // The "exceptionThrown" string is always reset to "" at the beginning
      // of this method: it is then set to a non-empty error message if an
      // exception is thrown (in which case a dummy retun value is returned).
      IFolderPtr getFolderNoThrow( IDatabase* ptr,
                                   std::string& excThr,
                                   const std::string& fullPath );

      // Wrapper for exceptions in IFolder::findObject.
      // The "exceptionThrown" string is always reset to "" at the beginning
      // of this method: it is then set to a non-empty error message if an
      // exception is thrown (in which case a dummy retun value is returned).
      // [NB: explicit namespace cool::IObjectPtr is required due to ROOT-7011]
      cool::IObjectPtr findObjectNoThrow( IFolder* ptr,
                                          std::string& excThr,
                                          const ValidityKey& pointInTime,
                                          const ChannelId& channelId,
                                          const std::string& tagName );

      // Wrapper for exceptions in IFolder::browseObjects.
      // The "exceptionThrown" string is always reset to "" at the beginning
      // of this method: it is then set to a non-empty error message if an
      // exception is thrown (in which case a dummy retun value is returned).
      // [NB: explicit namespace cool::IObjectPtr is required due to ROOT-7011]
      IObjectIteratorPtr browseObjectsNoThrow( IFolder* ptr,
                                               std::string& excThr,
                                               const ValidityKey& since,
                                               const ValidityKey& until,
                                               const ChannelSelection& channels,
                                               const std::string& tagName = "",
                                               const IRecordSelection* payloadQuery = 0 );

      // Wrapper for exceptions in IFolder::cloneTagAsUserTag.
      // The "exceptionThrown" string is always reset to "" at the beginning
      // of this method: it is then set to a non-empty error message if an
      // exception is thrown (in which case a dummy retun value is returned).
      void cloneTagAsUserTagNoThrow( IFolder* ptr,
                                     std::string& excThr,
                                     const std::string& tagName,
                                     const std::string& tagClone,
                                     const std::string& description,
                                     bool forceOverwriteTag );

#ifdef COOL290VP
      // Wrapper for exceptions in FolderSpecification::FolderSpecification.
      // The "exceptionThrown" string is always reset to "" at the beginning
      // of this method: it is then set to a non-empty error message if an
      // exception is thrown (in which case a dummy retun value is returned).
      FolderSpecification
      FolderSpecificationNoThrow( std::string& excThr,
                                  FolderVersioning::Mode mode,
                                  const IRecordSpecification& pSpec,
                                  PayloadMode::Mode payloadMode );
#endif

      // Helper to call RelationalDatabase::refreshDatabase()
      void refreshDatabaseFromDbSvc( IDatabaseSvc* dbSvc,
                                     const DatabaseId& dbId,
                                     bool keepNodes = false );

      // Helper to call RelationalDatabase::refreshDatabase()
      void refreshDatabaseFromDb( IDatabase* db,
                                  bool keepNodes = false );

    }
  }
}

#endif // RELATIONALCOOL_PYCOOLHELPERS_H
