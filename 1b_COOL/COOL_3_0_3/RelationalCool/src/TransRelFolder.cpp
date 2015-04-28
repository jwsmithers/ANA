// First of all, enable or disable the COOL290 API extensions (see bug #92204)
#include "CoolKernel/VersionInfo.h"

// Local include files
#include "IteratorException.h"
#include "ObjectIteratorCounter.h"
#include "RelationalException.h"
#include "RelationalObjectIterator.h"
#include "TransRelFolder.h"
#include "TransRelObjectIterator.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

void TransRelFolder::setupStorageBuffer( bool useBuffer )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::setupStorageBuffer");
  bool doCommit=false;
  if ( !useBuffer && m_folder->useBuffer() )
    doCommit=true;
  m_folder->setupStorageBuffer( useBuffer );
  if ( doCommit && m_trans.get() )
  {
    // if bulk operations are switched off, a
    // possible remaining transaction is committed
    m_trans->commit();
    m_trans.reset( 0 );
  }
}

//-----------------------------------------------------------------------------

void TransRelFolder::flushStorageBuffer()
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::flushStorageBuffer");
  if ( !m_trans.get() )
    m_trans.reset( new RelationalTransaction( db().transactionMgr()  ));  // r/w

  try
  {
    m_folder->flushStorageBuffer();

    m_trans->commit();
    m_trans.reset( 0 );
  }
  catch ( ... )
  {
    // rollback transaction in case of any failure
    m_trans->rollback();
    m_trans.reset( 0 );
    throw;
  }
}

//-----------------------------------------------------------------------------

void TransRelFolder::storeObject( const ValidityKey& since,
                                  const ValidityKey& until,
                                  const IRecord& payload,
                                  const ChannelId& channelId,
                                  const std::string& userTagName,
                                  bool userTagOnly )
{
  if ( !m_folder->db().isOpen() )
    throw DatabaseNotOpen("TransRelFolder::storeObject");

  if (ObjectIteratorCounter::testIteratorActive(db().transactionMgr().get() ) )
    throw Exception("Cannot start a concurrent write transaction",
                    "TransRelFolder::storeObject");

  if ( !m_folder->useBuffer() && m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::storeObject");

  // if bulk operation is active but no transaction active
  // or single store operation is active start a transaction
  if ( ! m_folder->useBuffer() )
    m_trans.reset( new RelationalTransaction( db().transactionMgr() ) );  // r/w

  try {
    m_folder->storeObject( since,
                           until,
                           payload,
                           channelId,
                           userTagName,
                           userTagOnly);
  } catch (...)
  {
    if ( m_trans.get() ) {
      // on all exceptions, rollback transaction if active
      m_trans->rollback();
      m_trans.reset( 0 );
    }
    throw;
  }

  // commit transaction for single store operation
  if ( m_trans.get() )
  {
    m_trans->commit();
    m_trans.reset( 0 );
  }
}

//-----------------------------------------------------------------------------

#ifdef COOL290VP
void TransRelFolder::storeObject( const ValidityKey& since,
                                  const ValidityKey& until,
                                  const std::vector<IRecordPtr>& payload,
                                  const ChannelId& channelId,
                                  const std::string& userTagName,
                                  bool userTagOnly )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::storeObject");

  if (ObjectIteratorCounter::testIteratorActive(db().transactionMgr().get() ) )
    throw Exception("Cannot start a concurrent write transaction",
                    "TransRelFolder::storeObject");

  if ( !m_folder->useBuffer() && m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::storeObject");

  // if bulk operation is active but no transaction active
  // or single store operation is active start a transaction
  if ( !m_folder->useBuffer()  )
    m_trans.reset( new RelationalTransaction( db().transactionMgr() ) );  // r/w

  try {
    m_folder->storeObject( since,
                           until,
                           payload,
                           channelId,
                           userTagName,
                           userTagOnly);
  } catch (...)
  {
    if ( m_trans.get() ) {
      // on all exceptions, rollback transaction if active
      m_trans->rollback();
      m_trans.reset( 0 );
    }
    throw;
  }

  // commit transaction for single store operation
  if ( m_trans.get() )
  {
    m_trans->commit();
    m_trans.reset( 0 );
  }
}
#endif

//-----------------------------------------------------------------------------

#ifndef COOL300DP
void TransRelFolder::storeObject( const ValidityKey& since,
                                  const ValidityKey& until,
                                  const coral::AttributeList& payload,
                                  const ChannelId& channelId,
                                  const std::string& userTagName,
                                  bool userTagOnly )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::storeObject");

  if (ObjectIteratorCounter::testIteratorActive(db().transactionMgr().get() ) )
    throw Exception("Cannot start a concurrent write transaction",
                    "TransRelFolder::storeObject");

  if ( !m_folder->useBuffer() && m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::storeObject");

  // if bulk operation is active but no transaction active
  // or single store operation is active start a transaction
  if ( !m_folder->useBuffer()  )
    m_trans.reset( new RelationalTransaction( db().transactionMgr() ) );  // r/w

  try {
    m_folder->storeObject( since,
                           until,
                           payload,
                           channelId,
                           userTagName,
                           userTagOnly);
  } catch (...)
  {
    if ( m_trans.get() ) {
      // on all exceptions, rollback transaction if active
      m_trans->rollback();
      m_trans.reset( 0 );
    }
    throw;
  }

  // commit transaction for single store operation
  if ( m_trans.get() )
  {
    m_trans->commit();
    m_trans.reset( 0 );
  }
}
#endif

//-----------------------------------------------------------------------------

int TransRelFolder::truncateObjectValidity( const ValidityKey& until,
                                            const ChannelSelection& channels )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::truncateObjectValidity");
  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::truncateObjectValidity");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr() ) ); // r/w

  int retValue = m_folder->truncateObjectValidity( until, channels );

  trans->commit();
  return retValue;
}

//-----------------------------------------------------------------------------

IObjectPtr TransRelFolder::findObject( const ValidityKey& pointInTime,
                                       const ChannelId& channelId,
                                       const std::string& tagName ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::findObject");

  if ( ObjectIteratorCounter::testIteratorActive( db().transactionMgr().get() ) )
    throw TooManyIterators( "ObjectIteratorCounter" );

  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::findObject");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  IObjectPtr retValue = m_folder->findObject( pointInTime,
                                              channelId,
                                              tagName );


  trans->commit();
  return retValue;
}

//-----------------------------------------------------------------------------

IObjectIteratorPtr TransRelFolder::findObjects( const ValidityKey& pointInTime,
                                                const ChannelSelection& channels,
                                                const std::string& tagName ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::findObjects");

  if (ObjectIteratorCounter::testIteratorActive(db().transactionMgr().get() ) )
    throw TooManyIterators( "ObjectIteratorCounter" );

  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::findObjects");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  IObjectIteratorPtr retValue =
    m_folder->findObjects( pointInTime,
                           channels,
                           tagName );

  // if we pass back an active cursor, wrap the iterator in
  // atransaction aware class, giving it the controll over
  // the transaction
  if ( dynamic_cast<RelationalObjectIterator*>( retValue.get() ) )
  {
    retValue = IObjectIteratorPtr( new TransRelObjectIterator( retValue,
                                                               trans ) );
  }
  else trans->commit();

  return retValue;
}

//-----------------------------------------------------------------------------

IObjectIteratorPtr TransRelFolder::browseObjects( const ValidityKey& since,
                                                  const ValidityKey& until,
                                                  const ChannelSelection& channels,
                                                  const std::string& tagName,
                                                  const IRecordSelection* payloadQuery ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::browseObject");

  if (ObjectIteratorCounter::testIteratorActive( db().transactionMgr().get()) )
    throw TooManyIterators( "ObjectIteratorCounter" );

  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::browseObject");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  IObjectIteratorPtr retValue =
    m_folder->browseObjects( since,
                             until,
                             channels,
                             tagName,
                             payloadQuery );

  // if we pass back an active cursor, wrap the iterator in
  // a transaction aware class, giving it the controll over the
  // transaction.
  if ( dynamic_cast<RelationalObjectIterator*>( retValue.get() ) )
  {
    retValue = IObjectIteratorPtr( new TransRelObjectIterator( retValue,
                                                               trans ) );
  }
  else trans->commit();

  return retValue;
}

//-----------------------------------------------------------------------------
unsigned int TransRelFolder::countObjects( const ValidityKey& since,
                                           const ValidityKey& until,
                                           const ChannelSelection& channels,
                                           const std::string& tagName,
                                           const IRecordSelection* payloadQuery ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::countObjects");

  if ( ObjectIteratorCounter::testIteratorActive( db().transactionMgr().get() ) )
    throw TooManyIterators( "ObjectIteratorCounter" );

  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::countObjects");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  unsigned int retValue =
    m_folder->countObjects( since,
                            until,
                            channels,
                            tagName,
                            payloadQuery );


  trans->commit();
  return retValue;
}

//-----------------------------------------------------------------------------

void TransRelFolder::renamePayload( const std::string& oldName,
                                    const std::string& newName )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::renamePayload");
  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::renamePayload");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), false ) ); // r/w

  // this is a DDL and auto-commiting
  m_folder->renamePayload( oldName, newName );

  trans->commit();
}

//-----------------------------------------------------------------------------

void TransRelFolder::extendPayloadSpecification( const IRecord& record )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::extendPayloadSpecification");
  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::extendPayloadSpecification");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), false ) ); // r/w

  // this is a DDL and auto-commiting
  m_folder->extendPayloadSpecification( record );

  trans->commit();
}

//-----------------------------------------------------------------------------

void TransRelFolder::tagCurrentHead( const std::string& tagName,
                                     const std::string& description ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::tagCurrentHead");
  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::tagCurrentHead");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), false ) ); // r/w

  m_folder->tagCurrentHead( tagName, description );

  trans->commit();
}

//-----------------------------------------------------------------------------

void TransRelFolder::cloneTagAsUserTag( const std::string& tagName,
                                        const std::string& tagClone,
                                        const std::string& description,
                                        bool forceOverwriteTag )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::cloneTagAsUserTag");
  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::cloneTagAsUserTag");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), false ) ); // r/w

  m_folder->cloneTagAsUserTag( tagName,
                               tagClone,
                               description,
                               forceOverwriteTag );

  trans->commit();
}

//-----------------------------------------------------------------------------

void TransRelFolder::tagHeadAsOfDate( const ITime& asOfDate,
                                      const std::string& tagName,
                                      const std::string& description ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::tagHeadAsofDate");
  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::tagHeadAsOfDate");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), false ) ); // r/w

  m_folder->tagHeadAsOfDate( asOfDate, tagName, description );

  trans->commit();
}

//-----------------------------------------------------------------------------

const Time TransRelFolder::insertionTimeOfLastObjectInTag
( const std::string& tagName ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::insertionTimeOfLastObjectInTag");
  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::insertionTimeOfLastObjectInTag");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  const Time retValue = m_folder->insertionTimeOfLastObjectInTag( tagName );

  trans->commit();
  return retValue;
}

//-----------------------------------------------------------------------------

void TransRelFolder::deleteTag( const std::string& tagName )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::deleteTag");
  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::deleteTag");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), false ) ); // r/w

  m_folder->deleteTag( tagName );

  trans->commit();
}

//-----------------------------------------------------------------------------

bool TransRelFolder::existsUserTag( const std::string& tagName ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::existsUserTag");
  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::existsUserTag");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  bool retValue = m_folder->existsUserTag( tagName );

  trans->commit();
  return retValue;
}

//-----------------------------------------------------------------------------

const std::vector<ChannelId> TransRelFolder::listChannels( ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::listChannels");
  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::tagHeadAsOfDate");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  const std::vector<ChannelId> retValue = m_folder->listChannels( );

  trans->commit();
  return retValue;
}

//-----------------------------------------------------------------------------

const std::map<ChannelId,std::string> TransRelFolder::listChannelsWithNames( ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::listChannelsWithNames");
  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::listChannelsWithNames");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  const std::map<ChannelId,std::string> retValue =
    m_folder->listChannelsWithNames( );

  trans->commit();
  return retValue;
}

//-----------------------------------------------------------------------------

void TransRelFolder::createChannel( const ChannelId& channelId,
                                    const std::string& channelName,
                                    const std::string& description )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::createChannel");
  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::createChannel");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), false ) ); // r/w

  m_folder->createChannel( channelId, channelName, description );

  trans->commit();
}

//-----------------------------------------------------------------------------

bool TransRelFolder::dropChannel( const ChannelId& channelId )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::dropChannel");
  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::dropChannel");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), false ) ); // r/w

  bool retValue = m_folder->dropChannel( channelId );

  trans->commit();
  return retValue;
}

//-----------------------------------------------------------------------------

void TransRelFolder::setChannelName( const ChannelId& channelId,
                                     const std::string& channelName )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::setChannelName");
  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::setChannelName");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), false ) ); // r/w

  m_folder->setChannelName( channelId, channelName );

  trans->commit();
}

//-----------------------------------------------------------------------------

const std::string TransRelFolder::channelName( const ChannelId& channelId ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::channelName");
  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::channelName");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  const std::string retValue =
    m_folder->channelName( channelId );

  trans->commit();
  return retValue;
}

//-----------------------------------------------------------------------------

ChannelId TransRelFolder::channelId( const std::string& channelName ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::channelId");
  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::channelId");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  const ChannelId retValue =
    m_folder->channelId( channelName );

  trans->commit();
  return retValue;
}

//-----------------------------------------------------------------------------

bool TransRelFolder::existsChannel( const ChannelId& channelId ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::existsChannel");
  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::existsChannel");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  bool retValue =
    m_folder->existsChannel( channelId );

  trans->commit();
  return retValue;
}

//-----------------------------------------------------------------------------

bool TransRelFolder::existsChannel( const std::string& channelName ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::existsChannel");
  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::existsChannel");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  bool retValue =
    m_folder->existsChannel( channelName );

  trans->commit();
  return retValue;
}

//-----------------------------------------------------------------------------

void TransRelFolder::setChannelDescription( const ChannelId & channelId,
                                            const std::string& description )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::setChannelDescription");
  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::channelDescription");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), false ) ); // r/w

  m_folder->setChannelDescription( channelId, description );

  trans->commit();
}

//-----------------------------------------------------------------------------

const std::string TransRelFolder::channelDescription( const ChannelId & channelId ) const
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolder::channelDescription");
  if ( m_trans.get() )
    throw RelationalException("Transaction still active!",
                              "TransRelFolder::channelDescription");

  std::auto_ptr<RelationalTransaction> trans
    ( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  const std::string retValue =
    m_folder->channelDescription( channelId );

  trans->commit();
  return retValue;
}

//-----------------------------------------------------------------------------
