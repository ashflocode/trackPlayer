#pragma once

#include <QQmlEngine>
#include <QAbstractListModel>
#include <QString>
#include <QVariant>
#include "Database.h"

class Controller;

struct PlaylistItem {
    QString name;
    bool isSelected;
};

class Playlist : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QString current READ current NOTIFY selectedChanged)

public:
    explicit Playlist(Controller* controller, Database* database);
    [[nodiscard]] int rowCount(const QModelIndex&) const override;
    [[nodiscard]] QVariant data(const QModelIndex &index, int role) const override;
    [[nodiscard]] QHash<int, QByteArray> roleNames() const override;
    [[nodiscard]] QString current() const;

    Q_INVOKABLE void add();
    Q_INVOKABLE void select(const QString& name);
    Q_INVOKABLE void remove(const QString& name);
    Q_INVOKABLE void startRename();
    Q_INVOKABLE void rename(const QString& newName);

    enum Roles {
        NameRole = Qt::UserRole + 1,
        IsSelectedRole
    };

signals:
    void selectedChanged();

private:
    Controller* _parent{};
    Database* _database{};
    QVector<PlaylistItem> _playlists;
    QString _playlistBeingEdited;
};
