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
import 'day_screen.dart';
import 'num_sample_screen.dart';
import 'num_prac_screen.dart';
import 'video_screen.dart';

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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('기억의 궁전', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/main.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildSectionHeader('학습 단계'),
                  const SizedBox(height: 10),
                  _buildGrid([
                    _buildMenuButton(context, '인트로', 'Day 0', Icons.play_circle_outline, () => _nav(DayScreen(title: '인트로', tiArray: Day0.getTiArray()))),
                    _buildMenuButton(context, '1일차', 'Day 1', Icons.looks_one, () => _nav(DayScreen(title: '1일차', tiArray: Day1.getTiArray()))),
                    _buildMenuButton(context, '2일차', 'Day 2', Icons.looks_two, () => _nav(DayScreen(title: '2일차', tiArray: Day2.getTiArray()))),
                    _buildMenuButton(context, '3일차', 'Day 3', Icons.looks_3, () => _nav(DayScreen(title: '3일차', tiArray: Day3.getTiArray()))),
                    _buildMenuButton(context, '3일차(추가)', 'Day 3-2', Icons.add_circle_outline, () => _nav(DayScreen(title: '3일차 추가', tiArray: Day32.getTiArray()))),
                    _buildMenuButton(context, '4일차', 'Day 4', Icons.looks_4, () => _nav(DayScreen(title: '4일차', tiArray: Day4.getTiArray()))),
                  ]),
                  
                  const SizedBox(height: 24),
                  _buildSectionHeader('연습 & 참고자료'),
                  const SizedBox(height: 10),
                  _buildGrid([
                    _buildMenuButton(context, '변환표 가이드', '00-99', Icons.people, () => _nav(const NumSampleScreen()), color: Colors.blue),
                    _buildMenuButton(context, '첫 번째 도전', 'Challenge', Icons.flag, () => _nav(DayScreen(title: '첫 번째 도전', tiArray: Day5FC.getTiArray())), color: Colors.orange),
                    _buildMenuButton(context, 'PAO 시스템', 'Day 6', Icons.schema, () => _nav(DayScreen(title: 'PAO 시스템', tiArray: Day6PAO.getTiArray())), color: Colors.purple),
                    _buildMenuButton(context, '암기 연습', 'Practice', Icons.quiz, () => _nav(const NumPracScreen()), color: Colors.green),
                  ]),

                  const SizedBox(height: 24),
                  _buildSectionHeader('비디오'),
                  const SizedBox(height: 10),
                  _buildGrid([
                     _buildMenuButton(context, 'TED 강연', '기억의 궁전', Icons.video_library, () => _nav(const VideoScreen()), color: Colors.red),
                  ]),
                  const SizedBox(height: 40),
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: Colors.black87, 
        ),
      ),
    );
  }

  Widget _buildGrid(List<Widget> children) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double itemWidth = (constraints.maxWidth - 12) / 2; // 12 is spacing
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: children.map((child) => SizedBox(
            width: itemWidth,
            child: child
          )).toList(),
        );
      }
    );
  }

  Widget _buildMenuButton(BuildContext context, String title, String subtitle, IconData icon, VoidCallback onPressed, {Color? color}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (color ?? Theme.of(context).primaryColor).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: color ?? Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
