// $Id: RelationalTableRow.cpp,v 1.6 2009-12-16 17:17:38 avalassi Exp $

// Local include files
#include "RelationalTableRow.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

RelationalTableRow::~RelationalTableRow()
{
}

//-----------------------------------------------------------------------------

RelationalTableRow::RelationalTableRow()
  : RelationalTableRowBase()
{
}

//-----------------------------------------------------------------------------

RelationalTableRow::RelationalTableRow
( const RelationalTableRow& aRow )
  : RelationalTableRowBase( aRow )
{
}

//-----------------------------------------------------------------------------

RelationalTableRow&
RelationalTableRow::operator=( const RelationalTableRow& aRow )
{
  m_data = aRow.data();
  return *this;
}

//---------------------------------------------------------------------------

RelationalTableRow::RelationalTableRow( const coral::AttributeList& data )
  : RelationalTableRowBase( data )
{
}

//-----------------------------------------------------------------------------
