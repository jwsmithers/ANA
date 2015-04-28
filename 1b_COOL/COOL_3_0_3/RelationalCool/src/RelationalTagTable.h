#ifndef RELATIONALCOOL_RELATIONALTAGTABLE_H
#define RELATIONALCOOL_RELATIONALTAGTABLE_H 1

// Include files
#include <cstdio> // For sprintf on gcc45
#include <cstring>

// Local include files
#include "scoped_enums.h"
#include "uppercaseString.h"

namespace cool
{

  // Forward declarations
  class IRecordSpecification;

  /** @namespace cool::RelationalTagTable RelationalTagTable.h
   *
   *  Relational schema of the table storing COOL local tags.
   *
   *  @author Andrea Valassi, Sven A. Schmidt and Marco Clemencic
   *  @date   2005-02-05
   *///

  namespace RelationalTagTable {

    inline const std::string defaultTableName
    ( const std::string& prefix, unsigned nodeId ) {
      char tableName[] = "Fxxxx_TAGS";
      snprintf( tableName, strlen(tableName)+1, // Fix Coverity SECURE_CODING
                "F%4.4u_TAGS", nodeId );
      return uppercaseString( prefix ) + std::string( tableName );
    }

    inline const std::string sequenceName( const std::string& tableName ) {
      return uppercaseString(tableName) + "_SEQ";
    }

    namespace columnNames {
      static const std::string tagId = "TAG_ID";
      static const std::string tagName = "TAG_NAME";
      static const std::string tagDescription = "TAG_DESCRIPTION";
      static const std::string sysInsTime = "SYS_INSTIME";
    }

    namespace columnTypeIds {
      static const StorageType::TypeId tagId          = cool_StorageType_TypeId::UInt32;
      static const StorageType::TypeId tagName        = cool_StorageType_TypeId::String255;
      static const StorageType::TypeId tagDescription = cool_StorageType_TypeId::String255;
      // TEMPORARY! Should be Time?
      static const StorageType::TypeId sysInsTime     = cool_StorageType_TypeId::String255;
    }

    namespace columnTypes {
      typedef UInt32 tagId;
      typedef String255 tagName;
      typedef String255 tagDescription;
      // TEMPORARY! Should be Time?
      typedef String255 sysInsTime;
    }

    /// Get the RecordSpecification of the tag table
    const IRecordSpecification& tableSpecification();

  }

}

#endif // RELATIONALCOOL_RELATIONALTAGTABLE_H
