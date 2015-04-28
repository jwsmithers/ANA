// First of all, enable or disable the COOL290 API extensions (bug #92204)
#include "CoolKernel/VersionInfo.h"

// Include files
#include <iostream>
#include "CoolKernel/FolderSpecification.h"
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordException.h"
#include "CoolKernel/RecordSpecification.h"
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"

// Local include files (CoolKernel/src)
#include "CoolKernel/../src/scoped_enums.h"

// Local include files (tests/Common)
#include "../Common/CppUnit_headers.h"
#include "../Common/attributeListToString.h"

// Namespace
namespace cool
{
  class FolderSpecTest;
}

//----------------------------------------------------------------------------

class cool::FolderSpecTest : public CppUnit::TestFixture
{

  CPPUNIT_TEST_SUITE( FolderSpecTest );
  CPPUNIT_TEST( test_folderSpec );
  CPPUNIT_TEST( test_bug103351 );
  CPPUNIT_TEST_SUITE_END();

public:

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_folderSpec()
  {
    RecordSpecification spec;
    spec.extend( "A_Bool", cool_StorageType_TypeId::Bool );
    spec.extend( "A_UChar", cool_StorageType_TypeId::UChar );
    spec.extend( "A_Int16", cool_StorageType_TypeId::Int16 );
    spec.extend( "A_UInt16", cool_StorageType_TypeId::UInt16 );
    spec.extend( "A_Int32", cool_StorageType_TypeId::Int32 );
    spec.extend( "A_UInt32", cool_StorageType_TypeId::UInt32 );
    spec.extend( "A_UInt63", cool_StorageType_TypeId::UInt63 );
    spec.extend( "A_Float", cool_StorageType_TypeId::Float );
    spec.extend( "A_Double", cool_StorageType_TypeId::Double );
    spec.extend( "A_String255", cool_StorageType_TypeId::String255 );
    spec.extend( "A_String4k", cool_StorageType_TypeId::String4k );
    spec.extend( "A_String64k", cool_StorageType_TypeId::String64k );
    spec.extend( "A_String16M", cool_StorageType_TypeId::String16M );
    spec.extend( "A_Blob64k", cool_StorageType_TypeId::Blob64k );
    spec.extend( "A_Blob16M", cool_StorageType_TypeId::Blob16M );
    std::cout << "Size=" << spec.size() << std::endl;
    for ( unsigned i=0; i<spec.size(); i++ ) {
      std::cout << "Item #" << i << ": " << spec[i].name()
                << " (" << spec[i].storageType().name() << ")" << std::endl;
    }
    std::string name = "A_String255";
    std::cout << "Item[ " << name << " ]: " << spec[name].name()
              << " (" << spec[name].storageType().name() << ")" << std::endl;
    coral::AttributeList aList = Record(spec).attributeList();
    // Here it would be nice to check at assignment time the maximum string size
    // But we would need our own AttributeList to do that...
    aList[name].setValue( std::string("aaaaa") );
    std::cout << "DATA: " << attributeListToString( aList ) << std::endl;
#ifdef COOL290VP
    RecordSpecification spec1;
    spec1.extend( "A_Bool", cool_StorageType_TypeId::Bool );
    FolderSpecification fSpec( spec1 );
#else
    FolderSpecification fSpec;
    fSpec.payloadSpecification().extend( "A_Bool", cool_StorageType_TypeId::Bool );
#endif
    const IRecordSpecification& payloadSpec = fSpec.payloadSpecification();
    std::cout << "FSize=" << payloadSpec.size() << std::endl;
    for ( unsigned i=0; i<payloadSpec.size(); i++ ) {
      std::cout << "fItem #" << i << ": " << payloadSpec[i].name()
                << " (" << payloadSpec[i].storageType().name()
                << ")" << std::endl;
    }
    coral::AttributeList aList2 = Record(payloadSpec).attributeList();
    std::cout << "DATA2: " << attributeListToString( aList2 ) << std::endl;
    RecordSpecification spec2;
    spec2.extend( name, cool_StorageType_TypeId::String255 );
    Record rec2(spec2);
    std::cout << "Record2 - empty: " << rec2 << std::endl;
    rec2[name].setNull();
    std::cout << "Record2 - null: " << rec2 << std::endl;
    //rec2[name].setNull(false);
    //std::cout << "Record2 - not null: " << rec2 << std::endl;
    rec2[name].setValue(std::string("ABC"));
    std::cout << "Record2 - ABC: " << rec2 << std::endl;
    rec2[name].setNull();
    std::cout << "Record2 - null: " << rec2 << std::endl;
    //rec2[name].setNull(false);
    //std::cout << "Record2 - not null: " << rec2 << std::endl;
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#if defined(__GNUC__) && defined (__GNUC_MINOR__) && ( (__GNUC__==4 && __GNUC_MINOR__ >=6 ) || __GNUC__>4 )
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#endif

  void test_bug103351()
  {
    RecordSpecification spec;
    spec.extend( "A_Bool", cool_StorageType_TypeId::Bool );

    // Test the two-parameter ctor with missing (i.e. default) third parameter
    FolderSpecification fSpec3none( cool_FolderVersioning_Mode::SINGLE_VERSION, spec );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "fSpec3none vMode", cool_FolderVersioning_Mode::SINGLE_VERSION, fSpec3none.versioningMode() );
    CPPUNIT_ASSERT_MESSAGE
      ( "fSpec3none pSpec", spec == fSpec3none.payloadSpecification() );
#ifdef COOL290VP
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "fSpec3none pMode", PayloadMode::Mode::INLINEPAYLOAD, fSpec3none.payloadMode() );
#else
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "fSpec3none hasPT", false, fSpec3none.hasPayloadTable() );
#endif

#ifndef COOL290VP
    // Test the two-parameter ctor with third parameter == false
    bool hasPT = false;
    FolderSpecification fSpec3false( cool_FolderVersioning_Mode::SINGLE_VERSION, spec, hasPT ); // does not compile on COOL290
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "fSpec3false vMode", cool_FolderVersioning_Mode::SINGLE_VERSION, fSpec3false.versioningMode() );
    CPPUNIT_ASSERT_MESSAGE
      ( "fSpec3false pSpec", spec == fSpec3false.payloadSpecification() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "fSpec3false hasPT", false, fSpec3false.hasPayloadTable() );
    // Test the two-parameter ctor with third parameter == true
    hasPT = true;
    FolderSpecification fSpec3true( cool_FolderVersioning_Mode::SINGLE_VERSION, spec, hasPT ); // does not compile on COOL290
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "fSpec3true vMode", cool_FolderVersioning_Mode::SINGLE_VERSION, fSpec3true.versioningMode() );
    CPPUNIT_ASSERT_MESSAGE
      ( "fSpec3true pSpec", spec == fSpec3true.payloadSpecification() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "fSpec3true hasPT", true, fSpec3true.hasPayloadTable() );
#endif

#ifndef COOL290VP
    // Test the two-parameter ctor with third parameter == (int)0
    FolderSpecification fSpec3_0( cool_FolderVersioning_Mode::SINGLE_VERSION, spec, (int)0 ); // does not compile on COOL290
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "fSpec3_0 vMode", cool_FolderVersioning_Mode::SINGLE_VERSION, fSpec3_0.versioningMode() );
    CPPUNIT_ASSERT_MESSAGE
      ( "fSpec3_0 pSpec", spec == fSpec3_0.payloadSpecification() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "fSpec3_0 hasPT", false, fSpec3_0.hasPayloadTable() );
    // Test the two-parameter ctor with third parameter == (int)1
    FolderSpecification fSpec3_1( cool_FolderVersioning_Mode::SINGLE_VERSION, spec, (int)1 ); // does not compile on COOL290
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "fSpec3_1 vMode", cool_FolderVersioning_Mode::SINGLE_VERSION, fSpec3_1.versioningMode() );
    CPPUNIT_ASSERT_MESSAGE
      ( "fSpec3_1 pSpec", spec == fSpec3_1.payloadSpecification() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "fSpec3_1 hasPT", true, fSpec3_1.hasPayloadTable() );
    // Test the two-parameter ctor with third parameter == (int)2
    FolderSpecification fSpec3_2( cool_FolderVersioning_Mode::SINGLE_VERSION, spec, (int)2 ); // does not compile on COOL290
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "fSpec3_2 vMode", cool_FolderVersioning_Mode::SINGLE_VERSION, fSpec3_2.versioningMode() );
    CPPUNIT_ASSERT_MESSAGE
      ( "fSpec3_2 pSpec", spec == fSpec3_2.payloadSpecification() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "fSpec3_2 hasPT", true, fSpec3_2.hasPayloadTable() ); // OK: REMOVED IN COOL290!
#endif

#ifdef COOL290VP
    // Test the two-parameter ctor with third parameter == (PayloadMode::Mode)0
    FolderSpecification fSpec3e0( cool_FolderVersioning_Mode::SINGLE_VERSION, spec, (PayloadMode::Mode)0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "fSpec3e0 vMode", cool_FolderVersioning_Mode::SINGLE_VERSION, fSpec3e0.versioningMode() );
    CPPUNIT_ASSERT_MESSAGE
      ( "fSpec3e0 pSpec", spec == fSpec3e0.payloadSpecification() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "fSpec3e0 pMode", PayloadMode::Mode::INLINEPAYLOAD, fSpec3e0.payloadMode() );
    // Test the two-parameter ctor with third parameter == (PayloadMode::Mode)1
    FolderSpecification fSpec3e1( cool_FolderVersioning_Mode::SINGLE_VERSION, spec, (PayloadMode::Mode)1 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "fSpec3e1 vMode", cool_FolderVersioning_Mode::SINGLE_VERSION, fSpec3e1.versioningMode() );
    CPPUNIT_ASSERT_MESSAGE
      ( "fSpec3e1 pSpec", spec == fSpec3e1.payloadSpecification() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "fSpec3e1 pMode", PayloadMode::Mode::SEPARATEPAYLOAD, fSpec3e1.payloadMode() );
    // Test the two-parameter ctor with third parameter == (PayloadMode::Mode)2
    FolderSpecification fSpec3e2( cool_FolderVersioning_Mode::SINGLE_VERSION, spec, (PayloadMode::Mode)2 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "fSpec3e2 vMode", cool_FolderVersioning_Mode::SINGLE_VERSION, fSpec3e2.versioningMode() );
    CPPUNIT_ASSERT_MESSAGE
      ( "fSpec3e2 pSpec", spec == fSpec3e2.payloadSpecification() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "fSpec3e2 pMode", PayloadMode::Mode::VECTORPAYLOAD, fSpec3e2.payloadMode() ); // OK!
#endif
  }

#if defined(__GNUC__) && defined (__GNUC_MINOR__) && ( (__GNUC__==4 && __GNUC_MINOR__ >=6 ) || __GNUC__>4 )
#pragma GCC diagnostic pop
#endif

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  FolderSpecTest() {}

  ~FolderSpecTest() {}

  void setUp() {}

  void tearDown() {}

};

CPPUNIT_TEST_SUITE_REGISTRATION( cool::FolderSpecTest );

//-----------------------------------------------------------------------------

// Include CppUnit test driver (tests/Common)
#include "../Common/CppUnit_testdriver.icpp"