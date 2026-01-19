/// TI (Text-Image) - 학습 슬라이드 데이터 모델
/// 기억의 궁전 앱의 핵심 데이터 구조
class TI {
  final String text;
  final String? imageAssetPath;
  final List<String>? animationFrames;
  final String? soundAssetPath;
  final int? alarmTimeInSeconds;
  final bool isHtml;
  final bool isYoutubeLink;
  final bool isTouchPage;
  final String? resultImageAssetPath;

  TI({
    required this.text,
    this.imageAssetPath,
    this.animationFrames,
    this.soundAssetPath,
    this.alarmTimeInSeconds,
    this.isHtml = false,
    this.isYoutubeLink = false,
    this.isTouchPage = false,
    this.resultImageAssetPath,
  });

  /// 타이머가 있는지 확인
  bool get hasTimer => alarmTimeInSeconds != null && alarmTimeInSeconds! > 0;

  /// 애니메이션이 있는지 확인
  bool get hasAnimation =>
      animationFrames != null && animationFrames!.isNotEmpty;

  /// 사운드가 있는지 확인
  bool get hasSound => soundAssetPath != null;

  /// 이미지가 있는지 확인
  bool get hasImage => imageAssetPath != null;

  /// 결과 이미지가 있는지 확인 (타이머 종료 후 보여줄 이미지)
  bool get hasResultImage => resultImageAssetPath != null;
}
