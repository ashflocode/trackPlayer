import QtQuick
import Qml 1.0

Rectangle {
	property alias textBox: text_box

	height: tracklist.height / tracksPerWindow
	color: "transparent"

	Text {
		id: text_box

		anchors.fill: parent
		verticalAlignment: Text.AlignVCenter
		padding: gMargin
		font.family: regular_font.name
		font.pixelSize: fontSize
		color: ColorPalette.colorF
		elide: Text.ElideRight
	}
}
