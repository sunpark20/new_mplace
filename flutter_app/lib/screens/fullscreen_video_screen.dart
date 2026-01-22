import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

/// 스킵 불가능한 풀스크린 가로모드 동영상 재생 화면
/// 동영상이 끝나면 자동으로 화면이 닫힘
class FullscreenVideoScreen extends StatefulWidget {
  final String videoPath;

  const FullscreenVideoScreen({super.key, required this.videoPath});

  @override
  State<FullscreenVideoScreen> createState() => _FullscreenVideoScreenState();
}

class _FullscreenVideoScreenState extends State<FullscreenVideoScreen> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    // 가로모드 강제
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    // 상태바, 네비게이션바 숨김
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _controller = VideoPlayerController.asset(widget.videoPath);
      await _controller!.initialize();

      // 동영상 끝나면 자동으로 화면 닫기
      _controller!.addListener(_onVideoProgress);

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
        await _controller!.play();
      }
    } catch (e) {
      debugPrint('Error initializing video: $e');
      if (mounted) {
        setState(() {
          _hasError = true;
        });
        // 에러 시 2초 후 자동으로 닫기
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) Navigator.pop(context);
        });
      }
    }
  }

  void _onVideoProgress() {
    if (_controller != null && _controller!.value.isInitialized) {
      final position = _controller!.value.position;
      final duration = _controller!.value.duration;

      // 동영상이 끝났으면 화면 닫기
      if (position >= duration - const Duration(milliseconds: 500)) {
        _controller!.removeListener(_onVideoProgress);
        if (mounted) {
          Navigator.pop(context);
        }
      }
    }
  }

  @override
  void dispose() {
    // 세로모드로 복귀
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // 시스템 UI 복원
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _controller?.removeListener(_onVideoProgress);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // 뒤로가기 버튼 비활성화 (스킵 방지)
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: _hasError
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, color: Colors.white, size: 64),
                    SizedBox(height: 16),
                    Text(
                      '동영상을 재생할 수 없습니다',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                )
              : _isInitialized && _controller != null
                  ? AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: VideoPlayer(_controller!),
                    )
                  : const CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}
