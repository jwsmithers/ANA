/****************************************************************************
** Meta object code from reading C++ file 'FolderOpenDialog.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.6)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "FolderOpenDialog.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'FolderOpenDialog.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.6. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_FolderOpenDialog[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      17,   28,   28,   28, 0x0a,
      29,   28,   28,   28, 0x0a,
      51,   28,   28,   28, 0x0a,
      76,   96,   28,   28, 0x0a,
     102,   96,   28,   28, 0x0a,
     126,   28,   28,   28, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_FolderOpenDialog[] = {
    "FolderOpenDialog\0slotOpen()\0\0"
    "slotAddChannelRange()\0slotRemoveChannelRange()\0"
    "slotCheckRange(int)\0index\0"
    "slotDisplayVKEPage(int)\0slotUpdateVKESetting()\0"
};

void FolderOpenDialog::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        FolderOpenDialog *_t = static_cast<FolderOpenDialog *>(_o);
        switch (_id) {
        case 0: _t->slotOpen(); break;
        case 1: _t->slotAddChannelRange(); break;
        case 2: _t->slotRemoveChannelRange(); break;
        case 3: _t->slotCheckRange((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 4: _t->slotDisplayVKEPage((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 5: _t->slotUpdateVKESetting(); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData FolderOpenDialog::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject FolderOpenDialog::staticMetaObject = {
    { &QDialog::staticMetaObject, qt_meta_stringdata_FolderOpenDialog,
      qt_meta_data_FolderOpenDialog, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &FolderOpenDialog::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *FolderOpenDialog::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *FolderOpenDialog::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_FolderOpenDialog))
        return static_cast<void*>(const_cast< FolderOpenDialog*>(this));
    return QDialog::qt_metacast(_clname);
}

int FolderOpenDialog::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QDialog::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
