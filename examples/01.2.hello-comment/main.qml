/* QML의 주석

QML은 다른 언어에서도 많이 이용되는 다음의 두가지
주석(코멘트)를 허용합니다.
*/

// 한줄 주석

/* 여러
  줄
주석 */

import QtQuick 2.0
/* import 구문

import 모듈 major.minor

해당 모듈의 특정 버전을 불러옵니다.
모듈에 포함된 타입을 사용하기 위해서는
반드시 import 구문을 사용해야 합니다.

본 예제에서 사용하는 모든 타입은
QtQuick 모듈에 포함되어 있습니다.
*/


Item {
/* Item 타입

Item은 모든 비쥬얼 타입들의 기본 타입입니다.
모든 비쥬얼 타입은 Item 타입으로부터 유도(상속)됩니다.
*/


	Text { // 화면에 글자를 표시하기 위한 아이템
		text: "Hello!"
		/* 프로퍼티(property)

		각각의 QML의 타입들은 특정 속성을 나타내는
		여러가지 프로퍼티를 가지고 있습니다.

		프로퍼티의 초기값은 다음과 같은 구문으로 설정합니다.

		프로퍼티명: 프로퍼티값

		Text타입의 text 프로퍼티는 표시할 문자열을 나타냅니다.
		*/

		/* Item의 주요 프로퍼티
		모든 비쥬얼 타입은 Item으로부터 유도되기 때문에
		Item의 프로퍼티를 모두 가지고 있습니다.

		width: 가로 길이
		height: 세로 길이
		x: 위치의 x좌표
		y: 위치의 y좌표
		z: 상대적 위아래
		anchors: 위치 지정용 (추후 설명)
		visible: 화면에 표시/숨김
		opacity: 불투명도
		*/

		/* Text 아이템의 주요 프로퍼티
		font: 폰트
		color: 글자색
		horizontalAlignment: 수평 정렬
		verticalAlignment: 수직 정렬
		*/

//		color: "#ff0000"

		/* 그룹 프로퍼티
		
		프로퍼티가 하위 프로퍼티를 가질 경우
		그룹 프로퍼티라고 합니다.
		Text의 font프로퍼티는 다음과 같이
		하위 프로퍼티를 가지는 그룹 프로퍼티입니다.
		font {
			family: 폰트 이름
			italic: 이탤릭체
			bold: 볼드체
			pixelSize: 폰트 크기(픽셀 기준)
			pointSize: 폰트 크기(포인트 기준)
			... 
		}
		그룹 프로퍼티는 '그룹.하위프로퍼티'와 같이 접근하거나
		그룹 { ... } 와 같이 접근할 수 있습니다.
		단, 동시에 두가지 방법으로 초기화할 수는 없습니다.
		*/

//		font {
//			bold: true
//			pixelSize: 40
//		}
//		font.bold: true		
//		font.pixelSize: 40
	}
}
