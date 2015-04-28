
// Include files
#include "CoolKernel/RecordSpecification.h"

// Local include files
#include "RelationalGlobalTagTable.h"

//-----------------------------------------------------------------------------

const cool::IRecordSpecification&
cool::RelationalGlobalTagTable::tableSpecification()
{
  static RecordSpecification spec;

  if ( spec.size() == 0 ) {
    spec.extend( RelationalGlobalTagTable::columnNames::nodeId,
                 RelationalGlobalTagTable::columnTypeIds::nodeId );
    spec.extend( RelationalGlobalTagTable::columnNames::tagId,
                 RelationalGlobalTagTable::columnTypeIds::tagId );
    spec.extend( RelationalGlobalTagTable::columnNames::tagName,
                 RelationalGlobalTagTable::columnTypeIds::tagName );
    spec.extend( RelationalGlobalTagTable::columnNames::tagLockStatus,
                 RelationalGlobalTagTable::columnTypeIds::tagLockStatus );
    spec.extend( RelationalGlobalTagTable::columnNames::tagDescription,
                 RelationalGlobalTagTable::columnTypeIds::tagDescription );
    /*
    // *** START *** 3.0.0 schema extensions (task #4396)
    spec.extend( RelationalGlobalTagTable::columnNames::tagType,
                 RelationalGlobalTagTable::columnTypeIds::tagType );
    // **** END **** 3.0.0 schema extensions (task #4396)
    *///
    spec.extend( RelationalGlobalTagTable::columnNames::sysInsTime,
                 RelationalGlobalTagTable::columnTypeIds::sysInsTime );
  }
  return spec;

}

//-----------------------------------------------------------------------------
