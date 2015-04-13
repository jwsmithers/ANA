// $Id: Record.cpp,v 1.38 2009-12-17 18:50:43 avalassi Exp $

// Include files
#include <iostream>
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordException.h"

// Local include files
#include "FieldAdapter.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

Record::~Record()
{
  reset();
}

//-----------------------------------------------------------------------------

Record::Record()
  : m_spec()
  , m_attrList()
  , m_fields()
{
}

//-----------------------------------------------------------------------------

Record::Record( const IRecordSpecification& spec )
  : m_spec()
  , m_attrList()
  , m_fields()
{
  //std::cout << "__COOL Create Record( IRecordSpecification& )" << std::endl;
  for ( UInt32 i = 0; i < spec.size(); i++ )
  {
    const std::string& name = spec[i].name();
    const StorageType& type = spec[i].storageType();
    //std::cout << "Add field " << name << std::endl;
    m_spec.extend( name, type.id() );
    //std::cout << "Add attribute " << name << std::endl;
    m_attrList.extend( name, type.cppType() );
    //std::cout << "Add attribute " << name << ": OK" << std::endl;
    FieldAdapter* field = new FieldAdapter( m_spec[name], m_attrList[name] );
    m_fields.push_back( field );
    //std::cout << "Add field " << name << ": OK" << std::endl;
  }
}

//-----------------------------------------------------------------------------

Record::Record( const IFieldSpecification& spec )
  : m_spec()
  , m_attrList()
  , m_fields()
{
  //std::cout << "__COOL Create Record( IFieldSpecification& )" << std::endl;
  const std::string& name = spec.name();
  const StorageType& type = spec.storageType();
  //std::cout << "Add field " << name << std::endl;
  m_spec.extend( name, type.id() );
  //std::cout << "Add attribute " << name << std::endl;
  m_attrList.extend( name, type.cppType() );
  //std::cout << "Add attribute " << name << ": OK" << std::endl;
  FieldAdapter* field = new FieldAdapter( m_spec[name], m_attrList[name] );
  m_fields.push_back( field );
  //std::cout << "Add field " << name << ": OK" << std::endl;
}

//-----------------------------------------------------------------------------

Record::Record( const IRecordSpecification& spec,
                const coral::AttributeList& attrList )
  : m_spec()
  , m_attrList( attrList )
  , m_fields()
{
  //std::cout << "__COOL Create Record( IRecordSpecification&, "
  //          << "coral::AttributeList& )" << std::endl;
  bool checkSize = false;
  spec.validate( attrList, checkSize );
  for ( UInt32 i = 0; i < spec.size(); i++ )
  {
    const std::string& name = spec[i].name();
    const StorageType& type = spec[i].storageType();
    m_spec.extend( name, type.id() );
    FieldAdapter* field = new FieldAdapter( m_spec[name], m_attrList[name] );
    m_fields.push_back( field );
  }
}

//-----------------------------------------------------------------------------

Record::Record( const Record& rhs )
  : IRecord( rhs ) // slc4_ia32_gcc34: explicitly init base class in copy ctor
  , m_spec()
  , m_attrList()
  , m_fields()
{
  //std::cout << "__COOL Create Record( Record& )" << std::endl;
  extend( rhs );
}

//-----------------------------------------------------------------------------

Record::Record( const IRecord& rhs )
  : m_spec()
  , m_attrList()
  , m_fields()
{
  //std::cout << "__COOL Create Record( IRecord& )" << std::endl;
  extend( rhs );
}

//-----------------------------------------------------------------------------

Record& Record::operator=( const Record& rhs )
{
  //std::cout << "__COOL Assign Record=( Record& )" << std::endl;
  reset();
  extend( rhs );
  return (*this);
}

//-----------------------------------------------------------------------------

Record& Record::operator=( const IRecord& rhs )
{
  //std::cout << "__COOL Assign Record=( IRecord& )" << std::endl;
  reset();
  extend( rhs );
  return (*this);
}

//-----------------------------------------------------------------------------

const IRecordSpecification& Record::specification() const
{
  return m_spec;
}

//-----------------------------------------------------------------------------

const IField& Record::operator[] ( const std::string& name ) const
{
  return IRecord::operator[] ( name );
}

//-----------------------------------------------------------------------------

IField& Record::operator[] ( const std::string& name )
{
  return IRecord::operator[] ( name );
}

//-----------------------------------------------------------------------------

const IField& Record::operator[] ( UInt32 index ) const
{
  return IRecord::operator[] ( index );
}

//-----------------------------------------------------------------------------

IField& Record::operator[] ( UInt32 index )
{
  return IRecord::operator[] ( index );
}

//-----------------------------------------------------------------------------

const IField& Record::field( UInt32 index ) const
{
  if ( index >= m_fields.size() )
    throw RecordSpecificationUnknownField
      ( index, m_fields.size(), "Record" );
  return *(m_fields[index]);
}

//-----------------------------------------------------------------------------

IField& Record::field( UInt32 index )
{
  if ( index >= m_fields.size() )
    throw RecordSpecificationUnknownField
      ( index, m_fields.size(), "Record" );
  return *(m_fields[index]);
}

//-----------------------------------------------------------------------------

const coral::AttributeList& Record::attributeList() const
{
  return m_attrList;
}

//-----------------------------------------------------------------------------

void Record::reset()
{
  for ( UInt32 i=0; i<size(); i++ ) delete m_fields[i];
  m_fields.clear();
  m_attrList = coral::AttributeList();
  m_spec = RecordSpecification();
}

//-----------------------------------------------------------------------------

void Record::extend( const IRecord& rhs )
{
  const IRecordSpecification& spec = rhs.specification();
  spec.validate( rhs ); // do not trust the input IRecord!
  for ( UInt32 i = 0; i < spec.size(); i++ )
  {
    const std::string& name = spec[i].name();
    const StorageType& type = spec[i].storageType();
    m_spec.extend( name, type.id() );
    m_attrList.extend( name, type.cppType() );
    FieldAdapter* field = new FieldAdapter( m_spec[name], m_attrList[name] );
    m_fields.push_back( field );
    if ( rhs[i].isNull() )
      field->setNull();
    else
      field->setValue( rhs[i].storageType().cppType(),
                       rhs[i].addressOfData() );
  }
}

//-----------------------------------------------------------------------------
