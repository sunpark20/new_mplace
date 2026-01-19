import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main_screen.dart';

/// 로딩 스크린 - 앱 시작 시 AdMob 초기화 및 로딩
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    // AdMob 초기화
    await MobileAds.instance.initialize();

    // 2초 딜레이 (로딩 화면 표시)
    await Future.delayed(const Duration(seconds: 2));

    // MainScreen으로 이동
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 로고 또는 앱 제목
            const Text(
              '기억의 궁전',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            // 로딩 인디케이터
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
