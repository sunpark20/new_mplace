import '../models/ti.dart';
const String arrow ="\n   ▽\n";
const String arrow_h = "<br>&nbsp;&nbsp;&nbsp;▽<br>";
class Day7Mnemonic {
  static List<TI> getTiArray() {
    return [
      TI( //인덱스1
        text: "핵전쟁이 일어났습니다. 가족과 함께 떠나야합니다. 어떤 방법으로 자금을 챙기시겠습니까?",
        imageAssetPath: 'assets/images/b_a.webp',
      ).withAutoFullscreenVideo('assets/videos/nuclear.mp4').withChoices([
        Choice("순금바", 1),
        Choice("현금", 1),
        Choice("모바일뱅킹 하면됨", 2),
        Choice("이럴줄 알고 미국달러통장 만들어놓음", 2),
      ]),
      TI( //인덱스2
        text: "순금바, 현금을 선택하셨습니다.\n   ▽\n응, 국경에서 다 압수$arrow다음으로 가서 해결책을 찾아봅시다.",
        imageAssetPath: 'assets/images/d7_boundary.webp',
      ).withSound('assets/sounds/b_1.mp3').withSound('assets/sounds/b_2.mp3'),
      TI( //인덱스3
        text: "모바일뱅킹(미국달러도 비축)을 선택하셨습니다.\n   ▽\n응, 한국 전산망 파괴, USA 해외거래소 자금동결$arrow다음으로 가서 해결책을 찾아봅시다.",
        imageAssetPath: 'assets/images/d7_trump.webp',
      ).withSound('assets/sounds/trump.mp3'),
      TI( //인덱스4
        text: "아니.. 다람쥐 선생님 그게 무슨 소리죠??",
        imageAssetPath: 'assets/images/d7_sq.webp',
      ),
      TI( //인덱스5
        text: "월동 준비!!! 바쁘다.\n"+
              "자세한건 나중에 동영상 봐, 내가 짧게 설명해주지\n"+
              "비트코인의 주소는 내가 모은 도토리 수 만큼이나 많지",
        imageAssetPath: 'assets/images/d7_address2.webp',
      ),
      TI( //인덱스5
        text: "이건 또 다른 친구가 준 팜플렛인데 그냥 버리기 아까워서 넣었다네\n"+
              "조금 다른데 비슷하다네\n"+
              "비트코인의 주소는 내가 모은 도토리 수 만큼이나 많지 허허",
        imageAssetPath: 'assets/images/d7_address.webp',
      ),
      TI( //인덱스5
        text: "자넨 졸업생이니 더이상 <미션>은 안하겠네. 우린 이런거 5분안에 다 외우지 않나?<br>"+
              "이 주소는 <a href='https://github.com/bitcoin/bips/blob/master/bip-0039/english.txt'>bip-0039</a>를 이용해 단어 24로 나타낼 수 있지<br>"+
              "이해가 안간다구? 일단 단어 24개(순서대로)를 외우면 된다고 알고 있게나",
        imageAssetPath: 'assets/images/d7_24word.webp',
      ).asHtml(),
      TI( //인덱스6
        text: "그 누구도 신뢰 하지 않는다. 검증한다. 비트코인의 핵심 철학이네.",
        imageAssetPath: 'assets/images/d7_trust.webp',
      ).asHtml(),
      TI( //인덱스7
        text: "각자 비트코인을 검증해보시게나. 기초적인 책, 유튜브 영상을 준비했다네.<br>"+
        "대빙하기에도 도토.. 아니 돈의 주권을 지킬 수 있게 될거야$arrow_h"+
        "<br><a href='https://www.youtube.com/watch?v=bBC-nXj3Ng4'>비트코인 설명영상</a><br><br>"+
        "'구구' 찾아라. 비밀의문 열린다.",
        imageAssetPath: 'assets/images/d7_dalas.webp',
      ).asHtml(),
    ];
  }
}
