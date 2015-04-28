// Include files
#include <sstream>
#include "CoolKernel/RecordException.h"
#include "CoolKernel/StorageType.h"
#include "CoolKernel/types.h"

// Local include files
#include "scoped_enums.h"

//-----------------------------------------------------------------------------

const std::string cool::StorageType::name() const
{
  switch ( m_id ) {
  case cool_StorageType_TypeId::Bool:      return "Bool";
    //case cool_StorageType_TypeId::Char:      return "Char";
  case cool_StorageType_TypeId::UChar:     return "UChar";
  case cool_StorageType_TypeId::Int16:     return "Int16";
  case cool_StorageType_TypeId::UInt16:    return "UInt16";
  case cool_StorageType_TypeId::Int32:     return "Int32";
  case cool_StorageType_TypeId::UInt32:    return "UInt32";
  case cool_StorageType_TypeId::UInt63:    return "UInt63";
  case cool_StorageType_TypeId::Int64:     return "Int64";
    //case cool_StorageType_TypeId::UInt64:    return "UInt64";
  case cool_StorageType_TypeId::Float:     return "Float";
  case cool_StorageType_TypeId::Double:    return "Double";
  case cool_StorageType_TypeId::String255: return "String255";
  case cool_StorageType_TypeId::String4k:  return "String4k";
  case cool_StorageType_TypeId::String64k: return "String64k";
  case cool_StorageType_TypeId::String16M: return "String16M";
  case cool_StorageType_TypeId::Blob64k:   return "Blob64k";
  case cool_StorageType_TypeId::Blob16M:   return "Blob16M";
  }
  std::stringstream out;
  out << "PANIC! Unknown type '" << m_id << "' in StorageType::name()";
  throw Exception( out.str(), "StorageType" );
}

//-----------------------------------------------------------------------------

const std::type_info& cool::StorageType::cppType() const
{
  switch ( m_id ) {
  case cool_StorageType_TypeId::Bool:      return typeid( cool::Bool );
    //case cool_StorageType_TypeId::Char:      return typeid( Char );
  case cool_StorageType_TypeId::UChar:     return typeid( cool::UChar );
  case cool_StorageType_TypeId::Int16:     return typeid( cool::Int16 );
  case cool_StorageType_TypeId::UInt16:    return typeid( cool::UInt16 );
  case cool_StorageType_TypeId::Int32:     return typeid( cool::Int32 );
  case cool_StorageType_TypeId::UInt32:    return typeid( cool::UInt32 );
  case cool_StorageType_TypeId::UInt63:    return typeid( cool::UInt63 );
  case cool_StorageType_TypeId::Int64:     return typeid( cool::Int64 );
    //case cool_StorageType_TypeId::UInt64:    return typeid( cool::UInt64 );
  case cool_StorageType_TypeId::Float:     return typeid( cool::Float );
  case cool_StorageType_TypeId::Double:    return typeid( cool::Double );
  case cool_StorageType_TypeId::String255: return typeid( cool::String255 );
  case cool_StorageType_TypeId::String4k:  return typeid( cool::String4k );
  case cool_StorageType_TypeId::String64k: return typeid( cool::String64k );
  case cool_StorageType_TypeId::String16M: return typeid( cool::String16M );
  case cool_StorageType_TypeId::Blob64k:   return typeid( cool::Blob64k );
  case cool_StorageType_TypeId::Blob16M:   return typeid( cool::Blob16M );
  }
  std::stringstream out;
  out << "PANIC! Unknown type '" << m_id << "' in StorageType::cppType()";
  throw Exception( out.str(), "StorageType" );
}

//-----------------------------------------------------------------------------

size_t cool::StorageType::maxSize() const
{
  switch ( m_id ) {
  case cool_StorageType_TypeId::Bool:      return 0;
    //case cool_StorageType_TypeId::Char:      return 0;
  case cool_StorageType_TypeId::UChar:     return 0;
  case cool_StorageType_TypeId::Int16:     return 0;
  case cool_StorageType_TypeId::UInt16:    return 0;
  case cool_StorageType_TypeId::Int32:     return 0;
  case cool_StorageType_TypeId::UInt32:    return 0;
  case cool_StorageType_TypeId::UInt63:    return 0;
  case cool_StorageType_TypeId::Int64:     return 0;
    //case cool_StorageType_TypeId::UInt64:    return 0;
  case cool_StorageType_TypeId::Float:     return 0;
  case cool_StorageType_TypeId::Double:    return 0;
  case cool_StorageType_TypeId::String255: return 255;
  case cool_StorageType_TypeId::String4k:  return 4000;
  case cool_StorageType_TypeId::String64k: return 65535;
  case cool_StorageType_TypeId::String16M: return 16777215;
  case cool_StorageType_TypeId::Blob64k:   return 65535;
  case cool_StorageType_TypeId::Blob16M:   return 16777215;
  }
  std::stringstream out;
  out << "PANIC! Unknown type '" << m_id << "' in StorageType::maxSize()";
  throw Exception( out.str(), "StorageType" );
}

//-----------------------------------------------------------------------------

const cool::StorageType& cool::StorageType::storageType( const TypeId& id )
{
  switch ( id ) {
  case cool_StorageType_TypeId::Bool:
    { static const StorageType type( id ); return type; }
    //case cool_StorageType_TypeId::Char:
    //  { static const StorageType type( id ); return type; }
  case cool_StorageType_TypeId::UChar:
    { static const StorageType type( id ); return type; }
  case cool_StorageType_TypeId::Int16:
    { static const StorageType type( id ); return type; }
  case cool_StorageType_TypeId::UInt16:
    { static const StorageType type( id ); return type; }
  case cool_StorageType_TypeId::Int32:
    { static const StorageType type( id ); return type; }
  case cool_StorageType_TypeId::UInt32:
    { static const StorageType type( id ); return type; }
  case cool_StorageType_TypeId::UInt63:
    { static const StorageType type( id ); return type; }
  case cool_StorageType_TypeId::Int64:
    { static const StorageType type( id ); return type; }
    //case cool_StorageType_TypeId::UInt64:
    //  { static const StorageType type( id ); return type; }
  case cool_StorageType_TypeId::Float:
    { static const StorageType type( id ); return type; }
  case cool_StorageType_TypeId::Double:
    { static const StorageType type( id ); return type; }
  case cool_StorageType_TypeId::String255:
    { static const StorageType type( id ); return type; }
  case cool_StorageType_TypeId::String4k:
    { static const StorageType type( id ); return type; }
  case cool_StorageType_TypeId::String64k:
    { static const StorageType type( id ); return type; }
  case cool_StorageType_TypeId::String16M:
    { static const StorageType type( id ); return type; }
  case cool_StorageType_TypeId::Blob64k:
    { static const StorageType type( id ); return type; }
  case cool_StorageType_TypeId::Blob16M:
    { static const StorageType type( id ); return type; }
  }
  std::stringstream out;
  out << "PANIC! Unknown type '" << id << "' in StorageType::storageType()";
  throw Exception( out.str(), "StorageType" );
}

//-----------------------------------------------------------------------------

void cool::StorageType::validate( const std::type_info& cppTypeOfData,
                                  const void* addressOfData,
                                  const std::string& variableName ) const
{
  if ( cppType() != cppTypeOfData )
    throw StorageTypeWrongCppType
      ( variableName, *this, cppTypeOfData, "StorageType" );
  switch( id() ) {
  case cool_StorageType_TypeId::String255:
  case cool_StorageType_TypeId::String4k:
  case cool_StorageType_TypeId::String64k:
  case cool_StorageType_TypeId::String16M:
    {
      const std::string& data =
        *( static_cast<const std::string*>( addressOfData ) );
      // Check that string values are not longer than the allowed maximum size
      size_t size = data.size(); // std::string::size() returns size_t
      if ( maxSize() < size )
        throw StorageTypeStringTooLong
          ( variableName, *this, size, "StorageType" );
      // Check that strings do not contain the character '\0' - fix bug #22385
      if ( data.find('\0') != std::string::npos )
        throw StorageTypeStringContainsNullChar
          ( variableName, *this, "StorageType" );
    }
    break;
  case cool_StorageType_TypeId::Blob64k:
  case cool_StorageType_TypeId::Blob16M:
    {
      const coral::Blob& data =
        *( static_cast<const coral::Blob*>( addressOfData ) );
      // Check that blob values are not longer than the allowed maximum size
      long size = data.size(); // coral::Blob::size() returns long
      if ( (long)maxSize() < size )
        throw StorageTypeBlobTooLong
          ( variableName, *this, size, "StorageType" );
    }
    break;
  case cool_StorageType_TypeId::UInt63:
    {
      cool::UInt63 data =
        *( static_cast<const cool::UInt63*>( addressOfData ) );
      // Check that UInt63 values are in the range [0, 2^63-1]
      //if ( ( data & 0x8000000000000000ULL ) != 0ULL ) // NO - use min/max
      //if ( data < UInt63Min || data > UInt63Max )     // NO - data never < 0
      if ( data > UInt63Max ) // Only check max...
        throw StorageTypeInvalidUInt63
          ( variableName, data, "StorageType" );
    }
    break;
  default:
    // All other types are always ok
    break;
  }
}

//-----------------------------------------------------------------------------
