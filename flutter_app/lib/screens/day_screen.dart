import 'video_screen.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_html/flutter_html.dart';

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
  final List<_HitEffect> _hitEffects = [];
  final Random _random = Random();
  
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
    super.initState();
    _loadCurrentPage();
  }

  void _loadCurrentPage() {
    _timerCompleted = false;
    _currentAnimationFrame = 0;
    _animationTimer?.cancel();

    final ti = widget.tiArray[_currentPage];

    if (ti.hasSound) {
      _playSound(ti.soundAssetPath!);
    }

    if (ti.hasTimer) {
      _startTimer(ti.alarmTimeInSeconds!);
    }

    if (ti.hasAnimation && ti.animationFrames!.length > 1) {
      _startAnimation(ti.animationFrames!.length);
    }
  }

  void _playSound(String path) async {
    try {
      final cleanPath = path.replaceFirst('assets/', '');
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(cleanPath));
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
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

  void _nextPage() {
    if (_currentPage < widget.tiArray.length - 1) {
      _countdownTimer?.cancel();
      _animationTimer?.cancel();
      _audioPlayer.stop();
      setState(() {
        _currentPage++;
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
    if (_currentPage > 0) {
      _countdownTimer?.cancel();
      _animationTimer?.cancel();
      _audioPlayer.stop();
      setState(() {
        _currentPage--;
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
    _countdownTimer?.cancel();
    _animationTimer?.cancel();
    _audioPlayer.dispose();
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
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (ti.hasImage && (!ti.hasTimer || !_timerCompleted))
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Image.asset(
                              ti.imageAssetPath!,
                              fit: BoxFit.contain,
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
                          ),
                        if (ti.hasResultImage && _timerCompleted)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Image.asset(
                              ti.resultImageAssetPath!,
                              fit: BoxFit.contain,
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Image.asset(
                              ti.animationFrames![_currentAnimationFrame],
                              fit: BoxFit.contain,
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
                          ),
                        if (ti.isHtml)
                          Html(
                            data: ti.text,
                            onLinkTap: (url, attributes, element) {
                              debugPrint('Link tapped: $url');
                            },
                          )
                        else
                          Text(
                            ti.text,
                            style: const TextStyle(fontSize: 16, height: 1.6),
                          ),
                        if (ti.hasTimer && _remainingSeconds > 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: Column(
                              children: [
                                Text(
                                  _formatTime(_remainingSeconds),
                                  style: const TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                LinearProgressIndicator(
                                  value: 1 -
                                      (_remainingSeconds /
                                          ti.alarmTimeInSeconds!),
                                ),
                              ],
                            ),
                          ),
                        if (ti.isYoutubeLink)
                          Padding(
                            padding: const EdgeInsets.only(top: 24.0),
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
                      ],
                    ),
                  ),
                ),
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
                                          Colors.orange.withOpacity(0.8),
                                          Colors.red.withOpacity(0.4),
                                          Colors.transparent,
                                        ],
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
                    onPressed: _nextPage,
                    child: const Text('다음 >'),
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
