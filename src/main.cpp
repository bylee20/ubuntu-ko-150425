#include <QApplication>
#include "mainwindow.hpp"
#include "main.hpp"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    MainWindow mw;
    mw.show();
    return app.exec();
}
