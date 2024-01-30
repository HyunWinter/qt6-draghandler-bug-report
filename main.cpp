#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QSurfaceFormat>
#include <QQmlContext>
#include <QDir>
#include <QtGlobal>
#include <QLoggingCategory>
#include <QStyleHints>

/**
 * @brief main The main entry point for the application
 * @param argc
 * @param argv
 * @return
 */
int main(int argc, char *argv[])
{
    // App settings
    const QString APP_NAME = "Drag Handler Reproduction";
    const QString APP_VERSION = "1.0";
    QGuiApplication::setApplicationName(APP_NAME);
    QGuiApplication::setApplicationVersion(APP_VERSION);

    // OpenGL
    QQuickWindow::setGraphicsApi(QSGRendererInterface::OpenGL);

    // Inits
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // Setups
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    // Cleanup
    qInstallMessageHandler(0);
    return app.exec();
}
