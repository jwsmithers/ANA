// $Id: RelationalSequenceTable.cpp,v 1.8 2009-12-16 17:17:38 avalassi Exp $

// Include files
#include "CoolKernel/RecordSpecification.h"

// Local include files
#include "RelationalSequenceTable.h"

//-----------------------------------------------------------------------------

const cool::IRecordSpecification&
cool::RelationalSequenceTable::tableSpecification
( bool seqNameOnly )
{
  static RecordSpecification spec_all;
  static RecordSpecification spec_name_only;
  RecordSpecification& spec = seqNameOnly ? spec_name_only : spec_all;

  if ( spec.size() == 0 ) {
    // Include the first column (the sequence name)
    spec.extend( RelationalSequenceTable::columnNames::sequenceName,
                 RelationalSequenceTable::columnTypeIds::sequenceName );
    // Include also all columns after the first column (the sequence name)
    if ( ! seqNameOnly ) {
      spec.extend( RelationalSequenceTable::columnNames::currentValue,
                   RelationalSequenceTable::columnTypeIds::currentValue );
      spec.extend( RelationalSequenceTable::columnNames::lastModDate,
                   RelationalSequenceTable::columnTypeIds::lastModDate );
    }
  }

  return spec;

}

//-----------------------------------------------------------------------------
