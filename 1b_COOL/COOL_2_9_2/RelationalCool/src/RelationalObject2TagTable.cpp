// $Id: RelationalObject2TagTable.cpp,v 1.16 2010-08-05 11:53:25 mwache Exp $

// Include files
#include "CoolKernel/RecordSpecification.h"

// Local include files
#include "RelationalObject2TagTable.h"

//-----------------------------------------------------------------------------

const cool::RecordSpecification
cool::RelationalObject2TagTable::tableSpecification( PayloadMode::Mode pMode )
{
  RecordSpecification spec;

  if ( spec.size() == 0 ) {
    spec.extend( RelationalObject2TagTable::columnNames::tagId,
                 RelationalObject2TagTable::columnTypeIds::tagId );
    spec.extend( RelationalObject2TagTable::columnNames::objectId,
                 RelationalObject2TagTable::columnTypeIds::objectId );
    spec.extend( RelationalObject2TagTable::columnNames::channelId,
                 RelationalObject2TagTable::columnTypeIds::channelId );
    spec.extend( RelationalObject2TagTable::columnNames::iovSince,
                 RelationalObject2TagTable::columnTypeIds::iovSince );
    spec.extend( RelationalObject2TagTable::columnNames::iovUntil,
                 RelationalObject2TagTable::columnTypeIds::iovUntil );
    spec.extend( RelationalObject2TagTable::columnNames::sysInsTime,
                 RelationalObject2TagTable::columnTypeIds::sysInsTime );
    // If the payload is in a separate table, add the payloadId
    if ( pMode == PayloadMode::SEPARATEPAYLOAD )
    {
      spec.extend( RelationalObject2TagTable::columnNames::payloadId,
                   RelationalObject2TagTable::columnTypeIds::payloadId );
    }
    else if ( pMode == PayloadMode::VECTORPAYLOAD )
    {
      spec.extend( RelationalObject2TagTable::columnNames::payloadSetId,
                   RelationalObject2TagTable::columnTypeIds::payloadSetId );
    }

  }
  return spec;

}

//-----------------------------------------------------------------------------
