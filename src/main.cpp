#include <QApplication>
#include "mainwindow.hpp"
#include "main.hpp"
#include <QtPlugin>
Q_IMPORT_PLUGIN(QtQuick2Plugin)

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    MainWindow mw;
    mw.show();
    return app.exec();
}
