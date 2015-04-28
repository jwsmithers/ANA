#ifndef COOLKERNEL_CONSTFIELDADAPTER_H
#define COOLKERNEL_CONSTFIELDADAPTER_H 1

// Include files
#include "CoolKernel/IField.h"
#include "CoralBase/Attribute.h"

namespace cool
{

  //--------------------------------------------------------------------------

  /** @class ConstFieldAdapter ConstFieldAdapter.h
   *
   *  Read-only wrapper of a constant coral::Attribute reference,
   *  implementing the cool::IField interface. The field specification is
   *  also kept only as a reference. The adapter can only be used as long
   *  as both the Attribute and the IFieldSpecification references are alive.
   *
   *  All non-const methods throw: this is effectively a read-only class.
   *
   *  This is essentially a private class of ConstRecordAdapter.
   *  The StorageType constraints on the data values of the coral
   *  Attribute are not performed by ConstFieldAdapter at construction time
   *  because they are delegated to the relevant ConstRecordAdapter methods.
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

  class ConstFieldAdapter : public IField {

  public:

    virtual ~ConstFieldAdapter();

    /// Constructor from a const field spec and a const Attribute references.
    /// Null string attributes are considered equal to "".
    ConstFieldAdapter( const IFieldSpecification& spec,
                       const coral::Attribute& attr );

    /// Return the specification of this field.
    const IFieldSpecification& specification() const;

    /// Is the value of this field null?
    /// For strings, this is always false (if the attribute is null,
    /// this is reinterpreted as a non null attribute equal to "").
    bool isNull() const;

    /// Return the address of the true-type data value of this field.
    /// Throw FieldIsNull the field is null, i.e. if isNull() is true.
    /// For strings, return a pointer to a static "" if the attribute is null.
    const void* addressOfData() const;

    /// Compare the values of this and another field.
    /// The values of two fields are equal either if they are both non null
    /// and their true type values are equal, or if they are both null
    bool compareValue( const IField& rhs ) const;

    /// Print the data value of this field.
    /// Print "NULL" if the field is null (print "" for null strings).
    std::ostream& printValue( std::ostream& os ) const;

    /// Explicit conversion to a constant coral Attribute reference.
    const coral::Attribute& attribute() const;

  private:

    /// This method THROWS an exception because this is a read-only class.
    void setNull();

    /// This method THROWS an exception because this is a read-only class.
    void setValue( const std::type_info& cppType,
                   const void* externalAddress );

  private:

    /// Default constructor is private
    ConstFieldAdapter();

    /// Copy constructor is private
    ConstFieldAdapter( const ConstFieldAdapter& rhs );

    /// Assignment operator is private
    ConstFieldAdapter& operator=( const ConstFieldAdapter& rhs );

  private:

    /// The field specification.
    /// CONST REFERENCE: the adapter can only be used as long as this is alive!
    const IFieldSpecification& m_spec;

    /// The field data (as an Attribute const reference).
    /// CONST REFERENCE: the adapter can only be used as long as this is alive!
    const coral::Attribute& m_attr;

  };

}
#endif // COOLKERNEL_CONSTFIELDADAPTER_H
