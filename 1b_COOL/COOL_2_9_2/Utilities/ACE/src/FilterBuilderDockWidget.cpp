#include <QtCore/QString>
#include <QtCore/QtDebug>
#include <QtGui/QWidget>
#include <QtGui/QCloseEvent>
#include <QtGui/QMessageBox>
#include <QtGui/QSizePolicy>

#include "ACE/FilterBuilderDockWidget.h"


FilterBuilderDockWidget::FilterBuilderDockWidget( QWidget* parent, Qt::WindowFlags flags ) :
    QDockWidget( parent, flags )
{
    setWindowTitle( trUtf8( "Filter Builder" ) );
    setObjectName( QString::fromUtf8( "FilterBuilderDockWidget" ) );
    QSizePolicy sizePolicy( QSizePolicy::Expanding, QSizePolicy::Preferred );
    sizePolicy.setHorizontalStretch( 0 );
    sizePolicy.setVerticalStretch( 0 );
    sizePolicy.setHeightForWidth( this->sizePolicy().hasHeightForWidth() );
    setSizePolicy( sizePolicy );
    setMinimumSize( QSize( 450, 0) );
    setFocusPolicy( Qt::StrongFocus );
    this->setFeatures( QDockWidget::DockWidgetVerticalTitleBar | QDockWidget::DockWidgetMovable | QDockWidget::DockWidgetFloatable ); //QDockWidget::DockWidgetClosable
    this->setAllowedAreas( Qt::BottomDockWidgetArea | Qt::TopDockWidgetArea ); // Qt::NoDockWidgetArea | Qt::RightDockWidgetArea
//    setFloating( true );
    filterBuilder = new FilterBuilder( this );

    // Give the fully constructed filterBuilderWidget to the dock widget to manage.
    setWidget( filterBuilder );
}

FilterBuilderDockWidget::~FilterBuilderDockWidget()
{
    delete filterBuilder;
}
/*
void FilterBuilderDockWidget::focusInEvent( QFocusEvent* event )
{
    event->accept();
    filterBuilder->setFocus();
//    emit changeFocusToFilterBuilder();
}

void FilterBuilderDockWidget::closeEvent( QCloseEvent* event )
{
    if ( folderTableModel == 0 )
    {
        event->accept();
        return;
    }

    if ( folderTableModel->getRootTableItem()->anyNew() )
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
        
        if ( reply == QMessageBox::No )
        {
            event->accept();
            return;
        }
        
        if ( reply == QMessageBox::Cancel )
        {
            event->ignore();
            return;
        }
    }
    event->accept();
}
*/

