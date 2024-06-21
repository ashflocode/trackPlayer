#include "../Include/Database.h"

Database::Database() : db(QSqlDatabase::addDatabase("QSQLITE"))
{
    db.setDatabaseName("m.db");
    query = QSqlQuery(db);
    db.open();

    mainTable = "Collection";
}

Database::~Database()
{
    QFile::remove("m.db");
}

void Database::getMetadataFields(const QStringList& metadataFields)
{
    QStringList dbFields = metadataFields;
    dbFields.append("path");
    fields = dbFields;
}

void Database::createTable(const QString& tableName)
{
    query.prepare(
            "SELECT name FROM sqlite_master WHERE type='table' AND name=:tableName"
            );
    query.bindValue(":tableName", tableName);

    bool tableExists = query.exec() && query.next();
    if (tableExists)
    {
        return;
    }

    QStringList fieldsWithTypes;

    for (const QString& filter : fields)
    {
        fieldsWithTypes.append(filter + " TEXT");
    }

    QString fieldsStr = fieldsWithTypes.join(", ");

    query.exec(QString(
            "CREATE TABLE %1 (%2)"
            ).arg(tableName, fieldsStr));

  emit databaseChanged();
}

void Database::removeTable(const QString& tableName)
{
    query.prepare(QString("DROP TABLE IF EXISTS %1").arg(tableName));
    query.exec();

    emit databaseChanged();
}

void Database::changeTableName(const QString& tableName, const QString& newName)
{
    if (newName == tableName)
    {
        return;
    }

    query.prepare(QString("ALTER TABLE %1 RENAME TO %2").arg(tableName, newName));
    query.exec();
}

QVariantList Database::getFromTable(
        const QString& tableName,
        const QStringList& filters,
        const QString& path
)
{
    query.prepare(QString(
            "SELECT %1 FROM %2 WHERE path=:path"
            ).arg(filters.join(", "), tableName));
    query.bindValue(":path", path);
    query.exec();

    QVariantList result;

    if (query.next())
    {
        for (const auto& filter : filters)
        {
            result.append(query.value(filter));
        }
    }

    return result;
}

QVariantList Database::getAllFromTable(const QString& tableName, const QString& orderField, bool alphabetically)
{
    if (!orderField.isEmpty())
    {
        QString order = alphabetically ? "ASC" : "DESC";
        query.prepare(QString(
                "SELECT * FROM %1 ORDER BY %2 %3"
        ).arg(tableName, orderField, order));
    }
    else
    {
        query.prepare(QString("SELECT * FROM %1").arg(tableName));
    }

    query.exec();

    QVariantList result;

    while (query.next())
    {
        QVariantMap row;

        for (int i = 0; i < query.record().count(); ++i)
        {
            row.insert(query.record().fieldName(i), query.value(i));
        }

        result.append(row);
    }

    return result;
}

void Database::removeFromTable(const QString& tableName, const QString& path)
{
  const QStringList tables = (tableName == mainTable) ? getAllTables() : QStringList{tableName};

  for (const QString& table : tables)
  {
    query.prepare(QString("DELETE FROM %1 WHERE path = :path").arg(table));
    query.bindValue(":path", path);
    query.exec();
  }

    emit databaseChanged();
}

void Database::addToTable(
        const QString& tableName,
        const QString& path,
        const QStringList& values
)
{
    if (this->entryExists(tableName, path))
    {
        return;
    }

    if (fields.size() != values.size())
    {
        qWarning() << "Mismatch! fields:" << fields.size()
                             << "values:" << values.size();
    }

    QString fieldsPrepStr = fields.join(", ");
    QString fieldsStr     = ":" + fields.join(", :");

    query.prepare(QString(
            "INSERT INTO %1 (%2) VALUES (%3)"
    ).arg(tableName, fieldsPrepStr, fieldsStr));

    int index = 0;
    for (const auto& field : fields)
    {
        query.bindValue(":" + field, values[index++]);
    }

    query.exec();

    if (tableName != mainTable)
    {
        this->addToTable(mainTable, path, values);
    }

    emit databaseChanged();
}

void Database::changeDataInTable(
        const QString& tableName,
        const QString& path,
        const QStringList& values
)
{
    QStringList setStr;

    int index = 0;
    for (const auto& value : values)
    {
        setStr.append(QString("%1 = '%2'").arg(fields[index++], value));
    }

    query.prepare(QString(
            "UPDATE %1 SET %2 WHERE path=:path"
    ).arg(tableName, setStr.join(", ")));
    query.bindValue(":path", path);
    query.exec();

    if (tableName != mainTable)
    {
        this->changeDataInTable(mainTable, path, values);
    }

    emit databaseChanged();
}

bool Database::entryExists(const QString& tableName, const QString& path)
{
    query.prepare(QString(
            "SELECT EXISTS(SELECT 1 FROM %1 WHERE path=:path LIMIT 1)"
            ).arg(tableName));
    query.bindValue(":path", path);
    query.exec();

    return query.next() && query.value(0).toBool();
}

QStringList Database::getAllTables()
{
  QStringList tables;

  query.prepare("SELECT name FROM sqlite_master WHERE type='table'");
  query.exec();

  while (query.next())
  {
    tables.append(query.value(0).toString());
  }

  return tables;
}