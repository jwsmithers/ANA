// $Id: test_propertyManager.cpp,v 1.3 2013-04-22 08:01:41 avalassi Exp $

// First of all, enable or disable the CORAL240 API extensions (bug #89707)
#include "CoralBase/VersionInfo.h"

// Include files
#ifndef CORAL300CPP11
#include "CoralBase/boost_bind_headers.h"
#endif
#include "CoralBase/../tests/Common/CoralCppUnitTest.h"
#include "CoralKernel/Context.h"
#include "CoralKernel/IPropertyManager.h"
#include "CoralKernel/Property.h"

// Forward declaration (for easier indentation)
namespace coral
{
  class PropertyManagerTest;
}

// Test for property manager
// Author: Zsolt Molnar
class coral::PropertyManagerTest : public coral::CoralCppUnitTest
{

  CPPUNIT_TEST_SUITE( PropertyManagerTest );
  CPPUNIT_TEST( testDefaults );
  CPPUNIT_TEST( testPropertySetting );
  CPPUNIT_TEST( testMissingPropertySetting );
  CPPUNIT_TEST( testCallback );
  CPPUNIT_TEST_SUITE_END();

protected:

  //--------------------------------------------------------------------------

  void testDefaults()
  {
    coral::IProperty* p1 = pm->property("AuthenticationFile");
    CPPUNIT_ASSERT(p1);
    CPPUNIT_ASSERT_EQUAL(std::string("authentication.xml"), p1->get());
    p1 = pm->property("DBLookupFile");
    CPPUNIT_ASSERT(p1);
    CPPUNIT_ASSERT_EQUAL(std::string("dblookup.xml"), p1->get());
    // For the rest, check only the existence of the properties
    CPPUNIT_ASSERT(pm->property("Server_Hostname"));
    CPPUNIT_ASSERT(pm->property("Server_Port"));
  }

  //--------------------------------------------------------------------------

  void testPropertySetting()
  {
    coral::IProperty* p1 = pm->property("AuthenticationFile");
    CPPUNIT_ASSERT(p1);
    CPPUNIT_ASSERT(p1->set("newValue"));
    CPPUNIT_ASSERT_EQUAL(std::string("newValue"), p1->get());
    // New search
    coral::IProperty* p2 = pm->property("AuthenticationFile");
    CPPUNIT_ASSERT(p2);
    CPPUNIT_ASSERT_EQUAL(std::string("newValue"), p2->get());
  }

  //--------------------------------------------------------------------------

  void testMissingPropertySetting()
  {
    coral::IProperty* p1 = pm->property("SurelyMissingProperty");
    CPPUNIT_ASSERT(!p1);
  }

  //--------------------------------------------------------------------------

  void testCallback()
  {
    coral::Property* p1 =
      dynamic_cast<coral::Property*>(pm->property("AuthenticationFile"));
    CPPUNIT_ASSERT(p1);
    coral::Property::CallbackID cid1 = -1, cid2 = -1;
    TestCallback obj1, obj2;
#ifdef CORAL300CPP11
    // See http://www.cplusplus.com/reference/functional/bind/
    // NB: Do not forget std::placeholders (else _1 is taken as boost::arg<1>!)
    std::function<void(const std::string&)> cb1(std::bind(&TestCallback::set,&obj1,std::placeholders::_1));
    std::function<void(const std::string&)> cb2(std::bind(&TestCallback::set,&obj2,std::placeholders::_1));
#else
    boost::function1<void, std::string> cb1(boost::bind(&TestCallback::set,
                                                        &obj1, _1));
    boost::function1<void, std::string> cb2(boost::bind(&TestCallback::set,
                                                        &obj2, _1));
#endif
    cid1 = p1->registerCallback(cb1);
    CPPUNIT_ASSERT_EQUAL((coral::Property::CallbackID) 0, cid1);
    cid2 = p1->registerCallback(cb2);
    CPPUNIT_ASSERT_EQUAL((coral::Property::CallbackID) 1, cid2);
    CPPUNIT_ASSERT(p1->set("newValue"));
    CPPUNIT_ASSERT_EQUAL_MESSAGE("obj1.val==newValue", std::string("newValue"), obj1.val);
    CPPUNIT_ASSERT_EQUAL_MESSAGE("obj2.val==newValue", std::string("newValue"), obj2.val);
    CPPUNIT_ASSERT(p1->unregisterCallback(cid1));
    CPPUNIT_ASSERT(p1->set("newValue2"));
    CPPUNIT_ASSERT_EQUAL_MESSAGE("obj1.val==newValue again", std::string("newValue"), obj1.val);
    CPPUNIT_ASSERT_EQUAL_MESSAGE("obj2.val==newValue2", std::string("newValue2"), obj2.val);
    CPPUNIT_ASSERT(!p1->unregisterCallback(cid1));
    CPPUNIT_ASSERT(p1->unregisterCallback(cid2));
    CPPUNIT_ASSERT(p1->set("newValue2"));
    CPPUNIT_ASSERT_EQUAL_MESSAGE("obj1.val==newValue again2", std::string("newValue"), obj1.val);
    CPPUNIT_ASSERT_EQUAL_MESSAGE("obj2.val==newValue2 again", std::string("newValue2"), obj2.val);
  }

  //--------------------------------------------------------------------------

private:

  coral::IPropertyManager* pm;

  struct TestCallback
  {
    void set( const std::string& v ) { val=v; }
    std::string val;
  };

public:

  void setUp()
  {
#ifdef CORAL240PM
    pm = &coral::Context::instance().propertyManager();
#else
    pm = &coral::Context::instance().PropertyManager();
#endif
  }

  void tearDown()
  {
  }

};

CPPUNIT_TEST_SUITE_REGISTRATION( coral::PropertyManagerTest );

CORALCPPUNITTEST_MAIN( PropertyManagerTest )
