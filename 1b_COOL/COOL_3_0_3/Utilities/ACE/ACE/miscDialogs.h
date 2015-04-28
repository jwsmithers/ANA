#include "ACE/ui_LineEdit_Dialog_BASE.h"

class QWidget;


class FillCellsDialog : public QDialog, public Ui::LineEdit_Dialog_BASE
{
    Q_OBJECT

public:
    FillCellsDialog( QWidget* parent = 0, Qt::WindowFlags f = 0 );
    ~FillCellsDialog() {};
    QString text() const;
};

