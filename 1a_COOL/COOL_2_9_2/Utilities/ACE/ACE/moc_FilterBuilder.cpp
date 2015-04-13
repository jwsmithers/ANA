/****************************************************************************
** Meta object code from reading C++ file 'FilterBuilder.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.6)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "FilterBuilder.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'FilterBuilder.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.6. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_FilterBuilder[] = {

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
      14,   57,   59,   59, 0x05,

 // slots: signature, parameters, type, tag, flags
      60,   59,   59,   59, 0x0a,
      81,  117,   59,   59, 0x0a,
     129,  173,   59,   59, 0x0a,
     195,  231,   59,   59, 0x2a,
     242,   59,   59,   59, 0x0a,
     264,   59,   59,   59, 0x0a,
     278,   59,   59,   59, 0x0a,
     304,  350,   59,   59, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_FilterBuilder[] = {
    "FilterBuilder\0applyClicked(FolderTableModel*,QList<int>)\0"
    ",\0\0slotAddFilterEntry()\0"
    "slotRemoveFilterEntry(FilterEntry*)\0"
    "filterEntry\0slotUpdateFilter(FolderTableModel*,QString)\0"
    "tableModel,folderName\0"
    "slotUpdateFilter(FolderTableModel*)\0"
    "tableModel\0slotUpdateTableView()\0"
    "slotShowAll()\0slotSaveColumnPositions()\0"
    "slotClearCurrentTableModel(FolderTableModel*)\0"
    "theModel\0"
};

void FilterBuilder::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        FilterBuilder *_t = static_cast<FilterBuilder *>(_o);
        switch (_id) {
        case 0: _t->applyClicked((*reinterpret_cast< FolderTableModel*(*)>(_a[1])),(*reinterpret_cast< QList<int>(*)>(_a[2]))); break;
        case 1: _t->slotAddFilterEntry(); break;
        case 2: _t->slotRemoveFilterEntry((*reinterpret_cast< FilterEntry*(*)>(_a[1]))); break;
        case 3: _t->slotUpdateFilter((*reinterpret_cast< FolderTableModel*(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 4: _t->slotUpdateFilter((*reinterpret_cast< FolderTableModel*(*)>(_a[1]))); break;
        case 5: _t->slotUpdateTableView(); break;
        case 6: _t->slotShowAll(); break;
        case 7: _t->slotSaveColumnPositions(); break;
        case 8: _t->slotClearCurrentTableModel((*reinterpret_cast< FolderTableModel*(*)>(_a[1]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData FilterBuilder::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject FilterBuilder::staticMetaObject = {
    { &QWidget::staticMetaObject, qt_meta_stringdata_FilterBuilder,
      qt_meta_data_FilterBuilder, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &FilterBuilder::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *FilterBuilder::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *FilterBuilder::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_FilterBuilder))
        return static_cast<void*>(const_cast< FilterBuilder*>(this));
    return QWidget::qt_metacast(_clname);
}

int FilterBuilder::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
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
void FilterBuilder::applyClicked(FolderTableModel * _t1, QList<int> _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}
QT_END_MOC_NAMESPACE
