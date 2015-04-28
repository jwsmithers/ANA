
// Include files
#include <sstream>

// Include files (COOL)
#include "CoolKernel/Record.h"
#include "CoolKernel/InternalErrorException.h"

// Include files (query management)
#include "CoralBase/Attribute.h"
#include "RelationalAccess/ICursor.h"
#include "RelationalAccess/IQuery.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ITable.h"

// Include files (update management)
#include "RelationalAccess/ITableDataEditor.h"

// Local include files
#include "IRelationalQueryDefinition.h"
#include "ISessionMgr.h"
#include "RalBulkOperation.h"
#include "RalCursor.h"
#include "RalQueryMgr.h"
#include "RalSequenceMgr.h"
#include "RelationalException.h"
#include "RelationalQueryDefinition.h"
#include "RelationalTableRow.h"
#include "TimingReportMgr.h"
//#include "attributeListToString.h" // debug only

// Namespace
using namespace cool;

//---------------------------------------------------------------------------

//RalQueryMgr::RalQueryMgr( const boost::shared_ptr<ISessionMgr>& sessionMgr )
RalQueryMgr::RalQueryMgr( const ISessionMgr& sessionMgr )
  : RelationalQueryMgr()
  , m_sessionMgr( &sessionMgr )
{
  log() << coral::Debug << "Instantiate a RalQueryMgr"
        << coral::MessageStream::endmsg;
  log() << coral::Debug << "Remote database technology: '"
        << databaseTechnology() << "'"
        << coral::MessageStream::endmsg;
  m_sequenceMgr = new RalSequenceMgr( *this, *m_sessionMgr );
}

//---------------------------------------------------------------------------

RalQueryMgr::~RalQueryMgr()
{
  log() << coral::Debug << "Delete the RalQueryMgr"
        << coral::MessageStream::endmsg;
  delete m_sequenceMgr; // First delete sequenceMgr (referencing sessionMgr)
  //m_sessionMgr.reset(); // Then release shared pointer to sessionMgr
}

//---------------------------------------------------------------------------

/*
RelationalQueryMgr* RalQueryMgr::clone() const
{
  log() << coral::Debug << "Clone a RalQueryMgr"
        << coral::MessageStream::endmsg;
  return new RalQueryMgr( m_sessionMgr ); // NB m_sessionMgr is shared pointer
}
*///

//---------------------------------------------------------------------------

bool RalQueryMgr::existsTable( const std::string& tableName ) const
{
  return m_sessionMgr->session().nominalSchema().existsTable( tableName );
}

//---------------------------------------------------------------------------

std::auto_ptr<coral::IQuery> RalQueryMgr::newQuery() const
{
  std::auto_ptr<coral::IQuery>
    query( m_sessionMgr->session().nominalSchema().newQuery() );
  return query;
}

//---------------------------------------------------------------------------

void RalQueryMgr::prepareQueryDefinition
( coral::IQueryDefinition& coralDef,
  const IRelationalQueryDefinition& coolDef,
  bool countStarSubquery ) const
{
  // Add tables and subqueries in the FROM clause (with aliases if != "")
  for ( unsigned item = 0; item < coolDef.getFromSize(); item++ )
  {
    const IRelationalQueryDefinition::IFromItem&
      fromItem = coolDef.getFromItem( item );
    std::string alias = fromItem.alias();
    if ( !fromItem.isSubquery() )
    {
      std::string tableName = fromItem.expression();
      // TODO: fix bug #43528
      // [expression() may be "schema.tableName" and existsTable may fails...]
      if ( ! existsTable( tableName ) )
        throw TableNotFound( tableName, "RalQueryMgr" );
      coralDef.addToTableList( tableName, alias );
    }
    else
    {
      coral::IQueryDefinition& coralSQDef =
        coralDef.defineSubQuery( alias );
      prepareQueryDefinition( coralSQDef, fromItem.subquery() );
      coralDef.addToTableList( alias );
    }
  }

  // Add all columns and subqueries in the SELECT list (with aliases if != "")
  // [do this also for 'SELECT COUNT(*) FROM ( subquery )' queries]
  for ( unsigned item = 0; item < coolDef.getSelectSize(); item++ )
  {
    const IRelationalQueryDefinition::ISelectItem&
      selectItem = coolDef.getSelectItem( item );
    std::string alias = selectItem.alias();
    //if ( !selectItem.isSubquery() )
    {
      std::string expression = selectItem.expression();
      if ( item == 0 && coolDef.getHint() != "" )
        expression =  coolDef.getHint() + " " + expression;
      coralDef.addToOutputList( expression, alias );
    }
    //else {}
  }

  // Set the WHERE clause and bind variables
  coralDef.setCondition( coolDef.getWhereClause(),
                         coolDef.getBindVariables().attributeList() );

  // Add columns to the GROUP BY clause.
  for ( unsigned item = 0; item < coolDef.getGroupSize(); item++ )
  {
    const IRelationalQueryDefinition::IGroupItem&
      groupItem = coolDef.getGroupItem( item );
    coralDef.groupBy( groupItem.expression() );
  }

  // Add columns to the ORDER BY clause.
  // Omit the ORDER BY clause for 'SELECT COUNT(*) FROM ( subquery )' queries.
  if ( ! countStarSubquery )
  {
    for ( unsigned item = 0; item < coolDef.getOrderSize(); item++ )
    {
      const IRelationalQueryDefinition::IOrderItem&
        orderItem = coolDef.getOrderItem( item );
      coralDef.addToOrderList( orderItem.expression() );
    }
  }

}

//---------------------------------------------------------------------------

std::auto_ptr<coral::IQuery>
RalQueryMgr::prepareQuery
( const IRelationalQueryDefinition& coolDef,
  boost::shared_ptr<coral::AttributeList>& dataBuffer ) const
{
  std::auto_ptr<coral::IQuery> query( newQuery() );

  // Prepare the query definition
  prepareQueryDefinition( *(query.get()), coolDef );

  // Set the aliases and C++ types of the selected fields in the result set
  // (the AttributeList is used by CORAL as data buffer for the current row)
  const IRecordSpecification& resultSetSpec =
    coolDef.getResultSetSpecification();
  dataBuffer.reset
    ( new coral::AttributeList( Record(resultSetSpec).attributeList() ) );
  //std::cout << "RalQueryMgr::prepareQuery2 defineOutput: " << dataBuffer.get() << std::endl;
  query->defineOutput( *dataBuffer );

  // Set the prefetch row cache size
  int newRowCacheSize = 100;
  query->setRowCacheSize( newRowCacheSize );

  // Return the query
  return query;
}

//---------------------------------------------------------------------------

IRelationalCursor* RalQueryMgr::prepareAndExecuteQuery
( const IRelationalQueryDefinition& coolDef,
  boost::shared_ptr<coral::AttributeList>& dataBuffer ) const
{
  std::auto_ptr<coral::IQuery> query( prepareQuery( coolDef, dataBuffer ) );

  // Execute the CORAL query and return the wrapped cursor
  return new RalCursor( query );
}

//---------------------------------------------------------------------------

const std::vector<RelationalTableRow>
RalQueryMgr::fetchOrderedRows
( const IRelationalQueryDefinition& coolDef,
  const std::string& description,
  UInt32 nExp,
  bool forUpdate ) const
{
  // Prepare the appropriate CORAL query
  boost::shared_ptr<coral::AttributeList> dataBuffer;
  std::auto_ptr<coral::IQuery> query( prepareQuery( coolDef, dataBuffer ) );

  // Lock the selected rows for update if required
  if ( forUpdate ) query->setForUpdate();

  // Describe the table list
  std::stringstream tableList;
  for ( unsigned item = 0; item < coolDef.getFromSize(); item++ )
  {
    const IRelationalQueryDefinition::IFromItem&
      fromItem = coolDef.getFromItem( item );
    std::string tableAlias = fromItem.alias();
    std::string tableName;
    if ( !fromItem.isSubquery() )
      tableName = fromItem.expression();
    else
      tableName = "(SELECT ... FROM ...)";
    if ( tableList.str() != "" ) tableList << ", ";
    tableList << tableName;
    if ( tableAlias != "" ) tableList << " as " << tableAlias;
  }

  // Describe the query
  std::string msg = "";
  if ( description != "" ) msg = " ('" + description + "')";

  // Retrieve the result set into a vector of rows
  // If required, check that exactly nExp rows are selected
  coral::ICursor& cursor = query->execute();
  std::vector<RelationalTableRow> rows;
  //bool cursorHasNext = cursorNext( cursor ); // with TimingReport
  bool cursorHasNext = cursor.next();
  while ( cursorHasNext )
  {
    if ( nExp > 0 && rows.size() > nExp )
    {
      std::stringstream s;
      s << "More than " << nExp << " rows selected from "
        << tableList.str() << msg;
      log() << coral::Verbose
            << "TooManyRowsFound: " << s.str() << coral::MessageStream::endmsg;
      throw TooManyRowsFound( s.str(), "RalQueryMgr" );
    }
    //std::cout << "Current row: "
    //          << attributeListToString( cursor.currentRow() ) << std::endl;
    RelationalTableRow row( cursor.currentRow() );
    rows.push_back( row );
    //cursorHasNext = cursorNext( cursor ); // with TimingReport
    cursorHasNext = cursor.next();
  }
  if ( nExp > 0 ) {
    if ( rows.size() == 0 ) {
      std::stringstream s;
      s << "No rows selected from " << tableList.str() << msg;
      log() << coral::Verbose
            << "NoRowsFound: " << s.str() << coral::MessageStream::endmsg;
      throw NoRowsFound( s.str(), "RalQueryMgr" );
    }
    else if ( rows.size() < nExp ) {
      std::stringstream s;
      s << "Too few rows selected from " << tableList.str() << msg;
      log() << coral::Verbose
            << "NoRowsFound: " << s.str() << coral::MessageStream::endmsg;
      throw NoRowsFound( s.str(), "RalQueryMgr" );
    }
  }

  // Return the rows retrieved from the database
  log() << "Successfully fetched " << rows.size() << " table rows"
        << msg << coral::MessageStream::endmsg;
  //std::vector<RelationalTableRow>::const_iterator rowIt;
  //for ( rowIt = rows.begin(); rowIt != rows.end(); rowIt++ )
  //  std::cout << attributeListToString( rowIt->data() ) << std::endl;
  return rows;

}

//---------------------------------------------------------------------------

UInt32 RalQueryMgr::countRows
( const IRelationalQueryDefinition& coolDef,
  const std::string& description ) const
{
  // Create a new CORAL query
  std::auto_ptr<coral::IQuery>
    query( m_sessionMgr->session().nominalSchema().newQuery() );

  // Define a subquery (strictly needed only if there is a GROUP BY clause)
  // Speed this up by removing the original ORDER BY clause [but keep the
  // original SELECTed columns - strictly necessary for MAX/SUM aggregates]
  coral::IQueryDefinition& subquery = query->defineSubQuery( "subquery" );
  bool countStarSubquery = true;
  prepareQueryDefinition( subquery, coolDef, countStarSubquery );
  query->addToTableList( "subquery" );

  // Describe the table list
  std::stringstream tableList;
  for ( unsigned item = 0; item < coolDef.getFromSize(); item++ )
  {
    const IRelationalQueryDefinition::IFromItem&
      fromItem = coolDef.getFromItem( item );
    std::string tableAlias = fromItem.alias();
    std::string tableName;
    if ( !fromItem.isSubquery() )
      tableName = fromItem.expression();
    else
      tableName = "(SELECT ... FROM ...)";
    if ( tableList.str() != "" ) tableList << ", ";
    tableList << tableName;
    if ( tableAlias != "" ) tableList << " as " << tableAlias;
  }

  // Define the output
  std::string countStar = "COUNT(*)"; // UPPERCASE for CORAL bug #16621
  query->addToOutputList( countStar );
  coral::AttributeList output; // This is not a temporary (it was on SQLite...)
  output.extend( countStar, "unsigned int" );
  query->defineOutput( output ); // For all backends (workaround bug #54756)

  // Retrieve a cursor over the result set
  coral::ICursor& cursor = query->execute();

  // Describe the query
  std::string msg = "";
  if ( description != "" ) msg = " ('" + description + "')";

  // Check that at least one row is selected
  {
    //bool cursorHasNext = cursorNext( cursor ); // with TimingReport
    bool cursorHasNext = cursor.next();
    if ( ! cursorHasNext ) // CORAL bug #16621 appears here
      throw NoRowsFound
        ( "No rows selected from " + tableList.str() + msg, "RalQueryMgr" );
  }

  // Retrieve the row count from the result set
  const coral::Attribute& countAttr = cursor.currentRow()[ countStar ];
  UInt32 count = countAttr.data<unsigned int>();

  // Check that only row is selected
  {
    //bool cursorHasNext = cursorNext( cursor ); // with TimingReport
    bool cursorHasNext = cursor.next();
    if ( cursorHasNext )
      throw TooManyRowsFound
        ( "More than one rows selected from " + tableList.str() + msg,
          "RalQueryMgr" );
  }

  // Return the row count retrieved from the database
  log() << "Table row count successfully fetched" << msg
        << ": count=" << count << coral::MessageStream::endmsg;
  return count;

}

//---------------------------------------------------------------------------

boost::shared_ptr<IRelationalBulkOperation>
RalQueryMgr::bulkInsertTableRows( const std::string& tableName,
                                  const Record& dataBuffer,
                                  int rowCacheSize ) const
{
  if ( rowCacheSize <=1 )
    throw InternalErrorException( "PANIC! RowCacheSize <= 1",
                                  "RalQueryMgr::bulkInsertTableRows" );
  coral::ITable& table =
    m_sessionMgr->session().nominalSchema().tableHandle( tableName );
  boost::shared_ptr<coral::IBulkOperation>
    coralBulkOperation( table.dataEditor().bulkInsert
                        ( dataBuffer.attributeList(), rowCacheSize ) );
  boost::shared_ptr<IRelationalBulkOperation>
    bulkInserter( new RalBulkOperation( coralBulkOperation, rowCacheSize ) );
  return bulkInserter;
}

//---------------------------------------------------------------------------

void RalQueryMgr::insertTableRow( const std::string& tableName,
                                  const Record& data ) const
{
  coral::ITable& table =
    m_sessionMgr->session().nominalSchema().tableHandle( tableName );
  return table.dataEditor().insertRow( data.attributeList() );
}

//---------------------------------------------------------------------------

boost::shared_ptr<IRelationalBulkOperation>
RalQueryMgr::bulkUpdateTableRows( const std::string& tableName,
                                  const std::string& setClause,
                                  const std::string& whereClause,
                                  const Record& dataBuffer,
                                  int rowCacheSize ) const
{
  if ( rowCacheSize <=1 )
    throw InternalErrorException( "PANIC! RowCacheSize <= 1",
                                  "RalQueryMgr::bulkInsertTableRows" );
  coral::ITable& table =
    m_sessionMgr->session().nominalSchema().tableHandle( tableName );
  boost::shared_ptr<coral::IBulkOperation> coralBulkOperation
    ( table.dataEditor().bulkUpdateRows
      ( setClause, whereClause, dataBuffer.attributeList(), rowCacheSize ) );
  boost::shared_ptr<IRelationalBulkOperation>
    bulkUpdater( new RalBulkOperation( coralBulkOperation, rowCacheSize ) );
  return bulkUpdater;
}

//---------------------------------------------------------------------------

UInt32 RalQueryMgr::updateTableRows
( const std::string& tableName,
  const std::string& setClause,
  const std::string& whereClause,
  const Record& updateData,
  UInt32 nExp ) const
{
  coral::ITable& table =
    m_sessionMgr->session().nominalSchema().tableHandle( tableName );
  UInt32 nRows = table.dataEditor().updateRows
    ( setClause, whereClause, updateData.attributeList() );
  if ( nExp > 0 ) {
    if ( nRows < nExp ) {
      std::stringstream s;
      s << "Could not update rows in table '" << tableName
        << "': updated " << nRows << ", expected " << nExp;
      throw RowNotUpdated( s.str(), "RalQueryMgr" );
    }
    else if ( nRows > nExp ) {
      std::stringstream s;
      s << "PANIC! Too many rows updated in table '" << tableName
        << "': updated " << nRows << ", expected " << nExp;
      throw RelationalException( s.str(), "RalQueryMgr" );
    }
  }
  return nRows;
}

//---------------------------------------------------------------------------

UInt32 RalQueryMgr::deleteTableRows
( const std::string& tableName,
  const std::string& whereClause,
  const Record& whereData,
  UInt32 nExp ) const
{
  UInt32 nRowsExp;
  if ( nExp > 0 )
  {
    nRowsExp = nExp;
  }
  else
  {
    RelationalQueryDefinition queryDef;
    queryDef.addFromItem( tableName );
    queryDef.setWhereClause( whereClause );
    queryDef.setBindVariables( whereData );
    nRowsExp = countRows( queryDef ); // no WHERE clause
  }
  coral::ITable& table =
    m_sessionMgr->session().nominalSchema().tableHandle( tableName );
  UInt32 nRows =
    table.dataEditor().deleteRows( whereClause, whereData.attributeList() );
  if ( nRows < nRowsExp ) {
    std::stringstream s;
    s << "Could not delete rows from table '" << tableName
      << "': deleted " << nRows << ", expected " << nRowsExp;
    throw RowNotDeleted( s.str(), "RalQueryMgr" );
  }
  else if ( nRows > nRowsExp ) {
    std::stringstream s;
    s << "PANIC! Too many rows deleted from table '" << tableName
      << "': deleted " << nRows << ", expected " << nRowsExp;
    throw RelationalException( s.str(), "RalQueryMgr" );
  }
  return nRows;
}

//---------------------------------------------------------------------------

void RalQueryMgr::deleteAllTableRows
( const std::string& tableName ) const
{
  if ( databaseTechnology() == "Oracle" || databaseTechnology() == "MySQL" )
  {
    // TRUNCATE TABLE triggers ORA-02266 if there are FKs (bug #64113)
    // TRUNCATE TABLE triggers MySQL-1701 if there are FKs (bug #103683)
    std::string dummyClause;
    Record dummyData;
    deleteTableRows( tableName, dummyClause, dummyData );
  }
  else
  {
    m_sessionMgr->session().nominalSchema().truncateTable( tableName );
  }
}

//---------------------------------------------------------------------------

const std::string RalQueryMgr::serverTimeClause() const
{
  return RelationalQueryMgr::serverTimeClause
    ( m_sessionMgr->databaseTechnology() );
}

//---------------------------------------------------------------------------

coral::ICursor& RalQueryMgr::executeQuery( coral::IQuery& query )
{
  if ( TimingReportMgr::isActive() )
    TimingReportMgr::startTimer( "coral::IQuery::execute()" );
  coral::ICursor& cursor = query.execute();
  if ( TimingReportMgr::isActive() )
    TimingReportMgr::stopTimer( "coral::IQuery::execute()" );
  return cursor;
}

//---------------------------------------------------------------------------

bool RalQueryMgr::cursorNext( coral::ICursor& cursor )
{
  if ( TimingReportMgr::isActive() )
    TimingReportMgr::startTimer( "coral::ICursor::next()" );
  bool hasNext = cursor.next();
  if ( TimingReportMgr::isActive() )
    TimingReportMgr::stopTimer( "coral::ICursor::next()" );
  return hasNext;
}

//---------------------------------------------------------------------------

const std::string RalQueryMgr::databaseTechnology() const
{
  return m_sessionMgr->databaseTechnology();
}

//---------------------------------------------------------------------------

const std::string RalQueryMgr::serverVersion() const
{
  return m_sessionMgr->serverVersion();
}

//---------------------------------------------------------------------------

const std::string RalQueryMgr::schemaName() const
{
  return m_sessionMgr->schemaName();
}

//---------------------------------------------------------------------------
