import QtQuick
import App 1.0

Image {
    objectName: "Artwork"

	width: cell.size(5, 5).width - gSpacing / 2
	height: cell.size(5, 5).height - gSpacing / 2
	opacity: Controller.trackLoaded ? 1 : 0.5
	cache: false
	source: Controller.trackLoaded
		? `image://ImageProvider/${Controller.filename}`
		: "qrc:/images/artwork"
}