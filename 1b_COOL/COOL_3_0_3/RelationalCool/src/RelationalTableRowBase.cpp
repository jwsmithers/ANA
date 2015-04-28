
// Local include files
#include "RelationalTableRowBase.h"

// Namespace
using namespace cool;

//---------------------------------------------------------------------------

RelationalTableRowBase::~RelationalTableRowBase()
{
}

//---------------------------------------------------------------------------

RelationalTableRowBase::RelationalTableRowBase()
{
}

//---------------------------------------------------------------------------

RelationalTableRowBase::RelationalTableRowBase
( const RelationalTableRowBase& aRow )
  : m_data( aRow.m_data )
{
}

//---------------------------------------------------------------------------

RelationalTableRowBase&
RelationalTableRowBase::operator=( const RelationalTableRowBase& aRow )
{
  m_data = aRow.data();
  return *this;
}

//---------------------------------------------------------------------------

RelationalTableRowBase::RelationalTableRowBase
( const coral::AttributeList& data )
  : m_data( data )
{
}

//---------------------------------------------------------------------------
