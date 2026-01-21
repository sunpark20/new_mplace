import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/item.dart';

class NumSampleScreen extends StatefulWidget {
  const NumSampleScreen({super.key});

  @override
  State<NumSampleScreen> createState() => _NumSampleScreenState();
}

class _NumSampleScreenState extends State<NumSampleScreen> {
  List<Item> items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final data = await rootBundle.loadString('assets/numsample.txt');
      final lines = data.split('\n');

      List<Item> tempItems = [];
      for (int i = 0; i < lines.length; i++) {
        if ((i + 1) % 4 == 2) {
          final name = lines[i].trim();
          final cha = i + 1 < lines.length ? lines[i + 1].trim() : '';
          final des = i + 2 < lines.length ? lines[i + 2].trim() : '';
          tempItems.add(Item(name: name, cha: cha, des: des));
        }
      }

      setState(() {
        items = tempItems;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<String> _makeDisplayList() {
    List<String> list = [];
    for (int i = 0; i < 10; i++) {
      list.add(i.toString());
    }
    for (int i = 0; i < 100; i++) {
      list.add(i.toString().padLeft(2, '0'));
    }
    return list;
  }

  void _showItemDialog(Item item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.cha,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              item.des,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayList = _makeDisplayList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('숫자-인물 가이드'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('설명서'),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/d4_2.png',
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox();
                          },
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          '숫자를 한글 자음으로 변환하는 시스템입니다.\n'
                          '0-9, 00-99까지의 숫자를 인물로 변환한 예시입니다.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
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
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SafeArea(
                      top: false,
                      child: GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1.2,
                        ),
                        itemCount: displayList.length,
                        itemBuilder: (context, index) {
                          final number = displayList[index];
                          return InkWell(
                            onTap: () {
                              if (index < items.length) {
                                _showItemDialog(items[index]);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.deepPurple.shade200,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  number,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple.shade700,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
        ],
      ),
    );
  }
}
