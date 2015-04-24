import QtQuick 2.0

Rectangle {
	id: game
	color: "green"
	
	readonly property int numberMax: grid.rows * grid.columns / 2
	readonly property alias cards: grid.children
	property var selected: []
	property int solved: 0

	function shuffle() {
		for (var i = 0; i < numberMax; ++i)
			cards[i * 2].number = cards[i * 2 + 1].number = i + 1
		var count = numberMax * 2
		solved = 0
		selected = []
		for (i = 0; i < count; ++i) {
			cards[i].front = false
			cards[i].enabled = true
			var j = Math.floor(Math.random() * count);
			var tmp = cards[i].number
			cards[i].number = cards[j].number
			cards[j].number = tmp
		}
	}

	function checkAnswer(card) {
		card.front = true
		card.enabled = false
		if (selected.length < 2)
			selected.push(card)
		if (selected.length < 2)
			return
		if (selected[0].number == selected[1].number)
			++solved
		else {
			for (var i = 0; i < selected.length; ++i)
				selected[i].reverse()
		}
		selected = []
	}

	Rectangle {
		anchors.horizontalCenter: parent.horizontalCenter
		width: parent.width
		height: 70
		Text {
			anchors.centerIn: parent
			text: solved + " / " + numberMax
			font.pixelSize: 30
		}
	}

	Grid {
		id: grid
		anchors.centerIn: parent
		rows: 4; columns: 2; spacing: 20
		Repeater {
			model: grid.columns * grid.rows
			Card {
				id: card
				onClicked: if (!front) checkAnswer(this)
				function reverse() { reverser.start() }
				SequentialAnimation {
					id: reverser
					NumberAnimation {
						target: card; property: "rotation"
						from: 0; to: 5; duration: 50
					}
					NumberAnimation {
						target: card; property: "rotation"
						to: -5; duration: 100
					}
					NumberAnimation {
						target: card; property: "rotation"
						to: 5; duration: 50
					}
					NumberAnimation {
						target: card; property: "rotation"
						to: -5; duration: 50
					}
					NumberAnimation {
						target: card; property: "rotation"
						to: 0; duration: 50
					}
					PropertyAction { target: card; property: "enabled"; value: true }
					PropertyAction { target: card; property: "front"; value: false }
				}
			}
		}
	}

	Rectangle {
		id: button
		width: 100; height: 50
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 30
		Text {
			text: "재시작"
			anchors.centerIn: parent
			font.pixelSize: 20
		}
		MouseArea {
			anchors.fill: parent
			onClicked: shuffle()
		}
	}

	// 해당 타입의 객체가 생성되면 호출되는 시그널
	Component.onCompleted: {
		shuffle()		
	}
}