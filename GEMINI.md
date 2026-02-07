# GEMINI.md - Project Context & Guidelines

## 1. Project Overview
**Name**: 기억의 궁전 (Memory Palace)
**Type**: Multi-platform Application (Android Java / Flutter)
**Purpose**: A memory training application teaching techniques like "Memory Palace" and "PAO (Person-Action-Object)".
**Repositories**:
*   `app/`: Legacy Android Application (Java)
*   `flutter_app/`: Modern Cross-platform Application (Flutter)

---

## 2. Legacy Android App (Java)
**Package**: `hungry.ex_frag`
**Stack**: Java, Android SDK (Min 21, Target 34), AdMob (`play-services-ads:23.0.0`)
**Architecture**: Activity-based (`MainActivity`, `Day_Activity`).
**Key Features**:
*   Slide-based learning with `TI` (Text-Image) objects.
*   Native `MediaPlayer` and External Video Player via `FileProvider`.
*   `CountDownTimer` for practice sessions.

---

## 3. Flutter App (New)
**Path**: `flutter_app/`
**Stack**:
*   **Framework**: Flutter (Dart 3.6.0+)
*   **Ads**: `google_mobile_ads` (^5.3.0)
*   **Media**: `video_player` (^2.10.0), `audioplayers` (^6.2.0)
*   **UI**: `flutter_html` (^3.0.0-beta.2)
*   **State Management**: `setState` (Basic), `Provider` (Implicit in architecture).

### A. Architecture & Components
*   **Entry Point**: `lib/main.dart` - Initializes app, sets orientation (Portrait), themes.
*   **Navigation**: `lib/screens/main_screen.dart` - Hub for Day 0-6, Practice, and Video.
*   **Core Logic**: `lib/screens/day_screen.dart`
    *   Renders slides based on `TI` objects.
    *   Handles Audio (`audioplayers`), Timer, Animations (Frame-based), and HTML rendering.
    *   Banner Ad integration at the top.
*   **Video**: `lib/screens/video_screen.dart` - Uses `video_player` to play local assets (`assets/videos/ted_video.mp4`).

### B. Data Models (`lib/models/`)
*   **`TI` (Text-Image)**: Immutable data class for slides.
    *   Fields: `text`, `imageAssetPath`, `animationFrames` (List<String>), `soundAssetPath`, `alarmTimeInSeconds`, `isHtml`, `isYoutubeLink`, `isTouchPage`, `resultImageAssetPath`, `hasTouchSound`.
    *   Helper methods: `withAnimation`, `withSound`, `withAlarm`, etc.
*   **`Item`**: POJO for Number-Person codes (00-99).

### C. Data Providers (`lib/data/`)
*   Static classes `Day0`, `Day1`... `Day6PAO` returning `List<TI>`.
*   Directly migrated from the Java version's logic.

### D. Resource Conventions
*   **Images**: `assets/images/` (e.g., `d0_1.png`).
*   **Sounds**: `assets/sounds/` (e.g., `highfive.mp3`).
*   **Videos**: `assets/videos/` (`ted_video.mp4`).
*   **Fonts/Text**: HTML content supported via `flutter_html`.

### E. Key Logic
*   **Timer**: `Timer.periodic` in `DayScreen`.
*   **Animations**: Custom frame-based animation using `Timer` and `Image.asset` (not Lottie/Gif).
*   **Ads**: Banner Ads loaded in `DayScreen` and `MainScreen`.

---

## 4. Operational Guidelines
*   **Context**: Check `GEMINI.md` to distinguish between Java and Flutter contexts.
*   **Flutter**:
    *   Run `flutter pub get` after dependency changes.
    *   Use `flutter_lints` for code quality.
    *   Ensure assets are declared in `pubspec.yaml`.
*   **Java**:
    *   Respect existing conventions for `TI` objects and `FileProvider`.
    *   Test Unit IDs for AdMob during dev.

## 5. Recent Changes

*   **Migration**: Porting logic from Android (Java) to Flutter is **COMPLETE**.
*   **iOS Release Prep (2026-02-08)**: See `RELEASE_PLAN.md` for full details.
    *   Bug fixes: duplicate initState, unused imports, splash config
    *   App icons generated from main.webp via flutter_launcher_icons
    *   Info.plist: Korean display name, ATS security hardened
    *   Assets optimized: 491MB → 190MB (-61%)
    *   Global error handler (runZonedGuarded) in main.dart
    *   31 debugPrints wrapped in kDebugMode
    *   14 deprecated withOpacity → withValues(alpha:)
    *   flutter_html pinned to exact version
    *   iOS AVAudioSession playback mode for silent switch
    *   Privacy policy created at docs/privacy-policy.html
*   **Remaining**: Bundle ID confirmation, version number, device testing, App Store submission

## 6. Troubleshooting / iOS
From experience, debugging on physical iOS devices in this environment requires specific handling:

1.  **Always use Release Mode**:
    *   Command: `flutter run --release`
    *   Debug mode often fails with JIT compilation errors or infinite hanging.

2.  **Fixing "Installing and launching..." Hangs**:
    *   If the process hangs during installation:
        1.  Kill stuck processes: `pkill -9 -f "flutter.*"` and `pkill -9 -f idevicesyslog`
        2.  Clean build: `flutter clean` && `flutter pub get`
        3.  Retry: `flutter run --release -d <device_id>`

3.  **Alternative (Xcode)**:
    *   Open `ios/Runner.xcworkspace` in Xcode.
    *   Select device and change Scheme to **Release** (Product > Scheme > Edit Scheme).
    *   Run (Cmd+R).
