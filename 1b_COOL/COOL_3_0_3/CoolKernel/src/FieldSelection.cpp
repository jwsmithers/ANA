// Include files
//#include <iostream>
#include <sstream>
#include "CoolKernel/FieldSelection.h"
#include "CoolKernel/InternalErrorException.h"
#include "CoolKernel/RecordSelectionException.h"

// Local include files
#include "scoped_enums.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

const std::string FieldSelection::describe( FieldSelection::Relation relation )
{
  switch( relation )
  {
  case cool_FieldSelection_Relation::EQ: return "="; // SQL-like '=' rather than C++like '=='
  case cool_FieldSelection_Relation::NE: return "!=";
  case cool_FieldSelection_Relation::GT: return ">";
  case cool_FieldSelection_Relation::GE: return ">=";
  case cool_FieldSelection_Relation::LT: return "<";
  case cool_FieldSelection_Relation::LE: return "<=";
  default:
    throw InternalErrorException( "PANIC! Unknown relation",
                                  "FieldSelection::describe()" );
  }
}

//-----------------------------------------------------------------------------

const std::string FieldSelection::describe( FieldSelection::Nullness nullness )
{
  switch( nullness )
  {
  case cool_FieldSelection_Nullness::IS_NULL: return "IS NULL";
  case cool_FieldSelection_Nullness::IS_NOT_NULL: return "IS NOT NULL";
  default:
    throw InternalErrorException( "PANIC! Unknown nullness",
                                  "FieldSelection::describe()" );
  }
}

//-----------------------------------------------------------------------------

FieldSelection::~FieldSelection()
{
}

//-----------------------------------------------------------------------------

void FieldSelection::initialize()
{
  const IFieldSpecification& fspec = m_refValue[0].specification();
  const StorageType& type = fspec.storageType();

  // Extra cross-checks for specific types in comparison to non-NULL
  switch ( type.id() ) {
  case cool_StorageType_TypeId::Bool:
  case cool_StorageType_TypeId::Blob64k:
  case cool_StorageType_TypeId::Blob16M:
  case cool_StorageType_TypeId::String255:
  case cool_StorageType_TypeId::String4k:
  case cool_StorageType_TypeId::String64k:
  case cool_StorageType_TypeId::String16M:
    if ( m_relation != cool_FieldSelection_Relation::EQ && m_relation != cool_FieldSelection_Relation::NE )
    {
      std::stringstream msg;
      msg << "Invalid relation '" << describe( m_relation )
          << "' for storage type '" << type.name() << "'";
      throw RecordSelectionException( msg.str(),
                                      "FieldSelection::initialize()" );
    }
  default:
    break;
  }

}

//-----------------------------------------------------------------------------

FieldSelection::FieldSelection( const std::string& name,
                                const StorageType::TypeId typeId,
                                Nullness nullness )
  : m_refValue( FieldSpecification( name, typeId ) )
{
  m_refValue[0].setNull();
  switch( nullness )
  {
  case cool_FieldSelection_Nullness::IS_NULL:
    m_relation = cool_FieldSelection_Relation::EQ; break;
  case cool_FieldSelection_Nullness::IS_NOT_NULL:
    m_relation = cool_FieldSelection_Relation::NE; break;
  default:
    throw InternalErrorException( "PANIC! Unknown nullness",
                                  "FieldSelection::FieldSelection()" );
  }

  // Extra cross-checks for specific types
  switch ( m_refValue[0].storageType().id() ) {
  case cool_StorageType_TypeId::String255:
  case cool_StorageType_TypeId::String4k:
  case cool_StorageType_TypeId::String64k:
  case cool_StorageType_TypeId::String16M:
    {
      FieldSelection::describe( nullness );
      std::stringstream msg;
      msg << "Invalid selection '" << FieldSelection::describe( nullness )
          << "' for storage type '" << m_refValue[0].storageType().name()
          << "' (string cool::Field instances are always NOT NULL)";
      throw RecordSelectionException( msg.str(),
                                      "FieldSelection::FieldSelection()" );
    }
  default:
    break;
  }

}

//-----------------------------------------------------------------------------

FieldSelection::FieldSelection( const FieldSelection& rhs )
  : IRecordSelection( rhs )
  , m_refValue( rhs.m_refValue )
  , m_relation( rhs.m_relation )
{
}

//-----------------------------------------------------------------------------

bool
FieldSelection::canSelect( const IRecordSpecification& rspec ) const
{
  const IFieldSpecification& fspec = m_refValue[0].specification();
  const std::string& fname = fspec.name();
  const StorageType& ftype = fspec.storageType();
  if ( ! rspec.exists( fname ) )
  {
    //std::cout << "__FieldSelection::canSelect Unknown field '"
    //          << fname << "'" << std::endl;
    return false;
  }
  if ( ftype != rspec[fname].storageType() )
  {
    //std::cout << "__FieldSelection::canSelect Field '" << fname
    //          << "' has type '" << rspec[fname].storageType().name()
    //          << "', expected '" << ftype.name() << "'" << std::endl;
    return false;
  }
  return true;
}

//-----------------------------------------------------------------------------

template <typename T>
inline bool compare( const T& value1,
                     FieldSelection::Relation relation,
                     const T& value2 )
{
  switch ( relation )
  {
  case cool_FieldSelection_Relation::GT:
    return value1 > value2;
  case cool_FieldSelection_Relation::GE:
    return value1 >= value2;
  case cool_FieldSelection_Relation::LT:
    return value1 < value2;
  case cool_FieldSelection_Relation::LE:
    return value1 <= value2;
  case cool_FieldSelection_Relation::EQ:
    return value1 == value2;
  case cool_FieldSelection_Relation::NE:
    return value1 != value2;
  }
  throw InternalErrorException( "PANIC! Unknown relation",
                                "FieldSelection::compare()" );
}

//-----------------------------------------------------------------------------

template <typename T>
inline bool compareBlobs( const T& value1,
                          FieldSelection::Relation relation,
                          const T& value2 )
{
  switch ( relation )
  {
  case cool_FieldSelection_Relation::EQ:
    return value1 == value2;
  case cool_FieldSelection_Relation::NE:
    return value1 != value2;
  case cool_FieldSelection_Relation::GT:
  case cool_FieldSelection_Relation::GE:
  case cool_FieldSelection_Relation::LT:
  case cool_FieldSelection_Relation::LE:
    throw InternalErrorException
      ( "PANIC! Invalid relation for Strings or Blobs",
        "FieldSelection::compareBlobs()" );
  default:
    throw InternalErrorException
      ( "PANIC! Unknown relation",
        "FieldSelection::compareBlobs()" );
  }
}

//-----------------------------------------------------------------------------

bool FieldSelection::select( const IRecord& record ) const
{
  const IField& field = record[m_refValue[0].name()];
  const IField& ref = m_refValue[0];

  // FieldSelection is a comparison to NULL (either IS_NULL or IS_NOT_NULL)
  if ( ref.isNull( ) )
  {
    switch( m_relation )
    {
    case cool_FieldSelection_Relation::EQ:
      return field.isNull();
    case cool_FieldSelection_Relation::NE:
      return !(field.isNull());
    default:
      throw InternalErrorException
        ( "PANIC! Invalid relation to NULL reference value",
          "FieldSelection::select()" );
    }
  }

  // FieldSelection is NOT a comparison to NULL
  else
  {
    // comparisons of fields with null value against anything not null is false
    if (field.isNull())
      return false;

    switch ( field.storageType().id() )
    {
    case cool_StorageType_TypeId::Bool:
      return compare( field.data<cool::Bool>(),
                      m_relation,ref.data<cool::Bool>() );
    case cool_StorageType_TypeId::UChar:
      return compare( field.data<cool::UChar>(),
                      m_relation,ref.data<cool::UChar>() );
    case cool_StorageType_TypeId::Int16:
      return compare( field.data<cool::Int16>(),
                      m_relation,ref.data<cool::Int16>() );
    case cool_StorageType_TypeId::UInt16:
      return compare( field.data<cool::UInt16>(),
                      m_relation,ref.data<cool::UInt16>() );
    case cool_StorageType_TypeId::Int32:
      return compare( field.data<cool::Int32>(),
                      m_relation,ref.data<cool::Int32>() );
    case cool_StorageType_TypeId::UInt32:
      return compare( field.data<cool::UInt32>(),
                      m_relation,ref.data<cool::UInt32>() );
    case cool_StorageType_TypeId::Int64:
      return compare( field.data<cool::Int64>(),
                      m_relation,ref.data<cool::Int64>() );
    case cool_StorageType_TypeId::UInt63:
      return compare( field.data<cool::UInt63>(),
                      m_relation,ref.data<cool::UInt63>() );
    case cool_StorageType_TypeId::Float:
      return compare( field.data<cool::Float>(),
                      m_relation,ref.data<cool::Float>() );
    case cool_StorageType_TypeId::Double:
      return compare( field.data<cool::Double>(),
                      m_relation,ref.data<cool::Double>() );
    case cool_StorageType_TypeId::String255:
      return compareBlobs( field.data<cool::String255>(),
                           m_relation,ref.data<cool::String255>() );
    case cool_StorageType_TypeId::String4k:
      return compareBlobs( field.data<cool::String4k>(),
                           m_relation,ref.data<cool::String4k>() );
    case cool_StorageType_TypeId::String64k:
      return compareBlobs( field.data<cool::String64k>(),
                           m_relation,ref.data<cool::String64k>() );
    case cool_StorageType_TypeId::String16M:
      return compareBlobs( field.data<cool::String16M>(),
                           m_relation,ref.data<cool::String16M>() );
    case cool_StorageType_TypeId::Blob64k:
      return compareBlobs( field.data<cool::Blob64k>(),
                           m_relation,ref.data<cool::Blob64k>() );
    case cool_StorageType_TypeId::Blob16M:
      return compareBlobs( field.data<cool::Blob16M>(),
                           m_relation,ref.data<cool::Blob16M>() );
    default:
      throw InternalErrorException
        ( "PANIC! Unsupported type in Fieldselection::select()",
          "FieldSelection::select()" );
    }
  }

}

//-----------------------------------------------------------------------------

IRecordSelection* FieldSelection::clone() const
{
  return new FieldSelection( *this );
}

//-----------------------------------------------------------------------------

FieldSelection::Nullness FieldSelection::nullness() const
{
  const IField& fld = m_refValue[0];
  if ( ! fld.isNull() ) return cool_FieldSelection_Nullness::IS_NOT_NULL;
  switch( m_relation )
  {
  case cool_FieldSelection_Relation::EQ:
    return cool_FieldSelection_Nullness::IS_NULL;
  case cool_FieldSelection_Relation::NE:
    return cool_FieldSelection_Nullness::IS_NOT_NULL;
  default:
    throw InternalErrorException
      ( "PANIC! Invalid relation to NULL reference value",
        "FieldSelection::nullness()" );
  }
}

//-----------------------------------------------------------------------------

FieldSelection::Relation FieldSelection::relation() const
{
  return m_relation;
}

//-----------------------------------------------------------------------------

const IField& FieldSelection::referenceValue() const
{
  return m_refValue[0];
}

//-----------------------------------------------------------------------------
