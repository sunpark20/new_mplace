import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

/// 클릭 사운드가 포함된 버튼 위젯
/// 누르면 MouseClick1.wav, 떼면 MouseClick2.wav 재생
class SoundButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;

  const SoundButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  State<SoundButton> createState() => _SoundButtonState();
}

class _SoundButtonState extends State<SoundButton> {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  void _onTapDown(TapDownDetails details) {
    _audioPlayer.stop();
    _audioPlayer.play(AssetSource('sounds/MouseClick1.wav'));
  }

  void _onTapUp(TapUpDetails details) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('sounds/MouseClick2.wav'));
    await Future.delayed(const Duration(milliseconds: 100));
    widget.onPressed();
  }

  void _onTapCancel() {
    _audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AbsorbPointer(
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

/// 텍스트만 있는 간단한 사운드 버튼
class SoundTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SoundTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SoundButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
