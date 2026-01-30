// 공통 텍스트 포맷팅 상수
const String arrow = "\n   ▽\n";
const String arrow_h = "<br>   ▽<br>";

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

/// 전환 효과 종류
enum TransformEffect {
  fadeIn,      // 페이드 인 - 서서히 나타남
  slideLeft,   // 왼쪽에서 슬라이드
  slideRight,  // 오른쪽에서 슬라이드
  slideUp,     // 아래에서 위로 슬라이드
  slideDown,   // 위에서 아래로 슬라이드
  scale,       // 중앙에서 커지며 나타남
  rotate,      // 회전하며 나타남
  flip,        // 뒤집히며 전환
  zoomBlur,    // 줌 + 블러에서 선명하게
  dissolve,    // 픽셀이 흩어지듯 전환
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
  final String? initialSound;
  final int? repeatCount;
  final bool showCounter;
  final String? videoPath;
  // Crack Transform 관련 필드
  final List<String>? crackImages;
  final List<int>? crackThresholds;
  final int? transformThreshold;
  final String? transformedImage;
  final String? transformSound;
  final TransformEffect? transformEffect;
  final String? backgroundMusic;
  final String? transformPopupTitle;
  final String? transformPopupButtonText;
  final String? transformPopupLink;
  // Repeat Sound 완료 팝업 관련 필드
  final String? repeatCompletionSound;
  final String? repeatPopupTitle;
  final String? repeatPopupButtonText;
  final String? repeatPopupLink;
  // 자동 풀스크린 비디오 (페이지 로드 시 바로 재생)
  final String? autoFullscreenVideo;

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
    this.initialSound,
    this.repeatCount,
    this.showCounter = false,
    this.videoPath,
    this.crackImages,
    this.crackThresholds,
    this.transformThreshold,
    this.transformedImage,
    this.transformSound,
    this.transformEffect,
    this.backgroundMusic,
    this.transformPopupTitle,
    this.transformPopupButtonText,
    this.transformPopupLink,
    this.repeatCompletionSound,
    this.repeatPopupTitle,
    this.repeatPopupButtonText,
    this.repeatPopupLink,
    this.autoFullscreenVideo,
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
      initialSound: initialSound,
      repeatCount: repeatCount,
      showCounter: showCounter,
      videoPath: videoPath,
      crackImages: crackImages,
      crackThresholds: crackThresholds,
      transformThreshold: transformThreshold,
      transformedImage: transformedImage,
      transformSound: transformSound,
      transformEffect: transformEffect,
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
      initialSound: initialSound,
      repeatCount: repeatCount,
      showCounter: showCounter,
      videoPath: videoPath,
      crackImages: crackImages,
      crackThresholds: crackThresholds,
      transformThreshold: transformThreshold,
      transformedImage: transformedImage,
      transformSound: transformSound,
      transformEffect: transformEffect,
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
      initialSound: initialSound,
      repeatCount: repeatCount,
      showCounter: showCounter,
      videoPath: videoPath,
      crackImages: crackImages,
      crackThresholds: crackThresholds,
      transformThreshold: transformThreshold,
      transformedImage: transformedImage,
      transformSound: transformSound,
      transformEffect: transformEffect,
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
      initialSound: initialSound,
      repeatCount: repeatCount,
      showCounter: showCounter,
      videoPath: videoPath,
      crackImages: crackImages,
      crackThresholds: crackThresholds,
      transformThreshold: transformThreshold,
      transformedImage: transformedImage,
      transformSound: transformSound,
      transformEffect: transformEffect,
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
      initialSound: initialSound,
      repeatCount: repeatCount,
      showCounter: showCounter,
      videoPath: videoPath,
      crackImages: crackImages,
      crackThresholds: crackThresholds,
      transformThreshold: transformThreshold,
      transformedImage: transformedImage,
      transformSound: transformSound,
      transformEffect: transformEffect,
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
      initialSound: initialSound,
      repeatCount: repeatCount,
      showCounter: showCounter,
      videoPath: videoPath,
      crackImages: crackImages,
      crackThresholds: crackThresholds,
      transformThreshold: transformThreshold,
      transformedImage: transformedImage,
      transformSound: transformSound,
      transformEffect: transformEffect,
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
      initialSound: initialSound,
      repeatCount: repeatCount,
      showCounter: showCounter,
      videoPath: videoPath,
      crackImages: crackImages,
      crackThresholds: crackThresholds,
      transformThreshold: transformThreshold,
      transformedImage: transformedImage,
      transformSound: transformSound,
      transformEffect: transformEffect,
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
      initialSound: initialSound,
      repeatCount: repeatCount,
      showCounter: showCounter,
      videoPath: videoPath,
      crackImages: crackImages,
      crackThresholds: crackThresholds,
      transformThreshold: transformThreshold,
      transformedImage: transformedImage,
      transformSound: transformSound,
      transformEffect: transformEffect,
    );
  }

  bool get hasTimer => alarmTimeInSeconds != null && alarmTimeInSeconds! > 0;
  bool get hasAnimation => animationFrames != null && animationFrames!.isNotEmpty;
  bool get hasSound => soundAssetPath != null;
  bool get hasImage => imageAssetPath != null;
  bool get hasResultImage => resultImageAssetPath != null;
  bool get hasChoices => choices != null && choices!.isNotEmpty;
  bool get hasVideo => videoPath != null;
  bool get hasCrackTransform => crackImages != null && crackThresholds != null && transformThreshold != null && transformedImage != null;
  bool get hasBackgroundMusic => backgroundMusic != null;
  bool get hasAutoFullscreenVideo => autoFullscreenVideo != null;

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
      initialSound: initialSound,
      repeatCount: repeatCount,
      showCounter: showCounter,
      videoPath: videoPath,
      crackImages: crackImages,
      crackThresholds: crackThresholds,
      transformThreshold: transformThreshold,
      transformedImage: transformedImage,
      transformSound: transformSound,
      transformEffect: transformEffect,
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
      initialSound: initialSound,
      repeatCount: repeatCount,
      showCounter: showCounter,
      videoPath: videoPath,
      crackImages: crackImages,
      crackThresholds: crackThresholds,
      transformThreshold: transformThreshold,
      transformedImage: transformedImage,
      transformSound: transformSound,
      transformEffect: transformEffect,
      autoFullscreenVideo: autoFullscreenVideo,
    );
  }

  /// 반복 재생 사운드 추가 - 초기 사운드와 반복 사운드를 설정
  /// 사용 예: .withRepeatSound('assets/sounds/mobak.mp3', 'assets/sounds/danbak.mp3', 99)
  /// 팝업 옵션 사용 예:
  /// .withRepeatSound('mobak.mp3', 'danbak.mp3', 99,
  ///   completionSound: 'assets/sounds/ClanInvitation.wav',
  ///   popupTitle: '히든조건 달성',
  ///   popupButtonText: '시타델 가입링크',
  ///   popupLink: 'https://discord.com/invite/...',
  /// )
  TI withRepeatSound(String initial, String repeat, int count, {
    bool showCounter = true,
    String? completionSound,
    String? popupTitle,
    String? popupButtonText,
    String? popupLink,
  }) {
    return TI(
      text: text,
      imageAssetPath: imageAssetPath,
      animationFrames: animationFrames,
      soundAssetPath: repeat,
      alarmTimeInSeconds: alarmTimeInSeconds,
      isHtml: isHtml,
      isYoutubeLink: isYoutubeLink,
      isTouchPage: isTouchPage,
      resultImageAssetPath: resultImageAssetPath,
      hasTouchSound: hasTouchSound,
      overlayText: overlayText,
      choices: choices,
      initialSound: initial,
      repeatCount: count,
      showCounter: showCounter,
      videoPath: videoPath,
      crackImages: crackImages,
      crackThresholds: crackThresholds,
      transformThreshold: transformThreshold,
      transformedImage: transformedImage,
      transformSound: transformSound,
      transformEffect: transformEffect,
      repeatCompletionSound: completionSound,
      repeatPopupTitle: popupTitle,
      repeatPopupButtonText: popupButtonText,
      repeatPopupLink: popupLink,
    );
  }

  /// 비디오 추가 - 페이지에 비디오를 추가하고 자동재생
  /// 사용 예: .withVideo('assets/videos/gump.mp4')
  TI withVideo(String video) {
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
      initialSound: initialSound,
      repeatCount: repeatCount,
      showCounter: showCounter,
      videoPath: video,
      crackImages: crackImages,
      crackThresholds: crackThresholds,
      transformThreshold: transformThreshold,
      transformedImage: transformedImage,
      transformSound: transformSound,
      transformEffect: transformEffect,
    );
  }

  /// 터치 시 균열 효과 + 이미지 전환 추가
  /// 사용 예: .withCrackTransform(
  ///   cracks: ['assets/images/crack1.png', 'assets/images/crack2.png'],
  ///   thresholds: [33, 66],
  ///   transformAt: 99,
  ///   transformTo: 'assets/images/hobbit2.webp',
  ///   sound: 'assets/sounds/ClanInvitation.mp3',
  ///   effect: TransformEffect.fadeIn,
  /// )
  TI withCrackTransform({
    required List<String> cracks,
    required List<int> thresholds,
    required int transformAt,
    required String transformTo,
    String? sound,
    TransformEffect effect = TransformEffect.fadeIn,
    String? popupTitle,
    String? popupButtonText,
    String? popupLink,
  }) {
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
      initialSound: initialSound,
      repeatCount: repeatCount,
      showCounter: showCounter,
      videoPath: videoPath,
      crackImages: cracks,
      crackThresholds: thresholds,
      transformThreshold: transformAt,
      transformedImage: transformTo,
      transformSound: sound,
      transformEffect: effect,
      backgroundMusic: backgroundMusic,
      transformPopupTitle: popupTitle,
      transformPopupButtonText: popupButtonText,
      transformPopupLink: popupLink,
    );
  }

  TI withBackgroundMusic(String music) {
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
      initialSound: initialSound,
      repeatCount: repeatCount,
      showCounter: showCounter,
      videoPath: videoPath,
      crackImages: crackImages,
      crackThresholds: crackThresholds,
      transformThreshold: transformThreshold,
      transformedImage: transformedImage,
      transformSound: transformSound,
      transformEffect: transformEffect,
      backgroundMusic: music,
      autoFullscreenVideo: autoFullscreenVideo,
    );
  }

  /// 페이지 로드 시 자동으로 풀스크린 비디오 재생
  /// 비디오 완료 후 페이지 내용(이미지, 선택지 등)이 표시됨
  TI withAutoFullscreenVideo(String video) {
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
      initialSound: initialSound,
      repeatCount: repeatCount,
      showCounter: showCounter,
      videoPath: videoPath,
      crackImages: crackImages,
      crackThresholds: crackThresholds,
      transformThreshold: transformThreshold,
      transformedImage: transformedImage,
      transformSound: transformSound,
      transformEffect: transformEffect,
      backgroundMusic: backgroundMusic,
      autoFullscreenVideo: video,
    );
  }
}
