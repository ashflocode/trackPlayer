import QtQuick
import Qml 1.0
import App 1.0

Item {
	width: playlist.width
	height: playlist.height / tracklist.tracksPerWindow

	Item {
		anchors.left: parent.left
		anchors.right: addPlaylist.left
		height: playlist_bar.height

		MainText {
			anchors.fill: parent
			anchors.margins: gMargin
			verticalAlignment: Text.AlignVCenter
			text: Controller.database.mainTable
		}

		MouseArea {
			anchors.fill: parent
			onClicked: Controller.playlist.select(Controller.database.mainTable)
		}
	}

	Item {
		id: addPlaylist

		width: playlist_bar.height
		height: playlist_bar.height
		anchors.right: parent.right

		Image {
			anchors.fill: parent
			anchors.margins: gSpacing
			source: "qrc:/images/addPlaylist"
		}

		MouseArea {
			anchors.fill: parent
			hoverEnabled: true

			onClicked: Controller.playlist.add()
			onContainsMouseChanged: information_popup.hover(parent, containsMouse)
		}
	}
}
