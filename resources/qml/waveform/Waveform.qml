import QtQuick
import Qml 1.0
import App 1.0

WaveformBase {
    objectName: "Waveform"

    property alias scrubArea: scrub_area

    property double position: Math.abs(waveformImage.x - nowLinePosition)
    property double nowLinePosition: parent.width / 8
    property double songPositionPercentage: position / width
    property double waveformZoomState: settings.waveformZoomSlider.value / settings.waveformZoomSlider.to
    property double waveformWidthBase: parent.width * waveformImage.waveformResolution
    property double waveformZoomSize: waveformWidthBase * waveformZoomState
    property bool atTrackEnd: position + nowLine.width >= width

    anchors.bottom: parent.bottom
    width: waveformWidthBase + waveformZoomSize
    height: parent.height * .85
    background.gradient: Gradient {
        GradientStop { position: 0.0; color: "transparent" }
        GradientStop { position: 0.5; color: ColorPalette.color1 }
        GradientStop { position: 1.0; color: "transparent" }
    }
    waveformImage.x: nowLinePosition
    nowLine.x: nowLinePosition

    function playback() {
        if (!isScrubbing) waveformImage.x = nowLinePosition
            - width / Controller.songLength * Controller.getPlayPositionInMs()
        if (loop.inProgress) loopBox.width = position + nowLine.width - loop.waveformLoopInPosition
    }

    MouseArea {
        id: scrub_area

        anchors.fill: parent
        drag {
			target: waveformImage
			axis: Drag.XAxis
			minimumX: -(waveformImage.width - nowLinePosition)
			maximumX: parent.width - (waveformImage.width - nowLinePosition)
		}

        function scrub() {
            if (loop.inProgress || loop.isActive) loop.clear()
			Controller.scrub(songPositionPercentage)
            waveforms.overview.nowLine.x = position / width * waveforms.overview.width
        }

        onPressed: { parent.isScrubbing = true }
        onPositionChanged: { scrub() }
        onReleased: { parent.isScrubbing = false }
    }
}