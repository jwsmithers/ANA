#include <QtCore/QtDebug>
#include <QtCore/QMultiMap>
#include <QtCore/QListIterator>

#include "ACE/foldertableitem.h"


FolderTableItem::FolderTableItem( const QList<QVariant>& data, RootFolderTableItem* parent, bool newItem ):
    tableItemData( data ),
    rootTableItem( parent ),
    clonedSourceItem( 0 ),
    hidden( false ),
    newItem( newItem )
{}

void FolderTableItem::setClonedSourceItem( FolderTableItem* newClonedSourceItem )
{
    clonedSourceItem = newClonedSourceItem;
}

FolderTableItem* FolderTableItem::getClonedSourceItem()
{
    return clonedSourceItem;
}

int FolderTableItem::columnCount() const
{
    return tableItemData.count();
}

RootFolderTableItem* FolderTableItem::parent()
{
    return rootTableItem;
}

int FolderTableItem::row() const
{
    if ( rootTableItem )
        return rootTableItem->childTableItems.indexOf( const_cast<FolderTableItem*>( this ) );

    return 0;
}

bool FolderTableItem::isNew() const
{
    return newItem;
}

bool FolderTableItem::isHidden() const
{
    return hidden;
}

void FolderTableItem::setHidden( bool enabled )
{
    hidden = enabled;
}

unsigned FolderTableItem::getChannelId() const
{
    return tableItemData.first().toUInt();
}

void FolderTableItem::setOld()
{
    newItem = false;
}

QList<QVariant> FolderTableItem::data() const
{
    return tableItemData;
}

QVariant FolderTableItem::data( int column ) const
{
    return tableItemData[ column ];
}

void FolderTableItem::setData( const QVariant& data, int column )
{
    tableItemData.replace( column, data );
}


RootFolderTableItem::RootFolderTableItem( const QList<QString>& headerNames, const QList< QPair< QString, QVariant > >& headerTypes )
   : headerNameList( headerNames ),
     headerTypeList( headerTypes )
{}

RootFolderTableItem::~RootFolderTableItem()
{
    qDeleteAll( childTableItems );
}

QList<FolderTableItem*> RootFolderTableItem::getChildren() const
{
    return childTableItems;
}

void RootFolderTableItem::appendChild( FolderTableItem* item )
{
    childTableItems.append( item );
}

void RootFolderTableItem::insertChild( FolderTableItem* item, int row )
{
    childTableItems.insert( row, item );
}

void RootFolderTableItem::removeChildAt( int row )
{
    childTableItems.removeAt( row );
}

FolderTableItem* RootFolderTableItem::child( int row )
{
    return childTableItems[ row ];
}

int RootFolderTableItem::childCount() const
{
    return childTableItems.count();
}

int RootFolderTableItem::columnCount() const
{
    return headerNameList.count();
}

QString RootFolderTableItem::header( int column ) const
{
    return headerNameList[ column ];
}

int RootFolderTableItem::headerPos( const QString& headerName ) const
{
    return headerNameList.indexOf( headerName );
}

QPair< QString, QVariant > RootFolderTableItem::headerType( int column ) const
{
    if ( column > columnCount() )
        return qMakePair( QString(), QVariant( QVariant::Invalid ) );
    return headerTypeList[ column ];
}

bool RootFolderTableItem::setHeader( const QString& data, int column )
{
    headerNameList.replace( column, data );
    return true;
}

QList< FolderTableItem* > RootFolderTableItem::newItems() const
{
    QList< FolderTableItem* > newItemList;
    foreach ( FolderTableItem* childTableItem, childTableItems)
    {
        if ( childTableItem->isNew() )
            newItemList.append( childTableItem );
    }
    return newItemList;
}

bool RootFolderTableItem::anyNew() const
{
    return !newItems().isEmpty();
}


bool RootFolderTableItem::isFiltered() const
{
    foreach ( FolderTableItem* childTableItem, childTableItems )
    {
        if ( childTableItem->isHidden() )
            return true;
    }
    return false;
}

QMap< int, FolderTableItem* > RootFolderTableItem::filteredChildren() const
{
    QMap< int, FolderTableItem* > fChildren;
    int pos( 0 );
    
    fChildren.clear();
    foreach ( FolderTableItem* childTableItem, childTableItems )
    {
        if ( !childTableItem->isHidden() )
            fChildren[ pos ] = childTableItem;
        pos++;
    }
    return fChildren;
}

int RootFolderTableItem::find( unsigned channelId ) const
{
    foreach ( FolderTableItem* childTableItem, childTableItems )
    {
        if ( childTableItem->getChannelId() == channelId )
            return childTableItem->row();
    }
    return -1;
}

void RootFolderTableItem::sort( int column, Qt::SortOrder order )
{
    QVariant::Type columnType = headerType( column ).second.type();
    if ( columnType == QVariant::Bool )
        sort1<bool>( column, order );
    else if ( columnType == QVariant::Char )
        sort1<int>( column, order );
    else if (columnType == QVariant::Int )
        sort1<int>( column, order );
    else if ( columnType == QVariant::UInt )
        sort1<unsigned int>( column, order );
    else if ( columnType == QVariant::ULongLong )
        sort1<unsigned long long>( column, order );
    else if ( columnType == QVariant::LongLong )
        sort1<long long>( column, order );
    else if ( columnType == QVariant::Double )
        sort1<double>( column, order );
    else if ( columnType == QVariant::String )
        sort1<QString>( column, order );
    else // do not compare
        return;
}

template <typename ColumnType>
void RootFolderTableItem::sort1( int column, Qt::SortOrder order )
{
    QMultiMap< ColumnType, int > sortedList;

    QList< int > intList;
	
    sortedList.clear();
    intList.clear();
    
    int pos( 0 );
    
    if ( isFiltered() )
    {
        QMap< int, FolderTableItem* > fChildren = filteredChildren();
        QList< int > filteredChildrenPos = fChildren.keys(); // ordered (ascending) keys

        // Associate the contents of a childTableItem value with its position. 
        
        foreach ( pos, filteredChildrenPos  )
        {
            QVariant v = fChildren.value( pos )->tableItemData.at( column );
            sortedList.insert( v.value<ColumnType>(), pos );
        }
        
        // The positions of filtered childTableItems in a sorted order 
        // (based on keys of the sortedList i.e. the childTableItem values)
        // stored in intList. Use of sortedList ceases here.
        intList = sortedList.values();
        QListIterator< int > i( intList ); 

        if ( order == Qt::AscendingOrder )
        {
            // Iterate over the positions of childItems that will be changed and
            // replace the current value with the childItem in the desired order. 
            foreach ( pos, filteredChildrenPos ) 
            {
                childTableItems.replace( pos, fChildren.value( i.next() ) );
            }
        }
        else // descending order
        {
            i.toBack();
            foreach ( pos, filteredChildrenPos )
            {
                childTableItems.replace( pos, fChildren.value( i.previous() ) );
            }
        }

        return;
    } // end of code block for the case where the table is filtered.

    // This part of the sort function caters to the situation 
    // where no childTableItems are hidden
	
    // Associate the contents of a childTableItem value with its position. 
    foreach ( FolderTableItem* childTableItem, childTableItems  )
	{
        QVariant v = childTableItem->tableItemData.at( column );
		sortedList.insert( v.value<ColumnType>(), pos++ );
	}
	
    // The positions of childTableItems in a sorted order (based on keys of the 
    // sortedList i.e. the childTableItem values) stored in intList.
	// Use of sortedList ceases here.
    intList = sortedList.values(); 
    
    // Add childTableItems in the required order to the existing childTableItems QList.
    // The unsorted section (i.e. the front section) will be removed a little later. 
    if ( order == Qt::AscendingOrder )
	{
		foreach ( pos, intList )
		{
			childTableItems.append( childTableItems.at( pos ) );
		}
	}
	else
	{
		QListIterator<int> i( intList );
		i.toBack();
		while ( i.hasPrevious() )
		{
			childTableItems.append( childTableItems.at( i.previous() ) );
		}
	}
	
    //Remove the unsorted section.
	for ( pos=0; pos < sortedList.size(); ++pos )
	{
		childTableItems.removeFirst();
	}
}

