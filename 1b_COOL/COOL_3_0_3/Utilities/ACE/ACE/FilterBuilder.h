#ifndef FILTERBUILDER_H
#define FILTERBUILDER_H

#include <QtCore/QList>
#include <QtCore/QMultiHash>
#include <QtGui/QDockWidget>

#include "ACE/ui_FilterBuilder_BASE.h"
#include "ACE/FilterEntry.h"

class FolderTableModel;
class QScrollArea;
class QPushButton;


class FilterBuilder : public QWidget, private Ui::FilterBuilder_BASE
{
    Q_OBJECT
    friend class FilterEntry;

public:
    FilterBuilder( QWidget* parent = 0, Qt::WindowFlags f = 0 );
    ~FilterBuilder();
    QList< int > applyFilter( FolderTableModel* tableModel, bool allChannels = true, int rowStartPos = -1, int rowEndPos = -1 );

private:
    QList< FilterEntry* > filterEntryList;
    QMultiHash< FolderTableModel*, int > filterColumnPositions;
    FolderTableModel* currentTableModel;
    QScrollArea* filterEntryScrollArea;
    QWidget* filterEntryScrollAreaWidget;
    QVBoxLayout* filterEntryScrollAreaWidget_Layout;
    QSpacerItem* spacerItem_ScrollAreaWidget;

    void updateColumnComboBox();
    int filterEntryCount( bool activeOnly = false );
    void fillColumn( FilterEntry* filterEntry, FolderTableModel* tableModel );

signals:
    void applyClicked( FolderTableModel*, QList< int > ); 

public slots:
    void slotAddFilterEntry();
    void slotRemoveFilterEntry( FilterEntry* filterEntry );
    void slotUpdateFilter( FolderTableModel* tableModel, QString folderName = "" );
    void slotUpdateTableView();
    void slotShowAll();
    void slotSaveColumnPositions();
    void slotClearCurrentTableModel( FolderTableModel* theModel );

};

#endif
