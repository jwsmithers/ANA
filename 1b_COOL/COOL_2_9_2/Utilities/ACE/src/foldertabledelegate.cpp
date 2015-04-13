#include <QtCore/QtDebug>
#include <QtGui/QLineEdit>
#include <QtGui/QMessageBox>

#include "ACE/foldertabledelegate.h"
#include "ACE/foldertablemodel.h"
#include "ACE/ContentEditor.h"


FolderTableDelegate::FolderTableDelegate( QObject* parent) :
    QItemDelegate( parent )
{}

FolderTableDelegate::~FolderTableDelegate()
{
    commitAndCloseEditor();
}

QWidget* FolderTableDelegate::createEditor( QWidget* parent, const QStyleOptionViewItem& /* option */, const QModelIndex& index ) const
{
    const FolderTableModel* folderTableModel = qobject_cast< const FolderTableModel* >( index.model() );
    bool newRow( folderTableModel->isNewRow( index.row() ) );
    if ( newRow && folderTableModel->getColumnResponse( index.column() ) == confirmResponse )
    {
        int ret = QMessageBox::question(
            parent,
            trUtf8( "Confirmation request" ),
            trUtf8( "Are you sure you wish to edit the highlighted field?" ),
            QMessageBox::Cancel | QMessageBox::Ok );
        if ( ret == QMessageBox::Cancel )
            return 0;
    }
    QString coolType = folderTableModel->getCoolTypeString( index );
    if ( ( coolType == "Blob64k" ) || ( coolType == "Blob16M" ) )
    {
        ContentEditor* editor = new ContentEditor( parent, true, !newRow );
        return editor;
    }
    else if ( ( coolType == "String4k" ) || ( coolType == "String64k" ) || ( coolType == "String16M") )
    {
        ContentEditor* editor = new ContentEditor( parent, false, !newRow );
        return editor;
    }
    else if ( newRow )
    {
        QLineEdit* editor = new QLineEdit( parent );
        editor->setInputMask( folderTableModel->getInputMask( index ) );
        editor->setValidator( folderTableModel->getValidator( index ) );
        return editor;
    }
    return 0;
}

void FolderTableDelegate::setEditorData( QWidget* editor, const QModelIndex& index ) const
{
    const FolderTableModel* folderTableModel = qobject_cast< const FolderTableModel* >( index.model() );
    QString coolType = folderTableModel->getCoolTypeString( index );
    if ( ( coolType == "Blob64k" ) || ( coolType == "Blob16M" ) )
    {
        ContentEditor* contentEditor = qobject_cast< ContentEditor* >( editor );
        QObject::connect( contentEditor, SIGNAL( accepted() ), this, SLOT( commitAndCloseEditor() ) );
        contentEditor->setContent( folderTableModel->rawData( index ), HexCT, true );
    }
    else if ( ( coolType == "String4k" ) || ( coolType == "String64k" ) || ( coolType == "String16M") )
    {
        ContentEditor* contentEditor = qobject_cast< ContentEditor* >( editor );
        QObject::connect( contentEditor, SIGNAL( accepted() ), this, SLOT( commitAndCloseEditor() ) );
        contentEditor->setContent( folderTableModel->rawData( index ), StringCT, true );
    }
    else
    {
        QLineEdit* lineEdit = qobject_cast< QLineEdit* >( editor );
        lineEdit->setText( folderTableModel->data( index, Qt::DisplayRole ).toString() );
        lineEdit->selectAll();
    }
}

void FolderTableDelegate::setModelData( QWidget* editor, QAbstractItemModel* model, const QModelIndex& index ) const
{
    FolderTableModel* folderTableModel = qobject_cast< FolderTableModel* >( model );
    QString coolType = folderTableModel->getCoolTypeString( index );
    if ( ( coolType == "Blob64k" ) || ( coolType == "Blob16M" ) || ( coolType == "String4k" ) || ( coolType == "String64k" ) || ( coolType == "String16M" ) )
    {
        ContentEditor* contentEditor = qobject_cast< ContentEditor* >( editor );
        if ( contentEditor->isModified() )
        {
            folderTableModel->setData( index, contentEditor->contents(), Qt::EditRole );
        }
    }
    else
    {
        QLineEdit* lineEdit = qobject_cast< QLineEdit* >( editor );
        folderTableModel->setData( index, lineEdit->text(), Qt::EditRole );
    }
}

void FolderTableDelegate::updateEditorGeometry( QWidget* editor, const QStyleOptionViewItem& option, const QModelIndex& ) const
{
    editor->setGeometry( option.rect );
}

void FolderTableDelegate::commitAndCloseEditor()
{
    ContentEditor *editor = qobject_cast<ContentEditor *>( sender() );
    emit commitData( editor );
    emit closeEditor( editor );
}

