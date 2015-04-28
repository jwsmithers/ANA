
// Include files
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"
#include "CoolKernel/RecordException.h"

// Local include files
#include "ConstFieldAdapter.h"
#include "isNaN.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

ConstFieldAdapter::~ConstFieldAdapter()
{
}

//-----------------------------------------------------------------------------

ConstFieldAdapter::ConstFieldAdapter( const IFieldSpecification& spec,
                                      const coral::Attribute& attr )
  : m_spec( spec )
  , m_attr( attr )
{
  // No need to validate values at construction time: validation is performed
  // by ConstRecordAdapter, of which this is essentially a private class
  //spec.validate( attr );
}

//-----------------------------------------------------------------------------

const IFieldSpecification& ConstFieldAdapter::specification() const
{
  return m_spec;
}

//-----------------------------------------------------------------------------

bool ConstFieldAdapter::isNull() const
{
  // Strings can never be null
  if ( m_attr.specification().type() == typeid( std::string ) )
  {
    return false;
  }
  // For all other types, field is null if underlying attribute is null
  else if ( m_attr.isNull() )
  {
    return true;
  }
  // CORAL floats are _also_ handled as null if NaN (bug #72147)
  else if ( m_attr.specification().type() == typeid( float ) &&
            isNaN( m_attr.data<float>() ) )
  {
    return true;
  }
  // CORAL doubles are _also_ handled as null if NaN (bug #72147)
  else if ( m_attr.specification().type() == typeid( double ) &&
            isNaN( m_attr.data<double>() ) )
  {
    return true;
  }
  // All other values are not null
  else
  {
    return false;
  }
}

//-----------------------------------------------------------------------------

const void* ConstFieldAdapter::addressOfData() const
{
  // Throw for null values (NB strings can never be null)
  if ( isNull() )
  {
    throw FieldIsNull
      ( this->name(), this->storageType(), "ConstFieldAdapter" );
  }
  // Return a pointer to "" for null string attributes with non-empty data
  else if ( m_attr.isNull() && m_attr.data<std::string>() != "" )
  {
    static const std::string nullString( "" );
    return &nullString;
  }
  // Delegate to coral::Attribute for all other cases
  else
  {
    return m_attr.addressOfData();
  }
}

//-----------------------------------------------------------------------------

void ConstFieldAdapter::setNull()
{
  throw Exception
    ( "All non-const methods of this class throw!", "ConstFieldAdapter" );
}

//-----------------------------------------------------------------------------

void ConstFieldAdapter::setValue( const std::type_info& /*cppType*/,
                                  const void* /*externalAddress*/ )
{
  throw Exception
    ( "All non-const methods of this class throw!", "ConstFieldAdapter" );
}

//-----------------------------------------------------------------------------

bool ConstFieldAdapter::compareValue( const IField& rhs ) const
{
  // If either field is null, return true only if both are null.
  // [NB: this cannot happen for strings, as string IField's are never null!]
  if ( this->isNull() || rhs.isNull() )
    return ( this->isNull() && rhs.isNull() );
  // Fix bug #62634: special handling if 'this' wraps a null string attribute
  // Bypass unreliable comparison of wrapped _Attributes_ nullness and values
  // ('this' is a non-null IField == "": check if rhs _IField_ value == "" too)
  if ( this->m_attr.isNull() &&
       this->m_attr.specification().type() == typeid( std::string ) )
    return this->data<std::string>() == rhs.data<std::string>();
  // If either field is null, compare their values by comparing the Attribute's
  // holding them. A temporary Attribute is wrapped around the external IField.
  coral::AttributeList rhsAttrList;
  rhsAttrList.extend( rhs.name(), rhs.storageType().cppType() );
  coral::Attribute& rhsAttr = rhsAttrList[ rhs.name() ];
  rhsAttr.bindUnsafely( rhs.addressOfData() );
  return ( this->m_attr == rhsAttr );
}

//-----------------------------------------------------------------------------

std::ostream& ConstFieldAdapter::printValue( std::ostream& os ) const
{
  // Print "NULL" for null values (NB strings can never be null)
  if ( isNull() )
  {
    os << "NULL";
    return os;
  }
  // Print "" for null string attributes
  else if ( m_attr.isNull() &&
            m_attr.specification().type() == typeid( std::string ) )
  {
    return os;
  }
  // Delegate to coral::Attribute for all other cases
  else
  {
    bool valueOnly = true;
    return m_attr.toOutputStream( os, valueOnly );
  }
}

//-----------------------------------------------------------------------------

const coral::Attribute& ConstFieldAdapter::attribute() const
{
  return m_attr;
}

//-----------------------------------------------------------------------------
