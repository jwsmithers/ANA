// First of all, enable or disable the CORAL240 API extensions (bug #89707)
#include "CoralBase/VersionInfo.h"

// Include files
#include <cstdlib>
#include <limits>
#include <map>
#include <sstream>
#include <stdexcept>
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"
#include "CoralBase/TimeStamp.h"
#include "CoralBase/../src/isNaN.h"
#include "CoralBase/../tests/Common/CoralCppUnitDBTest.h"
#include "CoralCommon/Utilities.h"
#include "CoralKernel/Context.h"
#include "CoralKernel/RefCounted.h"
#include "RelationalAccess/ConnectionService.h"
#include "RelationalAccess/IConnectionService.h"
#include "RelationalAccess/IDatabaseServiceDescription.h"
#include "RelationalAccess/IDatabaseServiceSet.h"
#include "RelationalAccess/ICursor.h"
#include "RelationalAccess/ILookupService.h"
#include "RelationalAccess/IQuery.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ISessionProxy.h"
#include "RelationalAccess/ITable.h"
#include "RelationalAccess/ITableDataEditor.h"
#include "RelationalAccess/ITablePrivilegeManager.h"
#include "RelationalAccess/ITransaction.h"
#include "RelationalAccess/ITypeConverter.h"
#include "RelationalAccess/IWebCacheControl.h"
#include "RelationalAccess/TableDescription.h"

// Local (COOL) include files
#include "types.h"
#include "StorageType.h"

// Workaround for CORAL bug #43972 (ORA-24801 while filling LOB locator)
#define NOBLOB 1

// Skip NaNs on MySQL?
#define skipNanMySQL true

// Put a fresh key into queries for the sake of frontier caching?
// Not needed because using frontier forcereload, but having a unique
// key is more efficient if there are a significant number of jobs
// reading same fresh data using the same key.
#undef USE_FRESHKEY
//#define USE_FRESHKEY 1

// Using "Desc" fails with old OracleAccess (eg CORAL 2.3.20b), lowercase?
// Using "DESC" also fails with old OracleAccess, reserved keyword conflict?
// Using "DESCR" should work everywhere as a temporary workaround
#define DESCFLD "Desc"
//#define DESCFLD "DESCR"

//-----------------------------------------------------------------------------

using namespace cool;

namespace coral
{

  // Type definition (simpler replacement of cool::FieldSpecification class)
  typedef std::pair<std::string, cool::StorageType::TypeId> FieldSpecification;

  // Type definition (simpler replacement of cool::RecordSpecification class)
  typedef std::vector<FieldSpecification> RecordSpecification;

  /** @class CoralReferenceDBTest
   *
   *  Comprehensive test for CORAL storage and retrieval of several
   *  distinct values of all persistent data types supported by COOL.
   *
   *  @author Andrea Valassi
   *  @date   2007-02-15
   *///

  class CoralReferenceDBTest : public CoralCppUnitDBTest
  {

    CPPUNIT_TEST_SUITE( CoralReferenceDBTest );
    CPPUNIT_TEST( test_oneBackend );
    CPPUNIT_TEST( test_oneBackendBindVar );
    CPPUNIT_TEST_SUITE_END();

  private:

    static bool& optDoFill()
    {
      static bool s_optDoFill = true;
      return s_optDoFill;
    }

    static unsigned& optNReads()
    {
      static unsigned s_optNReads = 1;
      return s_optNReads;
    }

    static bool skipNaN()
    {
      return skipNanMySQL
        && UrlRW() == BuildUrl( "MySQL", false );
    }

  public:

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    // Here you may redefine the static method from CoralCppUnitDBTest
    static bool ParseArguments( int argc, char** argv )
    {
      if ( argc == 1 || argc > 4 ||
           !ValidateBackends( argv[1] ) ||
           ( argc == 3 && std::string( argv[2] ) == "-h"  ) || // --help
           ( argc == 4 && std::string( argv[3] ) == "-h"  ) ) // --help
      {
        std::cout << "Usage : " << argv[0]
                  << " writer[:reader]"
                  << " [-h]" << std::endl;
        std::cout << "Usage : " << argv[0]
                  << " writer[:reader]"
                  << " [CppUnit_subtest_path [nReads] ]" << std::endl;
        std::cout << "Allowed values for writer[:reader] : " << std::endl
                  << "  oracle[:oracle]" << std::endl
                  << "  oracle:frontier" << std::endl
                  << "  oracle:coral" << std::endl
                  << "  oracle:proxy" << std::endl
                  << "  mysql[:mysql]" << std::endl
                  << "  mysql:coral" << std::endl
                  << "  sqlite[:sqlite]" << std::endl;
        return false;
      }
      if ( argc >= 3 )
      {
        TestPath() = argv[2];
      }
      if ( argc >= 4 )
      {
        optNReads() = atoi( argv[3] );
        optDoFill() = false;
      }
      return true;
    }

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    static void insertColumn( coral::TableDescription& desc,
                              const std::string& name,
                              const cool::StorageType::TypeId& typeId )
    {
      const cool::StorageType& type = cool::StorageType::storageType( typeId );
      const std::string typeName =
        coral::AttributeSpecification::typeNameForId( type.cppType() );
      int maxSize = type.maxSize();
      const bool fixedSize = false;
      // Workaround for CORAL bug #22543 - START
      // Bug is MySQL: BLOB(nnnnn) used instead of BLOB (and/or MEDIUMBLOB...)
      // Quick workaround applies to all but should not harm
      if ( type == StorageType::Blob64k ) maxSize=0;
      // Workaround for CORAL bug #22543 - END
      desc.insertColumn( name, typeName, maxSize, fixedSize );
    }

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    static void formatAttributeList( coral::AttributeList& data,
                                     const RecordSpecification& spec )
    {
      for ( RecordSpecification::const_iterator
              it = spec.begin(); it != spec.end(); it++ )
      {
        data.extend( it->first,
                     StorageType::storageType(it->second).cppType() );
      }
    }

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    static void formatBindVariables( coral::AttributeList& bvarAL,
                                     const RecordSpecification& spec,
                                     const std::string& fldName,
                                     const std::string& bvarName )
    {
      for ( RecordSpecification::const_iterator
              it = spec.begin(); it != spec.end(); it++ )
      {
        if ( fldName == it->first )
          bvarAL.extend( bvarName,
                         StorageType::storageType(it->second).cppType() );
      }
    }

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    static const RecordSpecification& referenceRecordSpec()
    {
      static RecordSpecification spec;
      if ( spec.size() == 0 )
      {
        // Payload metadata - unique ID and unique description
        spec.push_back( FieldSpecification
                        ( "ID", cool::StorageType::Int32 ) );
        spec.push_back( FieldSpecification
                        ( DESCFLD, cool::StorageType::String255 ) );
        // Payload data
        spec.push_back( FieldSpecification
                        ( "A_BOOL", cool::StorageType::Bool ) );
        spec.push_back( FieldSpecification
                        ( "A_UCHAR", cool::StorageType::UChar ) );
        spec.push_back( FieldSpecification
                        ( "A_INT16", cool::StorageType::Int16 ) );
        spec.push_back( FieldSpecification
                        ( "A_UINT16", cool::StorageType::UInt16 ) );
        spec.push_back( FieldSpecification
                        ( "A_INT32", cool::StorageType::Int32 ) );
        spec.push_back( FieldSpecification
                        ( "A_UINT32", cool::StorageType::UInt32 ) );
        spec.push_back( FieldSpecification
                        ( "A_UINT63", cool::StorageType::UInt63 ) );
        spec.push_back( FieldSpecification
                        ( "A_INT64", cool::StorageType::Int64 ) );
        spec.push_back( FieldSpecification
                        ( "A_FLOAT", cool::StorageType::Float ) );
        spec.push_back( FieldSpecification
                        ( "A_DOUBLE", cool::StorageType::Double ) );
        spec.push_back( FieldSpecification
                        ( "A_STRING255", cool::StorageType::String255 ) );
        spec.push_back( FieldSpecification
                        ( "A_STRING4K", cool::StorageType::String4k ) );
        spec.push_back( FieldSpecification
                        ( "A_STRING64K", cool::StorageType::String64k ) );
        spec.push_back( FieldSpecification
                        ( "A_STRING16M", cool::StorageType::String16M ) );
#ifndef NOBLOB
        spec.push_back( FieldSpecification
                        ( "A_BLOB64K", cool::StorageType::Blob64k ) );
        spec.push_back( FieldSpecification
                        ( "A_BLOB16M", cool::StorageType::Blob16M ) );
#endif
        spec.push_back( FieldSpecification
                        ( "RANDOM_STRING255", cool::StorageType::String255 ) );
      }
      return spec;
    }

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    static const coral::TableDescription& referenceTableDescription()
    {
      static coral::TableDescription desc;
      if ( desc.name() == "" )
      {
        desc.setName( BuildUniqueTableName( "CORALREF_COOL" ) );
        // Insert all fields from the reference record specification
        const RecordSpecification& spec = referenceRecordSpec();
        for ( RecordSpecification::const_iterator
                it = spec.begin(); it != spec.end(); it++ )
          insertColumn( desc, it->first, it->second );
        // Payload metadata - unique ID and unique description
        desc.setPrimaryKey( "ID" );
        desc.setUniqueConstraint( DESCFLD );
      }
      return desc;
    }

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    static const coral::AttributeList& referenceData( int index, const std::string& randomString = "RANDOM" )
    {
      static std::map<int,coral::AttributeList> dataMap_withNaN;
      static std::map<int,coral::AttributeList> dataMap_skipNaN;
      std::map<int,coral::AttributeList>& dataMap = dataMap_withNaN;
      if ( skipNaN() ) dataMap = dataMap_skipNaN;
      if ( dataMap.find( index ) == dataMap.end() )
      {
        // ******************************************************
        // *** Index = -4       *** NaN float/double value    ***
        // *** Index = -3       *** null value                ***
        // *** Index = -2       *** min value                 ***
        // *** Index = -1       *** max value                 ***
        // *** Index in [0,255] *** test all characters/bytes ***
        // ******************************************************
        if ( ( index>=-4 && index<=255) )
        {
          dataMap[index] = coral::AttributeList();
          coral::AttributeList& data = dataMap[index];
          const RecordSpecification& spec = referenceRecordSpec();
          formatAttributeList( data, spec );
          data["ID"].setNull( false );
          data["ID"].setValue( (cool::Int32)index );
          data[DESCFLD].setNull( false );
          data["A_BOOL"].setNull( false );
          data["A_UCHAR"].setNull( false );
          data["A_INT16"].setNull( false );
          data["A_UINT16"].setNull( false );
          data["A_INT32"].setNull( false );
          data["A_UINT32"].setNull( false );
          data["A_UINT63"].setNull( false );
          data["A_INT64"].setNull( false );
          data["A_FLOAT"].setNull( false );
          data["A_DOUBLE"].setNull( false );
          data["A_STRING255"].setNull( false );
          data["A_STRING4K"].setNull( false );
          data["A_STRING64K"].setNull( false );
          data["A_STRING16M"].setNull( false );
#ifndef NOBLOB
          data["A_BLOB64K"].setNull( false );
          data["A_BLOB16M"].setNull( false );
#endif
          data["RANDOM_STRING255"].setNull( false );
          data["RANDOM_STRING255"].setValue( randomString );
          // ******************************************************
          // *** Index = -4       *** NaN float/double value    ***
          // ******************************************************
          if ( index == -4 )
          {
            data[DESCFLD].setValue( std::string("NaN float/double") );
            data["A_BOOL"].setValue( false );
            data["A_UCHAR"].setValue( (unsigned char)'\0' );
            data["A_INT16"].setValue( (cool::Int16)0 );
            data["A_UINT16"].setValue( (cool::UInt16)0 );
            data["A_INT32"].setValue( (cool::Int32)0 );
            data["A_UINT32"].setValue( (cool::UInt32)0 );
            data["A_UINT63"].setValue( (cool::UInt63)0 );
            data["A_INT64"].setValue( (cool::Int64)0 );
            if ( !skipNaN() )
            {
              data["A_FLOAT"].setValue( std::numeric_limits<float>::quiet_NaN() );
              data["A_DOUBLE"].setValue( std::numeric_limits<double>::quiet_NaN() );
            }
            else
            {
              data["A_FLOAT"].setValue( (cool::Float)0 );
              data["A_DOUBLE"].setValue( (cool::Double)0 );
            }
            data["A_STRING255"].setValue( std::string("DUMMY") );
            data["A_STRING4K"].setValue( std::string("DUMMY") );
            data["A_STRING64K"].setValue( std::string("DUMMY") );
            data["A_STRING16M"].setValue( std::string("DUMMY") );
#ifndef NOBLOB
            data["A_BLOB64K"].data<coral::Blob>().resize(0);
            data["A_BLOB16M"].data<coral::Blob>().resize(0);
#endif
          }
          // ******************************************************
          // *** Index = -3       *** null value                ***
          // ******************************************************
          else if ( index == -3 )
          {
            data[DESCFLD].setValue( std::string("NULL values") );
            data["A_BOOL"].setNull( true );
            data["A_UCHAR"].setNull( true );
            data["A_INT16"].setNull( true );
            data["A_UINT16"].setNull( true );
            data["A_INT32"].setNull( true );
            data["A_UINT32"].setNull( true );
            data["A_UINT63"].setNull( true );
            data["A_INT64"].setNull( true );
            data["A_FLOAT"].setNull( true );
            data["A_DOUBLE"].setNull( true );
            data["A_STRING255"].setNull( true );
            data["A_STRING4K"].setNull( true );
            data["A_STRING64K"].setNull( true );
            data["A_STRING16M"].setNull( true );
#ifndef NOBLOB
            data["A_BLOB64K"].setNull( true );
            data["A_BLOB16M"].setNull( true );
#endif
          }
          // ******************************************************
          // *** Index = -2       *** min value                 ***
          // ******************************************************
          else if ( index == -2 )
          {
            data[DESCFLD].setValue( std::string("min values") );
            data["A_BOOL"].setValue( false );
            data["A_UCHAR"].setValue( cool::UCharMin );
            data["A_INT16"].setValue( cool::Int16Min );
            data["A_UINT16"].setValue( cool::UInt16Min );
            data["A_INT32"].setValue( cool::Int32Min );
            data["A_UINT32"].setValue( cool::UInt32Min );
            data["A_UINT63"].setValue( cool::UInt63Min );
            data["A_INT64"].setValue( cool::Int64Min );
            data["A_FLOAT"].setValue( (cool::Float)(0.123456789012345678901234567890) );
            data["A_DOUBLE"].setValue( (cool::Double)(0.123456789012345678901234567890) );
            data["A_STRING255"].setValue( std::string("") );
            data["A_STRING4K"].setValue( std::string("") );
            data["A_STRING64K"].setValue( std::string("") );
            data["A_STRING16M"].setValue( std::string("") );
#ifndef NOBLOB
            data["A_BLOB64K"].data<coral::Blob>().resize(0);
            data["A_BLOB16M"].data<coral::Blob>().resize(0);
#endif
          }
          // ******************************************************
          // *** Index = -1       *** max value                 ***
          // ******************************************************
          else if ( index == -1 )
          {
            data[DESCFLD].setValue( std::string("MAX VALUES") );
            data["A_BOOL"].setValue( true );
            data["A_UCHAR"].setValue( cool::UCharMax );
            data["A_INT16"].setValue( cool::Int16Max );
            data["A_UINT16"].setValue( cool::UInt16Max );
            data["A_INT32"].setValue( cool::Int32Max );
            data["A_UINT32"].setValue( cool::UInt32Max );
            data["A_UINT63"].setValue( cool::UInt63Max );
            data["A_INT64"].setValue( cool::Int64Max );
            data["A_FLOAT"].setValue( (cool::Float)(0.987654321098765432109876543210) );
            data["A_DOUBLE"].setValue( (cool::Double)(0.987654321098765432109876543210) );
            std::string high = "HIGH";
            data["A_STRING255"].setValue( high );
            data["A_STRING4K"].setValue( high );
            data["A_STRING64K"].setValue( high );
            data["A_STRING16M"].setValue( high );
#ifndef NOBLOB
            data["A_BLOB64K"].data<coral::Blob>().resize(0);
            data["A_BLOB16M"].data<coral::Blob>().resize(0);
#endif
          }
          // ******************************************************
          // *** Index in [0,255] *** test all characters/bytes ***
          // ******************************************************
          else
          {
            std::stringstream sIndex;
            sIndex << index;
            data[DESCFLD].setValue( "Value #"+sIndex.str() );
            data["A_BOOL"].setValue( true );
            unsigned char uc = index;
            data["A_UCHAR"].setValue( uc );
            data["A_INT16"].setValue( (cool::Int16)(-index) );
            data["A_UINT16"].setValue( (cool::UInt16)(index) );
            data["A_INT32"].setValue( (cool::Int32)(-index) );
            data["A_UINT32"].setValue( (cool::UInt32)(index) );
            data["A_UINT63"].setValue( (cool::UInt63)(index) );
            data["A_INT64"].setValue( (cool::Int64)(-index) );
            data["A_FLOAT"].setValue( (cool::Float)(-index) );
            data["A_DOUBLE"].setValue( (cool::Double)(index) );
            std::string sUc = std::string( 1, (char)uc );
            data["A_STRING255"].setValue( sUc );
            data["A_STRING4K"].setValue( sUc );
            data["A_STRING64K"].setValue( sUc );
            data["A_STRING16M"].setValue( sUc );
#ifndef NOBLOB
            data["A_BLOB64K"].data<coral::Blob>().resize
              ( sizeof(unsigned char) );
            unsigned char* pUc;
            pUc = static_cast<unsigned char*>
              ( data["A_BLOB64K"].data<coral::Blob>().startingAddress() );
            *pUc = uc;
            data["A_BLOB16M"].data<coral::Blob>().resize
              ( sizeof(unsigned char) );
            pUc = static_cast<unsigned char*>
              ( data["A_BLOB16M"].data<coral::Blob>().startingAddress() );
            *pUc = uc;
#endif
          }
        }
        // Unknown index: throw an exception
        else
        {
          std::stringstream msg;
          msg << "Unknown index value for reference data: " << index;
          throw std::runtime_error( msg.str() );
        }
      }
      return dataMap[index];
    }

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    void fillReferenceData( const std::string& connectString )
    {
      std::cout << std::endl
                << "Create and fill reference table..." << std::endl;
      std::cout << "Reference table: "
                << referenceTableDescription().name() << std::endl;
      coral::IConnectionService& connSvc = connectionService();
      coral::AccessMode accessMode = coral::Update;
      std::auto_ptr<coral::ISessionProxy>
        session( connSvc.connect( connectString, accessMode ) );
      session->transaction().start( false ); // read-write
      // ** START ** write reference data
      const coral::TableDescription& desc = referenceTableDescription();
      session->nominalSchema().dropIfExistsTable( desc.name() );
      coral::ITable& table = session->nominalSchema().createTable( desc );
      for ( int index =-4; index<=255; index++ )
      {
        table.dataEditor().insertRow( referenceData( index ) );
      }
      if ( connectString == BuildUrl( "Oracle", false ) )
      {
        table.privilegeManager().grantToUser
          ( "PUBLIC", coral::ITablePrivilegeManager::Select );
      }
      // **  END  ** write reference data
      session->transaction().commit();
      std::cout << "Create and fill reference table... DONE" << std::endl;
    }

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    template<class T>
    void assertEqualMessage( const std::string& msg,
                             const T& refValue,
                             const T& value )
    {
      CPPUNIT_ASSERT_EQUAL_MESSAGE( msg, refValue, value );
    }

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    template<class T>
    void testPayload( const std::string& sIndex,
                      const std::string& name,
                      const coral::AttributeList& refRow,
                      const coral::AttributeList& row,
                      const bool isNull,
                      const std::string& connectString )
    {
      // Compare nullness
      // Workaround for 'bug #22381' (Oracle feature: it treats '' as NULL)
      if ( ( connectString == BuildUrl( "Oracle", true ) ||
             connectString == BuildUrl( "Frontier", true ) ||
             connectString == BuildUrl( "CoralServer-Oracle", true ) ) &&
           ( sIndex == "Index#-2 " || sIndex == "Index#0 " ) &&
           typeid( T ) == typeid( std::string ) )
      {
        static bool first = true;
        if ( first )
          std::cout << "*** WARNING!! *** Oracle '' == NULL " << std::endl;
        first = false;
        CPPUNIT_ASSERT_EQUAL_MESSAGE( sIndex + name + " isNullOracle''",
                                      true,
                                      row[ name ].isNull() );
      }
      // Compare nullness
      // Workaround for 'bug #72147' (SQLite feature: it stores NaN as NULL)
      else if ( connectString == BuildUrl( "SQLite", true ) &&
                ( sIndex == "Index#-4 " ) &&
                ( typeid( T ) == typeid( float ) ||
                  typeid( T ) == typeid( double ) ) )
      {
        static bool first = true;
        if ( first )
          std::cout << "*** WARNING!! *** SQLite NaN == NULL " << std::endl;
        first = false;
        CPPUNIT_ASSERT_EQUAL_MESSAGE( sIndex + name + " isNullSQLiteNaN",
                                      true,
                                      row[ name ].isNull() );
      }
      // Compare nullness for all other cases
      else
      {
        CPPUNIT_ASSERT_EQUAL_MESSAGE( sIndex + name + " isNull1",
                                      refRow[ name ].isNull(),
                                      row[ name ].isNull() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( sIndex + name + " isNull2",
                                      isNull,
                                      row[ name ].isNull() );
      }
      // Compare values (only if not null)
      if ( !row[ name ].isNull() )
      {
        /*
        std::cout << sIndex << name
                  << " RefValue='" << refRow[ name ].data<T>() << "'"
                  << " Value='" << row[ name ].data<T>() << "'"
                  << std::endl;
        if ( typeid( T ) == typeid( std::string ) )
          std::cout << sIndex << name
                    << " RefSize=" << refRow[ name ].data<std::string>().size()
                    << " Size=" << row[ name ].data<std::string>().size()
                    << std::endl;
        *///
        // WARNING: skip '\0' string for all four backends
        if ( sIndex == "Index#0 " && typeid( T ) == typeid( std::string ) )
        {
          static bool first = true;
          if ( first )
            std::cout << "*** WARNING!! *** Skip test for "
                      << sIndex << name << std::endl;
          first = false;
        }
        else
        {
          assertEqualMessage( sIndex + name + " data",
                              refRow[ name ].data<T>(),
                              row[ name ].data<T>() );
        }
      }
    }

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    std::auto_ptr<coral::ISessionProxy>
    connectForReading( const std::string& connectString )
    {
      std::string connectStringNew = connectString;
      std::cout << "Read from reference table..." << std::endl;
      coral::IConnectionService& connSvc = connectionService();
      coral::AccessMode accessMode = coral::ReadOnly;

      std::string webCacheUrl = ""; // != "" only for Frontier
      if ( connectString == BuildUrl( "Frontier", true ) )
      {
        // For Frontier test:
        // - determine the webCacheUrl to test Time-To-Live settings
        // - modify the connect string to force reloading the caches
        ISessionProxy* session = connSvc.connect( connectString, accessMode );
        delete session; // dummy session to force the loading of ILookupService
        IHandle<ILookupService> lookupSvc = Context::instance().query<ILookupService>();
        if ( lookupSvc.get() == 0 )
          throw std::runtime_error( "ILookupService not found" );
        std::auto_ptr<IDatabaseServiceSet> replicas( lookupSvc->lookup( connectStringNew, accessMode ) );
        if ( replicas->numberOfReplicas() == 0 )
          throw std::runtime_error( "No replicas found for " + connectStringNew + "?" );
        webCacheUrl = replicas->replica( 0 ).connectionString();
        //std::cout << "webCacheUrl=" << webCacheUrl << std::endl;
        if ( webCacheUrl.find("frontier") == std::string::npos )
          throw std::runtime_error( "Replica " + webCacheUrl + " for " + connectStringNew + " is not a frontier or Squid replica?" );
        if ( webCacheUrl.find(":8000/") != std::string::npos )
          throw std::runtime_error( "Replica " + webCacheUrl + " for " + connectStringNew + " is not a Squid cache replica?" );
        // Build the URL required by IWebCacheControl::setTableTimeToLive()
        // - Determine the explicit frontier replica, and then either of:
        // - 1. 'frontier://(serverurl=)()/schema' => '(serverurl=)()'
        // - 2. 'frontier://h:p/servlet/schema' => 'http://h:p/servlet'
        if ( webCacheUrl.rfind("/") == std::string::npos )
          throw std::runtime_error( "Cannot strip schema off " + webCacheUrl );
        // - Strip off the trailing schema
        const std::string schema = webCacheUrl.substr(webCacheUrl.rfind("/"));
        webCacheUrl = webCacheUrl.substr(0,webCacheUrl.rfind("/"));
        //std::cout << "webCacheUrl=" << webCacheUrl << std::endl;
        if ( webCacheUrl.find("frontier://(") == 0 )
        {
          // 1: 'frontier://(serverurl=http://h:p/servlet)()/schema'
          webCacheUrl = webCacheUrl.substr( webCacheUrl.find("(") );
        }
        else
        {
          // 2: 'frontier://host:port/servlet/schema'
          webCacheUrl.replace( webCacheUrl.find("frontier"),
                               webCacheUrl.find("frontier")+8, "http" );
          webCacheUrl = "(serverurl=" + webCacheUrl + ")";
        }
        // See http://frontier.cern.ch/dist/FrontierClientUsage.html
        // don't cache anything inside frontier client
        webCacheUrl += "(clientcachemaxresultsize=0)";
        // don't cache anything at squids
        webCacheUrl += "(forcereload=long)";
        connectStringNew = "frontier://" + webCacheUrl + schema;
        std::cout << "Frontier test: "
                  << "connect to " << connectString
                  << ", connect string " << connectStringNew << std::endl;
      }

#ifdef CORAL300WC
      if (webCacheUrl != "")
      {
        // This is only to test that the API is accepted; the cache
        //  is forced to be reloaded every time anyway so it doesn't
        //  really matter what the Time To Live is.  The difference
        //  can only be seen by setting FRONTIER_LOG_LEVEL=debug and
        //  looking for &ttl=short in the query URLs.
        std::cout << "Setting TTL of " << referenceTableDescription().name()
                  << " to 1 for connection " << webCacheUrl << std::endl;
        connSvc.webCacheControl().setTableTimeToLive( webCacheUrl, referenceTableDescription().name(), 1 );
      }
#endif

      // Connect to the database
      std::auto_ptr<coral::ISessionProxy>
        session( connSvc.connect( connectStringNew, accessMode ) );
      return session;
    }

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    static void prepareQueryForReading( coral::IQuery& query,
                                        coral::AttributeList& dataBuffer,
                                        std::string& freshKey )
    {
#ifdef USE_FRESHKEY
      coral::TimeStamp now;
      std::stringstream fresh;
      fresh << now.toString() << iRead;
      freshKey = fresh.str();
#else
      freshKey = ""; // not strictly necessary
#endif
      unsigned nAttr = dataBuffer.size();
      for ( unsigned int iAttr = 0; iAttr < nAttr-1; ++iAttr )
        query.addToOutputList( dataBuffer[iAttr].specification().name() );
#ifdef USE_FRESHKEY
      std::cout << "freshKey=" << freshKey << std::endl;
      query.addToOutputList( "'"+freshKey+"'", dataBuffer[nAttr-1].specification().name() );
#else
      query.addToOutputList( dataBuffer[nAttr-1].specification().name() );
#endif
      query.addToTableList( referenceTableDescription().name() );
      query.defineOutput( dataBuffer );
    }

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    void readReferenceData( const std::string& connectString )
    {
      // Connect to the database
      std::auto_ptr<coral::ISessionProxy> session( connectForReading( connectString ) );
      session->transaction().start( true ); // read-only

      // Dump the supported C++ and SQL types for this backend
      // (except for CoralAccess where TypeConverter is not yet supported)
      if ( connectString != BuildUrl( "CoralServer-Oracle", true ) )
      {
        std::cout << std::endl << "Supported C++ types: " << std::endl;
        std::set<std::string> cppTypes =
          session->typeConverter().supportedCppTypes();
        for ( std::set<std::string>::const_iterator iType = cppTypes.begin();
              iType != cppTypes.end();
              ++iType )
        {
          std::cout << *iType << " -> "
                    << session->typeConverter().sqlTypeForCppType( *iType )
                    << std::endl;
        }
        std::cout << std::endl << "Supported SQL types: " << std::endl;
        std::set<std::string> sqlTypes =
          session->typeConverter().supportedSqlTypes();
        for ( std::set<std::string>::const_iterator iType = sqlTypes.begin();
              iType != sqlTypes.end();
              ++iType )
        {
          std::cout << *iType << " -> "
                    << session->typeConverter().cppTypeForSqlType( *iType )
                    << std::endl;
        }
        std::cout << std::endl;
      }
      // ** START ** read reference data
      coral::ISchema& schema = session->nominalSchema();
      coral::AttributeList dataBuffer;
      const RecordSpecification& spec = referenceRecordSpec();
      formatAttributeList( dataBuffer, spec );
      for ( unsigned iRead=0; iRead<optNReads(); iRead++ )
      {
        std::string freshKey;
        std::auto_ptr<coral::IQuery> query( schema.newQuery() );
        prepareQueryForReading( *query, dataBuffer, freshKey );
        query->addToOrderList( "ID" );
        coral::ICursor& cursor = query->execute();
        std::vector< coral::AttributeList > rows;
        while ( cursor.next() ) rows.push_back( cursor.currentRow() );
        CPPUNIT_ASSERT_EQUAL_MESSAGE( "# rows", 260, (int)rows.size() );
        std::cout << "Successfully read " << rows.size() << " rows ["
                  << iRead << "/" << optNReads() << "]" << std::endl;
        for ( int iRow = 0; iRow<=259; iRow++ )
        {
          int index = iRow-4; // iRow in [0,259], index in [-4,255]
          std::stringstream ssIndex;
          ssIndex << "Index#" << index << " ";
          std::string sIndex = ssIndex.str();
          const coral::AttributeList row = rows[iRow];
          const coral::AttributeList& refRow = referenceData( index );
          if ( optDoFill() ) // functional test (not the repeated-read test)
          {
            if ( index <= 2 || index >= 253 )
              std::cout << "Read from reference table (" << index << ")"
                        << std::endl;
            else if ( index == 3 )
              std::cout << "Read from reference table (3...252)"
                        << std::endl;
            CPPUNIT_ASSERT_EQUAL_MESSAGE( sIndex+"ID isNull1",
                                          refRow["ID"].isNull(),
                                          row["ID"].isNull() );
            CPPUNIT_ASSERT_EQUAL_MESSAGE( sIndex+"ID isNull2",
                                          false,
                                          row["ID"].isNull() );
            CPPUNIT_ASSERT_EQUAL_MESSAGE( sIndex+"ID data",
                                          refRow["ID"].data<cool::Int32>(),
                                          row["ID"].data<cool::Int32>() );
            CPPUNIT_ASSERT_EQUAL_MESSAGE( sIndex+"Desc isNull1",
                                          refRow[DESCFLD].isNull(),
                                          row[DESCFLD].isNull() );
            CPPUNIT_ASSERT_EQUAL_MESSAGE( sIndex+"Desc isNull2",
                                          false,
                                          row[DESCFLD].isNull() );
            CPPUNIT_ASSERT_EQUAL_MESSAGE( sIndex+"Desc data",
                                          refRow[DESCFLD].data<std::string>(),
                                          row[DESCFLD].data<std::string>() );
            bool isNull = false;
            if ( index == -3 ) isNull = true;
            testPayload<cool::Bool>
              ( sIndex, "A_BOOL", refRow, row, isNull, connectString );
            testPayload<cool::UChar>
              ( sIndex, "A_UCHAR", refRow, row, isNull, connectString );
            testPayload<cool::Int16>
              ( sIndex, "A_INT16", refRow, row, isNull, connectString );
            testPayload<cool::UInt16>
              ( sIndex, "A_UINT16", refRow, row, isNull, connectString );
            testPayload<cool::Int32>
              ( sIndex, "A_INT32", refRow, row, isNull, connectString );
            testPayload<cool::UInt32>
              ( sIndex, "A_UINT32", refRow, row, isNull, connectString );
            //testPayload<cool::UInt63>
            //  ( sIndex, "A_UINT63", refRow, row, isNull, connectString );
            //testPayload<cool::Int64>
            //  ( sIndex, "A_INT64", refRow, row, isNull, connectString );
            testPayload<cool::Float>
              ( sIndex, "A_FLOAT", refRow, row, isNull, connectString );
            testPayload<cool::Double>
              ( sIndex, "A_DOUBLE", refRow, row, isNull, connectString );
            testPayload<cool::String255>
              ( sIndex, "A_STRING255", refRow, row, isNull, connectString );
            testPayload<cool::String4k>
              ( sIndex, "A_STRING4K", refRow, row, isNull,connectString );
            testPayload<cool::String64k>
              ( sIndex, "A_STRING64K", refRow, row, isNull, connectString );
            testPayload<cool::String16M>
              ( sIndex, "A_STRING16M", refRow, row, isNull, connectString );
#ifndef NOBLOB
            // TO DO: BLOB templated method
            //testPayload<cool::Blob64k>
            //  ( sIndex, "A_BLOB64K", refRow, row, isNull );
            //testPayload<cool::Blob16M>
            //  ( sIndex, "A_BLOB16M", refRow, row, isNull );
#endif
          }
          const std::string name = "RANDOM_STRING255";
          assertEqualMessage( sIndex + name + " data",
#ifdef USE_FRESHKEY
                              freshKey,
#else
                              refRow[ name ].data<std::string>(),
#endif
                              row[ name ].data<std::string>() );
        }
      }
      // **  END  ** read reference data
      session->transaction().commit();
      std::cout << "Read from reference table... DONE" << std::endl;
    }

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    void readReferenceDataBindVar( const std::string& connectString )
    {
      // Connect to the database
      std::auto_ptr<coral::ISessionProxy> session( connectForReading( connectString ) );
      session->transaction().start( true ); // read-only
      coral::MsgLevel oldLvl = coral::MessageStream::msgVerbosity();
      try
      {
        // ** START ** read reference data
        coral::ISchema& schema = session->nominalSchema();
        coral::AttributeList dataBuffer;
        const RecordSpecification& spec = referenceRecordSpec();
        formatAttributeList( dataBuffer, spec );
        for ( unsigned iRead=0; iRead<optNReads(); iRead++ )
        {
          for ( unsigned iQvar=2; iQvar<=12; iQvar++ ) // BOOL to STRING255
          {
            std::string qvar1 = referenceRecordSpec()[iQvar].first; // queryvar1
            std::cout << "=== Test bind variables for " << qvar1 << std::endl;
            // Prepare one query per index value (skip -4=Nan and -3=null)
            // [Careful that some values may not be unique...]
            //for ( int index = 65; index<=65; index++ ) // SHORT TEST
            for ( int index = -2; index<=255; index++ )
            {
              bool debug = false; // no printout
              //bool debug = ( index == 65 ); // moderate printout
              //bool debug = ( qvar1 == "A_FLOAT" ); // targeted printout
              //bool debug = true; // full printout
              if ( debug )
                coral::MessageStream::setMsgVerbosity( coral::Debug );
              else
                coral::MessageStream::setMsgVerbosity( oldLvl );
              // Skip some indexes for specific variables
              if ( qvar1 == "A_STRING255" &&
                   ( index<65 || index > 90 ) ) continue;
              if ( ( qvar1 == "A_FLOAT" || qvar1 == "A_DOUBLE" ) &&
                   index<0 ) continue;
              // Prepare a string representation of the index for CPPUNIT logs
              std::stringstream ssIndex;
              ssIndex << "Index#" << index << " ";
              std::string sIndex = ssIndex.str();
              // Prepare the query
              // [Use TWO bind variables with the 2nd name including the 1st
              // to eventually test a subtle issue: without quotes, make sure
              // that ':BV+' is matched against ':BV' but ':BV2' is not!...]
              std::string bvar1 = "BVAR"; // bindvar1
              std::string qvar2 = "ID"; // queryvar2
              std::string bvar2 = "BVAR2"; // bindvar2 (bvar2==bvar1+"2"!)
              std::string bvar1a = "bvarlow"; // lowercase
              std::string bvar1b = "BVARESC"; // escaped in quotes
              coral::AttributeList bvarAL;
              formatBindVariables( bvarAL, spec, qvar1, bvar1 );
              formatBindVariables( bvarAL, spec, qvar2, bvar2 );
              formatBindVariables( bvarAL, spec, qvar1, bvar1a );
              formatBindVariables( bvarAL, spec, qvar1, bvar1b );
              const coral::AttributeList& refRow = referenceData(index);
              bvarAL[0] = refRow[qvar1];
              bvarAL[1] = refRow[qvar2];
              bvarAL[2] = refRow[qvar1];
              bvarAL[3] = refRow[qvar1];
              std::auto_ptr<coral::IQuery> query( schema.newQuery() );
              std::string clause;
              if ( UrlRW() == BuildUrl( "SQLite", false ) )
                clause = qvar2+"=:"+bvar2
                  +" AND "+qvar1+"=:"+bvar1a
                  //+" AND "+qvar1+"=:\""+bvar1b+"\"" // fails on sqlite
                  +" AND "+qvar1+"=:"+bvar1b // OK for sqlite
                  +" AND "+qvar1+"=:"+bvar1;
              else
                clause = qvar2+"=:"+bvar2
                  +" AND "+qvar1+"=:"+bvar1a
                  +" AND "+qvar1+"=:\""+bvar1b+"\"" // fails on sqlite
                  //+" AND "+qvar1+"=:"+bvar1b // OK for sqlite
                  +" AND "+qvar1+"=:"+bvar1;
              query->setCondition( clause, bvarAL );
              if ( debug )
                std::cout << "Query '" << clause
                          << "' with " << bvarAL << std::endl;
              std::string freshKey;
              prepareQueryForReading( *query, dataBuffer, freshKey );
              // Execute the query
              coral::ICursor& cursor = query->execute();
              std::vector< coral::AttributeList > rows;
              while ( cursor.next() ) rows.push_back( cursor.currentRow() );
              CPPUNIT_ASSERT_EQUAL_MESSAGE( "# rows", 1, (int)rows.size() );
              if ( debug )
                std::cout << "Successfully read " << rows.size() << " rows ["
                          << iRead << "/" << optNReads() << "]" << std::endl;
              const coral::AttributeList row = rows[0]; // only one row expected
              if ( optDoFill() ) // functional test (not the repeated-read test)
              {
                if ( index <= 2 || index >= 253 )
                  std::cout << "Read from reference table (" << index << ")"
                            << std::endl;
                else if ( index == 3 )
                  std::cout << "Read from reference table (3...252)"
                            << std::endl;
                CPPUNIT_ASSERT_EQUAL_MESSAGE( sIndex+"ID isNull1",
                                              refRow["ID"].isNull(),
                                              row["ID"].isNull() );
                CPPUNIT_ASSERT_EQUAL_MESSAGE( sIndex+"ID isNull2",
                                              false,
                                              row["ID"].isNull() );
                CPPUNIT_ASSERT_EQUAL_MESSAGE( sIndex+"ID data",
                                              refRow["ID"].data<cool::Int32>(),
                                              row["ID"].data<cool::Int32>() );
                CPPUNIT_ASSERT_EQUAL_MESSAGE( sIndex+"Desc isNull1",
                                              refRow[DESCFLD].isNull(),
                                              row[DESCFLD].isNull() );
                CPPUNIT_ASSERT_EQUAL_MESSAGE( sIndex+"Desc isNull2",
                                              false,
                                              row[DESCFLD].isNull() );
                CPPUNIT_ASSERT_EQUAL_MESSAGE( sIndex+"Desc data",
                                              refRow[DESCFLD].data<std::string>(),
                                              row[DESCFLD].data<std::string>() );
                bool isNull = false;
                if ( index == -3 ) isNull = true;
                testPayload<cool::Bool>
                  ( sIndex, "A_BOOL", refRow, row, isNull, connectString );
                testPayload<cool::UChar>
                  ( sIndex, "A_UCHAR", refRow, row, isNull, connectString );
                testPayload<cool::Int16>
                  ( sIndex, "A_INT16", refRow, row, isNull, connectString );
                testPayload<cool::UInt16>
                  ( sIndex, "A_UINT16", refRow, row, isNull, connectString );
                testPayload<cool::Int32>
                  ( sIndex, "A_INT32", refRow, row, isNull, connectString );
                testPayload<cool::UInt32>
                  ( sIndex, "A_UINT32", refRow, row, isNull, connectString );
                //testPayload<cool::UInt63>
                //  ( sIndex, "A_UINT63", refRow, row, isNull, connectString );
                //testPayload<cool::Int64>
                //  ( sIndex, "A_INT64", refRow, row, isNull, connectString );
                testPayload<cool::Float>
                  ( sIndex, "A_FLOAT", refRow, row, isNull, connectString );
                testPayload<cool::Double>
                  ( sIndex, "A_DOUBLE", refRow, row, isNull, connectString );
                testPayload<cool::String255>
                  ( sIndex, "A_STRING255", refRow, row, isNull, connectString );
                testPayload<cool::String4k>
                  ( sIndex, "A_STRING4K", refRow, row, isNull,connectString );
                testPayload<cool::String64k>
                  ( sIndex, "A_STRING64K", refRow, row, isNull, connectString );
                testPayload<cool::String16M>
                  ( sIndex, "A_STRING16M", refRow, row, isNull, connectString );
#ifndef NOBLOB
                // TO DO: BLOB templated method
                //testPayload<cool::Blob64k>
                //  ( sIndex, "A_BLOB64K", refRow, row, isNull );
                //testPayload<cool::Blob16M>
                //  ( sIndex, "A_BLOB16M", refRow, row, isNull );
#endif
              }
              const std::string name = "RANDOM_STRING255";
              assertEqualMessage( sIndex + name + " data",
#ifdef USE_FRESHKEY
                                  freshKey,
#else
                                  refRow[ name ].data<std::string>(),
#endif
                                  row[ name ].data<std::string>() );
            }
          }
        }
      }
      catch( ... )
      {
        coral::MessageStream::setMsgVerbosity( oldLvl );
        throw;
      }
      coral::MessageStream::setMsgVerbosity( oldLvl );
      // **  END  ** read reference data
      session->transaction().commit();
      std::cout << "Read from reference table... DONE" << std::endl;
    }

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    void test_oneBackend()
    {
      const std::string connectStringR = UrlRO();
      readReferenceData( connectStringR );
    }

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    void test_oneBackendBindVar()
    {
      const std::string connectStringR = UrlRO();
      readReferenceDataBindVar( connectStringR );
    }

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    coral::IConnectionService& connectionService()
    {
      static coral::ConnectionService connSvc;
      return connSvc;
    }

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    CoralReferenceDBTest(){}

    ~CoralReferenceDBTest(){}

    void setUp()
    {
      const std::string connectStringW = UrlRW();
      static bool first = true;
      if ( first && optDoFill() )
      {
        fillReferenceData( connectStringW );
        if( connectStringW == BuildUrl( "Oracle", false ) )
        {
          std::cout << "Sleep to avoid ORA-01466" << std::endl;
          coral::sleepSeconds(2);  // Workaround for ORA-01466
        }
      }
      else
      {
        std::cout << std::endl
                  << "Skip (re-)creation of reference table" << std::endl;
      }
      first = false;
    }

    void tearDown(){}

  };

  //---------------------------------------------------------------------------

  template<> void
  CoralReferenceDBTest::assertEqualMessage<float>( const std::string& msg,
                                                   const float& refValue,
                                                   const float& value )
  {
    if ( isNaN( refValue ) && isNaN( refValue ) ) return;  // Both are NaN: OK
    double exp = pow( (double)10, 5 );
    try
    {
      CPPUNIT_ASSERT_EQUAL_MESSAGE( msg,
                                    floor( refValue * exp ) / exp,
                                    floor( value    * exp ) / exp );
    }
    catch(...)
    {
      std::streamsize prec = std::cout.precision();
      std::cout.precision(20);
      std::cout << msg << " RefValue='" << refValue << "'"
                << " Value='" << value << "'" << std::endl;
      std::cout.precision(prec);
      throw;
    }
  }

  //---------------------------------------------------------------------------

  template<> void
  CoralReferenceDBTest::assertEqualMessage<double>( const std::string& msg,
                                                    const double& refValue,
                                                    const double& value )
  {
    if ( isNaN( refValue ) && isNaN( refValue ) ) return;  // Both are NaN: OK
    double exp = pow( (double)10, 14 );
    try
    {
      CPPUNIT_ASSERT_EQUAL_MESSAGE( msg,
                                    floor( refValue * exp ) / exp,
                                    floor( value    * exp ) / exp );
    }
    catch(...)
    {
      std::streamsize prec = std::cout.precision();
      std::cout.precision(20);
      std::cout << msg << " RefValue='" << refValue << "'"
                << " Value='" << value << "'" << std::endl;
      std::cout.precision(prec);
      throw;
    }
  }

  //---------------------------------------------------------------------------

  CPPUNIT_TEST_SUITE_REGISTRATION( CoralReferenceDBTest );

}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

CORALCPPUNITTEST_MAIN( CoralReferenceDBTest )
