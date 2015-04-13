// $Id: test_Record.cpp,v 1.19 2009-12-16 17:31:23 avalassi Exp $

// Include files
#include <cstdlib> // For getenv on gcc43
#include <iostream>
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordException.h"

// Local include files (tests/Common)
#include "../Common/CppUnit_headers.h"
#include "../Common/attributeListToString.h"

// Namespace
namespace cool {
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
      spec.extend( "A_Bool", StorageType::Bool );
      spec.extend( "A_UChar", StorageType::UChar );
      spec.extend( "A_Int16", StorageType::Int16 );
      spec.extend( "A_UInt16", StorageType::UInt16 );
      spec.extend( "A_Int32", StorageType::Int32 );
      spec.extend( "A_UInt32", StorageType::UInt32 );
      spec.extend( "A_UInt63", StorageType::UInt63 );
      spec.extend( "A_Int64", StorageType::Int64 );
      spec.extend( "A_Float", StorageType::Float );
      spec.extend( "A_Double", StorageType::Double );
      spec.extend( "A_String255", StorageType::String255 );
      spec.extend( "A_String4k", StorageType::String4k );
      spec.extend( "A_String64k", StorageType::String64k );
      spec.extend( "A_String16M", StorageType::String16M );
      spec.extend( "A_Blob64k", StorageType::Blob64k );
      spec.extend( "A_Blob16M", StorageType::Blob16M );

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
        StorageType::storageType( StorageType::String255 );
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
