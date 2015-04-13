#include <QtCore/QtDebug>
#include <QtCore/QDataStream>
#include <QtCore/QTextStream>
#include <QtCore/QFile>
#include <QtCore/QByteArray>
#include <QtCore/QString>
#include <QtGui/QFileDialog>
#include <QtGui/QMessageBox>

#include "ACE/ContentEditor.h"


ContentEditor::ContentEditor( QWidget* parent, bool binaryContent, bool readOnly, Qt::WindowFlags f ) :
    QDialog( parent, f ),
    contentBinary( binaryContent ),
    contentReadOnly( readOnly ),
    defaultContentType( StringCT ),
    currentContentType( StringCT ),
    defaultContent( QString() ),
    currentContent( QString() ),
    modified( false )
{
    setupUi( this );
    setConnections();
    prepareEditor( contentBinary, contentReadOnly );
}

ContentEditor::~ContentEditor()
{
    done( 0 );
}

void ContentEditor::setConnections()
{
    QObject::connect( pushButton_Browse, SIGNAL( clicked() ), this, SLOT( slotBrowse() ) );
    QObject::connect( pushButton_Revert, SIGNAL( clicked() ), this, SLOT( slotRevert() ) );
    QObject::connect( pushButton_Export, SIGNAL( clicked() ), this, SLOT( slotExport() ) );
    QObject::connect( pushButton_Cancel, SIGNAL( clicked() ), this, SLOT( slotRevert() ) );
    QObject::connect( comboBox_ContentType, SIGNAL( activated( int ) ), this, SLOT( slotViewContentAs( int ) ) );
}

QVariant ContentEditor::contents() const
{
    if ( modified )
    {
        // ignore "view as" state since binary content cannot be modified in textEdit.
        if ( contentBinary || contentReadOnly )
        {
            return currentContent;
        }
        // contents of textEdit changed by user keyboard input so currentContent will be stale.
        // Will also have to take into account the type.
        switch ( currentContentType )
        {
            case StringCT:
                return QVariant( textEdit->toPlainText() );
                break;
            
            case HexCT:
                return QVariant( QString( QByteArray::fromHex( QByteArray().append( textEdit->toPlainText() ) ) ) );
                break;
        }
    }
    return currentContent;
}

bool ContentEditor::isBinary() const
{
    return contentBinary;
}

bool ContentEditor::isReadOnly() const
{
    return contentReadOnly;
}

bool ContentEditor::isModified() const
{
    return modified;
}

QTextEdit* ContentEditor::getEditor()
{
    return textEdit;
}

void ContentEditor::prepareEditor( bool enableBinary, bool enableReadOnly )
{
    contentBinary = enableBinary;
    contentReadOnly = enableReadOnly;
    if ( contentBinary )
    {
        defaultContentType = HexCT;
    }
    textEdit->setReadOnly( contentReadOnly || contentBinary );
    textEdit->setTabChangesFocus( contentReadOnly );
    textEdit->setUndoRedoEnabled( !contentReadOnly );
    pushButton_Browse->setEnabled( !contentReadOnly );
    pushButton_Export->setEnabled( contentReadOnly );
    if ( contentReadOnly )
    {
        textEdit->viewport()->setProperty( "cursor", QVariant( QCursor( Qt::ForbiddenCursor ) ) );
        setWindowTitle( trUtf8( "Content Viewer" ) );
        pushButton_OK->setFocus();
    }
    else
    {
        textEdit->viewport()->setProperty( "cursor", QVariant( QCursor( Qt::IBeamCursor ) ) );
        if ( !contentBinary )
        {
            QObject::connect( textEdit, SIGNAL( textChanged() ), this, SLOT( slotTextChanged() ) );
        }
        setWindowTitle( trUtf8( "Content Editor" ) );
        textEdit->setFocus();
    }
}

void ContentEditor::setContent( QVariant content, ContentType cType, bool defaultValue )
{
    bool tcConnectionDisabled( false );
    pushButton_Revert->setEnabled( true );
    if ( content.isNull() ) // reset to the default values
    {
        content = defaultContent;
        cType = defaultContentType;
        modified = false;
        pushButton_Revert->setEnabled( false );
        tcConnectionDisabled = QObject::disconnect( textEdit, SIGNAL( textChanged() ), this, SLOT( slotTextChanged() ) );
    }
    else if ( defaultValue ) // set as default value
    {
        defaultContent = content;
        defaultContentType = cType;
        modified = false;
        pushButton_Revert->setEnabled( false );
        tcConnectionDisabled = QObject::disconnect( textEdit, SIGNAL( textChanged() ), this, SLOT( slotTextChanged() ) );
    }
    comboBox_ContentType->setCurrentIndex( cType );
    currentContentType = cType;
    currentContent = content;
    switch ( cType )
    {
        case StringCT:
            if ( content.canConvert( QVariant::String ) )
            {
                setCursor( Qt::WaitCursor );
                setUpdatesEnabled( false );
                textEdit->setPlainText( content.toString() );
                setUpdatesEnabled( true );
                unsetCursor();
                modified = true;
            }
            else
            {
                QMessageBox::warning(
                    this, 
                    trUtf8( "Content Editor display error" ),
                    trUtf8( "Unable to display content as text." ),
                    QMessageBox::Ok,
                    QMessageBox::Ok );
            }
            break;
        
        case HexCT:
            if ( content.canConvert( QVariant::ByteArray ) )
            {
                QString hstr = QString( content.toByteArray().toHex() );
                modified = true;
                setCursor( Qt::WaitCursor );
                setUpdatesEnabled( false );
                textEdit->setPlainText( hstr );
                setUpdatesEnabled( true );
                unsetCursor();
            }
            else
            {
                QMessageBox::warning(
                    this, 
                    trUtf8( "Content Editor display error" ),
                    trUtf8( "Unable to display content in hexadecimal." ),
                    QMessageBox::Ok,
                    QMessageBox::Ok );
            }
            break;
    }
    if ( tcConnectionDisabled )
    {
        QObject::connect( textEdit, SIGNAL( textChanged() ), this, SLOT( slotTextChanged() ) );
    }
}

void ContentEditor::slotBrowse()
{
    browsedFileName = QFileDialog::getOpenFileName( this, trUtf8( "Select file" ) );
    if ( browsedFileName.isNull() )
        return;
    QFile binFile( browsedFileName );
    if ( !binFile.open( QIODevice::ReadOnly ) )
    {
        QMessageBox::critical(
            this, 
            trUtf8( "File IO error!" ),
            trUtf8( "There was a problem reading the requested file!" ),
            QMessageBox::Ok,
            QMessageBox::Ok );
        return;
    }
    QDataStream ds( &binFile );
    QByteArray binContent = QByteArray();
    binContent.resize( binFile.size() );
    ds.readRawData( binContent.data(), binFile.size() );
    
    if ( contentBinary ) // if current default is null, set new content as default.
        setContent( QVariant( binContent ), HexCT, defaultContent.isNull() );
    else
        setContent( QVariant( binContent ), StringCT, defaultContent.isNull() );
    ds.unsetDevice();
    binFile.close();
}

void ContentEditor::slotExport()
{
    QString fileName = QString();
    if ( contentBinary ) // blob
    {
        fileName = QFileDialog::getSaveFileName( this, trUtf8( "Export binary content to file" ) );
    }
    else // clob
    {
        fileName = QFileDialog::getSaveFileName( this, trUtf8( "Export string content to file" ) );
    }
    if ( fileName.isNull() )
        return;
    QFile exportFile( fileName );
    if ( !exportFile.open( QIODevice::WriteOnly ) )
    {
        QMessageBox::critical(
            this, 
            trUtf8( "File IO error!" ),
            trUtf8( "There was a problem writing to the selected file!" ),
            QMessageBox::Ok,
            QMessageBox::Ok );
        return;
    }
    QDataStream ds( &exportFile );
    QByteArray tempBA = contents().toByteArray();
    if ( ds.writeRawData( tempBA.constData(), tempBA.size() ) == -1 )
    {
        QMessageBox::critical(
            this, 
            trUtf8( "File IO error!" ),
            trUtf8( "There was a problem writing to the selected file!" ),
            QMessageBox::Ok,
            QMessageBox::Ok );
    }
    ds.unsetDevice();
    exportFile.close();
}

void ContentEditor::slotRevert()
{
    setContent();
}

void ContentEditor::slotViewContentAs( int cType )
{
    // disconnection and reconnection of textChanged() signal to prevent the modified flag from changing.
    bool disconnectSuccess( QObject::disconnect( textEdit, SIGNAL( textChanged() ), this, SLOT( slotTextChanged() ) ) );
    setContent( contents(), static_cast<ContentType>( cType ), false );
    if ( disconnectSuccess )
        QObject::connect( textEdit, SIGNAL( textChanged() ), this, SLOT( slotTextChanged() ) );
}

void ContentEditor::slotTextChanged()
{
    modified = !contentReadOnly;
    pushButton_Revert->setEnabled( modified );
}

