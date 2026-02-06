import '../models/ti.dart';

class Day6PAO {
  static List<TI> getTiArray() {
    return [
      TI( //인덱스2
        text: "조지 밀러(George Miller)의 1956년 논문 <a href='https://labs.la.utexas.edu/gilden/files/2016/04/MagicNumberSeven-Miller1956.pdf'>“마법의 숫자 7, 플러스마이너스 2”</a>에서<br>"+
            "사람은 평균적으로 한번에 7개의 정보를 기억한다는 것을 실험적으로 증명했습니다.<br>"
            "(숫자나 무작위 알파벳 같은 의미 없는 정보)<br>"
            "순간적인 기억은 단기기억 또는 작업기억이라 불립니다. 지속되는 시간은 20초 미만으로 극히 짧습니다.<br>"
            "더 많이 기억 할 수 있는 방법은 없을까요??",
        imageAssetPath: 'assets/images/d6_zz.webp',
      ).asHtml(),
      TI( //인덱스3
        text: "청킹, 덩어리짓기, 묶음짓기 모두 같은 의미입니다.\n정보를 의미 있는 묶음 덩어리로 만든다면 한번에 외울 수 있는 양이 늘어나게 됩니다."+
            "사실 용어로 정의해서 그렇지, 누구나 다 사용하고 알고 있는 사실입니다.",
        imageAssetPath: 'assets/images/d6_chungking.webp',
      ),
      TI( //인덱스4
        text: "방법은 간단합니다. 자신의 머리속에 있는 장기기억과 새로운 정보를 묶는 것입니다.",
        imageAssetPath: 'assets/images/d6_longMemory.webp',
      ),
      TI( //인덱스5
        text: "어떻게 묶음이 지어지나요?\n"
            "010은 휴대폰 앞자리, 119는 소방서, 112는 경찰서 9개의 숫자가 3덩어리로 잘립니다.\n너무 당연한가요? 헤헤",
        imageAssetPath: 'assets/images/d6_010119112.webp',
      ),
      TI( //인덱스6
        text: "PAO시스템 입니다.\n"
            "이미지 2개를 1개로 압축할 수 있다는 장점이 있습니다.\n"
            "P: PERSON(사람), A: ACTION(행동), O: OBJECT(물체) 입니다.",
        imageAssetPath: 'assets/images/d6_pa.webp',
      ),
      TI( //인덱스7
        text: "01최강록(인물)에 50무천도사(행동)를 결합했습니다.\n"
        "0150을 한방에 외울 수 있겠죠",
      ).withInlineVideo('assets/videos/choiEnergy.mp4'),
      TI( //인덱스7
        text: "01최강록(인물)에 73서태웅(물체)를 결합했습니다.\n"
        "역시 0173을 한방에!"
      ).withInlineVideo('assets/videos/choiSlam.mp4'),
      TI( //인덱스8
        text: "기억의 궁전을 이용해서 숫자를 외워주세요. 8분이 지나면 알람을 울리겠습니다.",
        imageAssetPath: 'assets/images/d6_mission.webp',
      ).withAlarm(8 * 60),
      TI( //인덱스9
        text:"원주율 뒤 22자리 였습니다.<br>3.1415926535 8979323846 2643"
            "<br>▽<br>이제 이정도는 껌이죠??<br>"
            "이제 하산 할 때가 되었습니다. 여기까지 도달하셨다면 자동차 번호판, 전화번호, 신용카드번호 등 숫자를 닥치는대로 외우고 있으실거에요(?)<br>"
            "<a href='https://memoryleague.com/#!/home'>memoryLeague</a>로 가서 더 넓은 세상에서 많은 걸 배워보세요.<br>"
            "제 역할은 여기까지 입니다.<br>"
            "언젠가 기억력 대회에서 만날지도??\n기억의 궁전과 함께라면 인생 난이도 EASY모드 입니다. 안녕!! 친구들!!",
        imageAssetPath: 'assets/images/d6_end.webp',
      ).asHtml().withBackgroundMusic('assets/sounds/FiveArmies.mp3'),
    ];
  }
}
