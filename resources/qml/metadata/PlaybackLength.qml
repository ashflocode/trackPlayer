import QtQuick
import Qml 1.0

MainText {
    objectName: "PlaybackLength"

    property var description: ["Toggle between remaining/elapsed", "T"]

	width: cell.size(3).width
    horizontalAlignment: Text.AlignRight

    function toggle() {
		Controller.toggleLengthState()
        playback_length.text = Controller.setPlaybackLength()
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onClicked: { toggle() }

        onContainsMouseChanged: information_popup.hover(parent, containsMouse)
    }
}
