// $Id: test_ChannelSelection.cpp,v 1.12 2013-03-08 10:53:22 avalassi Exp $

// Include files
#include "CoolKernel/ChannelSelection.h"
#include "CoolKernel/Exception.h"

// Local include files
//#define COOLUNITTESTTIMER 1
#include "CoolKernel/../tests/Common/CoolUnitTest.h"

// Forward declaration (for easier indentation)
namespace cool
{
  class ChannelSelectionTest;
}

// The test class
class cool::ChannelSelectionTest : public cool::CoolUnitTest
{

private:

  CPPUNIT_TEST_SUITE( ChannelSelectionTest );
  CPPUNIT_TEST( test_default_constructor );
  CPPUNIT_TEST( test_from_int );
  CPPUNIT_TEST( test_order );
  CPPUNIT_TEST( test_InvalidChannelRange );
  CPPUNIT_TEST( test_range );
  CPPUNIT_TEST( test_range_order );
  CPPUNIT_TEST( test_all );
  CPPUNIT_TEST( test_ChannelRange );
  CPPUNIT_TEST( test_ChannelRange_inRange );
  CPPUNIT_TEST( test_inSelection );
  CPPUNIT_TEST( test_addRange );
  CPPUNIT_TEST( test_addRange_outOfOrder );
  CPPUNIT_TEST( test_addRange_overlap );
  CPPUNIT_TEST( test_isContiguous );
  CPPUNIT_TEST( test_addChannel );
  CPPUNIT_TEST( test_addChannel_outOfOrder );
  CPPUNIT_TEST( test_addChannel_overlap );
  CPPUNIT_TEST( test_channelName_constructor );
  CPPUNIT_TEST( test_non_numeric_exceptions );
  CPPUNIT_TEST( test_numeric_exceptions );
  CPPUNIT_TEST( test_inSelection_string );
  CPPUNIT_TEST_SUITE_END();

public:

  void test_default_constructor() {
    ChannelSelection s;
    CPPUNIT_ASSERT_EQUAL( (ChannelId)0, s.firstChannel() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)4294967295ul, s.lastChannel() );
    CPPUNIT_ASSERT_EQUAL( ChannelSelection::channelBeforeSince, s.order() );
    CPPUNIT_ASSERT( s.allChannels() );
    CPPUNIT_ASSERT( s.isNumeric() );
  }


  void test_from_int() {
    ChannelSelection s( 5 );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)5, s.firstChannel() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)5, s.lastChannel() );
    CPPUNIT_ASSERT_EQUAL( ChannelSelection::channelBeforeSince, s.order() );
    CPPUNIT_ASSERT( ! s.allChannels() );
    CPPUNIT_ASSERT( s.isNumeric() );
  }


  void test_order() {
    ChannelSelection s( ChannelSelection::sinceBeforeChannel );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)0, s.firstChannel() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)4294967295ul, s.lastChannel() );
    CPPUNIT_ASSERT_EQUAL( ChannelSelection::sinceBeforeChannel, s.order() );
    CPPUNIT_ASSERT( s.allChannels() );
    CPPUNIT_ASSERT( s.isNumeric() );
  }


  /// Tests exceptional behavior of the ChannelSelection constructor
  void test_InvalidChannelRange() {
    CPPUNIT_ASSERT_THROW( ChannelSelection s( 3, 2 ),
                          InvalidChannelRange );
  }

  void test_range() {
    ChannelSelection s( 5, 10 );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)5, s.firstChannel() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)10, s.lastChannel() );
    CPPUNIT_ASSERT_EQUAL( ChannelSelection::channelBeforeSince, s.order() );
    CPPUNIT_ASSERT( ! s.allChannels() );
    CPPUNIT_ASSERT( s.isNumeric() );
  }


  void test_range_order() {
    ChannelSelection s( 5, 10, ChannelSelection::sinceBeforeChannel );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)5, s.firstChannel() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)10, s.lastChannel() );
    CPPUNIT_ASSERT_EQUAL( ChannelSelection::sinceBeforeChannel, s.order() );
    CPPUNIT_ASSERT( ! s.allChannels() );
    CPPUNIT_ASSERT( s.isNumeric() );
  }


  void test_all() {
    ChannelSelection s = ChannelSelection::all();
    CPPUNIT_ASSERT_EQUAL( (ChannelId)0, s.firstChannel() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)4294967295ul, s.lastChannel() );
    CPPUNIT_ASSERT_EQUAL( ChannelSelection::channelBeforeSince, s.order() );
    CPPUNIT_ASSERT( s.allChannels() );
    CPPUNIT_ASSERT( s.isNumeric() );
  }


  void test_ChannelRange() {
    ChannelSelection::ChannelRange r( 2, 4 );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)2, r.firstChannel() );
    CPPUNIT_ASSERT_EQUAL( (ChannelId)4, r.lastChannel() );
  }


  void test_ChannelRange_inRange() {
    ChannelSelection::ChannelRange r( 2, 4 );
    CPPUNIT_ASSERT( ! r.inRange( 1 ) );
    CPPUNIT_ASSERT( r.inRange( 2 ) );
    CPPUNIT_ASSERT( r.inRange( 3 ) );
    CPPUNIT_ASSERT( r.inRange( 4 ) );
    CPPUNIT_ASSERT( ! r.inRange( 5 ) );
  }


  void test_inSelection() {
    ChannelSelection s( 2, 4 );
    CPPUNIT_ASSERT( ! s.inSelection( 1 ) );
    CPPUNIT_ASSERT( s.inSelection( 2 ) );
    CPPUNIT_ASSERT( s.inSelection( 3 ) );
    CPPUNIT_ASSERT( s.inSelection( 4 ) );
    CPPUNIT_ASSERT( ! s.inSelection( 5 ) );
  }


  void test_addRange() {
    ChannelSelection s( 2, 4 );
    s.addRange( 6, 8 );
    CPPUNIT_ASSERT( ! s.inSelection( 1 ) );
    CPPUNIT_ASSERT( s.inSelection( 2 ) );
    CPPUNIT_ASSERT( s.inSelection( 3 ) );
    CPPUNIT_ASSERT( s.inSelection( 4 ) );
    CPPUNIT_ASSERT( ! s.inSelection( 5 ) );
    CPPUNIT_ASSERT( s.inSelection( 6 ) );
    CPPUNIT_ASSERT( s.inSelection( 7 ) );
    CPPUNIT_ASSERT( s.inSelection( 8 ) );
    CPPUNIT_ASSERT( ! s.inSelection( 9 ) );
    CPPUNIT_ASSERT( ! s.isContiguous() );
  }


  void test_addRange_outOfOrder() {
    ChannelSelection s( 6, 8 );
    s.addRange( 2, 4 );
    CPPUNIT_ASSERT( ! s.inSelection( 1 ) );
    CPPUNIT_ASSERT( s.inSelection( 2 ) );
    CPPUNIT_ASSERT( s.inSelection( 3 ) );
    CPPUNIT_ASSERT( s.inSelection( 4 ) );
    CPPUNIT_ASSERT( ! s.inSelection( 5 ) );
    CPPUNIT_ASSERT( s.inSelection( 6 ) );
    CPPUNIT_ASSERT( s.inSelection( 7 ) );
    CPPUNIT_ASSERT( s.inSelection( 8 ) );
    CPPUNIT_ASSERT( ! s.inSelection( 9 ) );
    CPPUNIT_ASSERT( ! s.isContiguous() );
  }


  /// Tests isContiguous for multiple ranges
  void test_isContiguous() {
    {
      ChannelSelection s( 5, 7 );
      CPPUNIT_ASSERT( s.isContiguous() );
      s.addChannel( 8 );
      CPPUNIT_ASSERT( s.isContiguous() );
      s.addRange( 3, 4 );
      CPPUNIT_ASSERT( s.isContiguous() );
      s.addRange( 9, 10 );
      CPPUNIT_ASSERT( s.isContiguous() );
      s.addRange( 0, 1 );
      CPPUNIT_ASSERT( ! s.isContiguous() );
    }
    {
      ChannelSelection s( 4, 5 );
      CPPUNIT_ASSERT( s.isContiguous() );
      s.addRange( 7,8 );
      CPPUNIT_ASSERT( ! s.isContiguous() );
    }
  }


  void test_addRange_overlap() {
    try {
      ChannelSelection s( 6, 8 );
      s.addRange( 2, 7 );
      CPPUNIT_FAIL( "Exception excepted" );
    } catch ( Exception& e ) {
      CPPUNIT_ASSERT_EQUAL( std::string( "Cannot add range [2,7], "
                                         "because it overlaps with "
                                         "selection" ),
                            std::string( e.what() ) );
    }
    try {
      ChannelSelection s( 6, 8 );
      s.addRange( 7, 9 );
      CPPUNIT_FAIL( "Exception excepted" );
    } catch ( Exception& e ) {
      CPPUNIT_ASSERT_EQUAL( std::string( "Cannot add range [7,9], "
                                         "because it overlaps with "
                                         "selection" ),
                            std::string( e.what() ) );
    }
  }


  void test_addChannel() {
    ChannelSelection s( 2, 4 );
    s.addChannel( 6 );
    CPPUNIT_ASSERT( ! s.inSelection( 1 ) );
    CPPUNIT_ASSERT( s.inSelection( 2 ) );
    CPPUNIT_ASSERT( s.inSelection( 3 ) );
    CPPUNIT_ASSERT( s.inSelection( 4 ) );
    CPPUNIT_ASSERT( ! s.inSelection( 5 ) );
    CPPUNIT_ASSERT( s.inSelection( 6 ) );
    CPPUNIT_ASSERT( ! s.inSelection( 7 ) );
    CPPUNIT_ASSERT( ! s.isContiguous() );
  }


  void test_addChannel_outOfOrder() {
    ChannelSelection s( 4, 6 );
    s.addChannel( 2 );
    CPPUNIT_ASSERT( ! s.inSelection( 1 ) );
    CPPUNIT_ASSERT( s.inSelection( 2 ) );
    CPPUNIT_ASSERT( ! s.inSelection( 3 ) );
    CPPUNIT_ASSERT( s.inSelection( 4 ) );
    CPPUNIT_ASSERT( s.inSelection( 5 ) );
    CPPUNIT_ASSERT( s.inSelection( 6 ) );
    CPPUNIT_ASSERT( ! s.inSelection( 7 ) );
    CPPUNIT_ASSERT( ! s.isContiguous() );
  }


  void test_addChannel_overlap() {
    try {
      ChannelSelection s( 6, 8 );
      s.addChannel( 7 );
      CPPUNIT_FAIL( "Exception excepted" );
    } catch ( Exception& e ) {
      CPPUNIT_ASSERT_EQUAL( std::string( "Cannot add range [7,7], "
                                         "because it overlaps with "
                                         "selection" ),
                            std::string( e.what() ) );
    }
  }


  void test_channelName_constructor() {
    ChannelSelection s( "channel A" );
    CPPUNIT_ASSERT( ! s.isNumeric() );
    CPPUNIT_ASSERT_EQUAL( ChannelSelection::channelBeforeSince, s.order() );
    CPPUNIT_ASSERT( ! s.allChannels() );
    CPPUNIT_ASSERT_EQUAL( std::string("channel A"), s.channelName() );
  }


  void test_non_numeric_exceptions() {
    ChannelSelection s( "channel A" );

    try {
      s.addChannel( 0 );
      CPPUNIT_FAIL( "Expected exception" );
    } catch ( Exception& e ) {
      CPPUNIT_ASSERT_EQUAL( std::string("Numeric method called for "
                                        "non-numeric ChannelSelection"),
                            std::string(e.what()) );
    }
    try {
      s.addRange( 0, 1 );
      CPPUNIT_FAIL( "Expected exception" );
    } catch ( Exception& e ) {
      CPPUNIT_ASSERT_EQUAL( std::string("Numeric method called for "
                                        "non-numeric ChannelSelection"),
                            std::string(e.what()) );
    }
    try {
      s.firstChannel();
      CPPUNIT_FAIL( "Expected exception" );
    } catch ( Exception& e ) {
      CPPUNIT_ASSERT_EQUAL( std::string("Numeric method called for "
                                        "non-numeric ChannelSelection"),
                            std::string(e.what()) );
    }
    try {
      s.lastChannel();
      CPPUNIT_FAIL( "Expected exception" );
    } catch ( Exception& e ) {
      CPPUNIT_ASSERT_EQUAL( std::string("Numeric method called for "
                                        "non-numeric ChannelSelection"),
                            std::string(e.what()) );
    }
    try {
      if ( s.inSelection( 0 ) )
      {
        // Formally fix Coverity CHECKED_RETURN
      }
      CPPUNIT_FAIL( "Expected exception" );
    } catch ( Exception& e ) {
      CPPUNIT_ASSERT_EQUAL( std::string("Numeric method called for "
                                        "non-numeric ChannelSelection"),
                            std::string(e.what()) );
    }
    try {
      if ( s.isContiguous() )
      {
        // Formally fix Coverity CHECKED_RETURN
      }
      CPPUNIT_FAIL( "Expected exception" );
    } catch ( Exception& e ) {
      CPPUNIT_ASSERT_EQUAL( std::string("Numeric method called for "
                                        "non-numeric ChannelSelection"),
                            std::string(e.what()) );
    }
  }


  void test_numeric_exceptions() {
    ChannelSelection s( 0 );

    try {
      if ( s.inSelection( "channel 1" ) )
      {
        // Formally fix Coverity CHECKED_RETURN
      }
      CPPUNIT_FAIL( "Expected exception" );
    } catch ( Exception& e ) {
      CPPUNIT_ASSERT_EQUAL( std::string("Non-numeric method called for "
                                        "numeric ChannelSelection"),
                            std::string(e.what()) );
    }
  }


  void test_inSelection_string() {
    ChannelSelection s( "channel 1" );
    CPPUNIT_ASSERT( ! s.inSelection( "channel 0" ) );
    CPPUNIT_ASSERT( s.inSelection( "channel 1" ) );
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  // Constructor (executed N times, _before_ all N test executions)
  ChannelSelectionTest() : CoolUnitTest()
  {
  }

  // Destructor (executed N times, _after_ all N test executions)
  ~ChannelSelectionTest()
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

CPPUNIT_TEST_SUITE_REGISTRATION( cool::ChannelSelectionTest );

COOLTEST_MAIN( ChannelSelectionTest )
