/****************************************************************************
** Meta object code from reading C++ file 'MainWindow.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.15.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../../MainWindow.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'MainWindow.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.15.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef QT_METACALL_WRAP_START
#define QT_METACALL_WRAP_START
#endif
#ifndef QT_METACALL_WRAP_END
#define QT_METACALL_WRAP_END
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_MainWindow_t {
    QByteArrayData data[15];
    char stringdata0[119];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_MainWindow_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_MainWindow_t qt_meta_stringdata_MainWindow = {
    {
QT_MOC_LITERAL(0, 0, 10), // "MainWindow"
QT_MOC_LITERAL(1, 11, 11), // "textChanged"
QT_MOC_LITERAL(2, 23, 0), // ""
QT_MOC_LITERAL(3, 24, 11), // "getMetadata"
QT_MOC_LITERAL(4, 36, 11), // "setMetadata"
QT_MOC_LITERAL(5, 48, 8), // "filePath"
QT_MOC_LITERAL(6, 57, 8), // "filename"
QT_MOC_LITERAL(7, 66, 6), // "length"
QT_MOC_LITERAL(8, 73, 6), // "artist"
QT_MOC_LITERAL(9, 80, 5), // "title"
QT_MOC_LITERAL(10, 86, 5), // "album"
QT_MOC_LITERAL(11, 92, 7), // "comment"
QT_MOC_LITERAL(12, 100, 5), // "genre"
QT_MOC_LITERAL(13, 106, 4), // "year"
QT_MOC_LITERAL(14, 111, 7) // "artwork"

    },
    "MainWindow\0textChanged\0\0getMetadata\0"
    "setMetadata\0filePath\0filename\0length\0"
    "artist\0title\0album\0comment\0genre\0year\0"
    "artwork"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_MainWindow[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
      10,   32, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   29,    2, 0x06 /* Public */,

 // methods: name, argc, parameters, tag, flags
       3,    0,   30,    2, 0x02 /* Public */,
       4,    0,   31,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void,
    QMetaType::Void,

 // properties: name, type, flags
       5, QMetaType::QString, 0x00495003,
       6, QMetaType::QString, 0x00495003,
       7, QMetaType::QString, 0x00495003,
       8, QMetaType::QString, 0x00495003,
       9, QMetaType::QString, 0x00495003,
      10, QMetaType::QString, 0x00495003,
      11, QMetaType::QString, 0x00495003,
      12, QMetaType::QString, 0x00495003,
      13, QMetaType::QString, 0x00495003,
      14, QMetaType::QString, 0x00495003,

 // properties: notify_signal_id
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,
       0,

       0        // eod
};

void MainWindow::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    QT_METACALL_WRAP_START
    qt_static_metacall_inner(_o, _c, _id, _a);
    QT_METACALL_WRAP_END
}

void MainWindow::qt_static_metacall_inner(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<MainWindow *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->textChanged(); break;
        case 1: _t->getMetadata(); break;
        case 2: _t->setMetadata(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (MainWindow::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&MainWindow::textChanged)) {
                *result = 0;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<MainWindow *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->filePath; break;
        case 1: *reinterpret_cast< QString*>(_v) = _t->filename; break;
        case 2: *reinterpret_cast< QString*>(_v) = _t->length; break;
        case 3: *reinterpret_cast< QString*>(_v) = _t->artist; break;
        case 4: *reinterpret_cast< QString*>(_v) = _t->title; break;
        case 5: *reinterpret_cast< QString*>(_v) = _t->album; break;
        case 6: *reinterpret_cast< QString*>(_v) = _t->comment; break;
        case 7: *reinterpret_cast< QString*>(_v) = _t->genre; break;
        case 8: *reinterpret_cast< QString*>(_v) = _t->year; break;
        case 9: *reinterpret_cast< QString*>(_v) = _t->artwork; break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        auto *_t = static_cast<MainWindow *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0:
            if (_t->filePath != *reinterpret_cast< QString*>(_v)) {
                _t->filePath = *reinterpret_cast< QString*>(_v);
                Q_EMIT _t->textChanged();
            }
            break;
        case 1:
            if (_t->filename != *reinterpret_cast< QString*>(_v)) {
                _t->filename = *reinterpret_cast< QString*>(_v);
                Q_EMIT _t->textChanged();
            }
            break;
        case 2:
            if (_t->length != *reinterpret_cast< QString*>(_v)) {
                _t->length = *reinterpret_cast< QString*>(_v);
                Q_EMIT _t->textChanged();
            }
            break;
        case 3:
            if (_t->artist != *reinterpret_cast< QString*>(_v)) {
                _t->artist = *reinterpret_cast< QString*>(_v);
                Q_EMIT _t->textChanged();
            }
            break;
        case 4:
            if (_t->title != *reinterpret_cast< QString*>(_v)) {
                _t->title = *reinterpret_cast< QString*>(_v);
                Q_EMIT _t->textChanged();
            }
            break;
        case 5:
            if (_t->album != *reinterpret_cast< QString*>(_v)) {
                _t->album = *reinterpret_cast< QString*>(_v);
                Q_EMIT _t->textChanged();
            }
            break;
        case 6:
            if (_t->comment != *reinterpret_cast< QString*>(_v)) {
                _t->comment = *reinterpret_cast< QString*>(_v);
                Q_EMIT _t->textChanged();
            }
            break;
        case 7:
            if (_t->genre != *reinterpret_cast< QString*>(_v)) {
                _t->genre = *reinterpret_cast< QString*>(_v);
                Q_EMIT _t->textChanged();
            }
            break;
        case 8:
            if (_t->year != *reinterpret_cast< QString*>(_v)) {
                _t->year = *reinterpret_cast< QString*>(_v);
                Q_EMIT _t->textChanged();
            }
            break;
        case 9:
            if (_t->artwork != *reinterpret_cast< QString*>(_v)) {
                _t->artwork = *reinterpret_cast< QString*>(_v);
                Q_EMIT _t->textChanged();
            }
            break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
    Q_UNUSED(_a);
}

QT_INIT_METAOBJECT const QMetaObject MainWindow::staticMetaObject = { {
    QMetaObject::SuperData::link<QWidget::staticMetaObject>(),
    qt_meta_stringdata_MainWindow.data,
    qt_meta_data_MainWindow,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *MainWindow::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *MainWindow::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_MainWindow.stringdata0))
        return static_cast<void*>(this);
    return QWidget::qt_metacast(_clname);
}

int MainWindow::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QWidget::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 3)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 3)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 3;
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 10;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 10;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 10;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 10;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 10;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 10;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void MainWindow::textChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
