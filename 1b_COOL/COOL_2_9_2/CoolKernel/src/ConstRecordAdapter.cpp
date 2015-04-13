// $Id: ConstRecordAdapter.cpp,v 1.20 2009-12-17 18:50:43 avalassi Exp $

// Include files
#include "CoolKernel/ConstRecordAdapter.h"
#include "CoolKernel/RecordException.h"

// Local include files
#include "ConstFieldAdapter.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

ConstRecordAdapter::~ConstRecordAdapter()
{
  std::vector<IField*>::const_iterator ppField;
  for ( ppField = m_fields.begin(); ppField != m_fields.end(); ppField++ )
    delete (*ppField);
  m_fields.clear();
}

//-----------------------------------------------------------------------------

ConstRecordAdapter::ConstRecordAdapter( const IRecordSpecification& spec,
                                        const coral::AttributeList& attrList )
  : m_spec()
  , m_attrList( attrList )
  , m_fields()
  , m_publicAttrList()
{
  bool checkSize = false;
  spec.validate( attrList, checkSize );
  for ( UInt32 i = 0; i < spec.size(); i++ )
  {
    const std::string& name = spec[i].name();
    StorageType::TypeId typeId = spec[i].storageType().id();
    m_spec.extend( name, typeId );
    m_fields.push_back
      ( new ConstFieldAdapter( m_spec[name], m_attrList[name] ) );
    // Fix for bug #36646
    // Implementation copied from coral::AttributeList::merge
    m_publicAttrList.extend( name, m_attrList[name].specification().type() );
    m_publicAttrList[name].shareData( m_attrList[name] );
  }
}

//-----------------------------------------------------------------------------

const IRecordSpecification& ConstRecordAdapter::specification() const
{
  return m_spec;
}

//-----------------------------------------------------------------------------

const IField&
ConstRecordAdapter::operator[] ( const std::string& name ) const
{
  return IRecord::operator[] ( name );
}

//-----------------------------------------------------------------------------

const IField&
ConstRecordAdapter::operator[] ( UInt32 index ) const
{
  return IRecord::operator[] ( index );
}

//-----------------------------------------------------------------------------

const IField&
ConstRecordAdapter::field( UInt32 index ) const
{
  if ( index >= m_fields.size() )
    throw RecordSpecificationUnknownField
      ( index, m_fields.size(), "RecordAdapter" );
  return *(m_fields[index]);
}

//-----------------------------------------------------------------------------

IField&
ConstRecordAdapter::field( UInt32 )
{
  throw Exception
    ( "All non-const methods of this class throw!", "ConstRecordAdapter" );
}

//-----------------------------------------------------------------------------

const coral::AttributeList& ConstRecordAdapter::attributeList() const
{
  return m_publicAttrList;
}

//-----------------------------------------------------------------------------
