#pragma once

#include <QtWidgets>
#include <QQuickView>
#include <QQmlContext>
#include <taglib/mpeg/mpegfile.h>
#include <taglib/mpeg/id3v2/id3v2tag.h>
#include <taglib/mpeg/id3v2/frames/attachedpictureframe.h>
#include "ImageProvider.h"
#include "Audio.h"
#include "Database.h"
#include "Playlist.h"
#include "Tracklist.h"

class Controller : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Database* database READ database CONSTANT)
    Q_PROPERTY(Tracklist* tracklist READ tracklist CONSTANT)
    Q_PROPERTY(Playlist* playlist READ playlist CONSTANT)
    Q_PROPERTY(QStringList validFormats MEMBER validFormats CONSTANT)
    Q_PROPERTY(QString filename MEMBER _filename NOTIFY metadataChanged)
    Q_PROPERTY(QString artist MEMBER _artist NOTIFY metadataChanged)
    Q_PROPERTY(QString title MEMBER _title NOTIFY metadataChanged)
    Q_PROPERTY(QString album MEMBER _album NOTIFY metadataChanged)
    Q_PROPERTY(QString genre MEMBER _genre NOTIFY metadataChanged)
    Q_PROPERTY(QString year MEMBER _year NOTIFY metadataChanged)
    Q_PROPERTY(QString playlength MEMBER _playlength NOTIFY playlengthChanged)
    Q_PROPERTY(QString waveformColor MEMBER _waveformColor)
    Q_PROPERTY(QSize windowSize MEMBER _windowSize CONSTANT)
    Q_PROPERTY(QSize waveformSize MEMBER _waveformSize)
    Q_PROPERTY(float songLength MEMBER _songLength)
    Q_PROPERTY(bool trackLoaded MEMBER _trackLoaded NOTIFY trackLoadedChanged)
    Q_PROPERTY(bool waveformLoaded MEMBER _waveformLoaded NOTIFY waveformLoadedChanged)
    Q_PROPERTY(bool continuousPlayback MEMBER _continuousPlayback)
    Q_PROPERTY(bool isMp3 MEMBER _isMp3 NOTIFY trackValidatedChanged)

public:
    explicit Controller(QQuickView* view, QQmlEngine* engine);
    ~Controller() override;

    Q_INVOKABLE void load(QString filePath);
    Q_INVOKABLE bool isValidFormat(QString filePath);
    Q_INVOKABLE float getPlayPositionInMs();
    Q_INVOKABLE void setPlaybackLength();
    Q_INVOKABLE void scrub(float uiSongPosition);
    Q_INVOKABLE void setCue(float uiSongPosition);
    Q_INVOKABLE void filter(float dialValue, float dialRange);
    Q_INVOKABLE void delay(float dialValue);
    Q_INVOKABLE void delaySpeed(float speed);
    Q_INVOKABLE void getWaveform();
    Q_INVOKABLE void setMetadata(const QStringList& fields, const QString& databaseTable);
    Q_INVOKABLE void toggleLengthState() { _elapsed = !_elapsed; };
    Q_INVOKABLE void play()              { _audio.play(); };
    Q_INVOKABLE void pause()             { _audio.pause(); };
    Q_INVOKABLE void stop()              { _audio.stop(); };
    Q_INVOKABLE void reset()             { _audio.reset(); };
    Q_INVOKABLE void triggerCue()        { _audio.triggerCue(); };
    Q_INVOKABLE void loopIn()            { _audio.loopIn(); };
    Q_INVOKABLE void loopOut()           { _audio.loopOut(); };
    Q_INVOKABLE void clearLoop()         { _audio.clearLoop(); };
    Q_INVOKABLE void resetFilter()       { _audio.resetFilter(); };
    Q_INVOKABLE void resetDelay()        { _audio.resetDelay(); };
    Q_INVOKABLE void eject();

    Database* database() { return &_database; }
    Tracklist* tracklist() { return &_tracklist; }
    Playlist* playlist() { return &_playlist; }
    void getMetadata(const QString& filePath, const QString& databaseTable, bool updateDeck);
    QStringList validFormats{};
    QString filePath{};

signals:
    void metadataChanged();
    void playlengthChanged();
    void trackLoadedChanged();
    void trackValidatedChanged();
    void waveformLoadedChanged();

private:
    void _setupConnections();
    TagLib::MPEG::File _getFile(const QString& path);
    void _getArtwork();
    static QColor _getRGBA(float amplitude, QColor loud, QColor quiet);
    void _drawWaveform();

    ImageProvider* _pImageProvider{};
    Audio _audio{};
    Database _database{};
    Tracklist _tracklist{ this, &_database };
    Playlist _playlist{ this, &_database };
    QString _filename{};
    QString _artist{};
    QString _title{};
    QString _album{};
    QString _genre{};
    QString _year{};
    QString _playlength{};
    QString _waveformColor{};
    QSize _windowSize{};
    QSize _waveformSize{};
    float _songLength{};
    bool _elapsed{};
    bool _trackLoaded{};
    bool _waveformLoaded{};
    bool _continuousPlayback{};
    bool _isMp3{};
};
