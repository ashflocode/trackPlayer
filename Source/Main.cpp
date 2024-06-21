#include <QGuiApplication>
#include <QQuickView>
#include "../Include/Controller.h"

int main(int argc, char **argv) {
    QGuiApplication app(argc, argv);
    QQuickView view;
    Controller controller(&view, view.engine());

    qmlRegisterSingletonInstance("App", 1, 0, "Controller", &controller);
    view.setSource(QUrl("qrc:/ui/Qml/MainWindow.qml"));
    view.show();

    return QGuiApplication::exec();
}