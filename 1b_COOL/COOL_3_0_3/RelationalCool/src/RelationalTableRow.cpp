
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
