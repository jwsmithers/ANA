// $Id: test_RalDatabase_extendedSpec.cpp,v 1.123 2013-03-08 11:44:44 avalassi Exp $

// First of all, enable or disable the COOL290 API extensions (bug #92204)
#include "CoolKernel/VersionInfo.h"

// Include files
#include "CoolKernel/IDatabaseSvc.h"
#include "CoolKernel/IField.h"
#include "CoolKernel/InternalErrorException.h"
#include "CoolKernel/IObject.h"
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordException.h"
#include "CoolKernel/RecordSpecification.h"
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeListException.h"
#include "RelationalAccess/IConnectionService.h"
#include "RelationalAccess/IConnectionServiceConfiguration.h"

// Local include files
//#define COOLUNITTESTTIMER 1
//#define COOLDBUNITTESTDEBUG 1
#include "tests/Common/CoolDBUnitTest.h"
#include "src/CoralApplication.h"
#include "src/RelationalException.h"
#include "src/RelationalFolder.h"
#include "src/RelationalDatabase.h"
#include "src/RelationalNodeTable.h"
#include "src/RalDatabase.h"
#include "src/RalDatabaseSvc.h"
#include "src/SimpleObject.h"
#include "src/TransRalDatabase.h"

// Forward declaration (for easier indentation)
namespace cool
{
  class RalDatabaseTest_extendedSpec;
}

// The test class
class cool::RalDatabaseTest_extendedSpec : public cool::CoolDBUnitTest
{

private:

  CPPUNIT_TEST_SUITE( RalDatabaseTest_extendedSpec );
  CPPUNIT_TEST( test_payloadSpecDescription );
  CPPUNIT_TEST( test_payloadSpecTooManyFields );
  CPPUNIT_TEST( test_payloadSpecTooManyBlobFields );
  CPPUNIT_TEST( test_payloadSpecTooManyString255Fields );
  CPPUNIT_TEST( test_payloadSpecInvalidFieldName );
  CPPUNIT_TEST( test_payloadSpecOver8000Bytes ); // fails on MySQL (bug #24646)
  CPPUNIT_TEST( test_default_string4000 );
  CPPUNIT_TEST( test_extSpec_string255 );
  CPPUNIT_TEST( test_default_UInt63 );
  //CPPUNIT_TEST_EXCEPTION( test_unsupportedTypesToken,
  //                        coral::AttributeListException );
  //CPPUNIT_TEST_EXCEPTION( test_unsupportedTypesChar,
  //                        RelationalTypeConverterInvalidCppType );
  //CPPUNIT_TEST_EXCEPTION( test_unsupportedTypesLongDouble,
  //                        RelationalTypeConverterInvalidCppType );
  //CPPUNIT_TEST_EXCEPTION( test_unsupportedTypesLongLong,
  //                        RelationalTypeConverterInvalidCppType );
  //CPPUNIT_TEST_EXCEPTION( test_unsupportedTypesVector,
  //                        coral::AttributeListException );
  CPPUNIT_TEST( test_supportedTypes );
  CPPUNIT_TEST( test_extSpec_allStrings );
  CPPUNIT_TEST( test_storagObject_special_characters );
  CPPUNIT_TEST( test_emptyString );
  CPPUNIT_TEST( test_nullCharInString );
  CPPUNIT_TEST( test_blob64kOver64k );
  CPPUNIT_TEST( test_blob16MOver64k );
  CPPUNIT_TEST( test_emptyBlob );
  CPPUNIT_TEST_SUITE_END();

public:

  /// Tests storage and retrieval of non-ascii and 'sql-tricky' characters
  void test_storagObject_special_characters()
  {
    RecordSpecification spec;
    spec.extend( "quotes", StorageType::String255 );
    spec.extend( "umlauts", StorageType::String255 );
    spec.extend( "diacriticals", StorageType::String255 );
    Record payload( spec );
    IFolderPtr folder = s_db->createFolder( "/myfolder", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) );
    std::string umlauts = "umlauts ";
    // octal representation of umlauts in iso-8895-1
    // "������������"
    umlauts += "\304\313\317\326\334\337\344\353\357\366\374\377";
    umlauts += " in string";
    std::string diacriticals = "diacriticals ";
    // octal representation of other accents in iso-8895-1
    // "���������������������
    //  ���������������������
    //  ��������"
    diacriticals += "\300\301\302\303\305\306\307\310\311\312\314\315\316\320";
    diacriticals += "\321\322\323\324\325\330\331\332\333\335\336\340\341\342";
    diacriticals += "\343\345\346\347\350\351\352\354\355\356\360\361\362\363";
    diacriticals += "\364\365\370\371\372\373\375\376";
    diacriticals += " in string";
    payload[ "quotes" ].setValue<String255>
      ( "quotes '\" in string" );
    payload[ "umlauts" ].setValue<String255>
      ( umlauts );
    payload[ "diacriticals" ].setValue<String255>
      ( diacriticals );
    folder->storeObject( 5, 15, payload, 0 );
    IObjectPtr obj = folder->findObject( 10, 0 );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "quotes string",
        std::string( "quotes '\" in string" ),
        obj->payload()["quotes"].data<String255>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "umlauts string",
        umlauts,
        obj->payload()["umlauts"].data<String255>() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "diacriticals string",
        diacriticals,
        obj->payload()["diacriticals"].data<String255>() );
  }


  /// Tests creation of a folder with as many columns as there are
  /// C++ types supported in COOL (using default payload hints)
  /// [Test all types in pool/AttributeList/src/AttributePredefinedTypes.cpp]
  void test_supportedTypes()
  {
    try
    {
      // Create a folder with 12 payload columns
      typedef std::pair<std::string,StorageType::TypeId> pair_type;
      std::vector<pair_type> all_types;
      all_types.push_back(pair_type("A_BOOL",
                                    StorageType::Bool));
      //all_types.push_back(pair_type("A_CHAR",
      //                              StorageType::Char)); // MySQL problems
      all_types.push_back(pair_type("A_UCHAR",
                                    StorageType::UChar));
      all_types.push_back(pair_type("A_INT16",
                                    StorageType::Int16));
      all_types.push_back(pair_type("A_UINT16",
                                    StorageType::UInt16));
      all_types.push_back(pair_type("A_INT32",
                                    StorageType::Int32));
      all_types.push_back(pair_type("A_UINT32",
                                    StorageType::UInt32));
      all_types.push_back(pair_type("A_UINT63",
                                    StorageType::UInt63));
      all_types.push_back(pair_type("A_INT64",
                                    StorageType::Int64));
      //all_types.push_back(pair_type("A_UINT64",
      //                              StorageType::UInt64)); // SQLite problems
      all_types.push_back(pair_type("A_FLOAT",
                                    StorageType::Float));
      all_types.push_back(pair_type("A_DOUBLE",
                                    StorageType::Double));
      all_types.push_back(pair_type("A_STRING255",
                                    StorageType::String255));
      all_types.push_back(pair_type("A_STRING4K",
                                    StorageType::String4k));
      all_types.push_back(pair_type("A_STRING64K",
                                    StorageType::String64k));
      all_types.push_back(pair_type("A_STRING16M",
                                    StorageType::String16M));
      all_types.push_back(pair_type("A_BLOB64K",
                                    StorageType::Blob64k));
      all_types.push_back(pair_type("A_BLOB16M",
                                    StorageType::Blob16M));
      RecordSpecification spec;
      for( std::vector<pair_type>::iterator i = all_types.begin();
           i != all_types.end(); ++i )
      {
        spec.extend(i->first,i->second);
      }
      IFolderPtr folder = s_db->createFolder( "/myfolder", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) );
      CPPUNIT_ASSERT( folder.get() != 0 );
      // Store some data into the IOV table
      Record payload1( spec );
      payload1[ "A_BOOL" ].setValue<Bool>( false );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "false=0", false, payload1["A_BOOL"].data<Bool>());
      //payload1[ "A_CHAR" ]
      //  .setValue<char>( 'a' );      // THIS MUST BE CHARACTER DATA
      //  .setValue<char>( CHAR_MIN ); // -128 (if signed)
      payload1[ "A_UCHAR" ].setValue<UChar>( 0 );
      payload1[ "A_INT16" ].setValue<Int16>( Int16Min ); // -32768
      payload1[ "A_UINT16" ].setValue<UInt16>( 0 );
      payload1[ "A_INT32" ].setValue<Int32>( Int32Min ); // -2147483648
      payload1[ "A_UINT32" ].setValue<UInt32>( 0 );
      payload1[ "A_UINT63" ].setValue<UInt63>( 0 );
      payload1[ "A_INT64" ].setValue<Int64>( Int64Min ); // -9223372036854775808: OCI-22053!
      //payload1[ "A_UINT64" ].setValue<UInt64>( 0 );
      payload1[ "A_FLOAT" ].setValue<Float>( (Float)0.123456789012345678901234567890 );
      payload1[ "A_DOUBLE" ].setValue<Double>( 0.123456789012345678901234567890 );
      payload1[ "A_STRING255" ].setValue<String255>( "low values" );
      payload1[ "A_STRING4K" ].setValue<String4k>( "low values" );
      payload1[ "A_STRING64K" ].setValue<String64k>( "low values" );
      payload1[ "A_STRING16M" ].setValue<String16M>( "low values" );
      {
        Blob64k b64k = payload1[ "A_BLOB64K" ].data<Blob64k>();
        b64k.resize(100);
        Blob16M b16M = payload1[ "A_BLOB16M" ].data<Blob16M>();
        b16M.resize(100);
        unsigned char* ptr64k = static_cast<unsigned char *>
          ( b64k.startingAddress() );
        for ( int i = 0 ; i < 100; ++i ) ptr64k[i] = 0;
        unsigned char* ptr16M = static_cast<unsigned char *>
          ( b16M.startingAddress() );
        for ( int i = 0 ; i < 100; ++i ) ptr16M[i] = 0;
        payload1[ "A_BLOB64K" ].setValue<Blob64k>( b64k );
        payload1[ "A_BLOB16M" ].setValue<Blob16M>( b16M );
      }
      folder->storeObject( 5, 15, payload1, 0 );
      // Store some data into the IOV table
      Record payload2( spec );
      payload2[ "A_BOOL" ].setValue<Bool>( true );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "false=0", true, payload2["A_BOOL"].data<Bool>());
      //payload2[ "A_CHAR" ]
      //  .setValue<char>( 'Z' );      // THIS MUST BE CHARACTER DATA
      //  .setValue<char>( CHAR_MAX ); // -128 (if signed)
      payload2[ "A_UCHAR" ].setValue<UChar>( UCHAR_MAX ); // 255
      payload2[ "A_INT16" ].setValue<Int16>( Int16Max ); // 32767
      payload2[ "A_UINT16" ].setValue<UInt16>( UInt16Max ); // 65535
      payload2[ "A_INT32" ].setValue<Int32>( Int32Max ); // 2147483647
      payload2[ "A_UINT32" ].setValue<UInt32>( UInt32Max ); // 4294967295
      payload2[ "A_UINT63" ].setValue<UInt63>( Int64Max ); // 9223372036854775807
      payload2[ "A_INT64" ].setValue<Int64>( Int64Max ); // 9223372036854775807
      //payload2[ "A_UINT64" ].setValue<UInt64>( UInt64Max ); // 18446744073709551615
      payload2[ "A_FLOAT" ].setValue<Float>( (Float)0.987654321098765432109876543210 );
      payload2[ "A_DOUBLE" ].setValue<Double>( 0.987654321098765432109876543210 );
      payload2[ "A_STRING255" ].setValue<String255>( "HIGH VALUES" );
      payload2[ "A_STRING4K" ].setValue<String4k>( "HIGH VALUES" );
      payload2[ "A_STRING64K" ].setValue<String64k>( "HIGH VALUES" );
      payload2[ "A_STRING16M" ].setValue<String16M>( "HIGH VALUES" );
      {
        Blob64k b64k = payload2[ "A_BLOB64K" ].data<Blob64k>();
        b64k.resize(100);
        Blob16M b16M = payload2[ "A_BLOB16M" ].data<Blob16M>();
        b16M.resize(100);
        unsigned char* ptr64k = static_cast<unsigned char *>
          ( b64k.startingAddress() );
        for ( int i = 0 ; i < 100; ++i ) ptr64k[i] = 0xff;
        unsigned char* ptr16M = static_cast<unsigned char *>
          ( b16M.startingAddress() );
        for ( int i = 0 ; i < 100; ++i ) ptr16M[i] = 0xff;
        payload2[ "A_BLOB64K" ].setValue<Blob64k>( b64k );
        payload2[ "A_BLOB16M" ].setValue<Blob16M>( b16M );
      }
      folder->storeObject( 15, 25, payload2, 0 );
      // Retrieve back the two objects
      IObjectPtr obj1 = folder->findObject( 10, 0 );
      CPPUNIT_ASSERT_MESSAGE( "retrieved object 1", obj1.get() != 0 );
      IObjectPtr obj2 = folder->findObject( 20, 0 );
      CPPUNIT_ASSERT_MESSAGE( "retrieved object 2", obj2.get() != 0 );
      // Printout for bool
      if ( false )
      {
        std::cout << "Payload1 IN  -> "
                  << payload1["A_BOOL"].data<Bool>() << std::endl;
        std::cout << "Payload1 OUT -> "
                  << obj1->payload()["A_BOOL"].data<Bool>() << std::endl;
        std::cout << "Payload2 IN  -> "
                  << payload2["A_BOOL"].data<Bool>() << std::endl;
        std::cout << "Payload2 OUT -> "
                  << obj2->payload()["A_BOOL"].data<Bool>() << std::endl;
      }
      // Printout for unsigned char
      if ( false )
      {
        UChar u1in = payload1["A_UCHAR"].data<UChar>();
        UChar u1out = obj1->payload()["A_UCHAR"].data<UChar>();
        UChar u2in = payload2["A_UCHAR"].data<UChar>();
        UChar u2out = obj2->payload()["A_UCHAR"].data<UChar>();
        std::cout << "Payload1 IN  -> " << u1in << std::endl;
        std::cout << "Payload1 OUT -> " << u1out << std::endl;
        std::cout << "Payload2 IN  -> " << u2in << std::endl;
        std::cout << "Payload2 OUT -> " << u2out << std::endl;
        std::cout << "Payload1 IN  (int) -> " << (int)u1in << std::endl;
        std::cout << "Payload1 OUT (int) -> " << (int)u1out << std::endl;
        std::cout << "Payload2 IN  (int) -> " << (int)u2in << std::endl;
        std::cout << "Payload2 OUT (int) -> " << (int)u2out << std::endl;
      }
      // Printout for floats and doubles
      if ( false )
      {
        Float f_in = payload1["A_FLOAT"].data<Float>();
        Double d_in = payload1["A_DOUBLE"].data<Double>();
        Float f_out = obj1->payload()["A_FLOAT"].data<Float>();
        Double d_out = obj1->payload()["A_DOUBLE"].data<Double>();
        int p = std::cout.precision();
        std::cout.precision(30);
        std::cout << "float1 IN   -> " << f_in << std::endl;
        std::cout << "float1 OUT  -> " << f_out << std::endl;
        std::cout << "double1 IN  -> " << d_in << std::endl;
        std::cout << "double1 OUT -> " << d_out << std::endl;
        std::cout.precision(p);
      }
      // Compare the input payload to the retrieved payload for object 1 and 2
      for ( unsigned int i=0; i<spec.size(); i++ )
      {
        const IFieldSpecification& fldSpec = spec[i];
        std::string val1_in,val2_in;
        std::string val1_out,val2_out;
        // Special treatment for floats: compare with 6 digit precision
        // TEMPORARY! You should be able to use higher precision!
        if ( fldSpec.storageType() == StorageType::Float )
        {
          unsigned long fPrec = 6;
          Float f_in = payload1[ fldSpec.name() ].data<Float>();
          Float f_out = obj1->payload()[ fldSpec.name() ].data<Float>();
          std::ostringstream s1_in, s1_out;
          s1_in.precision(fPrec);
          s1_out.precision(fPrec);
          s1_in << f_in;
          s1_out << f_out;
          val1_in = s1_in.str();
          val1_out = s1_out.str();
          f_in = payload2[ fldSpec.name() ].data<Float>();
          f_out = obj2->payload()[ fldSpec.name() ].data<Float>();
          std::ostringstream s2_in, s2_out;
          s2_in.precision(fPrec);
          s2_out.precision(fPrec);
          s2_in << f_in;
          s2_out << f_out;
          val2_in = s2_in.str();
          val2_out = s2_out.str();
        }
        // Special treatment for doubles: compare with 15 digit precision
        // TEMPORARY! You should be able to use higher precision!
        else if ( fldSpec.storageType() == StorageType::Double )
        {
          unsigned long dPrec = 15;
          Double d_in = payload1[ fldSpec.name() ].data<Double>();
          Double d_out = obj1->payload()[ fldSpec.name() ].data<Double>();
          std::ostringstream s1_in,s1_out;
          s1_in.precision(dPrec);
          s1_out.precision(dPrec);
          s1_in << d_in;
          s1_out << d_out;
          val1_in = s1_in.str();
          val1_out = s1_out.str();
          d_in = payload2[ fldSpec.name() ].data<Double>();
          d_out = obj2->payload()[ fldSpec.name() ].data<Double>();
          std::ostringstream s2_in,s2_out;
          s2_in.precision(dPrec);
          s2_out.precision(dPrec);
          s2_in << d_in;
          s2_out << d_out;
          val2_in = s2_in.str();
          val2_out = s2_out.str();
        }
        else if ( fldSpec.storageType() == StorageType::Blob64k )
        {
          // use native comparison for blobs
          val1_in = "true";
          val1_out = ( payload1[ fldSpec.name() ].data<Blob64k>() == obj1->payload()[ fldSpec.name() ].data<Blob64k>() ? "true" : "false" );
          val2_in = "true";
          val2_out = ( payload2[ fldSpec.name() ].data<Blob64k>() == obj2->payload()[ fldSpec.name() ].data<Blob64k>() ? "true" : "false" );
        }
        else if ( fldSpec.storageType() == StorageType::Blob16M )
        {
          // use native comparison for blobs
          val1_in = "true";
          val1_out = ( payload1[ fldSpec.name() ].data<Blob16M>() == obj1->payload()[ fldSpec.name() ].data<Blob16M>() ? "true" : "false" );
          val2_in = "true";
          val2_out = ( payload2[ fldSpec.name() ].data<Blob16M>() == obj2->payload()[ fldSpec.name() ].data<Blob16M>() ? "true" : "false" );
        }
        // Default treatment for all but floats and doubles: compare as strings
        else
        {
          val1_in = toString( payload1[ fldSpec.name() ].attribute() );
          val1_out = toString( obj1->payload()[ fldSpec.name() ].attribute() );
          val2_in = toString( payload2[ fldSpec.name() ].attribute() );
          val2_out = toString( obj2->payload()[ fldSpec.name() ].attribute() );
        }
        // Compare expected and actual values
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( std::string( "payload1 ['" )
            + fldSpec.name() + "'] of type '"
            + fldSpec.storageType().name() + "'",
            val1_in, val1_out );
        CPPUNIT_ASSERT_EQUAL_MESSAGE
          ( std::string( "payload2 ['" )
            + fldSpec.name() + "'] of type '"
            + fldSpec.storageType().name() + "'",
            val2_in, val2_out );
      }
    }
    catch ( std::exception& e )
    {
      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
      throw;
    }
    catch ( ... )
    {
      std::cout << "UNKNOWN exception caught!" << std::endl;
      throw;
    }
  }


  /// Tests creation of a folder with a vector column - should fail
  /// PORT: This test used to throw a RelationalTypeConverterInvalidCppType
  /// exception from 'createFolder'. However in CORAL, Token is not a
  /// supported type and spec->extend( "A_VECTOR", "vector<string>" ) already
  /// throws an exception.
  /// Marco: With the new RecordSpecification, it is impossible to us an unsupported type
  //  void test_unsupportedTypesVector() {
  //    boost::shared_ptr<coral::AttributeListSpecification>
  //    spec( new coral::AttributeListSpecification(), releaser() );
  //    spec->extend( "A_VECTOR", "vector<string>" );
  //    IFolderPtr folder = s_db->createFolder( "/myfolder", *spec );
  //  }


  /// Tests creation of a folder with a Token column - should fail
  /// PORT: This test used to throw a RelationalTypeConverterInvalidCppType
  /// exception from 'createFolder'. However in CORAL, Token is not a
  /// supported type and spec->extend( "A_TOKEN", "Token" ) already throws
  /// an exception.
  /// Marco: With the new RecordSpecification, it is impossible to us an unsupported type
  //  void test_unsupportedTypesToken() {
  //    boost::shared_ptr<coral::AttributeListSpecification>
  //    spec( new coral::AttributeListSpecification(), releaser() );
  //    spec->extend( "A_TOKEN", "Token" );
  //    IFolderPtr folder = s_db->createFolder( "/myfolder", *spec );
  //  }


  /// Tests creation of a folder with a long long column - should fail
  /// Marco: With the new RecordSpecification, it is impossible to us an unsupported type
  //  void test_unsupportedTypesLongLong() {
  //    boost::shared_ptr<coral::AttributeListSpecification>
  //    spec( new coral::AttributeListSpecification(), releaser() );
  //    spec->extend( "A_LONGLONG", "long long" );
  //    try {
  //      IFolderPtr folder = s_db->createFolder( "/myfolder", *spec );
  //    } catch ( std::exception& /*e*/ ) {
  //      //std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
  //      throw;
  //    }
  //  }


  /// Tests creation of a folder with a char column - should fail
  /// Marco: With the new RecordSpecification, it is impossible to us an unsupported type
  //  void test_unsupportedTypesChar() {
  //    boost::shared_ptr<coral::AttributeListSpecification>
  //    spec( new coral::AttributeListSpecification(), releaser() );
  //    spec->extend( "A_CHAR", "char" );
  //    try {
  //      IFolderPtr folder = s_db->createFolder( "/myfolder", *spec );
  //    } catch ( std::exception& /*e*/ ) {
  //      //std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
  //      throw;
  //    }
  //  }


  /// Tests creation of a folder with a Token column - should fail
  /// Marco: With the new RecordSpecification, it is impossible to us an unsupported type
  //  void test_unsupportedTypesLongDouble() {
  //    boost::shared_ptr<coral::AttributeListSpecification>
  //    spec( new coral::AttributeListSpecification(), releaser() );
  //    spec->extend( "A_LONGDOUBLE", "long double" );
  //    try {
  //      IFolderPtr folder = s_db->createFolder( "/myfolder", *spec );
  //    } catch ( std::exception& /*e*/ ) {
  //      //std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
  //      throw;
  //    }
  //  }


  /// Tests that storing a UInt63 larger than 2^63-1 fails
  /// (default for both IOV boundaries and user payload UInt63)
  void test_default_UInt63()
  {
    RecordSpecification spec;
    std::string attrName = "UInt63";
    StorageType::TypeId attrType = StorageType::UInt63;
    spec.extend( attrName, attrType );
    IFolderPtr folder = s_db->createFolder( "/myfolder", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) );
    // Insert an object with uInt64=2^63-1: this should not throw
    Record payload( spec );
    UInt63 attrValue = Int64Max;
    payload[ attrName ].setValue<UInt63>( attrValue );
    folder->storeObject( 0, 1, payload, 0 );
    // Insert an object with uInt64=2^63: this should throw
    try
    {
      attrValue = (UInt63)Int64Max+1;
      payload[ attrName ].setValue( attrValue );
      folder->storeObject( 1, 2, payload, 0 );
      CPPUNIT_FAIL( "Inserting a UInt63 equal to Int64Max+1 should fail" );
    }
    catch( StorageTypeInvalidValue& ) {}
    //    std::string msg;
    //    try {
    //      std::string attrHint =
    //        RelationalTypeConverter::defaultUserPayloadHintForCppType( attrType );
    //      RelationalTypeConverterInvalidCppValue e0
    //        ( payload[attrName], attrHint, "" );
    //      msg = e0.what();
    //      folder->storeObject( 1, 2, payload, 0 );
    //    } catch ( StorageTypeInvalidValue &e ) {
    //      std::cout << "Exception caught: '" << e.what() << "'" << std::endl;
    //      CPPUNIT_ASSERT_EQUAL_MESSAGE
    //        ( "exception error message", msg, std::string( e.what() ) );
    //      throw;
    //    }
  }


  /// Tests creation of a folder with non-default maximum string length of 255
  /// (default has been changed to 4000 for user payload strings)
  /// Tests that storing a string of 300 characters fails
  void test_extSpec_string255()
  {
    // Create payload specification
    RecordSpecification spec;
    std::string attrName = "S";
    StorageType::TypeId attrType = StorageType::String255;
    spec.extend( attrName, attrType );
    // Create folder with extended payload specification
    IFolderPtr folder = s_db->createFolder( "/myfolder", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) );
    CPPUNIT_ASSERT( folder.get() != 0 );
    // Insert an object with 300 characters: this should throw
    try
    {
      Record payload( spec );
      payload[ attrName ].setValue<String255>( std::string(300,'x') );
      folder->storeObject( 0, 1, payload, 0 );
      CPPUNIT_FAIL( "Inserting a String255 with 300 characters should fail" );
    }
    catch( StorageTypeInvalidValue& ) {}
    //    std::string msg;
    //    try {
    //      RelationalTypeConverterInvalidCppValue e0
    //        ( payload[attrName], attrHint, "" );
    //      msg = e0.what();
    //      folder->storeObject( 0, 1, payload, 0 );
    //    } catch ( RelationalTypeConverterInvalidCppValue& e ) {
    //      CPPUNIT_ASSERT_EQUAL_MESSAGE
    //        ( "exception error message", msg, std::string( e.what() ) );
    //      throw;
    //    }
  }


  /// Tests creation of a folder with four string columns of all supported
  /// maximum lengths (255, 4K, 64K, 16M) using the private API
  void test_extSpec_allStrings()
  {
    // Create extended payload specification
    typedef std::pair<std::string,StorageType::TypeId> pair_type;
    std::vector<pair_type> all_types;
    all_types.push_back
      (pair_type ("A_STRING255", StorageType::String255 ) );
    all_types.push_back
      (pair_type ("A_STRING4K",  StorageType::String4k ) );
    all_types.push_back
      (pair_type ("A_STRING64K", StorageType::String64k ) );
    all_types.push_back
      (pair_type ("A_STRING16M", StorageType::String16M ) );
    RecordSpecification spec;
    std::vector<pair_type>::iterator i;
    for(i = all_types.begin(); i != all_types.end(); ++i )
    {
      spec.extend(i->first,i->second);
    }
    IFolderPtr folder = s_db->createFolder( "/myfolder", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) );
    CPPUNIT_ASSERT( folder.get() != 0 );
    Record payload( spec );
    for(i = all_types.begin(); i != all_types.end(); ++i )
      payload[i->first].setValue<std::string>( std::string(StorageType::storageType(i->second).maxSize(),'x') );
    folder->storeObject( 0, 100, payload, 0 );
    // Retrieve IOVS from the folder
    //std::cout << "MARCO: get object" << std::endl;
    IObjectPtr obj = folder->findObject( 10, 0 );
    for(i = all_types.begin(); i != all_types.end(); ++i )
    {
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Wrong number of char retrieved",
          StorageType::storageType(i->second).maxSize(),
          obj->payload()[i->first].data<std::string>().size() );
    }
  }


  /// Tests that storing a string longer than 4000 characters fails,
  /// while storing a 300 character string succeeds
  /// (default has been changed to 4000 for user payload strings)
  void test_default_string4000()
  {
    RecordSpecification spec;
    std::string attrName = "S";
    StorageType::TypeId attrType = StorageType::String4k;
    spec.extend( attrName, attrType );
    IFolderPtr folder = s_db->createFolder( "/myfolder", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) );
    // Insert an object with 300 characters: this should not throw
    Record payload( spec );
    payload[ attrName ].setValue<std::string>( std::string(300,'x') );
    folder->storeObject( 0, 1, payload, 0 );
    // Insert an object with 5000 characters: this should throw
    try
    {
      payload[ attrName ].setValue<std::string>( std::string(5000,'x') );
      folder->storeObject( 1, 2, payload, 0 );
      CPPUNIT_FAIL( "Inserting a String4k with 5000 characters should fail" );
    }
    catch( StorageTypeInvalidValue& ) {}
    //    std::string msg;
    //    try {
    //      std::string attrHint =
    //        RelationalTypeConverter::defaultUserPayloadHintForCppType( attrType );
    //      RelationalTypeConverterInvalidCppValue e0
    //        ( payload[attrName], attrHint, "" );
    //      msg = e0.what();
    //      folder->storeObject( 1, 2, payload, 0 );
    //    } catch ( RelationalTypeConverterInvalidCppValue& e ) {
    //      CPPUNIT_ASSERT_EQUAL_MESSAGE
    //        ( "exception error message", msg, std::string( e.what() ) );
    //      throw;
    //    }
  }


  /// Tests that storing a specification with a string representation
  /// 65535 characters long always succeeds.
  /// Note that the new constraints (<=900 fields with names <=30 characters)
  /// imply that the longest description that can be built is only
  /// 900*(30+1+9)+899*1=36899 characters ("name:String64k,name:String64k...).
  /// This test actually tests that this payload specification can be used.
  void test_payloadSpecDescription()
  {
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "PANIC! Unexpected folder payload description maxSize (hint)",
        StorageType::String64k,
        RelationalNodeTable::columnTypeIds::folderPayloadSpecDesc );
    RecordSpecification spec;
    for ( int i = 0; i < 900; ++i )
    {
      std::stringstream s;
      s << "S1234567890123456789012345" << i+1000;
      spec.extend( s.str(), StorageType::String64k );
    }
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "Payload description size",
        (size_t)36899,
        RelationalDatabase::encodeRecordSpecification( spec ).size() );
    IFolderPtr folder = s_db->createFolder( "/myfolder", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) );
    CPPUNIT_ASSERT( folder.get() != 0 );
  }


  /// Tests that storing a specification with over 900 columns fails
  void test_payloadSpecTooManyFields()
  {
    RecordSpecification spec;
    for ( int i = 0; i < 900; ++i )
    {
      std::stringstream s;
      s << "S" << i;
      spec.extend( s.str(), StorageType::String4k );
    }
    s_db->createFolder( "/myfolder900", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) );
    {
      int i = 900;
      std::stringstream s;
      s << "S" << i;
      spec.extend( s.str(), StorageType::String4k );
    }
    CPPUNIT_ASSERT_THROW( s_db->createFolder( "/myfolder901", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) ),
                          PayloadSpecificationTooManyFields );
  }


  /// Tests that storing a specification with over 10 blob columns fails
  void test_payloadSpecTooManyBlobFields()
  {
    RecordSpecification spec;
    for ( int i = 0; i < 10; ++i )
    {
      std::stringstream s;
      s << "B" << i;
      spec.extend( s.str(), StorageType::Blob64k );
    }
    s_db->createFolder( "/myfolder10blob", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) );
    {
      int i = 11;
      std::stringstream s;
      s << "B" << i;
      //spec.extend( s.str(), StorageType::Blob64k );
      spec.extend( s.str(), StorageType::Blob16M );
    }
    CPPUNIT_ASSERT_THROW( s_db->createFolder( "/myfolder11blob", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) ),
                          PayloadSpecificationTooManyBlobFields );
  }


  /// Test for bug #24646: storing a specification with over 8000 bytes fails
  /// (where each long VARCHAR, TEXT or BLOB counts for 768 bytes)
  void test_payloadSpecOver8000Bytes()
  {
    {
      // This succeeds on all backends
      RecordSpecification spec;
      for ( int i = 0; i < 10; ++i )
      {
        std::stringstream s;
        s << "CLOB" << i;
        spec.extend( s.str(), StorageType::String64k );
      }
      IFolderPtr folder = s_db->createFolder( "/myfolder10clob", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) );
      Record record( spec );
      std::string value = std::string( 1000, 'x' );
      for ( int i = 0; i < 10; ++i )
      {
        std::stringstream s;
        s << "CLOB" << i;
        record[s.str()].setValue( value );
      }
      folder->storeObject(  0, 10, record, 0 );
    }
    TransRalDatabase* traldb = dynamic_cast<TransRalDatabase*>( s_db.get() );
    if ( !traldb ) throw InternalErrorException( "Dynamic cast failed", "RelationalObjectMgrTest" );  // Fix Coverity FORWARD_NULL
    RalDatabase* ralDb = traldb->getRalDb();
    if ( ralDb->sessionMgr()->databaseTechnology() == "MySQL" )
    {
      std::cout << std::endl
                << "WARNING: '8000 bytes' test disabled for MySQL (bug #24646)"
                << std::endl;
    }
    else
    {
      // This fails on MySQL (total size is 11*768>8000) with
      // "MySQL errno:1030: Got error 139 from storage engine"
      RecordSpecification spec;
      for ( int i = 0; i < 11; ++i )
      {
        std::stringstream s;
        s << "CLOB" << i;
        spec.extend( s.str(), StorageType::String64k );
      }
      IFolderPtr folder = s_db->createFolder( "/myfolder11clob", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) );
      Record record( spec );
      std::string value = std::string( 1000, 'x' );
      for ( int i = 0; i < 11; ++i )
      {
        std::stringstream s;
        s << "CLOB" << i;
        record[s.str()].setValue( value );
      }
      folder->storeObject(  0, 10, record, 0 );
    }
  }


  /// Tests that storing a specification with over 200 string255 columns fails
  void test_payloadSpecTooManyString255Fields()
  {
    RecordSpecification spec;
    // Total size on MySQL is 65535 = 257*255 -> at most 257 (user+sys) fields.
    // IOV table has two String255 internal columns -> at most 255 user fields.
    // But 65535 also includes all numeric fields -> COOL limit is 200.
    for ( int i = 0; i < 200; ++i )
    {
      std::stringstream s;
      s << "S" << i;
      spec.extend( s.str(), StorageType::String255 );
    }
    // Assume long long (BIGINT) are the largest non-VARCHAR (8 bytes)
    // See http://dev.mysql.com/doc/refman/5.1/en/storage-requirements.html
    for ( int i = 0; i < 699; ++i )
    {
      std::stringstream s;
      s << "I" << i;
      spec.extend( s.str(), StorageType::Int64 );
    }
    s_db->createFolder( "/myfolder200String255", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) );
    {
      int i = 200;
      std::stringstream s;
      s << "S" << i;
      spec.extend( s.str(), StorageType::String255 );
    }
    CPPUNIT_ASSERT_THROW( s_db->createFolder( "/myfolder201String255", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) ),
                          PayloadSpecificationTooManyString255Fields );
  }


  /// Tests that storing a specification with invalid field names fails.
  void test_payloadSpecInvalidFieldName()
  {
    // Test that a field name of size 30 succeeds, of size 31 fails
    {
      RecordSpecification spec;
      spec.extend( "S12345678901234567890123456789", StorageType::String255 );
      s_db->createFolder( "/myfolder", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) );
      spec.extend( "S123456789012345678901234567890", StorageType::String255 );
      CPPUNIT_ASSERT_THROW( s_db->createFolder( "/myfoldernew", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) ),
                            PayloadSpecificationInvalidFieldName );
    }
    // Test that a field name of size 0 fails
    {
      RecordSpecification spec;
      try
      {
        spec.extend( "", StorageType::String255 );
        CPPUNIT_FAIL( "Creating a field spec with name '' should fail" );
      } catch ( FieldSpecificationInvalidName& ) {}
    }
    // Test that a field name containing the '-' sign fails
    {
      RecordSpecification spec;
      spec.extend( "is-a", StorageType::String255 );
      CPPUNIT_ASSERT_THROW( s_db->createFolder( "/myfoldernew", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) ),
                            PayloadSpecificationInvalidFieldName );
    }
    // Test that a field name starting with the '_' sign fails
    {
      RecordSpecification spec;
      spec.extend( "_payload", StorageType::String255 );
      CPPUNIT_ASSERT_THROW( s_db->createFolder( "/myfoldernew", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) ),
                            PayloadSpecificationInvalidFieldName );
    }
    // Test that a field name starting with a digit fails
    {
      RecordSpecification spec;
      spec.extend( "1payload", StorageType::String255 );
      CPPUNIT_ASSERT_THROW( s_db->createFolder( "/myfoldernew", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) ),
                            PayloadSpecificationInvalidFieldName );
    }
    // Test that a field name starting with "COOL_" fails
    {
      RecordSpecification spec;
      spec.extend( "COOL_payload", StorageType::String255 );
      CPPUNIT_ASSERT_THROW( s_db->createFolder( "/myfoldernew", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) ),
                            PayloadSpecificationInvalidFieldName );
    }
    // Test that a field name starting with "cool_" fails
    {
      RecordSpecification spec;
      spec.extend( "cool_payload", StorageType::String255 );
      CPPUNIT_ASSERT_THROW( s_db->createFolder( "/myfoldernew", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) ),
                            PayloadSpecificationInvalidFieldName );
    }
    // Test that a field name starting with "Cool_" fails
    {
      RecordSpecification spec;
      spec.extend( "Cool_Payload", StorageType::String255 );
      CPPUNIT_ASSERT_THROW( s_db->createFolder( "/myfoldernew", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) ),
                            PayloadSpecificationInvalidFieldName );
    }
  }


  /// Tests storing and retrieving empty strings
  void test_emptyString()
  {
    std::string name = "A_STRING255";
#ifdef COOL290VP
    RecordSpecification rspec;
    rspec.extend( name, StorageType::String255 );
    FolderSpecification fspec( rspec );
#else
    FolderSpecification fspec;
    fspec.payloadSpecification().extend
      ( name, StorageType::String255 );
#endif
    IFolderPtr folder = s_db->createFolder( "/myfolder", fspec );
    CPPUNIT_ASSERT( folder.get() != 0 );
    Record record( fspec.payloadSpecification() );
    // Store value at 0 = ""
    std::string value = "";
    record[name].setValue( value );
    folder->storeObject(  0, 10, record, 0 );
    // Store value at 10 = NULL
    record[name].setNull();
    folder->storeObject( 10, 20, record, 0 );
    // Retrieve value at 0 = ""
    {
      IObjectPtr obj = folder->findObject( 0, 0 );
      const IField& fld = obj->payload()[name];
      // This would succeed if setValue("") actually sets the value to NULL (2)
      //CPPUNIT_ASSERT_EQUAL_MESSAGE
      //  ( "Empty string - should be null (new IField!)",
      //    true, fld.isNull() );
      // This used to fail on Oracle when "" and NULL were different (1)
      // This now succeeds on all 3 dbs: setNull() sets the value to "" (3)
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Empty string - should be not null",
          false, fld.isNull() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Empty string - size should be 0",
          (size_t)0, fld.data<std::string>().size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Empty string - value should be \"\"",
          std::string(""), fld.data<std::string>() );
    }
    // Retrieve value at 10 = NULL
    {
      IObjectPtr obj = folder->findObject( 10, 0 );
      const IField& fld = obj->payload()[name];
      // This used to succeed on all 3 dbs when "" and NULL were different (1)
      // This would succeed if setValue("") actually sets the value to NULL (2)
      //CPPUNIT_ASSERT_EQUAL_MESSAGE
      //  ( "Null string - should be null",
      //    true, fld.isNull() );
      // This now succeeds on all 3 dbs: setNull() sets the value to "" (3)
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Null string - on readback, should be not null",
          false, fld.isNull() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Null string - on readback, size should be 0",
          (size_t)0, fld.data<std::string>().size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Null string - on readback, value should be \"\"",
          std::string(""), fld.data<std::string>() );
    }
  }


  /// Tests storing and retrieving std strings containing the \0 character
  /// This fails on all three backends!
  /// Note that it also fails on Benthic (but not on sqlplus).
  void test_nullCharInString()
  {
    std::string name = "A_STRING255";
#ifdef COOL290VP
    RecordSpecification rspec;
    rspec.extend( name, StorageType::String255 );
    FolderSpecification fspec( rspec );
#else
    FolderSpecification fspec;
    fspec.payloadSpecification().extend
      ( name, StorageType::String255 );
#endif
    IFolderPtr folder = s_db->createFolder( "/myfolder", fspec );
    CPPUNIT_ASSERT( folder.get() != 0 );
    Record record( fspec.payloadSpecification() );
    std::string value = "";
    for ( int i=0; i<10; i++ )
    {
      value += 'A';
      value += '\x00';
      value += 'Z';
    }
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "Input value size",
        (size_t)30, value.size() );
    try
    {
      record[name].setValue( value );
      CPPUNIT_FAIL( "setValue should fail" );
    }
    catch ( StorageTypeStringContainsNullChar& ) {}
    catch ( ... )
    {
      CPPUNIT_FAIL
        ( "Wrong exception: expected StorageTypeStringContainsNullChar" );
    }
    /*
      record[name].setValue( value );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "Input field size",
      (size_t)30, record[name].data<std::string>().size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "Input field - compare to input value",
      value, record[name].data<std::string>() );
      folder->storeObject( 0, 10, record, 0 );
      IObjectPtr obj = folder->findObject( 0, 0 );
      const IField& fld = obj->payload()[name];
      CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "Fetched string - should be not null",
      false, fld.isNull() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "Fetched string - size should be 30",
      (size_t)30, fld.data<std::string>().size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "Fetched string - compare to input value",
      value, fld.data<std::string>() );
    *///
  }


  /// Tests storing and reading back a BLOB64K longer than 65535 characters.
  /// This should fail on MySQL (the BLOB64K SQL type has that limit).
  void test_blob64kOver64k()
  {
    RecordSpecification spec;
    std::string name = "B";
    StorageType::TypeId attrType = StorageType::Blob64k;
    spec.extend( name, attrType );
    s_db->createFolder( "/myfolder", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) );
    // Insert a BLOB64K with 65536 bytes or more
    int numberOfElements = 65536 / sizeof(float);
    if ( 65536 % sizeof(float) != 0 ) numberOfElements++;
    Blob64k blob( numberOfElements * sizeof(float) );
    float* addressToElement = static_cast< float* >( blob.startingAddress() );
    for ( int i = 0; i < numberOfElements; ++i, ++addressToElement )
    {
      *addressToElement = static_cast<float>(i + 0.01);
    }
    Record record( spec );
    /*
      record[name].setValue( blob );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "Input field - should be not null",
      false, record[name].isNull() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "Input field size",
      blob.size(), record[name].data<Blob64k>().size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "Input field - compare to input value",
      true, blob == record[name].data<Blob64k>() );
      folder->storeObject( 0, 1, record, 0 );
      IObjectPtr obj = folder->findObject( 0, 0 );
      const IField& fld = obj->payload()[name];
      CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "Fetched field - should be not null",
      false, fld.isNull() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "Fetched field size",
      blob.size(), fld.data<Blob64k>().size() );
      CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "Fetched field - compare to input value",
      true, blob == fld.data<Blob64k>() );
    *///
    try
    {
      record[name].setValue( blob );
      CPPUNIT_FAIL( "setValue should fail" );
    }
    catch ( StorageTypeBlobTooLong& ) {}
    catch ( ... )
    {
      CPPUNIT_FAIL
        ( "Wrong exception: expected StorageTypeBlobTooLong" );
    }
  }


  /// Tests storing and reading back a BLOB16M longer than 65535 characters.
  /// This should succeed on all platforms.
  void test_blob16MOver64k()
  {
    RecordSpecification spec;
    std::string name = "B";
    StorageType::TypeId attrType = StorageType::Blob16M;
    spec.extend( name, attrType );
    IFolderPtr folder = s_db->createFolder( "/myfolder", FolderSpecification( FolderVersioning::SINGLE_VERSION, spec ) );
    // Insert a BLOB16M with 65536 bytes or more
    int numberOfElements = 65536 / sizeof(float);
    if ( 65536 % sizeof(float) != 0 ) numberOfElements++;
    Blob16M blob( numberOfElements * sizeof(float) );
    float* addressToElement = static_cast< float* >( blob.startingAddress() );
    for ( int i = 0; i < numberOfElements; ++i, ++addressToElement )
    {
      *addressToElement = static_cast< float >( i + 0.01 );
    }
    Record record( spec );
    record[name].setValue( blob );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "Input field - should be not null",
        false, record[name].isNull() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "Input field size",
        blob.size(), record[name].data<Blob16M>().size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "Input field - compare to input value",
        true, blob == record[name].data<Blob16M>() );
    folder->storeObject( 0, 1, record, 0 );
    IObjectPtr obj = folder->findObject( 0, 0 );
    const IField& fld = obj->payload()[name];
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "Fetched field - should be not null",
        false, fld.isNull() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "Fetched field size",
        blob.size(), fld.data<Blob16M>().size() );
    CPPUNIT_ASSERT_EQUAL_MESSAGE
      ( "Fetched field - compare to input value",
        true, blob == fld.data<Blob16M>() );
    /*
      try {
      record[name].setValue( blob );
      CPPUNIT_FAIL( "setValue should fail" );
      }
      catch ( StorageTypeBlobTooLong& ) {}
      catch ( ... ) {
      CPPUNIT_FAIL
      ( "Wrong exception: expected StorageTypeBlobTooLong" );
      }
    *///
  }


  /// Tests storing and retrieving empty blobs
  /// This used to fail for SQLite (bug #22485 aka bug #30036)
  void test_emptyBlob()
  {
    std::string name = "A_BLOB";
#ifdef COOL290VP
    RecordSpecification rspec;
    rspec.extend( name, StorageType::Blob64k );
    FolderSpecification fspec( rspec );
#else
    FolderSpecification fspec;
    fspec.payloadSpecification().extend
      ( name, StorageType::Blob64k );
#endif
    IFolderPtr folder = s_db->createFolder( "/myfolder", fspec );
    CPPUNIT_ASSERT( folder.get() != 0 );
    Record record( fspec.payloadSpecification() );
    // Insert value at 0 = BLOB with 0 bytes
    Blob64k value( 0 );
    record[name].setValue( value );
    folder->storeObject(  0, 10, record, 0 );
    // Insert value at 10 = NULL BLOB
    record[name].setNull();
    folder->storeObject( 10, 20, record, 0 );
    // Retrieve value at 0 = BLOB with 0 bytes
    {
      IObjectPtr obj = folder->findObject( 0, 0 );
      const IField& fld = obj->payload()[name];
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Empty blob - should be not null",
          false, fld.isNull() ); // Used to fail for sqlite (bug #22485)
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Empty blob - size should be 0",
          (long int)0, (long int)fld.data<Blob64k>().size() );
    }
    // Retrieve value at 10 = NULL BLOB
    {
      IObjectPtr obj = folder->findObject( 10, 0 );
      const IField& fld = obj->payload()[name];
      CPPUNIT_ASSERT_EQUAL_MESSAGE
        ( "Null blob - should be null",
          true, fld.isNull() );
    }
  }


  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  // Constructor (executed N times, _before_ all N test executions)
  RalDatabaseTest_extendedSpec() : CoolDBUnitTest()
  {
    // NB: there is no payload spec common to all tests!
  }

  // Destructor (executed N times, _after_ all N test executions)
  ~RalDatabaseTest_extendedSpec()
  {
  }

private:

  // Setup (executed N times, at the start of each test execution)
  void coolUnitTest_setUp()
  {
    try
    {
      if ( !s_db )
      {
        createDB();
        openDB();
      }
      else
      {
        refreshDB();
        openDB();
      }
    }
    catch ( std::exception& e )
    {
      std::cout << "Exception caught in setUp: " << e.what() << std::endl;
      throw;
    }
    catch ( ... )
    {
      std::cout << "UNKNOWN exception caught in setUp!" << std::endl;
      throw;
    }
  }

  // TearDown (executed N times, at the end of each test execution)
  void coolUnitTest_tearDown()
  {
  }

  // Private helper
  std::string toString( const coral::Attribute& a )
  {
    std::stringstream s;
    const bool valueOnly = true;
    a.toOutputStream( s, valueOnly );
    return s.str();
  }

};

CPPUNIT_TEST_SUITE_REGISTRATION( cool::RalDatabaseTest_extendedSpec );

COOLTEST_MAIN( RalDatabaseTest_extendedSpec )
