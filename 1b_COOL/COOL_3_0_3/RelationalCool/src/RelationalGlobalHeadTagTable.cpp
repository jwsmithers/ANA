
// Include files
#include "CoolKernel/RecordSpecification.h"

// Local include files
#include "RelationalGlobalHeadTagTable.h"

//-----------------------------------------------------------------------------

const cool::IRecordSpecification&
cool::RelationalGlobalHeadTagTable::tableSpecification()
{
  static RecordSpecification spec;

  if ( spec.size() == 0 )
  {
    spec.extend( RelationalGlobalHeadTagTable::columnNames::nodeId,
                 RelationalGlobalHeadTagTable::columnTypeIds::nodeId );
    spec.extend( RelationalGlobalHeadTagTable::columnNames::tagId,
                 RelationalGlobalHeadTagTable::columnTypeIds::tagId );
    spec.extend( RelationalGlobalHeadTagTable::columnNames::tagType,
                 RelationalGlobalHeadTagTable::columnTypeIds::tagType );
  }
  return spec;

}

//-----------------------------------------------------------------------------
