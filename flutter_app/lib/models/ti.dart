/// 선택지 클래스 - 분기 처리에 사용
/// [label]: 버튼에 표시될 텍스트
/// [targetIndex]: 선택 시 이동할 TI 배열의 인덱스
/// [videoPath]: 선택 시 재생할 동영상 경로 (옵션, 가로모드 풀스크린 재생)
class Choice {
  final String label;
  final int targetIndex;
  final String? videoPath;

  Choice(this.label, this.targetIndex, {this.videoPath});
}

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
  final bool hasTouchSound;
  final String? overlayText;
  final List<Choice>? choices;

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
    this.hasTouchSound = false,
    this.overlayText,
    this.choices,
  });

  TI withAnimation(List<String> frames) {
    return TI(
      text: text,
      imageAssetPath: imageAssetPath,
      animationFrames: frames,
      soundAssetPath: soundAssetPath,
      alarmTimeInSeconds: alarmTimeInSeconds,
      isHtml: isHtml,
      isYoutubeLink: isYoutubeLink,
      isTouchPage: isTouchPage,
      resultImageAssetPath: resultImageAssetPath,
      hasTouchSound: hasTouchSound,
      overlayText: overlayText,
      choices: choices,
    );
  }

  TI withSound(String sound) {
    return TI(
      text: text,
      imageAssetPath: imageAssetPath,
      animationFrames: animationFrames,
      soundAssetPath: sound,
      alarmTimeInSeconds: alarmTimeInSeconds,
      isHtml: isHtml,
      isYoutubeLink: isYoutubeLink,
      isTouchPage: isTouchPage,
      resultImageAssetPath: resultImageAssetPath,
      hasTouchSound: hasTouchSound,
      overlayText: overlayText,
      choices: choices,
    );
  }

  TI withTouchSound() {
    return TI(
      text: text,
      imageAssetPath: imageAssetPath,
      animationFrames: animationFrames,
      soundAssetPath: soundAssetPath,
      alarmTimeInSeconds: alarmTimeInSeconds,
      isHtml: isHtml,
      isYoutubeLink: isYoutubeLink,
      isTouchPage: isTouchPage,
      resultImageAssetPath: resultImageAssetPath,
      hasTouchSound: true,
      overlayText: overlayText,
      choices: choices,
    );
  }

  TI asYoutubeLink() {
    return TI(
      text: text,
      imageAssetPath: imageAssetPath,
      animationFrames: animationFrames,
      soundAssetPath: soundAssetPath,
      alarmTimeInSeconds: alarmTimeInSeconds,
      isHtml: isHtml,
      isYoutubeLink: true,
      isTouchPage: isTouchPage,
      resultImageAssetPath: resultImageAssetPath,
      hasTouchSound: hasTouchSound,
      overlayText: overlayText,
      choices: choices,
    );
  }

  TI withAlarm(int seconds) {
    return TI(
      text: text,
      imageAssetPath: imageAssetPath,
      animationFrames: animationFrames,
      soundAssetPath: soundAssetPath,
      alarmTimeInSeconds: seconds,
      isHtml: isHtml,
      isYoutubeLink: isYoutubeLink,
      isTouchPage: isTouchPage,
      resultImageAssetPath: resultImageAssetPath,
      hasTouchSound: hasTouchSound,
      overlayText: overlayText,
      choices: choices,
    );
  }

  TI asHtml() {
    return TI(
      text: text,
      imageAssetPath: imageAssetPath,
      animationFrames: animationFrames,
      soundAssetPath: soundAssetPath,
      alarmTimeInSeconds: alarmTimeInSeconds,
      isHtml: true,
      isYoutubeLink: isYoutubeLink,
      isTouchPage: isTouchPage,
      resultImageAssetPath: resultImageAssetPath,
      hasTouchSound: hasTouchSound,
      overlayText: overlayText,
      choices: choices,
    );
  }

  TI asTouchPage() {
    return TI(
      text: text,
      imageAssetPath: imageAssetPath,
      animationFrames: animationFrames,
      soundAssetPath: soundAssetPath,
      alarmTimeInSeconds: alarmTimeInSeconds,
      isHtml: isHtml,
      isYoutubeLink: isYoutubeLink,
      isTouchPage: true,
      resultImageAssetPath: resultImageAssetPath,
      hasTouchSound: hasTouchSound,
      overlayText: overlayText,
      choices: choices,
    );
  }

  TI withResultImage(String image) {
    return TI(
      text: text,
      imageAssetPath: imageAssetPath,
      animationFrames: animationFrames,
      soundAssetPath: soundAssetPath,
      alarmTimeInSeconds: alarmTimeInSeconds,
      isHtml: isHtml,
      isYoutubeLink: isYoutubeLink,
      isTouchPage: isTouchPage,
      resultImageAssetPath: image,
      hasTouchSound: hasTouchSound,
      overlayText: overlayText,
      choices: choices,
    );
  }

  bool get hasTimer => alarmTimeInSeconds != null && alarmTimeInSeconds! > 0;
  bool get hasAnimation => animationFrames != null && animationFrames!.isNotEmpty;
  bool get hasSound => soundAssetPath != null;
  bool get hasImage => imageAssetPath != null;
  bool get hasResultImage => resultImageAssetPath != null;
  bool get hasChoices => choices != null && choices!.isNotEmpty;

  TI withOverlayText(String text) {
    return TI(
      text: this.text,
      imageAssetPath: imageAssetPath,
      animationFrames: animationFrames,
      soundAssetPath: soundAssetPath,
      alarmTimeInSeconds: alarmTimeInSeconds,
      isHtml: isHtml,
      isYoutubeLink: isYoutubeLink,
      isTouchPage: isTouchPage,
      resultImageAssetPath: resultImageAssetPath,
      hasTouchSound: hasTouchSound,
      overlayText: text,
      choices: choices,
    );
  }

  /// 선택지 추가 - 분기 처리에 사용
  /// 사용 예: .withChoices([Choice("맞췄다", 31), Choice("틀렸다", 35)])
  TI withChoices(List<Choice> choices) {
    return TI(
      text: text,
      imageAssetPath: imageAssetPath,
      animationFrames: animationFrames,
      soundAssetPath: soundAssetPath,
      alarmTimeInSeconds: alarmTimeInSeconds,
      isHtml: isHtml,
      isYoutubeLink: isYoutubeLink,
      isTouchPage: isTouchPage,
      resultImageAssetPath: resultImageAssetPath,
      hasTouchSound: hasTouchSound,
      overlayText: overlayText,
      choices: choices,
    );
  }
}
