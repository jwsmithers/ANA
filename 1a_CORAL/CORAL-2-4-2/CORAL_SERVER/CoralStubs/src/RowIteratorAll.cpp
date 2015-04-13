// Include files
#include <iostream>
#include "CoralMonitor/ScopedTimer.h"

// Local include files
#include "CALProtocol.h"
#include "Exceptions.h"
#include "RowIteratorAll.h"

// Logger
#define LOGGER_NAME "CoralStubs::RowIteratorAll"
#include "logger.h"

// Namespace
using namespace coral::CoralStubs;

//-----------------------------------------------------------------------------

RowIteratorAll::RowIteratorAll( IByteBufferIteratorPtr reply,
                                AttributeList* rowBuffer,
                                CALOpcode opcode )
  : m_reply( reply )
  , m_obuffer( rowBuffer )
  , m_cbuffer( false )
  , m_ibuffer( false )
  , m_fbuffer( true )
  , m_sri( new SegmentReaderIterator( opcode, *m_reply ) ) // fix bug #100225
  , m_structure( 0 )
{
  if(m_obuffer)
  {
    m_fbuffer = m_obuffer->size() == 0;
  }
  else
  {
    //create a new attribute list
    m_obuffer = new AttributeList;
    m_cbuffer = true;
  }
}

//-----------------------------------------------------------------------------

RowIteratorAll::~RowIteratorAll()
{
  if(m_cbuffer) delete m_obuffer;
  delete m_sri;
  if(m_structure) free(m_structure);
}

//-----------------------------------------------------------------------------

bool
RowIteratorAll::nextRow()
{
  SCOPED_TIMER( "ClientStub::RowIteratorAll::nextRow" );
  bool hasnext;
  m_sri->extract( hasnext );
  if(hasnext)
  {
    if(m_structure)
    {
      //get only the raw data
      m_sri->extractD( m_structure );
      m_ibuffer = true;
      return true;
    }
    else
    {
      if(m_fbuffer)
      {
        if(m_obuffer->size() > 0)
          throw ReplyIteratorException("AttributeList structure was changed during request and next", "RowIteratorAll::nextRow()");
        //fill up the attribute structure
        //in the case that the attributelist was empty
        m_sri->extractE( *m_obuffer );
        m_fbuffer = false;
      }
      //now we have a structure in the buffer
      m_structure = m_sri->getStructure( *m_obuffer );
      //get only the raw data
      m_sri->extractD( m_structure );
      m_ibuffer = true;
      return true;
    }
  }
  else
  {
    m_ibuffer = false;
    return false;
  }
}

//-----------------------------------------------------------------------------

const coral::AttributeList&
RowIteratorAll::currentRow() const
{
  if(!m_ibuffer)
    throw ReplyIteratorException("no AttributeList available, nextRow() was not called", "RowIteratorAll::currentRow()");
  return *m_obuffer;
}

//-----------------------------------------------------------------------------
