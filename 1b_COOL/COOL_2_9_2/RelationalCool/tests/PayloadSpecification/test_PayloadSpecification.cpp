// $Id: test_PayloadSpecification.cpp,v 1.18 2013-03-08 10:53:24 avalassi Exp $

// Include files
#include "CoralBase/Attribute.h"
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordException.h"
#include "CoolKernel/RecordSpecification.h"

// Local include files
//#define COOLUNITTESTTIMER 1
#include "CoolKernel/../tests/Common/CoolUnitTest.h"
#include "../../src/RelationalDatabase.h"
#include "../../src/RelationalException.h"
#include "../../src/RelationalQueryMgr.h"

// Forward declaration (for easier indentation)
namespace cool
{
  class PayloadSpecificationTest;
}

class cool::PayloadSpecificationTest : public CoolUnitTest
{

private:

  inline const std::type_info&
  typeIdToCoralType( const StorageType::TypeId type_id )
  {
    return StorageType::storageType( type_id ).cppType();
  }

private:

  CPPUNIT_TEST_SUITE( PayloadSpecificationTest );
  CPPUNIT_TEST( test_extend );
  CPPUNIT_TEST( test_cannot_extend );
  CPPUNIT_TEST( test_copy_constructor );
  CPPUNIT_TEST( test_sum );
  CPPUNIT_TEST( test_size );
  CPPUNIT_TEST( test_empty );
  CPPUNIT_TEST( test_extend_AL );
  CPPUNIT_TEST( test_create_AL );
  CPPUNIT_TEST( test_check_AL );
  CPPUNIT_TEST( test_check_AL_bad_size );
  CPPUNIT_TEST( test_check_AL_bad_string_size );
  CPPUNIT_TEST( test_check_AL_good_string_size );
  CPPUNIT_TEST( test_check_AL_bad_UInt63 );
  CPPUNIT_TEST( test_check_AL_good_UInt63 );
  CPPUNIT_TEST( test_check_AL_unexpected_type );
  // Tests coming from RelationalDatabase tests
  CPPUNIT_TEST( test_encode_decode );
  CPPUNIT_TEST( test_decodeEmptySpec );
  CPPUNIT_TEST( test_decodeNoColon );
  CPPUNIT_TEST( test_decodeTrailingComma );
  CPPUNIT_TEST_SUITE_END();

public:

  // ------------------------------------------------------
  void test_extend() {
    // ------------------------------------------------------
    // -- allowed macros
    // CPPUNIT_ASSERT(condition)
    // CPPUNIT_ASSERT_MESSAGE(message,condition)
    // CPPUNIT_ASSERT_EQUAL(expected,actual)
    // CPPUNIT_ASSERT_EQUAL_MESSAGE(message,expected,actual)
    // CPPUNIT_ASSERT_DOUBLES_EQUAL(expected,actual,delta)
    // CPPUNIT_ASSERT_THROW( expression, ExceptionType )
    // CPPUNIT_ASSERT_NO_THROW( expression )

    // Test the signatures of the RecordSpecification::extend method
    RecordSpecification pls;

    // void extend( const std::string&, const StorageType::TypeId );
    pls.extend( "I", cool::StorageType::Int32 );

    // void extend( const std::string&, const StorageType& );
    pls.extend
      ( "X", cool::StorageType::storageType( cool::StorageType::Float ) );

    // void extend( const IFieldSpecification& );
    RecordSpecification tmp_pls1;
    tmp_pls1.extend( "S255", cool::StorageType::String255 );
    pls.extend( tmp_pls1["S255"] );

    // void extend( const IRecordSpecification& );
    RecordSpecification tmp_pls2;
    tmp_pls2.extend( "A", cool::StorageType::UInt32 );
    tmp_pls2.extend( "B", cool::StorageType::String4k );
    pls.extend( tmp_pls2 );

    // Check that the final specification is as expected
    CPPUNIT_ASSERT_MESSAGE
      ("RecordSpec::extend(const std::string&, StorageType::TypeId) failed",
       pls["I"].storageType() == cool::StorageType::Int32);
    CPPUNIT_ASSERT_MESSAGE
      ("RecordSpec::extend(const std::string&, const StorageType&) failed",
       pls["X"].storageType() == cool::StorageType::Float);
    CPPUNIT_ASSERT_MESSAGE
      ("RecordSpec::extend(const IFieldSpecification&) failed",
       pls["S255"].storageType() == cool::StorageType::String255);

    CPPUNIT_ASSERT_MESSAGE
      ("RecordSpec::extend(const IRecordSpecification&)failed",
       (pls["A"].storageType() == cool::StorageType::UInt32) &&
       (pls["B"].storageType() == cool::StorageType::String4k));

  }

  // ------------------------------------------------------
  void test_cannot_extend() {
    // ------------------------------------------------------
    RecordSpecification pls;

    pls.extend( "A", cool::StorageType::UInt32 );
    pls.extend( "B", cool::StorageType::String4k );

    CPPUNIT_ASSERT_THROW
      ( pls.extend( "A", cool::StorageType::String255 ),
        RecordSpecificationCannotExtend );

  }

  // ------------------------------------------------------
  void test_copy_constructor() {
    // ------------------------------------------------------
    RecordSpecification pls;

    pls.extend( "A", cool::StorageType::UInt32 );
    pls.extend( "B", cool::StorageType::String4k );

    RecordSpecification pls2(pls);

    CPPUNIT_ASSERT_MESSAGE
      ("RecordSpec::extend(const IRecordSpecification&) failed",
       (pls2["A"].storageType() == cool::StorageType::UInt32) &&
       (pls2["B"].storageType() == cool::StorageType::String4k));

  }

  // ------------------------------------------------------
  void test_sum() {
    // ------------------------------------------------------
    RecordSpecification pls1;

    pls1.extend( "A", cool::StorageType::UInt32 );
    pls1.extend( "B", cool::StorageType::String4k );

    RecordSpecification pls2;

    pls2.extend( "C", cool::StorageType::Float );
    pls2.extend( "D", cool::StorageType::Double );

    RecordSpecification pls = pls1;
    pls.extend( pls2 );

    CPPUNIT_ASSERT_MESSAGE
      ("RecordSpec::extend(const IRecordSpecification&) failed",
       (pls["A"].storageType() == cool::StorageType::UInt32) &&
       (pls["B"].storageType() == cool::StorageType::String4k) &&
       (pls["C"].storageType() == cool::StorageType::Float) &&
       (pls["D"].storageType() == cool::StorageType::Double));

  }

  // ------------------------------------------------------
  void test_size() {
    // ------------------------------------------------------
    RecordSpecification pls;

    CPPUNIT_ASSERT_EQUAL((UInt32)0,pls.size());

    pls.extend( "A", cool::StorageType::UInt32 );

    CPPUNIT_ASSERT_EQUAL((UInt32)1,pls.size());

    pls.extend( "B", cool::StorageType::String4k );

    CPPUNIT_ASSERT_EQUAL((UInt32)2,pls.size());
  }

  // ------------------------------------------------------
  void test_empty() {
    // ------------------------------------------------------
    RecordSpecification pls;

    CPPUNIT_ASSERT(pls.size()==0);

    pls.extend( "TEST", cool::StorageType::Double );

    CPPUNIT_ASSERT(pls.size()!=0);
  }

  // ------------------------------------------------------
  void test_extend_AL() {
    // ------------------------------------------------------
    RecordSpecification pls;

    pls.extend( "A", cool::StorageType::UInt32 );
    pls.extend( "B", cool::StorageType::String4k );

    coral::AttributeList al = Record( pls ).attributeList();

    CPPUNIT_ASSERT_MESSAGE
      ("Test_extend_AL failed",
       (al["A"].specification().type() ==
        typeIdToCoralType(cool::StorageType::UInt32)) &&
       (al["B"].specification().type() ==
        typeIdToCoralType(cool::StorageType::String4k)));
  }

  // ------------------------------------------------------
  void test_create_AL() {
    // ------------------------------------------------------
    RecordSpecification pls;

    pls.extend( "A", cool::StorageType::UInt32 );
    pls.extend( "B", cool::StorageType::String4k );

    coral::AttributeList al = Record( pls ).attributeList();

    CPPUNIT_ASSERT_MESSAGE
      ("Test_create_AL failed",
       (al["A"].specification().type() ==
        typeIdToCoralType(cool::StorageType::UInt32)) &&
       (al["B"].specification().type() ==
        typeIdToCoralType(cool::StorageType::String4k)));
  }

  // ------------------------------------------------------
  void test_check_AL() {
    // ------------------------------------------------------
    std::vector<StorageType::TypeId> all_types;

    all_types.push_back(StorageType::Bool);
    //all_types.push_back(StorageType::Char);
    all_types.push_back(StorageType::UChar);
    all_types.push_back(StorageType::Int16);
    all_types.push_back(StorageType::UInt16);
    all_types.push_back(StorageType::Int32);
    all_types.push_back(StorageType::UInt32);
    all_types.push_back(StorageType::UInt63);
    all_types.push_back(StorageType::Int64);
    //all_types.push_back(StorageType::UInt64);
    all_types.push_back(StorageType::Float);
    all_types.push_back(StorageType::Double);
    all_types.push_back(StorageType::String255);
    all_types.push_back(StorageType::String4k);
    all_types.push_back(StorageType::String64k);
    all_types.push_back(StorageType::String16M);

    RecordSpecification pls;
    std::vector<StorageType::TypeId>::iterator i;
    for(i = all_types.begin(); i != all_types.end(); ++i ) {
      pls.extend( StorageType::storageType(*i).name(),*i);
    }

    coral::AttributeList al = Record( pls ).attributeList();

    CPPUNIT_ASSERT_NO_THROW(pls.validate(al));
  }

  // ------------------------------------------------------
  void test_check_AL_bad_size() {
    // ------------------------------------------------------

    std::vector<StorageType::TypeId> all_types;
    all_types.push_back(StorageType::Int32);
    all_types.push_back(StorageType::UInt32);
    all_types.push_back(StorageType::UInt63);
    all_types.push_back(StorageType::Float);

    RecordSpecification pls;
    std::vector<StorageType::TypeId>::iterator i;
    for(i = all_types.begin(); i != all_types.end(); ++i )
      pls.extend(StorageType::storageType(*i).name(),*i);

    coral::AttributeList al = Record( pls ).attributeList();
    al.extend("AnotherOne","double");

    CPPUNIT_ASSERT_THROW(pls.validate(al),
                         RecordSpecificationWrongSize);

  }

  // ------------------------------------------------------
  void test_check_AL_bad_string_size() {
    // ------------------------------------------------------

    std::vector<StorageType::TypeId> all_types;
    all_types.push_back(StorageType::String255);
    all_types.push_back(StorageType::String4k);
    all_types.push_back(StorageType::String64k);
    all_types.push_back(StorageType::String16M);

    std::vector<StorageType::TypeId>::iterator i;
    for(i = all_types.begin(); i != all_types.end(); ++i ) {

      RecordSpecification pls;

      pls.extend("S",*i);

      coral::AttributeList al = Record( pls ).attributeList();

      al["S"].data<std::string>().append
        (StorageType::storageType(*i).maxSize()+1,'x');

      CPPUNIT_ASSERT_THROW(pls.validate(al),
                           StorageTypeInvalidValue);

    }
  }

  // ------------------------------------------------------
  void test_check_AL_good_string_size() {
    // ------------------------------------------------------

    std::vector<StorageType::TypeId> all_types;
    all_types.push_back(StorageType::String255);
    all_types.push_back(StorageType::String4k);
    all_types.push_back(StorageType::String64k);
    all_types.push_back(StorageType::String16M);

    std::vector<StorageType::TypeId>::iterator i;
    for(i = all_types.begin(); i != all_types.end(); ++i ) {

      RecordSpecification pls;

      pls.extend("S",*i);

      coral::AttributeList al = Record( pls ).attributeList();

      al["S"].data<std::string>()
        .append(StorageType::storageType(*i).maxSize(),'x');

      CPPUNIT_ASSERT_NO_THROW(pls.validate(al));

    }

  }

  // ------------------------------------------------------
  void test_check_AL_bad_UInt63() {
    // ------------------------------------------------------
    RecordSpecification pls;
    pls.extend("I", StorageType::UInt63);

    coral::AttributeList al = Record( pls ).attributeList();

    al["I"].data<UInt63>() = 9223372036854775808ULL;

    CPPUNIT_ASSERT_THROW(pls.validate(al),
                         StorageTypeInvalidValue);

  }

  // ------------------------------------------------------
  void test_check_AL_good_UInt63() {
    // ------------------------------------------------------
    RecordSpecification pls;
    pls.extend("I", StorageType::UInt63);

    coral::AttributeList al = Record( pls ).attributeList();

    al["I"].data<UInt63>() = 9223372036854775807ULL;

    CPPUNIT_ASSERT_NO_THROW(pls.validate(al));

  }

  // ------------------------------------------------------
  void test_check_AL_unexpected_type() {
    // ------------------------------------------------------
    RecordSpecification pls;
    pls.extend( "A", cool::StorageType::UInt32 );
    pls.extend( "B", cool::StorageType::String4k );

    coral::AttributeList al;
    al.extend<cool::UInt32>("A");
    al.extend<float>("B");

    CPPUNIT_ASSERT_THROW(pls.validate(al),
                         StorageTypeWrongCppType);

  }


  // ------------------------------------------------------
  void test_encode_decode() {
    // ------------------------------------------------------
    typedef std::pair<std::string,StorageType::TypeId> pair_type;
    std::vector<pair_type> all_types;

    all_types.push_back(pair_type("Bool",StorageType::Bool));
    //all_types.push_back(pair_type("Char",StorageType::Char));
    all_types.push_back(pair_type("UChar",StorageType::UChar));
    all_types.push_back(pair_type("Int16",StorageType::Int16));
    all_types.push_back(pair_type("UInt16",StorageType::UInt16));
    all_types.push_back(pair_type("Int32",StorageType::Int32));
    all_types.push_back(pair_type("UInt32",StorageType::UInt32));
    all_types.push_back(pair_type("UInt63",StorageType::UInt63));
    all_types.push_back(pair_type("Int64",StorageType::Int64));
    //all_types.push_back(pair_type("UInt64",StorageType::UInt64));
    all_types.push_back(pair_type("Float",StorageType::Float));
    all_types.push_back(pair_type("Double",StorageType::Double));
    all_types.push_back(pair_type("String255",StorageType::String255));
    all_types.push_back(pair_type("String4k",StorageType::String4k));
    all_types.push_back(pair_type("String64k",StorageType::String64k));
    all_types.push_back(pair_type("String16M",StorageType::String16M));

    RecordSpecification pls;
    std::ostringstream expected;

    std::vector<pair_type>::iterator i;
    for(i = all_types.begin(); i != all_types.end(); ++i ) {
      pls.extend(i->first,i->second);
      if (i != all_types.begin()) expected << ",";
      expected << i->first << ":"
               << StorageType::storageType(i->second).name();
    }

    CPPUNIT_ASSERT_EQUAL
      ( expected.str(), RelationalDatabase::encodeRecordSpecification(pls) );

    std::string pls2 =
      RelationalDatabase::encodeRecordSpecification(pls);

    CPPUNIT_ASSERT_MESSAGE
      ("encoded and decoded payloads do not match",
       pls == RelationalDatabase::decodeRecordSpecification(pls2));

  }

  // ------------------------------------------------------
  void test_decodeEmptySpec() {
    // ------------------------------------------------------

    std::string encodedSpec = "";
    RecordSpecification spec =
      RelationalDatabase::decodeRecordSpecification(encodedSpec);
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( std::string( "RecordSpecification size" ),
        (UInt32)0,spec.size() );
  }

  // Tests exception in decoding spec with no ":" colon
  // (missing type - "name" instead of "name:type")
  // ------------------------------------------------------
  void test_decodeNoColon() {
    // ------------------------------------------------------
    CPPUNIT_ASSERT_THROW
      ( RelationalDatabase::decodeRecordSpecification("I/Int32"),
        RelationalException );
  }


  // ------------------------------------------------------
  void test_decodeTrailingComma() {
    // ------------------------------------------------------
    CPPUNIT_ASSERT_THROW
      ( RelationalDatabase::decodeRecordSpecification("I:Int32,"),
        RelationalException );
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  // Constructor (executed N times, _before_ all N test executions)
  PayloadSpecificationTest() : CoolUnitTest()
  {
  }

  // Destructor (executed N times, _after_ all N test executions)
  ~PayloadSpecificationTest()
  {
  }

private:

  // Setup (executed N times, at the start of each test execution)
  void coolUnitTest_setUp()
  {
  }

  // TearDown (executed N times, at the end of each test execution)
  void coolUnitTest_tearDown()
  {
  }

};

CPPUNIT_TEST_SUITE_REGISTRATION( cool::PayloadSpecificationTest );

COOLTEST_MAIN( PayloadSpecificationTest )
