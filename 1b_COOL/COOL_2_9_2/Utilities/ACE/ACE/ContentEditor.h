#ifndef CONTENTEDITOR_H
#define CONTENTEDITOR_H

#include <QtCore/QVariant>
#include <QtCore/QString>

#include "ACE/ui_ContentEditor_BASE.h"

enum ContentType { StringCT, HexCT };

class ContentEditor : public QDialog, private Ui::ContentEditor_BASE
{
    Q_OBJECT

public:
    ContentEditor( QWidget* parent = 0, bool binaryContent = false, bool readOnly = true, Qt::WindowFlags f = 0 );
    ~ContentEditor();
    QVariant contents() const;
    bool isBinary() const;
    bool isReadOnly() const;
    bool isModified() const;
    QTextEdit* getEditor();
    void prepareEditor( bool enableBinary = false, bool enableReadOnly = true );
    void setContent( QVariant content = QVariant(), ContentType cType = StringCT, bool defaultValue = false );

private:
    void setConnections();
    
    bool contentBinary;
    bool contentReadOnly;
    ContentType defaultContentType;
    ContentType currentContentType;
    QVariant defaultContent;
    QVariant currentContent;
    bool modified;
    QString browsedFileName;
    

public slots:
    void slotBrowse();
    void slotExport();
    void slotRevert();
    void slotViewContentAs( int cType );
    void slotTextChanged();

};

#endif
