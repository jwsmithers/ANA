/****************************************************************************
** Meta object code from reading C++ file 'ContentEditor.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.6)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "ContentEditor.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'ContentEditor.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.6. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_ContentEditor[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       5,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      14,   27,   27,   27, 0x0a,
      28,   27,   27,   27, 0x0a,
      41,   27,   27,   27, 0x0a,
      54,   77,   27,   27, 0x0a,
      83,   27,   27,   27, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_ContentEditor[] = {
    "ContentEditor\0slotBrowse()\0\0slotExport()\0"
    "slotRevert()\0slotViewContentAs(int)\0"
    "cType\0slotTextChanged()\0"
};

void ContentEditor::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        ContentEditor *_t = static_cast<ContentEditor *>(_o);
        switch (_id) {
        case 0: _t->slotBrowse(); break;
        case 1: _t->slotExport(); break;
        case 2: _t->slotRevert(); break;
        case 3: _t->slotViewContentAs((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 4: _t->slotTextChanged(); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData ContentEditor::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject ContentEditor::staticMetaObject = {
    { &QDialog::staticMetaObject, qt_meta_stringdata_ContentEditor,
      qt_meta_data_ContentEditor, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &ContentEditor::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *ContentEditor::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *ContentEditor::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_ContentEditor))
        return static_cast<void*>(const_cast< ContentEditor*>(this));
    return QDialog::qt_metacast(_clname);
}

int ContentEditor::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QDialog::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 5)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
