import '../models/ti.dart';

class Day2 {
  static List<TI> getTiArray() {
    return [
      TI(
        text: "뇌가 잘 기억하지 못하는 것을 기억하기 쉬운 것으로 바꾸기!!\n   ▽\n(기억하기 어려운)숫자를\n\n(기억하기 쉬운)이미지로 바꿔 봅시다.",
        imageAssetPath: 'assets/images/d1_2.png',
      ),
      TI(
        text: "샤샤는 감자가 먹고싶습니다.\n   ▽\n0~9의 숫자를 이미지로 상상하는 연습을 해서 샤샤가 감자를 먹을 수 있게 도와주세요.",
        imageAssetPath: 'assets/images/d1_0.png',
      ),
      TI(
        text: "숫자 0을 터치해주세요",
        imageAssetPath: 'assets/images/d1_4.png',
      ).asTouchPage(),
      TI(
        text: "샤샤는 0을 보며 감자가 먹고 싶다고 합니다.\n   ▽\n어제 하셨던 머리속으로 상상하기 잊지 않으셨겠죠??\n다음을 눌러 진행해 봅시다.",
        imageAssetPath: 'assets/images/d1_5.png',
      ).withSound('random'),
      TI(
        text: "숫자0을 자신만의 감자로 바꿔봅시다. 난 타박감자 좋아해.",
        imageAssetPath: 'assets/images/d1_4.png',
      ).withAlarm(15).withOverlayText("눈을 감고\n0을 상상해보세요"),
      TI(
        text: "0은 감자입니다.",
        imageAssetPath: 'assets/images/d1_5.png',
      ).withSound('random'),
      TI(
        text: "3분만 집중해주세요.\n   ▽\n나머지 숫자도 이미지로 바꿔볼께요.\n   ▽\n다음페이지 숫자 1부터 시작합니다!!",
        imageAssetPath: 'assets/images/d1_9.png',
      ),
      TI(
        text: "",
        imageAssetPath: 'assets/images/d1_10_1.jpg',
      ).withAlarm(15).withOverlayText("눈을 감고\n1을 상상해보세요"),
      TI(
        text: "",
        imageAssetPath: 'assets/images/d1_10_2.png',
      ).withSound('random'),
      TI(
        text: "숫자2를 바꿔 봅시다.\n   ▽\n호수위의 백조, 숫자 2와 닮았나요?",
        animationFrames: [
          'assets/images/d1_12_1.png',
          'assets/images/d1_12_2.png',
          'assets/images/d1_12_3.png',
          'assets/images/d1_12_4.png'
        ],
      ).withAlarm(15).withResultImage('assets/images/d1_13.png').withOverlayText("눈을 감고\n2를 상상해보세요"),
      TI(
        text: "2는 백조입니다.",
        imageAssetPath: 'assets/images/d1_13.png',
      ).withSound('random'),
      TI(
        text: "숫자3 바꿔 봅시다.\n   ▽\n갈매기를 옆으로 돌리면 3과 비슷합니다. 어디서 바다짠내도 나지 않아요?",
        imageAssetPath: 'assets/images/d1_14.png',
      ).withSound('assets/sounds/seagull.mp3').withAlarm(15).withOverlayText("눈을 감고\n3을 상상해보세요"),
      TI(
        text: "3은 갈매기입니다.",
        imageAssetPath: 'assets/images/d1_14_1.png',
      ).withSound('random'),
      TI(
        text: "숫자4를 바꿔 봅시다.\n   ▽\n요트 타보셨나요?",
        imageAssetPath: 'assets/images/d1_16.png',
      ).withAlarm(15).withOverlayText("눈을 감고\n4를 상상해보세요"),
      TI(
        text: "4는 요트입니다.",
        imageAssetPath: 'assets/images/d1_16_1.png',
      ).withSound('random'),
      TI(
        text: "숫자5를 바꿔 봅시다.\n   ▽\n5에 찔리면 엄청 아프겠네요.",
        imageAssetPath: 'assets/images/d1_18.png',
      ).withAlarm(15).withOverlayText("눈을 감고\n5를 상상해보세요"),
      TI(
        text: "5는 낚시바늘 입니다.\n   ▽\n베이거나 찔리는 상상은 기억에 잘 남습니다",
        imageAssetPath: 'assets/images/d1_18_1.png',
      ).withSound('random'),
      TI(
        text: "숫자6을 바꿔 봅시다.\n   ▽\n빠알간 앵두네요. 숫자 6이 보이시나요??",
        imageAssetPath: 'assets/images/d1_20.png',
      ).withAlarm(15).withOverlayText("눈을 감고\n6을 상상해보세요"),
      TI(
        text: "6은 새빨간 앵두입니다. 거의 다 왔습니다.",
        imageAssetPath: 'assets/images/d1_20_1.png',
      ).withSound('random'),
      TI(
        text: "숫자7을 바꿔 봅시다.\n   ▽\n꼬부랑 할머니의 지팡이가 7과 닮았네요.",
        imageAssetPath: 'assets/images/d1_22.png',
      ).withAlarm(15).withOverlayText("눈을 감고\n7을 상상해보세요"),
      TI(
        text: "7은 꼬부랑 할머니의 지팡이 입니다.",
        imageAssetPath: 'assets/images/d1_22_1.png',
      ).withSound('random'),
      TI(
        text: "숫자8을 바꿔 봅시다.\n   ▽\n눈사람, 8과 비슷한가요.\n   ▽\n이름은 올라프구요, 우리집 냉장고에 삽니다.",
        imageAssetPath: 'assets/images/d1_24.png',
      ).withAlarm(15).withOverlayText("눈을 감고\n8을 상상해보세요"),
      TI(
        text: "8은 눈사람입니다. 다음으로 가볼까요?",
        imageAssetPath: 'assets/images/d1_24_1.png',
      ).withSound('random'),
      TI(
        text: "숫자9를 바꿔 봅시다. 구구콘!! 9와 안닮았지만.. 그냥 하세요..\n   ▽\nppl 아닙니다ㅜㅜ",
        imageAssetPath: 'assets/images/d1_26.png',
      ).withAlarm(15).withOverlayText("눈을 감고\n9를 상상해보세요"),
      TI(
        text: "9는 포켓몬 구구의 울음소.... 아니 구구콘입니다. 조심해 오타쿠라는걸 들키면 안돼!!\n   ▽\n 다음으로 가볼까요?",
        imageAssetPath: 'assets/images/d1_26_1.png',
      ).withSound('assets/sounds/gugusounx3.mp3'),
      TI(
        text: "<미션> 0~9를 이미지로 변환하자.\n폰을 놓고, 눈을 감은 후, 0~9까지 숫자를 변환된 이미지로 떠올려본다.\n   ▽\n혹시 잘 떠오르지 않으면 다시 복습하시고 오세요.\n   ▽\n다 떠올렸다면 다음으로 고고!!",
        imageAssetPath: 'assets/images/umm.png',
      ),
      TI(
        text: "4198 12784 ...\n조사병단의 비밀 지령입니다. ",
        imageAssetPath: 'assets/images/d1_27.png',
      ),
      TI(
        text: "우리는 2개씩 숫자를 체인으로 연결하겠습니다. 기억들을 단단하게 묶어줍시다.\n   ▽\n이미지들로 이야기를 만들어봅시다.\n다음을 눌러 방법을 봅시다.",
        imageAssetPath: 'assets/images/d1_28.png',
      ),
      TI(
        text: "<미션>\n   ▽\n(괄호)속 내용은 이유나 배경입니다.\n   ▽\n밑의 예시를 본 뒤, 눈을 감고 한줄씩!! 상상!!\n   ▽\n41:바다로 가니 요트(4)가 있어 요트에 칼(1)을 꽂았다 푹!\n   ▽\n19:꽂힌 칼(1)을 이용해 구구콘(9)껍데기를 벗겼다.\n   ▽\n98:쿠쿠콘(9)을 한입 먹었는데, 너무 차가워서 난 눈사람(8)이 됐다.\n   ▽\n81:눈사람(8)이 된 나는 칼(1)을 뽑아들었다.\n   ▽\n12:높이 쳐든 칼(1)은 백조(2)모양으로 휘었다.\n   ▽\n27:백조(2)모양으로 휘었던 칼은 어느새 무거워져 지팡이(7)로 변해 퉁 소리를 내며 바닥에 떨어졌다.\n   ▽\n78:지팡이(7)를 주워들어 눈사람(8)(나에게)에 폭! 꽂아 팔을 만들어 줬다.\n   ▽\n84:눈사람(8)은 뒤뚱뒤뚱 걸어가 요트(4) 중간에 완전히 푹 박혀버렸다.",
        imageAssetPath: 'assets/images/d1_29.png',
      ).withOverlayText("눈을 감고 한줄씩\n상상해보세요"),
      TI(
        text: "<기억해보자!>\n처음 시작점인 요트가 떠있는 바다로 갑시다.\n눈을 감고 이야기를 떠올려서 샤샤에게 암호를 전달해주세요.\n\n다음을 눌러 샤샤의 반응을 봅시다",
        imageAssetPath: 'assets/images/d1_30.png',
      ).withChoices([                                                                                                                              
        Choice("맞췄다", 30, videoPath: 'assets/videos/sasa.mp4'),                                                                                            
        Choice("틀렸다", 31),                                                                                         
      ]),
      TI(
        text: "성공!!\n   ▽\n41.98 N, 127.84 E\n   ▽\n조선인민공화국 함경북도 량강도 대홍단 감자밭 위경도입니다.\n   ▽\n샤샤가 감자를 먹고 행복해합니다.",
        imageAssetPath: 'assets/images/d1_31.png',
      ),
      TI(
        text: "실패!! 샤샤는 밥은 언제 되냐며, 고기를 찾습니다. 괜찮습니다. 다음 챕터에서 기억의궁전을 익힌다면 인류를 아니 샤샤를 구할 수 있을겁니다.",
        imageAssetPath: 'assets/images/d1_32.png',
      ).withTouchSound(),
      TI(
        text: "<미션> 이야기 만들기는 조금 어려울 수 있습니다.\n   ▽\n상상은 당신의 몫입니다. 5분이 지나면 알려드릴께요.",
        imageAssetPath: 'assets/images/go.png',
      ).withAlarm(5 * 60),
      TI(
        text: "한번 눈감고 외워보세요! 하이파이브 한 번 하고 다음으로 갑시다.",
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
