TEMPLATE = app

QT += qml quick widgets quickwidgets

SOURCES += main.cpp \
    mainwindow.cpp \
    qmledit.cpp

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

CONFIG += c++11 debug_and_release

TARGET = viewer
DESTDIR = ../

HEADERS += \
    main.hpp \
    mainwindow.hpp \
    qmledit.hpp

FORMS += \
    mainwindow.ui
