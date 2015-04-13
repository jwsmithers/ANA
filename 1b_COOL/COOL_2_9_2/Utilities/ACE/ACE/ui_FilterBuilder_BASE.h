/********************************************************************************
** Form generated from reading ui file 'FilterBuilder_BASE.ui'
**
** Created: Tue Apr 15 16:08:18 2008
**      by: Qt User Interface Compiler version 4.3.3
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
********************************************************************************/

#ifndef UI_FILTERBUILDER_BASE_H
#define UI_FILTERBUILDER_BASE_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QComboBox>
#include <QtGui/QFrame>
#include <QtGui/QHBoxLayout>
#include <QtGui/QLabel>
#include <QtGui/QPushButton>
#include <QtGui/QSpacerItem>
#include <QtGui/QVBoxLayout>
#include <QtGui/QWidget>

class Ui_FilterBuilder_BASE
{
public:
    virtual ~Ui_FilterBuilder_BASE(){}
    QVBoxLayout *vboxLayout;
    QHBoxLayout *hboxLayout;
    QLabel *label;
    QLabel *label_FilterTarget;
    QPushButton *pushButton_DisableFilter;
    QPushButton *pushButton_ApplyFilter;
    QFrame *line;
    QHBoxLayout *hboxLayout1;
    QLabel *label_2;
    QComboBox *comboBox_FilterBehaviour;
    QLabel *label_3;
    QSpacerItem *spacerItem;

    void setupUi(QWidget *FilterBuilder_BASE)
    {
    if (FilterBuilder_BASE->objectName().isEmpty())
        FilterBuilder_BASE->setObjectName(QString::fromUtf8("FilterBuilder_BASE"));
    FilterBuilder_BASE->resize(688, 110);
    vboxLayout = new QVBoxLayout(FilterBuilder_BASE);
    vboxLayout->setObjectName(QString::fromUtf8("vboxLayout"));
    hboxLayout = new QHBoxLayout();
    hboxLayout->setObjectName(QString::fromUtf8("hboxLayout"));
    label = new QLabel(FilterBuilder_BASE);
    label->setObjectName(QString::fromUtf8("label"));

    hboxLayout->addWidget(label);

    label_FilterTarget = new QLabel(FilterBuilder_BASE);
    label_FilterTarget->setObjectName(QString::fromUtf8("label_FilterTarget"));
    QSizePolicy sizePolicy(QSizePolicy::Preferred, QSizePolicy::Preferred);
    sizePolicy.setHorizontalStretch(1);
    sizePolicy.setVerticalStretch(0);
    sizePolicy.setHeightForWidth(label_FilterTarget->sizePolicy().hasHeightForWidth());
    label_FilterTarget->setSizePolicy(sizePolicy);

    hboxLayout->addWidget(label_FilterTarget);

    pushButton_DisableFilter = new QPushButton(FilterBuilder_BASE);
    pushButton_DisableFilter->setObjectName(QString::fromUtf8("pushButton_DisableFilter"));

    hboxLayout->addWidget(pushButton_DisableFilter);

    pushButton_ApplyFilter = new QPushButton(FilterBuilder_BASE);
    pushButton_ApplyFilter->setObjectName(QString::fromUtf8("pushButton_ApplyFilter"));
    pushButton_ApplyFilter->setAutoDefault(true);
    pushButton_ApplyFilter->setDefault(true);

    hboxLayout->addWidget(pushButton_ApplyFilter);


    vboxLayout->addLayout(hboxLayout);

    line = new QFrame(FilterBuilder_BASE);
    line->setObjectName(QString::fromUtf8("line"));
    line->setFrameShape(QFrame::HLine);
    line->setFrameShadow(QFrame::Sunken);

    vboxLayout->addWidget(line);

    hboxLayout1 = new QHBoxLayout();
    hboxLayout1->setObjectName(QString::fromUtf8("hboxLayout1"));
    label_2 = new QLabel(FilterBuilder_BASE);
    label_2->setObjectName(QString::fromUtf8("label_2"));

    hboxLayout1->addWidget(label_2);

    comboBox_FilterBehaviour = new QComboBox(FilterBuilder_BASE);
    comboBox_FilterBehaviour->setObjectName(QString::fromUtf8("comboBox_FilterBehaviour"));

    hboxLayout1->addWidget(comboBox_FilterBehaviour);

    label_3 = new QLabel(FilterBuilder_BASE);
    label_3->setObjectName(QString::fromUtf8("label_3"));

    hboxLayout1->addWidget(label_3);

    spacerItem = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

    hboxLayout1->addItem(spacerItem);


    vboxLayout->addLayout(hboxLayout1);


    retranslateUi(FilterBuilder_BASE);

    QMetaObject::connectSlotsByName(FilterBuilder_BASE);
    } // setupUi

    void retranslateUi(QWidget *FilterBuilder_BASE)
    {
    label->setText(QApplication::translate("FilterBuilder_BASE", "Filter target:", 0, QApplication::UnicodeUTF8));
    pushButton_DisableFilter->setToolTip(QApplication::translate("FilterBuilder_BASE", "Remove all effective filters.", 0, QApplication::UnicodeUTF8));
    pushButton_DisableFilter->setText(QApplication::translate("FilterBuilder_BASE", "Disable", 0, QApplication::UnicodeUTF8));
    pushButton_ApplyFilter->setText(QApplication::translate("FilterBuilder_BASE", "Apply", 0, QApplication::UnicodeUTF8));
    label_2->setText(QApplication::translate("FilterBuilder_BASE", "Apply", 0, QApplication::UnicodeUTF8));
    comboBox_FilterBehaviour->clear();
    comboBox_FilterBehaviour->insertItems(0, QStringList()
     << QApplication::translate("FilterBuilder_BASE", "any", 0, QApplication::UnicodeUTF8)
     << QApplication::translate("FilterBuilder_BASE", "all", 0, QApplication::UnicodeUTF8)
    );
    comboBox_FilterBehaviour->setToolTip(QString());
    label_3->setText(QApplication::translate("FilterBuilder_BASE", "of the following filter rules:", 0, QApplication::UnicodeUTF8));
    Q_UNUSED(FilterBuilder_BASE);
    } // retranslateUi

};

namespace Ui 
{
  class FilterBuilder_BASE: public Ui_FilterBuilder_BASE 
  {
  public:
    virtual ~FilterBuilder_BASE(){}
  };
} // namespace Ui

#endif // UI_FILTERBUILDER_BASE_H
