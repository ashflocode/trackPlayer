import QtQuick
import QtQuick.Window
import Qml 1.0
import App 1.0

Item {
    id: main_window

	width: Controller.windowSize.width
	height: Controller.windowSize.height

    // FONT
    FontLoader { id: regular_font; source: "qrc:/fonts/regular" }
    FontLoader { id: bold_font; source: "qrc:/fonts/bold" }
    property int fontSize: 13

	// LAYOUT
	property int gMargin: 5
	property int gSpacing: 2

    Rectangle {
        id: background

        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: ColorPalette.color1 }
            GradientStop { position: 0.5; color: ColorPalette.color5 }
        }
    }

    KeyboardControls { id: keyboard_controls }
    Playback { id: playback }

    Item {
        id: deck

		anchors {
			top: parent.top
			left: parent.left
			right: parent.right
			margins: gMargin
		}
		height: parent.height / 2
        clip: true

		Transport { id: transport }

        Item {
			id: track_info

            width: parent.width - transport.width - gMargin
			height: parent.height / 2
			anchors.right: parent.right

            Grid {
                id: metadata_window

				anchors.fill: parent
				rows: 6

				Cell { id: cell }
				Row {
					MainText {
						id: file_name
						text: Controller.filename
					}
					PlaybackLength { id: playback_length }
					ToolBarButton { id: settings_button
						buttonType: "settings"
					}
					ToolBarButton { id: information_button }
				}
				Row {
					Artwork { id: artwork }
					Column {
						Repeater {
							id: metadata
							model: Controller.tracklist.metadataFields
							Metadata {}
						}
					}
					Column {
						topPadding: cell.size(2).height

						Delay { id: delay }
						Filter { id: filter }
					}
					Column {
						Edit { id: edit }
						Cue { id: cue }
						Loop { id: loop }
					}
				}
            }
        }
        Waveforms { id: waveforms }
		TrackLoader { id: track_loader }
		SelectTrackOverlay { id: select_track_overlay }
    }
	Database { id: database }
	Settings { id: settings }
	InformationPopup { id: information_popup }
	GeneralPopup { id: popup }
}
