#ifndef RELATIONALCOOL_RELATIONALOBJECT2TAGTABLE_H
#define RELATIONALCOOL_RELATIONALOBJECT2TAGTABLE_H 1

// Include files
#include <cstdio> // For sprintf on gcc45
#include <cstring>
//#include "CoolKernel/PayloadMode.h"
#include "PayloadMode.h" // TEMPORARY
#include "CoolKernel/StorageType.h"

// Local include files
#include "scoped_enums.h"
#include "uppercaseString.h"

namespace cool
{

  // Forward declarations
  class IRecordSpecification;

  /** @namespace cool::RelationalObject2TagTable RelationalObject2TagTable.h
   *
   *  Relational schema of the table storing COOL tag <--> object relations.
   *
   *  @author Andrea Valassi, Sven A. Schmidt and Marco Clemencic
   *  @date   2005-02-06
   *///

  namespace RelationalObject2TagTable {

    inline const std::string defaultTableName
    ( const std::string& prefix, unsigned nodeId ) {
      char tableName[] = "Fxxxx_IOV2TAG";
      snprintf( tableName, strlen(tableName)+1, // Fix Coverity SECURE_CODING
                "F%4.4u_IOV2TAG", nodeId );
      // TEMPORARY? AV 04.04.2005
      // FIXME: presently the input prefix is uppercase anyway...
      return uppercaseString( prefix ) + std::string( tableName );
    }

    namespace columnNames {
      static const std::string tagId = "TAG_ID";
      static const std::string objectId = "OBJECT_ID";
      static const std::string channelId = "CHANNEL_ID";
      static const std::string iovSince = "IOV_SINCE";
      static const std::string iovUntil = "IOV_UNTIL";
      static const std::string payloadId = "PAYLOAD_ID";
      static const std::string payloadSetId = "PAYLOAD_SET_ID";
      static const std::string sysInsTime = "SYS_INSTIME";
    }

    namespace columnTypeIds {
      static const StorageType::TypeId tagId      = cool_StorageType_TypeId::UInt32;
      static const StorageType::TypeId objectId   = cool_StorageType_TypeId::UInt32;
      static const StorageType::TypeId channelId  = cool_StorageType_TypeId::UInt32;
      static const StorageType::TypeId iovSince   = cool_StorageType_TypeId::UInt63;
      static const StorageType::TypeId iovUntil   = cool_StorageType_TypeId::UInt63;
      static const StorageType::TypeId payloadId  = cool_StorageType_TypeId::UInt32;
      static const StorageType::TypeId payloadSetId = cool_StorageType_TypeId::UInt32;
      // TEMPORARY! Should be Time?
      static const StorageType::TypeId sysInsTime = cool_StorageType_TypeId::String255;
    }

    namespace columnTypes {
      typedef UInt32 tagId;
      typedef UInt32 objectId;
      typedef UInt32 channelId;
      typedef UInt63 iovSince;
      typedef UInt63 iovUntil;
      typedef UInt32 payloadId;
      typedef UInt32 payloadSetId;
      // TEMPORARY! Should be Time?
      typedef String255 sysInsTime;
    }

    /// Get the RecordSpecification of the tag table
    const RecordSpecification tableSpecification( PayloadMode::Mode pMode );

  }

}

#endif // RELATIONALCOOL_RELATIONALOBJECT2TAGTABLE_H
