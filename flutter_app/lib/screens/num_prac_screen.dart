import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class NumPracScreen extends StatefulWidget {
  const NumPracScreen({super.key});

  @override
  State<NumPracScreen> createState() => _NumPracScreenState();
}

class _NumPracScreenState extends State<NumPracScreen> {
  static const int sizeSet = 30;
  static const int sizeTotalNum = 10000;

  List<String> numberSet = [];
  Set<int> scoreSet = {};
  int currentIndex = 0;
  int correctCount = 0;
  int incorrectCount = 0;
  bool isGameFinished = false;

  int elapsedSeconds = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    super.initState();
    _loadScore();
    _startNewGame();
  }

  Future<void> _loadScore() async {
    final prefs = await SharedPreferences.getInstance();
    final scoreList = prefs.getStringList('num_prac_score') ?? [];
    scoreSet = scoreList.map((e) => int.parse(e)).toSet();
  }

  void _startNewGame() {
    final random = Random();
    final allNumbers =
        List.generate(sizeTotalNum, (i) => i.toString().padLeft(4, '0'));
    allNumbers.shuffle(random);

    setState(() {
      numberSet = allNumbers.take(sizeSet).toList();
      currentIndex = 0;
      correctCount = 0;
      incorrectCount = 0;
      isGameFinished = false;
      elapsedSeconds = 0;
    });

    _startTimer();
  }

  void _startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!isGameFinished) {
        setState(() {
          elapsedSeconds++;
        });
      }
    });
  }

  void _onCorrect() {
    if (isGameFinished) return;

    final numToRemove = int.parse(numberSet[currentIndex]);
    scoreSet.add(numToRemove);

    setState(() {
      numberSet.removeAt(currentIndex);
      correctCount++;

      if (numberSet.isEmpty) {
        _finishGame();
      } else {
        currentIndex = currentIndex % numberSet.length;
      }
    });
  }

  void _onIncorrect() {
    if (isGameFinished) return;

    setState(() {
      incorrectCount++;
      currentIndex = (currentIndex + 1) % numberSet.length;
    });
  }

  void _finishGame() {
    setState(() {
      isGameFinished = true;
    });
    timer?.cancel();
    _saveScore();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('모든 문제를 완료했습니다!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _saveScore() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'num_prac_score',
      scoreSet.map((e) => e.toString()).toList(),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('숫자 암기 연습'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('설명서'),
                  content: const Text(
                    '화면에 나타나는 4자리 숫자를 기억하세요.\n\n'
                    '기억했으면 "정답" 버튼을,\n'
                    '기억하지 못했으면 "오답" 버튼을 누르세요.\n\n'
                    '30개의 숫자를 모두 기억하는 것이 목표입니다!',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('닫기'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text('정답', style: TextStyle(fontSize: 14)),
                    Text(
                      '$correctCount',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text('오답', style: TextStyle(fontSize: 14)),
                    Text(
                      '$incorrectCount',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text('남은 문제', style: TextStyle(fontSize: 14)),
                    Text(
                      '${numberSet.length}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.deepPurple.shade200, width: 2),
            ),
            child: Text(
              _formatTime(elapsedSeconds),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade700,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(48),
                child: Text(
                  isGameFinished
                      ? '완료'
                      : (numberSet.isNotEmpty
                          ? numberSet[currentIndex]
                          : ''),
                  style: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8,
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isGameFinished ? null : _onIncorrect,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(24),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child: const Text('오답'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isGameFinished ? null : _onCorrect,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(24),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child: const Text('정답'),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isGameFinished)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ElevatedButton.icon(
                      onPressed: _startNewGame,
                      icon: const Icon(Icons.refresh),
                      label: const Text('새 게임 시작'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
