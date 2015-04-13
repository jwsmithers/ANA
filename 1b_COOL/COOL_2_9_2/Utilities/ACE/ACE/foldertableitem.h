#ifndef FOLDERTABLEITEM_H
#define FOLDERTABLEITEM_H

#include <QtCore/QList>
#include <QtCore/QMap>
#include <QtCore/QVariant>
#include <QtCore/QPair>
#include <QtCore/QSettings>


class RootFolderTableItem;


class FolderTableItem
{
    friend class RootFolderTableItem;
    
public:
    FolderTableItem( const QList<QVariant>& data, RootFolderTableItem* parent, bool newItem = false );
    ~FolderTableItem() {};
    void setClonedSourceItem( FolderTableItem* newClonedSourceItem );
    FolderTableItem* getClonedSourceItem();
    int columnCount() const;
    QVariant data( int column ) const;
    QList<QVariant> data() const;
    void setData( const QVariant& data, int column = 0 );
    int row() const;
    RootFolderTableItem* parent();
    bool isNew() const;
    bool isHidden() const;
    void setHidden( bool enabled = true );
    unsigned getChannelId() const;
    void setOld();

protected:
    QList<QVariant> tableItemData;
    RootFolderTableItem* rootTableItem;
    FolderTableItem* clonedSourceItem;
    bool hidden;
    bool newItem;
};


class RootFolderTableItem
{
    friend class FolderTableItem;

public:
    RootFolderTableItem( const QList<QString>& headerNames, const QList< QPair< QString, QVariant > >& headerTypes );
    ~RootFolderTableItem();

    QList<FolderTableItem*> getChildren() const;
    void appendChild( FolderTableItem* child );
    void insertChild( FolderTableItem* child, int row = 0 );
    void removeChildAt( int row );
    FolderTableItem* child( int row );
    int childCount() const;
    int columnCount() const;
    QString header( int column ) const;
    int headerPos( const QString& headerName ) const;
    QPair< QString, QVariant > headerType( int column ) const;
    bool setHeader( const QString& headerName, int column = 0 );
    QList< FolderTableItem* > newItems() const;
    bool anyNew() const;
    bool isFiltered() const;
    QMap< int, FolderTableItem* > filteredChildren() const;
    int find( unsigned channelId ) const;
    void sort( int column, Qt::SortOrder order );
    template <typename ColumnType> void sort1( int column, Qt::SortOrder order );
    
    QSettings settings;

private:
    QList<FolderTableItem*> childTableItems;
    QList<QString> headerNameList;
    QList< QPair< QString, QVariant > > headerTypeList;
//    QMap< QString, QPair< QString, QVariant > > folderAttributes;

};

#endif

