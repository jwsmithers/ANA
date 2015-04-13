#ifndef ACCESSTOCOOL_H
#define ACCESSTOCOOL_H

#include <CoolKernel/ChannelSelection.h>
#include <CoolKernel/IDatabaseSvc.h>
#include <CoolKernel/IDatabase.h>
#include <CoolKernel/DatabaseId.h>
#include <CoolKernel/types.h>
#include <CoolKernel/Record.h>
#include <CoolKernel/RecordSpecification.h>
#include <CoolKernel/FolderSpecification.h> 
#include <CoolKernel/FolderVersioning.h>
#include <CoolKernel/IFolder.h>
#include <CoolKernel/StorageType.h>
#include <CoolKernel/Exception.h>
#include <CoolKernel/IObject.h>
#include <CoolKernel/IObjectIterator.h>
#include <CoolKernel/IField.h>
#include <CoolKernel/IFieldSpecification.h>

#include <CoralBase/Exception.h>
#include <CoolApplication/DatabaseSvcFactory.h>
#include <RelationalAccess/ConnectionServiceException.h>

// Test routine includes
#include <QtCore/QString>
#include <QtCore/QByteArray>
#include "CoralBase/Attribute.h"
#include "CoralBase/Blob.h"
#include <sstream>


namespace cool {
bool openDatabase( cool::DatabaseId m_dbId, cool::IDatabasePtr& db );

// Test routines
void createTestDB();
coral::AttributeList createPayload( int index, const cool::RecordSpecification& spec );

} // cool namespace

#endif

