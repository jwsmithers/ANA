/********************************************************************************
** Form generated from reading ui file 'FilterEntry_BASE.ui'
**
** Created: Thu Apr 17 15:09:25 2008
**      by: Qt User Interface Compiler version 4.3.3
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
********************************************************************************/

#ifndef UI_FILTERENTRY_BASE_H
#define UI_FILTERENTRY_BASE_H

#include <QtCore/QDate>
#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QComboBox>
#include <QtGui/QDateTimeEdit>
#include <QtGui/QGridLayout>
#include <QtGui/QGroupBox>
#include <QtGui/QHBoxLayout>
#include <QtGui/QLabel>
#include <QtGui/QLineEdit>
#include <QtGui/QPushButton>
#include <QtGui/QSpacerItem>
#include <QtGui/QVBoxLayout>
#include <QtGui/QWidget>

class Ui_FilterEntry_BASE
{
public:
    virtual ~Ui_FilterEntry_BASE(){}
    QVBoxLayout *vboxLayout;
    QGroupBox *groupBox_FilterEntry;
    QHBoxLayout *hboxLayout;
    QVBoxLayout *vboxLayout1;
    QHBoxLayout *hboxLayout1;
    QComboBox *comboBox_Column;
    QComboBox *comboBox_Comparators;
    QSpacerItem *spacerItem;
    QVBoxLayout *vboxLayout2;
    QWidget *entryContainer_nonDate;
    QHBoxLayout *hboxLayout2;
    QLineEdit *lineEdit_EntryA;
    QLabel *entryContainer_nonDate_ampersand;
    QLineEdit *lineEdit_EntryB;
    QWidget *entryContainer_Date;
    QGridLayout *gridLayout;
    QComboBox *comboBox_PredefinedFilters;
    QDateTimeEdit *dateTimeEdit_A;
    QLabel *entryContainer_Date_ampersand;
    QDateTimeEdit *dateTimeEdit_B;
    QSpacerItem *spacerItem1;
    QVBoxLayout *vboxLayout3;
    QHBoxLayout *hboxLayout3;
    QPushButton *pushButton_RemoveFilter;
    QPushButton *pushButton_AddFilter;
    QSpacerItem *spacerItem2;

    void setupUi(QWidget *FilterEntry_BASE)
    {
    if (FilterEntry_BASE->objectName().isEmpty())
        FilterEntry_BASE->setObjectName(QString::fromUtf8("FilterEntry_BASE"));
    FilterEntry_BASE->resize(821, 120);
    QSizePolicy sizePolicy(QSizePolicy::Expanding, QSizePolicy::Fixed);
    sizePolicy.setHorizontalStretch(0);
    sizePolicy.setVerticalStretch(0);
    sizePolicy.setHeightForWidth(FilterEntry_BASE->sizePolicy().hasHeightForWidth());
    FilterEntry_BASE->setSizePolicy(sizePolicy);
    vboxLayout = new QVBoxLayout(FilterEntry_BASE);
    vboxLayout->setObjectName(QString::fromUtf8("vboxLayout"));
    vboxLayout->setContentsMargins(0, 0, 0, 0);
    groupBox_FilterEntry = new QGroupBox(FilterEntry_BASE);
    groupBox_FilterEntry->setObjectName(QString::fromUtf8("groupBox_FilterEntry"));
    QSizePolicy sizePolicy1(QSizePolicy::Preferred, QSizePolicy::Maximum);
    sizePolicy1.setHorizontalStretch(0);
    sizePolicy1.setVerticalStretch(0);
    sizePolicy1.setHeightForWidth(groupBox_FilterEntry->sizePolicy().hasHeightForWidth());
    groupBox_FilterEntry->setSizePolicy(sizePolicy1);
    groupBox_FilterEntry->setCheckable(true);
    hboxLayout = new QHBoxLayout(groupBox_FilterEntry);
    hboxLayout->setObjectName(QString::fromUtf8("hboxLayout"));
    hboxLayout->setContentsMargins(5, 5, 5, 5);
    vboxLayout1 = new QVBoxLayout();
    vboxLayout1->setSpacing(0);
    vboxLayout1->setObjectName(QString::fromUtf8("vboxLayout1"));
    hboxLayout1 = new QHBoxLayout();
    hboxLayout1->setObjectName(QString::fromUtf8("hboxLayout1"));
    comboBox_Column = new QComboBox(groupBox_FilterEntry);
    comboBox_Column->setObjectName(QString::fromUtf8("comboBox_Column"));
    sizePolicy.setHeightForWidth(comboBox_Column->sizePolicy().hasHeightForWidth());
    comboBox_Column->setSizePolicy(sizePolicy);

    hboxLayout1->addWidget(comboBox_Column);

    comboBox_Comparators = new QComboBox(groupBox_FilterEntry);
    comboBox_Comparators->setObjectName(QString::fromUtf8("comboBox_Comparators"));
    sizePolicy.setHeightForWidth(comboBox_Comparators->sizePolicy().hasHeightForWidth());
    comboBox_Comparators->setSizePolicy(sizePolicy);

    hboxLayout1->addWidget(comboBox_Comparators);


    vboxLayout1->addLayout(hboxLayout1);

    spacerItem = new QSpacerItem(20, 0, QSizePolicy::Minimum, QSizePolicy::Expanding);

    vboxLayout1->addItem(spacerItem);


    hboxLayout->addLayout(vboxLayout1);

    vboxLayout2 = new QVBoxLayout();
    vboxLayout2->setSpacing(0);
    vboxLayout2->setObjectName(QString::fromUtf8("vboxLayout2"));
    entryContainer_nonDate = new QWidget(groupBox_FilterEntry);
    entryContainer_nonDate->setObjectName(QString::fromUtf8("entryContainer_nonDate"));
    sizePolicy1.setHeightForWidth(entryContainer_nonDate->sizePolicy().hasHeightForWidth());
    entryContainer_nonDate->setSizePolicy(sizePolicy1);
    hboxLayout2 = new QHBoxLayout(entryContainer_nonDate);
    hboxLayout2->setObjectName(QString::fromUtf8("hboxLayout2"));
    hboxLayout2->setContentsMargins(0, 0, 0, 0);
    lineEdit_EntryA = new QLineEdit(entryContainer_nonDate);
    lineEdit_EntryA->setObjectName(QString::fromUtf8("lineEdit_EntryA"));
    QSizePolicy sizePolicy2(QSizePolicy::Expanding, QSizePolicy::Fixed);
    sizePolicy2.setHorizontalStretch(1);
    sizePolicy2.setVerticalStretch(0);
    sizePolicy2.setHeightForWidth(lineEdit_EntryA->sizePolicy().hasHeightForWidth());
    lineEdit_EntryA->setSizePolicy(sizePolicy2);
    lineEdit_EntryA->setMinimumSize(QSize(110, 0));

    hboxLayout2->addWidget(lineEdit_EntryA);

    entryContainer_nonDate_ampersand = new QLabel(entryContainer_nonDate);
    entryContainer_nonDate_ampersand->setObjectName(QString::fromUtf8("entryContainer_nonDate_ampersand"));
    QSizePolicy sizePolicy3(QSizePolicy::Fixed, QSizePolicy::Preferred);
    sizePolicy3.setHorizontalStretch(0);
    sizePolicy3.setVerticalStretch(0);
    sizePolicy3.setHeightForWidth(entryContainer_nonDate_ampersand->sizePolicy().hasHeightForWidth());
    entryContainer_nonDate_ampersand->setSizePolicy(sizePolicy3);

    hboxLayout2->addWidget(entryContainer_nonDate_ampersand);

    lineEdit_EntryB = new QLineEdit(entryContainer_nonDate);
    lineEdit_EntryB->setObjectName(QString::fromUtf8("lineEdit_EntryB"));
    sizePolicy2.setHeightForWidth(lineEdit_EntryB->sizePolicy().hasHeightForWidth());
    lineEdit_EntryB->setSizePolicy(sizePolicy2);
    lineEdit_EntryB->setMinimumSize(QSize(110, 0));

    hboxLayout2->addWidget(lineEdit_EntryB);


    vboxLayout2->addWidget(entryContainer_nonDate);

    entryContainer_Date = new QWidget(groupBox_FilterEntry);
    entryContainer_Date->setObjectName(QString::fromUtf8("entryContainer_Date"));
    entryContainer_Date->setEnabled(true);
    sizePolicy1.setHeightForWidth(entryContainer_Date->sizePolicy().hasHeightForWidth());
    entryContainer_Date->setSizePolicy(sizePolicy1);
    gridLayout = new QGridLayout(entryContainer_Date);
    gridLayout->setObjectName(QString::fromUtf8("gridLayout"));
    gridLayout->setContentsMargins(0, 0, 0, 0);
    comboBox_PredefinedFilters = new QComboBox(entryContainer_Date);
    comboBox_PredefinedFilters->setObjectName(QString::fromUtf8("comboBox_PredefinedFilters"));
    sizePolicy.setHeightForWidth(comboBox_PredefinedFilters->sizePolicy().hasHeightForWidth());
    comboBox_PredefinedFilters->setSizePolicy(sizePolicy);
    comboBox_PredefinedFilters->setMinimumSize(QSize(248, 0));

    gridLayout->addWidget(comboBox_PredefinedFilters, 0, 0, 1, 3);

    dateTimeEdit_A = new QDateTimeEdit(entryContainer_Date);
    dateTimeEdit_A->setObjectName(QString::fromUtf8("dateTimeEdit_A"));
    sizePolicy2.setHeightForWidth(dateTimeEdit_A->sizePolicy().hasHeightForWidth());
    dateTimeEdit_A->setSizePolicy(sizePolicy2);
    dateTimeEdit_A->setMaximumDate(QDate(2106, 2, 7));
    dateTimeEdit_A->setMinimumDate(QDate(1970, 1, 1));
    dateTimeEdit_A->setCalendarPopup(true);

    gridLayout->addWidget(dateTimeEdit_A, 1, 0, 1, 1);

    entryContainer_Date_ampersand = new QLabel(entryContainer_Date);
    entryContainer_Date_ampersand->setObjectName(QString::fromUtf8("entryContainer_Date_ampersand"));
    sizePolicy3.setHeightForWidth(entryContainer_Date_ampersand->sizePolicy().hasHeightForWidth());
    entryContainer_Date_ampersand->setSizePolicy(sizePolicy3);

    gridLayout->addWidget(entryContainer_Date_ampersand, 1, 1, 1, 1);

    dateTimeEdit_B = new QDateTimeEdit(entryContainer_Date);
    dateTimeEdit_B->setObjectName(QString::fromUtf8("dateTimeEdit_B"));
    sizePolicy2.setHeightForWidth(dateTimeEdit_B->sizePolicy().hasHeightForWidth());
    dateTimeEdit_B->setSizePolicy(sizePolicy2);
    dateTimeEdit_B->setMaximumDate(QDate(2106, 2, 7));
    dateTimeEdit_B->setMinimumDate(QDate(1970, 1, 1));
    dateTimeEdit_B->setCurrentSection(QDateTimeEdit::DaySection);
    dateTimeEdit_B->setCalendarPopup(true);

    gridLayout->addWidget(dateTimeEdit_B, 1, 2, 1, 1);


    vboxLayout2->addWidget(entryContainer_Date);

    spacerItem1 = new QSpacerItem(20, 0, QSizePolicy::Minimum, QSizePolicy::Expanding);

    vboxLayout2->addItem(spacerItem1);


    hboxLayout->addLayout(vboxLayout2);

    vboxLayout3 = new QVBoxLayout();
    vboxLayout3->setSpacing(0);
    vboxLayout3->setObjectName(QString::fromUtf8("vboxLayout3"));
    hboxLayout3 = new QHBoxLayout();
    hboxLayout3->setSpacing(0);
    hboxLayout3->setObjectName(QString::fromUtf8("hboxLayout3"));
    pushButton_RemoveFilter = new QPushButton(groupBox_FilterEntry);
    pushButton_RemoveFilter->setObjectName(QString::fromUtf8("pushButton_RemoveFilter"));
    pushButton_RemoveFilter->setEnabled(false);
    QSizePolicy sizePolicy4(QSizePolicy::Fixed, QSizePolicy::Fixed);
    sizePolicy4.setHorizontalStretch(0);
    sizePolicy4.setVerticalStretch(0);
    sizePolicy4.setHeightForWidth(pushButton_RemoveFilter->sizePolicy().hasHeightForWidth());
    pushButton_RemoveFilter->setSizePolicy(sizePolicy4);
    pushButton_RemoveFilter->setMinimumSize(QSize(52, 32));
    pushButton_RemoveFilter->setMaximumSize(QSize(52, 32));
    pushButton_RemoveFilter->setFlat(false);

    hboxLayout3->addWidget(pushButton_RemoveFilter);

    pushButton_AddFilter = new QPushButton(groupBox_FilterEntry);
    pushButton_AddFilter->setObjectName(QString::fromUtf8("pushButton_AddFilter"));
    sizePolicy4.setHeightForWidth(pushButton_AddFilter->sizePolicy().hasHeightForWidth());
    pushButton_AddFilter->setSizePolicy(sizePolicy4);
    pushButton_AddFilter->setMinimumSize(QSize(52, 32));
    pushButton_AddFilter->setMaximumSize(QSize(52, 32));
    pushButton_AddFilter->setFlat(false);

    hboxLayout3->addWidget(pushButton_AddFilter);


    vboxLayout3->addLayout(hboxLayout3);

    spacerItem2 = new QSpacerItem(20, 0, QSizePolicy::Minimum, QSizePolicy::Expanding);

    vboxLayout3->addItem(spacerItem2);


    hboxLayout->addLayout(vboxLayout3);


    vboxLayout->addWidget(groupBox_FilterEntry);


    retranslateUi(FilterEntry_BASE);

    QMetaObject::connectSlotsByName(FilterEntry_BASE);
    } // setupUi

    void retranslateUi(QWidget *FilterEntry_BASE)
    {
    groupBox_FilterEntry->setTitle(QApplication::translate("FilterEntry_BASE", "Filter #1", 0, QApplication::UnicodeUTF8));
    comboBox_Comparators->clear();
    comboBox_Comparators->insertItems(0, QStringList()
     << QApplication::translate("FilterEntry_BASE", "is", 0, QApplication::UnicodeUTF8)
     << QApplication::translate("FilterEntry_BASE", "is not", 0, QApplication::UnicodeUTF8)
     << QApplication::translate("FilterEntry_BASE", "is greater than", 0, QApplication::UnicodeUTF8)
     << QApplication::translate("FilterEntry_BASE", "is less than", 0, QApplication::UnicodeUTF8)
     << QApplication::translate("FilterEntry_BASE", "is between", 0, QApplication::UnicodeUTF8)
     << QApplication::translate("FilterEntry_BASE", "contains", 0, QApplication::UnicodeUTF8)
     << QApplication::translate("FilterEntry_BASE", "does not contain", 0, QApplication::UnicodeUTF8)
     << QApplication::translate("FilterEntry_BASE", "starts with", 0, QApplication::UnicodeUTF8)
     << QApplication::translate("FilterEntry_BASE", "ends with", 0, QApplication::UnicodeUTF8)
     << QApplication::translate("FilterEntry_BASE", "date is", 0, QApplication::UnicodeUTF8)
    );
    entryContainer_nonDate_ampersand->setText(QApplication::translate("FilterEntry_BASE", "&", 0, QApplication::UnicodeUTF8));
    comboBox_PredefinedFilters->clear();
    comboBox_PredefinedFilters->insertItems(0, QStringList()
     << QApplication::translate("FilterEntry_BASE", "most recent", 0, QApplication::UnicodeUTF8)
     << QApplication::translate("FilterEntry_BASE", "before", 0, QApplication::UnicodeUTF8)
     << QApplication::translate("FilterEntry_BASE", "after", 0, QApplication::UnicodeUTF8)
     << QApplication::translate("FilterEntry_BASE", "between", 0, QApplication::UnicodeUTF8)
    );
    dateTimeEdit_A->setDisplayFormat(QApplication::translate("FilterEntry_BASE", "ddd dd/MM/yyyy HH:mm:ss", 0, QApplication::UnicodeUTF8));
    entryContainer_Date_ampersand->setText(QApplication::translate("FilterEntry_BASE", "&", 0, QApplication::UnicodeUTF8));
    dateTimeEdit_B->setDisplayFormat(QApplication::translate("FilterEntry_BASE", "ddd dd/MM/yyyy HH:mm:ss", 0, QApplication::UnicodeUTF8));
    pushButton_RemoveFilter->setToolTip(QApplication::translate("FilterEntry_BASE", "Add a new filter entry", 0, QApplication::UnicodeUTF8));
    pushButton_RemoveFilter->setWhatsThis(QApplication::translate("FilterEntry_BASE", "Add a new filter entry", 0, QApplication::UnicodeUTF8));
    pushButton_RemoveFilter->setText(QApplication::translate("FilterEntry_BASE", "-", 0, QApplication::UnicodeUTF8));
    pushButton_AddFilter->setToolTip(QApplication::translate("FilterEntry_BASE", "Add a new filter entry", 0, QApplication::UnicodeUTF8));
    pushButton_AddFilter->setWhatsThis(QApplication::translate("FilterEntry_BASE", "Add a new filter entry", 0, QApplication::UnicodeUTF8));
    pushButton_AddFilter->setText(QApplication::translate("FilterEntry_BASE", "+", 0, QApplication::UnicodeUTF8));
    Q_UNUSED(FilterEntry_BASE);
    } // retranslateUi

};

namespace Ui 
{
  class FilterEntry_BASE: public Ui_FilterEntry_BASE 
  {
  public:
    virtual ~FilterEntry_BASE(){}
  };
} // namespace Ui

#endif // UI_FILTERENTRY_BASE_H
