import QtQuick
import Qml 1.0
import App 1.0

MainText {
    objectName: "PlaybackLength"

    property var description: ["Toggle between remaining/elapsed", "T"]

	width: cell.size(3).width
    horizontalAlignment: Text.AlignRight
	text: Controller.playlength

    function toggle() { Controller.toggleLengthState() }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onClicked: { toggle() }

        onContainsMouseChanged: information_popup.hover(parent, containsMouse)
    }
}
