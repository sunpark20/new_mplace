import '../models/ti.dart';

class Day0 {
  const String arrow ="\n   ▽\n";
  const String arrow_h = "<br>&nbsp;&nbsp;&nbsp;▽<br>";
  static List<TI> getTiArray() {
    return [
      TI(
        text: "'기억의 궁전'에 대한 기록은 기원전 86년, 로마 시대의 그리스 문헌에서 찾아볼 수 있습니다.$arrow기록 매체가 귀했던 고대 사회에서, 웅변이나 연설을 하기 위해 기억술은 선택이 아닌 필수였습니다.",
        imageAssetPath: 'assets/images/d0_5.png',
      ),
      TI(
        text: "동물은 직감적으로 공간을 기억합니다.<br>   ▽<br>뇌에는 공간을 인지하는 Hippocampus(해마)가 있습니다.<br>   ▽<br>"+
            "<a href='https://namu.wiki/w/%ED%95%98%EC%96%80%EB%A7%88%EC%9D%8C%20%EB%B0%B1%EA%B5%AC'>하얀 마음 백구</a>가 대전으로 팔려갔다가, 300km를 달려 다시 집을 찾아온 이야기 아시죠?(알면 아제)<br>",
        imageAssetPath: 'assets/images/d0_2.png',
      ).asHtml(),
      TI(
        text: "프로 기억력 선수라는게 있어요<br>   ▽<br>옥스포드 사전의 6만개 단어의 뜻을 암기하고, <a href='https://www.guinnessworldrecords.com/world-records/most-pi-places-memorised'>7만자리의 원주율값</a>을 순서대로 외운답니다."+
            "<br>&nbsp;&nbsp;&nbsp;▽<br>서번트, 포토메모리가 아닌 평범한 우리도 기억의궁전으로 할 수 있어요!",
        imageAssetPath: 'assets/images/d0_1.png',
      ).asHtml(),
      TI(
        text: "기억력 대회 취재를 간<br><span style='color: red; font-size: 23px;'>   평범한</span> 기자의 ted 강연입니다.$arrow_h(나중에 보셔도 됩니다)",
      ).asHtml().asYoutubeLink(),
      TI(
        text: "기억의 궁전과 특별한 여정을 떠나봅시다.\n기억력 원정대 출발",
        imageAssetPath: 'assets/images/hobbit1.webp',
      ).withTouchSound(),
    ];
  }
}
