#ifndef FILTERENTRY_H
#define FILTERENTRY_H

#include <QtCore/QPair>
#include <QtCore/QString>
#include <QtCore/QModelIndex>
#include <QtCore/QDateTime>

#include "ACE/ui_FilterEntry_BASE.h"

class FilterBuilder;
class FilterEntry;


// typedef of pointer to member function. 
typedef bool ( FilterEntry::*FilterFunction )( QModelIndex );


class FilterEntry : public QWidget, public Ui::FilterEntry_BASE
{
    Q_OBJECT

public:
    FilterEntry( const QString filterName, FilterBuilder* fBuilder, QWidget* parent = 0, Qt::WindowFlags f = 0 );
    ~FilterEntry();
    QPair< int, FilterFunction > getFilterFunction();
    bool filter_Date( QModelIndex tableModelIndex );
    bool filter_nonDate( QModelIndex tableModelIndex );

private:
    void setConnections();
    int columnIndex;
    int comparatorIndex;
    int predefinedFilterIndex;
    FilterBuilder* filterBuilder;

signals:
    void removeFilter( FilterEntry* );

private slots:
    void slotSelectColumn( int selection );
    void slotSelectComparator( int selection = -1 );
    void slotSelectDateFilter( int selection = -1 );
    void slotRemoveClicked();
    void slotSetDateTimeB( QDateTime dateTime );
    void slotCheckDateTimeB( QDateTime dateTime );
};

#endif
