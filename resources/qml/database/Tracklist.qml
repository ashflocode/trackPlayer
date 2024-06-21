import QtQuick
import Qml 1.0
import App 1.0

Item {
	width: database.width - playlist.width
	height: database.height

	property int tracksPerWindow: 10
	property int entrySize: height / tracksPerWindow

	FilterBar { id: filter_bar }

	ListView {
		id: listView

		model: Controller.tracklist
		width: tracklist.width
		height: tracklist.height - entrySize
		anchors.top: filter_bar.bottom
		anchors.topMargin: -1 // removes clipping edge
		clip: true

		delegate: Rectangle {
			width: listView.width
			height: entrySize
			color: track_mouse_area.containsMouse && !isSelected
				? ColorPalette.color6
				: isSelected ? ColorPalette.color3 : "transparent"

			MouseArea {
				id: track_mouse_area

				anchors.fill: parent
				hoverEnabled: true

				onDoubleClicked: track_loader.openTrack(path)
			}

			Row {
				Field {
					id: track_index

					width: entrySize
					color: track_index_mouse_area.containsMouse ? "red" : "transparent"
					textBox {
						horizontalAlignment: Text.AlignHCenter
						text: track_index_mouse_area.containsMouse ? "X" : index + 1
						elide: Text.ElideNone
					}

					MouseArea {
						id: track_index_mouse_area

						anchors.fill: parent
						hoverEnabled: true
						onClicked: Controller.tracklist.removeTrack(path)
					}
				}

				Repeater {
					model: metadata.length

					Field {
						width: (listView.width - track_index.width) / metadata.length
						textBox.text: metadata[modelData]
					}
				}
			}
		}
	}

	DropArea {
		anchors.fill: parent

		onDropped: (drop) => { Controller.tracklist.getTrackData(drop.urls) }
	}
}
