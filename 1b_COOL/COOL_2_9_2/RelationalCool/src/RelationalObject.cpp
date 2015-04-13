// $Id: RelationalObject.cpp,v 1.57 2012-07-02 13:42:49 avalassi Exp $

// Include files
#include "CoolKernel/ConstRecordAdapter.h"
#include "CoolKernel/InternalErrorException.h"

// Local include files
#include "RelationalException.h"
#include "RelationalObject.h"
#include "RelationalObjectTable.h"
#include "RelationalObjectTableRow.h"
#include "RelationalPayloadTable.h"
#include "TimingReportMgr.h"
#include "timeToString.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

RelationalObject::RelationalObject( const ValidityKey& since,
                                    const ValidityKey& until,
                                    const IRecord& payload,
                                    const ChannelId& channelId,
                                    const std::string& userTagName )
  : m_since( since )
  , m_until( until )
  , m_payloadPtr( new Record( payload ) )
  , m_payloadVector( )
  , m_payloadIterator( m_payloadVector )
  , m_channelId( channelId )
  , m_userTagName( userTagName )
  , m_objectId( 0 )
  , m_payloadId( 0 )
  , m_payloadSetId( 0 )
  , m_payloadSize( 0 )
  , m_userTagId( 0 )
{

  // This is used for WRITING data.

  // NB The input IRecord& payload is the one specified by the user
  // in IFolder::storeObject: the user owns it and control its lifetime,
  // hence the data must be copied at least once (here using copy ctor),
  // __IF__ COOL is meant to ultimately own the data (as in COOL 133).

  // On the other hand, the COOL133 code was not optimal because the data
  // owned by the user could be directly stored into the database via CORAL!

  // Need TWO separate implementations for writing (data owned by the user
  // and not copied) and reading (data owned by COOL)?

  // Bulk insertion - MUST copy...

  // insert payload into vector for vector folders
  m_payloadVector.push_back( m_payloadPtr );
}

//-----------------------------------------------------------------------------

RelationalObject::RelationalObject( const ValidityKey& since,
                                    const ValidityKey& until,
                                    const std::vector<IRecordPtr>& payload,
                                    const ChannelId& channelId,
                                    const std::string& userTagName )
  : m_since( since )
  , m_until( until )
  , m_payloadPtr( new Record() )
  , m_payloadVector( )
  , m_payloadIterator( m_payloadVector )
  , m_channelId( channelId )
  , m_userTagName( userTagName )
  , m_objectId( 0 )
  , m_payloadId( 0 )
  , m_payloadSetId( 0 )
  , m_payloadSize( payload.size() )
  , m_userTagId( 0 )
{

  // This is used for WRITING data.

  // NB The input IRecord& payload is the one specified by the user
  // in IFolder::storeObject: the user owns it and control its lifetime,
  // hence the data must be copied at least once (here using copy ctor),
  // __IF__ COOL is meant to ultimately own the data (as in COOL 133).

  // Bulk insertion - MUST copy...

  m_payloadVector.reserve( payload.size() );
  for ( std::vector<IRecordPtr>::const_iterator it=payload.begin();
        it!= payload.end(); ++it )
  {
    m_payloadVector.push_back( IRecordPtr( new Record( *(*it) ) ) );
  };

  if ( m_payloadVector.size() > 0 )
  {
    // This has already been modified to fix Coverity FORWARD_NULL (bug #95774)
    // FIXME all this has to be rethought, don't copy payload!
    Record* rec = dynamic_cast<Record*>(m_payloadPtr.get());
    if ( !rec ) // Fix Coverity FORWARD_NULL
      throw InternalErrorException( "PANIC! Dynamic cast to Record* failed",
                                    "RelationalObject ctor" );
    rec->extend( **m_payloadVector.begin() );
  };
}

//-----------------------------------------------------------------------------

RelationalObject::RelationalObject( const ValidityKey& since,
                                    const ValidityKey& until,
                                    const unsigned int payloadId,
                                    const ChannelId& channelId,
                                    const std::string& userTagName )
  : m_since( since )
  , m_until( until )
  , m_payloadPtr( new Record() )
  , m_payloadVector( )
  , m_payloadIterator( m_payloadVector )
  , m_channelId( channelId )
  , m_userTagName( userTagName )
  , m_objectId( 0 )
  , m_payloadId( payloadId )
  , m_payloadSetId( 0 )
  , m_payloadSize( 1 )
  , m_userTagId( 0 )
{

  // This is used for WRITING data.

  // NB The input IRecord& payload is the one specified by the user
  // in IFolder::storeObject: the user owns it and control its lifetime,
  // hence the data must be copied at least once (here using copy ctor),
  // __IF__ COOL is meant to ultimately own the data (as in COOL 133).

  // On the other hand, the COOL133 code was not optimal because the data
  // owned by the user could be directly stored into the database via CORAL!

  // Need TWO separate implementations for writing (data owned by the user
  // and not copied) and reading (data owned by COOL)?

  // Bulk insertion - MUST copy...

  // insert payload into vector for vector folders
  m_payloadVector.push_back( m_payloadPtr );
}

//-----------------------------------------------------------------------------

RelationalObject::RelationalObject( const ValidityKey& since,
                                    const ValidityKey& until,
                                    const unsigned int payloadSetId,
                                    const unsigned int payloadSize,
                                    const ChannelId& channelId,
                                    const std::string& userTagName )
  : m_since( since )
  , m_until( until )
  , m_payloadPtr( new Record() )
  , m_payloadVector( )
  , m_payloadIterator( m_payloadVector )
  , m_channelId( channelId )
  , m_userTagName( userTagName )
  , m_objectId( 0 )
  , m_payloadId( 0 )
  , m_payloadSetId( payloadSetId )
  , m_payloadSize( payloadSize )
  , m_userTagId( 0 )
{

  // This is used for WRITING data.

  // NB The input IRecord& payload is the one specified by the user
  // in IFolder::storeObject: the user owns it and control its lifetime,
  // hence the data must be copied at least once (here using copy ctor),
  // __IF__ COOL is meant to ultimately own the data (as in COOL 133).

  // On the other hand, the COOL133 code was not optimal because the data
  // owned by the user could be directly stored into the database via CORAL!

  // Need TWO separate implementations for writing (data owned by the user
  // and not copied) and reading (data owned by COOL)?

  // Bulk insertion - MUST copy...

  // insert payload into vector for vector folders
  m_payloadVector.push_back( m_payloadPtr );
}

//-----------------------------------------------------------------------------

IObject* RelationalObject::clone() const
{
  RelationalObject *ret=0;
  if ( m_payloadVector.size()==1 )
  {
    ret = new RelationalObject(m_since, m_until, *(m_payloadPtr.get()),
                               m_channelId, m_userTagName );
  }
  else
  {
    ret =  new RelationalObject(m_since, m_until, m_payloadVector,
                                m_channelId, m_userTagName );
  }

  ret->m_objectId  = m_objectId;
  ret->m_payloadId  = m_payloadId;
  ret->m_userTagId = m_userTagId;
  ret->m_insertionTime = m_insertionTime;
  ret->m_payloadSetId = m_payloadSetId;
  ret->m_payloadSize = m_payloadSize;

  return ret;
}
//-----------------------------------------------------------------------------

/*
RelationalObject::RelationalObject( RelationalObjectTableRow& row,
                                    const IRecordSpecification& payloadSpec )
  : m_since( row.since() )
  , m_until( row.until() )
  , m_payload()
  //, m_payload( ConstRecordAdapter( payloadSpec, row.data() ) // later
  , m_channelId( row.channelId() )
  , m_userTagName( "" )
  , m_insertionTime( row.insertionTime() )
  , m_objectId( row.objectId() )
  , m_userTagId( row.userTagId() ) { // keep it here else M-x clean gets weird
  // This is used for READING back data.
  // ASSUME (check...) that RelationalObjectTableRow is a wrapper around
  // a reference to a temporary CORAL buffer: here you must do a DEEP copy!
  // CHECK: is this copying 'fast' enough?
  ConstRecordAdapter rec( payloadSpec, row.data() );
  m_payload = rec;
}
*///

//-----------------------------------------------------------------------------

RelationalObject::RelationalObject ( const coral::AttributeList& aList,
                                     const IRecordSpecification& payloadSpec,
                                     PayloadMode::Mode pMode )
  : m_since( aList[RelationalObjectTable::columnNames::iovSince()]
             .data<ValidityKey>() )
  , m_until( aList[RelationalObjectTable::columnNames::iovUntil()]
             .data<ValidityKey>() )
  , m_payloadPtr( new Record() )
  , m_payloadVector()
  , m_payloadIterator( m_payloadVector )
  , m_channelId( aList[RelationalObjectTable::columnNames::channelId()]
                 .data<ChannelId>() )
  , m_userTagName( "" )
  , m_insertionTime( stringToTime
                     ( aList[RelationalObjectTable::columnNames::sysInsTime()]
                       .data<std::string>() ) )
  , m_objectId( aList[RelationalObjectTable::columnNames::objectId()]
                .data<unsigned int>() )
  , m_payloadId( 0 )
  , m_payloadSetId( 0 )
  , m_payloadSize( 0 )
  , m_userTagId( aList[RelationalObjectTable::columnNames::userTagId()]
                 .data<unsigned int>() )
{

  // This is used for READING back data.

  // ASSUME (check...) that RelationalObjectTableRow is a wrapper around
  // a reference to a temporary CORAL buffer: here you must do a DEEP copy!

  if ( TimingReportMgr::isActive() )
    TimingReportMgr::startTimer( "cool::RelationalObject::ctor" );

  if ( pMode == PayloadMode::INLINEPAYLOAD )
  {
    m_payloadId = 0;
  }
  else
  {
    m_payloadId = aList[RelationalPayloadTable::columnNames::payloadId()]
      .data<unsigned int>();
  }
  // vector payload can't be initialized from a aList...

  // CHECK: is this copying 'fast' enough?
  ConstRecordAdapter rec( payloadSpec, aList );
  Record* rec2 = dynamic_cast<Record*>(m_payloadPtr.get());
  if ( !rec2 ) // Fix Coverity FORWARD_NULL
    throw InternalErrorException( "PANIC! Dynamic cast to Record* failed", "RelationalObject ctor" );
  //*(m_payloadPtr.get()) = rec; // BAD use of IRecord::operator= (bug #95823)
  *rec2 = rec; // fix bug #95823
  m_payloadVector.push_back( m_payloadPtr );

  if ( TimingReportMgr::isActive() )
    TimingReportMgr::stopTimer( "cool::RelationalObject::ctor" );

}

//-----------------------------------------------------------------------------

const ValidityKey& RelationalObject::since() const
{
  return m_since;
}

//-----------------------------------------------------------------------------

const ValidityKey& RelationalObject::until() const
{
  return m_until;
}

//-----------------------------------------------------------------------------

const IRecord& RelationalObject::payload() const
{
  return *(m_payloadPtr.get());
}

//-----------------------------------------------------------------------------

IRecordIterator& RelationalObject::payloadIterator() const
{
  return m_payloadIterator;
}

//-----------------------------------------------------------------------------

const ChannelId& RelationalObject::channelId() const
{
  return m_channelId;
}

//-----------------------------------------------------------------------------

/*
const std::string& RelationalObject::channelName() const
{
  throw RelationalException
    ( "RelationalObject::channelName is not implemented yet" );
}
*///

//-----------------------------------------------------------------------------

const std::string& RelationalObject::userTagName() const
{
  return m_userTagName;
}

//-----------------------------------------------------------------------------

unsigned int RelationalObject::userTagId() const
{
  return m_userTagId;
}

//-----------------------------------------------------------------------------

bool RelationalObject::isStored() const
{
  return true;
}

//-----------------------------------------------------------------------------

unsigned int RelationalObject::objectId() const
{
  return m_objectId;
}

//-----------------------------------------------------------------------------

unsigned int RelationalObject::payloadId() const
{
  return m_payloadId;
}

//-----------------------------------------------------------------------------

unsigned int RelationalObject::payloadSetId() const
{
  return m_payloadSetId;
}

//-----------------------------------------------------------------------------

unsigned int RelationalObject::payloadSize() const
{
  return m_payloadSize;
}

//-----------------------------------------------------------------------------

const ITime& RelationalObject::insertionTime() const
{
  return m_insertionTime;
}

//-----------------------------------------------------------------------------
/*
const ValidityKey& RelationalObject::sinceOriginal() const
{
  return m_sinceOriginal;
}

//-----------------------------------------------------------------------------

const ValidityKey& RelationalObject::untilOriginal() const
{
  return m_untilOriginal;
}

//-----------------------------------------------------------------------------

const ITime& RelationalObject::insertionTimeOriginal() const
{
  return m_insertionTimeOriginal;
}
*///
//-----------------------------------------------------------------------------

std::ostream& RelationalObject::print( std::ostream& s ) const
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
