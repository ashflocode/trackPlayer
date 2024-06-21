import QtQuick
import QtQuick.Window
import Qml 1.0

Item {
    id: main_window

    Component.onCompleted: {
        width = Controller.windowSize.width
        height = Controller.windowSize.height
    }

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

		TrackLoader { id: track_loader }
		Transport { id: transport }

        Item {
			id: track_info

            width: parent.width - transport.width - gMargin
			height: parent.height / 2
			anchors.right: parent.right

            Grid {
                id: metadata_window

				property var metadataText: ({})
				property var metadataEdit: ({})

				anchors.fill: parent
				rows: 6

				Cell { id: cell }
				Row {
					MainText { id: file_name }
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
							model: Controller.tracklist.metadataFields.length
							Metadata { id: metadata }
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
		SelectTrackOverlay { id: select_track_overlay }
    }
	Database { id: database }
	Settings { id: settings }
	InformationPopup { id: information_popup }
	GeneralPopup { id: popup }
}
