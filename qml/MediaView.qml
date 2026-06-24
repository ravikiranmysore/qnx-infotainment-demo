import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    id: root

    readonly property color bgCard     : "#1C2030"
    readonly property color accentBlue : "#3A8FD9"
    readonly property color textPrimary: "#E8ECF0"
    readonly property color textMuted  : "#6B7280"

    RowLayout {
        anchors { fill: parent; margins: 24 }
        spacing: 24

        // ── Album art placeholder ──────────────────────────────────────────────
        Rectangle {
            Layout.preferredWidth: parent.height - 16
            Layout.fillHeight: true
            color: bgCard
            radius: 12

            Rectangle {
                anchors { fill: parent; margins: 20 }
                radius: 8
                color: "#252A3A"

                // Vinyl disc animation
                Rectangle {
                    id: disc
                    anchors.centerIn: parent
                    width: Math.min(parent.width, parent.height) - 20
                    height: width
                    radius: width / 2
                    color: "#0D0F14"

                    Rectangle {
                        anchors.centerIn: parent
                        width: parent.width * 0.3
                        height: width
                        radius: width / 2
                        color: accentBlue
                        opacity: 0.6
                    }

                    Rectangle {
                        anchors.centerIn: parent
                        width: 12; height: 12
                        radius: 6
                        color: "#0D0F14"
                    }

                    RotationAnimator on rotation {
                        from: 0; to: 360
                        duration: 4000
                        loops: Animation.Infinite
                        running: media.playing
                    }
                }
            }
        }

        // ── Track info + controls ──────────────────────────────────────────────
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: bgCard
            radius: 12

            Column {
                anchors { fill: parent; margins: 24 }
                spacing: 0

                // Track & artist
                Text {
                    width: parent.width
                    text:  media.trackTitle
                    color: textPrimary
                    font { pixelSize: 28; bold: true }
                    elide: Text.ElideRight
                    Behavior on text { PropertyAnimation { duration: 200 } }
                }

                Text {
                    width: parent.width
                    text:  media.artist
                    color: accentBlue
                    font { pixelSize: 16 }
                    topPadding: 4
                }

                Item { height: 32; width: 1 }

                // Playback progress bar (decorative / simulated)
                Rectangle {
                    width: parent.width; height: 4; radius: 2
                    color: "#2A2F3E"

                    Rectangle {
                        id: progressFill
                        height: parent.height; radius: parent.radius
                        color: accentBlue
                        width: parent.width * progress.value

                        NumberAnimation on width {
                            id: progressAnim
                            from: 0; to: parent.parent.width
                            duration: 200000   // 3.3 min track length
                            running: media.playing
                            loops: Animation.Infinite
                        }
                    }
                }

                // Hidden slider helper
                Item { id: progress; property real value: 0 }

                Item { height: 32; width: 1 }

                // Transport controls
                Row {
                    spacing: 20

                    Repeater {
                        model: [
                            { label: "⏮",  action: "prev"      },
                            { label: media.playing ? "⏸" : "▶", action: "play" },
                            { label: "⏭",  action: "next"      }
                        ]

                        delegate: Rectangle {
                            width: 56; height: 56; radius: 28
                            color: modelData.action === "play" ? accentBlue : "#252A3A"

                            Text {
                                anchors.centerIn: parent
                                text:  modelData.label
                                font.pixelSize: modelData.action === "play" ? 22 : 18
                                color: textPrimary
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    if      (modelData.action === "play") media.playPause()
                                    else if (modelData.action === "next") media.nextTrack()
                                    else                                  media.prevTrack()
                                }
                            }
                        }
                    }
                }

                Item { height: 28; width: 1 }

                // Volume row
                Row {
                    spacing: 12
                    width: parent.width

                    Text {
                        text: "🔊"; font.pixelSize: 18
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Rectangle {
                        width: 200; height: 6; radius: 3
                        color: "#2A2F3E"
                        anchors.verticalCenter: parent.verticalCenter

                        Rectangle {
                            width: parent.width * (media.volume / 100)
                            height: parent.height; radius: parent.radius
                            color: accentBlue
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: media.volume = Math.round((mouseX / parent.width) * 100)
                        }
                    }

                    Text {
                        text: media.volume + "%"
                        color: textMuted; font.pixelSize: 13
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }
}
