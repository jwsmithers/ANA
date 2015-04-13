/****************************************************************************
** Meta object code from reading C++ file 'FilterEntry.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.6)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "FilterEntry.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'FilterEntry.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.6. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_FilterEntry[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       9,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
      12,   39,   39,   39, 0x05,

 // slots: signature, parameters, type, tag, flags
      40,   62,   39,   39, 0x08,
      72,   62,   39,   39, 0x08,
      98,   39,   39,   39, 0x28,
     121,   62,   39,   39, 0x08,
     147,   39,   39,   39, 0x28,
     170,   39,   39,   39, 0x08,
     190,  218,   39,   39, 0x08,
     227,  218,   39,   39, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_FilterEntry[] = {
    "FilterEntry\0removeFilter(FilterEntry*)\0"
    "\0slotSelectColumn(int)\0selection\0"
    "slotSelectComparator(int)\0"
    "slotSelectComparator()\0slotSelectDateFilter(int)\0"
    "slotSelectDateFilter()\0slotRemoveClicked()\0"
    "slotSetDateTimeB(QDateTime)\0dateTime\0"
    "slotCheckDateTimeB(QDateTime)\0"
};

void FilterEntry::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        FilterEntry *_t = static_cast<FilterEntry *>(_o);
        switch (_id) {
        case 0: _t->removeFilter((*reinterpret_cast< FilterEntry*(*)>(_a[1]))); break;
        case 1: _t->slotSelectColumn((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 2: _t->slotSelectComparator((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 3: _t->slotSelectComparator(); break;
        case 4: _t->slotSelectDateFilter((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 5: _t->slotSelectDateFilter(); break;
        case 6: _t->slotRemoveClicked(); break;
        case 7: _t->slotSetDateTimeB((*reinterpret_cast< QDateTime(*)>(_a[1]))); break;
        case 8: _t->slotCheckDateTimeB((*reinterpret_cast< QDateTime(*)>(_a[1]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData FilterEntry::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject FilterEntry::staticMetaObject = {
    { &QWidget::staticMetaObject, qt_meta_stringdata_FilterEntry,
      qt_meta_data_FilterEntry, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &FilterEntry::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *FilterEntry::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *FilterEntry::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_FilterEntry))
        return static_cast<void*>(const_cast< FilterEntry*>(this));
    if (!strcmp(_clname, "Ui::FilterEntry_BASE"))
        return static_cast< Ui::FilterEntry_BASE*>(const_cast< FilterEntry*>(this));
    return QWidget::qt_metacast(_clname);
}

int FilterEntry::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QWidget::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 9)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 9;
    }
    return _id;
}

// SIGNAL 0
void FilterEntry::removeFilter(FilterEntry * _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}
QT_END_MOC_NAMESPACE
