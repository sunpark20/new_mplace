import '../models/ti.dart';

class Day1 {

  static List<TI> getTiArray() {
    return [
      TI( //인덱스1
        text: "졸르딕 가문의 남매 킬르아와 알르카가 전학을 왔습니다.$arrow졸르딕 가문은 엄격한 교육으로 유명한데요, 기억력도 뛰어 날까요?$arrow킬루아: 내일은 첫 등교하는 날\n\n알르카: 오빠 내 준비물 확실히 챙겨야해!!\"\n   ▽\n우리 함께 졸르딕 자매와 함께 학교 준비물을 외워 봅시다.",
        imageAssetPath: 'assets/images/d1_1.webp',
      ),
      TI( //인덱스2
        text: "머리부터 발까지 내려가며, 자신의 신체부위에 준비물을 결합 할 것입니다.",
        imageAssetPath: 'assets/images/d1_2.webp',
      ),
      TI( //인덱스3
        text: "다음 페이지부터 지시를 따르시면 됩니다.\n1.준비물을 확인한다.$arrow 2.준비물과 결합할 자신의 신체 부위를 떠올린다.$arrow 3.눈을 감고 준비물을 몸에 붙이는 상상을 한다.$arrow준비가 됐다면 다음을 눌러 시작해 봅시다!",
        animationFrames: [
          'assets/images/d1_3_1.webp',
          'assets/images/d1_3_2.webp',
          'assets/images/d1_3_3.webp',
          'assets/images/d1_3_4.webp'
        ],
      ),
      TI( //인덱스4
        text: "준비물1. 8절지 스케치북 - 머리\n   ▽\n알르카:스케치북을 8모양으로 잘라 머리에 붙였어. 이쁘죠. 에헤헤헤\n   ▽\n팔랑팔랑 거려요 팔랑!! 팔랑팔랑!!",
      ).withInlineVideo('assets/videos/d1_4.mp4').withOverlayText("반드시 눈을 감고 자신의 몸에 붙이는\n 상상을 하고 넘어가자"),
      TI( //인덱스5
        text: "준비물2. 드로잉 재료 - 눈\n   ▽\n드로잉 재료로 킬르아 눈을 멋지게 꾸며주네요!!!",
      ).withInlineVideo('assets/videos/d1_5.mp4').withOverlayText("반드시 눈을 감고 자신의 몸에 붙이는\n 상상을 하고 넘어가자"),
      TI( //인덱스6
        text: "준비물3. U모양 자석 - 콧구멍\n   ▽\n킬르아: 저언기 정언기가 크허엏어어어크킁 정건기가꾸아아악.\n알르카:콧구멍에 손가락도 넣어보고, 감전된 것처럼 몸도 떨면 잘외울수 있어!!",
      ).withInlineVideo('assets/videos/d1_6.mp4').withOverlayText("반드시 눈을 감고 자신의 몸에 붙이는\n 상상을 하고 넘어가자"),
      TI( //인덱스7
        text: "준비물4. 아주 가는 철사 - 입\n   ▽\n킬르아: 알르카~~ 내가 교정해줄게~~~ 아~~~~",
      ).withInlineVideo('assets/videos/d1_7.mp4').withOverlayText("반드시 눈을 감고 자신의 몸에 붙이는\n 상상을 하고 넘어가자"),
      TI( //인덱스7_5
        text: "이런.. 킬르아와 알르카의 아빠 회사에 문제가 생겼나봐요.\n다른곳으로 전학을 간다고 합니다. 킬르아 알르카 안녕~~~~\n다음장부터는 철수가 준비물을 챙기는데 도움을 준다고 해요",
        imageAssetPath: 'assets/images/d1_7_5.webp',
      ),
      TI( //robot
        text: "준비물4. 아주 가는 철사 - 입\n   ▽\n어.. 철수야 벌써 [아주가는철사]는 챙겼어. 음.. 한번 더 외우며 좋죠 머\n   ▽\n철수: 윙 치킨치킨~~ 위잉~ 치퀸",
        animationFrames: [
          'assets/images/d1_robot1.webp',
          'assets/images/d1_robot2.webp',
          'assets/images/d1_robot3.webp'
        ],
      ).withSound('assets/sounds/robot.wav').withOverlayText("반드시 눈을 감고 자신의 몸에 붙이는\n 상상을 하고 넘어가자"),
      TI( //인덱스8
        text: "준비물5. 탬버린 - 목\n   ▽\n탬버린을 목에 걸다니..우와 철수 노래방에 많이 가봤구나",
        animationFrames: [
          'assets/images/d1_9_1.webp',
          'assets/images/d1_9_2.webp',
          'assets/images/d1_9_3.webp'
        ],
      ).withSound('assets/sounds/tambourine.mp3').withOverlayText("반드시 눈을 감고 자신의 몸에 붙이는\n 상상을 하고 넘어가자"),
      TI( //인덱스9
        text: "준비물6. 등산용 양말 - 가슴\n   ▽\n양말을 연결해서 브라자를 만들어봐요.\n 킁크읔킁!!!! 그런데 꼬락내가 엄청 나네요.. 한번 이틀동안 신었던 양말냄새를 떠올려보세요. 으으..킁킁",
        imageAssetPath: 'assets/images/d1_10.webp',
      ).withSound('assets/sounds/vomit.mp3').withOverlayText("반드시 눈을 감고 자신의 몸에 붙이는\n 상상을 하고 넘어가자"),
      TI( //인덱스10
        text: "준비물7. 점토 - 손\n   ▽\n점토를 손에 발라 왕주먹이 되었습니다. 철퍽철퍽~~ 쭈걱쭈걱 슥싹쓱싹??",
        imageAssetPath: 'assets/images/d1_11.webp',
      ).withSound('assets/sounds/soil.mp3').withOverlayText("반드시 눈을 감고 자신의 몸에 붙이는\n 상상을 하고 넘어가자"),
      TI( //인덱스11
        text: "준비물8. 마이크 - 배\n   ▽\n배에 마이크를 붙였더니 꼬르륵 소리가 잘들리네요.\n여기서 실제로는 배가 손보다 위에 있는데요? 하시는 분들은 알아서 외우세요 흥",
        imageAssetPath: 'assets/images/d1_12.webp',
      ).withSound('assets/sounds/stomachgrowl.mp3').withOverlayText("반드시 눈을 감고 자신의 몸에 붙이는\n 상상을 하고 넘어가자"),
      TI( //인덱스12
        text: "준비물9. 해바라기 - 무릎$arrow_h무릎에 예쁜 해바라기를 달았네요. 해바라기들이 해를 바라보고 있네요.\n<span style='color: #ff8000; font-weight: bold;'>+9 해바라기 각반</span> 장착!!",
        imageAssetPath: 'assets/images/d1_13.webp',
      ).asHtml().withSound('assets/sounds/EquipArmorDouble.mp3').withOverlayText("반드시 눈을 감고 자신의 몸에 붙이는\n 상상을 하고 넘어가자"),
      TI( //인덱스13
        text: "준비물10. 돋보기 - 발\n   ▽\n띠오잉~ 발이 크게 보여요.\n   ▽\n입으로 띠오잉 하고 효과음을 내셔야해요. 내셔야한다구요..",
        imageAssetPath: 'assets/images/d1_14.webp',
      ).withSound('assets/sounds/woah.mp3').withOverlayText("반드시 눈을 감고 자신의 몸에 붙이는\n 상상을 하고 넘어가자"),
      TI( //인덱스14
        text: "<미션> 눈을 감고 머리부터 쭉 내려오며 준비물을 맞춰봅시다.\n\n(다음 페이지에는 정답이 있으니 조심) ",
        imageAssetPath: 'assets/images/d1_15.webp',
      ),
      TI( //인덱스15
        text: "1.8절 스케치북\n   ▽\n2.드로잉 재료\n   ▽\n3.자석\n   ▽\n4.아주 가는 철사\n   ▽\n5.탬버린\n   ▽\n6.등산용 양말"
            "\n   ▽\n7.점토\n   ▽\n8.마이크\n   ▽\n9.해바라기\n   ▽\n10.돋보기\n   ▽\n여러분들 덕분에 철수가 선생님께 칭찬을 받았다고 합니다. 짝짝",
        imageAssetPath: 'assets/images/d1_30.webp',
      ).withRepeatSound('assets/sounds/mobak.mp3', 'assets/sounds/danbak.mp3', 99,
        completionSound: 'assets/sounds/ClanInvitation.wav',
        popupTitle: '히든조건 달성',
        popupButtonText: '시타델 가입링크',
        popupLink: 'https://discord.com/invite/gfWYEFkDPd',
      ),
      TI( //인덱스16
        text: "하이파이브 한 번 하고 다음으로 갑시다.",
        imageAssetPath: 'assets/images/palm.webp',
      ).withTouchSound().withCrackTransform(
        cracks: ['assets/images/crack1.webp', 'assets/images/crack2.webp'],
        thresholds: [33, 66],
        transformAt: 99,
        transformTo: 'assets/images/citadel.webp',
        sound: 'assets/sounds/ClanInvitation.wav',
        effect: TransformEffect.fadeIn,
        popupTitle: '히든조건 달성',
        popupButtonText: '시타델 가입링크',
        popupLink: 'https://discord.com/invite/gfWYEFkDPd',
      ),
      TI( //인덱스17
        text: "오감은 기억력의 일등 공신입니다.$arrow손가락으로 코찌르기, 양말냄새 상상하기!! 진짜 하신거죠??\n혹시 다 못마추셨어도 실망하지 마세요.\n우리는 준비물의 순서까지도 외우고 있습니다!$arrow다음 단계에서 연습해보자구요!",
        imageAssetPath: 'assets/images/d1_f.webp',
      ),
    ];
  }
}
