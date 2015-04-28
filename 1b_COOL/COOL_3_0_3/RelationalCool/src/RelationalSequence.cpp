
// Include files
#include "CoolKernel/RecordSpecification.h"
#include "CoralBase/Attribute.h"

// Local include files
#include "RelationalDatabase.h"
#include "RelationalException.h"
#include "RelationalQueryDefinition.h"
#include "RelationalQueryMgr.h"
#include "RelationalSequence.h"
#include "RelationalSequenceMgr.h"
#include "RelationalSequenceTable.h"
#include "RelationalTableRow.h"
#include "uppercaseString.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

RelationalSequence::RelationalSequence
( const std::string& name,
  const RelationalSequenceMgr& sequenceMgr )
  : m_name( name )
  , m_sequenceMgr( sequenceMgr )
{
  //std::cout << "RelationalSequence constructor" << std::endl;
}

//-----------------------------------------------------------------------------

RelationalSequence::~RelationalSequence()
{
  //std::cout << "RelationalSequence destructor" << std::endl;
}

//-----------------------------------------------------------------------------

const std::pair<unsigned, std::string>
RelationalSequence::currValDate( unsigned nSteps, bool forUpdate )
{
  if ( nSteps > 0 && !forUpdate )
    throw RelationalException
      ( "Need select for update if setting new value in currValDate()",
        "RelationalSequence" );

  // Select the row with the current sequence value and date FOR UPDATE
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( name() );
  queryDef.addSelectItem
    ( RelationalSequenceTable::columnNames::currentValue,
      RelationalSequenceTable::columnTypeIds::currentValue );
  queryDef.addSelectItem
    ( RelationalSequenceTable::columnNames::lastModDate,
      RelationalSequenceTable::columnTypeIds::lastModDate );
  RelationalTableRow row =
    sequenceMgr().queryMgr().fetchOrderedRows
    ( queryDef, "", 1, forUpdate )[0]; // no WHERE clause - expect 1 row
  const coral::AttributeList& attr = row.data();

  // Test whether the sequence is initialised
  bool isNull =
    attr[RelationalSequenceTable::columnNames::currentValue].isNull();

  // If nSteps == 0, return the current value
  // Throw an exception if the sequence is not yet initialised
  if ( nSteps == 0 )
  {
    if ( isNull )
    {
      throw RelationalException
        ( "Sequence is not initialized yet", "RelationalSequence" );
    }
    else
    {
      unsigned int currentValue =
        attr[RelationalSequenceTable::columnNames::currentValue]
        .data<RelationalSequenceTable::columnTypes::currentValue>();
      std::string lastModDate =
        attr[RelationalSequenceTable::columnNames::lastModDate]
        .data<RelationalSequenceTable::columnTypes::lastModDate>();
      return std::pair<unsigned int, std::string>( currentValue, lastModDate );
    }
  }

  // If nSteps > 0, increment the current value and return it
  // Initialise the sequence if the sequence is not yet initialised
  else
  {
    unsigned int nextValue;
    if ( isNull )
    {
      nextValue = s_firstValue;
      nextValue += s_increment * (nSteps - 1);
    }
    else
    {
      nextValue =
        attr[RelationalSequenceTable::columnNames::currentValue]
        .data<RelationalSequenceTable::columnTypes::currentValue>();
      nextValue += s_increment * nSteps;
    }
    RecordSpecification updateDataSpec;
    updateDataSpec.extend
      ( "newvalue",
        RelationalSequenceTable::columnTypeIds::currentValue );
    Record updateData( updateDataSpec );
    updateData["newvalue"].setValue( nextValue );
    std::string setClause = RelationalSequenceTable::columnNames::currentValue;
    setClause += "=:newvalue";
    setClause += ", ";
    setClause += RelationalSequenceTable::columnNames::lastModDate;
    setClause += "=";
    setClause += sequenceMgr().queryMgr().serverTimeClause();
    std::string dummyWhereClause = ""; // no selection (update all rows)

    // TEMPORARY? No need for checkAttributeListCompliance size checks here
    // at update time (the sequence name is unchanged and was checked at
    // insertion time, the sequence value has no maximum size to check,
    // the last modification date is a short string by construction)

    if ( ! sequenceMgr().queryMgr().updateTableRows
         ( name(), setClause, dummyWhereClause, updateData ) )
      throw RowNotUpdated
        ( "Could not update the sequence table", "RelationalSequence" );
    std::string lastModDate = "UNKNOWN";
    return std::pair<unsigned int, std::string>( nextValue, lastModDate );
  }

}

//-----------------------------------------------------------------------------
