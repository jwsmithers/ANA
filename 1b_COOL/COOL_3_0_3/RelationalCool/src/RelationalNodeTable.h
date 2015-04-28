#ifndef RELATIONALCOOL_RELATIONALNODETABLE_H
#define RELATIONALCOOL_RELATIONALNODETABLE_H 1

// Include files
#include "CoolKernel/StorageType.h"

// Local include files
#include "VersionNumber.h"
#include "scoped_enums.h"
#include "uppercaseString.h"

namespace cool
{

  // Forward declarations
  class IRecordSpecification;

  /** @namespace cool::RelationalNodeTable RelationalNodeTable.h
   *
   *  Relational schema of the table storing COOL HVS "nodes"
   *  (conditions database "folders" and "folder sets").
   *
   *  @author Andrea Valassi, Sven A. Schmidt and Marco Clemencic
   *  @date   2004-12-16
   *///

  namespace RelationalNodeTable {

    inline const std::string defaultTableName( const std::string& prefix )
    {
      // TEMPORARY? AV 04.04.2005
      // FIXME: presently the input prefix is uppercase anyway...
      return uppercaseString(prefix) + "NODES";
    }

    inline const std::string sequenceName( const std::string& tableName )
    {
      // TEMPORARY? AV 04.04.2005
      // FIXME: presently the input table name is uppercase anyway...
      return uppercaseString(tableName) + "_SEQ";
    }

    namespace columnNames
    {
      static const
      std::string nodeId = "NODE_ID";
      static const
      std::string nodeParentId = "NODE_PARENTID";
      static const
      std::string nodeName = "NODE_NAME";
      static const
      std::string nodeFullPath = "NODE_FULLPATH";
      static const
      std::string nodeDescription = "NODE_DESCRIPTION";
      static const
      std::string nodeIsLeaf = "NODE_ISLEAF";
      static const
      std::string nodeSchemaVersion = "NODE_SCHEMA_VERSION";
      static const
      std::string nodeInsertionTime = "NODE_INSTIME";
      static const
      std::string lastModDate = "LASTMOD_DATE";
      static const
      std::string folderPayloadSpecDesc = "FOLDER_PAYLOADSPEC";
      static const
      std::string folderPayloadInline = "FOLDER_PAYLOAD_INLINE";
      static const
      std::string folderPayloadExtRef = "FOLDER_PAYLOAD_EXTREF";
      static const
      std::string folderChannelSpecDesc = "FOLDER_CHANNELSPEC";
      static const
      std::string folderChannelExtRef = "FOLDER_CHANNEL_EXTREF";
      static const
      std::string folderVersioningMode = "FOLDER_VERSIONING";
      static const
      std::string folderObjectTableName = "FOLDER_IOVTABLENAME";
      static const
      std::string folderTagTableName = "FOLDER_TAGTABLENAME";
      static const
      std::string folderObject2TagTableName = "FOLDER_IOV2TAGTABLENAME";
      static const
      std::string folderChannelTableName = "FOLDER_CHANNELTABLENAME";
    }

    namespace columnTypeIds
    {
      static const
      StorageType::TypeId nodeId                    = cool_StorageType_TypeId::UInt32;
      static const
      StorageType::TypeId nodeParentId              = cool_StorageType_TypeId::UInt32;
      static const
      StorageType::TypeId nodeName                  = cool_StorageType_TypeId::String255;
      static const
      StorageType::TypeId nodeFullPath              = cool_StorageType_TypeId::String255;
      static const
      StorageType::TypeId nodeDescription           = cool_StorageType_TypeId::String255;
      static const
      StorageType::TypeId nodeIsLeaf                = cool_StorageType_TypeId::Bool;
      static const
      StorageType::TypeId nodeSchemaVersion         = cool_StorageType_TypeId::String255;
      static const
      StorageType::TypeId nodeInsertionTime         = cool_StorageType_TypeId::String255;
      static const
      StorageType::TypeId lastModDate               = cool_StorageType_TypeId::String255;
      static const
      StorageType::TypeId folderPayloadSpecDesc     = cool_StorageType_TypeId::String64k;
      static const
      StorageType::TypeId folderPayloadInline       = cool_StorageType_TypeId::UInt16;
      static const
      StorageType::TypeId folderPayloadExtRef       = cool_StorageType_TypeId::String64k;
      static const
      StorageType::TypeId folderChannelSpecDesc     = cool_StorageType_TypeId::String64k;
      static const
      StorageType::TypeId folderChannelExtRef       = cool_StorageType_TypeId::String64k;
      static const
      StorageType::TypeId folderVersioningMode      = cool_StorageType_TypeId::Int32;
      static const
      StorageType::TypeId folderObjectTableName     = cool_StorageType_TypeId::String255;
      static const
      StorageType::TypeId folderTagTableName        = cool_StorageType_TypeId::String255;
      static const
      StorageType::TypeId folderObject2TagTableName = cool_StorageType_TypeId::String255;
      static const
      StorageType::TypeId folderChannelTableName    = cool_StorageType_TypeId::String255;
    }

    namespace columnTypes
    {
      typedef UInt32 nodeId;
      typedef UInt32 nodeParentId;
      typedef String255 nodeName;
      typedef String255 nodeFullPath;
      typedef String255 nodeDescription;
      typedef Bool nodeIsLeaf;
      typedef String255 nodeSchemaVersion;
      typedef String255 nodeInsertionTime;
      typedef String255 lastModDate;
      typedef String64k folderPayloadSpecDesc;
      typedef UInt16 folderPayloadInline;
      typedef String64k folderPayloadExtRef;
      typedef String64k folderChannelSpecDesc;
      typedef String64k folderChannelExtRef;
      typedef Int32 folderVersioningMode;
      typedef String255 folderObjectTableName;
      typedef String255 folderTagTableName;
      typedef String255 folderObject2TagTableName;
      typedef String255 folderChannelTableName;
    }

    /// Get the record specification of the folder table for this release.
    const IRecordSpecification&
    tableSpecification();

    /// Get the record specification of the folder table for a given
    /// COOL release (this is needed by the schema evolution tools).
    const IRecordSpecification&
    tableSpecification( const VersionNumber& dbSchemaVersion );

  }

}

#endif // RELATIONALCOOL_RELATIONALNODETABLE_H
