// $Id: RelationalNodeTable.cpp,v 1.33 2009-12-16 17:17:37 avalassi Exp $

// Include files
#include <map>
#include "CoolKernel/RecordSpecification.h"

// Local include files
#include "RelationalNodeTable.h"
#include "RelationalException.h"
#include "VersionInfo.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

const IRecordSpecification&
RelationalNodeTable::tableSpecification()
{
  return tableSpecification( VersionInfo::schemaVersion );
}

//-----------------------------------------------------------------------------

const IRecordSpecification&
RelationalNodeTable::tableSpecification( const VersionNumber& dbSchemaVersion )
{
  static std::map< VersionNumber, RecordSpecification> specs;
  RecordSpecification& spec = specs[dbSchemaVersion];
  if ( spec.size() == 0 )
  {
    // Default columns for both folder sets and folders
    spec.extend( RelationalNodeTable::columnNames::nodeId,
                 RelationalNodeTable::columnTypeIds::nodeId );
    //if ( hasParent )
    spec.extend( RelationalNodeTable::columnNames::nodeParentId,
                 RelationalNodeTable::columnTypeIds::nodeParentId );
    spec.extend( RelationalNodeTable::columnNames::nodeName,
                 RelationalNodeTable::columnTypeIds::nodeName );
    spec.extend( RelationalNodeTable::columnNames::nodeFullPath,
                 RelationalNodeTable::columnTypeIds::nodeFullPath );
    spec.extend( RelationalNodeTable::columnNames::nodeDescription,
                 RelationalNodeTable::columnTypeIds::nodeDescription );
    spec.extend( RelationalNodeTable::columnNames::nodeIsLeaf,
                 RelationalNodeTable::columnTypeIds::nodeIsLeaf );
    if ( dbSchemaVersion >= VersionNumber( "2.0.0" ) )
      spec.extend( RelationalNodeTable::columnNames::nodeSchemaVersion,
                   RelationalNodeTable::columnTypeIds::nodeSchemaVersion );
    spec.extend( RelationalNodeTable::columnNames::nodeInsertionTime,
                 RelationalNodeTable::columnTypeIds::nodeInsertionTime );
    if ( dbSchemaVersion >= VersionNumber( "2.0.0" ) )
      spec.extend( RelationalNodeTable::columnNames::lastModDate,
                   RelationalNodeTable::columnTypeIds::lastModDate );
    spec.extend
      ( RelationalNodeTable::columnNames::folderVersioningMode,
        RelationalNodeTable::columnTypeIds::folderVersioningMode );

    // Columns relevant for folders only
    spec.extend
      ( RelationalNodeTable::columnNames::folderPayloadSpecDesc,
        RelationalNodeTable::columnTypeIds::folderPayloadSpecDesc );
    if ( dbSchemaVersion >= VersionNumber( "2.0.0" ) )
    {
      spec.extend
        ( RelationalNodeTable::columnNames::folderPayloadInline,
          RelationalNodeTable::columnTypeIds::folderPayloadInline );
      spec.extend
        ( RelationalNodeTable::columnNames::folderPayloadExtRef,
          RelationalNodeTable::columnTypeIds::folderPayloadExtRef );
      spec.extend
        ( RelationalNodeTable::columnNames::folderChannelSpecDesc,
          RelationalNodeTable::columnTypeIds::folderChannelSpecDesc );
      spec.extend
        ( RelationalNodeTable::columnNames::folderChannelExtRef,
          RelationalNodeTable::columnTypeIds::folderChannelExtRef );
    }
    spec.extend
      ( RelationalNodeTable::columnNames::folderObjectTableName,
        RelationalNodeTable::columnTypeIds::folderObjectTableName );
    spec.extend
      ( RelationalNodeTable::columnNames::folderTagTableName,
        RelationalNodeTable::columnTypeIds::folderTagTableName );
    spec.extend
      ( RelationalNodeTable::columnNames::folderObject2TagTableName,
        RelationalNodeTable::columnTypeIds::folderObject2TagTableName );
    if ( dbSchemaVersion >= VersionNumber( "2.0.0" ) )
      spec.extend
        ( RelationalNodeTable::columnNames::folderChannelTableName,
          RelationalNodeTable::columnTypeIds::folderChannelTableName );
  }

  return spec;

}

//-----------------------------------------------------------------------------
