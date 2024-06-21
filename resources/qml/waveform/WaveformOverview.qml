import QtQuick
import Qml 1.0
import App 1.0

WaveformBase {
    objectName: "WaveformOverview"

    property alias scrubArea: scrub_area

    property var description: ["Scrub through track", "0-9"]
    property double songPositionPercentage: nowLine.x / width
    property bool atTrackEnd: nowLine.x + nowLine.width >= width

    anchors.top: parent.top
    height: parent.height - parent.waveform.height - gMargin
    waveformImage.height: height * 2
    background.gradient: Gradient {
        GradientStop { position: 0; color: "transparent" }
        GradientStop { position: 1; color: ColorPalette.color1 }
    }

    function playback() {
        if (waveforms.waveform.isScrubbing
        || (atTrackEnd && !waveforms.waveform.atTrackEnd)) return
        if (!isScrubbing) nowLine.x = width / Controller.songLength * Controller.getPlayPositionInMs()
        if (loop.inProgress) loopBox.width = nowLine.x + nowLine.width - loop.overviewLoopInPosition
    }

    MouseArea {
        id: scrub_area

        anchors.fill: parent
        hoverEnabled: true
        drag {
			target: nowLine
			axis: Drag.XAxis
			minimumX: 0
			maximumX: width - nowLine.width
			smoothed: false
		}

        function moveNowLine(position, scrubTrack = false) {
            parent.isScrubbing = true;
            if (loop.inProgress || loop.isActive) loop.clear()
            nowLine.x = position
            if (scrubTrack) scrub()
        }

        function scrub() {
            if (atTrackEnd) transport.stop()
			Controller.scrub(songPositionPercentage)
            waveforms.waveform.waveformImage.x = waveforms.waveform.nowLinePosition
                - (nowLine.x / width * waveforms.waveform.width)
            parent.isScrubbing = false
        }

        onPressed: { moveNowLine(mouseX) }
        onReleased: { scrub() }
		onContainsMouseChanged: information_popup.hover(parent, containsMouse)
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton

        onClicked: if (cue.isSet) cue.set(
            mouseX / width,
            mouseX,
            Math.abs(mouseX / width * waveforms.waveform.width)
        )
    }
}