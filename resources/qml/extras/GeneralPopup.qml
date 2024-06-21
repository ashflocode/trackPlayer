import QtQuick
import QtQuick.Controls

Popup {
    width: parent.width / 3
    height: parent.height / 3
    anchors.centerIn: parent

    background: Rectangle {
        anchors.fill: parent
        color: ColorPalette.color3
    }

    function show(text) {
        text_box.text = text
        open()
    }

	MainText {
        id: text_box

		anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
    }

    MouseArea {
        anchors.fill: parent
        onClicked: { close() }
    }
}
