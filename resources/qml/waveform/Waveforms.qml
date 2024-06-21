import QtQuick
import App 1.0

Item {
    property alias overview: waveform_overview
    property alias waveform: waveform_main

	anchors {
		top: track_info.bottom
		left: parent.left
		bottom: parent.bottom
		right: parent.right
		topMargin: gMargin
	}
	visible: Controller.trackLoaded

    WaveformOverview { id: waveform_overview }
    Waveform { id: waveform_main }
}