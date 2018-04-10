#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "database.h"
#include <QtGui>
#include <QtQuick>
#include "cpp.h"
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setOrganizationName("Some Company");
        app.setOrganizationDomain("somecompany.com");
        app.setApplicationName("Amazing Application");

    QQmlApplicationEngine engine;
    // Подключаемся к базе данных
    database dataBase;
    dataBase.connectToDataBase();
    // Обеспечиваем доступ к модели и классу для работы с базой данных из QML
    engine.rootContext()->setContextProperty("dataBase", &dataBase);

    cpp *cppClass = new cpp(&engine);
    engine.rootContext()->setContextProperty(QLatin1String("cppClass"),cppClass);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
