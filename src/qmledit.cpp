#include "qmledit.hpp"
#include <QFile>
#include <QSyntaxHighlighter>
#include <QDebug>

// syntax highlighter from https://github.com/danvratil/qtquick-slides
// Copyright (C) 2013 Daniel Vrátil <dan@progdan.cz>

class QMLSyntaxHighlighter : public QSyntaxHighlighter
{
  public:
    explicit QMLSyntaxHighlighter(const QFont &font, QTextDocument *textDocument);
    virtual ~QMLSyntaxHighlighter();

  protected:
    virtual void highlightBlock(const QString &text);

  private:
    struct HighlightingRule
    {
        QRegExp pattern;
        QTextCharFormat format;
        bool comment = false;
    };
    QVector<HighlightingRule> highlightingRules;

    QRegExp commentStartExpression;
    QRegExp commentEndExpression;

    QTextCharFormat keywordFormat;
    QTextCharFormat classFormat;
    QTextCharFormat singleLineCommentFormat;
    QTextCharFormat multiLineCommentFormat;
    QTextCharFormat quotationFormat;
    QTextCharFormat functionFormat;
    QTextCharFormat propertyFormat;
    QTextCharFormat referenceFormat;
};

QMLSyntaxHighlighter::QMLSyntaxHighlighter(const QFont &font, QTextDocument *textDocument):
    QSyntaxHighlighter(textDocument)
{
    keywordFormat.setFont(font);
    classFormat.setFont(font);
    singleLineCommentFormat.setFont(font);
    multiLineCommentFormat.setFont(font);
    quotationFormat.setFont(font);
    propertyFormat.setFont(font);
    referenceFormat.setFont(font);

    HighlightingRule rule;

    keywordFormat.setForeground(Qt::darkYellow);
    //keywordFormat.setFontWeight(QFont::Bold);
    QStringList keywordPatterns;
    keywordPatterns << "\\baction\\b" << "\\bbool\\b" << "\\bcolor\\b"
                    << "\\bdate\\b" << "\\bdouble\\b" << "\\benumeration\\b"
                    << "\\bfont\\b" << "\\bint\\b" << "\\blist\\b"
                    << "\\bpoint\\b" << "\\breal\\b" << "\\brect\\b"
                    << "\\bsize\\b" << "\\bstring\\b" << "\\btime\\b"
                    << "\\burl\\b" << "\\bvariant\\b" << "\\bvector3d\\b"
                    << "\\bimport\\b" << "\\bfunction\\b" << "\\bvar\\b"
                    << "\\bbehavior\\b" << "\\bproperty\\b" << "\\balias\\b"
                    << "\\bsignal\\b" << "\\breadonly\\b";
    foreach (const QString &pattern, keywordPatterns) {
        rule.pattern = QRegExp(pattern);
        rule.format = keywordFormat;
        highlightingRules.append(rule);
    }

//    classFormat.setFontWeight(QFont::Bold);
    classFormat.setForeground(Qt::magenta);
    rule.pattern = QRegExp("\\b[A-Z][A-Za-z]+[\\s]+(?=\\{)");
    rule.format = classFormat;
    highlightingRules.append(rule);

    quotationFormat.setForeground(Qt::darkGreen);
    rule.pattern = QRegExp("\".*\"");
    rule.format = quotationFormat;
    highlightingRules.append(rule);

    functionFormat.setFontItalic(true);
    functionFormat.setForeground(Qt::blue);
    rule.pattern = QRegExp("\\b[A-Za-z0-9_]+(?=\\()");
    rule.format = functionFormat;
    highlightingRules.append(rule);

    commentStartExpression = QRegExp("/\\*");
    commentEndExpression = QRegExp("\\*/");

    referenceFormat.setFontItalic(true);
    rule.pattern = QRegExp("\\b[a-z][A-Za-z0-9_]+[.]");
    rule.format = referenceFormat;
    highlightingRules.append(rule);

    rule.pattern = QRegExp("parent");
    highlightingRules.append(rule);

    propertyFormat.setForeground(Qt::red);
    rule.pattern = QRegExp("\\b[a-z][A-Za-z0-9_]*[\\s]*(?=[:\{])");
    rule.format = propertyFormat;
    highlightingRules.append(rule);

    rule.pattern = QRegExp("\\b[a-z][A-Za-z0-9_]*[.][a-z][A-Za-z0-9_]*[\\s]*(?=[:\{])");
    highlightingRules.append(rule);

    singleLineCommentFormat.setForeground(Qt::blue);
    rule.pattern = QRegExp("//[^\n]*");
    rule.format = singleLineCommentFormat;
    rule.comment = true;
    highlightingRules.append(rule);

    multiLineCommentFormat.setForeground(Qt::blue);
}

QMLSyntaxHighlighter::~QMLSyntaxHighlighter()
{
}

void QMLSyntaxHighlighter::highlightBlock(const QString &text)
{
    bool quit = false;
    for (const HighlightingRule &rule : highlightingRules) {
        QRegExp expression(rule.pattern);
        int index = expression.indexIn(text);
        while (index >= 0) {
            int length = expression.matchedLength();
            setFormat(index, length , rule.format);
            index = expression.indexIn(text, index + length);
            if (rule.comment)
                quit = true;
        }
        if (quit)
            break;
    }

    setCurrentBlockState(0);

    int startIndex = 0;
    if (previousBlockState() != 1)
        startIndex = commentStartExpression.indexIn(text);

    while (startIndex >= 0) {
        int endIndex = commentEndExpression.indexIn(text, startIndex);
        int commentLength;
        if (endIndex == -1) {
            setCurrentBlockState(1);
            commentLength = text.length() - startIndex;
        } else {
            commentLength = endIndex - startIndex
                    + commentEndExpression.matchedLength();
        }
        setFormat(startIndex, commentLength, multiLineCommentFormat);
        startIndex = commentStartExpression.indexIn(text, startIndex + commentLength);
    }
}

/******************************************************************************/

struct QmlEdit::Data {
    QString file;
};

QmlEdit::QmlEdit(const QString &file, QWidget *parent)
    : QTextEdit(parent), d(new Data)
{
    d->file = file;
    load();
    QFont font("monospace");
    font.setPointSize(20);
//    font.setFixedPitch(true);
    setFont(font);
    setCurrentFont(font);
    new QMLSyntaxHighlighter(font, document());
    setLineWrapMode(NoWrap);
    setTabStopWidth(QFontMetrics(font).width("  "));
}

QmlEdit::~QmlEdit()
{
    delete d;
}

auto QmlEdit::save() const -> void
{
    QFile file(d->file);
    file.open(QFile::WriteOnly | QFile::Truncate);
    file.write(toPlainText().toUtf8());
}

auto QmlEdit::load() -> void
{
    QFile file(d->file);
    file.open(QFile::ReadOnly);
    setPlainText(QString::fromUtf8(file.readAll()));
}

auto QmlEdit::file() const -> QString
{
    return d->file;
}
