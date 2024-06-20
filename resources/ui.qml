import QtQuick 2.15
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.3
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.12

Item {
    id: main_window

    property var color1: "#444"
    property var color2: "#AAA"
    property var fontSize: 14
    property var imgSize: 80
    property var filenameHeight: 40
    property var labels: ["artist", "title", "album", "comment", "genre", "year"]

    width: 400
    height: 200

    Rectangle {
        id: background

        anchors.fill: parent
        color: color1
    }

    MouseArea {
        id: main_window_mousearea

        enabled: !edit_button.active
        anchors.fill: parent
        cursorShape: edit_button.active ? Qt.ArrowCursor : Qt.PointingHandCursor

        onClicked: {
            Track.getMetadata()

            if (Track.filePath !== "") {
                select_track.visible = false
                grid.visible = true
                edit_button.visible = true

                file_name.text = Track.filename
                file_length.text = Track.length
                for (var i = 0; i < main_window.labels.length; i++)  {
                    metadata_text.itemAt(i).text = Track[main_window.labels[i]]
                }
                artwork.source = Track.artwork
            }
        }
    }

    Rectangle {
        id: main_box

        x: 10; y: 10
        width: main_window.width - 20
        height: main_window.height - 20
        color: color1
        border.color: color2
        border.width: 5
        radius: 20

        Text {
            id: select_track

            visible: true
            anchors.fill: parent
            text: "SELECT TRACK"
            font.pixelSize: fontSize * 2
            color: color2
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        GridLayout {
            id: grid

            function prefWidth(cells) {
                return (grid.width / grid.columns) * cells - (grid.columnSpacing * 2)
            }

            function prefHeight(cells) {
                return (grid.height / grid.rows) * cells - (grid.rowSpacing * 2)
            }

            visible: false
            rows: 9
            columns: 4
            rowSpacing: 2
            columnSpacing: 2
            anchors.fill: parent

            Rectangle {
                Layout.rowSpan: 2
                Layout.columnSpan: 3
                Layout.preferredWidth: grid.prefWidth(this.Layout.columnSpan)
                Layout.preferredHeight: grid.prefHeight(this.Layout.rowSpan)
                color: "transparent"
                clip: true

                Text {
                    id: file_name

                    anchors.fill: parent
                    anchors.leftMargin: 20
                    font.pixelSize: fontSize
                    font.bold: true
                    color: color2
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Rectangle {
                Layout.rowSpan: 2
                Layout.columnSpan: 1
                Layout.preferredWidth: grid.prefWidth(this.Layout.columnSpan)
                Layout.preferredHeight: grid.prefHeight(this.Layout.rowSpan)
                color: "transparent"

                Text {
                    id: file_length

                    anchors.fill: parent
                    anchors.rightMargin: 20
                    font.pixelSize: fontSize
                    font.bold: true
                    color: color2
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Repeater {
                model: main_window.labels.length

                Rectangle {
                    Layout.row: modelData + 2
                    Layout.preferredWidth: grid.prefWidth(1)
                    Layout.preferredHeight: grid.prefHeight(1)
                    color: "transparent"

                    Text {
                        id: label

                        width: grid.prefWidth(1)
                        text: main_window.labels[modelData] + ":"
                        horizontalAlignment: Text.AlignRight
                        font.capitalization: Font.AllUppercase
                        font.pixelSize: fontSize
                        font.bold: true
                        color: color2
                    }
                }
            }

            Repeater {
                id: metadata_text

                model: main_window.labels.length

                Text {
                    Layout.column: 2
                    Layout.row: modelData + 2
                    Layout.preferredWidth: grid.prefWidth(2)
                    Layout.preferredHeight: grid.prefHeight(1)
                    visible: !edit_button.active
                    clip: true
                    font.pixelSize: fontSize
                    color: color2
                }
            }

            Repeater {
                id: metadata_edit_box

                model: main_window.labels.length

                TextField {
                    Layout.column: 2
                    Layout.row: modelData + 2
                    Layout.preferredWidth: grid.prefWidth(2)
                    Layout.preferredHeight: grid.prefHeight(1)
                    visible: edit_button.active
                    font.pixelSize: fontSize * .7
                }
            }

            Rectangle {
                Layout.row: 2
                Layout.column: 3
                Layout.rowSpan: 4
                Layout.preferredWidth: grid.prefWidth(1)
                Layout.preferredHeight: grid.prefHeight(this.Layout.rowSpan)
                color: "transparent"

                Image {
                    id: artwork

                    source: ":AlbumArtPlaceholder"
                    width: parent.Layout.preferredHeight
                    height: parent.Layout.preferredHeight
                }

                Colorize {
                    anchors.fill: artwork
                    source: artwork
                    saturation: 0
                }
            }

            Rectangle {
                Layout.row: 7
                Layout.column: 3
                Layout.rowSpan: 2
                Layout.preferredWidth: grid.prefWidth(1)
                Layout.preferredHeight: grid.prefHeight(this.Layout.rowSpan)
                color: "transparent"

                Rectangle {
                    id: edit_button

                    property bool active: false

                    visible: true
                    width: artwork.width
                    height: parent.height / 2
                    border.color: color2
                    border.width: 2
                    radius: 5
                    color: active ? color1 : color2

                    Text {
                        id: edit_button_text

                        text: parent.active ? "SAVE" : "EDIT"
                        anchors.fill: parent
                        font.pixelSize: fontSize
                        font.bold: true
                        color: parent.active ? color2 : color1
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            if (edit_button.active) { // SAVE
                                edit_button.active = false

                                for (var i = 0; i < main_window.labels.length; i++) {
                                    if (i === 5) { // year
                                        if (metadata_edit_box.itemAt(i).text.match(/\d+/) !== null) { // contains number
                                            Track[main_window.labels[i]] = metadata_edit_box.itemAt(i).text
                                        }
                                    } else {
                                        Track[main_window.labels[i]] = metadata_edit_box.itemAt(i).text
                                    }
                                    metadata_text.itemAt(i).text = Track[main_window.labels[i]]
                                }

                                Track.setMetadata()
                            } else { // EDIT
                                edit_button.active = true

                                for (var i = 0; i < main_window.labels.length; i++) {
                                    metadata_edit_box.itemAt(i).text = Track[main_window.labels[i]]
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
