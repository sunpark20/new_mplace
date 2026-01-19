/// Item - 숫자-인물 변환 시스템 데이터 모델
/// 00-99까지의 숫자를 인물로 변환하는 PAO 시스템
class Item {
  final String name; // 인물 이름
  final String cha; // 특징/캐릭터
  final String des; // 설명

  Item({
    required this.name,
    required this.cha,
    required this.des,
  });
}
