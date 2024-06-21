import QtQuick
import QtQuick.Controls.Basic
import Qml 1.0
import App 1.0

CustomDial {
	description: ["Add delay to track. Click to change speed. Double click to disable", ""]
	title: "DELAY"

	property var speeds: ["1", "1/2", "1/4", "1/8"]
	property var speedMap: ({
		  "1": 1,
		"1/2": 2,
		"1/4": 4,
		"1/8": 8,
	})

	onEngageEffect: {
		dialText.text = isActive ? speeds[0] : "DELAY"
		Controller.delay(normalizedPosition)
	}

	onClickAction: {
		if (!isEngaged) return
		speeds.push(speeds.shift())
		dialText.text = speeds[0]
		Controller.delaySpeed(speedMap[speeds[0]])
	}

	onResetAudio: { Controller.resetDelay() }
}
