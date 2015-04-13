#include <QtCore/QString>
#include <QtCore/QtDebug>
#include <QtGui/QWidget>
#include <QtGui/QCloseEvent>
#include <QtGui/QMessageBox>
#include <QtGui/QSizePolicy>

#include <ACE/foldertabledockwidget.h>


FolderTableDockWidget::FolderTableDockWidget( /*const QString& folderName, int folderNumber,*/ QWidget* parent, Qt::WindowFlags flags ) :
    QDockWidget( parent, flags ),
    folderTableModel( 0 )
{
//    setWindowTitle( tr( "%1:%2[*]" ).arg( folderNumber ).arg( folderName ) );
//    setObjectName( QString::fromUtf8( "dockWidget_Table" ).append( QString::number( folderNumber ) ) );
    QSizePolicy sizePolicy( QSizePolicy::Expanding, QSizePolicy::Preferred );
    sizePolicy.setHorizontalStretch( 0 );
    sizePolicy.setVerticalStretch( 0 );
    sizePolicy.setHeightForWidth( this->sizePolicy().hasHeightForWidth() );
    setSizePolicy( sizePolicy );
    setMinimumSize( QSize( 450, 0) );
    setFocusPolicy( Qt::StrongFocus );
    this->setFeatures( QDockWidget::DockWidgetClosable | QDockWidget::DockWidgetMovable | QDockWidget::DockWidgetFloatable );
    this->setAllowedAreas( Qt::BottomDockWidgetArea | Qt::RightDockWidgetArea | Qt::TopDockWidgetArea ); // Qt::NoDockWidgetArea
}

FolderTableDockWidget::~FolderTableDockWidget()
{
    // Notify filterBuilder to clear is currentTableFolder pointer if applicable.
    emit folderTableDockWidgetClose( folderTableModel );
}

void FolderTableDockWidget::focusInEvent( QFocusEvent* /*event*/ )
{
    emit changeFocusToTable();
}

void FolderTableDockWidget::closeEvent( QCloseEvent* event )
{
    if ( folderTableModel != 0 && folderTableModel->getRootTableItem()->anyNew() )
    {
        int reply = QMessageBox::warning(
                        this, 
                        tr( "Save" ),
                        tr( "Newly cloned entries have not been commited.\nDo you wish to commit them?" ),
                        QMessageBox::Yes | QMessageBox::No | QMessageBox::Cancel, 
                        QMessageBox::Yes );
        if ( reply == QMessageBox::Yes )
        {
            while ( reply == QMessageBox::Yes && !folderTableModel->commit() )
            {
                switch ( QMessageBox::critical(
                    this, 
                    tr( "Unexpected Error" ),
                    tr( "Failure encountered whilst commiting!" ),
                    QMessageBox::Retry | QMessageBox::Discard | QMessageBox::Cancel,
                    QMessageBox::Retry ) )
                {
                case QMessageBox::Retry:
                    continue;
                case QMessageBox::Discard:
                    reply = QMessageBox::No;
                    break;
                case QMessageBox::Cancel:
                    reply = QMessageBox::Cancel;
                    break;
                default:
                    reply = QMessageBox::Cancel;
                    break;
                } // end switch statement
            }
        }
        if ( reply == QMessageBox::Cancel )
        {
            event->ignore();
            return;
        }
    }
    // Notify filterBuilder to clear is currentTableFolder pointer if applicable.
    emit folderTableDockWidgetClose( folderTableModel );
    event->accept();
}

void FolderTableDockWidget::setTableModel( FolderTableModel* model )
{
    folderTableModel = model;
}

