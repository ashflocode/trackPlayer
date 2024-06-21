#include <QtQuickTest>
#include <QQmlEngine>
#include <memory>
#include "../Include/Controller.h"

class Setup : public QObject
{
Q_OBJECT

public:
    Setup() = default;

private:
    std::unique_ptr<Controller> window;

public slots:
    void qmlEngineAvailable(QQmlEngine *engine)
    {
        QQuickView view;
        window = std::make_unique<Controller>(&view, engine);
        engine->rootContext()->setContextProperty("testPath", qApp->applicationDirPath());
    }
};

QUICK_TEST_MAIN_WITH_SETUP(test, Setup)

#include "TestApp.moc"
