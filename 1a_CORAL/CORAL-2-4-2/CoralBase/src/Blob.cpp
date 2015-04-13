#include <cstdlib>
#include <cstring>
#include "CoralBase/Blob.h"
#include "CoralBase/Exception.h"


coral::Blob::Blob()
  : m_size( 0 )
  , m_data( 0 )
{
}


coral::Blob::Blob( long initialSizeInBytes )
  : m_size( initialSizeInBytes )
{
  if ( m_size<0 ) // Fix Coverity-related bug #95349
    throw Exception( "Cannot create a Blob with a negative size!",
                     "Blob::Blob(size)",
                     "coral::CoralBase" );
  m_data = ::malloc( m_size ); // Fix Coverity NEGATIVE_RETURNS
  if ( (!m_data) && m_size>0 )
    throw Exception( "::malloc failed",
                     "Blob::Blob(size)",
                     "coral::CoralBase" );
}


coral::Blob::~Blob()
{
  if ( m_data ) ::free( m_data );
}


const void*
coral::Blob::startingAddress() const
{
  return m_data;
}


void*
coral::Blob::startingAddress()
{
  return m_data;
}


long
coral::Blob::size() const
{
  return m_size;
}


void
coral::Blob::extend( long additionalSizeInBytes )
{
  if ( additionalSizeInBytes<0 ) // Fix Coverity-related bug #95349
    throw Exception( "Cannot extend by a negative size!",
                     "Blob::extend",
                     "coral::CoralBase" );
  m_data = ::realloc( m_data, m_size + additionalSizeInBytes );
  m_size += additionalSizeInBytes;
  if ( (!m_data) && m_size>0 )
    throw Exception( "::realloc failed",
                     "Blob::extend",
                     "coral::CoralBase" );
}


void
coral::Blob::resize( long sizeInBytes )
{
  if ( sizeInBytes<0 ) // Fix Coverity-related bug #95349
    throw Exception( "Cannot resize to a negative size!",
                     "Blob::resize",
                     "coral::CoralBase" );
  if ( sizeInBytes != m_size )
  {
    m_data = ::realloc( m_data, sizeInBytes );
    m_size = sizeInBytes;
    if ( (!m_data) && m_size>0 )
      throw Exception( "::realloc failed",
                       "Blob::resize",
                       "coral::CoralBase" );
  }
}


coral::Blob::Blob( const coral::Blob& rhs )
  : m_size( rhs.m_size )
  , m_data( 0 )
{
  if ( m_size<0 ) // Fix Coverity-related bug #95349
    throw Exception( "Cannot copy a Blob with a negative size!",
                     "Blob::Blob(Blob&)",
                     "coral::CoralBase" );
  if ( m_size > 0 )
  {
    m_data = ::malloc( m_size );
    if ( (!m_data) && m_size>0 )
      throw Exception( "::malloc failed",
                       "Blob::Blob(Blob&)",
                       "coral::CoralBase" );
    m_data = ::memcpy( m_data, rhs.m_data, m_size );
  }
}


coral::Blob&
coral::Blob::operator=( const Blob& rhs )
{
  if ( this == &rhs ) return *this;  // Fix Coverity SELF_ASSIGN
  if ( rhs.m_size < 0 ) // Fix Coverity-related bug #95349
    throw Exception( "Cannot assign a Blob with a negative size!",
                     "Blob::operator=",
                     "coral::CoralBase" );
  if ( m_data ) // check that old data is non-0 (instead of old m_size != 0)
  {
    if ( ( rhs.m_size > 0 )
         && rhs.m_data ) // unnecessary: try to silence Coverity MISSING_ASSIGN
    {
      m_data = ::realloc( m_data, rhs.m_size ); // realloc old (non-0) data
      if ( (!m_data) )
        throw Exception( "::realloc failed",
                         "Blob::operator=",
                         "coral::CoralBase" );
      ::memcpy( m_data, rhs.m_data, rhs.m_size );
    }
    else
    {
      ::free( m_data ); // free and zero old (non-0) data
      m_data = 0;
    }
  }
  else // old data was 0
  {
    if ( ( rhs.m_size > 0 ) // Fix Coverity FORWARD_NULL (no memcpy if size<=0)
         && rhs.m_data ) // unnecessary: try to silence Coverity MISSING_ASSIGN
    {
      m_data = ::malloc( rhs.m_size ); // malloc new data (old was 0)
      if ( (!m_data) )
        throw Exception( "::malloc failed",
                         "Blob::operator=",
                         "coral::CoralBase" );
      ::memcpy( m_data, rhs.m_data, rhs.m_size );
    }
    else
    {
      // nothing to do, old data was 0 and new data is still 0
    }
  }
  m_size = rhs.m_size; // finally set the size here
  return *this;
}


coral::Blob&
coral::Blob::operator+=( const coral::Blob& rhs )
{
  long initialSize = m_size;
  this->extend( rhs.size() );
  ::memcpy( static_cast<char*>(m_data) + initialSize, rhs.m_data, rhs.size() );
  return *this;
}


bool
coral::Blob::operator==( const coral::Blob& rhs ) const
{
  if ( m_size != rhs.m_size ) return false;
  if ( m_size == 0 ) return true;
  const unsigned char* thisData = static_cast<const unsigned char*>(m_data);
  const unsigned char* rhsData = static_cast<const unsigned char*>(rhs.m_data);
  for ( long i = 0; i < m_size; ++i, ++thisData, ++rhsData )
    if ( *thisData != *rhsData )
      return false;
  return true;
}
