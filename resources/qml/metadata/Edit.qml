import QtQuick
import Qml 1.0
import App 1.0

TransportButton {
    objectName: "Edit"

    description: ["Edit track metadata. Saves changes when disabled", "E"]
    property bool isActive: false

	width: cell.size(2, 2).width
	height: cell.size(2, 2).height
    opacity: enabled ? 1 : .5
	hoverEnabled: enabled
    icon{
		source: "qrc:/images/edit"
		color: isActive ? ColorPalette.colorF : ColorPalette.color1
	}
	enabled: Controller.isMp3 && Controller.trackLoaded

    function trigger() {
        if (isActive) save()
		isActive = !isActive
    }

    function save() {
		Controller.setMetadata(
			Controller.tracklist.metadataFields.map((_, i) => metadata.itemAt(i)?.editedText),
			Controller.playlist.current
		)
    }

	onClicked: { trigger() }
}