#ifndef QMLEDIT_HPP
#define QMLEDIT_HPP

#include <QTextEdit>

class QmlEdit : public QTextEdit {
    Q_OBJECT
public:
    QmlEdit(const QString &file, QWidget *parent = nullptr);
    ~QmlEdit();
    auto save() const -> void;
    auto load() -> void;
    auto file() const -> QString;
private:
    struct Data;
    Data *d;
};

#endif // QMLEDIT_HPP
