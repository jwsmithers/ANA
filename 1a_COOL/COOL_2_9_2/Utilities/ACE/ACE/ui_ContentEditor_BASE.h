/********************************************************************************
** Form generated from reading ui file 'ContentEditor_BASE.ui'
**
** Created: Tue Sep 9 03:51:33 2008
**      by: Qt User Interface Compiler version 4.3.3
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
********************************************************************************/

#ifndef UI_CONTENTEDITOR_BASE_H
#define UI_CONTENTEDITOR_BASE_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QComboBox>
#include <QtGui/QDialog>
#include <QtGui/QGroupBox>
#include <QtGui/QHBoxLayout>
#include <QtGui/QLabel>
#include <QtGui/QPushButton>
#include <QtGui/QSpacerItem>
#include <QtGui/QTextEdit>
#include <QtGui/QVBoxLayout>

class Ui_ContentEditor_BASE
{
public:
    virtual ~Ui_ContentEditor_BASE(){}
    QVBoxLayout *vboxLayout;
    QGroupBox *groupBox_ViewContentAs;
    QHBoxLayout *hboxLayout;
    QSpacerItem *spacerItem;
    QLabel *label_ViewAsType;
    QComboBox *comboBox_ContentType;
    QTextEdit *textEdit;
    QHBoxLayout *hboxLayout1;
    QPushButton *pushButton_Revert;
    QSpacerItem *spacerItem1;
    QPushButton *pushButton_Export;
    QPushButton *pushButton_Browse;
    QPushButton *pushButton_Cancel;
    QPushButton *pushButton_OK;

    void setupUi(QDialog *ContentEditor_BASE)
    {
    if (ContentEditor_BASE->objectName().isEmpty())
        ContentEditor_BASE->setObjectName(QString::fromUtf8("ContentEditor_BASE"));
    ContentEditor_BASE->setWindowModality(Qt::WindowModal);
    ContentEditor_BASE->resize(424, 286);
    ContentEditor_BASE->setSizeGripEnabled(true);
    vboxLayout = new QVBoxLayout(ContentEditor_BASE);
    vboxLayout->setSpacing(0);
    vboxLayout->setObjectName(QString::fromUtf8("vboxLayout"));
    vboxLayout->setContentsMargins(0, 0, 0, 0);
    groupBox_ViewContentAs = new QGroupBox(ContentEditor_BASE);
    groupBox_ViewContentAs->setObjectName(QString::fromUtf8("groupBox_ViewContentAs"));
    QSizePolicy sizePolicy(QSizePolicy::Preferred, QSizePolicy::Fixed);
    sizePolicy.setHorizontalStretch(0);
    sizePolicy.setVerticalStretch(0);
    sizePolicy.setHeightForWidth(groupBox_ViewContentAs->sizePolicy().hasHeightForWidth());
    groupBox_ViewContentAs->setSizePolicy(sizePolicy);
    groupBox_ViewContentAs->setFlat(true);
    hboxLayout = new QHBoxLayout(groupBox_ViewContentAs);
    hboxLayout->setObjectName(QString::fromUtf8("hboxLayout"));
    hboxLayout->setContentsMargins(0, 0, 0, 0);
    spacerItem = new QSpacerItem(41, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

    hboxLayout->addItem(spacerItem);

    label_ViewAsType = new QLabel(groupBox_ViewContentAs);
    label_ViewAsType->setObjectName(QString::fromUtf8("label_ViewAsType"));
    label_ViewAsType->setTextFormat(Qt::PlainText);

    hboxLayout->addWidget(label_ViewAsType);

    comboBox_ContentType = new QComboBox(groupBox_ViewContentAs);
    comboBox_ContentType->setObjectName(QString::fromUtf8("comboBox_ContentType"));

    hboxLayout->addWidget(comboBox_ContentType);


    vboxLayout->addWidget(groupBox_ViewContentAs);

    textEdit = new QTextEdit(ContentEditor_BASE);
    textEdit->setObjectName(QString::fromUtf8("textEdit"));
    textEdit->viewport()->setProperty("cursor", QVariant(QCursor(Qt::IBeamCursor)));
    textEdit->setLineWrapMode(QTextEdit::WidgetWidth);

    vboxLayout->addWidget(textEdit);

    hboxLayout1 = new QHBoxLayout();
    hboxLayout1->setObjectName(QString::fromUtf8("hboxLayout1"));
    pushButton_Revert = new QPushButton(ContentEditor_BASE);
    pushButton_Revert->setObjectName(QString::fromUtf8("pushButton_Revert"));
    pushButton_Revert->setEnabled(false);

    hboxLayout1->addWidget(pushButton_Revert);

    spacerItem1 = new QSpacerItem(0, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

    hboxLayout1->addItem(spacerItem1);

    pushButton_Export = new QPushButton(ContentEditor_BASE);
    pushButton_Export->setObjectName(QString::fromUtf8("pushButton_Export"));
    pushButton_Export->setEnabled(false);

    hboxLayout1->addWidget(pushButton_Export);

    pushButton_Browse = new QPushButton(ContentEditor_BASE);
    pushButton_Browse->setObjectName(QString::fromUtf8("pushButton_Browse"));
    pushButton_Browse->setEnabled(false);

    hboxLayout1->addWidget(pushButton_Browse);

    pushButton_Cancel = new QPushButton(ContentEditor_BASE);
    pushButton_Cancel->setObjectName(QString::fromUtf8("pushButton_Cancel"));

    hboxLayout1->addWidget(pushButton_Cancel);

    pushButton_OK = new QPushButton(ContentEditor_BASE);
    pushButton_OK->setObjectName(QString::fromUtf8("pushButton_OK"));
    pushButton_OK->setDefault(true);

    hboxLayout1->addWidget(pushButton_OK);


    vboxLayout->addLayout(hboxLayout1);

    QWidget::setTabOrder(textEdit, comboBox_ContentType);
    QWidget::setTabOrder(comboBox_ContentType, pushButton_Browse);
    QWidget::setTabOrder(pushButton_Browse, pushButton_Cancel);
    QWidget::setTabOrder(pushButton_Cancel, pushButton_OK);
    QWidget::setTabOrder(pushButton_OK, pushButton_Revert);

    retranslateUi(ContentEditor_BASE);
    QObject::connect(pushButton_OK, SIGNAL(clicked()), ContentEditor_BASE, SLOT(accept()));
    QObject::connect(pushButton_Cancel, SIGNAL(clicked()), ContentEditor_BASE, SLOT(reject()));

    QMetaObject::connectSlotsByName(ContentEditor_BASE);
    } // setupUi

    void retranslateUi(QDialog *ContentEditor_BASE)
    {
    ContentEditor_BASE->setWindowTitle(QApplication::translate("ContentEditor_BASE", "Content Editor", 0, QApplication::UnicodeUTF8));
    label_ViewAsType->setText(QApplication::translate("ContentEditor_BASE", "View content as:", 0, QApplication::UnicodeUTF8));
    comboBox_ContentType->clear();
    comboBox_ContentType->insertItems(0, QStringList()
     << QApplication::translate("ContentEditor_BASE", "Text", 0, QApplication::UnicodeUTF8)
     << QApplication::translate("ContentEditor_BASE", "Hex", 0, QApplication::UnicodeUTF8)
    );
    pushButton_Revert->setText(QApplication::translate("ContentEditor_BASE", "Revert", 0, QApplication::UnicodeUTF8));
    pushButton_Export->setText(QApplication::translate("ContentEditor_BASE", "Export", 0, QApplication::UnicodeUTF8));
    pushButton_Browse->setText(QApplication::translate("ContentEditor_BASE", "Browse", 0, QApplication::UnicodeUTF8));
    pushButton_Cancel->setText(QApplication::translate("ContentEditor_BASE", "Cancel", 0, QApplication::UnicodeUTF8));
    pushButton_OK->setText(QApplication::translate("ContentEditor_BASE", "OK", 0, QApplication::UnicodeUTF8));
    Q_UNUSED(ContentEditor_BASE);
    } // retranslateUi

};

namespace Ui 
{
  class ContentEditor_BASE: public Ui_ContentEditor_BASE 
  {
  public:
    virtual ~ContentEditor_BASE(){}
  };
} // namespace Ui

#endif // UI_CONTENTEDITOR_BASE_H
