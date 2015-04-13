// $Id: RecordSpecification.cpp,v 1.28 2009-12-17 18:50:43 avalassi Exp $

// Include files
#include "CoralBase/AttributeListException.h"
#include "CoolKernel/FieldSpecification.h"
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordException.h"
#include "CoolKernel/RecordSpecification.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

RecordSpecification::~RecordSpecification()
{
  reset();
}

//-----------------------------------------------------------------------------

RecordSpecification::RecordSpecification()
  : m_fSpecs()
{
}

//-----------------------------------------------------------------------------

RecordSpecification::RecordSpecification( const RecordSpecification& rhs )
  : IRecordSpecification( rhs )
  , m_fSpecs()
{
  extend( rhs );
}

//-----------------------------------------------------------------------------

RecordSpecification::RecordSpecification( const IRecordSpecification& rhs )
  : IRecordSpecification( rhs )
  , m_fSpecs()
{
  extend( rhs );
}

//-----------------------------------------------------------------------------

RecordSpecification&
RecordSpecification::operator=( const RecordSpecification& rhs )
{
  reset();
  extend( rhs );
  return (*this);
}

//-----------------------------------------------------------------------------

RecordSpecification&
RecordSpecification::operator=( const IRecordSpecification& rhs )
{
  reset();
  extend( rhs );
  return (*this);
}

//-----------------------------------------------------------------------------

void RecordSpecification::extend( const std::string& name,
                                  const StorageType::TypeId typeId )
{
  if ( exists( name ) )
    throw RecordSpecificationCannotExtend( name, "RecordSpecification" );
  m_fSpecs.push_back( new FieldSpecification( name, typeId ) );
}

//-----------------------------------------------------------------------------

void RecordSpecification::extend( const std::string& name,
                                  const StorageType& type )
{
  extend( name, type.id() );
}

//-----------------------------------------------------------------------------

void RecordSpecification::extend( const IFieldSpecification& fldSpec )
{
  extend( fldSpec.name(), fldSpec.storageType() );
}

//-----------------------------------------------------------------------------

void RecordSpecification::extend( const IRecordSpecification& recSpec )
{
  for ( UInt32 i = 0; i < recSpec.size(); i++ )
    extend( recSpec[i].name(), recSpec[i].storageType() );
}

//-----------------------------------------------------------------------------

UInt32 RecordSpecification::size() const
{
  return m_fSpecs.size();
}

//-----------------------------------------------------------------------------

bool
RecordSpecification::operator==( const IRecordSpecification& rhs ) const
{
  if ( size() != rhs.size() ) return false;
  for ( UInt32 i=0; i<size(); i++ ) {
    if ( (*this)[i] != rhs[i] ) return false;
  }
  return true;
}

//-----------------------------------------------------------------------------

bool
RecordSpecification::operator!=( const IRecordSpecification& rhs ) const
{
  return ! ( *this == rhs );
}

//-----------------------------------------------------------------------------

bool RecordSpecification::exists( const std::string& name ) const
{
  for ( UInt32 i = 0; i < m_fSpecs.size(); i++ )
    if ( m_fSpecs[i]->name() == name ) return true;
  return false;
}

//-----------------------------------------------------------------------------

const IFieldSpecification&
RecordSpecification::operator[] ( const std::string& name ) const
{
  for ( UInt32 i = 0; i < m_fSpecs.size(); i++ )
    if ( m_fSpecs[i]->name() == name ) return *m_fSpecs[i];
  throw RecordSpecificationUnknownField( name, "RecordSpecification" );
}

//-----------------------------------------------------------------------------

const IFieldSpecification&
RecordSpecification::operator[] ( UInt32 index ) const
{
  if ( index >= m_fSpecs.size() )
    throw RecordSpecificationUnknownField
      ( index, m_fSpecs.size(), "RecordSpecification" );
  return *(m_fSpecs[index]);
}

//-----------------------------------------------------------------------------

UInt32 RecordSpecification::index( const std::string& name ) const
{
  for ( UInt32 i = 0; i < m_fSpecs.size(); i++ )
    if ( m_fSpecs[i]->name() == name ) return i;
  throw RecordSpecificationUnknownField( name, "RecordSpecification" );
}

//-----------------------------------------------------------------------------

void RecordSpecification::validate( const IRecord& record,
                                    bool checkSize ) const
{
  for ( UInt32 i=0; i<size(); i++ ) {
    const IFieldSpecification& fldSpec = (*this)[i];
    fldSpec.validate( record[ fldSpec.name() ] );
  }
  if ( checkSize && size() != record.size() )
    throw RecordSpecificationWrongSize
      ( size(), record.size(), "RecordSpecification::validate" );
}

//-----------------------------------------------------------------------------

void RecordSpecification::validate( const coral::AttributeList& attributeList,
                                    bool checkSize ) const
{
  for ( UInt32 i=0; i<size(); i++ ) {
    const IFieldSpecification& fldSpec = (*this)[i];
    fldSpec.validate( attributeList[ fldSpec.name() ] );
  }
  if ( checkSize && size() != attributeList.size() )
    throw RecordSpecificationWrongSize
      ( size(), attributeList.size(), "RecordSpecification" );
}

//-----------------------------------------------------------------------------

void RecordSpecification::reset()
{
  for ( UInt32 i=0; i<size(); i++ ) delete m_fSpecs[i];
  m_fSpecs.clear();
}

//-----------------------------------------------------------------------------
