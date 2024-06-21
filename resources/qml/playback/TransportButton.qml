import QtQuick
import QtQuick.Controls.Basic
import Qml 1.0
import App 1.0

Button {
	property alias buttonBackground: button_background

	property var description
	property var margin: gSpacing

	padding: gSpacing
	enabled: Controller.trackLoaded
	opacity: enabled ? 1 : 0.5
	palette.buttonText: ColorPalette.color1
	font {
		family: bold_font.name
		pixelSize: fontSize + 2
		bold: true
	}

	icon {
		width: -1
		height: -1
		color: ColorPalette.color1
	}

	background: Rectangle {
		id: button_background

		anchors.fill: parent
		anchors.margins: margin
		color: Controller.trackLoaded
			? down
				? ColorPalette.color8
				: (hovered && enabled && !settings_button.isActive)
					? ColorPalette.color7
					: ColorPalette.color6
			: ColorPalette.color6
	}

	onHoveredChanged: information_popup.hover(this, hovered)
}