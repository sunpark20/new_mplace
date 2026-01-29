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

### 11. 반복 사운드 `.withRepeatSound(초기사운드, 반복사운드, 횟수)` ⭐ NEW

초기 사운드를 한 번 재생한 후, 반복 사운드를 지정된 횟수만큼 재생합니다.
카운터 표시 여부를 선택할 수 있습니다.

```dart
TI(
  text: "박수 소리를 들어보세요",
  imageAssetPath: 'assets/images/clap.png',
).withRepeatSound(
  'assets/sounds/mobak.mp3',   // 초기 사운드 (1회)
  'assets/sounds/danbak.mp3',  // 반복 사운드
  99,                           // 반복 횟수
  showCounter: true,           // 카운터 표시 (기본값: true)
)
```

99회 완료 시 축하 팝업이 자동으로 표시됩니다.

### 12. 비디오 재생 `.withVideo('경로')` ⭐ NEW

페이지에 비디오를 추가하고 자동 재생합니다. 이미지 대신 비디오가 표시됩니다.

```dart
TI(
  text: "포레스트 검프 명장면",
  imageAssetPath: 'assets/images/gump_thumbnail.png',
).withVideo('assets/videos/gump.mp4')
```

비디오는 한 번 재생되고 멈춥니다 (반복 없음).

### 13. 크랙 변환 효과 `.withCrackTransform(...)` ⭐ NEW

터치할 때마다 균열 이미지가 나타나고, 특정 횟수 도달 시 이미지가 변환되는 효과입니다.

```dart
import '../models/ti.dart'; // TransformEffect enum 포함

TI(
  text: "화면을 터치하세요!",
  imageAssetPath: 'assets/images/hobbit1.webp',
).withCrackTransform(
  cracks: ['assets/images/crack1.png', 'assets/images/crack2.png'],
  thresholds: [33, 66],           // 각 crack이 나타나는 터치 횟수
  transformAt: 99,                 // 이미지 변환이 일어나는 터치 횟수
  transformTo: 'assets/images/citadel.webp',  // 변환될 이미지
  sound: 'assets/sounds/ClanInvitation.wav',  // 변환 시 재생할 사운드 (옵션)
  effect: TransformEffect.fadeIn,  // 변환 애니메이션 효과
  // 팝업 옵션 (선택사항)
  popupTitle: '99번 달성!',        // 팝업 제목 (생략 시 "축하합니다!")
  popupButtonText: '시타델 가입하기',  // 버튼 텍스트
  popupLink: 'https://discord.com/invite/xxx',  // 버튼 클릭 시 열리는 링크
)
```

**사용 가능한 TransformEffect (10가지)**:

| Effect | 설명 |
|--------|------|
| `fadeIn` | 서서히 나타남 (기본값) |
| `slideLeft` | 오른쪽에서 왼쪽으로 슬라이드 |
| `slideRight` | 왼쪽에서 오른쪽으로 슬라이드 |
| `slideUp` | 아래에서 위로 슬라이드 |
| `slideDown` | 위에서 아래로 슬라이드 |
| `scale` | 중앙에서 커지며 나타남 |
| `rotate` | 회전하며 나타남 |
| `flip` | 3D 뒤집히며 전환 |
| `zoomBlur` | 줌 인하며 선명해짐 |
| `dissolve` | 부드럽게 녹아드는 전환 |

**동작 방식**:
1. 터치할 때마다 카운터 증가
2. thresholds 값에 도달하면 해당 crack 이미지가 오버레이로 표시
3. transformAt 값에 도달하면 소리 재생 + 이미지 변환 + 애니메이션 효과
4. 변환 후에는 더 이상 터치 카운터가 증가하지 않음
5. 팝업 옵션 설정 시 변환 완료 후 팝업 표시 (popupButtonText + popupLink 필수)

### 14. 백그라운드 음악 `.withBackgroundMusic('경로')` ⭐ NEW

페이지에 진입하면 배경 음악이 루프 재생되고, 페이지를 벗어나면 자동 정지됩니다.

```dart
TI(
  text: "기억의 궁전 여정 시작",
  imageAssetPath: 'assets/images/hobbit1.webp',
).withBackgroundMusic('assets/sounds/FiveArmies.mp3')
```

- 다른 효과음(터치 사운드, 변환 사운드)과 동시 재생 가능
- 페이지 이동 시 자동 정지

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
