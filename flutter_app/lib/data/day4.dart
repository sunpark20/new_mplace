import '../models/ti.dart';

class Day4 {
  static List<TI> getTiArray() {
    return [
      TI( //인덱스1
          text: "오늘은 숫자를 언어로 바꿔볼거예요.$arrow_h"+
              "day2의 숫자를 이미지로 상상했을 때보다 훨씬 효율적입니다$arrow_h"+
              "먼저 숫자를 한글의 자음으로 변환합니다.$arrow_h"+
              "그리고 자음을 인물로 변환하고 기억의 궁전에 배치합니다. 뭔 말인가 싶죠?? 다음으로 가봅시다!"+
              "<a href='https://q5m5vh7kjn-cyber.github.io/mplace/'>도미니크 오브라이언</a>",
          imageAssetPath: 'assets/images/d4_dominik.webp',
      ).asHtml(),
      TI( //인덱스2
        text: "1648년 독일의 \"J.winkelann\"에 의해서 숫자의 자음화가 시작되었고, 지금까지 계속 발전해왔습니다."+ 
            "$arrow 순서대로 1234숫자에 가나다라 한글을 순서대로 맞추면 됩니다. 지금 당장 외울 필요는 없습니다.\n"
            "손가락을 접으며 기역..니은..디귿..하고 말해보면 순서를 알아낼 수 있으니깐요.\n"
            "숫자는 뜻이 없고 추상적이기 때문에 기억하기 어렵습니다. 어떻게 해야 하면 좋을까요?",
        imageAssetPath: 'assets/images/d4_num.webp',
      ),
      TI( //인덱스3
        text: "숫자 -> 자음  -> 초성에 맞춰 인물을 생각한다. 2자 이상도 괜찮습니다.$arrow술자리에서 하는 초성게임과 유사합니다. 무슨 단어로도 바꿀 수 있지만, 사람으로 바꾸는 것을 추천드립니다."
            "$arrow왜냐하면 사람마다 차이점과 특징이 명확하게 구분되기 때문입니다.",
        imageAssetPath: 'assets/images/sinse.webp',
      ),
      TI( //인덱스4
        text: "숫자를 글자로 바꾸고 이미지로 바꿔주시면 됩니다.$arrow한번 슥 읽어보시고 다음으로 가서 여러분만의 이미지를 만들어봅시다.\n"
            "60 - 야구선수 박찬호, LA다저스 모자를 쓰고 쉴세 없이 떠든다 TMT\n"
            "61 - 피카피카!!! 가랏 백만볼트!!!\n"
            "62 - 파랑 수달 보노보노가 조개를 양손에 들고 슝슝슝 효과음이 나며 땀을 흘린다.\n"
            "63 - 배트맨이 양손을 뒤집어까서 박쥐 안경을 만든다. 배트맨~~\n"
            "64 - 롤 캐릭터, 긴팔을 뻗어 상대를 뽑아온다. 특유의 슁 로봇소리\n"
            "65 - 박명수가 우이쒸 하고 화를 냅니다.\n"
            "66 - 롤 캐릭터, 뽀삐가 R 망치로 적을 날려버립니다.\n"
            "67 - 박세리가 바지를 걷어붙이고 호수옆에 빠진 골프공을 쳐올립니다.\n"
            "68 - 롤 캐릭터, 베이가가 R을 날립니다. 펑!!\n"
            "69 - 배지환은 제 사촌동생입니다. 이건 아무도 못써먹겠네요..,"
            "\n   ▽\n명심하세요. 자신이 제일 처음 떠올린 이미지가 가장 강력한 기억입니다.",
        imageAssetPath: 'assets/images/d4_60.webp',
      ),
      TI( //인덱스5
        text: "명심하세요. 머리속에 띠옹 하고 떠오른 이미지. 그게 가장 강력한 기억이자, 다음번에도 떠올릴 기억입니다.",
        imageAssetPath: 'assets/images/d4_q1.webp',
      ).withAlarm(10 * 60),
      TI( //인덱스6
        text: "기억의궁전(공간)을 확보하지 못했다면, 산책을 한번 갔다와서 집주변 기억의궁전을 만들고 돌아오세요.\n",
        imageAssetPath: 'assets/images/d4_q2.webp',
      ).withAlarm(8 * 60),
      TI( //인덱스8
        text: "잘 외우셨나요?? 저는 숫자를 인물로 바꿀 때 엄청 오래걸렸습니다.$arrow"+
        "어릴적 하던 게임도 생각해보고, 웹에서 여러 연예인의 사진도 찾아봤습니다.",
        imageAssetPath: 'assets/images/d4_wayPoint.webp',
      ),
      TI( //인덱스6
        text: "잘하셨어요!!! 머리 쓰는것도 몸을 쓰는 헬스만큼이나 어렵죠?$arrow이제 숫자에 좀 친숙해질 것 같죠?? 꾸준함과 끈기!!!!",
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
    ];
  }
}
