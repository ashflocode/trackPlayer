#pragma once

#include <QtWidgets>
#include <QSqlQuery>
#include <QSqlRecord>

class Database : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString mainTable MEMBER mainTable CONSTANT)

public:
    explicit Database();
    ~Database() override;

    Q_INVOKABLE void createTable(const QString& name);
    Q_INVOKABLE void removeTable(const QString& tableName);
    Q_INVOKABLE void changeTableName(const QString& tableName, const QString& newName);
    Q_INVOKABLE QVariantList getFromTable(const QString& tableName, const QStringList& filters, const QString& path);
    Q_INVOKABLE QVariantList getAllFromTable(const QString& tableName, const QString& orderField, bool alphabetically);
    Q_INVOKABLE void removeFromTable(const QString& tableName, const QString& path);

    void getMetadataFields(const QStringList& metadataFields);
    void addToTable(const QString& tableName, const QString& path, const QStringList& values);
    void changeDataInTable(const QString& tableName, const QString& path, const QStringList& values);
    QStringList getAllTables();

    QString mainTable{};

signals:
    void databaseChanged();

private:
    bool entryExists(const QString& tableName, const QString& path);

    QSqlDatabase db{};
    QSqlQuery query{};
    QStringList fields{};
};
