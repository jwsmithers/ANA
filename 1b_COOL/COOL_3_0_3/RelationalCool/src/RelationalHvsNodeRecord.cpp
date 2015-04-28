
// Include files
#include "CoralBase/Attribute.h"

// Local include files
#include "HvsPathHandler.h"
#include "RelationalHvsNodeRecord.h"
#include "RelationalNodeTable.h"
#include "timeToString.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

RelationalHvsNodeRecord::RelationalHvsNodeRecord
( const coral::AttributeList& row )
  : m_schemaVersion( row[RelationalNodeTable::columnNames::nodeSchemaVersion]
                     .data<std::string>() )
  , m_nodeAttributes()
{
  // TODO: use COOL typedefs instead of explicit <T> like <std::string>...

  m_id = row[RelationalNodeTable::columnNames::nodeId]
    .data<unsigned int>();

  m_fullPath = row[RelationalNodeTable::columnNames::nodeFullPath]
    .data<std::string>();

  // TEMPORARY! CHECK IF nodeId==0 TO ASSUME ROOT FOLDER SET
  // EVENTUALLY: fetch METHODS SHOULD RETURN LIST OF NULL ATTRIBUTES
  HvsPathHandler handler;
  if( m_fullPath == handler.rootFullPath() ) {
    m_parentId = m_id;
  } else {
    m_parentId = row[RelationalNodeTable::columnNames::nodeParentId]
      .data<unsigned int>();
  }

  m_description = row[RelationalNodeTable::columnNames::nodeDescription]
    .data<std::string>();

  m_isLeaf = row[RelationalNodeTable::columnNames::nodeIsLeaf]
    .data<bool>();

  // No default constructor for VersionNumber
  //m_schemaVersion = row[RelationalNodeTable::columnNames::nodeSchemaVersion]
  //  .data<std::string>();

  std::string time = row[RelationalNodeTable::columnNames::nodeInsertionTime]
    .data<std::string>();
  m_insertionTime = stringToTime( time );
}

//-----------------------------------------------------------------------------

const std::string& RelationalHvsNodeRecord::fullPath() const
{
  return m_fullPath;
}

//-----------------------------------------------------------------------------

const std::string& RelationalHvsNodeRecord::description() const
{
  return m_description;
}

//-----------------------------------------------------------------------------

bool RelationalHvsNodeRecord::isLeaf() const
{
  return m_isLeaf;
}

//-----------------------------------------------------------------------------

const VersionNumber& RelationalHvsNodeRecord::schemaVersion() const
{
  return m_schemaVersion;
}

//-----------------------------------------------------------------------------

const ITime& RelationalHvsNodeRecord::insertionTime() const
{
  return m_insertionTime;
}

//-----------------------------------------------------------------------------

unsigned int RelationalHvsNodeRecord::id() const
{
  return m_id;
}

//-----------------------------------------------------------------------------

unsigned int RelationalHvsNodeRecord::parentId() const
{
  return m_parentId;
}

//-----------------------------------------------------------------------------

const IRecord& RelationalHvsNodeRecord::nodeAttributes() const
{
  /// Avoid link time error: 'liblcg_RelationalCool.so: undefined reference to
  /// `virtual thunk to cool::RelationalHvsNodeRecord::nodeAttributes() const'
  ///return (const IRecord&)m_nodeAttributes;
  const Record& attr = m_nodeAttributes;
  return attr;
}

//-----------------------------------------------------------------------------
