import QtQuick
import QtQuick.Controls.Basic
import Qml 1.0
import App 1.0

CustomDial {
	objectName: "Filter"

	description: ["Low <-> Hi pass filter. Double click to disable", ""]
	buttonStateOptions: ["LPF", "HPF", "FILTER"]
	title: buttonStateOptions[2]
	startPosition: 0

	onEngageEffect: {
		dialText.text = currentPosition < startPosition
			? buttonStateOptions[0]
			: currentPosition > startPosition
				? buttonStateOptions[1]
				: buttonStateOptions[2]
		Controller.filter(currentPosition, max)
	}

	onResetAudio: { Controller.resetFilter() }
}
