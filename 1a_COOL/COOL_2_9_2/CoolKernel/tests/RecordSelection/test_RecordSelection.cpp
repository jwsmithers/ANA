// $Id: test_RecordSelection.cpp,v 1.20 2011-10-03 07:08:37 avalassi Exp $

// Include files
#include <cstdlib>
#include <iostream>
#include "CoolKernel/FieldSelection.h"
#include "CoolKernel/IFolder.h"

// Local include files (tests/Common)
#include "../Common/CppUnit_headers.h"
#include "../Common/attributeListToString.h"

// Namespace
namespace cool
{
  class RecordSelectionTest;
}

//-----------------------------------------------------------------------------

class cool::RecordSelectionTest : public CppUnit::TestFixture {

  CPPUNIT_TEST_SUITE( RecordSelectionTest );

  CPPUNIT_TEST( test_createFieldSelection );

  CPPUNIT_TEST_SUITE_END();

public:

  bool debug;

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_createFieldSelection()
  {
    try
    {
      RecordSpecification spec;
      spec.extend("I", StorageType::Int32);
      spec.extend("S", StorageType::String4k);
      spec.extend("X", StorageType::Float);
      Record rec(spec);

      RecordSpecification spec_types;
      spec_types.extend("I", StorageType::Double);
      spec_types.extend("S", StorageType::UInt32);
      spec_types.extend("X", StorageType::String255);
      Record rec_types(spec_types);

      RecordSpecification spec_field;
      spec.extend("I1", StorageType::Int32);
      spec.extend("S1", StorageType::String4k);
      spec.extend("X1", StorageType::Float);
      Record rec_field(spec_field);

      FieldSelection sel("I",StorageType::Int32, FieldSelection::EQ, (Int32)5);

      CPPUNIT_ASSERT_EQUAL_MESSAGE("canSelect 1",
                                   sel.canSelect(spec), true);
      CPPUNIT_ASSERT_EQUAL_MESSAGE("canSelect 2",
                                   sel.canSelect(spec_types), false);
      CPPUNIT_ASSERT_EQUAL_MESSAGE("canSelect 3",
                                   sel.canSelect(spec_field), false);

      FieldSelection sel_null("I",StorageType::Int32,FieldSelection::IS_NULL);

      CPPUNIT_ASSERT_EQUAL_MESSAGE("canSelect 4",
                                   sel_null.canSelect(spec), true);
      CPPUNIT_ASSERT_EQUAL_MESSAGE("canSelect 5",
                                   sel_null.canSelect(spec_types), false);
      CPPUNIT_ASSERT_EQUAL_MESSAGE("canSelect 6",
                                   sel_null.canSelect(spec_field), false);

      CPPUNIT_ASSERT_THROW( FieldSelection( "S", StorageType::String4k, FieldSelection::GT, "hotzplotz" ), Exception );
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", StorageType::String4k, FieldSelection::LT, "hotzplotz" ), Exception );
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", StorageType::String4k, FieldSelection::GE, "hotzplotz" ), Exception );
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", StorageType::String4k, FieldSelection::LE, "hotzplotz" ), Exception );

      // check Blob64k initialization
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", StorageType::Blob64k, FieldSelection::GT, "hotzplotz" ), Exception );
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", StorageType::Blob64k, FieldSelection::LT, "hotzplotz" ), Exception );
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", StorageType::Blob64k, FieldSelection::GE, "hotzplotz" ), Exception );
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", StorageType::Blob64k, FieldSelection::LE, "hotzplotz" ), Exception );

      // check Blob16M initialization
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", StorageType::Blob16M, FieldSelection::GT, "hotzplotz" ), Exception );
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", StorageType::Blob16M, FieldSelection::LT, "hotzplotz" ), Exception );
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", StorageType::Blob16M, FieldSelection::GE, "hotzplotz" ), Exception );
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", StorageType::Blob16M, FieldSelection::LE, "hotzplotz" ), Exception );

      // some wrong types
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", StorageType::String4k, FieldSelection::EQ, (Int32)5 ), Exception );
      CPPUNIT_ASSERT_THROW( FieldSelection( "U", StorageType::Float, FieldSelection::EQ, (Int32)5 ), Exception );
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", StorageType::UInt32, FieldSelection::EQ, (Int32)-5 ), Exception );

      RecordSpecification nspec;
      nspec.extend("I",StorageType::Int32);
      Record nrec(nspec);
      nrec["I"].setValue<Int32>( (Int32) 5 );

      FieldSelection nsel("I",StorageType::Int32,FieldSelection::EQ,(Int32) 5);

      // test selection. More detailed tests are in test_RelationalFolder
      CPPUNIT_ASSERT_EQUAL_MESSAGE("select 1",nsel.select(nrec),true);
      nrec["I"].setValue<Int32>((Int32)5+10);
      CPPUNIT_ASSERT_EQUAL_MESSAGE("select 1",nsel.select(nrec),false);

    }

    catch ( std::exception& e )
    {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  RecordSelectionTest()
    : debug( false )
  {
    if ( getenv( "COOLTEST_DEBUG" ) ) debug = true;
  }

  ~RecordSelectionTest() {}

  void setUp() {
    if ( debug ) std::cout << std::endl;
  }

  void tearDown() {}

};

CPPUNIT_TEST_SUITE_REGISTRATION( cool::RecordSelectionTest );

//-----------------------------------------------------------------------------

// Include CppUnit test driver (tests/Common)
#include "../Common/CppUnit_testdriver.icpp"
