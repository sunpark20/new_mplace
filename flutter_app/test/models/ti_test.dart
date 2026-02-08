import 'package:flutter_test/flutter_test.dart';
import 'package:memory_palace/models/ti.dart';

void main() {
  group('TI Model Tests', () {
    test('should create TI with basic properties', () {
      final ti = TI(text: 'Test text');

      expect(ti.text, 'Test text');
      expect(ti.imageAssetPath, null);
      expect(ti.soundAssetPath, null);
      expect(ti.alarmTimeInSeconds, null);
      expect(ti.isHtml, false);
      expect(ti.isYoutubeLink, false);
      expect(ti.isTouchPage, false);
      expect(ti.hasTouchSound, false);
    });

    test('should create TI with image', () {
      final ti = TI(
        text: 'Test',
        imageAssetPath: 'assets/images/test.png',
      );

      expect(ti.hasImage, true);
      expect(ti.imageAssetPath, 'assets/images/test.png');
    });

    test('should use withSound builder method', () {
      final ti = TI(text: 'Test').withSound('assets/sounds/test.mp3');

      expect(ti.hasSound, true);
      expect(ti.soundAssetPath, 'assets/sounds/test.mp3');
    });

    test('should use withAlarm builder method', () {
      final ti = TI(text: 'Test').withAlarm(60);

      expect(ti.hasTimer, true);
      expect(ti.alarmTimeInSeconds, 60);
    });

    test('should use withAnimation builder method', () {
      final frames = ['frame1.png', 'frame2.png', 'frame3.png'];
      final ti = TI(text: 'Test').withAnimation(frames);

      expect(ti.hasAnimation, true);
      expect(ti.animationFrames, frames);
      expect(ti.animationFrames!.length, 3);
    });

    test('should chain multiple builder methods', () {
      final ti = TI(text: 'Test')
          .withSound('test.mp3')
          .withAlarm(30)
          .asHtml()
          .withTouchSound();

      expect(ti.hasSound, true);
      expect(ti.hasTimer, true);
      expect(ti.isHtml, true);
      expect(ti.hasTouchSound, true);
    });

    test('should use asYoutubeLink builder method', () {
      final ti = TI(text: 'Test').asYoutubeLink();

      expect(ti.isYoutubeLink, true);
    });

    test('should use withOverlayText builder method', () {
      final ti = TI(text: 'Test').withOverlayText('Overlay');

      expect(ti.overlayText, 'Overlay');
    });

    test('should handle result image', () {
      final ti = TI(text: 'Test').withResultImage('result.png');

      expect(ti.resultImageAssetPath, 'result.png');
    });
  });
}
