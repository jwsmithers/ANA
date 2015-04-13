// $Id: TransRelObjectIterator.cpp,v 1.2 2011-04-09 20:41:47 avalassi Exp $

// include files

// Local include files
#include "RelationalTransaction.h"
#include "TransRelObjectIterator.h"


// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

void TransRelObjectIterator::close()
{
  m_it->close();
  if ( m_trans.get() )
  {
    m_trans->commit();
    m_trans.reset(0);
  }
}

//-----------------------------------------------------------------------------
