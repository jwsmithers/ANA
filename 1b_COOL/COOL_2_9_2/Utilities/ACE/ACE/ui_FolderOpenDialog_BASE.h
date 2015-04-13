/********************************************************************************
** Form generated from reading ui file 'FolderOpenDialog_BASE.ui'
**
** Created: Fri Oct 1 12:17:49 2010
**      by: Qt User Interface Compiler version 4.5.2
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
********************************************************************************/

#ifndef UI_FOLDEROPENDIALOG_BASE_H
#define UI_FOLDEROPENDIALOG_BASE_H

#include <QtCore/QDate>
#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QComboBox>
#include <QtGui/QDateTimeEdit>
#include <QtGui/QDialog>
#include <QtGui/QFrame>
#include <QtGui/QGridLayout>
#include <QtGui/QGroupBox>
#include <QtGui/QHBoxLayout>
#include <QtGui/QHeaderView>
#include <QtGui/QLabel>
#include <QtGui/QLineEdit>
#include <QtGui/QListWidget>
#include <QtGui/QPushButton>
#include <QtGui/QRadioButton>
#include <QtGui/QSpacerItem>
#include <QtGui/QSpinBox>
#include <QtGui/QStackedWidget>
#include <QtGui/QVBoxLayout>
#include <QtGui/QWidget>

QT_BEGIN_NAMESPACE

class Ui_FolderOpenDialog_BASE
{
public:
    QVBoxLayout *verticalLayout;
    QHBoxLayout *hboxLayout;
    QLabel *label_5;
    QLabel *label_FolderName;
    QFrame *line;
    QGroupBox *groupBox_VKE;
    QGridLayout *gridLayout_2;
    QComboBox *comboBox_PredefinedVKE;
    QPushButton *pushButton_RemoveVKE;
    QStackedWidget *stackedWidget_VKE;
    QWidget *page_TimeVKE;
    QGridLayout *gridLayout;
    QLabel *label_6;
    QLineEdit *lineEdit_PredefinedBit;
    QRadioButton *radioButton_IOVrecent;
    QRadioButton *radioButton_IOVsince;
    QDateTimeEdit *dateTimeEdit_Since;
    QWidget *page_GenericVKE;
    QGridLayout *gridLayout_3;
    QLineEdit *lineEdit_HighBits;
    QSpinBox *spinBox_HighBits;
    QLineEdit *lineEdit_LowBits;
    QSpinBox *spinBox_LowBits;
    QPushButton *pushButton_SaveVKE;
    QGroupBox *groupBox_ChannelSelection;
    QVBoxLayout *verticalLayout_4;
    QHBoxLayout *hboxLayout1;
    QLabel *label_3;
    QComboBox *comboBox_From;
    QLabel *label;
    QComboBox *comboBox_To;
    QPushButton *pushButton_AddChannelRange;
    QVBoxLayout *verticalLayout_3;
    QHBoxLayout *horizontalLayout_2;
    QLabel *label_2;
    QSpacerItem *horizontalSpacer;
    QPushButton *pushButton_RemoveChannelRange;
    QListWidget *listWidget_CurrentChannelSelection;
    QGroupBox *groupBox_TagSelection;
    QHBoxLayout *hboxLayout2;
    QLabel *label_4;
    QComboBox *comboBox_Tags;
    QSpacerItem *spacerItem;
    QHBoxLayout *hboxLayout3;
    QSpacerItem *spacerItem1;
    QPushButton *pushButton_Cancel;
    QPushButton *pushButton_Open;

    void setupUi(QDialog *FolderOpenDialog_BASE)
    {
        if (FolderOpenDialog_BASE->objectName().isEmpty())
            FolderOpenDialog_BASE->setObjectName(QString::fromUtf8("FolderOpenDialog_BASE"));
        FolderOpenDialog_BASE->setWindowModality(Qt::ApplicationModal);
        FolderOpenDialog_BASE->resize(486, 721);
        QSizePolicy sizePolicy(QSizePolicy::Fixed, QSizePolicy::MinimumExpanding);
        sizePolicy.setHorizontalStretch(0);
        sizePolicy.setVerticalStretch(0);
        sizePolicy.setHeightForWidth(FolderOpenDialog_BASE->sizePolicy().hasHeightForWidth());
        FolderOpenDialog_BASE->setSizePolicy(sizePolicy);
        FolderOpenDialog_BASE->setModal(true);
        verticalLayout = new QVBoxLayout(FolderOpenDialog_BASE);
        verticalLayout->setObjectName(QString::fromUtf8("verticalLayout"));
        hboxLayout = new QHBoxLayout();
        hboxLayout->setObjectName(QString::fromUtf8("hboxLayout"));
        label_5 = new QLabel(FolderOpenDialog_BASE);
        label_5->setObjectName(QString::fromUtf8("label_5"));

        hboxLayout->addWidget(label_5);

        label_FolderName = new QLabel(FolderOpenDialog_BASE);
        label_FolderName->setObjectName(QString::fromUtf8("label_FolderName"));
        QSizePolicy sizePolicy1(QSizePolicy::Preferred, QSizePolicy::Fixed);
        sizePolicy1.setHorizontalStretch(1);
        sizePolicy1.setVerticalStretch(0);
        sizePolicy1.setHeightForWidth(label_FolderName->sizePolicy().hasHeightForWidth());
        label_FolderName->setSizePolicy(sizePolicy1);
        label_FolderName->setContextMenuPolicy(Qt::NoContextMenu);
        label_FolderName->setFrameShape(QFrame::StyledPanel);
        label_FolderName->setFrameShadow(QFrame::Sunken);
        label_FolderName->setTextFormat(Qt::PlainText);
        label_FolderName->setMargin(2);

        hboxLayout->addWidget(label_FolderName);


        verticalLayout->addLayout(hboxLayout);

        line = new QFrame(FolderOpenDialog_BASE);
        line->setObjectName(QString::fromUtf8("line"));
        line->setFrameShape(QFrame::HLine);
        line->setFrameShadow(QFrame::Sunken);

        verticalLayout->addWidget(line);

        groupBox_VKE = new QGroupBox(FolderOpenDialog_BASE);
        groupBox_VKE->setObjectName(QString::fromUtf8("groupBox_VKE"));
        groupBox_VKE->setEnabled(true);
        QSizePolicy sizePolicy2(QSizePolicy::Preferred, QSizePolicy::MinimumExpanding);
        sizePolicy2.setHorizontalStretch(0);
        sizePolicy2.setVerticalStretch(0);
        sizePolicy2.setHeightForWidth(groupBox_VKE->sizePolicy().hasHeightForWidth());
        groupBox_VKE->setSizePolicy(sizePolicy2);
        groupBox_VKE->setCheckable(true);
        groupBox_VKE->setChecked(true);
        gridLayout_2 = new QGridLayout(groupBox_VKE);
        gridLayout_2->setObjectName(QString::fromUtf8("gridLayout_2"));
        comboBox_PredefinedVKE = new QComboBox(groupBox_VKE);
        comboBox_PredefinedVKE->insertItems(0, QStringList()
         << QString::fromUtf8("time")
         << QString::fromUtf8("run-lumi")
         << QString::fromUtf8("run-event")
        );
        comboBox_PredefinedVKE->setObjectName(QString::fromUtf8("comboBox_PredefinedVKE"));
        comboBox_PredefinedVKE->setEnabled(true);
        QSizePolicy sizePolicy3(QSizePolicy::MinimumExpanding, QSizePolicy::Fixed);
        sizePolicy3.setHorizontalStretch(0);
        sizePolicy3.setVerticalStretch(0);
        sizePolicy3.setHeightForWidth(comboBox_PredefinedVKE->sizePolicy().hasHeightForWidth());
        comboBox_PredefinedVKE->setSizePolicy(sizePolicy3);
        comboBox_PredefinedVKE->setEditable(false);
        comboBox_PredefinedVKE->setDuplicatesEnabled(false);

        gridLayout_2->addWidget(comboBox_PredefinedVKE, 0, 0, 1, 1);

        pushButton_RemoveVKE = new QPushButton(groupBox_VKE);
        pushButton_RemoveVKE->setObjectName(QString::fromUtf8("pushButton_RemoveVKE"));
        pushButton_RemoveVKE->setEnabled(false);

        gridLayout_2->addWidget(pushButton_RemoveVKE, 0, 2, 1, 1);

        stackedWidget_VKE = new QStackedWidget(groupBox_VKE);
        stackedWidget_VKE->setObjectName(QString::fromUtf8("stackedWidget_VKE"));
        sizePolicy2.setHeightForWidth(stackedWidget_VKE->sizePolicy().hasHeightForWidth());
        stackedWidget_VKE->setSizePolicy(sizePolicy2);
        stackedWidget_VKE->setFrameShape(QFrame::StyledPanel);
        stackedWidget_VKE->setFrameShadow(QFrame::Plain);
        page_TimeVKE = new QWidget();
        page_TimeVKE->setObjectName(QString::fromUtf8("page_TimeVKE"));
        gridLayout = new QGridLayout(page_TimeVKE);
        gridLayout->setObjectName(QString::fromUtf8("gridLayout"));
        label_6 = new QLabel(page_TimeVKE);
        label_6->setObjectName(QString::fromUtf8("label_6"));

        gridLayout->addWidget(label_6, 0, 0, 1, 1);

        lineEdit_PredefinedBit = new QLineEdit(page_TimeVKE);
        lineEdit_PredefinedBit->setObjectName(QString::fromUtf8("lineEdit_PredefinedBit"));
        lineEdit_PredefinedBit->setReadOnly(true);

        gridLayout->addWidget(lineEdit_PredefinedBit, 0, 1, 1, 2);

        radioButton_IOVrecent = new QRadioButton(page_TimeVKE);
        radioButton_IOVrecent->setObjectName(QString::fromUtf8("radioButton_IOVrecent"));
        radioButton_IOVrecent->setChecked(true);

        gridLayout->addWidget(radioButton_IOVrecent, 1, 0, 1, 2);

        radioButton_IOVsince = new QRadioButton(page_TimeVKE);
        radioButton_IOVsince->setObjectName(QString::fromUtf8("radioButton_IOVsince"));

        gridLayout->addWidget(radioButton_IOVsince, 2, 0, 1, 2);

        dateTimeEdit_Since = new QDateTimeEdit(page_TimeVKE);
        dateTimeEdit_Since->setObjectName(QString::fromUtf8("dateTimeEdit_Since"));
        QSizePolicy sizePolicy4(QSizePolicy::Expanding, QSizePolicy::Fixed);
        sizePolicy4.setHorizontalStretch(0);
        sizePolicy4.setVerticalStretch(0);
        sizePolicy4.setHeightForWidth(dateTimeEdit_Since->sizePolicy().hasHeightForWidth());
        dateTimeEdit_Since->setSizePolicy(sizePolicy4);
        dateTimeEdit_Since->setAlignment(Qt::AlignLeading|Qt::AlignLeft|Qt::AlignVCenter);
        dateTimeEdit_Since->setMaximumDate(QDate(2106, 2, 7));
        dateTimeEdit_Since->setMinimumDate(QDate(1969, 12, 28));
        dateTimeEdit_Since->setCalendarPopup(true);
        dateTimeEdit_Since->setTimeSpec(Qt::UTC);

        gridLayout->addWidget(dateTimeEdit_Since, 2, 2, 1, 1);

        stackedWidget_VKE->addWidget(page_TimeVKE);
        page_GenericVKE = new QWidget();
        page_GenericVKE->setObjectName(QString::fromUtf8("page_GenericVKE"));
        gridLayout_3 = new QGridLayout(page_GenericVKE);
        gridLayout_3->setObjectName(QString::fromUtf8("gridLayout_3"));
        lineEdit_HighBits = new QLineEdit(page_GenericVKE);
        lineEdit_HighBits->setObjectName(QString::fromUtf8("lineEdit_HighBits"));
        lineEdit_HighBits->setEnabled(true);

        gridLayout_3->addWidget(lineEdit_HighBits, 0, 0, 1, 1);

        spinBox_HighBits = new QSpinBox(page_GenericVKE);
        spinBox_HighBits->setObjectName(QString::fromUtf8("spinBox_HighBits"));
        spinBox_HighBits->setEnabled(true);
        spinBox_HighBits->setFrame(true);
        spinBox_HighBits->setReadOnly(false);
        spinBox_HighBits->setAccelerated(true);
        spinBox_HighBits->setMinimum(1);
        spinBox_HighBits->setMaximum(63);
        spinBox_HighBits->setValue(31);

        gridLayout_3->addWidget(spinBox_HighBits, 0, 1, 1, 1);

        lineEdit_LowBits = new QLineEdit(page_GenericVKE);
        lineEdit_LowBits->setObjectName(QString::fromUtf8("lineEdit_LowBits"));
        lineEdit_LowBits->setEnabled(true);

        gridLayout_3->addWidget(lineEdit_LowBits, 1, 0, 1, 1);

        spinBox_LowBits = new QSpinBox(page_GenericVKE);
        spinBox_LowBits->setObjectName(QString::fromUtf8("spinBox_LowBits"));
        spinBox_LowBits->setEnabled(true);
        spinBox_LowBits->setMaximum(63);
        spinBox_LowBits->setValue(32);

        gridLayout_3->addWidget(spinBox_LowBits, 1, 1, 1, 1);

        stackedWidget_VKE->addWidget(page_GenericVKE);

        gridLayout_2->addWidget(stackedWidget_VKE, 1, 0, 1, 3);

        pushButton_SaveVKE = new QPushButton(groupBox_VKE);
        pushButton_SaveVKE->setObjectName(QString::fromUtf8("pushButton_SaveVKE"));
        pushButton_SaveVKE->setEnabled(false);

        gridLayout_2->addWidget(pushButton_SaveVKE, 0, 1, 1, 1);


        verticalLayout->addWidget(groupBox_VKE);

        groupBox_ChannelSelection = new QGroupBox(FolderOpenDialog_BASE);
        groupBox_ChannelSelection->setObjectName(QString::fromUtf8("groupBox_ChannelSelection"));
        groupBox_ChannelSelection->setEnabled(true);
        sizePolicy2.setHeightForWidth(groupBox_ChannelSelection->sizePolicy().hasHeightForWidth());
        groupBox_ChannelSelection->setSizePolicy(sizePolicy2);
        groupBox_ChannelSelection->setCheckable(true);
        groupBox_ChannelSelection->setChecked(false);
        verticalLayout_4 = new QVBoxLayout(groupBox_ChannelSelection);
        verticalLayout_4->setObjectName(QString::fromUtf8("verticalLayout_4"));
        hboxLayout1 = new QHBoxLayout();
        hboxLayout1->setObjectName(QString::fromUtf8("hboxLayout1"));
        label_3 = new QLabel(groupBox_ChannelSelection);
        label_3->setObjectName(QString::fromUtf8("label_3"));

        hboxLayout1->addWidget(label_3);

        comboBox_From = new QComboBox(groupBox_ChannelSelection);
        comboBox_From->setObjectName(QString::fromUtf8("comboBox_From"));
        sizePolicy1.setHeightForWidth(comboBox_From->sizePolicy().hasHeightForWidth());
        comboBox_From->setSizePolicy(sizePolicy1);

        hboxLayout1->addWidget(comboBox_From);

        label = new QLabel(groupBox_ChannelSelection);
        label->setObjectName(QString::fromUtf8("label"));
        QSizePolicy sizePolicy5(QSizePolicy::Fixed, QSizePolicy::Preferred);
        sizePolicy5.setHorizontalStretch(0);
        sizePolicy5.setVerticalStretch(0);
        sizePolicy5.setHeightForWidth(label->sizePolicy().hasHeightForWidth());
        label->setSizePolicy(sizePolicy5);
        label->setTextFormat(Qt::PlainText);

        hboxLayout1->addWidget(label);

        comboBox_To = new QComboBox(groupBox_ChannelSelection);
        comboBox_To->setObjectName(QString::fromUtf8("comboBox_To"));
        sizePolicy1.setHeightForWidth(comboBox_To->sizePolicy().hasHeightForWidth());
        comboBox_To->setSizePolicy(sizePolicy1);

        hboxLayout1->addWidget(comboBox_To);

        pushButton_AddChannelRange = new QPushButton(groupBox_ChannelSelection);
        pushButton_AddChannelRange->setObjectName(QString::fromUtf8("pushButton_AddChannelRange"));

        hboxLayout1->addWidget(pushButton_AddChannelRange);


        verticalLayout_4->addLayout(hboxLayout1);

        verticalLayout_3 = new QVBoxLayout();
        verticalLayout_3->setSpacing(0);
        verticalLayout_3->setObjectName(QString::fromUtf8("verticalLayout_3"));
        horizontalLayout_2 = new QHBoxLayout();
        horizontalLayout_2->setObjectName(QString::fromUtf8("horizontalLayout_2"));
        label_2 = new QLabel(groupBox_ChannelSelection);
        label_2->setObjectName(QString::fromUtf8("label_2"));
        QSizePolicy sizePolicy6(QSizePolicy::Preferred, QSizePolicy::Fixed);
        sizePolicy6.setHorizontalStretch(0);
        sizePolicy6.setVerticalStretch(0);
        sizePolicy6.setHeightForWidth(label_2->sizePolicy().hasHeightForWidth());
        label_2->setSizePolicy(sizePolicy6);

        horizontalLayout_2->addWidget(label_2);

        horizontalSpacer = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        horizontalLayout_2->addItem(horizontalSpacer);

        pushButton_RemoveChannelRange = new QPushButton(groupBox_ChannelSelection);
        pushButton_RemoveChannelRange->setObjectName(QString::fromUtf8("pushButton_RemoveChannelRange"));
        QSizePolicy sizePolicy7(QSizePolicy::Fixed, QSizePolicy::Fixed);
        sizePolicy7.setHorizontalStretch(0);
        sizePolicy7.setVerticalStretch(0);
        sizePolicy7.setHeightForWidth(pushButton_RemoveChannelRange->sizePolicy().hasHeightForWidth());
        pushButton_RemoveChannelRange->setSizePolicy(sizePolicy7);

        horizontalLayout_2->addWidget(pushButton_RemoveChannelRange);


        verticalLayout_3->addLayout(horizontalLayout_2);

        listWidget_CurrentChannelSelection = new QListWidget(groupBox_ChannelSelection);
        listWidget_CurrentChannelSelection->setObjectName(QString::fromUtf8("listWidget_CurrentChannelSelection"));
        sizePolicy2.setHeightForWidth(listWidget_CurrentChannelSelection->sizePolicy().hasHeightForWidth());
        listWidget_CurrentChannelSelection->setSizePolicy(sizePolicy2);
        listWidget_CurrentChannelSelection->setSelectionMode(QAbstractItemView::ExtendedSelection);
        listWidget_CurrentChannelSelection->setSelectionBehavior(QAbstractItemView::SelectRows);

        verticalLayout_3->addWidget(listWidget_CurrentChannelSelection);


        verticalLayout_4->addLayout(verticalLayout_3);


        verticalLayout->addWidget(groupBox_ChannelSelection);

        groupBox_TagSelection = new QGroupBox(FolderOpenDialog_BASE);
        groupBox_TagSelection->setObjectName(QString::fromUtf8("groupBox_TagSelection"));
        groupBox_TagSelection->setCheckable(true);
        groupBox_TagSelection->setChecked(false);
        hboxLayout2 = new QHBoxLayout(groupBox_TagSelection);
        hboxLayout2->setObjectName(QString::fromUtf8("hboxLayout2"));
        label_4 = new QLabel(groupBox_TagSelection);
        label_4->setObjectName(QString::fromUtf8("label_4"));
        sizePolicy6.setHeightForWidth(label_4->sizePolicy().hasHeightForWidth());
        label_4->setSizePolicy(sizePolicy6);

        hboxLayout2->addWidget(label_4);

        comboBox_Tags = new QComboBox(groupBox_TagSelection);
        comboBox_Tags->setObjectName(QString::fromUtf8("comboBox_Tags"));

        hboxLayout2->addWidget(comboBox_Tags);

        spacerItem = new QSpacerItem(151, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        hboxLayout2->addItem(spacerItem);


        verticalLayout->addWidget(groupBox_TagSelection);

        hboxLayout3 = new QHBoxLayout();
        hboxLayout3->setObjectName(QString::fromUtf8("hboxLayout3"));
        spacerItem1 = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        hboxLayout3->addItem(spacerItem1);

        pushButton_Cancel = new QPushButton(FolderOpenDialog_BASE);
        pushButton_Cancel->setObjectName(QString::fromUtf8("pushButton_Cancel"));

        hboxLayout3->addWidget(pushButton_Cancel);

        pushButton_Open = new QPushButton(FolderOpenDialog_BASE);
        pushButton_Open->setObjectName(QString::fromUtf8("pushButton_Open"));
        pushButton_Open->setDefault(true);

        hboxLayout3->addWidget(pushButton_Open);


        verticalLayout->addLayout(hboxLayout3);

        QWidget::setTabOrder(comboBox_Tags, comboBox_From);
        QWidget::setTabOrder(comboBox_From, comboBox_To);
        QWidget::setTabOrder(comboBox_To, pushButton_AddChannelRange);
        QWidget::setTabOrder(pushButton_AddChannelRange, pushButton_Open);
        QWidget::setTabOrder(pushButton_Open, pushButton_Cancel);

        retranslateUi(FolderOpenDialog_BASE);
        QObject::connect(pushButton_Cancel, SIGNAL(clicked()), FolderOpenDialog_BASE, SLOT(reject()));

        comboBox_PredefinedVKE->setCurrentIndex(0);
        stackedWidget_VKE->setCurrentIndex(0);


        QMetaObject::connectSlotsByName(FolderOpenDialog_BASE);
    } // setupUi

    void retranslateUi(QDialog *FolderOpenDialog_BASE)
    {
        FolderOpenDialog_BASE->setWindowTitle(QApplication::translate("FolderOpenDialog_BASE", "Open COOL Folder", 0, QApplication::UnicodeUTF8));
        label_5->setText(QApplication::translate("FolderOpenDialog_BASE", "Folder name:", 0, QApplication::UnicodeUTF8));
        label_FolderName->setText(QString());
        groupBox_VKE->setTitle(QApplication::translate("FolderOpenDialog_BASE", "Validaity key encoding", 0, QApplication::UnicodeUTF8));
        pushButton_RemoveVKE->setText(QApplication::translate("FolderOpenDialog_BASE", "Remove", 0, QApplication::UnicodeUTF8));
        label_6->setText(QApplication::translate("FolderOpenDialog_BASE", "Encoding details:", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_TOOLTIP
        lineEdit_PredefinedBit->setToolTip(QApplication::translate("FolderOpenDialog_BASE", "Ratio of bits used", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_TOOLTIP
        lineEdit_PredefinedBit->setText(QApplication::translate("FolderOpenDialog_BASE", "63 bits", 0, QApplication::UnicodeUTF8));
        radioButton_IOVrecent->setText(QApplication::translate("FolderOpenDialog_BASE", "Most recent only", 0, QApplication::UnicodeUTF8));
        radioButton_IOVsince->setText(QApplication::translate("FolderOpenDialog_BASE", "All IOVs valid from:", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_TOOLTIP
        dateTimeEdit_Since->setToolTip(QApplication::translate("FolderOpenDialog_BASE", "UTC time IOVs are valid from.", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_TOOLTIP
#ifndef QT_NO_WHATSTHIS
        dateTimeEdit_Since->setWhatsThis(QApplication::translate("FolderOpenDialog_BASE", "UTC time", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_WHATSTHIS
        dateTimeEdit_Since->setDisplayFormat(QApplication::translate("FolderOpenDialog_BASE", "ddd dd/MM/yyyy HH:mm:ss", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_TOOLTIP
        lineEdit_HighBits->setToolTip(QApplication::translate("FolderOpenDialog_BASE", "Name of the higher n-bits", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_TOOLTIP
        lineEdit_HighBits->setInputMask(QString());
        lineEdit_HighBits->setText(QApplication::translate("FolderOpenDialog_BASE", "CustomHigh", 0, QApplication::UnicodeUTF8));
        spinBox_HighBits->setSuffix(QApplication::translate("FolderOpenDialog_BASE", " high bits", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_TOOLTIP
        lineEdit_LowBits->setToolTip(QApplication::translate("FolderOpenDialog_BASE", "Name of the lower n-bits", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_TOOLTIP
        lineEdit_LowBits->setText(QApplication::translate("FolderOpenDialog_BASE", "CustomLow", 0, QApplication::UnicodeUTF8));
        spinBox_LowBits->setSuffix(QApplication::translate("FolderOpenDialog_BASE", " low bits", 0, QApplication::UnicodeUTF8));
        pushButton_SaveVKE->setText(QApplication::translate("FolderOpenDialog_BASE", "Save", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_TOOLTIP
        groupBox_ChannelSelection->setToolTip(QApplication::translate("FolderOpenDialog_BASE", "Leave unchecked to load all channels.", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_TOOLTIP
        groupBox_ChannelSelection->setTitle(QApplication::translate("FolderOpenDialog_BASE", "Channel selection", 0, QApplication::UnicodeUTF8));
        label_3->setText(QApplication::translate("FolderOpenDialog_BASE", "Define selection:", 0, QApplication::UnicodeUTF8));
        label->setText(QApplication::translate("FolderOpenDialog_BASE", "to", 0, QApplication::UnicodeUTF8));
        pushButton_AddChannelRange->setText(QApplication::translate("FolderOpenDialog_BASE", "Add", 0, QApplication::UnicodeUTF8));
        label_2->setText(QApplication::translate("FolderOpenDialog_BASE", "Current selections:", 0, QApplication::UnicodeUTF8));
        pushButton_RemoveChannelRange->setText(QApplication::translate("FolderOpenDialog_BASE", "Remove", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_TOOLTIP
        groupBox_TagSelection->setToolTip(QApplication::translate("FolderOpenDialog_BASE", "Leave unchecked to select the HEAD tag.", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_TOOLTIP
        groupBox_TagSelection->setTitle(QApplication::translate("FolderOpenDialog_BASE", "Tag selection", 0, QApplication::UnicodeUTF8));
        label_4->setText(QApplication::translate("FolderOpenDialog_BASE", "Choose tag:", 0, QApplication::UnicodeUTF8));
        pushButton_Cancel->setText(QApplication::translate("FolderOpenDialog_BASE", "Cancel", 0, QApplication::UnicodeUTF8));
        pushButton_Open->setText(QApplication::translate("FolderOpenDialog_BASE", "Open", 0, QApplication::UnicodeUTF8));
        Q_UNUSED(FolderOpenDialog_BASE);
    } // retranslateUi

};

namespace Ui {
    class FolderOpenDialog_BASE: public Ui_FolderOpenDialog_BASE {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_FOLDEROPENDIALOG_BASE_H
