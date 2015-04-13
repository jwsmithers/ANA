#include <QtCore/QString>
#include <QtCore/QStringList>
#include <QtCore/QPair>
#include <QtCore/QtDebug>
#include <QtCore/QSettings>
#include <QtCore/QRegExp>
#include <QtGui/QColor>
#include <QtGui/QValidator>
#include <QtGui/QRegExpValidator>
#include <QtGui/QIntValidator>
#include <QtGui/QDoubleValidator>

#include "ACE/foldertablemodel.h"
#include "ACE/ACE_Errors.h"

FolderTableModel::FolderTableModel( cool::IFolderPtr folderPtr, QString vkEncoding, cool::ValidityKey start, cool::ValidityKey end, cool::ChannelSelection channels, QString tag, QObject* parent )
try :
    QAbstractTableModel( parent ),
    coolFolderPtr( folderPtr ),
    payloadSpec( coolFolderPtr->payloadSpecification() ),
    filtered( false ),
    vkEncoding( vkEncoding ),
    versioningMode( coolFolderPtr->versioningMode() )
{
    QSettings settings;
    setupFolderTableModelData( start, end, channels, tag );
    defaultCopyRow = rowCount() - 1;
    settings.beginGroup( "Preferences/FolderTables" );
    newRowColour = settings.value( "NewRowBGColour", QString( "#00FFFF" ) ).toString();
    modifiedColour = settings.value( "ModifiedBGColour", QString( "#DDFFFF" ) ).toString();
    filteredColour = settings.value( "FilteredBGColour", QString( "#DDEEFF" ) ).toString();
    settings.beginGroup( "Mask" );
    if ( settings.value( "ChannelId_Hex", true ).toBool() )
    {
        displayAsMaskHash[ 0 ] = hexMask;
    }
    if ( vkEncoding == "time" )
    {
        displayAsMaskHash[ 1 ] = IOV_time_Mask;
        displayAsMaskHash[ 2 ] = IOV_time_Mask;
    }
    else if ( vkEncoding == "run-lumi" )
    {
        displayAsMaskHash[ 1 ] = IOV_runLB_Mask;
        displayAsMaskHash[ 2 ] = IOV_runLB_Mask;
    }
    else if ( vkEncoding == "run-event" )
    {
        displayAsMaskHash[ 1 ] = IOV_runEvt_Mask;
        displayAsMaskHash[ 2 ] = IOV_runEvt_Mask;
    }
    else
    {
        displayAsMaskHash[ 1 ] = IOV_generic_Mask;
        displayAsMaskHash[ 2 ] = IOV_generic_Mask;
    }
    maskColour = settings.value( "MaskColour", QString( "#000080" ) ).toString();
    settings.endGroup(); // Mask
    settings.endGroup(); // Preferences/FolderTables
    columnResponseHash[ 0 ] = confirmResponse;    
    columnResponseHash[ 1 ] = readonlyResponse;
    columnResponseHash[ 2 ] = readonlyResponse;
}
catch ( ace_errors::EmptyFolder& )
{
    qCritical() << "Could not construct FolderTableModel from empty folder!";
    throw;
}
catch ( cool::Exception& e )
{
    qCritical() << e.what();
    throw;
}
catch ( ... )
{
    qCritical() << "Unknown error! Could not construct FolderTableModel!";
    throw;
}

FolderTableModel::~FolderTableModel()
{
    delete rootTableItem;
}

Qt::ItemFlags FolderTableModel::flags( const QModelIndex& index ) const
{
    if ( !index.isValid() )
        return 0;
    else if ( columnResponseHash.value( index.column(), noResponse ) == readonlyResponse ) 
        return Qt::ItemIsEnabled | Qt::ItemIsSelectable;
    else
        return QAbstractTableModel::flags( index ) | Qt::ItemIsEditable;
}

int FolderTableModel::rowCount( const QModelIndex& parent ) const
{
    if ( parent.column() > 0 )
        return 0;

    if ( !parent.isValid() )
        return rootTableItem->childCount();
    else
        return 0;
}

int FolderTableModel::columnCount( const QModelIndex& parent ) const
{
    if ( parent.isValid() )
        return static_cast<FolderTableItem*>( parent.internalPointer() )->columnCount();
    else
        return rootTableItem->columnCount();
}

QVariant FolderTableModel::headerData( int section, Qt::Orientation orientation, int role ) const
{
    if ( orientation == Qt::Horizontal && role == Qt::DisplayRole )
        return QVariant( rootTableItem->header( section ) );

    return QVariant();
}

QModelIndex FolderTableModel::index( int row, int column, const QModelIndex& parent) const
{
    if ( !hasIndex( row, column, parent ) )
        return QModelIndex();

    if ( !parent.isValid() )
    {
        FolderTableItem* childItem = rootTableItem->child( row );
        if ( childItem )
            return createIndex( row, column, childItem );
        else
            return QModelIndex();
    }
    else
    {
        qCritical() << "FolderTableItems should not have children!";
        return QModelIndex();
    }
}

QModelIndex FolderTableModel::parent( const QModelIndex& /*index*/ ) const
{
    // The parent index is always the root item's index.
    return QModelIndex();
}

void FolderTableModel::setupFolderTableModelData( cool::ValidityKey start, cool::ValidityKey end, cool::ChannelSelection channels, QString tag )
{
    QSettings settings;
    cool::IObjectIteratorPtr ic;
    bool ok( false );
    if ( start == cool::ValidityKeyMax )
    {
//        qDebug() << "using findObjects. The folder description is: " << QString::fromStdString( coolFolderPtr->description() ) << ".";
        ic = coolFolderPtr->findObjects( start - 1, channels, tag.toStdString() ); // original line
//        ic = coolFolderPtr->browseObjects( start, cool::ValidityKeyMax, channels, tag.toStdString() );
    }
    else
    {
//        qDebug() << "using browseObjects. The folder description is: " << QString::fromStdString( coolFolderPtr->description() ) << ".";
        ic = coolFolderPtr->browseObjects( start, end, channels, tag.toStdString() );  // original line
    }
    
//    const cool::Record& folderAttributes = coolFolderPtr->folderAttributes();
    
    if ( ic->isEmpty() )
    {
        throw ace_errors::EmptyFolder();
    }
    
    // Populate the rootTableItem using folder's payload specification
    QList< QPair< QString, QVariant > > hTypeList;
    QList<QString> hNames;
    QString typeName;
    QString headingStr_since;
    QString headingStr_until;
    if ( vkEncoding == "time" )
    {
        headingStr_since = "Since";
        headingStr_until = "Until";
    }
    else
    {
        settings.beginGroup( "Validity Key Encoding/" + vkEncoding );
        headingStr_since = "Since:[" + settings.value( "lineEdit_HighBits" ).toString() + "|" + settings.value( "lineEdit_LowBits" ).toString()  + "]";
        headingStr_until = "Until:[" + settings.value( "lineEdit_HighBits" ).toString() + "|" + settings.value( "lineEdit_LowBits" ).toString()  + "]";
        settings.endGroup();
    }
    hNames << "ChannelId" << headingStr_since << headingStr_until;
    hTypeList.append( qMakePair( QString( "UInt32" ), QVariant( getQVariantType( std::string( "UInt32" ) ) ) ) );
    hTypeList.append( qMakePair( QString( "UInt63" ), QVariant( getQVariantType( std::string( "UInt63" ) ) ) ) );
    hTypeList.append( qMakePair( QString( "UInt63" ), QVariant( getQVariantType( std::string( "UInt63" ) ) ) ) );
     
    for ( unsigned int i=0; i<payloadSpec.size(); i++ )
    {
        const cool::IFieldSpecification& fSpec = payloadSpec[ i ];
        const cool::StorageType& st = fSpec.storageType();
        // Add the column header name to the hNames QList.
        hNames.append( QString::fromStdString( fSpec.name() ) );
        // Add to QPair using cool's type name and 
        // a null QVariant equivalent as default value.
        typeName = QString::fromStdString( st.name() );
        hTypeList.append( qMakePair( typeName, QVariant( getQVariantType( st.name() ) ) ) );
        if ( ( typeName == "Blob64k" ) || ( typeName == "Blob16M" ) )
        {
            displayAsMaskHash[ i + 3 ] = blobMask;
        }
        else if ( ( typeName == "String4k" ) || ( typeName == "String64k" ) || ( typeName == "String16M") )
        {
            displayAsMaskHash[ i + 3 ] = clobMask;
        }
        else if ( typeName == "UChar" )
        {
            displayAsMaskHash[ i + 3 ] = decMask;
        }
    }
    
    rootTableItem = new RootFolderTableItem( hNames, hTypeList );

    //Populate the rest of the table items.

    while ( ic->goToNext() )
    {
        const cool::IObject& o = ic->currentRef();
        const cool::IRecord& r = o.payload();
        const cool::IRecordSpecification& recordSpec = r.specification();
        QList<QVariant> entryData;
        entryData << QVariant( o.channelId() ) << QVariant( o.since() ) << QVariant( o.until() );
        for ( unsigned int i=0; i<recordSpec.size(); i++ )
        {
            const cool::IField& f = r[ i ];
            DisplayAsMask currentMask = getDisplayAsMask( i + 3 );
            if (  currentMask == blobMask )
            {
                const coral::Blob& tempBlob = o.payloadValue< coral::Blob >( f.name() );
                entryData.append( QVariant( QByteArray( static_cast<const char*>( tempBlob.startingAddress() ), ( int ) tempBlob.size() ) ) );
            }
            else
            {
                entryData.append( qStringToQVariant( QString::fromStdString( o.payloadValue( f.name() ) ), &ok, i+3 ) );
            }
        }
        FolderTableItem* newTableItem = new FolderTableItem( entryData, rootTableItem, false );
        rootTableItem->appendChild( newTableItem );
    }
}

bool FolderTableModel::setHeaderData( int /*section*/, Qt::Orientation /*orientation*/, const QVariant& /*value*/, int /*role*/ )
{
//    if ( orientation == Qt::Horizontal && role == Qt::EditRole && value.type() == QVariant::String )
//        return rootTableItem->setHeader( value.toString(), section );

    // Table header should not be modifiable
    return false;
}

bool FolderTableModel::removeRows( int row, int count, const QModelIndex& parent )
{
    if ( count < 1 || row < 0 )
    {
        qWarning() << "Either count < 1 or row < 0";
        return false;
    }
    
    if ( parent.isValid() )
    {
        qCritical() << "Parent index provided does not refer to the rootTableItem!";
        return false;
    }

    beginRemoveRows( QModelIndex(), row, row + count - 1 );
    while ( count-- )
    {
        delete rootTableItem->child( row );
        rootTableItem->removeChildAt( row );
    }
    endRemoveRows();
    if ( !rootTableItem->anyNew() )
    {
        emit modelChanged( this, false );
    }
    return true;
}

// Add a blank row.
bool FolderTableModel::insertRows( int row, int count, const QModelIndex& parent )
{
    if ( count < 1 || row < 0 )
    {
        qWarning() << "Either count < 1 or row < 0";
        return false;
    }
    if ( parent.isValid() )
    {
        qCritical() << "Parent index provided does not refer to the rootTableItem!";
        return false;
    }
    beginInsertRows( QModelIndex(), row, row + count - 1 );
    while ( count-- )
    {
        FolderTableItem* cloneSourceTableItem = rootTableItem->child( defaultCopyRow );
        FolderTableItem* newTableItem = new FolderTableItem( cloneSourceTableItem->data(), rootTableItem, true );
        
        newTableItem->setData( QVariant( (qulonglong)( QDateTime::currentDateTime().toTime_t() ) * (qulonglong)( 1000000000 ) ), 1 ); // remove dependency on Seal
        newTableItem->setData( QVariant( cool::ValidityKeyMax ), 2 );
        
        newTableItem->setClonedSourceItem( cloneSourceTableItem );
        rootTableItem->insertChild( newTableItem, row );
    }
    endInsertRows();
    emit modelChanged( this, true );
    return true;
}

QVariant::Type FolderTableModel::getQVariantType( const std::string& coolType ) const
{
    if ( coolType == "Bool" )
        return QVariant::Bool;
    else if ( coolType == "UChar" )
        return QVariant::Char;
    else if ( coolType == "Int16" )
        return QVariant::Int;
    else if ( coolType == "UInt16" )
        return QVariant::UInt;
    else if ( coolType == "Int32" )
        return QVariant::Int;
    else if ( coolType == "UInt32" )
        return QVariant::UInt;
    else if ( coolType == "UInt63" )
        return QVariant::ULongLong;
    else if ( coolType == "Int64" )
        return QVariant::LongLong;
    else if ( coolType == "Float" )
        return QVariant::Double;
    else if ( coolType == "Double" )
        return QVariant::Double;
    else if ( coolType == "String255" )
        return QVariant::String;
    else if ( coolType == "String4k" )
        return QVariant::String;
    else if ( coolType == "String64k" )
        return QVariant::String;
    else if ( coolType == "String16M" )
        return QVariant::String;
    else if ( coolType == "Blob64k" )
        return QVariant::ByteArray;
    else if ( coolType == "Blob16M" )
        return QVariant::ByteArray;
    else
    {
        qWarning() << "[getQVariantType()] Unrecognised COOL type (" << QString::fromStdString( coolType ) << ") provided!";
        return QVariant::Invalid;
    }
}

QVariant::Type FolderTableModel::getQVariantType( const QModelIndex& index ) const
{
    if ( index.isValid() )
        return rootTableItem->headerType( index.column() ).second.type();
    qWarning() << "[getQVariantType()]: Invalid index provided!";
    return QVariant::Invalid;
}

QVariant::Type FolderTableModel::getQVariantType( const QString& field ) const
{
    int column = rootTableItem->headerPos( field );
    if ( column == -1 )
    {
        qWarning() << "[getQVariantType()]: " << field << " not found!";
        return QVariant::Invalid;
    }
    return rootTableItem->headerType( column ).second.type();
}

QVariant::Type FolderTableModel::getQVariantType( int column ) const
{
    if ( column <= columnCount() )
        return rootTableItem->headerType( column ).second.type();
    qWarning() << "[getQVariantType()]: No such column!";
    return QVariant::Invalid;
}

QString FolderTableModel::getCoolTypeString( const QModelIndex& index ) const
{
    if ( index.isValid() )
        return rootTableItem->headerType( index.column() ).first;
    qWarning() << "[getCoolTypeString()]: Invalid index provided!";
    return QString( "Unknown type" );
}

RootFolderTableItem* FolderTableModel::getRootTableItem() const
{
    return rootTableItem;
}

void FolderTableModel::setDefaultCopyRow( int row )
{
    if ( row < rowCount() )
        defaultCopyRow = row;
    else
        qWarning() << "Trying to set a non-existent row as the defaultCopyRow!";
}

// Search for rows that satisfy the 'pointer to member function' test.
QList< int > FolderTableModel::filter( FilterFunction0 f, bool inverse, bool allChannels, int rowStartPos, int rowEndPos )
{
    QList< int > selectedRows;
    int startRow = 0, maxRow = rowCount() - 1;
    unsigned int channelId = 0;

    if ( rowStartPos != -1 )  // specific start and end rows are tested only if searching for a particular channel
    {
        startRow = rowStartPos;
        if ( rowEndPos != -1 )
            maxRow = rowEndPos;
    }
    
    // *Important* rowStartPos and rowEndPos should not be used beyond this point.
    
    if ( !allChannels ) // look for a specific channelId
    {
        channelId = getRootTableItem()->child( startRow )->getChannelId();
    }

    // Traverse the rows of interest
    for ( int r = startRow; r <= maxRow; r++ )
    {
        // If allChannels is true, channelId is meaningless.
        // The second part of the if test is not executed. 
        if ( !allChannels && ( getRootTableItem()->child( r )->getChannelId() != channelId ) )
        {
            continue;
        }
        // ChannelId is ignored now.
        if ( inverse )
        {
            if ( !( this->*f )( r ) )
            {
                selectedRows.append( r );
            }
        }
        else
        {
            if ( ( this->*f )( r ) )
            {
                selectedRows.append( r );
            }
        }
    }
    return selectedRows;
}

// Retrieve list of most recent entries i.e. entries with ValidityKeyMax in the 'Until' field.
QList< int > FolderTableModel::filter_mres( bool inverse )
{
    return filter( &FolderTableModel::filter_mre, inverse );
}

// Filter for most recent entries i.e. entries with 'Until' set to cool::ValidityKeyMax
bool FolderTableModel::filter_mre( int row )
{
    return cool::ValidityKeyMax - getRootTableItem()->child( row )->data( 2 ).toLongLong() == 0;
}

// Special function to get *last but one* recent entry to be used in _updateValidityKeys()
int FolderTableModel::filter_mre_singleChannel( int row )
{
    QList< int > filterResult( filter( &FolderTableModel::filter_mre, false, false, row ) ) ;
    if ( filterResult.count() > 1 )
    {
        // Note: function returns last but one recent entry.
        if (  getRootTableItem()->child( filterResult.at( 0 ) )->data( 1 ).toLongLong()  >  getRootTableItem()->child( filterResult.at( 1 ) )->data( 1 ).toLongLong() )
            return filterResult.at( 1 );
        else
            return filterResult.at( 0 );
    }
    else
        return filterResult.at( 0 );
}

// Update the 'Until' ValidityKey of the old channels that have been cloned and committed.
// Should be executed by commit() and not directly.
// Note that _updateValidityKeys() implemented as a 'pass-thru' function so that 
// rootTableItem->newItems() executes only once in the commit() function.
QList< FolderTableItem* > FolderTableModel::_updateValidityKeys( QList< FolderTableItem* > newTableItems )
{
    foreach ( FolderTableItem* tableItem, newTableItems )
    {
        FolderTableItem* sourceItem( tableItem->getClonedSourceItem() );
        if ( !sourceItem ) // item is a new channel and not a cloned channel
            continue;

        if ( sourceItem->getChannelId() == tableItem->getChannelId() )
        {
            // Check if the cloned entry was also the most recent entry. This will reduces the 
            // need to search for the most recent entry of the particular channel.
            if ( cool::ValidityKeyMax - sourceItem->data( 2 ).toLongLong() == 0 )
            {
                setData( index( sourceItem->row(), 2 ), tableItem->data( 1 ) );
            }
            else // Cloned entry not most recent. Search for most recent entry of the channel.
            {
                setData( index( filter_mre_singleChannel( sourceItem->row() ), 2 ), tableItem->data( 1 ) );
            }
        }
        else // search for the first row with the modified channel id.
        {
            int modifiedChannelRow = getRootTableItem()->find( tableItem->getChannelId() );
            if ( modifiedChannelRow != tableItem->row() ) // new channel is the only one.
            {
                setData( index( filter_mre_singleChannel( modifiedChannelRow ), 2 ), tableItem->data( 1 ) );
            }
        }
    }
    return newTableItems;
}

bool FolderTableModel::commit()
{
    int totalColumns( rootTableItem->columnCount() );
    QVariant commitTime = QVariant( (qulonglong)( QDateTime::currentDateTime().toTime_t() ) * (qulonglong)( 1000000000 ) );
    QList< FolderTableItem* > newItems = rootTableItem->newItems();
    try
    {
        coolFolderPtr->setupStorageBuffer( true );
        foreach ( FolderTableItem* newItem, newItems )
        {
            cool::Record payload = cool::Record( payloadSpec );
            cool::ChannelId cId( newItem->getChannelId() );
            for ( int i = 3; i < totalColumns; i++ )
            {
                QPair< QString, QVariant > valueTypePair = rootTableItem->headerType( i );
                std::string coolType = valueTypePair.first.toStdString();
                std::string headerName = rootTableItem->header( i ).toStdString();
                if ( coolType == "Bool" )
                {
                    payload[ headerName ].setValue<cool::Bool>( newItem->data( i ).value<bool>() );
                    continue;
                }
                else if ( coolType == "UChar" )
                {
                    payload[ headerName ].setValue<cool::UChar>( newItem->data( i ).toInt() ); // more convenient to use int.
                    continue;
                }
                else if ( coolType == "Int16" )
                {
                    payload[ headerName ].setValue<cool::Int16>( newItem->data( i ).value<short>() );
                    continue;
                }
                else if ( coolType == "UInt16" )
                {
                    payload[ headerName ].setValue<cool::UInt16>( newItem->data( i ).value<unsigned short>() );
                    continue;
                }
                else if ( coolType == "Int32" )
                {
                    payload[ headerName ].setValue<cool::Int32>( newItem->data( i ).value<int>() );
                    continue;
                }
                else if ( coolType == "UInt32" )
                {
                    payload[ headerName ].setValue<cool::UInt32>( newItem->data( i ).value<unsigned int>() );
                    continue;
                }
                else if ( coolType == "UInt63" )
                {
                    payload[ headerName ].setValue<cool::UInt63>( newItem->data( i ).value<unsigned long long>() );
                    continue;
                }
                else if ( coolType == "Int64" )
                {
                    payload[ headerName ].setValue<cool::Int64>( newItem->data( i ).value<long long>() );
                    continue;
                }
                else if ( coolType == "Float" )
                {
                    payload[ headerName ].setValue<cool::Float>( newItem->data( i ).value<float>() );
                    continue;
                }
                else if ( coolType == "Double" )
                {
                    payload[ headerName ].setValue<cool::Double>( newItem->data( i ).value<double>() );
                    continue;
                }
                else if ( coolType == "String255" )
                {
                    payload[ headerName ].setValue<cool::String255>( newItem->data( i ).toString().toStdString() );
                    continue;
                }
                else if ( coolType == "String4k" )
                {
                    payload[ headerName ].setValue<cool::String4k>( newItem->data( i ).toString().toStdString() );
                    continue;
                }
                else if ( coolType == "String64k" )
                {
                    payload[ headerName ].setValue<cool::String64k>( newItem->data( i ).toString().toStdString() );
                    continue;
                }
                else if ( coolType == "String16M" )
                {
                    payload[ headerName ].setValue<cool::String16M>( newItem->data( i ).toString().toStdString() );
                    continue;
                }
                else if ( coolType == "Blob64k" )
                {
                    QByteArray ba = newItem->data( i ).value<QByteArray>();
                    int blobSize = ( int ) ba.size();
                    const char* rawdata = ba.constData();
                    cool::Blob64k blob;
                    blob.resize( blobSize );
                    char* p = static_cast<char*>( blob.startingAddress() );
                    for ( int j = 0; j < blobSize; ++j, ++p, ++rawdata ) *p = *rawdata;
                    payload[ headerName ].setValue<cool::Blob64k>( blob );
                    continue;
                }
                else if ( coolType == "Blob16M" )
                {
                    QByteArray ba = newItem->data( i ).value<QByteArray>();
                    int blobSize = ( int ) ba.size();
                    const char* rawdata = ba.constData();
                    cool::Blob16M blob;
                    blob.resize( blobSize );
                    char* p = static_cast<char*>( blob.startingAddress() );
                    for ( int j = 0; j < blobSize; ++j, ++p, ++rawdata ) *p = *rawdata;
                    payload[ headerName ].setValue<cool::Blob16M>( blob );
                    continue;
                }
                else
                    qWarning() << "COOL type" << valueTypePair.first << "not recognised. Skipping.";
            }
            newItem->setData( commitTime, 1 ); // Reset insertion time to commit time.
            coolFolderPtr->storeObject( cool::ValidityKey( newItem->data( 1 ).toLongLong() ), cool::ValidityKey( newItem->data( 2 ).toLongLong() ), payload, cId );
        }
        coolFolderPtr->flushStorageBuffer();
        // Cloned channels (i.e. the old channels) will have had their 'Until' ValidityKeys
        // changed upon committing the newly created channels. Need to perform the update
        // before these new items are set to old.
        // The update is is done through the _updateValidityKeys() function.
        foreach ( FolderTableItem* newItem, _updateValidityKeys( newItems ) )
        {
            newItem->setOld();
        }
    }
    catch ( cool::Exception& e )
    {
        qCritical() << "COOL Exception: Error storing object. " << e.what();
        return false;
    }
    catch ( coral::Exception& e )
    {
        qCritical() << "CORAL Exception: Error storing object. " << e.what();
        return false;
    }
    reset();  // update the 'Until' values of affected entries.
    emit modelChanged( this, false );

    return true;
}

bool FolderTableModel::isNewRow( int row ) const
{
    FolderTableItem* item = rootTableItem->child( row );
    if ( item )
        return item->isNew();
    else
        return false;
}

QSet< unsigned int > FolderTableModel::newRowChannelIds( QList< FolderTableItem* > newTableItems ) const
{
    QSet< unsigned int > channelIds;
    if ( newTableItems.isEmpty() )
    {
        newTableItems = rootTableItem->newItems();
    }
    foreach ( FolderTableItem* item, newTableItems )
    {
        channelIds.insert( item->getChannelId() );
    }
    return channelIds;
}

void FolderTableModel::setData( const QModelIndexList& indexList, const QVariant& value, int role )
{
    QModelIndex index;
    foreach ( index, indexList )
    {
        if ( flags( index ) & Qt::ItemIsEditable )
        {
            setData( index, value, role );
        }
    }
}

bool FolderTableModel::setData( const QModelIndex& index, const QVariant& value, int role )
{
    bool ok( false );
    if ( index.isValid() && role == Qt::EditRole )
    {
        // If mask is enabled for the particular column, It is assumed that
        // the user has entered the new value with the particular mask in mind.
        // ACE will need to convert it back to an integer for storage in COOL.
        FolderTableItem* currentItem = static_cast<FolderTableItem*>( index.internalPointer() );
        int column = index.column();
        DisplayAsMask currentMask = getDisplayAsMask( column );
        QVariant newQVariant;

        switch ( currentMask )
        {
            case octMask:
                if ( value.canConvert( QVariant::String ) )
                {
                    newQVariant = qStringToQVariant( value.toString(), &ok, column, 8 );
                }
                if ( ok )
                {
                    currentItem->setData( newQVariant, column );
                }
                else
                {
                    qWarning() << "Error storing octal value: " << value;
                    return false;
                }
                break;
                
            case decMask:
                if ( value.canConvert( QVariant::String ) )
                {
                    newQVariant = qStringToQVariant( value.toString(), &ok, column, 10 );
                }
                if ( ok )
                {
                    currentItem->setData( newQVariant, column );
                }
                else
                {
                    qWarning() << "Error storing decimal value:" << value;
                    return false;
                }
                break;
                
            case hexMask:
                if ( value.canConvert( QVariant::String ) )
                {
                    newQVariant = qStringToQVariant( value.toString(), &ok, column, 16 );
                }
                if ( ok )
                {
                    currentItem->setData( newQVariant, column );
                }
                else
                {
                    qWarning() << "Error storing hexadecimal value: " << value;
                    return false;
                }
                break;
            
            case blobMask:
                if ( value.canConvert( QVariant::ByteArray ) )
                {
                    currentItem->setData( value, column );
                }
                else
                {
                    qWarning() << "Error storing blob.";
                    return false;
                }
                break;

            case clobMask:
                if ( value.canConvert( QVariant::String ) )
                {
                    currentItem->setData( value, column );
                }
                else
                {
                    qWarning() << "Error storing clob.";
                    return false;
                }
                break;

            case IOV_time_Mask: // no special treatment (for now).
            case IOV_runLB_Mask:
            case IOV_runEvt_Mask:
            case IOV_generic_Mask:
            case noMask:
                if ( value.canConvert( QVariant::String ) )
                {
                    newQVariant = qStringToQVariant( value.toString(), &ok, column, 10 );
                }
                if ( ok )
                {
                    currentItem->setData( newQVariant, column );
                }
                else
                {
                    qWarning() << "Invalid value detected: " << value;
                    return false;
                }
				break;
        }
        if ( ok )
        {
            emit dataChanged( index, index );
        }
    }
    return ok;
}

QVariant FolderTableModel::getMaskedData( FolderTableItem*& item, int column ) const
{
    QSettings settings;
    DisplayAsMask currentMask = getDisplayAsMask( column );
    QVariant currentValue( item->data( column ) );
    bool ok( false );
    
    switch ( currentMask )
    {
        case octMask:
            currentValue = applyMaskToQVariant( QString( "%L1" ), currentValue, column, &ok, 0, 8 );
            break;

        case decMask:
            currentValue = applyMaskToQVariant( QString( "%L1" ), currentValue, column, &ok, 0, 10 );
            break;

        case hexMask:
            currentValue = applyMaskToQVariant( QString( "%L1" ), currentValue, column, &ok, 0, 16 );
            break;

        case IOV_time_Mask:
            if ( currentValue.canConvert( QVariant::ULongLong ) )
            {
                if ( cool::ValidityKeyMax-currentValue.toLongLong() == 0 )
                {
                    currentValue = QVariant( "ValidityKeyMax" );
                }
                else
                {
                    currentValue = QVariant( QDateTime::fromTime_t( currentValue.toString().left(10).toUInt() ).toString( Qt::ISODate ) );
                }
            }
            break;

        case IOV_runLB_Mask:
        case IOV_runEvt_Mask:
        case IOV_generic_Mask:
            if ( currentValue.canConvert( QVariant::ULongLong ) )
            {
                //currentValue = QVariant( "VKEncoding" );
                //qDebug() << "VEncoding (63 bits) = " << currentValue;
                qulonglong highBits = currentValue.toULongLong();
                qulonglong lowBits = currentValue.toULongLong();
                highBits >>= 32;
                lowBits <<= 32;
                lowBits >>= 32;
                currentValue = QVariant( QVariant( highBits ).toString() + " | " + QVariant( lowBits ).toString() );
            }
            break;

        case blobMask:
            currentValue = QVariant( "Blob" );
            break;

        case clobMask:
            currentValue = QVariant( "Clob" );
            break;

        case noMask:
            break;
    }
    return currentValue;
}

/*
Mask is applied here for retrieval of data for display in table.
*/
QVariant FolderTableModel::data( const QModelIndex& index, int role ) const
{
    if ( !index.isValid() )
        return QVariant();
    FolderTableItem* item = static_cast<FolderTableItem*>( index.internalPointer() );
    
    if ( role == Qt::DisplayRole )
    {
        return getMaskedData( item, index.column() );
    }
    else if ( role == Qt::BackgroundRole )
    {
        if ( item->isNew() )
        {
            return QVariant( QColor( newRowColour ) );
        }

        if ( isFiltered() )
        {
            return QVariant( QColor( filteredColour ) );
        }
    }
    else if ( role == Qt::ForegroundRole )
    {
        if ( hasMask( index.column() ) )
        {
            return QVariant( QColor( maskColour ) );
        }
    }
    else if ( role == Qt::ToolTipRole )
    {
        return QVariant( getCoolTypeString( index ) );
    }
    return QVariant();
}

QVariant FolderTableModel::rawData( const QModelIndex& index ) const
{
    FolderTableItem* item = static_cast<FolderTableItem*>( index.internalPointer() );
    return item->data( index.column() );
}

DisplayAsMask FolderTableModel::getDisplayAsMask( int column ) const
{
    return displayAsMaskHash.value( column, noMask );
}

ColumnResponse FolderTableModel::getColumnResponse( int column ) const
{
    return columnResponseHash.value( column, noResponse );
}


bool FolderTableModel::hasMask( int column ) const
{
    return displayAsMaskHash.contains( column );
}

void FolderTableModel::setDisplayAsMask( const QModelIndex& index, DisplayAsMask dMask )
{
    if ( !index.isValid() )
    {
        return;
    }
    int column = index.column();
    if ( column < rootTableItem->columnCount() )
    {
        if ( dMask == noMask )
        {
            displayAsMaskHash.remove( column );
        }
        else
        {
            displayAsMaskHash[ column ] = dMask;
        }
        emit dataChanged( index.sibling( 0, column ), index.sibling( rootTableItem->childCount() - 1, column ) );
    }
    else
    {
        qWarning() << "Column" << column << "does not exist!";
    }
}

bool FolderTableModel::canSetDisplayAsMask( const QModelIndex& index ) const
{
    // *** TO DO ***
    // More checks to come.
    return index.isValid();
}

bool FolderTableModel::canSetDisplayAsMask( const QModelIndexList& indexList ) const
{
    foreach ( QModelIndex index, indexList )
    {
        if ( canSetDisplayAsMask( index ) )
            return true;
    }
    return false;
}

QVariant FolderTableModel::qStringToQVariant( QString value, bool* ok, int column, int base )
{
    QString testValue;
    switch ( getQVariantType( column ) )
    {
        case QVariant::Bool:
            *ok = true;
            testValue = value.simplified().toLower();
            if ( testValue == "false" || testValue == "0" || testValue.isEmpty() || testValue.isNull() )
            {
                return QVariant( false );
            }
            return QVariant( true );
         case QVariant::Char:
            return QVariant( QChar( value.toInt( ok, base ) ) );
         case QVariant::Int:
            return QVariant( value.toInt( ok, base ) );
         case QVariant::UInt: 
            return QVariant( value.toUInt( ok, base ) );
         case QVariant::LongLong:
            return QVariant( value.toLongLong( ok, base ) );
         case QVariant::ULongLong:
            return QVariant( value.toULongLong( ok, base ) );
         case QVariant::Double:
            return QVariant( value.toDouble( ok ) );
         case QVariant::String:
            *ok = true;
            return QVariant( value );
         case QVariant::ByteArray:
            *ok = true;
            return QVariant( value.toAscii() );
         default:
            *ok = false;
            qDebug() << "Unknown type --- returning QVariant()";
            return QVariant();
    }
}

// format conversion - 
QVariant FolderTableModel::applyMaskToQVariant( QString format, QVariant currentValue, int column, bool* ok, int fieldWidth, int base, const QChar& fillChar ) const
{
    switch ( getQVariantType( column ) )
    {
        case QVariant::Bool:
            *ok = true;
            return QVariant( currentValue.toBool() );
            break;
        case QVariant::Char:
            return QVariant( format.arg( currentValue.toInt( ok ), fieldWidth, base, fillChar ) );
            break;
        case QVariant::Int:
            return QVariant( format.arg( currentValue.toInt( ok ), fieldWidth, base, fillChar ).toUpper() );
            break;
        case QVariant::UInt:
            return QVariant( format.arg( currentValue.toUInt( ok ), fieldWidth, base, fillChar ).toUpper() );
            break;
        case QVariant::LongLong:
            return QVariant( format.arg( currentValue.toLongLong( ok ), fieldWidth, base, fillChar ).toUpper() );
            break;
        case QVariant::ULongLong:
            return QVariant( format.arg( currentValue.toULongLong( ok ), fieldWidth, base, fillChar ).toUpper() );
            break;
        case QVariant::Double:
            return QVariant( format.arg( currentValue.toDouble( ok ), fieldWidth, 'g', -1, fillChar ).toUpper() );
            break;
        case QVariant::String:
        default:
            *ok = true;
            return currentValue;
            break;
    }
}

QString FolderTableModel::getInputMask( const QModelIndex& /*index*/ ) const
{
    return "";
}

QValidator* FolderTableModel::getValidator( const QModelIndex& index ) const
{
    return getValidator( index.column() );
}

QValidator* FolderTableModel::getValidator( unsigned int column ) const
{
    DisplayAsMask currentMask = getDisplayAsMask( column );
    QRegExp rx;
    std::string cooltype;

    switch ( currentMask )
    {
        case octMask:
            rx.setPattern( "[0-7]+" );
            return new QRegExpValidator( rx, 0 );
            break;
            
        case decMask:
            if ( getQVariantType( column ) == QVariant::Char )
            {
                QIntValidator* iv = new QIntValidator( 0 );
                iv->setRange( 0, 255 );
                return iv;
            }
            else
                return new QIntValidator( 0 );
            break;
            
        case hexMask:
            rx.setPattern( "[0-9a-fA-F]+" );
            return new QRegExpValidator( rx, 0 );
            break;

        case IOV_time_Mask:
        case IOV_runLB_Mask:
        case IOV_runEvt_Mask:
        case IOV_generic_Mask:
        case blobMask:
        case clobMask:
            return 0;
            break;
        
        case noMask:
            // Validator will have to rely on currentType
            switch ( getQVariantType( column ) )
            {
                case QVariant::Char: // COOL only has UChar so the validator should only 
                    return new QIntValidator( 0, 255, 0 );
                    break;
                case QVariant::Int:
                    cooltype = rootTableItem->headerType( column ).first.toStdString();
                    if ( cooltype == "Int16" )
                        return new QIntValidator( cool::Int16Min, cool::Int16Max, 0 );
                    else // Int32
                        return new QIntValidator( cool::Int32Min, cool::Int32Max, 0 );
                    break;
                case QVariant::UInt:
                    cooltype = rootTableItem->headerType( column ).first.toStdString();
                    if ( cooltype == "UInt16" )
                        return new QIntValidator( cool::UInt16Min, cool::UInt16Max, 0 );
                    else // UInt32
                    {
                        QDoubleValidator* dValidator = new QDoubleValidator( cool::UInt32Min, cool::UInt32Max, 0, 0 );
                        dValidator->setNotation( QDoubleValidator::StandardNotation );
                        return dValidator;
                    }
                    break;
                case QVariant::Double:
                    return new QDoubleValidator( 0 );
                    break;
                case QVariant::LongLong:
                    rx.setPattern( "-?\\d+" );
                    return new QRegExpValidator( rx, 0 );
                    break;
                case QVariant::ULongLong:
                    rx.setPattern( "\\d+" );
                    return new QRegExpValidator( rx, 0 );
                    break;
                case QVariant::String:
                default:
                    return 0;
                    break;            
            }
            break;
    }
    return 0;
}

void FolderTableModel::sort( int column, Qt::SortOrder order = Qt::AscendingOrder )
{
    emit layoutAboutToBeChanged();
    rootTableItem->sort( column, order );
    emit layoutChanged();
}

int FolderTableModel::compare( const QModelIndex& index, QString value )
{
    bool ok( true );
    int base;
    int column = index.column();
    QVariant valueAsQVariant( value );
    QVariant valueAtIndex;
    switch ( getDisplayAsMask( column ) )
    {
        case blobMask:
            // comparison not possible.
            return 0;
            break;

        case octMask:
            base = 8;
            break;
            
        case hexMask:
            base = 16;
            break;

        case clobMask:
        case decMask:
        default:
            base = 10;
            break;
    }

    valueAsQVariant = qStringToQVariant( value, &ok, column, base );
    // Retrieve the raw data at the particular table index.
    valueAtIndex = rawData( index );

    // Compare QVariants
    if ( ok )
    {
        return compareQVariants( valueAtIndex, valueAsQVariant );
    }
    qDebug() << "Comparison failed. Could not convert "<< value << " to a QVariant.\nTreating as strings instead.";
    return QString::localeAwareCompare( valueAtIndex.toString(), value );
}

int FolderTableModel::compareQVariants( QVariant a, QVariant b )
{
    QVariant::Type typeA = a.type();
    double dTest = 0.0;
    
    if ( typeA != b.type() )
    {
        // Force comparision of a and b as strings.
        qDebug() << "Types do not match. Treating as strings instead.";
        typeA = QVariant::String;
    }
    
    switch ( typeA )
    {
        case QVariant::Bool:
            return a.toBool() - b.toBool();
            break;
        case QVariant::Char:
        case QVariant::Int:
            return a.toInt() - b.toInt();
            break;
        case QVariant::LongLong:
            return a.toLongLong() - b.toLongLong();
            break;
        case QVariant::UInt:
            return a.toUInt() - b.toUInt();
            break;
        case QVariant::ULongLong:
            return a.toULongLong() - b.toULongLong();
            break;
        case QVariant::Double:
            dTest = a.toDouble() - b.toDouble();
            if ( dTest == 0.0 )
                return 0;
            else if ( dTest > 0.0 )
                return 1;
            else
                return  -1;
            break;
        case QVariant::String:
            return QString::localeAwareCompare( a.toString(), b.toString() );
            break;
        case QVariant::ByteArray: // meaningless to compare binary data.
        default:
            return 0;
            break;
    }
}

void FolderTableModel::setFiltered( bool enabled )
{
    filtered = enabled;
}

bool FolderTableModel::isFiltered() const
{
    return filtered;
}


/*
// Optimisation methods
bool FolderTableModel::hasChildren( const QModelIndex& parent ) const;

bool FolderTableModel::canFetchMore( const QModelIndex& parent ) const;

void FolderTableModel::fetchMore( const QModelIndex& parent );
*/
/*
// Optional methods
QModelIndex FolderTableModel::buddy( const QModelIndex& index ) const;

bool FolderTableModel::dropMimeData( const QMimeData* data, Qt::DropAction action, int row, int column, const QModelIndex& parent );

Qt::DropActions supportedDropActions() const;
*/
/*
// Not implemented as columns are not designed to be removed.
bool FolderTableModel::removeColumns( int column, int count, const QModelIndex& parent );
bool FolderTableModel::insertColumns( int column, int count, const QModelIndex& parent );
*/

