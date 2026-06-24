#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>

#include "src/SystemInfoProvider.h"
#include "src/ClimateController.h"
#include "src/MediaController.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    app.setApplicationName("QNX Infotainment");
    app.setApplicationVersion("1.0.0");
    app.setOrganizationName("QNX CAR Platform");

    // Use Basic style — guaranteed to work on QNX without platform themes
    QQuickStyle::setStyle("Basic");

    QQmlApplicationEngine engine;

    // Allow QML to find components/ module via qrc
    engine.addImportPath(QStringLiteral("qrc:/"));

    // Register C++ backend objects into QML context
    SystemInfoProvider sysInfo;
    ClimateController  climate;
    MediaController    media;

    engine.rootContext()->setContextProperty("systemInfo", &sysInfo);
    engine.rootContext()->setContextProperty("climate",    &climate);
    engine.rootContext()->setContextProperty("media",      &media);

    const QUrl url(QStringLiteral("qrc:/qml/Main.qml"));

    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection
    );

    engine.load(url);

    return app.exec();
}
