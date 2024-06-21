import QtQuick
import App 1.0

Item {
    focus: true

    Keys.onPressed: (event) => {
        switch(event.key) {
            // transport buttons
            case Qt.Key_Left:
                transport.trackStart()
                break
            case Qt.Key_Tab:
                transport.eject()
                break
            case Qt.Key_Return:
                edit.isActive
                    ? edit.save()
                    : transport.stop()
                break
            case Qt.Key_Space:
                transport.playPause()
                break

            // time elapsed
            case Qt.Key_T:
                playback_length.toggle()
                break

            // edit button
            case Qt.Key_E:
                if (edit.enabled) edit.trigger()
                break

            // loop button
            case Qt.Key_L:
                loop.trigger()
                break

            // Settings button
            case Qt.Key_S:
                settings_button.trigger()
                break

            // Information button
            case Qt.Key_I:
                information_button.trigger()
                break

            // scrub
            case Qt.Key_0:
                waveforms.overview.scrubArea.moveNowLine(
                    0,
                    true
                )
                break
            case Qt.Key_1:
                waveforms.overview.scrubArea.moveNowLine(
                    waveforms.overview.width * 0.1,
                    true
                )
                break
            case Qt.Key_2:
                waveforms.overview.scrubArea.moveNowLine(
                    waveforms.overview.width * 0.2,
                    true
                )
                break
            case Qt.Key_3:
                waveforms.overview.scrubArea.moveNowLine(
                    waveforms.overview.width * 0.3,
                    true
                )
                break
            case Qt.Key_4:
                waveforms.overview.scrubArea.moveNowLine(
                    waveforms.overview.width * 0.4,
                    true
                )
                break
            case Qt.Key_5:
                waveforms.overview.scrubArea.moveNowLine(
                    waveforms.overview.width * 0.5,
                    true
                )
                break
            case Qt.Key_6:
                waveforms.overview.scrubArea.moveNowLine(
                    waveforms.overview.width * 0.6,
                    true
                )
                break
            case Qt.Key_7:
                waveforms.overview.scrubArea.moveNowLine(
                    waveforms.overview.width * 0.7,
                    true
                )
                break
            case Qt.Key_8:
                waveforms.overview.scrubArea.moveNowLine(
                    waveforms.overview.width * 0.8,
                    true
                )
                break
            case Qt.Key_9:
                waveforms.overview.scrubArea.moveNowLine(
                    waveforms.overview.width * 0.9,
                    true
                )
                break

			// Playlist
			case Qt.Key_P:
				Controller.playlist.add()
				break
        }
    }
}
