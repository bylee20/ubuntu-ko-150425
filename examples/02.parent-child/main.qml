import QtQuick 2.0

Rectangle {
/* Rectangle 아이템

화면에 사각형 영역을 표시하기 위한 아이템입니다.

주요 프로퍼티
color: 사각형 색
radius: 모서리 반경
border.width: 테두리 두께
border.color: 테두리 색
*/

	color: "red"
//	radius: 30
//	border.width: 10
//	border.color: "gray"


	id: root 
/* id 속성

모든 QML 타입은 id라는 속성을 가질수 있습니다.
해당 객체를 가리키기 위한 이름으로 사용됩니다.
*/

	Rectangle {
		id: blue
		width: 150
		height: 400
		color: "blue"
		x: 20
		y: 50 

		Rectangle {
			id: green
			width: 100
			height: 300
			color: "green"
//			z: 1
		}
		Rectangle {
			id: pink
			color: "pink"
			width: 130
			height: 200
		}
	}
/* 아이템의 부모-자식 관계

부모 { ... 자식 { ... } }
이와 같이 아이템이 중첩되있는 경우,
바깥쪽 아이템과 안쪽 아이템은 각각의
부모(parent)/자식(child)이 됩니다.

여기에서 root는 blue의 부모가 되고,
blue는 green과 pink의 부모가 됩니다.
중첩 레벨이 같은 green과 pink는 형제(sibling)가 됩니다.

z값에 관계 없이 자식은 항상 부모 위에 표시됩니다.
(단, z < 0 인경우는 부모 아래에 표시)

형제끼리는 z값이 높은 아이템이 위에 표시됩니다.
z값이 같으면 나중에 선언된 아이템이 위에 표시됩니다.
*/

// x, y좌표는 부모에 대한 상대좌표입니다.
/*
	Rectangle {
		id: yellow
		width: 150
		height: 100
		color: "yellow"
		y: 100
//		parent: pink
	}
*/
// parent: 중첩관계와 상관없이 
//         부모를 지정할 수 있는 프로퍼티

}

/* QML 소스 코드의 기본 형식

모든 QML 소스 코드는 단 하나의 최상위 요소를 포함합니다.
전형적인 소스 코드는 다음과 같은 모습을 하고 있습니다.

// 문서 시작
import 모듈1
import 모듈2
...

SomeKindOfItem {
	...
}
// 문서 끝

여기서 최상위 요소는 SomeKindOfItem입니다.
앞의 예제에서 최상위 요소는 Rectangle 이었습니다.
*/



