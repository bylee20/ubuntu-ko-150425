import QtQuick 2.0

Item {
	id: card
	width: 80; height: width * 1.5

	property int number: 0
	property bool front: false
	readonly property alias color: text.color

	signal clicked
	onClicked: front = !front

	function numberToColor(num) {
		var hue = ((card.number * 17) % 10)/10
		return Qt.hsla(hue, 1.0, 0.5, 1.0)
	}

	Rectangle {
		id: border
		anchors.fill: parent
		radius: 10
		border { color: "black"; width: 2 }

		Text {
			id: text
			anchors.centerIn: parent
			text: card.number
			font.pixelSize: card.height * 0.4
			color: card.numberToColor(card.number)
			style: Text.Outline
			styleColor: "black"
			visible: !back.visible
			transform: Rotation {
				origin { x: text.width * 0.5; y: 0 }
				axis { x:0; y:1; z:0 } angle: 180
			}
		}
		Rectangle {
			id: back
			anchors { fill: parent; margins: 10 }
			radius: 5
			color: "navy"
			visible: rot.angle < 90
		}
		transform: Rotation {
			id: rot
			origin { x: card.width * 0.5; y: 0 }
			axis { x: 0; y: 1; z: 0 }
			angle: card.front ? 180 : 0
			Behavior on angle { NumberAnimation { duration: 100 } }
		}
	}

	MouseArea {
		id: mouseArea
		anchors.fill: parent
		hoverEnabled: true
		onClicked: parent.clicked()
	}

	scale: mouseArea.containsMouse ? 1.1 : 1.0
	Behavior on scale { NumberAnimation { duration: 100 } }
}
