import QtQuick 2.2

/* 프로퍼티 바인딩

프로퍼티를 초기화할 때 다른 프로퍼티를 이용하거나
자바스크립트 코드를 사용하면
프로퍼티 바인딩이라는 것이 생성됩니다.
다른 프로퍼티가 바뀌면 바인딩된 프로퍼티도 자동으로
갱신됩니다.
*/

Item {

	MouseArea {
		id: mouseArea
		anchors.fill: rect
		hoverEnabled: true
	}

	Rectangle {
		id: rect
// mouseArea.pressed가 바뀔때마다 갱신됩니다.
		width: mouseArea.pressed ? 50 : 150
		height: mouseArea.pressed ? 200 : 300
// mouseArea.containsMouse가 바뀔때마다 색이바뀝니다.
		color: { // 자바스크립트도 가능
			if (!mouseArea.containsMouse)
				return "lightgray"
			// return은 생략 가능
			Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0)
		}
		anchors.centerIn: parent
	}

	Rectangle {
		id: top
// anchors도 바인딩의 하나입니다.
// rect의 위치나 크기 변경에 맞춰서 top도 재조정됩니다.
		anchors.bottom: rect.top
		anchors.bottomMargin: 50
		anchors.horizontalCenter: rect.horizontalCenter
// 항상 rect.color와 같은 값을 가지게 됩니다.
		color: rect.color
// 항상 rect.width와 같은 값을 가지게 됩니다.
		width: rect.width
// 항상 가로와 세로가 같은 크기를 가지게 됩니다.
		height: width
	}

}

/* 성능에 대한 주의

프로퍼티 바인딩은 동적으로 프로퍼티를 갱신할 수 있게
해주며, QML을 보다 선언형답게 만들어주는 핵심 기능입니다.
다만, 성능에 있어서 프로퍼티를 갱신하기 위해 매번
자바스크립트를 실행하는 것은 좋지 않은 쪽으로 작용합니다.
바인딩 식이 간결한 경우 QML 인터프리터에 의해
특별한 최적화가 이루어질수 있기 때문에,
값이 매우 빈번하게 변하는 바인딩에 대해서는 복잡한
자바스크립트를 피하는게 좋습니다.
*/

/* 순환 바인딩에 주의

프로퍼티 바인딩은 프로퍼티간에 의존성을 가지게 합니다.
이때 바인딩은 반드시 한쪽방향으로만 이루어져야 합니다.
상호간에 의존하는 바인딩은 순환 바인딩이라 하며,
코드 실행에 실패하게 됩니다.

예: Item { width: height; height: width; }

특히 아이템의 수가 많아 지면
아이템 간의 상대적인 위치/크기를 정하면서
순환 바인딩을 만드는 실수가 많습니다.
*/


