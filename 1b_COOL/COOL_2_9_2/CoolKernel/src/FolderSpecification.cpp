// $Id: FolderSpecification.cpp,v 1.11 2012-07-08 20:02:33 avalassi Exp $

// First of all, enable or disable the COOL290 API extensions (bug #92204)
#include "CoolKernel/VersionInfo.h"

// Include files
#include <sstream>
#include "CoolKernel/Exception.h"
#include "CoolKernel/FolderSpecification.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

FolderSpecification::~FolderSpecification()
{
}

//-----------------------------------------------------------------------------

#ifndef COOL290VP
FolderSpecification::FolderSpecification( FolderVersioning::Mode mode )
  : m_versioningMode( mode )
  , m_payloadSpec()
  , m_hasPayloadTable( false )
{
  // Throw if an invalid versioning mode is specified (fix bug #103343)
  if ( mode != FolderVersioning::SINGLE_VERSION &&
       mode != FolderVersioning::MULTI_VERSION )
  {
    std::stringstream s;
    s << "Invalid versioning mode specified: " << mode;
    throw InvalidFolderSpecification( s.str(), "FolderSpecification" );
  }
}
#endif

//-----------------------------------------------------------------------------

#ifdef COOL290VP
FolderSpecification::FolderSpecification( const IRecordSpecification& payloadSpecification )
  : m_versioningMode( FolderVersioning::SINGLE_VERSION )
  , m_payloadSpec( payloadSpecification )
  , m_payloadMode( PayloadMode::INLINEPAYLOAD )
{
}
#endif

//-----------------------------------------------------------------------------

#ifndef COOL290VP
FolderSpecification::FolderSpecification( FolderVersioning::Mode mode,
                                          const IRecordSpecification& pSpec,
                                          bool hasPayloadTable )
  : m_versioningMode( mode )
  , m_payloadSpec( pSpec )
  , m_hasPayloadTable( hasPayloadTable )
{
  // Throw if an invalid versioning mode is specified (fix bug #103343)
  if ( mode != FolderVersioning::SINGLE_VERSION &&
       mode != FolderVersioning::MULTI_VERSION )
  {
    std::stringstream s;
    s << "Invalid versioning mode specified: " << mode;
    throw InvalidFolderSpecification( s.str(), "FolderSpecification" );
  }
}
#endif

//-----------------------------------------------------------------------------

#ifdef COOL290VP
FolderSpecification::FolderSpecification( FolderVersioning::Mode mode,
                                          const IRecordSpecification& pSpec,
                                          PayloadMode::Mode payloadMode )
  : m_versioningMode( mode )
  , m_payloadSpec( pSpec )
  , m_payloadMode( payloadMode )
{
  // Throw if an invalid versioning mode is specified (fix bug #103343)
  if ( mode != FolderVersioning::SINGLE_VERSION &&
       mode != FolderVersioning::MULTI_VERSION )
  {
    std::stringstream s;
    s << "Invalid versioning mode specified: " << mode;
    throw InvalidFolderSpecification( s.str(), "FolderSpecification" );
  }
  // Throw if an invalid payload mode is specified (fix bug #103351)
  if ( payloadMode != PayloadMode::INLINEPAYLOAD &&
       payloadMode != PayloadMode::SEPARATEPAYLOAD &&
       payloadMode != PayloadMode::VECTORPAYLOAD )
  {
    std::stringstream s;
    s << "Invalid payload mode specified: " << payloadMode;
    throw InvalidFolderSpecification( s.str(), "FolderSpecification" );
  }
}
#endif

//-----------------------------------------------------------------------------

/*
FolderSpecification::FolderSpecification( FolderVersioning::Mode mode,
                                          const IRecordSpecification& pSpec,
                                          const IRecordSpecification& cSpec )
  : m_versioningMode( mode )
  , m_payloadSpec( pSpec )
  , m_hasPayloadTable( false )
{
  // Throw if an invalid versioning mode is specified (fix bug #103343)
  if ( mode != FolderVersioning::SINGLE_VERSION &&
       mode != FolderVersioning::MULTI_VERSION )
  {
    std::stringstream s;
    s << "Invalid versioning mode specified: " << mode;
    throw InvalidFolderSpecification( s.str(), "FolderSpecification" );
  }
}
*///

//-----------------------------------------------------------------------------

#ifdef COOL290VP
FolderSpecification::FolderSpecification( const FolderSpecification& rhs )
  : m_versioningMode( rhs.m_versioningMode )
  , m_payloadSpec( rhs.m_payloadSpec )
  , m_payloadMode( rhs.m_payloadMode )
{
}
#endif

//-----------------------------------------------------------------------------

#ifdef COOL290VP
FolderSpecification& FolderSpecification::operator=( const FolderSpecification& rhs )
{
  m_versioningMode = rhs.m_versioningMode;
  m_payloadSpec = rhs.m_payloadSpec;
  m_payloadMode = rhs.m_payloadMode;
  return *this;
}
#endif

//-----------------------------------------------------------------------------

const FolderVersioning::Mode& FolderSpecification::versioningMode() const
{
  return m_versioningMode;
}

//-----------------------------------------------------------------------------

#ifndef COOL290VP
FolderVersioning::Mode& FolderSpecification::versioningMode()
{
  return m_versioningMode;
}
#endif

//-----------------------------------------------------------------------------

const IRecordSpecification& FolderSpecification::payloadSpecification() const
{
  return m_payloadSpec;
}

//-----------------------------------------------------------------------------

#ifndef COOL290VP
RecordSpecification& FolderSpecification::payloadSpecification()
{
  return m_payloadSpec;
}
#endif

//-----------------------------------------------------------------------------

/*
const IRecordSpecification& FolderSpecification::channelSpecification() const
{
  return m_channelSpec;
}
*///

//-----------------------------------------------------------------------------

/*
RecordSpecification& FolderSpecification::channelSpecification()
{
  return m_channelSpec;
}
*///

//-----------------------------------------------------------------------------

#ifndef COOL290VP
const bool& FolderSpecification::hasPayloadTable() const
{
  return m_hasPayloadTable;
}
#endif

//-----------------------------------------------------------------------------

#ifndef COOL290VP
bool& FolderSpecification::hasPayloadTable()
{
  return m_hasPayloadTable;
}
#endif

//-----------------------------------------------------------------------------

#ifdef COOL290VP
const PayloadMode::Mode& FolderSpecification::payloadMode() const
{
  return m_payloadMode;
}
#endif

//-----------------------------------------------------------------------------
