import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    property int    currentIndex: 0
    property color  bgColor
    property color  accentColor
    property color  textColor
    property color  mutedColor

    color: bgColor

    // Top separator line
    Rectangle {
        anchors { top: parent.top; left: parent.left; right: parent.right }
        height: 1
        color: accentColor
        opacity: 0.3
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Repeater {
            model: [
                { label: "CLUSTER",  icon: "🚗" },
                { label: "MEDIA",    icon: "🎵" },
                { label: "CLIMATE",  icon: "❄️"  }
            ]

            delegate: Item {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Rectangle {
                    anchors { top: parent.top; left: parent.left; right: parent.right }
                    height: 3
                    color: accentColor
                    visible: index === root.currentIndex
                }

                Column {
                    anchors.centerIn: parent
                    spacing: 2

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: modelData.icon
                        font.pixelSize: 20
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: modelData.label
                        color: index === root.currentIndex ? accentColor : mutedColor
                        font { pixelSize: 10; letterSpacing: 1.5; bold: index === root.currentIndex }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.currentIndex = index
                }
            }
        }
    }
}
