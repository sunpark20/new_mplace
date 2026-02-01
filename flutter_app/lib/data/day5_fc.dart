import '../models/ti.dart';
const String arrow ="\n   ▽\n";
const String arrow_h = "<br>&nbsp;&nbsp;&nbsp;▽<br>";
class Day5FC {

  static List<TI> getTiArray() {
    return [
      TI( //인덱스1
        text: "오늘은 기억의궁전에 관한 질문들에 답변해드릴께요. 마지막엔 꾸준히 해야 할 숙제도 있습니다.",
        imageAssetPath: 'assets/images/d5_1.webp',
      ),
      TI( //인덱스2
        text: "A)하루에 20~30분 정도 꾸준히 연습하세요. 일단은 장소부터 확실하게 확보해야 합니다.\n저도 기억의 궁전을 만들기 위해서"
            " 사진을 찍으며 동내를 걸어다니고, 옛날 살던 곳을 찾아간 적도 있습니다."
            " 또 여행을 다녀오면 꼭 그곳을 이용해서 기억의 궁전을 만들고 이상한 것들을 외운답니다.",
        imageAssetPath: 'assets/images/d5_2.webp',
      ),
      TI( //인덱스3
        text: "제가 쓰는 팁을 몇개 더 알려드릴께요.\n"
            "'day2-상상하기' 에서 나왔던 체인입니다.\n"
            "1번 방에 이미지를 결합하고 2번 방까지 이미지를 결합합니다. 그리고 뒤를 돌아봅니다."
            " 뒤돌아서 이전 방을 한번 더 확인하는 것입니다. 속도는 느려지겠지만, 도움이 됩니다. "
            " 그리고 마지막 이미지까지 넣었다면, 끝에서 처음으로 가며 한번 더 방을 확인합니다."
            "\n   ▽\n처음부터 끝까지 돌아보며 진행"
            "\n   ▽\n끝에서 처음까지 다시 한번 걸어간다"
            "\n   ▽\n이게 저의 한 세트입니다.",
        imageAssetPath: 'assets/images/chain.webp',
      ),
      TI( //인덱스4
        text: "에빙하우스의 <a href='https://ko.wikipedia.org/wiki/%EB%A7%9D%EA%B0%81_%EA%B3%A1%EC%84%A0'>망각곡선</a>입니다. \n\n"
            "사람마다 효과적인 복습주기는 다릅니다. 자신에게 맞는 복습주기를 찾는다면 학습에 도움이 될 것입니다. "
            "저같은 경우엔 학습 직후, 24시간, 1주, 1달, 3달후 주기로 복습합니다. \n"
            "실험을 해보시면 재밋습니다. 어떤 조건에서 더 기억이 잘났는지, 어떤 주기로 외우면 좋을지 알 수 있습니다.",
        imageAssetPath: 'assets/images/d5_3.webp',
      ).asHtml(),
      TI( //인덱스5
        text: "두번째 질문이네요. 방을 쪼개는 방법이 있습니다. 다음 그림을 보며 이야기 합시다.",
        imageAssetPath: 'assets/images/d5_4.webp',
      ),
      TI( //인덱스6
        text: "방에 들어갔을 때, 정면에 보이는 것은 베란다 창문입니다. 이 곳을 기준으로 시계 방향으로 돕니다. 텔레비전, 책상, 침대를 거쳐 다시 베란다 창문으로 오게 되면"
            " 방을 빠져 나갑니다. 이미지를 저장할 수 있는 공간이 4개로 늘어났죠. 방향마다 특색이 있는 공간이라면 빙 둘러보며 많은 장소를 확보할 수 있습니다.",
        imageAssetPath: 'assets/images/d5_5.webp',
      ),
      TI( //인덱스7
        text: "긴 궁전을 만드는 두번째 팁입니다. 머리속에선 뭐든지 가능합니다. 마지막 장소에 빛의 기둥을 만드세요. 그리고 그 옆엔 단서를 놔둡니다.\n"
            "예)집 뒷산 정상까지 올라갔다. 그곳에 빛의 기둥을 세우고 내가 좋아하는 도미를 놔뒀다. 빛의 기둥에 다가가니 슈우우우웅~ 도미를 파는 해운대 회센터로 왔다. 여기부터 방을 만들며 이어 간다.",
        imageAssetPath: 'assets/images/d5_6.webp',
      ).withSound('assets/sounds/shsh.mp3'),
      TI( //인덱스8
        text: "꾸준히 기억의 궁전을 하시다 보면 자신만의 비법이 생길거에요. \"이렇게 하니까 잘 안외워지네. 아 이런건 잘 외워지네~\"\n"
            "제가 가르쳐주는 팁들이 잘 맞으면 참고하시고 아니라면 버리면 됩니다.",
        imageAssetPath: 'assets/images/d2_16.webp',
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
      TI( //인덱스9
        text: "0~99까지 숫자를 자음화->인물로 변환(day4)해서 기억의 궁전으로 외우시면 됩니다."
            "(0~9, 00~99)\n"
            "다음장으로 가서 자세한 설명을 봅시다.",
        imageAssetPath: 'assets/images/d5_8.webp',
      ),
      TI( //인덱스10
        text: "대한민국의 자랑스러운 마라토너 이봉주씨입니다. 이봉주씨는 숫자 (ㅇ)8 (ㅂ)6이 되겠죠. 중요한 점은 행동이나 특징을 같이 외워야 합니다."
            " 마라톤을 하는 행동. 선글라스와 스포츠 목걸이. 신체적 특징인 쌍거풀 수술한 눈. 등의 행동이나 특징을 함께 외울 수 있습니다."
            " 특징이나 행동은 상세한 정보로 이미지 기억에 도움이 될 것입니다. 그리고 다음 장에서 PAO 시스템에서 특징이나 행동을 사용하게 됩니다."
            " 비슷한 특징이나 행동을 가진 인물은 헷갈리겠죠. 최대한 다른 종류 인물들로 채워봅시다.",
        imageAssetPath: 'assets/images/d5_9.webp',
      ),
      TI( //인덱스11
        text: "100개가 넘는 기억의 궁전을 만들고 저것들을 외우고 나면, 숫자 외우기는 식은 죽 먹기가 될 것입니다. 또한 기억의 궁전 기본기가 탄탄해지게 될 것입니다."
            "화이팅!! 자 그럼 오늘부터 차근차근 자신만의 인물을 만들어 보는겁니다.\n제가 사용하는 인물-숫자 샘플 day5 오른쪽에 있습니다. 참고$arrow_h"+
            "<span style='color: red; font-size: 23px;'>100개의 기억의궁전을 확보하고, 0~99 숫자를 자신만의 캐릭터로 외우세요. 이 100개의 방은 숫자외우기의 탄탄한 기초가 될것입니다.</span> ",
        imageAssetPath: 'assets/images/d5_8.webp',
      ).asHtml(),
    ];
  }
}
