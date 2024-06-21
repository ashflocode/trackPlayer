import QtQuick
import Qml 1.0

TransportButton {
    objectName: "Edit"

    description: ["Edit track metadata. Saves changes when disabled", "E"]
    property bool isActive: false

	width: cell.size(2, 2).width
	height: cell.size(2, 2).height
    opacity: enabled ? 1 : .5
	hoverEnabled: enabled

    icon.source: "qrc:/images/edit"

    function trigger() {
        if (isActive) { save(); return }
		isActive = !isActive
        icon.color = ColorPalette.colorF
		Controller.tracklist.metadataFields.forEach((label) => {
			metadata_window.metadataEdit[label].textBox.text = Controller[label]
        });
    }

    function save() {
		isActive = !isActive
        icon.color = ColorPalette.color1

		let editedMetadata = Controller.tracklist.metadataFields.map(label =>
			metadata_window.metadataEdit[label].textBox.text
		);
		Controller.setMetadata(editedMetadata, database.playlist.selectedPlaylist)
    }

	onClicked: { trigger() }
}