import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// 메인 화면 - 앱의 허브, 다양한 학습 단계로 이동
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  BannerAd? _bannerAd;
  bool _isBannerLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: _getAdUnitId(),
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

  String _getAdUnitId() {
    // TODO: 실제 AdMob Unit ID로 교체 필요
    // 테스트 ID: 'ca-app-pub-3940256099942544/6300978111'
    return 'ca-app-pub-3940256099942544/6300978111';
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          // 뒤로가기 시 앱 종료
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('기억의 궁전'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // 상단 배너 광고
            if (_isBannerLoaded && _bannerAd != null)
              SizedBox(
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            // 메인 콘텐츠
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      '학습 단계',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildMenuButton(
                      context,
                      title: '인트로',
                      subtitle: 'Day 0',
                      icon: Icons.play_circle_outline,
                      onPressed: () {
                        // TODO: Day 0 화면으로 이동
                        _showComingSoon(context, 'Day 0');
                      },
                    ),
                    _buildMenuButton(
                      context,
                      title: '1일차',
                      subtitle: 'Day 1',
                      icon: Icons.looks_one,
                      onPressed: () {
                        _showComingSoon(context, 'Day 1');
                      },
                    ),
                    _buildMenuButton(
                      context,
                      title: '2일차',
                      subtitle: 'Day 2',
                      icon: Icons.looks_two,
                      onPressed: () {
                        _showComingSoon(context, 'Day 2');
                      },
                    ),
                    _buildMenuButton(
                      context,
                      title: '3일차',
                      subtitle: 'Day 3',
                      icon: Icons.looks_3,
                      onPressed: () {
                        _showComingSoon(context, 'Day 3');
                      },
                    ),
                    _buildMenuButton(
                      context,
                      title: '3일차 추가',
                      subtitle: 'Day 3-2',
                      icon: Icons.add_circle_outline,
                      onPressed: () {
                        _showComingSoon(context, 'Day 3-2');
                      },
                    ),
                    _buildMenuButton(
                      context,
                      title: '4일차',
                      subtitle: 'Day 4',
                      icon: Icons.looks_4,
                      onPressed: () {
                        _showComingSoon(context, 'Day 4');
                      },
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '연습 & 참고자료',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildMenuButton(
                      context,
                      title: '숫자-인물 가이드',
                      subtitle: '00-99 변환표',
                      icon: Icons.people,
                      color: Colors.blue,
                      onPressed: () {
                        _showComingSoon(context, '숫자-인물 가이드');
                      },
                    ),
                    _buildMenuButton(
                      context,
                      title: '첫 번째 도전',
                      subtitle: 'First Challenge',
                      icon: Icons.flag,
                      color: Colors.orange,
                      onPressed: () {
                        _showComingSoon(context, 'First Challenge');
                      },
                    ),
                    _buildMenuButton(
                      context,
                      title: 'PAO 시스템',
                      subtitle: 'Day 6',
                      icon: Icons.schema,
                      color: Colors.purple,
                      onPressed: () {
                        _showComingSoon(context, 'PAO 시스템');
                      },
                    ),
                    _buildMenuButton(
                      context,
                      title: '숫자 암기 연습',
                      subtitle: 'Practice',
                      icon: Icons.quiz,
                      color: Colors.green,
                      onPressed: () {
                        _showComingSoon(context, '숫자 암기 연습');
                      },
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '비디오',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildMenuButton(
                      context,
                      title: 'TED 비디오',
                      subtitle: '기억의 궁전 강연',
                      icon: Icons.video_library,
                      color: Colors.red,
                      onPressed: () {
                        _showComingSoon(context, 'TED 비디오');
                      },
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

  Widget _buildMenuButton(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onPressed,
    Color? color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        leading: Icon(
          icon,
          size: 36,
          color: color ?? Theme.of(context).primaryColor,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onPressed,
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature 준비 중...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
