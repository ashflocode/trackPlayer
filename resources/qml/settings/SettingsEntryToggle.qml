import QtQuick
import QtQuick.Controls.Basic
import Qml 1.0

RoundButton {
	property string checkIcon: "\u2713"

	height: parent.height * .8
	width: height
	anchors.verticalCenter: parent.verticalCenter
	anchors.right: parent.right
	checked: false
	text: checked ? checkIcon : ""
	background: Rectangle {
		radius: width / 2
		color: checked ? ColorPalette.color8 : ColorPalette.color3
	}
}