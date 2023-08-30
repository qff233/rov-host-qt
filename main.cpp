#include "component/frameless_window.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <qqml.h>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<FrameLessWindow>("Rov.window", 1, 0, "FrameLessWindow");

    QQmlApplicationEngine engine;
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("rov-host-qt", "Main");

    return app.exec();
}
