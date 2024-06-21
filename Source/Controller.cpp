#include "../Include/Controller.h"

Controller::Controller(QQuickView* view, QQmlEngine* engine)
{
    _pImageProvider = new ImageProvider;
    _windowSize = {600, 500};
    _elapsed = false;
    validFormats = { "*.mp3", "*.wav", "*.flac", "*.aiff" };

    engine->addImageProvider("ImageProvider", _pImageProvider);
    engine->addImportPath("qrc:/ui");

    view->setTitle("TRACK PLAYER");
    view->setMinimumSize(_windowSize);
    view->setMaximumSize(_windowSize);

    this->_setupConnections();
}

Controller::~Controller() = default;

void Controller::_setupConnections()
{
    auto reloadTracklist = [this]() { _tracklist.loadTracklist(); };
    connect(this, &Controller::trackLoadedChanged, this, reloadTracklist);
    connect(&_database, &Database::databaseChanged, this, reloadTracklist);
    connect(&_tracklist, &Tracklist::filterChanged, this, reloadTracklist);
    connect(&_playlist, &Playlist::selectedChanged, this, reloadTracklist);
}

//==============AUDIO==============\\

void Controller::load(QString path)
{
    filePath = std::move(path);
    _audio.load(QUrl(filePath).path().toStdString().c_str());
    _songLength = _audio.getSongLength();

    this->setPlaybackLength();
    this->getMetadata(filePath, _playlist.current(), true);
    this->getWaveform();

    _trackLoaded = true;
    emit trackLoadedChanged();

    if (_continuousPlayback) this->play();
}

void Controller::eject()
{
    _audio.eject();
    filePath = nullptr;
    _filename = _artist = _title = _album = _genre = _year = _playlength = "";
    _trackLoaded = false;

    emit metadataChanged();
    emit playlengthChanged();
    emit trackLoadedChanged();
}

bool Controller::isValidFormat(QString filePath)
{
    const QString suffix = "*." + QFileInfo(filePath).suffix().toLower();

    _isMp3 = (suffix == "*.mp3");

    emit trackValidatedChanged();

    return validFormats.contains(suffix);
}

float Controller::getPlayPositionInMs()
{
    return _audio.getPlayPositionInMs();
}

void Controller::setPlaybackLength()
{
    int positionInSeconds = static_cast<int>(_audio.getPlayPositionInMs());

    std::function<QString(int)> formatter = [](int time)
    {
        return time < 10
                ? "0" + QString::number(time)
                : QString::number(time);
    };

    _playlength = _elapsed
            ? formatter(positionInSeconds / 60) // minutes
                    + ":"
                    + formatter(positionInSeconds % 60) // seconds
            : "-"
                    + formatter((static_cast<int>(_songLength) - positionInSeconds) / 60)
                    + ":"
                    + formatter((static_cast<int>(_songLength) - positionInSeconds) % 60);

    emit playlengthChanged();
}

void Controller::scrub(float uiSongPosition)
{
    _audio.setSongPosition(uiSongPosition);
}

void Controller::setCue(float uiSongPosition)
{
    _audio.setCue(uiSongPosition);
}

void Controller::filter(float dialValue, float dialRange)
{
    _audio.filter(dialValue, dialRange);
}

void Controller::delay(float dialValue)
{
    _audio.delay(dialValue);
}

void Controller::delaySpeed(float speed)
{
    _audio.delaySpeed(speed);
}

//==============WAVEFORM==============\\

void Controller::getWaveform()
{
    std::thread waveformThread([this]() {
        this->_drawWaveform();
    });
    waveformThread.detach();
}

QColor Controller::_getRGBA(float amplitude, QColor loud, QColor quiet)
{
    double mixFactor = std::fabs(static_cast<double>(amplitude));

    int r = static_cast<int>(std::lround(quiet.red()   + mixFactor * (loud.red()   - quiet.red())));
    int g = static_cast<int>(std::lround(quiet.green() + mixFactor * (loud.green() - quiet.green())));
    int b = static_cast<int>(std::lround(quiet.blue()  + mixFactor * (loud.blue()  - quiet.blue())));
    int a = 180;

    return {r, g, b, a};
}

void Controller::_drawWaveform()
{
    const auto allSamples   = _audio.getAllSamples();
    int samplesPerPixel     = _audio.getSamplesPerPixel(_waveformSize.width());
    float waveformHCenter   = static_cast<float>(_waveformSize.height()) / 2;

    QImage image(_waveformSize.width(), _waveformSize.height(), QImage::Format_ARGB32);
    image.fill(Qt::transparent);

    QPainter painter(&image);
    painter.setRenderHint(QPainter::Antialiasing);
    painter.setPen(Qt::NoPen);

    QColor loudColor(Qt::white);
    QColor quietColor(_waveformColor);

    for (int i = 0; i < _waveformSize.width(); i++)
    {
        float amplitude = *std::min_element(
                allSamples.begin() + samplesPerPixel * i,
                allSamples.begin() + samplesPerPixel * i + samplesPerPixel);

        float yOffset = amplitude * waveformHCenter;

        painter.setBrush(this->_getRGBA(amplitude, loudColor, quietColor));

        QPolygonF waveformSegment;
        waveformSegment << QPointF(i, waveformHCenter - yOffset)
                        << QPointF(i, waveformHCenter + yOffset)
                        << QPointF(i + 1, waveformHCenter + yOffset)
                        << QPointF(i + 1, waveformHCenter - yOffset);

        painter.drawPolygon(waveformSegment);
    }

    painter.end();

    _pImageProvider->image = image;

    emit waveformLoadedChanged();
}

//==============METADATA==============\\

TagLib::MPEG::File Controller::_getFile(const QString& path)
{
    return {QUrl(path).toLocalFile().toUtf8()};
}

void Controller::getMetadata(const QString& path, const QString& databaseTable, bool updateDeck)
{
    TagLib::MPEG::File f  = this->_getFile(path);

    _filename   = QFileInfo(path).baseName();
    _artist     = QString::fromStdWString(f.tag()->artist().toWString());
    _title      = QString::fromStdWString(f.tag()->title().toWString());
    _album      = QString::fromStdWString(f.tag()->album().toWString());
    _genre      = QString::fromStdWString(f.tag()->genre().toWString());
    _year       = (f.tag()->year() == 0 ? "" : QString::number(f.tag()->year()));

    this->_getArtwork();

    _database.addToTable(
            databaseTable,
            path,
            {
                _artist,
                _title.isEmpty() ? _filename : _title,
                _album,
                _genre,
                _year,
                path
            }
    );

    if (updateDeck)
    {
        emit metadataChanged();
    }
}

void Controller::setMetadata(const QStringList& fields, const QString& databaseTable)
{
    _artist = fields[0];
    _title = fields[1];
    _album = fields[2];
    _genre = fields[3];
    _year = fields[4];

    TagLib::MPEG::File f = this->_getFile(filePath);

    f.tag()->setArtist(_artist.toStdString());
    f.tag()->setTitle(_title.toStdString());
    f.tag()->setAlbum(_album.toStdString());
    f.tag()->setGenre(_genre.toStdString());

    const std::string &y = _year.toStdString();
    if (!y.empty() && y.size() == 4 && std::all_of(y.begin(), y.end(), ::isdigit))
    {
        f.tag()->setYear(std::stoi(_year.toStdString()));
    }

    f.save();

    _database.changeDataInTable(
            databaseTable,
            filePath,
            { _artist, _title, _album, _genre, _year }
    );

    emit metadataChanged();
}

void Controller::_getArtwork()
{
    TagLib::MPEG::File f            = this->_getFile(filePath);
    TagLib::ID3v2::Tag *id3v2tag    = f.ID3v2Tag();

    if (!id3v2tag->frameList("APIC").isEmpty())
    {
        auto *frame = (TagLib::ID3v2::AttachedPictureFrame*)id3v2tag->frameList("APIC").front();

        _pImageProvider->image.loadFromData(
                (uchar *)frame->picture().data(),
                static_cast<int>(frame->picture().size())
        );
    }
    else
    {
        _pImageProvider->image.load(":/images/artwork");
    }
}
