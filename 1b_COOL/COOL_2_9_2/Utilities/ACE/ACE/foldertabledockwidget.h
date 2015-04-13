#ifndef FOLDERTABLEDOCKWIDGET_H
#define FOLDERTABLEDOCKWIDGET_H

#include <QtGui/QDockWidget>

#include <ACE/foldertablemodel.h>

class QWidget;
class QCloseEvent;


class FolderTableDockWidget : public QDockWidget
{
    Q_OBJECT

public:
    FolderTableDockWidget( /*const QString& folderName, int folderNumber,*/ QWidget* parent = 0, Qt::WindowFlags flags = 0 );
    ~FolderTableDockWidget();
    void setTableModel( FolderTableModel* model );

private:
    FolderTableModel* folderTableModel;
    void closeEvent( QCloseEvent* event );
    void focusInEvent( QFocusEvent* event );

signals:
    void changeFocusToTable();
    void folderTableDockWidgetClose( FolderTableModel* );
};

#endif

