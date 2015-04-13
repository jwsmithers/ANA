// $Id: ConstRelationalObjectAdapter.cpp,v 1.18 2011-04-13 09:39:33 avalassi Exp $

// Local include files
//#include "attributeListToString.h"
#include "ConstRelationalObjectAdapter.h"
#include "RelationalException.h"
#include "RelationalObject.h"
#include "RelationalObjectTable.h"
#include "RelationalObjectTableRow.h"
#include "TimingReportMgr.h"
#include "timeToString.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

ConstRelationalObjectAdapter::ConstRelationalObjectAdapter
( RelationalObjectIterator& iterator,
  const coral::AttributeList& aList,
  const IRecordSpecification& payloadSpec,
  PayloadMode::Mode pMode )
  : m_iterator( iterator )
  , m_isTimingActive( isTimingActive() )
  , m_aList( aList )
  , m_payloadSpec( payloadSpec )
  , m_since( aList[RelationalObjectTable::columnNames::iovSince()]
             .data<ValidityKey>() )
  , m_until( aList[RelationalObjectTable::columnNames::iovUntil()]
             .data<ValidityKey>() )
  , m_payload( payloadSpec, aList )
  , m_payloadIterator( m_iterator, m_aList, m_payload )
  , m_channelId( aList[RelationalObjectTable::columnNames::channelId()]
                 .data<ChannelId>() )
  , m_insertionTime( aList[RelationalObjectTable::columnNames::sysInsTime()]
                     .data<std::string>() )
  , m_objectId( aList[RelationalObjectTable::columnNames::objectId()]
                .data<unsigned int>() )
  , m_payloadId0( 0 )
  , m_payloadId( pMode == PayloadMode::SEPARATEPAYLOAD ?
                 aList[RelationalObjectTable::columnNames::payloadId()].data<unsigned int>() :
                 m_payloadId0 )
  , m_payloadSetId( pMode == PayloadMode::VECTORPAYLOAD ?
                    aList[RelationalObjectTable::columnNames::payloadSetId()].data<unsigned int>() :
                    m_payloadId0 )
  , m_payloadSize1( 1 )
  , m_payloadSize( pMode == PayloadMode::VECTORPAYLOAD ?
                   aList[RelationalObjectTable::columnNames::payloadSize()].data<unsigned int>() :
                   m_payloadSize1 )
  , m_payloadMode( pMode )
{

  // This is used for READING back data __WITHOUT ANY DEEP COPY__!

  // Assuming that the RelationalObjectTableRow is a wrapper around
  // a reference to a temporary CORAL buffer, this instance can only be
  // used as long as the temporary CORAL buffer contains the right data!

  if ( m_isTimingActive )
    TimingReportMgr::stopTimer
      ( "cool::ConstRelationalObjectAdapter::ctor" );

}

//-----------------------------------------------------------------------------

ConstRelationalObjectAdapter::~ConstRelationalObjectAdapter()
{
  //if ( m_isTimingActive )
  //  TimingReportMgr::stopTimer
  //    ( "cool::ConstRelationalObjectAdapter [LIFETIME]" );
}

//-----------------------------------------------------------------------------

bool ConstRelationalObjectAdapter::isTimingActive() const
{
  if ( TimingReportMgr::isActive() )
  {
    TimingReportMgr::startTimer
      ( "cool::ConstRelationalObjectAdapter::ctor" );
    //TimingReportMgr::startTimer
    //  ( "cool::ConstRelationalObjectAdapter [LIFETIME]" );
    return true;
  }
  else return false;
}

//-----------------------------------------------------------------------------

IObject* ConstRelationalObjectAdapter::clone() const
{
  if ( m_payloadMode == PayloadMode::VECTORPAYLOAD )
  {
    RelationalObject *ret = new RelationalObject( since(),
                                                  until(),
                                                  *payloadIterator().fetchAllAsVector(),
                                                  channelId() );
    ret->setObjectId( m_objectId);
    ret->setPayloadId( m_payloadId );
    ret->setInsertionTime( m_insertionTime );
    ret->setPayloadSetId( m_payloadSetId );
    ret->setPayloadNItems( m_payloadSize );
    return ret;
  }

  //std::cout << "ConstRelationalObjectAdapter::clone" << std::endl;
  //std::cout << "DATA: " << attributeListToString(m_aList) << std::endl;
  //std::cout << "SPEC: " << Record(m_payloadSpec) << std::endl;
  return new RelationalObject( m_aList, m_payloadSpec, m_payloadMode );
}

//-----------------------------------------------------------------------------

const ValidityKey& ConstRelationalObjectAdapter::since() const
{
  return m_since;
}

//-----------------------------------------------------------------------------

const ValidityKey& ConstRelationalObjectAdapter::until() const
{
  return m_until;
}

//-----------------------------------------------------------------------------

const IRecord& ConstRelationalObjectAdapter::payload() const
{
  return m_payload;
}

//-----------------------------------------------------------------------------

IRecordIterator& ConstRelationalObjectAdapter::payloadIterator() const
{
  return m_payloadIterator;
}

//-----------------------------------------------------------------------------

const ChannelId& ConstRelationalObjectAdapter::channelId() const
{
  return m_channelId;
}

//-----------------------------------------------------------------------------

/*
const std::string& ConstRelationalObjectAdapter::channelName() const
{
  throw RelationalException
    ( "ConstRelationalObjectAdapter::channelName is not implemented yet" );
}
*///

//-----------------------------------------------------------------------------

bool ConstRelationalObjectAdapter::isStored() const
{
  return true;
}

//-----------------------------------------------------------------------------

unsigned int ConstRelationalObjectAdapter::objectId() const
{
  return m_objectId;
}

//-----------------------------------------------------------------------------

unsigned int ConstRelationalObjectAdapter::payloadId() const
{
  return m_payloadId;
}

//-----------------------------------------------------------------------------

unsigned int ConstRelationalObjectAdapter::payloadSetId() const
{
  return m_payloadSetId;
}

//-----------------------------------------------------------------------------

unsigned int ConstRelationalObjectAdapter::payloadSize() const
{
  std::cout << "return m_payloadSize " << m_payloadSize << std::endl;
  return m_payloadSize;
}

//-----------------------------------------------------------------------------

const ITime& ConstRelationalObjectAdapter::insertionTime() const
{
  return m_insertionTime;
}

//-----------------------------------------------------------------------------
/*
const ValidityKey& ConstRelationalObjectAdapter::sinceOriginal() const
{
  return m_sinceOriginal;
}

//-----------------------------------------------------------------------------

const ValidityKey& ConstRelationalObjectAdapter::untilOriginal() const
{
  return m_untilOriginal;
}

//-----------------------------------------------------------------------------

const ITime& ConstRelationalObjectAdapter::insertionTimeOriginal() const
{
  return m_insertionTimeOriginal;
}
*///
//-----------------------------------------------------------------------------

std::ostream& ConstRelationalObjectAdapter::print( std::ostream& s ) const
{
  s << "Object: ";
  {
    unsigned int maxSize = 3;
    s << std::setw(maxSize) << objectId();
  }

  s << " ";

  {
    unsigned int maxSize = 2;
    s << "(" << std::setw(maxSize) << channelId() << ")";
  }

  { // assemble IOV
    std::stringstream iov;
    iov << " [" << since() << "," ;
    if ( until() == ValidityKeyMax ) {
      iov << "+inf";
    } else {
      iov << until();
    }
    iov << "[";
    unsigned int maxSize = 10;
    s << std::setiosflags(std::ios::left) << std::setw(maxSize);
    s << iov.str();
    s << std::resetiosflags(std::ios::left);
  }

  s << " ";

  s << "PayloadId: ";
  {
    unsigned int maxSize = 3;
    s << std::setw(maxSize) << payloadId();
  }

  s << " ";

  { // assemble payload
    std::stringstream p;
    p << "[";
    bool first = true;
    const IRecordSpecification& spec = payload().specification();
    for ( unsigned int i = 0; i < spec.size(); i++ ) {
      if ( first ) {
        first = false;
        p << payload()[i];
      } else {
        p << "|" << payload()[i];
      }
    }
    p << "] ";

    unsigned int maxSize = 20;
    s << std::setiosflags(std::ios::left) << std::setw(maxSize);
    s << p.str();
    s << std::resetiosflags(std::ios::left);
  }

  s << timeToString( insertionTime() );
  return s;
}

//-----------------------------------------------------------------------------
