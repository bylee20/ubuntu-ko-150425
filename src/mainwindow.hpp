#ifndef MAINWINDOW_HPP
#define MAINWINDOW_HPP

#include <QWidget>
#include <QTextEdit>

class MainWindow : public QWidget {
    Q_OBJECT
public:
    MainWindow();
    ~MainWindow();
    auto refresh() -> void;
    auto save() -> void;
    auto load(const QString &folder) -> void;
private:
    struct Data;
    Data *d;
};

#endif // MAINWINDOW_HPP
