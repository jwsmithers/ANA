// $Id: FieldSpecification.cpp,v 1.30 2009-12-16 17:31:22 avalassi Exp $

// Include files
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"
#include "CoolKernel/FieldSpecification.h"
#include "CoolKernel/IField.h"
#include "CoolKernel/RecordException.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

FieldSpecification::~FieldSpecification()
{
}

//-----------------------------------------------------------------------------

FieldSpecification::FieldSpecification( const std::string& name,
                                        const StorageType::TypeId typeId )
  : m_name( name )
  , m_type( StorageType::storageType( typeId ) )
{
  if ( name == "" )
    throw FieldSpecificationInvalidName( name, "FieldSpecification" );
}

//-----------------------------------------------------------------------------

FieldSpecification::FieldSpecification( const FieldSpecification& rhs )
  : IFieldSpecification( rhs )
  , m_name( rhs.m_name )
  , m_type( rhs.m_type )
{
}

//-----------------------------------------------------------------------------

const std::string& FieldSpecification::name() const
{
  return m_name;
}

//-----------------------------------------------------------------------------

const StorageType& FieldSpecification::storageType() const
{
  return m_type;
}

//-----------------------------------------------------------------------------

bool
FieldSpecification::operator==( const IFieldSpecification& rhs ) const {
  return
    ( name() == rhs.name() ) &&
    ( storageType() == rhs.storageType() );
}

//-----------------------------------------------------------------------------

bool
FieldSpecification::operator!=( const IFieldSpecification& rhs ) const
{
  return ! ( *this == rhs );
}

//-----------------------------------------------------------------------------

void FieldSpecification::validate( const IField& field,
                                   bool checkName ) const
{
  if ( checkName && name() != field.name() )
    throw FieldSpecificationWrongName
      ( name(), field.name(), "FieldSpecification" );
  if ( storageType() != field.storageType() )
    throw FieldSpecificationWrongStorageType
      ( name(), storageType(), field.storageType(), "FieldSpecification" );
  validate( field.attribute(), checkName );
}

//-----------------------------------------------------------------------------

void FieldSpecification::validate( const coral::Attribute& attribute,
                                   bool checkName ) const
{

  // Validate the variable name
  if ( checkName && name() != attribute.specification().name() )
    throw FieldSpecificationWrongName
      ( name(), attribute.specification().name(), "FieldSpecification" );

  // Validate the C++ type
  const std::type_info& cppType = attribute.specification().type();
  if ( storageType().cppType() != cppType )
    throw StorageTypeWrongCppType
      ( name(), storageType(), cppType, "FieldSpecification" );

  // NULL values are always valid
  if ( attribute.isNull() ) return;

  // Validate the (non null) data value - delegated to StorageType
  // This triggers an ugly switch from (type,void*) to template<T> via
  // static_cast, back to (type,void*) and back to template<T> via static_cast
  // but is unavoidable to keep private the _unsafe_ validate(void*,type).
  switch( storageType().id() ) {
  case StorageType::Bool:
    storageType().validate( attribute.data<Bool>() ); break;
    //case StorageType::Char:
    //  storageType().validate( attribute.data<Char>() ); break;
  case StorageType::UChar:
    storageType().validate( attribute.data<UChar>() ); break;
  case StorageType::Int16:
    storageType().validate( attribute.data<Int16>() ); break;
  case StorageType::UInt16:
    storageType().validate( attribute.data<UInt16>() ); break;
  case StorageType::Int32:
    storageType().validate( attribute.data<Int32>() ); break;
  case StorageType::UInt32:
    storageType().validate( attribute.data<UInt32>() ); break;
  case StorageType::UInt63:
    storageType().validate( attribute.data<UInt63>() ); break;
  case StorageType::Int64:
    storageType().validate( attribute.data<Int64>() ); break;
    //case StorageType::UInt64:
    //  storageType().validate( attribute.data<UInt64>() ); break;
  case StorageType::Float:
    storageType().validate( attribute.data<Float>() ); break;
  case StorageType::Double:
    storageType().validate( attribute.data<Double>() ); break;
  case StorageType::String255:
    storageType().validate( attribute.data<String255>() ); break;
  case StorageType::String4k:
    storageType().validate( attribute.data<String4k>() ); break;
  case StorageType::String64k:
    storageType().validate( attribute.data<String64k>() ); break;
  case StorageType::String16M:
    storageType().validate( attribute.data<String16M>() ); break;
  case StorageType::Blob64k:
    storageType().validate( attribute.data<Blob64k>() ); break;
  case StorageType::Blob16M:
    storageType().validate( attribute.data<Blob16M>() ); break;
  default:
    std::stringstream out;
    out << "PANIC! Unknown type '" << storageType().id()
        << "' in FieldSpecification::validate";
    throw Exception( out.str(), "FieldSpecification" );
  }

}

//-----------------------------------------------------------------------------
