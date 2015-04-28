// Include files
#include "CoolKernel/InternalErrorException.h"
#include "CoolKernel/types.h"
#include "RelationalAccess/ICursor.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ITable.h"

// Local include files
//#include "attributeListToString.h"
#include "HvsTagRecord.h"
#include "IRelationalCursor.h"
#include "IRelationalQueryDefinition.h"
#include "IteratorException.h"
#include "ObjectIteratorCounter.h"
#include "RalQueryMgr.h"
#include "RelationalException.h"
#include "RelationalFolder.h"
#include "RelationalObject.h"
#include "RelationalObjectIterator.h"
#include "RelationalObjectTable.h"
#include "RelationalObjectTableRow.h"
#include "RelationalTagMgr.h"
#include "TimingReportMgr.h"
#include "scoped_enums.h"

// Namespace
using namespace cool;

//---------------------------------------------------------------------------

RelationalObjectIterator::RelationalObjectIterator
( const boost::shared_ptr<ISessionMgr>& sessionMgr,
  const RelationalQueryMgr& /*queryMgr*/,
  const boost::shared_ptr<IRelationalTransactionMgr>& transactionMgr,
  const RelationalTagMgr& tagMgr,
  const RelationalFolder& folder,
  const ValidityKey& since,
  const ValidityKey& until,
  const ChannelSelection& channels,
  const std::string& tagName,
  bool isUserTag,
  const IRecordSelection* payloadQuery,
  const bool countOnly )
  : m_isTimingActive( isTimingActive() )
  , m_transactionMgr( transactionMgr.get() )
  , m_isRegistered( false )
  , m_sessionMgr( sessionMgr )
    //, m_queryMgr( queryMgr.clone() )
  , m_queryMgr( new RalQueryMgr( *m_sessionMgr ) )
  , m_objectTable( new RelationalObjectTable( *m_queryMgr, folder ) )
  , m_versioningMode( folder.versioningMode() )
  , m_dataBuffer( new coral::AttributeList() )
  , m_since(since)
  , m_until(until)
  , m_channels(channels)
  , m_tagName(tagName)
  , m_isUserTag(isUserTag)
  , m_selection( payloadQuery != 0 ? payloadQuery->clone() : 0 )
  , m_pq( payloadQuery != 0 ?
          new RelationalPayloadQuery( *m_selection.get() ) : 0 )
  , m_queryDef( ( m_selection.get() !=0 && m_pq->isTrusted() ) ?
                getQueryDefinition( since, until, channels, tagName, isUserTag, m_selection.get() ) :
                getQueryDefinition( since, until, channels, tagName, isUserTag, 0 ) )
  , m_sizeKnown( false )
  , m_size( 0 )
  , m_currentObject( 0 )
  , m_payloadMode( folder.payloadMode() )
{
  //std::cout << "RelationalObjectIterator ctor " << this << std::endl;

  if ( countOnly )
  {
    m_state = COUNTONLY;
  }
  else
  {
    m_cursor.reset( m_queryMgr->prepareAndExecuteQuery( *m_queryDef, m_dataBuffer ) );
    //std::cout << "cool::RelationalObjectIterator uses adapter to buffer " << m_dataBuffer.get() << std::endl;
    //coral::AttributeList& outputDataBuffer = *(m_dataBuffer.get());
    //std::cout << "cool::RelationalObjectIterator Attribute#0 is " << &(outputDataBuffer[0]) << std::endl;
    //for ( unsigned int i = 0; i < outputDataBuffer.size(); ++i )
    //  std::cout << "AL "<<&outputDataBuffer<<" #"<<i<<" is " << &(outputDataBuffer[i]) << std::endl;
    m_currentRowAdapter.reset
      ( new ConstRelationalObjectAdapter( *this,
                                          *m_dataBuffer,
                                          folder.payloadSpecification(),
                                          folder.payloadMode() ) );
    m_state = ACTIVE;
  }

  // Marco: this needs to be here to avoid the registration of the iterator
  // if an exception occurs in the initialization statements (bug #25256).
  ObjectIteratorCounter::registerIterator( this, m_transactionMgr );
  m_isRegistered = true;

  // After starting the transaction, check that the tag exists
  // Throw TagNotFound if the tag does not exist in this folder
  if ( ! IHvsNode::isHeadTag( tagName ) )
  {
    try
    {
      // Throws TagNotFound if tag does not exist
      tagMgr.findTagRecord( folder.id(), tagName );
    }
    catch ( ... )
    {
      // Release any associated server resources and unregister the iterator
      bool rollback = true;
      close( rollback );
      throw;
    }
  }

  if ( m_isTimingActive )
    TimingReportMgr::stopTimer
      ( "cool::RelationalObjectIterator::ctor" );

  if ( m_pq.get() != 0  && m_payloadMode == cool_PayloadMode_Mode::VECTORPAYLOAD )
    throw RelationalException( "sorry, payload queries currently don't work"
                               " with vector folders",
                               "RelationalObjectIterator");
}

//---------------------------------------------------------------------------

RelationalObjectIterator::~RelationalObjectIterator()
{
  //std::cout << "RelationalObjectIterator dtor " << this << std::endl;

  // Move the iterator into the Closed state.
  close();

  //if ( m_isTimingActive )
  //  TimingReportMgr::stopTimer
  //    ( "cool::RelationalObjectIterator [LIFETIME]" );
}

//---------------------------------------------------------------------------

bool RelationalObjectIterator::isTimingActive() const
{
  if ( TimingReportMgr::isActive() )
  {
    TimingReportMgr::startTimer
      ( "cool::RelationalObjectIterator::ctor" );
    //TimingReportMgr::startTimer
    //  ( "cool::RelationalObjectIterator [LIFETIME]" );
    return true;
  }
  else return false;
}

//-----------------------------------------------------------------------------

bool RelationalObjectIterator::isEmpty()
{
  if ( m_currentObject > 0 ) return false;
  return size() == 0;
}

//---------------------------------------------------------------------------

const IObject& RelationalObjectIterator::currentRef()
{
  // Iterator is in the CountOnly state
  if ( m_state == COUNTONLY )
  {
    throw InternalErrorException( "PANIC! Iterator can be used only for counting",
                                  "RelationalObjectIterator" );
  }

  // Iterator is in the Closed state
  else if ( m_state == CLOSED )
  {
    throw IteratorIsClosed( "RelationalObjectIterator" );
  }

  // Iterator is in the Started state
  // [next() has not been called yet and/or the iterator is empty].
  else if ( m_currentObject == 0 || m_state == END_OF_ROWS )
  {
    throw IteratorHasNoCurrentItem( "RelationalObjectIterator" );
  }

  // Iterator is in the Active state
  else
  {
    if ( m_isTimingActive )
    {
      TimingReportMgr::startTimer
        ( "cool::RelationalObjectIterator::currentRef" );
      TimingReportMgr::stopTimer
        ( "cool::RelationalObjectIterator::currentRef" );
    }
    return *m_currentRowAdapter;
  }
}

//---------------------------------------------------------------------------

bool RelationalObjectIterator::goToNext()
{
  //std::cout << "cool::RelationalObjectIterator::goToNext" << std::endl;
  if ( m_state == COUNTONLY )
    throw InternalErrorException( "PANIC! Iterator can be used only for counting",
                                  "RelationalObjectIterator" );

  if ( m_isTimingActive )
    TimingReportMgr::startTimer
      ( "cool::RelationalObjectIterator::goToNext()" );

  // Iterator is in the Closed state
  if ( m_state == CLOSED )
  {
    if ( m_isTimingActive )
      TimingReportMgr::stopTimer
        ( "cool::RelationalObjectIterator::goToNext()" );
    throw IteratorIsClosed( "RelationalObjectIterator" );
  }

  // Iterator (Started or Active) has a non-null next object
  else if ( m_payloadMode == cool_PayloadMode_Mode::VECTORPAYLOAD )
  {
    ConstRecordIterator *recordIt = dynamic_cast<ConstRecordIterator*>
      (&m_currentRowAdapter->payloadIterator());
    if ( recordIt == 0 )
      throw PanicException("currentRowAdapter->payloadIterator is not of type"
                           " ConstRecordIterator!",
                           "RelationalObjectIterator::goToNext()");
    bool gotNext= recordIt->nextPayloadSet();

    if ( !gotNext )
      m_state = END_OF_ROWS;
    if ( m_isTimingActive )
      TimingReportMgr::stopTimer
        ( "cool::RelationalObjectIterator::goToNext()" );
    return gotNext;
  }
  else
  {
    bool gotNext = fetchNext();
    if ( !gotNext )
      m_state = END_OF_ROWS;
    if ( m_isTimingActive )
      TimingReportMgr::stopTimer
        ( "cool::RelationalObjectIterator::goToNext()" );
    return gotNext;
  }
  // No path to this statement: fix Coverity UNREACHABLE
  //throw PanicException( "goToNext() unhandled mode",
  //                      "RelationalObjectIterator" );
}

//---------------------------------------------------------------------------

unsigned int RelationalObjectIterator::size()
{
  //std::cout << "RelationalObjectIterator::size()" << std::endl;
  // Iterator is in the Closed state
  if ( m_state == CLOSED )
  {
    throw IteratorIsClosed( "RelationalObjectIterator" );
  }
  else if ( m_selection.get()!=0 && !m_pq->isTrusted() )
  {
    // NB This makes sense also for COUNTONLY iterators...
    throw RelationalException
      ( "Size is not known since the payload query is not trusted",
        "RelationalObjectIterator" );
  }
  // Iterator is in the NotStarted, Started or Active state
  else if ( !m_sizeKnown )
  {
    // size is requested for the first time, so fetch it
    m_sizeKnown = true;
    m_size = getSize( m_since, m_until, m_channels, m_tagName, m_isUserTag, m_selection.get() );
  }
  //std::cout << "RelationalObjectIterator::size() is " << m_size << std::endl;
  return m_size;
}

//---------------------------------------------------------------------------

const IObjectVectorPtr RelationalObjectIterator::fetchAllAsVector()
{
  if ( m_state == COUNTONLY )
    throw InternalErrorException( "PANIC! Iterator can be used only for counting",
                                  "RelationalObjectIterator" );

  // Iterator is in the Closed state
  if ( m_state == CLOSED )
  {
    throw IteratorIsClosed( "RelationalObjectIterator" );
  }

  // Iterator is in the Started state
  else if ( m_currentObject == 0 )
  {
    IObjectVectorPtr objects( new IObjectVector() );
    if ( m_isTimingActive )
      TimingReportMgr::startTimer
        ( "cool::RelationalObjectIterator::fetchAllAsVec()" );
    while( goToNext() )
    {
      //std::cout << "cool::RelationalObjectIterator::fetchAllAsVector:\n push next object:" << currentRef() << std::endl;
      objects->push_back( IObjectPtr( currentRef().clone() ) );
    }
    if ( m_isTimingActive )
      TimingReportMgr::stopTimer
        ( "cool::RelationalObjectIterator::fetchAllAsVec()" );
    return objects;
  }

  // Iterator is in the Active state
  else
  {
    throw IteratorIsActive( "RelationalObjectIterator" );
  }
}

//---------------------------------------------------------------------------

void RelationalObjectIterator::close( bool /*rollback*/ )
{
  //std::cout << "RelationalObjectIterator close() " << this << std::endl;

  // Iterator is not already in the Closed state
  if (  m_state != CLOSED )
  {
    // Delete the cursor and release all associated database resources
    std::auto_ptr<IRelationalCursor> nullCursor;
    m_cursor = nullCursor;

    /*
    // This was removed in task #3271: ok or not ok?
    // Commit and delete the read-only transaction
    if ( m_transaction )
    {
      if ( ! rollback ) m_transaction->commit();
      else m_transaction->rollback();
      delete m_transaction;
      m_transaction = 0;
    }
    *///

    // Move the iterator into the Closed state
    m_state = CLOSED;

    // Unregister the iterator
    ObjectIteratorCounter::unregisterIterator( this, m_transactionMgr );
  }
}

//---------------------------------------------------------------------------

unsigned int
RelationalObjectIterator::getSize( const ValidityKey& since,
                                   const ValidityKey& until,
                                   const ChannelSelection& channels,
                                   const std::string& tagName,
                                   bool isUserTag,
                                   const IRecordSelection* payloadQuery ) const
{
  unsigned int size;
  if ( m_versioningMode == cool_FolderVersioning_Mode::SINGLE_VERSION )
  {
    if ( ! IHvsNode::isHeadTag( tagName ) )
      throw RelationalException
        ( "Single version folder: browsing within a non-null tag '"
          + tagName + "' makes no sense", "RelationalObjectIterator" );
    const std::auto_ptr<IRelationalQueryDefinition>
      def( m_objectTable->queryDefinitionSV
           ( since, until, channels, payloadQuery, false, payloadQuery != 0 ) );
    // don't fetch payload, otherwise vector folder count will be wrong
    // but only if there is no payload query
    size = m_queryMgr->countRows( *def, "SV object count" );
  }
  else if ( m_versioningMode == cool_FolderVersioning_Mode::MULTI_VERSION )
  {
    if ( isUserTag )
    {
      const std::auto_ptr<IRelationalQueryDefinition>
        def( m_objectTable->queryDefinitionHeadAndUserTag
             ( since, until, channels, tagName, payloadQuery, false,
               payloadQuery != 0 ) );
      // don't fetch payload, otherwise vector folder count will be wrong
      // but only if there is no payload query
      size = m_queryMgr->countRows( *def, "MV userTag object count" );
    }
    else if ( IHvsNode::isHeadTag( tagName ) )
    {
      const std::auto_ptr<IRelationalQueryDefinition>
        def( m_objectTable->queryDefinitionHeadAndUserTag
             ( since, until, channels, tagName, payloadQuery, false,
               payloadQuery != 0 ) );
      // don't fetch payload, otherwise vector folder count will be wrong
      // but only if there is no payload query
      size = m_queryMgr->countRows( *def, "MV headTag object count" );
    }
    else
    {
      const std::auto_ptr<IRelationalQueryDefinition>
        def( m_objectTable->queryDefinitionTag
             ( since, until, channels, tagName, payloadQuery, false,
               payloadQuery != 0 ) );
      // don't fetch payload, otherwise vector folder count will be wrong
      // but only if there is no payload query
      size = m_queryMgr->countRows( *def, "MV tag object count" );
    }
  }
  else
  {
    std::stringstream s;
    s << "Object count not supported for this folder type: "
      << m_versioningMode;
    throw RelationalException( s.str(), "RelationalObjectIterator" );
  }
  return size;
}

//---------------------------------------------------------------------------

bool RelationalObjectIterator::optimizeClobs()
{
  // Optimize CLOB retrieval (fix bug #51429)
  // only if env is not set and backend is oracle
  static bool optimizeClobsEnv = ( getenv( "COOL_DONT_FETCH_CLOBS_AS_CHAR" ) == 0 );
  return optimizeClobsEnv && ( m_queryMgr->databaseTechnology() == "Oracle" );
}

//---------------------------------------------------------------------------

std::auto_ptr<IRelationalQueryDefinition>
RelationalObjectIterator::getQueryDefinition( const ValidityKey& since,
                                              const ValidityKey& until,
                                              const ChannelSelection& channels,
                                              const std::string& tagName,
                                              bool isUserTag,
                                              const IRecordSelection* payloadQuery )
{
  // --- SINGLE VERSION ---
  if ( m_versioningMode == cool_FolderVersioning_Mode::SINGLE_VERSION )
  {
    if ( ! IHvsNode::isHeadTag( tagName ) )
      throw RelationalException
        ( "Single version folder: browsing within a non-null tag '"
          + tagName + "' makes no sense", "RelationalObjectIterator" );
    std::auto_ptr<IRelationalQueryDefinition>
      def( m_objectTable->queryDefinitionSV
           ( since, until, channels, payloadQuery,
             optimizeClobs() ) );
    return def;
  }

  // --- MULTI VERSION ---
  else
  {
    if ( IHvsNode::isHeadTag( tagName ) )
    { // MV HEAD
      std::auto_ptr<IRelationalQueryDefinition>
        def( m_objectTable->queryDefinitionHeadAndUserTag
             ( since, until, channels, "HEAD", payloadQuery,
               optimizeClobs() ) );
      return def;
    }
    else if ( isUserTag )
    { // MV User Tag
      std::auto_ptr<IRelationalQueryDefinition>
        def( m_objectTable->queryDefinitionHeadAndUserTag
             ( since, until, channels, tagName, payloadQuery,
               optimizeClobs() ) );
      return def;
    }
    else
    { // MV Tag
      std::auto_ptr<IRelationalQueryDefinition>
        def( m_objectTable->queryDefinitionTag
             ( since, until, channels, tagName, payloadQuery,
               optimizeClobs() ) );
      return def;
    }
  }
}

//---------------------------------------------------------------------------

bool RelationalObjectIterator::fetchNext()
{
  if ( m_state == COUNTONLY )
    throw InternalErrorException( "PANIC! Iterator can be used only for counting",
                                  "RelationalObjectIterator" );

  // Iterator is in the Closed state (???)
  if ( m_state == CLOSED )
    throw InternalErrorException( "PANIC! The iterator is closed!?",
                                  "RelationalObjectIterator" );

  bool client_side_pq = m_selection.get()!=0 && !m_pq->isTrusted();
  // If there is a payload selection (m_selection), fetch objects
  // until one satisfies the selection or we have no more objects
  do
  {
    if ( !m_cursor->next() )
      // end of cursor
      return false;

    m_currentObject++;

    // if we fetched clobs as char 4000, we have to check the length of
    // the clobs and if longer than 4000 char get it again in full length
    m_queryDef->checkLengthClobs( m_dataBuffer.get() , m_queryMgr.get() );
  }
  while ( client_side_pq && !m_selection->select( currentRef().payload() ) );

  return true;
}

//---------------------------------------------------------------------------
