/****************************************************************************
** Meta object code from reading C++ file 'database.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.10.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../database.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'database.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.10.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_database_t {
    QByteArrayData data[21];
    char stringdata0[180];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_database_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_database_t qt_meta_stringdata_database = {
    {
QT_MOC_LITERAL(0, 0, 8), // "database"
QT_MOC_LITERAL(1, 9, 14), // "inserIntoTable"
QT_MOC_LITERAL(2, 24, 0), // ""
QT_MOC_LITERAL(3, 25, 4), // "data"
QT_MOC_LITERAL(4, 30, 5), // "fname"
QT_MOC_LITERAL(5, 36, 5), // "sname"
QT_MOC_LITERAL(6, 42, 3), // "nik"
QT_MOC_LITERAL(7, 46, 12), // "removeRecord"
QT_MOC_LITERAL(8, 59, 2), // "id"
QT_MOC_LITERAL(9, 62, 9), // "requestDB"
QT_MOC_LITERAL(10, 72, 8), // "getTitle"
QT_MOC_LITERAL(11, 81, 14), // "QList<QString>"
QT_MOC_LITERAL(12, 96, 4), // "name"
QT_MOC_LITERAL(13, 101, 8), // "getValue"
QT_MOC_LITERAL(14, 110, 9), // "TableName"
QT_MOC_LITERAL(15, 120, 10), // "ColumnName"
QT_MOC_LITERAL(16, 131, 8), // "getColor"
QT_MOC_LITERAL(17, 140, 8), // "setColor"
QT_MOC_LITERAL(18, 149, 6), // "colors"
QT_MOC_LITERAL(19, 156, 11), // "getCountCol"
QT_MOC_LITERAL(20, 168, 11) // "getCountRow"

    },
    "database\0inserIntoTable\0\0data\0fname\0"
    "sname\0nik\0removeRecord\0id\0requestDB\0"
    "getTitle\0QList<QString>\0name\0getValue\0"
    "TableName\0ColumnName\0getColor\0setColor\0"
    "colors\0getCountCol\0getCountRow"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_database[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      10,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    1,   64,    2, 0x0a /* Public */,
       1,    3,   67,    2, 0x0a /* Public */,
       7,    1,   74,    2, 0x0a /* Public */,
       9,    0,   77,    2, 0x0a /* Public */,
      10,    1,   78,    2, 0x0a /* Public */,
      13,    3,   81,    2, 0x0a /* Public */,
      16,    1,   88,    2, 0x0a /* Public */,
      17,    2,   91,    2, 0x0a /* Public */,
      19,    1,   96,    2, 0x0a /* Public */,
      20,    1,   99,    2, 0x0a /* Public */,

 // slots: parameters
    QMetaType::Bool, QMetaType::QVariantList,    3,
    QMetaType::Bool, QMetaType::QString, QMetaType::QString, QMetaType::QString,    4,    5,    6,
    QMetaType::Bool, QMetaType::Int,    8,
    QMetaType::Void,
    0x80000000 | 11, QMetaType::QString,   12,
    QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::QString,   14,   15,    8,
    QMetaType::QString, QMetaType::QString,   12,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   12,   18,
    QMetaType::Int, QMetaType::QString,   12,
    QMetaType::Int, QMetaType::QString,   12,

       0        // eod
};

void database::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        database *_t = static_cast<database *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: { bool _r = _t->inserIntoTable((*reinterpret_cast< const QVariantList(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 1: { bool _r = _t->inserIntoTable((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const QString(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 2: { bool _r = _t->removeRecord((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 3: _t->requestDB(); break;
        case 4: { QList<QString> _r = _t->getTitle((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QList<QString>*>(_a[0]) = std::move(_r); }  break;
        case 5: { QString _r = _t->getValue((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 6: { QString _r = _t->getColor((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 7: _t->setColor((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 8: { int _r = _t->getCountCol((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 9: { int _r = _t->getCountRow((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject database::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_database.data,
      qt_meta_data_database,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *database::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *database::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_database.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int database::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 10)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 10;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 10)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 10;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
