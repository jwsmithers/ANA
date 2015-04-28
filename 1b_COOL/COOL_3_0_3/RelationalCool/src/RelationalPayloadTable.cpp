// Include files
//#include "CoralBase/AttributeSpecification.h"
#include "CoralBase/Attribute.h"

// Local include files
#include "RelationalException.h"
#include "RelationalPayloadTable.h"

// Namespace
using namespace cool;

//---------------------------------------------------------------------------

const IRecordSpecification&
RelationalPayloadTable::defaultSpecification( PayloadMode::Mode pMode )
{
  static RecordSpecification specVector;
  static RecordSpecification specSeparate;

  if ( specSeparate.size() == 0 ) {
    specSeparate.extend( RelationalPayloadTable::columnNames::payloadId(),
                         RelationalPayloadTable::columnTypeIds::payloadId );
    specSeparate.extend( RelationalPayloadTable::columnNames::p_sysInsTime(),
                         RelationalPayloadTable::columnTypeIds::p_sysInsTime );
  }
  if ( specVector.size() == 0 ) {
    specVector.extend( RelationalPayloadTable::columnNames::payloadSetId(),
                       RelationalPayloadTable::columnTypeIds::payloadSetId );
    specVector.extend( RelationalPayloadTable::columnNames::payloadItemId(),
                       RelationalPayloadTable::columnTypeIds::payloadItemId );
    specVector.extend( RelationalPayloadTable::columnNames::p_sysInsTime(),
                       RelationalPayloadTable::columnTypeIds::p_sysInsTime );
  }

  if ( pMode == cool_PayloadMode_Mode::SEPARATEPAYLOAD )
    return specSeparate;
  else if ( pMode == cool_PayloadMode_Mode::VECTORPAYLOAD )
    return specVector;
  else
    throw PanicException( "using RelationalPayloadTable in INLINEPAYLOAD mode",
                          "RelationalPayloadTable::defaultSpecification" );
}

//--------------------------------------------------------------------------

const RecordSpecification
RelationalPayloadTable::tableSpecification( const IRecordSpecification& payloadSpec,
                                            PayloadMode::Mode pMode )
{
  RecordSpecification spec;
  for ( unsigned int i=0; i<defaultSpecification( pMode ).size(); i++ ) {
    const IFieldSpecification& field = defaultSpecification( pMode )[i];
    spec.extend( field.name(), field.storageType() );
  }
  for ( unsigned int i=0; i<payloadSpec.size(); i++ ) {
    const IFieldSpecification& field = payloadSpec[i];
    spec.extend( field.name(), field.storageType() );
  }
  return spec;
}

//--------------------------------------------------------------------------

const coral::AttributeList
RelationalPayloadTable::rowAttributeList
( const coral::AttributeList& payload, PayloadMode::Mode pMode )
{
  RecordSpecification tmp=defaultSpecification( pMode );

  coral::AttributeList al = Record( tmp ).attributeList();
  // User-defined payload columns
  for ( coral::AttributeList::const_iterator
          i = payload.begin(); i != payload.end(); ++i ) {
    al.extend( i->specification().name(), i->specification().typeName() );
  }

  return al;
}
