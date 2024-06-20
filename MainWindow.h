#ifndef TRACKINFO_MAINWINDOW_H
#define TRACKINFO_MAINWINDOW_H

#include <QtWidgets>
#include <QQuickView>
#include <QQmlContext>
#include <taglib/mpeg/mpegfile.h>
#include "taglib/mpeg/id3v2/id3v2tag.h"
#include "taglib/mpeg/id3v2/frames/attachedpictureframe.h"

class MainWindow : public QWidget
{
    Q_OBJECT
    Q_PROPERTY(QString filePath MEMBER filePath NOTIFY textChanged)
    Q_PROPERTY(QString filename MEMBER filename NOTIFY textChanged)
    Q_PROPERTY(QString length MEMBER length NOTIFY textChanged)
    Q_PROPERTY(QString artist MEMBER artist NOTIFY textChanged)
    Q_PROPERTY(QString title MEMBER title NOTIFY textChanged)
    Q_PROPERTY(QString album MEMBER album NOTIFY textChanged)
    Q_PROPERTY(QString comment MEMBER comment NOTIFY textChanged)
    Q_PROPERTY(QString genre MEMBER genre NOTIFY textChanged)
    Q_PROPERTY(QString year MEMBER year NOTIFY textChanged)
    Q_PROPERTY(QString artwork MEMBER artwork NOTIFY textChanged)

    public:
        explicit MainWindow();
        ~MainWindow() override;

        Q_INVOKABLE void getMetadata();
        Q_INVOKABLE void setMetadata();
        void getArtwork(TagLib::MPEG::File *f);

    signals:
        void textChanged();

    private:
        QQuickView *_uiQML;
        QString filePath;
        QString filename;
        QString length;
        QString artist;
        QString title;
        QString album;
        QString comment;
        QString genre;
        QString year;
        QString artwork;
        std::string imgName;
};

#endif //TRACKINFO_MAINWINDOW_H
