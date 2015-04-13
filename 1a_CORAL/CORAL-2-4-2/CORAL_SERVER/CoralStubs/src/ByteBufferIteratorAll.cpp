// Include files
//#include "CoralKernel/Context.h"
#include "CoralMonitor/ScopedTimer.h"
//#include "CoralMonitor/SQLiteReporter.h"
#include "CoralServerBase/ConnectionProperties.h"
#include "CoralServerBase/RequestProperties.h"
#include "RelationalAccess/IMonitoringService.h"
#include "RelationalAccess/../src/IExtendedMonitoringService.h" // TEMPORARY! but already an Interface

// Local include files
#include "ByteBufferIteratorAll.h"

// Namespace
using namespace coral::CoralStubs;

//-----------------------------------------------------------------------------

ByteBufferIteratorAll::ByteBufferIteratorAll( IRowIterator* rowi,
                                              CALOpcode opcode,
                                              bool cacheable,
                                              bool proxy,
                                              bool isempty,
                                              AttributeList* rowBuffer,
                                              const std::string& schema,
                                              const std::list< std::string >& tables,
                                              const ConnectionProperties* cprop,
                                              const RequestProperties& properties )
  : m_swi(opcode, cacheable, true)
  , m_rowi( rowi )
  , m_rowBuffer( rowBuffer )
  , m_isempty( isempty )
  , m_structure( 0 )
  , m_islast( false )
  , m_lastbuffer( false )
  , m_schema( schema )
  , m_tables( tables )
  , m_address( "0.0.0.0" )
  , m_connid( 0 )
  , m_requestid( properties.requestId )
  , m_montime( 0 )
  , m_monsize( 0 )
{
  m_swi.setProxy( proxy );
  if(isempty)
  {
    if(m_rowi->nextRow())
    {
      m_swi.append( true );
      const AttributeList& attr01 = m_rowi->currentRow();
      //first send the attribute list
      m_swi.appendE( attr01 );
      m_structure = m_swi.getStructure( attr01 );
      //write only the raw data
      m_swi.appendD( m_structure );
    }
    else
    {
      //send termination
      m_swi.append( false );
      m_swi.flush();
      //set as last block
      m_islast = true;
    }
  }
  else
  {
    //rowbuffer remains always the same
    //so we can use the rowbuffer as pointer
    m_structure = m_swi.getStructure( *m_rowBuffer );
  }
  if( cprop )
  {
    // Convert the remote address
    std::string tmp(cprop->remoteEnd);
    // Parse the address to filter the port
    std::string::size_type loc = tmp.find( ":", 0 );
    if( loc != std::string::npos )
    {
      m_address = tmp.substr(0, loc);
    }
    else
    {
      m_address = tmp;
    }
    // get the connection id
    m_connid = cprop->connid;
  }
}

//-----------------------------------------------------------------------------

ByteBufferIteratorAll::~ByteBufferIteratorAll()
{
  if(m_rowBuffer) delete m_rowBuffer;
  delete m_rowi;
  if(m_structure) free( m_structure );
  /*
  // First approach to collect event data
  coral::IHandle<monitor::IExtendedMonitoringService> handle;
  handle = coral::Context::instance().query<monitor::IExtendedMonitoringService>("CORAL/Services/CoralMonitoringService");
  if(handle.isValid())
  {
    monitor::IExtendedMonitoringService& monitor = *(handle.get());
    coral::CoralMonitor::SQLiteReporterFullReply* record =
      new coral::CoralMonitor::SQLiteReporterFullReply( m_schema, m_tables, m_address, m_connid, m_requestid, m_montime, m_monsize );
    monitor.record("Events", coral::monitor::Application, coral::monitor::Info, "Stubs::FetchAllRows", record );
  }
  *///
}

//-----------------------------------------------------------------------------

void
ByteBufferIteratorAll::fillBuffer()
{
  //StopTimer timer;
  //timer.start();
  while(!m_swi.nextBuffer())
  {
    //std::cout << "try to get the next row from row iterator ...";
    bool newrow = m_rowi->nextRow();
    //std::cout << "done [" << newrow << "]" << std::endl;
    if(newrow)
    {
      if(m_isempty)
      {
        const AttributeList& attr02 = m_rowi->currentRow();
        m_swi.append( true );
        //write only the raw data
        m_swi.appendD( m_structure, attr02 );
      }
      else
      {
        m_swi.append( true );
        //write only the raw data
        m_swi.appendD( m_structure );
      }
    }
    else
    {
      //set the terminal
      m_swi.append( false );
      //flush the last time
      //now we should have something in the buffer
      //will return in the next loop
      m_swi.flush();
      //return as is last
      m_islast = true;
    }
  }
  //check if it was the last
  //only check if the m_islast set to true
  //otherwise it is always last as long there is only one entry in the buffer
  //FIXME fix that on the swi
  m_lastbuffer = m_swi.isLastBuffer() && m_islast;
  //timer.stop();
  //m_montime = m_montime + timer.getRealTime();
}

//-----------------------------------------------------------------------------

bool
ByteBufferIteratorAll::nextBuffer()
{
  SCOPED_TIMER( "ServerStub::ByteBufferIteratorAll::nextBuffer" );
  if(!m_islast)
  {
    if(m_swi.nextBuffer())
    {
      m_monsize = m_monsize + m_swi.currentBuffer().usedSize();
      return true;
    }
    else
    {
      fillBuffer();
      m_monsize = m_monsize + m_swi.currentBuffer().usedSize();
      return true;
    }
  }
  else
  {
    if(m_swi.nextBuffer())
    {
      m_monsize = m_monsize + m_swi.currentBuffer().usedSize();
      m_lastbuffer = m_swi.isLastBuffer();
      return true;
    }
  }
  return false;
}

//-----------------------------------------------------------------------------

bool
ByteBufferIteratorAll::isLastBuffer() const
{
  return m_lastbuffer;
}

//-----------------------------------------------------------------------------

const coral::ByteBuffer&
ByteBufferIteratorAll::currentBuffer() const
{
  return m_swi.currentBuffer();
}

//-----------------------------------------------------------------------------
