/********************************************************************************
** Form generated from reading ui file 'ConnectionDialog_BASE.ui'
**
** Created: Fri Sep 12 05:29:42 2008
**      by: Qt User Interface Compiler version 4.3.3
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
********************************************************************************/

#ifndef UI_CONNECTIONDIALOG_BASE_H
#define UI_CONNECTIONDIALOG_BASE_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QCheckBox>
#include <QtGui/QComboBox>
#include <QtGui/QDialog>
#include <QtGui/QGridLayout>
#include <QtGui/QGroupBox>
#include <QtGui/QHBoxLayout>
#include <QtGui/QLabel>
#include <QtGui/QLineEdit>
#include <QtGui/QPushButton>
#include <QtGui/QRadioButton>
#include <QtGui/QSpacerItem>
#include <QtGui/QStackedWidget>
#include <QtGui/QTabWidget>
#include <QtGui/QVBoxLayout>
#include <QtGui/QWidget>

class Ui_ConnectionDialog_BASE
{
public:
    virtual ~Ui_ConnectionDialog_BASE(){}
    QGridLayout *gridLayout;
    QTabWidget *tabWidget_ConnectionBuilder;
    QWidget *ConnectionBuilder;
    QVBoxLayout *vboxLayout;
    QLabel *label_11;
    QRadioButton *radioButton_PredefinedConnections;
    QRadioButton *radioButton_AdhocConnections;
    QStackedWidget *stackedWidget_ConnectionBuilder;
    QWidget *page_0;
    QVBoxLayout *vboxLayout1;
    QHBoxLayout *hboxLayout;
    QCheckBox *checkBox_UseConnectionAlias;
    QComboBox *comboBox_ConnectionAlias;
    QGroupBox *groupBox_NotUsingConnectionAlias;
    QGridLayout *gridLayout1;
    QLabel *label_9;
    QComboBox *comboBox_DBType_2;
    QLabel *label_wildcard_1;
    QComboBox *comboBox_Server_2;
    QLabel *label_wildcard_2;
    QComboBox *comboBox_Schema_2;
    QHBoxLayout *hboxLayout1;
    QLabel *label_7;
    QComboBox *comboBox_Role;
    QHBoxLayout *hboxLayout2;
    QLabel *label_10;
    QComboBox *comboBox_DBName_2;
    QWidget *page_1;
    QGridLayout *gridLayout2;
    QLabel *label;
    QComboBox *comboBox_DBType;
    QLabel *label_wildcard_3;
    QComboBox *comboBox_Server;
    QLabel *label_wildcard_4;
    QComboBox *comboBox_Schema;
    QLabel *label_5;
    QComboBox *comboBox_DBName;
    QLabel *label_3;
    QComboBox *comboBox_Login;
    QLabel *label_4;
    QLineEdit *lineEdit_Password;
    QSpacerItem *spacerItem;
    QWidget *ConnectionHistory;
    QGridLayout *gridLayout3;
    QComboBox *comboBox_ConnectionHistory;
    QSpacerItem *spacerItem1;
    QPushButton *pushButton_RemoveAllHistory;
    QPushButton *pushButton_RemoveHistoryEntry;
    QSpacerItem *spacerItem2;
    QSpacerItem *spacerItem3;
    QPushButton *pushButton_Cancel;
    QPushButton *pushButton_Connect;

    void setupUi(QDialog *ConnectionDialog_BASE)
    {
    if (ConnectionDialog_BASE->objectName().isEmpty())
        ConnectionDialog_BASE->setObjectName(QString::fromUtf8("ConnectionDialog_BASE"));
    ConnectionDialog_BASE->setWindowModality(Qt::ApplicationModal);
    ConnectionDialog_BASE->resize(502, 426);
    QSizePolicy sizePolicy(QSizePolicy::Preferred, QSizePolicy::Fixed);
    sizePolicy.setHorizontalStretch(0);
    sizePolicy.setVerticalStretch(0);
    sizePolicy.setHeightForWidth(ConnectionDialog_BASE->sizePolicy().hasHeightForWidth());
    ConnectionDialog_BASE->setSizePolicy(sizePolicy);
    ConnectionDialog_BASE->setModal(true);
    gridLayout = new QGridLayout(ConnectionDialog_BASE);
    gridLayout->setObjectName(QString::fromUtf8("gridLayout"));
    tabWidget_ConnectionBuilder = new QTabWidget(ConnectionDialog_BASE);
    tabWidget_ConnectionBuilder->setObjectName(QString::fromUtf8("tabWidget_ConnectionBuilder"));
    tabWidget_ConnectionBuilder->setFocusPolicy(Qt::NoFocus);
    ConnectionBuilder = new QWidget();
    ConnectionBuilder->setObjectName(QString::fromUtf8("ConnectionBuilder"));
    vboxLayout = new QVBoxLayout(ConnectionBuilder);
    vboxLayout->setObjectName(QString::fromUtf8("vboxLayout"));
    label_11 = new QLabel(ConnectionBuilder);
    label_11->setObjectName(QString::fromUtf8("label_11"));

    vboxLayout->addWidget(label_11);

    radioButton_PredefinedConnections = new QRadioButton(ConnectionBuilder);
    radioButton_PredefinedConnections->setObjectName(QString::fromUtf8("radioButton_PredefinedConnections"));
    radioButton_PredefinedConnections->setCheckable(false);
    radioButton_PredefinedConnections->setChecked(false);

    vboxLayout->addWidget(radioButton_PredefinedConnections);

    radioButton_AdhocConnections = new QRadioButton(ConnectionBuilder);
    radioButton_AdhocConnections->setObjectName(QString::fromUtf8("radioButton_AdhocConnections"));
    radioButton_AdhocConnections->setChecked(true);

    vboxLayout->addWidget(radioButton_AdhocConnections);

    stackedWidget_ConnectionBuilder = new QStackedWidget(ConnectionBuilder);
    stackedWidget_ConnectionBuilder->setObjectName(QString::fromUtf8("stackedWidget_ConnectionBuilder"));
    stackedWidget_ConnectionBuilder->setMinimumSize(QSize(410, 240));
    stackedWidget_ConnectionBuilder->setFrameShape(QFrame::StyledPanel);
    stackedWidget_ConnectionBuilder->setFrameShadow(QFrame::Sunken);
    page_0 = new QWidget();
    page_0->setObjectName(QString::fromUtf8("page_0"));
    vboxLayout1 = new QVBoxLayout(page_0);
    vboxLayout1->setObjectName(QString::fromUtf8("vboxLayout1"));
    hboxLayout = new QHBoxLayout();
    hboxLayout->setObjectName(QString::fromUtf8("hboxLayout"));
    checkBox_UseConnectionAlias = new QCheckBox(page_0);
    checkBox_UseConnectionAlias->setObjectName(QString::fromUtf8("checkBox_UseConnectionAlias"));

    hboxLayout->addWidget(checkBox_UseConnectionAlias);

    comboBox_ConnectionAlias = new QComboBox(page_0);
    comboBox_ConnectionAlias->setObjectName(QString::fromUtf8("comboBox_ConnectionAlias"));
    comboBox_ConnectionAlias->setEnabled(false);
    QSizePolicy sizePolicy1(QSizePolicy::Preferred, QSizePolicy::Fixed);
    sizePolicy1.setHorizontalStretch(1);
    sizePolicy1.setVerticalStretch(0);
    sizePolicy1.setHeightForWidth(comboBox_ConnectionAlias->sizePolicy().hasHeightForWidth());
    comboBox_ConnectionAlias->setSizePolicy(sizePolicy1);
    comboBox_ConnectionAlias->setEditable(true);

    hboxLayout->addWidget(comboBox_ConnectionAlias);


    vboxLayout1->addLayout(hboxLayout);

    groupBox_NotUsingConnectionAlias = new QGroupBox(page_0);
    groupBox_NotUsingConnectionAlias->setObjectName(QString::fromUtf8("groupBox_NotUsingConnectionAlias"));
    groupBox_NotUsingConnectionAlias->setFlat(true);
    groupBox_NotUsingConnectionAlias->setCheckable(false);
    gridLayout1 = new QGridLayout(groupBox_NotUsingConnectionAlias);
    gridLayout1->setObjectName(QString::fromUtf8("gridLayout1"));
    gridLayout1->setVerticalSpacing(0);
    gridLayout1->setContentsMargins(0, 0, 0, 0);
    label_9 = new QLabel(groupBox_NotUsingConnectionAlias);
    label_9->setObjectName(QString::fromUtf8("label_9"));

    gridLayout1->addWidget(label_9, 0, 0, 1, 1);

    comboBox_DBType_2 = new QComboBox(groupBox_NotUsingConnectionAlias);
    comboBox_DBType_2->setObjectName(QString::fromUtf8("comboBox_DBType_2"));
    sizePolicy1.setHeightForWidth(comboBox_DBType_2->sizePolicy().hasHeightForWidth());
    comboBox_DBType_2->setSizePolicy(sizePolicy1);

    gridLayout1->addWidget(comboBox_DBType_2, 0, 1, 1, 1);

    label_wildcard_1 = new QLabel(groupBox_NotUsingConnectionAlias);
    label_wildcard_1->setObjectName(QString::fromUtf8("label_wildcard_1"));

    gridLayout1->addWidget(label_wildcard_1, 1, 0, 1, 1);

    comboBox_Server_2 = new QComboBox(groupBox_NotUsingConnectionAlias);
    comboBox_Server_2->setObjectName(QString::fromUtf8("comboBox_Server_2"));
    sizePolicy1.setHeightForWidth(comboBox_Server_2->sizePolicy().hasHeightForWidth());
    comboBox_Server_2->setSizePolicy(sizePolicy1);
    comboBox_Server_2->setEditable(true);

    gridLayout1->addWidget(comboBox_Server_2, 1, 1, 1, 1);

    label_wildcard_2 = new QLabel(groupBox_NotUsingConnectionAlias);
    label_wildcard_2->setObjectName(QString::fromUtf8("label_wildcard_2"));

    gridLayout1->addWidget(label_wildcard_2, 2, 0, 1, 1);

    comboBox_Schema_2 = new QComboBox(groupBox_NotUsingConnectionAlias);
    comboBox_Schema_2->setObjectName(QString::fromUtf8("comboBox_Schema_2"));
    sizePolicy1.setHeightForWidth(comboBox_Schema_2->sizePolicy().hasHeightForWidth());
    comboBox_Schema_2->setSizePolicy(sizePolicy1);
    comboBox_Schema_2->setEditable(true);

    gridLayout1->addWidget(comboBox_Schema_2, 2, 1, 1, 1);


    vboxLayout1->addWidget(groupBox_NotUsingConnectionAlias);

    hboxLayout1 = new QHBoxLayout();
    hboxLayout1->setObjectName(QString::fromUtf8("hboxLayout1"));
    label_7 = new QLabel(page_0);
    label_7->setObjectName(QString::fromUtf8("label_7"));

    hboxLayout1->addWidget(label_7);

    comboBox_Role = new QComboBox(page_0);
    comboBox_Role->setObjectName(QString::fromUtf8("comboBox_Role"));
    sizePolicy1.setHeightForWidth(comboBox_Role->sizePolicy().hasHeightForWidth());
    comboBox_Role->setSizePolicy(sizePolicy1);
    comboBox_Role->setEditable(true);

    hboxLayout1->addWidget(comboBox_Role);


    vboxLayout1->addLayout(hboxLayout1);

    hboxLayout2 = new QHBoxLayout();
#ifndef Q_OS_MAC
    hboxLayout2->setSpacing(-1);
#endif
    hboxLayout2->setObjectName(QString::fromUtf8("hboxLayout2"));
    label_10 = new QLabel(page_0);
    label_10->setObjectName(QString::fromUtf8("label_10"));

    hboxLayout2->addWidget(label_10);

    comboBox_DBName_2 = new QComboBox(page_0);
    comboBox_DBName_2->setObjectName(QString::fromUtf8("comboBox_DBName_2"));
    sizePolicy1.setHeightForWidth(comboBox_DBName_2->sizePolicy().hasHeightForWidth());
    comboBox_DBName_2->setSizePolicy(sizePolicy1);
    comboBox_DBName_2->setAcceptDrops(true);
    comboBox_DBName_2->setEditable(true);

    hboxLayout2->addWidget(comboBox_DBName_2);


    vboxLayout1->addLayout(hboxLayout2);

    stackedWidget_ConnectionBuilder->addWidget(page_0);
    page_1 = new QWidget();
    page_1->setObjectName(QString::fromUtf8("page_1"));
    gridLayout2 = new QGridLayout(page_1);
    gridLayout2->setObjectName(QString::fromUtf8("gridLayout2"));
    label = new QLabel(page_1);
    label->setObjectName(QString::fromUtf8("label"));

    gridLayout2->addWidget(label, 0, 0, 1, 1);

    comboBox_DBType = new QComboBox(page_1);
    comboBox_DBType->setObjectName(QString::fromUtf8("comboBox_DBType"));

    gridLayout2->addWidget(comboBox_DBType, 0, 1, 1, 1);

    label_wildcard_3 = new QLabel(page_1);
    label_wildcard_3->setObjectName(QString::fromUtf8("label_wildcard_3"));

    gridLayout2->addWidget(label_wildcard_3, 1, 0, 1, 1);

    comboBox_Server = new QComboBox(page_1);
    comboBox_Server->setObjectName(QString::fromUtf8("comboBox_Server"));
    comboBox_Server->setEditable(true);

    gridLayout2->addWidget(comboBox_Server, 1, 1, 1, 1);

    label_wildcard_4 = new QLabel(page_1);
    label_wildcard_4->setObjectName(QString::fromUtf8("label_wildcard_4"));

    gridLayout2->addWidget(label_wildcard_4, 2, 0, 1, 1);

    comboBox_Schema = new QComboBox(page_1);
    comboBox_Schema->setObjectName(QString::fromUtf8("comboBox_Schema"));
    comboBox_Schema->setAcceptDrops(true);
    comboBox_Schema->setEditable(true);

    gridLayout2->addWidget(comboBox_Schema, 2, 1, 1, 1);

    label_5 = new QLabel(page_1);
    label_5->setObjectName(QString::fromUtf8("label_5"));

    gridLayout2->addWidget(label_5, 3, 0, 1, 1);

    comboBox_DBName = new QComboBox(page_1);
    comboBox_DBName->setObjectName(QString::fromUtf8("comboBox_DBName"));
    comboBox_DBName->setAcceptDrops(true);
    comboBox_DBName->setEditable(true);

    gridLayout2->addWidget(comboBox_DBName, 3, 1, 1, 1);

    label_3 = new QLabel(page_1);
    label_3->setObjectName(QString::fromUtf8("label_3"));

    gridLayout2->addWidget(label_3, 4, 0, 1, 1);

    comboBox_Login = new QComboBox(page_1);
    comboBox_Login->setObjectName(QString::fromUtf8("comboBox_Login"));
    comboBox_Login->setAcceptDrops(true);
    comboBox_Login->setEditable(true);

    gridLayout2->addWidget(comboBox_Login, 4, 1, 1, 1);

    label_4 = new QLabel(page_1);
    label_4->setObjectName(QString::fromUtf8("label_4"));

    gridLayout2->addWidget(label_4, 5, 0, 1, 1);

    lineEdit_Password = new QLineEdit(page_1);
    lineEdit_Password->setObjectName(QString::fromUtf8("lineEdit_Password"));
    lineEdit_Password->setEchoMode(QLineEdit::Password);

    gridLayout2->addWidget(lineEdit_Password, 5, 1, 1, 1);

    spacerItem = new QSpacerItem(20, 91, QSizePolicy::Minimum, QSizePolicy::Expanding);

    gridLayout2->addItem(spacerItem, 6, 1, 1, 1);

    stackedWidget_ConnectionBuilder->addWidget(page_1);

    vboxLayout->addWidget(stackedWidget_ConnectionBuilder);

    tabWidget_ConnectionBuilder->addTab(ConnectionBuilder, QString());
    ConnectionHistory = new QWidget();
    ConnectionHistory->setObjectName(QString::fromUtf8("ConnectionHistory"));
    gridLayout3 = new QGridLayout(ConnectionHistory);
    gridLayout3->setObjectName(QString::fromUtf8("gridLayout3"));
    comboBox_ConnectionHistory = new QComboBox(ConnectionHistory);
    comboBox_ConnectionHistory->setObjectName(QString::fromUtf8("comboBox_ConnectionHistory"));
    comboBox_ConnectionHistory->setFocusPolicy(Qt::TabFocus);

    gridLayout3->addWidget(comboBox_ConnectionHistory, 0, 0, 1, 3);

    spacerItem1 = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

    gridLayout3->addItem(spacerItem1, 1, 0, 1, 1);

    pushButton_RemoveAllHistory = new QPushButton(ConnectionHistory);
    pushButton_RemoveAllHistory->setObjectName(QString::fromUtf8("pushButton_RemoveAllHistory"));
    pushButton_RemoveAllHistory->setFocusPolicy(Qt::NoFocus);

    gridLayout3->addWidget(pushButton_RemoveAllHistory, 1, 1, 1, 1);

    pushButton_RemoveHistoryEntry = new QPushButton(ConnectionHistory);
    pushButton_RemoveHistoryEntry->setObjectName(QString::fromUtf8("pushButton_RemoveHistoryEntry"));
    pushButton_RemoveHistoryEntry->setFocusPolicy(Qt::NoFocus);

    gridLayout3->addWidget(pushButton_RemoveHistoryEntry, 1, 2, 1, 1);

    spacerItem2 = new QSpacerItem(20, 41, QSizePolicy::Minimum, QSizePolicy::Expanding);

    gridLayout3->addItem(spacerItem2, 2, 1, 1, 1);

    tabWidget_ConnectionBuilder->addTab(ConnectionHistory, QString());

    gridLayout->addWidget(tabWidget_ConnectionBuilder, 0, 0, 1, 5);

    spacerItem3 = new QSpacerItem(21, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

    gridLayout->addItem(spacerItem3, 1, 0, 1, 3);

    pushButton_Cancel = new QPushButton(ConnectionDialog_BASE);
    pushButton_Cancel->setObjectName(QString::fromUtf8("pushButton_Cancel"));

    gridLayout->addWidget(pushButton_Cancel, 1, 3, 1, 1);

    pushButton_Connect = new QPushButton(ConnectionDialog_BASE);
    pushButton_Connect->setObjectName(QString::fromUtf8("pushButton_Connect"));
    pushButton_Connect->setDefault(true);

    gridLayout->addWidget(pushButton_Connect, 1, 4, 1, 1);

    QWidget::setTabOrder(radioButton_PredefinedConnections, radioButton_AdhocConnections);
    QWidget::setTabOrder(radioButton_AdhocConnections, checkBox_UseConnectionAlias);
    QWidget::setTabOrder(checkBox_UseConnectionAlias, comboBox_ConnectionAlias);
    QWidget::setTabOrder(comboBox_ConnectionAlias, comboBox_DBType_2);
    QWidget::setTabOrder(comboBox_DBType_2, comboBox_Server_2);
    QWidget::setTabOrder(comboBox_Server_2, comboBox_Schema_2);
    QWidget::setTabOrder(comboBox_Schema_2, comboBox_Role);
    QWidget::setTabOrder(comboBox_Role, comboBox_DBName_2);
    QWidget::setTabOrder(comboBox_DBName_2, comboBox_DBType);
    QWidget::setTabOrder(comboBox_DBType, comboBox_Server);
    QWidget::setTabOrder(comboBox_Server, comboBox_Schema);
    QWidget::setTabOrder(comboBox_Schema, comboBox_DBName);
    QWidget::setTabOrder(comboBox_DBName, comboBox_Login);
    QWidget::setTabOrder(comboBox_Login, lineEdit_Password);
    QWidget::setTabOrder(lineEdit_Password, comboBox_ConnectionHistory);
    QWidget::setTabOrder(comboBox_ConnectionHistory, pushButton_Connect);
    QWidget::setTabOrder(pushButton_Connect, pushButton_Cancel);

    retranslateUi(ConnectionDialog_BASE);
    QObject::connect(pushButton_Cancel, SIGNAL(clicked()), ConnectionDialog_BASE, SLOT(reject()));
    QObject::connect(comboBox_ConnectionHistory, SIGNAL(activated(int)), pushButton_Connect, SLOT(setFocus()));
    QObject::connect(comboBox_DBType, SIGNAL(activated(int)), comboBox_Server, SLOT(setFocus()));
    QObject::connect(comboBox_Server, SIGNAL(activated(int)), comboBox_Login, SLOT(setFocus()));
    QObject::connect(comboBox_Login, SIGNAL(activated(int)), lineEdit_Password, SLOT(setFocus()));
    QObject::connect(lineEdit_Password, SIGNAL(returnPressed()), pushButton_Connect, SLOT(setFocus()));
    QObject::connect(checkBox_UseConnectionAlias, SIGNAL(toggled(bool)), comboBox_ConnectionAlias, SLOT(setEnabled(bool)));
    QObject::connect(checkBox_UseConnectionAlias, SIGNAL(toggled(bool)), groupBox_NotUsingConnectionAlias, SLOT(setDisabled(bool)));
    QObject::connect(comboBox_DBName_2, SIGNAL(activated(int)), pushButton_Connect, SLOT(setFocus()));

    tabWidget_ConnectionBuilder->setCurrentIndex(0);
    stackedWidget_ConnectionBuilder->setCurrentIndex(1);


    QMetaObject::connectSlotsByName(ConnectionDialog_BASE);
    } // setupUi

    void retranslateUi(QDialog *ConnectionDialog_BASE)
    {
    ConnectionDialog_BASE->setWindowTitle(QApplication::translate("ConnectionDialog_BASE", "Open COOL connection", 0, QApplication::UnicodeUTF8));
    label_11->setText(QApplication::translate("ConnectionDialog_BASE", "Select connection string creation method", 0, QApplication::UnicodeUTF8));
    radioButton_PredefinedConnections->setText(QApplication::translate("ConnectionDialog_BASE", "Predefined connections", 0, QApplication::UnicodeUTF8));
    radioButton_AdhocConnections->setText(QApplication::translate("ConnectionDialog_BASE", "Adhoc connections", 0, QApplication::UnicodeUTF8));
    checkBox_UseConnectionAlias->setText(QApplication::translate("ConnectionDialog_BASE", "Use connection alias:", 0, QApplication::UnicodeUTF8));
    groupBox_NotUsingConnectionAlias->setTitle(QString());
    label_9->setText(QApplication::translate("ConnectionDialog_BASE", "Database type:", 0, QApplication::UnicodeUTF8));
    comboBox_DBType_2->clear();
    comboBox_DBType_2->insertItems(0, QStringList()
     << QApplication::translate("ConnectionDialog_BASE", "oracle://", 0, QApplication::UnicodeUTF8)
     << QApplication::translate("ConnectionDialog_BASE", "mysql://", 0, QApplication::UnicodeUTF8)
     << QApplication::translate("ConnectionDialog_BASE", "sqlite_file:", 0, QApplication::UnicodeUTF8)
    );
    label_wildcard_1->setText(QApplication::translate("ConnectionDialog_BASE", "Server:", 0, QApplication::UnicodeUTF8));
    label_wildcard_2->setText(QApplication::translate("ConnectionDialog_BASE", "Schema:", 0, QApplication::UnicodeUTF8));
    label_7->setText(QApplication::translate("ConnectionDialog_BASE", "Role:", 0, QApplication::UnicodeUTF8));
    label_10->setText(QApplication::translate("ConnectionDialog_BASE", "DB Instance:", 0, QApplication::UnicodeUTF8));
    label->setText(QApplication::translate("ConnectionDialog_BASE", "Database type:", 0, QApplication::UnicodeUTF8));
    comboBox_DBType->clear();
    comboBox_DBType->insertItems(0, QStringList()
     << QApplication::translate("ConnectionDialog_BASE", "oracle", 0, QApplication::UnicodeUTF8)
     << QApplication::translate("ConnectionDialog_BASE", "mysql", 0, QApplication::UnicodeUTF8)
     << QApplication::translate("ConnectionDialog_BASE", "sqlite", 0, QApplication::UnicodeUTF8)
    );
    label_wildcard_3->setText(QApplication::translate("ConnectionDialog_BASE", "Server:", 0, QApplication::UnicodeUTF8));
    label_wildcard_4->setText(QApplication::translate("ConnectionDialog_BASE", "Schema:", 0, QApplication::UnicodeUTF8));
    label_5->setText(QApplication::translate("ConnectionDialog_BASE", "DB Instance:", 0, QApplication::UnicodeUTF8));
    label_3->setText(QApplication::translate("ConnectionDialog_BASE", "Login:", 0, QApplication::UnicodeUTF8));
    label_4->setText(QApplication::translate("ConnectionDialog_BASE", "Password:", 0, QApplication::UnicodeUTF8));
    tabWidget_ConnectionBuilder->setTabText(tabWidget_ConnectionBuilder->indexOf(ConnectionBuilder), QApplication::translate("ConnectionDialog_BASE", "Connection Builder", 0, QApplication::UnicodeUTF8));
    pushButton_RemoveAllHistory->setText(QApplication::translate("ConnectionDialog_BASE", "Clear All", 0, QApplication::UnicodeUTF8));
    pushButton_RemoveHistoryEntry->setText(QApplication::translate("ConnectionDialog_BASE", "Remove Entry", 0, QApplication::UnicodeUTF8));
    tabWidget_ConnectionBuilder->setTabText(tabWidget_ConnectionBuilder->indexOf(ConnectionHistory), QApplication::translate("ConnectionDialog_BASE", "Connection History", 0, QApplication::UnicodeUTF8));
    pushButton_Cancel->setText(QApplication::translate("ConnectionDialog_BASE", "Cancel", 0, QApplication::UnicodeUTF8));
    pushButton_Connect->setText(QApplication::translate("ConnectionDialog_BASE", "Connect", 0, QApplication::UnicodeUTF8));
    Q_UNUSED(ConnectionDialog_BASE);
    } // retranslateUi

};

namespace Ui 
{
  class ConnectionDialog_BASE: public Ui_ConnectionDialog_BASE 
  {
  public:
    virtual ~ConnectionDialog_BASE(){}
  };
} // namespace Ui

#endif // UI_CONNECTIONDIALOG_BASE_H
