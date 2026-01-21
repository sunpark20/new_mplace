import '../models/ti.dart';

class Day1 {
  static const String w = "\n   ▽\n반드시 눈을 감고 머리속으로 상상한 뒤에 넘어갑시다.";

  static List<TI> getTiArray() {
    return [
      TI(
        text: "신체를 이용한 이용한 기억법을 배워봅시다. 방법은 간단합니다. 눈을 감고 머리속으로 상상만 하면 됩니다. 고고!",
        imageAssetPath: 'assets/images/d2_1.png',
      ),
      TI(
        text: "철수: \"내일은 첫 등교하는 날.\n준비물을 확실히 챙겨야해!!\"\n   ▽\n우리 함께 철수를 위해서 학교 준비물을 외워 봅시다.",
        imageAssetPath: 'assets/images/d2_4.png',
      ),
      TI(
        text: "머리부터 발까지 내려가며 각 신체부위에 준비물을 결합 할 것입니다.",
        imageAssetPath: 'assets/images/d2_3.png',
      ),
      TI(
        text: "다음 페이지부터 지시를 따르시면 됩니다.\n1.준비물이 뭔지 확인 한다.\n   ▽\n2.준비물과 결합할 자신의 신체부위를 확인한다.▽\n3.눈을 감고 준비물을 몸에 붙이는 상상을 한다.\n   ▽\n준비가 됐다면 다음을 눌러 시작해 봅시다!",
        animationFrames: [
          'assets/images/d1_3_1.png',
          'assets/images/d1_3_2.png',
          'assets/images/d1_3_3.png',
          'assets/images/d1_3_4.png'
        ],
      ),
      TI(
        text: "준비물1. 8절지 스케치북 - 머리\n   ▽\n스케치북을 8모양으로 잘라 내 머리에 붙였네요. 어허허허 이쁘죠.\n   ▽\n팔랑팔랑 거려요 펄렁 펄렁...$w",
        imageAssetPath: 'assets/images/d2_6.png',
      ).withSound('assets/sounds/paper.mp3'),
      TI(
        text: "준비물2. 드로잉 재료 - 눈\n   ▽\n드로잉재료를 이용해 눈을 크게 그렸군요. 눈썹도 찐하게 만들구요. 여자분들은 알아서 그리세요..$w",
        animationFrames: [
          'assets/images/d2_6_1.png',
          'assets/images/d2_6_2.png',
          'assets/images/d2_6_3.png',
          'assets/images/d2_6_4.png'
        ],
      ).withSound('assets/sounds/pencil.mp3'),
      TI(
        text: "준비물3. U모양 자석 - 콧구멍\n   ▽\n자석을 콧구멍에 꽂았더니 크허엏어어어크킁 정건기가꾸아아악. 팁 - 콧구멍에 손가락도 넣어보고, 감전된 것처럼 몸도 떨면 잘 외워집니다.(진짜)$w",
        animationFrames: [
          'assets/images/d2_7_1.png',
          'assets/images/d2_7_2.png'
        ],
      ).withSound('assets/sounds/lightning.mp3'),
      TI(
        text: "준비물4. 아주 가는 철사 - 입\n   ▽\n철사를 이용해서 입을 사이보그로 DIY했군요. 이빨모양- lllll. 윙~ 치킨 ~~ 윙윙치킨!! 냠냠냠 치킨$w",
        animationFrames: [
          'assets/images/d2_8_1.png',
          'assets/images/d2_8_2.png',
          'assets/images/d2_8_3.png'
        ],
      ).withSound('assets/sounds/robot.wav'),
      TI(
        text: "준비물5. 탬버린 - 목\n   ▽\n탬버린을 목에 걸다니..우와 왕년에 노래방가서 좀 흔드셨나봐요.$w",
        animationFrames: [
          'assets/images/d2_9_1.png',
          'assets/images/d2_9_2.png',
          'assets/images/d2_9_3.png'
        ],
      ).withSound('assets/sounds/tambourine.mp3'),
      TI(
        text: "준비물6. 등산용 양말 - 가슴\n   ▽\n양말을 연결해서 브라자를 만들어봐요.\n 킁크읔킁!!!! 그런데 꼬락내가 엄청 나네요.. 한번 이틀동안 신었던 양말냄새를 떠올려보세요. 으으..킁킁$w",
        imageAssetPath: 'assets/images/d2_10.png',
      ).withSound('assets/sounds/vomit.mp3'),
      TI(
        text: "준비물7. 점토 - 손\n   ▽\n점토를 손에 발라 왕주먹이 되었습니다. 철퍽철퍽~~ 쭈걱쭈걱 슥싹쓱싹??$w",
        imageAssetPath: 'assets/images/d2_11.png',
      ).withSound('assets/sounds/soil.mp3'),
      TI(
        text: "준비물8. 마이크 - 배\n   ▽\n배에 마이크를 붙였더니 꼬르륵 소리가 잘들리네요.\n여기서 실제로는 배가 손보다 위에 있는데요? 하시는 분들은 순서를 바꿔서 외워주세요.$w",
        imageAssetPath: 'assets/images/d2_12.png',
      ).withSound('assets/sounds/stomachgrowl.mp3'),
      TI(
        text: "준비물9. 해바라기 - 무릎\n   ▽\n무릎에 예쁜 해바라기를 달았네요. 해바라기들이 해를 바라보고 있네요.\n+9 해바라기 각반 장착!!$w",
        imageAssetPath: 'assets/images/d2_13.png',
      ).withSound('assets/sounds/EquipArmorDouble.mp3'),
      TI(
        text: "준비물10. 돋보기 - 발\n   ▽\n띠오잉~ 발이 크게 보여요.\n   ▽\n입으로 띠오잉 하고 효과음을 내셔야해요. 내셔야한다구요..",
        imageAssetPath: 'assets/images/d2_14.png',
      ).withSound('assets/sounds/woah.mp3'),
      TI(
        text: "<미션> 눈을 감고 머리부터 쭉 내려오며 준비물을 맞춰봅시다.\n\n(다음 페이지에는 정답이 있으니 조심) ",
        imageAssetPath: 'assets/images/d2_15.png',
      ),
      TI(
        text: "1.8절 스케치북\n   ▽\n2.드로잉 재료\n   ▽\n3.자석\n   ▽\n4.아주 가는 철사\n   ▽\n5.탬버린\n   ▽\n6.등산용 양말"
            "\n   ▽\n7.점토\n   ▽\n8.마이크\n   ▽\n9.해바라기\n   ▽\n10.돋보기\n   ▽\n여러분들 덕분에 철수가 선생님께 칭찬을 받았다고 합니다. 짝짝",
        imageAssetPath: 'assets/images/d1_30.png',
      ),
      TI(
        text: "하이파이브 한 번 하고 다음으로 갑시다.",
        imageAssetPath: 'assets/images/d2_16.png',
      ).withTouchSound(),
      TI(
        text: "혹시 다 못마추셨어도 실망하지 마세요. 우리는 점점 똑똑해지고 있습니다.\n준비물의 순서까지도 외우고 있습니다.\n유아 지니어스\n다음 단계에서 만나요!"
            "\n그리고 오감은 기억력의 일등공신입니다. 코찌르기, 양말냄새 상상하기!! 진짜 해보셨죠?? ",
        imageAssetPath: 'assets/images/d0_3.png',
      ),
    ];
  }
}
