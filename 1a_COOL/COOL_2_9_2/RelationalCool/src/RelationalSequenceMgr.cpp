// $Id: RelationalSequenceMgr.cpp,v 1.8 2009-12-16 17:17:38 avalassi Exp $

// Local include files
#include "RelationalQueryMgr.h"
#include "RelationalSequence.h"
#include "RelationalSequenceMgr.h"

// Namespace
using namespace cool;

//---------------------------------------------------------------------------

RelationalSequenceMgr::RelationalSequenceMgr
( const RelationalQueryMgr& queryMgr )
  : m_queryMgr( queryMgr )
  , m_log( new coral::MessageStream( "RelationalSequenceMgr" ))
{
  log() << coral::Debug << "Instantiate a RelationalSequenceMgr"
        << coral::MessageStream::endmsg;
}

//---------------------------------------------------------------------------

RelationalSequenceMgr::~RelationalSequenceMgr()
{
  log() << coral::Debug
        << "Delete the RelationalSequenceMgr" << coral::MessageStream::endmsg;
}

//---------------------------------------------------------------------------

boost::shared_ptr<RelationalSequence>
RelationalSequenceMgr::instantiateSequence( const std::string& name )
{
  boost::shared_ptr<RelationalSequence>
    ptr( new RelationalSequence( name, *this ) );
  return ptr;
}

//-----------------------------------------------------------------------------
