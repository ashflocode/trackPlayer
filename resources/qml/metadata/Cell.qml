import QtQuick

QtObject {
	property real rowHeight: metadata_window.height / metadata_window.rows

	function size(w = 1, h = 1) {
		return Qt.size(rowHeight * w, rowHeight * h)
	}

	function dynamicSize(objects) {
		let w = metadata_window.width
		let h = metadata_window.height
		if (objects) objects.forEach(obj => {
			w -= obj.width
			h -= obj.height
		})
		return Qt.size(w, h)
	}
}