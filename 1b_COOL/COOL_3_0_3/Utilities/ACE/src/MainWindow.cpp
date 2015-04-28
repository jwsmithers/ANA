#ifndef WIN32
#ifndef __APPLE__
#include <QtCore/QtDebug>
#include <QtCore/QObject>
#include <QtCore/QSettings>
#include <QtCore/QCoreApplication>
#include <QtCore/QPoint>
#include <QtCore/QSize>
#include <QtCore/QByteArray>
#include <QtGui/QDockWidget>
#include <QtGui/QHBoxLayout>
#include <QtGui/QVBoxLayout>
#include <QtGui/QTreeView>
#include <QtGui/QCloseEvent>
#include <QtGui/QMessageBox>

#include "ACE/MainWindow.h"
#include "ACE/foldertreemodel.h"
#include "ACE/foldertablemodel.h"
#include "ACE/foldertableview.h"
#include "ACE/foldertabledockwidget.h"
#include "ACE/ConnectionDialog.h"
#include "ACE/FilterBuilderDockWidget.h"
#include "ACE/FolderOpenDialog.h"
#include "ACE/ACE_Errors.h"

#include "CoolKernel/../src/scoped_enums.h"

MainWindow::MainWindow( QWidget *parent ): 
    QMainWindow( parent ),
    connectionCounter( 0 )
{
    setupUi( this );
    initialise_ACE_Settings();
    loadGUISettings();
    defaultConnectionTab = tabWidget_Connections->widget( 0 );
    connectionDialog = new ConnectionDialog( this );
    folderOpenDialog = new FolderOpenDialog( this );
    filterBuilderDockWidget = new FilterBuilderDockWidget( this );
    addDockWidget( Qt::TopDockWidgetArea, filterBuilderDockWidget );
    filterBuilderDockWidget->hide();
    setConnections(); // Qt connections
}

MainWindow::~MainWindow()
{
    QSettings settings;
    delete filterBuilderDockWidget;
    delete folderOpenDialog;
    delete connectionDialog;
    qDeleteAll( folderTreeViews );
    qDeleteAll( folderTableModels );
    saveGUISettings();
}

void MainWindow::setConnections()
{
    QObject::connect( action_ConnectionOpen, SIGNAL( triggered() ), this, SLOT( slotConnectionOpen() ) );
    QObject::connect( action_FolderCommit, SIGNAL( triggered() ), this, SLOT( slotFolderCommit() ) );
    QObject::connect( connectionDialog, SIGNAL( buildFolderTree( cool::IDatabasePtr, const QString ) ), this, SLOT( slotCreateFolderTree( cool::IDatabasePtr, const QString ) ) );
    QObject::connect( action_FolderFilter, SIGNAL( toggled( bool ) ), this, SLOT( slotFolderFilter( bool ) ) );
    QObject::connect( action_FolderCommitAll, SIGNAL( triggered() ), this, SLOT( slotFolderCommitAll() ) );
    QObject::connect( action_ConnectionDisconnect, SIGNAL( triggered() ), this, SLOT( slotConnectionDisconnect() ) );

/*
    QObject::connect( action_ConnectionProperties, SIGNAL( triggered() ), this, SLOT( slotConnectionProperties() ) );
    QObject::connect( action_ConnectionRefresh, SIGNAL( triggered() ), this, SLOT( slotConnectionRefresh() ) );
    QObject::connect( action_FolderNew, SIGNAL( triggered() ), this, SLOT( slotFolderNew() ) );
    QObject::connect( action_FolderCopy, SIGNAL( triggered() ), this, SLOT( slotFolderCopy() ) );
    QObject::connect( action_FolderDelete, SIGNAL( triggered() ), this, SLOT( slotFolderDelete() ) );
    QObject::connect( action_FolderProperties, SIGNAL( triggered() ), this, SLOT( slotFolderProperties() ) );
*/
}

void MainWindow::initialise_ACE_Settings()
{
    QCoreApplication::setOrganizationName( "LCG" );
    QCoreApplication::setOrganizationDomain( "AA" );
    QCoreApplication::setApplicationName( "ACE" );
}

void MainWindow::loadGUISettings()
{
    QSettings settings;
    settings.beginGroup( objectName() );
    if ( settings.value( "maximised", false ).toBool() )
        showMaximized();
    else
    {
        resize( settings.value( "size", QSize( 400, 400 ) ).toSize() );
        move( settings.value( "pos", QPoint( 200, 200) ).toPoint() );
    }
    settings.endGroup();
}

void MainWindow::saveGUISettings()
{
    QSettings settings;
    settings.beginGroup( objectName() );
    settings.setValue( "size", size() );
    settings.setValue( "pos", pos() );
    settings.setValue( "maximised", isFullScreen() );
    settings.endGroup();
}

void MainWindow::closeEvent( QCloseEvent* event )
{
    if ( !commitAll( true ) )
    {
        int ret = QMessageBox::warning(
            this,
            trUtf8("Warning"),
            trUtf8("Not all folders were committed successfully.\n"
               "Continue to quit?"),
            QMessageBox::Yes | QMessageBox::No,
            QMessageBox::No);
        if ( ret == QMessageBox::No )
        {
            event->ignore();
            return;
        }
    }
    saveGUISettings();
    event->accept();
}

bool MainWindow::commitAll( bool ask, FolderTableModel* thisModelOnly )
{
    bool ok( true );
    int ret;
    foreach ( const FolderTableModel* model, folderTableDockWidgets.keys() )
    {
        FolderTableModel* tempTableModel = const_cast< FolderTableModel* >( model );
        if ( thisModelOnly && tempTableModel != thisModelOnly )
            continue;
        if ( tempTableModel->getRootTableItem()->anyNew() )
        {
            if ( ask )
            {
                ret = QMessageBox::question(
                          this, 
                          trUtf8( "Folder modified" ),
                          QString( "Save changes to:\n%1?" ).arg( folderTableDockWidgets[ tempTableModel ]->windowTitle() ),
                          QMessageBox::Yes | QMessageBox::No, 
                          QMessageBox::Yes );
                if ( ret == QMessageBox::No ) // leave ok as true
                    continue;
            }
            setCursor( Qt::WaitCursor );
            if ( !tempTableModel->commit() )
            {
                ok = false;
                unsetCursor();
                ret = QMessageBox::warning(
                          this, 
                          trUtf8( "Commit failed!" ),
                          QString( "Could not commit\n%1\n\n%2" ).arg( folderTableDockWidgets[ tempTableModel ]->windowTitle() ).arg( "Continue to commit remaining folders?" ),
                          QMessageBox::Yes | QMessageBox::No, 
                          QMessageBox::Yes );
                if ( ret == QMessageBox::No )
                    break;
            }
            unsetCursor();
        }
    }
    slotCheckButtons();
    unsetCursor();
    return ok;
}

void MainWindow::slotFolderCommitAll()
{
    commitAll();
}

void MainWindow::slotFolderCommit()
{
    FolderTableModel* tempTableModel;
    if ( FolderTableView* tempFolderView = dynamic_cast< FolderTableView* >( QApplication::focusWidget() ) )
    {
        try
        {
            tempTableModel = tempFolderView->getFolderTableModel();
        }
        catch ( ... )
        {
            return;
        }
        setCursor( Qt::WaitCursor );
        if ( !tempTableModel->commit() )
        {
            QMessageBox::warning(
                this, 
                folderTableDockWidgets[ tempTableModel ]->windowTitle(),
                trUtf8( "Commit failed!" ),
                QMessageBox::Ok, 
                QMessageBox::Ok );
        }
        unsetCursor();
    }
    slotCheckButtons();
}

void MainWindow::slotCheckButtons( bool force )
{
    bool tBool( false );
    static QWidget* prevWidget = NULL; 
    
    if ( prevWidget == QApplication::focusWidget() )
    {
        if ( !force )
        {
            return;
        }
    }
    else
    {
        prevWidget = QApplication::focusWidget();
    }
//    action_ConnectionCopy->setEnabled( false );
//    action_ConnectionProperties->setEnabled( false );
//    action_ConnectionDisconnect->setEnabled( false );
//    action_ConnectionRefresh->setEnabled( false );
//    action_FolderNew->setEnabled( false );
//    action_FolderCopy->setEnabled( false );
//    action_FolderDelete->setEnabled( false );
//    action_FolderProperties->setEnabled( false );

    // Filter and commit action
    FolderTableModel* tempTableModel = NULL;

    if ( FolderTableView* tempFolderView = dynamic_cast< FolderTableView* >( prevWidget ) )
    {
        try
        {
            tempTableModel = tempFolderView->getFolderTableModel();
            action_FolderCommit->setEnabled( tempTableModel->getRootTableItem()->anyNew() );
//            action_FolderFilter->setEnabled( true );
//            action_FolderFilter->setChecked( tempTableModel->getRootTableItem()->isFiltered() );
;
        }
        catch ( ... )
        {
//            action_FolderFilter->setEnabled( false );
            action_FolderCommit->setEnabled( false );
        }
    }
    else
    {
//        action_FolderFilter->setEnabled( false );
        action_FolderCommit->setEnabled( false );
    }

    // Commit all action
    tBool = false;
    foreach ( const FolderTableModel* model, folderTableDockWidgets.keys() )
    {
        if ( model->getRootTableItem()->anyNew() )
        {
            tBool = true;
            break;
        }
    }
    action_FolderCommitAll->setEnabled( tBool );
}

void MainWindow::removeFolder( FolderTableModel* theModel, QModelIndex treeIndex )
{
    if ( treeIndex.isValid() )
    {
        // Remove tree index and folderTableModel association
        folderTableModels.remove( treeIndex );
        // Remove folderTableModel and dock widget association.
        // Delete dock widgets. FolderTableViews should be destroyed as well.
        FolderTableDockWidget* dockWidget = folderTableDockWidgets.value( theModel );
        folderTableDockWidgets.remove( theModel );
        removeDockWidget( dockWidget );
        delete dockWidget;
        delete theModel; // FolderTableItems deleted as well.
    }
    else
    {
        // Loop through ALL folder table models.
        QHashIterator< QModelIndex, FolderTableModel* > i( folderTableModels );
        while ( i.hasNext() )
        {
            i.next();
            if ( i.value() == theModel )
            {
                // Remove tree index and folderTableModel association
                folderTableModels.remove( i.key() );
                // Remove folderTableModel and dock widget association.
                // Delete dock widgets. FolderTableViews should be destroyed as well.
                FolderTableDockWidget* dockWidget = folderTableDockWidgets.value( theModel );
                folderTableDockWidgets.remove( theModel );
                removeDockWidget( dockWidget );
                delete dockWidget;
                delete theModel; // FolderTableItems deleted as well.
                return;
            }
        }
    }
}

void MainWindow::slotRemoveFolder( FolderTableModel* theModel )
{
    removeFolder( theModel );
}

void MainWindow::slotConnectionDisconnect()
{
    int ret;
    bool saveChanges( true );

    // Get the current tab widget and get access to its associated tree view
    QWidget* tabWidget = tabWidget_Connections->currentWidget();
    if ( tabWidget == defaultConnectionTab )
        return;
    QTreeView* currentTreeView = tabWidget->findChild< QTreeView* >();
    FolderTreeModel* currentTreeModel = static_cast< FolderTreeModel* >( currentTreeView->model() );
    
    // Check if the connection has folders that have been modified.
    if ( currentTreeModel->isModified() )
    {
        ret = QMessageBox::information(
                  this,
                  trUtf8( "Folder(s) modified" ),
                  trUtf8( "Commit changes before disconnection?" ),
                  QMessageBox::Yes | QMessageBox::No, 
                  QMessageBox::Yes );
        if ( ret == QMessageBox::No )
            saveChanges = false;
    }

    // Loop through ALL folder table models.
    // Commit those that have been modified and close every one.
    QHashIterator< QModelIndex, FolderTableModel* > i( folderTableModels );
    while ( i.hasNext() )
    {
        i.next();
        // Check if current iteration's index and model pair is for current connection.
        if ( const_cast< FolderTreeModel* >( dynamic_cast< const FolderTreeModel* >( i.key().model() ) ) != currentTreeModel )
            continue;

        if ( saveChanges && currentTreeModel->getModifiedFolders().contains( i.key() ) )
        {
            if ( !commitAll( false, i.value() ) ) // failure in a commit.
                return;
        }

        removeFolder( i.value(), i.key() );

/*        
        // Remove tree index and folderTableModel association
        folderTableModels.remove( i.key() );
        // Remove folderTableModel and dock widget association.
        // Delete dock widgets. FolderTableViews should be destroyed as well.
        FolderTableDockWidget* dockWidget = folderTableDockWidgets.value( i.value() );
        folderTableDockWidgets.remove( i.value() );
        removeDockWidget( dockWidget );
        delete dockWidget;
        delete i.value(); // FolderTableItems deleted as well.
*/
    }
    
    // *Tree-related deletions* -------------------
    // Remove the hash entry from folderTreeViews.
    // Delete the tree model object the tree view object. 
    folderTreeViews.remove( currentTreeModel );
    delete currentTreeView;
    
    connectionDialog->closeConnection( currentTreeModel->coolConnectionString );
    delete currentTreeModel; // tree items are deleted recursively in the model's destructor.
    
    // Remove the tab from the tab widget. Does not delete the tab and its contents.
    tabWidget_Connections->setUpdatesEnabled( false );
    tabWidget_Connections->removeTab( tabWidget_Connections->currentIndex() );
    // Check if last tab removed. Show the blank tab.
    if ( tabWidget_Connections->count() == 0 )
    {
        tabWidget_Connections->addTab( defaultConnectionTab, trUtf8( "No current connection" ) );
    }
    tabWidget_Connections->setUpdatesEnabled( true );
    delete tabWidget;
    action_ConnectionDisconnect->setEnabled( connectionDialog->isConnected() );
    // ---------------------------------------------
}

void MainWindow::slotCreateFolderTree( cool::IDatabasePtr dbPtr, const QString connectionString )
{
    int tabIndex = 0;
    QSettings settings;
    connectionCounter++;

    // Create model
    setCursor( Qt::WaitCursor );
    FolderTreeModel* folderTreeModel = new FolderTreeModel( dbPtr, connectionString );
    unsetCursor();
    // Create the view components
    QWidget* tab_Connection = new QWidget();
    
    tab_Connection->setObjectName( QString::fromUtf8( "DB Connect " ).append( QString::number( connectionCounter ) ) );

    QHBoxLayout* hboxLayout = new QHBoxLayout( tab_Connection );
    hboxLayout->setObjectName( QString::fromUtf8( "hboxLayout" ).append( QString::number( connectionCounter ) ) );
    QTreeView* treeView_Folders = new QTreeView( tab_Connection );
    treeView_Folders->setModel( folderTreeModel );
    settings.beginGroup( "Preferences/FolderTrees" );
    if ( settings.value( "ExpandAll", true ).toBool() )
    {
        treeView_Folders->expandAll();
    }
    settings.endGroup(); // Preferences/FolderTrees
    treeView_Folders->setObjectName( QString::fromUtf8( "COOL DB " ).append( QString::number( connectionCounter ) ) );
    treeView_Folders->show();
    folderTreeViews[ folderTreeModel ] = treeView_Folders;

    hboxLayout->addWidget( treeView_Folders );

    // Update the tab widget with the newly created tab.
    tabWidget_Connections->setUpdatesEnabled( false );
    if ( tabWidget_Connections->count() == 1 && tabWidget_Connections->widget( 0 ) == defaultConnectionTab )
    {
        tabWidget_Connections->removeTab( 0 );
    }

    tabIndex = tabWidget_Connections->addTab( tab_Connection, QString::fromUtf8( "DB Connect " ).append( QString::number( connectionCounter ) ) );
    tabWidget_Connections->setUpdatesEnabled( true );
    
    tabWidget_Connections->setTabToolTip( tabIndex, connectionString );

    QObject::connect( treeView_Folders, SIGNAL( doubleClicked( const QModelIndex& ) ), this, SLOT( slotCreateFolderTable( const QModelIndex& ) ) );
    action_ConnectionDisconnect->setEnabled( connectionDialog->isConnected() );
}

void MainWindow::slotCreateFolderTable( const QModelIndex& fTreeIndex )
{
    // Test routine (TO BE REMOVED)
    // testRoutine();
    // ----------------------------
    
    if ( folderTableModels.contains( fTreeIndex ) )
    {
        folderTableDockWidgets[ folderTableModels[ fTreeIndex ] ]->show();
        return;
    }
    const FolderTreeModel* folderTreeModel = static_cast< const FolderTreeModel* >( fTreeIndex.model() );
    const QString& fName = folderTreeModel->folderName( fTreeIndex );
    setCursor( Qt::WaitCursor );
    if ( !folderTreeModel->getCoolDBPtr()->existsFolder( fName.toStdString() ) )
    {
        unsetCursor();
        return;
    }
    cool::IFolderPtr folderPtr = folderTreeModel->getCoolDBPtr()->getFolder( fName.toStdString() );

/*    cool::FolderVersioning::Mode vm( folderPtr->versioningMode() );
    if ( vm == cool::cool_FolderVersioning_Mode::MULTI_VERSION )
    {
        QMessageBox::warning(
            this, 
            trUtf8( "Folder Versioning" ),
            trUtf8( "MULTI_VERSION" ),
            QMessageBox::Ok, 
            QMessageBox::Ok );
    }
    else if ( vm == cool::cool_FolderVersioning_Mode::SINGLE_VERSION )
    {
        QMessageBox::warning(
            this, 
            trUtf8( "Folder Versioning" ),
            trUtf8( "SINGLE_VERSION" ),
            QMessageBox::Ok, 
            QMessageBox::Ok );
    }
    else if ( vm == cool::cool_FolderVersioning_Mode::NONE )
    {
        QMessageBox::warning(
            this, 
            trUtf8( "Folder Versioning" ),
            trUtf8( "NONE" ),
            QMessageBox::Ok, 
            QMessageBox::Ok );
    }
*/

    folderOpenDialog->prepare( folderPtr, fName );
    if ( !folderOpenDialog->exec() )
    {
        unsetCursor();
        return;
    }

    FolderTableModel* folderTableModel;
    try
    {
        folderTableModel = new FolderTableModel( folderPtr, folderOpenDialog->getVKEncoding(), folderOpenDialog->getSinceIOV(), cool::ValidityKeyMax, folderOpenDialog->getChannelSelection(), folderOpenDialog->getTag() );
    }
    catch ( ace_errors::EmptyFolder& )
    {
        QMessageBox::warning(
            this, 
            trUtf8( "Error" ),
            trUtf8( "Folder is empty!" ),
            QMessageBox::Ok, 
            QMessageBox::Ok );
        unsetCursor();
        return;
    }
    catch ( ... )
    {
        QMessageBox::warning(
            this, 
            trUtf8( "Unexpected Error" ),
            trUtf8( "Table could not be constructed!" ),
            QMessageBox::Ok, 
            QMessageBox::Ok );
        unsetCursor();
        return;
    }

    FolderTableDockWidget* dockWidget_Table = new FolderTableDockWidget( this );
    dockWidget_Table->setWindowTitle( trUtf8( "%1:%2[*]" ).arg( folderTableModels.size() ).arg( fName ) );
    //dockWidget_Table->setObjectName( trUtf8( "dockWidget_Table%1" ).arg( folderNumber ) );
    dockWidget_Table->setToolTip( folderOpenDialog->getFolderCharacteristics() );
    dockWidget_Table->setTableModel( folderTableModel );
    QWidget* dockWidgetContents_Table = new QWidget( dockWidget_Table );
    dockWidgetContents_Table->setObjectName( QString::fromUtf8( "dockWidgetContents_Table" ).append( QString::number( folderTableModels.size() ) ) );
    QVBoxLayout* vboxLayout = new QVBoxLayout( dockWidgetContents_Table );
    vboxLayout->setObjectName( QString::fromUtf8( "vboxLayout" ).append( QString::number( folderTableModels.size() ) ) );
    vboxLayout->setContentsMargins( 0, 0, 0, 0 );
    FolderTableView* tableView_Folder = new FolderTableView( dockWidgetContents_Table, folderTableModel );
    tableView_Folder->setObjectName( dockWidget_Table->windowTitle() );
    tableView_Folder->setMinimumSize( QSize( 400, 0 ) );
    tableView_Folder->show();
    folderTableModels[ fTreeIndex ] = folderTableModel;
    folderTableDockWidgets[ folderTableModel ] = dockWidget_Table;
    vboxLayout->addWidget( tableView_Folder );

    dockWidget_Table->setWidget( dockWidgetContents_Table );

    // Enable connections
    QObject::connect( folderTableModel, SIGNAL( modelChanged( const FolderTableModel*, bool ) ), this, SLOT( slotTableModified( const FolderTableModel*, bool ) ) );
    QObject::connect( tableView_Folder, SIGNAL( checkButtons( bool ) ), this, SLOT( slotCheckButtons( bool ) ) );
    QObject::connect( tableView_Folder, SIGNAL( updateFilterTarget( FolderTableModel*, QString ) ), filterBuilderDockWidget->filterBuilder, SLOT( slotUpdateFilter( FolderTableModel*, QString ) ) );
    QObject::connect( dockWidget_Table, SIGNAL( folderTableDockWidgetClose( FolderTableModel* ) ), filterBuilderDockWidget->filterBuilder, SLOT( slotClearCurrentTableModel( FolderTableModel* ) ) );
    QObject::connect( dockWidget_Table, SIGNAL( folderTableDockWidgetClose( FolderTableModel* ) ), this, SLOT( slotRemoveFolder( FolderTableModel* ) ) );
    QObject::connect( filterBuilderDockWidget->filterBuilder, SIGNAL( applyClicked( FolderTableModel*, QList< int > ) ), tableView_Folder, SLOT( slotApplyFilter( FolderTableModel*, QList< int > ) ) );
    QObject::connect( dockWidget_Table, SIGNAL( changeFocusToTable() ), tableView_Folder, SLOT( slotSetFocus() ) );
    

    // Position sensitive.... connections have to be set up bas addDockWidget will result in emmissions.
    addDockWidget( Qt::RightDockWidgetArea, dockWidget_Table );
    unsetCursor();
    dockWidget_Table->setFocus();
    slotCheckButtons();
}

void MainWindow::slotConnectionOpen()
{
    connectionDialog->exec();
}

void MainWindow::slotFolderFilter( bool enabled )
{
    if ( enabled )
    {
        filterBuilderDockWidget->show();
    }
    else
    {
        filterBuilderDockWidget->hide();
    }
/*    
    FolderTableModel* tempTableModel;
    if ( FolderTableView* tempFolderView = dynamic_cast< FolderTableView* >( QApplication::focusWidget() ) )
    {
        try
        {
            tempTableModel = tempFolderView->getFolderTableModel();
        }
        catch ( ... )
        {
            return;
        }
        if ( enabled )
//            tempFolderView->setRowsHidden( tempTableModel->filter_mres(), true );
            tempFolderView->setRowsHidden( filterBuilderDockWidget->filterBuilder->applyFilter( tempTableModel ), true );
        else
            tempFolderView->showAllRows();
    }
    slotCheckButtons();
*/
}

void MainWindow::slotTableModified( const FolderTableModel* modifiedModel, const bool changed )
{
    folderTableDockWidgets[ modifiedModel ]->setWindowModified( changed );
    QHashIterator< QModelIndex, FolderTableModel* > i( folderTableModels );
    while ( i.hasNext() )
    {
        i.next();
        if ( modifiedModel == i.value() )
        {
            // Very ugly!!!
            FolderTreeModel* folderTreeModel = const_cast< FolderTreeModel* >( dynamic_cast< const FolderTreeModel* >( i.key().model() ) );
            folderTreeModel->emitDataChanged( i.key(), changed );
            break;
        }
    }
}

void MainWindow::testRoutine()
{

//    cool::DatabaseId dbId("sqlite://;schema=/afs/cern.ch/user/c/ctan/mytest.sqlite;dbname=COOLTEST"); // Old-style
//    cool::DatabaseId dbId("sqlite_file:/afs/cern.ch/user/c/ctan/mytest.sqlite/COOLTEST");  // CORAL-aware
    cool::DatabaseId dbId("ACETEST1/TEST");  // CORAL-aware and alias
    cool::IDatabasePtr dbPtr;
    if ( !cool::openDatabase( dbId, dbPtr ) )
    {
        qDebug() << "Oops! test database could not be opened.";
        return;
    }
    dbPtr->getFolder( "/folder_1" );
    qDebug() << "testRoutine: Opened test database successful. Folder retrieved as well." ;
}

// Disable icc warning #1419: external declaration in primary source file
#ifdef __ICC
#pragma warning( push )
#pragma warning( disable: 1419 )
#endif

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    Q_INIT_RESOURCE(icons);
    MainWindow mainWin;
    mainWin.show();
    return app.exec();
}

// Reenable icc warning 1419
#ifdef __ICC
#pragma warning( pop )
#endif

#else
#include <iostream>

int main( int, char** )
{
  std::cout << "ACE is not supported on MacOSX!" << std::endl;
  return 1;
}

#endif

#else
#include <iostream>

int main( int, char** )
{
  std::cout << "ACE is not supported on Windows!" << std::endl;
  return 1;
}

#endif
