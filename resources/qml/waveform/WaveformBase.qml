import QtQuick
import Qml 1.0

import Qt5Compat.GraphicalEffects

Rectangle {
    id: waveform_base

    property alias cueLine: cue_line
    property alias loopBox: loop_box
    property alias nowLine: now_line
    property alias waveformImage: waveform_image
    property alias background: background_gradient

    property bool isScrubbing: false

    width: parent.width
    color: ColorPalette.inverted ? ColorPalette.c5 : "transparent"
    clip: true

    Rectangle {
        id: background_gradient

        anchors.fill: parent
    }

    Image {
        id: waveform_image

        // increase for more zoom range
        property int waveformResolution: 8

        width: parent.width
        height: parent.height

        Component.onCompleted: {
			Controller.waveformSize = Qt.size(width * waveformResolution, height * 2)
			Controller.waveformColor = ColorPalette.color6
        }

        Rectangle {
            id: cue_line

            height: parent.height
            visible: false
            width: 2
            color: ColorPalette.colorF
            opacity: .5
        }

        Rectangle {
            id: loop_box

            height: parent.height
            visible: false
            opacity: .5
        }
    }

    Rectangle {
        id: now_line

        height: parent.height
        width: 2
        color: ColorPalette.colorF
    }
}