import QtQuick 2.0

/* 시그널 속성

시그널은 특정 동작에 대한 반응으로 실행되는 코드입니다.
시그널에는 다음의 두종류가 있습니다.

* 프로퍼티 시그널
* 일반 시그널

시그널에는 대응하는 고유한 시그널 핸들러를 정의할 수 있습니다.
시그널 핸들러의 이름은 시그널의 이름으로부터 다음과 같이 정의됩니다.

on+첫글자를대문자로한시그널이름

예를 들어, someSignal 이라는 시그널에 대한 핸들러의 이름은

onSomeSignal이 됩니다.
시그널 핸들러는 자바스크립트로 작성됩니다.
*/

Item {


	Rectangle {
		id: rect
		width: 150
		height: 400
		color: "lightgray"
		anchors.centerIn: parent
	}

	Text {
		id: text
		anchors.fill: parent
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: 30
	}

	MouseArea {
	/* MouseArea 아이템

	마우스관련 동작을 위한 아이템입니다.
	주요 프로퍼티는 다음과 같습니다.
	hoverEnabled: 클릭하지 않아도 마우스의 위치를 체크
	containsMouse: 마우스가 아이템 안에 있음
	pressed: 눌러진 상태임
	*/
		anchors.fill: rect
		hoverEnabled: true // 항상 마우스 위치를 추적

	/* 프로퍼티 시그널

	모든 프로퍼티는 값변화에 대응하는 시그널을 가집니다.
	이 시그널은 프로퍼티의 값이 변할때마다 실행됩니다.
	시그널의 이름은 프로퍼티 + Changed로 결정됩니다.
	예를 들어 프로퍼티의 이름이 someProperty라면
	대응하는 시그널은 somePropertyChanged가 되며,
	이 시그널을 처리하기 위한 핸들러 이름은
	onSomePropertyChanged 가 됩니다.
	*/
		// 시그널의 자바스크립트 코드는 {...}로 싸줍니다.
		onPressedChanged: {
			if (pressed)
				text.text = "눌림"
			else
				text.text = ""
		}
		// 단, 한줄짜리 코드는 {...}를 생략가능합니다.
		onContainsMouseChanged:
			rect.color = containsMouse ? "pink" : "lightgray"

	/* 일반 시그널

	프로퍼티와 상관없이, 특정 조건하에서
	실행되는 시그널입니다.
	일반 시그널에는 인자가 넘어오기도 합니다.

	MouseArea 아이템의 시그널에서 mouse 인자는
	마우스 이벤트의 내용을 나타냅니다.

	pressed(mouse): 마우스 버튼이 눌렸을 때
	released(mouse): 마우스 버튼을 뗐을 때
	clicked(mouse): 클릭되었을 때
	doubleClicked(mouse): 더블 클릭되었을 때
	positionChanged(mouse): 마우스가 이동했을 때
	entered(): 마우스가 아이템안으로 들어왔을 때
	exited(): 마우스가 아이템밖으로 나갔을 때

	mouse 인자는 다음의 프로퍼티를 가지고 있습니다.
	mouse.x: 이벤트 발생시의 마우스 x좌표
	mouse.y: 이벤트 발생시의 마우스 y좌표
	mouse.accepted: 이벤트를 처리/무시
	*/
		onPositionChanged:
		 text.text = "위치: (" + mouse.x + "," + mouse.y + ")"
	}
}
