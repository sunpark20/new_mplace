import 'package:flutter/foundation.dart';
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
  bool _isFadingOut = false;

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
      if (kDebugMode) debugPrint('Error initializing video: $e');
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
        _closeWithTransition();
      }
    }
  }

  Future<void> _closeWithTransition() async {
    if (kDebugMode) debugPrint('=== _closeWithTransition started ===');
    if (!mounted) {
      if (kDebugMode) debugPrint('=== NOT MOUNTED, returning ===');
      return;
    }

    // 1. 페이드아웃 시작
    setState(() => _isFadingOut = true);

    // 2. 비디오 정지
    await _controller?.pause();

    // 3. 페이드아웃 애니메이션 대기
    await Future.delayed(const Duration(milliseconds: 200));

    // 4. orientation 미리 변경 (iPad에서 실패할 수 있음)
    try {
      await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    } catch (e) {
      if (kDebugMode) debugPrint('Orientation change failed: $e');
    }

    // 5. 회전 완료 대기 후 pop
    await Future.delayed(const Duration(milliseconds: 100));

    if (kDebugMode) debugPrint('=== Calling Navigator.pop, mounted=$mounted ===');
    if (mounted) Navigator.pop(context);
    if (kDebugMode) debugPrint('=== Navigator.pop done ===');
  }

  @override
  void dispose() {
    // _closeWithTransition에서 이미 처리하지 않은 경우만
    if (!_isFadingOut) {
      try {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      } catch (e) {
        if (kDebugMode) debugPrint('Orientation change failed: $e');
      }
    }
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
        body: AnimatedOpacity(
          opacity: _isFadingOut ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Center(
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
      ),
    );
  }
}
