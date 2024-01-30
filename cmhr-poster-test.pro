TEMPLATE = app

QT += core qml quick
CONFIG += c++11
CONFIG -= debug_and_release_target
CONFIG += qmlcompiler
CONFIG += console

SOURCES += main.cpp

TARGET=Poster
DESTDIR = out

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH += qml

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH +=

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

LIB_PATH += $$_PRO_FILE_PWD_/lib

win32 {
    #...

    EXTRA_BINFILES_WIN = $${EXTRA_BINFILES}
    EXTRA_BINFILES_WIN ~= s,/,\\,g
        DESTDIR_WIN = $${DESTDIR}
    DESTDIR_WIN ~= s,/,\\,g
    for(FILE,EXTRA_BINFILES_WIN){
                QMAKE_POST_LINK +=$$quote(cmd /c xcopy /e /r /y \"$${FILE}\" $${DESTDIR_WIN}$$escape_expand(\n\t))
    }
    CONFIG_FILE ~= s,/,\\,g
    CONFIG_DEST ~= s,/,\\,g
}

macx {
    #...

    DESTDIR_WIN ~= s,/,\\,g
    for(FILE,EXTRA_BINFILES){
                QMAKE_POST_LINK +=$$quote(cp -fa $${FILE} $${DESTDIR} || :$$escape_expand(\n\t))
    }
}

DISTFILES += \
    qml/qmldir

mytarget.command = touch $$mytarget.target
mytarget.depends = mytarget2

mytarget2.commands = @echo Building $$mytarget.target

QMAKE_EXTRA_TARGETS += mytarget mytarget2
PRE_TARGETDEPS += mytarget2
