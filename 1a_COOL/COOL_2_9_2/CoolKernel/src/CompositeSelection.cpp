// $Id: CompositeSelection.cpp,v 1.10 2009-12-17 18:50:43 avalassi Exp $

// Include files
#include <sstream>
#include "CoolKernel/CompositeSelection.h"
#include "CoolKernel/InternalErrorException.h"
#include "CoolKernel/RecordSelectionException.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

const std::string
CompositeSelection::describe( CompositeSelection::Connective conn )
{
  switch( conn )
  {
  case AND: return "AND";
  case OR:  return "OR";
  default:
    throw InternalErrorException( "PANIC! Unknown logical connective",
                                  "CompositeSelection::describe()" );
  }
}

//-----------------------------------------------------------------------------

CompositeSelection::~CompositeSelection()
{
  for ( unsigned int iSel = 0; iSel < m_selVec.size(); iSel++ )
  {
    delete m_selVec[iSel];
    m_selVec[iSel] = 0;
  }
}

//-----------------------------------------------------------------------------

CompositeSelection::CompositeSelection( const IRecordSelection* sel1,
                                        Connective conn,
                                        const IRecordSelection* sel2 )
  : m_conn( conn )
  , m_selVec()
{
  m_selVec.push_back( sel1->clone() );
  m_selVec.push_back( sel2->clone() );
}

//-----------------------------------------------------------------------------

CompositeSelection::CompositeSelection
( Connective conn,
  const std::vector<const IRecordSelection*>& selVec )
  : m_conn( conn )
  , m_selVec()
{
  if ( selVec.size() < 2 )
    throw RecordSelectionException
      ( "At least two selections must be provided",
        "CompositeSelection::ctor" );
  for ( unsigned int iSel = 0; iSel < selVec.size(); iSel++ )
  {
    m_selVec.push_back( selVec[iSel]->clone() );
  }
}

//-----------------------------------------------------------------------------

CompositeSelection::CompositeSelection( const CompositeSelection& rhs )
  : IRecordSelection( rhs )
  , m_conn( rhs.m_conn )
  , m_selVec()
{
  for ( unsigned int iSel = 0; iSel < rhs.m_selVec.size(); iSel++ )
  {
    m_selVec.push_back( rhs.m_selVec[iSel]->clone() );
  }
}

//-----------------------------------------------------------------------------

CompositeSelection::CompositeSelection( Connective conn )
  : m_conn( conn )
  , m_selVec()
{
}

//-----------------------------------------------------------------------------

void CompositeSelection::connect( Connective conn,
                                  const IRecordSelection* sel )
{
  // Connect using the current logical connective
  if ( conn == m_conn )
  {
    m_selVec.push_back( sel->clone() );
  }
  // Connect using a different logical connective
  else
  {
    // Copy current selections into a clone and transfer their ownership
    CompositeSelection* sel1 = new CompositeSelection( m_conn );
    for ( unsigned int iSel = 0; iSel < m_selVec.size(); iSel++ )
    {
      sel1->m_selVec.push_back( m_selVec[iSel] );
    }
    m_selVec.clear();
    // Redefine this instance using clone, input selection and input connective
    m_conn = conn;
    m_selVec.push_back( sel1 );
    m_selVec.push_back( sel->clone() );
  }
}

//-----------------------------------------------------------------------------

bool
CompositeSelection::canSelect( const IRecordSpecification& rspec ) const
{
  for ( unsigned int iSel = 0; iSel < m_selVec.size(); iSel++ )
  {
    if ( ! m_selVec[iSel]->canSelect( rspec ) ) return false;
  }
  return true;
}

//-----------------------------------------------------------------------------

bool CompositeSelection::select( const IRecord& record ) const
{
  switch( m_conn )
  {
  case AND:
    for ( unsigned int iSel = 0; iSel < m_selVec.size(); iSel++ )
    {
      if ( ! m_selVec[iSel]->select( record ) ) return false;
    }
    return true;
  case OR:
    for ( unsigned int iSel = 0; iSel < m_selVec.size(); iSel++ )
    {
      if ( m_selVec[iSel]->select( record ) ) return true;
    }
    return false;
  default:
    throw InternalErrorException( "PANIC! Unknown logical connective",
                                  "CompositeSelection::select()" );
  }
}

//-----------------------------------------------------------------------------

IRecordSelection* CompositeSelection::clone() const
{
  return new CompositeSelection( *this );
}

//-----------------------------------------------------------------------------

CompositeSelection::Connective CompositeSelection::connective() const
{
  return m_conn;
}

//-----------------------------------------------------------------------------

unsigned int CompositeSelection::size() const
{
  return m_selVec.size();
}

//-----------------------------------------------------------------------------

const IRecordSelection*
CompositeSelection::operator[] ( unsigned int index ) const
{
  if ( index >= m_selVec.size() )
  {
    std::ostringstream msg;
    msg << "Selection #" << index
        << " not found in the composite selection"
        << " (expected range [0," << m_selVec.size()-1 << "])";
    throw RecordSelectionException( msg.str(),
                                    "CompositeSelection::operator[]" );
  }
  return m_selVec[index];
}

//-----------------------------------------------------------------------------
