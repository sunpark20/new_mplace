import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/day0.dart';
import '../data/day1.dart';
import '../data/day2.dart';
import '../data/day3.dart';
import '../data/day32.dart';
import '../data/day4.dart';
import '../data/day5_fc.dart';
import '../data/day6_pao.dart';
import '../data/day7_mnemonic.dart';
import 'day_screen.dart';
import 'num_sample_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
                _buildButton('day6-PAO', () => _nav(DayScreen(title: 'day6-PAO', tiArray: Day6PAO.getTiArray()))),
                const SizedBox(height: 12),
                _buildButton('day7-뇌모닉', () => _nav(DayScreen(title: 'day7-뇌모닉', tiArray: Day7Mnemonic.getTiArray()))),
                const SizedBox(height: 40),
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
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
