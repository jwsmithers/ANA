// $Id: RelationalFolderSetUnsupported.cpp,v 1.5 2009-12-17 18:38:53 avalassi Exp $

// Local include files
#include "RelationalDatabase.h"
#include "RelationalFolderSetUnsupported.h"
#include "RelationalNodeTable.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

void
RelationalFolderSetUnsupported::initialize( const coral::AttributeList& row )
{
  const IRecordSpecification& spec = folderSetAttributesSpecification();
  m_publicFolderSetAttributes = Record( spec, row );
  log() << coral::Debug
        << "Instantiate a RelationalFolderSetUnsupported for '"
        << fullPath() << "'" << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

RelationalFolderSetUnsupported::~RelationalFolderSetUnsupported()
{
  log() << coral::Debug
        << "Delete the RelationalFolderSetUnsupported for '"
        << fullPath() << "'" << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

coral::MessageStream& RelationalFolderSetUnsupported::log()
{
  *m_log << coral::Verbose;
  return *m_log;
}

//-----------------------------------------------------------------------------

const IRecord& RelationalFolderSetUnsupported::folderSetAttributes() const
{
  return m_publicFolderSetAttributes;
}

//-----------------------------------------------------------------------------

const RecordSpecification&
RelationalFolderSetUnsupported::folderSetAttributesSpecification()
{
  static RecordSpecification s_folderSetAttrSpec;
  if ( s_folderSetAttrSpec.size() == 0 ) {
    s_folderSetAttrSpec.extend
      ( RelationalNodeTable::columnNames::nodeSchemaVersion,
        RelationalNodeTable::columnTypeIds::nodeSchemaVersion );
  }
  return s_folderSetAttrSpec;
}

//-----------------------------------------------------------------------------
