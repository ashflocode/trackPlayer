#include "../Include/Tracklist.h"
#include "../Include/Controller.h"

Tracklist::Tracklist(Controller* controller, Database* database)
        : _parent(controller)
        , _database(database)
{
  _metadataFields   = { "artist", "title", "album", "genre", "year" };
  _currentFilter    = _metadataFields.at(1);
  _alphabetical     = true;

  _database->getMetadataFields(_metadataFields);
}

int Tracklist::rowCount(const QModelIndex&) const
{
  return static_cast<int>(m_tracks.size());
}

QVariant Tracklist::data(const QModelIndex &index, int role) const
{
  if (!index.isValid() || index.row() >= m_tracks.size()) return {};

  const auto &track = m_tracks.at(index.row());
  switch (role) {
    case PathRole: return track.path;
    case MetadataRole: return track.metadata;
    case IsSelectedRole: return track.isSelected;
    default: return {};
  }
}

QHash<int, QByteArray> Tracklist::roleNames() const
{
  return {
          { PathRole, "path" },
          { MetadataRole, "metadata" },
          { IsSelectedRole, "isSelected" }
  };
}

void Tracklist::removeTrack(const QString &path)
{
  for (int i = 0; i < m_tracks.size(); ++i)
  {
    if (m_tracks[i].path == path)
    {
      beginRemoveRows({}, i, i);
      m_tracks.removeAt(i);
      endRemoveRows();

      _database->removeFromTable(_parent->playlist()->current(), path);
      return;
    }
  }
}

void Tracklist::reorder(const QString& filterName)
{
  if (_currentFilter == filterName)
  {
    _alphabetical = !_alphabetical;
  }
  else
  {
    _currentFilter = filterName;
  }

  emit filterChanged();
}

void Tracklist::getTrackData(const QList<QUrl>& urls)
{
  for (const QUrl& url : urls)
  {
    const QFileInfo info(url.toLocalFile());

    if (!info.exists()) continue;

    const QDir dir = info.isDir() ? QDir(info.absoluteFilePath()) : info.dir();
    const QString targetFile = info.isFile() ? info.absoluteFilePath() : QString();
    const QFileInfoList files = dir.entryInfoList(
            _parent->validFormats,
            QDir::Files | QDir::NoSymLinks,
            QDir::Name
    );

    for (const QFileInfo& file : files)
    {
      if (!targetFile.isEmpty() && file.absoluteFilePath() != targetFile) continue;

      _parent->getMetadata(
              QUrl::fromLocalFile(file.absoluteFilePath()).toString(),
              _parent->playlist()->current(),
              false
      );
    }
  }
}

QString Tracklist::nextTrackPath()
{
  if (m_tracks.isEmpty()) return {};

  for (int i = 0; i < m_tracks.size(); ++i)
  {
    if (m_tracks[i].path == _parent->filePath)
    {
      return m_tracks[(i + 1) % m_tracks.size()].path;
    }
  }
  return m_tracks.first().path;
}

void Tracklist::loadTracklist(
        std::optional<QString> filterName,
        std::optional<bool> alphabetical
)
{
  if (filterName.has_value()) _currentFilter = filterName.value();
  if (alphabetical.has_value()) _alphabetical = alphabetical.value();

  const QString playlist = _parent->playlist()->current();

  beginResetModel();
  m_tracks.clear();

  QVariantList allTracks = _database->getAllFromTable(playlist, _currentFilter, _alphabetical);

  for (const QVariant &item : allTracks)
  {
    QString path = item.toMap().value("path").toString();

    m_tracks.append(TrackItem{
            path,
            _database->getFromTable(playlist, _metadataFields, path),
            path == _parent->filePath
    });
  }
  endResetModel();
}
