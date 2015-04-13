// $Id: RelationalIovTablesTable.cpp,v 1.2 2009-12-16 17:17:37 avalassi Exp $

// Include files
#include "CoolKernel/RecordSpecification.h"

// Local include files
#include "RelationalIovTablesTable.h"

//-----------------------------------------------------------------------------

const cool::IRecordSpecification&
cool::RelationalIovTablesTable::tableSpecification()
{
  static RecordSpecification spec;

  if ( spec.size() == 0 )
  {
    spec.extend
      ( RelationalIovTablesTable::columnNames::iovTableName,
        RelationalIovTablesTable::columnTypeIds::iovTableName );
    spec.extend
      ( RelationalIovTablesTable::columnNames::iovTableSchemaVersion,
        RelationalIovTablesTable::columnTypeIds::iovTableSchemaVersion );
    spec.extend
      ( RelationalIovTablesTable::columnNames::iovTableVersioningMode,
        RelationalIovTablesTable::columnTypeIds::iovTableVersioningMode );
    spec.extend
      ( RelationalIovTablesTable::columnNames::iovTableInsertionTime,
        RelationalIovTablesTable::columnTypeIds::iovTableInsertionTime );
    spec.extend
      ( RelationalIovTablesTable::columnNames::payloadSpecDesc,
        RelationalIovTablesTable::columnTypeIds::payloadSpecDesc );
    spec.extend
      ( RelationalIovTablesTable::columnNames::payloadInline,
        RelationalIovTablesTable::columnTypeIds::payloadInline );
    spec.extend
      ( RelationalIovTablesTable::columnNames::payloadExtRef,
        RelationalIovTablesTable::columnTypeIds::payloadExtRef );
  }
  return spec;

}

//-----------------------------------------------------------------------------
