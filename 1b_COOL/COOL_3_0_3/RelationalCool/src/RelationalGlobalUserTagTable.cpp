
// Include files
#include "CoolKernel/RecordSpecification.h"

// Local include files
#include "RelationalGlobalUserTagTable.h"

//-----------------------------------------------------------------------------

const cool::IRecordSpecification&
cool::RelationalGlobalUserTagTable::tableSpecification()
{
  static RecordSpecification spec;

  if ( spec.size() == 0 )
  {
    spec.extend( RelationalGlobalUserTagTable::columnNames::nodeId,
                 RelationalGlobalUserTagTable::columnTypeIds::nodeId );
    spec.extend( RelationalGlobalUserTagTable::columnNames::tagId,
                 RelationalGlobalUserTagTable::columnTypeIds::tagId );
    spec.extend( RelationalGlobalUserTagTable::columnNames::tagType,
                 RelationalGlobalUserTagTable::columnTypeIds::tagType );
  }
  return spec;

}

//-----------------------------------------------------------------------------
