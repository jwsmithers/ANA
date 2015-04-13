#include <iostream>
#include <stdexcept>
#include "CoralBase/Blob.h"
#include "CoralBase/Exception.h"
#include "CoralBase/../tests/Common/CoralCppUnitTest.h"

namespace coral
{

  class BlobTest : public CoralCppUnitTest
  {

    CPPUNIT_TEST_SUITE( BlobTest );
    CPPUNIT_TEST( test_BlobReadWrite );
    CPPUNIT_TEST( test_BlobNegativeSize );
    CPPUNIT_TEST( test_BlobCopyAssign );
    CPPUNIT_TEST_SUITE_END();

  public:


    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    void setUp() {}

    void tearDown() {}

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    void test_BlobReadWrite()
    {
      coral::Blob blob1;
      coral::Blob blob1cp( blob1 );
      coral::Blob blob1cpasgn = blob1;
      blob1cp = blob1cpasgn;
      blob1cpasgn += blob1cpasgn;
      int numberOfElements = 1024;
      blob1.extend( numberOfElements * sizeof(float) );
      float* addressToElement = static_cast<float*>( blob1.startingAddress() );
      for ( int i = 0; i < numberOfElements; ++i, ++addressToElement )
      {
        *addressToElement = (float)i;
      }
      int extraElements = 512;
      blob1.extend( extraElements * sizeof(float) );
      addressToElement = static_cast<float*>( blob1.startingAddress() );
      for ( int i = 0; i < numberOfElements; ++i, ++addressToElement ) {}
      for ( int i = numberOfElements;
            i < numberOfElements + extraElements;
            ++i, ++addressToElement )
      {
        *addressToElement = (float)i;
      }
      int numberOfDroppedElements = 126;
      numberOfElements += extraElements - numberOfDroppedElements;
      blob1.resize( numberOfElements * sizeof(float) );
      long blobSize = blob1.size();
      if ( blobSize != static_cast<long>( numberOfElements * sizeof( float ) ) )
      {
        std::cerr << "Blob size : " << blobSize << std::endl;
        std::cerr << "Expected : " << numberOfElements * sizeof( float ) << std::endl;
        throw std::runtime_error( "Unexpected size of the blob" );
      }
      coral::Blob blob2( 100 * sizeof(float) );
      addressToElement = static_cast< float* >( blob2.startingAddress() );
      for ( int i = 0; i < 100; ++i, ++addressToElement )
      {
        *addressToElement = (float)i + numberOfElements;
      }
      blob1 += blob2;
      numberOfElements += 100;
      if ( blob1.size() !=
           static_cast<long>( numberOfElements*sizeof(float) ) )
        throw std::runtime_error( "Unexpected size of blob after appending" );
      addressToElement = static_cast< float* >( blob1.startingAddress() );
      for ( int i = 0; i < numberOfElements; ++i, ++addressToElement )
      {
        if ( *addressToElement != i )
          throw std::runtime_error( "Unexpected data found" );
      }
      for ( int i = 0; i < 10; ++i )
      {
        blob1 = coral::Blob();
        long targetSize = 1000 * ( i + 1 );
        while ( targetSize > 0 )
        {
          long chunkSize = 1024;
          coral::Blob chunk( chunkSize );
          targetSize -= chunkSize;
          if ( targetSize < 0 ) chunkSize += targetSize;
          chunk.resize( chunkSize );
          blob1 += chunk;
        }
      }
    }

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    // Test for negative sizes (bug #95349)
    void test_BlobNegativeSize()
    {
      try
      {
        coral::Blob blob1(-100);
        CPPUNIT_FAIL( "Blob ctor with negative size should throw" );
      }
      catch ( coral::Exception& ) {}
      coral::Blob blob1(100);
      CPPUNIT_ASSERT_THROW_MESSAGE( "Extending a Blob by a negative size should throw", blob1.extend(-200), coral::Exception );
      CPPUNIT_ASSERT_THROW_MESSAGE( "Resizing a Blob to a negative size should throw", blob1.resize(-100), coral::Exception );
    }

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    // Test copy and assignment (see bug #95349)
    void test_BlobCopyAssign()
    {
      coral::Blob blob0(0);
      coral::Blob blob1(256);
      char* addressToElement = static_cast<char*>( blob1.startingAddress() );
      for ( int i=0; i<256; ++i, ++addressToElement )
        *addressToElement = (char)i;
      if ( blob0 == blob1 )
        CPPUNIT_FAIL( "Expect Blob0 != Blob1" );
      coral::Blob blob2(256);
      addressToElement = static_cast<char*>( blob2.startingAddress() );
      for ( int i=255; i>=0; --i, ++addressToElement )
        *addressToElement = (char)i;
      if ( blob0 == blob2 )
        CPPUNIT_FAIL( "Expect Blob0 != Blob2" );
      if ( blob1 == blob2 )
        CPPUNIT_FAIL( "Expect Blob1 != Blob2" );
      // Assign non-zero into zero Blob
      coral::Blob blob0a( blob0 );
      if ( blob0a != blob0 )
        CPPUNIT_FAIL( "1 Expect Blob0a == Blob0" );
      if ( blob0a == blob1 )
        CPPUNIT_FAIL( "1 Expect Blob0a != Blob1" );
      blob0a = blob1;
      if ( blob0a != blob1 )
        CPPUNIT_FAIL( "1 Expect Blob0a == Blob1" );
      // Assign zero into non-zero Blob
      coral::Blob blob1a( blob1 );
      if ( blob1a != blob1 )
        CPPUNIT_FAIL( "2 Expect Blob1a == Blob1" );
      if ( blob1a == blob0 )
        CPPUNIT_FAIL( "2 Expect Blob1a != Blob0" );
      blob1a = blob0;
      if ( blob1a != blob0 )
        CPPUNIT_FAIL( "2 Expect Blob1a == Blob1" );
      // Assign zero into zero Blob
      coral::Blob blob0b( blob0 );
      if ( blob0b != blob0 )
        CPPUNIT_FAIL( "3 Expect Blob0b == Blob0" );
      blob0b = blob0;
      if ( blob0b != blob0 )
        CPPUNIT_FAIL( "3 Expect Blob0b == Blob0 again" );
      // Assign non-zero into non-zero Blob
      coral::Blob blob1b( blob1 );
      if ( blob1b != blob1 )
        CPPUNIT_FAIL( "4 Expect Blob1b == Blob1" );
      blob1b = blob2;
      if ( blob1b != blob2 )
        CPPUNIT_FAIL( "4 Expect Blob1b == Blob2" );
    }

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  };

  CPPUNIT_TEST_SUITE_REGISTRATION( BlobTest );

}

CORALCPPUNITTEST_MAIN( BlobTest )
