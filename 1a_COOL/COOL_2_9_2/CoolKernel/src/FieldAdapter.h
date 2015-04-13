// $Id: FieldAdapter.h,v 1.16 2009-12-16 17:31:22 avalassi Exp $
#ifndef COOLKERNEL_FIELDADAPTER_H
#define COOLKERNEL_FIELDADAPTER_H 1

// Include files
#include "CoolKernel/IField.h"
#include "CoralBase/Attribute.h"

namespace cool
{

  //--------------------------------------------------------------------------

  /** @class FieldAdapter FieldAdapter.h
   *
   *  Read-write wrapper of a non-constant coral::Attribute reference,
   *  implementing the cool::IField interface. The field specification is
   *  also kept only as a reference. The adapter can only be used as long
   *  as both the Attribute and the IFieldSpecification references are alive.
   *
   *  This is essentially a private class of Record.
   *  The StorageType constraints on the data values of the coral
   *  Attribute are not performed by FieldAdapter at construction time
   *  because they are delegated to the relevant Record methods.
   *  The constraints are instead validated internally in setValue.
   *
   *  Note the special semantics of null values for string variables only.
   *  For strings, setNull() is now considered equivalent to setValue(""):
   *  after such calls, isNull() returns false, and data() returns "".
   *  This has been introduced to avoid inconsistencies for Oracle databases
   *  (where empty strings are treated as SQL NULL values - see bug #22381).
   *  **WARNING**: CORAL Attribute's are different from COOL Field's in the
   *  management of null values. IField::data<T>() throws if IField::isNull()
   *  returns true, while coral::Attribute::data<T>() does not throw and
   *  returns an undefined value if coral::Attribute::isNull() returns true.
   *  Note also that IField::isNull() is always false for strings.
   *
   *  **WARNING**: in line with was explained above about CORAL Attribute's
   *  being different from COOL Field's in the management of null values, the
   *  Attribute reference returned by the attribute() method will behave as
   *  follows: for all types except strings, isNull() and attribute().isNull(),
   *  as well as data() and attribute().data(), always return the same value;
   *  for strings, isNull() always returns false, while data() returns ""
   *  if either of attribute().isNull() or attribute.data<std::string>()==""
   *  are true, but it is not guaranteed that both these conditions are true.
   *
   *  @author Andrea Valassi and Marco Clemencic
   *  @date   2006-12-04
   *///

  class FieldAdapter : public IField {

  public:

    virtual ~FieldAdapter();

    /// Constructor from a field spec and a non-const Attribute references.
    /// Null string attributes are considered (but _not_ reset) equal to "".
    FieldAdapter( const IFieldSpecification& spec,
                  coral::Attribute& attr );

    /// Return the specification of this field.
    const IFieldSpecification& specification() const;

    /// Is the value of this field null?
    /// For strings, this is always false (if the attribute is null,
    /// this is reinterpreted as a non null attribute equal to "").
    bool isNull() const;

    /// Return the address of the true-type data value of this field.
    /// Throw FieldIsNull if the field is null (for all storage types):
    /// For strings, the attribute contains "" if setNull() was called;
    /// if the original attribute is null, return a pointer to a static "".
    const void* addressOfData() const;

    /// Set the value of this field to null: any previous value is lost.
    /// For strings, setNull() is equivalent to setValue(""): data() and
    /// addressOfData() will return "" and a pointer to "" after setNull().
    void setNull();

    /// Set the value of this field to a well defined (non null) true-type.
    /// Throw FieldWrongCppType if the field C++ type is not cppType.
    /// For strings, setNull() is equivalent to setValue("").
    void setValue( const std::type_info& cppType,
                   const void* externalAddress );

    /// Compare the values of this and another field.
    /// The values of two fields are equal either if they are both non null
    /// and their true type values are equal, or if they are both null.
    bool compareValue( const IField& rhs ) const;

    /// Print the data value of this field.
    /// Print "NULL" if the field is null (print "" for null strings).
    std::ostream& printValue( std::ostream& os ) const;

    /// Explicit conversion to a constant coral Attribute reference.
    const coral::Attribute& attribute() const;

  private:

    /// Default constructor is private
    FieldAdapter();

    /// Copy constructor is private
    FieldAdapter( const FieldAdapter& rhs );

    /// Assignment operator is private
    FieldAdapter& operator=( const FieldAdapter& rhs );

  private:

    /// The field specification.
    /// CONST REFERENCE: the adapter can only be used as long as this is alive!
    const IFieldSpecification& m_spec;

    /// The field data (as an Attribute non-const reference).
    /// REFERENCE: the adapter can only be used as long as this is alive!
    coral::Attribute& m_attr;

  };

}
#endif // COOLKERNEL_FIELDADAPTER_H
