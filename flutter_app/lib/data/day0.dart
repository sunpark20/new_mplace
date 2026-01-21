import '../models/ti.dart';

class Day0 {
  static List<TI> getTiArray() {
    return [
      TI(
        text: "'기억의 궁전'에 대한 기록은 기원전 86년, 로마 시대의 그리스 문헌에서 찾아볼 수 있습니다. 기록 매체가 귀했던 고대 사회에서, 웅변이나 연설을 하기 위해 기억술은 선택이 아닌 필수였습니다. 이처럼 기억술은 인류의 역사와 함께 발전해 왔습니다.",
        imageAssetPath: 'assets/images/d0_5.png',
      ),
      TI(
        text: "동물은 직감적으로 방향과 위치를 알고 있습니다. 뇌에는 위치를 인지하는 영역과 세포가 있습니다. 장소를 이용한 기억법이 바로 '기억의 궁전' 입니다." +
            "\n하지만 이건 '짠' 하고 저절로 외워지는 마법은 아닙니다. 마치 헬스장에서 근육을 키우듯, '기억의 궁전' 또한 꾸준한 훈련이 필요합니다." +
            "<a href='https://namu.wiki/w/%ED%95%98%EC%96%80%EB%A7%88%EC%9D%8C%20%EB%B0%B1%EA%B5%AC'>하얀 마음 백구</a>가 대전으로 팔려갔다가, 300km를 달려 다시 집을 찾아온 이야기 아시죠?<br>",
        imageAssetPath: 'assets/images/d0_2.png',
      ).asHtml(),
      TI(
        text: "프로 기억력 선수들과 '기억의궁전'을 배운 많은 사람들이 기억술의 힘을 증명하고 있습니다.\n" +
            "학교에서 성적을 잘 받거나, 마트에서 살 물건외우기 등 생활에 도움이 되는 것부터 시작해서" +
            "옥스포드 사전의 6만개 단어의 뜻을 암기하고, <a href='https://www.guinnessworldrecords.com/world-records/most-pi-places-memorised'>7만자리의 원주율값을 순서대로 외우는</a> 괴물같은 능력을 보여주고 있습니다.",
        imageAssetPath: 'assets/images/d0_1.png',
      ).asHtml(),
      TI(
        text: "특별한 사람들의 이야기 같나요?? 기억력대회를 취재하러 갔다가, 1년만에 미국기억력 챔피언이 된.  <span style='color: red; font-size: 23px;'>평범한</span 기자의 ted 강연입니다.\n   ▽\n나중에 보셔도 됩니다. 데이터조심!",
      ).asYoutubeLink(),
       TI(
        text: "핸드폰으로 슥쑉 AI로 쇽쇽 하면 되는 세상에서 왜 기억법을 배워야할까요?? 뇌에 근접해가고 있는 AI이지만 아직은 인간의 뇌처럼 정보를 연결하고 기억을 빼쓰진 못합니다. 뇌의 가능성은 무한합니다. 장소를 자주 찾아야 하는 런던 택시기사의 뇌의 해마는 일반인 3배 정도로 큽니다. 또한 한 실험에서 일반인이 기억력대회 종목을 연습한 결과 뇌에 새로운 연결경로가 생겼다는 <a href='https://pmc.ncbi.nlm.nih.gov/articles/PMC5439266/'>논문</a>이 뇌의 가능성을 뒷바침해줍니다.",
        imageAssetPath: 'assets/images/d4_1.png',
      ).asHtml(),
      TI(
        text: "천재?특별한능력??? 아닙니다. 본격적으로 기억의 궁전을 만들어봅시다. 레츠고!",
        imageAssetPath: 'assets/images/d0_4.png',
      ),
    ];
  }
}
