
// Include files
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordSpecification.h"
#include "CoralBase/Attribute.h"

// Local include files
#include "RelationalDatabase.h"
#include "RelationalException.h"
#include "RelationalNodeMgr.h"
#include "RelationalNodeTable.h"
#include "RelationalQueryDefinition.h"
#include "RelationalQueryMgr.h"
#include "RelationalTableRow.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

RelationalNodeMgr::RelationalNodeMgr( const RelationalDatabase& aDb )
  : m_db( aDb )
  , m_log( new coral::MessageStream( "RelationalNodeMgr" ) )
{
  log() << coral::Debug << "Instantiate a RelationalNodeMgr"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

RelationalNodeMgr::~RelationalNodeMgr()
{
  log() << coral::Debug << "Delete the RelationalNodeMgr" << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

RelationalQueryMgr& RelationalNodeMgr::queryMgr() const
{
  return db().queryMgr();
}

//-----------------------------------------------------------------------------

bool RelationalNodeMgr::existsNode( const std::string& fullPath )
{
  // Transaction handled in the outer scope
  try
  {
    fetchNodeTableRow( fullPath );
    return true;
  }
  catch ( NodeTableRowNotFound& )
  {
    return false;
  }
}

//-----------------------------------------------------------------------------

bool RelationalNodeMgr::existsFolderSet( const std::string& fullPath )
{
  // Cross-check that the database is open
  db().checkDbOpenTransaction( "RelationalNodeMgr::existsFolderSet",
                               cool::ReadOnly );

  try
  {
    RelationalTableRow row = fetchNodeTableRow( fullPath );
    bool isLeaf =
      row[RelationalNodeTable::columnNames::nodeIsLeaf].data<bool>();
    return (!isLeaf);
  }
  catch ( NodeTableRowNotFound& )
  {
    return false;
  }
}

//-----------------------------------------------------------------------------

bool RelationalNodeMgr::existsFolder( const std::string& fullPath )
{
  // Cross-check that the database is open
  db().checkDbOpenTransaction( "RelationalNodeMgr::existsFolder",
                               cool::ReadOnly );

  try
  {
    RelationalTableRow row = fetchNodeTableRow( fullPath );
    bool isLeaf =
      row[RelationalNodeTable::columnNames::nodeIsLeaf].data<bool>();
    return isLeaf;
  }
  catch ( NodeTableRowNotFound& )
  {
    return false;
  }
}

//-----------------------------------------------------------------------------

const std::vector<std::string>
RelationalNodeMgr::listNodes( unsigned int nodeId,
                              bool isLeaf,
                              bool ascending )
{
  // Cross-check that the database is open
  db().checkDbOpenTransaction( "RelationalNodeMgr::listNodes",
                               cool::ReadOnly );

  // Define the WHERE clause for the selection using bind variables
  // NB: Oracle execution plan -- still to be tested
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "parentId",
                        RelationalNodeTable::columnTypeIds::nodeParentId );
  whereDataSpec.extend( "isLeaf",
                        RelationalNodeTable::columnTypeIds::nodeIsLeaf );
  Record whereData( whereDataSpec );
  whereData["parentId"].setValue( nodeId );
  whereData["isLeaf"].setValue( isLeaf );
  std::string whereClause = RelationalNodeTable::columnNames::nodeParentId;
  whereClause += "= :parentId";
  whereClause += " AND ";
  whereClause += RelationalNodeTable::columnNames::nodeIsLeaf;
  whereClause += "= :isLeaf";

  /// Define the ORDER BY clause for the selection
  std::string orderClause = RelationalNodeTable::columnNames::nodeFullPath;
  if ( ascending ) orderClause += " ASC";
  else orderClause += " DESC";

  // Delegate the query to the RelationalQueryMgr
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( db().nodeTableName() );
  queryDef.addSelectItems( RelationalNodeTable::tableSpecification() );
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );
  queryDef.addOrderItem( orderClause );
  std::vector<RelationalTableRow> rows =
    queryMgr().fetchOrderedRows( queryDef );

  // Loop over all rows and copy folder names into a string vector
  std::vector<std::string> folderList;
  for ( std::vector<RelationalTableRow>::const_iterator
          row = rows.begin(); row != rows.end(); ++row ) {
    std::string fullPath =
      (*row)[RelationalNodeTable::columnNames::nodeFullPath]
      .data<std::string>();
    folderList.push_back( fullPath );
  }
  return folderList;
}

//-----------------------------------------------------------------------------

const std::vector<std::string>
RelationalNodeMgr::listAllNodes( bool ascending )
{
  // Loop over all rows and copy folder names into a string vector
  std::vector<RelationalTableRow> rows =
    fetchAllNodeTableRows( ascending );
  std::vector<std::string> folderList;
  for ( std::vector<RelationalTableRow>::const_iterator
          row = rows.begin(); row != rows.end(); ++row ) {
    std::string fullPath =
      (*row)[RelationalNodeTable::columnNames::nodeFullPath]
      .data<std::string>();
    folderList.push_back( fullPath );
  }

  // Return the list of folders
  return folderList;
}

//-----------------------------------------------------------------------------

const std::vector<RelationalTableRow>
RelationalNodeMgr::fetchAllNodeTableRows( bool ascending ) const
{
  log() << "Fetch all nodes in the database" << coral::MessageStream::endmsg;

  // Cross-check that the database is open
  db().checkDbOpenTransaction( "RelationalNodeMgr::fetchAllNodeTableRows",
                               cool::ReadOnly );

  // Define the ORDER BY clause for the selection
  // NB: Oracle execution plan, from interactive Benthic test, uses
  // => ASCENDING: fast access via the 1D primary key index on nodeId
  // (SELECT STATEMENT, TABLE ACCESS BY INDEX ROWID, INDEX FULL SCAN)
  // => DESCENDING: ?
  // NB: the above applies to previous ordering by nodeId
  std::string orderClause = RelationalNodeTable::columnNames::nodeFullPath;
  if ( ascending ) orderClause += " ASC";
  else orderClause += " DESC";

  // Delegate the query to the RalQueryMgr
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( db().nodeTableName() );
  queryDef.addSelectItems( RelationalNodeTable::tableSpecification() );
  queryDef.addOrderItem( orderClause );
  std::vector<RelationalTableRow> rows =
    queryMgr().fetchOrderedRows( queryDef ); // no WHERE clause (all nodes)

  // Return the list of folders
  return rows;
}

//-----------------------------------------------------------------------------

const RelationalTableRow
RelationalNodeMgr::fetchNodeTableRow( const std::string& fullPath ) const
{
  log() << "Fetch table row for folder[set] with fullPath="
        << fullPath << coral::MessageStream::endmsg;

  // Define the WHERE clause for the selection using bind variables
  // NB: Oracle execution plan, from interactive Benthic test, uses
  // fast access via the 1D index on fullPath
  // (SELECT STATEMENT, TABLE ACCESS BY INDEX ROWID, INDEX RANGE SCAN)
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "fullName",
                        RelationalNodeTable::columnTypeIds::nodeFullPath );
  Record whereData( whereDataSpec );
  whereData["fullName"].setValue( fullPath );
  std::string whereClause = RelationalNodeTable::columnNames::nodeFullPath;
  whereClause += "= :fullName";

  // Execute the query
  try
  {
    return fetchNodeTableRow( whereClause, whereData );
  }
  catch( NodeTableRowNotFound& )
  {
    throw NodeTableRowNotFound( fullPath, "RelationalNodeMgr" );
  }
}

//-----------------------------------------------------------------------------

const RelationalTableRow
RelationalNodeMgr::fetchNodeTableRow( unsigned int nodeId ) const
{
  log() << "Fetch table row for folder[set] with nodeId="
        << nodeId << coral::MessageStream::endmsg;

  // Define the WHERE clause for the selection using bind variables
  // NB: Oracle execution plan -- still to be tested
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "nodeId",
                        RelationalNodeTable::columnTypeIds::nodeId );
  Record whereData( whereDataSpec );
  whereData["nodeId"].setValue( nodeId );
  std::string whereClause = RelationalNodeTable::columnNames::nodeId;
  whereClause += "= :nodeId";

  // Execute the query
  try
  {
    return fetchNodeTableRow( whereClause, whereData );
  }
  catch( NodeTableRowNotFound& )
  {
    throw NodeTableRowNotFound( nodeId, "RelationalNodeMgr" );
  }
}

//-----------------------------------------------------------------------------

const RelationalTableRow
RelationalNodeMgr::fetchNodeTableRow( const std::string& whereClause,
                                      const Record& whereData ) const
{
  try
  {
    RelationalQueryDefinition queryDef;
    queryDef.addFromItem( db().nodeTableName() );
    queryDef.addSelectItems( RelationalNodeTable::tableSpecification() );
    queryDef.setWhereClause( whereClause );
    queryDef.setBindVariables( whereData );
    return queryMgr().fetchOrderedRows( queryDef, "", 1 )[0]; // expect 1 row
  }
  catch( NoRowsFound& )
  {
    throw NodeTableRowNotFound( "RelationalNodeMgr" );
  }
}

//-----------------------------------------------------------------------------

const std::vector<UInt32>
RelationalNodeMgr::resolveNodeHierarchy( UInt32 ancestorNodeId,
                                         UInt32 descendantNodeId ) const
{
  log() << "Find all descendants of node #" << ancestorNodeId
        << " until node #" << descendantNodeId << " included" << coral::MessageStream::endmsg;
  if ( ancestorNodeId == descendantNodeId )
    throw NodeRelationNotFound
      ( ancestorNodeId, descendantNodeId, "RelationalNodeMgr" );
  std::vector<UInt32> nodes;
  UInt32 nodeId = descendantNodeId;
  while ( true ) {
    RelationalTableRow row = fetchNodeTableRow( nodeId );
    UInt32 parentId =
      row[RelationalNodeTable::columnNames::nodeParentId].data<UInt32>();
    if ( parentId == nodeId )
    {
      // End of the loop: root node - node hierarchy not resolved
      throw NodeRelationNotFound
        ( ancestorNodeId, descendantNodeId, "RelationalNodeMgr" );
    }
    else if ( parentId == ancestorNodeId )
    {
      // End of the loop: ancestor found - node hierarchy resolved
      std::vector<UInt32> revNodes;
      for ( std::vector<UInt32>::reverse_iterator
              node = nodes.rbegin(); node != nodes.rend(); ++node )
        revNodes.push_back( *node );
      revNodes. push_back( descendantNodeId );
      return revNodes;
    }
    else
    {
      // Continue the loop
      nodes.push_back( parentId );
      nodeId = parentId;
    }
  }
}

//-----------------------------------------------------------------------------
