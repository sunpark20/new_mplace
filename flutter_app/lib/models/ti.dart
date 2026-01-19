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
    );
  }

  bool get hasTimer => alarmTimeInSeconds != null && alarmTimeInSeconds! > 0;
  bool get hasAnimation => animationFrames != null && animationFrames!.isNotEmpty;
  bool get hasSound => soundAssetPath != null;
  bool get hasImage => imageAssetPath != null;
  bool get hasResultImage => resultImageAssetPath != null;
}
