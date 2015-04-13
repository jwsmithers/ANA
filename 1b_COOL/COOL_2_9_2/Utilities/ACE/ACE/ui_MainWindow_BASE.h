/********************************************************************************
** Form generated from reading ui file 'MainWindow_BASE.ui'
**
** Created: Tue Apr 15 16:34:25 2008
**      by: Qt User Interface Compiler version 4.3.3
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
********************************************************************************/

#ifndef UI_MAINWINDOW_BASE_H
#define UI_MAINWINDOW_BASE_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QMainWindow>
#include <QtGui/QMenu>
#include <QtGui/QMenuBar>
#include <QtGui/QStatusBar>
#include <QtGui/QTabWidget>
#include <QtGui/QToolBar>
#include <QtGui/QVBoxLayout>
#include <QtGui/QWidget>

class Ui_MainWindow_BASE
{
public:
    virtual ~Ui_MainWindow_BASE(){}
    QAction *action_ConnectionOpen;
    QAction *action_ConnectionCopy;
    QAction *action_ConnectionProperties;
    QAction *action_ConnectionDisconnect;
    QAction *action_ConnectionRefresh;
    QAction *action_ConnectionQuit;
    QAction *action_FolderNew;
    QAction *action_FolderCopy;
    QAction *action_FolderDelete;
    QAction *action_FolderProperties;
    QAction *action_FolderFilter;
    QAction *action_FolderCommit;
    QAction *action_FolderCommitAll;
    QAction *actionAbout;
    QWidget *centralwidget;
    QVBoxLayout *vboxLayout;
    QTabWidget *tabWidget_Connections;
    QWidget *tab;
    QMenuBar *menubar;
    QMenu *menu_Connection;
    QMenu *menu_Folder;
    QMenu *menu_Preferences;
    QMenu *menu_Help;
    QMenu *menu_View;
    QStatusBar *statusbar;
    QToolBar *toolBar;

    void setupUi(QMainWindow *MainWindow_BASE)
    {
    if (MainWindow_BASE->objectName().isEmpty())
        MainWindow_BASE->setObjectName(QString::fromUtf8("MainWindow_BASE"));
    MainWindow_BASE->resize(696, 329);
    MainWindow_BASE->setMinimumSize(QSize(696, 0));
    QFont font;
    font.setPointSize(12);
    font.setStyleStrategy(QFont::PreferDefault);
    MainWindow_BASE->setFont(font);
    MainWindow_BASE->setDockOptions(QMainWindow::AllowNestedDocks|QMainWindow::AllowTabbedDocks|QMainWindow::AnimatedDocks);
    action_ConnectionOpen = new QAction(MainWindow_BASE);
    action_ConnectionOpen->setObjectName(QString::fromUtf8("action_ConnectionOpen"));
    action_ConnectionOpen->setIcon(QIcon(QString::fromUtf8(":/action_icons/icons/network_online.png")));
    action_ConnectionCopy = new QAction(MainWindow_BASE);
    action_ConnectionCopy->setObjectName(QString::fromUtf8("action_ConnectionCopy"));
    action_ConnectionCopy->setEnabled(false);
    action_ConnectionProperties = new QAction(MainWindow_BASE);
    action_ConnectionProperties->setObjectName(QString::fromUtf8("action_ConnectionProperties"));
    action_ConnectionProperties->setEnabled(false);
    action_ConnectionProperties->setIcon(QIcon(QString::fromUtf8(":/action_icons/icons/control_panel.png")));
    action_ConnectionProperties->setVisible(false);
    action_ConnectionDisconnect = new QAction(MainWindow_BASE);
    action_ConnectionDisconnect->setObjectName(QString::fromUtf8("action_ConnectionDisconnect"));
    action_ConnectionDisconnect->setEnabled(false);
    action_ConnectionDisconnect->setIcon(QIcon(QString::fromUtf8(":/action_icons/icons/network_offline.png")));
    action_ConnectionDisconnect->setVisible(true);
    action_ConnectionRefresh = new QAction(MainWindow_BASE);
    action_ConnectionRefresh->setObjectName(QString::fromUtf8("action_ConnectionRefresh"));
    action_ConnectionRefresh->setEnabled(false);
    action_ConnectionRefresh->setIcon(QIcon(QString::fromUtf8(":/action_icons/icons/exec.png")));
    action_ConnectionRefresh->setVisible(false);
    action_ConnectionQuit = new QAction(MainWindow_BASE);
    action_ConnectionQuit->setObjectName(QString::fromUtf8("action_ConnectionQuit"));
    action_ConnectionQuit->setIcon(QIcon(QString::fromUtf8(":/action_icons/icons/button_cancel.png")));
    action_FolderNew = new QAction(MainWindow_BASE);
    action_FolderNew->setObjectName(QString::fromUtf8("action_FolderNew"));
    action_FolderNew->setEnabled(false);
    action_FolderNew->setIcon(QIcon(QString::fromUtf8(":/action_icons/icons/folder_edit.png")));
    action_FolderNew->setVisible(false);
    action_FolderCopy = new QAction(MainWindow_BASE);
    action_FolderCopy->setObjectName(QString::fromUtf8("action_FolderCopy"));
    action_FolderCopy->setEnabled(false);
    action_FolderCopy->setIcon(QIcon(QString::fromUtf8(":/action_icons/icons/folder_documents.png")));
    action_FolderCopy->setVisible(false);
    action_FolderDelete = new QAction(MainWindow_BASE);
    action_FolderDelete->setObjectName(QString::fromUtf8("action_FolderDelete"));
    action_FolderDelete->setEnabled(false);
    action_FolderDelete->setIcon(QIcon(QString::fromUtf8(":/action_icons/icons/trash_full.png")));
    action_FolderDelete->setVisible(false);
    action_FolderProperties = new QAction(MainWindow_BASE);
    action_FolderProperties->setObjectName(QString::fromUtf8("action_FolderProperties"));
    action_FolderProperties->setEnabled(false);
    action_FolderProperties->setIcon(QIcon(QString::fromUtf8(":/action_icons/icons/folder_properties.png")));
    action_FolderProperties->setVisible(false);
    action_FolderFilter = new QAction(MainWindow_BASE);
    action_FolderFilter->setObjectName(QString::fromUtf8("action_FolderFilter"));
    action_FolderFilter->setCheckable(true);
    action_FolderFilter->setIcon(QIcon(QString::fromUtf8(":/action_icons/icons/folder_app2.png")));
    action_FolderFilter->setVisible(true);
    action_FolderCommit = new QAction(MainWindow_BASE);
    action_FolderCommit->setObjectName(QString::fromUtf8("action_FolderCommit"));
    action_FolderCommit->setEnabled(false);
    action_FolderCommit->setIcon(QIcon(QString::fromUtf8(":/action_icons/icons/button_ok.png")));
    action_FolderCommitAll = new QAction(MainWindow_BASE);
    action_FolderCommitAll->setObjectName(QString::fromUtf8("action_FolderCommitAll"));
    action_FolderCommitAll->setEnabled(false);
    action_FolderCommitAll->setVisible(true);
    actionAbout = new QAction(MainWindow_BASE);
    actionAbout->setObjectName(QString::fromUtf8("actionAbout"));
    actionAbout->setEnabled(false);
    centralwidget = new QWidget(MainWindow_BASE);
    centralwidget->setObjectName(QString::fromUtf8("centralwidget"));
    vboxLayout = new QVBoxLayout(centralwidget);
    vboxLayout->setObjectName(QString::fromUtf8("vboxLayout"));
    tabWidget_Connections = new QTabWidget(centralwidget);
    tabWidget_Connections->setObjectName(QString::fromUtf8("tabWidget_Connections"));
    QSizePolicy sizePolicy(QSizePolicy::MinimumExpanding, QSizePolicy::Expanding);
    sizePolicy.setHorizontalStretch(0);
    sizePolicy.setVerticalStretch(0);
    sizePolicy.setHeightForWidth(tabWidget_Connections->sizePolicy().hasHeightForWidth());
    tabWidget_Connections->setSizePolicy(sizePolicy);
    tabWidget_Connections->setMinimumSize(QSize(250, 0));
    tabWidget_Connections->setTabPosition(QTabWidget::West);
    tab = new QWidget();
    tab->setObjectName(QString::fromUtf8("tab"));
    tabWidget_Connections->addTab(tab, QString());

    vboxLayout->addWidget(tabWidget_Connections);

    MainWindow_BASE->setCentralWidget(centralwidget);
    menubar = new QMenuBar(MainWindow_BASE);
    menubar->setObjectName(QString::fromUtf8("menubar"));
    menubar->setGeometry(QRect(0, 0, 696, 22));
    menu_Connection = new QMenu(menubar);
    menu_Connection->setObjectName(QString::fromUtf8("menu_Connection"));
    menu_Folder = new QMenu(menubar);
    menu_Folder->setObjectName(QString::fromUtf8("menu_Folder"));
    menu_Folder->setEnabled(true);
    menu_Preferences = new QMenu(menubar);
    menu_Preferences->setObjectName(QString::fromUtf8("menu_Preferences"));
    menu_Preferences->setEnabled(false);
    menu_Help = new QMenu(menubar);
    menu_Help->setObjectName(QString::fromUtf8("menu_Help"));
    menu_Help->setEnabled(false);
    menu_View = new QMenu(menubar);
    menu_View->setObjectName(QString::fromUtf8("menu_View"));
    menu_View->setEnabled(false);
    MainWindow_BASE->setMenuBar(menubar);
    statusbar = new QStatusBar(MainWindow_BASE);
    statusbar->setObjectName(QString::fromUtf8("statusbar"));
    MainWindow_BASE->setStatusBar(statusbar);
    toolBar = new QToolBar(MainWindow_BASE);
    toolBar->setObjectName(QString::fromUtf8("toolBar"));
    toolBar->setEnabled(true);
    toolBar->setMovable(false);
    toolBar->setToolButtonStyle(Qt::ToolButtonTextUnderIcon);
    toolBar->setFloatable(false);
    MainWindow_BASE->addToolBar(Qt::TopToolBarArea, toolBar);

    menubar->addAction(menu_Connection->menuAction());
    menubar->addAction(menu_Folder->menuAction());
    menubar->addAction(menu_Preferences->menuAction());
    menubar->addAction(menu_View->menuAction());
    menubar->addAction(menu_Help->menuAction());
    menu_Connection->addAction(action_ConnectionOpen);
    menu_Connection->addAction(action_ConnectionDisconnect);
    menu_Connection->addSeparator();
    menu_Connection->addAction(action_ConnectionProperties);
    menu_Connection->addAction(action_ConnectionRefresh);
    menu_Connection->addSeparator();
    menu_Connection->addAction(action_ConnectionQuit);
    menu_Folder->addAction(action_FolderNew);
    menu_Folder->addAction(action_FolderCopy);
    menu_Folder->addAction(action_FolderDelete);
    menu_Folder->addSeparator();
    menu_Folder->addAction(action_FolderProperties);
    menu_Folder->addAction(action_FolderCommit);
    menu_Folder->addAction(action_FolderCommitAll);
    menu_Folder->addSeparator();
    menu_Folder->addAction(action_FolderFilter);
    menu_Help->addAction(actionAbout);
    toolBar->addAction(action_ConnectionOpen);
    toolBar->addAction(action_ConnectionRefresh);
    toolBar->addAction(action_ConnectionDisconnect);
    toolBar->addSeparator();
    toolBar->addAction(action_FolderFilter);
    toolBar->addAction(action_FolderCommit);

    retranslateUi(MainWindow_BASE);
    QObject::connect(action_ConnectionQuit, SIGNAL(triggered()), MainWindow_BASE, SLOT(close()));

    tabWidget_Connections->setCurrentIndex(0);


    QMetaObject::connectSlotsByName(MainWindow_BASE);
    } // setupUi

    void retranslateUi(QMainWindow *MainWindow_BASE)
    {
    MainWindow_BASE->setWindowTitle(QApplication::translate("MainWindow_BASE", "ACE - A COOL Editor", 0, QApplication::UnicodeUTF8));
    action_ConnectionOpen->setText(QApplication::translate("MainWindow_BASE", "&Open", 0, QApplication::UnicodeUTF8));
    action_ConnectionCopy->setText(QApplication::translate("MainWindow_BASE", "Copy", 0, QApplication::UnicodeUTF8));
    action_ConnectionProperties->setText(QApplication::translate("MainWindow_BASE", "Properties", 0, QApplication::UnicodeUTF8));
    action_ConnectionDisconnect->setText(QApplication::translate("MainWindow_BASE", "Disconnect", 0, QApplication::UnicodeUTF8));
    action_ConnectionRefresh->setText(QApplication::translate("MainWindow_BASE", "Refresh", 0, QApplication::UnicodeUTF8));
    action_ConnectionQuit->setText(QApplication::translate("MainWindow_BASE", "Quit", 0, QApplication::UnicodeUTF8));
    action_FolderNew->setText(QApplication::translate("MainWindow_BASE", "&New", 0, QApplication::UnicodeUTF8));
    action_FolderCopy->setText(QApplication::translate("MainWindow_BASE", "&Copy", 0, QApplication::UnicodeUTF8));
    action_FolderDelete->setText(QApplication::translate("MainWindow_BASE", "&Delete", 0, QApplication::UnicodeUTF8));
    action_FolderProperties->setText(QApplication::translate("MainWindow_BASE", "Properties", 0, QApplication::UnicodeUTF8));
    action_FolderFilter->setText(QApplication::translate("MainWindow_BASE", "F&ilter", 0, QApplication::UnicodeUTF8));
    action_FolderFilter->setToolTip(QApplication::translate("MainWindow_BASE", "Toggle most recent entries", 0, QApplication::UnicodeUTF8));
    action_FolderCommit->setText(QApplication::translate("MainWindow_BASE", "Commit", 0, QApplication::UnicodeUTF8));
    action_FolderCommitAll->setText(QApplication::translate("MainWindow_BASE", "Commit All", 0, QApplication::UnicodeUTF8));
    actionAbout->setText(QApplication::translate("MainWindow_BASE", "About", 0, QApplication::UnicodeUTF8));
    tabWidget_Connections->setTabText(tabWidget_Connections->indexOf(tab), QApplication::translate("MainWindow_BASE", "No current connection", 0, QApplication::UnicodeUTF8));
    menu_Connection->setTitle(QApplication::translate("MainWindow_BASE", "&Connection", 0, QApplication::UnicodeUTF8));
    menu_Folder->setTitle(QApplication::translate("MainWindow_BASE", "&Folder", 0, QApplication::UnicodeUTF8));
    menu_Preferences->setTitle(QApplication::translate("MainWindow_BASE", "&Preferences", 0, QApplication::UnicodeUTF8));
    menu_Help->setWindowTitle(QApplication::translate("MainWindow_BASE", "COOL Editor", 0, QApplication::UnicodeUTF8));
    menu_Help->setTitle(QApplication::translate("MainWindow_BASE", "&Help", 0, QApplication::UnicodeUTF8));
    menu_View->setTitle(QApplication::translate("MainWindow_BASE", "&View", 0, QApplication::UnicodeUTF8));
    toolBar->setWindowTitle(QApplication::translate("MainWindow_BASE", "toolBar", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui 
{
  class MainWindow_BASE: public Ui_MainWindow_BASE 
  {
  public:
    virtual ~MainWindow_BASE(){}
  };
} // namespace Ui

#endif // UI_MAINWINDOW_BASE_H
