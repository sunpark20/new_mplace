import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../data/day0.dart';
import '../data/day1.dart';
import '../data/day2.dart';
import '../data/day3.dart';
import '../data/day32.dart';
import '../data/day4.dart';
import '../data/day5_fc.dart';
import '../data/day6_pao.dart';
import '../data/day7_mnemonic.dart';
import '../widgets/sound_button.dart';
import 'day_screen.dart';
import 'num_sample_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? _noticeText;
  bool _isLoadingNotice = true;
  static const String _noticeUrl = 'https://gist.githubusercontent.com/q5m5vh7kjn-cyber/80e3cdc9aa2605d8607615e26681514d/raw/gistfile1.txt';

  @override
  void initState() {
    super.initState();
    _fetchNotice();
  }

  Future<void> _fetchNotice() async {
    try {
      final response = await http.get(Uri.parse(_noticeUrl));
      if (response.statusCode == 200) {
        final text = response.body.trim();
        setState(() {
          _noticeText = text.isNotEmpty ? text : null;
          _isLoadingNotice = false;
        });
      } else {
        setState(() {
          _noticeText = null;
          _isLoadingNotice = false;
        });
      }
    } catch (e) {
      setState(() {
        _noticeText = null;
        _isLoadingNotice = false;
      });
    }
  }

  Widget _buildNoticeBoard() {
    if (_isLoadingNotice || _noticeText == null) {
      return const SizedBox.shrink();
    }

    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
        children: _parseNoticeText(_noticeText!),
      ),
    );
  }

  /// 마크다운 링크 [텍스트](URL) 형식을 파싱하여 클릭 가능한 TextSpan 리스트로 변환
  List<TextSpan> _parseNoticeText(String text) {
    final List<TextSpan> spans = [];
    final RegExp linkRegex = RegExp(r'\[([^\]]+)\]\(([^)]+)\)');

    int lastEnd = 0;
    for (final match in linkRegex.allMatches(text)) {
      // 링크 이전 텍스트
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: text.substring(lastEnd, match.start)));
      }

      // 링크 텍스트
      final linkText = match.group(1)!;
      final linkUrl = match.group(2)!;

      spans.add(TextSpan(
        text: linkText,
        style: const TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () async {
            final uri = Uri.parse(linkUrl);
            // canLaunchUrl 체크 없이 바로 실행 (iOS 커스텀 스킴 지원)
            try {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            } catch (e) {
              debugPrint('Error launching URL: $e');
            }
          },
      ));

      lastEnd = match.end;
    }

    // 마지막 링크 이후 텍스트
    if (lastEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastEnd)));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('기억의 궁전', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildButton('머리말', () => _nav(DayScreen(title: '머리말', tiArray: Day0.getTiArray()))),
                const SizedBox(height: 12),
                _buildButton('day1-몸', () => _nav(DayScreen(title: 'day1-몸', tiArray: Day1.getTiArray()))),
                const SizedBox(height: 12),
                _buildButton('day2-상상하기', () => _nav(DayScreen(title: 'day2-상상하기', tiArray: Day2.getTiArray()))),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildButton('day3-장소', () => _nav(DayScreen(title: 'day3-장소', tiArray: Day3.getTiArray())))),
                    const SizedBox(width: 12),
                    Expanded(child: _buildButton('궁전만들기Tip', () => _nav(DayScreen(title: '궁전만들기Tip', tiArray: Day32.getTiArray())))),
                  ],
                ),
                const SizedBox(height: 12),
                _buildButton('day4-숫자', () => _nav(DayScreen(title: 'day4-숫자', tiArray: Day4.getTiArray()))),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildButton('day5-첫번째 도전', () => _nav(DayScreen(title: 'day5-첫번째도전', tiArray: Day5FC.getTiArray())))),
                    const SizedBox(width: 12),
                    Expanded(child: _buildButton('인물-숫자 샘플', () => _nav(const NumSampleScreen()))),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  '↓ 첫번째 도전 완료후',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey, // 회색 글씨
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8), // 텍스트와 버튼 사이 간격
                _buildButton('day6-PAO', () => _nav(DayScreen(title: 'day6-PAO', tiArray: Day6PAO.getTiArray()))),
                const SizedBox(height: 12),
                SoundButton(
                  onPressed: () => _nav(DayScreen(title: 'day7-뇌모닉', tiArray: Day7Mnemonic.getTiArray())),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/bitcoin.webp',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '뇌모닉',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                _buildNoticeBoard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _nav(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  Widget _buildButton(String title, VoidCallback onPressed) {
    return SoundTextButton(
      text: title,
      onPressed: onPressed,
    );
  }
}
