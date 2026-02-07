import '../models/ti.dart';
const String arrow ="\n   ▽\n";
const String arrow_h = "<br>&nbsp;&nbsp;&nbsp;▽<br>";
class Day5FC {

  static List<TI> getTiArray() {
    return [
      //영화21 포스터 소개: 카드 카운팅
      //수학자 에드워드 소프 소개: 블랙잭/ 룰렛을 정복하고 세상에서 가장 큰 카지노인 주식시장을 정복한 사람
      //

      
      //카드를 외우는 방법

      //"죠슈아 포어 기술 <a href='https://archive.nytimes.com/www.nytimes.com/interactive/2011/02/20/magazine/mind-secrets.html?_r=0'>죠수아포어의팁</a> 기사입니다.(영어)"
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
