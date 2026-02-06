import '../models/ti.dart';
const String arrow ="\n   ▽\n";
const String arrow_h = "<br>&nbsp;&nbsp;&nbsp;▽<br>";
class Day42 {

  static List<TI> getTiArray() {
    return [
      TI( //인덱스1
        text: "A)하루에 20~30분 정도 꾸준히 연습하세요. 일단 장소부터 확실하게 확보하세요.\n"
            "저는 일부러 어릴적 살던 곳을 찾아가고, 추억의 사진을 들춰보며 장소를 떠올렸습니다.\n"
            "또 여행을 다녀오면 꼭 그곳을 이용해서 기억의 궁전을 만들고 이상한 것들을 외웁니다."
            "$arrow눈을 감고 머리속을 돌아다니고 있지만,\n"+
            "아이러니하게 모든것을 의미있게 바라보게 되더라구요.",
        imageAssetPath: 'assets/images/d5_2.webp',
      ),
      TI( //인덱스2
        text: "제가 방을 돌아다니는 팁입니다. 'day2'에 나왔던 체인입니다.\n"
            "1번 방에 이미지를 결합 -> 2번 방까지 이미지를 결합합니다. 뒤돌아서 1번방 확인하고 3번으로 진행.\n"+
            "마지막 이미지까지 결합했다면, 끝에서 처음 역순으로 한번 더 방을 확인합니다.\n"
            "<<정리>>\n   ▽\n처음부터 끝까지 뒤돌아보며 진행"
            "\n   ▽\n끝에서 처음까지 다시 한번 걸어간다"
            "\n   ▽\n이게 저의 한 세트입니다. 체인으로 정보 두개를 엮으면 단기 기억에 도움이 됩니다.",
        imageAssetPath: 'assets/images/chain.webp',
      ),
      TI( //인덱스4
        text: "에빙하우스의 <a href='https://ko.wikipedia.org/wiki/%EB%A7%9D%EA%B0%81_%EA%B3%A1%EC%84%A0'>망각곡선</a>입니다."+
            "사람마다 효과적인 복습주기는 다릅니다. 자신에게 맞는 복습주기를 찾아보세요.<br>"+
            "저같은 경우엔 학습 직후, 24시간, 1주, 1달, 3달후 주기로 복습합니다.<br>"+
            "너무 자주 반복하는것도 좋지 않습니다.<br>잊었다 끄집어내려 애쓸 때, 뇌의 신경회로는 더 굵고 튼튼하게 연결됩니다.<br>"+
            "뇌의 신경가소성을 알아보세요 <a href='https://product.kyobobook.co.kr/detail/S000000886599?utm_source=google&utm_medium=cpc&utm_campaign=googleSearch&gt_network=g&gt_keyword=&gt_target_id=dsa-1544589326563&gt_campaign_id=9979905549&gt_adgroup_id=132556570510&gad_source=1'>기적을 부르는 뇌</a>",
        imageAssetPath: 'assets/images/d5_3.webp',
      ).asHtml(),
      TI( //인덱스5
        text: "두번째 질문이네요.\n방을 쪼개는 방법이 있습니다. 다음장으로 가봅시다.",
        imageAssetPath: 'assets/images/d5_4.webp',
      ),
      TI( //인덱스6
        text: "방에 들어갔을 때, 정면에 보이는 것은 베란다 창문입니다.<br>이 곳을 기준으로 시계 방향으로 돕니다.<br>"+
            "텔레비전, 책상, 침대를 거쳐 다시 베란다 창문으로 돌아오면, 다시 방을 빠져나갑니다.<br>"+
            "공간이 4개로 늘어났죠. 상상속에선 무엇이든 가능합니다.<br><br>"+
            "용은 무엇이든지 될 수 있어 <a href='https://product.kyobobook.co.kr/detail/S000001277555'>-피를 마시는 새-</a>",
        imageAssetPath: 'assets/images/d5_5.webp',
      ).asHtml(),
      TI( //인덱스7
        text: "다른 궁전을 점프하는 팁입니다.\n마지막 장소에 빛의 기둥을 만드세요. 그리고 그 옆엔 단서를 놔둡니다.\n"
            "<<예>>\n집 뒷산 정상까지 올라갔다.$arrow그곳에 빛의 기둥을 세우고 내가 좋아하는 도미를 놔뒀다.$arrow빛의 기둥에 다가가니 슈우우우웅~ 도미를 파는 해운대 회센터로 왔다. 띠옹..",
        imageAssetPath: 'assets/images/d5_6.webp',
      ).withSound('assets/sounds/shsh.mp3'),
      TI( //인덱스8
        text: "꾸준히 기억의 궁전을 하시다 보면 자신만의 비법이 생길거에요.\n"+
            "이렇게 하니까 잘 안외워지네. 아 이런건 잘 외워지네~\n"+
            "제가 가르쳐주는 팁들이 잘 맞으면 참고하시고 아니라면 버리면 됩니다.",
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
      )
    ];
  }
}
