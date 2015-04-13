#include <QtCore/QAbstractItemModel>
#include <QtCore/QString>
#include <QtCore/QStringList>
#include <QtCore/QtDebug>
#include <QtCore/QSettings>

#include <iostream>

#include "ACE/foldertreeitem.h"
#include "ACE/foldertreemodel.h"


FolderTreeModel::FolderTreeModel( cool::IDatabasePtr dbPtr, const QString connectionString, QObject* parent ) :
    QAbstractItemModel( parent ),
    coolConnectionString( connectionString ), 
    coolDBPtr( dbPtr )
{
    QSettings settings;
    std::vector< std::string > nodeList( coolDBPtr->listAllNodes() );
    setupFolderTreeModelData( nodeList );
    settings.beginGroup( "Preferences/FolderTrees" );
    modifiedColour = static_cast<Qt::GlobalColor>( settings.value( "ModifiedColour", static_cast<int>( Qt::cyan ) ).toInt() );
    settings.endGroup(); // Preferences/FolderTrees
}

FolderTreeModel::~FolderTreeModel()
{
    delete rootTreeItem;
}

int FolderTreeModel::columnCount( const QModelIndex& parent ) const
{
    if ( parent.isValid() )
        return static_cast<FolderTreeItem*>( parent.internalPointer() )->columnCount();
    else
        return rootTreeItem->columnCount();
}

QVariant FolderTreeModel::data( const QModelIndex& index, int role ) const
{
    if ( !index.isValid() )
        return QVariant();

    FolderTreeItem *item = static_cast<FolderTreeItem*>( index.internalPointer() );

    if ( role == Qt::DisplayRole )
    {    
        return item->data( index.column() );
    }
    else if ( role == Qt::BackgroundRole )
    {
        if ( modifiedFolders.contains( index ) )
        {
            return QVariant( modifiedColour );
        }
//        else
//        {
//            return QVariant( qApp.palette().color( QPalette::Base ) );
//        }
    }
//    else if ( role == Qt::ToolTipRole )
//    {
//        return QVariant( getCoolTypeString( index ) );
//    }
    return QVariant();
}

QString FolderTreeModel::folderName( const QModelIndex& index ) const
{
    QStringList tNames;
    QModelIndex tIndex( index );
    while ( tIndex.isValid() )
    {  
        const QString tName( data( tIndex ).toString() );
        tNames.prepend( tName );
        tIndex = parent( tIndex );
    }
    return QString("/").append( tNames.join( "/" ) );
}

cool::IDatabasePtr FolderTreeModel::getCoolDBPtr() const
{
    return coolDBPtr;
}

bool FolderTreeModel::isModified() const
{
    return !modifiedFolders.isEmpty();
}

QSet< QModelIndex > FolderTreeModel::getModifiedFolders() const
{
    return modifiedFolders;
}

void FolderTreeModel::setModifiedFolders( const QModelIndex& index, const bool modified )
{
    if ( modified )
    {
        modifiedFolders.insert( index );
    }
    else
    {
        modifiedFolders.remove( index );
    }
}

Qt::ItemFlags FolderTreeModel::flags( const QModelIndex& index ) const
{
    if ( !index.isValid() )
        return 0;

    return Qt::ItemIsEnabled | Qt::ItemIsSelectable;
}

QVariant FolderTreeModel::headerData( int section, Qt::Orientation orientation, int role ) const
{
    if ( orientation == Qt::Horizontal && role == Qt::DisplayRole )
        return rootTreeItem->data( section );

    return QVariant();
}

QModelIndex FolderTreeModel::index( int row, int column, const QModelIndex& parent) const
{
    if ( !hasIndex( row, column, parent ) )
        return QModelIndex();

    FolderTreeItem* parentItem;

    if ( !parent.isValid() )
        parentItem = rootTreeItem;
    else
        parentItem = static_cast<FolderTreeItem*>( parent.internalPointer() );

    FolderTreeItem* childItem = parentItem->child( row );
    if ( childItem )
        return createIndex( row, column, childItem );
    else
        return QModelIndex();
}

QModelIndex FolderTreeModel::index( const QString& fullFolderName) const
{
    QStringList parsedFolderName = fullFolderName.split( "/", QString::SkipEmptyParts );
    FolderTreeItem* currentTreeItem = rootTreeItem;
    int entryPos( -1 );

    foreach( QString parsedFolderNameToken, parsedFolderName )
    {
        entryPos = currentTreeItem->pos( parsedFolderNameToken );
        if ( entryPos < 0 ) {
            qWarning() << "[FolderTreeModel::index()]" << parsedFolderNameToken << "folder not found (" << parsedFolderName << ").";
            return QModelIndex();
        }
        currentTreeItem = currentTreeItem->child( entryPos );
        qDebug() << "currentTreeItem's data is" << currentTreeItem->data() << ".";
    }
    qDebug() << "Creating index for entryPos=" << entryPos << "of" << currentTreeItem->parent()->data() << ".";
    return createIndex( entryPos, 0, currentTreeItem );
}

QModelIndex FolderTreeModel::parent( const QModelIndex& index ) const
{
    if ( !index.isValid() )
        return QModelIndex();

    FolderTreeItem* childItem = static_cast<FolderTreeItem*>( index.internalPointer() );
    FolderTreeItem* parentItem = childItem->parent();

    if ( parentItem == rootTreeItem )
        return QModelIndex();

    return createIndex( parentItem->row(), 0, parentItem );
}

int FolderTreeModel::rowCount( const QModelIndex& parent ) const
{
    FolderTreeItem* parentItem;
    if ( parent.column() > 0 )
        return 0;

    if ( !parent.isValid() )
        parentItem = rootTreeItem;
    else
        parentItem = static_cast<FolderTreeItem*>( parent.internalPointer() );

    return parentItem->childCount();
}

void FolderTreeModel::setupFolderTreeModelData( std::vector< std::string >& nodeList )
{
    std::vector<std::string>::iterator nodeList_i;
    
    // Create the rootTreeItem
    QList<QVariant> rootData;  // Using QList to allow for future expansion.
    rootData << "Folders";
//    qDebug() << "[FolderTreeModel] Added 'Folders' as the header.";
    rootTreeItem = new FolderTreeItem( rootData );

    for ( nodeList_i = nodeList.begin(); nodeList_i != nodeList.end(); nodeList_i++ )
    {
        QString node = QString::fromStdString( *nodeList_i );
        QStringList parsedNode = node.split( "/", QString::SkipEmptyParts );
        
        FolderTreeItem* currentTreeItem = rootTreeItem;
        foreach ( QString parsedNode_Entry, parsedNode ) 
        {
            int entryPos = currentTreeItem->pos( parsedNode_Entry );
            if ( entryPos < 0 )
            {
                QList<QVariant> entryData;
                entryData << parsedNode_Entry;
//                qDebug() << "[FolderTreeModel] Added" << parsedNode_Entry << "to the tree data structure.";
                FolderTreeItem* newTreeItem = new FolderTreeItem( entryData, currentTreeItem );
                currentTreeItem->appendChild( newTreeItem );
                currentTreeItem = newTreeItem;
            }
            else
            {
//                qDebug() << "[FolderTreeModel] Using existing" << parsedNode_Entry << "entry in tree data structure.";
                currentTreeItem = currentTreeItem->child( entryPos );
            }
        }
    }
}

bool FolderTreeModel::setData( const QModelIndex& index, const QVariant& value, int role )
{
    if ( index.isValid() && role == Qt::EditRole )
    {
        FolderTreeItem* currentItem = static_cast<FolderTreeItem*>( index.internalPointer() );
        currentItem->setData( value );
        emit dataChanged( index, index );
        return true;
    }
    return false;
}

void FolderTreeModel::emitDataChanged( const QModelIndex& index, const bool changed )
{
    setModifiedFolders( index, changed );
    emit dataChanged( index, index );
}

bool FolderTreeModel::setHeaderData( int /*section*/, Qt::Orientation /*orientation*/, const QVariant& /*value*/, int /*role*/ )
{
//    if ( orientation == Qt::Horizontal && role == Qt::EditRole )
//        return rootTreeItem->setData( value, section );

    // Table header should not be modifiable
    return false;
}

bool FolderTreeModel::removeRows( int row, int count, const QModelIndex& parent )
{
    if ( count < 1 || row < 0 )
    {
        qWarning() << "Either count < 1 or row < 0";
        return false;
    }
    FolderTreeItem* parentItem;
    if ( !parent.isValid() )
        parentItem = rootTreeItem;
    else
        parentItem = static_cast<FolderTreeItem*>( parent.internalPointer() );
    
    beginRemoveRows( parent, row, row + count - 1 );
    while ( count-- )
    {
        delete parentItem->child( row );
        parentItem->removeChildAt( row );
    }
    endRemoveRows();
    return true;
}

bool FolderTreeModel::insertRows( int row, int count, const QModelIndex& parent )
{
    if ( count < 1 || row < 0 )
    {
        qWarning() << "Either count < 1 or row < 0";
        return false;
    }
    FolderTreeItem* parentItem;
    if ( !parent.isValid() )
        parentItem = rootTreeItem;
    else
        parentItem = static_cast<FolderTreeItem*>( parent.internalPointer() );

    beginInsertRows( parent, row, row + count - 1 );
    while ( count-- )
    {
        QList<QVariant> entryData;
        entryData << "newfolder";
        qDebug() << "[FolderTreeModel::insertRows] Adding new folder to the" << parentItem->data(0) << "parent folder.";
        FolderTreeItem* newTreeItem = new FolderTreeItem( entryData, parentItem );
        parentItem->insertChild( newTreeItem, row );
    }
    endInsertRows();
    return true;
}

/*
// Optimisation methods
bool FolderTreeModel::hasChildren( const QModelIndex& parent ) const;

bool FolderTreeModel::canFetchMore( const QModelIndex& parent ) const;

void FolderTreeModel::fetchMore( const QModelIndex& parent );
*/
/*
// Optional methods
QModelIndex FolderTreeModel::buddy( const QModelIndex& index ) const;

bool FolderTreeModel::dropMimeData( const QMimeData* data, Qt::DropAction action, int row, int column, const QModelIndex& parent );

Qt::DropActions supportedDropActions() const;
*/
/*
// Not implemented as columns are not designed to be removed.
bool FolderTreeModel::removeColumns( int column, int count, const QModelIndex& parent );
bool FolderTreeModel::insertColumns( int column, int count, const QModelIndex& parent );
*/

