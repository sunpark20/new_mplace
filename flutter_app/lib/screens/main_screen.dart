import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/day0.dart';
import '../data/day1.dart';
import '../data/day2.dart';
import '../data/day3.dart';
import '../data/day32.dart';
import '../data/day4.dart';
import '../data/day42.dart';
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

  // 비트코인 라이트닝 주소 (앱 내 안전하게 저장)
  static const String _btcLightningAddress = "lno1zrxq8pjw7qjlm68mtp7e3yvxee4y5xrgjhhyf2fxhlphpckrvevh50u0qtwhegttle4kls3ffpqcf646cxf3w2yxxkwrctww5uvnu3qsanqhgqsrsmgeljslcyqpmg5ru5etfz6uetx6wetmpu2g7g5zwnuxquxl4zgsqvccxell2n5nctgsr9czs2vffxsrsrsu0y5lahnlk8ae0ymyyq524vqggckfedm6qhq6pkepn2t2l53khrfmq20lv5t2v2mqz02nrf6edaqf2rxa23ldyje4tku6kyvqrvl68n6z6qqshcxt4v5pxgm5wjak8xzyd0tgzs";

  // 텍스트 크기 조절 (핀치 줌)
  double _textScale = 1.0;
  double _baseTextScale = 1.0;
  static const double _minTextScale = 0.8;
  static const double _maxTextScale = 2.5;

  @override
  void initState() {
    super.initState();
    _fetchNotice();
    _loadTextScale();
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

    // 매직 키워드들을 위젯으로 변환
    final widgets = _parseNoticeWithMagicKeywords(_noticeText!);

    if (widgets.length == 1 && widgets.first is RichText) {
      return widgets.first;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  /// 매직 키워드를 파싱하여 위젯 리스트로 변환
  List<Widget> _parseNoticeWithMagicKeywords(String text) {
    final List<Widget> widgets = [];
    final RegExp magicRegex = RegExp(r'\{\{(BTC_BUTTON|TOSS_QR|LIGHTNING_QR)\}\}');

    int lastEnd = 0;
    for (final match in magicRegex.allMatches(text)) {
      // 매직 키워드 이전 텍스트
      if (match.start > lastEnd) {
        final beforeText = text.substring(lastEnd, match.start).trim();
        if (beforeText.isNotEmpty) {
          if (widgets.isNotEmpty) widgets.add(const SizedBox(height: 8));
          widgets.add(RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              style: TextStyle(fontSize: 12 * _textScale, color: Colors.grey),
              children: _parseNoticeText(beforeText),
            ),
          ));
        }
      }

      // 매직 키워드에 해당하는 위젯 추가
      final keyword = match.group(1);
      if (widgets.isNotEmpty) widgets.add(const SizedBox(height: 8));

      if (keyword == 'BTC_BUTTON') {
        widgets.add(_buildBtcCopyCard());
      } else if (keyword == 'TOSS_QR') {
        widgets.add(_buildTossQrImage());
      } else if (keyword == 'LIGHTNING_QR') {
        widgets.add(_buildLightningQrImage());
      }

      lastEnd = match.end;
    }

    // 마지막 매직 키워드 이후 텍스트
    if (lastEnd < text.length) {
      final afterText = text.substring(lastEnd).trim();
      if (afterText.isNotEmpty) {
        if (widgets.isNotEmpty) widgets.add(const SizedBox(height: 8));
        widgets.add(RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            style: TextStyle(fontSize: 12 * _textScale, color: Colors.grey),
            children: _parseNoticeText(afterText),
          ),
        ));
      }
    }

    // 매직 키워드가 없으면 전체 텍스트를 RichText로
    if (widgets.isEmpty) {
      widgets.add(RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          style: TextStyle(fontSize: 12 * _textScale, color: Colors.grey),
          children: _parseNoticeText(text),
        ),
      ));
    }

    return widgets;
  }

  /// 토스 QR 이미지 위젯
  Widget _buildTossQrImage() {
    return Image.asset(
      'assets/images/toss_qr.png',
      width: 150,
      height: 150,
    );
  }

  /// 라이트닝 QR 이미지 위젯
  Widget _buildLightningQrImage() {
    return Image.asset(
      'assets/images/lightning_qr.png',
      width: 150,
      height: 150,
    );
  }

  /// 비트코인 라이트닝 복사 카드 위젯
  Widget _buildBtcCopyCard() {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(const ClipboardData(text: _btcLightningAddress));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('주소가 복사되었습니다! 지갑 앱에 붙여넣으세요.'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bolt, color: Colors.orange, size: 16),
          SizedBox(width: 4),
          Text(
            "라이트닝 네트워크 짤토시 보내주기",
            style: TextStyle(fontSize: 12, color: Colors.orange, decoration: TextDecoration.underline),
          ),
          SizedBox(width: 4),
          Icon(Icons.copy, color: Colors.orange, size: 14),
          SizedBox(width: 2),
          Text(
            "탭하여 주소복사하기",
            style: TextStyle(fontSize: 11, color: Colors.orange),
          ),
        ],
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
          child: GestureDetector(
            onScaleStart: (details) {
              _baseTextScale = _textScale;
            },
            onScaleUpdate: (details) {
              if (details.pointerCount >= 2) {
                setState(() {
                  _textScale = (_baseTextScale * details.scale)
                      .clamp(_minTextScale, _maxTextScale);
                });
              }
            },
            onScaleEnd: (details) {
              _saveTextScale();
            },
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
                    Expanded(child: _buildButton('Tip-궁전만들기', () => _nav(DayScreen(title: 'Tip-궁전만들기', tiArray: Day32.getTiArray())))),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildButton('day4-숫자', () => _nav(DayScreen(title: 'day4-숫자', tiArray: Day4.getTiArray())))),
                    const SizedBox(width: 12),
                    Expanded(child: _buildButton('Tip2-궁전만들기', () => _nav(DayScreen(title: 'Tip2-궁전만들기', tiArray: Day42.getTiArray())))),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '↓ 기억의궁전 방(공간)을 26개 만들고 진행하세요',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14 * _textScale,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildButton('day5-카드, () => _nav(DayScreen(title: 'day5-카드', tiArray: Day5FC.getTiArray())))),
                    const SizedBox(width: 12),
                    Expanded(child: _buildButton('인물-숫자 샘플', () => _nav(const NumSampleScreen()))),
                  ],
                ),
                const SizedBox(height: 12),
                _buildButton('day6-PAO', () => _nav(DayScreen(title: 'day6-PAO', tiArray: Day6PAO.getTiArray()))),
                const SizedBox(height: 12),
                Text(
                  '↓ 번외편',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14 * _textScale,
                    fontWeight: FontWeight.w500,
                  ),
                ),
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
