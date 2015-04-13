// $Id: test_CoralBase.cpp,v 1.5 2012-07-07 21:16:48 avalassi Exp $

// First of all, enable or disable the CORAL240 API extensions (bug #89707)
#include "CoralBase/VersionInfo.h"

// Include files
#include <cstdlib>
#include <iostream>
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"
#include "CoralBase/AttributeListSpecification.h"
#include "CoralBase/AttributeSpecification.h"
#include "CoralBase/Date.h"
#include "CoralBase/Exception.h"
#include "CoralBase/TimeStamp.h"
#include "CoralBase/../tests/Common/CoralCppUnitTest.h"

// Forward declaration (for easier indentation)
namespace coral
{
  class CoralBaseTest;
}

// The test class
class coral::CoralBaseTest : public coral::CoralCppUnitTest
{

  CPPUNIT_TEST_SUITE( CoralBaseTest );

  // The following tests were originally based on stdout comparison
  // (which has not yet been ported to CppUnit)
  CPPUNIT_TEST( test_ALS_alsFunctionality );
  CPPUNIT_TEST( test_AL_simpleAtLi );
  CPPUNIT_TEST( test_AL_atLiWithSpec );
  CPPUNIT_TEST( test_AL_atLiWithSharedSpec );
  CPPUNIT_TEST( test_AL_atLiBound );
  CPPUNIT_TEST( test_AL_atLiShared );
  CPPUNIT_TEST( test_attributeReadWrite );
  CPPUNIT_TEST( test_attributeReadWrite_testSharingLoop );

  CPPUNIT_TEST_SUITE_END();

public:

  void setUp() {}

  void tearDown() {}

  // ------------------------------------------------------

  void
  test_ALS_alsFunctionality()
  {
    std::cout << std::endl;
    coral::AttributeListSpecification* spec = new coral::AttributeListSpecification;
    spec->extend<double>( "x" );
    spec->extend( "y", typeid(float) );
    spec->extend( "z", "int" );
    for ( coral::AttributeListSpecification::const_iterator iSpec = spec->begin(); iSpec != spec->end(); ++iSpec )
    {
      std::cout << iSpec->name() << " : " << iSpec->typeName() << std::endl;
    }
    const coral::AttributeSpecification& atSpec = spec->specificationForAttribute( spec->index( "y" ) );
    std::cout << "Type for \"y\" is \"" << atSpec.typeName() << "\"" << std::endl;
#ifdef CORAL240AL // Test for task #20089
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "ALS contains x", spec->exists("x"), true );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "ALS contains w", spec->exists("w"), false );
#endif
    spec->release();
    std::cout << std::endl;
  }

  // ------------------------------------------------------

  void
  test_AL_simpleAtLi()
  {
    std::cout << std::endl;
    coral::AttributeList atlist;
    atlist.extend<double>( "x" );
    atlist.extend( "y", "float" );
    atlist.extend( "z", typeid(int) );
    atlist.extend( "d", typeid(coral::Date) );
    atlist.extend( "t", typeid(coral::TimeStamp) );
    atlist.extend( "ll", "long long" );
    atlist["y"].data<float>() = 2;
    atlist[2].data<int>() = 3;
    atlist.begin()->data<double>() = 1;
    atlist[3].data<coral::Date>() = coral::Date::today();
    atlist[4].setValue( coral::TimeStamp::now() );
    atlist[5].data<long long>() = 12345678900LL;
    atlist.toOutputStream( std::cout );
#ifdef CORAL240AL // Test for task #20089
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "AL contains x", atlist.exists("x"), true );
    CPPUNIT_ASSERT_EQUAL_MESSAGE( "AL contains w", atlist.exists("w"), false );
#endif
    std::cout << std::endl;
  }

  // ------------------------------------------------------

  void
  test_AL_atLiWithSpec()
  {
    std::cout << std::endl;
    coral::AttributeListSpecification* spec = new coral::AttributeListSpecification;
    spec->extend<double>( "x" );
    spec->extend( "y", "float" );
    spec->extend( "z", typeid(int) );
    coral::AttributeList atlist1( *spec );
    atlist1.begin()->data<double>() = 1;
    atlist1["y"].data<float>() = 2;
    atlist1[2].data<int>() = 3;
    spec->extend<unsigned int>( "i" );
    coral::AttributeList atlist2( *spec );
    atlist2.begin()->data<double>() = 10;
    atlist2["y"].data<float>() = 20;
    atlist2[2].data<int>() = 30;
    atlist2[3].data<unsigned int>() = 40;
    spec->release();
    atlist1.toOutputStream( std::cout );
    std::cout << std::endl;
    atlist2.toOutputStream( std::cout );
    std::cout << std::endl;
  }

  // ------------------------------------------------------

  void
  test_AL_atLiWithSharedSpec()
  {
    std::cout << std::endl;
    coral::AttributeListSpecification* spec = new coral::AttributeListSpecification;
    spec->extend<double>( "x" );
    spec->extend( "y", "float" );
    spec->extend( "z", typeid(int) );
    coral::AttributeList atlist1( *spec, true );
    atlist1.begin()->data<double>() = 1;
    atlist1["y"].data<float>() = 2;
    atlist1[2].data<int>() = 3;
    spec->extend<unsigned int>( "i" );
    coral::AttributeList atlist2( *spec, true );
    atlist2.begin()->data<double>() = 10;
    atlist2["y"].data<float>() = 20;
    atlist2[2].data<int>() = 30;
    atlist2[3].data<unsigned int>() = 40;
    spec->release();
    atlist1.toOutputStream( std::cout );
    std::cout << std::endl;
    atlist2.toOutputStream( std::cout );
    std::cout << std::endl;
    atlist2["y"].setNull();
    atlist2.toOutputStream( std::cout );
    std::cout << std::endl;
    coral::AttributeList atlist3 = atlist2;
    atlist3.toOutputStream( std::cout );
    std::cout << std::endl;
    coral::AttributeList atlist4 = atlist3;
    atlist4.extend< unsigned int >( "ii" );
    atlist4[ "ii" ].data< unsigned int >() = 44;
    atlist4.toOutputStream( std::cout );
    std::cout << std::endl;
  }

  // ------------------------------------------------------

  void
  test_AL_atLiBound()
  {
    std::cout << std::endl;
    class MyObject
    {
    public:
      MyObject() : x(1), y(2), z(3), b( true ) {}
      ~MyObject() {}
      double x;
      float y;
      long z;
      bool b;
    };
    MyObject myObject;
    coral::AttributeList atlist;
    atlist.extend<double>( "x" );
    atlist["x"].bind( myObject.x );
    atlist.extend<float>( "y" );
    atlist["y"].bind( myObject.y );
    atlist.extend<long>( "z" );
    atlist["z"].bindUnsafely( &(myObject.z) );
    atlist.extend<bool>( "b" );
    atlist["b"].bindUnsafely( &(myObject.b) );
    atlist.extend<std::string>( "unchanged" );
    atlist["unchanged"].data<std::string>() = "data";
    atlist.toOutputStream( std::cout );
    std::cout << std::endl;
    myObject.x = 123;
    myObject.y = 231;
    myObject.z = 312;
    myObject.b = false;
    atlist.toOutputStream( std::cout );
    std::cout << std::endl;
    atlist["x"].data<double>() = 0.123;
    std::cout << "Object.x = " << myObject.x << std::endl;
  }

  // ------------------------------------------------------

  void
  test_AL_atLiShared()
  {
    std::cout << std::endl;
    std::cout << "Testing shared lists..." << std::endl;
    coral::AttributeList atlist1;
    atlist1.extend<double>( "x" );
    atlist1["x"].data<double>() = 1;
    atlist1.extend<float>( "y" );
    atlist1["y"].data<float>() = 2;
    atlist1.extend<int>( "z" );
    atlist1["z"].data<int>() = 3;
    coral::AttributeList atlist2;
    atlist2.extend<double>( "XX" );
    atlist2["XX"].data<double>() = 10;
    atlist2.extend<float>( "YY" );
    // Share atlist2.YY with atlist1.y
    atlist1["y"].shareData( atlist2["YY"] );
    atlist1["y"].data<float>() = 2;
    atlist1.toOutputStream( std::cout ) << std::endl;
    atlist2.toOutputStream( std::cout ) << std::endl;
    coral::AttributeList atlist3 = atlist2;
    // Share attlist3.YY with atlist2.YY
    atlist3["YY"].shareData( atlist2["YY"] );
    atlist3["YY"].data<float>() = 123;
    atlist1.toOutputStream( std::cout ) << std::endl;
    atlist2.toOutputStream( std::cout ) << std::endl;
    atlist3.toOutputStream( std::cout ) << std::endl;
    std::cout << "Setting null" << std::endl;
    atlist1["y"].setNull( true );
    atlist1.toOutputStream( std::cout ) << std::endl;
    atlist2.toOutputStream( std::cout ) << std::endl;
    atlist3.toOutputStream( std::cout ) << std::endl;
    std::cout << "Setting not null" << std::endl;
    atlist3["YY"].setNull( false );
    atlist1.toOutputStream( std::cout ) << std::endl;
    atlist2.toOutputStream( std::cout ) << std::endl;
    atlist3.toOutputStream( std::cout ) << std::endl;
  }

  // ------------------------------------------------------

  void
  test_attributeReadWrite()
  {
    std::cout << std::endl;
    coral::AttributeList al;
    al.extend("x", typeid(double));
    coral::Attribute& attribute = al[0];
    attribute.data<double>() = 11.22;
    std::cout << attribute.specification().name() << " ("
              << attribute.specification().typeName() << ") : "
              << attribute.data<double>() << std::endl;
    // Test for throwing exception if the attribute is null
    attribute.setNull();
    try
    {
      attribute.data<double>() = 11.22; // must throw exception
      CPPUNIT_FAIL( "NULL attribute data access did not throw" );
    }
    catch ( coral::AttributeException& ) {}
    try
    {
      const coral::Attribute& cAttr = attribute; // const method must throw too
      cAttr.data<double>();
      CPPUNIT_FAIL( "NULL attribute data access (const) did not throw" );
    }
    catch ( coral::AttributeException& ) {}
    std::cout << std::endl;
  }

  // ------------------------------------------------------

  void
  test_attributeReadWrite_testSharingLoop()
  {
    std::cout << std::endl;
    coral::AttributeList al1;
    al1.extend("x", typeid(double));
    coral::AttributeList al2;
    al2.extend("y", typeid(double));
    coral::AttributeList al3;
    al3.extend("z", typeid(double));
    al1[0].shareData(al2[0]);
    al3[0].shareData(al2[0]);
    al1[0].shareData(al3[0]);
    // This should not crash. If the sharing does not prevent sharing loop,
    // the 3 lines below start an infinite loop of recursive function calls
    // causing segmentation fault.
    al1[0].addressOfData();
    al2[0].addressOfData();
    al3[0].addressOfData();
    // Check if sharing is real
    static const double VAL = 3.5;
    al1[0].data<double>() = VAL;
    if (al1[0].data<double>() != VAL || al2[0].data<double>() != VAL || al3[0].data<double>() != VAL)
    {
      CPPUNIT_FAIL( "Data was not shared ..." );
    }
    std::cout << std::endl;
  }

  // ------------------------------------------------------

};

CPPUNIT_TEST_SUITE_REGISTRATION( coral::CoralBaseTest );

CORALCPPUNITTEST_MAIN( CoralBaseTest )
