import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import App 1.0

Item {
    objectName: "Transport"

	width: cell.size(5).width
	height: cell.dynamicSize().height

	property var unicode: ({
		backArrow: "\u003C",
		tab: "\u21E5",
		enter: "\u23CE",
		spaceBar: "\u2423",
	})

    function trackStart() {
		Controller.reset()
        waveforms.overview.nowLine.x = 0
        waveforms.waveform.waveformImage.x = waveforms.waveform.nowLinePosition
        if (loop.isActive) loop.clear()
    }

    function eject() {
		Controller.eject()
		if (edit.isActive) edit.save()
		loop.clear()
		cue.clear()
		delay.reset()
		filter.reset()
    }

    function stop() {
		Controller.stop()
        playback.isPlaying = false
        waveforms.overview.nowLine.x = 0
        waveforms.waveform.waveformImage.x = waveforms.waveform.nowLinePosition
        if (loop.isActive) loop.clear()
    }

    function playPause() {
        playback.isPlaying
            ? Controller.pause()
            : Controller.play()

        playback.isPlaying = !playback.isPlaying
    }

	Column {
		Row {
			TransportButton {
				description: ["Set playhead to track start", transport.unicode.backArrow]
				width: cell.size(2.5, 2).width
				height: cell.size(2.5, 2).height
				margin: gSpacing / 2
				icon.source: "qrc:/images/trackStart"
				onClicked: { trackStart() }
			}

			TransportButton {
				description: ["Eject track", transport.unicode.tab]
				width: cell.size(2.5, 2).width
				height: cell.size(2.5, 2).height
				margin: gSpacing / 2
				icon.source: "qrc:/images/eject"
				onClicked: { eject() }
			}
		}

		TransportButton {
			description: ["Stop track at track start", transport.unicode.enter]
			width: cell.size(5, 2).width
			height: cell.size(5, 2).height
			margin: gSpacing / 2
			icon.source: "qrc:/images/stop"
			onClicked: { stop() }
		}

		TransportButton {
			description: ["Play/Pause track", transport.unicode.spaceBar]
			width: cell.size(5, 2).width
			height: cell.size(5, 2).height
			margin: gSpacing / 2
			icon.source: playback.isPlaying ? "qrc:/images/pause" : "qrc:/images/play"
			onClicked: { playPause() }
		}
	}
}
