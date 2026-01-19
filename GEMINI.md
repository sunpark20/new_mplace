# GEMINI.md - Project Context & Guidelines

## 1. Project Overview
**Name**: 기억의 궁전 (Memory Palace)
**Type**: Android Application (Java)
**Purpose**: A memory training application teaching techniques like "Memory Palace" and "PAO (Person-Action-Object)".
**Package**: `hungry.ex_frag`

## 2. Tech Stack & Dependencies
*   **Language**: Java
*   **Min SDK**: 21
*   **Target SDK**: 34
*   **Ads**: Google AdMob (`play-services-ads:23.0.0`)
*   **Media**: Native `MediaPlayer` for sounds, External Video Player via `FileProvider` for video.

## 3. Architecture & Key Components

### A. Activity Flow
*   **LoadingActivity**: App entry point. Initializes MobileAds and delays for 2 seconds before launching MainActivity.
*   **MainActivity**: The hub. Navigation to different learning days (Day 0-6), Practice, and Video.
*   **Day_Activity** (`hungry.ex_frag.day`): The core learning interface.
    *   Displays a sequence of slides defined by `TI` objects.
    *   Handles Images, Animations, Sounds, Timers, and HTML text.
*   **NumPrac_Activity** (`hungry.ex_frag.numPrac`): Number memorization practice game.
*   **NumSample_Activity** (`hungry.ex_frag.numSample`): Reference guide for Number-Person codes (00-99).
    *   Uses `NumSample_Dialog` to show details.

### B. Data Models
#### 1. `TI` (Text-Image) - Located in `hungry.ex_frag.day`
The primary data structure for learning slides.
*   **Fields**:
    *   `text`: Main content text.
    *   `imageResId`: Main image resource.
    *   `animationDrawableResId`: Frame animation resource.
    *   `soundResId`: Audio resource (raw).
    *   `alarmTimeInSeconds`: Timer duration (starts `CountDownTimer`).
    *   `isHtml`: Boolean to render HTML text.
    *   `isYoutubeLink`: Boolean to show video button (plays local `ted_video`).
    *   `isTouchPage`: Boolean. If true, touching image advances to next page.
    *   `resultImageResId`: Image to show *after* timer finishes (used for transformation effects).
    
#### 2. `Item` - Located in `hungry.ex_frag.numSample`
Simple POJO for Number codes.
*   **Fields**: `name` (Person), `cha` (Character/Feature), `des` (Description).

### C. Resource Conventions
*   **Images**: Stored in `res/drawable`. Naming convention: `d{day}_{index}` (e.g., `d1_4`, `d2_16`).
*   **Sounds/Video**: Stored in `res/raw`. `ted_video.mp4` is the main video.
*   **Data Providers**: Static classes `day0.java`, `day1.java`, ..., `day6_pao.java` provide `ArrayList<TI>`.

## 4. Key Logic & Recent Fixes (CRITICAL)

### A. Video Playback
*   **Mechanism**: Uses System's External Player.
*   **Implementation**: Copies `R.raw.ted_video` to `getCacheDir()` and shares via `FileProvider` (`androidx.core.content.FileProvider`).
*   **Reason**: `android.resource://` URIs are often blocked by external players due to permissions.

### B. Scroll & Layout Stability
*   **Issue**: ScrollView retaining position or layout shifting when changing pages with different content lengths.
*   **Solution**: In `Day_Activity.updatePageContent`:
    1.  `tv.clearFocus()` to prevent auto-scroll to links.
    2.  `scV.scrollTo(0, 0)` immediately.
    3.  `scV.post` and `postDelayed` to force `fullScroll(View.FOCUS_UP)` after layout calculation.
    4.  `frag_day.xml`: ScrollView uses `overScrollMode="never"` and NO `fillViewport`. TextView uses `gravity="top"`.

### C. Timer & Animations
*   **Timer**: Uses `CountDownTimer`. Updates `timer` TextView.
*   **Animation Layering**: Animations are set via `iv.setImageResource()` (not background) to ensure they appear on top.
*   **Transformation Logic (Day 2 Page 10 etc.)**:
    *   If `resultImageResId` is set: Animation plays during timer -> Image switches to `resultImageResId` on finish.
    *   If `imageResId` is 0 but `animationDrawableResId` exists: Animation starts immediately (used for Day 2, Page 10).

### D. AdMob & Policies
*   **Policy**: "Data Safety" form in Play Console MUST declare collection of Device ID, Location, and Crash Logs (for AdMob).
*   **Testing**: Always use Test Unit IDs in `strings.xml` during development.
*   **Placement**: Banner (`adView111`) is placed at the **TOP** of layouts (`alignParentTop="true"`).

## 5. Coding Guidelines
*   **Context**: Always read `GEMINI.md` first to understand the environment.
*   **Safety**: Use `try-catch` blocks when dealing with Intents (especially external apps) and File I/O.
*   **Compatibility**: Use `AppCompat` themes (e.g., `Theme.AppCompat.Light.Dialog`) for Dialog activities to avoid crashes.
*   **UI Updates**: Any UI changes in `Day_Activity` must consider the `TI` object's state (reset visibility of all elements: Image, Button, Timer, FrameLayout).
