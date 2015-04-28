
// Include files
#include "CoolKernel/RecordSpecification.h"

// Local include files
#include "RelationalTag2TagTable.h"

//-----------------------------------------------------------------------------

const cool::IRecordSpecification &
cool::RelationalTag2TagTable::tableSpecification()
{
  static RecordSpecification spec;
  if ( spec.size() == 0 ) {
    spec.extend( RelationalTag2TagTable::columnNames::parentNodeId,
                 RelationalTag2TagTable::columnTypeIds::parentNodeId );
    spec.extend( RelationalTag2TagTable::columnNames::parentTagId,
                 RelationalTag2TagTable::columnTypeIds::parentTagId );
    spec.extend( RelationalTag2TagTable::columnNames::childNodeId,
                 RelationalTag2TagTable::columnTypeIds::childNodeId );
    spec.extend( RelationalTag2TagTable::columnNames::childTagId,
                 RelationalTag2TagTable::columnTypeIds::childTagId );
    spec.extend( RelationalTag2TagTable::columnNames::sysInsTime,
                 RelationalTag2TagTable::columnTypeIds::sysInsTime );
  }
  return spec;
}

//-----------------------------------------------------------------------------
