# 기억의 궁전 - iOS 출시 전 점검/최적화 계획

## Context
Flutter 기반 기억력 트레이닝 앱 "기억의 궁전"의 iOS App Store 출시를 위한 전체 점검.
탐색 결과 앱 아이콘 미설정, 런타임 버그, 491MB 에셋 크기, 릴리즈 빌드 미정리 등의 문제 발견.
**Phase 순서대로 시행 → 테스트를 반복하며 진행.**

## 진행 상황
- [x] Phase 0: 크리티컬 버그 수정 ✅
- [x] Phase 1-1: 앱 아이콘 생성 ✅ (main.webp 기반)
- [x] Phase 1-2: Info.plist 수정 ✅ (앱 이름 한글화, ATS 보안)
- [ ] Phase 1-3: Bundle ID 확인 (사용자 확인 필요: `com.sunguk.mplace`)
- [ ] Phase 1-4: 버전 번호 결정 (현재 `1.0.0+1`)
- [x] Phase 1-5: 개인정보 처리방침 ✅ (docs/privacy-policy.html)
- [x] Phase 2: 앱 크기 최적화 ✅ (491MB → 190MB, -61%)
- [x] Phase 3: 릴리즈 빌드 안정성 ✅
- [x] Phase 4: Deprecated API 정리 ✅
- [x] Phase 5-1: iOS 무음모드 오디오 설정 ✅
- [ ] Phase 5-2/3: 실기기 테스트 (사용자 테스트 필요)
- [ ] Phase 6: App Store 제출

---

## Phase 0: 크리티컬 버그 수정
> 앱 동작에 직접 영향을 주는 버그 즉시 수정

### 0-1. `super.initState()` 중복 호출 제거
- **파일**: `flutter_app/lib/screens/num_sample_screen.dart` (line 22)
- **내용**: `super.initState();`가 2번 호출됨 → 1개 삭제
- **테스트**: 앱 실행 → 숫자샘플 화면 진입 확인

### 0-2. 미사용 import 제거
- **파일**: `flutter_app/lib/screens/day_screen.dart` (line 4)
- **내용**: `import 'dart:io';` 사용되지 않음 → 삭제
- **테스트**: `flutter analyze` 실행

### 0-3. 스플래시 설정 오류 수정
- **파일**: `flutter_app/pubspec.yaml` (line 71)
- **내용**: `background_image: "assets/images/main.png"` → 실제 파일은 `main.webp`
- **변경**: `main.png` → `main.webp`로 수정
- **테스트**: `dart run flutter_native_splash:create` 실행 후 앱 시작 시 스플래시 확인

### Phase 0 완료 검증
```bash
flutter analyze
flutter run --release -d <device>  # NumSampleScreen 진입 + 스플래시 확인
```

---

## Phase 1: iOS App Store 필수 요구사항
> 이것들이 없으면 Apple 심사에서 반려됨

### 1-1. 앱 아이콘 교체 (현재 기본 Flutter 아이콘)
- **파일**: `flutter_app/ios/Runner/Assets.xcassets/AppIcon.appiconset/` 전체
- **현황**: 1024x1024 아이콘이 11KB (기본 플레이스홀더)
- **필요**: 실제 앱 아이콘 1024x1024 PNG (투명 배경 불가, 알파 채널 불가)
- **방법**: 사용자가 아이콘 원본 제공 → `flutter_launcher_icons` 패키지로 자동 생성
- **테스트**: 시뮬레이터/실기기 홈화면에서 아이콘 확인

### 1-2. Info.plist 수정
- **파일**: `flutter_app/ios/Runner/Info.plist`
- **변경사항**:
  - `CFBundleDisplayName`: "Memory Palace" → "기억의 궁전"
  - `CFBundleName`: "memory_palace" → "기억의 궁전"
  - `NSAllowsArbitraryLoads`: `true` → 특정 도메인만 허용 (Apple 심사 리스크)

### 1-3. Bundle ID 확인/통일
- **현재**: Xcode 프로젝트 = `com.sunguk.mplace`
- **확인**: Apple Developer Portal에 등록된 ID와 일치하는지 확인

### 1-4. 버전 번호 설정
- **파일**: `flutter_app/pubspec.yaml` (line 19)
- **현재**: `version: 1.0.0+1`
- **확인**: 출시 버전/빌드넘버 결정 (사용자 확인 필요)

### 1-5. 개인정보 처리방침 준비 (코드 외)
- Apple은 모든 앱에 개인정보 처리방침 URL 필요
- GitHub Pages 또는 Google Docs로 간단히 작성

### Phase 1 완료 검증
```bash
flutter build ios --release
# Xcode에서 Product > Archive → IPA 생성 확인
# 실기기에서 아이콘, 앱 이름, 공지사항 확인
```

---

## Phase 2: 앱 크기 최적화
> 현재 에셋만 491MB. Apple 200MB 셀룰러 다운로드 제한 고려

### 2-1. 미사용 원본 영상 삭제 (즉시 -216MB)
- `flutter_app/assets/videos/d32_elon_original.mp4` (130MB) - 코드에서 미참조
- `flutter_app/assets/videos/gump_original.mp4` (86MB) - 코드에서 미참조
- **테스트**: 앱에서 모든 영상 재생 확인

### 2-2. 대용량 영상 추가 압축
- `d0_tedVideo.mp4` (67MB), `d32_elon.mp4` (67MB)가 가장 큼
- FFmpeg으로 재인코딩: `ffmpeg -i input.mp4 -vcodec libx264 -crf 28 -preset medium -acodec aac -b:a 128k output.mp4`
- 목표: 전체 영상 150MB 이하
- **테스트**: 해당 영상 재생하여 화질 확인

### 2-3. 대용량 이미지 압축
- `d7_4.webp` (9.9MB) → 1080px 너비로 리사이즈
- `bitcoin.webp` (3.7MB) → 실제 표시 크기에 맞게 축소
- **테스트**: 해당 이미지 포함 화면 진입 확인

### Phase 2 완료 검증
```bash
flutter build ios --release
# IPA 파일 크기 확인 (목표: 200MB 이하)
# 모든 Day 화면 탐색하며 영상/이미지 확인
```

---

## Phase 3: 릴리즈 빌드 안정성
> 프로덕션에서 크래시 방지

### 3-1. 글로벌 에러 핸들러 추가
- **파일**: `flutter_app/lib/main.dart`
- **내용**: `runZonedGuarded` + `FlutterError.onError` 로 감싸기
- 릴리즈 모드에서 화이트스크린(crash) 방지

### 3-2. debugPrint를 kDebugMode로 감싸기 (31개)
- `day_screen.dart` (21개)
- `fullscreen_video_screen.dart` (7개)
- `video_screen.dart` (2개)
- `main_screen.dart` (1개)
- **패턴**: `debugPrint('...')` → `if (kDebugMode) debugPrint('...')`

### 3-3. 공지사항 fetch에 timeout 추가
- **파일**: `flutter_app/lib/screens/main_screen.dart`
- **내용**: `http.get()` 에 `.timeout(Duration(seconds: 5))` 추가

### Phase 3 완료 검증
```bash
flutter analyze
flutter build ios --release
# 네트워크 끊은 상태로 앱 실행 → 크래시 없이 동작 확인
```

---

## Phase 4: Deprecated API 정리
> Flutter 업데이트 시 빌드 깨짐 방지

### 4-1. `withOpacity()` → `withValues(alpha:)` 마이그레이션 (14개)
- `day_screen.dart` (11개)
- `video_screen.dart` (3개)
- **패턴**: `Colors.black.withOpacity(0.5)` → `Colors.black.withValues(alpha: 0.5)`

### 4-2. flutter_html 버전 고정
- **파일**: `flutter_app/pubspec.yaml` (line 47)
- **변경**: `flutter_html: ^3.0.0-beta.2` → `flutter_html: 3.0.0-beta.2` (캐럿 제거)

### Phase 4 완료 검증
```bash
flutter analyze  # warning 0개 확인
flutter run --release -d <device>
```

---

## Phase 5: iOS 플랫폼 동작 확인
> 실기기에서의 iOS 특화 이슈

### 5-1. 무음모드 오디오 동작 확인
- iOS 무음 스위치 켠 상태에서 앱 사운드 재생 테스트
- 필요 시 `AppDelegate.swift`에 `AVAudioSession` 설정 추가

### 5-2. 영상 화면 전환(세로↔가로) 테스트
- 모든 영상 재생 → 가로모드 전환 → 세로 복귀 확인

### 5-3. 코드 사이닝 확인
- Xcode에서 Archive → 사이닝 성공 확인

### Phase 5 완료 검증
```bash
flutter run --release -d <iPhone-device-id>
# 체크리스트: 스플래시→메인→각 Day→영상→사운드→공지사항
```

---

## Phase 6: App Store 제출 (코드 외 작업)
- [ ] App Store Connect에서 앱 생성
- [ ] 스크린샷 캡처 (iPhone 6.9", 6.7", 6.5" 필수)
- [ ] 앱 설명 작성 (한국어)
- [ ] 개인정보 처리방침 URL 등록
- [ ] `flutter build ipa` → Xcode Organizer로 업로드
- [ ] 심사 제출

---

## 핵심 파일 목록
| 파일 | 수정 Phase |
|------|-----------|
| `lib/screens/num_sample_screen.dart` | 0 |
| `lib/screens/day_screen.dart` | 0, 3, 4 |
| `pubspec.yaml` | 0, 1, 4 |
| `ios/Runner/Info.plist` | 1 |
| `ios/Runner/Assets.xcassets/AppIcon.appiconset/*` | 1 |
| `lib/main.dart` | 3 |
| `lib/screens/main_screen.dart` | 3 |
| `lib/screens/fullscreen_video_screen.dart` | 3 |
| `lib/screens/video_screen.dart` | 3, 4 |
| `assets/videos/*_original.mp4` | 2 (삭제) |
| `assets/images/d7_4.webp, bitcoin.webp` | 2 (압축) |

## 최소 출시 경로 (시간 부족 시)
**Phase 0 → Phase 1 → Phase 2-1 → Phase 3-1 → Phase 5-3 → Phase 6**
