import QtQuick 2.15

Rectangle {
    id: root

    property string label     : "ZONE"
    property real   tempVal   : 22.0
    property color  accentCol : "#3A8FD9"
    property color  bgCol     : "#1C2030"
    property color  textCol   : "#E8ECF0"
    property color  mutedCol  : "#6B7280"

    signal increment()
    signal decrement()

    color: bgCol; radius: 12

    Column {
        anchors.centerIn: parent
        spacing: 16

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text:  root.label
            color: mutedCol
            font { pixelSize: 11; letterSpacing: 2; bold: true }
        }

        // Up button
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 56; height: 56; radius: 28
            color: "#252A3A"

            Text { anchors.centerIn: parent; text: "▲"; font.pixelSize: 22; color: root.accentCol }

            MouseArea { anchors.fill: parent; onClicked: root.increment() }
        }

        // Temperature value
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 2

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text:  root.tempVal.toFixed(1)
                color: textCol
                font { pixelSize: 48; bold: true }
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text:  "°C"
                color: root.accentCol
                font { pixelSize: 18; bold: true }
            }
        }

        // Down button
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 56; height: 56; radius: 28
            color: "#252A3A"

            Text { anchors.centerIn: parent; text: "▼"; font.pixelSize: 22; color: root.accentCol }

            MouseArea { anchors.fill: parent; onClicked: root.decrement() }
        }
    }
}
