# 기억의 궁전 - iOS 출시 전 점검/최적화 계획

> **이 파일은 AI 어시스턴트가 작업을 이어받기 위한 컨텍스트 문서입니다.**
> 새 세션에서 이어서 작업할 때: 이 파일을 먼저 읽고, "남은 작업" 섹션부터 진행하세요.

---

## 프로젝트 개요
- **앱 이름**: 기억의 궁전 (Memory Palace)
- **종류**: 기억력 트레이닝 교육 앱 (Flutter)
- **경로**: `flutter_app/` (레포 루트 기준)
- **플랫폼**: iOS 우선 출시, 이후 Android
- **Bundle ID**: `com.sunguk.mplace` (Xcode 프로젝트 기준)
- **버전**: `1.0.0+1` (pubspec.yaml)
- **기술 스택**: Flutter (Dart 3.6.0+), video_player, audioplayers, flutter_html, shared_preferences
- **상태관리**: 순수 setState (외부 라이브러리 없음)
- **백엔드**: 없음 (로컬 전용, 공지사항만 GitHub Gist에서 fetch)

## 핵심 파일 구조
```
flutter_app/
├── lib/
│   ├── main.dart                    # 앱 진입점 (글로벌 에러 핸들러 포함)
│   ├── models/ti.dart               # TI 데이터 모델 (슬라이드)
│   ├── models/item.dart             # 숫자-인물 매핑 모델
│   ├── screens/
│   │   ├── loading_screen.dart      # 스플래시 → 메인 전환
│   │   ├── main_screen.dart         # 메인 네비게이션 허브
│   │   ├── day_screen.dart          # 핵심 콘텐츠 엔진 (~1900줄)
│   │   ├── video_screen.dart        # 일반 영상 재생
│   │   ├── fullscreen_video_screen.dart  # 풀스크린 영상
│   │   └── num_sample_screen.dart   # 숫자 샘플 그리드
│   ├── widgets/sound_button.dart    # 클릭 사운드 버튼
│   └── data/day0~7.dart             # 10개 콘텐츠 데이터 파일
├── assets/
│   ├── images/ (31MB)
│   ├── videos/ (143MB)
│   └── sounds/ (17MB)
├── ios/Runner/
│   ├── Info.plist
│   ├── AppDelegate.swift
│   └── Assets.xcassets/AppIcon.appiconset/
├── pubspec.yaml
└── docs/privacy-policy.html
```

---

## 진행 상황

### 완료된 작업 ✅
| Phase | 내용 | 커밋 요약 |
|-------|------|----------|
| **0-1** | `num_sample_screen.dart` 중복 `super.initState()` 제거 | Phase 0 커밋 |
| **0-2** | `day_screen.dart` 미사용 `import 'dart:io'` 제거 | Phase 0 커밋 |
| **0-3** | `pubspec.yaml` 스플래시 설정 `main.png` → `main_splash.png` (PNG 변환) | Phase 0 + 아이콘 커밋 |
| **1-1** | 앱 아이콘: `main.webp` 기반 1024x1024 생성, `flutter_launcher_icons`로 모든 크기 자동 생성 | 아이콘 커밋 |
| **1-2** | `Info.plist`: `CFBundleDisplayName`/`CFBundleName` → "기억의 궁전", `NSAllowsArbitraryLoads` → false + gist 도메인 예외 | Info.plist 커밋 |
| **1-5** | `docs/privacy-policy.html` 생성 (App Store 제출용) | Phase 5 커밋 |
| **2-1** | 미사용 원본 영상 삭제: `d32_elon_original.mp4` (130MB), `gump_original.mp4` (86MB) | Phase 2 커밋 |
| **2-2** | 영상 압축: `d0_tedVideo` 67→48MB, `d32_elon` 67→42MB, `d1_4` 19→2.5MB | Phase 2 커밋 |
| **2-3** | 이미지 압축: `d7_4.webp` 9.9MB→290KB, `bitcoin.webp` 3.7MB→20KB | Phase 2 커밋 |
| **3-1** | `main.dart`에 `runZonedGuarded` + `FlutterError.onError` 추가 | Phase 3 커밋 |
| **3-2** | 31개 `debugPrint`를 `if (kDebugMode)` 로 감싸기 (4개 파일) | Phase 3 커밋 |
| **3-3** | `main_screen.dart` 공지사항 fetch에 5초 timeout 추가 | Phase 3 커밋 |
| **4-1** | 14개 `withOpacity()` → `withValues(alpha:)` 마이그레이션 | Phase 4 커밋 |
| **4-2** | `flutter_html: ^3.0.0-beta.2` → `3.0.0-beta.2` 버전 고정 | Phase 4 커밋 |
| **4-추가** | 미사용 `_currentRepeatPath` 필드, `_increaseTextScale`, `_decreaseTextScale` 삭제 | Phase 4 커밋 |
| **5-1** | `AppDelegate.swift`에 `AVAudioSession.playback` 설정 (무음모드 오디오) | Phase 5 커밋 |
| **추가** | `pubspec.yaml` description을 한글로 변경 | Phase 5 커밋 |

**에셋 최적화 결과**: 491MB → 190MB (**61% 감소**)
**flutter analyze 결과**: 에러 0, 경고 0, info 23개 (string concatenation, naming convention — 무시 가능)

---

### 남은 작업 (사용자 확인/테스트 필요)

#### 1. Bundle ID 확인 (`Phase 1-3`)
- **현재 설정**: `com.sunguk.mplace` (Xcode project.pbxproj)
- **필요**: Apple Developer Portal에 이 ID가 등록되어 있는지 사용자 확인
- **수정 방법**: 변경 필요 시 `flutter_app/ios/Runner.xcodeproj/project.pbxproj`에서 `PRODUCT_BUNDLE_IDENTIFIER` 수정

#### 2. 버전 번호 결정 (`Phase 1-4`)
- **현재**: `version: 1.0.0+1` (`flutter_app/pubspec.yaml` line 19)
- **필요**: 출시 버전 결정 (사용자)
- **수정 방법**: `pubspec.yaml`의 `version:` 값 변경

#### 3. 실기기 테스트 (`Phase 5-2/3`)
- **테스트 명령**: `flutter run --release -d <iPhone-device-id>`
- **체크리스트**:
  - [ ] 스플래시 화면 정상 표시
  - [ ] 앱 아이콘 정상 표시
  - [ ] 앱 이름 "기억의 궁전" 표시
  - [ ] 메인 화면 → 각 Day 화면 진입
  - [ ] 모든 영상 재생 (특히 압축된 d0_tedVideo, d32_elon, d1_4)
  - [ ] 모든 사운드 재생
  - [ ] 무음모드에서 사운드 재생
  - [ ] 영상 가로모드 전환 → 세로 복귀
  - [ ] 공지사항 로드 (네트워크 연결 시)
  - [ ] 네트워크 끊긴 상태에서 크래시 없음
  - [ ] 코드 사이닝: Xcode Archive 성공

#### 4. App Store 제출 (`Phase 6`)
- [ ] App Store Connect에서 앱 생성 (Bundle ID: `com.sunguk.mplace`)
- [ ] 스크린샷 캡처 (iPhone 6.9", 6.7", 6.5" 필수)
- [ ] 앱 설명 작성 (한국어)
- [ ] 카테고리: Education
- [ ] 개인정보 처리방침 URL 등록 (GitHub Pages로 `docs/privacy-policy.html` 호스팅)
- [ ] `flutter build ipa` → Xcode Organizer로 업로드
- [ ] 심사 제출
- [ ] day7 뇌모닉(비트코인) 콘텐츠 → 교육 목적임을 심사 노트에 설명

---

## 이슈/버그 발견 시 대응 가이드

### 빌드 실패 시
```bash
flutter clean && flutter pub get
flutter build ios --release
```

### iOS 실기기 설치 hang 시
```bash
pkill -9 -f "flutter.*"
pkill -9 -f idevicesyslog
flutter clean && flutter pub get
flutter run --release -d <device_id>
```

### 아이콘 교체 시
1. 새 1024x1024 PNG를 `flutter_app/assets/app_icon.png`로 교체
2. `dart run flutter_launcher_icons` 실행
3. iOS/Android 아이콘 자동 재생성

### 앱 설명 키워드 제안
기억력, 기억의 궁전, 메모리 팰리스, 기억법, PAO, 숫자 기억, 카드 기억, 니모닉, 뇌 훈련
