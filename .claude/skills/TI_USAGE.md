# TI (Text-Image) 모델 사용법

Flutter 앱의 콘텐츠 데이터 구조입니다. 각 TI 항목은 텍스트와 이미지로 구성되며, 다양한 메서드 체이닝으로 기능을 추가할 수 있습니다.

## 기본 구조

```dart
TI(
  text: "표시할 텍스트",
  imageAssetPath: 'assets/images/example.png',
)
```

## 사용 가능한 메서드 체이닝

### 1. 타이머 추가 `.withAlarm(초)`
페이지에 카운트다운 타이머를 추가합니다. 타이머 완료 시 자동으로 다음 페이지로 이동합니다.

```dart
TI(
  text: "15초 동안 상상해보세요",
  imageAssetPath: 'assets/images/think.png',
).withAlarm(15)
```

### 2. 오버레이 텍스트 `.withOverlayText("텍스트")`
이미지 위에 반투명 배경의 텍스트를 표시합니다. 타이머 없이도 독립적으로 사용 가능합니다.

```dart
TI(
  text: "미션 설명",
  imageAssetPath: 'assets/images/mission.png',
).withOverlayText("눈을 감고\n상상해보세요")
```

### 3. 사운드 재생 `.withSound('경로')`
페이지 진입 시 지정된 사운드를 재생합니다.

```dart
TI(
  text: "구구콘 소개",
  imageAssetPath: 'assets/images/gugucon.png',
).withSound('assets/sounds/gugusounx3.mp3')
```

**참고**: 타이머 완료 후 다음 페이지에 `.withSound()`가 있으면, 알람 소리 대신 해당 사운드가 재생됩니다.

### 4. 터치 사운드 `.withTouchSound()`
페이지 터치 시 하이파이브 효과음을 재생합니다.

```dart
TI(
  text: "하이파이브!",
  imageAssetPath: 'assets/images/highfive.png',
).withTouchSound()
```

### 5. 애니메이션 프레임 `.withAnimation([프레임목록])`
이미지 애니메이션을 설정합니다. 지정된 이미지들이 순차적으로 전환됩니다.

```dart
TI(
  text: "애니메이션 예시",
  imageAssetPath: 'assets/images/frame1.png',
).withAnimation([
  'assets/images/frame1.png',
  'assets/images/frame2.png',
  'assets/images/frame3.png',
])
```

### 6. 결과 이미지 `.withResultImage('경로')`
타이머 완료 후 표시될 결과 이미지를 설정합니다.

```dart
TI(
  text: "문제를 풀어보세요",
  imageAssetPath: 'assets/images/question.png',
).withAlarm(30).withResultImage('assets/images/answer.png')
```

### 7. HTML 렌더링 `.asHtml()`
텍스트를 HTML로 렌더링합니다.

```dart
TI(
  text: "<b>굵은 텍스트</b>와 <i>기울임</i>",
  imageAssetPath: 'assets/images/example.png',
).asHtml()
```

### 8. YouTube 링크 `.asYoutubeLink()`
YouTube 비디오 재생 버튼을 표시합니다.

```dart
TI(
  text: "TED 영상을 시청하세요",
  imageAssetPath: 'assets/images/ted.png',
).asYoutubeLink()
```

### 9. 터치 페이지 `.asTouchPage()`
터치 상호작용이 가능한 페이지로 설정합니다.

```dart
TI(
  text: "화면을 터치하세요",
  imageAssetPath: 'assets/images/touch.png',
).asTouchPage()
```

### 10. 선택지/분기 `.withChoices([Choice목록])` ⭐ NEW

페이지에 선택 버튼을 추가하고, 선택에 따라 다른 인덱스로 점프합니다.
선택지가 있는 페이지에서는 "다음" 버튼이 비활성화되어 반드시 선택해야 합니다.

```dart
import 'package:flutter_app/models/ti.dart'; // Choice 클래스 포함

TI(
  text: "기억해보세요!\n\n다 기억했나요?",
  imageAssetPath: 'assets/images/question.png',
).withChoices([
  Choice("맞췄다", 31),   // 31번 인덱스로 이동
  Choice("틀렸다", 35),   // 35번 인덱스로 이동
])
```

**동영상 재생 후 이동 (videoPath 옵션)**:
선택 시 동영상을 먼저 가로모드 풀스크린으로 재생하고, 끝나면 해당 인덱스로 이동합니다.
동영상 재생 중에는 스킵/뒤로가기가 불가능합니다.

```dart
TI(
  text: "정답을 맞추셨나요?",
  imageAssetPath: 'assets/images/quiz.png',
).withChoices([
  Choice("맞췄다", 31, videoPath: 'assets/videos/sasa.mp4'),  // 동영상 재생 후 31번으로
  Choice("틀렸다", 35),   // 바로 35번으로 이동
])
```

**사용 예시 (분기 구조)**:
```dart
// 인덱스 30: 선택지 페이지
TI(
  text: "정답을 맞추셨나요?",
  imageAssetPath: 'assets/images/quiz.png',
).withChoices([
  Choice("맞췄다 ✓", 31, videoPath: 'assets/videos/celebration.mp4'),
  Choice("틀렸다 ✗", 35),
]),

// 인덱스 31: 맞췄을 때 (동영상 끝난 후 이 페이지로 옴)
TI(
  text: "축하합니다! 정답입니다!",
  imageAssetPath: 'assets/images/correct.png',
),
// ... 31-a 경로 계속 ...

// 인덱스 35: 틀렸을 때 (31-b 시작)
TI(
  text: "아쉽네요. 다시 한번 복습해봅시다.",
  imageAssetPath: 'assets/images/wrong.png',
),
// ... 31-b 경로 계속 ...
```

**주의사항**:
- `targetIndex`는 TI 배열의 0-based 인덱스입니다
- 인덱스를 계산할 때 주석이나 빈 줄은 제외하고 실제 TI 항목만 카운트하세요
- 선택지가 있는 페이지에서는 일반 스와이프로도 다음 페이지 이동이 가능합니다

## 메서드 체이닝 조합 예시

여러 메서드를 조합할 수 있습니다:

```dart
TI(
  text: "15초 동안 눈을 감고 상상해보세요",
  imageAssetPath: 'assets/images/imagine.png',
).withAlarm(15).withOverlayText("눈을 감고\n집중하세요").withResultImage('assets/images/result.png')
```

## 파일 위치

- **TI 모델**: `lib/models/ti.dart`
- **화면 렌더링**: `lib/screens/day_screen.dart`
- **데이터 파일들**: `lib/data/day0.dart`, `day1.dart`, `day2.dart`, etc.
