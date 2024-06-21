import QtQuick
import Qml 1.0

Text {
    objectName: "SelectTrackOverlay"

	anchors.centerIn: waveforms
    font.family: bold_font.name
    font.pixelSize: fontSize * 2
    color: ColorPalette.colorF
	visible: true

    text: "SELECT TRACK"
}