#include <QtCore/QtDebug>
#include <QtCore/QList>

#include "ACE/foldertreeitem.h"

FolderTreeItem::FolderTreeItem( QList<QVariant>& data, FolderTreeItem* parent )
{
    parentTreeItem = parent;
    treeItemData = data;
}

FolderTreeItem::~FolderTreeItem()
{
    qDeleteAll( childTreeItems );
}

void FolderTreeItem::appendChild( FolderTreeItem* item )
{
    childTreeItems.append(item);
}

void FolderTreeItem::insertChild( FolderTreeItem* item, int row )
{
    childTreeItems.insert( row, item );
}

void FolderTreeItem::removeChildAt( int row )
{
    childTreeItems.removeAt( row );
}

FolderTreeItem* FolderTreeItem::child( int row )
{
    return childTreeItems.value( row );
}

int FolderTreeItem::childCount() const
{
    return childTreeItems.count();
}

int FolderTreeItem::columnCount() const
{
    return treeItemData.count();
}

QVariant FolderTreeItem::data( int column ) const
{
    return treeItemData.value( column );
}

bool FolderTreeItem::setData( const QVariant& data, int column )
{
    treeItemData.replace( column, data );
    return true;
}

FolderTreeItem* FolderTreeItem::parent()
{
    return parentTreeItem;
}

int FolderTreeItem::row() const
{
    if ( parentTreeItem )
        return parentTreeItem->childTreeItems.indexOf( const_cast<FolderTreeItem*>( this ) );

    return 0;
}

int FolderTreeItem::pos( QString& subFolder ) const
{
    int fPos( -1 );
    foreach ( FolderTreeItem* childTreeItem, childTreeItems )
    {
        if ( childTreeItem->treeItemData[ 0 ] == subFolder )
            return ++fPos;
        ++fPos;
    }
    return -1;
}
