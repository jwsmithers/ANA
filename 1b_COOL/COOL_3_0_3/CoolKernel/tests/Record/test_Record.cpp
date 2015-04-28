// First of all, enable or disable the COOL290 API extensions (bug #92204)
#include "CoolKernel/VersionInfo.h"

// Include files
#ifdef COOL_HAS_CPP11
#include <cstdint> // For int64_t
#endif
#include <cstdlib> // For getenv on gcc43
#include <iostream>
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordException.h"

// Local include files (CoolKernel/src)
#include "CoolKernel/../src/scoped_enums.h"

// Local include files (tests/Common)
#include "../Common/CppUnit_headers.h"
#include "../Common/attributeListToString.h"

// Namespace
namespace cool
{
  class RecordTest;
}

//-----------------------------------------------------------------------------

class cool::RecordTest : public CppUnit::TestFixture {

  CPPUNIT_TEST_SUITE( RecordTest );

  CPPUNIT_TEST( test_createRecord );

  CPPUNIT_TEST( test_constructors );

  CPPUNIT_TEST_SUITE_END();

public:

  bool debug;

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_createRecord()
  {

    try {

      RecordSpecification spec;
      spec.extend( "A_Bool", cool_StorageType_TypeId::Bool );
      spec.extend( "A_UChar", cool_StorageType_TypeId::UChar );
      spec.extend( "A_Int16", cool_StorageType_TypeId::Int16 );
      spec.extend( "A_UInt16", cool_StorageType_TypeId::UInt16 );
      spec.extend( "A_Int32", cool_StorageType_TypeId::Int32 );
      spec.extend( "A_UInt32", cool_StorageType_TypeId::UInt32 );
      spec.extend( "A_UInt63", cool_StorageType_TypeId::UInt63 );
      spec.extend( "A_Int64", cool_StorageType_TypeId::Int64 );
      spec.extend( "A_Float", cool_StorageType_TypeId::Float );
      spec.extend( "A_Double", cool_StorageType_TypeId::Double );
      spec.extend( "A_String255", cool_StorageType_TypeId::String255 );
      spec.extend( "A_String4k", cool_StorageType_TypeId::String4k );
      spec.extend( "A_String64k", cool_StorageType_TypeId::String64k );
      spec.extend( "A_String16M", cool_StorageType_TypeId::String16M );
      spec.extend( "A_Blob64k", cool_StorageType_TypeId::Blob64k );
      spec.extend( "A_Blob16M", cool_StorageType_TypeId::Blob16M );

      Record rec( spec );
      UInt32 size = rec.specification().size();
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Specification size", (UInt32)16, size );

      for ( unsigned i=0; i<size; i++ ) {
        std::stringstream out;
        out << "item #" << i;
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Name of " + out.str(),
            rec[i].name(),
            spec[i].name() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Type of " + out.str(),
            rec[i].storageType().name(),
            spec[i].storageType().name() );
      }

      std::string name = "A_String255";
      std::string str255( 255, 'A' );
      rec[name].setValue( str255 );
      try {
        std::string str256( 256, 'B' );
        rec[name].setValue( str256 );
        CPPUNIT_FAIL( "Inserting 256 char should fail" );
      }
      catch ( RecordException& ) {}
      catch ( ... ) {
        CPPUNIT_FAIL( "Inserting 256 char threw UNKNOWN exception" );
      }

      if ( debug ) {
        // This will print 255 A instead of 256 B
        std::cout << "Record[" << name << "]: "
                  << rec[name].data<std::string>() << std::endl;
        std::cout << "DATA: " << rec << std::endl;
      }

#ifdef COOL_HAS_CPP11
      // Quick test for int64_t vs cool::Int64 (CORALCOOL-2734)
      std::cout << std::endl << "Record[A_Int64] as Int64: "
                << rec["A_Int64"].data<cool::Int64>() << std::endl;
      std::cout << "Record[A_Int64] as long long: "
                << rec["A_Int64"].data<long long>() << std::endl;
      try
      {
        std::cout << "Record[A_Int64] as int64_t: "
                  << rec["A_Int64"].data<int64_t>() << std::endl;
      }
      catch( cool::FieldWrongCppType& e )
      {
        std::cout << "Exception caught while trying to retrieve "
                  << "Record[A_Int64] as int64_t: " << e.what() << std::endl;
      }
#endif

    }

    catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }

  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_constructors()
  {

    try {

      const std::string name = "A_String255";
      const StorageType& type =
        StorageType::storageType( cool_StorageType_TypeId::String255 );
      RecordSpecification spec;
      spec.extend( name, type );
      Record rec( spec );

      std::string str255( 255, 'A' );
      rec[name].setValue( str255 );

      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Size", (UInt32)1, rec.specification().size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Name", name, rec[name].name() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Type", type.name(), rec[name].storageType().name() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Value", str255, rec[name].data<String255>() );

      // Test constructor from field spec
      // Test IField::setValue( const IField& )
      {
        const IFieldSpecification& fspec = rec.specification()[0];
        Record rec2( fspec );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Size", (UInt32)1, rec2.specification().size() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Name2", name, rec2[name].name() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Type2", type.name(), rec2[name].storageType().name() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Value2 old", std::string(""), rec2[name].data<String255>() );
        rec2[0].setValue( rec[0] );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Value2 new", str255, rec2[name].data<String255>() );
      }

      // Test copy constructor from const Record&
      {
        Record rec2( rec );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Size", (UInt32)1, rec2.specification().size() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Name2", name, rec2[name].name() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Type2", type.name(), rec2[name].storageType().name() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Value2", str255, rec2[name].data<String255>() );
      }

      // Test copy constructor from const IRecord&
      {
        IRecord& irec = rec;
        Record rec2( irec );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Size", (UInt32)1, rec2.specification().size() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Name2", name, rec2[name].name() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Type2", type.name(), rec2[name].storageType().name() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Value2", str255, rec2[name].data<String255>() );
      }

      // Test assignment from const Record&
      {
        Record rec2;
        rec2 = rec;
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Size", (UInt32)1, rec2.specification().size() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Name2", name, rec2[name].name() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Type2", type.name(), rec2[name].storageType().name() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Value2", str255, rec2[name].data<String255>() );
      }

      // Test assignment from const IRecord&
      {
        IRecord& irec = rec;
        Record rec2;
        rec2 = irec;
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Size", (UInt32)1, rec2.specification().size() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Name2", name, rec2[name].name() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Type2", type.name(), rec2[name].storageType().name() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Value2", str255, rec2[name].data<String255>() );
      }

    }

    catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }

  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  RecordTest()
    : debug( false )
  {
    if ( getenv( "COOLTEST_DEBUG" ) ) debug = true;
  }

  ~RecordTest() {}

  void setUp() {
    if ( debug ) std::cout << std::endl;
  }

  void tearDown() {}

};

CPPUNIT_TEST_SUITE_REGISTRATION( cool::RecordTest );

//-----------------------------------------------------------------------------

// Include CppUnit test driver (tests/Common)
#include "../Common/CppUnit_testdriver.icpp"
