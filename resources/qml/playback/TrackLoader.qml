import QtQuick
import QtCore
import QtQuick.Dialogs
import QtQuick.Controls

Item {
    objectName: "TrackSelector"

    property alias fileDialog: file_dialog

    property bool trackOnDeck: false
	property bool continuousEnabled: settings.continuousPlayback.isEnabled
    property string extension: ""
	property var validFiles: ["*.mp3", "*.wav", "*.flac", "*.aiff"]

    anchors.fill: parent

	Component.onCompleted: { openTrack("file:///Users/aevans/Music/ASHFLO - Broken Remix_MOCK.mp3") } // TESTING PURPOSES ONLY

    Connections {
        target: Controller
        ignoreUnknownSignals: true

		function onTrackLoadedChanged() {
			playback_length.text = Controller.setPlaybackLength()
			select_track_overlay.visible = false
			track_loader.trackOnDeck = keyboard_controls.focus = true
		}

        function onMetadataChanged() {
            file_name.text = Controller.filename
			Controller.tracklist.metadataFields.forEach((label) => {
				metadata_window.metadataText[label].text = Controller[label]
			});
            artwork.source = `image://ImageProvider/${Controller.filename}`
        }

        function onWaveformLoadedChanged() {
            waveforms.waveform.waveformImage.source =
                waveforms.overview.waveformImage.source =
                    `image://ImageProvider/${Controller.filename}`
            waveforms.visible = true
			if (continuousEnabled) Controller.play()
        }
    }

    function getMetadata(file) {
		Controller.getMetadata(file, Controller.playlist.current, true)
		const isMP3 = extension === "*.mp3"
        edit.enabled = isMP3
        settings.lockEditor.disable(isMP3)
    }

    function openTrack(file) {
		extension = "*." + file.toString().split(".").pop().toLowerCase()
        if (!validFiles.includes(extension)) {
			popup.show("File format not supported!")
			return
		}
		waveforms.waveform.waveformImage.source =
			waveforms.overview.waveformImage.source = ""
		Controller.load(file)
        getMetadata(file)
		Controller.getWaveform()
        playback.isPlaying = continuousEnabled
        if (loop.isActive) loop.clear()
        waveforms.overview.nowLine.x = 0
        waveforms.waveform.waveformImage.x = waveforms.waveform.nowLinePosition
    }

    MouseArea {
        enabled: !edit.isActive
        anchors.fill: parent

        onClicked: { if (!trackOnDeck) file_dialog.open() }
    }

	DropArea {
		enabled: !edit.isActive
		anchors.fill: parent

		onDropped: (drop) => { openTrack(drop.urls[0]) }
	}

    FileDialog {
        id: file_dialog

        visible: false
        fileMode: FileDialog.OpenFile
        selectedFile: StandardPaths.standardLocations(StandardPaths.MusicLocation)[0]
        nameFilters: { validFiles.join(" ") }
        onAccepted: { openTrack(selectedFile) }
    }
}