
// Include files
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"
#include "CoolKernel/FieldSpecification.h"
#include "CoolKernel/IField.h"
#include "CoolKernel/RecordException.h"

// Local include files
#include "scoped_enums.h"

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
  case cool_StorageType_TypeId::Bool:
    storageType().validate( attribute.data<Bool>() ); break;
    //case cool_StorageType_TypeId::Char:
    //  storageType().validate( attribute.data<Char>() ); break;
  case cool_StorageType_TypeId::UChar:
    storageType().validate( attribute.data<UChar>() ); break;
  case cool_StorageType_TypeId::Int16:
    storageType().validate( attribute.data<Int16>() ); break;
  case cool_StorageType_TypeId::UInt16:
    storageType().validate( attribute.data<UInt16>() ); break;
  case cool_StorageType_TypeId::Int32:
    storageType().validate( attribute.data<Int32>() ); break;
  case cool_StorageType_TypeId::UInt32:
    storageType().validate( attribute.data<UInt32>() ); break;
  case cool_StorageType_TypeId::UInt63:
    storageType().validate( attribute.data<UInt63>() ); break;
  case cool_StorageType_TypeId::Int64:
    storageType().validate( attribute.data<Int64>() ); break;
    //case cool_StorageType_TypeId::UInt64:
    //  storageType().validate( attribute.data<UInt64>() ); break;
  case cool_StorageType_TypeId::Float:
    storageType().validate( attribute.data<Float>() ); break;
  case cool_StorageType_TypeId::Double:
    storageType().validate( attribute.data<Double>() ); break;
  case cool_StorageType_TypeId::String255:
    storageType().validate( attribute.data<String255>() ); break;
  case cool_StorageType_TypeId::String4k:
    storageType().validate( attribute.data<String4k>() ); break;
  case cool_StorageType_TypeId::String64k:
    storageType().validate( attribute.data<String64k>() ); break;
  case cool_StorageType_TypeId::String16M:
    storageType().validate( attribute.data<String16M>() ); break;
  case cool_StorageType_TypeId::Blob64k:
    storageType().validate( attribute.data<Blob64k>() ); break;
  case cool_StorageType_TypeId::Blob16M:
    storageType().validate( attribute.data<Blob16M>() ); break;
  default:
    std::stringstream out;
    out << "PANIC! Unknown type '" << storageType().id()
        << "' in FieldSpecification::validate";
    throw Exception( out.str(), "FieldSpecification" );
  }

}

//-----------------------------------------------------------------------------
