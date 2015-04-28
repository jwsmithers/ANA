
// Include files
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"
#include "CoolKernel/RecordException.h"

// Local include files
#include "FieldAdapter.h"
#include "isNaN.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

FieldAdapter::~FieldAdapter()
{
}

//-----------------------------------------------------------------------------

FieldAdapter::FieldAdapter( const IFieldSpecification& spec,
                            coral::Attribute& attr )
  : m_spec( spec )
  , m_attr( attr )
{
  // No need to validate values at construction time: validation is performed
  // by Record, of which this is essentially a private class
  //spec.validate( attr );
}

//-----------------------------------------------------------------------------

const IFieldSpecification& FieldAdapter::specification() const
{
  return m_spec;
}

//-----------------------------------------------------------------------------

bool FieldAdapter::isNull() const
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

const void* FieldAdapter::addressOfData() const
{
  // Throw for null values (NB strings can never be null)
  if ( isNull() )
  {
    throw FieldIsNull
      ( this->name(), this->storageType(), "FieldAdapter" );
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

void FieldAdapter::setNull()
{
  // For strings, setNull() is strictly equivalent to setValue(""):
  // set the attribute value to "" and also mark the attribute as null
  if ( m_attr.specification().type() == typeid( std::string ) )
  {
    m_attr.setValue<std::string>( "" );
    //m_attr.setNull( false ); // OLD: 'bug' (or feature) #65100?...
    m_attr.setNull(); // NEW: fix 'bug' (or feature) #65100?
  }
  // For all other storage types, just mark the attribute as null
  else
  {
    m_attr.setNull();
  }
}

//-----------------------------------------------------------------------------

void FieldAdapter::setValue( const std::type_info& cppType,
                             const void* externalAddress )
{
  // Check C++ type (as in CORAL)
  std::string name = this->name();
  if ( this->storageType().cppType() != cppType )
    throw FieldWrongCppType
      ( name, this->storageType(), cppType, "FieldAdapter" );

  // Check C++ value (new in COOL)
  // In order to check the value before it is assigned to the Field,
  // a temporary Attribute is wrapped around the external variable.
  {
    coral::AttributeList tmpAttrList;
    tmpAttrList.extend( name, cppType );
    coral::Attribute& tmpAttr = tmpAttrList[name];
    tmpAttr.bindUnsafely( externalAddress );
    m_spec.validate( tmpAttr );
  }

  // Set the value (as in CORAL)
  m_attr.setValueFromAddress( externalAddress );

  // Mark the attribute as not null (for all types including strings)
  // [NB Better setNull(false) here before checking data<std::string>() later!
  m_attr.setNull( false );

  // For strings, setNull() is strictly equivalent to setValue(""):
  // set the attribute value to "" and also mark the attribute as null
  // Mark the attribute as null for strings == "" (fix for bug #65100)
  if ( m_attr.specification().type() == typeid( std::string ) &&
       m_attr.data<std::string>() == "" )
  {
    m_attr.setNull();
  }

  // For floats, setValue(NaN) is forbidden in COOL (bug #72147).
  // This is not (yet?) enforced in validate because that would break the
  // possibility to read back existing CORAL NaNs as null.
  else if ( m_attr.specification().type() == typeid( float ) &&
            isNaN( m_attr.data<float>() ) )
  {
    throw StorageTypeFloatIsNaN( name, "FieldAdapter::setValue" );
  }

  // For doubles, setValue(NaN) is forbidden in COOL (bug #72147).
  // This is not (yet?) enforced in validate because that would break the
  // possibility to read back existing CORAL NaNs as null.
  else if ( m_attr.specification().type() == typeid( double ) &&
            isNaN( m_attr.data<double>() ) )
  {
    throw StorageTypeDoubleIsNaN( name, "FieldAdapter::setValue" );
  }

}

//-----------------------------------------------------------------------------

bool FieldAdapter::compareValue( const IField& rhs ) const
{
  if ( this->isNull() || rhs.isNull() )
    return ( this->isNull() && rhs.isNull() );
  // Fix bug #62634: special handling if 'this' wraps a null string attribute
  // Bypass unreliable comparison of wrapped _Attributes_ nullness and values
  // ('this' is a non-null IField == "": check if rhs _IField_ value == "" too)
  if ( this->m_attr.isNull() &&
       this->m_attr.specification().type() == typeid( std::string ) )
    return this->data<std::string>() == rhs.data<std::string>();
  // Compare the values by comparing Attribute's holding them.
  // A temporary Attribute is wrapped around the external IField.
  coral::AttributeList rhsAttrList;
  rhsAttrList.extend( rhs.name(), rhs.storageType().cppType() );
  coral::Attribute& rhsAttr = rhsAttrList[ rhs.name() ];
  rhsAttr.bindUnsafely( rhs.addressOfData() );
  return ( this->m_attr == rhsAttr );
}

//-----------------------------------------------------------------------------

std::ostream& FieldAdapter::printValue( std::ostream& os ) const
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

const coral::Attribute& FieldAdapter::attribute() const
{
  return m_attr;
}

//-----------------------------------------------------------------------------
