import QtQuick
import Qml 1.0

Rectangle {
	enum Orientation { Horizontal, Vertical }

	property int orientation: SplitLine.Horizontal
	property Item target: parent

	color: ColorPalette.color3

	width:	orientation === SplitLine.Vertical		? 1 : target.width
	height: orientation === SplitLine.Horizontal	? 1 : target.height

	anchors {
		bottom: orientation === SplitLine.Horizontal ? target.bottom : undefined
		right:  orientation === SplitLine.Vertical   ? target.right  : undefined
	}
}
