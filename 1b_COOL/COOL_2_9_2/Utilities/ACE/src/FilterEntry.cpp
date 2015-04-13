#include <QtCore/QtDebug>
#include <QtCore/QObject>
#include <QtGui/QMessageBox>

#include "ACE/FilterEntry.h"
#include "ACE/FilterBuilder.h"
#include "ACE/foldertablemodel.h"


FilterEntry::FilterEntry( const QString filterName, FilterBuilder* fBuilder, QWidget* parent, Qt::WindowFlags f ) :
    QWidget( parent, f ),
    filterBuilder( fBuilder )
{
    setupUi( this );
    groupBox_FilterEntry->setTitle( filterName );
    slotSelectColumn( -1 ); // Initiate a reset for all the comboboxes
    resize( 680, 45 );
    setConnections();
}

FilterEntry::~FilterEntry()
{}

QPair< int, FilterFunction > FilterEntry::getFilterFunction()
{
    int columnIndex = comboBox_Column->currentIndex();
    switch ( comboBox_Comparators->currentIndex() )
    {
        case 9:  // "date is"
            return qMakePair( columnIndex, &FilterEntry::filter_Date );
            break;
        default:
            // Make a QPair of the column index and the filter function
            return qMakePair( columnIndex, &FilterEntry::filter_nonDate );
            break;
    }
}

bool FilterEntry::filter_Date( QModelIndex tableModelIndex )
{
    QDateTime currentDateTime = filterBuilder->currentTableModel->data( tableModelIndex ).toDateTime();
    if ( !currentDateTime.isValid() )
    {
        currentDateTime = QDateTime::fromTime_t( 0 );
    }
    switch ( comboBox_PredefinedFilters->currentIndex() )
    {
        case 0: // most recent
            return filterBuilder->currentTableModel->data( tableModelIndex ) == QVariant( "ValidityKeyMax" );
        case 1: // before
            return currentDateTime < dateTimeEdit_A->dateTime();
        case 2: // after
            return currentDateTime > dateTimeEdit_A->dateTime();
        case 3: // between
            return ( currentDateTime > dateTimeEdit_A->dateTime() ) && ( currentDateTime < dateTimeEdit_B->dateTime() );
        default:
            return false;
    }
}

bool FilterEntry::filter_nonDate( QModelIndex tableModelIndex )
{
    if ( !( filterBuilder->currentTableModel ) )
    {
        return false;
    }
    DisplayAsMask entryMask = filterBuilder->currentTableModel->getDisplayAsMask( tableModelIndex.column() );
    bool useRaw( entryMask == clobMask );
    switch ( comboBox_Comparators->currentIndex() )
    {
        case 0: // "=="
            return filterBuilder->currentTableModel->compare( tableModelIndex, lineEdit_EntryA->text() ) == 0;
            break;
        case 1: // "!="
            return filterBuilder->currentTableModel->compare( tableModelIndex, lineEdit_EntryA->text() ) != 0;
            break;
        case 2: // ">"
            return filterBuilder->currentTableModel->compare( tableModelIndex, lineEdit_EntryA->text() ) > 0;
            break;
        case 3: // "<"
            return filterBuilder->currentTableModel->compare( tableModelIndex, lineEdit_EntryA->text() ) < 0;
            break;
        case 4: // "in between"
            return ( filterBuilder->currentTableModel->compare( tableModelIndex, lineEdit_EntryA->text() ) > 0 ) && ( filterBuilder->currentTableModel->compare( tableModelIndex, lineEdit_EntryB->text() ) < 0 );
            break;
        case 5: // "contains"
            if ( useRaw )
                return filterBuilder->currentTableModel->rawData( tableModelIndex ).toString().contains( lineEdit_EntryA->text(), Qt::CaseInsensitive );
            else
                return filterBuilder->currentTableModel->data( tableModelIndex ).toString().contains( lineEdit_EntryA->text(), Qt::CaseInsensitive );
            break;
        case 6: // "!contains"
            if ( useRaw )
                return !( filterBuilder->currentTableModel->rawData( tableModelIndex ).toString().contains( lineEdit_EntryA->text(), Qt::CaseInsensitive ) );
            else
                return !( filterBuilder->currentTableModel->data( tableModelIndex ).toString().contains( lineEdit_EntryA->text(), Qt::CaseInsensitive ) );
            break;
        case 7: // "starts with"
            if ( useRaw )
                return filterBuilder->currentTableModel->rawData( tableModelIndex ).toString().startsWith( lineEdit_EntryA->text(), Qt::CaseInsensitive );
            else
                return filterBuilder->currentTableModel->data( tableModelIndex ).toString().startsWith( lineEdit_EntryA->text(), Qt::CaseInsensitive );
            break;
        case 8: // "ends with"
            if ( useRaw )
                return filterBuilder->currentTableModel->rawData( tableModelIndex ).toString().endsWith( lineEdit_EntryA->text(), Qt::CaseInsensitive );
            else
                return filterBuilder->currentTableModel->data( tableModelIndex ).toString().endsWith( lineEdit_EntryA->text(), Qt::CaseInsensitive );
            break;

        default: // error. returns false
            break;
    }
    return false;
}

void FilterEntry::setConnections()
{
    QObject::connect( comboBox_Column, SIGNAL( activated( int ) ), this, SLOT( slotSelectColumn( int ) ) );
    QObject::connect( comboBox_Comparators, SIGNAL( activated( int ) ), this, SLOT( slotSelectComparator( int ) ) );
    QObject::connect( comboBox_PredefinedFilters, SIGNAL( activated( int ) ), this, SLOT( slotSelectDateFilter( int ) ) );
    QObject::connect( pushButton_RemoveFilter, SIGNAL( clicked() ), this, SLOT( slotRemoveClicked() ) );
    QObject::connect( dateTimeEdit_A, SIGNAL( dateTimeChanged( QDateTime ) ), this, SLOT( slotSetDateTimeB( QDateTime ) ) );
    QObject::connect( dateTimeEdit_B, SIGNAL( dateTimeChanged( QDateTime ) ), this, SLOT( slotCheckDateTimeB( QDateTime ) ) );
}

void FilterEntry::slotRemoveClicked()
{
    emit removeFilter( this );
}

void FilterEntry::slotSetDateTimeB( QDateTime dateTime )
{
    dateTimeEdit_B->setMinimumDate( dateTime.date() );
    if ( dateTimeEdit_B->dateTime() < dateTime )
    {
        dateTimeEdit_B->setDateTime( dateTimeEdit_A->dateTime() );
    }
}

void FilterEntry::slotCheckDateTimeB( QDateTime dateTime )
{
    if ( dateTime < dateTimeEdit_A->dateTime() )
    {
        dateTimeEdit_B->setDateTime( dateTimeEdit_A->dateTime() );
    }
}

void FilterEntry::slotSelectColumn( int selection )
{
    switch ( selection )
    {
        case 1: // "Since"
        case 2: // "Until"
            comboBox_Comparators->setCurrentIndex( 9 );
            slotSelectComparator( 9 );
            break;
        case -1: // reset
            comboBox_Column->setCurrentIndex( 0 );
            slotSelectComparator( -1 );
            break;
        default:
            if ( filterBuilder->currentTableModel->getDisplayAsMask( selection ) == blobMask )
            {
                QMessageBox::warning(
                    filterBuilder, 
                    trUtf8( "Filter Builder warning" ),
                    trUtf8( "Not able to apply filters to blobs. Please select another field." ),
                    QMessageBox::Ok,
                    QMessageBox::Ok );
                comboBox_Column->setCurrentIndex( 0 );
            }
            else
                slotSelectComparator( -1 ); // reset comparator combobox to its default view             
            break;
    }
}

void FilterEntry::slotSelectComparator( int selection )
{
    switch ( selection )
    {
        case 4: // "is between" comparator
            entryContainer_Date->hide();
            entryContainer_nonDate_ampersand->show();
            lineEdit_EntryA->show();
            lineEdit_EntryB->show();
            entryContainer_nonDate->show();
            break;
        case 9: // "date is" comparator
            entryContainer_nonDate->hide();
            entryContainer_Date->show();
            slotSelectDateFilter( -1 );
            break;
        case -1: // reset
            comboBox_Comparators->setCurrentIndex( 0 );
            // No break. Continue to execute the default case.
        default: // the rest of the comparators
            entryContainer_Date->hide();
            lineEdit_EntryA->show();
            entryContainer_nonDate_ampersand->hide();
            lineEdit_EntryB->hide();
            entryContainer_nonDate->show();
            break;
    }
}

void FilterEntry::slotSelectDateFilter( int selection )
{
    switch ( selection )
    {
        case 3: // "between"
            dateTimeEdit_A->setDateTime( QDateTime::currentDateTime() );
            dateTimeEdit_B->setDateTime( QDateTime::currentDateTime() );
            dateTimeEdit_A->show();
            dateTimeEdit_B->show();
            entryContainer_Date_ampersand->show();
            break;
        case 0: // "most recent"
        case -1: //  reset.
            dateTimeEdit_A->hide();
            dateTimeEdit_B->hide();
            entryContainer_Date_ampersand->hide();
            comboBox_PredefinedFilters->setCurrentIndex( 0 );
            break;
        default: // the rest of the predefined filters
            dateTimeEdit_B->hide();
            entryContainer_Date_ampersand->hide();
            dateTimeEdit_A->setDateTime( QDateTime::currentDateTime() );
            dateTimeEdit_A->show();
            break;
    }
}

