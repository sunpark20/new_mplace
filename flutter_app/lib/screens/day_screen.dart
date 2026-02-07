import 'video_screen.dart';
import 'fullscreen_video_screen.dart';
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../models/ti.dart';

class DayScreen extends StatefulWidget {
  final String title;
  final List<TI> tiArray;

  const DayScreen({
    super.key,
    required this.title,
    required this.tiArray,
  });

  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> with TickerProviderStateMixin {
  int _currentPage = 0;
  Timer? _countdownTimer;
  Timer? _animationTimer;
  int _remainingSeconds = 0;
  bool _timerCompleted = false;
  int _currentAnimationFrame = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();
  DateTime? _lastBackPressTime;
  bool _showExitWarning = false;
  Timer? _exitWarningTimer;
  bool _isExiting = false;  // 나가기 중복 방지

  final List<AudioPlayer> _combatPlayers = [];
  Offset _shakeOffset = Offset.zero;

  Timer? _flashTimer;
  bool _showPreviousPagePreview = false;
  bool _triggerFlashOnLoad = false;
  final List<_HitEffect> _hitEffects = [];
  final Random _random = Random();

  int _currentRepeatCount = 0;
  int _totalRepeatCount = 0;
  final AudioPlayer _repeatAudioPlayer = AudioPlayer();
  bool _isRepeatPlaying = false;
  CancelableOperation<void>? _repeatSoundOperation;
  StreamSubscription<void>? _repeatCompleteSubscription;
  String? _currentRepeatPath;

  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  bool _autoVideoPlayed = false;  // autoFullscreenVideo 재생 완료 여부
  final AudioPlayer _backgroundMusicPlayer = AudioPlayer();

  // Crack Transform 관련 변수
  int _crackTouchCounter = 0;
  List<bool> _visibleCracks = [];
  bool _isTransformed = false;
  AnimationController? _transformAnimController;
  Animation<double>? _transformAnimation;
  Animation<Offset>? _slideAnimation;
  Animation<double>? _scaleAnimation;
  Animation<double>? _rotateAnimation;

  // 텍스트 크기 조절
  double _textScale = 1.0;
  double _baseTextScale = 1.0;  // 핀치 시작 시 스케일 저장
  static const double _minTextScale = 0.8;
  static const double _maxTextScale = 2.5;

  // 선택지 목적지 인덱스들 (이전/다음에서 건너뛸 페이지들)
  late final Set<int> _choiceDestinations;

  static const List<String> _alarmSounds = [
    'assets/sounds/alarm/ArrangedTeamInvitation.wav',
    'assets/sounds/alarm/ClanInvitation.wav',
    'assets/sounds/alarm/DuskWolf.wav',
    'assets/sounds/alarm/GoldMineRunningOut1.wav',
    'assets/sounds/alarm/Hint.wav',
    'assets/sounds/alarm/MapPing.wav',
    'assets/sounds/alarm/NewTournament.wav',
    'assets/sounds/alarm/OrcMAinGlueScreenBear02.wav',
    'assets/sounds/alarm/OrcMAinGlueScreenBear03.wav',
    'assets/sounds/alarm/PeasantBuildingComplete1.wav',
    'assets/sounds/alarm/QuestCompleted.wav',
    'assets/sounds/alarm/QuestFailed.wav',
    'assets/sounds/alarm/QuestNew.wav',
    'assets/sounds/alarm/Rescue.wav',
    'assets/sounds/alarm/SecretFound.wav',
    'assets/sounds/alarm/UpkeepRing.wav',
    'assets/sounds/alarm/Warning.wav',
  ];

  static const List<String> _combatSounds = [
    'sounds/combat/AxeMediumChopWood1.wav',
    'sounds/combat/AxeMediumChopWood2.wav',
    'sounds/combat/AxeMediumChopWood3.wav',
    'sounds/combat/AxeMediumChopWood4.wav',
    'sounds/combat/EtherealHeavyHit1.wav',
    'sounds/combat/EtherealHeavyHit2.wav',
    'sounds/combat/EtherealHeavyHit3.wav',
    'sounds/combat/EtherealMediumHit1.wav',
    'sounds/combat/EtherealMediumHit2.wav',
    'sounds/combat/EtherealMediumHit3.wav',
    'sounds/combat/MetalHeavyBashFlesh1.wav',
    'sounds/combat/MetalHeavyBashFlesh2.wav',
    'sounds/combat/MetalHeavyBashFlesh3.wav',
    'sounds/combat/MetalHeavyBashMetal1.wav',
    'sounds/combat/MetalHeavyBashMetal2.wav',
    'sounds/combat/MetalHeavyBashMetal3.wav',
    'sounds/combat/MetalHeavyBashStone1.wav',
    'sounds/combat/MetalHeavyBashStone2.wav',
    'sounds/combat/MetalHeavyBashStone3.wav',
    'sounds/combat/MetalHeavyBashWood1.wav',
    'sounds/combat/MetalHeavyBashWood2.wav',
    'sounds/combat/MetalHeavyBashWood3.wav',
    'sounds/combat/MetalHeavyChopFlesh1.wav',
    'sounds/combat/MetalHeavyChopFlesh2.wav',
    'sounds/combat/MetalHeavyChopFlesh3.wav',
    'sounds/combat/MetalHeavyChopMetal1.wav',
    'sounds/combat/MetalHeavyChopMetal2.wav',
    'sounds/combat/MetalHeavyChopMetal3.wav',
    'sounds/combat/MetalHeavyChopStone1.wav',
    'sounds/combat/MetalHeavyChopStone2.wav',
    'sounds/combat/MetalHeavyChopStone3.wav',
    'sounds/combat/MetalHeavyChopWood1.wav',
    'sounds/combat/MetalHeavyChopWood2.wav',
    'sounds/combat/MetalHeavyChopWood3.wav',
    'sounds/combat/MetalHeavySliceFlesh1.wav',
    'sounds/combat/MetalHeavySliceFlesh2.wav',
    'sounds/combat/MetalHeavySliceFlesh3.wav',
    'sounds/combat/MetalHeavySliceMetal1.wav',
    'sounds/combat/MetalHeavySliceMetal2.wav',
    'sounds/combat/MetalHeavySliceMetal3.wav',
    'sounds/combat/MetalHeavySliceStone1.wav',
    'sounds/combat/MetalHeavySliceStone2.wav',
    'sounds/combat/MetalHeavySliceStone3.wav',
    'sounds/combat/MetalHeavySliceWood1.wav',
    'sounds/combat/MetalHeavySliceWood2.wav',
    'sounds/combat/MetalHeavySliceWood3.wav',
    'sounds/combat/MetalLightChopFlesh1.wav',
    'sounds/combat/MetalLightChopFlesh2.wav',
    'sounds/combat/MetalLightChopFlesh3.wav',
    'sounds/combat/MetalLightChopMetal1.wav',
    'sounds/combat/MetalLightChopMetal2.wav',
    'sounds/combat/MetalLightChopMetal3.wav',
    'sounds/combat/MetalLightChopStone1.wav',
    'sounds/combat/MetalLightChopStone2.wav',
    'sounds/combat/MetalLightChopStone3.wav',
    'sounds/combat/MetalLightChopWood1.wav',
    'sounds/combat/MetalLightChopWood2.wav',
    'sounds/combat/MetalLightChopWood3.wav',
    'sounds/combat/MetalLightSliceFlesh1.wav',
    'sounds/combat/MetalLightSliceFlesh2.wav',
    'sounds/combat/MetalLightSliceFlesh3.wav',
    'sounds/combat/MetalLightSliceMetal1.wav',
    'sounds/combat/MetalLightSliceMetal2.wav',
    'sounds/combat/MetalLightSliceMetal3.wav',
    'sounds/combat/MetalLightSliceStone1.wav',
    'sounds/combat/MetalLightSliceStone2.wav',
    'sounds/combat/MetalLightSliceStone3.wav',
    'sounds/combat/MetalLightSliceWood1.wav',
    'sounds/combat/MetalLightSliceWood2.wav',
    'sounds/combat/MetalLightSliceWood3.wav',
    'sounds/combat/MetalMediumBashFlesh1.wav',
    'sounds/combat/MetalMediumBashFlesh2.wav',
    'sounds/combat/MetalMediumBashFlesh3.wav',
    'sounds/combat/MetalMediumBashMetal1.wav',
    'sounds/combat/MetalMediumBashMetal2.wav',
    'sounds/combat/MetalMediumBashMetal3.wav',
    'sounds/combat/MetalMediumBashStone1.wav',
    'sounds/combat/MetalMediumBashStone2.wav',
    'sounds/combat/MetalMediumBashStone3.wav',
    'sounds/combat/MetalMediumBashWood1.wav',
    'sounds/combat/MetalMediumBashWood2.wav',
    'sounds/combat/MetalMediumBashWood3.wav',
    'sounds/combat/MetalMediumChopFlesh1.wav',
    'sounds/combat/MetalMediumChopFlesh2.wav',
    'sounds/combat/MetalMediumChopFlesh3.wav',
    'sounds/combat/MetalMediumChopMetal1.wav',
    'sounds/combat/MetalMediumChopMetal2.wav',
    'sounds/combat/MetalMediumChopMetal3.wav',
    'sounds/combat/MetalMediumChopStone1.wav',
    'sounds/combat/MetalMediumChopStone2.wav',
    'sounds/combat/MetalMediumChopStone3.wav',
    'sounds/combat/MetalMediumChopWood1.wav',
    'sounds/combat/MetalMediumChopWood2.wav',
    'sounds/combat/MetalMediumChopWood3.wav',
    'sounds/combat/MetalMediumSliceFlesh1.wav',
    'sounds/combat/MetalMediumSliceFlesh2.wav',
    'sounds/combat/MetalMediumSliceFlesh3.wav',
    'sounds/combat/MetalMediumSliceMetal1.wav',
    'sounds/combat/MetalMediumSliceMetal2.wav',
    'sounds/combat/MetalMediumSliceMetal3.wav',
    'sounds/combat/MetalMediumSliceStone1.wav',
    'sounds/combat/MetalMediumSliceStone2.wav',
    'sounds/combat/MetalMediumSliceStone3.wav',
    'sounds/combat/MetalMediumSliceWood1.wav',
    'sounds/combat/MetalMediumSliceWood2.wav',
    'sounds/combat/MetalMediumSliceWood3.wav',
    'sounds/combat/RockHeavyBashFlesh1.wav',
    'sounds/combat/RockHeavyBashFlesh2.wav',
    'sounds/combat/RockHeavyBashFlesh3.wav',
    'sounds/combat/RockHeavyBashMetal1.wav',
    'sounds/combat/RockHeavyBashMetal2.wav',
    'sounds/combat/RockHeavyBashMetal3.wav',
    'sounds/combat/RockHeavyBashStone1.wav',
    'sounds/combat/RockHeavyBashStone2.wav',
    'sounds/combat/RockHeavyBashStone3.wav',
    'sounds/combat/RockHeavyBashWood1.wav',
    'sounds/combat/RockHeavyBashWood2.wav',
    'sounds/combat/RockHeavyBashWood3.wav',
    'sounds/combat/WoodHeavyBashFlesh1.wav',
    'sounds/combat/WoodHeavyBashFlesh2.wav',
    'sounds/combat/WoodHeavyBashFlesh3.wav',
    'sounds/combat/WoodHeavyBashMetal1.wav',
    'sounds/combat/WoodHeavyBashMetal2.wav',
    'sounds/combat/WoodHeavyBashMetal3.wav',
    'sounds/combat/WoodHeavyBashStone1.wav',
    'sounds/combat/WoodHeavyBashStone2.wav',
    'sounds/combat/WoodHeavyBashStone3.wav',
    'sounds/combat/WoodHeavyBashWood1.wav',
    'sounds/combat/WoodHeavyBashWood2.wav',
    'sounds/combat/WoodHeavyBashWood3.wav',
    'sounds/combat/WoodLightBashFlesh1.wav',
    'sounds/combat/WoodLightBashFlesh2.wav',
    'sounds/combat/WoodLightBashFlesh3.wav',
    'sounds/combat/WoodLightBashMetal1.wav',
    'sounds/combat/WoodLightBashMetal2.wav',
    'sounds/combat/WoodLightBashMetal3.wav',
    'sounds/combat/WoodLightBashStone1.wav',
    'sounds/combat/WoodLightBashStone2.wav',
    'sounds/combat/WoodLightBashStone3.wav',
    'sounds/combat/WoodLightBashWood1.wav',
    'sounds/combat/WoodLightBashWood2.wav',
    'sounds/combat/WoodLightBashWood3.wav',
    'sounds/combat/WoodMediumBashFlesh1.wav',
    'sounds/combat/WoodMediumBashFlesh2.wav',
    'sounds/combat/WoodMediumBashFlesh3.wav',
    'sounds/combat/WoodMediumBashMetal1.wav',
    'sounds/combat/WoodMediumBashMetal2.wav',
    'sounds/combat/WoodMediumBashMetal3.wav',
    'sounds/combat/WoodMediumBashStone1.wav',
    'sounds/combat/WoodMediumBashStone2.wav',
    'sounds/combat/WoodMediumBashStone3.wav',
    'sounds/combat/WoodMediumBashWood1.wav',
    'sounds/combat/WoodMediumBashWood2.wav',
    'sounds/combat/WoodMediumBashWood3.wav',
  ];


  @override
  void initState() {
    super.initState();
    // 모든 선택지의 목적지 인덱스 수집 (이전/다음에서 건너뛸 페이지들)
    _choiceDestinations = <int>{};
    for (final ti in widget.tiArray) {
      if (ti.hasChoices) {
        for (final choice in ti.choices!) {
          _choiceDestinations.add(choice.targetIndex);
        }
      }
    }
    _loadTextScale();
    _loadCurrentPage();
  }

  Future<void> _loadTextScale() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _textScale = prefs.getDouble('textScale') ?? 1.0;
    });
  }

  Future<void> _saveTextScale() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('textScale', _textScale);
  }

  void _increaseTextScale() {
    if (_textScale < _maxTextScale) {
      setState(() {
        _textScale = (_textScale + 0.1).clamp(_minTextScale, _maxTextScale);
      });
      _saveTextScale();
    }
  }

  void _decreaseTextScale() {
    if (_textScale > _minTextScale) {
      setState(() {
        _textScale = (_textScale - 0.1).clamp(_minTextScale, _maxTextScale);
      });
      _saveTextScale();
    }
  }

  void _loadCurrentPage() {
    _timerCompleted = false;
    _currentAnimationFrame = 0;
    _animationTimer?.cancel();
    _currentRepeatCount = 0;
    _isRepeatPlaying = false;
    _repeatSoundOperation?.cancel();
    _repeatSoundOperation = null;
    _repeatCompleteSubscription?.cancel();
    _repeatCompleteSubscription = null;
    _currentRepeatPath = null;
    _repeatAudioPlayer.stop();
    _disposeVideoController();
    _autoVideoPlayed = false;

    final ti = widget.tiArray[_currentPage];

    // 자동 풀스크린 비디오 재생 (build 완료 후 호출)
    if (ti.hasAutoFullscreenVideo) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _playAutoFullscreenVideo(ti.autoFullscreenVideo!);
      });
    }

    if (ti.hasVideo) {
      _initializeVideo(ti.videoPath!);
    }

    // Crack Transform 초기화
    if (ti.hasCrackTransform) {
      _crackTouchCounter = 0;
      _visibleCracks = List.filled(ti.crackImages!.length, false);
      _isTransformed = false;
      _initTransformAnimation(ti.transformEffect ?? TransformEffect.fadeIn);
    }

    // 백그라운드 음악
    _backgroundMusicPlayer.stop();
    if (ti.hasBackgroundMusic) {
      _playBackgroundMusic(ti.backgroundMusic!);
    }

    if (ti.initialSound != null && ti.repeatCount != null) {
      _totalRepeatCount = ti.repeatCount!;
      _startRepeatSound(ti.initialSound!, ti.soundAssetPath!);
    } else if (ti.hasSound) {
      _playSound(ti.soundAssetPath!);
    }

    if (ti.hasTimer) {
      _startTimer(ti.alarmTimeInSeconds!);
    }

    if (ti.hasAnimation && ti.animationFrames!.length > 1) {
      _startAnimation(ti.animationFrames!.length);
    }

    if (_triggerFlashOnLoad) {
      _triggerFlashOnLoad = false;
      _runFlashEffect();
    }
  }

  Widget _buildTransformedImage(TI ti) {
    final effect = ti.transformEffect ?? TransformEffect.fadeIn;

    Widget image = Image.asset(
      ti.transformedImage!,
      width: double.infinity,
      fit: BoxFit.fitWidth,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Error loading transformed image ${ti.transformedImage}: $error');
        return Container(
          height: 200,
          color: Colors.grey[300],
          child: const Center(
            child: Icon(Icons.image_not_supported, size: 64),
          ),
        );
      },
    );

    if (_transformAnimController == null) return image;

    return AnimatedBuilder(
      animation: _transformAnimController!,
      builder: (context, child) {
        switch (effect) {
          case TransformEffect.fadeIn:
            return Opacity(
              opacity: _transformAnimation?.value ?? 1.0,
              child: child,
            );
          case TransformEffect.slideLeft:
          case TransformEffect.slideRight:
          case TransformEffect.slideUp:
          case TransformEffect.slideDown:
            return SlideTransition(
              position: _slideAnimation ?? AlwaysStoppedAnimation(Offset.zero),
              child: child,
            );
          case TransformEffect.scale:
            return Transform.scale(
              scale: _scaleAnimation?.value ?? 1.0,
              child: child,
            );
          case TransformEffect.rotate:
            return Transform.rotate(
              angle: (_rotateAnimation?.value ?? 0.0) * pi,
              child: Opacity(
                opacity: _transformAnimation?.value ?? 1.0,
                child: child,
              ),
            );
          case TransformEffect.flip:
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY((_rotateAnimation?.value ?? 0.0) * pi),
              child: child,
            );
          case TransformEffect.zoomBlur:
            return Transform.scale(
              scale: _scaleAnimation?.value ?? 1.0,
              child: Opacity(
                opacity: _transformAnimation?.value ?? 1.0,
                child: child,
              ),
            );
          case TransformEffect.dissolve:
            return Opacity(
              opacity: _transformAnimation?.value ?? 1.0,
              child: child,
            );
        }
      },
      child: image,
    );
  }

  void _initTransformAnimation(TransformEffect effect) {
    _transformAnimController?.dispose();
    _transformAnimController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    switch (effect) {
      case TransformEffect.fadeIn:
        _transformAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _transformAnimController!, curve: Curves.easeInOut),
        );
        break;
      case TransformEffect.slideLeft:
        _slideAnimation = Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero).animate(
          CurvedAnimation(parent: _transformAnimController!, curve: Curves.easeOutCubic),
        );
        break;
      case TransformEffect.slideRight:
        _slideAnimation = Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero).animate(
          CurvedAnimation(parent: _transformAnimController!, curve: Curves.easeOutCubic),
        );
        break;
      case TransformEffect.slideUp:
        _slideAnimation = Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero).animate(
          CurvedAnimation(parent: _transformAnimController!, curve: Curves.easeOutCubic),
        );
        break;
      case TransformEffect.slideDown:
        _slideAnimation = Tween<Offset>(begin: const Offset(0.0, -1.0), end: Offset.zero).animate(
          CurvedAnimation(parent: _transformAnimController!, curve: Curves.easeOutCubic),
        );
        break;
      case TransformEffect.scale:
        _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _transformAnimController!, curve: Curves.elasticOut),
        );
        break;
      case TransformEffect.rotate:
        _rotateAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
          CurvedAnimation(parent: _transformAnimController!, curve: Curves.easeOutBack),
        );
        _transformAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _transformAnimController!, curve: Curves.easeInOut),
        );
        break;
      case TransformEffect.flip:
        _rotateAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(parent: _transformAnimController!, curve: Curves.easeInOut),
        );
        break;
      case TransformEffect.zoomBlur:
        _scaleAnimation = Tween<double>(begin: 1.5, end: 1.0).animate(
          CurvedAnimation(parent: _transformAnimController!, curve: Curves.easeOut),
        );
        _transformAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _transformAnimController!, curve: Curves.easeIn),
        );
        break;
      case TransformEffect.dissolve:
        _transformAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _transformAnimController!, curve: Curves.easeInOutSine),
        );
        break;
    }
  }

  void _initializeVideo(String videoPath) async {
    try {
      // 기존 컨트롤러가 있으면 먼저 정리
      await _disposeVideoControllerAsync();

      final cleanPath = videoPath.replaceFirst('assets/', '');
      _videoController = VideoPlayerController.asset('assets/$cleanPath');
      await _videoController!.initialize();
      await _videoController!.setLooping(false); // 한 번만 재생

      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
        });
        await _videoController!.play();
      }
    } catch (e) {
      debugPrint('Error initializing video: $e');
      _disposeVideoControllerAsync();
    }
  }

  Future<void> _disposeVideoControllerAsync() async {
    if (_videoController != null) {
      try {
        await _videoController!.pause();
        await _videoController!.dispose();
      } catch (e) {
        debugPrint('Error disposing video controller: $e');
      }
      _videoController = null;
      _isVideoInitialized = false;
    }
  }

  void _disposeVideoController() {
    if (_videoController != null) {
      final controller = _videoController;
      _videoController = null;
      _isVideoInitialized = false;
      // 비동기로 정리하되, 현재 컨트롤러 참조 유지
      controller!.pause().then((_) {
        controller.dispose();
      }).catchError((e) {
        debugPrint('Error disposing video controller sync: $e');
        try {
          controller.dispose();
        } catch (_) {}
      });
    }
  }

  /// 페이지 로드 시 자동으로 풀스크린 비디오 재생
  void _playAutoFullscreenVideo(String videoPath) async {
    debugPrint('=== _playAutoFullscreenVideo started ===');
    if (mounted) {
      debugPrint('=== Navigator.push starting ===');
      await Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              FullscreenVideoScreen(videoPath: videoPath),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
      debugPrint('=== Navigator.push returned, mounted=$mounted ===');
      // 비디오 완료 후 돌아오면 콘텐츠 표시
      if (mounted) {
        debugPrint('=== Setting _autoVideoPlayed = true ===');
        setState(() {
          _autoVideoPlayed = true;
        });
      }
    }
  }

  void _playSound(String path) async {
    try {
      String actualPath = path;
      if (path == 'random') {
        actualPath = _alarmSounds[_random.nextInt(_alarmSounds.length)];
      }

      final cleanPath = actualPath.replaceFirst('assets/', '');
      await _audioPlayer.stop();
      if (cleanPath.contains('seagull.mp3')) {
        await _audioPlayer.setSource(AssetSource(cleanPath));
        await _audioPlayer.seek(const Duration(seconds: 2));
        await _audioPlayer.resume();
      } else {
        await _audioPlayer.play(AssetSource(cleanPath));
      }
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
  }

  void _playBackgroundMusic(String path) async {
    try {
      await _backgroundMusicPlayer.stop();
      final cleanPath = path.replaceFirst('assets/', '');
      await _backgroundMusicPlayer.setReleaseMode(ReleaseMode.loop);
      await _backgroundMusicPlayer.play(AssetSource(cleanPath));
    } catch (e) {
      debugPrint('Error playing background music: $e');
    }
  }

  void _startRepeatSound(String initialPath, String repeatPath) async {
    try {
      // 기존 operation 취소
      _repeatSoundOperation?.cancel();

      // 초기 사운드 재생 (mobak)
      final cleanInitialPath = initialPath.replaceFirst('assets/', '');
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(cleanInitialPath));

      // 초기 사운드가 끝나면 반복 사운드 시작 (취소 가능하도록)
      _repeatSoundOperation = CancelableOperation.fromFuture(
        _audioPlayer.onPlayerComplete.first,
        onCancel: () => debugPrint('Repeat sound operation cancelled'),
      );

      _repeatSoundOperation!.value.then((_) {
        if (mounted && !_isRepeatPlaying) {
          _playRepeatSound(repeatPath);
        }
      });
    } catch (e) {
      debugPrint('Error playing initial sound: $e');
    }
  }

  void _playRepeatSound(String repeatPath) async {
    if (_currentRepeatCount >= _totalRepeatCount) return;

    _currentRepeatPath = repeatPath;

    // 기존 subscription 정리
    _repeatCompleteSubscription?.cancel();

    // 완료 이벤트 리스너 설정
    _repeatCompleteSubscription = _repeatAudioPlayer.onPlayerComplete.listen((_) {
      if (!mounted) return;

      setState(() {
        _currentRepeatCount++;
      });

      if (_currentRepeatCount < _totalRepeatCount) {
        // 다음 반복 재생
        _playSingleRepeat(repeatPath);
      } else {
        // 완료 시 팝업 표시
        _repeatCompleteSubscription?.cancel();
        _repeatCompleteSubscription = null;
        final ti = widget.tiArray[_currentPage];
        if (ti.repeatCompletionSound != null) {
          _playSound(ti.repeatCompletionSound!);
        }
        _showCompletionDialog(ti);
      }
    });

    // 첫 번째 재생 시작
    _playSingleRepeat(repeatPath);
  }

  void _playSingleRepeat(String repeatPath) async {
    try {
      final cleanRepeatPath = repeatPath.replaceFirst('assets/', '');
      await _repeatAudioPlayer.stop();
      await _repeatAudioPlayer.play(AssetSource(cleanRepeatPath));
    } catch (e) {
      debugPrint('Error playing repeat sound: $e');
    }
  }

  void _showCompletionDialog(TI ti) {
    // 커스텀 팝업이 설정된 경우
    if (ti.repeatPopupLink != null && ti.repeatPopupButtonText != null) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              ti.repeatPopupTitle ?? '축하합니다!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            actions: [
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        final uri = Uri.parse(ti.repeatPopupLink!);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri, mode: LaunchMode.externalApplication);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        ti.repeatPopupButtonText!,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('닫기', style: TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    } else {
      // 기본 팝업
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text(
              '🎉 대단합니다!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            content: const Text(
              '박수를 99번 들은 당신은\n뭘 해도 할 사람이군요.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                height: 1.5,
              ),
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    '확인',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  void _showTransformPopup(TI ti) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            ti.transformPopupTitle ?? '축하합니다!',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          actions: [
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      final uri = Uri.parse(ti.transformPopupLink!);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      ti.transformPopupButtonText!,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('닫기', style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _runFlashEffect() {
    int flashCount = 0;
    const int totalFlashes = 6; // 3 cycles

    _flashTimer?.cancel();
    _flashTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _showPreviousPagePreview = !_showPreviousPagePreview;
        });
        flashCount++;

        if (flashCount >= totalFlashes) {
          timer.cancel();
          setState(() {
            _showPreviousPagePreview = false;
          });
        }
      }
    });
  }



  void _startTimer(int seconds) {
    setState(() {
      _remainingSeconds = seconds;
    });

    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_remainingSeconds > 0) {
            _remainingSeconds--;
          } else {
            _timerCompleted = true;
            timer.cancel();
            if (_currentPage < widget.tiArray.length - 1) {
              final nextTi = widget.tiArray[_currentPage + 1];
              if (!nextTi.hasSound) {
                final randomSound = _alarmSounds[_random.nextInt(_alarmSounds.length)];
                _playSound(randomSound);
              }
              _triggerFlashOnLoad = true;
              _nextPage();
            } else {
              _nextPage();
            }
          }
        });
      }
    });
  }

  void _startAnimation(int frameCount) {
    _animationTimer?.cancel();
    _animationTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _currentAnimationFrame = (_currentAnimationFrame + 1) % frameCount;
        });
      }
    });
  }

  /// 선택지 버튼 위젯 생성
  Widget _buildChoiceButton(Choice choice) {
    // 퀘스트 스타일 버튼 (isAccept가 지정된 경우)
    if (choice.isAccept != null) {
      return _buildQuestButton(choice);
    }

    return GestureDetector(
      onTapDown: _onChoiceTapDown,
      onTapUp: (_) => _onChoiceTapUp(choice),
      onTapCancel: () => _audioPlayer.stop(),
      child: AbsorbPointer(
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.blue.shade600,
            foregroundColor: Colors.white,
          ),
          child: Text(
            choice.label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  /// 와우 스타일 퀘스트 버튼 생성
  Widget _buildQuestButton(Choice choice) {
    final isAccept = choice.isAccept ?? false;
    final buttonColor = isAccept
        ? const Color(0xFF2E7D32)  // 진한 녹색
        : const Color(0xFF8B0000); // 진한 빨강
    final borderColor = isAccept
        ? const Color(0xFF4CAF50)  // 밝은 녹색
        : const Color(0xFFB71C1C); // 밝은 빨강

    return GestureDetector(
      onTapDown: _onChoiceTapDown,
      onTapUp: (_) => _onChoiceTapUp(choice),
      onTapCancel: () => _audioPlayer.stop(),
      child: AbsorbPointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                buttonColor.withValues(alpha: 0.9),
                buttonColor,
                buttonColor.withValues(alpha: 0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: borderColor, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Text(
            choice.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withValues(alpha: 0.7),
                  blurRadius: 2,
                  offset: const Offset(1, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 선택지 버튼 누름 시작 - mouseclick1 재생
  void _onChoiceTapDown(TapDownDetails details) {
    _audioPlayer.stop();
    _audioPlayer.play(AssetSource('sounds/MouseClick1.wav'));
  }

  /// 선택지 버튼 뗌 - 사운드 재생 후 선택 처리
  void _onChoiceTapUp(Choice choice) async {
    await _audioPlayer.stop();

    // choice에 지정된 사운드가 있으면 그것을 재생, 없으면 기본 클릭 사운드
    final soundToPlay = choice.soundPath ?? 'sounds/MouseClick2.wav';
    final isAssetPath = soundToPlay.startsWith('assets/');
    await _audioPlayer.play(AssetSource(isAssetPath ? soundToPlay.substring(7) : soundToPlay));

    if (choice.soundPath != null) {
      // 커스텀 사운드는 완료될 때까지 대기
      final completer = Completer<void>();
      late StreamSubscription subscription;
      subscription = _audioPlayer.onPlayerComplete.listen((_) {
        if (!completer.isCompleted) {
          completer.complete();
        }
        subscription.cancel();
      });
      await completer.future;
    } else {
      // 기본 클릭 사운드는 짧게 대기
      await Future.delayed(const Duration(milliseconds: 150));
    }

    _handleChoiceSelection(choice);
  }

  /// 선택지 선택 처리 - 동영상이 있으면 먼저 재생
  void _handleChoiceSelection(Choice choice) async {
    // 앱 종료 옵션이 있으면 메시지 표시 후 최소화
    if (choice.exitApp) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('앱을 종료합니다.'),
            duration: Duration(seconds: 1),
          ),
        );
      }
      await Future.delayed(const Duration(milliseconds: 1200));
      SystemNavigator.pop();
      return;
    }

    if (choice.videoPath != null) {
      // 동영상 재생 후 해당 인덱스로 이동
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FullscreenVideoScreen(videoPath: choice.videoPath!),
        ),
      );
      _jumpToIndex(choice.targetIndex);
    } else if (choice.targetIndex >= 0) {
      _jumpToIndex(choice.targetIndex);
    } else {
      // targetIndex가 -1이면 다음 페이지로
      _nextPage();
    }
  }

  /// 선택지에서 특정 인덱스로 점프
  void _jumpToIndex(int targetIndex) {
    if (targetIndex >= 0 && targetIndex < widget.tiArray.length) {
      _flashTimer?.cancel();
      _countdownTimer?.cancel();
      _animationTimer?.cancel();
      _audioPlayer.stop();
      _showPreviousPagePreview = false;
      setState(() {
        _currentPage = targetIndex;
        _loadCurrentPage();
      });
    }
  }

  /// 스와이프 시작 시 버튼 누르는 소리
  void _onSwipeStart() {
    _audioPlayer.stop();
    _audioPlayer.play(AssetSource('sounds/MouseClick1.wav'));
  }

  /// 스와이프로 다음 페이지 (버튼 떼는 소리 후 페이지 이동)
  Future<void> _swipeNextPage() async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('sounds/MouseClick2.wav'));
    await Future.delayed(const Duration(milliseconds: 100));
    _nextPage();
  }

  /// 스와이프로 이전 페이지 (버튼 떼는 소리 후 페이지 이동)
  Future<void> _swipePreviousPage() async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('sounds/MouseClick2.wav'));
    await Future.delayed(const Duration(milliseconds: 100));
    _previousPage();
  }

  void _nextPage() {
    _flashTimer?.cancel();
    _showPreviousPagePreview = false;
    _isRepeatPlaying = false;
    // _triggerFlashOnLoad = false; // Keep it if set by timer
    if (_currentPage < widget.tiArray.length - 1) {
      _countdownTimer?.cancel();
      _animationTimer?.cancel();
      _audioPlayer.stop();
      _repeatAudioPlayer.stop();
      setState(() {
        _currentPage++;
        // 선택지 목적지 페이지는 건너뛰기
        while (_currentPage < widget.tiArray.length &&
            _choiceDestinations.contains(_currentPage)) {
          _currentPage++;
        }
        if (_currentPage >= widget.tiArray.length) {
          _currentPage = widget.tiArray.length - 1;
        }
        _loadCurrentPage();
      });
    } else {
      DateTime now = DateTime.now();
      if (_lastBackPressTime == null ||
          now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
        _lastBackPressTime = now;

        setState(() {
          _showExitWarning = true;
        });

        _exitWarningTimer?.cancel();
        _exitWarningTimer = Timer(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              _showExitWarning = false;
            });
          }
        });
      } else {
        if (!_isExiting && mounted && Navigator.canPop(context)) {
          _isExiting = true;
          Navigator.pop(context);
        }
      }
    }
  }

  void _previousPage() {
    _flashTimer?.cancel();
    _showPreviousPagePreview = false;
    _triggerFlashOnLoad = false;
    _isRepeatPlaying = false;
    if (_currentPage > 0) {
      _countdownTimer?.cancel();
      _animationTimer?.cancel();
      _audioPlayer.stop();
      _repeatAudioPlayer.stop();
      setState(() {
        _currentPage--;
        // 선택지 목적지 페이지는 건너뛰기
        while (_currentPage > 0 &&
            _choiceDestinations.contains(_currentPage)) {
          _currentPage--;
        }
        _loadCurrentPage();
      });
    }
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _handleHighFiveTouch(Offset position) async {
    final ti = widget.tiArray[_currentPage];

    // Crack Transform 로직
    if (ti.hasCrackTransform && !_isTransformed) {
      _crackTouchCounter++;

      // 각 임계값에서 crack 표시
      for (int i = 0; i < ti.crackThresholds!.length; i++) {
        if (_crackTouchCounter >= ti.crackThresholds![i] && !_visibleCracks[i]) {
          setState(() {
            _visibleCracks[i] = true;
          });
        }
      }

      // 변환 임계값 도달
      if (_crackTouchCounter >= ti.transformThreshold!) {
        // 변환 소리 재생
        if (ti.transformSound != null) {
          _playSound(ti.transformSound!);
        }

        setState(() {
          _isTransformed = true;
          _visibleCracks = List.filled(ti.crackImages!.length, false);
        });

        // 변환 애니메이션 시작
        _transformAnimController?.forward().then((_) {
          // 팝업 옵션이 있으면 팝업 표시
          if (ti.transformPopupLink != null && ti.transformPopupButtonText != null) {
            _showTransformPopup(ti);
          }
        });
        return; // 변환 후에는 더 이상 터치 처리하지 않음
      }
    }

    // Shake effect
    setState(() {
      _shakeOffset = Offset(
          (_random.nextDouble() - 0.5) * 20, (_random.nextDouble() - 0.5) * 20);
    });
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) {
        setState(() {
          _shakeOffset = Offset.zero;
        });
      }
    });

    if (_combatPlayers.length >= 5) {
      final oldPlayer = _combatPlayers.removeAt(0);
      oldPlayer.stop();
      oldPlayer.dispose();
    }

    final soundIndex = _random.nextInt(_combatSounds.length);
    final sound = _combatSounds[soundIndex];
    debugPrint('Playing sound $soundIndex: $sound (total: ${_combatSounds.length})');
    final player = AudioPlayer();
    _combatPlayers.add(player);

    try {
      await player.play(AssetSource(sound));
      player.onPlayerComplete.listen((_) {
        player.dispose();
        _combatPlayers.remove(player);
      });
    } catch (e) {
      debugPrint('Error playing combat sound: $e');
      player.dispose();
      _combatPlayers.remove(player);
    }

    if (_hitEffects.length >= 10) {
      _hitEffects.removeAt(0);
    }
    final effect = _HitEffect(position: position, id: DateTime.now().millisecondsSinceEpoch);
    setState(() {
      _hitEffects.add(effect);
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() {
          _hitEffects.removeWhere((e) => e.id == effect.id);
        });
      }
    });
  }

  /// 네비게이션 버튼 (이전/다음) - 클릭 사운드 포함
  Widget _buildNavButton(String text, VoidCallback? onPressed) {
    final buttonStyle = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    );

    if (onPressed == null) {
      return ElevatedButton(
        onPressed: null,
        style: buttonStyle,
        child: Text(text),
      );
    }

    return GestureDetector(
      onTapDown: (_) {
        _audioPlayer.stop();
        _audioPlayer.play(AssetSource('sounds/MouseClick1.wav'));
      },
      onTapUp: (_) async {
        await _audioPlayer.stop();
        await _audioPlayer.play(AssetSource('sounds/MouseClick2.wav'));
        await Future.delayed(const Duration(milliseconds: 100));
        onPressed();
      },
      onTapCancel: () => _audioPlayer.stop(),
      child: AbsorbPointer(
        child: ElevatedButton(
          onPressed: () {},
          style: buttonStyle,
          child: Text(text),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _flashTimer?.cancel();
    _countdownTimer?.cancel();
    _animationTimer?.cancel();
    _repeatSoundOperation?.cancel();
    _repeatCompleteSubscription?.cancel();
    _audioPlayer.dispose();
    _repeatAudioPlayer.dispose();
    _backgroundMusicPlayer.dispose();
    _disposeVideoController();
    _exitWarningTimer?.cancel();
    _transformAnimController?.dispose();
    for (var player in _combatPlayers) {
      player.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ti = widget.tiArray[_currentPage];

    // autoFullscreenVideo가 있고 아직 재생 전이면 검은 화면만 표시 (잔상 방지)
    if (ti.hasAutoFullscreenVideo && !_autoVideoPlayed) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Container(color: Colors.black),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque, // 빈 영역에서도 스와이프 감지
                  // 핀치 줌 + 스와이프
                  onScaleStart: (details) {
                    _baseTextScale = _textScale;
                    if (!ti.hasTouchSound && !ti.hasCrackTransform && details.pointerCount == 1) {
                      _onSwipeStart();
                    }
                  },
                  onScaleUpdate: (details) {
                    // 두 손가락 핀치: 글씨 크기 조절
                    if (details.pointerCount >= 2) {
                      setState(() {
                        _textScale = (_baseTextScale * details.scale)
                            .clamp(_minTextScale, _maxTextScale);
                      });
                    }
                  },
                  onScaleEnd: (details) {
                    // 핀치 후 저장
                    _saveTextScale();
                    // 단일 손가락 스와이프 처리 (위/아래 스와이프는 무시)
                    if (!ti.hasTouchSound && !ti.hasCrackTransform) {
                      final dx = details.velocity.pixelsPerSecond.dx;
                      final dy = details.velocity.pixelsPerSecond.dy;
                      // 수직 속도가 수평 속도보다 크면 위/아래 스와이프로 간주하여 무시
                      if (dy.abs() > dx.abs()) return;
                      if (dx > 200 && _currentPage > 0) {
                        _swipePreviousPage();
                      } else if (dx < -200) {
                        if (!ti.hasChoices) _swipeNextPage();
                      }
                    }
                  },
                  onTapDown: (details) {
                    if (ti.hasTouchSound) {
                      _handleHighFiveTouch(details.localPosition);
                    } else if (ti.isTouchPage) {
                      _nextPage();
                    }
                  },
                  child: Transform.translate(
                    offset: _shakeOffset,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          padding: EdgeInsets.zero,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (ti.hasVideo && _isVideoInitialized)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: _videoController!.value.aspectRatio,
                                  child: VideoPlayer(_videoController!),
                                ),
                                if (ti.overlayText != null)
                                  Positioned(
                                    top: 16,
                                    left: 16,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        ti.overlayText!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        if (ti.hasImage && (!ti.hasTimer || !_timerCompleted) && !ti.hasVideo)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Stack(
                              children: [
                                // 원본 이미지 또는 변환된 이미지
                                if (ti.hasCrackTransform && _isTransformed)
                                  _buildTransformedImage(ti)
                                else
                                  Image.asset(
                                    ti.imageAssetPath!,
                              width: double.infinity,
                              fit: BoxFit.fitWidth,
                              errorBuilder: (context, error, stackTrace) {
                                debugPrint(
                                    'Error loading image ${ti.imageAssetPath}: $error');
                                return Container(
                                  height: 200,
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: Icon(Icons.image_not_supported,
                                        size: 64),
                                  ),
                                );
                              },
                            ),
                                // Crack 오버레이 이미지들
                                if (ti.hasCrackTransform && !_isTransformed)
                                  ...List.generate(ti.crackImages!.length, (index) {
                                    if (_visibleCracks.length > index && _visibleCracks[index]) {
                                      return Positioned.fill(
                                        child: Image.asset(
                                          ti.crackImages![index],
                                          fit: BoxFit.fitWidth,
                                        ),
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  }),
                            if (_showPreviousPagePreview && _currentPage > 0)
                              Builder(builder: (context) {
                                final prevTi = widget.tiArray[_currentPage - 1];
                                final imagePath = prevTi.hasImage
                                    ? prevTi.imageAssetPath
                                    : (prevTi.hasAnimation &&
                                            prevTi.animationFrames!.isNotEmpty
                                        ? prevTi.animationFrames![0]
                                        : null);

                                if (imagePath != null) {
                                  return Positioned.fill(
                                    child: Image.asset(
                                      imagePath,
                                      width: double.infinity,
                                      fit: BoxFit.fitWidth,
                                      key: ValueKey('preview_prev_image_$imagePath'),
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              }),
                            if (ti.overlayText != null)
                              Positioned(
                                top: 16,
                                left: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    ti.overlayText!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            if (ti.hasTimer && _remainingSeconds > 0)
                              Positioned(
                                top: 16,
                                right: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    _formatTime(_remainingSeconds),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            if (ti.showCounter && ti.repeatCount != null && _currentRepeatCount > 0)
                              Positioned(
                                bottom: 16,
                                right: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 8,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '$_currentRepeatCount',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (ti.hasAnimation && ti.animationFrames!.isNotEmpty)
                          Stack(
                            children: [
                            Image.asset(
                              ti.animationFrames![_currentAnimationFrame],
                              width: double.infinity,
                              fit: BoxFit.fitWidth,
                              gaplessPlayback: true,
                              errorBuilder: (context, error, stackTrace) {
                                debugPrint(
                                    'Error loading animation frame: $error');
                                return Container(
                                  height: 200,
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: Icon(Icons.animation, size: 64),
                                  ),
                                );
                              },
                            ),
                            if (_showPreviousPagePreview && _currentPage > 0)
                              Builder(builder: (context) {
                                final prevTi = widget.tiArray[_currentPage - 1];
                                final imagePath = prevTi.hasImage
                                    ? prevTi.imageAssetPath
                                    : (prevTi.hasAnimation &&
                                            prevTi.animationFrames!.isNotEmpty
                                        ? prevTi.animationFrames![0]
                                        : null);

                                if (imagePath != null) {
                                  return Positioned.fill(
                                    child: Image.asset(
                                      imagePath,
                                      width: double.infinity,
                                      fit: BoxFit.fitWidth,
                                      key: ValueKey(
                                          'preview_prev_anim_image_$imagePath'),
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              }),
                            if (ti.overlayText != null)
                              Positioned(
                                top: 16,
                                left: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    ti.overlayText!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            if (ti.hasTimer && _remainingSeconds > 0)
                              Positioned(
                                top: 16,
                                right: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    _formatTime(_remainingSeconds),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            if (ti.showCounter && ti.repeatCount != null && _currentRepeatCount > 0)
                              Positioned(
                                bottom: 16,
                                right: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 8,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '$_currentRepeatCount',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        if (ti.isHtml)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Html(
                              data: ti.text,
                              style: {
                                "body": Style(
                                  fontSize: FontSize(18.0 * _textScale),
                                  lineHeight: LineHeight(1.6),
                                ),
                              },
                              onLinkTap: (url, attributes, element) async {
                                debugPrint('Link tapped: $url');
                                if (url != null) {
                                  final uri = Uri.parse(url);
                                  try {
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                                    } else {
                                      debugPrint('Could not launch $url');
                                    }
                                  } catch (e) {
                                    debugPrint('Error launching url: $e');
                                  }
                                }
                              },
                            ),
                          )
                      else
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              ti.text,
                              style: TextStyle(fontSize: 18 * _textScale, height: 1.6),
                            ),
                          ),

                        // 선택지 버튼 UI
                        if (ti.hasChoices)
                          Padding(
                            padding: const EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
                            child: ti.choices!.length <= 2
                              // 2개 이하: 가로 배열
                              ? Row(
                                  children: ti.choices!.map((choice) {
                                    return Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                        child: _buildChoiceButton(choice),
                                      ),
                                    );
                                  }).toList(),
                                )
                              // 3개 이상: 세로 배열
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: ti.choices!.map((choice) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: _buildChoiceButton(choice),
                                    );
                                  }).toList(),
                                ),
                          ),

                        if (ti.hasFullscreenVideoButton)
                          Padding(
                            padding: const EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                try {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VideoScreen(videoPath: ti.fullscreenVideoPath),
                                    ),
                                  );
                                } catch (e) {
                                  debugPrint('Error navigating to video: $e');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('비디오를 재생할 수 없습니다'),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(Icons.play_circle_outline),
                              label: const Text('비디오 재생'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(16),
                              ),
                            ),
                          ),
                        const SizedBox(height: 32), // Add bottom padding for better scrolling
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                ),),
                if (_showExitWarning)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '한 번 더 누르면 종료됩니다',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ..._hitEffects.map((effect) => Positioned(
                  left: effect.position.dx - 50,
                  top: effect.position.dy - 50,
                  child: IgnorePointer(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Stack(
                        children: [
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.3, end: 1.5),
                            duration: const Duration(milliseconds: 350),
                            builder: (context, scale, child) {
                              return Transform.scale(
                                scale: scale,
                                child: Opacity(
                                  opacity: (1.5 - scale).clamp(0.0, 1.0),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: RadialGradient(
                                        colors: [
                                          Colors.white,
                                          Colors.yellow,
                                          Colors.red,
                                          Colors.transparent,
                                        ],
                                        stops: const [0.0, 0.2, 0.6, 1.0],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 1.0, end: 0.0),
                            duration: const Duration(milliseconds: 150),
                            builder: (context, opacity, child) {
                              return Center(
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(opacity),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.yellow.withOpacity(opacity * 0.8),
                                        blurRadius: 15,
                                        spreadRadius: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavButton(
                    '< 이전',
                    _currentPage > 0 ? _previousPage : null,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.home),
                        onPressed: () {
                          if (!_isExiting && mounted && Navigator.canPop(context)) {
                            _isExiting = true;
                            Navigator.pop(context);
                          }
                        },
                        tooltip: '홈으로',
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${_currentPage + 1} / ${widget.tiArray.length}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  _buildNavButton(
                    ti.hasChoices ? '선택하세요' : '다음 >',
                    ti.hasChoices ? null : _nextPage,
                  ),
                ],
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }
}

class _HitEffect {
  final Offset position;
  final int id;
  
  _HitEffect({required this.position, required this.id});
}
