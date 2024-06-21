import QtQuick
import QtQuick.Controls.Basic
import Qml 1.0
import App 1.0

Button {
	id: toolBar_button

	property var buttonTypes: ["settings", "info"]
	property string buttonType
    property bool isActive: false

	width: cell.size().width
	height: cell.size().height
    enabled: Controller.trackLoaded
    background: Item {}
	padding: 0
	opacity: enabled
		? buttonType === buttonTypes[0]
			? isActive ? 0.5 : 1
			: isActive ? 1 : 0.5
		: 0.25
	icon {
		width: parent.width
		height: parent.height
		color: ColorPalette.colorF
		source: buttonType === buttonTypes[0]
			? "qrc:/images/settings"
			: "qrc:/images/info"
	}

	function trigger() { isActive = !isActive }

    onClicked: { trigger() }
}