#ifndef CONNECTIONDIALOG_H
#define CONNECTIONDIALOG_H

#include <QtCore/QString>
#include <QtCore/QHash>

#include "ACE/accesstocool.h"
#include "ACE/ui_ConnectionDialog_BASE.h"

class QCloseEvent;


class ConnectionDialog : public QDialog, private Ui::ConnectionDialog_BASE
{
    Q_OBJECT

public:
    ConnectionDialog( QWidget* parent = 0, Qt::WindowFlags f = 0 );
    ~ConnectionDialog();
    void closeConnection( QString connectionString );
    bool isConnected( QString connectionString = "" );

private:
    QHash< QString, cool::IDatabasePtr > connectionHash;
    QString dbConnectionQString;

    void closeEvent( QCloseEvent* event );
    void setConnections();
    QString buildConnectionString();
    void loadConnectionSettings( bool reload = false );
    void saveConnectionSettings();

signals:
    void buildFolderTree( cool::IDatabasePtr dbPtr, const QString connectionString );

private slots:
    void slotConnect();
    void slotRemoveHistoryEntry();
    void slotRemoveAllHistory();
    void slotPredefinedCS( bool enabled );
    void slotPrepareDBType( int choice );
    void slotPrepareDBType_2( int choice );
};

#endif
