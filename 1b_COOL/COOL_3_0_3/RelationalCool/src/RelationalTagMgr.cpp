// Include files
#include "CoolKernel/Record.h"
#include "CoolKernel/RecordSpecification.h"
#include "CoralBase/Attribute.h"

// Local include files
#include "IRelationalTransactionMgr.h"
#include "RelationalDatabase.h"
#include "RelationalException.h"
#include "RelationalFolder.h"
#include "RelationalGlobalTagTable.h"
#include "RelationalHvsTagRecord.h"
#include "RelationalNodeMgr.h"
#include "RelationalNodeTable.h"
#include "RelationalQueryDefinition.h"
#include "RelationalQueryMgr.h"
#include "RelationalSequence.h"
#include "RelationalSequenceMgr.h"
#include "RelationalTableRow.h"
#include "RelationalTagMgr.h"
#include "RelationalTagSequence.h"
#include "RelationalTag2TagTable.h"
#include "scoped_enums.h"
#include "timeToString.h"

// Namespace
using namespace cool;

// Local type definitions
typedef boost::shared_ptr<RelationalSequence> RelationalSequencePtr;

//-----------------------------------------------------------------------------

RelationalTagMgr::RelationalTagMgr
( const RelationalDatabase& aDb )
  : m_db( aDb )
  , m_log( new coral::MessageStream( "RelationalTagMgr" ) )
{
  log() << coral::Debug << "Instantiate a RelationalTagMgr"
        << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

RelationalTagMgr::~RelationalTagMgr()
{
  log() << coral::Debug << "Delete the RelationalTagMgr" << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

RelationalQueryMgr& RelationalTagMgr::queryMgr() const
{
  return db().queryMgr();
}

//-----------------------------------------------------------------------------

RelationalNodeMgr& RelationalTagMgr::nodeMgr() const
{
  return db().nodeMgr();
}

//-----------------------------------------------------------------------------

const RelationalTableRow
RelationalTagMgr::fetchGlobalTagTableRowForNode
( const std::string& tagName ) const
{
  log() << "Fetch global tag table row for tag " << tagName
        << coral::MessageStream::endmsg;

  // TEMPORARY implementation - until the isLeaf column is added
  bool leafFound = false;
  bool innerFound = false;
  RelationalTableRow row;
  const std::vector<RelationalTableRow> rows =
    fetchGlobalTagTableRows( tagName );

  // Loop over all tag records retrieved
  for ( std::vector<RelationalTableRow>::const_iterator
          rowIt = rows.begin(); rowIt != rows.end(); ++rowIt )
  {
    const RelationalTableRow& tagRow = *rowIt;
    UInt32 nodeId =
      tagRow[RelationalGlobalTagTable::columnNames::nodeId].data<UInt32>();
    const RelationalTableRow nodeRow =
      nodeMgr().fetchNodeTableRow( nodeId );
    bool isLeaf =
      nodeRow[RelationalNodeTable::columnNames::nodeIsLeaf].data<bool>();
    if ( isLeaf )
    {
      leafFound = true;
      row = tagRow;
    }
    else
    {
      if ( innerFound )
      {
        throw RelationalException
          ( "PANIC! Tag applied to more than one inner node!",
            "RelationalTagMgr" );
      }
      else
      {
        innerFound = true;
        row = tagRow;
      }
    }
  }

  // Tag not found in any (inner or leaf) node
  if ( !innerFound && !leafFound )
    throw TagNotFound
      ( "Tag '" + tagName + "' not found in any node", "RelationalTagMgr" );

  // Tag found both in an inner and in a leaf node?!
  if ( innerFound && leafFound )
    throw RelationalException
      ( "PANIC! Tag applied to both inner and leaf nodes!",
        "RelationalTagMgr" );

  // Tag found (either in an inner or in a leaf node)
  // Do not use "else" here: workaround for a warning on MacOSX
  // (control reaches end of non-void function) - see task #2062
  return row;

}

//-----------------------------------------------------------------------------

const std::vector<RelationalTableRow>
RelationalTagMgr::fetchGlobalTagTableRows( UInt32 nodeId ) const
{
  log() << "Fetch global tag table rows for node #" << nodeId << coral::MessageStream::endmsg;

  // Define the WHERE clause for the selection using bind variables
  RecordSpecification whereDataSpec;
  whereDataSpec.extend
    ( "nodeId", RelationalGlobalTagTable::columnTypeIds::nodeId );
  Record whereData( whereDataSpec );
  whereData["nodeId"].setValue( nodeId );
  std::string whereClause = RelationalGlobalTagTable::columnNames::nodeId;
  whereClause += "= :nodeId";

  // Delegate the query to the RelationalQueryMgr
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( db().globalTagTableName() );
  queryDef.addSelectItems( RelationalGlobalTagTable::tableSpecification() );
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );
  std::vector<RelationalTableRow> rows =
    queryMgr().fetchOrderedRows( queryDef );
  return rows;
}

//-----------------------------------------------------------------------------

const std::vector<RelationalTableRow>
RelationalTagMgr::fetchGlobalTagTableRows( const std::string& tagName ) const
{
  log() << "Fetch global tag table rows for tag " << tagName << coral::MessageStream::endmsg;

  // Define the WHERE clause for the selection using bind variables
  RecordSpecification whereDataSpec;
  whereDataSpec.extend
    ( "tagName", RelationalGlobalTagTable::columnTypeIds::tagName );
  Record whereData( whereDataSpec );
  whereData["tagName"].setValue( tagName );
  std::string whereClause = RelationalGlobalTagTable::columnNames::tagName;
  whereClause += "= :tagName";

  // Delegate the query to the RelationalQueryMgr
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( db().globalTagTableName() );
  queryDef.addSelectItems( RelationalGlobalTagTable::tableSpecification() );
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );
  std::vector<RelationalTableRow> rows =
    queryMgr().fetchOrderedRows( queryDef );
  if ( rows.size() != 0 )
    return rows;
  else
    throw TagNotFound( "Tag '" + tagName + "' not found in any node",
                       "RelationalTagMgr" );
}

//-----------------------------------------------------------------------------

const RelationalTableRow
RelationalTagMgr::fetchGlobalTagTableRow( UInt32 nodeId,
                                          const std::string& tagName ) const
{
  log() << "Fetch global tag table row for nodeId=" << nodeId
        << " and tag=" << tagName << coral::MessageStream::endmsg;

  // Define the WHERE clause for the selection using bind variables
  RecordSpecification whereDataSpec;
  whereDataSpec.extend
    ( "nodeId", RelationalGlobalTagTable::columnTypeIds::nodeId );
  whereDataSpec.extend
    ( "tagName", RelationalGlobalTagTable::columnTypeIds::tagName );
  Record whereData( whereDataSpec );
  whereData["nodeId"].setValue( nodeId );
  whereData["tagName"].setValue( tagName );
  std::string whereClause;
  whereClause += RelationalGlobalTagTable::columnNames::nodeId;
  whereClause += "= :nodeId";
  whereClause += " AND ";
  whereClause += RelationalGlobalTagTable::columnNames::tagName;
  whereClause += "= :tagName";

  // Delegate the query to the RelationalQueryMgr
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( db().globalTagTableName() );
  queryDef.addSelectItems( RelationalGlobalTagTable::tableSpecification() );
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );
  try
  {
    return queryMgr().fetchOrderedRows( queryDef, "", 1 )[0]; // expect 1 row
  }
  catch( NoRowsFound& )
  {
    throw TagNotFound( tagName, nodeId, "RelationalTagMgr" );
  }
}

//-----------------------------------------------------------------------------

const RelationalTableRow
RelationalTagMgr::fetchGlobalTagTableRow( UInt32 nodeId,
                                          UInt32 tagId ) const
{
  log() << "Fetch global tag table row for nodeId=" << nodeId
        << " and tagId=" << tagId << coral::MessageStream::endmsg;

  // Define the WHERE clause for the selection using bind variables
  RecordSpecification whereDataSpec;
  whereDataSpec.extend
    ( "nodeId", RelationalGlobalTagTable::columnTypeIds::nodeId );
  whereDataSpec.extend
    ( "tagId", RelationalGlobalTagTable::columnTypeIds::tagId );
  Record whereData( whereDataSpec );
  whereData["nodeId"].setValue( nodeId );
  whereData["tagId"].setValue( tagId );
  std::string whereClause;
  whereClause += RelationalGlobalTagTable::columnNames::nodeId;
  whereClause += "= :nodeId";
  whereClause += " AND ";
  whereClause += RelationalGlobalTagTable::columnNames::tagId;
  whereClause += "= :tagId";

  // Delegate the query to the RelationalQueryMgr
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( db().globalTagTableName() );
  queryDef.addSelectItems( RelationalGlobalTagTable::tableSpecification() );
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );
  try
  {
    return queryMgr().fetchOrderedRows( queryDef, "", 1 )[0]; // expect 1 row
  }
  catch( NoRowsFound& )
  {
    throw TagNotFound( tagId, nodeId, "RelationalTagMgr" );
  }
}

//-----------------------------------------------------------------------------

bool RelationalTagMgr::existsTag( const std::string& tagName ) const
{
  if ( IHvsNode::isHeadTag( tagName ) ) return true;
  try
  {
    // TEMPORARY! This STILL assumes 'tag = tag name' and one node per tag!
    tagNameScope( tagName );
    return true;
  }
  catch ( TagNotFound& )
  {
    return false;
  }
}

//-----------------------------------------------------------------------------

IHvsNode::Type
RelationalTagMgr::tagNameScope( const std::string& tagName ) const
{
  // Cross-check that the database is open
  if ( ! db().isOpen() ) throw DatabaseNotOpen( "RelationalTagMgr" );
  db().checkDbOpenTransaction( "RelationalTagMgr::tagNameScope",
                               cool::ReadOnly );


  bool isLeaf;
  if ( IHvsNode::isHeadTag( tagName ) )
    isLeaf = true;
  RelationalTableRow nodeRow;
  std::vector<RelationalTableRow> tagRows =
    fetchGlobalTagTableRows( tagName ); // throws TagNotFound if none found
  UInt32 nRows = tagRows.size();
  if ( nRows == 0 )
  {
    throw PanicException( "No rows and no throw from fetchGlobalTagTableRows?",
                          "RelationalTagMgr::tagNameScope" );
  }
  else if ( nRows > 1 )
  {
    // AV TEMPORARY - UGLY AND DANGEROUS!
    isLeaf = true;
  }
  else
  {
    RelationalTableRow& tagRow = tagRows[0];
    UInt32 nodeId =
      tagRow[RelationalGlobalTagTable::columnNames::nodeId].data<UInt32>();
    nodeRow = nodeMgr().fetchNodeTableRow( nodeId );
    isLeaf =
      nodeRow[RelationalNodeTable::columnNames::nodeIsLeaf].data<bool>();
  }
  if ( isLeaf )
    return cool_IHvsNode_Type::LEAF_NODE;
  else
    return cool_IHvsNode_Type::INNER_NODE;
}

//-----------------------------------------------------------------------------

const std::vector<std::string>
RelationalTagMgr::taggedNodes( const std::string& tagName ) const
{
  // Cross-check that the database is open
  db().checkDbOpenTransaction( "RelationalTagMgr::taggedNodes",
                               cool::ReadOnly );

  std::vector<std::string> nodes;
  if ( IHvsNode::isHeadTag( tagName ) )
    throw ReservedHeadTag( tagName, "RelationalTagMgr" );

  std::vector<RelationalTableRow> rows =
    fetchGlobalTagTableRows( tagName ); // throws TagNotFound if none found
  for ( std::vector<RelationalTableRow>::const_iterator
          row = rows.begin(); row != rows.end(); ++row )
  {
    const RelationalTableRow& tagRow = *row;
    unsigned int nodeId =
      tagRow[RelationalGlobalTagTable::columnNames::nodeId]
      .data<unsigned int>();
    RelationalTableRow nodeRow = nodeMgr().fetchNodeTableRow( nodeId );
    std::string fullPath =
      nodeRow[RelationalNodeTable::columnNames::nodeFullPath]
      .data<std::string>();
    nodes.push_back( fullPath );
  }
  return nodes;
}

//-----------------------------------------------------------------------------

const HvsTagRecord
RelationalTagMgr::findTagRecord( UInt32 nodeId,
                                 const std::string& tagName ) const
{
  db().checkDbOpenTransaction( "RelationalTagMgr::findTagRecord",
                               cool::ReadOnly );

  RelationalTableRow
    row( fetchGlobalTagTableRow( nodeId, tagName ) );
  //std::cout << "*** RelationalTagMgr::findTagRecord - 2" << std::endl;

  // AV - Split up the following line in two parts for clarity
  //RelationalHvsTagRecord record( row.data() );

  const coral::AttributeList &rowAL = row.data();
  //std::cout << "*** RelationalTagMgr::findTagRecord - 3" << std::endl;
  //std::cout << "*** RelationalTagMgr::findTagRecord - input AL size: "
  //          << rowAL.size() << std::endl;
  //std::stringstream msg;
  //rowAL.toOutputStream( msg );
  //std::cout << "*** RelationalTagMgr::findTagRecord - input AL: "
  //          << msg.str() << std::endl;

  // AV - The following will throw an unknown exception on Windows
  //RelationalHvsTagRecord record( rowAL );

  // AV - The following is a workaround (WHY???)
  HvsTagRecord record0 = RelationalHvsTagRecord::fromRow( rowAL );
  //std::cout << "*** RelationalTagMgr::findTagRecord - 4" << std::endl;
  RelationalHvsTagRecord record( record0 );

  //std::cout << "*** RelationalTagMgr::findTagRecord - END" << std::endl;
  return record;
}

//-----------------------------------------------------------------------------

const HvsTagRecord
RelationalTagMgr::findTagRecord( UInt32 nodeId,
                                 UInt32 tagId ) const
{
  db().checkDbOpenTransaction( "RelationalTagMgr::findTagRecord",
                               cool::ReadOnly );

  RelationalTableRow
    row( fetchGlobalTagTableRow( nodeId, tagId ) );

  // AV - Split up the following line in two parts for clarity
  //RelationalHvsTagRecord record( row.data() );
  const coral::AttributeList &rowAL = row.data();
  // AV - The following will throw an unknown exception on Windows
  //RelationalHvsTagRecord record( rowAL );
  // AV - Apply the same workaround as for findTagRecord( nodeId, tagId )
  HvsTagRecord record0 = RelationalHvsTagRecord::fromRow( rowAL );
  RelationalHvsTagRecord record( record0 );

  return record;
}

//-----------------------------------------------------------------------------

const Time
RelationalTagMgr::tagInsertionTime
( const IHvsNode* node, const std::string& tagName ) const
{
  //std::cout << "*** RelationalTagMgr::tagInsertionTime - START" << std::endl;

  // HEAD tag for folder sets, SV folders, MV folders
  if ( IHvsNode::isHeadTag( tagName ) )
  {
    //std::cout << "*** RelationalTagMgr::tagInsTime - END HEAD" << std::endl;
    return node->insertionTime();
  }

  // Retrieve the tag insertion time from the global tag table
  return findTagRecord( node->id(), tagName ).insertionTime();

  /*
  // Folder set - retrieve the tag insertion time from the global tag table
  if ( !node->isLeaf() )
  {
    return findTagRecord( node->id(), tagName ).insertionTime();
  }

  // Folder
  else
  {
    const RelationalFolder* folder =
      dynamic_cast<const RelationalFolder*>( node );
    if ( !folder )
      throw RelationalException
        ( "PANIC! Could not dynamic cast IHvsNode* to RelationalFolder*",
          "RelationalTagMgr" );
    // SV folder
    if ( folder->versioningMode() != cool_FolderVersioning_Mode::MULTI_VERSION )
    {
      throw TagNotFound( tagName, folder->fullPath(), "RelationalTagMgr" );
    }
    // MV folder - retrieve the tag insertion time from the global tag table
    else
    {
      //std::cout << "*** RelationalTagMgr::tagInsTime - END MV" << std::endl;
      return findTagRecord( folder->id(), tagName ).insertionTime();
    }
  }
  *///

}

//-----------------------------------------------------------------------------

const std::string
RelationalTagMgr::tagDescription
( const IHvsNode* node, const std::string& tagName ) const
{
  // HEAD tag for folder sets, SV folders, MV folders
  if ( IHvsNode::isHeadTag( tagName ) )
    return std::string( "HEAD tag" );

  // Retrieve the tag description from the global tag table
  return findTagRecord( node->id(), tagName ).description();

  /*
  // Folder set - retrieve the tag description from the global tag table
  if ( !node->isLeaf() )
  {
    return findTagRecord( node->id(), tagName ).description();
  }

  // Folder
  else
  {
    const RelationalFolder* folder =
      dynamic_cast<const RelationalFolder*>( node );
    if ( !folder )
      throw RelationalException
        ( "PANIC! Could not dynamic cast IHvsNode* to RelationalFolder*",
          "RelationalTagMgr" );
    // SV folder
    if ( folder->versioningMode() != cool_FolderVersioning_Mode::MULTI_VERSION )
    {
      throw TagNotFound( tagName, node->fullPath(), "RelationalTagMgr" );
    }
    // MV folder - retrieve the tag description from the global tag table
    else
    {
      return findTagRecord( folder->id(), tagName ).description();
    }
  }
  *///

}

//-----------------------------------------------------------------------------

HvsTagLock::Status
RelationalTagMgr::tagLockStatus
( const IHvsNode* node, const std::string& tagName ) const
{
  // HEAD tag for folder sets, SV folders, MV folders - never locked!
  if ( IHvsNode::isHeadTag( tagName ) )
  {
    return cool_HvsTagLock_Status::UNLOCKED;
  }

  // Retrieve the tag lock status from the global tag table
  return findTagRecord( node->id(), tagName ).lockStatus();

  /*
  // Folder set - retrieve the tag lock status from the global tag table
  if ( !node->isLeaf() )
  {
    return findTagRecord( node->id(), tagName ).lockStatus();
  }

  // Folder
  else
  {
    const RelationalFolder* folder =
      dynamic_cast<const RelationalFolder*>( node );
    if ( !folder )
      throw RelationalException
        ( "PANIC! Could not dynamic cast IHvsNode* to RelationalFolder*",
          "RelationalTagMgr" );
    // SV folder
    if ( folder->versioningMode() != cool_FolderVersioning_Mode::MULTI_VERSION )
    {
      throw TagNotFound( tagName, folder->fullPath(), "RelationalTagMgr" );
    }
    // MV folder - retrieve the tag lock status from the global tag table
    else
    {
      return findTagRecord( folder->id(), tagName ).lockStatus();
    }
  }
  *///

}

//-----------------------------------------------------------------------------

void
RelationalTagMgr::setTagLockStatus( const IHvsNode* node,
                                    const std::string& tagName,
                                    HvsTagLock::Status tagLockStatus )
{
  // HEAD tag for folder sets, SV folders, MV folders - never locked!
  if ( IHvsNode::isHeadTag( tagName ) )
  {
    throw ReservedHeadTag( tagName, "RelationalTagMgr" );
  }

  db().checkDbOpenTransaction( "RelationalTagMgr::setTagLockStatus",
                               cool::ReadWrite );


  // Define the SET and WHERE clauses for the update using bind variables
  RecordSpecification updateDataSpec;
  updateDataSpec.extend
    ( "tagLockStatus",
      RelationalGlobalTagTable::columnTypeIds::tagLockStatus );
  updateDataSpec.extend
    ( "nodeId",
      RelationalGlobalTagTable::columnTypeIds::nodeId );
  updateDataSpec.extend
    ( "tagName",
      RelationalGlobalTagTable::columnTypeIds::tagName );
  Record updateData( updateDataSpec );
  updateData["tagLockStatus"].setValue( (UInt16)tagLockStatus );
  updateData["nodeId"].setValue( node->id() );
  updateData["tagName"].setValue( tagName );
  std::string setClause =
    RelationalGlobalTagTable::columnNames::tagLockStatus;
  setClause += "= :tagLockStatus";
  std::string whereClause = RelationalGlobalTagTable::columnNames::nodeId;
  whereClause += " = :nodeId";
  whereClause += " AND ";
  whereClause += RelationalGlobalTagTable::columnNames::tagName;
  whereClause += " = :tagName";

  // Execute the update
  if ( 1 != queryMgr().updateTableRows
       ( db().globalTagTableName(), setClause, whereClause, updateData ) )
    throw RowNotUpdated
      ( "Could not update the tag lock status - does tag exist?",
        "RalDatabase" );

}

//-----------------------------------------------------------------------------

const HvsTagRecord
RelationalTagMgr::findOrCreateTag( UInt32 nodeId,
                                   const std::string& tagName ) const
{
  if ( ! db().isOpen() ) throw DatabaseNotOpen( "RelationalTagMgr" );
  try
  {
    // AV - Split up the following line in two parts for clarity
    //RelationalHvsTagRecord record
    //  ( fetchGlobalTagTableRow( nodeId, tagName ).data() );
    const coral::AttributeList rowAL =
      fetchGlobalTagTableRow( nodeId, tagName ).data();
    // AV - The following will throw an unknown exception on Windows
    //RelationalHvsTagRecord record( rowAL );
    // AV - Apply the same workaround as for findTagRecord( nodeId, tagId )
    HvsTagRecord record0 = RelationalHvsTagRecord::fromRow( rowAL );
    RelationalHvsTagRecord record( record0 );
    return record;
  }
  catch ( TagNotFound& )
  {
    // PERFORMANCE WARNING - createTag() will query existsTag() a 2nd time
    std::string description = "";
    return createTag( nodeId, tagName, description );
  }
}

//-----------------------------------------------------------------------------

const HvsTagRecord
RelationalTagMgr::createTag( UInt32 nodeId,
                             const std::string& tagName,
                             const std::string& description ) const
{
  return createTagAndLocalTag( nodeId, tagName, description, "" );
}

//-----------------------------------------------------------------------------

const HvsTagRecord
RelationalTagMgr::createTagAndLocalTag
( UInt32 nodeId,
  const std::string& tagName,
  const std::string& description,
  const std::string& inputTagTableName ) const
{
  // Check if this tag exists (globally)
  // [NB existsTag(tagName) returns true for the reserved tags "" or "HEAD"]
  if ( existsTag( tagName ) )
    throw TagExists( tagName, "RelationalTagMgr" );

  // TEMPORARY! - Start
  // TEMPORARY! Functionality needed but this implementation is an ugly hack!
  // Check whether the node supports versioning - is it a SV folder?
  // Must perform the check before retrieving the tag sequence (none for SV!)
  // HACK - Skip check if input local tag name is provided
  std::string tagTableName = "";
  if ( inputTagTableName != "" )
  {
    tagTableName = inputTagTableName;
  }
  else
  {
    RelationalTableRow row = nodeMgr().fetchNodeTableRow( nodeId );
    bool isLeaf =
      row[RelationalNodeTable::columnNames::nodeIsLeaf].data<bool>();
    if ( isLeaf )
    {
      FolderVersioning::Mode mode =
        RelationalFolder::versioningMode( row.data() );
      if ( mode == cool_FolderVersioning_Mode::MULTI_VERSION )
        tagTableName = RelationalFolder::tagTableName( row.data() );
      else
        throw FolderIsSingleVersion( nodeId, "RelationalTagMgr" );
    }
  }
  // TEMPORARY! - End

  // Get a new tag ID from the sequence
  std::string tagSeqName = RelationalTagSequence::sequenceName
    ( db().defaultTablePrefix(), nodeId );
  RelationalSequencePtr sequence
    ( db().queryMgr().sequenceMgr().getSequence( tagSeqName ) );
  UInt32 tagId = sequence->nextVal();
  const std::string insertionTime = sequence->currDate(); // nextVal -> recent!

  // New tags are UNLOCKED
  HvsTagLock::Status tagLockStatus = cool_HvsTagLock_Status::UNLOCKED;

  // Register the tag in the global tag table
  insertGlobalTagTableRow
    ( nodeId, tagId, tagName, tagLockStatus, description, insertionTime );

  // TEMPORARY! - Start
  // TEMPORARY! - Also fill the local tag table if necessary.
  // Fill the local tag table name if one is provided.
  // Otherwise retrieve it from the node table for MV folders.
  // Insert the new tag also in the local tag table
  if ( tagTableName != "" )
    insertTagTableRow
      ( tagTableName, tagId, tagName, description, insertionTime );
  // TEMPORARY! - End

  // Return the new tag ID
  return HvsTagRecord( tagId, nodeId, tagName, tagLockStatus, description,
                       stringToTime( insertionTime ) );
}

//-----------------------------------------------------------------------------

void RelationalTagMgr::deleteTag( UInt32 nodeId,
                                  const std::string& tagName ) const
{
  deleteGlobalTagTableRow( nodeId, findTagRecord( nodeId, tagName ).id() );
}

//-----------------------------------------------------------------------------

void RelationalTagMgr::insertGlobalTagTableRow
( UInt32 nodeId,
  UInt32 tagId,
  const std::string& tagName,
  HvsTagLock::Status tagLockStatus,
  const std::string& tagDescription,
  const std::string& insertionTime ) const
{
  // Existence check handled in the outer scope

  // Register the tag in the global tag table
  Record data( RelationalGlobalTagTable::tableSpecification() );
  data[RelationalGlobalTagTable::columnNames::nodeId].setValue
    ( nodeId );
  data[RelationalGlobalTagTable::columnNames::tagId].setValue
    ( tagId );
  data[RelationalGlobalTagTable::columnNames::tagName].setValue
    ( tagName );
  data[RelationalGlobalTagTable::columnNames::tagLockStatus].setValue
    ( (UInt16)tagLockStatus );
  data[RelationalGlobalTagTable::columnNames::tagDescription].setValue
    ( tagDescription );
  data[RelationalGlobalTagTable::columnNames::sysInsTime].setValue
    ( insertionTime );

  /*
  // Check that all column values are within their allowed range.
  // REMOVE? This is already done by the IField::setValue calls above.
  RelationalGlobalTagTable::tableSpecification().validate( data );
  *///

  // Perform the actual db update
  queryMgr().insertTableRow( db().globalTagTableName(), data );
}

//-----------------------------------------------------------------------------

void RelationalTagMgr::deleteGlobalTagTableRow( UInt32 nodeId,
                                                UInt32 tagId ) const
{
  // Throw TagIsLocked if the tag is locked (either LOCKED or PARTIALLYLOCKED,
  // both are equivalent here): this is not strictly necessary because
  // this protection is already implemented where necessary (i.e.
  // in deleteTag for MV folders and in deleteTagRelation), but is added
  // here for extra protection at the cost of little performance overhead.
  // PANIC exception because there should be no path to this statement...!
  const HvsTagRecord tag = findTagRecord( nodeId, tagId );
  if ( tag.lockStatus() != cool_HvsTagLock_Status::UNLOCKED )
  {
    std::stringstream msg;
    msg << "PANIC! Cannot delete global tag table row for tag '" << tag.name()
        << " (tag #" << tagId << ") in node #" << nodeId
        << ": tag is locked";
    throw TagIsLocked( msg.str(), "RelationalTagMgr" );
  }
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "nodeId",
                        RelationalGlobalTagTable::columnTypeIds::nodeId );
  whereDataSpec.extend( "tagId",
                        RelationalGlobalTagTable::columnTypeIds::tagId );
  Record whereData( whereDataSpec );
  whereData["nodeId"].setValue( nodeId );
  whereData["tagId"].setValue( tagId );
  std::string whereClause;
  whereClause += RelationalGlobalTagTable::columnNames::nodeId;
  whereClause += "= :nodeId";
  whereClause += " AND ";
  whereClause += RelationalGlobalTagTable::columnNames::tagId;
  whereClause += "= :tagId";
  queryMgr().deleteTableRows
    ( db().globalTagTableName(), whereClause, whereData, 1 );
}

//-----------------------------------------------------------------------------

UInt32
RelationalTagMgr::deleteGlobalTagTableRowsForNode( UInt32 nodeId ) const
{
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "nodeId",
                        RelationalGlobalTagTable::columnTypeIds::nodeId );
  Record whereData( whereDataSpec );
  whereData["nodeId"].setValue( nodeId );
  std::string whereClause = RelationalGlobalTagTable::columnNames::nodeId;
  whereClause += "= :nodeId";
  return queryMgr().deleteTableRows
    ( db().globalTagTableName(), whereClause, whereData );
}

//-----------------------------------------------------------------------------

void RelationalTagMgr::insertTagTableRow
( const std::string& tagTableName,
  UInt32 tagId,
  const std::string& tagName,
  const std::string& description,
  const std::string& insertionTime ) const
{

  // AV - DO NOT TEST IF TAG EXISTS HERE - TAG DOES EXIST IN GLOBAL TAG TABLE!

  // Register the tag in the local tag table
  const IRecordSpecification& dataSpec =
    RelationalTagTable::tableSpecification();
  Record data( dataSpec );
  data[RelationalTagTable::columnNames::tagId].setValue
    ( tagId );
  data[RelationalTagTable::columnNames::tagName].setValue
    ( tagName );
  data[RelationalTagTable::columnNames::tagDescription].setValue
    ( description );
  data[RelationalTagTable::columnNames::sysInsTime].setValue
    ( insertionTime );

  /*
  // Check that all column values are within their allowed range.
  // REMOVE? This is already done by the IField::setValue calls above.
  dataSpec.validate( data );
  *///

  // Perform the actual db update
  queryMgr().insertTableRow( tagTableName, data );

  // Return the systemID for the tag
  //return tagId;
}

//-----------------------------------------------------------------------------

void RelationalTagMgr::deleteTagTableRow( const std::string& tagTableName,
                                          UInt32 tagId ) const
{
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "tagId",
                        RelationalTagTable::columnTypeIds::tagId );
  Record whereData( whereDataSpec );
  whereData["tagId"].setValue( tagId );
  std::string whereClause = RelationalTagTable::columnNames::tagId;
  whereClause += "= :tagId";
  queryMgr().deleteTableRows( tagTableName, whereClause, whereData, 1 );
}

//-----------------------------------------------------------------------------

void RelationalTagMgr::insertTag2TagTableRow
( UInt32 parentNodeId,
  UInt32 parentTagId,
  UInt32 childNodeId,
  UInt32 childTagId,
  const std::string& insertionTime ) const
{
  // Existence check handled in the outer scope

  // Register the tag in the global tag table
  const IRecordSpecification& dataSpec =
    RelationalTag2TagTable::tableSpecification();
  Record data( dataSpec );
  data[RelationalTag2TagTable::columnNames::parentNodeId].setValue
    ( parentNodeId );
  data[RelationalTag2TagTable::columnNames::parentTagId].setValue
    ( parentTagId );
  data[RelationalTag2TagTable::columnNames::childNodeId].setValue
    ( childNodeId );
  data[RelationalTag2TagTable::columnNames::childTagId].setValue
    ( childTagId );
  data[RelationalTag2TagTable::columnNames::sysInsTime].setValue
    ( insertionTime );

  /*
  // Check that all column values are within their allowed range.
  // REMOVE? This is already done by the IField::setValue calls above.
  dataSpec.validate( data );
  *///

  // Perform the actual db update
  queryMgr().insertTableRow( db().tag2TagTableName(), data );
}

//-----------------------------------------------------------------------------

const RelationalTableRow
RelationalTagMgr::fetchTag2TagTableRow( UInt32 parentNodeId,
                                        UInt32 parentTagId,
                                        UInt32 childNodeId ) const
{
  log() << "Fetch tag2tag row for relation between parent tag #"
        << parentTagId << " in node #" << parentNodeId
        << " and child tag in node #" << childNodeId
        << coral::MessageStream::endmsg;

  RecordSpecification whereDataSpec;
  whereDataSpec.extend
    ( "parentNodeId", RelationalTag2TagTable::columnTypeIds::parentNodeId );
  whereDataSpec.extend
    ( "parentTagId", RelationalTag2TagTable::columnTypeIds::parentTagId );
  whereDataSpec.extend
    ( "childNodeId", RelationalTag2TagTable::columnTypeIds::childNodeId );
  Record whereData( whereDataSpec );
  whereData["parentNodeId"].setValue( parentNodeId );
  whereData["parentTagId"].setValue( parentTagId );
  whereData["childNodeId"].setValue( childNodeId );
  std::string whereClause;
  whereClause += RelationalTag2TagTable::columnNames::parentNodeId;
  whereClause += "= :parentNodeId";
  whereClause += " AND ";
  whereClause += RelationalTag2TagTable::columnNames::parentTagId;
  whereClause += "= :parentTagId";
  whereClause += " AND ";
  whereClause += RelationalTag2TagTable::columnNames::childNodeId;
  whereClause += "= :childNodeId";
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( db().tag2TagTableName() );
  queryDef.addSelectItems( RelationalTag2TagTable::tableSpecification() );
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );
  try
  {
    return queryMgr().fetchOrderedRows( queryDef, "", 1 )[0]; // expect 1 row
  }
  catch( NoRowsFound& )
  {
    throw TagRelationNotFound
      ( parentNodeId, parentTagId, childNodeId, "RelationalTagMgr" );
  }
}

//-----------------------------------------------------------------------------

void RelationalTagMgr::deleteTag2TagTableRow( UInt32 parentNodeId,
                                              UInt32 parentTagId,
                                              UInt32 childNodeId ) const
{
  log() << "Delete tag2tag row for relation between parent tag #"
        << parentTagId << " in node #" << parentNodeId
        << " and child tag in node #" << childNodeId << coral::MessageStream::endmsg;

  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "parentNodeId",
                        RelationalTag2TagTable::columnTypeIds::parentNodeId );
  whereDataSpec.extend( "parentTagId",
                        RelationalTag2TagTable::columnTypeIds::parentTagId );
  whereDataSpec.extend( "childNodeId",
                        RelationalTag2TagTable::columnTypeIds::childNodeId );
  Record whereData( whereDataSpec );
  whereData["parentNodeId"].setValue( parentNodeId );
  whereData["parentTagId"].setValue( parentTagId );
  whereData["childNodeId"].setValue( childNodeId );
  std::string whereClause;
  whereClause += RelationalTag2TagTable::columnNames::parentNodeId;
  whereClause += "= :parentNodeId";
  whereClause += " AND ";
  whereClause += RelationalTag2TagTable::columnNames::parentTagId;
  whereClause += "= :parentTagId";
  whereClause += " AND ";
  whereClause += RelationalTag2TagTable::columnNames::childNodeId;
  whereClause += "= :childNodeId";
  queryMgr().deleteTableRows
    ( db().tag2TagTableName(), whereClause, whereData, 1 );
}

//-----------------------------------------------------------------------------

UInt32
RelationalTagMgr::deleteTag2TagTableRowsForNode( UInt32 nodeId ) const
{
  RecordSpecification whereDataSpec;
  whereDataSpec.extend( "parentNodeId",
                        RelationalTag2TagTable::columnTypeIds::parentNodeId );
  whereDataSpec.extend( "childNodeId",
                        RelationalTag2TagTable::columnTypeIds::childNodeId );
  Record whereData( whereDataSpec );
  whereData["parentNodeId"].setValue( nodeId );
  whereData["childNodeId"].setValue( nodeId );
  std::string whereClause;
  whereClause += RelationalTag2TagTable::columnNames::parentNodeId;
  whereClause += "= :parentNodeId";
  whereClause += " OR ";
  whereClause += RelationalTag2TagTable::columnNames::childNodeId;
  whereClause += "= :childNodeId";
  return queryMgr().deleteTableRows
    ( db().tag2TagTableName(), whereClause, whereData );
}

//-----------------------------------------------------------------------------

bool
RelationalTagMgr::existsTagInTag2TagTable( UInt32 nodeId,
                                           UInt32 tagId ) const
{
  RecordSpecification whereDataSpec;
  whereDataSpec.extend
    ( "parentNodeId", RelationalTag2TagTable::columnTypeIds::parentNodeId );
  whereDataSpec.extend
    ( "parentTagId", RelationalTag2TagTable::columnTypeIds::parentTagId );
  whereDataSpec.extend
    ( "childNodeId", RelationalTag2TagTable::columnTypeIds::childNodeId );
  whereDataSpec.extend
    ( "childTagId", RelationalTag2TagTable::columnTypeIds::childTagId );
  Record whereData( whereDataSpec );
  whereData["parentNodeId"].setValue( nodeId );
  whereData["parentTagId"].setValue( tagId );
  whereData["childNodeId"].setValue( nodeId );
  whereData["childTagId"].setValue( tagId );
  std::string whereClause;
  whereClause += "( ";
  whereClause += RelationalTag2TagTable::columnNames::parentNodeId;
  whereClause += " = :parentNodeId";
  whereClause += " AND ";
  whereClause += RelationalTag2TagTable::columnNames::parentTagId;
  whereClause += " = :parentTagId";
  whereClause += " ) OR ( ";
  whereClause += RelationalTag2TagTable::columnNames::childNodeId;
  whereClause += " = :childNodeId";
  whereClause += " AND ";
  whereClause += RelationalTag2TagTable::columnNames::childTagId;
  whereClause += " = :childTagId";
  whereClause += " )";
  RelationalQueryDefinition queryDef;
  queryDef.addFromItem( db().tag2TagTableName() );
  queryDef.setWhereClause( whereClause );
  queryDef.setBindVariables( whereData );
  unsigned int rowCount = db().queryMgr().countRows( queryDef );
  return ( rowCount > 0 );
}

//-----------------------------------------------------------------------------
/*
bool
RelationalTagMgr::isTagUsed( UInt32 nodeId,
                             UInt32 tagId ) const
{
  // Is the tag referenced in the TAG2TAG table?
  if ( existsTagInTag2TagTable( nodeId, tagId ) )
  {
    return true;
  }
  // TEMPORARY? Not nice to have this code here :-(
  // Otherwise - must check if this is a folder or folder set
  else
  {
    // If this is a folder set, return false
    // If this is a folder, check the IOV and IOV2TAG tables
  }
}
*///
//-----------------------------------------------------------------------------

void
RelationalTagMgr::createTagRelation( UInt32 parentNodeId,
                                     const std::string& parentTagName,
                                     UInt32 childNodeId,
                                     const std::string& childTagName ) const
{
  log() << "Create tag relation between parent tag '" << parentTagName
        << "' in node #" << parentNodeId << " and child tag '" << childTagName
        << "' in node #" << childNodeId << coral::MessageStream::endmsg;

  // Throw ReservedHeadTag if one of the two tags is a HEAD tag
  if ( IHvsNode::isHeadTag( parentTagName ) )
    throw ReservedHeadTag( parentTagName, "RelationalTagMgr" );
  if ( IHvsNode::isHeadTag( childTagName ) )
    throw ReservedHeadTag( childTagName, "RelationalTagMgr" );

  // Throw InvalidTagRelation if the two tags are the same (bug #68071)
  if ( parentTagName == childTagName )
    throw InvalidTagRelation( parentTagName, childTagName, childNodeId,
                              "child and parent tag are the same",
                              "RelationalTagMgr" );

  // Throw NodeRelationNotFound if the nodes are not parent and child
  // TEMPORARY! Replace by a method returning a node record...
  RelationalTableRow childNode =
    db().nodeMgr().fetchNodeTableRow( childNodeId );
  if ( childNode[RelationalNodeTable::columnNames::nodeParentId].isNull() )
  {
    // Better fix for bug #35891 (already solved by the fix for bug #34512)
    throw InvalidTagRelation( parentTagName, childTagName, childNodeId,
                              "child node has no parent",
                              "RelationalTagMgr" );
  }
  else if ( childNode[RelationalNodeTable::columnNames::nodeParentId].data<UInt32>() != parentNodeId )
  {
    throw NodeRelationNotFound
      ( parentNodeId, childNodeId, "RelationalTagMgr", true );
  }

  // Create the parent tag in the parent node if not defined yet.
  const HvsTagRecord parentTag =
    findOrCreateTag( parentNodeId, parentTagName );
  UInt32 parentTagId = parentTag.id();

  // Throw TagIsLocked if the tag is fully LOCKED.
  // A new relation can be created both if UNLOCKED or PARTIALLYLOCKED:
  // I can add a new child tag relation to a partially locked parent tag.
  // If a relation already exists, TagRelationExists is thrown in all cases!
  if ( parentTag.lockStatus() != cool_HvsTagLock_Status::UNLOCKED &&
       parentTag.lockStatus() != cool_HvsTagLock_Status::PARTIALLYLOCKED )
    throw TagIsLocked
      ( "Cannot create tag relation to parent tag '" + parentTagName +
        "': tag is locked", "RelationalTagMgr" );

  // Create the child tag in the child node if not defined yet.
  UInt32 childTagId =
    findOrCreateTag( childNodeId, childTagName ).id();

  // Throw TagRelationExists if a relation to a child tag already exists
  bool tagRelationExists = false;
  try
  {
    findTagRelation( parentNodeId, parentTagName, childNodeId );
    tagRelationExists = true;
  }
  catch( ... ) {}
  if ( tagRelationExists )
    throw TagRelationExists
      ( parentNodeId, parentTagId, childNodeId, "RelationalTagMgr" );

  // Get a new insertion time from the tag2tag sequence
  const std::string tableName = db().tag2TagTableName();
  const std::string seqName =
    RelationalTag2TagTable::sequenceName( tableName );
  RelationalSequencePtr sequence
    ( db().queryMgr().sequenceMgr().getSequence( seqName ) );
  sequence->nextVal(); // TEMPORARY! value not used: need a non-sequence clock!
  const std::string insertionTime = sequence->currDate(); // nextVal -> recent!

  // Insert a new row in the tag2tag table
  insertTag2TagTableRow
    ( parentNodeId, parentTagId, childNodeId, childTagId, insertionTime );
}

//-----------------------------------------------------------------------------

//void
UInt32
RelationalTagMgr::deleteTagRelation( UInt32 parentNodeId,
                                     const std::string& parentTagName,
                                     UInt32 childNodeId ) const
{
  log() << "Delete tag relation between parent tag '" << parentTagName
        << "' in node #" << parentNodeId
        << " and child tag in node #" << childNodeId << coral::MessageStream::endmsg;

  // Throw ReservedHeadTag if the parent tag is a HEAD tag
  if ( IHvsNode::isHeadTag( parentTagName ) )
    throw ReservedHeadTag( parentTagName, "RelationalTagMgr" );

  // Throw TagNotFound if the parent tag does not exist in the parent node
  const HvsTagRecord tag = findTagRecord( parentNodeId, parentTagName );
  UInt32 parentTagId = tag.id();

  // Throw TagIsLocked if the tag is locked
  // (either LOCKED or PARTIALLYLOCKED - both are equivalent here)
  if ( tag.lockStatus() != cool_HvsTagLock_Status::UNLOCKED )
    throw TagIsLocked
      ( "Cannot delete tag relation to parent tag '" + parentTagName +
        "': tag is locked", "RelationalTagMgr" );

  // Throw TagRelationNotFound if the parent tag has no related child tag
  RelationalTableRow relation =
    fetchTag2TagTableRow( parentNodeId, parentTagId, childNodeId );
  UInt32 childTagId =
    relation[RelationalTag2TagTable::columnNames::childTagId].data<UInt32>();

  // Delete the relation between a parent tag node and a child tag
  deleteTag2TagTableRow( parentNodeId, parentTagId, childNodeId );

  // Delete the parent tag if not related to another parent/child tag.
  // TEMPORARY? Assume the parent can only be a folder set!
  // All there is to delete in this case is the global tag table row
  if ( ! existsTagInTag2TagTable( parentNodeId, parentTagId ) )
    deleteGlobalTagTableRow( parentNodeId, parentTagId );

  // TEMPORARY - this is handled in the calling routine...
  // Delete the tag in this node if not related to another parent or IOVs.
  // Throw TagIsLocked if this would lead to deletion of a locked child tag
  // (either LOCKED or PARTIALLYLOCKED - both are equivalent here).

  // TEMPORARY- return the childTagId
  return childTagId;
}

//-----------------------------------------------------------------------------

void
RelationalTagMgr::deleteTagRelation( const RelationalHvsNode& childNode,
                                     const std::string& parentTagName ) const
{
  UInt32 parentNodeId = childNode.parentId();
  UInt32 childNodeId = childNode.id();

  // First delete the tag relation
  UInt32 childTagId =
    deleteTagRelation( parentNodeId, parentTagName, childNodeId );

  // Then, delete also the child tag if this has no IOV or HVS relations left
  // Throw TagIsLocked if this would lead to deletion of a locked child tag
  // (either LOCKED or PARTIALLYLOCKED - both are equivalent here)
  // [this is ALSO implemented in deleteGlobalTagTableRow for extra protection]
  const HvsTagRecord childTag =
    findTagRecord( childNodeId, childTagId );

  // Check if this is a folder or a folder set
  bool isLeaf = childNode.isLeaf();
  // Folder set - nothing else to check or to delete
  if ( !isLeaf )
  {
    if ( ! existsTagInTag2TagTable( childNodeId, childTagId ) )
    {
      if ( childTag.lockStatus() != cool_HvsTagLock_Status::UNLOCKED )
        throw TagIsLocked
          ( "Cannot delete tag relation to parent tag '" + parentTagName +
            "': this would lead to the deletion of locked child tag '"
            + childTag.name() + "'", "RelationalTagMgr" );
      deleteGlobalTagTableRow( childNodeId, childTagId );
    }
  }
  // Folder - check if SV or MV
  else
  {
    const RelationalFolder* pFolder;
    try
    {
      const RelationalFolder& folder =
        dynamic_cast<const RelationalFolder&>( childNode );
      pFolder = &folder;
    }
    catch( ... )
    {
      throw RelationalException
        ( "PANIC! Could not dynamic cast to const RelationalFolder&",
          "RelationalTagMgr" );
    }
    if ( !pFolder )
      throw RelationalException
        ( "PANIC! Null pointer from dynamic cast to const RelationalFolder&",
          "RelationalTagMgr" );
    // SV folder  - nothing else to check or to delete
    if ( pFolder->versioningMode() != cool_FolderVersioning_Mode::MULTI_VERSION )
    {
      if ( ! existsTagInTag2TagTable( childNodeId, childTagId ) )
      {
        if ( childTag.lockStatus() != cool_HvsTagLock_Status::UNLOCKED )
          throw TagIsLocked
            ( "Cannot delete tag relation to parent tag '" + parentTagName +
              "': this would lead to the deletion of locked child tag '"
              + childTag.name() + "'", "RelationalTagMgr" );
        deleteGlobalTagTableRow( childNodeId, childTagId );
      }
    }
    // MV folder - check IOV and IOV2TAG table, delete also from TAG table
    if ( !existsTagInTag2TagTable( childNodeId, childTagId ) &&
         !RelationalFolder::existsUserTagInObjectTable
         ( db().queryMgr(), childTagId, pFolder->objectTableName() ) &&
         !RelationalFolder::existsTagInObject2TagTable
         ( db().queryMgr(), childTagId, pFolder->object2TagTableName() ) )
    {
      if ( childTag.lockStatus() != cool_HvsTagLock_Status::UNLOCKED )
        throw TagIsLocked
          ( "Cannot delete tag relation to parent tag '" + parentTagName +
            "': this would lead to the deletion of locked child tag '"
            + childTag.name() + "'", "RelationalTagMgr" );
      deleteGlobalTagTableRow( childNodeId, childTagId );
      deleteTagTableRow( pFolder->tagTableName(), childTagId );
    }
    // TODO
  }

}

//-----------------------------------------------------------------------------

UInt32
RelationalTagMgr::findTagRelation( UInt32 parentNodeId,
                                   const std::string& parentTagName,
                                   UInt32 childNodeId ) const
{
  log() << "Find the child tag in node #" << childNodeId
        << " related to parent tag '" << parentTagName
        << " in node '" << parentNodeId << coral::MessageStream::endmsg;

  // Throw ReservedHeadTag if the parent tag is a HEAD tag
  if ( IHvsNode::isHeadTag( parentTagName ) )
    throw ReservedHeadTag( parentTagName, "RelationalTagMgr" );

  // Throw TagNotFound if the parent tag does not exist in the parent node
  UInt32 parentTagId =
    findTagRecord( parentNodeId, parentTagName ).id();

  // Throw TagRelationNotFound if the parent tag has no related child tag
  RelationalTableRow relation =
    fetchTag2TagTableRow( parentNodeId, parentTagId, childNodeId );

  // Find the child node tag associated to the given parent node tag.
  return
    relation[RelationalTag2TagTable::columnNames::childTagId].data<UInt32>();
}

//-----------------------------------------------------------------------------

UInt32
RelationalTagMgr::resolveTag( const std::string& ancestorTagName,
                              UInt32 descendantNodeId ) const
{
  log() << "Find the descendant tag# in node #" << descendantNodeId
        << " related to ancestor tag '" << ancestorTagName << "'"
        << coral::MessageStream::endmsg;

  // Throw ReservedHeadTag if the ancestor tag is a HEAD tag
  if ( IHvsNode::isHeadTag( ancestorTagName ) )
    throw ReservedHeadTag( ancestorTagName, "RelationalTagMgr" );

  // Determine the node where the tag is defined.
  // Throw TagNotFound if the tag does not exist in any node.
  RelationalTableRow ancestorTag =
    fetchGlobalTagTableRowForNode( ancestorTagName );
  UInt32 ancestorNodeId =
    ancestorTag[RelationalGlobalTagTable::columnNames::nodeId].data<UInt32>();
  UInt32 ancestorTagId =
    ancestorTag[RelationalGlobalTagTable::columnNames::tagId].data<UInt32>();

  // Special case: the node where the tag is defined is the 'descendant'
  // node itself
  if ( ancestorNodeId == descendantNodeId )
    return ancestorTagId;

  // Throw NodeRelationNotFound if the node where the ancestor tag
  // is defined is not an ancestor of the descendant node
  const std::vector<UInt32> dNodes =
    nodeMgr().resolveNodeHierarchy( ancestorNodeId, descendantNodeId );
  UInt32 parentNodeId = ancestorNodeId;
  UInt32 parentTagId = ancestorTagId;
  for ( std::vector<UInt32>::const_iterator
          dNode = dNodes.begin(); dNode != dNodes.end(); ++dNode )
  {
    UInt32 childNodeId = *dNode;
    // Throw TagRelationNotFound if the parent tag has no related child tag
    RelationalTableRow relation =
      fetchTag2TagTableRow( parentNodeId, parentTagId, childNodeId );
    UInt32 childTagId =
      relation[RelationalTag2TagTable::columnNames::childTagId].data<UInt32>();
    if ( childNodeId == descendantNodeId )
    {
      return childTagId;
    }
    else
    {
      parentNodeId = childNodeId;
      parentTagId = childTagId;
    }
  }
  throw RelationalException
    ( "PANIC! Descendant node not included in resolved hierarchy???",
      "RelationalTagMgr" );
}

//-----------------------------------------------------------------------------

void RelationalTagMgr::setTagDescription( const IHvsNode* node,
                                          const std::string& tagName,
                                          const std::string& description )
{
  //if ( IHvsNode::isHeadTag( tagName ) )

  if (description.size() > 255)
  {
    throw Exception("Description string exceeds 255 character limit.",
                    "RelationalFolder");
  }

  // We're using the tag lookup in 'findTagRecord' to trigger the
  // the following exceptions:
  // - trying to set a description for a non-existing tag
  // - trying to set a description for tag name not defined for this node
  // - trying to set a description for the HEAD tag
  findTagRecord(node->id(), tagName);

  // prepare update data
  RecordSpecification updateDataSpec;
  updateDataSpec.extend( "description",
                         RelationalTagTable::columnTypeIds::tagDescription );
  updateDataSpec.extend( "tagName",
                         RelationalTagTable::columnTypeIds::tagName );
  Record updateData( updateDataSpec );
  updateData["description"].setValue( description );
  updateData["tagName"].setValue( tagName );
  std::string setClause =
    RelationalTagTable::columnNames::tagDescription + " = :description";
  std::string whereClause =
    RelationalTagTable::columnNames::tagName + " = :tagName";

  db().checkDbOpenTransaction( "RelationalTagMgr::setTagDescription",
                               cool::ReadWrite );

  // update global tag table
  // NB: we are ignoring / have to ignore the local tag table, because only
  // leaves (folders, as opposed to foldersets) have one and we can't / don't
  // want to differentiate between the two here. The duplication of the tag
  // description in the local tag table should be removed.
  db().queryMgr().updateTableRows( db().globalTagTableName(),
                                   setClause,
                                   whereClause,
                                   updateData );

}

//-----------------------------------------------------------------------------
