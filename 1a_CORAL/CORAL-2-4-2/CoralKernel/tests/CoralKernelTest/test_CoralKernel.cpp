// First of all, enable or disable the CORAL240 API extensions (bug #89707)
#include "CoralBase/VersionInfo.h"

// Include files
#include <iostream>
#include "CoralBase/../tests/Common/CoralCppUnitTest.h"
#include "CoralBase/Date.h"
#include "CoralBase/Exception.h"
#include "CoralKernel/IHandle.h"

// Forward declaration (for easier indentation)
namespace coral
{
  class CoralKernelTest;
}

// Test for CoralKernel
class coral::CoralKernelTest : public coral::CoralCppUnitTest
{

  CPPUNIT_TEST_SUITE( CoralKernelTest );
  CPPUNIT_TEST( test_IHandle_noRefCounted );
  CPPUNIT_TEST( test_IHandle_RefCounted );
  CPPUNIT_TEST_SUITE_END();

public:

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  CoralKernelTest() : CoralCppUnitTest()
  {
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void
  setUp()
  {
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void
  tearDown()
  {
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  class Test1
  {
  public:
    Test1() {}
    virtual ~Test1() {}
    virtual void test1() // A virtual method is needed else the build fails!
    {
      std::cout << "I am a Test1: this is test1!" << std::endl;
    }
  };

  class Test2 : public Test1
  {
  public:
    Test2() {}
    virtual ~Test2() {}
    void test1()
    {
      std::cout << "I am a Test2 hence a Test1: this is test1!" << std::endl;
    }
  };

  class Test3 : public RefCounted
  {
  public:
    Test3() {}
    virtual ~Test3() {}
    virtual void test3() // A virtual method is needed else the build fails!
    {
      std::cout << "I am a Test3: this is test3!" << std::endl;
    }
  };

  class Test4 : public Test3
  {
  public:
    Test4() {}
    virtual ~Test4() {}
    void test3()
    {
      std::cout << "I am a Test4 hence a Test3: this is test3!" << std::endl;
    }
  };

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void
  test_IHandle_noRefCounted()
  {
    // Setup
    std::cout << std::endl;
    IHandle<Test2> ht2; // succeeds (wrapped object is 0)
    std::cout << "IHandleT2.get " << ht2.get() << std::endl;
    Test2* t2 = new Test2();
    std::cout << "Test2* " << t2 << std::endl;

    // Test possible alternatives to dynamic cast...
    t2->test1();
    std::cout << "Executed test1 (as Test2)" << std::endl;
    Test1* t21 = t2;
    std::cout << "Test2* as Test1* " << t21 << std::endl;
    t21->test1();
    std::cout << "Executed test1 (as Test1)" << std::endl;
    //Test3* t23 = t2; // build error (cannot convert T2* to T3* in initializ.)
    //RefCounted* t2rc = t2; // build error (use it to avoid dynamic cast?)
    Test3* t23 = (Test3*)t2; // builds but converts to rubbish
    std::cout << "Test2* as Test3* " << t23 << std::endl;
    //t23->test3(); // crash in old and new versions
    //std::cout << "Executed test3?!" << std::endl;

    // Test dereference -> and * for null object
#ifdef CORAL240CO
    CPPUNIT_ASSERT_THROW( ht2->test1(), coral::Exception ); // crash in 2.3.23
#endif
    try
    {
      Test2& t2r = *ht2; // reference to null in 2.3.23!
      std::cout << "&(IHandleT2*) " << &t2r << std::endl;
#ifdef CORAL240CO
      CPPUNIT_FAIL( "Dereferencing null should fail" ); // pass in 2.3.23
#else
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "&(IHandleT2*)" , (Test2*)0, &t2r );
      //t2r.test1(); // crash in 2.3.23
#endif
    }
    catch( coral::Exception& ) {}

    // Test copy ctor from null no-RefCounted
    IHandle<Test2> ht2c( ht2 );
    std::cout << "IHandleT2c.get " << ht2c.get() << std::endl;

    // Test ctor from no-RefCounted
    try
    {
      IHandle<Test2> ht2b( t2 ); // does not steal a reference (not RefCounted)
      std::cout << "IHandleT2b.get " << ht2b.get() << std::endl;
#ifdef CORAL240CO
      CPPUNIT_FAIL( "Copy no-RefCounted should fail" ); // pass in 2.3.23
#endif
    }
    catch( coral::Exception& ) {}

    // Test assignment from no-RefCounted
    try
    {
      ht2 = t2;
      std::cout << "IHandleT2.get " << ht2.get() << std::endl;
#ifdef CORAL240CO
      CPPUNIT_FAIL( "Assign no-RefCounted should fail" ); // pass in 2.3.23
#endif
    }
    catch( coral::Exception& ) {}

    // Test copy ctor from null no-RefCounted again
    IHandle<Test2> ht2d( ht2 );
    std::cout << "IHandleT2d.get " << ht2d.get() << std::endl;

    // Cleanup
    ht2 = 0;
    std::cout << "IHandleT2 was reset: " << ht2.get() << std::endl;
    ht2c = 0;
    std::cout << "IHandleT2c was reset: " << ht2c.get() << std::endl;
    ht2d = 0;
    std::cout << "IHandleT2d was reset: " << ht2d.get() << std::endl;
    delete t2; // t2 is not deleted on any IHandle exit
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  void
  test_IHandle_RefCounted()
  {
    // Setup
    std::cout << std::endl;
    IHandle<Test4> ht4; // succeeds (wrapped object is 0)
    std::cout << "IHandleT4.get " << ht4.get() << std::endl;
    Test4* t4 = new Test4(); // Ref=1
    std::cout << "Test4* " << t4 << std::endl;

    // Test possible alternatives to dynamic cast...
    t4->test3();
    std::cout << "Executed test3 (as Test4)" << std::endl;
    Test3* t43 = t4;
    std::cout << "Test4* as Test3* " << t43 << std::endl;
    t43->test3();
    std::cout << "Executed test3 (as Test3)" << std::endl;
    RefCounted* t4rc = t4;
    std::cout << "Test4* as RefCounted* " << t4rc << std::endl;
    //Test1* t41 = t4; // build error (cannot convert T4* to T1* in initializ.)
    Test1* t41 = (Test1*)t4; // builds but converts to rubbish
    std::cout << "Test4* as Test1* " << t41 << std::endl;
    //t41->test1(); // does not crash in old and new versions?! does nothing
    //std::cout << "Executed test1?!" << std::endl;

    // Test dereference -> and * for null object
#ifdef CORAL240CO
    CPPUNIT_ASSERT_THROW( ht4->test3(), coral::Exception ); // crash in 2.3.23
#endif
    try
    {
      Test4& t4r = *ht4;
      std::cout << "&(IHandleT4*) " << &t4r << std::endl;
#ifdef CORAL240CO
      CPPUNIT_FAIL( "Dereferencing null should fail" ); // pass in 2.3.23
#else
      CPPUNIT_ASSERT_EQUAL_MESSAGE( "&(IHandleT4*)" , (Test4*)0, &t4r );
      //t4r.test3(); // crash in 2.3.23
#endif
    }
    catch( coral::Exception& ) {}

    // Test copy ctor from null no-RefCounted
    IHandle<Test4> ht4c( ht4 ); // Nothing to Ref...
    std::cout << "IHandleT4c.get " << ht4c.get() << std::endl;

    // Test ctor from RefCounted
    IHandle<Test4> ht4b( t4 ); // Ref=1 again (STOLE reference!)
    std::cout << "IHandleT4b.get " << ht4b.get() << std::endl;

    // Test assignment from no-RefCounted
    ht4 = t4; // Ref=1 again (STOLE reference!)
    ht4->addReference(); // Ref=2 (avoid double delete or boost locks...)
    std::cout << "IHandleT4.get " << ht4.get() << std::endl;

    // Test copy ctor from non-null no-RefCounted
    IHandle<Test4> ht4d( ht4 ); // Ref=3
    std::cout << "IHandleT4d.get " << ht4d.get() << std::endl;

    // Cleanup
#ifdef CORAL240CO
    ht4 = 0; // Ref=2
    std::cout << "IHandleT4 was reset: " << ht4.get() << std::endl;
    ht4b = 0; // Ref=1
    std::cout << "IHandleT4b was reset: " << ht4b.get() << std::endl;
    ht4c = 0; // Nothing to Ref...
    std::cout << "IHandleT4c was reset: " << ht4c.get() << std::endl;
    ht4d = 0; // Ref=0 -> will delete
    std::cout << "IHandleT4d was reset: " << ht4d.get() << std::endl;
#else
    IHandle<Test4> null4;
    ht4 = null4; // Ref=2
    std::cout << "IHandleT4 was reset: " << ht4.get() << std::endl;
    ht4b = null4; // Ref=1
    std::cout << "IHandleT4b was reset: " << ht4b.get() << std::endl;
    ht4c = null4; // Nothing to Ref...
    std::cout << "IHandleT4c was reset: " << ht4c.get() << std::endl;
    ht4d = null4; // Ref=0 -> will delete
    std::cout << "IHandleT4d was reset: " << ht4d.get() << std::endl;
#endif
    //delete t4; // do not double delete: will be deleted on IHandle exit
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

};

CPPUNIT_TEST_SUITE_REGISTRATION( coral::CoralKernelTest );

CORALCPPUNITTEST_MAIN( CoralKernelTest )
