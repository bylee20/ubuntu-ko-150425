import QtQuick 2.0

/* 프로퍼티, 시그널, 메소드의 정의

아이템에는 직접 새로운 프로퍼티/시그널/메소드를
정의하여 기능을 확장할 수 있습니다.
*/

Item {
	Item {
		id: card
    width: 80; height: width * 1.5
		anchors.centerIn: parent

		/* 프로퍼티의 정의

		일반적인 프로퍼티는 다음과 같이 정의할 수 있습니다.

		property 타입명 프로퍼티명: 초기값

		타입명에는 다음의 기본타입과, 모듈에 정의된 타입들이
		이용가능합니다.

		주요 타입들
		bool: true 또는 false
		int: 정수
		real: 실수
		string: 문자열
		color: 색깔 ("red", "#ff0000", Qt.rgba(1.0, 0.0, 0.0, 1.0))
		var: 제네릭 타입

		property 앞에 readonly라고 붙이면 읽기 전용이 됩니다.
		이렇게 선언된 프로퍼티는 초기화시외에 값을 대입할 수
		없습니다. 다만, 프로퍼티 바인딩을 통해 초기화된
		경우에는 프로퍼티 바인딩에 의해 업데이트 될수 있습니다.
		*/
		property int number: 0 // int 타입의 프로퍼티
		property bool front: false // bool 타입의 프로퍼티

		/* alias(별명) 프로퍼티 정의

		타입 이름대신 alias를 적으면 다른 프로퍼티에 대한 
		별명 프로퍼티를 정의하게 됩니다.
		별명 프로퍼티는 반드시 다른 프로퍼티로 초기화되어야
		하며 해당 프로퍼티와 완전히 동일한 프로퍼티로
		간주됩니다.
		별명 프로퍼티를 변경하면 원본도 변경되며
		원본이 변경되면 별명 프로퍼티도 변경됩니다.
		*/
		readonly property alias color: text.color

		/* 시그널 정의
		
		시그널은

		signal 시그널이름(인자)

		와 같이 정의할 수 있습니다.
		인자가 없는 경우에는 ()를 생략할 수 있습니다.
		*/
		signal clicked

		// 정의한 시그널의 핸들러도 같은 이름 규칙을 따릅니다.
		onClicked: front = !front

		/* 메소드 정의

		QML 타입의 메소드는 일반 자바스크립트 함수와 동일합니다.
		*/
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
				// 메소드 호출하여 프로퍼티 바인딩
				color: card.numberToColor(card.number)
				style: Text.Outline
				styleColor: "black"
				visible: !back.visible
			}
			Rectangle {
				id: back
				anchors { fill: parent; margins: 10 }
				radius: 5
				color: "navy"
				visible: !card.front
			}
		}

		MouseArea {
			id: mouseArea
			anchors.fill: parent
			hoverEnabled: true
			onContainsMouseChanged: {
				if (containsMouse)
					card.scale = 1.1
				else
					card.scale = 1.0
			}
			// 시그널 발생(함수 호출과 동일)
			onClicked: parent.clicked()
		}
	}
}