# Flutter 앱 최적화 및 정리 전략

## 1. 사용하지 않는 파일 삭제

### 삭제된 파일 확인 (git status 기준)
```
deleted: assets/images/chain.png
deleted: assets/images/d0_2_backup.png
deleted: assets/images/d0_2x.png
deleted: assets/images/d0_4_1.png
deleted: assets/images/exam.png
deleted: lib/screens/num_prac_screen.dart
deleted: ../SKILL.md
```

### 확인 필요
- `num_prac_screen.dart` 삭제 시 다른 파일에서 import 제거 필요
- 삭제된 이미지들이 data 파일에서 참조되지 않는지 확인

## 2. 이미지 최적화

### 대용량 파일 확인
```bash
find assets/images -type f -size +500k
```

### 최적화 방법
- PNG → WebP 변환 (50-70% 용량 감소)
- 불필요하게 큰 해상도 이미지 리사이즈
- 사용하지 않는 이미지 삭제

## 3. 비디오 최적화

### 현재 비디오 파일
- `assets/videos/ted_video.mp4` (69MB) - 매우 큼
- `assets/videos/sasa.mp4` (5.9MB)

### 최적화 방법
```bash
# ffmpeg으로 비디오 압축
ffmpeg -i input.mp4 -vcodec h264 -acodec aac -crf 28 output.mp4
```

## 4. 코드 정리

### 중복 코드 확인
- `day0.dart`, `day1.dart`, `day2.dart`, `day32.dart` 패턴 확인
- 공통 TI 패턴 추출 가능 여부

### 미사용 import 제거
```bash
flutter analyze
```

### 미사용 변수/함수 제거
- IDE의 "unused" 경고 확인
- `dart analyze` 실행

## 5. 의존성 정리

### pubspec.yaml 확인
```bash
flutter pub outdated
```

### 미사용 패키지 제거
- 실제로 사용되는 패키지만 유지

## 6. 빌드 크기 분석

```bash
flutter build ios --analyze-size
flutter build apk --analyze-size
```

## 7. 실행 순서

1. **백업**: 현재 상태 커밋
2. **분석**: 미사용 파일/코드 목록 작성
3. **이미지 최적화**: 대용량 이미지 압축
4. **비디오 최적화**: 대용량 비디오 압축
5. **코드 정리**: 미사용 import/변수 제거
6. **의존성 정리**: 미사용 패키지 제거
7. **테스트**: 전체 앱 기능 테스트
8. **빌드**: 최종 빌드 크기 확인

## 8. 예상 효과

- 앱 크기 감소 (특히 비디오 최적화 시)
- 빌드 시간 단축
- 코드 가독성 향상
