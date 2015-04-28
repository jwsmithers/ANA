
// Include files
#include "CoralBase/AttributeList.h"
#include "RelationalAccess/IColumn.h"

// Local include files
#include "TableDataEditor.h"
#include "logger.h"

// Namespace
using namespace coral::CoralAccess;

//-----------------------------------------------------------------------------

TableDataEditor::TableDataEditor( const SessionProperties& /*sessionProperties*/,
                                  const ITableDescription& tableDescription )
  //: m_sessionProperties( sessionProperties ) // unused (bug #99801)
  : m_tableDescription( tableDescription )
{
  logger << "Create TableDataEditor" << endlog;
}

//-----------------------------------------------------------------------------

TableDataEditor::~TableDataEditor()
{
  logger << "Delete TableDataEditor" << endlog;
}

//-----------------------------------------------------------------------------

void TableDataEditor::rowBuffer( AttributeList& buffer )
{
  int nCol = m_tableDescription.numberOfColumns();
  for ( int iCol = 0; iCol < nCol; iCol++ ) {
    const IColumn& col = m_tableDescription.columnDescription( iCol );
    buffer.extend( col.name(), col.type() );
  }
}

//-----------------------------------------------------------------------------
