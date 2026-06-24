import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: root
    visible: true
    width:  1280
    height: 480
    title:  "QNX CAR Infotainment"

    // ── Palette (dark automotive HMI) ────────────────────────────────────────
    readonly property color bgBase     : "#0D0F14"
    readonly property color bgPanel    : "#151820"
    readonly property color bgCard     : "#1C2030"
    readonly property color accentBlue : "#3A8FD9"
    readonly property color accentAmber: "#F5A623"
    readonly property color textPrimary: "#E8ECF0"
    readonly property color textMuted  : "#6B7280"

    color: bgBase

    // ── Status bar ───────────────────────────────────────────────────────────
    Rectangle {
        id: statusBar
        anchors { top: parent.top; left: parent.left; right: parent.right }
        height: 36
        color: bgPanel

        RowLayout {
            anchors { fill: parent; leftMargin: 16; rightMargin: 16 }

            Text {
                text: "QNX CAR 2.1"
                color: accentBlue
                font { pixelSize: 13; bold: true; letterSpacing: 1.5 }
            }

            Item { Layout.fillWidth: true }

            Text {
                text: systemInfo.currentTime
                color: textPrimary
                font { pixelSize: 14; bold: true }
            }

            Rectangle {
                width: 1; height: 20
                color: textMuted
                Layout.leftMargin: 12; Layout.rightMargin: 12
            }

            // Fuel indicator
            Text {
                text: "⛽ " + Math.round(systemInfo.fuelLevel * 100) + "%"
                color: systemInfo.fuelLevel < 0.2 ? "#EF4444" : textPrimary
                font.pixelSize: 13
            }
        }
    }

    // ── Main content area ─────────────────────────────────────────────────────
    StackLayout {
        id: stack
        anchors {
            top:    statusBar.bottom
            left:   parent.left
            right:  parent.right
            bottom: navBar.top
        }
        currentIndex: navBar.currentIndex

        ClusterView {}
        MediaView   {}
        ClimateView {}
    }

    // ── Navigation bar ────────────────────────────────────────────────────────
    NavBar {
        id: navBar
        anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
        height: 64
        bgColor:      bgPanel
        accentColor:  accentBlue
        textColor:    textPrimary
        mutedColor:   textMuted
    }
}
