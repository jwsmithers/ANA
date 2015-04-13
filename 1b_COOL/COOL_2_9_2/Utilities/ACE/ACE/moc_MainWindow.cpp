/****************************************************************************
** Meta object code from reading C++ file 'MainWindow.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.6)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "MainWindow.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'MainWindow.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.6. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_MainWindow[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      11,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      11,   46,   57,   57, 0x0a,
      58,  107,   57,   57, 0x0a,
     130,   57,   57,   57, 0x0a,
     151,   57,   57,   57, 0x0a,
     178,   57,   57,   57, 0x0a,
     197,   57,   57,   57, 0x0a,
     219,  242,   57,   57, 0x0a,
     250,  298,   57,   57, 0x0a,
     320,  343,   57,   57, 0x0a,
     349,   57,   57,   57, 0x2a,
     368,  404,   57,   57, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_MainWindow[] = {
    "MainWindow\0slotCreateFolderTable(QModelIndex)\0"
    "fTreeIndex\0\0"
    "slotCreateFolderTree(cool::IDatabasePtr,QString)\0"
    "dbPtr,connectionString\0slotConnectionOpen()\0"
    "slotConnectionDisconnect()\0"
    "slotFolderCommit()\0slotFolderCommitAll()\0"
    "slotFolderFilter(bool)\0enabled\0"
    "slotTableModified(const FolderTableModel*,bool)\0"
    "modifiedModel,changed\0slotCheckButtons(bool)\0"
    "force\0slotCheckButtons()\0"
    "slotRemoveFolder(FolderTableModel*)\0"
    "theModel\0"
};

void MainWindow::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        MainWindow *_t = static_cast<MainWindow *>(_o);
        switch (_id) {
        case 0: _t->slotCreateFolderTable((*reinterpret_cast< const QModelIndex(*)>(_a[1]))); break;
        case 1: _t->slotCreateFolderTree((*reinterpret_cast< cool::IDatabasePtr(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 2: _t->slotConnectionOpen(); break;
        case 3: _t->slotConnectionDisconnect(); break;
        case 4: _t->slotFolderCommit(); break;
        case 5: _t->slotFolderCommitAll(); break;
        case 6: _t->slotFolderFilter((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 7: _t->slotTableModified((*reinterpret_cast< const FolderTableModel*(*)>(_a[1])),(*reinterpret_cast< const bool(*)>(_a[2]))); break;
        case 8: _t->slotCheckButtons((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 9: _t->slotCheckButtons(); break;
        case 10: _t->slotRemoveFolder((*reinterpret_cast< FolderTableModel*(*)>(_a[1]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData MainWindow::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject MainWindow::staticMetaObject = {
    { &QMainWindow::staticMetaObject, qt_meta_stringdata_MainWindow,
      qt_meta_data_MainWindow, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &MainWindow::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *MainWindow::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *MainWindow::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_MainWindow))
        return static_cast<void*>(const_cast< MainWindow*>(this));
    return QMainWindow::qt_metacast(_clname);
}

int MainWindow::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QMainWindow::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 11)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 11;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
