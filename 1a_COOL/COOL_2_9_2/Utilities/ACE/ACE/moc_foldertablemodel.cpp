/****************************************************************************
** Meta object code from reading C++ file 'foldertablemodel.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.6)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "foldertablemodel.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'foldertablemodel.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.6. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_FolderTableModel[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       1,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
      17,   60,   78,   78, 0x05,

       0        // eod
};

static const char qt_meta_stringdata_FolderTableModel[] = {
    "FolderTableModel\0"
    "modelChanged(const FolderTableModel*,bool)\0"
    "thisModel,changed\0\0"
};

void FolderTableModel::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        FolderTableModel *_t = static_cast<FolderTableModel *>(_o);
        switch (_id) {
        case 0: _t->modelChanged((*reinterpret_cast< const FolderTableModel*(*)>(_a[1])),(*reinterpret_cast< const bool(*)>(_a[2]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData FolderTableModel::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject FolderTableModel::staticMetaObject = {
    { &QAbstractTableModel::staticMetaObject, qt_meta_stringdata_FolderTableModel,
      qt_meta_data_FolderTableModel, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &FolderTableModel::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *FolderTableModel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *FolderTableModel::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_FolderTableModel))
        return static_cast<void*>(const_cast< FolderTableModel*>(this));
    return QAbstractTableModel::qt_metacast(_clname);
}

int FolderTableModel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractTableModel::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 1)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 1;
    }
    return _id;
}

// SIGNAL 0
void FolderTableModel::modelChanged(const FolderTableModel * _t1, const bool _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}
QT_END_MOC_NAMESPACE
