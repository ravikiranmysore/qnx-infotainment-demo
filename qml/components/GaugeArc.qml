import QtQuick 2.15

Item {
    id: root

    property real   value     : 0
    property real   maxValue  : 100
    property color  arcColor  : "#3A8FD9"
    property string label     : ""
    property string valueText : "0"

    readonly property real startAngle: 220   // degrees from 3-o'clock, clockwise
    readonly property real sweepAngle: 280

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);

            var cx  = width  / 2;
            var cy  = height / 2;
            var r   = Math.min(width, height) / 2 - 12;
            var lw  = 10;

            // Helper: degrees → radians (canvas 0 = 3 o'clock)
            function toRad(deg) { return (deg - 90) * Math.PI / 180; }

            var sRad = toRad(-(sweepAngle / 2) + 90);  // start at bottom-left
            var eRad = toRad( (sweepAngle / 2) + 90);  // end  at bottom-right

            // Track
            ctx.beginPath();
            ctx.arc(cx, cy, r, sRad, eRad);
            ctx.strokeStyle = "#2A2F3E";
            ctx.lineWidth   = lw;
            ctx.lineCap     = "round";
            ctx.stroke();

            // Fill arc
            var ratio   = Math.min(1.0, value / maxValue);
            var fillEnd = sRad + ratio * (eRad - sRad);
            ctx.beginPath();
            ctx.arc(cx, cy, r, sRad, fillEnd);
            ctx.strokeStyle = root.arcColor;
            ctx.lineWidth   = lw;
            ctx.lineCap     = "round";
            ctx.stroke();

            // Inner glow dot at tip
            if (ratio > 0.01) {
                var tipX = cx + r * Math.cos(fillEnd);
                var tipY = cy + r * Math.sin(fillEnd);
                ctx.beginPath();
                ctx.arc(tipX, tipY, lw / 2 + 2, 0, 2 * Math.PI);
                ctx.fillStyle = Qt.lighter(root.arcColor, 1.4).toString();
                ctx.fill();
            }
        }
    }

    // Repaint whenever value changes
    onValueChanged: canvas.requestPaint()

    // Value label
    Column {
        anchors.centerIn: parent
        spacing: 2

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text:  root.valueText
            color: "#E8ECF0"
            font { pixelSize: 36; bold: true }
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text:  root.label
            color: root.arcColor
            font { pixelSize: 12; letterSpacing: 1 }
        }
    }
}
