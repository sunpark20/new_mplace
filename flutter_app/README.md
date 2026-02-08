# 기억의 궁전 (Memory Palace)

Flutter로 제작된 크로스 플랫폼 기억력 훈련 앱입니다.

## 📱 소개

"기억의 궁전"과 "PAO(Person-Action-Object)" 같은 고대부터 내려온 기억술을 배우고 연습할 수 있는 앱입니다.

### 주요 기능
- **학습 모드**: Day 0-6 단계별 기억술 학습
- **숫자-인물 변환**: 00-99 숫자를 인물로 매핑
- **연습 모드**: 기억력 테스트 및 게임
- **멀티미디어**: 이미지, 사운드, 비디오, 애니메이션 지원

## 🛠 기술 스택

- **Framework**: Flutter (Dart 3.6.0+)
- **상태 관리**: setState (기본)
- **멀티미디어**:
  - video_player (^2.10.0)
  - audioplayers (^6.2.0)
- **UI**:
  - flutter_html (^3.0.0-beta.2)
  - url_launcher (^6.3.1)
- **저장소**:
  - shared_preferences (^2.3.5)
  - path_provider (^2.1.5)

## 📁 프로젝트 구조

```
lib/
├── main.dart              # 앱 진입점
├── models/                # 데이터 모델
│   ├── ti.dart           # 학습 슬라이드 모델
│   └── item.dart         # 숫자-인물 매핑 모델
├── screens/              # 화면
│   ├── loading_screen.dart
│   ├── main_screen.dart
│   ├── day_screen.dart   # 학습 화면 (핵심)
│   ├── num_sample_screen.dart
│   └── video_screen.dart
└── data/                 # 학습 콘텐츠 데이터
    ├── day0.dart ~ day6_pao.dart
    └── ...

assets/
├── images/               # 151개 이미지
├── sounds/               # 사운드 효과
│   ├── alarm/           # 17개 알람 사운드
│   └── combat/          # 154개 게임 사운드
└── videos/               # 비디오 파일
```

## 🚀 시작하기

### 필수 조건
- Flutter SDK 3.38.7+
- Dart 3.6.0+

### 설치 및 실행

```bash
# 의존성 설치
flutter pub get

# 개발 모드 실행
flutter run

# 릴리즈 빌드
flutter run --release

# iOS 물리 기기에서 실행 (권장)
flutter run --release -d <device_id>
```

### 빌드

```bash
# Android APK
flutter build apk --release

# iOS (Xcode 필요)
flutter build ios --release
```

## 📋 테스트

```bash
# 코드 품질 검사
flutter analyze

# 테스트 실행
flutter test
```

## 🎯 개발 가이드

### 새로운 학습 콘텐츠 추가
1. `lib/data/` 에 새 파일 생성 (예: `day7.dart`)
2. `TI` 객체 리스트 정의
3. `main_screen.dart` 에 버튼 추가

### TI 모델 사용법
```dart
TI(
  text: "학습 텍스트",
  imageAssetPath: 'assets/images/image.png',
)
.withSound('assets/sounds/sound.mp3')
.withAlarm(60)  // 60초 타이머
.withAnimation(['frame1.png', 'frame2.png'])
.asHtml()  // HTML 렌더링
```

## 📊 코드 품질

- **flutter analyze**: ✅ 0 issues
- **flutter test**: ✅ All tests passed
- **Code style**: Linted with flutter_lints ^5.0.0

## 📝 문서

- **GEMINI.md**: 프로젝트 가이드 및 아키텍처
- **WORK_LOG.md**: 작업 이력
- **.claude/skills/OPTIMIZATION_PLAN.md**: 최적화 계획

## ⚠️ 주의사항

### iOS 빌드
- **Release 모드 필수**: Debug 모드는 물리 기기에서 불안정
- 무한 대기 시: `pkill -9 -f "flutter.*"` 후 재시도
- Xcode에서 빌드 시 Scheme을 Release로 설정

### Android
- Min SDK: 21
- Target SDK: 최신

## 📜 라이선스

MIT License

## 👨‍💻 개발자

sunpark20

---

**작업 전 필독**: `지침.md` 확인
