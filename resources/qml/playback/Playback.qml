import QtQuick

Timer {
    property bool isPlaying: false

    interval: 1
    running: isPlaying
    repeat: true
    onTriggered: () => {
        if (waveforms.waveform.atTrackEnd && !waveforms.overview.isScrubbing) {
			if (settings.continuousPlayback.isEnabled && Controller.tracklist.nextTrackPath()) {
				track_loader.openTrack(Controller.tracklist.nextTrackPath())
			} else {
				Controller.stop()
				isPlaying = false
			}
        }

        return [
            playback_length.text = Controller.setPlaybackLength(),
            waveforms.overview.playback(),
            waveforms.waveform.playback()
        ]
    }
}
