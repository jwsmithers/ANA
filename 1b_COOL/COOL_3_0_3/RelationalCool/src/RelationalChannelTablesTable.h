#ifndef RELATIONALCOOL_RELATIONALCHANNELTABLESTABLE_H
#define RELATIONALCOOL_RELATIONALCHANNELTABLESTABLE_H 1

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

  /** @namespace cool::RelationalChannelTablesTable RelationalChannelTablesTable.h
   *
   *  Relational schema of the table storing metadata of COOL channel tables.
   *
   *  @author Andrea Valassi
   *  @date   2007-02-15
   *///

  namespace RelationalChannelTablesTable {

    inline const std::string defaultTableName( const std::string& prefix )
    {
      return uppercaseString(prefix) + "CHANNELTABLES";
    }

    namespace columnNames
    {
      static const
      std::string chTableName = "CHANNELTABLE_NAME";
      static const
      std::string chTableSchemaVersion = "CHANNELTABLE_SCHEMA_VERSION";
      static const
      std::string chTableVersioningMode = "CHANNELTABLE_VERSIONING";
      static const
      std::string chTableInsertionTime = "CHANNELTABLE_INSTIME";
      static const
      std::string channelSpecDesc = "CHANNEL_SPEC";
      static const
      std::string channelExtRef = "CHANNEL_EXTREF";
    }

    namespace columnTypeIds
    {
      static const
      StorageType::TypeId chTableName = cool_StorageType_TypeId::String255;
      static const
      StorageType::TypeId chTableSchemaVersion = cool_StorageType_TypeId::String255;
      static const
      StorageType::TypeId chTableVersioningMode = cool_StorageType_TypeId::Int32;
      static const
      StorageType::TypeId chTableInsertionTime = cool_StorageType_TypeId::String255;
      static const
      StorageType::TypeId channelSpecDesc = cool_StorageType_TypeId::String64k;
      static const
      StorageType::TypeId channelExtRef = cool_StorageType_TypeId::String64k;
    }

    namespace columnTypes
    {
      typedef String255 chTableName;
      typedef String255 chTableSchemaVersion;
      typedef Int32 chTableVersioningMode;
      typedef String255 chTableInsertionTime;
      typedef String64k channelSpecDesc;
      typedef String64k channelExtRef;
    }

    /// Get the record specification of the channelTables table.
    const IRecordSpecification& tableSpecification();

  }

}

#endif // RELATIONALCOOL_RELATIONALCHANNELTABLESTABLE_H
