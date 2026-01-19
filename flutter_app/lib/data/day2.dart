import '../models/ti.dart';

class Day2 {
  static const String w = "\n   ▽\n눈을 감고 상상해봅시다\n15초 후에 알람이 울립니다.";

  static List<TI> getTiArray() {
    return [
      TI(
        text: "뇌가 잘 기억하지 못하는 것을 기억하기 쉬운 것으로 바꾸기!!\n   ▽\n(기억하기 어려운)숫자를 (기억하기 쉬운)이미지로 바꿔 봅시다.",
        imageAssetPath: 'assets/images/d1_2.png',
      ),
      TI(
        text: "영희는 부모님의 폰번호를 외우려고 합니다.(영희==효녀)\n   ▽\n0~9의 숫자를 이미지로 상상하는 연습을 해보겠습니다.",
        imageAssetPath: 'assets/images/d1_0.png',
      ),
      TI(
        text: "숫자 0을 터치해주세요",
        imageAssetPath: 'assets/images/d1_4.png',
      ).asTouchPage(),
      TI(
        text: "저는 숫자 0을 보면 축구공을 떠올립니다.\n   ▽\n어제 하셨던 머리속으로 상상하기 잊지 않으셨겠죠??\n다음을 눌러 진행해 봅시다.",
        imageAssetPath: 'assets/images/d1_5.png',
      ),
      TI(
        text: "숫자0을 자신만의 축구공으로 바꿔봅시다." + w,
        imageAssetPath: 'assets/images/d1_4.png',
        animationFrames: ['assets/images/d1_8_ani.png'],
      ).withAlarm(15),
      TI(
        text: "0은 축구공입니다.",
        imageAssetPath: 'assets/images/d1_5.png',
      ),
      TI(
        text: "3분만 집중해주세요.\n   ▽\n나머지 숫자(1~9)도 이미지로 바꿔볼까요.\n   ▽\n각 숫자와 닮은 이미지를 떠올리시면 됩니다. 고고고",
        imageAssetPath: 'assets/images/d1_9.png',
      ),
      TI(
        text: "숫자1을 바꿔 봅시다.\n   ▽\n이번 올림픽에서 멋지게 활약했던 박상영 선수네요.\n   ▽\n검이 1과 비슷하게 생겼네요." + w,
        imageAssetPath: 'assets/images/d1_10_2.png',
        animationFrames: ['assets/images/d1_10_ani.png'],
      ).withAlarm(15),
      TI(
        text: "1은 검입니다.\n   ▽\n찔리면 엄청 아프겠어요.",
        imageAssetPath: 'assets/images/d1_10_1.png',
      ),
      TI(
        text: "숫자2를 바꿔 봅시다.\n   ▽\n호수위의 백조, 숫자 2와 닮았나요?" + w,
        animationFrames: ['assets/images/d1_12_ani.png'],
      ).withAlarm(15).withResultImage('assets/images/d1_13.png'),
      TI(
        text: "2는 백조입니다.",
        imageAssetPath: 'assets/images/d1_13.png',
      ),
      TI(
        text: "숫자3 바꿔 봅시다.\n   ▽\n갈매기를 옆으로 돌리면 3과 비슷합니다. 어디서 바다짠내도 나지 않아요?" + w,
        imageAssetPath: 'assets/images/d1_14.png',
        animationFrames: ['assets/images/d1_14_ani.png'],
      ).withSound('assets/sounds/seagull.mp3').withAlarm(15),
      TI(
        text: "3은 갈매기입니다.",
        imageAssetPath: 'assets/images/d1_14_1.png',
      ),
      TI(
        text: "숫자4를 바꿔 봅시다.\n   ▽\n요트 타보셨나요?" + w,
        imageAssetPath: 'assets/images/d1_16.png',
        animationFrames: ['assets/images/d1_16_ani.png'],
      ).withAlarm(15),
      TI(
        text: "4는 요트입니다.",
        imageAssetPath: 'assets/images/d1_16_1.png',
      ),
      TI(
        text: "숫자5를 바꿔 봅시다.\n   ▽\n5에 찔리면 엄청 아프겠네요." + w,
        imageAssetPath: 'assets/images/d1_18.png',
        animationFrames: ['assets/images/d1_18_ani.png'],
      ).withAlarm(15),
      TI(
        text: "5는 낚시바늘 입니다.\n   ▽\n베이거나 찔리는 상상은 기억에 잘 남습니다",
        imageAssetPath: 'assets/images/d1_18_1.png',
      ),
      TI(
        text: "숫자6을 바꿔 봅시다.\n   ▽\n빠알간 앵두네요. 숫자 6이 보이시나요??",
        imageAssetPath: 'assets/images/d1_20.png',
        animationFrames: ['assets/images/d1_20_ani.png'],
      ).withAlarm(15),
      TI(
        text: "6은 새빨간 앵두입니다. 거의 다 왔습니다.",
        imageAssetPath: 'assets/images/d1_20_1.png',
      ),
      TI(
        text: "숫자7을 바꿔 봅시다.\n   ▽\n꼬부랑 할머니의 지팡이가 7과 닮았네요.",
        imageAssetPath: 'assets/images/d1_22.png',
        animationFrames: ['assets/images/d1_22_ani.png'],
      ).withAlarm(15),
      TI(
        text: "7은 꼬부랑 할머니의 지팡이 입니다.",
        imageAssetPath: 'assets/images/d1_22_1.png',
      ),
      TI(
        text: "숫자8을 바꿔 봅시다.\n   ▽\n눈사람, 8과 비슷한가요.\n   ▽\n이름은 올라프구요, 우리집 냉장고에 삽니다.",
        imageAssetPath: 'assets/images/d1_24.png',
        animationFrames: ['assets/images/d1_24_ani.png'],
      ).withAlarm(15),
      TI(
        text: "8은 눈사람입니다. 다음으로 가볼까요?",
        imageAssetPath: 'assets/images/d1_24_1.png',
      ),
      TI(
        text: "숫자9를 바꿔 봅시다. 구구콘!! 9와 안닮았지만.. 그냥 하세요..\n   ▽\nppl 아닙니다ㅜㅜ",
        imageAssetPath: 'assets/images/d1_26.png',
        animationFrames: ['assets/images/d1_26_ani.png'],
      ).withAlarm(15),
      TI(
        text: "9는 구구콘입니다.\n   ▽\n 다음으로 가볼까요?",
        imageAssetPath: 'assets/images/d1_26_1.png',
      ),
      TI(
        text: "<미션> 0~9를 이미지로 변환하자.\n폰을 놓고, 눈을 감은 후, 0~9까지 숫자를 변환된 이미지로 떠올려본다.\n   ▽\n혹시 잘 떠오르지 않으면 다시 복습하시고 오세요.\n   ▽\n다 떠올렸다면 다음으로 고고!!",
        imageAssetPath: 'assets/images/umm.png',
      ),
      TI(
        text: "영희 어머니의 전화번호입니다. 이 전화번호를 2개씩 묶을 것입니다. 다음으로 가봅시다.",
        imageAssetPath: 'assets/images/exam.png',
      ),
      TI(
        text: "2개씩 연결한 체인들은 기억들을 단단하게 묶어줍니다.\n   ▽\n이미지들로 이야기를 만들어봅시다.\n다음을 눌러 방법을 봅시다.",
        imageAssetPath: 'assets/images/chain.png',
      ),
      TI(
        text: "<미션>\n   ▽\n(괄호)속 내용은 이유나 배경입니다.\n   ▽\n밑의 예시를 본 뒤, 눈을 감고 장면을 상상하세요. 한줄씩!! 상상!!\n   ▽\n42:바다로 가서 요트(4)에 백조(2)를 태웠다.\n   ▽\n25:(휘이잉~ 갑자기 바람이 분다)백조(2)가 휘청거리더니 갈고리(5)에 찔렸다. 백조아파아파..\n   ▽\n56:(휘이휘이~한번 더 강풍이 분다)갈고리(5)는 앵두(6)도 찔렀다. 앵두는 터져버렸다..",
        imageAssetPath: 'assets/images/phone.png',
      ),
      TI(
        text: "699:터져버린 앵두(6)는 버리고 구구콘(9) 2개를 먹었다. 냠냠\n   ▽\n97:먹던 구구콘(9)을 흘렸는데 지팡이(7)에 묻었다.\n   ▽\n78:지팡이(7)를 눈사람(8)에 슥~꽂아 팔을 만들어 줬다.\n슥~~ 따라오셨죠. 그냥 슥~ 다음장으로 가봅시다.",
        imageAssetPath: 'assets/images/phone.png',
      ),
      TI(
        text: "<기억해보자!>\n처음 시작점인 요트가 떠있는 바다로 가볼까요?? 눈을 감고 이야기를 떠올려보세요.\n\n몇 개 틀렸다구요? 괜찮아요. 자신이 만들어낸 이야기가 훨씬 기억에 잘 남을거에요. 다음 페이지로 가서 자신만의 이야기를 만들어 봅시다.",
        imageAssetPath: 'assets/images/d2_16.png',
      ).withTouchSound(),
      TI(
        text: "<미션> 이야기 만들기는 조금 어려울 수 있습니다.\n   ▽\n상상은 당신의 몫입니다. 5분이 지나면 알려드릴께요.",
        imageAssetPath: 'assets/images/go.png',
      ).withAlarm(5 * 60),
      TI(
        text: "하이파이브 한 번 하고 다음으로 갑시다.",
        imageAssetPath: 'assets/images/d2_16.png',
      ).withTouchSound(),
      TI(
        text: "맞추셨다면 아주 잘 하셨습니다.\n   ▽\n다 기억나지 않더라도 괜찮습니다.\n   ▽\n사실 이 방법은 조금 어렵습니다.\n   ▽\n다음 시간에는 그 한계를 뛰어 넘을 수 있는 기억법 드디어 기억을 궁전을 배워봅시다.",
        imageAssetPath: 'assets/images/d0_3.png',
      ),
      TI(
        text: "오늘도 역시 생생한 이미지 상상하기!! 그리고 자신만의 스토리!! 기억하세요.\n   ▽\n다음 시간에 만나요. 바이바이",
        imageAssetPath: 'assets/images/d1_2.png',
      ),
    ];
  }
}
