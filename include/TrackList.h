#pragma once

#include <QQmlEngine>
#include <QAbstractListModel>
#include <QString>
#include <QVariant>
#include "Database.h"

class Controller;

struct TrackItem {
    QString path{};
    QVariantList metadata{};
    bool isSelected{};
};

class Tracklist : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QStringList metadataFields MEMBER _metadataFields CONSTANT)
    Q_PROPERTY(QString currentFilter MEMBER _currentFilter NOTIFY filterChanged)
    Q_PROPERTY(bool alphabetical MEMBER _alphabetical NOTIFY filterChanged)

public:
    explicit Tracklist(Controller* controller, Database* database);
    [[nodiscard]] int rowCount(const QModelIndex&) const override;
    [[nodiscard]] QVariant data(const QModelIndex &index, int role) const override;
    [[nodiscard]] QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void removeTrack(const QString &path);
    Q_INVOKABLE void reorder(const QString& orderField);
    Q_INVOKABLE void getTrackData(const QList<QUrl>& urls);
    Q_INVOKABLE QString nextTrackPath();
    Q_INVOKABLE void loadTracklist(
            std::optional<QString> filterName = std::nullopt,
            std::optional<bool> alphabetical = std::nullopt
    );

    enum Roles {
        PathRole = Qt::UserRole + 1,
        MetadataRole,
        IsSelectedRole
    };

signals:
    void filterChanged();

private:
    Controller* _parent{};
    Database* _database{};
    QStringList _metadataFields{};
    QVector<TrackItem> m_tracks{};
    QString _currentFilter{};
    bool _alphabetical{};
};
