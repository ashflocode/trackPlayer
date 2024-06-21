import QtQuick
import Qml 1.0
import App 1.0

Item {
	width: database.width / 5
	height: database.height

	PlaylistBar { id: playlist_bar }

	ListView {
		id: playlistView

		model: Controller.playlist
		width: playlist.width
		height: playlist.height
		anchors.top: playlist_bar.bottom
		clip: true

		delegate: Field {
			width: playlist_bar.width
			height: playlist_bar.height

			color: isSelected ? ColorPalette.color3 : "transparent"

			TextInput {
				id: text_box

				anchors.fill: parent
				verticalAlignment: Text.AlignVCenter
				padding: gMargin
				font.family: regular_font.name
				font.pixelSize: fontSize
				color: mouse_area.containsMouse || isSelected ? ColorPalette.colorF : ColorPalette.color8
				selectionColor: ColorPalette.color6
				maximumLength: 12
				text: name

				onEditingFinished: {
					Controller.playlist.rename(text)
					keyboard_controls.focus = true
				}
			}

			MouseArea {
				id: mouse_area

				anchors.fill: parent
				hoverEnabled: true

				onClicked: {
					Controller.playlist.select(name)
					keyboard_controls.focus = true
				}

				onDoubleClicked: {
					Controller.playlist.startRename()
					text_box.forceActiveFocus()
					text_box.selectAll()
				}
			}

			Field {
				id: remove_playlist

				property var description: ["Remove playlist", ""]
				property real size: playlist_bar.height

				width: size
				height: size
				anchors.right: parent.right
				opacity: 0
				textBox {
					horizontalAlignment: Text.AlignHCenter
					color: "red"
					text: "X"
				}

				MouseArea {
					anchors.fill: parent
					hoverEnabled: true

					onContainsMouseChanged: {
						remove_playlist.opacity = containsMouse ? 1 : 0
						information_popup.hover(parent, containsMouse)
					}

					onClicked: { Controller.playlist.remove(name) }
				}
			}
		}
	}

	DropArea {
		anchors.fill: parent

		onDropped: (drop) => {
			Controller.playlist.add()
			Controller.tracklist.getTrackData(drop.urls)
		}
	}

	SplitLine { orientation: SplitLine.Vertical }
}