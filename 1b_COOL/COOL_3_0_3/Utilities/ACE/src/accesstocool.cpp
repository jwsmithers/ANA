#include <QtCore/QtDebug>
#include "CoolKernel/FolderSpecification.h"
#include "CoolKernel/../src/scoped_enums.h"
#include "ACE/accesstocool.h"

namespace cool {

bool openDatabase( cool::DatabaseId m_dbId, cool::IDatabasePtr& db )
{
    cool::IDatabaseSvc* m_dbSvc( &(cool::DatabaseSvcFactory::databaseService() ) );

    // Open the database.
    try
    {
        db = m_dbSvc->openDatabase( m_dbId, false );
    }
    catch(cool::DatabaseDoesNotExist&)
    {
        qDebug() << "openDatabase: DB does not exist.";
//        createTestDB();
        return false;
    }
    catch(coral::ConnectionNotAvailableException&)
    {
        // From COOL 2.x, this exception (and not cool::DatabaseDoesNotExist)
        // is thrown if an sqlite database file doesnt exist. In which case
        // we do need to create the database.
        // For other plugins (with a server) this may be inappropriate?
        qDebug() << "openDatabase: DB connection not available.";
        return false;
    }
    catch(cool::Exception &e)
    {
        qDebug() << "openDatabase: failed to open DB (COOL exception).";
        qDebug() << e.what() << ".";
        return false;
    }
    catch(coral::Exception &e)
    {
        qDebug() << "openDatabase: failed to open DB (CORAL exception).";
        qDebug() << e.what() << ".";
        return false;
    }
    catch(...)
    {
        qDebug() << "openDatabase: failed to open DB (unknown exception).";
        return false;
    }
    return true;
}

void createTestDB()
{
    cool::DatabaseId dbId("sqlite://;schema=/afs/cern.ch/user/c/ctan/mytest.sqlite;dbname=TEST");
//    cool::DatabaseId dbId("oracle://devdb10;schema=atlas_trig_dev;dbname=TEST");

    // Create database
    cool::IDatabaseSvc& dbSvc = cool::DatabaseSvcFactory::databaseService();
    dbSvc.dropDatabase( dbId );

    cool::IDatabasePtr db = dbSvc.createDatabase( dbId );

    // Create specification
    cool::RecordSpecification spec;
    spec.extend("Bool",cool::cool_StorageType_TypeId::Bool);
    spec.extend("UChar",cool::cool_StorageType_TypeId::UChar);
    spec.extend("Int16",cool::cool_StorageType_TypeId::Int16);
    spec.extend("UInt16",cool::cool_StorageType_TypeId::UInt16);
    spec.extend("Int32",cool::cool_StorageType_TypeId::Int32);
    spec.extend("UInt32",cool::cool_StorageType_TypeId::UInt32);
    spec.extend("UInt63",cool::cool_StorageType_TypeId::UInt63);
    spec.extend("Int64",cool::cool_StorageType_TypeId::Int64);
    spec.extend("Float",cool::cool_StorageType_TypeId::Float);
    spec.extend("Double",cool::cool_StorageType_TypeId::Double);
    spec.extend("String255",cool::cool_StorageType_TypeId::String255);
    spec.extend("String4k",cool::cool_StorageType_TypeId::String4k);
    spec.extend("String64k",cool::cool_StorageType_TypeId::String64k);
    spec.extend("String16M",cool::cool_StorageType_TypeId::String16M);
    spec.extend("Blob64k",cool::cool_StorageType_TypeId::Blob64k);
    spec.extend("Blob16M",cool::cool_StorageType_TypeId::Blob16M);

    // Create folder
    FolderSpecification fSpec( cool_FolderVersioning_Mode::MULTI_VERSION, spec );
    cool::IFolderPtr f1 = db->createFolder( "/folder_1", fSpec, "DESCRIPTION" );

    // Populate folder
    qDebug() << "Storing objects in different channels (Channel 0-6)";
    for ( int i = 0; i < 20; ++i )
    {
      cool::ValidityKey since = i;
      cool::ValidityKey until = ValidityKeyMax;
      cool::ChannelId channel = i / 3;
      cool::Record payload( spec, createPayload( i, spec ) );
      f1->storeObject( since, until, payload, (ChannelId)channel );
      if ( i%3 == 0 )
      {
        std::stringstream s; s << "Tag_" << i;
        std::stringstream t; t << "after Object " << i;
        f1->tagCurrentHead( s.str(), t.str() );
      }
    }
}

coral::AttributeList createPayload( int index, const cool::RecordSpecification& spec )
{
    coral::AttributeList payload = Record( spec ).attributeList();
    payload["Bool"].data<cool::Bool>() = false;
    payload["UChar"].data<cool::UChar>() = 255;
    payload["Int16"].data<cool::Int16>() = index * -1;
    payload["UInt16"].data<cool::UInt16>() = index;
    payload["Int32"].data<cool::Int32>() = index * -1;
    payload["UInt32"].data<cool::UInt32>() = index;
    payload["UInt63"].data<cool::UInt63>() = index;
    payload["Int64"].data<cool::Int64>() = index * -1;
    payload["Float"].data<cool::Float>() = index * -1.0;
    payload["Double"].data<cool::Double>() = index * -1.0;

    QString s( "THIS IS A TEST." );
    payload["String255"].data<cool::String255>() = s.toStdString();
    payload["String4k"].data<cool::String4k>() = s.toStdString();
    payload["String64k"].data<cool::String64k>() = s.toStdString();
    payload["String16M"].data<cool::String16M>() = s.toStdString();

    QByteArray ba = QString( "0123456789abcdefABCDEF.GHIJKLMNOPQRSTUVWXYZ" ).toUtf8();
    coral::Blob& blob = payload["Blob64k"].data<coral::Blob>();
    int blobSize = ba.size();
    blob.resize( blobSize );
    char* p = static_cast<char*>( blob.startingAddress() );
    char *data = ba.data();
    for ( int j = 0; j < blobSize; ++j, ++p, ++data ) *p = *data;

    QByteArray ba1 = QString( "0123456789abcdefABCDEF.GHIJKLMNOPQRSTUVWXYZ" ).toUtf8();
    coral::Blob& blob1 = payload["Blob16M"].data<coral::Blob>();
    int blobSize1 = ba1.size();
    blob1.resize( blobSize1 );
    char* p1 = static_cast<char*>( blob1.startingAddress() );
    char *data1 = ba1.data();
    for ( int j1 = 0; j1 < blobSize1; ++j1, ++p1, ++data1 ) *p1 = *data1;

    return payload;
}

} // namespace cool
