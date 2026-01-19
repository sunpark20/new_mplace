import '../models/ti.dart';

class Day6PAO {
  static List<TI> getTiArray() {
    return [
      TI(
        text: "숫자를 외우는 신무기를 장착해봅시다.\n"
            "['day5-첫번째 도전'으로 인물을 만든 뒤 진행해주세요]",
        imageAssetPath: 'assets/images/dp_1.png',
      ),
      TI(
        text: "밀러의 실험에서 사람은 평균적으로 한번에 7개의 정보를 기억했습니다.\n"
            "(숫자나 무작위 알파벳 같은 의미 없는 정보)\n"
            "순간적인 기억은 단기기억 또는 작업기억이라 불립니다. 지속되는 시간은 20초 미만으로 엄청 짧습니다.\n"
            "더 많이 기억 할 수 있는 방법은 없을까요??",
        imageAssetPath: 'assets/images/dp_2.png',
      ),
      TI(
        text: "청킹, 덩어리짓기, 묶음짓기 모두 같은 의미입니다. 정보를 의미 있는 묶음 덩어리로 만든다면 한번에 외울 수 있는 양이 늘어나게 됩니다."
            "사실 용어로 정의해서 그렇지, 누구나 다 사용하고 알고 있는 사실입니다.",
        imageAssetPath: 'assets/images/dp_3.png',
      ),
      TI(
        text: "방법은 간단합니다. 자신의 머리속에 있는 장기기억과 새로운 정보를 묶는 것입니다. 다음으로 가서 예를 봅시다.",
        imageAssetPath: 'assets/images/dp_4.png',
      ),
      TI(
        text: "어떻게 묶음이 지어지나요?\n"
            "010은 휴대폰 앞자리, 119는 소방서, 112는 경찰서 9개의 숫자가 3덩어리로 잘립니다. 당연한 사실입니다. 헤헤\n다음으로 가서 이 당연한 것을 적용해보죠.",
        imageAssetPath: 'assets/images/dp_5.png',
      ),
      TI(
        text: "PAO시스템 입니다."
            " PAO시스템을 활용해서 4자리 숫자를 한 이미지로 합쳐봅시다.\n"
            "P: PERSON(사람), A: ACTION(행동), O: OBJECT(물체) 입니다. 다음으로 가서 예를 살펴봅시다.",
        imageAssetPath: 'assets/images/dp_6.png',
      ),
      TI(
        text: "78: ㅅㅇ -> 성유리 , 04: ㅊㅎ -> 최홍만, 사람(P)과 행동(A)이나 물체(O)을 합쳐서 이미지로 저장합니다.\n"
            "핑클의 성유리(성유리의 P)가 K1무대에서 양손으로 내 목을 잡고 니킥으로 공격(최홍만의 A)한다. 코피가 난다.\n"
            "한번 여러분의 이미지로 바꿔 볼까요?",
        imageAssetPath: 'assets/images/dp_7.png',
      ),
      TI(
        text: "8분이 지나면 알람을 울려드립니다. 기억의 궁전을 이용해서 다음 숫자를 외워봅시다.",
        imageAssetPath: 'assets/images/dp_8.png',
      ).withAlarm(8 * 60),
      TI(
        text: "맞추셨나요?? 잘하셨습니다.\n\n"
            "원주율 뒤 22자리 였습니다.\n3.1415926535 8979323846 2643"
            "\n   ▽\n"
            "자동차 번호판은 재밋는 연습 상대입니다. 매장의 간판 전화번호도 마찬가지죠. 매장은 공간을 포함하고 있으므로"
            " 그 자체가 기억의 궁전이 되기 때문에 길다니며 외워보면 재밋습니다(?). 쭉쭉 외우면서 숫자외우기 마스터가 되봅시다.\n"
            "day6-숫자2 오른쪽에 PAO 연습도 있으니 연습해보세요.(사실.. 왜 만들었는지 모르겠..ㅜㅜ별 쓸떼기 없네요..)"
            "\n   ▽\n참고로 프로 선수의 방법중엔 (0~999)를 1000개의 인물을 만들어 놓는 방법, pao 인물 행동 물체 3개를 묶어 기억하느법 등이 여러가지가 있습니다.\n 다음시간에 봐요~",
        imageAssetPath: 'assets/images/d2_16.png',
      ).withTouchSound(),
    ];
  }
}
