// $Id: RelationalFolderUnsupported.cpp,v 1.4 2009-12-17 18:38:53 avalassi Exp $

// Local include files
#include "RelationalFolderUnsupported.h"
#include "RelationalNodeTable.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

void RelationalFolderUnsupported::initialize( const coral::AttributeList& row )
{
  const IRecordSpecification& spec = folderAttributesSpecification();
  m_publicFolderAttributes = Record( spec, row );
  log() << coral::Debug
        << "Instantiate a RelationalFolderUnsupported for '"
        << fullPath() << "'" << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

RelationalFolderUnsupported::~RelationalFolderUnsupported()
{
  log() << coral::Debug << "Delete the RelationalFolderUnsupported for '"
        << fullPath() << "'" << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

coral::MessageStream& RelationalFolderUnsupported::log() const
{
  *m_log << coral::Verbose;
  return *m_log;
}

//-----------------------------------------------------------------------------

const IRecord& RelationalFolderUnsupported::folderAttributes() const
{
  return m_publicFolderAttributes;
}

//-----------------------------------------------------------------------------

const RecordSpecification&
RelationalFolderUnsupported::folderAttributesSpecification()
{
  static RecordSpecification s_folderAttrSpec;
  if ( s_folderAttrSpec.size() == 0 ) {
    s_folderAttrSpec.extend
      ( RelationalNodeTable::columnNames::nodeSchemaVersion,
        RelationalNodeTable::columnTypeIds::nodeSchemaVersion );
  }
  return s_folderAttrSpec;
}

//-----------------------------------------------------------------------------
