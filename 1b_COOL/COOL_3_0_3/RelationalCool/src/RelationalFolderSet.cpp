
// Include files
#include "CoolKernel/Exception.h"

// Local include files
#include "RelationalDatabase.h"
#include "RelationalFolderSet.h"
#include "RelationalNodeTable.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

bool RelationalFolderSet::isSupportedSchemaVersion
( const VersionNumber& rhs )
{
  VersionNumber lhs = folderSetSchemaVersion();
  return
    ( lhs.majorVersion() == rhs.majorVersion() )
    && ( lhs.minorVersion() == rhs.minorVersion() );
  //&& ( lhs.patchVersion() <= rhs.patchVersion() );
}

//-----------------------------------------------------------------------------

void RelationalFolderSet::initialize( const coral::AttributeList& row )
{
  const IRecordSpecification& spec = folderSetAttributesSpecification();
  m_publicFolderSetAttributes = Record( spec, row );
  log() << coral::Debug << "Instantiate a RelationalFolderSet for '"
        << fullPath() << "'" << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

RelationalFolderSet::~RelationalFolderSet()
{
  log() << coral::Debug << "Delete the RelationalFolderSet for '"
        << fullPath() << "'" << coral::MessageStream::endmsg;
}

//-----------------------------------------------------------------------------

coral::MessageStream& RelationalFolderSet::log()
{
  *m_log << coral::Verbose;
  return *m_log;
}

//-----------------------------------------------------------------------------

std::vector<std::string>
RelationalFolderSet::listFolders( bool ascending )
{
  return db().listFolders( this, ascending );
}


//-----------------------------------------------------------------------------

std::vector<std::string>
RelationalFolderSet::listFolderSets( bool ascending )
{
  return db().listFolderSets( this, ascending );
}

//-----------------------------------------------------------------------------

const IRecord& RelationalFolderSet::folderSetAttributes() const
{
  return m_publicFolderSetAttributes;
}

//-----------------------------------------------------------------------------

const RecordSpecification&
RelationalFolderSet::folderSetAttributesSpecification()
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
