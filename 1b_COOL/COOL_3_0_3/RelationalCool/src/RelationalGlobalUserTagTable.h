#ifndef RELATIONALCOOL_RELATIONALGLOBALUSERTAGTABLE_H
#define RELATIONALCOOL_RELATIONALGLOBALUSERTAGTABLE_H 1

// Include files
#include "CoolKernel/StorageType.h"

// Local include files
#include "scoped_enums.h"
#include "uppercaseString.h"

namespace cool
{

  // Forward declarations
  class IRecordSpecification;

  /** @namespace cool::RelationalGlobalUserTagTable RelationalGlobalUserTagTable.h
   *
   *  Relational schema of the table storing COOL global user tags.
   *
   *  @author Andrea Valassi
   *  @date   2007-02-15
   *///

  namespace RelationalGlobalUserTagTable {

    inline const std::string defaultTableName( const std::string& prefix )
    {
      return uppercaseString(prefix) + "USERTAGS";
    }

    namespace columnNames
    {
      static const std::string nodeId  = "NODE_ID";
      static const std::string tagId   = "TAG_ID";
      // Tag type (NOT NULL): 0(unknown), 1(head), 2(user)
      // Tag type must be equal to 2 (CHECK constraint) for the user tag table
      static const std::string tagType = "TAG_TYPE";
    }

    namespace columnTypeIds
    {
      static const StorageType::TypeId nodeId  = cool_StorageType_TypeId::UInt32;
      static const StorageType::TypeId tagId   = cool_StorageType_TypeId::UInt32;
      static const StorageType::TypeId tagType = cool_StorageType_TypeId::UInt16;
    }

    namespace columnTypes
    {
      typedef UInt32 nodeId;
      typedef UInt32 tagId;
      typedef UInt16 tagType;
    }

    /// Get the record specification of the global user tag table
    const IRecordSpecification& tableSpecification();

  }

}

#endif // RELATIONALCOOL_RELATIONALGLOBALUSERTAGTABLE_H
