#include <QtCore/QtDebug>
#include <QtCore/QSet>
#include <QtCore/QMap>
#include <QtCore/QSettings>
#include <QtCore/QVariant>
#include <QtGui/QContextMenuEvent>
#include <QtGui/QAction>
#include <QtGui/QWidget>
#include <QtGui/QMenu>
#include <QtGui/QHeaderView>
#include <QtGui/QMessageBox>
#include <QtGui/QItemSelectionModel>

#include "ACE/foldertableview.h"
#include "ACE/foldertablemodel.h"
#include "ACE/foldertabledelegate.h"
#include "ACE/miscDialogs.h"


FolderTableView::FolderTableView( QWidget* parent, FolderTableModel* theModel ):
    QTableView( parent ),
    folderTableModel( theModel )
{
    QSettings settings;
    settings.beginGroup( "Preferences/FolderTables/Display" );
    setAlternatingRowColors( settings.value( "AlternatingRowColors", true ).toBool() );
    bool s = settings.value( "SortingEnabled", true ).toBool();
    setSortingEnabled( s );
    horizontalHeader()->setSortIndicatorShown( s );
    horizontalHeader()->setClickable( s );
    horizontalHeader()->setDefaultAlignment( Qt::AlignLeft );
    settings.endGroup();
    
    createActions();
    fillCellsDialog = new FillCellsDialog( this );
    folderTableDelegate = new FolderTableDelegate( this );
    setItemDelegate( folderTableDelegate );
    setModel( folderTableModel );
}

FolderTableView::~FolderTableView()
{
// *** TO DO ***
// Clear has table in MainWindow to allow the view to be created again.
// Need to decide where to put the code. Do nothing for now.
    delete fillCellsDialog;
    delete folderTableDelegate;
    selectionInspectionResults.clear();
}

void FolderTableView::enableSorting( bool enabled )
{
    if ( enabled && !( folderTableModel->isFiltered() ) )
    {
        QSettings settings;
        settings.beginGroup( "Preferences/FolderTables/Display" );
        enabled = settings.value( "SortingEnabled", true ).toBool();
        settings.endGroup();
    }
    else
        qWarning() << "Sorting is disabled and/or filter is active."; 
    setSortingEnabled( enabled );
    horizontalHeader()->setSortIndicatorShown( enabled );
    horizontalHeader()->setSortIndicatorShown( enabled );
    horizontalHeader()->setClickable( enabled );
}

QModelIndexList FolderTableView::excludeHiddenItems( QModelIndexList fullSelection )
{
    QModelIndexList filteredModelIndexList;
    filteredModelIndexList.clear();

    foreach ( QModelIndex index, fullSelection )
    {
        if ( !isRowHidden( index.row() ) )
            filteredModelIndexList.append( index );
    }
    return filteredModelIndexList;
}

void FolderTableView::focusInEvent( QFocusEvent* event )
{
    emit checkButtons( false );

    emit updateFilterTarget( folderTableModel, objectName() );
    QTableView::focusInEvent( event );
}

void FolderTableView::focusOutEvent( QFocusEvent* event )
{
    emit checkButtons( false );
    QTableView::focusOutEvent( event );
}

void FolderTableView::contextMenuEvent( QContextMenuEvent* event )
{
    selectionInspectionResults.clear();
    QModelIndex currentTableModelIndex( indexAt( event->pos() ) );
    currentSelectionModel = selectionModel();
    QModelIndexList indexes = excludeHiddenItems( currentSelectionModel->selectedIndexes() );
    if ( !currentTableModelIndex.isValid() )
        return;
    QMenu menu( this );
    testSelection( indexes );
    if ( selectionInspectionResults.contains( newRows ) )
    {
        menu.addAction( actionCommit );
        menu.addAction( actionRemove );
        if ( folderTableModel->flags( currentTableModelIndex ) & Qt::ItemIsEditable )
        {
            menu.addAction( actionFillCells );
        }
    }
    if ( selectionInspectionResults.contains( oldRows ) )
    {
        menu.addAction( actionClone );
    }
    if ( folderTableModel->canSetDisplayAsMask( indexes ) && ( currentTableModelIndex.column() < 1 || currentTableModelIndex.column() > 2 ) )
    {
        menu.addSeparator();
        QMenu* displayAsMenu = menu.addMenu( tr( "Display as" ) );
        displayAsMenu->addAction( actionDisplayAsHex );
        displayAsMenu->addAction( actionDisplayAsOct );
        displayAsMenu->addAction( actionDisplayAsDec );
        if ( !folderTableModel->getDisplayAsMask( currentTableModelIndex.column() ) == noMask )
        {
            displayAsMenu->addAction( actionDisplayAs_Remove );
        }
    }
    menu.exec( event->globalPos() );
}

void FolderTableView::createActions()
{
    actionClone = new QAction( tr( "&Clone rows" ), this );
//    actionClone->setShortcut( tr( "Ctrl+C" ) );
    actionClone->setStatusTip( tr( "Create a new row based on an existing one." ) );
    QObject::connect( actionClone, SIGNAL( triggered() ), this, SLOT( slotNewRow() ) );

    actionCommit = new QAction( tr( "Commit" ), this );
    actionCommit->setStatusTip( tr( "Commit the newly added rows to the COOL database." ) );
    QObject::connect( actionCommit, SIGNAL( triggered() ), this, SLOT( slotCommit() ) );

    actionRemove = new QAction( tr( "Remove rows" ), this );
    actionRemove->setStatusTip( tr( "Remove the uncommitted row." ) );
    QObject::connect( actionRemove, SIGNAL( triggered() ), this, SLOT( slotRemove() ) );

    actionFillCells = new QAction( tr( "Fill" ), this );
    actionFillCells->setStatusTip( tr( "Fill selected cells with the same value." ) );
    QObject::connect( actionFillCells, SIGNAL( triggered() ), this, SLOT( slotFillCells() ) );

    actionDisplayAsDec = new QAction( tr( "Dec" ), this );
    actionDisplayAsDec->setStatusTip( tr( "Display all values in the column to decimal." ) );
    QObject::connect( actionDisplayAsDec, SIGNAL( triggered() ), this, SLOT( slotDisplayAsDec() ) );
    
    actionDisplayAsHex = new QAction( tr( "Hex" ), this );
    actionDisplayAsHex->setStatusTip( tr( "Display all values in the column to hexadecimal." ) );
    QObject::connect( actionDisplayAsHex, SIGNAL( triggered() ), this, SLOT( slotDisplayAsHex() ) );

    actionDisplayAsOct = new QAction( tr( "Oct" ), this );
    actionDisplayAsOct->setStatusTip( tr( "Display all values in the column to octal." ) );
    QObject::connect( actionDisplayAsOct, SIGNAL( triggered() ), this, SLOT( slotDisplayAsOct() ) );

    actionDisplayAsDateTime = new QAction( tr( "Date/Time" ), this );
    actionDisplayAsDateTime->setStatusTip( tr( "Converts UTC to Date/Time format." ) );
    QObject::connect( actionDisplayAsDateTime, SIGNAL( triggered() ), this, SLOT( slotDisplayAsDateTime() ) );

    actionDisplayAs_Remove = new QAction( tr( "No mask" ), this );
    actionDisplayAs_Remove->setStatusTip( tr( "Remove any mask currently in place." ) );
    QObject::connect( actionDisplayAs_Remove, SIGNAL( triggered() ), this, SLOT( slotDisplayAs_Remove() ) );
        
/*
    actionGroupDisplayAs = new QActionGroup( this );
    actionGroupDisplayAs->addAction( actionDisplayAsHex );
    actionGroupDisplayAs->addAction( actionDisplayAsDec );
    actionGroupDisplayAs->addAction( actionDisplayAsOct );
    actionGroupDisplayAs->addAction( actionDisplayAs_Remove );
    actionDisplayAsDec->setChecked(true); // Default
*/
}

void FolderTableView::testSelection( QModelIndexList& currentSelectionList )
{
    QModelIndex currentSelection;
    QSet< int > rowSet;
    QSet< unsigned int > channelIdSet;
    int row( -1 );
    bool rowIsNew( false );
    unsigned int channelId( 0 );
    foreach ( currentSelection, currentSelectionList )
    {
        row = currentSelection.row();
        channelId = folderTableModel->getRootTableItem()->child( row )->getChannelId();
        rowIsNew = folderTableModel->isNewRow( row );
        if ( rowIsNew )
        {
            if ( selectionInspectionResults.contains( newRows ) )
            {
                selectionInspectionResults[ newRows ].append( currentSelection );
            }
            else
            {
                QModelIndexList indexList = QModelIndexList();
                indexList.append( currentSelection );
                selectionInspectionResults[ newRows ] = indexList;
            }
        }
        else // row is not newly cloned.
        {
            if ( selectionInspectionResults.contains( oldRows ) )
            {
                selectionInspectionResults[ oldRows ].append( currentSelection );
            }
            else
            {
                QModelIndexList indexList = QModelIndexList();
                indexList.append( currentSelection );
                selectionInspectionResults[ oldRows ] = indexList; 
            }
        }
        if ( !rowSet.contains( row ) )  // NOTE: selections in existing rows are discarded!
        {
            rowSet.insert( row );
            if ( channelIdSet.contains( channelId ) ) // Duplicate channel!!
            {
                // Note 1: Only selections corresponding to rows other
                // than those in the rowSet will be added to either 
                // duplicateNewRows or duplicateOldRows.
                //
                // Note 2: Only duplicates are added to duplicate???Rows.
                // The original model index is not.
                if ( rowIsNew )
                {
                    if ( selectionInspectionResults.contains( duplicateNewRows ) )
                    {
                        selectionInspectionResults[ duplicateNewRows ].append( currentSelection );
                    }
                    else
                    {
                        QModelIndexList indexList = QModelIndexList();
                        indexList.append( currentSelection );
                        selectionInspectionResults[ duplicateNewRows ] = indexList;
                    }
                }
                else
                {
                    if ( selectionInspectionResults.contains( duplicateOldRows ) )
                    {
                        selectionInspectionResults[ duplicateOldRows ].append( currentSelection );
                    }
                    else
                    {
                        QModelIndexList indexList = QModelIndexList();
                        indexList.append( currentSelection );
                        selectionInspectionResults[ duplicateOldRows ] = indexList;
                    }
                }
            }
            else // new channelId encountered. Adding.
            {
                channelIdSet.insert( channelId );
            }
        }
    }
}

int FolderTableView::selectionRowCount( QModelIndexList& currentSelectionList )
{
    QModelIndex currentSelection;
    QSet< int > rowSet;
    foreach ( currentSelection, currentSelectionList )
    {
        rowSet.insert( currentSelection.row() );
    }
    return rowSet.size();
}

void FolderTableView::setRowsHidden( QList< int > rows, bool hide )
{
    foreach ( int row, rows )
    {
        setRowHidden( row, hide );
    }
    
    // Double loop to hopefully speed up screen update?
    foreach ( int row, rows )
    {
        folderTableModel->getRootTableItem()->child( row )->setHidden( hide );
    }
}

void FolderTableView::showAllRows()
{
    int rowCount =  folderTableModel->rowCount();
    for ( int row = 0; row < rowCount; row++ )
    {
        setRowHidden( row, false );
    }

    // Double loop to hopefully speed up screen update?
    for ( int row = 0; row < rowCount; row++ )
    {
        folderTableModel->getRootTableItem()->child( row )->setHidden( false );
    }
    folderTableModel->setFiltered( false );
}

FolderTableModel* FolderTableView::getFolderTableModel() const
{
    return folderTableModel;
}

void FolderTableView::slotNewRow()
{
    if ( selectionInspectionResults.contains( duplicateOldRows ) )
    {
        QMessageBox::warning(
            this, 
            tr( "Selection Error" ),
            tr( "The current selection includes duplicate channels!\nPlease only select unique channels from existing (i.e. committed) rows." ),
            QMessageBox::Ok, 
            QMessageBox::Ok );
        return;
    }
    if ( !selectionInspectionResults.contains( oldRows ) )
    {
        QMessageBox::warning(
            this, 
            tr( "Selection Error" ),
            tr( "No existing rows to clone. Please choose only existing (i.e. committed) rows to clone." ),
            QMessageBox::Ok, 
            QMessageBox::Ok );
        return;
    }
    if ( selectionInspectionResults.contains( newRows ) )
    {
        QMessageBox::information(
            this, 
            tr( "Selection Warning" ),
            tr( "Newly created rows cannot be cloned. These rows will be ignored." ),
            QMessageBox::Ok, 
            QMessageBox::Ok );
    }
    QSet< unsigned int > newRowChannelIds( folderTableModel->newRowChannelIds() );
    QModelIndex currentSelection;
    QSet< int > ignoredRows;
    QSet< int > selectedRows;
    int row;
    foreach ( currentSelection, selectionInspectionResults.value( oldRows ) )
    {
        row = currentSelection.row();
        // Assume that the user wants to copy/clone the currently selected row.
        if ( !newRowChannelIds.contains( folderTableModel->getRootTableItem()->child( row )->getChannelId() ) )
        {
            if ( !selectedRows.contains( row ) )
            {
                folderTableModel->setDefaultCopyRow( row );
                folderTableModel->insertRows( folderTableModel->rowCount() );
                selectedRows.insert( row );
            }
            continue;
        }
        else
        {
            ignoredRows.insert( row );
        }
    }
    if ( !ignoredRows.isEmpty() )
    {
        QMessageBox::information(
            this, 
            tr( "Selection Warning" ),
            tr( "Selected rows with channel ids identical to newly cloned rows have been ignored." ),
            QMessageBox::Ok, 
            QMessageBox::Ok );
    }
    emit checkButtons();
    scrollToBottom();
}

void FolderTableView::slotCommit()
{
    folderTableModel->commit();
    emit checkButtons();
}

void FolderTableView::slotRemove()
{
    if ( selectionInspectionResults.contains( oldRows ) )
    {
        QMessageBox::warning(
            this, 
            tr( "Selection Warning" ),
            tr( "The current selection includes existing entries !\nThese will not be removed." ),
            QMessageBox::Ok, 
            QMessageBox::Ok );
    }
    if ( !selectionInspectionResults.contains( newRows ) )
    {
        QMessageBox::information(
            this, 
            tr( "Selection Error" ),
            tr( "No newly created rows selected. Nothing to remove." ),
            QMessageBox::Ok, 
            QMessageBox::Ok );
        return;
    }
     // use of QMap for key sorting only. bool value is not used.
    QMap< int, bool > selectedRows;
    QMap< int, bool >::const_iterator  i;
    QModelIndex currentSelection;
    int row;
    foreach ( currentSelection, selectionInspectionResults.value( newRows ) )
    {
        row = currentSelection.row();
        if ( !selectedRows.contains( row ) ) // row not yet removed.
        {
            selectedRows[ row ] = true; // dummmy value.
        }
    }
    for ( i = selectedRows.constEnd() - 1 ; i != selectedRows.constBegin() - 1; --i )
    {
        folderTableModel->removeRows( i.key() );
    }
    emit checkButtons();
}

void FolderTableView::slotFillCells()
{
    // No modification possible on existing rows.
    if ( selectionInspectionResults.contains( oldRows ) )
    {
        QMessageBox::warning(
            this, 
            tr( "Selection Warning" ),
            tr( "The current selection includes existing entries !\nThese will be ignored." ),
            QMessageBox::Ok, 
            QMessageBox::Ok );
    }
    
    // Check for different types when using this bulk fill functionality.
    QVariant::Type controlType = getFolderTableModel()->getQVariantType( selectionInspectionResults.value( newRows )[ 0 ] );
    foreach ( QModelIndex index, selectionInspectionResults.value( newRows ) )
    {
        if ( !getFolderTableModel()->getQVariantType( index ) == controlType )
        {
            QMessageBox::warning(
                this, 
                tr( "Selection Error" ),
                tr( "The current selection includes entries of different types!\nPlease amend selection." ),
            QMessageBox::Ok, 
            QMessageBox::Ok );
            return;
        }
    }
    
    // Install mask and validator
    fillCellsDialog->lineEdit->setInputMask( getFolderTableModel()->getInputMask( selectionInspectionResults.value( newRows )[ 0 ] ) );
    fillCellsDialog->lineEdit->setValidator( getFolderTableModel()->getValidator( selectionInspectionResults.value( newRows )[ 0 ] ) );

    fillCellsDialog->exec();
    if ( fillCellsDialog->result() == QDialog::Accepted )
    {
        folderTableModel->setData( selectionInspectionResults.value( newRows ), QVariant( fillCellsDialog->text() ) );
    }
}

void FolderTableView::slotDisplayAsHex()
{
    int column;
    QSet< int > columnSet;
    QModelIndex tempModelIndex;
    QModelIndexList tempModelIndexList( selectionInspectionResults.value( oldRows, QModelIndexList() ) );
    tempModelIndexList += selectionInspectionResults.value( newRows, QModelIndexList() );
    foreach ( tempModelIndex, tempModelIndexList )
    {
        column = tempModelIndex.column();
        if ( columnSet.contains( column ) )
        {
            continue;
        }
        else
        {
            columnSet.insert( column );
            folderTableModel->setDisplayAsMask( tempModelIndex, hexMask );
        }
    }
}

void FolderTableView::slotDisplayAsDec()
{
    int column;
    QSet< int > columnSet;
    QModelIndex tempModelIndex;
    QModelIndexList tempModelIndexList( selectionInspectionResults.value( oldRows, QModelIndexList() ) );
    tempModelIndexList += selectionInspectionResults.value( newRows, QModelIndexList() );
    foreach ( tempModelIndex, tempModelIndexList )
    {
        column = tempModelIndex.column();
        if ( columnSet.contains( column ) )
        {
            continue;
        }
        else
        {
            columnSet.insert( column );
            folderTableModel->setDisplayAsMask( tempModelIndex, decMask );
        }
    }
}

void FolderTableView::slotDisplayAsOct()
{
    int column;
    QSet< int > columnSet;
    QModelIndex tempModelIndex;
    QModelIndexList tempModelIndexList( selectionInspectionResults.value( oldRows, QModelIndexList() ) );
    tempModelIndexList += selectionInspectionResults.value( newRows, QModelIndexList() );
    foreach ( tempModelIndex, tempModelIndexList )
    {
        column = tempModelIndex.column();
        if ( columnSet.contains( column ) )
        {
            continue;
        }
        else
        {
            columnSet.insert( column );
            folderTableModel->setDisplayAsMask( tempModelIndex, octMask );
        }
    }
}

void FolderTableView::slotDisplayAsDateTime()
{
    int column;
    QSet< int > columnSet;
    QModelIndex tempModelIndex;
    QModelIndexList tempModelIndexList( selectionInspectionResults.value( oldRows, QModelIndexList() ) );
    tempModelIndexList += selectionInspectionResults.value( newRows, QModelIndexList() );
    foreach ( tempModelIndex, tempModelIndexList )
    {
        column = tempModelIndex.column();
        if ( columnSet.contains( column ) )
        {
            continue;
        }
        else
        {
            columnSet.insert( column );
            folderTableModel->setDisplayAsMask( tempModelIndex, IOV_time_Mask );
        }
    }
}

void FolderTableView::slotDisplayAs_Remove()
{
    int column;
    QSet< int > columnSet;
    QModelIndex tempModelIndex;
    QModelIndexList tempModelIndexList( selectionInspectionResults.value( oldRows, QModelIndexList() ) );
    tempModelIndexList += selectionInspectionResults.value( newRows, QModelIndexList() );
    foreach ( tempModelIndex, tempModelIndexList )
    {
        column = tempModelIndex.column();
        if ( columnSet.contains( column ) )
        {
            continue;
        }
        else
        {
            columnSet.insert( column );
            folderTableModel->setDisplayAsMask( tempModelIndex, noMask );
        }
    }
}

void FolderTableView::slotSetFocus()
{
    setFocus();
}

void FolderTableView::slotApplyFilter( FolderTableModel* tableModel, QList< int > hiddenRows )
{
    bool anyRowsToHide( !hiddenRows.isEmpty() );
    
    if ( tableModel == folderTableModel )
    {
        if ( anyRowsToHide )
        {
            setRowsHidden( hiddenRows, true );
        }
        else
        {
            showAllRows();
        }
        folderTableModel->setFiltered( anyRowsToHide );
    }
}
