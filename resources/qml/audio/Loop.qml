import QtQuick
import QtQuick.Controls.Basic
import Qml 1.0

Item {
    objectName: "Loop"

    property var description: ["Set in/out position during playback. Right click to disable", "L"]
    property var buttonStateOptions: ["IN", "ON", "LOOP"]
    property int iterator: buttonStateOptions.length - 1
    property bool inProgress: iterator === 0
    property bool isActive: iterator !== 2
    property double overviewLoopInPosition
    property double waveformLoopInPosition

	width: cell.size(2, 2).width
	height: cell.size(2, 2).height

    function trigger() {
        iterator === buttonStateOptions.length - 1
                   ? iterator = 0
                   : iterator++

        switch (iterator) {
            case 0: loopIn(iterator); break;
            case 1: loopOut(iterator); break;
            case 2: clear(); break;
        }
    }

    function loopIn(i) {
		Controller.loopIn()
        overviewLoopInPosition =
            waveforms.overview.loopBox.x = waveforms.overview.nowLine.x
        waveformLoopInPosition =
            waveforms.waveform.loopBox.x = waveforms.waveform.position
        waveforms.overview.loopBox.visible = waveforms.waveform.loopBox.visible = true
        loop_text.text = buttonStateOptions[i]
        loop_text.color = loop_in.icon.color = ColorPalette.colorF
        loop_out.icon.color = ColorPalette.color1
    }

    function loopOut(i) {
		Controller.loopOut()
        loop_text.text = buttonStateOptions[i]
        loop_text.color =
			loop_in.icon.color =
				loop_out.icon.color = ColorPalette.colorF
    }

    function clear() {
		Controller.clearLoop()
        waveforms.overview.loopBox.visible =
            waveforms.waveform.loopBox.visible = false
        waveforms.overview.loopBox.width =
            waveforms.waveform.loopBox.width = 0
        loop_text.text = buttonStateOptions[2]
        loop_text.color =
			loop_in.icon.color =
				loop_out.icon.color = ColorPalette.color1
        iterator = 2
    }

    TransportButton {
        description: parent.description
        anchors.fill: parent

        onClicked: { trigger() }

        Text {
            id: loop_text

            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            topPadding: gSpacing
			color: ColorPalette.color1
            font.family: bold_font.name
            font.pixelSize: fontSize - 2
            text: buttonStateOptions[2]
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
            id: loop_in

            rotation: 180
        }

        LoopIcon {
            id: loop_out

            anchors.right: parent.right
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton

        onClicked: { clear() }
    }
}