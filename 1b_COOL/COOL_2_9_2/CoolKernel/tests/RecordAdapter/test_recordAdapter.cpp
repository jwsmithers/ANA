// $Id: test_recordAdapter.cpp,v 1.26 2010-09-17 08:33:35 avalassi Exp $

// Include files
#include <iostream>
#include <limits>
#include <stdexcept>
#include "CoolKernel/ConstRecordAdapter.h"
#include "CoolKernel/InternalErrorException.h"
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordException.h"
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"

// Local include files
#include "../Common/CppUnit_headers.h"
#include "../Common/attributeListToString.h"
#include "../../src/FieldAdapter.h"
#include "../../src/isNaN.h"

// Namespace
namespace cool {
  class RecordAdapterTest;
}

//-----------------------------------------------------------------------------

class cool::RecordAdapterTest : public CppUnit::TestFixture {

  CPPUNIT_TEST_SUITE( RecordAdapterTest );

  CPPUNIT_TEST( test_AttributeList );
  CPPUNIT_TEST( test_constness );
  CPPUNIT_TEST( test_bug36646 );
  CPPUNIT_TEST( test_bug62634 );
  CPPUNIT_TEST( test_bug72147_float );
  CPPUNIT_TEST( test_bug72147_double );

  CPPUNIT_TEST_SUITE_END();

public:

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_bug72147_float()
  {
    test_bug72147<float>();
  }

  void test_bug72147_double()
  {
    test_bug72147<double>();
  }

  template<typename flt> void test_bug72147()
  {
    std::string name = "";
    const StorageType* ptype = 0; // non-const ptr to const StorageType
    if ( typeid(flt) == typeid(double) )
    {
      name = "A_Double";
      ptype = &( StorageType::storageType( StorageType::Double ) );
    }
    else if ( typeid(flt) == typeid(float) )
    {
      name = "A_Float";
      ptype = &( StorageType::storageType( StorageType::Float ) );
    }
    else
    {
      throw InternalErrorException( "PANIC! Type is neither float nor double",
                                    "test_bug72147" );
    }

    // Create and test a NaN constant
    flt nan = std::numeric_limits<flt>::quiet_NaN();
    CPPUNIT_ASSERT_MESSAGE( "isNaN( NaN )", isNaN( nan ) );
    CPPUNIT_ASSERT_MESSAGE( "NaN != NaN", nan != nan ); // WEIRD! NaN!=NaN

    // Execute the test for the specific type (float or double)
    try
    {

      const StorageType& type = *ptype;
      RecordSpecification spec;
      spec.extend( name, type );
      flt zero( 0 );

      // For COOL float fields, setValue(nan) should throw an exception.
      // Presently it does not (i.e. the following test presently succeeds).
      {
        Record rec1( spec );
        if ( typeid(flt) == typeid(double) )
          CPPUNIT_ASSERT_THROW
            ( rec1[0].setValue( nan ), StorageTypeDoubleIsNaN );
        else
          CPPUNIT_ASSERT_THROW
            ( rec1[0].setValue( nan ), StorageTypeFloatIsNaN );
      }

      // For CORAL string attrs, setValue(NaN) and setNull() are NOT the same!
      // A CORAL NaN is read back as a NULL from COOL.
      //
      // AL1b[0].setValue(NaN)
      // ==> AL1b[0]:  not null, value==NaN
      // ==> REC1b[0]:     null, value N/A
      //
      // AL2b[0].setNull() following setValue(0)
      // ==> AL2b[0]:      null, value N/A
      // ==> REC2b[0]:     null, value N/A
      //
      // AL3b[0].setNull() following setValue(NaN)
      // ==> AL3b[0]:      null, value N/A
      // ==> REC3b[0]:     null, value N/A
      // In other words, AL2b and AL3b are indistinguishable
      {
        coral::AttributeList al1b;
        coral::AttributeList al2b;
        coral::AttributeList al3b;
        al1b.extend<flt>( name );
        al2b.extend<flt>( name );
        al3b.extend<flt>( name );
        al1b[0].setValue( nan );
        al2b[0].setValue( zero );
        al2b[0].setNull();
        al3b[0].setValue( nan );
        al3b[0].setNull();
        CPPUNIT_ASSERT_MESSAGE
          ( "AL1b[0] is not null", !al1b[0].isNull() );
        CPPUNIT_ASSERT_MESSAGE
          ( "AL1b[0] is nan", isNaN( al1b[0].data<flt>() ) );
        CPPUNIT_ASSERT_MESSAGE
          ( "AL1b != AL1b", al1b != al1b ); // WEIRD! NaN!=NaN
        CPPUNIT_ASSERT_MESSAGE
          ( "AL1b[0] != AL1b[0]", al1b[0] != al1b[0] ); // WEIRD! NaN!=NaN
        CPPUNIT_ASSERT_MESSAGE
          ( "AL2b[0] is null", al2b[0].isNull() );
        CPPUNIT_ASSERT_THROW
          ( al2b[0].data<flt>(), coral::AttributeException );
        CPPUNIT_ASSERT_MESSAGE
          ( "AL3b[0] is null", al3b[0].isNull() );
        CPPUNIT_ASSERT_THROW
          ( al3b[0].data<flt>(), coral::AttributeException );
        CPPUNIT_ASSERT_MESSAGE
          ( "AL2b == AL3b", al2b == al3b );
        CPPUNIT_ASSERT_MESSAGE
          ( "AL3b == AL2b", al3b == al2b );

        ConstRecordAdapter rec1b( spec, al1b );
        ConstRecordAdapter rec2b( spec, al2b );
        ConstRecordAdapter rec3b( spec, al3b );
        CPPUNIT_ASSERT_MESSAGE
          ( "Rec1b[0] is null", rec1b[0].isNull() );
        CPPUNIT_ASSERT_THROW
          ( rec1b[0].data<flt>(), FieldIsNull );
        CPPUNIT_ASSERT_MESSAGE
          ( "Rec1b == Rec1b", rec1b == rec1b );
        CPPUNIT_ASSERT_MESSAGE
          ( "Rec1b[0] == Rec1b[0]", rec1b[0] == rec1b[0] );
        CPPUNIT_ASSERT_MESSAGE
          ( "Rec2b[0] is null", rec2b[0].isNull() );
        CPPUNIT_ASSERT_THROW
          ( rec2b[0].data<flt>(), FieldIsNull );
        CPPUNIT_ASSERT_MESSAGE
          ( "Rec3b[0] is null", rec3b[0].isNull() );
        CPPUNIT_ASSERT_THROW
          ( rec3b[0].data<flt>(), FieldIsNull );
        CPPUNIT_ASSERT_MESSAGE
          ( "Rec2b[0] == Rec3b[0]", rec2b[0] == rec3b[0] );
        CPPUNIT_ASSERT_MESSAGE
          ( "Rec3b[0] == Rec2b[0]", rec3b[0] == rec2b[0] );
        CPPUNIT_ASSERT_MESSAGE
          ( "Rec2b == Rec3b", rec2b == rec3b );
        CPPUNIT_ASSERT_MESSAGE
          ( "Rec3b == Rec2b", rec3b == rec2b );

        const coral::AttributeList& al1bb = rec1b.attributeList();
        const coral::AttributeList& al2bb = rec2b.attributeList();
        const coral::AttributeList& al3bb = rec3b.attributeList();
        CPPUNIT_ASSERT_MESSAGE
          ( "AL1bb[0] is not null", !al1bb[0].isNull() );
        CPPUNIT_ASSERT_MESSAGE
          ( "AL1bb[0] is nan", isNaN( al1bb[0].data<flt>() ) );
        CPPUNIT_ASSERT_MESSAGE
          ( "AL1bb != AL1bb", al1bb != al1bb ); // WEIRD! NaN!=NaN
        CPPUNIT_ASSERT_MESSAGE
          ( "AL1bb[0] != AL1bb[0]", al1bb[0] != al1bb[0] ); // WEIRD! NaN!=NaN
        CPPUNIT_ASSERT_MESSAGE
          ( "AL2bb[0] is null", al2b[0].isNull() );
        CPPUNIT_ASSERT_THROW
          ( al2bb[0].data<flt>(), coral::AttributeException );
        CPPUNIT_ASSERT_MESSAGE
          ( "AL3bb[0] is null", al3b[0].isNull() );
        CPPUNIT_ASSERT_THROW
          ( al3bb[0].data<flt>(), coral::AttributeException );
        CPPUNIT_ASSERT_MESSAGE
          ( "AL2bb == AL3bb", al2bb == al3bb );
        CPPUNIT_ASSERT_MESSAGE
          ( "AL3bb == AL2bb", al3bb == al2bb );

        FieldAdapter fld1b( spec[0], al1b[0] );
        FieldAdapter fld2b( spec[0], al2b[0] );
        FieldAdapter fld3b( spec[0], al3b[0] );
        CPPUNIT_ASSERT_MESSAGE
          ( "Fld1b is null", fld1b.isNull() );
        CPPUNIT_ASSERT_THROW
          ( fld1b.data<flt>(), FieldIsNull );
        CPPUNIT_ASSERT_MESSAGE
          ( "Fld2b is null", fld2b.isNull() );
        CPPUNIT_ASSERT_THROW
          ( fld2b.data<flt>(), FieldIsNull );
        CPPUNIT_ASSERT_MESSAGE
          ( "Fld3b is null", fld3b.isNull() );
        CPPUNIT_ASSERT_THROW
          ( fld3b.data<flt>(), FieldIsNull );
        CPPUNIT_ASSERT_MESSAGE
          ( "Fld3b == Fld2b", fld3b == fld2b );
        CPPUNIT_ASSERT_MESSAGE
          ( "Fld2b == Fld3b", fld2b == fld3b );
      }
    }

    catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }

  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_bug62634()
  {

    try
    {

      const std::string name = "A_String255";
      const StorageType& type =
        StorageType::storageType( StorageType::String255 );
      RecordSpecification spec;
      spec.extend( name, type );
      std::string empty( "" );
      std::string dummy( "DUMMY" );

      // For COOL string fields, setValue("") and setNull() are the same!
      //
      // REC1[0].setValue("")
      // ==> REC1[0]: not null, value==""
      // ==> AL1[0]:      null, value=="" (NEW fix bug #65100 - was not null)
      //
      // REC2[0].setNull()
      // ==> REC2[0]: not null, value==""
      // ==> AL2[0]:      null, value=="" (NEW fix bug #65100 - was not null)
      {

        Record rec1( spec );
        Record rec2( spec );
        rec1[0].setValue( empty );
        rec2[0].setNull();
        CPPUNIT_ASSERT_MESSAGE
          ( "Rec1[0] is not null", !rec1[0].isNull() );
        CPPUNIT_ASSERT_MESSAGE
          ( "Rec2[0] is not null", !rec2[0].isNull() ); // weird feature...
        CPPUNIT_ASSERT_MESSAGE
          ( "Rec1[0] == ''", rec1[0].data<std::string>() == empty );
        CPPUNIT_ASSERT_MESSAGE
          ( "Rec2[0] == ''", rec2[0].data<std::string>() == empty );
        CPPUNIT_ASSERT_MESSAGE
          ( "Rec1[0] == Rec2[0]", rec1[0] == rec2[0] );
        CPPUNIT_ASSERT_MESSAGE
          ( "Rec2[0] == Rec1[0]", rec2[0] == rec1[0] );
        CPPUNIT_ASSERT_MESSAGE
          ( "Rec1 == Rec2", rec1 == rec2 );
        CPPUNIT_ASSERT_MESSAGE
          ( "Rec2 == Rec1", rec2 == rec1 );

        const coral::AttributeList& al1 = rec1.attributeList();
        const coral::AttributeList& al2 = rec2.attributeList();
        //CPPUNIT_ASSERT_MESSAGE
        //  ( "AL1[0] is not null", !al1[0].isNull() ); // OLD feature
        //CPPUNIT_ASSERT_MESSAGE
        //  ( "AL2[0] is not null", !al2[0].isNull() ); // weird OLD feature
        CPPUNIT_ASSERT_MESSAGE
          ( "AL1[0] is null", al1[0].isNull() ); // NEW (fix bug #65100)
        CPPUNIT_ASSERT_MESSAGE
          ( "AL2[0] is null", al2[0].isNull() ); // NEW (fix bug #65100)
        CPPUNIT_ASSERT_MESSAGE
          ( "AL1[0] == ''", al1[0].data<std::string>() == empty );
        CPPUNIT_ASSERT_MESSAGE
          ( "AL2[0] == ''", al2[0].data<std::string>() == empty );
        CPPUNIT_ASSERT_MESSAGE
          ( "AL1[0] == AL2[0]", al1[0] == al2[0] );
        CPPUNIT_ASSERT_MESSAGE
          ( "AL2[0] == AL1[0]", al2[0] == al1[0] );
        CPPUNIT_ASSERT_MESSAGE
          ( "AL1 == AL2", al1 == al2 );
        CPPUNIT_ASSERT_MESSAGE
          ( "AL2 == AL1", al2 == al1 );

      }

      // For CORAL string attrs, setValue("") and setNull() are NOT the same!
      //
      // AL1b[0].setValue("")
      // ==> AL1b[0]:  not null, value==""
      // ==> REC1b[0]: not null, value==""
      //
      // AL2b[0].setNull() following setValue("")
      // ==> AL2b[0]:      null, value==""
      // ==> REC2b[0]: not null, value==""
      //
      // AL3b[0].setNull() following setValue("DUMMY")
      // ==> AL3b[0]:      null, value=="" (reset to "" in fix for bug #34512)
      // ==> REC3b[0]: not null, value==""
      // In other words, AL2b and AL3b are indistinguishable
      //
      // [WARNING: coral::Attribute::setNull(false) is NOT recommended!!!]
      // [WARNING: it is not used in COOL hence it is not tested here....]
      {

        coral::AttributeList al1b;
        coral::AttributeList al2b;
        coral::AttributeList al3b;
        al1b.extend<std::string>( name );
        al2b.extend<std::string>( name );
        al3b.extend<std::string>( name );
        al1b[0].setValue( empty );
        al2b[0].setValue( empty );
        al2b[0].setNull();
        al3b[0].setValue( dummy );
        al3b[0].setNull();
        CPPUNIT_ASSERT_MESSAGE
          ( "AL1b[0] is not null", !al1b[0].isNull() );
        //CPPUNIT_ASSERT_MESSAGE
        //  ( "AL2b[0] is not null", !al2b[0].isNull() ); // FAILS
        //CPPUNIT_ASSERT_MESSAGE
        //  ( "AL3b[0] is not null", !al3b[0].isNull() ); // FAILS
        CPPUNIT_ASSERT_MESSAGE
          ( "AL1b[0] == ''", al1b[0].data<std::string>() == empty );
        CPPUNIT_ASSERT_MESSAGE
          ( "AL2b[0] == ''", al2b[0].data<std::string>() == empty );
        CPPUNIT_ASSERT_MESSAGE
          ( "AL3b[0] == ''", al3b[0].data<std::string>() == empty );
        //CPPUNIT_ASSERT_MESSAGE
        //  ( "AL1b[0] == AL2b[0]", al1b[0] == al2b[0] ); // FAILS
        //CPPUNIT_ASSERT_MESSAGE
        //  ( "AL2b[0] == AL1b[0]", al2b[0] == al1b[0] ); // FAILS
        //CPPUNIT_ASSERT_MESSAGE
        //  ( "AL1b == AL2b", al1b == al2b ); // FAILS
        //CPPUNIT_ASSERT_MESSAGE
        //  ( "AL2b == AL1b", al2b == al1b ); // FAILS
        //CPPUNIT_ASSERT_MESSAGE
        //  ( "AL1b[0] == AL3b[0]", al1b[0] == al3b[0] ); // FAILS
        //CPPUNIT_ASSERT_MESSAGE
        //  ( "AL3b[0] == AL1b[0]", al3b[0] == al1b[0] ); // FAILS
        //CPPUNIT_ASSERT_MESSAGE
        //  ( "AL1b == AL3b", al1b == al3b ); // FAILS
        //CPPUNIT_ASSERT_MESSAGE
        //  ( "AL3b == AL1b", al3b == al1b ); // FAILS
        CPPUNIT_ASSERT_MESSAGE
          ( "AL2b[0] == AL3b[0]", al2b[0] == al3b[0] );
        CPPUNIT_ASSERT_MESSAGE
          ( "AL3b[0] == AL2b[0]", al3b[0] == al2b[0] );
        CPPUNIT_ASSERT_MESSAGE
          ( "AL2b == AL3b", al2b == al3b );
        CPPUNIT_ASSERT_MESSAGE
          ( "AL3b == AL2b", al3b == al2b );

        CPPUNIT_ASSERT_MESSAGE
          ( "AL2b[0] is null", al2b[0].isNull() ); // !!!
        CPPUNIT_ASSERT_MESSAGE
          ( "AL3b[0] is null", al3b[0].isNull() ); // !!!
        CPPUNIT_ASSERT_MESSAGE
          ( "AL1b[0] != AL2b[0]", al1b[0] != al2b[0] ); // !!!
        CPPUNIT_ASSERT_MESSAGE
          ( "AL2b[0] != AL1b[0]", al2b[0] != al1b[0] ); // !!!
        CPPUNIT_ASSERT_MESSAGE
          ( "AL1b != AL2b", al1b != al2b ); // !!!
        CPPUNIT_ASSERT_MESSAGE
          ( "AL2b != AL1b", al2b != al1b ); // !!!
        CPPUNIT_ASSERT_MESSAGE
          ( "AL1b[0] != AL3b[0]", al1b[0] != al3b[0] ); // !!!
        CPPUNIT_ASSERT_MESSAGE
          ( "AL3b[0] != AL1b[0]", al3b[0] != al1b[0] ); // !!!
        CPPUNIT_ASSERT_MESSAGE
          ( "AL1b != AL3b", al1b != al3b ); // !!!
        CPPUNIT_ASSERT_MESSAGE
          ( "AL3b != AL1b", al3b != al1b ); // !!!

        ConstRecordAdapter rec1b( spec, al1b );
        ConstRecordAdapter rec2b( spec, al2b );
        CPPUNIT_ASSERT_MESSAGE
          ( "Rec1b[0] is not null", !rec1b[0].isNull() );
        CPPUNIT_ASSERT_MESSAGE
          ( "Rec2b[0] is not null", !rec2b[0].isNull() ); // weird feature
        CPPUNIT_ASSERT_MESSAGE
          ( "Rec1b[0] == ''", rec1b[0].data<std::string>() == empty );
        CPPUNIT_ASSERT_MESSAGE
          ( "Rec2b[0] == ''", rec2b[0].data<std::string>() == empty );
        CPPUNIT_ASSERT_MESSAGE
          ( "Rec1b[0] == Rec2b[0]", rec1b[0] == rec2b[0] );
        CPPUNIT_ASSERT_MESSAGE // Here WAS bug #62634 in ConstFieldAdapter
          ( "Rec2b[0] == Rec1b[0]", rec2b[0] == rec1b[0] );
        CPPUNIT_ASSERT_MESSAGE
          ( "Rec1b == Rec2b", rec1b == rec2b );
        CPPUNIT_ASSERT_MESSAGE // Here WAS bug #62634 in ConstFieldAdapter
          ( "Rec2b == Rec1b", rec2b == rec1b );

        const coral::AttributeList& al1bb = rec1b.attributeList();
        const coral::AttributeList& al2bb = rec2b.attributeList();
        CPPUNIT_ASSERT_MESSAGE
          ( "AL1bb[0] is not null", !al1bb[0].isNull() );
        //CPPUNIT_ASSERT_MESSAGE
        //  ( "AL2bb[0] is not null", !al2bb[0].isNull() ); // FAILS
        CPPUNIT_ASSERT_MESSAGE
          ( "AL1bb[0] == ''", al1bb[0].data<std::string>() == empty );
        CPPUNIT_ASSERT_MESSAGE
          ( "AL2bb[0] == ''", al2bb[0].data<std::string>() == empty );
        //CPPUNIT_ASSERT_MESSAGE
        //  ( "AL1bb[0] == AL2bb[0]", al1bb[0] == al2bb[0] ); // FAILS
        //CPPUNIT_ASSERT_MESSAGE
        //  ( "AL2bb[0] == AL1bb[0]", al2bb[0] == al1bb[0] ); // FAILS
        //CPPUNIT_ASSERT_MESSAGE
        //  ( "AL1bb == AL2bb", al1bb == al2bb ); // FAILS
        //CPPUNIT_ASSERT_MESSAGE
        //  ( "AL2bb == AL1bb", al2bb == al1bb ); // FAILS

        CPPUNIT_ASSERT_MESSAGE
          ( "AL2bb[0] is null", al2bb[0].isNull() ); // !!!
        CPPUNIT_ASSERT_MESSAGE
          ( "AL1bb[0] != AL2bb[0]", al1bb[0] != al2bb[0] ); // !!!
        CPPUNIT_ASSERT_MESSAGE
          ( "AL2bb[0] != AL1bb[0]", al2bb[0] != al1bb[0] ); // !!!
        CPPUNIT_ASSERT_MESSAGE
          ( "AL1bb != AL2bb", al1bb != al2bb ); // !!!
        CPPUNIT_ASSERT_MESSAGE
          ( "AL2bb != AL1bb", al2bb != al1bb ); // !!!

        FieldAdapter fld1b( spec[0], al1b[0] );
        FieldAdapter fld2b( spec[0], al2b[0] );
        CPPUNIT_ASSERT_MESSAGE
          ( "Fld1b is not null", !fld1b.isNull() );
        CPPUNIT_ASSERT_MESSAGE
          ( "Fld2b is not null", !fld2b.isNull() ); // weird feature
        CPPUNIT_ASSERT_MESSAGE
          ( "Fld1b == ''", fld1b.data<std::string>() == empty );
        CPPUNIT_ASSERT_MESSAGE
          ( "Fld2b == ''", fld2b.data<std::string>() == empty );
        CPPUNIT_ASSERT_MESSAGE
          ( "Fld1b == Fld2b", fld1b == fld2b );
        CPPUNIT_ASSERT_MESSAGE // Here WAS bug #62634 in FieldAdapter
          ( "Fld2b == Fld1b", fld2b == fld1b );

      }
    }

    catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }

  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_bug36646()
  {

    try
    {

      const std::string namePri = "privateString";
      const std::string namePub = "publicString";

      coral::AttributeList al;
      al.extend( namePri, "string" );
      al.extend( namePub, "string" );

      RecordSpecification spec;
      spec.extend( namePub, StorageType::String255 );

      ConstRecordAdapter rec( spec, al );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Record size", (UInt32)1, rec.specification().size() );
      const coral::AttributeList alRec = rec.attributeList();
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "AttrList size", (UInt32)1, (UInt32)alRec.size() );

    }

    catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }

  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_constness()
  {

    try {

      const std::string name = "A_String255";
      const StorageType& type =
        StorageType::storageType( StorageType::String255 );
      RecordSpecification spec;
      spec.extend( name, type );

      coral::AttributeList al = Record(spec).attributeList();

      std::string str255A( 255, 'A' );
      al[name].setValue( str255A );

      const coral::AttributeList& alConst = al;
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Value", str255A, alConst[name].data<String255>() );

      {
        /*
        // If you want to build a non-const RecordAdapter,
        // you need to have a non-const AttributeList
        RecordAdapter rec( spec, al );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Size", (UInt32)1, rec.specification().size() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Name", name, rec[name].name() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Type", type.name(), rec[name].storageType().name() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Value", str255A, rec[name].data<String255>() );

        // Changing the RecordAdapter will also change the AttributeList
        std::string str255B( 255, 'B' );
        rec[name].setValue( str255B );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Value", str255B, rec[name].data<String255>() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Value", str255B, alConst[name].data<String255>() );
        rec[name].setValue( str255A ); // reset for the following tests!
        *///
      }

      {
        // If you have a const AttributeList,
        // you cannot build a non-const RecordAdapter

        // The following will NOT COMPILE (good!)
        //RecordAdapter rec( spec, alConst );
      }

      {
        // If you have a const AttributeList,
        // you also cannot build a const RecordAdapter (how would you?!)
        // Need two separate adapters for const and non-const
        // (or could hold a constness flag inside but even more ugly)

        // The following will NOT COMPILE (unfortunately...)
        //const RecordAdapter rec( spec, alConst );
      }

      {
        // If you have a const AttributeList,
        // you can only build a ConstRecordAdapter
        ConstRecordAdapter rec( spec, alConst );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Size", (UInt32)1, rec.specification().size() );

        // The following will NOT COMPILE (~ok...) - non-const rec[] is private
        //CPPUNIT_ASSERT_EQUAL_MESSAGE
        //  ( "Name", name, rec[name].name() );
        //CPPUNIT_ASSERT_EQUAL_MESSAGE
        //  ( "Type", type.name(), rec[name].storageType().name() );
        //CPPUNIT_ASSERT_EQUAL_MESSAGE
        //  ( "Value", str255A, rec[name].data<String255>() );
        const ConstRecordAdapter& crec = rec;
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Name", name, crec[name].name() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Type", type.name(), crec[name].storageType().name() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( "Value", str255A, crec[name].data<String255>() );

        // Try to setValue from str255A to str255B
        std::string str255B( 255, 'B' );

        // The following will NOT COMPILE (good!) - non-const rec[] is private
        //rec[name].setValue( str255B );

        // The following will NOT COMPILE (good!) - setValue is non const
        //crec[name].setValue( str255B );

        // The following will NOT COMPILE (very good!)
        // This is only since I made IRecord read-only:
        // previously this was failing at runtime...!
        /*
        try {
          IRecord& irec = rec;
          irec[name].setValue( str255B );
          throw std::runtime_error("cool::Exception expected");
        }
        catch ( Exception& ){
        }
        *///
      }

    }

    catch ( std::exception& e ) {
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }

  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  // Tests the very basic behaviour of a coral::AtributeList
  // This fails when building COOL on vc9 against the CORAL_2_0_0 built on vc71
  void test_AttributeList()
  {
    coral::AttributeList al;
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "New AttrList size", (int)0, (int)al.size() );
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  RecordAdapterTest()
  {
  }

  ~RecordAdapterTest() {}

  void setUp() {
  }

  void tearDown() {}

};

CPPUNIT_TEST_SUITE_REGISTRATION( cool::RecordAdapterTest );

//-----------------------------------------------------------------------------

// Include CppUnit test driver (tests/Common)
#include "../Common/CppUnit_testdriver.icpp"
