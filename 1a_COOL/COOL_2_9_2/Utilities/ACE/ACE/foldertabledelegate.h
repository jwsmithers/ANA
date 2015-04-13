#ifndef FOLDERTABLEDELEGATE_H
#define FOLDERTABLEDELEGATE_H

#include <QtGui/QItemDelegate>


class FolderTableDelegate: public QItemDelegate
{
    Q_OBJECT

public:
    FolderTableDelegate( QObject* parent = 0 );
    ~FolderTableDelegate();
    QWidget* createEditor( QWidget* parent, const QStyleOptionViewItem& option, const QModelIndex& index ) const;
    void setEditorData( QWidget* editor, const QModelIndex& index ) const;
    void setModelData( QWidget* editor, QAbstractItemModel* model, const QModelIndex& index ) const;
    void updateEditorGeometry( QWidget* editor, const QStyleOptionViewItem& option, const QModelIndex& index ) const;

private slots:
    void commitAndCloseEditor();
};

#endif
