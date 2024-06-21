import QtQuick
import QtQuick.Controls.Basic
import Qml 1.0

Button {
    width: parent.width / 5
	height: parent.height
	anchors {
		top: parent.top
		right: parent.right
		bottom: parent.bottom
	}
	palette.buttonText: ColorPalette.colorF
    font.family: regular_font.name
    font.pixelSize: fontSize - 2
    background: Item {}
}