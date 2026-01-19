import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
  int _remainingSeconds = 0;
  bool _timerCompleted = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  BannerAd? _bannerAd;
  bool _isBannerLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
    _loadCurrentPage();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _bannerAd?.load();
  }

  void _loadCurrentPage() {
    _timerCompleted = false;
    final ti = widget.tiArray[_currentPage];

    if (ti.hasSound) {
      _playSound(ti.soundAssetPath!);
    }

    if (ti.hasTimer) {
      _startTimer(ti.alarmTimeInSeconds!);
    }
  }

  void _playSound(String path) async {
    try {
      await _audioPlayer.play(AssetSource(path.replaceFirst('assets/', '')));
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
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timerCompleted = true;
          timer.cancel();
        }
      });
    });
  }

  void _nextPage() {
    if (_currentPage < widget.tiArray.length - 1) {
      _countdownTimer?.cancel();
      _audioPlayer.stop();
      setState(() {
        _currentPage++;
        _loadCurrentPage();
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _countdownTimer?.cancel();
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

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _audioPlayer.dispose();
    _bannerAd?.dispose();
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
          if (_isBannerLoaded && _bannerAd != null)
            SizedBox(
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (ti.isTouchPage || ti.hasTouchSound) {
                  if (ti.hasTouchSound) {
                    _playSound('assets/sounds/touch.mp3');
                  }
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
                          errorBuilder: (context, error, stackTrace) {
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
                          errorBuilder: (context, error, stackTrace) {
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
                          ti.animationFrames!.first,
                          errorBuilder: (context, error, stackTrace) {
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
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
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
                  child: const Text('이전'),
                ),
                Text(
                  '${_currentPage + 1} / ${widget.tiArray.length}',
                  style: const TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed:
                      _currentPage < widget.tiArray.length - 1
                          ? _nextPage
                          : null,
                  child: const Text('다음'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
