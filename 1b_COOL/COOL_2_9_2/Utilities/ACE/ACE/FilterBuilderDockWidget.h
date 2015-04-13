#ifndef FILTERBUILDERDOCKWIDGET_H
#define FILTERBUILDERDOCKWIDGET_H

#include <QtGui/QDockWidget>
#include "ACE/FilterBuilder.h"

class QWidget;
class QCloseEvent;


class FilterBuilderDockWidget : public QDockWidget
{
    Q_OBJECT

public:
    FilterBuilderDockWidget( QWidget* parent = 0, Qt::WindowFlags flags = 0 );
    ~FilterBuilderDockWidget();
    FilterBuilder* filterBuilder;
/*
private:
//    void closeEvent( QCloseEvent* event );
    void focusInEvent( QFocusEvent* event );

signals:
    void changeFocusToFilterBuilder();
*/
};

#endif
