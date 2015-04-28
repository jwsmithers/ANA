#ifndef RELATIONALCOOL_RELATIONALSEQUENCETABLE_H
#define RELATIONALCOOL_RELATIONALSEQUENCETABLE_H 1

// Include files
#include "CoolKernel/StorageType.h"

// Local include files
#include "scoped_enums.h"

namespace cool
{

  // Forward declarations
  class IRecordSpecification;

  /** @namespace cool::RelationalSequenceTable RelationalSequenceTable.h
   *
   *  Relational schema of the tables implementing "sequence" functionalities.
   *
   *  @author Andrea Valassi, Sven A. Schmidt and Marco Clemencic
   *  @date   2005-04-15
   *///

  namespace RelationalSequenceTable {

    namespace columnNames {
      static const std::string sequenceName = "SEQUENCE_NAME";
      static const std::string currentValue = "CURRENT_VALUE";
      static const std::string lastModDate = "LASTMOD_DATE";
    }

    namespace columnTypeIds {
      static const StorageType::TypeId sequenceName = cool_StorageType_TypeId::String255;
      static const StorageType::TypeId currentValue = cool_StorageType_TypeId::UInt32;
      static const StorageType::TypeId lastModDate  = cool_StorageType_TypeId::String255;
    }

    namespace columnTypes {
      typedef String255 sequenceName;
      typedef UInt32 currentValue;
      typedef String255 lastModDate;
    }

    /// Get the RecordSpecification of the sequence table.
    /// If the flag is true, include only the first column (the sequence name).
    const IRecordSpecification&
    tableSpecification( bool seqNameOnly = false );

  }

}

#endif // RELATIONALCOOL_RELATIONALSEQUENCETABLE_H
