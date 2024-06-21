import QtQuick
import QtCore
import QtQuick.Dialogs
import QtQuick.Controls
import App 1.0

Item {
    objectName: "TrackSelector"

    anchors.fill: parent

	Component.onCompleted: { openTrack("file:///Users/aevans/Music/ASHFLO - Broken Remix_MOCK.mp3") } // TESTING PURPOSES ONLY

    function openTrack(file) {
        if (!Controller.isValidFormat(file)) {
			popup.show("File format not supported!")
			return
		}

		Controller.load(file)

		playback.isPlaying = Controller.continuousPlayback
        if (loop.isActive) loop.clear()
        waveforms.overview.nowLine.x = 0
        waveforms.waveform.waveformImage.x = waveforms.waveform.nowLinePosition
    }

	DropArea {
		enabled: !edit.isActive
		anchors.fill: parent

		onDropped: (drop) => { openTrack(drop.urls[0]) }
	}
}