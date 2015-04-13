/****************************************************************************
** Meta object code from reading C++ file 'foldertableview.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.6)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "foldertableview.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'foldertableview.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.6. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_FolderTableView[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      14,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: signature, parameters, type, tag, flags
      16,   35,   41,   41, 0x05,
      42,   41,   41,   41, 0x25,
      57,  103,   41,   41, 0x05,

 // slots: signature, parameters, type, tag, flags
     105,   41,   41,   41, 0x08,
     118,   41,   41,   41, 0x08,
     131,   41,   41,   41, 0x08,
     144,   41,   41,   41, 0x08,
     160,   41,   41,   41, 0x08,
     179,   41,   41,   41, 0x08,
     198,   41,   41,   41, 0x08,
     217,   41,   41,   41, 0x08,
     240,   41,   41,   41, 0x08,
     264,   41,   41,   41, 0x08,
     279,  325,   41,   41, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_FolderTableView[] = {
    "FolderTableView\0checkButtons(bool)\0"
    "force\0\0checkButtons()\0"
    "updateFilterTarget(FolderTableModel*,QString)\0"
    ",\0slotNewRow()\0slotCommit()\0slotRemove()\0"
    "slotFillCells()\0slotDisplayAsHex()\0"
    "slotDisplayAsDec()\0slotDisplayAsOct()\0"
    "slotDisplayAs_Remove()\0slotDisplayAsDateTime()\0"
    "slotSetFocus()\0"
    "slotApplyFilter(FolderTableModel*,QList<int>)\0"
    "tableModel,hiddenRows\0"
};

void FolderTableView::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        FolderTableView *_t = static_cast<FolderTableView *>(_o);
        switch (_id) {
        case 0: _t->checkButtons((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 1: _t->checkButtons(); break;
        case 2: _t->updateFilterTarget((*reinterpret_cast< FolderTableModel*(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 3: _t->slotNewRow(); break;
        case 4: _t->slotCommit(); break;
        case 5: _t->slotRemove(); break;
        case 6: _t->slotFillCells(); break;
        case 7: _t->slotDisplayAsHex(); break;
        case 8: _t->slotDisplayAsDec(); break;
        case 9: _t->slotDisplayAsOct(); break;
        case 10: _t->slotDisplayAs_Remove(); break;
        case 11: _t->slotDisplayAsDateTime(); break;
        case 12: _t->slotSetFocus(); break;
        case 13: _t->slotApplyFilter((*reinterpret_cast< FolderTableModel*(*)>(_a[1])),(*reinterpret_cast< QList<int>(*)>(_a[2]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData FolderTableView::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject FolderTableView::staticMetaObject = {
    { &QTableView::staticMetaObject, qt_meta_stringdata_FolderTableView,
      qt_meta_data_FolderTableView, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &FolderTableView::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *FolderTableView::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *FolderTableView::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_FolderTableView))
        return static_cast<void*>(const_cast< FolderTableView*>(this));
    return QTableView::qt_metacast(_clname);
}

int FolderTableView::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QTableView::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 14)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 14;
    }
    return _id;
}

// SIGNAL 0
void FolderTableView::checkButtons(bool _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 2
void FolderTableView::updateFilterTarget(FolderTableModel * _t1, QString _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}
QT_END_MOC_NAMESPACE
