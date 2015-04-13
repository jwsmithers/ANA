#ifndef FOLDERTREEITEM_H
#define FOLDERTREEITEM_H

#include <QtCore/QList>
#include <QtCore/QVariant>

class FolderTreeItem
{

public:
    FolderTreeItem( QList<QVariant>& data, FolderTreeItem* parent = 0 );
    ~FolderTreeItem();

    void appendChild( FolderTreeItem* child );
    void insertChild( FolderTreeItem* child, int row = 0 );
    void removeChildAt( int row );

    FolderTreeItem* child( int row );
    int childCount() const;
    int columnCount() const;
    QVariant data( int column = 0 ) const;
    bool setData( const QVariant& data, int column = 0 );
    int row() const;
    FolderTreeItem* parent();
    int pos( QString& subFolder ) const;

private:
    QList<FolderTreeItem*> childTreeItems;
    QList<QVariant> treeItemData;
    FolderTreeItem* parentTreeItem;
};

#endif
