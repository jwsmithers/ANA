#include <QtGui/QCloseEvent>
#include <QtGui/QMessageBox>
#include <QtCore/QtDebug>
#include <QtCore/QPoint>
#include <QtCore/QSize>
#include <QtCore/QSettings>
#include <QtCore/QStringList>
#include <QtCore/QObject>

#include "ACE/ConnectionDialog.h"

ConnectionDialog::ConnectionDialog( QWidget* parent, Qt::WindowFlags f ) :
    QDialog( parent, f ),
    dbConnectionQString("")
{
    setupUi( this );
//    pushButton_TestConnection->setVisible( false );
    setConnections(); // Qt connections
    loadConnectionSettings();
}

ConnectionDialog::~ConnectionDialog()
{
}

void ConnectionDialog::setConnections()
{
    QObject::connect( pushButton_Connect, SIGNAL( clicked() ), this, SLOT( slotConnect() ) );
    QObject::connect( pushButton_RemoveAllHistory, SIGNAL( clicked() ), this, SLOT( slotRemoveAllHistory() ) );
    QObject::connect( pushButton_RemoveHistoryEntry, SIGNAL( clicked() ), this, SLOT( slotRemoveHistoryEntry() ) );
    QObject::connect( radioButton_PredefinedConnections, SIGNAL( toggled( bool ) ), this, SLOT( slotPredefinedCS( bool ) ) );
    QObject::connect( comboBox_DBType, SIGNAL( activated( int ) ), this, SLOT( slotPrepareDBType( int ) ) );
    QObject::connect( comboBox_DBType_2, SIGNAL( activated( int ) ), this, SLOT( slotPrepareDBType_2( int ) ) );
}

void ConnectionDialog::closeEvent( QCloseEvent* event )
{
    event->accept();
}

QString ConnectionDialog::buildConnectionString()
{
    // Establish connection using connection string from connection history
    if ( tabWidget_ConnectionBuilder->currentIndex() == 1 )
        return comboBox_ConnectionHistory->currentText();
    // Establish connection using connection string from connection builder
    QString csComponent = "";

    if ( stackedWidget_ConnectionBuilder->currentIndex() == 0 )  // Predefined connection string
    {
        if ( checkBox_UseConnectionAlias->isChecked() )
        {
            if ( comboBox_ConnectionAlias->currentText().isEmpty() )
            {
                QMessageBox::warning(
                    this, 
                    trUtf8( "Connection string invalid!" ),
                    trUtf8( "Connection Alias is empty!" ),
                    QMessageBox::Ok, 
                    QMessageBox::Ok );
                return QString();
            }
            csComponent.append( comboBox_ConnectionAlias->currentText() );
        }
        else // not using alias
        {
            csComponent.append( comboBox_DBType_2->currentText() );
            csComponent.append( comboBox_Server_2->currentText() );
            if ( comboBox_Schema_2->isVisible() ) 
            {
                csComponent.append( "/" ).append( comboBox_Schema_2->currentText() );
            }
        }
        if ( !comboBox_Role->currentText().isEmpty() )
        {
            csComponent.append( "(" ).append( comboBox_Role->currentText() ).append( ")" );
        }
        if ( comboBox_DBName_2->currentText().isEmpty() )
        {
            QMessageBox::warning(
                this, 
                trUtf8( "Connection string invalid!" ),
                trUtf8( "COOL database instance is empty!" ),
                QMessageBox::Ok, 
                QMessageBox::Ok );
            return QString();
        }
        csComponent.append("/").append( comboBox_DBName_2->currentText() );
/*
        QMessageBox::information(
            this, 
            trUtf8( "Connection String" ),
            csComponent,
            QMessageBox::Ok, 
            QMessageBox::Ok );
*/
    }
    else  // Adhoc connection string
    {
        QStringList csList;
        csComponent = comboBox_Server->lineEdit()->text().trimmed();
        if ( csComponent.isEmpty() ) // No server defined
            csList << comboBox_DBType->currentText().append( "://");
        else
            csList << comboBox_DBType->currentText().append( "://").append( csComponent );
        csComponent = comboBox_Schema->lineEdit()->text().trimmed();
        if ( !csComponent.isEmpty() )
        {
            csList << QString( "schema=" ).append( csComponent );
        }
        csComponent = comboBox_DBName->lineEdit()->text().trimmed();
        if  ( !csComponent.isEmpty() )
        {
            csList << QString( "dbname=" ).append( csComponent );
        }
        csComponent = comboBox_Login->lineEdit()->text().trimmed();
        if ( !csComponent.isEmpty() )
        {
            csList << QString( "user=" ).append( csComponent );
        }
        csComponent = lineEdit_Password->text().trimmed();
        if ( !csComponent.isEmpty() )
        {
            csList << QString( "password=" ).append( csComponent );
        }
        csComponent = csList.join( ";" );
    }
    return csComponent;
}

void ConnectionDialog::slotPredefinedCS( bool enabled )
{
    stackedWidget_ConnectionBuilder->setCurrentIndex( ( int ) ( !enabled ) );
}

void ConnectionDialog::slotPrepareDBType_2( int choice )
{
    switch ( choice )
    {
        case 0: // Oracle
            label_wildcard_1->setText( trUtf8( "Server:", "Oracle server address" ) );
            label_wildcard_2->setVisible( true );
            label_wildcard_2->setText( trUtf8( "Schema:", "Oracle database schema" ) );
            comboBox_Schema_2->setVisible( true );
            
            break;
        case 1: // MySql
            label_wildcard_1->setText( trUtf8( "Host:", "MySQL host address" ) );
            label_wildcard_2->setVisible( true );
            label_wildcard_2->setText( trUtf8( "Database:", "MySQL database" ) );
            comboBox_Schema_2->setVisible( true );
        
        
            break;
        case 2: // SQLite
            label_wildcard_1->setText( trUtf8( "File:", "Full path to SQLite database file" ) );
            label_wildcard_2->setVisible( false );
            comboBox_Schema_2->setVisible( false );
    
    
            break;
    }

}

void ConnectionDialog::slotPrepareDBType( int /*choice*/ )
{
    return;
}

void ConnectionDialog::slotConnect()
{
    // Handle to the cool database
    cool::IDatabasePtr dbPtr;
    dbConnectionQString = buildConnectionString();
    if ( dbConnectionQString.isEmpty() )
    {
        return;
    }
    cool::DatabaseId dbConnectionId( dbConnectionQString.toStdString() );
    
    if ( connectionHash.contains( dbConnectionQString ) )
    {
        QMessageBox::information(
            this, 
            trUtf8( "Connection Error" ),
            trUtf8( "Connection already exists." ),
            QMessageBox::Ok, 
            QMessageBox::Ok );
        return;
    }
    
    if ( cool::openDatabase( dbConnectionId, dbPtr ) )
    {
        connectionHash[ dbConnectionQString ] = dbPtr;
        emit buildFolderTree( dbPtr, dbConnectionQString );
    }
    else
    {
        QMessageBox::warning(
            this, 
            trUtf8( "Connection Error" ),
            trUtf8( "Could not establish connection to database." ),
            QMessageBox::Ok, 
            QMessageBox::Ok );
//        cool::createTestDB();
        return;
    }
    saveConnectionSettings();
    loadConnectionSettings( true );
    close();
}

void ConnectionDialog::slotRemoveHistoryEntry()
{
    comboBox_ConnectionHistory->removeItem( comboBox_ConnectionHistory->currentIndex() );
}

void ConnectionDialog::slotRemoveAllHistory()
{
    comboBox_ConnectionHistory->clear();
}

void ConnectionDialog::loadConnectionSettings( bool reload )
{
    QSettings settings;
    int aSize;

    // Look into ConnectionDialog section of configuration
    settings.beginGroup( objectName() ); // ConnectionDialog
    
    if ( !reload )
    {
        // load GUI settings
        resize( settings.value( "size", QSize( 400, 400 ) ).toSize() );
        move( settings.value( "pos", QPoint( 200, 200) ).toPoint() );
        tabWidget_ConnectionBuilder->setCurrentIndex( settings.value( "page" ).toInt() );
    }
    // Load connection history
    settings.beginGroup( comboBox_ConnectionHistory->objectName() );
    aSize = settings.beginReadArray( "history" );
    comboBox_ConnectionHistory->clear();
    for ( int i = 0; i < aSize; ++i )
    {
        settings.setArrayIndex( i );
        comboBox_ConnectionHistory->addItem( settings.value( "item", "" ).toString() );
    }
    settings.endArray(); // connectionhistory
    // Set connection history entry position
    comboBox_ConnectionHistory->setCurrentIndex( settings.value( "index", 0 ).toInt() );
    settings.endGroup(); // comboBox_ConnectionHistory
    
    if (!reload)
    {
        // Set DBType entry position
        settings.beginGroup( comboBox_DBType->objectName() );
        comboBox_DBType->setCurrentIndex( settings.value( "index", 0 ).toInt() );
        settings.endGroup(); // comboBox_DBType
    }
    // Load Server history 
    settings.beginGroup( comboBox_Server->objectName() );
    aSize = settings.beginReadArray( "history" );
    comboBox_Server->clear();
    for ( int i = 0; i < aSize; ++i )
    {
        settings.setArrayIndex( i );
        comboBox_Server->addItem( settings.value( "item", "" ).toString() );
    }
    settings.endArray();
    // Set Server history entry position
    comboBox_Server->setCurrentIndex( 0 );
    settings.endGroup(); // comboBox_Server

    // Load Login history 
    settings.beginGroup( comboBox_Login->objectName() );
    aSize = settings.beginReadArray( "history" );
    comboBox_Login->clear();
    for ( int i = 0; i < aSize; ++i )
    {
        settings.setArrayIndex( i );
        comboBox_Login->addItem( settings.value( "item", "" ).toString() );
    }
    settings.endArray();
    // Set Login history entry position
    comboBox_Login->setCurrentIndex( 0 );
    settings.endGroup(); // comboBox_Login


    // Load Schema history 
    settings.beginGroup( comboBox_Schema->objectName() );
    aSize = settings.beginReadArray( "history" );
    comboBox_Schema->clear();
    for ( int i = 0; i < aSize; ++i )
    {
        settings.setArrayIndex( i );
        comboBox_Schema->addItem( settings.value( "item", "" ).toString() );
    }
    settings.endArray();
    // Set Login history entry position
    comboBox_Schema->setCurrentIndex( 0 );
    settings.endGroup(); // comboBox_Schema


    // Load DBName history 
    settings.beginGroup( comboBox_DBName->objectName() );
    aSize = settings.beginReadArray( "history" );
    comboBox_DBName->clear();
    for ( int i = 0; i < aSize; ++i )
    {
        settings.setArrayIndex( i );
        comboBox_DBName->addItem( settings.value( "item", "" ).toString() );
    }
    settings.endArray();
    // Set DBName history entry position
    comboBox_DBName->setCurrentIndex( 0 );
    settings.endGroup(); // comboBox_DBName
    
    settings.endGroup(); // ConnectionDialog
}

void ConnectionDialog::saveConnectionSettings()
{
    QSettings settings;
    int aSize;
    QStringList historyList;

    // Look into ConnectionDialog section of configuration
    settings.beginGroup( objectName() ); // ConnectionDialog
    
    // Save GUI settings ----------------
    settings.setValue( "size", size() );
    settings.setValue( "pos", pos() );
    settings.setValue( "page", tabWidget_ConnectionBuilder->currentIndex() );
    // ----------------------------------
    
    
    // Save connection history-----------
    settings.remove( comboBox_ConnectionHistory->objectName() );
    settings.beginGroup( comboBox_ConnectionHistory->objectName() );
    aSize = comboBox_ConnectionHistory->count();
    // Read entries in history
    for ( int i = 0; i < aSize; ++i )
    {
        QString cStr( comboBox_ConnectionHistory->itemText( i ) );
        if ( !cStr.trimmed().isEmpty() && !historyList.contains( cStr ) )
        {
            historyList << cStr;
        }
    }
    // Read connectionHash entries
    foreach ( QString cStr, connectionHash.keys() )
    {
        if ( !cStr.trimmed().isEmpty() && !historyList.contains( cStr ) )
        {
            historyList << cStr;
        }
    }
    settings.beginWriteArray( "history" );
    aSize = historyList.count();
    for ( int i = 0; i < aSize; ++i )
    {
        settings.setArrayIndex( i );
        settings.setValue( "item", historyList.at( i ) );
    }
    settings.endArray(); // history
    // Set connection history entry position
    settings.setValue( "index", historyList.indexOf( dbConnectionQString ) );
    historyList.clear();
    settings.endGroup(); // comboBox_ConnectionHistory
    // ----------------------------------
    
    
    
    // Set DBType entry position --------
    settings.remove( comboBox_DBType->objectName() );
    settings.beginGroup( comboBox_DBType->objectName() );
    settings.setValue( "index", comboBox_DBType->currentIndex() );
    settings.endGroup(); // comboBox_DBType
    // ----------------------------------
    


    // Load Server history --------------
    settings.remove( comboBox_Server->objectName() );
    settings.beginGroup( comboBox_Server->objectName() );
    aSize = comboBox_Server->count();
    // Read entries in history
    if ( comboBox_Server->lineEdit() )
        historyList << comboBox_Server->lineEdit()->text();
    for ( int i = 0; i < aSize; ++i )
    {
        QString cStr( comboBox_Server->itemText( i ) );
        if ( !cStr.trimmed().isEmpty() && !historyList.contains( cStr ) )
        {
            historyList << cStr;
        }
    }
    settings.beginWriteArray( "history" );
    aSize = historyList.count();
    for ( int i = 0; i < aSize; ++i )
    {
        settings.setArrayIndex( i );
        settings.setValue( "item", historyList.at( i ) );
    }
    historyList.clear();
    settings.endArray(); // history
    // Set Server history entry position
    settings.setValue( "index", comboBox_Server->currentIndex() );
    settings.endGroup(); // comboBox_Server
    // ----------------------------------


    // Save Login history ---------------
    settings.remove( comboBox_Login->objectName() );
    settings.beginGroup( comboBox_Login->objectName() );
    aSize = comboBox_Login->count();
    // Read entries in history
    if ( comboBox_Login->lineEdit() )
        historyList << comboBox_Login->lineEdit()->text();
    for ( int i = 0; i < aSize; ++i )
    {
        QString cStr( comboBox_Login->itemText( i ) );
        if ( !cStr.trimmed().isEmpty() && !historyList.contains( cStr ) )
        {
            historyList << cStr;
        }
    }
    settings.beginWriteArray( "history" );
    aSize = historyList.count();
    for ( int i = 0; i < aSize; ++i )
    {
        settings.setArrayIndex( i );
        settings.setValue( "item", historyList.at( i ) );
    }
    historyList.clear();
    settings.endArray(); // history
    // Set Login history entry position
    settings.setValue( "index", comboBox_Login->currentIndex() );
    settings.endGroup(); // comboBox_Login
    // ----------------------------------


    // Load Schema history --------------
    settings.remove( comboBox_Schema->objectName() );
    settings.beginGroup( comboBox_Schema->objectName() );
    aSize = comboBox_Schema->count();
    // Read entries in history
    if ( comboBox_Schema->lineEdit() )
        historyList << comboBox_Schema->lineEdit()->text();
    for ( int i = 0; i < aSize; ++i )
    {
        QString cStr( comboBox_Schema->itemText( i ) );
        if ( !cStr.trimmed().isEmpty() && !historyList.contains( cStr ) )
        {
            historyList << cStr;
        }
    }
    settings.beginWriteArray( "history" );
    aSize = historyList.count();
    for ( int i = 0; i < aSize; ++i )
    {
        settings.setArrayIndex( i );
        settings.setValue( "item", historyList.at( i ) );
    }
    historyList.clear();
    settings.endArray(); // history
    // Set Schema history entry position
    settings.setValue( "index", comboBox_Schema->currentIndex() );
    settings.endGroup(); // comboBox_Schema
    // ----------------------------------


    // Load DBName history --------------
    settings.remove( comboBox_DBName->objectName() );
    settings.beginGroup( comboBox_DBName->objectName() );
    aSize = comboBox_DBName->count();
    // Read entries in history
    if ( comboBox_DBName->lineEdit() )
        historyList << comboBox_DBName->lineEdit()->text();
    for ( int i = 0; i < aSize; ++i )
    {
        QString cStr( comboBox_DBName->itemText( i ) );
        if ( !cStr.trimmed().isEmpty() && !historyList.contains( cStr ) )
        {
            historyList << cStr;
        }
    }
    settings.beginWriteArray( "history" );
    aSize = historyList.count();
    for ( int i = 0; i < aSize; ++i )
    {
        settings.setArrayIndex( i );
        settings.setValue( "item", historyList.at( i ) );
    }
    historyList.clear();
    settings.endArray(); // history
    // Set DBName history entry position
    settings.setValue( "index", comboBox_DBName->currentIndex() );
    settings.endGroup(); // comboBox_DBName
    // ----------------------------------
    
    settings.endGroup(); // ConnectionDialog
}

void ConnectionDialog::closeConnection( QString connectionString )
{
    connectionHash.remove( connectionString );
}

bool ConnectionDialog::isConnected( QString connectionString )
{
    if ( connectionString.isEmpty() )
    {
        return !connectionHash.isEmpty();
    }
    else
    {
        return connectionHash.contains( connectionString );
    }
}

