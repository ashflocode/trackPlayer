import QtQuick

Text {
    objectName: "MainText"

	width: cell.dynamicSize([playback_length, settings_button, information_button]).width
	height: cell.size().height
    font.family: bold_font.name
    font.pixelSize: fontSize
    color: ColorPalette.colorF
    verticalAlignment: Text.AlignVCenter
    elide: Text.ElideRight
}