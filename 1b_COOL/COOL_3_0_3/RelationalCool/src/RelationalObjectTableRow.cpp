// Include files
#include "CoralBase/AttributeSpecification.h"

// Local include files
#include "RelationalException.h"
#include "RelationalObjectTableRow.h"
#include "RelationalPayloadTable.h"
#include "timeToString.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

RelationalObjectTableRow::~RelationalObjectTableRow()
{
}

//-----------------------------------------------------------------------------

RelationalObjectTableRow::RelationalObjectTableRow
( const coral::AttributeList& data )
  : RelationalTableRowBase( data )
{
}

//-----------------------------------------------------------------------------

RelationalObjectTableRow::RelationalObjectTableRow( const IObjectPtr& object,
                                                    PayloadMode::Mode mode )
  : RelationalTableRowBase( RelationalObjectTable::rowAttributeList
                            ( object->payload().attributeList(), mode ) )
{

  m_data[RelationalObjectTable::columnNames::objectId()].setValue
    ( object->objectId() );

  m_data[RelationalObjectTable::columnNames::channelId()].setValue
    ( object->channelId() );

  m_data[RelationalObjectTable::columnNames::iovSince()].setValue
    ( object->since() );

  m_data[RelationalObjectTable::columnNames::iovUntil()].setValue
    ( object->until() );

  m_data[RelationalObjectTable::columnNames::sysInsTime()].setValue
    ( std::string("") );

  m_data[RelationalObjectTable::columnNames::lastModDate()].setValue
    ( std::string("") );

  m_data[RelationalObjectTable::columnNames::originalId()].setValue( 0u );

  m_data[RelationalObjectTable::columnNames::newHeadId()].setValue( 0u );

  if ( mode == cool_PayloadMode_Mode::SEPARATEPAYLOAD )
    m_data[RelationalObjectTable::columnNames::payloadId()].setValue
      ( object->payloadId() );

  if ( mode == cool_PayloadMode_Mode::VECTORPAYLOAD )
    m_data[RelationalObjectTable::columnNames::payloadSetId()].setValue
      ( object->objectId() );

  if ( mode == cool_PayloadMode_Mode::INLINEPAYLOAD )
  {
    // If the payload is not in a separate table, add the data payload columns
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
}

//-----------------------------------------------------------------------------

RelationalObjectTableRow::RelationalObjectTableRow
( const RelationalTableRow& row )
  : RelationalTableRowBase( row.data() )
{
}

//-----------------------------------------------------------------------------

RelationalObjectTableRow::RelationalObjectTableRow
( const RelationalObjectTableRow& aRow )
  : RelationalTableRowBase( aRow )
{
}

//-----------------------------------------------------------------------------

RelationalObjectTableRow&
RelationalObjectTableRow::operator=( const RelationalObjectTableRow& rhs )
{
  m_data = rhs.m_data;
  return *this;
}

//-----------------------------------------------------------------------------
/*
const RelationalObjectTableRow&
RelationalObjectTableRow::operator=( const RelationalObjectTableRow& rhs ) {
  m_spec = rhs.m_spec;
  m_data = AttrListPtr( new coral::AttributeList( m_spec ) );

  // Copy the individual Attribute values
  coral::AttributeList::const_iterator sourceAttr;
  coral::AttributeList::iterator targetAttr = m_data->begin();
  for ( sourceAttr = rhs.m_data->begin();
        sourceAttr != rhs.m_data->end();
        sourceAttr++, targetAttr++ ) {

    coral::AttributeValueAccessor( *targetAttr ).setValueFromData
    ( coral::AttributeValueAccessor( *sourceAttr ).getMemoryAddress() );

  }

  return *this;
}
*///
//-----------------------------------------------------------------------------

unsigned int RelationalObjectTableRow::objectId() const
{
  return
    m_data[RelationalObjectTable::columnNames::objectId()].data<unsigned int>();
}

//-----------------------------------------------------------------------------

ValidityKey RelationalObjectTableRow::since() const
{
  return
    m_data[RelationalObjectTable::columnNames::iovSince()].data<ValidityKey>();
}

//-----------------------------------------------------------------------------

ValidityKey RelationalObjectTableRow::until() const
{
  return
    m_data[RelationalObjectTable::columnNames::iovUntil()].data<ValidityKey>();
}

//-----------------------------------------------------------------------------

ChannelId RelationalObjectTableRow::channelId() const
{
  return
    m_data[RelationalObjectTable::columnNames::channelId()].data<ChannelId>();
}

//-----------------------------------------------------------------------------

unsigned int RelationalObjectTableRow::userTagId() const
{
  return
    m_data[RelationalObjectTable::columnNames::userTagId()].data<unsigned int>();
}

//-----------------------------------------------------------------------------

unsigned int RelationalObjectTableRow::originalId() const
{
  return
    m_data[RelationalObjectTable::columnNames::originalId()]
    .data<unsigned int>();
}

//-----------------------------------------------------------------------------

unsigned int RelationalObjectTableRow::newHeadId() const
{
  return
    m_data[RelationalObjectTable::columnNames::newHeadId()].data<unsigned int>();
}

//-----------------------------------------------------------------------------

Time RelationalObjectTableRow::insertionTime() const
{
  std::string value =
    m_data[RelationalObjectTable::columnNames::sysInsTime()].data<std::string>();
  return stringToTime( value );
}

//-----------------------------------------------------------------------------

Time RelationalObjectTableRow::lastModDate() const
{
  std::string value =
    m_data[RelationalObjectTable::columnNames::lastModDate()]
    .data<std::string>();
  return stringToTime( value );
}

//-----------------------------------------------------------------------------

unsigned int RelationalObjectTableRow::payloadId() const
{
  return
    m_data[RelationalObjectTable::columnNames::payloadId()].data<unsigned int>();
}

//-----------------------------------------------------------------------------

unsigned int RelationalObjectTableRow::payloadSetId() const
{
  return
    m_data[RelationalObjectTable::columnNames::payloadSetId()].data<unsigned int>();
}

//-----------------------------------------------------------------------------

unsigned int RelationalObjectTableRow::payloadSize() const
{
  return
    m_data[RelationalObjectTable::columnNames::payloadSize()].data<unsigned int>();
}

//-----------------------------------------------------------------------------

void RelationalObjectTableRow::setObjectId( unsigned int objectId )
{
  m_data[RelationalObjectTable::columnNames::objectId()].setValue( objectId );
}

//-----------------------------------------------------------------------------

void RelationalObjectTableRow::setPayloadId( const unsigned int payloadId )
{
  m_data[RelationalObjectTable::columnNames::payloadId()].setValue( payloadId );
}

//-----------------------------------------------------------------------------

void RelationalObjectTableRow::setPayloadSetId( const unsigned int payloadSetId )
{
  m_data[RelationalObjectTable::columnNames::payloadSetId()].setValue( payloadSetId );
}

//-----------------------------------------------------------------------------

void RelationalObjectTableRow::setPayloadNItems( const unsigned int payloadSize )
{
  m_data[RelationalObjectTable::columnNames::payloadSize()].setValue( payloadSize );
}

//-----------------------------------------------------------------------------

void RelationalObjectTableRow::setSince( const ValidityKey& since )
{
  m_data[RelationalObjectTable::columnNames::iovSince()].setValue( since );
}

//-----------------------------------------------------------------------------

void RelationalObjectTableRow::setUntil( const ValidityKey& until )
{
  m_data[RelationalObjectTable::columnNames::iovUntil()].setValue( until );
}

//-----------------------------------------------------------------------------

void RelationalObjectTableRow::setUserTagId( unsigned int userTagId )
{
  m_data[RelationalObjectTable::columnNames::userTagId()].setValue( userTagId );
}

//-----------------------------------------------------------------------------

void RelationalObjectTableRow::setOriginalId( unsigned int value )
{
  m_data[RelationalObjectTable::columnNames::originalId()].setValue( value );
}

//-----------------------------------------------------------------------------

void RelationalObjectTableRow::setNewHeadId( unsigned int value )
{
  m_data[RelationalObjectTable::columnNames::newHeadId()].setValue( value );
}

//-----------------------------------------------------------------------------
