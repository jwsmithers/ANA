// First of all, enable or disable the COOL290 API extensions (bug #92204)
#include "CoolKernel/VersionInfo.h"

// Include files
#include "CoralBase/AttributeSpecification.h"

// Local include files
#include "RelationalPayloadTable.h"
#include "RelationalPayloadTableRow.h"
#include "scoped_enums.h"
#include "timeToString.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

RelationalPayloadTableRow::~RelationalPayloadTableRow()
{
}

//-----------------------------------------------------------------------------

RelationalPayloadTableRow::RelationalPayloadTableRow
( const coral::AttributeList& data )
  : RelationalTableRowBase( data )
{
}

//-----------------------------------------------------------------------------

RelationalPayloadTableRow::RelationalPayloadTableRow( const IObjectPtr& object,
                                                      PayloadMode::Mode pMode )
  : RelationalTableRowBase( RelationalPayloadTable::rowAttributeList
                            ( object->payload().attributeList(),
                              pMode ) )
{

  if ( pMode == cool_PayloadMode_Mode::SEPARATEPAYLOAD )
    m_data[RelationalPayloadTable::columnNames::payloadId()].setValue
      ( object->payloadId() );
#ifdef COOL290VP
  else if ( pMode == cool_PayloadMode_Mode::VECTORPAYLOAD )
    m_data[RelationalPayloadTable::columnNames::payloadSetId()].setValue
      ( object->payloadSetId() );
#endif

  // Add the data payload columns
  const coral::AttributeList& payload = object->payload().attributeList();
  for ( coral::AttributeList::const_iterator attr = payload.begin();
        attr != payload.end();
        ++attr ) {
    // share data instead of copying
    m_data[ attr->specification().name() ].shareData( *attr );
    // copy
    //coral::AttributeValueAccessor
    //( (*m_data)[ attr->spec().name() ] ).setValueFromData
    //( coral::AttributeValueAccessor( *attr ).getMemoryAddress() );
  }

}

//-----------------------------------------------------------------------------

RelationalPayloadTableRow::RelationalPayloadTableRow( const IRecord& record,
                                                      PayloadMode::Mode pMode )
  : RelationalTableRowBase( RelationalPayloadTable::rowAttributeList
                            ( record.attributeList(),
                              pMode ) )
{

  // Add the data payload columns
  const coral::AttributeList& payload = record.attributeList();
  for ( coral::AttributeList::const_iterator attr = payload.begin();
        attr != payload.end();
        ++attr ) {
    // share data instead of copying
    m_data[ attr->specification().name() ].shareData( *attr );
    // copy
    //coral::AttributeValueAccessor
    //( (*m_data)[ attr->spec().name() ] ).setValueFromData
    //( coral::AttributeValueAccessor( *attr ).getMemoryAddress() );
  }

}


//-----------------------------------------------------------------------------

RelationalPayloadTableRow::RelationalPayloadTableRow
( const RelationalTableRow& row )
  : RelationalTableRowBase( row.data() )
{
}

//-----------------------------------------------------------------------------

RelationalPayloadTableRow::RelationalPayloadTableRow
( const RelationalPayloadTableRow& aRow )
  : RelationalTableRowBase( aRow )
{
}

//-----------------------------------------------------------------------------

unsigned int RelationalPayloadTableRow::payloadId() const
{
  return
    m_data[RelationalPayloadTable::columnNames::payloadId()].data<unsigned int>();
}

//-----------------------------------------------------------------------------

void RelationalPayloadTableRow::setPayloadId( const unsigned int payloadId )
{
  m_data[RelationalPayloadTable::columnNames::payloadId()].setValue( payloadId );
}

//-----------------------------------------------------------------------------

unsigned int RelationalPayloadTableRow::payloadSetId() const
{
  return
    m_data[RelationalPayloadTable::columnNames::payloadSetId()].data<unsigned int>();
}

//-----------------------------------------------------------------------------

void RelationalPayloadTableRow::setPayloadSetId( const unsigned int payloadSetId )
{
  m_data[RelationalPayloadTable::columnNames::payloadSetId()].setValue( payloadSetId );
}

//-----------------------------------------------------------------------------

unsigned int RelationalPayloadTableRow::payloadItemId() const
{
  return
    m_data[RelationalPayloadTable::columnNames::payloadItemId()].data<unsigned int>();
}

//-----------------------------------------------------------------------------

void RelationalPayloadTableRow::setPayloadItemId( const unsigned int payloadItemId )
{
  m_data[RelationalPayloadTable::columnNames::payloadItemId()].setValue( payloadItemId );
}

//-----------------------------------------------------------------------------
