#include "mainwindow.hpp"
#include "qmledit.hpp"
#include "ui_mainwindow.h"
#include <QDebug>
#include <QQuickWidget>
#include <QDir>
#include <QStringBuilder>
#include <QQmlEngine>
#include <QSyntaxHighlighter>
#include <QMessageBox>

struct MainWindow::Data {
    Ui::MainWindow ui;
    QQuickWidget *q = nullptr;
    QDir dir;
    QAction *save, *exit, *refresh;
    QString folder;
};

MainWindow::MainWindow()
    : d(new Data)
{
    d->ui.setupUi(this);
    d->q = new QQuickWidget(this);
    d->q->setResizeMode(QQuickWidget::SizeRootObjectToView);
    d->ui.splitter->insertWidget(0, d->q);


    connect(d->ui.refresh, &QPushButton::clicked, this, &MainWindow::refresh);
    connect(d->ui.save, &QPushButton::clicked, this, &MainWindow::save);
    connect(d->ui.exit, &QPushButton::clicked, qApp, &QApplication::quit);
    auto cc = static_cast<void(QComboBox::*)(const QString&)>(&QComboBox::currentTextChanged);
    connect(d->ui.folders, cc, this, &MainWindow::save);

    resize(1000, 600);

    d->q->setFixedWidth(200);

    d->exit = new QAction(this);
    d->exit->setShortcut(Qt::CTRL + Qt::Key_Q);
    connect(d->exit, &QAction::triggered, qApp, &QApplication::quit);
    addAction(d->exit);

    d->save = new QAction(this);
    d->save->setShortcut(Qt::CTRL + Qt::Key_S);
    connect(d->save, &QAction::triggered, this, &MainWindow::save);
    addAction(d->save);

    d->refresh = new QAction(this);
    d->refresh->setShortcut(Qt::Key_F5);
    connect(d->refresh, &QAction::triggered, this, &MainWindow::refresh);
    addAction(d->refresh);

    d->q->engine()->addImportPath(qApp->applicationDirPath());
    qDebug() << d->q->engine()->importPathList();
    d->dir = QDir(qApp->applicationDirPath() + "/examples");
    refresh();
}

MainWindow::~MainWindow()
{
    delete d;
}

auto MainWindow::save() -> void
{
    for (int i = 0; i < d->ui.tab->count(); ++i) {
        auto edit = static_cast<QmlEdit*>(d->ui.tab->widget(i));
        edit->save();
    }
    d->q->setSource(QUrl());
    d->q->engine()->clearComponentCache();

    const auto folder = d->ui.folders->currentText();
    if (folder == d->folder && d->ui.tab->count() > 0) {
        const auto main = static_cast<QmlEdit*>(d->ui.tab->widget(0))->file();
        d->q->setSource(QUrl::fromLocalFile(main));
        return;
    }

    d->folder = folder;
    d->ui.tab->clear();
    if (!d->dir.exists(folder))
        return;

    const QDir dir(d->dir.absoluteFilePath(folder));
    const auto files = dir.entryInfoList({"*.qml"});
    QFileInfo main;
    for (auto &file : files) {
        if (file.baseName() == "main") {
            main = file;
            continue;
        }
        d->ui.tab->addTab(new QmlEdit(file.absoluteFilePath()), file.fileName());
    }
    if (!main.filePath().isEmpty()) {
        d->ui.tab->insertTab(0, new QmlEdit(main.absoluteFilePath()), main.fileName());
        d->ui.tab->setCurrentIndex(0);
        d->q->setSource(QUrl::fromLocalFile(main.absoluteFilePath()));
    }
}

auto MainWindow::refresh() -> void
{
    const auto folder = d->ui.folders->currentText();

    d->ui.folders->clear();
    d->ui.tab->clear();

    auto dirs = d->dir.entryList(QDir::Dirs | QDir::NoDotAndDotDot, QDir::Name);
    d->ui.folders->addItems(dirs);
    save();

    if (!folder.isEmpty())
        d->ui.folders->setCurrentText(folder);
}
