import QtQuick
import QtQuick.Controls.Basic
import Qml 1.0
import App 1.0

Item {
	readonly property var buttonStateOptions: ["IN", "ON", "LOOP"]
	property int loopState: 2
	property bool inProgress: loopState === 0
	property bool isActive: loopState !== 2
	property double overviewLoopInPosition
	property double waveformLoopInPosition

	width: cell.size(2, 2).width
	height: cell.size(2, 2).height

	function trigger() {
		loopState = (loopState + 1) % 3

		switch (loopState) {
			case 0: Controller.loopIn(); break
			case 1: Controller.loopOut(); break
			case 2: Controller.clearLoop(); break
		}
	}

	function clear() {
		if (loopState === 2) return
		loopState = 2
		Controller.clearLoop()
	}

	onLoopStateChanged: {
		const visible = loopState !== 2

		waveforms.overview.loopBox.visible = waveforms.waveform.loopBox.visible = visible
		if (!visible) waveforms.overview.loopBox.width = waveforms.waveform.loopBox.width = 0
		if (loopState === 0) {
			overviewLoopInPosition = waveforms.overview.loopBox.x = waveforms.overview.nowLine.x
			waveformLoopInPosition = waveforms.waveform.loopBox.x = waveforms.waveform.position
		}
	}

	TransportButton {
		description: ["Set in/out position during playback. Right click to disable", "L"]
		anchors.fill: parent
		onClicked: trigger()

		Text {
			anchors.fill: parent
			horizontalAlignment: Text.AlignHCenter
			topPadding: gSpacing

			text: buttonStateOptions[loopState]
			color: loopState === 2
				? ColorPalette.color1
				: ColorPalette.colorF

			font.family: bold_font.name
			font.pixelSize: fontSize - 2
		}

		component LoopIcon : Button {
			height: parent.height / 2
			width: parent.width / 2
			anchors.bottom: parent.bottom
			anchors.margins: gSpacing

			background: Item {}
			enabled: false
			padding: -1
			icon.source: "qrc:/images/loop"
		}

		LoopIcon {
			rotation: 180
			icon.color: loopState !== 2
				? ColorPalette.colorF
				: ColorPalette.color1
		}

		LoopIcon {
			anchors.right: parent.right
			icon.color: loopState === 1
				? ColorPalette.colorF
				: ColorPalette.color1
		}
	}

	MouseArea {
		anchors.fill: parent
		acceptedButtons: Qt.RightButton
		onClicked: clear()
	}
}
