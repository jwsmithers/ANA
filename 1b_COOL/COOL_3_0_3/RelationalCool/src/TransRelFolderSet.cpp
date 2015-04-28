
// Include files
#include "CoolKernel/Exception.h"

// Local include files
#include "RelationalDatabase.h"
#include "RelationalTransaction.h"
#include "TransRelFolderSet.h"

// Namespace
using namespace cool;

//-----------------------------------------------------------------------------

std::vector<std::string> TransRelFolderSet::listFolders( bool ascending )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolderSet::listfolders");
  std::auto_ptr<RelationalTransaction>
    trans( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  std::vector<std::string> retValue =
    m_folderSet->listFolders( ascending );

  trans->commit();
  return retValue;
}

//-----------------------------------------------------------------------------

std::vector<std::string> TransRelFolderSet::listFolderSets( bool ascending )
{
  if ( !db().isOpen() ) throw DatabaseNotOpen("TransRelFolderSet::listFolderSets");
  std::auto_ptr<RelationalTransaction>
    trans( new RelationalTransaction( db().transactionMgr(), true ) ); // r/o

  std::vector<std::string> retValue =
    m_folderSet->listFolderSets( ascending );

  trans->commit();
  return retValue;
}

//-----------------------------------------------------------------------------
