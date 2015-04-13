#ifndef FOLDEROPENDIALOG_H
#define FOLDEROPENDIALOG_H

#include <QtCore/QStringList>

#include "ACE/accesstocool.h"
#include "ACE/ui_FolderOpenDialog_BASE.h"


class FolderOpenDialog : public QDialog, private Ui::FolderOpenDialog_BASE
{
    Q_OBJECT

public:
    FolderOpenDialog( QWidget* parent = 0, Qt::WindowFlags f = 0 );
    ~FolderOpenDialog();
    void prepare( cool::IFolderPtr fPtr, QString fName );
    cool::ValidityKey getSinceIOV();
    cool::ChannelSelection getChannelSelection();
    QString getTag();
    QString getFolderCharacteristics();
    QString getVKEncoding();

private:
    void setConnections();
    void fill();
    void protectWidgets( int index );
    void ensureDefaultEncodingsExist();
    
    QMap< unsigned int, unsigned int > channelPosMap;
    QMap< unsigned int, unsigned int > channelSubsetPosMap;
    cool::IFolderPtr folderPtr;
    QString folderName;
    QStringList tagList;

public slots:
    void slotOpen();
    void slotAddChannelRange();
    void slotRemoveChannelRange();
    void slotCheckRange( int index );
    void slotDisplayVKEPage( int index );
    void slotUpdateVKESetting();

};

#endif
