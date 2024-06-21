import QtQuick
import Qml 1.0
import App 1.0

Item {
	width: cell.dynamicSize([artwork, filter, edit]).width
	height: cell.size().height

	property alias editedText: metadata_edit.text

	Row {
		Text {
			id: metadata_label

			width: cell.size(2.5).width
			height: cell.size().height
			horizontalAlignment: Text.AlignRight
			verticalAlignment: Text.AlignVCenter
			color: ColorPalette.color5
			font {
				family: regular_font.name
				capitalization: Font.AllUppercase
				pixelSize: fontSize - 2
				bold: true
			}
			text: modelData + ": "
		}

		Text {
			id: metadata_text

			width: cell.dynamicSize([artwork, metadata_label, filter, edit]).width
			height: cell.size().height
			anchors.leftMargin: gSpacing
			verticalAlignment: Text.AlignVCenter
			font.family: bold_font.name
			font.pixelSize: fontSize
			color: ColorPalette.colorF
			elide: Text.ElideRight
			visible: !edit.isActive
			text: Controller[modelData]
		}

		Item {
			width: cell.dynamicSize([artwork, metadata_label, filter, edit]).width
			height: cell.size().height
			visible: edit.isActive

			Rectangle {
				id: background

				anchors {
					fill: parent
					topMargin: gSpacing
					bottomMargin: gSpacing
				}
				gradient: Gradient {
					orientation: Gradient.Horizontal
					GradientStop { position: 0; color: ColorPalette.colorF }
					GradientStop { position: 1; color: "transparent" }
				}
			}

			TextInput {
				id: metadata_edit

				anchors.fill: parent
				anchors.leftMargin: gSpacing
				verticalAlignment: Text.AlignVCenter
				font.family: bold_font.name
				font.pixelSize: fontSize
				color: ColorPalette.color1
				selectionColor: ColorPalette.color5
				maximumLength: 20
				text: Controller[modelData]

				onFocusChanged: { if(focus) selectAll() }
			}
		}
	}
}