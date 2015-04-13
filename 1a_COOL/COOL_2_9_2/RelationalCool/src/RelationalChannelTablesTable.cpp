// $Id: RelationalChannelTablesTable.cpp,v 1.2 2009-12-16 17:17:37 avalassi Exp $

// Include files
#include "CoolKernel/RecordSpecification.h"

// Local include files
#include "RelationalChannelTablesTable.h"

//-----------------------------------------------------------------------------

const cool::IRecordSpecification&
cool::RelationalChannelTablesTable::tableSpecification()
{
  static RecordSpecification spec;

  if ( spec.size() == 0 )
  {
    spec.extend
      ( RelationalChannelTablesTable::columnNames::chTableName,
        RelationalChannelTablesTable::columnTypeIds::chTableName );
    spec.extend
      ( RelationalChannelTablesTable::columnNames::chTableSchemaVersion,
        RelationalChannelTablesTable::columnTypeIds::chTableSchemaVersion );
    spec.extend
      ( RelationalChannelTablesTable::columnNames::chTableVersioningMode,
        RelationalChannelTablesTable::columnTypeIds::chTableVersioningMode );
    spec.extend
      ( RelationalChannelTablesTable::columnNames::chTableInsertionTime,
        RelationalChannelTablesTable::columnTypeIds::chTableInsertionTime );
    spec.extend
      ( RelationalChannelTablesTable::columnNames::channelSpecDesc,
        RelationalChannelTablesTable::columnTypeIds::channelSpecDesc );
    spec.extend
      ( RelationalChannelTablesTable::columnNames::channelExtRef,
        RelationalChannelTablesTable::columnTypeIds::channelExtRef );
  }
  return spec;

}

//-----------------------------------------------------------------------------
