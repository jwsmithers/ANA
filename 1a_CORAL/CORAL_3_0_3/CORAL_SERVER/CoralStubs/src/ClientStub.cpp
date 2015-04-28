// Include files
#include <iostream>
#include <sstream>
#include "CoralMonitor/ScopedTimer.h"
#include "CoralServerBase/IRequestHandler.h"
#include "CoralServerBase/RequestProperties.h"
#include "CoralStubs/ClientStub.h"

// Local include files
#include "CALProtocol.h"
#include "CppTypes.h"
#include "Exceptions.h"
#include "RowIteratorAll.h"
#include "RowIteratorFetch.h"
#include "SegmentWriterIterator.h"
#include "SegmentReaderIterator.h"

// Logger
#define LOGGER_NAME "CoralStubs::ClientStub"
#include "logger.h"

// Namespace
using namespace coral::CoralStubs;

//-----------------------------------------------------------------------------

ClientStub::ClientStub( IRequestHandler& requestHandler )
  : m_requestHandler( requestHandler )
{
}

//-----------------------------------------------------------------------------

ClientStub::~ClientStub()
{
}

//-----------------------------------------------------------------------------

void
ClientStub::setCertificateData( const ICertificateData* /*cert*/ )
{
  // DUMMY ???
}

//-----------------------------------------------------------------------------

coral::Token
ClientStub::connect( const std::string& dbUrl,
                     const AccessMode mode,
                     bool& fromProxy ) const
{
  SCOPED_TIMER( "ClientStub::connect" );
  CALOpcode opcode = ( mode == coral::ReadOnly ?
                       CALOpcodes::ConnectRO :
                       CALOpcodes::ConnectRW );
  //create the request buffer object as cacheable and no reply
  std::auto_ptr<SegmentWriterIterator> swi(new SegmentWriterIterator(opcode, true, false));
  swi->append16( dbUrl );
  swi->flush();
  //call request handler with empty properties and transfer swi ownership
  IByteBufferIteratorPtr reply = m_requestHandler.replyToRequest( IByteBufferIteratorPtr( swi.release() ), RequestProperties() );
  //create the response buffer object
  SegmentReaderIterator sri( opcode, *reply );
  Token mytoken;
  sri.extract(mytoken);
  fromProxy = sri.proxy();
  return mytoken;
}

//-----------------------------------------------------------------------------

void
ClientStub::releaseSession( Token sessionID ) const
{
  SCOPED_TIMER( "ClientStub::releaseSession" );
  //create the request buffer object as no cacheable and no reply
  std::auto_ptr<SegmentWriterIterator> swi(new SegmentWriterIterator(CALOpcodes::Disconnect, false, false));
  swi->append( sessionID );
  swi->flush();
  //call request handler with empty properties and transfer swi ownership
  IByteBufferIteratorPtr reply = m_requestHandler.replyToRequest( IByteBufferIteratorPtr( swi.release() ), RequestProperties() );
  //create the response buffer object
  SegmentReaderIterator sri( CALOpcodes::Disconnect, *reply );
  //use empty instead of noextract to prevent
  //exception in the case of empty content
  sri.empty();
}

//-----------------------------------------------------------------------------

void
ClientStub::startTransaction( Token sessionID, bool readOnly ) const
{
  SCOPED_TIMER( "ClientStub::startTransaction" );
  CALOpcode opcode = ( readOnly ?
                       CALOpcodes::StartTransactionRO :
                       CALOpcodes::StartTransactionRW );
  //create the request buffer object as no cacheable and no reply
  std::auto_ptr<SegmentWriterIterator> swi(new SegmentWriterIterator(opcode, false, false));
  swi->append( sessionID );
  swi->flush();
  //call request handler with empty properties and transfer swi ownership
  IByteBufferIteratorPtr reply = m_requestHandler.replyToRequest( IByteBufferIteratorPtr( swi.release() ), RequestProperties() );
  //create the response buffer object
  SegmentReaderIterator sri( opcode, *reply );
  //use empty instead of noextract to prevent
  //exception in the case of empty content
  sri.empty();
}

//-----------------------------------------------------------------------------

void
ClientStub::commitTransaction( Token sessionID ) const
{
  SCOPED_TIMER( "ClientStub::commitTransaction" );
  //create the request buffer object as no cacheable and no reply
  std::auto_ptr<SegmentWriterIterator> swi(new SegmentWriterIterator(CALOpcodes::CommitTransaction, false, false));
  swi->append( sessionID );
  swi->flush();
  //call request handler with empty properties and transfer swi ownership
  IByteBufferIteratorPtr reply = m_requestHandler.replyToRequest( IByteBufferIteratorPtr( swi.release() ), RequestProperties() );
  //create the response buffer object
  SegmentReaderIterator sri( CALOpcodes::CommitTransaction, *reply );
  //use empty instead of noextract to prevent
  //exception in the case of empty content
  sri.empty();
}

//-----------------------------------------------------------------------------

void
ClientStub::rollbackTransaction( Token sessionID ) const
{
  SCOPED_TIMER( "ClientStub::rollbackTransaction" );
  //create the request buffer object as no cacheable and no reply
  std::auto_ptr<SegmentWriterIterator> swi(new SegmentWriterIterator(CALOpcodes::RollbackTransaction, false, false));
  swi->append( sessionID );
  swi->flush();
  //call request handler with empty properties and transfer swi ownership
  IByteBufferIteratorPtr reply = m_requestHandler.replyToRequest( IByteBufferIteratorPtr( swi.release() ), RequestProperties() );
  //create the response buffer object
  SegmentReaderIterator sri( CALOpcodes::RollbackTransaction, *reply );
  //use empty instead of noextract to prevent
  //exception in the case of empty content
  sri.empty();
}

//-----------------------------------------------------------------------------

const std::vector<std::string>
ClientStub::fetchSessionProperties( Token sessionID ) const
{
  SCOPED_TIMER( "ClientStub::fetchSessionProperties" );
  //create the request buffer object as cacheable and no reply
  std::auto_ptr<SegmentWriterIterator> swi(new SegmentWriterIterator(CALOpcodes::FetchSessionProperties, true, false));
  swi->append( sessionID );
  swi->flush();
  //call request handler with empty properties and transfer swi ownership
  IByteBufferIteratorPtr reply = m_requestHandler.replyToRequest( IByteBufferIteratorPtr( swi.release() ), RequestProperties() );
  //create the response buffer object
  SegmentReaderIterator sri( CALOpcodes::FetchSessionProperties, *reply );
  //create a new set
  std::vector<std::string> ret;
  sri.extract( ret );
  return ret;
}

//-----------------------------------------------------------------------------

coral::IRowIteratorPtr
ClientStub::fetchRows( Token sessionID,
                       const QueryDefinition& qd,
                       AttributeList* pRowBuffer,
                       unsigned int rowCacheSize,
                       unsigned int memoryCacheSize ) const
{
  SCOPED_TIMER( "ClientStub::fetchRowsOB" );
  //create the request buffer object as cacheable and no reply
  std::auto_ptr<SegmentWriterIterator> swi(new SegmentWriterIterator(CALOpcodes::FetchRows, true, false));
  swi->append( sessionID );
  swi->append( qd );
  swi->append( (uint32_t)rowCacheSize );
  swi->append( (uint32_t)memoryCacheSize );
  //check if we have an empty AttributeList
  if(pRowBuffer)
  {
    swi->append(true);
    swi->appendE(*pRowBuffer);
  }
  else
  {
    swi->append(false);
  }
  swi->flush();
  //call request handler with empty properties and transfer swi ownership
  IByteBufferIteratorPtr reply = m_requestHandler.replyToRequest( IByteBufferIteratorPtr( swi.release() ), RequestProperties() );
  //create the response buffer object
  SegmentReaderIterator sri( CALOpcodes::FetchRows, *reply );
  //create a new set
  uint32_t cursorID;
  sri.extract( cursorID );
  RowIteratorFetch* tfetch = new RowIteratorFetch(m_requestHandler, cursorID, pRowBuffer);
  //return the iterator packed into a smart pointer
  return std::auto_ptr<IRowIterator>(tfetch);
}

//-----------------------------------------------------------------------------

coral::IRowIteratorPtr
ClientStub::fetchRows( Token sessionID,
                       const QueryDefinition& qd,
                       const std::map< std::string, std::string > outputTypes,
                       unsigned int rowCacheSize,
                       unsigned int memoryCacheSize ) const
{
  SCOPED_TIMER( "ClientStub::fetchRowsOT" );
  logger << Debug << "fetchRows" << endlog;
  //create the request buffer object as cacheable and no reply
  std::auto_ptr<SegmentWriterIterator> swi(new SegmentWriterIterator(CALOpcodes::FetchRowsOT, true, false));
  swi->append( sessionID );
  swi->append( qd );
  swi->append( (uint32_t)rowCacheSize );
  swi->append( (uint32_t)memoryCacheSize );
  swi->append( outputTypes );
  swi->flush();
  //call request handler with empty properties and transfer swi ownership
  IByteBufferIteratorPtr reply = m_requestHandler.replyToRequest( IByteBufferIteratorPtr( swi.release() ), RequestProperties() );
  //create the response buffer object
  SegmentReaderIterator sri( CALOpcodes::FetchRowsOT, *reply );
  //create a new set
  uint32_t cursorID;
  sri.extract( cursorID );
  RowIteratorFetch* tfetch = new RowIteratorFetch(m_requestHandler, cursorID, NULL);
  //return the iterator packed into a smart pointer
  return std::auto_ptr<IRowIterator>(tfetch);
}

//-----------------------------------------------------------------------------

coral::IRowIteratorPtr
ClientStub::fetchAllRows( Token sessionID,
                          const QueryDefinition& qd,
                          AttributeList* rowBuffer ) const
{
  SCOPED_TIMER( "ClientStub::fetchAllRowsOB" );
  //create the request buffer object as cacheable and no reply
  std::auto_ptr<SegmentWriterIterator> swi(new SegmentWriterIterator(CALOpcodes::FetchAllRows, true, false));
  swi->append( sessionID );
  swi->append( qd );
  if(rowBuffer)
  {
    logger << Debug << "fetchAllRows with rowBuffer" << endlog;
    if(rowBuffer->size() > 0)
    {
      swi->append( true );
      swi->appendE( *rowBuffer );
    }
    else
      swi->append( false );
  }
  else
  {
    logger << Debug << "fetchAllRows with NONE rowBuffer" << endlog;
    swi->append( false );
  }
  swi->flush();
  //call request handler with empty properties and transfer swi ownership
  IByteBufferIteratorPtr reply = m_requestHandler.replyToRequest( IByteBufferIteratorPtr( swi.release() ), RequestProperties() );
  RowIteratorAll* tall = new RowIteratorAll( reply, rowBuffer, CALOpcodes::FetchAllRows );
  return std::auto_ptr<IRowIterator>(tall);
}

//-----------------------------------------------------------------------------

coral::IRowIteratorPtr
ClientStub::fetchAllRows( Token sessionID,
                          const QueryDefinition& qd,
                          const std::map< std::string, std::string > outputTypes ) const
{
  SCOPED_TIMER( "ClientStub::fetchAllRowsOT" );
  //create the request buffer object as cacheable and no reply
  std::auto_ptr<SegmentWriterIterator> swi(new SegmentWriterIterator(CALOpcodes::FetchAllRowsOT, true, false));
  swi->append( sessionID );
  swi->append( qd );
  swi->append( outputTypes );
  swi->flush();
  //call request handler with empty properties and transfer swi ownership
  IByteBufferIteratorPtr reply = m_requestHandler.replyToRequest( IByteBufferIteratorPtr( swi.release() ), RequestProperties() );
  RowIteratorAll* tall = new RowIteratorAll( reply, NULL, CALOpcodes::FetchAllRowsOT );
  return std::auto_ptr<IRowIterator>(tall);
}

//-----------------------------------------------------------------------------

const std::set<std::string>
ClientStub::listTables( Token sessionID,
                        const std::string& schemaName ) const
{
  SCOPED_TIMER( "ClientStub::listTables" );
  //create the request buffer object as cacheable and no reply
  std::auto_ptr<SegmentWriterIterator> swi(new SegmentWriterIterator(CALOpcodes::ListTables, true, false));
  swi->append( sessionID );
  swi->append16( schemaName );
  swi->flush();
  //call request handler with empty properties and transfer swi ownership
  IByteBufferIteratorPtr reply = m_requestHandler.replyToRequest( IByteBufferIteratorPtr( swi.release() ), RequestProperties() );
  //create the response buffer object
  SegmentReaderIterator sri( CALOpcodes::ListTables, *reply );
  //create a new set
  std::set<std::string> myset;
  sri.extract( myset );
  //return the set
  return myset;
}

//-----------------------------------------------------------------------------

bool ClientStub::existsTable( Token sessionID,
                              const std::string& schemaName,
                              const std::string& tableName ) const
{
  SCOPED_TIMER( "ClientStub::existsTable" );
  //create the request buffer object as cacheable and no reply
  std::auto_ptr<SegmentWriterIterator> swi(new SegmentWriterIterator(CALOpcodes::TableExists, true, false));
  swi->append( sessionID );
  swi->append16( schemaName );
  swi->append16( tableName );
  swi->flush();
  //call request handler with empty properties and transfer swi ownership
  IByteBufferIteratorPtr reply = m_requestHandler.replyToRequest( IByteBufferIteratorPtr( swi.release() ), RequestProperties() );
  //create the response buffer object
  SegmentReaderIterator sri( CALOpcodes::TableExists, *reply );
  //create a new set
  bool exists;
  sri.extract( exists );
  //return the set
  return exists;
}

//-----------------------------------------------------------------------------

const coral::TableDescription
ClientStub::fetchTableDescription( Token sessionID,
                                   const std::string& schemaName,
                                   const std::string& tableName ) const
{
  SCOPED_TIMER( "ClientStub::fetchTableDescription" );
  //create the request buffer object as cacheable and no reply
  std::auto_ptr<SegmentWriterIterator> swi(new SegmentWriterIterator(CALOpcodes::FetchTableDescription, true, false));
  swi->append( sessionID );
  swi->append16( schemaName );
  swi->append16( tableName );
  swi->flush();
  //call request handler with empty properties and transfer swi ownership
  IByteBufferIteratorPtr reply = m_requestHandler.replyToRequest( IByteBufferIteratorPtr( swi.release() ), RequestProperties() );
  //create the response buffer object
  SegmentReaderIterator sri( CALOpcodes::FetchTableDescription, *reply );
  //create a new set
  TableDescription td;
  sri.extract( td );
  //return the set
  return td;
}

//-----------------------------------------------------------------------------

const std::set<std::string>
ClientStub::listViews( Token sessionID,
                       const std::string& schemaName ) const
{
  SCOPED_TIMER( "ClientStub::listViews" );
  //create the request buffer object as cacheable and no reply
  std::auto_ptr<SegmentWriterIterator> swi(new SegmentWriterIterator(CALOpcodes::ListViews, true, false));
  swi->append( sessionID );
  swi->append16( schemaName );
  swi->flush();
  //call request handler with empty properties and transfer swi ownership
  IByteBufferIteratorPtr reply = m_requestHandler.replyToRequest( IByteBufferIteratorPtr( swi.release() ), RequestProperties() );
  //create the response buffer object
  SegmentReaderIterator sri( CALOpcodes::ListViews, *reply );
  //create a new set
  std::set<std::string> myset;
  sri.extract( myset );
  //return the set
  return myset;
}

//-----------------------------------------------------------------------------

bool ClientStub::existsView( Token sessionID,
                             const std::string& schemaName,
                             const std::string& viewName ) const
{
  SCOPED_TIMER( "ClientStub::existsView" );
  //create the request buffer object as cacheable and no reply
  std::auto_ptr<SegmentWriterIterator> swi(new SegmentWriterIterator(CALOpcodes::ViewExists, true, false));
  swi->append( sessionID );
  swi->append16( schemaName );
  swi->append16( viewName );
  swi->flush();
  //call request handler with empty properties and transfer swi ownership
  IByteBufferIteratorPtr reply = m_requestHandler.replyToRequest( IByteBufferIteratorPtr( swi.release() ), RequestProperties() );
  //create the response buffer object
  SegmentReaderIterator sri( CALOpcodes::ViewExists, *reply );
  //create a new set
  bool exists;
  sri.extract( exists );
  //return the set
  return exists;
}

//-----------------------------------------------------------------------------

const std::pair< coral::TableDescription , std::string >
ClientStub::fetchViewDescription( Token sessionID,
                                  const std::string& schemaName,
                                  const std::string& viewName ) const
{
  SCOPED_TIMER( "ClientStub::fetchViewDescription" );
  //create the request buffer object as cacheable and no reply
  std::auto_ptr<SegmentWriterIterator> swi(new SegmentWriterIterator(CALOpcodes::FetchViewDescription, true, false));
  swi->append( sessionID );
  swi->append16( schemaName );
  swi->append16( viewName );
  swi->flush();
  //call request handler with empty properties and transfer swi ownership
  IByteBufferIteratorPtr reply = m_requestHandler.replyToRequest( IByteBufferIteratorPtr( swi.release() ), RequestProperties() );
  //create the response buffer object
  SegmentReaderIterator sri( CALOpcodes::FetchViewDescription, *reply );
  //create a new set
  TableDescription td;
  sri.extract( td );
  std::string alias;
  sri.extract16( alias );
  //return the set
  return std::pair< TableDescription , std::string >(td, alias);
}

//-----------------------------------------------------------------------------

int
ClientStub::deleteTableRows( Token /*sessionID*/,
                             const std::string& /*schemaName*/,
                             const std::string& /*tableName*/,
                             const std::string& /*whereClause*/,
                             const std::string& /*whereData*/ ) const
{
  //SCOPED_TIMER( "ClientStub::deleteTableRows" );
  throw StubsException( "ClientStub::deleteTableRows, This function is not available" );
}

//-----------------------------------------------------------------------------

const std::string
ClientStub::formatRowBufferAsString( Token /*sessionID*/,
                                     const std::string& /*schemaName*/,
                                     const std::string& /*tableName*/ ) const
{
  //SCOPED_TIMER( "ClientStub::formatRowsBufferAS" );
  throw StubsException( "ClientStub::formatRowBufferAsString, This function is not available" );
}

//-----------------------------------------------------------------------------

void
ClientStub::insertRowAsString( Token /*sessionID*/,
                               const std::string& /*schemaName*/,
                               const std::string& /*tableName*/,
                               const std::string& /*rowBufferAS*/ ) const
{
  //SCOPED_TIMER( "ClientStub::insertRowAS" );
  throw StubsException( "ClientStub::insertRowAsString, This function is not available" );
}

//-----------------------------------------------------------------------------

coral::Token
ClientStub::bulkInsertAsString( Token /*sessionID*/,
                                const std::string& /*schemaName*/,
                                const std::string& /*tableName*/,
                                const std::string& /*rowBufferAS*/,
                                int /*rowCacheSizeDb*/ ) const
{
  //SCOPED_TIMER( "ClientStub::bulkInsertAS" );
  throw StubsException( "ClientStub::bulkInsertAsString, This function is not available" );
}

//-----------------------------------------------------------------------------

void
ClientStub::releaseBulkOp( Token /*bulkOpID*/ ) const
{
  //SCOPED_TIMER( "ClientStub::releaseBulkOp" );
  throw StubsException( "ClientStub::releaseBulkOp, This function is not available" );
}

//-----------------------------------------------------------------------------

void
ClientStub::processRows( Token /*bulkOpID*/,
                         const std::vector<AttributeList>& /*rowsAS*/ ) const
{
  //SCOPED_TIMER( "ClientStub::processRows" );
  throw StubsException( "ClientStub::processRows, This function is not available" );
}

//-----------------------------------------------------------------------------

void
ClientStub::flush( Token /*bulkOpID*/ ) const
{
  //SCOPED_TIMER( "ClientStub::flush" );
  throw StubsException( "ClientStub::flush, This function is not available" );
}

//-----------------------------------------------------------------------------

void
ClientStub::callProcedure( Token /*sessionID*/,
                           const std::string& /*schemaName*/,
                           const std::string& /*procedureName*/,
                           const AttributeList& /*inputArguments*/ ) const
{
  //SCOPED_TIMER( "ClientStub::callProcedure" );
  throw StubsException( "ClientStub::callProcedure, This function is not available" );
}

//-----------------------------------------------------------------------------
