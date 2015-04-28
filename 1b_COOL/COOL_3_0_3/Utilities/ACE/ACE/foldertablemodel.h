#ifndef FOLDERTABLEMODEL_H
#define FOLDERTABLEMODEL_H

#include <QtCore/QAbstractTableModel>
#include <QtCore/QModelIndex>
#include <QtCore/QVariant>
#include <QtCore/QSet>
#include <QtCore/QDateTime>

#include <vector>
#include <string>

#include "ACE/foldertableitem.h"
#include "ACE/accesstocool.h"

enum DisplayAsMask { noMask, octMask, decMask, hexMask, blobMask, clobMask, IOV_time_Mask, IOV_runLB_Mask, IOV_runEvt_Mask, IOV_generic_Mask };
enum ColumnResponse { noResponse, readonlyResponse, confirmResponse };

class RootFolderTableItem;
class QValidator;
class FolderTableModel;

// typedef of pointer to member function. 
typedef bool ( FolderTableModel::*FilterFunction0 )( int );


class FolderTableModel : public QAbstractTableModel
{
    Q_OBJECT

public:
    FolderTableModel( cool::IFolderPtr folderPtr, QString vkEncoding = "time", cool::ValidityKey start = cool::ValidityKeyMin, cool::ValidityKey end = cool::ValidityKeyMax, cool::ChannelSelection channels = cool::ChannelSelection(), QString tag = "", QObject* parent = 0 );
    ~FolderTableModel();

    QVariant data( const QModelIndex& index, int role = Qt::DisplayRole ) const;
    QVariant rawData( const QModelIndex& index ) const;
    QVariant headerData( int section, Qt::Orientation orientation = Qt::Horizontal, int role = Qt::DisplayRole ) const;
    QModelIndex index( int row, int column, const QModelIndex& parent = QModelIndex() ) const;
    QModelIndex parent( const QModelIndex& index ) const;
    int rowCount( const QModelIndex& parent = QModelIndex() ) const;
    int columnCount( const QModelIndex& parent = QModelIndex() ) const;
    Qt::ItemFlags flags( const QModelIndex& index ) const;
    bool setData( const QModelIndex& index, const QVariant& value, int role = Qt::EditRole );
    void setData( const QModelIndexList& indexList, const QVariant& value, int role = Qt::EditRole );
    bool canSetDisplayAsMask( const QModelIndex& index ) const;
    bool canSetDisplayAsMask( const QModelIndexList& indexList ) const;
    bool setHeaderData( int section, Qt::Orientation orientation, const QVariant& value, int role = Qt::EditRole );
    bool removeRows( int row, int count = 1, const QModelIndex& parent = QModelIndex() );
    bool insertRows( int row, int count = 1, const QModelIndex& parent = QModelIndex() );
    QVariant::Type getQVariantType( const std::string& coolType ) const;
    QVariant::Type getQVariantType( const QModelIndex& index ) const;
    QVariant::Type getQVariantType( const QString& field ) const;
    QVariant::Type getQVariantType( int column ) const;
    QString getCoolTypeString( const QModelIndex& index ) const;
    RootFolderTableItem* getRootTableItem() const;
    void setDefaultCopyRow( int row );
	QList< int > filter( FilterFunction0 f, bool inverse, bool allChannels = true, int rowStartPos = -1, int rowEndPos = -1 );
    QList< int > filter_mres( bool inverse = true );
    int filter_mre_singleChannel( int row );
    bool filter_mre( int row );
    QList< FolderTableItem* > _updateValidityKeys( QList< FolderTableItem* > newTableItems );
    bool commit();
    bool isNewRow( int row ) const;
    DisplayAsMask getDisplayAsMask( int column ) const;
    ColumnResponse getColumnResponse( int column ) const;
    bool hasMask( int column ) const;
    void setDisplayAsMask( const QModelIndex& index, DisplayAsMask dMask );
    QString getInputMask( const QModelIndex& index ) const;
    QVariant getMaskedData( FolderTableItem*& item, int column ) const;
    QValidator* getValidator( const QModelIndex& index ) const;
    QValidator* getValidator( unsigned int column ) const;
    void sort( int column, Qt::SortOrder order );
    int compare( const QModelIndex& index, QString value );
    int compareQVariants( QVariant A, QVariant B );
    void setFiltered( bool enabled = true );
    bool isFiltered() const;

    QSet< unsigned int > newRowChannelIds( QList< FolderTableItem* > newTableItems = QList< FolderTableItem* >() ) const;

private:
    cool::IFolderPtr coolFolderPtr;
    const cool::IRecordSpecification& payloadSpec;
    bool filtered;
    QString vkEncoding;
    cool::FolderVersioning::Mode versioningMode;
    RootFolderTableItem* rootTableItem;
    int defaultCopyRow;
    QString newRowColour, modifiedColour, maskColour, filteredColour;
    QHash< int, DisplayAsMask > displayAsMaskHash;
    QHash< int, ColumnResponse > columnResponseHash;
    
    void setupFolderTableModelData( cool::ValidityKey start, cool::ValidityKey end, cool::ChannelSelection channels, QString tag );
    QVariant qStringToQVariant( QString value, bool* ok, int column, int base = 0 );
    QVariant applyMaskToQVariant( QString format, QVariant currentValue, int column, bool* ok, int fieldWidth = 1, int base = 10, const QChar& fillChar = QLatin1Char( ' ' ) ) const;

signals:
    void modelChanged( const FolderTableModel* thisModel, const bool changed );

};

#endif
/*
// Optimisation methods
    bool hasChildren( const QModelIndex& parent = QModelIndex() ) const;
    bool canFetchMore( const QModelIndex& parent ) const;
    void fetchMore( const QModelIndex& parent );

// Optional methods
    QModelIndex buddy( const QModelIndex& index ) const;
    bool dropMimeData( const QMimeData* data, Qt::DropAction action, int row, int column, const QModelIndex& parent );
    Qt::DropActions supportedDropActions() const;
*/
