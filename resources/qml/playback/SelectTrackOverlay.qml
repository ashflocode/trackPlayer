import QtQuick
import QtCore
import QtQuick.Dialogs
import Qml 1.0
import App 1.0

Item {
	anchors.fill: parent
	visible: !Controller.trackLoaded

	MouseArea {
		enabled: !edit.isActive
		anchors.fill: parent

		onClicked: { file_dialog.open() }
	}

	FileDialog {
		id: file_dialog

		visible: false
		fileMode: FileDialog.OpenFile
		selectedFile: StandardPaths.standardLocations(StandardPaths.MusicLocation)[0]
		nameFilters: { Controller.validFormats.join(" ") }
		onAccepted: { track_loader.openTrack(selectedFile) }
	}

	Text {
		visible: true
		color: ColorPalette.colorF
		text: "SELECT TRACK"
		anchors {
			horizontalCenter: parent.horizontalCenter
			top: parent.top
			topMargin: parent.height * 0.7
		}
		font {
			family: bold_font.name
			pixelSize: fontSize * 2
		}
	}
}