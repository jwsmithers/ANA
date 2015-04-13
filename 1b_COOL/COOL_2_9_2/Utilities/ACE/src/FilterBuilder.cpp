#include <QtCore/QObject>
#include <QtCore/QtDebug>
#include <QtCore/QHash>
#include <QtGui/QMessageBox>
#include <QtGui/QScrollArea>
#include <QtGui/QVBoxLayout>
#include <QtGui/QLabel>
#include <QtGui/QPushButton>

#include "ACE/FilterEntry.h"
#include "ACE/FilterBuilder.h"
#include "ACE/foldertablemodel.h"
#include "ACE/foldertableitem.h"


FilterBuilder::FilterBuilder( QWidget* parent, Qt::WindowFlags f ) :
    QWidget( parent, f ),
    currentTableModel( NULL)
{
    setupUi( this );

    // Scroll area required as filter entries are added dynamically.
    filterEntryScrollArea = new QScrollArea( this );

    
    // QScrollArea manages a single widget so a wrapper widget is used.
    filterEntryScrollAreaWidget = new QWidget( filterEntryScrollArea );

    // Create a vertical layout for the filterEntryScrollAreaWidget.
    filterEntryScrollAreaWidget_Layout = new QVBoxLayout( filterEntryScrollAreaWidget );
    filterEntryScrollAreaWidget_Layout->setObjectName( QString::fromUtf8( "filterEntryScrollAreaWidget_Layout" ) );
    
    // Spacer to keep the filter entries to the top of the scroll area.
    // This spacer will be removed and re-added when a filter entry is added
    spacerItem_ScrollAreaWidget = new QSpacerItem( 20, 0, QSizePolicy::Minimum, QSizePolicy::Expanding);
    filterEntryScrollAreaWidget_Layout->addItem( spacerItem_ScrollAreaWidget );
    
    // Give the empty filterEntryScrollAreaWidget to the scroll area to manage.
    filterEntryScrollArea->setWidget( filterEntryScrollAreaWidget );
    filterEntryScrollArea->setWidgetResizable( true );

    layout()->addWidget( filterEntryScrollArea );

    // Connections
    QObject::connect( pushButton_ApplyFilter, SIGNAL( clicked() ), this, SLOT( slotUpdateTableView() ) );
    QObject::connect( pushButton_DisableFilter, SIGNAL( clicked() ), this, SLOT( slotShowAll() ) );
    
    slotAddFilterEntry();

}

FilterBuilder::~FilterBuilder()
{
//    delete tempFilterEntry;
}

void FilterBuilder::slotSaveColumnPositions()
{
    // Save the current selection in the comboBox_Column of each filter entry.
    if ( currentTableModel )
    {
        filterColumnPositions.remove( currentTableModel );
        foreach ( FilterEntry* tempFilterEntry, filterEntryList )
        {
            filterColumnPositions.insert( currentTableModel, tempFilterEntry->comboBox_Column->currentIndex() );
        }
    }
}

void FilterBuilder::slotAddFilterEntry()
{
    // remove spacer
    filterEntryScrollAreaWidget_Layout->removeItem( spacerItem_ScrollAreaWidget );
    
    // Create new filter entry
    FilterEntry* tempFilterEntry = new FilterEntry( trUtf8( "Filter" ), this,filterEntryScrollAreaWidget );
    QObject::connect( tempFilterEntry->pushButton_AddFilter, SIGNAL( clicked() ), this, SLOT( slotAddFilterEntry() ) );
    QObject::connect( tempFilterEntry, SIGNAL( removeFilter( FilterEntry* ) ), this, SLOT( slotRemoveFilterEntry( FilterEntry* ) ) );
    QObject::connect( tempFilterEntry->comboBox_Column, SIGNAL( activated ( int ) ), this, SLOT( slotSaveColumnPositions() ) );
    tempFilterEntry->show();
    filterEntryScrollAreaWidget_Layout->addWidget( tempFilterEntry );
    // reintroduce spacer
    filterEntryScrollAreaWidget_Layout->addItem( spacerItem_ScrollAreaWidget );
//    filterEntryScrollAreaWidget->updateGeometry();
    switch ( filterEntryList.size() )
    {
        case 0:
            break;
        case 1:
            filterEntryList.at( 0 )->pushButton_RemoveFilter->setEnabled( true );
            break; // Fix Coverity MISSING_BREAK (bug #95773)
        default:
            tempFilterEntry->pushButton_RemoveFilter->setEnabled( true );
            break;
    }
    filterEntryList.append( tempFilterEntry );
    fillColumn( tempFilterEntry, currentTableModel );
}

void FilterBuilder::slotRemoveFilterEntry( FilterEntry* filterEntry )
{
    // Remove filterEntry from the scroll area.
    filterEntryScrollAreaWidget_Layout->removeWidget( filterEntry );
//    filterEntryScrollAreaWidget->updateGeometry();

    // remove filterEntry in filterEntryList and delete it.
    int index = filterEntryList.indexOf( filterEntry );
    if ( index == -1 )
    {
        qWarning() << "Could not find filterEntry in filterEntryList!";
    }
    else
    {
        delete filterEntryList.takeAt( index );
    }
    // remove ALL the entries in the filterColumnPositions that correspond to this filterEntry
    // Modification of filterColumnPositions only possible because foreach will automatically
    // work on a copy if modification occurs. In other situations, it is implicitly shared.
    foreach ( FolderTableModel* theModel, filterColumnPositions.uniqueKeys() )
    {
        // order: most recent insertion at start of list.
        QList<int> positions = filterColumnPositions.values( theModel ); 
        filterColumnPositions.remove( theModel );
        int pSize = positions.size();
        for ( int i = 0; i < pSize; i++ )
        {
            // Use of removeLast() and takeLast() to right the reverse order used in positions
            if ( i == index )
            {
                positions.removeLast();
//                qDebug() << "index " << i << " matches index of deleted filter entry. Removing from positions.";
            }
            else
            {
                int tempPos = positions.takeLast();
                filterColumnPositions.insert( theModel, tempPos );
//                qDebug() << "reinserting value of " << tempPos << " into filterColumnPositions";
            }
        }
    }

    // Disable remove filter button if there is only one filter entry. 
    if ( filterEntryList.size() == 1 ) // a filter Entry already exists
    {
        filterEntryList.at( 0 )->pushButton_RemoveFilter->setEnabled( false );
    }
}

int FilterBuilder::filterEntryCount( bool activeOnly )
{
    int total = 0;
    if ( activeOnly )
    {
        foreach ( FilterEntry* tempFilterEntry, filterEntryList )
        {
            if ( tempFilterEntry->groupBox_FilterEntry->isChecked() )
                total++;
        }
    }
    else
    {
        total = filterEntryList.size();
    }
    return total;
}

// Search for rows that satisfy the tests in 'pointer to member function' QList.
QList< int > FilterBuilder::applyFilter( FolderTableModel* tableModel, bool allChannels, int rowStartPos, int rowEndPos )
{
//    qDebug() << "****applyFilter() called byslotUpdateTableView()";
    QList< int > selectedRows;
    int startRow = 0, maxRow = tableModel->rowCount() - 1;
    unsigned int channelId = 0;
    int counter, columnPos;
    int totalActiveFilters;
    bool result( false );
    bool all( comboBox_FilterBehaviour->currentIndex() );
    QPair< int, FilterFunction > filterFunctionPair;

    // Filter works on the basis of hidding existing rows.
    // Hence there is the need to fill the selectedRows with all available rows and remove
    // them as required.
    // Note: Use of maxRow is position sensitive as it may change later.
    for ( int r = 0; r <= maxRow; r++ ) 
    {
        selectedRows.append( r );
    }
    
    if ( !allChannels ) // look for a specific channelId
        channelId = tableModel->getRootTableItem()->child( rowStartPos )->getChannelId();
    
    else if ( rowStartPos != -1 )  // specific start and end rows are tested only if searching for a particular channel
    {
        startRow = rowStartPos;
        if ( rowEndPos != -1 )
            maxRow = rowEndPos;
    }

    totalActiveFilters = filterEntryCount( true );

    // Traverse the rows of interest in reverse order to benefit from row and list index association. 
    for ( int r = maxRow; r >= startRow; r-- )
    {
        result = false;
        counter = totalActiveFilters;
        FolderTableItem* currentTableItem = tableModel->getRootTableItem()->child( r );

        if ( !allChannels && ( currentTableItem->getChannelId() != channelId ) )
            continue;
        
        foreach ( FilterEntry* tempFilterEntry, filterEntryList )
        {
            if ( !tempFilterEntry->groupBox_FilterEntry->isChecked() )
            {
                continue;
            }
            filterFunctionPair = tempFilterEntry->getFilterFunction(); 
            columnPos = filterFunctionPair.first;
            if ( columnPos == -1 )
            {
                continue;
            }
            else
            {
//                result = ( tempFilterEntry->*filterFunctionPair.second )( tableModel->getMaskedData( currentTableItem, columnPos ) ); // get the masked data from the correct column specified by the filter. 
                result = ( tempFilterEntry->*filterFunctionPair.second )( tableModel->index( r, columnPos ) ); 
            }
            if ( result )
            {
                if ( all ) // all filters must return true
                {
                    counter -= 1; // counter decremented only when using 'all' filters
                }
                else // any filter returning true will result in a selected row.
                {
                    selectedRows.removeAt( r );
                    break; // stop looping through the list of filters and proceed to next row.
                }
            }
            else // filter returned false
            {
                if ( all )
                {
                    break;
                }
            }
        } // end of foreach loop

        if ( result && !counter ) // all filters returned true.
        {
            selectedRows.removeAt( r );
        }

    } // end of for loop traversing rows of interest
    
    return selectedRows;
}

void FilterBuilder::slotUpdateFilter( FolderTableModel* tableModel, QString folderName )
{
//    qDebug() << "****updateFilterTarget() signal detected. Executing slotUpdateFilter()";
    if ( tableModel != currentTableModel )
    {
        currentTableModel = tableModel;
        // Indicate which table is currently targetted.
        if ( !folderName.isEmpty() )
        {
            label_FilterTarget->setText( folderName );
        }
        // Restore selection of comboBox_Columns
        
        QList<int> positions = filterColumnPositions.values( currentTableModel );
        int pos = positions.size() - 1;
        // Modify column ComboBox
//        qDebug() << "filterEntryList has " << filterEntryList.size();
//        qDebug() << "positions size for current table is " << positions.size();
        foreach ( FilterEntry* filterEntry, filterEntryList )
        {
            filterEntry->comboBox_Column->clear();
            fillColumn( filterEntry, tableModel );
            // Set the previous selection visible.
            if ( pos > -1 )
            {
                filterEntry->comboBox_Column->setCurrentIndex( positions.at( pos-- ) ); 
            }
//            filterEntry->comboBox_Column->updateGeometry();
        }
//        qDebug() << "filter Update complete";
    }
}

void FilterBuilder::fillColumn( FilterEntry* filterEntry, FolderTableModel* tableModel )
{
    if ( tableModel )
    {
        for ( int t = 0; t < tableModel->columnCount(); t++ )
        {
            filterEntry->comboBox_Column->addItem( tableModel->headerData( t ).toString() );
        }
    }
}

void FilterBuilder::slotUpdateTableView()
{
    if ( currentTableModel )
    {
        setCursor( Qt::WaitCursor );
        if ( currentTableModel->isFiltered() )
        {
            slotShowAll();
        }
        emit applyClicked( currentTableModel, applyFilter( currentTableModel ) );
        unsetCursor();
    }
}

void FilterBuilder::slotShowAll()
{
    emit applyClicked( currentTableModel, QList< int >() );
}

void FilterBuilder::slotClearCurrentTableModel( FolderTableModel* theModel )
{
    if ( theModel == currentTableModel )
    {
        currentTableModel = NULL;
        label_FilterTarget->setText( QString() );
        foreach ( FilterEntry* filterEntry, filterEntryList )
        {
            filterEntry->comboBox_Column->clear();
        }
    }
}


