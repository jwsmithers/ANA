#include <QtCore/QString>
#include <QtCore/QtDebug>
#include <QtCore/QRegExp>
#include <QtCore/QSettings>
#include <QtGui/QMessageBox>
#include <QtGui/QListWidgetItem>

#include "ACE/foldertreemodel.h"
#include "ACE/FolderOpenDialog.h"

#include <iostream>
#include <iomanip>

FolderOpenDialog::FolderOpenDialog( QWidget* parent, Qt::WindowFlags f ) :
    QDialog( parent, f )
{
    setupUi( this );
    setConnections();
    ensureDefaultEncodingsExist();
    tagList = QStringList();
    dateTimeEdit_Since->setDateTime( QDateTime::currentDateTime() );
}

FolderOpenDialog::~FolderOpenDialog()
{}

void FolderOpenDialog::prepare( cool::IFolderPtr fPtr, QString fName )
{
    folderName = fName;
    folderPtr = fPtr;
    label_FolderName->setText( folderName );
    fill();
}

void FolderOpenDialog::setConnections()
{
    QObject::connect( pushButton_Open, SIGNAL( clicked() ), this, SLOT( slotOpen() ) );
    QObject::connect( pushButton_Open, SIGNAL( clicked() ), this, SLOT( slotUpdateVKESetting() ) );
    QObject::connect( pushButton_SaveVKE, SIGNAL( clicked() ), this, SLOT( slotUpdateVKESetting() ) );
    QObject::connect( pushButton_AddChannelRange, SIGNAL( clicked() ), this, SLOT( slotAddChannelRange() ) );
    QObject::connect( pushButton_RemoveChannelRange, SIGNAL( clicked() ), this, SLOT( slotRemoveChannelRange() ) );
    QObject::connect( comboBox_From, SIGNAL( activated( int ) ), comboBox_To, SLOT( setCurrentIndex( int ) ) );
    QObject::connect( comboBox_To, SIGNAL( activated( int ) ), this, SLOT( slotCheckRange( int ) ) );
    QObject::connect( comboBox_PredefinedVKE, SIGNAL( activated( int ) ), this, SLOT( slotDisplayVKEPage( int ) ) );
    QObject::connect( stackedWidget_VKE, SIGNAL( currentChanged( int ) ), comboBox_PredefinedVKE, SLOT( setCurrentIndex( int ) ) );
}

void FolderOpenDialog::protectWidgets( int index )
{
    bool allowChange( index > 2 ); // index < 3 are default encodings so cannot be changed.
    pushButton_RemoveVKE->setEnabled( allowChange );
    pushButton_SaveVKE->setEnabled( allowChange );
    lineEdit_HighBits->setReadOnly( !allowChange );
    lineEdit_LowBits->setReadOnly( !allowChange );
    spinBox_HighBits->setReadOnly( !allowChange );
    spinBox_LowBits->setReadOnly( !allowChange );
}

QString FolderOpenDialog::getVKEncoding()
{
    return comboBox_PredefinedVKE->currentText();
}

void FolderOpenDialog::ensureDefaultEncodingsExist()
{
    QSettings settings;
    settings.beginGroup( "Validity Key Encoding/run-lumi" );
    settings.setValue( "lineEdit_HighBits", "Run" );
    settings.setValue( "spinBox_HighBits", 31 );
    settings.setValue( "lineEdit_LowBits", "Lumi Block" );
    settings.setValue( "spinBox_LowBits", 32 );
    settings.endGroup();
    settings.beginGroup( "Validity Key Encoding/run-event" );
    settings.setValue( "lineEdit_HighBits", "Run" );
    settings.setValue( "spinBox_HighBits", 31 );
    settings.setValue( "lineEdit_LowBits", "Event" );
    settings.setValue( "spinBox_LowBits", 32 );
    settings.endGroup();
}

// Display the correct VKE page based on the selected comboBox_VKE entry selected.
void FolderOpenDialog::slotDisplayVKEPage( int index )
{
    QSettings settings;
    protectWidgets( index );
    if ( index == 0 )
    {
        // switch to time encoding page
        stackedWidget_VKE->setCurrentIndex( 0 );
        return;
    }
    // populate generic page with settings
    settings.beginGroup( "Validity Key Encoding/" + comboBox_PredefinedVKE->currentText() );
    lineEdit_HighBits->setText( settings.value( "lineEdit_HighBits", "Generic_HighBits" ).toString() );
    spinBox_HighBits->setValue( settings.value( "spinBox_HighBits", 31 ).toInt() );
    lineEdit_LowBits->setText( settings.value( "lineEdit_LowBits", "Generic_LowBits" ).toString() );
    spinBox_LowBits->setValue( settings.value( "spinBox_LowBits", 32 ).toInt() );
    settings.endGroup();
    // Switch to generic page
    stackedWidget_VKE->setCurrentIndex( 1 );
}

void FolderOpenDialog::slotCheckRange( int index )
{
    int fromIndex = comboBox_From->currentIndex();
    if ( index < fromIndex )
    {
        comboBox_To->setCurrentIndex( fromIndex );
        QMessageBox::warning(
            this, 
            trUtf8( "Range selection error" ),
            trUtf8( "The second value should be greater or equal to the first value." ),
            QMessageBox::Ok, 
            QMessageBox::Ok );
    }
}

void FolderOpenDialog::slotAddChannelRange()
{
    listWidget_CurrentChannelSelection->addItem( QString( "%1-%2" ).arg( comboBox_From->currentText() ).arg( comboBox_To->currentText() ) );
}

void FolderOpenDialog::slotRemoveChannelRange()
{
    QList< QListWidgetItem* > selectedItems = listWidget_CurrentChannelSelection->selectedItems();
    foreach ( QListWidgetItem* item, selectedItems )
    {
        listWidget_CurrentChannelSelection->takeItem( listWidget_CurrentChannelSelection->row( item ) );
    }
    qDeleteAll( selectedItems );
}

void FolderOpenDialog::slotUpdateVKESetting()
{
    QSettings settings;
    // Save VKE Settings
    if ( comboBox_PredefinedVKE->currentIndex() < 3 )
    {
        return;
    }
    QString vke_name( comboBox_PredefinedVKE->currentText() );
    settings.beginGroup( "Validity Key Encoding" );
    settings.beginGroup( vke_name.trimmed() );
    settings.setValue( "lineEdit_HighBits", lineEdit_HighBits->text().trimmed() );
    settings.setValue( "spinBox_HighBits", spinBox_HighBits->value() );
    settings.setValue( "lineEdit_LowBits", lineEdit_LowBits->text().trimmed() );
    settings.setValue( "spinBox_LowBits", spinBox_LowBits->value() );
    settings.endGroup(); // The specific encoding concerned.
    settings.endGroup(); // "Validity Key Encoding"
}

void FolderOpenDialog::fill()
{
    QSettings settings;
    // Fill tags
    comboBox_Tags->clear();
    tagList.clear();
    const std::vector< std::string > v = folderPtr->listTags();
    bool enableTags( v.size() > 0 );
    groupBox_TagSelection->setVisible( enableTags );
    if ( enableTags )
    {
        for ( unsigned i = 0; i < v.size(); ++i )
        {
            tagList.append( QString::fromStdString( v[ i ] ) );
        }
        comboBox_Tags->addItems( tagList );
    }
    else
    {
        groupBox_TagSelection->setChecked( false );
    }
    // Fill channels
    listWidget_CurrentChannelSelection->clear();
    comboBox_From->clear();
    comboBox_To->clear();
    channelPosMap.clear();
    const std::vector< cool::ChannelId > v1 = folderPtr->listChannels();
    for ( unsigned i = 0; i < v1.size(); ++i )
    {
        const unsigned int channelId = ( unsigned int ) v1[ i ];
        channelPosMap[ channelId ] = i;
        QString channelIdHex = QString( "%L1" ).arg( channelId, 0, 16 );
        comboBox_From->addItem( channelIdHex );
        comboBox_To->addItem( channelIdHex );
    }
    // ValidityKey encoding - Retrieve the timeStamp format used
    QString fDesc( QString::fromStdString( folderPtr->description() ) );
    // qDebug() << fDesc;
    QRegExp timeStampRegEx( QRegExp::escape( "<timeStamp>" ) + QString( "([\\w\\-]+)" ) + QRegExp::escape( "</timeStamp>" ) );
    QString defaultEncoding( "time" );
    QString encoding( "" );
    int selectionPos = 0;
    int pos = timeStampRegEx.indexIn( fDesc, 0 );
    if ( pos < 0 )
    {
        QMessageBox::warning(
            this, 
            trUtf8( "ValidityKey encoding missing or invalid!" ),
            trUtf8( "Select an appropriate encoding from the Validity key encoding section.\nDefault encoding is time." ),
            QMessageBox::Ok, 
            QMessageBox::Ok );
        encoding = defaultEncoding;
    } 
    else
    { // encoding retrieved successfully
        encoding = timeStampRegEx.cap( 1 );
//        qDebug() << "pos = " << pos << ", encoding = " << encoding;
    }
    settings.beginGroup( "Validity Key Encoding" );
    QStringList availableEncoding( settings.childGroups() );
    bool encodingRecognised( availableEncoding.contains( encoding ) or encoding == defaultEncoding );
    // Modify display of widgets relating to the ValidityKey encoding
    groupBox_VKE->setChecked( !encodingRecognised );
    if ( encodingRecognised )
    {
        // set comboBox_PredefinedVKE to show the currently detected encoding.
        selectionPos = comboBox_PredefinedVKE->findText( encoding );
        comboBox_PredefinedVKE->setCurrentIndex( selectionPos );
    }
    else
    { // encoding not recognised
        // Insert new encoding name as the last entry in the comboBox.
        selectionPos = comboBox_PredefinedVKE->count();
        comboBox_PredefinedVKE->insertItem( selectionPos, encoding );
        comboBox_PredefinedVKE->setCurrentIndex( selectionPos - 1 );
    }
    slotDisplayVKEPage( selectionPos );
    settings.endGroup(); // Validity Key Encoding
}

cool::ValidityKey FolderOpenDialog::getSinceIOV()
{
    if ( comboBox_PredefinedVKE->currentIndex() != 0 ) // not time encoding
        return cool::ValidityKeyMin;
    
    cool::ValidityKey s;
    if ( radioButton_IOVrecent->isChecked() )
        s = cool::ValidityKeyMax;
    else
        s = (qulonglong)( dateTimeEdit_Since->dateTime().toTime_t() ) * (qulonglong)( 1000000000 );
    return s;
}

cool::ChannelSelection FolderOpenDialog::getChannelSelection()
{
    if ( !groupBox_ChannelSelection->isChecked() || ( listWidget_CurrentChannelSelection->count() == 0 ) )
    {
        return cool::ChannelSelection();
    }
    bool ok( false );
    channelSubsetPosMap.clear();
    //Populate the QMap with channelId as key and row as value.
    // This QMap is used to create the second QMap with row as key and ChannelId as value. 
    // The latter is a subset of the former as only entries in selected ranges are inserted.
    for ( int is = 0; is < listWidget_CurrentChannelSelection->count(); is++ )
    {
        QStringList rangeFromTo = listWidget_CurrentChannelSelection->item( is )->text().split( "-" );

        unsigned int fromChannel = rangeFromTo.at( 0 ).toUInt( &ok, 16 );
        unsigned int toChannel = rangeFromTo.at( 1 ).toUInt( &ok, 16 );

        QMap<unsigned int, unsigned int>::const_iterator ic = channelPosMap.constFind( fromChannel );
        while ( ic != channelPosMap.constEnd() && ic.key() <= toChannel )
        {
            channelSubsetPosMap[ ic.value() ] = ic.key();
//            qDebug() << "Added channelSubsetPosMap["<< ic.value() << "] = " << i.key();
            ++ic;
        }
    }
    
    // Take the first entry and use it to instantiate a ChannelSelection.
    // This will facilitate the use of a while loop for the rest of the entries
    // allowing subsequent ranges to be added using addRange() without the problem of
    // overlapping ranges (not supported by COOL). 
    // The use of QMap interator ensures that the ranges are added in order (out of order
    // ranges are not supported by COOL). 
    QMap<unsigned int, unsigned int>::const_iterator j = channelSubsetPosMap.constBegin();
    cool::ChannelSelection channelSelection( (cool::ChannelId) j.value() );
    j++;
    if ( j == channelSubsetPosMap.constEnd() )
        return channelSelection;
    unsigned int startPos = j.key();
    unsigned int prevEndPos = startPos;
    unsigned int endPos = startPos;
    while ( j != channelSubsetPosMap.constEnd() )
    {
//        qDebug() << "Traversing channelSubsetPosMap[" << j.key() << "]=" << j.value();
        endPos = j.key();
        if ( endPos - prevEndPos > 1 ) // a gap in the range is detected
        {
            channelSelection.addRange( (cool::ChannelId) channelSubsetPosMap.value( startPos ), (cool::ChannelId) channelSubsetPosMap.value( prevEndPos ) );
//            qDebug() << "Added " << channelSubsetPosMap.value( startPos ) << " - " << channelSubsetPosMap.value( prevEndPos ) << ".";
            startPos = endPos;
        }
        prevEndPos = endPos;
        ++j;
    }
    channelSelection.addRange( (cool::ChannelId) channelSubsetPosMap.value( startPos ), (cool::ChannelId) channelSubsetPosMap.value( prevEndPos ) );
//    qDebug() << "Added " << channelSubsetPosMap.value( startPos ) << " - " << channelSubsetPosMap.value( prevEndPos ) << ".";
    return channelSelection;
}


QString FolderOpenDialog::getTag()
{
    if ( tagList.isEmpty() || !groupBox_TagSelection->isChecked() )
    {
        return QString( "" );
    }
    return comboBox_Tags->currentText();
}

QString FolderOpenDialog::getFolderCharacteristics()
{
    QString channels, iov;
    cool::ValidityKey IOVsince = getSinceIOV();

    if ( getVKEncoding() == "time" )
    {
        // IOV string
        if ( IOVsince == cool::ValidityKeyMin )
            iov = QString( "All IOVs" );
        else if ( IOVsince == cool::ValidityKeyMax )
            iov = QString( "Most recent IOVs" );
        else
            iov = QString( "IOVs since %1" ).arg( dateTimeEdit_Since->dateTime().toString( "ddd dd/MM/yyyy HH:mm:ss" ) );
    }
    else
    {
        iov = getVKEncoding(); // an encoding other than time.
    }
    // Channel selection string
    if ( getChannelSelection().allChannels() )
        channels = QString( "All" );
    else
        channels = QString( "Subset" );
    return QString( "Tag[%1] : Channels[%2] : %3" ).arg( getTag() ).arg( channels ).arg( iov );
}

void FolderOpenDialog::slotOpen()
{
    accept();
}
