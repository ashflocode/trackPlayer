import QtTest
// import Qml 1.0

import "qrc:/ui/Qml"

MainWindow {
    TestCase {
        name: "TestApp";
        when: windowShown

        function getObj(objectName) { return findChild(parent, objectName); }

        function test_001_SelectTrackOverlay() {
            verify(
                getObj("SelectTrackOverlay").visible,
                "SelectTrackOverlay was not visible."
            );
            compare(
                getObj("SelectTrackOverlay").text,
                "SELECT TRACK",
                `Incorrect SelectTrackOverlay text: ${getObj("SelectTrackOverlay").text}.`
            );
        }

        function test_002_TrackSelector() {
            mouseClick(getObj("TrackSelector"));
            verify(
                getObj("TrackSelector").fileDialog.visible,
                "Clicking TrackSelector did not open dialog."
            );
            getObj("TrackSelector").fileDialog.close();
            verify(
                !getObj("TrackSelector").fileDialog.visible,
                "TrackSelector dialog did not close."
            );
        }

        function test_003_MainText_PlaybackLength_MetadataText() {
            getObj("TrackSelector").openTrack("file://" + testPath + "/TestFile.mp3");
            compare(
                getObj("MainText").text,
                "TestFile",
                `Incorrect MainText text: ${getObj("MainText").text}.`
            );
            compare(
                getObj("PlaybackLength").text,
                "-02:00",
                `Incorrect playback_length text: ${getObj("PlaybackLength").text}.`
            );
            ["artist", "title", "album", "genre", "year"].forEach((label) => {
                compare(
                    getObj(`${label}_text`).text,
                    label === "year" ? "2024" : `test_${label}`,
                    `Incorrect ${label} text: ${getObj(`${label}_text`).text}.`
                );
            });
        }
    }
}