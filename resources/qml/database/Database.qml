import QtQuick

Item {
	anchors {
		top: deck.bottom
		left: parent.left
		bottom: parent.bottom
		right: parent.right
		margins: gMargin
	}

	Row {
		Playlist { id: playlist }
		Tracklist { id: tracklist }
	}
}