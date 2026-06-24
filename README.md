<<<<<<< HEAD
# QNX CAR Platform Infotainment Demo

A cross-platform automotive HMI application built with **Qt 6 / QML**, targeting the **QNX CAR 2.1 platform** (QNX Neutrino RTOS). Runs on Windows desktop for simulation and cross-compiles to QNX Neutrino via QNX SDP 8.0.

---

## Screenshots

> Run locally with `Desktop Qt 6.10.2 MinGW 64-bit` kit in Qt Creator to see the live UI.

---

## Features

| Screen | Description |
|--------|-------------|
| 🚗 Cluster | Live speed arc gauge, RPM bar, gear indicator, fuel level |
| 🎵 Media | Now-playing track, vinyl animation, play/pause/skip, volume |
| ❄️ Climate | Dual-zone temperature control, fan speed, A/C toggle |

- 1280×480 resolution (standard automotive HMI display)
- Dark automotive colour palette
- Simulated live vehicle data via `QTimer` + `QRandomGenerator`
- Bottom navigation bar with tab switching

---

## Architecture

```
qnx_infotainment/
├── main.cpp                        # App entry point, QML engine setup
├── src/
│   ├── SystemInfoProvider.{h,cpp}  # Speed, RPM, fuel — exposed to QML
│   ├── ClimateController.{h,cpp}   # Dual-zone HVAC backend
│   └── MediaController.{h,cpp}     # Media playback backend
├── qml/
│   ├── Main.qml                    # Root ApplicationWindow
│   ├── NavBar.qml                  # Bottom tab navigation
│   ├── ClusterView.qml             # Instrument cluster screen
│   ├── MediaView.qml               # Media player screen
│   ├── ClimateView.qml             # Climate control screen
│   └── components/
│       ├── GaugeArc.qml            # Reusable Canvas arc gauge
│       ├── TempControl.qml         # Temperature +/- card
│       └── qmldir                  # QML module descriptor
└── resources/
    └── qml.qrc                     # Bundles all QML into binary
```

---

## Tech Stack

- **Qt 6.10.2** — QtQuick, QtQML, QtQuickControls2
- **QML / C++** — QML UI with C++ QObject backends via `setContextProperty`
- **QNX SDP 8.0** — Cross-compile toolchain (qcc / q++ / ntoaarch64-gdb)
- **Target OS** — QNX Neutrino RTOS (QNX CAR 2.1 platform)
- **Host** — Windows 10/11 with MinGW 64-bit or MSVC 2022

---

## Build & Run (Desktop Simulation)

**Requirements:** Qt 6.x with Qt Quick, Qt Creator 13+

```bash
# Open in Qt Creator
File → Open File or Project → qnx_infotainment.pro

# Select kit
Desktop Qt 6.10.2 MinGW 64-bit   (or MSVC 2022 x86_64)

# Run
Ctrl+R
```

---

## QNX Cross-Compile (Target Hardware)

**Requirements:** QNX SDP 8.0, Qt built for QNX aarch64

```bat
# Set environment (Windows CMD)
G:\QNX800\qnx800\qnxsdp-env.bat

# Launch Qt Creator with QNX env
start "" "G:\QT\Tools\QtCreator\bin\qtcreator.exe"
```

Compiler path: `host\win64\x86_64\usr\bin\q++.exe`  
SDP path: your QNX SDP 8.0 installation root  
Target arch: `aarch64le` (ARM64 little-endian)

The `.pro` file auto-activates QNX-specific flags when built with a QNX kit:

```qmake
qnx {
    LIBS        += -lsocket
    DEFINES     += QNX_PLATFORM
    QMAKE_LFLAGS += -lang-c++
}
```

---

## Author

**Ravi Kiran** — Automotive Embedded Systems Engineer  
13+ years experience across HMI/Infotainment, ECU Integration & Validation  
BMW · Daimler · VW Group platforms

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue)](https://linkedin.com/in/ravikiranmysore)
=======
# qnx-infotainment-demo
Qt6/QML infotainment HMI demo targeting QNX CAR 2.1 platform - Cluster, Media, Climate screens with C++ backend
>>>>>>> f9f04d8bf449237431fdb6c1806f44044738ffa0
