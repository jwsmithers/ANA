
// Include files
#include "CoolKernel/RecordSpecification.h"

// Local include files
#include "RelationalSharedSequenceTable.h"

//-----------------------------------------------------------------------------

const cool::IRecordSpecification&
cool::RelationalSharedSequenceTable::tableSpecification
( bool nodeIdOnly )
{
  static RecordSpecification spec_all;
  static RecordSpecification spec_id_only;
  RecordSpecification& spec = nodeIdOnly ? spec_id_only : spec_all;

  if ( spec.size() == 0 )
  {

    // Include the first column (the nodeId)
    spec.extend
      ( RelationalSharedSequenceTable::columnNames::nodeId,
        RelationalSharedSequenceTable::columnTypeIds::nodeId );

    // Include also all columns after the first column (the nodeId)
    if ( ! nodeIdOnly )
    {
      spec.extend
        ( RelationalSharedSequenceTable::columnNames::currentValue,
          RelationalSharedSequenceTable::columnTypeIds::currentValue );
      spec.extend
        ( RelationalSharedSequenceTable::columnNames::lastModDate,
          RelationalSharedSequenceTable::columnTypeIds::lastModDate );
    }

  }
  return spec;

}

//-----------------------------------------------------------------------------
