#include "../Include/Playlist.h"
#include "../Include/Controller.h"

Playlist::Playlist(Controller* controller, Database* database)
        : _parent(controller)
        , _database(database)
{
  _database->createTable(_database->mainTable);
}

int Playlist::rowCount(const QModelIndex&) const
{
  return static_cast<int>(_playlists.size());
}

QVariant Playlist::data(const QModelIndex &index, int role) const
{
  if (!index.isValid() || index.row() >= _playlists.size()) return {};

  const auto& playlist = _playlists[index.row()];
  switch (role)
  {
    case NameRole: return playlist.name;
    case IsSelectedRole: return playlist.isSelected;
    default: return {};
  }
}

QHash<int, QByteArray> Playlist::roleNames() const
{
  return {
          { NameRole, "name" },
          { IsSelectedRole, "isSelected" }
  };
}

QString Playlist::current() const
{
  for (const auto& p : _playlists)
  {
    if (p.isSelected) return p.name;
  }
  return _database->mainTable;
}

void Playlist::add()
{
  QString name = QStringLiteral("Playlist%1").arg(_playlists.size() + 1);

  beginInsertRows({}, static_cast<int>(_playlists.size()), static_cast<int>(_playlists.size()));
  _playlists.push_back({ name, false });
  endInsertRows();

  _database->createTable(name);
  this->select(name);
}

void Playlist::select(const QString& name)
{
  for (auto& playlist : _playlists)
  {
    playlist.isSelected = (playlist.name == name);
  }

  emit dataChanged(
          index(0),
          index(static_cast<int>(_playlists.size() - 1)),
          { IsSelectedRole }
  );
  emit selectedChanged();
}

void Playlist::remove(const QString& name)
{
  for (int i = 0; i < _playlists.size(); ++i)
  {
    if (_playlists[i].name == name)
    {
      beginRemoveRows({}, i, i);
      _playlists.removeAt(i);
      endRemoveRows();

      _database->removeTable(name);
      return;
    }
  }
  this->select(_database->mainTable);
}

void Playlist::startRename()
{
  _playlistBeingEdited = this->current();
}

void Playlist::rename(const QString& newName)
{
  for (int i = 0; i < _playlists.size(); ++i)
  {
    if (_playlists[i].name == _playlistBeingEdited)
    {
      _playlists[i].name = newName;
      _database->changeTableName(_playlistBeingEdited, newName);

      emit dataChanged(index(i), index(i), { NameRole });
      break;
    }
  }
}
