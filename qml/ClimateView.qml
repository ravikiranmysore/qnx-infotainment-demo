import QtQuick 2.15
import QtQuick.Layouts 1.15
import "components"

Item {
    id: root

    readonly property color bgCard     : "#1C2030"
    readonly property color accentBlue : "#3A8FD9"
    readonly property color textPrimary: "#E8ECF0"
    readonly property color textMuted  : "#6B7280"

    RowLayout {
        anchors { fill: parent; margins: 24 }
        spacing: 24

        // ── Driver zone ────────────────────────────────────────────────────────
        TempControl {
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.3
            label:    "DRIVER"
            tempVal:  climate.driverTemp
            accentCol: accentBlue
            bgCol:    bgCard
            textCol:  textPrimary
            mutedCol: textMuted
            onIncrement: climate.driverTemp = climate.driverTemp + 0.5
            onDecrement: climate.driverTemp = climate.driverTemp - 0.5
        }

        // ── Fan & AC centre ────────────────────────────────────────────────────
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: bgCard; radius: 12

            Column {
                anchors.centerIn: parent
                spacing: 24

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "FAN SPEED"
                    color: textMuted
                    font { pixelSize: 11; letterSpacing: 2 }
                }

                // Fan speed dots
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 10

                    Repeater {
                        model: 5
                        delegate: Rectangle {
                            width: 32; height: 32; radius: 16
                            color: (index + 1) <= climate.fanSpeed ? accentBlue : "#252A3A"

                            Text {
                                anchors.centerIn: parent
                                text: (index + 1).toString()
                                color: textPrimary
                                font { pixelSize: 13; bold: true }
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: climate.fanSpeed = index + 1
                            }
                        }
                    }
                }

                // AC toggle
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 120; height: 44; radius: 22
                    color: climate.acOn ? accentBlue : "#252A3A"

                    Text {
                        anchors.centerIn: parent
                        text: climate.acOn ? "A/C  ON" : "A/C  OFF"
                        color: textPrimary
                        font { pixelSize: 14; bold: true; letterSpacing: 1 }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: climate.acOn = !climate.acOn
                    }
                }

                // Airflow icon (decorative)
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: climate.acOn ? "❄️  " + climate.fanSpeed + " bar" : "💨  " + climate.fanSpeed + " bar"
                    color: textMuted
                    font.pixelSize: 14
                }
            }
        }

        // ── Passenger zone ─────────────────────────────────────────────────────
        TempControl {
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.3
            label:    "PASSENGER"
            tempVal:  climate.passengerTemp
            accentCol: "#F5A623"
            bgCol:    bgCard
            textCol:  textPrimary
            mutedCol: textMuted
            onIncrement: climate.passengerTemp = climate.passengerTemp + 0.5
            onDecrement: climate.passengerTemp = climate.passengerTemp - 0.5
        }
    }
}
