# QNX CAR Platform Infotainment — Qt/QML Demo

## Requirements
| Tool           | Version                          |
|----------------|----------------------------------|
| Qt Creator     | 19.0.0                           |
| Qt             | 6.20 (MSVC 2022 x86_64)         |
| Target OS      | QNX Neutrino (QNX CAR 2.1)      |
| Host build     | Windows 10/11, MSVC 2022        |

## Project structure
```
qnx_infotainment/
├── qnx_infotainment.pro       ← open this in Qt Creator
├── main.cpp
├── src/
│   ├── SystemInfoProvider.{h,cpp}   — vehicle telemetry (speed, RPM, fuel)
│   ├── ClimateController.{h,cpp}    — dual-zone HVAC
│   └── MediaController.{h,cpp}      — media playback
├── qml/
│   ├── Main.qml              — root ApplicationWindow
│   ├── NavBar.qml            — bottom tab bar
│   ├── ClusterView.qml       — speedometer / RPM / fuel
│   ├── MediaView.qml         — now playing + controls
│   ├── ClimateView.qml       — dual-zone temperature
│   └── components/
│       ├── GaugeArc.qml      — Canvas arc gauge
│       ├── TempControl.qml   — +/- temperature card
│       └── FanButton.qml     — (reserved)
└── resources/
    └── qml.qrc               — bundles all QML into the binary
```

## Opening in Qt Creator

1. **File → Open File or Project** → select `qnx_infotainment.pro`
2. Configure the kit:
   - **Desktop simulation**: choose *Qt 6.20 MSVC 2022 x86_64*
   - **QNX cross-compile**: choose your *QNX SDP 7.x* kit configured with
     `qcc` / `aarch64-unknown-nto-qnx7.1.0-g++`
3. Press **Run** (Ctrl+R) — the app opens at 1280×480 (typical HMI resolution)

## QNX cross-compile notes
- Install **QNX SDP 7.x** and set `QNX_HOST` / `QNX_TARGET` environment variables.
- In Qt Creator → Preferences → Kits → add a QNX kit pointing to the SDP.
- The `.pro` `qnx { }` block activates `-lsocket` and `QNX_PLATFORM` define.
- Deploy: `make install` copies the binary to `/opt/qnxcar/apps/infotainment`
  on the target (adjust `target.path` as needed).

## Simulated data
On desktop the `SystemInfoProvider` uses `QTimer` + `QRandomGenerator` to
simulate live vehicle data. Replace with QNX PPS reads from
`/pps/qnxcar/sensors/...` for the real target.
