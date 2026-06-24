import QtQuick 2.15
import QtQuick.Layouts 1.15
import "components"

Item {
    id: root

    readonly property color bgCard     : "#1C2030"
    readonly property color accentBlue : "#3A8FD9"
    readonly property color accentAmber: "#F5A623"
    readonly property color textPrimary: "#E8ECF0"
    readonly property color textMuted  : "#6B7280"

    RowLayout {
        anchors { fill: parent; margins: 24 }
        spacing: 24

        // ── Speed gauge ───────────────────────────────────────────────────────
        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.38
            color: bgCard
            radius: 12

            Column {
                anchors.centerIn: parent
                spacing: 8

                GaugeArc {
                    width:  200; height: 200
                    anchors.horizontalCenter: parent.horizontalCenter
                    value:    systemInfo.speed
                    maxValue: 220
                    arcColor: accentBlue
                    label:    "km/h"
                    valueText: systemInfo.speed.toString()
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text:  "SPEED"
                    color: textMuted
                    font { pixelSize: 11; letterSpacing: 2; bold: true }
                }
            }
        }

        // ── Centre info column ─────────────────────────────────────────────────
        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: bgCard
            radius: 12

            Column {
                anchors.centerIn: parent
                spacing: 20

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "VEHICLE STATUS"
                    color: textMuted
                    font { pixelSize: 11; letterSpacing: 2 }
                }

                // Gear indicator
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: systemInfo.speed === 0 ? "P" :
                          systemInfo.speed < 30   ? "1" :
                          systemInfo.speed < 60   ? "2" :
                          systemInfo.speed < 90   ? "3" :
                          systemInfo.speed < 130  ? "4" :
                          systemInfo.speed < 170  ? "5" : "6"
                    color: accentAmber
                    font { pixelSize: 64; bold: true }
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "GEAR"
                    color: textMuted
                    font { pixelSize: 11; letterSpacing: 2 }
                }

                // RPM text fallback
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 180; height: 6
                    radius: 3
                    color: "#2A2F3E"

                    Rectangle {
                        width: parent.width * (systemInfo.rpm / 8000)
                        height: parent.height
                        radius: parent.radius
                        color: systemInfo.rpm > 6000 ? "#EF4444" : accentBlue
                        Behavior on width { SmoothedAnimation { duration: 300 } }
                    }
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: systemInfo.rpm + " RPM"
                    color: textPrimary
                    font { pixelSize: 14; bold: true }
                }
            }
        }

        // ── Fuel gauge ────────────────────────────────────────────────────────
        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.25
            color: bgCard
            radius: 12

            Column {
                anchors.centerIn: parent
                spacing: 16

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "FUEL"
                    color: textMuted
                    font { pixelSize: 11; letterSpacing: 2 }
                }

                // Vertical fuel bar
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 32; height: 160
                    radius: 6
                    color: "#2A2F3E"

                    Rectangle {
                        anchors { bottom: parent.bottom; left: parent.left; right: parent.right }
                        height: parent.height * systemInfo.fuelLevel
                        radius: parent.radius
                        color: systemInfo.fuelLevel < 0.2 ? "#EF4444" :
                               systemInfo.fuelLevel < 0.4 ? accentAmber : "#22C55E"
                        Behavior on height { SmoothedAnimation { duration: 500 } }
                    }
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: Math.round(systemInfo.fuelLevel * 100) + "%"
                    color: textPrimary
                    font { pixelSize: 18; bold: true }
                }
            }
        }
    }
}
