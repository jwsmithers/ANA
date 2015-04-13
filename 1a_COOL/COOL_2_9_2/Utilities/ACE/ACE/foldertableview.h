#ifndef FOLDERTABLEVIEW_H
#define FOLDERTABLEVIEW_H

#include <QtCore/QHash>
#include <QtCore/QModelIndex>
#include <QtGui/QTableView>

class QContextMenuEvent;
class QItemSelectionModel;
class QWidget;
class FolderTableModel;
class FolderTableDelegate;
class FillCellsDialog;


class FolderTableView : public QTableView
{
    Q_OBJECT

public:
    FolderTableView( QWidget* parent, FolderTableModel* theModel );
    ~FolderTableView();
    void enableSorting( bool enabled = true );
    void setRowsHidden( QList< int > rows, bool hide );
    void showAllRows();

    FolderTableModel* getFolderTableModel() const;

protected:
    void contextMenuEvent( QContextMenuEvent* event );

private:
    enum SelectionCategories { oldRows, newRows, duplicateOldRows, duplicateNewRows };
    FolderTableModel* folderTableModel;
    FillCellsDialog* fillCellsDialog;
    QAction* actionClone;
    QAction* actionCommit;
    QAction* actionRemove;
    QAction* actionFillCells;
    QAction* actionDisplayAsDec;
    QAction* actionDisplayAsHex;
    QAction* actionDisplayAsOct;
    QAction* actionDisplayAsDateTime;
    QAction* actionDisplayAs_Remove;
    QItemSelectionModel* currentSelectionModel;
    FolderTableDelegate* folderTableDelegate;
    QHash< SelectionCategories, QModelIndexList > selectionInspectionResults;

    void createActions();
    int selectionRowCount( QModelIndexList& currentSelectionList );
    void testSelection( QModelIndexList& currentSelectionList );
    QModelIndexList excludeHiddenItems( QModelIndexList fullSelection );
    void focusInEvent( QFocusEvent* event );
    void focusOutEvent( QFocusEvent* event );

signals:
    void checkButtons( bool force = true );
    void updateFilterTarget( FolderTableModel*, QString );

private slots:
    void slotNewRow();
    void slotCommit();
    void slotRemove();
    void slotFillCells();
    void slotDisplayAsHex();
    void slotDisplayAsDec();
    void slotDisplayAsOct();
    void slotDisplayAs_Remove();
    void slotDisplayAsDateTime();
    void slotSetFocus();
    void slotApplyFilter( FolderTableModel* tableModel, QList< int > hiddenRows );

};

#endif

