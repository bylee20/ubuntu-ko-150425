import QtQuick 2.0

Item {
	Rectangle {
		anchors {
			top: card1.top
			left: card1.left
			right: card1.right
			bottom: card2.bottom
			margins: -5
		}
		color: "cyan"
	}
/* 사용자 정의 타입

새로운 타입의 이름은 파일명과 같습니다.
이경우 Card.qml으로 정의된 타입명은 Card가 됩니다.
*/
	Card {
		id: card1
		number: 1 // 새롭게 정의한 타입의 프로퍼티
		x: 10; y: 10 // Item으로부터 상속받은 프로퍼티
	}
	Card {
		id: card2
		number: 2
		anchors {
			top: card1.bottom
			topMargin: 20
			left: card1.left
		}
	}

	Rectangle {
		anchors.fill: column
		anchors.margins: -5
		color: "pink"
	}
	Column {
		id: column
		x: 110
		y: 10
		spacing: 20
		Card { number: 3 }
		Card { number: 4 }
	}

	Rectangle {
		anchors.fill: row
		anchors.margins: -5
		color: "lightgreen"
	}
	Row {
		id: row
		x: 10
		y: 290
		spacing: 20
		Card { number: 5 }
		Card { number: 6 }
	}

	Rectangle {
		anchors.fill: grid
		anchors.margins: -5
		color: "orange"
	}
	Grid {
		id: grid
		columns: 2
		rows: 2
		x: 10
		y: 430
		spacing: 20
		Card { number: 7 }
		Card { number: 8 }
		Card { number: 9 }
		Card { number: 10 }
	}

	Rectangle {
		anchors.fill: grid2
		anchors.margins: -5
		color: "darkcyan"
	}
	Grid {
		id: grid2
		anchors.centerIn: parent
		columns: 2
		rows: 4
		spacing: 20
		Repeater {
			model: grid2.columns * grid2.rows
			Card { number: index + 1 }
		}
	}

}