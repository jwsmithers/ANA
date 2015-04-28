// Include files
#include "CoolKernel/Record.h"
#include "CoralBase/Attribute.h"
#include "CoralBase/AttributeList.h"
#include "CoralBase/AttributeSpecification.h"
#include "RelationalAccess/ISchema.h"
#include "RelationalAccess/ITable.h"
#include "RelationalAccess/ITableDataEditor.h"
#include "RelationalAccess/ITypeConverter.h"

// Local include files
#include "HvsPathHandler.h"
#include "RalSchemaMgr.h"
#include "RalSessionMgr.h"
#include "RelationalChannelTable.h"
#include "RelationalDatabase.h"
#include "RelationalDatabaseTable.h"
#include "RelationalException.h"
#include "RelationalFolderSet.h"
#include "RelationalGlobalTagTable.h"
#include "RelationalNodeTable.h"
#include "RelationalObjectTable.h"
#include "RelationalObject2TagTable.h"
#include "RelationalPayloadTable.h"
//#include "RelationalQueryDefinition.h" // debug bug #54767
#include "RelationalQueryMgr.h"
#include "RelationalSequence.h"
#include "RelationalSharedSequenceTable.h"
#include "RelationalSequenceMgr.h"
//#include "RelationalTableRow.h" // debug bug #54767
#include "RelationalTagSequence.h"
#include "RelationalTagTable.h"
#include "RelationalTag2TagTable.h"
#include "VersionInfo.h"
#include "attributeListToString.h"
#include "scoped_enums.h"

// *** START *** 3.0.0 schema extensions (task #4307, task #4396)
#include "RelationalChannelTablesTable.h"
#include "RelationalGlobalHeadTagTable.h"
#include "RelationalGlobalUserTagTable.h"
#include "RelationalIovTablesTable.h"
// **** END **** 3.0.0 schema extensions (task #4307, task #4396)

// Namespace
using namespace cool;

// Local type definitions
typedef boost::shared_ptr<RelationalSequence> RelationalSequencePtr;

//---------------------------------------------------------------------------

void RalSchemaMgr::initialize()
{
  log() << coral::Debug << "Instantiate a RalSchemaMgr"
        << coral::MessageStream::endmsg;
}

//---------------------------------------------------------------------------

RalSchemaMgr::~RalSchemaMgr()
{
  log() << coral::Debug << "Delete the RalSchemaMgr"
        << coral::MessageStream::endmsg;
}

//---------------------------------------------------------------------------

coral::ISessionProxy& RalSchemaMgr::session() const
{
  return m_sessionMgr->session();
}

//---------------------------------------------------------------------------

bool RalSchemaMgr::dropTable( const std::string& tableName ) const
{
  if ( ! queryMgr().existsTable( tableName ) ) {
    return false;
  } else {
    session().nominalSchema().dropTable( tableName );
    return true;
  }
}

//---------------------------------------------------------------------------

std::auto_ptr<coral::TableDescription>
RalSchemaMgr::createTableDescription( const std::string& tableName,
                                      const IRecordSpecification& spec,
                                      const std::string& primaryKey ) const
{
  log() << "Create the description of table " << tableName
        << coral::MessageStream::endmsg;

  std::auto_ptr<coral::TableDescription>
    tableDesc( new coral::TableDescription( "cool::RalSchemaMgr" ) );

  tableDesc->setName( tableName );

  for ( unsigned int i=0; i<spec.size(); i++ ) {
    const IFieldSpecification& field = spec[i];
    if ( ! isValidColumnName( field.name() ) )
      throw InvalidColumnName
        ( field.name(), "RalSchemaMgr::createTableDescription");
    bool fixedSize = false;
    int maxSize = field.storageType().maxSize(); // No bug #22543 anymore
    tableDesc->insertColumn
      ( field.name(),
        coral::AttributeSpecification::typeNameForId
        ( field.storageType().cppType() ), maxSize, fixedSize );
  }

  if ( !primaryKey.empty() ) tableDesc->setPrimaryKey( primaryKey );

  return tableDesc;
}

//-----------------------------------------------------------------------------

void RalSchemaMgr::createMainTable( const std::string& mainTableName ) const
{
  log() << "Create table " << mainTableName << coral::MessageStream::endmsg;

  // Create the description of the main table.
  // Create the PK (attributeName).
  std::auto_ptr<coral::TableDescription> mainTableDesc =
    createTableDescription
    ( mainTableName,
      RelationalDatabaseTable::tableSpecification(),
      RelationalDatabaseTable::columnNames::attributeName );

  // Create the main table
  session().nominalSchema().createTable( *mainTableDesc );
  log() << "Created table " << mainTableName << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

void RalSchemaMgr::fillMainTable( const std::string& mainTableName,
                                  const coral::AttributeList& dbAttr ) const
{
  log() << "Fill table " << mainTableName
        << " with the following database attributes: "
        << attributeListToString( dbAttr ) << coral::MessageStream::endmsg;

  // Store the database attributes in the top-level management table
  const IRecordSpecification& spec =
    RelationalDatabaseTable::tableSpecification();
  Record data( spec );
  for ( coral::AttributeList::const_iterator
          dbAttrIt = dbAttr.begin(); dbAttrIt != dbAttr.end(); ++dbAttrIt )
  {
    RelationalDatabaseTable::columnTypes::attributeName attrName =
      dbAttrIt->specification().name();
    // Set the attribute name
    data[RelationalDatabaseTable::columnNames::attributeName].setValue
      ( attrName );
    // Set the attribute value
    data[RelationalDatabaseTable::columnNames::attributeValue].setValue
      ( dbAttrIt->data<RelationalDatabaseTable::columnTypes::attributeValue>() );

    // TEMPORARY? Check that all column values are within their allowed range.
    spec.validate(data.attributeList());

    // Insert a new row
    log() << "Insert row: " << data << coral::MessageStream::endmsg;
    queryMgr().insertTableRow( mainTableName, data );
  }
  log() << "Filled table " << mainTableName << coral::MessageStream::endmsg;

}

//-----------------------------------------------------------------------------

// *** START *** 3.0.0 schema extensions (task #4307)
void RalSchemaMgr::createIovTablesTable
//( const std::string& iovTablesTableName ) const
( const std::string& ) const
{
  // TODO
}

//-----------------------------------------------------------------------------

void RalSchemaMgr::createChannelTablesTable
//( const std::string& channelTablesTableName ) const
( const std::string& ) const
{
  // TODO
}
// **** END **** 3.0.0 schema extensions (task #4307)

//-----------------------------------------------------------------------------

void RalSchemaMgr::createNodeTable
( const std::string& nodeTableName,
  const std::string& defaultTablePrefix ) const
{
  // Create the description of the node table.
  // Create the PK (nodeId).
  std::auto_ptr<coral::TableDescription> nodeTableDesc =
    createTableDescription( nodeTableName,
                            RelationalNodeTable::tableSpecification(),
                            RelationalNodeTable::columnNames::nodeId );

  // Create the FK reference to itself (parentNodeId -> nodeId).
  nodeTableDesc->createForeignKey
    ( nodeTableName + "_PARENT_FK",
      RelationalNodeTable::columnNames::nodeParentId,
      nodeTableName,
      RelationalNodeTable::columnNames::nodeId );

  // Create a UK constraint on (nodeFullPath)
  // [NB On Oracle this unique constraint will also create a unique index]
  nodeTableDesc->setUniqueConstraint
    ( RelationalNodeTable::columnNames::nodeFullPath,
      nodeTableName+"_FULLPATH_UK" );

  // Create a UK constraint on (nodeId, parentNodeId)
  // [NB On Oracle this unique constraint will also create a unique index]
  // This is needed so that the TAG2TAG table can reference the NODES table
  {
    std::vector<std::string> ukColumns;
    ukColumns.push_back( RelationalNodeTable::columnNames::nodeId );
    ukColumns.push_back( RelationalNodeTable::columnNames::nodeParentId );
    nodeTableDesc->setUniqueConstraint
      ( ukColumns, nodeTableName+"_PARENT_UK" );
  }

  // Create the node table
  log() << "Create table " << nodeTableName << coral::MessageStream::endmsg;
  session().nominalSchema().createTable( *nodeTableDesc );

  // Create a sequence for the node table PK (will fail if it already exists)
  std::string nodeSeqName =
    RelationalNodeTable::sequenceName( nodeTableName );
  log() << "Create sequence " << nodeSeqName << coral::MessageStream::endmsg;
  RelationalSequencePtr nodeSeq
    ( queryMgr().sequenceMgr().createSequence( nodeSeqName ) );

  // Get the node ID for the root folder set from the sequence
  unsigned int nodeId = nodeSeq->nextVal();
  if ( nodeId != 0 )
    throw RelationalException
      ( "PANIC! First ID from the sequence not equal to 0?", "RalSchemaMgr" );
  std::string nodeInsTime = nodeSeq->currDate(); // nextVal -> recent!

  // Get the name of the root folder set from the HvsPathHandler
  HvsPathHandler handler;
  std::string nodeUnresolvedName = handler.rootUnresolvedName();
  std::string nodeFullPath = handler.rootFullPath();

  // Prepare the root folder set row in the node table
  const IRecordSpecification& rSpec =
    RelationalNodeTable::tableSpecification();
  Record rData( rSpec );
  rData[RelationalNodeTable::columnNames::nodeId].setValue
    ( nodeId );
  rData[RelationalNodeTable::columnNames::nodeParentId].setNull
    ();
  rData[RelationalNodeTable::columnNames::nodeName].setValue
    ( nodeUnresolvedName );
  rData[RelationalNodeTable::columnNames::nodeFullPath].setValue
    ( nodeFullPath );
  rData[RelationalNodeTable::columnNames::nodeDescription].setValue
    ( std::string( "" ) );
  rData[RelationalNodeTable::columnNames::nodeIsLeaf].setValue
    ( false );
  rData[RelationalNodeTable::columnNames::nodeSchemaVersion].setValue
    ( std::string( RelationalFolderSet::folderSetSchemaVersion() ) );
  rData[RelationalNodeTable::columnNames::nodeInsertionTime].setValue
    ( nodeInsTime );
  rData[RelationalNodeTable::columnNames::lastModDate].setValue
    ( nodeInsTime );
  rData[RelationalNodeTable::columnNames::folderVersioningMode].setValue
    ( (int)cool_FolderVersioning_Mode::NONE );
  rData[RelationalNodeTable::columnNames::folderPayloadSpecDesc].setValue
    ( std::string( "" ) );
  rData[RelationalNodeTable::columnNames::folderPayloadInline].setValue
    ( RelationalFolderSet::folderSetSchemaPayloadMode() ); // default (0)
  rData[RelationalNodeTable::columnNames::folderPayloadExtRef].setValue
    ( std::string( "" ) );
  rData[RelationalNodeTable::columnNames::folderChannelSpecDesc].setValue
    ( std::string( "" ) );
  rData[RelationalNodeTable::columnNames::folderChannelExtRef].setValue
    ( std::string( "" ) );
  rData[RelationalNodeTable::columnNames::folderObjectTableName].setValue
    ( std::string( "" ) );
  rData[RelationalNodeTable::columnNames::folderTagTableName].setValue
    ( std::string( "" ) );
  rData[RelationalNodeTable::columnNames::folderObject2TagTableName].setValue
    ( std::string( "" ) );
  rData[RelationalNodeTable::columnNames::folderChannelTableName].setValue
    ( std::string( "" ) );

  // TEMPORARY? Check that all column values are within their allowed range.
  rSpec.validate( rData.attributeList() );

  // Insert the root folder set into the node table
  queryMgr().insertTableRow( nodeTableName, rData );

  // Create the tag sequence for the root folder set
  std::string tagSequenceName = RelationalTagSequence::sequenceName
    ( defaultTablePrefix, nodeId );
  createTagSequence( tagSequenceName );
}

//-----------------------------------------------------------------------------

void
RalSchemaMgr::createGlobalTagTable( const std::string& globalTagTableName,
                                    const std::string& nodeTableName ) const
{
  // Create the description of the tag table
  std::auto_ptr<coral::TableDescription> tableDesc =
    createTableDescription
    ( globalTagTableName, RelationalGlobalTagTable::tableSpecification() );

  // Create the PK (nodeId, tagId)
  {
    std::vector<std::string> pkColumns;
    pkColumns.push_back( RelationalGlobalTagTable::columnNames::nodeId );
    pkColumns.push_back( RelationalGlobalTagTable::columnNames::tagId );
    tableDesc->setPrimaryKey( pkColumns );
  }

  /*
  // *** START *** 3.0.0 schema extensions (task #4396)
  // Create a UK constraint on (nodeId, tagId, tagType)
  // [NB On Oracle this unique constraint will also create a unique index]
  {
    std::vector<std::string> ukColumns;
    ukColumns.push_back( RelationalGlobalTagTable::columnNames::nodeId );
    ukColumns.push_back( RelationalGlobalTagTable::columnNames::tagId );
    ukColumns.push_back( RelationalGlobalTagTable::columnNames::tagType );
    tableDesc->setUniqueConstraint
      ( ukColumns, globalTagTableName+"_TAGTYPE_UK" );
  }
  // Create a NOT NULL constraint on (tagType)
  tableDesc->setNotNullConstraint
    ( RelationalGlobalTagTable::columnNames::tagType );
  // Create a CHECK constraint on (tagType) = {0,1,2}
  // ... waiting for CORAL (sr#101506) ...
  // **** END **** 3.0.0 schema extensions (task #4396)
  *///

  // Create a UK constraint on (tagName)
  // [NB On Oracle this unique constraint will also create a unique index]
  tableDesc->setUniqueConstraint
    ( RelationalTagTable::columnNames::tagName,
      globalTagTableName+"_TAGNAME_UK" );

  // Create FK reference to the NODES table (nodeId -> nodeId)
  tableDesc->createForeignKey
    ( globalTagTableName + "_NODEID_FK",
      RelationalGlobalTagTable::columnNames::nodeId,
      nodeTableName,
      RelationalNodeTable::columnNames::nodeId );

  // Create the table
  log() << "Create table " << globalTagTableName
        << coral::MessageStream::endmsg;
  session().nominalSchema().createTable( *tableDesc );
}

//-----------------------------------------------------------------------------

void
RalSchemaMgr::createGlobalHeadTagTable
( const std::string& globalHeadTagTableName,
  const std::string& globalTagTableName ) const
{
  // Create the description of the head tag table
  std::auto_ptr<coral::TableDescription> tableDesc =
    createTableDescription
    ( globalHeadTagTableName,
      RelationalGlobalHeadTagTable::tableSpecification() );

  // Create the PK (nodeId, tagId)
  {
    std::vector<std::string> pkColumns;
    pkColumns.push_back( RelationalGlobalHeadTagTable::columnNames::nodeId );
    pkColumns.push_back( RelationalGlobalHeadTagTable::columnNames::tagId );
    tableDesc->setPrimaryKey( pkColumns );
  }

  // Create FK reference to the TAGS table (nodeId, tagId, tagType)
  {
    std::vector<std::string> fkColumnsSrc;
    fkColumnsSrc.push_back
      ( RelationalGlobalHeadTagTable::columnNames::nodeId );
    fkColumnsSrc.push_back
      ( RelationalGlobalHeadTagTable::columnNames::tagId );
    fkColumnsSrc.push_back
      ( RelationalGlobalHeadTagTable::columnNames::tagType );
    std::vector<std::string> fkColumnsTgt;
    fkColumnsTgt.push_back
      ( RelationalGlobalTagTable::columnNames::nodeId );
    fkColumnsTgt.push_back
      ( RelationalGlobalTagTable::columnNames::tagId );
    fkColumnsTgt.push_back
      ( RelationalGlobalTagTable::columnNames::tagType );
    tableDesc->createForeignKey
      ( globalHeadTagTableName + "_TAGS_FK", fkColumnsSrc,
        globalTagTableName, fkColumnsTgt );
  }

  // Create a CHECK constraint on (tagType) = {1}
  // ... waiting for CORAL (sr#101506) ...

  // Create the table
  log() << "Create table " << globalHeadTagTableName
        << coral::MessageStream::endmsg;
  session().nominalSchema().createTable( *tableDesc );
}

//-----------------------------------------------------------------------------

void
RalSchemaMgr::createGlobalUserTagTable
( const std::string& globalUserTagTableName,
  const std::string& globalTagTableName ) const
{
  // Create the description of the user tag table
  std::auto_ptr<coral::TableDescription> tableDesc =
    createTableDescription
    ( globalUserTagTableName,
      RelationalGlobalUserTagTable::tableSpecification() );

  // Create the PK (nodeId, tagId)
  {
    std::vector<std::string> pkColumns;
    pkColumns.push_back( RelationalGlobalUserTagTable::columnNames::nodeId );
    pkColumns.push_back( RelationalGlobalUserTagTable::columnNames::tagId );
    tableDesc->setPrimaryKey( pkColumns );
  }

  // Create FK reference to the TAGS table (nodeId, tagId, tagType)
  {
    std::vector<std::string> fkColumnsSrc;
    fkColumnsSrc.push_back
      ( RelationalGlobalUserTagTable::columnNames::nodeId );
    fkColumnsSrc.push_back
      ( RelationalGlobalUserTagTable::columnNames::tagId );
    fkColumnsSrc.push_back
      ( RelationalGlobalUserTagTable::columnNames::tagType );
    std::vector<std::string> fkColumnsTgt;
    fkColumnsTgt.push_back
      ( RelationalGlobalTagTable::columnNames::nodeId );
    fkColumnsTgt.push_back
      ( RelationalGlobalTagTable::columnNames::tagId );
    fkColumnsTgt.push_back
      ( RelationalGlobalTagTable::columnNames::tagType );
    tableDesc->createForeignKey
      ( globalUserTagTableName + "_TAGS_FK", fkColumnsSrc,
        globalTagTableName, fkColumnsTgt );
  }

  // Create a CHECK constraint on (tagType) = {2}
  // ... waiting for CORAL (sr#101506) ...

  // Create the table
  log() << "Create table " << globalUserTagTableName
        << coral::MessageStream::endmsg;
  session().nominalSchema().createTable( *tableDesc );
}

//-----------------------------------------------------------------------------

void
RalSchemaMgr::createTag2TagTable( const std::string& tag2TagTableName,
                                  const std::string& globalTagTableName,
                                  const std::string& nodeTableName ) const
{
  // Create the description of the tag2tag table
  std::auto_ptr<coral::TableDescription> tableDesc =
    createTableDescription
    ( tag2TagTableName, RelationalTag2TagTable::tableSpecification() );

  // Set the primary key
  std::vector<std::string> pkColumns;
  pkColumns.push_back( RelationalTag2TagTable::columnNames::parentNodeId );
  pkColumns.push_back( RelationalTag2TagTable::columnNames::parentTagId );
  pkColumns.push_back( RelationalTag2TagTable::columnNames::childNodeId );
  tableDesc->setPrimaryKey( pkColumns );

  // Create FK reference to the NODES table for parent and child nodes
  {
    std::vector<std::string> fkColumnsSrc;
    fkColumnsSrc.push_back
      ( RelationalTag2TagTable::columnNames::childNodeId );
    fkColumnsSrc.push_back
      ( RelationalTag2TagTable::columnNames::parentNodeId );
    std::vector<std::string> fkColumnsTgt;
    fkColumnsTgt.push_back
      ( RelationalNodeTable::columnNames::nodeId );
    fkColumnsTgt.push_back
      ( RelationalNodeTable::columnNames::nodeParentId );
    tableDesc->createForeignKey
      ( tag2TagTableName + "_NODES_FK", fkColumnsSrc,
        nodeTableName, fkColumnsTgt );
  }

  // Create the table
  log() << "Create table " << tag2TagTableName << coral::MessageStream::endmsg;
  session().nominalSchema().createTable( *tableDesc );

  // Create FK reference to the TAGS table for the parent tag (nodeId, tagId)
  // Create FK reference to the TAGS table for the child tag (nodeId, tagId)
  createTag2TagFKs( tag2TagTableName, globalTagTableName );

  // Create a sequence for the tag2tag table insertion time (not for the PK)
  std::string tag2TagSeqName =
    RelationalTag2TagTable::sequenceName( tag2TagTableName );
  log() << "Create sequence " << tag2TagSeqName
        << coral::MessageStream::endmsg;
  queryMgr().sequenceMgr().createSequence( tag2TagSeqName );
}

//-----------------------------------------------------------------------------

void
RalSchemaMgr::createTag2TagFKs( const std::string& tag2TagTableName,
                                const std::string& globalTagTableName ) const
{
  coral::ITable& tag2TagTable =
    session().nominalSchema().tableHandle( tag2TagTableName );
  coral::ITableSchemaEditor& editor = tag2TagTable.schemaEditor();
  // Create FK reference to the TAGS table for the parent tag (nodeId, tagId)
  try
  {
    std::vector<std::string> fkColumnsSrc;
    fkColumnsSrc.push_back
      ( RelationalTag2TagTable::columnNames::parentNodeId );
    fkColumnsSrc.push_back
      ( RelationalTag2TagTable::columnNames::parentTagId );
    std::vector<std::string> fkColumnsTgt;
    fkColumnsTgt.push_back
      ( RelationalGlobalTagTable::columnNames::nodeId );
    fkColumnsTgt.push_back
      ( RelationalGlobalTagTable::columnNames::tagId );
    log() << "Create FK constraint " << tag2TagTableName + "_PTAG_FK"
          << " on table " << tag2TagTableName << coral::MessageStream::endmsg;
    editor.createForeignKey
      ( tag2TagTableName + "_PTAG_FK", fkColumnsSrc,
        globalTagTableName, fkColumnsTgt );
  }
  catch ( std::exception& e )
  {
    log() << coral::Error
          << "Exception caught: '" << e.what()
          << "'" << coral::MessageStream::endmsg;
    log() << coral::Error
          << "Failed to create FK constraint "
          << tag2TagTableName + "_PTAG_FK"
          << " on table " << tag2TagTableName << coral::MessageStream::endmsg;
    throw; // Re-throw (see bug #40295)
  }
  // Create FK reference to the TAGS table for the child tag (nodeId, tagId)
  try
  {
    std::vector<std::string> fkColumnsSrc;
    fkColumnsSrc.push_back
      ( RelationalTag2TagTable::columnNames::childNodeId );
    fkColumnsSrc.push_back
      ( RelationalTag2TagTable::columnNames::childTagId );
    std::vector<std::string> fkColumnsTgt;
    fkColumnsTgt.push_back
      ( RelationalGlobalTagTable::columnNames::nodeId );
    fkColumnsTgt.push_back
      ( RelationalGlobalTagTable::columnNames::tagId );
    log() << "Create FK constraint " << tag2TagTableName + "_CTAG_FK"
          << " on table " << tag2TagTableName << coral::MessageStream::endmsg;
    editor.createForeignKey
      ( tag2TagTableName + "_CTAG_FK", fkColumnsSrc,
        globalTagTableName, fkColumnsTgt );
  }
  catch ( std::exception& e )
  {
    log() << coral::Error
          << "Exception caught: '" << e.what() << "'"
          << coral::MessageStream::endmsg;
    log() << coral::Error
          << "Failed to create FK constraint "
          << tag2TagTableName + "_CTAG_FK"
          << " on table " << tag2TagTableName << coral::MessageStream::endmsg;
    throw; // Re-throw (see bug #40295)
  }
}

//-----------------------------------------------------------------------------

bool
RalSchemaMgr::dropTag2TagFKs( const std::string& tag2TagTableName,
                              bool verbose ) const
{
  bool status = true;
  coral::ITable& tag2TagTable =
    session().nominalSchema().tableHandle( tag2TagTableName );
  coral::ITableSchemaEditor& editor = tag2TagTable.schemaEditor();
  // Drop FK reference to the TAGS table for the parent tag (nodeId, tagId)
  try
  {
    log() << "Drop FK constraint " << tag2TagTableName + "_PTAG_FK"
          << " on table " << tag2TagTableName << coral::MessageStream::endmsg;
    editor.dropForeignKey( tag2TagTableName + "_PTAG_FK" );
  }
  catch ( std::exception& e )
  {
    if ( verbose )
    {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error << "Failed to drop FK constraint "
            << tag2TagTableName + "_PTAG_FK"
            << " on table " << tag2TagTableName
            << coral::MessageStream::endmsg;
    }
    status = false;
  }
  // Drop FK reference to the TAGS table for the child tag (nodeId, tagId)
  try
  {
    log() << "Drop FK constraint " << tag2TagTableName + "_CTAG_FK"
          << " on table " << tag2TagTableName << coral::MessageStream::endmsg;
    editor.dropForeignKey( tag2TagTableName + "_CTAG_FK" );
  }
  catch ( std::exception& e )
  {
    if ( verbose )
    {
      log() << coral::Error
            << "Exception caught: '" << e.what() << "'"
            << coral::MessageStream::endmsg;
      log() << coral::Error << "Failed to drop FK constraint "
            << tag2TagTableName + "_CTAG_FK"
            << " on table " << tag2TagTableName
            << coral::MessageStream::endmsg;
    }
    status = false;
  }
  return status;
}

//-----------------------------------------------------------------------------

void
RalSchemaMgr::createSharedSequence( const std::string& sharedSequenceName,
                                    const std::string& nodeTableName ) const
{

  // Create the description of the shared sequence table
  std::auto_ptr<coral::TableDescription> tableDesc =
    createTableDescription
    ( sharedSequenceName,
      RelationalSharedSequenceTable::tableSpecification(),
      RelationalSharedSequenceTable::columnNames::nodeId );

  // Create FK reference to the NODES table (nodeId -> nodeId)
  tableDesc->createForeignKey
    ( sharedSequenceName + "_NODEID_FK",
      RelationalSharedSequenceTable::columnNames::nodeId,
      nodeTableName,
      RelationalNodeTable::columnNames::nodeId );

  // Create the table
  log() << "Create table " << sharedSequenceName
        << coral::MessageStream::endmsg;
  session().nominalSchema().createTable( *tableDesc );

}

//-----------------------------------------------------------------------------

void
RalSchemaMgr::createPayloadTable( const std::string& payloadTableName,
                                  const std::string& objectTableName,
                                  const IRecordSpecification& payloadSpec,
                                  PayloadMode::Mode pMode ) const
{
  // Create the description of the object table
  std::auto_ptr<coral::TableDescription> payloadTableDesc =
    createTableDescription
    ( payloadTableName,
      RelationalPayloadTable::tableSpecification( payloadSpec, pMode ) );

  // add primary key
  if ( pMode == cool_PayloadMode_Mode::SEPARATEPAYLOAD )
  {
    payloadTableDesc->setPrimaryKey( RelationalPayloadTable::columnNames::payloadId() );
  }
  else
  {
    // Create the PK (payloadSetId, payloadItemId)
    std::vector<std::string> pkColumns;
    pkColumns.push_back( RelationalPayloadTable::columnNames::payloadSetId() );
    pkColumns.push_back( RelationalPayloadTable::columnNames::payloadItemId() );
    payloadTableDesc->setPrimaryKey( pkColumns );
  }

  // Create the object table
  log() << "Create table " << payloadTableName << coral::MessageStream::endmsg;
  session().nominalSchema().createTable( *payloadTableDesc );

  if ( pMode == cool_PayloadMode_Mode::VECTORPAYLOAD )
  {
    createPayloadToObjectIdFK( payloadTableName, objectTableName );
  }
  else
  {
    // separate payload mode needs a id sequence

    // Create a sequence for the payload table primary key
    std::string payloadSeqName =
      RelationalPayloadTable::sequenceName( payloadTableName );

    // Create the sequence (will fail if it already exists)
    log() << "Create sequence " << payloadSeqName
          << coral::MessageStream::endmsg;
    RelationalSequencePtr payloadSeq
      ( queryMgr().sequenceMgr().createSequence( payloadSeqName ) );

    // Initialize the sequence: first inserted payload will have ID=1 (not ID=0)
    // ID=0 is reserved for not yet inserted payloads
    payloadSeq->nextVal();
  }
}

//-----------------------------------------------------------------------------

void
RalSchemaMgr::createObjectTable
( const std::string& objectTableName,
  const std::string& channelTableName,
  const IRecordSpecification& payloadSpec,
  FolderVersioning::Mode versioningMode,
  const std::string& payloadTableName,
  PayloadMode::Mode payloadMode ) const
{
  // Create the description of the object table
  std::auto_ptr<coral::TableDescription> objectTableDesc =
    createTableDescription
    ( objectTableName,
      RelationalObjectTable::tableSpecification( payloadSpec, payloadMode ),
      RelationalObjectTable::columnNames::objectId() );

  // Index on channel ID
  // TEMPORARY? In Oracle: one partition per channel?!
  //std::vector< std::string > objectIndexCh;
  //objectIndexCh.push_back( RelationalObjectTable::columnNames::channelId );
  //objectTableDesc->createIndex
  //  ( objectTableName+"_C_1INDX", objectIndexCh, false );

  // Index on channel ID and object ID
  // TEMPORARY? In Oracle: primary key on chID+objID, partitioned by chID?
  std::vector< std::string > objectIndexChOb;
  objectIndexChOb.push_back( RelationalObjectTable::columnNames::channelId() );
  objectIndexChOb.push_back( RelationalObjectTable::columnNames::objectId() );
  objectTableDesc->createIndex( objectTableName+"_CO_2INDX",
                                objectIndexChOb,
                                false );

  // Index on channel ID and since
  // TEMPORARY? In Oracle: local index on since within channel partition?!
  //std::vector< std::string > objectIndexChSi;
  //objectIndexChSi.push_back( RelationalObjectTable::columnNames::channelId );
  //objectIndexChSi.push_back( RelationalObjectTable::columnNames::iovSince );
  //objectTableDesc->createIndex
  //  ( objectTableName+"_CS_2INDX", objectIndexChSi, false );

  // Index on channel ID and since and until
  // TEMPORARY? In Oracle: local index on since/until within channel partition?
  std::vector< std::string > objectIndexChSiUn;
  objectIndexChSiUn.push_back
    ( RelationalObjectTable::columnNames::channelId() );
  objectIndexChSiUn.push_back
    ( RelationalObjectTable::columnNames::iovSince() );
  objectIndexChSiUn.push_back
    ( RelationalObjectTable::columnNames::iovUntil() );
  objectTableDesc->createIndex( objectTableName+"_CSU_3INDX",
                                objectIndexChSiUn,
                                false );

  // Index on since and until (new in COOL_1_3_0)
  // Suggested by DavidF and LucaC for SV queries with no channel selection
  // TEMPORARY? In Oracle: local index on since/until within channel partition?
  std::vector< std::string > objectIndexSiUn;
  objectIndexSiUn.push_back
    ( RelationalObjectTable::columnNames::iovSince() );
  objectIndexSiUn.push_back
    ( RelationalObjectTable::columnNames::iovUntil() );
  objectTableDesc->createIndex( objectTableName+"_SU_2INDX",
                                objectIndexSiUn,
                                false );

  // Additional indices for MULTI_VERSION mode
  if ( versioningMode == cool_FolderVersioning_Mode::MULTI_VERSION )
  {
    // TODO: ALSO need to add a UK constraint - different from unique index
    // See http://asktom.oracle.com/pls/asktom/f?p=100:11:0::::P11_QUESTION_ID:36858373078604
    {
      std::vector<std::string> indColumns;
      indColumns.push_back( RelationalObjectTable::columnNames::objectId() );
      indColumns.push_back( RelationalObjectTable::columnNames::channelId() );
      indColumns.push_back( RelationalObjectTable::columnNames::iovSince() );
      indColumns.push_back( RelationalObjectTable::columnNames::iovUntil() );
      bool unique = true;
      // We are close to the maximum index name length of 31 characters here!
      std::string indexName = objectTableName + "_OCSU_4INDX";
      objectTableDesc->createIndex( indexName, indColumns, unique );
    }
    // 5-column index for findObject(userTag) - see task #4381
    {
      std::vector<std::string> indColumns;
      indColumns.push_back( RelationalObjectTable::columnNames::userTagId() );
      indColumns.push_back( RelationalObjectTable::columnNames::newHeadId() );
      indColumns.push_back( RelationalObjectTable::columnNames::channelId() );
      indColumns.push_back( RelationalObjectTable::columnNames::iovSince() );
      indColumns.push_back( RelationalObjectTable::columnNames::iovUntil() );
      bool unique = true;
      std::string indexName = objectTableName + "_UTAG_5INDX";
      objectTableDesc->createIndex( indexName, indColumns, unique );
    }
  }

  // Create the object table
  log() << "Create table " << objectTableName << coral::MessageStream::endmsg;
  session().nominalSchema().createTable( *objectTableDesc );

  // Create FK reference on channelId from object table to channel table
  createObjectChannelFK( objectTableName, channelTableName );

  // Create FK reference on payloadId from object table to payload table
  // (only if the payload is stored in a separate table)
  if ( payloadMode == cool_PayloadMode_Mode::SEPARATEPAYLOAD )
    createObjectPayloadFK( objectTableName, payloadTableName );

  // Vector folders have a self referencing foreign key from payload set id
  // to object id
  if ( payloadMode == cool_PayloadMode_Mode::VECTORPAYLOAD )
  {
    createObjectToOriginalIdFK( objectTableName );
    createObjectToObjectIdFK( objectTableName );
  }

  // Create a sequence for the IOV table primary key
  std::string objectSeqName =
    RelationalObjectTable::sequenceName( objectTableName );

  // Create the sequence (will fail if it already exists)
  log() << "Create sequence " << objectSeqName << coral::MessageStream::endmsg;
  RelationalSequencePtr objectSeq
    ( queryMgr().sequenceMgr().createSequence( objectSeqName ) );

  // Initialize the sequence: first inserted IOV will have ID=1 (not ID=0)
  objectSeq->nextVal();
}

//-----------------------------------------------------------------------------

void RalSchemaMgr::createObjectChannelFK
( const std::string& objectTableName,
  const std::string& channelTableName ) const
{
  coral::ITable& objectTable =
    session().nominalSchema().tableHandle( objectTableName );
  coral::ITableSchemaEditor& editor = objectTable.schemaEditor();
  // Create FK reference to the channel table (channelId)
  try
  {
    log() << "Create FK constraint " << objectTableName + "_CHANNEL_FK"
          << " on table " << objectTableName << coral::MessageStream::endmsg;
    editor.createForeignKey
      ( objectTableName + "_CHANNEL_FK",
        RelationalObjectTable::columnNames::channelId(),
        channelTableName,
        RelationalChannelTable::columnNames::channelId() );
  }
  catch ( std::exception& e )
  {
    log() << coral::Error
          << "Exception caught: '" << e.what() << "'"
          << coral::MessageStream::endmsg;
    log() << coral::Error
          << "Failed to create FK constraint "
          << objectTableName + "_CHANNEL_FK"
          << " on table " << objectTableName << coral::MessageStream::endmsg;
    throw; // Re-throw (see bug #54767)
  }
}

//-----------------------------------------------------------------------------

void RalSchemaMgr::dropObjectChannelFK
( const std::string& objectTableName ) const
{
  coral::ITable& objectTable =
    session().nominalSchema().tableHandle( objectTableName );
  // Debug printouts for bug #54767
  /*
  //if ( true )
  if ( objectTableName == "COOLTGT_F0007_IOVS" )
  {
    RelationalQueryDefinition def;
    RecordSpecification dummy; // empty payload specification
    bool payloadTable = false;
    RecordSpecification spec =
      RelationalObjectTable::tableSpecification( dummy, payloadTable );
    def.addSelectItems( spec );
    def.setResultSetSpecification( spec );
    def.addFromItem( objectTableName );
    std::vector<RelationalTableRow> rows = queryMgr().fetchOrderedRows( def );
    std::cout << "List rows in " << objectTableName << "..." << std::endl;
    std::cout << "Fetched " << rows.size() << " rows:" << std::endl;
    for ( std::vector<RelationalTableRow>::const_iterator
            row = rows.begin(); row != rows.end(); ++row )
    {
      const coral::AttributeList& data = row->data();
      std::cout << " -> " << attributeListToString( data ) << std::endl;
    }
    std::cout << "List rows in " << objectTableName << "... DONE" << std::endl;
  }
  *///
  // Drop FK reference to the channel table (channelId)
  coral::ITableSchemaEditor& editor = objectTable.schemaEditor();
  try
  {
    log() << "Drop FK constraint " << objectTableName + "_CHANNEL_FK"
          << " on table " << objectTableName << coral::MessageStream::endmsg;
    editor.dropForeignKey( objectTableName + "_CHANNEL_FK" );
  }
  catch ( std::exception& e )
  {
    log() << coral::Error
          << "Exception caught: '" << e.what() << "'"
          << coral::MessageStream::endmsg;
    log() << coral::Error
          << "Failed to drop FK constraint "
          << objectTableName + "_CHANNEL_FK"
          << " on table " << objectTableName << coral::MessageStream::endmsg;
    throw; // Re-throw (see bug #54767)
  }
}

//-----------------------------------------------------------------------------

void RalSchemaMgr::createObjectPayloadFK
( const std::string& objectTableName,
  const std::string& payloadTableName ) const
{
  coral::ITable& objectTable =
    session().nominalSchema().tableHandle( objectTableName );
  coral::ITableSchemaEditor& editor = objectTable.schemaEditor();
  // Create FK reference to the payload table (payloadId)
  try
  {
    log() << "Create FK constraint " << objectTableName + "_PAYLOAD_FK"
          << " on table " << objectTableName << coral::MessageStream::endmsg;
    editor.createForeignKey
      ( objectTableName + "_PAYLOAD_FK",
        RelationalObjectTable::columnNames::payloadId(),
        payloadTableName,
        RelationalPayloadTable::columnNames::payloadId() );
  }
  catch ( std::exception& e )
  {
    log() << coral::Error
          << "Exception caught: '" << e.what() << "'"
          << coral::MessageStream::endmsg;
    log() << coral::Error
          << "Failed to create FK constraint "
          << objectTableName + "_PAYLOAD_FK"
          << " on table " << objectTableName << coral::MessageStream::endmsg;
    throw; // Re-throw (see bug #54767)
  }
}

//-----------------------------------------------------------------------------

void RalSchemaMgr::createObjectToObjectIdFK
( const std::string& objectTableName ) const
{
  coral::ITable& objectTable =
    session().nominalSchema().tableHandle( objectTableName );
  coral::ITableSchemaEditor& editor = objectTable.schemaEditor();
  // Create FK self reference from payload set id to the object id
  try
  {
    std::vector<std::string> fkColumnsTo;
    fkColumnsTo.push_back( RelationalObjectTable::columnNames::channelId() );
    fkColumnsTo.push_back( RelationalObjectTable::columnNames::objectId() );
    log() << "Create UK constraint " << objectTableName + "_P_SETID_UK"
          << " on table " << objectTableName << coral::MessageStream::endmsg;
    editor.setUniqueConstraint( fkColumnsTo,
                                objectTableName + "_P_SETID_UK",
                                true );

    log() << "Create FK constraint " << objectTableName + "_P_SETID_FK"
          << " on table " << objectTableName << coral::MessageStream::endmsg;
    std::vector<std::string> fkColumnsFrom;
    fkColumnsFrom.push_back( RelationalObjectTable::columnNames::channelId() );
    fkColumnsFrom.push_back( RelationalObjectTable::columnNames::payloadSetId() );
    editor.createForeignKey
      ( objectTableName + "_P_SETID_FK",
        fkColumnsFrom,
        objectTableName,
        fkColumnsTo );
  }
  catch ( std::exception& e )
  {
    log() << coral::Error
          << "Exception caught: '" << e.what() << "'"
          << coral::MessageStream::endmsg;
    log() << coral::Error
          << "Failed to create FK constraint "
          << objectTableName + "_PYLD_SET_ID_FK"
          << " on table " << objectTableName << coral::MessageStream::endmsg;
    throw; // Re-throw (see bug #54767)
  }
}
//-----------------------------------------------------------------------------

void RalSchemaMgr::createObjectToOriginalIdFK
( const std::string& objectTableName ) const
{
  coral::ITable& objectTable =
    session().nominalSchema().tableHandle( objectTableName );
  coral::ITableSchemaEditor& editor = objectTable.schemaEditor();
  // Create FK self reference from payload set id to the object id
  try
  {
    std::vector<std::string> fkColumnsTo;
    fkColumnsTo.push_back( RelationalObjectTable::columnNames::objectId() );
#if 0
    fkColumnsTo.push_back( RelationalObjectTable::columnNames::payloadSetId() );
    log() << "Create UK constraint " << objectTableName + "_ORIGID_UK"
          << " on table " << objectTableName << coral::MessageStream::endmsg;
    editor.setUniqueConstraint( fkColumnsTo,
                                objectTableName + "_ORIGID_UK",
                                true );
#endif
    log() << "Create FK constraint " << objectTableName + "_ORIGID_FK"
          << " on table " << objectTableName << coral::MessageStream::endmsg;
    std::vector<std::string> fkColumnsFrom;
    fkColumnsFrom.push_back( RelationalObjectTable::columnNames::payloadSetId() );
    //fkColumnsFrom.push_back( RelationalObjectTable::columnNames::originalId() );
    editor.createForeignKey
      ( objectTableName + "_ORIGID_FK",
        fkColumnsFrom,
        objectTableName,
        fkColumnsTo );
  }
  catch ( std::exception& e )
  {
    log() << coral::Error
          << "Exception caught: '" << e.what() << "'"
          << coral::MessageStream::endmsg;
    log() << coral::Error
          << "Failed to create FK constraint "
          << objectTableName + "_PYLD_SET_ID_FK"
          << " on table " << objectTableName << coral::MessageStream::endmsg;
    throw; // Re-throw (see bug #54767)
  }
}

//-----------------------------------------------------------------------------

void RalSchemaMgr::createPayloadToObjectIdFK
( const std::string& payloadTableName,
  const std::string& objectTableName ) const
{
  coral::ITable& payloadTable =
    session().nominalSchema().tableHandle( payloadTableName );
  coral::ITableSchemaEditor& editor = payloadTable.schemaEditor();
  // Create FK reference from payload set id to the object id
  try
  {
    log() << "Create FK constraint " << payloadTableName << "_OID_FK"
          << " on table " << payloadTableName << coral::MessageStream::endmsg;
    editor.createForeignKey
      ( payloadTableName + "_OID_FK",
        RelationalPayloadTable::columnNames::payloadSetId(),
        objectTableName,
        RelationalObjectTable::columnNames::objectId() );
  }
  catch ( std::exception& e )
  {
    log() << coral::Error
          << "Exception caught: '" << e.what() << "'"
          << coral::MessageStream::endmsg;
    log() << coral::Error
          << "Failed to create FK constraint "
          << payloadTableName + "_OBJ_ID_FK"
          << " on table " << objectTableName << coral::MessageStream::endmsg;
    throw; // Re-throw (see bug #54767)
  }
}

//-----------------------------------------------------------------------------

void RalSchemaMgr::dropObjectPayloadFK
( const std::string& objectTableName ) const
{
  coral::ITable& objectTable =
    session().nominalSchema().tableHandle( objectTableName );
  coral::ITableSchemaEditor& editor = objectTable.schemaEditor();
  // Drop FK reference to the payload table (payloadId)
  try
  {
    log() << "Drop FK constraint " << objectTableName + "_PAYLOAD_FK"
          << " on table " << objectTableName << coral::MessageStream::endmsg;
    editor.dropForeignKey( objectTableName + "_PAYLOAD_FK" );
  }
  catch ( std::exception& e )
  {
    log() << coral::Error
          << "Exception caught: '" << e.what() << "'"
          << coral::MessageStream::endmsg;
    log() << coral::Error
          << "Failed to drop FK constraint "
          << objectTableName + "_PAYLOAD_FK"
          << " on table " << objectTableName << coral::MessageStream::endmsg;
    throw; // Re-throw (see bug #54767)
  }
}

//-----------------------------------------------------------------------------

void RalSchemaMgr::createTagTable( const std::string& tagTableName ) const
{
  // Create the description of the local tag table
  std::auto_ptr<coral::TableDescription> tableDesc =
    createTableDescription( tagTableName,
                            RelationalTagTable::tableSpecification(),
                            RelationalTagTable::columnNames::tagId );

  // Create the table
  log() << "Create table " << tagTableName << coral::MessageStream::endmsg;
  session().nominalSchema().createTable( *tableDesc );

  // Create a unique index on (tagName)
  // [NB this is a unique index, not a unique constraint]
  // [NB this will be obsoleted by the 2.1.0 folder schema]
  bool unique = true;
  tableDesc->createIndex( tagTableName+"_NAME_UK",
                          RelationalTagTable::columnNames::tagName,
                          unique );
}

//-----------------------------------------------------------------------------

void RalSchemaMgr::createChannelTable( const std::string& tableName ) const
{
  // Create the description of the local channel table
  std::auto_ptr<coral::TableDescription> tableDesc =
    createTableDescription( tableName,
                            RelationalChannelTable::tableSpecification(),
                            RelationalChannelTable::columnNames::channelId() );

  // Set the unique constraint on the channel name.
  // Note that Oracle treats "" and NULL as equivalent: multiple rows can
  // be inserted with "" as name, without violating the UK constraint
  // (they are all considered as NULL, and many NULLs do not violate a UK).
  // For MySQL and SQLite we probably need to make sure a real NULL is
  // inserted, instead of an empty string (this would also be nicer for
  // consistency across backends, and would help in payload queries too).
  // Probably need a hack in the relational query mgr to make sure field=""
  // are translated to NULL (note that IField strings are never null -
  // this was exactly motivated by the Oracle feature).
  bool unique = true;
  tableDesc->createIndex( tableName+"_N_UK",
                          RelationalChannelTable::columnNames::channelName(),
                          unique );

  // Create the table
  log() << "Create table " << tableName << coral::MessageStream::endmsg;
  session().nominalSchema().createTable( *tableDesc );

}

//-----------------------------------------------------------------------------

void RalSchemaMgr::createTagSequence( const std::string& seqName ) const
{
  // Create a sequence
  log() << "Create sequence " << seqName << coral::MessageStream::endmsg;
  RelationalSequencePtr sequence
    ( queryMgr().sequenceMgr().createSequence( seqName ) );

  // Initialize the sequence: first inserted row will have ID=1 (not ID=0)
  sequence->nextVal();
}

//-----------------------------------------------------------------------------

void RalSchemaMgr::createObject2TagTable
( const std::string& obj2tagTableName,
  const std::string& objectTableName,
  const std::string& tagTableName,
  const std::string& payloadTableName,
  PayloadMode::Mode pMode ) const
{
  // Create the description of the local tag table
  std::auto_ptr<coral::TableDescription> tableDesc =
    createTableDescription
    ( obj2tagTableName, RelationalObject2TagTable::tableSpecification( pMode ) );

  // Set the primary key
  std::vector<std::string> pkColumns;
  pkColumns.push_back( RelationalObject2TagTable::columnNames::tagId );
  pkColumns.push_back( RelationalObject2TagTable::columnNames::objectId );
  tableDesc->setPrimaryKey( pkColumns );

  // Create 4D index
  std::vector<std::string> i4Columns;
  i4Columns.push_back( RelationalObject2TagTable::columnNames::tagId );
  i4Columns.push_back( RelationalObject2TagTable::columnNames::channelId );
  i4Columns.push_back( RelationalObject2TagTable::columnNames::iovSince );
  i4Columns.push_back( RelationalObject2TagTable::columnNames::iovUntil );
  // We are close to the maximum index name length of 31 characters here!
  // (with a default table name of COOLTEST_F0001_IOV2TAG)
  std::string indexName = obj2tagTableName + "_4INDX";
  tableDesc->createIndex( indexName, i4Columns );

  // Create the foreign key constraints
  // TEMPORARY! Disabled: this FK needs a corresponding PK/UK constraint
  // (which we don't have yet, just a unique index, which does not suffice)
  // Foreign key #1
  /*
    std::vector<std::string> fk1Columns;
    fk1Columns.push_back( RelationalObject2TagTable::columnNames::objectId );
    fk1Columns.push_back( RelationalObject2TagTable::columnNames::channelId );
    fk1Columns.push_back( RelationalObject2TagTable::columnNames::iovSince );
    fk1Columns.push_back( RelationalObject2TagTable::columnNames::iovUntil );
    std::string fk1TargetTable = objectTableName;
    std::vector<std::string> fk1TargetColumns;
    fk1TargetColumns.push_back( RelationalObjectTable::columnNames::objectId );
    fk1TargetColumns.push_back( RelationalObjectTable::columnNames::channelId );
    fk1TargetColumns.push_back( RelationalObjectTable::columnNames::iovSince );
    fk1TargetColumns.push_back( RelationalObjectTable::columnNames::iovUntil );
    std::string fk1ConstraintName = tableName + "_OCSU_FK";
    if ( ! tableDesc->createForeignKey
    ( fk1ConstraintName, fk1Columns, fk1TargetTable, fk1TargetColumns ) )
    throw RelationalException( "Could not create FK", "RalSchemaMgr" );
  *///
  // Foreign key #2
  std::vector<std::string> fk2Columns;
  fk2Columns.push_back( RelationalObject2TagTable::columnNames::objectId );
  std::string fk2TargetTable = objectTableName;
  std::string fk2ConstraintName = obj2tagTableName + "_O_FK";
  tableDesc->createForeignKey( fk2ConstraintName,
                               fk2Columns,
                               fk2TargetTable,
                               fk2Columns );
  // Foreign key #3
  std::vector<std::string> fk3Columns;
  fk3Columns.push_back( RelationalObject2TagTable::columnNames::tagId );
  std::string fk3TargetTable = tagTableName;
  std::string fk3ConstraintName = obj2tagTableName + "_T_FK";
  tableDesc->createForeignKey( fk3ConstraintName,
                               fk3Columns,
                               fk3TargetTable,
                               fk3Columns );

  // Foreign key #4 (if there is a payload table only)
  if ( pMode == cool_PayloadMode_Mode::SEPARATEPAYLOAD )
  {
    std::vector<std::string> fk4Columns;
    fk4Columns.push_back( RelationalObject2TagTable::columnNames::payloadId );
    std::string fk4TargetTable = payloadTableName;
    std::string fk4ConstraintName = obj2tagTableName + "_P_FK";
    tableDesc->createForeignKey( fk4ConstraintName,
                                 fk4Columns,
                                 fk4TargetTable,
                                 fk4Columns );
  }
  else if ( pMode == cool_PayloadMode_Mode::VECTORPAYLOAD )
  {
    std::string fk4TargetTable = objectTableName;
    std::string fk4ConstraintName = obj2tagTableName + "_P_FK";
    tableDesc->createForeignKey( fk4ConstraintName,
                                 RelationalObject2TagTable::columnNames::payloadSetId,
                                 fk4TargetTable,
                                 RelationalObjectTable::columnNames::objectId() );
  }

  // Create the table
  log() << "Create table " << obj2tagTableName << coral::MessageStream::endmsg;
  session().nominalSchema().createTable( *tableDesc );
}

//-----------------------------------------------------------------------------

void RalSchemaMgr::renameColumnInTable
( const std::string& tableName,
  const std::string& oldColumnName,
  const std::string& newColumnName ) const
{
  if ( ! isValidColumnName( newColumnName ) )
    throw InvalidColumnName
      ( newColumnName, "RalSchemaMgr::renameColumnInTable");

  coral::ITable& table =
    session().nominalSchema().tableHandle( tableName );

  table.schemaEditor().renameColumn( oldColumnName, newColumnName );
}

//-----------------------------------------------------------------------------

void RalSchemaMgr::addColumnsToTable
( const std::string& tableName,
  const IRecord& columns ) const
{

  // Get a table handle
  coral::ITable& table =
    session().nominalSchema().tableHandle( tableName );

  // Prepare the set clause for setting the default values
  std::string setClause;

  // Loop over all columns and add them one by one
  const IRecordSpecification& spec = columns.specification();
  for ( UInt32 i = 0; i < spec.size(); i++ )
  {
    const IField& column = columns[i];

    const std::string& columnName = column.specification().name();
    const StorageType::TypeId columnTypeId = column.specification().storageType().id();

    if ( ! isValidColumnName( columnName ) )
      throw InvalidColumnName
        ( columnName, "RalSchemaMgr::addColumnToTable");

    const StorageType& columnType = StorageType::storageType( columnTypeId );
    const std::string columnTypeName =
      coral::AttributeSpecification::typeNameForId( columnType.cppType() );
    int maxSize = columnType.maxSize();
    bool fixedSize = false;
    table.schemaEditor().insertColumn
      ( columnName, columnTypeName, maxSize, fixedSize );

    if ( setClause != "" ) setClause += ", ";
    setClause += columnName + " = :" + columnName;

  }

  // Set the default values for the new columns in all existing rows
  std::string whereClause = "";
  const coral::AttributeList& updateData = columns.attributeList();
  table.dataEditor().updateRows( setClause, whereClause, updateData );

}

//-----------------------------------------------------------------------------
