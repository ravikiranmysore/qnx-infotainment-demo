###############################################################################
# QNX CAR Platform Infotainment App
# Target  : QNX Neutrino RTOS (QNX CAR 2.1 Platform)
# Toolchain: MSVC 2022 x86_64  |  Qt 6.20
# Qt Creator 19.0.0
###############################################################################

QT       += core gui qml quick quickcontrols2

greaterThan(QT_MAJOR_VERSION, 5): QT += widgets

TARGET   = QNXInfotainment
TEMPLATE = app
CONFIG   += c++17

# ── Source files ──────────────────────────────────────────────────────────────
SOURCES += \
    main.cpp \
    src/SystemInfoProvider.cpp \
    src/ClimateController.cpp \
    src/MediaController.cpp

HEADERS += \
    src/SystemInfoProvider.h \
    src/ClimateController.h \
    src/MediaController.h

# ── QML / Resources ───────────────────────────────────────────────────────────
RESOURCES += \
    resources/qml.qrc

# ── QNX Neutrino cross-compile flags ──────────────────────────────────────────
qnx {
    LIBS        += -lsocket
    QMAKE_LFLAGS += -lang-c++
    DEFINES     += QNX_PLATFORM
    message("Building for QNX Neutrino target")
} else {
    # Desktop (Windows MSVC) simulation build
    message("Building for host desktop simulation")
}

# ── Compiler / linker options ─────────────────────────────────────────────────
DEFINES += QT_DEPRECATED_WARNINGS

CONFIG(release, debug|release): DEFINES += QT_NO_DEBUG_OUTPUT

QMAKE_CXXFLAGS += -Wall

# ── Install paths (QNX target filesystem) ────────────────────────────────────
target.path = /opt/qnxcar/apps/infotainment
INSTALLS    += target
