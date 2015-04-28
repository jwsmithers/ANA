
// Include files
#include "RelationalAccess/ISchema.h"

// Local include files
//#define COOLUNITTESTTIMER 1
//#define COOLDBUNITTESTDEBUG 1
#include "tests/Common/CoolDBUnitTest.h"
#include "src/RalDatabase.h"
#include "src/RelationalQueryMgr.h"
#include "src/RelationalSequence.h"
#include "src/RelationalSequenceMgr.h"
#include "src/RelationalTransaction.h"

// Forward declaration (for easier indentation)
namespace cool
{
  class RalSequenceTest;
}

// The test class
class cool::RalSequenceTest : public cool::CoolDBUnitTest
{

private:

  CPPUNIT_TEST_SUITE( RalSequenceTest );
  CPPUNIT_TEST( test_createSequence );
  CPPUNIT_TEST( test_nextVal );
  CPPUNIT_TEST( test_currVal );
  CPPUNIT_TEST_SUITE_END();

public:

  void test_currVal()
  {
    try {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      boost::shared_ptr<RelationalSequence>
        seq( ralDb->queryMgr().sequenceMgr().createSequence
             ( std::string( s_coolDBName + "_SEQ" ) ) );
      unsigned long id = seq->nextVal();
      CPPUNIT_ASSERT_EQUAL( 0ul, id );
      id = seq->currVal();
      CPPUNIT_ASSERT_EQUAL( 0ul, id );
      transaction.commit();
    } catch ( std::exception& e ) {
      std::cout << e.what() << std::endl;
      throw;
    }
  }

  void test_nextVal()
  {
    try {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      boost::shared_ptr<RelationalSequence>
        seq( ralDb->queryMgr().sequenceMgr().createSequence
             ( std::string( s_coolDBName + "_SEQ" ) ) );
      unsigned long id = seq->nextVal();
      CPPUNIT_ASSERT_EQUAL( 0ul, id );
      id = seq->nextVal();
      CPPUNIT_ASSERT_EQUAL( 1ul, id );
      id = seq->nextVal();
      CPPUNIT_ASSERT_EQUAL( 2ul, id );
      transaction.commit();
    } catch ( std::exception& e ) {
      std::cout << e.what() << std::endl;
      throw;
    }
  }

  void test_createSequence()
  {
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      ralDb->queryMgr().sequenceMgr().createSequence
        ( std::string( s_coolDBName + "_SEQ" ) );
      transaction.commit();
    }
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      CPPUNIT_ASSERT( ralDb->session().nominalSchema().existsTable
                      ( std::string( s_coolDBName + "_SEQ" ) ) );
      transaction.commit();
    }
  }

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  // Constructor (executed N times, _before_ all N test executions)
  RalSequenceTest()
    : cool::CoolDBUnitTest( false ) // do not load dbSvc (not needed)
    , ralDb( 0 ) // Fix Coverity UNINIT_CTOR
  {
  }

  // Destructor (executed N times, _after_ all N test executions)
  ~RalSequenceTest()
  {
  }

private:

  RalDatabase* ralDb;

  // Setup (executed N times, at the start of each test execution)
  void coolUnitTest_setUp()
  {
    try
    {
      ralDb = new RalDatabase( ppConnectionSvc(), s_connectionString, false );
    }
    catch ( std::exception& e )
    {
      ralDb = 0;
      std::cout << "Exception caught: " << e.what() << std::endl;
      throw;
    }
  }

  // TearDown (executed N times, at the end of each test execution)
  void coolUnitTest_tearDown()
  {
    if ( ralDb )
    {
      RelationalTransaction transaction( ralDb->transactionMgr() );
      ralDb->session().nominalSchema().dropIfExistsTable
        ( std::string( s_coolDBName + "_SEQ" ) );
      transaction.commit();
      delete ralDb;
      ralDb = 0;
    }
  }

};

CPPUNIT_TEST_SUITE_REGISTRATION( cool::RalSequenceTest );

COOLTEST_MAIN( RalSequenceTest )
