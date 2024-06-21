import QtQuick
import QtQuick.Controls.Basic
import Qml 1.0
import App 1.0

Item {
    property bool isSet: false

	width: cell.size(2).width
	height: cell.size(2).height

    function set(songPosition, overviewPosition, waveformPosition) {
        isSet = true
		Controller.setCue(songPosition)
        waveforms.overview.cueLine.x = overviewPosition
        waveforms.waveform.cueLine.x = waveformPosition
    }

    function trigger() {
		Controller.triggerCue()
        if (loop.isActive) loop.clear()
        if (!playback.isPlaying) transport.playPause()
    }

    function clear() { isSet = false }

	onIsSetChanged: waveforms.overview.cueLine.visible = waveforms.waveform.cueLine.visible = isSet

    TransportButton {
        description: ["Set/Trigger cue. Right click to disable", "C"]
        anchors.fill: parent

		contentItem: Text {
			id: cue_text

			anchors.fill: parent
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
			color: isSet ? ColorPalette.colorF : ColorPalette.color1
			font.family: bold_font.name
			font.pixelSize: fontSize - 2
			text: "CUE"
		}

		onClicked: isSet
            ? trigger()
            : set(
                waveforms.overview.songPositionPercentage,
                waveforms.overview.nowLine.x,
                waveforms.waveform.position
            )
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton

        onClicked: { clear() }
    }
}