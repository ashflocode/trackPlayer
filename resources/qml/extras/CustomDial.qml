import QtQuick
import QtQuick.Controls.Basic
import Qml 1.0

TransportButton {
	property alias dialText: text

	property string title
	property var description
	property var buttonStateOptions
	property double startPosition: min
	property double currentPosition: startPosition
	property double previousPosition: startPosition
	property bool isActive: false
	property bool isEngaged: currentPosition !== startPosition
	property double min: -127
	property double max: 127
	signal engageEffect()
	signal clickAction()
	signal resetAudio()

	property double normalizedPosition: Math.min(1, Math.max(0, (currentPosition - min) / (max - min)))

	width: cell.size(2, 2).width
	height: cell.size(2, 2).height
	buttonBackground.radius: 180

	function reset() {
		resetAudio()
		previousPosition = currentPosition = startPosition
		dialText.text = title
		dialText.color = ColorPalette.color1
	}

	Rectangle {
		id: line

		visible: isEngaged
		anchors.horizontalCenter: parent.horizontalCenter
		height: parent.height / 2 - gSpacing
		width: 2
		y: gSpacing
		color: ColorPalette.colorF

		transform: Rotation {
			angle: currentPosition
			origin {
				x: line.width / 2
				y: height / 2 - gSpacing
			}
		}
	}

	Text {
		id: text

		anchors.fill: parent
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: isEngaged ? Text.AlignBottom : Text.AlignVCenter
		bottomPadding: isEngaged ? gMargin : 0
		color: ColorPalette.color1
		font.family: bold_font.name
		font.pixelSize: fontSize - 6
		text: title
	}

	MouseArea {
		property double initialMousePosition: 0
		property double mouseMoved: -mouseY + initialMousePosition
		property bool isWithinRange: previousPosition + mouseMoved > min
			&& previousPosition + mouseMoved < max

		anchors.fill: parent
		acceptedButtons: Qt.LeftButton

		onPressed: {
			initialMousePosition = mouseY
			isActive = !isActive
		}

		onPositionChanged: {
			if (!isActive || !isWithinRange) return
			currentPosition = previousPosition + mouseMoved
			currentPosition = Math.max(min, Math.min(max, currentPosition))
			dialText.color = ColorPalette.colorF
			engageEffect()
		}

		onReleased: {
			previousPosition = currentPosition
			isActive = !isActive
		}

		onClicked: { clickAction() }

		onDoubleClicked: { reset() }
	}
}
