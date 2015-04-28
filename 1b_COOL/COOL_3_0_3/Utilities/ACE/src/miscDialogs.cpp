#include "ACE/miscDialogs.h"


FillCellsDialog::FillCellsDialog( QWidget* parent, Qt::WindowFlags f ) :
    QDialog( parent, f )
{
    setupUi( this );
    setObjectName( QString::fromUtf8( "FillCellsDialog" ) );
    setWindowTitle( trUtf8( "Fill Cells Dialog" ) );
    label_Question->setText( trUtf8( "Fill selected cells with:" ) );
}

QString FillCellsDialog::text() const
{
    return lineEdit->text().trimmed();
}
