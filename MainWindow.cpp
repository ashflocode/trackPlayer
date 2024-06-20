#include "MainWindow.h"

MainWindow::MainWindow() {
    _uiQML = new QQuickView(QUrl::fromLocalFile(":ui"));
    _uiQML->rootContext()->setContextProperty("Track", this);
    _uiQML->show();
}

MainWindow::~MainWindow() {
    std::remove(imgName.c_str());
}

void MainWindow::getMetadata() {
    filePath = QFileDialog::getOpenFileName(
            this,
            "SELECT TRACK",
            "/Users/aevans/Music",
            "MP3 Files (*.mp3)"
    );

    if (filePath == "") return;

    TagLib::MPEG::File f(filePath.toUtf8().constData()); // ERROR WHEN filePath FILE HAS NO METADATA

    filename = QString::fromStdString(filePath.toStdString().substr(filePath.toStdString().find_last_of("/\\") + 1));

    int m = f.audioProperties()->length() / 60;
    int s = f.audioProperties()->length() % 60;
    length = (QString::number(m)) + ":" + (s < 10 ?  "0" + QString::number(s) : QString::number(s));

    artist = QString::fromStdWString(f.tag()->artist().toWString());
    title = QString::fromStdWString(f.tag()->title().toWString());
    album = QString::fromStdWString(f.tag()->album().toWString());
    comment = QString::fromStdWString(f.tag()->comment().toWString());
    genre = QString::fromStdWString(f.tag()->genre().toWString());
    year = (f.tag()->year() == 0 ? "" : QString::number(f.tag()->year()));

    this->getArtwork(&f);

    emit this->textChanged();
}

void MainWindow::setMetadata() {
    if (filePath == "") return;
    TagLib::MPEG::File f(filePath.toUtf8().constData());
    f.tag()->setArtist(artist.toStdString());
    f.tag()->setTitle(title.toStdString());
    f.tag()->setAlbum(album.toStdString());
    f.tag()->setComment(comment.toStdString());
    f.tag()->setGenre(genre.toStdString());

    const std::string &y = year.toStdString();
    if (!y.empty() && std::all_of(y.begin(), y.end(), ::isdigit)) {
        f.tag()->setYear(std::stoi(year.toStdString()));
    }

    f.save();

    emit this->textChanged();
}

void MainWindow::getArtwork(TagLib::MPEG::File *f) {
    TagLib::ID3v2::Tag *ID3v2tag = f->ID3v2Tag();
    TagLib::ID3v2::FrameList Frame(ID3v2tag->frameListMap()["APIC"]);

    if (Frame.isEmpty()) {
        artwork = ":AlbumArtPlaceholder";
        return;
    }

    std::remove(imgName.c_str());
    imgName = "../resources/" + std::to_string(time(0) % 999999) + ".png";

    FILE *png(fopen(imgName.c_str(), "wb"));
    for(auto &i : Frame)
    {
        auto *PicFrame = (TagLib::ID3v2::AttachedPictureFrame *)i;
        {
            void *RetImage = NULL, *SrcImage;
            unsigned long Size = PicFrame->picture().size();
            SrcImage = malloc(Size);
            if (SrcImage)
            {
                memcpy(SrcImage, PicFrame->picture().data(), Size);
                fwrite(SrcImage, Size, 1, png);
                fclose(png);
                free(SrcImage);
            }

        }
    }
    artwork = QString::fromStdString("../" + imgName);
}