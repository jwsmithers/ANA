// Include files
#include <map>
#include <sstream>
#include "CoralBase/../src/coral_thread_headers.h"
#include "CoralBase/AttributeException.h"
#include "CoralBase/AttributeListException.h"
#include "CoralMonitor/ScopedTimer.h"
#include "CoralServerBase/ByteBuffer.h"
#include "CoralServerBase/CALPacketHeader.h"
#include "CoralServerBase/IRowIterator.h"
#include "CoralStubs/ServerStub.h"
#include "RelationalAccess/AccessMode.h"
#include "RelationalAccess/AuthenticationServiceException.h"
#include "RelationalAccess/ConnectionServiceException.h"
#include "RelationalAccess/LookupServiceException.h"
#include "RelationalAccess/MonitoringException.h"
#include "RelationalAccess/RelationalServiceException.h"
#include "RelationalAccess/SchemaException.h"
#include "RelationalAccess/SessionException.h"
#include "RelationalAccess/WebCacheControlException.h"

// Local include files
#include "ByteBufferIteratorAll.h"
#include "CALProtocol.h"
#include "CppTypes.h"
#include "Exceptions.h"
#include "SegmentReaderIterator.h"
#include "SegmentWriterIterator.h"
#include "SimpleByteBufferIterator.h"

// Logger
#define LOGGER_NAME "CoralStubs::ServerStub"
#include "logger.h"

// Private forward declarations and typedefs used in the implementation code
namespace coral
{
  namespace CoralStubs
  {

    // Forward declaration
    struct RowIteratorProperties;

    // Type definition for a request-handling method
    typedef coral::IByteBufferIterator*
    (*Request_t)( ICoralFacade& facade,
                  SegmentReaderIterator&,
                  RowIteratorMap&,
                  const RequestProperties&,
                  const ConnectionProperties* );

    // Macro for the forward declaration of all request-handling methods
#define DECLARE_REQUEST_T( NAME )                                       \
    static coral::IByteBufferIterator* NAME( ICoralFacade& facade,      \
                                             SegmentReaderIterator& sri, \
                                             RowIteratorMap&,           \
                                             const RequestProperties &, \
                                             const ConnectionProperties* )

    // Declare all request-handling methods
    class ServerStubImpl
    {
    public:
      static void prepareMultiTables( std::list< std::string >&, std::vector< std::pair<std::string,std::string> >& );
      static void prepareCoralException( SegmentWriterIterator*, coral::Exception& );
      DECLARE_REQUEST_T( request_ConnectRO );
      DECLARE_REQUEST_T( request_ConnectRW );
      DECLARE_REQUEST_T( request_Disconnect );
      DECLARE_REQUEST_T( request_TransactionStartRO );
      DECLARE_REQUEST_T( request_TransactionStartRW );
      DECLARE_REQUEST_T( request_TransactionCommit );
      DECLARE_REQUEST_T( request_TransactionRollback );
      DECLARE_REQUEST_T( request_FetchRows );
      DECLARE_REQUEST_T( request_FetchRowsOT );
      DECLARE_REQUEST_T( request_FetchRowsNext );
      DECLARE_REQUEST_T( request_ReleaseCursor );
      DECLARE_REQUEST_T( request_FetchAllRows );
      DECLARE_REQUEST_T( request_FetchAllRowsOT );
      DECLARE_REQUEST_T( request_ListTables );
      DECLARE_REQUEST_T( request_FetchTableDescription );
      DECLARE_REQUEST_T( request_TableExists );
      DECLARE_REQUEST_T( request_ListViews );
      DECLARE_REQUEST_T( request_FetchViewDescription );
      DECLARE_REQUEST_T( request_ViewExists );
      DECLARE_REQUEST_T( request_FetchSessionProperties );
      static Request_t request_matrix[29];
      static bool request_table[255];
    };

  }
}

// Private struct used in the implementation code
struct coral::CoralStubs::RowIteratorProperties
{
  IRowIterator* iterator;
  unsigned int rowCacheSize;
  unsigned int memoryCacheSize;
  coral::AttributeList* buffer;
};

// Private struct used in the implementation code
struct coral::CoralStubs::RowIteratorMap
{
  std::map<size_t, RowIteratorProperties*> maps;
  coral::mutex mutex;
  //counter for concurent fetchall operations
  size_t m_fall_ops;
};

// Namespace
using namespace coral::CoralStubs;

//-----------------------------------------------------------------------------

coral::IByteBufferIterator*
ServerStubImpl::request_ConnectRO( ICoralFacade& facade,
                                   SegmentReaderIterator& sri,
                                   RowIteratorMap&,
                                   const RequestProperties&,
                                   const ConnectionProperties* )
{
  SCOPED_TIMER( "ServerStub::ConnectRO" );
  std::string url;
  sri.extract16( url );
  //call the facade method
  bool proxy = sri.proxy();
  Token sessionID = facade.connect( url, coral::ReadOnly, proxy );
  //write the session id to the stream
  SegmentWriterIterator* swi = new SegmentWriterIterator(CALOpcodes::ConnectRO, sri.cacheable(), true);
  //copy the proxy flag to the reply
  swi->setProxy( proxy );
  swi->append( sessionID );
  //write all temp data to the buffers
  swi->flush();
  //return
  return swi;
}

//-----------------------------------------------------------------------------

coral::IByteBufferIterator*
ServerStubImpl::request_ConnectRW( ICoralFacade& facade,
                                   SegmentReaderIterator& sri,
                                   RowIteratorMap&,
                                   const RequestProperties&,
                                   const ConnectionProperties* )
{
  SCOPED_TIMER( "ServerStub::ConnectRW" );
  std::string url;
  sri.extract16( url );
  //call the facade method
  bool proxy = sri.proxy();
  Token sessionID = facade.connect( url, coral::Update, proxy );
  SegmentWriterIterator* swi = new SegmentWriterIterator(CALOpcodes::ConnectRW, sri.cacheable(), true);
  //copy the proxy flag to the reply
  swi->setProxy( proxy );
  //write the session id to the stream
  swi->append( sessionID );
  //write all temp data to the buffers
  swi->flush();
  //return
  return swi;
}

//-----------------------------------------------------------------------------

coral::IByteBufferIterator*
ServerStubImpl::request_Disconnect( ICoralFacade& facade,
                                    SegmentReaderIterator& sri,
                                    RowIteratorMap&,
                                    const RequestProperties&,
                                    const ConnectionProperties* )
{
  SCOPED_TIMER( "ServerStub::Disconnect" );
  coral::Token sessionID;
  sri.extract( sessionID );
  //call the facade method
  facade.releaseSession( sessionID );
  SegmentWriterIterator* swi = new SegmentWriterIterator(CALOpcodes::Disconnect, sri.cacheable(), true);
  //copy the proxy flag to the reply
  swi->setProxy( sri.proxy() );
  //write all temp data to the buffers
  swi->flush();
  //return
  return swi;
}

//-----------------------------------------------------------------------------

coral::IByteBufferIterator*
ServerStubImpl::request_TransactionStartRO( ICoralFacade& facade,
                                            SegmentReaderIterator& sri,
                                            RowIteratorMap&,
                                            const RequestProperties&,
                                            const ConnectionProperties* )
{
  SCOPED_TIMER( "ServerStub::TransactionStartRO" );
  coral::Token sessionID;
  sri.extract( sessionID );
  //call the facade method
  facade.startTransaction( sessionID, true );
  SegmentWriterIterator* swi = new SegmentWriterIterator(CALOpcodes::StartTransactionRO, sri.cacheable(), true);
  //copy the proxy flag to the reply
  swi->setProxy( sri.proxy() );
  //write all temp data to the buffers
  swi->flush();
  //return
  return swi;
}

//-----------------------------------------------------------------------------

coral::IByteBufferIterator*
ServerStubImpl::request_TransactionStartRW( ICoralFacade& facade,
                                            SegmentReaderIterator& sri,
                                            RowIteratorMap&,
                                            const RequestProperties&,
                                            const ConnectionProperties* )
{
  SCOPED_TIMER( "ServerStub::TransactionStartRW" );
  coral::Token sessionID;
  sri.extract( sessionID );
  //call the facade method
  try
  {
    facade.startTransaction( sessionID, false );
  }
  catch(...)
  {
    throw;
  }
  SegmentWriterIterator* swi = new SegmentWriterIterator(CALOpcodes::StartTransactionRW, sri.cacheable(), true);
  //copy the proxy flag to the reply
  swi->setProxy( sri.proxy() );
  //write all temp data to the buffers
  swi->flush();
  //return
  return swi;
}

//-----------------------------------------------------------------------------

coral::IByteBufferIterator*
ServerStubImpl::request_TransactionCommit( ICoralFacade& facade,
                                           SegmentReaderIterator& sri,
                                           RowIteratorMap&,
                                           const RequestProperties&,
                                           const ConnectionProperties* )
{
  SCOPED_TIMER( "ServerStub::TransactionCommit" );
  coral::Token sessionID;
  sri.extract( sessionID );
  //call the facade method
  facade.commitTransaction( sessionID );
  SegmentWriterIterator* swi = new SegmentWriterIterator(CALOpcodes::CommitTransaction, sri.cacheable(), true);
  //copy the proxy flag to the reply
  swi->setProxy( sri.proxy() );
  //write all temp data to the buffers
  swi->flush();
  //return
  return swi;
}

//-----------------------------------------------------------------------------

coral::IByteBufferIterator*
ServerStubImpl::request_TransactionRollback( ICoralFacade& facade,
                                             SegmentReaderIterator& sri,
                                             RowIteratorMap&,
                                             const RequestProperties&,
                                             const ConnectionProperties* )
{
  SCOPED_TIMER( "ServerStub::TransactionRollback" );
  coral::Token sessionID;
  sri.extract( sessionID );
  //call the facade method
  facade.rollbackTransaction( sessionID );
  SegmentWriterIterator* swi = new SegmentWriterIterator(CALOpcodes::RollbackTransaction, sri.cacheable(), true);
  //copy the proxy flag to the reply
  swi->setProxy( sri.proxy() );
  //write all temp data to the buffers
  swi->flush();
  //return
  return swi;
}

//-----------------------------------------------------------------------------

coral::IByteBufferIterator*
ServerStubImpl::request_FetchRows( ICoralFacade& facade,
                                   SegmentReaderIterator& sri,
                                   RowIteratorMap& mgri,
                                   const RequestProperties&,
                                   const ConnectionProperties* )
{
  SCOPED_TIMER( "ServerStub::FetchRows" );
  coral::Token sessionID;
  sri.extract( sessionID );
  QueryDefinition qd;
  sri.extract( qd );
  uint32_t rowCacheSize;
  sri.extract( rowCacheSize );
  uint32_t memoryCacheSize;
  sri.extract( memoryCacheSize );
  //check if we have an empty rowbuffer
  AttributeList* pRowBuffer = NULL;
  bool isempty;
  sri.extract( isempty );
  //row buffer is empty
  if(isempty)
  {
    //create a new attributelist
    pRowBuffer = new AttributeList;
    //get the list
    sri.extractE( *pRowBuffer );
  }
  IRowIteratorPtr rowi = facade.fetchRows( sessionID, qd, pRowBuffer, rowCacheSize, memoryCacheSize );
  uint32_t ntoken = 0;
  mgri.mutex.lock();
  std::map<size_t, RowIteratorProperties*>::iterator i;
  do
  {
    ntoken++;
    i = mgri.maps.find(ntoken);
  }
  while(i != mgri.maps.end());
  RowIteratorProperties* rip = new RowIteratorProperties;
  rip->iterator = rowi.release();
  rip->rowCacheSize = rowCacheSize;
  rip->memoryCacheSize = memoryCacheSize;
  rip->buffer = pRowBuffer;
  mgri.maps.insert(std::pair<size_t, RowIteratorProperties*>(ntoken, rip));
  mgri.mutex.unlock();
  SegmentWriterIterator* swi = new SegmentWriterIterator(CALOpcodes::FetchRows, sri.cacheable(), true);
  //copy the proxy flag to the reply
  swi->setProxy( sri.proxy() );
  //write the session id to the stream
  swi->append( ntoken );
  //write all temp data to the buffers
  swi->flush();
  //return
  return swi;
}

//-----------------------------------------------------------------------------

coral::IByteBufferIterator*
ServerStubImpl::request_FetchRowsOT( ICoralFacade& facade,
                                     SegmentReaderIterator& sri,
                                     RowIteratorMap& mgri,
                                     const RequestProperties&,
                                     const ConnectionProperties* )
{
  SCOPED_TIMER( "ServerStub::FetchRowsOT" );
  coral::Token sessionID;
  sri.extract( sessionID );
  QueryDefinition qd;
  sri.extract( qd );
  uint32_t rowCacheSize;
  sri.extract( rowCacheSize );
  uint32_t memoryCacheSize;
  sri.extract( memoryCacheSize );
  std::map< std::string, std::string > outputTypes;
  sri.extract( outputTypes );
  IRowIteratorPtr rowi = facade.fetchRows( sessionID, qd, outputTypes, rowCacheSize, memoryCacheSize );
  uint32_t ntoken = 0;
  mgri.mutex.lock();
  std::map<size_t, RowIteratorProperties*>::iterator i;
  do
  {
    ntoken++;
    i = mgri.maps.find(ntoken);
  }
  while(i != mgri.maps.end());
  RowIteratorProperties* rip = new RowIteratorProperties;
  rip->iterator = rowi.release();
  rip->rowCacheSize = rowCacheSize;
  rip->memoryCacheSize = memoryCacheSize;
  rip->buffer = 0;
  mgri.maps.insert(std::pair<size_t, RowIteratorProperties*>(ntoken, rip));
  mgri.mutex.unlock();
  SegmentWriterIterator* swi = new SegmentWriterIterator(CALOpcodes::FetchRowsOT, sri.cacheable(), true);
  //copy the proxy flag to the reply
  swi->setProxy( sri.proxy() );
  //write the session id to the stream
  swi->append( ntoken );
  //write all temp data to the buffers
  swi->flush();
  //return
  return swi;
}

//-----------------------------------------------------------------------------

coral::IByteBufferIterator*
ServerStubImpl::request_FetchRowsNext( ICoralFacade&,
                                       SegmentReaderIterator& sri,
                                       RowIteratorMap& mgri,
                                       const RequestProperties&,
                                       const ConnectionProperties* )
{
  SCOPED_TIMER( "ServerStub::FetchRowsNext" );
  uint32_t cursorID;
  sri.extract( cursorID );
  mgri.mutex.lock();
  std::map<size_t, RowIteratorProperties*>::iterator i = mgri.maps.find(cursorID);
  if(i == mgri.maps.end()) {
    mgri.mutex.unlock();
    throw StubsException("Can't find the RowIterator");
  }
  //get the iterator properties
  RowIteratorProperties* rip = i->second;
  //unlock the mutex
  mgri.mutex.unlock();
  //get all rows and store them into the buffer iterator
  //FIXME better solution is to connect the byte buffer iterator
  //with the row iterator
  SegmentWriterIterator* swi = new SegmentWriterIterator(CALOpcodes::FetchRowsNext, sri.cacheable(), true);
  //copy the proxy flag to the reply
  swi->setProxy( sri.proxy() );
  IRowIterator* rowi = rip->iterator;
  /* If MemoryCache size is bigger than zero use it
   * Else use rowCacheSize to transmit a bundle of rows \
   *///
  if( rip->memoryCacheSize > 0 )
  {
    // Cache size in mb
    size_t realsize = rip->memoryCacheSize * 1000000;
    bool hasnext = false;
    while( swi->written() < realsize )
    {
      hasnext = rowi->nextRow();
      if(!hasnext) break;
      swi->append( true );
      swi->appendV( rowi->currentRow() );
    }
    swi->append( false );
    swi->append( !hasnext );
  }
  else
  {
    bool hasnext = false;
    size_t counter = 0;
    while( counter < rip->rowCacheSize )
    {
      hasnext = rowi->nextRow();
      if(!hasnext) break;
      swi->append( true );
      swi->appendV( rowi->currentRow() );
      counter++;
    }
    swi->append( false );
    swi->append( !hasnext );
  }
  //write all temp data to the buffers
  swi->flush();
  //return
  return swi;
}

//-----------------------------------------------------------------------------

coral::IByteBufferIterator*
ServerStubImpl::request_ReleaseCursor( ICoralFacade&,
                                       SegmentReaderIterator& sri,
                                       RowIteratorMap& mgri,
                                       const RequestProperties&,
                                       const ConnectionProperties* )
{
  SCOPED_TIMER( "ServerStub::ReleaseCursor" );
  uint32_t cursorID;
  sri.extract( cursorID );
  mgri.mutex.lock();
  std::map<size_t, RowIteratorProperties*>::iterator i = mgri.maps.find(cursorID);
  if(i == mgri.maps.end()) {
    mgri.mutex.unlock();
    throw StubsException("Can't find the RowIterator");
  }
  RowIteratorProperties* rip = i->second;
  mgri.maps.erase( i );
  mgri.mutex.unlock();
  delete rip->iterator;
  if(rip->buffer) delete rip->buffer;
  delete rip;
  SegmentWriterIterator* swi = new SegmentWriterIterator(CALOpcodes::ReleaseCursor, sri.cacheable(), true);
  //copy the proxy flag to the reply
  swi->setProxy( sri.proxy() );
  //write all temp data to the buffers
  swi->flush();
  //return
  return swi;
}

//-----------------------------------------------------------------------------

void
ServerStubImpl::prepareMultiTables( std::list< std::string >& s,
                                    std::vector< std::pair<std::string,std::string> >& list )
{
  for( size_t i = 1; i < list.size(); ++i )
  {
    s.push_back( list[i].first );
  }
}

//-----------------------------------------------------------------------------

coral::IByteBufferIterator*
ServerStubImpl::request_FetchAllRows( ICoralFacade& facade,
                                      SegmentReaderIterator& sri,
                                      RowIteratorMap&,
                                      const RequestProperties& properties,
                                      const ConnectionProperties* cprop )
{
  coral::Token sessionID;
  sri.extract( sessionID );
  QueryDefinition qd;
  //sri.extractMon( qd, schema, tablelist );
  sri.extract( qd );
  std::string schema = qd.getSchemaName(); // as in SegmentWriterIterator - fix bug #100255
  std::vector< std::pair<std::string,std::string> > tablelist = qd.getTableList(); // as in SegmentWriterIterator - fix bug #100255
  // The string for the tables result
  std::list< std::string > tables;
  ServerStubImpl::prepareMultiTables( tables, tablelist );
  //create AttributeList
  AttributeList* rowBuffer = new AttributeList;
  bool isempty = true;
  bool hasbuffer;
  sri.extract( hasbuffer );
  //row buffer is empty
  if( hasbuffer )
    //row buffer is not empty
  {
    //get the list
    sri.extractE( *rowBuffer );
    isempty = rowBuffer->size() == 0;
  }
  IRowIteratorPtr rowptr;
  if(isempty)
    rowptr = facade.fetchAllRows( sessionID, qd, NULL );
  else
    rowptr = facade.fetchAllRows( sessionID, qd, rowBuffer );
  return new ByteBufferIteratorAll(rowptr.release(),
                                   CALOpcodes::FetchAllRows,
                                   sri.cacheable(), sri.proxy(),
                                   isempty, rowBuffer, schema, tables,
                                   cprop, properties);
}

//-----------------------------------------------------------------------------

coral::IByteBufferIterator*
ServerStubImpl::request_FetchAllRowsOT( ICoralFacade& facade,
                                        SegmentReaderIterator& sri,
                                        RowIteratorMap&,
                                        const RequestProperties& properties,
                                        const ConnectionProperties* cprop )
{
  coral::Token sessionID;
  sri.extract( sessionID );
  //check if we have an empty rowbuffer
  QueryDefinition qd;
  //sri.extractMon( qd, schema, tablelist );
  sri.extract( qd );
  std::string schema = qd.getSchemaName(); // as in SegmentWriterIterator - fix bug #100255
  std::vector< std::pair<std::string,std::string> > tablelist = qd.getTableList(); // as in SegmentWriterIterator - fix bug #100255
  // The string for the tables result
  std::list< std::string > tables;
  ServerStubImpl::prepareMultiTables( tables, tablelist );
  std::map< std::string, std::string > outputTypes;
  sri.extract( outputTypes );
  IRowIteratorPtr rowptr = facade.fetchAllRows( sessionID, qd, outputTypes );
  return new ByteBufferIteratorAll(rowptr.release(),
                                   CALOpcodes::FetchAllRowsOT,
                                   sri.cacheable(), sri.proxy(),
                                   true, 0, schema, tables,
                                   cprop, properties);

}

//-----------------------------------------------------------------------------

coral::IByteBufferIterator*
ServerStubImpl::request_ListTables( ICoralFacade& facade,
                                    SegmentReaderIterator& sri,
                                    RowIteratorMap&,
                                    const RequestProperties&,
                                    const ConnectionProperties* )
{
  SCOPED_TIMER( "ServerStub::ListTables" );
  coral::Token sessionID;
  sri.extract( sessionID );
  std::string schemaName;
  sri.extract16( schemaName );
  const std::set<std::string> myset = facade.listTables( sessionID, schemaName );
  logger << Debug << "request_ListTables: found [" << myset.size() << "] tables" << endlog;
  SegmentWriterIterator* swi = new SegmentWriterIterator(CALOpcodes::ListTables, sri.cacheable(), true);
  //copy the proxy flag to the reply
  swi->setProxy( sri.proxy() );
  swi->append( myset );
  //write all temp data to the buffers
  swi->flush();
  //return
  return swi;
}

//-----------------------------------------------------------------------------

coral::IByteBufferIterator*
ServerStubImpl::request_FetchTableDescription( ICoralFacade& facade,
                                               SegmentReaderIterator& sri,
                                               RowIteratorMap&,
                                               const RequestProperties&,
                                               const ConnectionProperties* )
{
  SCOPED_TIMER( "ServerStub::FetchTableDescription" );
  coral::Token sessionID;
  sri.extract( sessionID );
  std::string schemaName;
  sri.extract16( schemaName );
  std::string tableName;
  sri.extract16( tableName );
  const TableDescription& desc = facade.fetchTableDescription( sessionID, schemaName, tableName );
  SegmentWriterIterator* swi = new SegmentWriterIterator(CALOpcodes::FetchTableDescription, sri.cacheable(), true);
  //copy the proxy flag to the reply
  swi->setProxy( sri.proxy() );
  swi->append( desc );
  //write all temp data to the buffers
  swi->flush();
  //return
  return swi;
}

//-----------------------------------------------------------------------------

coral::IByteBufferIterator*
ServerStubImpl::request_TableExists( ICoralFacade& facade,
                                     SegmentReaderIterator& sri,
                                     RowIteratorMap&,
                                     const RequestProperties&,
                                     const ConnectionProperties* )
{
  SCOPED_TIMER( "ServerStub::TableExists" );
  coral::Token sessionID;
  sri.extract( sessionID );
  std::string schemaName;
  sri.extract16( schemaName );
  std::string tableName;
  sri.extract16( tableName );
  SegmentWriterIterator* swi = new SegmentWriterIterator(CALOpcodes::TableExists, sri.cacheable(), true);
  //copy the proxy flag to the reply
  swi->setProxy( sri.proxy() );
  swi->append( facade.existsTable( sessionID, schemaName, tableName ) );
  //write all temp data to the buffers
  swi->flush();
  //return
  return swi;
}

//-----------------------------------------------------------------------------

coral::IByteBufferIterator*
ServerStubImpl::request_ListViews( ICoralFacade& facade,
                                   SegmentReaderIterator& sri,
                                   RowIteratorMap&,
                                   const RequestProperties&,
                                   const ConnectionProperties* )
{
  SCOPED_TIMER( "ServerStub::ListViews" );
  coral::Token sessionID;
  sri.extract( sessionID );
  std::string schemaName;
  sri.extract16( schemaName );
  const std::set<std::string> myset = facade.listViews( sessionID, schemaName );
  logger << Debug << "request_ListViews: found [" << myset.size() << "] tables" << endlog;
  SegmentWriterIterator* swi = new SegmentWriterIterator(CALOpcodes::ListViews, sri.cacheable(), true);
  //copy the proxy flag to the reply
  swi->setProxy( sri.proxy() );
  swi->append( myset );
  //write all temp data to the buffers
  swi->flush();
  //return
  return swi;
}

//-----------------------------------------------------------------------------

coral::IByteBufferIterator*
ServerStubImpl::request_FetchViewDescription( ICoralFacade& facade,
                                              SegmentReaderIterator& sri,
                                              RowIteratorMap&,
                                              const RequestProperties&,
                                              const ConnectionProperties* )
{
  SCOPED_TIMER( "ServerStub::FetchViewDescription" );
  coral::Token sessionID;
  sri.extract( sessionID );
  std::string schemaName;
  sri.extract16( schemaName );
  std::string viewName;
  sri.extract16( viewName );
  const std::pair<TableDescription,std::string>& desc = facade.fetchViewDescription( sessionID, schemaName, viewName );
  SegmentWriterIterator* swi = new SegmentWriterIterator(CALOpcodes::FetchViewDescription, sri.cacheable(), true);
  //copy the proxy flag to the reply
  swi->setProxy( sri.proxy() );
  swi->append( desc.first );
  swi->append16( desc.second );
  //write all temp data to the buffers
  swi->flush();
  //return
  return swi;
}

//-----------------------------------------------------------------------------

coral::IByteBufferIterator*
ServerStubImpl::request_ViewExists( ICoralFacade& facade,
                                    SegmentReaderIterator& sri,
                                    RowIteratorMap&,
                                    const RequestProperties&,
                                    const ConnectionProperties* )
{
  SCOPED_TIMER( "ServerStub::ViewExists" );
  coral::Token sessionID;
  sri.extract( sessionID );
  std::string schemaName;
  sri.extract16( schemaName );
  std::string viewName;
  sri.extract16( viewName );
  SegmentWriterIterator* swi = new SegmentWriterIterator(CALOpcodes::ViewExists, sri.cacheable(), true);
  //copy the proxy flag to the reply
  swi->setProxy( sri.proxy() );
  swi->append( facade.existsView( sessionID, schemaName, viewName ) );
  //write all temp data to the buffers
  swi->flush();
  //return
  return swi;
}

//-----------------------------------------------------------------------------

coral::IByteBufferIterator*
ServerStubImpl::request_FetchSessionProperties( ICoralFacade& facade,
                                                SegmentReaderIterator& sri,
                                                RowIteratorMap&,
                                                const RequestProperties&,
                                                const ConnectionProperties* )
{
  SCOPED_TIMER( "ServerStub::FetchSessionProperties" );
  coral::Token sessionID;
  sri.extract( sessionID );
  const std::vector<std::string>& sessionp = facade.fetchSessionProperties( sessionID );
  SegmentWriterIterator* swi = new SegmentWriterIterator(CALOpcodes::FetchSessionProperties, sri.cacheable(), true);
  //copy the proxy flag to the reply
  swi->setProxy( sri.proxy() );
  swi->append( sessionp );
  //write all temp data to the buffers
  swi->flush();
  //return
  return swi;
}

//-----------------------------------------------------------------------------

// The array for calling a request-handling method by its opcode.
Request_t
ServerStubImpl::request_matrix[29] = {
  NULL, //0x00
  &request_ConnectRO, //0x01
  &request_ConnectRW, //0x02
  &request_Disconnect, //0x03
  &request_TransactionStartRO, //0x04
  &request_TransactionStartRW, //0x05
  &request_TransactionCommit, //0x06
  &request_TransactionRollback, //0x07
  NULL, //0x08
  NULL, //0x09
  NULL, //0x0a
  NULL, //0x0b
  NULL, //0x0c
  NULL, //0x0d
  NULL, //0x0e
  NULL, //0x0f
  &request_FetchRows, //0x10
  &request_FetchRowsNext, //0x11
  &request_ReleaseCursor, //0x12
  &request_FetchAllRows, //0x13
  &request_ListTables, //0x14
  &request_FetchTableDescription, //0x15
  &request_TableExists, //0x16
  &request_FetchSessionProperties, //0x17
  &request_FetchRowsOT, //0x18
  &request_FetchAllRowsOT, //0x19
  &request_ListViews, //0x1a
  &request_FetchViewDescription, //0x1b
  &request_ViewExists //0x1c
};

// The array to determine which opcodes are available (from 0 to 255)
bool
ServerStubImpl::request_table[255] = {
  false, //0x00
  true, //0x01
  true, //0x02
  true, //0x03
  true, //0x04
  true, //0x05
  true, //0x06
  true, //0x07
  false, //0x08
  false, //0x09
  false, //0x0a
  false, //0x0b
  false, //0x0c
  false, //0x0d
  false, //0x0e
  false, //0x0f
  true , //0x10
  true , //0x11
  true , //0x12
  true , //0x13
  true , //0x14
  true , //0x15
  true , //0x16
  true , //0x17
  true , //0x18
  true , //0x19
  true , //0x1a
  true , //0x1b
  true , //0x1c
  false, //0x1d
  false, //0x1e
  false //0x1f
};

//-----------------------------------------------------------------------------

void
ServerStubImpl::prepareCoralException( SegmentWriterIterator* swi,
                                       coral::Exception& e )
{
  //copy the exception string to a local string
  std::string ex(e.what());
  //find the first position
  size_t pos01 = ex.find("( CORAL");
  //create a substring until the end of the exception string
  std::string ez(ex.substr(pos01));
  //find the second position
  size_t pos02 = ez.find(" from ");
  //create the original three parts
  std::string part01(ex.substr(0, pos01 - 1));
  std::string part02(ez.substr(11, pos02 - 12));
  std::string part03(ez.substr(pos02 + 7, ez.size() - pos02 - 10));
  //write the encoding for exceptions to the buffer
  swi->exception(0x00, 0x02, part01, part02, part03);
}

//-----------------------------------------------------------------------------

ServerStub::ServerStub(ICoralFacade& coralFacade)
  : m_facade( coralFacade )
  , m_rowimap()
  , m_connprop( 0 )
{
  //logger << "Create ServerStub" << endlog;
  m_rowimap = new RowIteratorMap;
  m_rowimap->m_fall_ops = 0;
}

//-----------------------------------------------------------------------------

ServerStub::~ServerStub()
{
  //logger << "Delete ServerStub..." << endlog;
  std::map<size_t, RowIteratorProperties*>::iterator i;
  for(i = m_rowimap->maps.begin(); i != m_rowimap->maps.end(); i++ )
  {
    RowIteratorProperties* rip = i->second;
    delete rip->iterator;
    delete rip;
  }
  //logger << "Delete ServerStub... 1" << endlog;
  delete m_rowimap;
  if( m_connprop ) delete m_connprop;
  m_connprop = 0;
  //logger << "Delete ServerStub... DONE" << endlog;
}

//-----------------------------------------------------------------------------

void
ServerStub::setConnectionProperties( ConnectionPropertiesConstPtr connprop )
{
  // Delete previous connection properties
  if( m_connprop ) delete m_connprop;
  // Set the new one
  m_connprop = connprop.release();
}

//-----------------------------------------------------------------------------

coral::IByteBufferIteratorPtr
ServerStub::replyToRequest( IByteBufferIteratorPtr request,
                            const RequestProperties& properties )
{
  // Create the reader
  SegmentReaderIterator sri( 0, *request );
  // Workaround for catching the CAL protocol exception
  // BUG #64373
  try
  {
    // Extract header by calling empty method
    sri.noextract();
  }
  catch( StreamBufferException& e )
  {
    // Log local what happened
    logger << Error << "Caught coral::Exception: '" << e.what() << "'" << endlog;
    SegmentWriterIterator* swi = new SegmentWriterIterator(sri.opcode(), sri.cacheable(), true);
    // Copy the proxy flag to the reply
    swi->setProxy( sri.proxy() );
    ServerStubImpl::prepareCoralException( swi, e );
    return std::auto_ptr<IByteBufferIterator>( swi );
  }
  // Get the opcode
  CALOpcode opcode = sri.opcode();
  if(!ServerStubImpl::request_table[opcode])
  {
    SegmentWriterIterator* swi = new SegmentWriterIterator(opcode, sri.cacheable(), true);
    //copy the proxy flag to the reply
    swi->setProxy( sri.proxy() );
    std::ostringstream s;
    s << "Message with opcode ("
      << hexstring(&opcode,1) << ") can't be handled";
    swi->exception(0x00, 0x10, s.str(), "ServerStub::replyToRequest", "");
    return std::auto_ptr<IByteBufferIterator>( swi );
  }
  //execute the facade implementation
  try
  {
    //execute
    IByteBufferIterator* iter =
      ServerStubImpl::request_matrix[opcode]( m_facade,
                                              sri,
                                              *m_rowimap,
                                              properties,
                                              m_connprop );
    return std::auto_ptr<IByteBufferIterator>( iter );
  }
  catch ( coral::Exception& e )
  {
    //log local what happened
    logger << Error << "Caught coral::Exception: '" << e.what() << "'" << endlog;
    SegmentWriterIterator* swi = new SegmentWriterIterator(opcode, sri.cacheable(), true);
    //copy the proxy flag to the reply
    swi->setProxy( sri.proxy() );
    ServerStubImpl::prepareCoralException( swi, e );
    return std::auto_ptr<IByteBufferIterator>( swi );
  }
  catch ( std::exception& e )
  {
    logger << Error << "Caught std::exception: '" << e.what() << "'" << endlog;
    //create new exception message
    SegmentWriterIterator* swi = new SegmentWriterIterator(opcode, sri.cacheable(), true);
    //copy the proxy flag to the reply
    swi->setProxy( sri.proxy() );
    swi->exception(0x00, 0x01, e.what(), "ServerStub::replyToRequest", "");
    return std::auto_ptr<IByteBufferIterator>( swi );
  }
  catch (...)
  {
    //create new exception message
    logger << Error << "Caught unknown exception" << endlog;
    //create new exception message
    SegmentWriterIterator* swi = new SegmentWriterIterator(opcode, sri.cacheable(), true);

    //copy the proxy flag to the reply
    swi->setProxy( sri.proxy() );
    swi->exception(0x00, 0x00, "Unkown exception caught", "ServerStub::replyToRequest", "");
    return std::auto_ptr<IByteBufferIterator>( swi );
  }
}

//-----------------------------------------------------------------------------
