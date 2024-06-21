import QtQuick

Image {
    objectName: "Artwork"

	width: cell.size(5, 5).width - gSpacing / 2
	height: cell.size(5, 5).height - gSpacing / 2
	opacity: track_loader.trackOnDeck ? 1 : 0.5
	cache: false
	source: "qrc:/images/artwork"
}