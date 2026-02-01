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
        imageAssetPath: 'assets/images/b_1.webp',
      ).withSound('assets/sounds/b_1.mp3').withSound('assets/sounds/b_2.mp3'),
      TI( //인덱스3
        text: "모바일뱅킹(미국달러도 비축)을 선택하셨습니다.\n   ▽\n응, 한국 전산망 파괴, USA 해외거래소 자금동결$arrow다음으로 가서 해결책을 찾아봅시다.",
        imageAssetPath: 'assets/images/b_2.webp',
      ).withSound('assets/sounds/trump.mp3'),
      TI( //인덱스4
        text: "이런.. 방법이 없을까요??\n   ▽\n혹시.. 돈을 기억의궁전에 숨길 수 있을까??",
        imageAssetPath: 'assets/images/d7_4.webp',
      ),
      TI( //인덱스5
        text: "맞습니다. 단어 24자리를 순서대로 외우면 됩니다. 종이하나 없이 뇌에 비트코인을 저장할수 있습니다.$arrow핵전쟁이 일어나도 우리 가족들을 안전하게 지켜줄 자산은 단연코 비트코인입니다.ㅇ\nd\nddd\nddd\nddd\nd\nddd\nddd\nddd",
        imageAssetPath: 'assets/images/bitcoin.webp',
      ),
      TI( //인덱스6
        text: "그 누구도 신뢰 하지 않는다. 검증한다. 비트코인의 핵심 철학입니다.",
        imageAssetPath: 'assets/images/b_5.webp',
      ).asHtml(),
      TI( //인덱스7
        text: "각자 검증해보세요. 기초적인 책, 유튜브 영상을 준비했습니다.<br>"+
        "책을 읽고 비트코인의 철학에 설득이 되셨다면, 기억의궁전과 함께 니모닉을 뇌속에 저장하세요. 대재난에도 돈의 주권을 지킬 수 있게 될 것입니다.$arrow_h"+
        "<br><a href='https://www.youtube.com/watch?v=bBC-nXj3Ng4'>비트코인 설명영상</a><br><br>"+
        "'구구' 찾아라. 비밀의문 열린다.",
        imageAssetPath: 'assets/images/b_6.webp',
      ).asHtml(),
    ];
  }
}
