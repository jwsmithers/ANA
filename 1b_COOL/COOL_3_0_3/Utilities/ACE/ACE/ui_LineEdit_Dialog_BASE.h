/********************************************************************************
** Form generated from reading ui file 'LineEdit_Dialog_BASE.ui'
**
** Created: Wed Oct 31 21:25:19 2007
**      by: Qt User Interface Compiler version 4.3.1
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
********************************************************************************/

#ifndef UI_LINEEDIT_DIALOG_BASE_H
#define UI_LINEEDIT_DIALOG_BASE_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QDialog>
#include <QtGui/QDialogButtonBox>
#include <QtGui/QGridLayout>
#include <QtGui/QLabel>
#include <QtGui/QLineEdit>

class Ui_LineEdit_Dialog_BASE
{
public:
    virtual ~Ui_LineEdit_Dialog_BASE(){}
    QGridLayout *gridLayout;
    QLabel *label_Question;
    QLineEdit *lineEdit;
    QDialogButtonBox *buttonBox;

    void setupUi(QDialog *LineEdit_Dialog_BASE)
    {
    if (LineEdit_Dialog_BASE->objectName().isEmpty())
        LineEdit_Dialog_BASE->setObjectName(QString::fromUtf8("LineEdit_Dialog_BASE"));
    LineEdit_Dialog_BASE->setWindowModality(Qt::WindowModal);
    LineEdit_Dialog_BASE->resize(387, 73);
    QSizePolicy sizePolicy(QSizePolicy::Maximum, QSizePolicy::Fixed);
    sizePolicy.setHorizontalStretch(0);
    sizePolicy.setVerticalStretch(0);
    sizePolicy.setHeightForWidth(LineEdit_Dialog_BASE->sizePolicy().hasHeightForWidth());
    LineEdit_Dialog_BASE->setSizePolicy(sizePolicy);
    LineEdit_Dialog_BASE->setSizeGripEnabled(false);
    LineEdit_Dialog_BASE->setModal(true);
    gridLayout = new QGridLayout(LineEdit_Dialog_BASE);
    gridLayout->setObjectName(QString::fromUtf8("gridLayout"));
    label_Question = new QLabel(LineEdit_Dialog_BASE);
    label_Question->setObjectName(QString::fromUtf8("label_Question"));

    gridLayout->addWidget(label_Question, 0, 0, 1, 1);

    lineEdit = new QLineEdit(LineEdit_Dialog_BASE);
    lineEdit->setObjectName(QString::fromUtf8("lineEdit"));

    gridLayout->addWidget(lineEdit, 0, 1, 1, 1);

    buttonBox = new QDialogButtonBox(LineEdit_Dialog_BASE);
    buttonBox->setObjectName(QString::fromUtf8("buttonBox"));
    buttonBox->setOrientation(Qt::Horizontal);
    buttonBox->setStandardButtons(QDialogButtonBox::Cancel|QDialogButtonBox::NoButton|QDialogButtonBox::Ok);
    buttonBox->setCenterButtons(false);

    gridLayout->addWidget(buttonBox, 1, 0, 1, 2);


    retranslateUi(LineEdit_Dialog_BASE);
    QObject::connect(buttonBox, SIGNAL(accepted()), LineEdit_Dialog_BASE, SLOT(accept()));
    QObject::connect(buttonBox, SIGNAL(rejected()), LineEdit_Dialog_BASE, SLOT(reject()));

    QMetaObject::connectSlotsByName(LineEdit_Dialog_BASE);
    } // setupUi

    void retranslateUi(QDialog *LineEdit_Dialog_BASE)
    {
    LineEdit_Dialog_BASE->setWindowTitle(QApplication::translate("LineEdit_Dialog_BASE", "Line Edit Dialog", 0, QApplication::UnicodeUTF8));
    label_Question->setText(QApplication::translate("LineEdit_Dialog_BASE", "Enter value:", 0, QApplication::UnicodeUTF8));
    Q_UNUSED(LineEdit_Dialog_BASE);
    } // retranslateUi

};

namespace Ui 
{
  class LineEdit_Dialog_BASE: public Ui_LineEdit_Dialog_BASE 
  {
  public:
    virtual ~LineEdit_Dialog_BASE(){}
  };
} // namespace Ui

#endif // UI_LINEEDIT_DIALOG_BASE_H
