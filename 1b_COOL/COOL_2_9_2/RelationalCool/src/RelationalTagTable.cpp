// $Id: RelationalTagTable.cpp,v 1.8 2009-12-17 17:05:54 avalassi Exp $

// Include files
#include "CoolKernel/RecordSpecification.h"

// Local include files
#include "RelationalTagTable.h"

//-----------------------------------------------------------------------------

const cool::IRecordSpecification&
cool::RelationalTagTable::tableSpecification()
{

  static RecordSpecification spec;

  if ( spec.size() == 0 ) {
    spec.extend( RelationalTagTable::columnNames::tagId,
                 RelationalTagTable::columnTypeIds::tagId );
    spec.extend( RelationalTagTable::columnNames::tagName,
                 RelationalTagTable::columnTypeIds::tagName );
    spec.extend( RelationalTagTable::columnNames::tagDescription,
                 RelationalTagTable::columnTypeIds::tagDescription );
    spec.extend( RelationalTagTable::columnNames::sysInsTime,
                 RelationalTagTable::columnTypeIds::sysInsTime );
  }

  return spec;

}

//-----------------------------------------------------------------------------
