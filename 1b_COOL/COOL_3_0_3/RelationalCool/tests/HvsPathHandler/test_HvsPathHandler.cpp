
// Local include files
//#define COOLUNITTESTTIMER 1
#include "CoolKernel/../tests/Common/CoolUnitTest.h"
#include "src/HvsPathHandler.h"
#include "src/HvsPathHandlerException.h"

// Forward declaration (for easier indentation)
namespace cool
{
  class HvsPathHandlerTest;
}

//-----------------------------------------------------------------------------

class cool::HvsPathHandlerTest : public cool::CoolUnitTest
{

private:

  CPPUNIT_TEST_SUITE( HvsPathHandlerTest );
  CPPUNIT_TEST( test_removeTrailingSeparators );
  CPPUNIT_TEST( test_removeDoubleSeparators );
  CPPUNIT_TEST( test_splitFullPath );
  CPPUNIT_TEST( test_decodeFullPath );
  CPPUNIT_TEST( test_encodeFullPath );
  CPPUNIT_TEST_SUITE_END();

public:

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  typedef std::string S;
  typedef std::pair<S,S> P;
  typedef std::vector<S> V;
  const V newV( const int nS, const S& s1, const S& s2="", const S& s3="",
                const S& s4="", const S& s5="", const S& s6="" )
  {
    V v;
    if ( nS<1 || nS >6 )
      throw HvsPathHandlerException( "Wrong arguments to newV" );
    if ( nS>=1 ) v.push_back( s1 );
    if ( nS>=2 ) v.push_back( s2 );
    if ( nS>=3 ) v.push_back( s3 );
    if ( nS>=4 ) v.push_back( s4 );
    if ( nS>=5 ) v.push_back( s5 );
    if ( nS>=6 ) v.push_back( s6 );
    return v;
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_removeTrailingSeparators()
  {
    HvsPathHandler h;
    CPPUNIT_ASSERT_MESSAGE
      ( "Test '/a/b/c'",
        "/a/b/c" == h.removeTrailingSeparators("/a/b/c") );
    CPPUNIT_ASSERT_MESSAGE
      ( "Test '/a/b/c/'",
        "/a/b/c" == h.removeTrailingSeparators("/a/b/c/") );
    CPPUNIT_ASSERT_MESSAGE
      ( "Test '/a/b/c//'",
        "/a/b/c" == h.removeTrailingSeparators("/a/b/c//") );
    CPPUNIT_ASSERT_MESSAGE
      ( "Test '/'",
        "/" == h.removeTrailingSeparators("/") );
    CPPUNIT_ASSERT_MESSAGE
      ( "Test '//'",
        "/" == h.removeTrailingSeparators("//") );
    CPPUNIT_ASSERT_MESSAGE
      ( "Test ''",
        "" == h.removeTrailingSeparators("") );
    CPPUNIT_ASSERT_MESSAGE
      ( "Test 'a//b/c//'",
        "a//b/c" == h.removeTrailingSeparators("a//b/c//") );
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_removeDoubleSeparators()
  {
    HvsPathHandler h;
    CPPUNIT_ASSERT_MESSAGE
      ( "Test '/a/b/c'",
        "/a/b/c" == h.removeDoubleSeparators("/a/b/c") );
    CPPUNIT_ASSERT_MESSAGE
      ( "Test '/a/b/c/'",
        "/a/b/c/" == h.removeDoubleSeparators("/a/b/c/") );
    CPPUNIT_ASSERT_MESSAGE
      ( "Test '/a/b/c//'",
        "/a/b/c/" == h.removeDoubleSeparators("/a/b/c//") );
    CPPUNIT_ASSERT_MESSAGE
      ( "Test '/a/b//c'",
        "/a/b/c" == h.removeDoubleSeparators("/a/b//c") );
    CPPUNIT_ASSERT_MESSAGE
      ( "Test '///a/b///c//'",
        "/a/b/c/" == h.removeDoubleSeparators("///a///b/c//") );
    CPPUNIT_ASSERT_MESSAGE
      ( "Test '/'",
        "/" == h.removeDoubleSeparators("/") );
    CPPUNIT_ASSERT_MESSAGE
      ( "Test '//'",
        "/" == h.removeDoubleSeparators("//") );
    CPPUNIT_ASSERT_MESSAGE
      ( "Test ''",
        "" == h.removeDoubleSeparators("") );
    CPPUNIT_ASSERT_MESSAGE
      ( "Test 'a//b/c'",
        "a/b/c" == h.removeDoubleSeparators("a//b/c") );
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_splitFullPath()
  {

    HvsPathHandler h;

    // Test retrieving pairs
    CPPUNIT_ASSERT_MESSAGE
      ( "Test '/a/b/c'",
        P( "/a/b", "c" ) == h.splitFullPath("/a/b/c") );
    CPPUNIT_ASSERT_MESSAGE
      ( "Test '/a'",
        P( "/", "a" ) == h.splitFullPath("/a") );

    // Test catching exceptions
    bool caught;
    std::vector<std::string> excPaths;
    excPaths.push_back("");
    excPaths.push_back("/");
    excPaths.push_back("/a/b/");
    excPaths.push_back("/a//b");
    excPaths.push_back("//");
    std::vector<std::string>::const_iterator iPath;
    for ( iPath = excPaths.begin(); iPath != excPaths.end(); iPath++ ) {
      std::string excPath = *iPath;
      try { caught = false; h.splitFullPath(excPath); }
      catch ( HvsPathHandlerException& /* dummy */ ) { caught = true; }
      CPPUNIT_ASSERT_MESSAGE( std::string("Test ")+excPath, caught == true );
    }
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_decodeFullPath()
  {

    HvsPathHandler h;

    // Test retrieving vectors
    CPPUNIT_ASSERT_MESSAGE
      ( "Test '/a/b/c'",
        newV( 4, "", "a", "b", "c" ) == h.decodeFullPath("/a/b/c") );
    CPPUNIT_ASSERT_MESSAGE
      ( "Test '/a'",
        newV( 2, "", "a" ) == h.decodeFullPath("/a") );
    CPPUNIT_ASSERT_MESSAGE
      ( "Test '/",
        newV( 1, "" ) == h.decodeFullPath("/") );

    // Test catching exceptions
    bool caught;
    std::vector<std::string> excPaths;
    excPaths.push_back("");
    excPaths.push_back("a");
    excPaths.push_back("/a/b/");
    excPaths.push_back("/a//b");
    excPaths.push_back("//");
    std::vector<std::string>::const_iterator iPath;
    for ( iPath = excPaths.begin(); iPath != excPaths.end(); iPath++ ) {
      std::string excPath = *iPath;
      try { caught = false; h.decodeFullPath(excPath); }
      catch ( HvsPathHandlerException& /* dummy */ ) { caught = true; }
      CPPUNIT_ASSERT_MESSAGE( std::string("Test ")+excPath, caught == true );
    }

  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void test_encodeFullPath()
  {

    HvsPathHandler h;

    // Test building full paths
    CPPUNIT_ASSERT_MESSAGE
      ( "Test '/a/b/c'",
        "/a/b/c" == h.encodeFullPath( newV(4,"","a","b","c") ) );
    CPPUNIT_ASSERT_MESSAGE
      ( "Test '/'",
        "/" == h.encodeFullPath( newV(1,"") ) );

    // Test catching exceptions
    bool caught;
    std::vector<V> excLists;
    excLists.push_back(newV(1,"a"));
    excLists.push_back(newV(1,"/"));
    excLists.push_back(newV(2,"/","a"));
    excLists.push_back(newV(2,"","/"));
    excLists.push_back(newV(2,"","/a"));
    excLists.push_back(newV(2,"","a/"));
    std::vector<V>::const_iterator iList;
    for ( iList = excLists.begin(); iList != excLists.end(); iList++ ) {
      V excList = *iList;
      try { caught = false; h.encodeFullPath(excList); }
      catch ( HvsPathHandlerException& /* dummy */ ) { caught = true; }
      std::ostringstream msg;
      msg << "Test " << excList.size();
      for ( V::const_iterator iS = (*iList).begin(); iS != (*iList).end();
            iS++ ) { msg << ", '" << *iS << "'"; }
      CPPUNIT_ASSERT_MESSAGE( msg.str(), caught == true );
    }

  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  // Constructor (executed N times, _before_ all N test executions)
  HvsPathHandlerTest() : CoolUnitTest()
  {
  }

  // Destructor (executed N times, _after_ all N test executions)
  ~HvsPathHandlerTest()
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

CPPUNIT_TEST_SUITE_REGISTRATION( cool::HvsPathHandlerTest );

//-----------------------------------------------------------------------------

// Include CppUnit test driver
#include "CoolKernel/../tests/Common/CppUnit_testdriver.icpp"
