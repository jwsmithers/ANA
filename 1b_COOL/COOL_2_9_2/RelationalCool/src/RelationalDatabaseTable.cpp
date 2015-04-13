// $Id: RelationalDatabaseTable.cpp,v 1.7 2006-09-28 12:49:29 avalassi Exp $

// Include files
#include "CoolKernel/RecordSpecification.h"

// Local include files
#include "RelationalDatabaseTable.h"

//-----------------------------------------------------------------------------

const cool::IRecordSpecification&
cool::RelationalDatabaseTable::tableSpecification()
{
  static cool::RecordSpecification spec;
  if ( spec.size() == 0 ) {
    spec.extend
      ( cool::RelationalDatabaseTable::columnNames::attributeName,
        cool::RelationalDatabaseTable::columnTypeIds::attributeName );
    spec.extend
      ( cool::RelationalDatabaseTable::columnNames::attributeValue,
        cool::RelationalDatabaseTable::columnTypeIds::attributeValue );
  }
  return spec;
}

//-----------------------------------------------------------------------------
