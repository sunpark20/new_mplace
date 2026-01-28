import 'video_screen.dart';
import 'fullscreen_video_screen.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_html/flutter_html.dart';
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

class _DayScreenState extends State<DayScreen> {
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

  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;

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
    _loadCurrentPage();
  }

  void _loadCurrentPage() {
    _timerCompleted = false;
    _currentAnimationFrame = 0;
    _animationTimer?.cancel();
    _currentRepeatCount = 0;
    _isRepeatPlaying = false;
    _disposeVideoController();

    final ti = widget.tiArray[_currentPage];

    if (ti.hasVideo) {
      _initializeVideo(ti.videoPath!);
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

  void _initializeVideo(String videoPath) async {
    try {
      final cleanPath = videoPath.replaceFirst('assets/', '');
      _videoController = VideoPlayerController.asset('assets/$cleanPath');
      await _videoController!.initialize();
      await _videoController!.setLooping(false);
      await _videoController!.play();
      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Error initializing video: $e');
    }
  }

  void _disposeVideoController() {
    if (_videoController != null) {
      _videoController!.dispose();
      _videoController = null;
      _isVideoInitialized = false;
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

  void _startRepeatSound(String initialPath, String repeatPath) async {
    try {
      // 초기 사운드 재생 (mobak)
      final cleanInitialPath = initialPath.replaceFirst('assets/', '');
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(cleanInitialPath));

      // 초기 사운드가 끝나면 반복 사운드 시작
      _audioPlayer.onPlayerComplete.first.then((_) {
        if (mounted && !_isRepeatPlaying) {
          _playRepeatSound(repeatPath);
        }
      });
    } catch (e) {
      debugPrint('Error playing initial sound: $e');
    }
  }

  void _playRepeatSound(String repeatPath) async {
    if (_isRepeatPlaying || _currentRepeatCount >= _totalRepeatCount) return;

    _isRepeatPlaying = true;

    try {
      final cleanRepeatPath = repeatPath.replaceFirst('assets/', '');
      await _repeatAudioPlayer.stop();
      await _repeatAudioPlayer.play(AssetSource(cleanRepeatPath));

      await _repeatAudioPlayer.onPlayerComplete.first;

      if (mounted) {
        setState(() {
          _currentRepeatCount++;
        });

        if (_currentRepeatCount < _totalRepeatCount) {
          _isRepeatPlaying = false;
          _playRepeatSound(repeatPath);
        } else {
          // 99번 완료 시 팝업 표시
          _showCompletionDialog();
        }
      }
    } catch (e) {
      debugPrint('Error playing repeat sound: $e');
      _isRepeatPlaying = false;
    }
  }

  void _showCompletionDialog() {
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

  /// 선택지 선택 처리 - 동영상이 있으면 먼저 재생
  void _handleChoiceSelection(Choice choice) async {
    if (choice.videoPath != null) {
      // 동영상 재생 후 해당 인덱스로 이동
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FullscreenVideoScreen(videoPath: choice.videoPath!),
        ),
      );
      _jumpToIndex(choice.targetIndex);
    } else {
      _jumpToIndex(choice.targetIndex);
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
        Navigator.pop(context);
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

  @override
  void dispose() {
    _flashTimer?.cancel();
    _countdownTimer?.cancel();
    _animationTimer?.cancel();
    _audioPlayer.dispose();
    _repeatAudioPlayer.dispose();
    _disposeVideoController();
    _exitWarningTimer?.cancel();
    for (var player in _combatPlayers) {
      player.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ti = widget.tiArray[_currentPage];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GestureDetector(
                  onTapDown: (details) {
                    if (ti.hasTouchSound) {
                      _handleHighFiveTouch(details.localPosition);
                    } else if (ti.isTouchPage) {
                      _nextPage();
                    }
                  },
                  child: Transform.translate(
                    offset: _shakeOffset,
                    child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (ti.hasVideo && _isVideoInitialized)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: AspectRatio(
                              aspectRatio: _videoController!.value.aspectRatio,
                              child: VideoPlayer(_videoController!),
                            ),
                          ),
                        if (ti.hasImage && (!ti.hasTimer || !_timerCompleted) && !ti.hasVideo)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Stack(
                              children: [
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
                        if (ti.hasResultImage && _timerCompleted)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Image.asset(
                              ti.resultImageAssetPath!,
                              width: double.infinity,
                              fit: BoxFit.fitWidth,
                              errorBuilder: (context, error, stackTrace) {
                                debugPrint(
                                    'Error loading result image ${ti.resultImageAssetPath}: $error');
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
                                  fontSize: FontSize(18.0),
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
                              style: const TextStyle(fontSize: 18, height: 1.6),
                            ),
                          ),

                        // 선택지 버튼 UI
                        if (ti.hasChoices)
                          Padding(
                            padding: const EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
                            child: Row(
                              children: ti.choices!.map((choice) {
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    child: ElevatedButton(
                                      onPressed: () => _handleChoiceSelection(choice),
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
                              }).toList(),
                            ),
                          ),

                        if (ti.isYoutubeLink)
                          Padding(
                            padding: const EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                try {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const VideoScreen(),
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
                              label: const Text('TED 비디오 재생'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(16),
                              ),
                            ),
                          ),
                        const SizedBox(height: 32), // Add bottom padding for better scrolling
                      ],
                    ),
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
            bottom: false,
            child: Container(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
                bottom: 32.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _currentPage > 0 ? _previousPage : null,
                    child: const Text('< 이전'),
                  ),
                  Text(
                    '${_currentPage + 1} / ${widget.tiArray.length}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  ElevatedButton(
                    onPressed: ti.hasChoices ? null : _nextPage,
                    child: Text(ti.hasChoices ? '선택하세요' : '다음 >'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HitEffect {
  final Offset position;
  final int id;
  
  _HitEffect({required this.position, required this.id});
}
