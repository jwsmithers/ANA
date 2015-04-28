#ifndef COMMON_COOLUNITTEST_H
#define COMMON_COOLUNITTEST_H 1

// Include files
#include <stdexcept>
#include <iostream>
#ifdef _WIN32
#include <eh.h>
#include <windows.h>
#endif

// Local include files
#include "CppUnit_headers.h"
#include "SimpleTimer.h"

// Debug
//#define COOLUNITTESTTIMER 1 // for all tests!
#ifdef COOLUNITTESTTIMER
#  ifndef _WIN32
static const bool _COOLUNITTEST_TIMER_ = true;
#  else
static const bool _COOLUNITTEST_TIMER_ = false; // No support on Windows
#  endif
#else
static const bool _COOLUNITTEST_TIMER_ = false;
#endif

// Redefine CPPUNIT_TEST
#undef CPPUNIT_TEST
/* COOLCPPCLEAN-NOINDENT-START *///
#define CPPUNIT_TEST( testMethod ) \
  CPPUNIT_TEST_SUITE_ADD_TEST( \
    ( new cool::TestCaller<TestFixtureType>( \
        context.getTestNameFor( # testMethod ), \
        &TestFixtureType::testMethod, \
        context.makeFixture() ) ) )
/* COOLCPPCLEAN-NOINDENT-END *///

namespace cool
{

  static double s_totalSecondsRealSetUp    = 0;
  static double s_totalSecondsRealRunTest  = 0;
  static double s_totalSecondsRealTearDown = 0;

  //--------------------------------------------------------------------------

#ifdef _WIN32

  /*
   *  Windows Structured Exception Handling (SEH) using _set_se_translator.
   *  See http://msdn.microsoft.com/en-us/library/5z4bw5h5(VS.80).aspx
   *
   *  @author Andrea Valassi
   *  @date   2009-01-12
   *///

  class SE_Exception : public std::exception
  {
  public:
    SE_Exception( unsigned int nSECode,
                  const std::string& message )
      : m_nSECode( nSECode ), m_message( message ) {}
    virtual ~SE_Exception() {}
    int getSECode() { return m_nSECode; }
    const char* what() const { return m_message.c_str(); }
  private:
    int m_nSECode;
    std::string m_message;
  };

  // See http://www.codeproject.com/KB/cpp/seexception.aspx
  // See http://msdn.microsoft.com/en-us/library/ms681401(VS.85).aspx
  void SE_translator( unsigned int nSECode, EXCEPTION_POINTERS* /*pExcPtr*/ )
  {
    std::cout << "__cool::SE_translator WINDOWS SE CAUGHT" << std::endl;
    std::stringstream msg;
    msg << "WINDOWS STRUCTURED EXCEPTION";
    msg << " 0x" << std::hex << nSECode;
    // This would print out exactly the same exception code
    //msg << " 0x" << pExcPtr->ExceptionRecord->ExceptionCode;
    msg << std::dec;
    if ( nSECode == EXCEPTION_ACCESS_VIOLATION )
      msg << " (EXCEPTION_ACCESS_VIOLATION)";
    else if ( nSECode == EXCEPTION_ARRAY_BOUNDS_EXCEEDED )
      msg << " (EXCEPTION_ARRAY_BOUNDS_EXCEEDED)";
    else if ( nSECode == EXCEPTION_BREAKPOINT )
      msg << " (EXCEPTION_BREAKPOINT)";
    else if ( nSECode == EXCEPTION_DATATYPE_MISALIGNMENT )
      msg << " (EXCEPTION_DATATYPE_MISALIGNMENT)";
    else if ( nSECode == EXCEPTION_FLT_DENORMAL_OPERAND )
      msg << " (EXCEPTION_FLT_DENORMAL_OPERAND)";
    else if ( nSECode == EXCEPTION_FLT_DIVIDE_BY_ZERO )
      msg << " (EXCEPTION_FLT_DIVIDE_BY_ZERO)";
    else if ( nSECode == EXCEPTION_FLT_INEXACT_RESULT )
      msg << " (EXCEPTION_FLT_INEXACT_RESULT)";
    else if ( nSECode == EXCEPTION_FLT_INVALID_OPERATION )
      msg << " (EXCEPTION_FLT_INVALID_OPERATION)";
    else if ( nSECode == EXCEPTION_FLT_OVERFLOW )
      msg << " (EXCEPTION_FLT_OVERFLOW)";
    else if ( nSECode == EXCEPTION_FLT_STACK_CHECK )
      msg << " (EXCEPTION_FLT_STACK_CHECK)";
    else if ( nSECode == EXCEPTION_FLT_UNDERFLOW )
      msg << " (EXCEPTION_FLT_UNDERFLOW)";
    else if ( nSECode == EXCEPTION_ILLEGAL_INSTRUCTION )
      msg << " (EXCEPTION_ILLEGAL_INSTRUCTION)";
    else if ( nSECode == EXCEPTION_IN_PAGE_ERROR )
      msg << " (EXCEPTION_IN_PAGE_ERROR)";
    else if ( nSECode == EXCEPTION_INT_DIVIDE_BY_ZERO )
      msg << " (EXCEPTION_INT_DIVIDE_BY_ZERO)";
    else if ( nSECode == EXCEPTION_INT_OVERFLOW )
      msg << " (EXCEPTION_INT_OVERFLOW)";
    else if ( nSECode == EXCEPTION_INVALID_DISPOSITION )
      msg << " (EXCEPTION_INVALID_DISPOSITION)";
    else if ( nSECode == EXCEPTION_NONCONTINUABLE_EXCEPTION )
      msg << " (EXCEPTION_NONCONTINUABLE_EXCEPTION)";
    else if ( nSECode == EXCEPTION_PRIV_INSTRUCTION )
      msg << " (EXCEPTION_PRIV_INSTRUCTION)";
    else if ( nSECode == EXCEPTION_SINGLE_STEP )
      msg << " (EXCEPTION_SINGLE_STEP)";
    else if ( nSECode == EXCEPTION_STACK_OVERFLOW )
      msg << " (EXCEPTION_STACK_OVERFLOW)";
    else
      msg << " (UNKNOWN)";
    std::cout << msg.str() << std::endl;
    throw SE_Exception( nSECode, msg.str() );
  }

#endif

  //--------------------------------------------------------------------------

  /** @class TestCaller
   *
   *  Simple TestCaller wrapping the execution of each test in a test suite.
   *
   *  @author Andrea Valassi
   *  @date   2009-01-12
   *///

  template< class Fixture > class TestCaller
    : virtual public CppUnit::TestCaller<Fixture>
  {

    typedef void ( Fixture::* TestMethod )();

  public:

    virtual ~TestCaller(){}

    TestCaller( std::string name, TestMethod test )
      : CppUnit::TestCaller<Fixture>( name, test ){}

    TestCaller( std::string name, TestMethod test, Fixture& fixture )
      : CppUnit::TestCaller<Fixture>( name, test, fixture ){}

    TestCaller( std::string name, TestMethod test, Fixture* fixture )
      : CppUnit::TestCaller<Fixture>( name, test, fixture ){}

#ifdef _WIN32
    // See http://msdn.microsoft.com/en-us/library/s58ftw19.aspx
    int filter( unsigned int code, struct _EXCEPTION_POINTERS* ep )
    {
      if ( code == EXCEPTION_ACCESS_VIOLATION )
      {
        std::cout << "__cool::TestCaller::filter"
                  << " ERROR! WIN32 Access Violation" << std::endl;
        return EXCEPTION_EXECUTE_HANDLER;
      }
      else
      {
        std::cout << "__cool::TestCaller::filter"
                  << " ERROR! WIN32 Unknown exception" << std::endl;
        return EXCEPTION_EXECUTE_HANDLER;
        //return EXCEPTION_CONTINUE_SEARCH;
      };
    }
#endif

    void runTest()
    {
      SimpleTimer timer;
      //std::cout << std::endl;
      //std::cout << "+++ cool::TestCaller::runTest '"
      //          << this->getName() << "'..." << std::endl;
#ifdef _WIN32
      // This fails to build even when replacing /EHsc by /EHa
      // (C2712: Cannot use __try in functions that require object unwinding)
      // See http://msdn.microsoft.com/en-us/library/1deeycx5(VS.80).aspx and
      // http://http://msdn.microsoft.com/en-us/library/1deeycx5(VS.80).aspx
      /*
      __try {
        CppUnit::TestCaller<Fixture>::runTest();
      }
      __except( filter( GetExceptionCode(), GetExceptionInformation() ) ) {
        std::cout << "__cool::TestCaller::runTest"
                  << " ERROR! WIN32 Structured exception caught" << std::endl;
      }
      *///
      try
      {
        CppUnit::TestCaller<Fixture>::runTest();
      }
      catch (...)
      {
        //std::cout << "+++ cool::TestCaller::runTest '" << this->getName()
        //          << "'... EXCEPTION CAUGHT!" << std::endl;
        throw;
      }
#else
      CppUnit::TestCaller<Fixture>::runTest();
#endif
      //std::cout << "--- cool::TestCaller::runTest '"
      //          << this->getName() << "'... DONE" << std::endl;
      double elapsedSecondsReal = timer.elapsedSecondsReal();
      s_totalSecondsRealRunTest += elapsedSecondsReal;
      if ( _COOLUNITTEST_TIMER_ )
        std::cout << " + " << elapsedSecondsReal << "s";
    }

  private:

    TestCaller<Fixture>();

  };

  //--------------------------------------------------------------------------

  /** @class TextTestRunner
   *
   *  Simple TextTestRunner wrapping the execution of a test suite.
   *
   *  @author Andrea Valassi
   *  @date   2009-01-12
   *///

  class TextTestRunner : virtual public CppUnit::TextTestRunner
  {

  public:

    virtual ~TextTestRunner(){}

    TextTestRunner() : CppUnit::TextTestRunner() {}

    void run( CppUnit::TestResult& controller, const std::string& testPath="" )
    {
      // Avoid compilation warning (virtual function was hidden...) on osx
      CppUnit::TextTestRunner::run( controller, testPath );
    }

    bool run( std::string testName = "",
              bool doWait = false,
              bool doPrintResult = true,
              bool doPrintProgress = true )
    {
      //std::cout << "+++ cool::TextTestRunner::run '"
      //          << testName << "'..." << std::endl;
      bool status = CppUnit::TextTestRunner::run( testName,
                                                  doWait,
                                                  doPrintResult,
                                                  doPrintProgress );
      //std::cout << "--- cool::TextTestRunner::run '"
      //          << testName << "'... DONE" << std::endl;
      return status;
    }

  };

  //--------------------------------------------------------------------------

  /** @class ProgressListener
   *
   *  Simple TestListener printing one line per test in the standard output.
   *
   *  Based on  CppUnit::BriefTestProgressListener (copy and paste)
   *  using std::cout instead of std::cerr.
   *
   *  @author Marco Clemencic
   *  @date   2006-11-13
   *///

  class ProgressListener : public CppUnit::TestListener
  {

  public:

    /// Default constructor.
    ProgressListener() : m_lastTestFailed(false) {}

    /// Destructor.
    virtual ~ProgressListener() {}

    void startTest( CppUnit::Test *test )
    {
      std::cout << test->getName();
      std::cout.flush();
      m_lastTestFailed = false;
    }

    void addFailure( const CppUnit::TestFailure &failure )
    {
      std::cout << " : " << (failure.isError() ? "error" : "assertion");
      m_lastTestFailed  = true;
    }

    void endTest( CppUnit::Test * /*test*/ )
    {
      if ( !m_lastTestFailed )
        std::cout <<  " : OK";
      std::cout << std::endl;
    }

  private:

    bool m_lastTestFailed;

  };


  //---------------------------------------------------------------------------

  /** @class CoolUnitTest CoolUnitTest.h Common/CoolUnitTest.h
   *
   *  Base class for COOL tests that does not use a database
   *  (use CoolDBUnitTest for tests involving databases).
   *
   *  @author Marco Clemencic
   *  @date   2006-05-09
   *///
  class CoolUnitTest : public CppUnit::TestFixture {

  public:

    /// Standard constructor
    CoolUnitTest(){}

    /// Destructor
    virtual ~CoolUnitTest(){}

    /// Program main
    static int Main( int argc, char* argv[] );

    /// SetUp (calls coolUnitTest_setUp)
    void setUp();

    /// TearDown (calls coolUnitTest_tearDown)
    void tearDown();

  private:

    /// SetUp of the concrete test class
    virtual void coolUnitTest_setUp(){}

    /// TearDown of the concrete test class
    virtual void coolUnitTest_tearDown(){}

  };

  int CoolUnitTest::Main( int argc, char* argv[] )
  {
    //std::cout << "+++ cool::CoolUnitTest::Main..." << std::endl;
#ifdef _WIN32
    _set_se_translator( cool::SE_translator );
#endif
    // Retrieve test path from command line first argument.
    // Default to "" which resolve to the top level suite.
    std::string testPath =
      (argc > 1) ? std::string(argv[1]) : std::string("");

    // Add a listener that colllects test result
    //CppUnit::TestResultCollector result;
    //controller.addListener( &result );

    /// Get the top level suite from the registry
    CppUnit::Test *suite =
      CppUnit::TestFactoryRegistry::getRegistry().makeTest();

    /// Adds the test to the list of test to run
    // CppUnit::TestRunner runner;
    // CppUnit::TextTestRunner runner;
    cool::TextTestRunner runner;
    runner.addTest( suite );

    // Change the default outputter to a compiler error format outputter
    // uncomment the following line if you need a compiler outputter.
    runner.setOutputter( new CppUnit::CompilerOutputter( &runner.result(),
                                                         std::cout ) );

    // Change the default outputter to a xml error format outputter
    // uncomment the following line if you need a xml outputter.
    //runner.setOutputter( new CppUnit::XmlOutputter( &runner.result(),
    //                                                    std::cout ) );

    cool::ProgressListener progressListener;
    runner.eventManager().addListener( &progressListener );

    //CppUnit::TestResultCollector *collector =
    //  new CppUnit::TestResultCollector();
    //runner.eventManager().addListener(collector);

    bool wasSuccessful = false;

    try
    {
      wasSuccessful = runner.run( testPath, false, true, false );
    }

    // Test path not resolved
    catch ( std::invalid_argument &e )
    {
      std::cout << std::endl << "ERROR: " << e.what() << std::endl;
      return 0;
    }

    // Should never happen?
    catch ( std::exception& e )
    {
      std::cout << std::endl
                << "UNEXPECTED STD EXCEPTION CAUGHT in CoolUnitTest: "
                << e.what() << std::endl;
      return 0;
    }

    // Should never happen?
    catch ( ... )
    {
      std::cout << std::endl
                << "UNKNOWN EXCEPTION CAUGHT in CoolUnitTest" << std::endl;
      return 0;
    }

    // Print out the total elapsed time
    if ( _COOLUNITTEST_TIMER_ )
    {
      std::cout << "TOTAL real time (setUp): "
                << s_totalSecondsRealSetUp << "s" << std::endl;
      std::cout << "TOTAL real time (runTest): "
                << s_totalSecondsRealRunTest << "s" << std::endl;
      std::cout << "TOTAL real time (tearDown): "
                << s_totalSecondsRealTearDown << "s" << std::endl;
    }

    // Return error code 1 if the one of tests failed.
    // Print a message on standard error if something failed (for QMTest)
    if ( ! wasSuccessful ) std::cerr << "Error: CppUnit Failures" << std::endl;
    int retcode = wasSuccessful ? 0 : 1;
    // Uncomment the next line if you want to integrate CppUnit with Oval
    std::cout << "[OVAL] Cppunit-result =" << retcode << std::endl;
    //std::cout << "--- cool::CoolUnitTest::Main... DONE" << std::endl;
    return retcode;

  }

  void CoolUnitTest::setUp()
  {
    SimpleTimer timer;
    coolUnitTest_setUp();
    double elapsedSecondsReal = timer.elapsedSecondsReal();
    s_totalSecondsRealSetUp += elapsedSecondsReal;
    if ( _COOLUNITTEST_TIMER_ )
      std::cout << " : " << elapsedSecondsReal << "s";
  }

  void CoolUnitTest::tearDown()
  {
    SimpleTimer timer;
    coolUnitTest_tearDown();
    double elapsedSecondsReal = timer.elapsedSecondsReal();
    s_totalSecondsRealTearDown += elapsedSecondsReal;
    if ( _COOLUNITTEST_TIMER_ )
      std::cout << " + " << elapsedSecondsReal << "s";
  }

  //---------------------------------------------------------------------------

}

#define COOLTEST_MAIN(CLASS) int main( int argc, char* argv[] ) \
  { return cool::CLASS::Main( argc, argv ); }

#endif // COMMON_COOLUNITTEST_H
