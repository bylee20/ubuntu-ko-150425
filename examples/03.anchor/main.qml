import QtQuick 2.2

Rectangle {
	color: "lightgray"

/* anchors 그룹 프로퍼티

anchors는 아이템의 위치를 지정하는 그룹 프로퍼티입니다.
anchor(닻)이라는 이름대로,
특정 위치를 다른 아이템의 위치에 고정시킵니다.
*/

	Rectangle {
		color: "green"
		anchors {
			top: parent.top // 위쪽을 부모의 위쪽에
			left: parent.left // 왼쪽을 부모의 왼쪽에
			right: parent.right // 오른쪽을 부모의 아래쪽에
			bottom: parent.bottom // 오른쪽을 부모의 아래쪽에
//		fill: parent // 위 네줄과 동일한 효과

			topMargin: 10 // 위쪽 여백
			leftMargin: 10 // 왼쪽 여백
			rightMargin: 10 // 오른쪽 여백
			bottomMargin: 10 // 아래쪽 여백
//		margins: 10 // 위 네줄과 동일한 효과
		}
/* 이 아이템은 모든 변에 anchor를 설정했기 때문에
	 x, y, width, height는 anchor에 의해서 자동으로
 	 결정됩니다. 여기에 x, y, width, height를 설정하려 하면
	 문제가 발생할 수 있으니 주의. */
}

/*
	Rectangle {
		id: orange
		color: "orange"
		anchors {
// 수직 중심을 부모의 수직 중심에 맞춤
			verticalCenter: parent.verticalCenter
// 수평 중심을 부모의 수평 중심에 맞춤
			horizontalCenter: parent.horizontalCenter
//		centerIn: parent // 위 두줄과 같은 효과
// 수직 중심 오프셋(y방향으로 평행 이동)
//			verticalCenterOffset: -100
// 수평 중심 오프셋(x방향으로 평행 이동)
//			horizontalCenterOffset: 20
		}
// 이 아이템은 anchor로 위치만을 지정하였기 때문에
// 별도로 크기를 width, height로 지정해야합니다.
		width: 100
		height: 200
	}
*/

/*
	// anchors의 대상은 자식->부모 또는 형제<->형제만 가능
	Rectangle {
		color: "blue"
		anchors {
			top: orange.bottom // 위쪽을 orange의 아래쪽에
			right: orange.left // 오른쪽을 orange의 왼쪽에
			bottom: parent.bottom // 아래쪽을 부모의 아래쪽에
		}
		width: 150 // 위아래가 고정되어 height는 자동계산
	}
*/
}

