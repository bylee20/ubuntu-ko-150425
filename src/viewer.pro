TEMPLATE = app

QT += qml quick widgets quickwidgets

SOURCES += main.cpp \
    mainwindow.cpp \
    qmledit.cpp

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

CONFIG += c++11

contains(CONFIG,static) {
LIBS *= -LC:/msys64/mingw64/qt5-static/share/qt5/qml/QtQuick.2
QTPLUGIN *= qtquick2plugin
}

TARGET = viewer
DESTDIR = ../

HEADERS += \
    main.hpp \
    mainwindow.hpp \
    qmledit.hpp

FORMS += \
    mainwindow.ui
