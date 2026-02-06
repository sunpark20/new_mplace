import '../models/ti.dart';

class Day32 {
  static List<TI> getTiArray() {
    return [
      TI( //인덱스1
        text: "그리스 고서 rhetorica ad herennium[헤렌니우스에게 바치는 수사학]에 소개된 장소기억법에 대한 내용입니다.",
        imageAssetPath: 'assets/images/d32_book.webp',
      ),
      TI( //인덱스1.5 
        text: "일론머스크의 기억에 대한 생각을 잠깐 보고 가죠. 카드덱을 외웠다면 일론도 기억의궁전을 사용해본 것 같네요.\n\n출처) FULL SEND PODCAST 일론머스크편",
         imageAssetPath: 'assets/images/d32_elonWithX.webp',
      ).withFullscreenVideoButton('assets/videos/d32_elon.mp4'),
      TI( //인덱스2
        text: "기억의 궁전은 장소와 상으로 이루어집니다.$arrow스케치북(장소)에 물감(상상력)으로 그림(상)을 그릴 수 있습니다.",
        imageAssetPath: 'assets/images/d32_pAndS.webp',
      ),
      TI( //인덱스3
        text: "장소는 나무나 강과 같은 자연, 집이나 건축물,$arrow또는 자신의 상상력을 더해 만들어 놓은 장면입니다.$arrow그림을 그릴 땐 하얀 스케치북이 필수겠죠.",
        imageAssetPath: 'assets/images/d32_house.webp',
      ),
      TI( //인덱스4
        text: "장소는 순서대로 기억하고 있어야 합니다.$arrow서울, 대전, 대구, 부산은 쉽지만 그 사이에 광주를 넣는다면 헷갈리겠죠?? $arrow꼬리를 무는 체인 아시죠!! 순서는 기억의 연쇄작용을 도와줍니다.",
        imageAssetPath: 'assets/images/d32_map.webp',
      ),
      TI( //인덱스5
        text: "장소에 사람이나 사물이 너무 많다면 노노$arrow특색있는 간단한 장소에 모상을 놔둡시다.$arrow장소는 적당한 크기가 좋습니다. 실제로 걷는다고 생각합시다.$arrow모상이 너무 밝거나 어두워도 안되며, 장소 사이의 간격도 쉽게 다음 장소가 보일 수 있도록 설정하는 것이 좋습니다.",
        imageAssetPath: 'assets/images/d32_caslte.webp',
      ),
      TI( //인덱스6
        text: "기억의궁전 공간(방)은 재사용이 가능합니다.$arrow넣었던 이미지를 지우개로 슥삭슥삭 지우는 상상을 하며 돌아다니면 깨끗하게 비워집니다.",
        imageAssetPath: 'assets/images/d32_erase.webp',
      ),
      TI( //인덱스7
        text: "모상은 모습, 형태, 흔적을 뜻합니다.$arrow인간의 뇌는 새로운, 야한장면, 끔찍함(바퀴벌레??), 칼날에 베이는 섬뜩한 느낌을 쉽게 기억합니다.$arrow남자는 야한 상상을, 여자는 감정적인 요소를 기억술에 많이 사용한다고 합니다.$arrow야한 장면을 상상하는 기술은 고대에 기억술이 천대받는 원인이 되었다죠 헤헤.. vs현세대 기억력 챔피언 도미니크 오브라이언은 반대주장을 합니다. 실제로 가본곳, 논리정연한 상상, 현실에서 일어날법한 일들 등을 잘 활용해야 한다고 합니다.*사실 저도 이쪽이 더 잘됨",
        imageAssetPath: 'assets/images/d32_19.webp',
      ),
      TI( //인덱스8
        text: "어떤 기억력 챔피언은 에베레스트산을 오르며 대회를 준비했다네요. 띠옹!! 참 방법은 다양하네요.$arrow꾸준하게 장소를 확보해야 많은 것들을 담을 수 있습니다.$arrow시행착오를 통해 어떤 장소와 모상이 좋은지,점차 알수 있을 겁니다. 화이팅! 바바이",
      ).withInlineVideo('assets/videos/d32_tesla.mp4'),
    ];
  }
}
