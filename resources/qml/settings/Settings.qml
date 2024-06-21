import QtQuick
import QtQuick.Controls.Basic
import Qml 1.0
import App 1.0

Item {
	property alias continuousPlayback: continuous_playback
    property alias waveformZoomSlider: waveform_zoom_slider
    property alias lockEditor: lock_editor

    anchors.fill: parent
	visible: settings_button.isActive

    Rectangle {
        id: outside_settings_window

        anchors.fill: parent
        color: ColorPalette.color1
        opacity: .5

        MouseArea {
            anchors.fill: parent
            onClicked: settings_button.isActive = false
        }
    }

    Rectangle {
        id: settings_window

        width: parent.width * .75
        height: parent.height * .9
        anchors.centerIn: parent
		radius: gMargin
        gradient: Gradient {
            GradientStop { position: 0; color: ColorPalette.color5 }
            GradientStop { position: .3; color: ColorPalette.color1 }
        }

		MouseArea {
            anchors.fill: parent
            onClicked: {} // window dismissal
        }

        Column {
			id: settings_list

            anchors.fill: parent

            SettingsEntry {
				title.text: "SETTINGS"
				title.width: width
				title.horizontalAlignment: Text.AlignHCenter
            }

			SettingsEntry {
				id: continuous_playback

				title.text: "Continuous Playback"

				function defaultState() { cp_toggle.checked = false }

				SettingsEntryToggle {
					id: cp_toggle

					onClicked: {
						checked = !checked
						Controller.continuousPlayback = checked
					}
				}
			}

            SettingsEntry {
				title.text: "Time Display"

                property bool elapsed: false

				function defaultState() {
					if (elapsed) playback_length.toggle()
					elapsed = false
				}

				SettingsEntryButton {
					text: "ELAPSED"
					anchors.right: remaining.left
					opacity: parent.elapsed ? 1 : .5
					onClicked: {
						if (!parent.elapsed) playback_length.toggle()
						parent.elapsed = true
					}
				}

				SettingsEntryButton {
					id: remaining

					text: "REMAINING"
					opacity: parent.elapsed ? .5 : 1
					onClicked: { parent.defaultState() }
				}
            }

            SettingsEntry {
				title.text: "Waveform Size"

                property bool halfWaveform: false

				function defaultState() {
					waveforms.waveform.waveformImage.height =
						waveforms.waveform.waveformImage.parent.height
					halfWaveform = false
				}

                SettingsEntryButton {
                    text: "FULL"
                    anchors.right: half.left
                    opacity: parent.halfWaveform ? .5 : 1
                    onClicked: { parent.defaultState() }
                }

                SettingsEntryButton {
                    id: half

					text: "HALF"
                    opacity: parent.halfWaveform ? 1 : .5
                    onClicked: {
                        waveforms.waveform.waveformImage.height =
                            waveforms.waveform.waveformImage.parent.height * 2
                        parent.halfWaveform = true
                    }
                }
            }

            SettingsEntry {
                title.text: "Waveform Zoom"

				function defaultState() { waveform_zoom_slider.value = 50 }

				MainText {
					width: parent.width
					height: parent.height
					font.family: regular_font.name
                    horizontalAlignment: Text.AlignHCenter
                    text: Math.floor(waveform_zoom_slider.value) + "%"
                }

                Slider {
                    id: waveform_zoom_slider

                    width: parent.width / 3
                    height: parent.height
                    anchors.right: parent.right
                    handle.implicitHeight: 0
                    padding: 0

                    to: 100
                    value: 50
                }
            }

            SettingsEntry {
                id: lock_editor

                title.text: "Lock Editor"

				opacity: Controller.isMp3 ? 1 : .25
				onVisibleChanged: {
					if (le_toggle.visible) le_toggle.checked = false
				}

				function defaultState() {
					if (le_toggle.visible === false) return
					if (edit.isActive) edit.trigger()
					edit.enabled = true
					le_toggle.checked = false
				}

				SettingsEntryToggle {
					id: le_toggle

					visible: Controller.isMp3

					onClicked: {
						if (edit.isActive) edit.trigger()
						edit.enabled = checked
						checked = !checked
					}
				}
            }

			SettingsEntry {
				id: day_mode

				title.text: "Day Mode"

				function defaultState() {
					dm_toggle.checked = false
					ColorPalette.inverted = false
				}

				SettingsEntryToggle {
					id: dm_toggle

					onClicked: {
						checked = !checked
						ColorPalette.inverted = checked
					}
				}
			}

			SettingsEntry {
				SettingsEntryButton {
					id: reset

					text: "RESET"
					background: Rectangle {
						anchors.verticalCenter: parent.verticalCenter
						height: parent.height - gMargin * 2
						color: ColorPalette.color3
					}

					onClicked: {
						for (var i = 0; i < settings_list.children.length; i++) {
							var child = settings_list.children[i];
							if (child.defaultState !== undefined) child.defaultState();
						}
					}
				}
			}
        }
    }
}