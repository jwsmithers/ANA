#include <QtCore/QHash>
#include <QtCore/QModelIndex>
#include <QtCore/QString>

#include "ACE/ui_MainWindow_BASE.h"
#include "ACE/accesstocool.h"


class QTreeView;
class QCloseEvent;
class QDockWidget;
class FolderTreeModel;
class FolderTableModel;
class FolderTableDockWidget;
class FolderTableView;
class ConnectionDialog;
class FilterBuilderDockWidget;
class FolderOpenDialog;


class MainWindow : public QMainWindow, private Ui::MainWindow_BASE
{
    Q_OBJECT

public:
    MainWindow( QWidget* parent = 0 );
    ~MainWindow();

private:
    QHash< QModelIndex, FolderTableModel* > folderTableModels; // ModelIndex is for folder tree
    QHash< const FolderTableModel*, FolderTableDockWidget* > folderTableDockWidgets;
    QHash< FolderTreeModel*, QTreeView* > folderTreeViews;
    ConnectionDialog* connectionDialog;
    FolderOpenDialog* folderOpenDialog;
    FilterBuilderDockWidget* filterBuilderDockWidget;
    QWidget* defaultConnectionTab;
    unsigned int connectionCounter;

    void setConnections();
    void initialise_ACE_Settings();
    void closeEvent( QCloseEvent* event );
    void loadGUISettings();
    void saveGUISettings();
    bool commitAll( bool ask = false, FolderTableModel* thisModelOnly = NULL );
    void removeFolder( FolderTableModel* theModel, QModelIndex treeIndex = QModelIndex() );
    // Test routines
    void testRoutine();

public slots:
    void slotCreateFolderTable( const QModelIndex& fTreeIndex );
    void slotCreateFolderTree( cool::IDatabasePtr dbPtr, const QString connectionString );
    void slotConnectionOpen();
    void slotConnectionDisconnect();
    void slotFolderCommit();
    void slotFolderCommitAll();
    void slotFolderFilter( bool enabled );
    void slotTableModified( const FolderTableModel* modifiedModel, const bool changed );
    void slotCheckButtons( bool force = true );
    void slotRemoveFolder( FolderTableModel* theModel );
//    void slotRemoveFolderTable( const QModelIndex& fTreeIndex );
//    void slotRemoveFolderTree( int tabPos );


};

