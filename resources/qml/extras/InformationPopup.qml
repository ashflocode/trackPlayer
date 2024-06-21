import QtQuick

Rectangle {
	property var owner: null

    width: parent.width / 4
    height: parent.height / 4
    color: ColorPalette.color3
    visible: false
	bottomRightRadius: gMargin
	topLeftRadius: gMargin
	anchors {
		bottom: parent.bottom
		right: parent.right
		margins: gMargin
	}

	function hover(item, hovered) {
		if (!information_button.isActive || settings_button.isActive) return
		if (hovered) {
			owner = item
			text_box.text = item.description[0]
			shortcut_box.text = item.description[1]
			visible = true
		} else {
			if (owner === item) {
				owner = null
				visible = false
			}
		}
	}

    component TextBox : Text {
        padding: gMargin
        wrapMode: Text.Wrap
        font.family: regular_font.name
        font.pixelSize: fontSize
        color: ColorPalette.colorF
        text: ""
    }

    TextBox {
        id: text_box

        anchors.fill: parent
    }

    TextBox {
        id: shortcut_box

        anchors.bottom: parent.bottom
        anchors.right: parent.right
    }
}
