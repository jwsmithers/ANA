
// Include files
#include <cstdlib>
#include <iostream>
#include "CoolKernel/FieldSelection.h"
#include "CoolKernel/IFolder.h"

// Local include files (CoolKernel/src)
#include "CoolKernel/../src/scoped_enums.h"

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
      spec.extend("I", cool_StorageType_TypeId::Int32);
      spec.extend("S", cool_StorageType_TypeId::String4k);
      spec.extend("X", cool_StorageType_TypeId::Float);
      Record rec(spec);

      RecordSpecification spec_types;
      spec_types.extend("I", cool_StorageType_TypeId::Double);
      spec_types.extend("S", cool_StorageType_TypeId::UInt32);
      spec_types.extend("X", cool_StorageType_TypeId::String255);
      Record rec_types(spec_types);

      RecordSpecification spec_field;
      spec.extend("I1", cool_StorageType_TypeId::Int32);
      spec.extend("S1", cool_StorageType_TypeId::String4k);
      spec.extend("X1", cool_StorageType_TypeId::Float);
      Record rec_field(spec_field);

      FieldSelection sel("I",cool_StorageType_TypeId::Int32, cool_FieldSelection_Relation::EQ, (Int32)5);

      CPPUNIT_ASSERT_EQUAL_MESSAGE("canSelect 1",
                                   sel.canSelect(spec), true);
      CPPUNIT_ASSERT_EQUAL_MESSAGE("canSelect 2",
                                   sel.canSelect(spec_types), false);
      CPPUNIT_ASSERT_EQUAL_MESSAGE("canSelect 3",
                                   sel.canSelect(spec_field), false);

      FieldSelection sel_null("I",cool_StorageType_TypeId::Int32,cool_FieldSelection_Nullness::IS_NULL);

      CPPUNIT_ASSERT_EQUAL_MESSAGE("canSelect 4",
                                   sel_null.canSelect(spec), true);
      CPPUNIT_ASSERT_EQUAL_MESSAGE("canSelect 5",
                                   sel_null.canSelect(spec_types), false);
      CPPUNIT_ASSERT_EQUAL_MESSAGE("canSelect 6",
                                   sel_null.canSelect(spec_field), false);

      CPPUNIT_ASSERT_THROW( FieldSelection( "S", cool_StorageType_TypeId::String4k, cool_FieldSelection_Relation::GT, "hotzplotz" ), Exception );
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", cool_StorageType_TypeId::String4k, cool_FieldSelection_Relation::LT, "hotzplotz" ), Exception );
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", cool_StorageType_TypeId::String4k, cool_FieldSelection_Relation::GE, "hotzplotz" ), Exception );
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", cool_StorageType_TypeId::String4k, cool_FieldSelection_Relation::LE, "hotzplotz" ), Exception );

      // check Blob64k initialization
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", cool_StorageType_TypeId::Blob64k, cool_FieldSelection_Relation::GT, "hotzplotz" ), Exception );
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", cool_StorageType_TypeId::Blob64k, cool_FieldSelection_Relation::LT, "hotzplotz" ), Exception );
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", cool_StorageType_TypeId::Blob64k, cool_FieldSelection_Relation::GE, "hotzplotz" ), Exception );
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", cool_StorageType_TypeId::Blob64k, cool_FieldSelection_Relation::LE, "hotzplotz" ), Exception );

      // check Blob16M initialization
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", cool_StorageType_TypeId::Blob16M, cool_FieldSelection_Relation::GT, "hotzplotz" ), Exception );
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", cool_StorageType_TypeId::Blob16M, cool_FieldSelection_Relation::LT, "hotzplotz" ), Exception );
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", cool_StorageType_TypeId::Blob16M, cool_FieldSelection_Relation::GE, "hotzplotz" ), Exception );
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", cool_StorageType_TypeId::Blob16M, cool_FieldSelection_Relation::LE, "hotzplotz" ), Exception );

      // some wrong types
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", cool_StorageType_TypeId::String4k, cool_FieldSelection_Relation::EQ, (Int32)5 ), Exception );
      CPPUNIT_ASSERT_THROW( FieldSelection( "U", cool_StorageType_TypeId::Float, cool_FieldSelection_Relation::EQ, (Int32)5 ), Exception );
      CPPUNIT_ASSERT_THROW( FieldSelection( "S", cool_StorageType_TypeId::UInt32, cool_FieldSelection_Relation::EQ, (Int32)-5 ), Exception );

      RecordSpecification nspec;
      nspec.extend("I",cool_StorageType_TypeId::Int32);
      Record nrec(nspec);
      nrec["I"].setValue<Int32>( (Int32) 5 );

      FieldSelection nsel("I",cool_StorageType_TypeId::Int32,cool_FieldSelection_Relation::EQ,(Int32) 5);

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
