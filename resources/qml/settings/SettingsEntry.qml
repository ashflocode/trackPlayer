import QtQuick
import Qml 1.0

Item {
	property alias title: title

    property int entriesPerWindow: 14

	width: settings_window.width - gMargin * 4
	height: settings_window.height / entriesPerWindow
    anchors.horizontalCenter: parent.horizontalCenter

	MainText {
		id: title

		width: parent.width / 2
		height: parent.height
	}
}
