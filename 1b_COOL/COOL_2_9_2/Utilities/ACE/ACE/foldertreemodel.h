#ifndef FOLDERTREEMODEL_H
#define FOLDERTREEMODEL_H

#include <QtCore/QAbstractItemModel>
#include <QtCore/QModelIndex>
#include <QtCore/QVariant>
#include <QtCore/QSet>

#include "ACE/accesstocool.h"

#include <vector>
#include <string>

class FolderTreeItem;


class FolderTreeModel : public QAbstractItemModel
{
    Q_OBJECT

public:
//    FolderTreeModel( std::vector< std::string >& nodeList, QObject* parent = 0 );
    FolderTreeModel( cool::IDatabasePtr dbPtr, const QString connectionString, QObject* parent = 0 );
    ~FolderTreeModel();
    
    QVariant data( const QModelIndex& index, int role = Qt::DisplayRole ) const;
    QVariant headerData( int section = 0, Qt::Orientation orientation = Qt::Horizontal, int role = Qt::DisplayRole ) const;
    QModelIndex index( int row, int column, const QModelIndex& parent = QModelIndex() ) const;
    QModelIndex index( const QString& fullFolderName) const;
    QModelIndex parent( const QModelIndex& index ) const;
    int rowCount( const QModelIndex& parent = QModelIndex() ) const;
    int columnCount( const QModelIndex& parent = QModelIndex() ) const;
    Qt::ItemFlags flags( const QModelIndex& index ) const;
    bool setData( const QModelIndex& index, const QVariant& value, int role = Qt::EditRole );
    void emitDataChanged( const QModelIndex& index, const bool changed );
    bool setHeaderData( int section, Qt::Orientation orientation, const QVariant& value, int role = Qt::EditRole );
    bool removeRows( int row, int count = 1, const QModelIndex& parent = QModelIndex() );
    bool insertRows( int row, int count = 1, const QModelIndex& parent = QModelIndex() );
    QString folderName( const QModelIndex& index ) const;
    cool::IDatabasePtr getCoolDBPtr() const;
    bool isModified() const;
    QSet< QModelIndex > getModifiedFolders() const;

    QString coolConnectionString;

    /*
    // Optimisation methods
    bool hasChildren( const QModelIndex& parent = QModelIndex() ) const;
    bool canFetchMore( const QModelIndex& parent ) const;
    void fetchMore( const QModelIndex& parent );
    */
    
    /*
    // Optional methods
    QModelIndex buddy( const QModelIndex& index ) const;
    bool dropMimeData( const QMimeData* data, Qt::DropAction action, int row, int column, const QModelIndex& parent );
    Qt::DropActions supportedDropActions() const;
    */
    
    /*
    // Not implemented as columns are not designed to be removed.
    bool removeColumns( int column, int count, const QModelIndex& parent = QModelIndex() );
    bool insertColumns( int column, int count, const QModelIndex& parent = QModelIndex() );
    */
    
private:
  
  /// Copy constructor is private (fix Coverity MISSING_COPY)
  FolderTreeModel( const FolderTreeModel& rhs );
  
  /// Assignment operator is private (fix Coverity MISSING_ASSIGN)
  FolderTreeModel& operator=( const FolderTreeModel& rhs );

private:
    FolderTreeItem* rootTreeItem;
    cool::IDatabasePtr coolDBPtr;
    Qt::GlobalColor modifiedColour;
    QSet< QModelIndex > modifiedFolders;

    void setupFolderTreeModelData( std::vector< std::string >& nodeList );
    void setModifiedFolders( const QModelIndex& index, const bool modified );

};

#endif
