pragma Singleton
import QtQuick
import Qml 1.0

QtObject {
	property bool inverted: false
	property real t: inverted ? 1 : 0

	Behavior on t {
		NumberAnimation { duration: 100; easing.type: Easing.InOutQuad }
	}

	property color c1: "#111111"
	property color c3: "#333333"
	property color c5: "#555555"
	property color c6: "#666666"
	property color c7: "#777777"
	property color c8: "#888888"
	property color cF: "#FFFFFF"

	function mix(a, b, t) {
		return Qt.rgba(
			a.r + (b.r - a.r) * t,
			a.g + (b.g - a.g) * t,
			a.b + (b.b - a.b) * t,
			a.a + (b.a - a.a) * t
		)
	}

	function inv(c) {
		return Qt.rgba(1 - c.r, 1 - c.g, 1 - c.b, c.a)
	}

	property color color1: mix(c1, inv(c1), t)
	property color color3: mix(c3, inv(c3), t)
	property color color5: mix(c5, inv(c5), t)
	property color color6: mix(c6, inv(c6), t)
	property color color7: mix(c7, inv(c7), t)
	property color color8: mix(c8, inv(c8), t)
	property color colorF: mix(cF, inv(cF), t)
}
