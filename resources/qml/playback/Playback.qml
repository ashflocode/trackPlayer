import QtQuick
import App 1.0

Timer {
    property bool isPlaying: false

    interval: 1
    running: isPlaying
    repeat: true
    onTriggered: () => {
        if (waveforms.waveform.atTrackEnd && !waveforms.overview.isScrubbing) {
			if (Controller.continuousPlayback && Controller.tracklist.nextTrackPath()) {
				track_loader.openTrack(Controller.tracklist.nextTrackPath())
			} else {
				Controller.stop()
				isPlaying = false
			}
        }

        return [
            Controller.setPlaybackLength(),
            waveforms.overview.playback(),
            waveforms.waveform.playback()
        ]
    }
}
