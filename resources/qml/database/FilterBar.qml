import QtQuick
import Qml 1.0
import App 1.0

Row {
	Field {
		id: filter_index

		width: entrySize
		textBox {
			horizontalAlignment: Text.AlignHCenter
			text: "#"
		}

		SplitLine { orientation: SplitLine.Horizontal }
	}

	Repeater {
		model: Controller.tracklist.metadataFields.length

		Field {
			property var description: [`Order by ${textBox.text}${isSelected ? ". Click arrow to toggle ascending/descending" : ""}`, ""]
			property bool isSelected: Controller.tracklist.currentFilter === Controller.tracklist.metadataFields[model.index]

			width: (tracklist.width - filter_index.width) / Controller.tracklist.metadataFields.length
			color: isSelected ? ColorPalette.color3 : "transparent"
			textBox {
				color: mouse_area.containsMouse || isSelected ? ColorPalette.colorF : ColorPalette.color8
				text: {
					const str = Controller.tracklist.metadataFields[model.index]
					return str.charAt(0).toUpperCase() + str.slice(1)
				}
			}

			Image {
				id: order_icon

				property real size: parent.height

				width: size
				height: size
				visible: isSelected
				anchors.right: parent.right
				source: "qrc:/images/order"
				transform: Rotation {
					angle: Controller.tracklist.alphabetical ? 0 : 180
					origin.x: order_icon.width / 2
					origin.y: order_icon.height / 2
				}
			}

			MouseArea {
				id: mouse_area

				anchors.fill: parent
				hoverEnabled: true

				onClicked: Controller.tracklist.reorder(Controller.tracklist.metadataFields[model.index])
				onContainsMouseChanged: information_popup.hover(parent, containsMouse)
			}

			SplitLine { orientation: SplitLine.Horizontal }
		}
	}
}
